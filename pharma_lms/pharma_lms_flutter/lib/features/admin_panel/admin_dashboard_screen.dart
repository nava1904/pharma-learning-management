import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/stat_card.dart';

/// Training Admin: 4 stat cards, Quick Actions, Compliance Heatmap, Course Management.
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final _searchController = TextEditingController();
  String _filterStatus = 'all';
  int _assignedById = 1;

  @override
  void initState() {
    super.initState();
    _loadAssignedBy();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAssignedBy() async {
    final user = await client.user.getUserByEmail('admin@pharmacorp.demo');
    if (user?.id != null) {
      setState(() => _assignedById = user!.id!);
    }
  }

  Future<void> _showAssignmentWizard() async {
    Department? dept;
    PharmaUser? user;
    Course? course;
    CourseVersion? version;
    List<CourseVersion> versions = [];
    List<Department> departments = [];
    List<PharmaUser> users = [];
    List<Course> courses = [];

    try {
      final orgs = await client.organization.listOrganizations();
      if (orgs.isNotEmpty && orgs.first.id != null) {
        final sites = await client.organization.listSites(orgs.first.id!);
        if (sites.isNotEmpty && sites.first.id != null) {
          departments =
              await client.organization.listDepartments(sites.first.id!);
        }
      }
      users = await client.organization.listUsers();
      courses = await client.course.listCourses();
      if (courses.isNotEmpty && courses.first.id != null) {
        versions = await client.course.getCourseVersions(courses.first.id!);
        version = versions.isNotEmpty ? versions.first : null;
      }
    } catch (_) {}

    final dueController = TextEditingController(
      text: DateTime.now().add(const Duration(days: 30)).toString().split(' ')[0],
    );

    if (!mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return AlertDialog(
            title: const Text('Assign Training'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Department>(
                    value: dept,
                    decoration: const InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder()),
                    items: departments
                        .map((d) =>
                            DropdownMenuItem(value: d, child: Text(d.name)))
                        .toList(),
                    onChanged: (d) => setState(() => dept = d),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<PharmaUser>(
                    value: user,
                    decoration: const InputDecoration(
                        labelText: 'User (optional)',
                        border: OutlineInputBorder()),
                    items: users
                        .map((u) => DropdownMenuItem(
                            value: u,
                            child: Text(
                                '${u.firstName} ${u.lastName} (${u.email})')))
                        .toList(),
                    onChanged: (u) => setState(() => user = u),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Course>(
                    initialValue: course,
                    decoration: const InputDecoration(
                        labelText: 'Course',
                        border: OutlineInputBorder()),
                    items: courses
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c.title)))
                        .toList(),
                    onChanged: (c) async {
                      course = c;
                      version = null;
                      if (c?.id != null) {
                        final v =
                            await client.course.getCourseVersions(c!.id!);
                        setState(() {
                          versions = v;
                          version = v.isNotEmpty ? v.first : null;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<CourseVersion>(
                    value: version,
                    decoration: const InputDecoration(
                        labelText: 'Course Version',
                        border: OutlineInputBorder()),
                    items: versions
                        .map((v) => DropdownMenuItem(
                            value: v, child: Text('v${v.version}')))
                        .toList(),
                    onChanged: (v) => setState(() => version = v),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: dueController,
                    decoration: const InputDecoration(
                        labelText: 'Due date (YYYY-MM-DD)',
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx,
                    (dept != null || user != null) && version != null),
                child: const Text('Assign'),
              ),
            ],
          );
        },
      ),
    );

    if (ok != true || !mounted) return;

    final due =
        DateTime.tryParse(dueController.text) ??
        DateTime.now().add(const Duration(days: 30));

    try {
      if (dept?.id != null && version?.id != null) {
        await client.admin.assignTrainingToDepartment(
          departmentId: dept!.id!,
          courseVersionId: version!.id!,
          assignedById: _assignedById,
          dueDate: due,
          source: 'manual',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Assigned to department')));
        }
      } else if (user?.id != null && version?.id != null) {
        try {
          await client.training.assignTraining(
            userId: user!.id!,
            courseVersionId: version!.id!,
            assignedById: _assignedById,
            dueDate: due,
            priority: 'medium',
            source: 'manual',
            forceReassign: false,
          );
        } catch (e) {
          final msg = e.toString();
          if (mounted &&
              msg.contains('active assignment') &&
              msg.contains('forceReassign')) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Duplicate Assignment'),
                content: const Text(
                  'User already has an active assignment for this course. '
                  'Do you want to reassign?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Reassign'),
                  ),
                ],
              ),
            );
            if (confirm == true && mounted) {
              await client.training.assignTraining(
                userId: user!.id!,
                courseVersionId: version!.id!,
                assignedById: _assignedById,
                dueDate: due,
                priority: 'medium',
                source: 'manual',
                forceReassign: true,
              );
            } else {
              rethrow;
            }
          } else {
            rethrow;
          }
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Assigned to user')));
        }
      }
      ref.invalidate(departmentComplianceSummaryProvider);
      ref.invalidate(coursesProvider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  Future<void> _bulkImport() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result == null || result.files.isEmpty || !mounted) return;

    final bytes = result.files.first.bytes;
    if (bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read file')));
      return;
    }

    final csvBase64 = base64Encode(bytes);
    try {
      final res = await client.admin.bulkImportUsers(
        csvBase64: csvBase64,
        assignedById: _assignedById,
        dueDate: DateTime.now().add(const Duration(days: 30)),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Imported ${res.imported} users. Errors: ${res.errors}')),
        );
        ref.invalidate(departmentComplianceSummaryProvider);
        ref.invalidate(usersProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Import failed: $e')));
      }
    }
  }

  Future<void> _showUserManagementDialog() async {
    List<PharmaUser> users = [];
    try {
      users = await client.organization.listUsers();
    } catch (_) {}

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('User Management'),
        content: SizedBox(
          width: 400,
          child: users.isEmpty
              ? const Text('No users found')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, i) {
                    final u = users[i];
                    final email = u.email;
                    return ListTile(
                      title: Text('${u.firstName} ${u.lastName}'),
                      subtitle: Text(email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () async {
                              try {
                                final ok = await client.admin.lockUserByEmail(email);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        ok ? 'User locked' : 'User not found',
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed: $e')),
                                  );
                                }
                              }
                            },
                            child: const Text('Lock'),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                final ok = await client.admin.unlockUserByEmail(email);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        ok ? 'User unlocked' : 'User not found',
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed: $e')),
                                  );
                                }
                              }
                            },
                            child: const Text('Unlock'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSignatureMeaningsDialog() async {
    List<SignatureMeaning> meanings = [];
    try {
      meanings = await client.admin.listSignatureMeanings();
    } catch (_) {}

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => _SignatureMeaningsDialog(
        initialMeanings: meanings,
        onCreate: (meaning, orderIndex) async {
          await client.admin.createSignatureMeaning(
            meaning: meaning,
            isActive: true,
            orderIndex: orderIndex,
          );
        },
        onUpdate: (id, meaning, isActive, orderIndex) async {
          await client.admin.updateSignatureMeaning(
            id: id,
            meaning: meaning,
            isActive: isActive,
            orderIndex: orderIndex,
          );
        },
      ),
    );
  }

  Future<void> _exportComplianceReport() async {
    try {
      final summary = await client.analytics.getDepartmentComplianceSummary();
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (ctx) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Compliance Report',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              ...summary.map((m) => pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      '${m.departmentName}: ${m.complianceRate.toStringAsFixed(1)}%',
                    ),
                  )),
            ],
          ),
        ),
      );

      var bytes = await pdf.save();
      final hash = sha256.convert(bytes).toString();
      pdf.addPage(
        pw.Page(
          build: (ctx) => pw.Center(
            child: pw.Text(
              'Report Hash: $hash',
              style: pw.TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
      bytes = await pdf.save();
      try {
        await client.audit.logReportExport(
          reportType: 'compliance_report',
          hashSha256: hash,
        );
      } catch (_) {}
      final result = await FilePicker.platform.saveFile(
        fileName: 'compliance-report-${DateTime.now().toIso8601String().split('T')[0]}.pdf',
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result != null
                  ? 'Report saved'
                  : 'Report generated (cancelled or saved)',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return AppShell(
      title: 'Training Administrator Portal',
      icon: Icons.people,
      child: userAsync.when(
        data: (_) => _AdminDashboardContent(
          searchController: _searchController,
          filterStatus: _filterStatus,
          onFilterChanged: (v) => setState(() => _filterStatus = v),
          onSearchChanged: () => setState(() {}),
          onAssignTraining: _showAssignmentWizard,
          onBulkImport: _bulkImport,
          onExportReport: _exportComplianceReport,
          onManageSignatureMeanings: _showSignatureMeaningsDialog,
          onManageUsers: _showUserManagementDialog,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorDisplay(e)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(currentUserProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _errorDisplay(Object e) => e.toString();
}

class _AdminDashboardContent extends ConsumerWidget {
  const _AdminDashboardContent({
    required this.searchController,
    required this.filterStatus,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onAssignTraining,
    required this.onBulkImport,
    required this.onExportReport,
    required this.onManageSignatureMeanings,
    required this.onManageUsers,
  });

  final TextEditingController searchController;
  final String filterStatus;
  final VoidCallback onSearchChanged;
  final void Function(String) onFilterChanged;
  final VoidCallback onAssignTraining;
  final VoidCallback onBulkImport;
  final VoidCallback onExportReport;
  final VoidCallback onManageSignatureMeanings;
  final VoidCallback onManageUsers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);
    final coursesAsync = ref.watch(coursesProvider);
    final complianceAsync = ref.watch(departmentComplianceSummaryProvider);
    final nonCompliantAsync = ref.watch(nonCompliantEmployeesProvider);
    final upcomingExpAsync = ref.watch(upcomingExpirationsByDeptProvider);
    final recentAssignAsync = ref.watch(recentAssignmentsProvider);
    final openCapasAsync = ref.watch(openCapasRequiringTrainingProvider);
    final pendingQaAsync = ref.watch(pendingQaApprovalsCountProvider);
    final sopQueueAsync = ref.watch(sopRetrainingQueueProvider);
    final dlqAsync = ref.watch(dlqFailureCountProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(usersProvider);
        ref.invalidate(coursesProvider);
        ref.invalidate(departmentComplianceSummaryProvider);
        ref.invalidate(nonCompliantEmployeesProvider);
        ref.invalidate(upcomingExpirationsByDeptProvider);
        ref.invalidate(recentAssignmentsProvider);
        ref.invalidate(openCapasRequiringTrainingProvider);
        ref.invalidate(pendingQaApprovalsCountProvider);
        ref.invalidate(sopRetrainingQueueProvider);
        ref.invalidate(dlqFailureCountProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // 4 stat cards
          usersAsync.when(
            data: (users) {
              final courses = coursesAsync.valueOrNull ?? [];
              final compliance = complianceAsync.valueOrNull ?? [];
              final totalEmployees = users.length;
              final activeCourses =
                  courses.where((c) => c.status == 'approved').length;
              final overallCompliance = compliance.isEmpty
                  ? 0.0
                  : compliance
                          .map((c) => c.complianceRate)
                          .reduce((a, b) => a + b) /
                      compliance.length;
              final totalOverdue =
                  compliance.fold<int>(0, (s, c) => s + c.overdue);

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount =
                      constraints.maxWidth > 600 ? 4 : (constraints.maxWidth > 400 ? 2 : 1);
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      StatCard(
                        label: 'Total Employees',
                        value: '$totalEmployees',
                        icon: Icons.people,
                        iconBackgroundColor: AppColors.indigo100,
                        iconColor: AppColors.indigo600,
                      ),
                      StatCard(
                        label: 'Active Courses',
                        value: '$activeCourses',
                        icon: Icons.menu_book,
                        iconBackgroundColor: const Color(0xFFDCFCE7),
                        iconColor: const Color(0xFF16A34A),
                      ),
                      StatCard(
                        label: 'Overall Compliance',
                        value: '${overallCompliance.toStringAsFixed(0)}%',
                        icon: Icons.trending_up,
                        iconBackgroundColor: const Color(0xFFFEF3C7),
                        iconColor: const Color(0xFFD97706),
                      ),
                      StatCard(
                        label: 'Overdue Training',
                        value: '$totalOverdue',
                        icon: Icons.warning_amber_rounded,
                        iconBackgroundColor: const Color(0xFFFEE2E2),
                        iconColor: AppColors.destructive,
                      ),
                    ],
                  );
                },
              );
            },
            loading: () => const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator())),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 24),

          // Non-Compliant Employees list
          nonCompliantAsync.when(
            data: (employees) {
              if (employees.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Non-Compliant Employees',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Column(
                      children: employees.take(10).map((u) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.person_off, color: AppColors.destructive, size: 20),
                        title: Text('${u.firstName} ${u.lastName}', style: const TextStyle(fontSize: 14)),
                        subtitle: Text(u.email, style: const TextStyle(fontSize: 12)),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Pending QA, Open CAPAs, Recent Assignments, SOP Queue, System Alerts
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              pendingQaAsync.when(
                data: (c) => SizedBox(width: 160, child: StatCard(label: 'Pending QA', value: '$c', icon: Icons.pending_actions, iconBackgroundColor: const Color(0xFFFEF3C7), iconColor: const Color(0xFFD97706))),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              openCapasAsync.when(
                data: (list) => SizedBox(width: 160, child: StatCard(label: 'Open CAPAs', value: '${list.length}', icon: Icons.assignment_late, iconBackgroundColor: const Color(0xFFFEE2E2), iconColor: AppColors.destructive)),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              recentAssignAsync.when(
                data: (list) => SizedBox(width: 160, child: StatCard(label: 'Recent Assignments', value: '${list.length}', icon: Icons.assignment, iconBackgroundColor: AppColors.indigo100, iconColor: AppColors.indigo600)),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              sopQueueAsync.when(
                data: (list) => SizedBox(width: 160, child: StatCard(label: 'SOP Retraining', value: '${list.length}', icon: Icons.update, iconBackgroundColor: const Color(0xFFE0E7FF), iconColor: const Color(0xFF4F46E5))),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              dlqAsync.when(
                data: (c) => SizedBox(width: 160, child: StatCard(label: 'System Alerts', value: '$c', icon: Icons.warning, iconBackgroundColor: c > 0 ? const Color(0xFFFEE2E2) : AppColors.slate100, iconColor: c > 0 ? AppColors.destructive : AppColors.slate600)),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate900,
                ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount =
                  constraints.maxWidth > 600 ? 3 : (constraints.maxWidth > 400 ? 2 : 1);
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.2,
                children: [
                  QuickActionButton(
                    label: 'Assign Training',
                    subtitle: 'By role, department, or individual',
                    icon: Icons.add,
                    onPressed: onAssignTraining,
                    backgroundColor: AppColors.indigo50,
                    borderColor: AppColors.indigo200,
                    iconColor: AppColors.indigo600,
                  ),
                  QuickActionButton(
                    label: 'Training Matrix',
                    subtitle: 'Role-based curriculum mapping',
                    icon: Icons.grid_view,
                    onPressed: () => context.push('/training-matrix'),
                    backgroundColor: const Color(0xFFFEF3C7),
                    borderColor: const Color(0xFFFCD34D),
                    iconColor: const Color(0xFFD97706),
                  ),
                  QuickActionButton(
                    label: 'Training Waivers',
                    subtitle: 'Request, approve, or reject waivers',
                    icon: Icons.verified_user,
                    onPressed: () => context.push('/admin/training-waivers'),
                    backgroundColor: const Color(0xFFDCFCE7),
                    borderColor: const Color(0xFF86EFAC),
                    iconColor: const Color(0xFF16A34A),
                  ),
                  QuickActionButton(
                    label: 'Create Course',
                    subtitle: 'Build new training module',
                    icon: Icons.menu_book,
                    onPressed: () => context.push('/trainer/course-builder'),
                    backgroundColor: const Color(0xFFDCFCE7),
                    borderColor: const Color(0xFF86EFAC),
                    iconColor: const Color(0xFF16A34A),
                  ),
                  QuickActionButton(
                    label: 'Generate Report',
                    subtitle: 'Export compliance data',
                    icon: Icons.bar_chart,
                    onPressed: () => context.push('/compliance-report'),
                    backgroundColor: const Color(0xFFFEF3C7),
                    borderColor: const Color(0xFFFDE047),
                    iconColor: const Color(0xFFD97706),
                  ),
                  QuickActionButton(
                    label: 'E-Signature Meanings',
                    subtitle: 'Configure 21 CFR Part 11 signature meanings',
                    icon: Icons.draw,
                    onPressed: onManageSignatureMeanings,
                    backgroundColor: const Color(0xFFE0E7FF),
                    borderColor: const Color(0xFFA5B4FC),
                    iconColor: const Color(0xFF4F46E5),
                  ),
                  QuickActionButton(
                    label: 'User Management',
                    subtitle: 'Lock or unlock user accounts',
                    icon: Icons.lock,
                    onPressed: onManageUsers,
                    backgroundColor: const Color(0xFFFEE2E2),
                    borderColor: const Color(0xFFFECACA),
                    iconColor: AppColors.destructive,
                  ),
                  QuickActionButton(
                    label: 'Document Control',
                    subtitle: 'SOPs, QA classification',
                    icon: Icons.description,
                    onPressed: () => context.push('/documents'),
                    backgroundColor: const Color(0xFFE0E7FF),
                    borderColor: const Color(0xFFA5B4FC),
                    iconColor: const Color(0xFF4F46E5),
                  ),
                  QuickActionButton(
                    label: 'Event Triggers',
                    subtitle: 'Test workflows without Kafka',
                    icon: Icons.play_arrow,
                    onPressed: () => context.push('/event-triggers'),
                    backgroundColor: const Color(0xFFF3E8FF),
                    borderColor: const Color(0xFFE9D5FF),
                    iconColor: const Color(0xFF7C3AED),
                  ),
                  QuickActionButton(
                    label: 'Inspection Management',
                    subtitle: 'Create auditor tokens & packages',
                    icon: Icons.assignment,
                    onPressed: () => context.push('/inspection-management'),
                    backgroundColor: const Color(0xFFE0F2FE),
                    borderColor: const Color(0xFF7DD3FC),
                    iconColor: const Color(0xFF0284C7),
                  ),
                  QuickActionButton(
                    label: 'System Health',
                    subtitle: 'Job status, DLQ, DB connectivity',
                    icon: Icons.health_and_safety,
                    onPressed: () => context.push('/admin/health'),
                    backgroundColor: const Color(0xFFF0FDF4),
                    borderColor: const Color(0xFFBBF7D0),
                    iconColor: const Color(0xFF15803D),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Compliance Heatmap
          Text(
            'Department Compliance Heatmap',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate900,
                ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            child: complianceAsync.when(
              data: (summary) {
                if (summary.isEmpty) {
                  return const EmptyState(message: 'No compliance data');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: summary.map((dept) {
                    final rate = dept.complianceRate;
                    final color = rate >= 95
                        ? AppColors.success
                        : rate >= 90
                            ? AppColors.warning
                            : AppColors.destructive;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dept.departmentName ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.slate900,
                                          ),
                                    ),
                                    Text(
                                      '${dept.compliant} / ${dept.totalEmployees} compliant',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.slate600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              if (dept.overdue > 0)
                                Text(
                                  '${dept.overdue} overdue',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.destructive,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              const SizedBox(width: 8),
                              Text(
                                '${rate.toStringAsFixed(1)}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: rate / 100,
                              minHeight: 8,
                              backgroundColor: AppColors.slate200,
                              valueColor: AlwaysStoppedAnimation<Color>(color),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
          const SizedBox(height: 24),

          // Course Management
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Course Management',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate900,
                    ),
              ),
              TextButton.icon(
                onPressed: () => context.push('/trainer/course-builder'),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('New Course'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search and filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search courses...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => onSearchChanged(),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: filterStatus,
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All Status')),
                  DropdownMenuItem(value: 'approved', child: Text('Approved')),
                  DropdownMenuItem(value: 'pending-qa', child: Text('Pending QA')),
                  DropdownMenuItem(value: 'draft', child: Text('Draft')),
                ],
                onChanged: (v) => v != null ? onFilterChanged(v) : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          coursesAsync.when(
            data: (courses) {
              var filtered = courses;
              final term = searchController.text;
              if (term.isNotEmpty) {
                filtered = filtered
                    .where((c) =>
                        c.title.toLowerCase().contains(term.toLowerCase()))
                    .toList();
              }
              if (filterStatus != 'all') {
                filtered =
                    filtered.where((c) => c.status == filterStatus).toList();
              }
              if (filtered.isEmpty) {
                return const EmptyState(message: 'No courses match');
              }
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Column(
                  children: filtered.asMap().entries.map((entry) {
                    final index = entry.key;
                    final course = entry.value;
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.slate200,
                            width: index < filtered.length - 1 ? 1 : 0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      course.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.slate900,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: course.status == 'approved'
                                            ? const Color(0xFFDCFCE7)
                                            : course.status == 'pending-qa'
                                                ? const Color(0xFFFEF3C7)
                                                : AppColors.slate100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        course.status.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: course.status == 'approved'
                                                  ? const Color(0xFF166534)
                                                  : course.status ==
                                                          'pending-qa'
                                                      ? const Color(0xFF854D0E)
                                                      : AppColors.slate700,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (course.description != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    course.description!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.slate600,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => context.push(
                                    '/trainer/course-builder',
                                    extra: course),
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: onAssignTraining,
                                child: const Text('Assign'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            loading: () =>
                const Center(child: Padding(padding: EdgeInsets.all(48), child: CircularProgressIndicator())),
            error: (e, _) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }
}

class _SignatureMeaningsDialog extends StatefulWidget {
  const _SignatureMeaningsDialog({
    required this.initialMeanings,
    required this.onCreate,
    required this.onUpdate,
  });

  final List<SignatureMeaning> initialMeanings;
  final Future<void> Function(String meaning, int orderIndex) onCreate;
  final Future<void> Function(
    int id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
  ) onUpdate;

  @override
  State<_SignatureMeaningsDialog> createState() =>
      _SignatureMeaningsDialogState();
}

class _SignatureMeaningsDialogState extends State<_SignatureMeaningsDialog> {
  late List<SignatureMeaning> _meanings;
  final _newMeaningController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _meanings = List.from(widget.initialMeanings);
  }

  @override
  void dispose() {
    _newMeaningController.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final text = _newMeaningController.text.trim();
    if (text.isEmpty) return;
    setState(() => _saving = true);
    try {
      await widget.onCreate(text, _meanings.length);
      if (mounted) {
        final updated =
            await client.admin.listSignatureMeanings();
        setState(() {
          _meanings = updated;
          _newMeaningController.clear();
          _saving = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _toggleActive(SignatureMeaning m) async {
    final id = m.id;
    if (id == null) return;
    setState(() => _saving = true);
    try {
      await widget.onUpdate(id, null, !m.isActive, null);
      if (mounted) {
        final updated = await client.admin.listSignatureMeanings();
        setState(() {
          _meanings = updated;
          _saving = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('E-Signature Meanings'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Configure FDA-compliant signature meanings for 21 CFR Part 11.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ..._meanings.map((m) => ListTile(
                    title: Text(m.meaning),
                    subtitle: Text(
                      'Order: ${m.orderIndex} • ${m.isActive ? "Active" : "Inactive"}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Switch(
                      value: m.isActive,
                      onChanged: _saving ? null : (_) => _toggleActive(m),
                    ),
                  )),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _newMeaningController,
                      decoration: const InputDecoration(
                        labelText: 'New meaning',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _add(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saving ? null : _add,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
