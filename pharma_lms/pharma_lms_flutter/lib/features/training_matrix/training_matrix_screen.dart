import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../../core/file_io.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../features/esignature/esignature_screen.dart' show showEsignatureModal;
import '../../widgets/app_shell.dart';

/// Admin screen for role-based curriculum (training matrix).
/// Maps job roles to required courses; allows assigning training to users.
class TrainingMatrixScreen extends StatefulWidget {
  const TrainingMatrixScreen({super.key});

  @override
  State<TrainingMatrixScreen> createState() => _TrainingMatrixScreenState();
}

class _TrainingMatrixScreenState extends State<TrainingMatrixScreen> {
  List<Organization> _orgs = [];
  List<Site> _sites = [];
  List<Department> _departments = [];
  List<JobRole> _jobRoles = [];
  List<Course> _courses = [];
  JobRole? _selectedRole;
  List<int> _curriculumCourseIds = [];
  List<int> _curriculumVersionIds = [];
  List<int> _lastSavedCourseIds = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final orgs = await client.organization.listOrganizations();
      List<Site> sites = [];
      List<Department> departments = [];
      List<JobRole> jobRoles = [];
      if (orgs.isNotEmpty && orgs.first.id != null) {
        sites = await client.organization.listSites(orgs.first.id!);
        if (sites.isNotEmpty && sites.first.id != null) {
          departments =
              await client.organization.listDepartments(sites.first.id!);
          if (departments.isNotEmpty && departments.first.id != null) {
            jobRoles =
                await client.organization.listJobRoles(departments.first.id!);
          }
        }
      }
      final courses = await client.course.listCourses();
      setState(() {
        _orgs = orgs;
        _sites = sites;
        _departments = departments;
        _jobRoles = jobRoles;
        _courses = courses;
        _selectedRole = jobRoles.isNotEmpty ? jobRoles.first : null;
        _loading = false;
      });
      if (_selectedRole?.id != null) {
        _loadCurriculum(_selectedRole!.id!);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _loadCurriculum(int jobRoleId) async {
    try {
      final versionIds =
          await client.admin.getRoleBasedCurriculum(jobRoleId);
      final courseIds = <int>[];
      for (final vid in versionIds) {
        final v = await client.course.getCourseVersion(vid);
        if (v?.courseId != null) courseIds.add(v!.courseId!);
      }
      setState(() {
        _curriculumVersionIds = versionIds;
        _curriculumCourseIds = courseIds;
        _lastSavedCourseIds = List.from(courseIds);
      });
    } catch (_) {
      setState(() {
        _curriculumVersionIds = [];
        _curriculumCourseIds = [];
      });
    }
  }

  bool get _hasChanges {
    if (_curriculumCourseIds.length != _lastSavedCourseIds.length) return true;
    final a = Set<int>.from(_curriculumCourseIds);
    final b = Set<int>.from(_lastSavedCourseIds);
    return !a.containsAll(b) || !b.containsAll(a);
  }

  Future<void> _saveMatrix() async {
    if (_selectedRole?.id == null) return;
    try {
      final json = jsonEncode(_curriculumCourseIds);
      await client.admin.updateJobRoleTrainingMatrix(
        jobRoleId: _selectedRole!.id!,
        trainingMatrixJson: json,
      );
      if (mounted) {
        setState(() => _lastSavedCourseIds = List.from(_curriculumCourseIds));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Training matrix saved')),
        );
        _loadCurriculum(_selectedRole!.id!);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    }
  }

  Future<void> _submitToQa() async {
    if (_selectedRole?.id == null || !_hasChanges) return;
    final added = _curriculumCourseIds
        .where((id) => !_lastSavedCourseIds.contains(id))
        .toList();
    final removed = _lastSavedCourseIds
        .where((id) => !_curriculumCourseIds.contains(id))
        .toList();
    final addedTitles = added
        .map((id) => _courses.where((c) => c.id == id).map((c) => c.title).firstOrNull ?? 'ID $id')
        .toList();
    final removedTitles = removed
        .map((id) => _courses.where((c) => c.id == id).map((c) => c.title).firstOrNull ?? 'ID $id')
        .toList();

    if (!mounted) return;
    final proceed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Submit to QA for Approval'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Matrix changes require QA e-signature before taking effect.',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              if (addedTitles.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Added: ${addedTitles.join(', ')}', style: TextStyle(color: Colors.green[700])),
              ],
              if (removedTitles.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Removed: ${removedTitles.join(', ')}', style: TextStyle(color: Colors.red[700])),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Proceed to E-Sign'),
          ),
        ],
      ),
    );
    if (proceed != true || !mounted) return;

    int? qaUserId;
    try {
      final qaUser = await client.user.getUserByEmail('qa@pharmacorp.demo');
      qaUserId = qaUser?.id;
    } catch (_) {}
    if (qaUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QA user not found. Configure QA role.')),
      );
      return;
    }

    final esignatureId = await showEsignatureModal(
      context,
      userId: qaUserId,
      entityType: 'training_matrix',
      entityId: 'job_role-${_selectedRole?.id}',
      signatureMeaning: 'I have reviewed and approved this training matrix change as compliant',
    );
    if (!mounted) return;
    if (esignatureId == null) return;
    await _saveMatrix();
  }

  Future<void> _showBulkImport() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result == null || result.files.isEmpty || !mounted) return;
    List<int> bytes;
    final file = result.files.single;
    if (file.bytes != null) {
      bytes = file.bytes!.toList();
    } else if (file.path != null) {
      bytes = await _readFileBytes(file.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not read file')),
      );
      return;
    }
    try {
      final csvBase64 = base64Encode(bytes);
      final bulkResult = await client.admin.bulkImportTrainingMatrix(
        csvBase64: csvBase64,
      );
      if (!mounted) return;
      final msg = bulkResult.errors.isEmpty
          ? 'Imported ${bulkResult.imported} role(s)'
          : 'Imported ${bulkResult.imported}. Errors: ${bulkResult.errors.take(3).join('; ')}${bulkResult.errors.length > 3 ? '...' : ''}';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      if (_selectedRole?.id != null) _loadCurriculum(_selectedRole!.id!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    }
  }

  Future<List<int>> _readFileBytes(String path) async {
    return readFileBytes(path);
  }

  Future<void> _assignToUser() async {
    if (_selectedRole?.id == null) return;
    final users = await client.organization.listUsers();
    final due = DateTime.now().add(const Duration(days: 30));
    int assignedById = 1;
    try {
      final adminUser =
          await client.user.getUserByEmail('admin@pharmacorp.demo');
      if (adminUser?.id != null) assignedById = adminUser!.id!;
    } catch (_) {}

    if (!mounted) return;
    PharmaUser? pickedUser;
    final picked = await showDialog<PharmaUser>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setDialogState) {
          return AlertDialog(
            title: const Text('Assign role-based training'),
            content: SizedBox(
              width: 400,
              child: DropdownButtonFormField<PharmaUser>(
                value: pickedUser,
                decoration: const InputDecoration(labelText: 'User'),
                items: users
                    .map((u) => DropdownMenuItem(
                          value: u,
                          child: Text(
                              '${u.firstName} ${u.lastName} (${u.email})'),
                        ))
                    .toList(),
                onChanged: (u) => setDialogState(() => pickedUser = u),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (pickedUser != null) Navigator.pop(ctx, pickedUser);
                },
                child: const Text('Assign'),
              ),
            ],
          );
        },
      ),
    );
    if (picked?.id == null) return;
    try {
      await client.admin.assignRoleBasedTraining(
        userId: picked!.id!,
        jobRoleId: _selectedRole!.id!,
        assignedById: assignedById,
        dueDate: due,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Assigned ${_curriculumVersionIds.length} courses to ${picked.firstName} ${picked.lastName}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Assignment failed: $e')),
        );
      }
    }
  }

  void _toggleCourse(int courseId) {
    setState(() {
      if (_curriculumCourseIds.contains(courseId)) {
        _curriculumCourseIds.remove(courseId);
      } else {
        _curriculumCourseIds.add(courseId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return AppShell(
        title: 'Training Matrix',
        icon: Icons.grid_view,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return AppShell(
        title: 'Training Matrix',
        icon: Icons.grid_view,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _load,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return AppShell(
      title: 'Training Matrix',
      icon: Icons.grid_view,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job role → curriculum mapping',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<JobRole>(
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Job role',
                      border: OutlineInputBorder(),
                    ),
                    items: _jobRoles
                        .map((r) => DropdownMenuItem(
                              value: r,
                              child: Text('${r.name} (${r.code})'),
                            ))
                        .toList(),
                    onChanged: (r) {
                      setState(() => _selectedRole = r);
                      if (r?.id != null) _loadCurriculum(r!.id!);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Required courses for this role:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _courses.map((c) {
                      final selected = c.id != null &&
                          _curriculumCourseIds.contains(c.id);
                      return FilterChip(
                        label: Text(c.title),
                        selected: selected,
                        onSelected: (_) {
                          if (c.id != null) _toggleCourse(c.id!);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (_hasChanges)
                        ElevatedButton(
                          onPressed: _submitToQa,
                          child: const Text('Submit to QA'),
                        )
                      else
                        ElevatedButton(
                          onPressed: _saveMatrix,
                          child: const Text('Save matrix'),
                        ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _curriculumVersionIds.isEmpty
                            ? null
                            : _assignToUser,
                        child: const Text('Assign to user'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton.icon(
                        onPressed: _showBulkImport,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Bulk import'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
