import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/file_io.dart';
import '../../core/theme/app_colors.dart';
import '../../features/esignature/esignature_screen.dart' show showEsignatureModal;
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';

/// ════════════════════════════════════════════════════════════════════════════
/// ROLE-BASED CURRICULUM MANAGER
/// ────────────────────────────────────────────────────────────────────────────
/// ADM-WF-03: Diff preview workflow for training matrix changes.
/// Split-pane layout: Role sidebar (flex 1) + Curriculum workspace (flex 3).
/// ════════════════════════════════════════════════════════════════════════════
class TrainingMatrixScreen extends StatefulWidget {
  const TrainingMatrixScreen({super.key});

  @override
  State<TrainingMatrixScreen> createState() => _TrainingMatrixScreenState();
}

class _TrainingMatrixScreenState extends State<TrainingMatrixScreen> {
  // ─────────────────────────────────────────────────────────────────────────────
  // State
  // ─────────────────────────────────────────────────────────────────────────────
  // ignore: unused_field - used in cascading data load
  List<Organization> _orgs = [];
  // ignore: unused_field - used in cascading data load
  List<Site> _sites = [];
  // ignore: unused_field - used in cascading data load
  List<Department> _departments = [];
  List<JobRole> _jobRoles = [];
  List<Course> _courses = [];
  JobRole? _selectedRole;
  Set<int> _curriculumCourseIds = {};
  List<int> _curriculumVersionIds = [];
  Set<int> _lastSavedCourseIds = {};
  bool _loading = true;
  bool _savingMatrix = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Data Loading
  // ─────────────────────────────────────────────────────────────────────────────
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
      final versionIds = await client.admin.getRoleBasedCurriculum(jobRoleId);
      final courseIds = <int>{};
      for (final vid in versionIds) {
        final v = await client.course.getCourseVersion(vid);
        if (v?.courseId != null) courseIds.add(v!.courseId);
      }
      setState(() {
        _curriculumVersionIds = versionIds;
        _curriculumCourseIds = courseIds;
        _lastSavedCourseIds = Set.from(courseIds);
      });
    } catch (_) {
      setState(() {
        _curriculumVersionIds = [];
        _curriculumCourseIds = {};
        _lastSavedCourseIds = {};
      });
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // ADM-WF-03: Diff Computation
  // ─────────────────────────────────────────────────────────────────────────────
  bool get _hasChanges {
    if (_curriculumCourseIds.length != _lastSavedCourseIds.length) return true;
    return !_curriculumCourseIds.containsAll(_lastSavedCourseIds) ||
        !_lastSavedCourseIds.containsAll(_curriculumCourseIds);
  }

  Set<int> get _addedCourseIds =>
      _curriculumCourseIds.difference(_lastSavedCourseIds);

  Set<int> get _removedCourseIds =>
      _lastSavedCourseIds.difference(_curriculumCourseIds);

  String _getCourseTitle(int courseId) {
    return _courses
            .where((c) => c.id == courseId)
            .map((c) => c.title)
            .firstOrNull ??
        'Course #$courseId';
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Actions
  // ─────────────────────────────────────────────────────────────────────────────
  void _toggleCourse(int courseId) {
    setState(() {
      if (_curriculumCourseIds.contains(courseId)) {
        _curriculumCourseIds.remove(courseId);
      } else {
        _curriculumCourseIds.add(courseId);
      }
    });
  }

  void _selectRole(JobRole role) {
    if (_selectedRole?.id == role.id) return;
    setState(() => _selectedRole = role);
    if (role.id != null) _loadCurriculum(role.id!);
  }

  Future<void> _saveMatrix() async {
    if (_selectedRole?.id == null) return;
    setState(() => _savingMatrix = true);
    try {
      final json = jsonEncode(_curriculumCourseIds.toList());
      await client.admin.updateJobRoleTrainingMatrix(
        jobRoleId: _selectedRole!.id!,
        trainingMatrixJson: json,
      );
      if (mounted) {
        setState(() {
          _lastSavedCourseIds = Set.from(_curriculumCourseIds);
          _savingMatrix = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Training matrix saved successfully'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        _loadCurriculum(_selectedRole!.id!);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _savingMatrix = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Save failed: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // ADM-WF-03: Diff Preview Dialog + E-Signature
  // ─────────────────────────────────────────────────────────────────────────────
  Future<void> _showDiffPreviewAndSubmitToQA() async {
    if (_selectedRole?.id == null || !_hasChanges) return;

    final added = _addedCourseIds.toList();
    final removed = _removedCourseIds.toList();

    if (!mounted) return;

    final proceed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _DiffPreviewDialog(
        roleName: _selectedRole!.name,
        addedCourses: added.map(_getCourseTitle).toList(),
        removedCourses: removed.map(_getCourseTitle).toList(),
      ),
    );

    if (proceed != true || !mounted) return;

    // Find QA user for e-signature
    int? qaUserId;
    try {
      final qaUser = await client.user.getUserByEmail('qa@pharmacorp.demo');
      qaUserId = qaUser?.id;
    } catch (_) {}

    if (qaUserId == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('QA user not found. Please configure QA role.'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Show e-signature modal (ADM-WF-03 approval)
    final esignatureId = await showEsignatureModal(
      context,
      userId: qaUserId,
      entityType: 'training_matrix',
      entityId: 'job_role-${_selectedRole?.id}',
      signatureMeaning:
          'I have reviewed and approved this training matrix change as compliant with 21 CFR Part 11',
    );

    if (!mounted) return;
    if (esignatureId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('E-signature cancelled'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Save the matrix after QA approval
    await _saveMatrix();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Bulk Import
  // ─────────────────────────────────────────────────────────────────────────────
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
      bytes = await readFileBytes(file.path!);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
      );
      if (_selectedRole?.id != null) _loadCurriculum(_selectedRole!.id!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Assign to User
  // ─────────────────────────────────────────────────────────────────────────────
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.indigo50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      const Icon(Icons.person_add, color: AppColors.indigo600),
                ),
                const SizedBox(width: 12),
                const Text('Assign Role-Based Training'),
              ],
            ),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 18, color: AppColors.slate500),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This will assign ${_curriculumVersionIds.length} course(s) from the "${_selectedRole?.name}" curriculum.',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.slate600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<PharmaUser>(
                    value: pickedUser,
                    decoration: InputDecoration(
                      labelText: 'Select Employee',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.person_search),
                    ),
                    items: users
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(
                                  '${u.firstName} ${u.lastName} (${u.email})'),
                            ))
                        .toList(),
                    onChanged: (u) => setDialogState(() => pickedUser = u),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              FilledButton.icon(
                onPressed: pickedUser != null
                    ? () => Navigator.pop(ctx, pickedUser)
                    : null,
                icon: const Icon(Icons.send, size: 18),
                label: const Text('Assign'),
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
                'Assigned ${_curriculumVersionIds.length} courses to ${picked.firstName} ${picked.lastName}'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Assignment failed: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return AppShell(
        title: 'Role-Based Curriculum Manager',
        icon: Icons.account_tree,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return AppShell(
        title: 'Role-Based Curriculum Manager',
        icon: Icons.account_tree,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.destructive),
              const SizedBox(height: 16),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return AppShell(
      title: 'Role-Based Curriculum Manager',
      icon: Icons.account_tree,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ═══════════════════════════════════════════════════════════════════
          // LEFT PANE: Job Roles Sidebar (Flex 1)
          // ═══════════════════════════════════════════════════════════════════
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Sidebar Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.indigo100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.badge,
                              size: 20, color: AppColors.indigo600),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Job Roles',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '${_jobRoles.length} roles configured',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.slate500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Roles List
                  Expanded(
                    child: _jobRoles.isEmpty
                        ? const EmptyState(
                            message: 'No job roles found',
                            icon: Icons.work_off,
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: _jobRoles.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 4),
                            itemBuilder: (context, index) {
                              final role = _jobRoles[index];
                              final isSelected =
                                  _selectedRole?.id == role.id;
                              return _JobRoleCard(
                                role: role,
                                isSelected: isSelected,
                                onTap: () => _selectRole(role),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          // ═══════════════════════════════════════════════════════════════════
          // RIGHT PANE: Curriculum Workspace (Flex 3)
          // ═══════════════════════════════════════════════════════════════════
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Workspace Header
                  _buildWorkspaceHeader(),
                  const Divider(height: 1),
                  // Course Grid
                  Expanded(
                    child: _selectedRole == null
                        ? const EmptyState(
                            message: 'Select a job role to manage its curriculum',
                            icon: Icons.touch_app,
                          )
                        : _buildCourseGrid(),
                  ),
                  // Action Bar
                  if (_selectedRole != null) _buildActionBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Workspace Header
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildWorkspaceHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.indigo600.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.school, color: AppColors.indigo600, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedRole?.name ?? 'Select a Role',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildStatBadge(
                      icon: Icons.menu_book,
                      label: '${_curriculumCourseIds.length} courses',
                      color: AppColors.indigo600,
                    ),
                    const SizedBox(width: 12),
                    if (_hasChanges)
                      _buildStatBadge(
                        icon: Icons.edit_note,
                        label: 'Unsaved changes',
                        color: AppColors.warning,
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Quick Actions
          Row(
            children: [
              _HeaderActionButton(
                icon: Icons.upload_file,
                label: 'Bulk Import',
                onPressed: _showBulkImport,
              ),
              const SizedBox(width: 8),
              _HeaderActionButton(
                icon: Icons.person_add,
                label: 'Assign to User',
                onPressed:
                    _curriculumVersionIds.isEmpty ? null : _assignToUser,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Course Grid
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildCourseGrid() {
    if (_courses.isEmpty) {
      return const EmptyState(
        message: 'No courses available',
        icon: Icons.library_books,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive column count
        final width = constraints.maxWidth;
        final crossAxisCount = width > 1200
            ? 4
            : width > 900
                ? 3
                : width > 600
                    ? 2
                    : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
          ),
          itemCount: _courses.length,
          itemBuilder: (context, index) {
            final course = _courses[index];
            final courseId = course.id;
            if (courseId == null) return const SizedBox.shrink();

            final isInCurriculum = _curriculumCourseIds.contains(courseId);
            final wasInCurriculum = _lastSavedCourseIds.contains(courseId);
            final isAdded = isInCurriculum && !wasInCurriculum;
            final isRemoved = !isInCurriculum && wasInCurriculum;

            return _CourseCard(
              course: course,
              isSelected: isInCurriculum,
              isAdded: isAdded,
              isRemoved: isRemoved,
              onToggle: () => _toggleCourse(courseId),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Action Bar
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildActionBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          // Diff Summary
          if (_hasChanges) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_addedCourseIds.isNotEmpty) ...[
                    Icon(Icons.add_circle, size: 16, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(
                      '+${_addedCourseIds.length}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (_removedCourseIds.isNotEmpty) ...[
                    Icon(Icons.remove_circle,
                        size: 16, color: AppColors.destructive),
                    const SizedBox(width: 4),
                    Text(
                      '-${_removedCourseIds.length}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.destructive,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
          const Spacer(),
          // Action Buttons
          if (_hasChanges) ...[
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _curriculumCourseIds = Set.from(_lastSavedCourseIds);
                });
              },
              child: const Text('Discard Changes'),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: _savingMatrix ? null : _showDiffPreviewAndSubmitToQA,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.indigo600,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              icon: _savingMatrix
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.rate_review, size: 18),
              label: Text(
                _savingMatrix ? 'Saving...' : 'Review Changes & Submit to QA',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ] else ...[
            FilledButton.icon(
              onPressed: _savingMatrix ? null : _saveMatrix,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.slate600,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              icon: const Icon(Icons.save, size: 18),
              label: const Text('Save Matrix'),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SUPPORTING WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

/// Job Role Card in Sidebar
class _JobRoleCard extends StatelessWidget {
  const _JobRoleCard({
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final JobRole role;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.indigo50 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.indigo200 : AppColors.slate200,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.indigo100 : AppColors.slate100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.work,
                  size: 18,
                  color:
                      isSelected ? AppColors.indigo600 : AppColors.slate500,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.name,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.indigo700
                            : AppColors.slate700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      role.code,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? AppColors.indigo600
                            : AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.chevron_right, color: AppColors.indigo600),
            ],
          ),
        ),
      ),
    );
  }
}

/// Course Selection Card in Grid
class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.isSelected,
    required this.isAdded,
    required this.isRemoved,
    required this.onToggle,
  });

  final Course course;
  final bool isSelected;
  final bool isAdded;
  final bool isRemoved;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.slate200;
    Color bgColor = Colors.white;
    Color? indicatorColor;

    if (isSelected) {
      borderColor = AppColors.indigo200;
      bgColor = AppColors.indigo50;
    }
    if (isAdded) {
      borderColor = AppColors.success;
      indicatorColor = AppColors.success;
    }
    if (isRemoved) {
      borderColor = AppColors.destructive;
      indicatorColor = AppColors.destructive;
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: isAdded || isRemoved ? 2 : 1),
          ),
          child: Row(
            children: [
              // Course Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getStatusColor(course.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.menu_book,
                  size: 20,
                  color: _getStatusColor(course.status),
                ),
              ),
              const SizedBox(width: 12),
              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            course.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (indicatorColor != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: indicatorColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isAdded ? 'NEW' : 'REMOVED',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: indicatorColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${course.sopNumber ?? 'ID: ${course.id}'} • ${course.status}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              // Checkbox
              Transform.scale(
                scale: 1.1,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onToggle(),
                  activeColor: AppColors.indigo600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'effective':
        return AppColors.success;
      case 'draft':
        return AppColors.warning;
      case 'archived':
        return AppColors.slate400;
      default:
        return AppColors.indigo600;
    }
  }
}

/// Header Action Button
class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.slate700,
        side: BorderSide(color: AppColors.slate300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADM-WF-03: DIFF PREVIEW DIALOG
// ═══════════════════════════════════════════════════════════════════════════════
class _DiffPreviewDialog extends StatelessWidget {
  const _DiffPreviewDialog({
    required this.roleName,
    required this.addedCourses,
    required this.removedCourses,
  });

  final String roleName;
  final List<String> addedCourses;
  final List<String> removedCourses;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 520,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.difference,
                        color: AppColors.indigo600, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Review Matrix Changes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate800,
                          ),
                        ),
                        Text(
                          'ADM-WF-03 • Diff Preview for "$roleName"',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.slate600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(Icons.close),
                    color: AppColors.slate500,
                  ),
                ],
              ),
            ),

            // Compliance Notice
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.info.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.gpp_good, size: 20, color: AppColors.info),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '21 CFR Part 11: Matrix changes require QA e-signature before taking effect.',
                      style: TextStyle(fontSize: 13, color: AppColors.info),
                    ),
                  ),
                ],
              ),
            ),

            // Diff Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Added Courses
                    if (addedCourses.isNotEmpty) ...[
                      _DiffSection(
                        title: 'Added Courses',
                        icon: Icons.add_circle,
                        color: AppColors.success,
                        items: addedCourses,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Removed Courses
                    if (removedCourses.isNotEmpty)
                      _DiffSection(
                        title: 'Removed Courses',
                        icon: Icons.remove_circle,
                        color: AppColors.destructive,
                        items: removedCourses,
                      ),
                  ],
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pop(context, true),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.indigo600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.draw, size: 18),
                      label: const Text('Confirm & Proceed to E-Sign'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Diff Section Widget (Added/Removed)
class _DiffSection extends StatelessWidget {
  const _DiffSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
                Text(
                  '$title (${items.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Items
          ...items.map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: color.withOpacity(0.1)),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu_book, size: 16, color: color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
