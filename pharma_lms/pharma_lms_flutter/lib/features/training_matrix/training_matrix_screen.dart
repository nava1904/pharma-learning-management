import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
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
      });
    } catch (_) {
      setState(() {
        _curriculumVersionIds = [];
        _curriculumCourseIds = [];
      });
    }
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
