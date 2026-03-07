import 'dart:convert';

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
        await client.training.assignTraining(
          userId: user!.id!,
          courseVersionId: version!.id!,
          assignedById: _assignedById,
          dueDate: due,
          priority: 'medium',
          source: 'manual',
        );
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

      final bytes = await pdf.save();
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
  });

  final TextEditingController searchController;
  final String filterStatus;
  final VoidCallback onSearchChanged;
  final void Function(String) onFilterChanged;
  final VoidCallback onAssignTraining;
  final VoidCallback onBulkImport;
  final VoidCallback onExportReport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);
    final coursesAsync = ref.watch(coursesProvider);
    final complianceAsync = ref.watch(departmentComplianceSummaryProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(usersProvider);
        ref.invalidate(coursesProvider);
        ref.invalidate(departmentComplianceSummaryProvider);
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
