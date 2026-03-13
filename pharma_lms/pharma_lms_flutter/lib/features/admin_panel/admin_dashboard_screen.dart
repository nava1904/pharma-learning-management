import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' as protocol;
import 'package:pdf/widgets.dart' as pw;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../design_system/colors.dart';
import '../../providers/analytics_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/compliance_heatmap.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/stat_card.dart';

/// Admin Control Center - Salesforce-inspired tabbed dashboard.
/// Implements ADM-WF-01, ADM-WF-02, ADM-WF-04, ADM-WF-07.
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _filterStatus = 'all';
  int _assignedById = 1;

  // Report generation state
  String _reportTemplate = 'dept_summary';
  DateTime? _reportFromDate;
  DateTime? _reportToDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadAssignedBy();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAssignedBy() async {
    final user = await client.user.getUserByEmail('admin@pharmacorp.demo');
    if (user?.id != null && mounted) {
      setState(() => _assignedById = user!.id!);
    }
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ADM-WF-01: Manually Assign Training
  // ════════════════════════════════════════════════════════════════════════════
  Future<void> _showAssignmentWizard() async {
    protocol.Department? dept;
    protocol.PharmaUser? user;
    protocol.Course? course;
    protocol.CourseVersion? version;
    List<protocol.CourseVersion> versions = [];
    List<protocol.Department> departments = [];
    List<protocol.PharmaUser> users = [];
    List<protocol.Course> courses = [];
    String targetType = 'department';

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
        course = courses.first;
      }
    } catch (_) {}

    if (departments.isNotEmpty) {
      dept = departments.first;
    }

    final dueController = TextEditingController(
      text: DateTime.now().add(const Duration(days: 30)).toString().split(' ')[0],
    );
    final reasonController = TextEditingController();
    String assignmentCategory = 'ad_hoc';
    String priority = 'medium';

    if (!mounted) return;
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: DesignColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.assignment_add, color: DesignColors.primary, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assign Training',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'ADM-WF-01 • Manual Assignment',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey.shade200),
                    // Form
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        children: [
                          // Target Type Selection
                          Text('Assignment Target', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _SelectionChip(
                                  label: 'Individual',
                                  icon: Icons.person,
                                  selected: targetType == 'individual',
                                  onTap: () => setState(() {
                                    targetType = 'individual';
                                    dept = null;
                                    user = users.isNotEmpty ? users.first : null;
                                  }),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SelectionChip(
                                  label: 'Department',
                                  icon: Icons.business,
                                  selected: targetType == 'department',
                                  onTap: () => setState(() {
                                    targetType = 'department';
                                    user = null;
                                    dept = departments.isNotEmpty ? departments.first : null;
                                  }),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SelectionChip(
                                  label: 'Job Role',
                                  icon: Icons.work,
                                  selected: targetType == 'role',
                                  onTap: () => setState(() {
                                    targetType = 'role';
                                    user = null;
                                    dept = null;
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Target Selection
                          if (targetType == 'individual') ...[
                            DropdownButtonFormField<protocol.PharmaUser>(
                              value: user,
                              decoration: InputDecoration(
                                labelText: 'Select Employee',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                prefixIcon: const Icon(Icons.person_search),
                              ),
                              items: users.map((u) => DropdownMenuItem(
                                value: u,
                                child: Text('${u.firstName} ${u.lastName} (${u.email})'),
                              )).toList(),
                              onChanged: (u) => setState(() => user = u),
                            ),
                          ] else if (targetType == 'department') ...[
                            DropdownButtonFormField<protocol.Department>(
                              value: dept,
                              decoration: InputDecoration(
                                labelText: 'Select Department',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                prefixIcon: const Icon(Icons.business),
                              ),
                              items: departments.map((d) => DropdownMenuItem(
                                value: d,
                                child: Text(d.name),
                              )).toList(),
                              onChanged: (d) => setState(() => dept = d),
                            ),
                          ] else ...[
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: DesignColors.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: DesignColors.warning.withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: DesignColors.warning),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Role-based assignment uses the Training Matrix. Configure it in Training Matrix settings.',
                                      style: TextStyle(color: DesignColors.warning, fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),

                          // Course Selection
                          Text('Course', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<protocol.Course>(
                            value: course,
                            decoration: InputDecoration(
                              labelText: 'Select Course',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              prefixIcon: const Icon(Icons.menu_book),
                            ),
                            items: courses.map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.title),
                            )).toList(),
                            onChanged: (c) async {
                              setState(() {
                                course = c;
                                version = null;
                              });
                              if (c?.id != null) {
                                final v = await client.course.getCourseVersions(c!.id!);
                                if (ctx2.mounted) {
                                  setState(() {
                                    versions = v;
                                    version = v.isNotEmpty ? v.first : null;
                                  });
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<protocol.CourseVersion>(
                            value: version,
                            decoration: InputDecoration(
                              labelText: 'Version',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              prefixIcon: const Icon(Icons.history),
                            ),
                            items: versions.map((v) => DropdownMenuItem(
                              value: v,
                              child: Text('Version ${v.version} (${v.status})'),
                            )).toList(),
                            onChanged: (v) => setState(() => version = v),
                          ),
                          const SizedBox(height: 20),

                          // Assignment Details
                          Text('Assignment Details', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: dueController,
                                  decoration: InputDecoration(
                                    labelText: 'Due Date',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    prefixIcon: const Icon(Icons.calendar_today),
                                    hintText: 'YYYY-MM-DD',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: priority,
                                  decoration: InputDecoration(
                                    labelText: 'Priority',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    prefixIcon: const Icon(Icons.flag),
                                  ),
                                  items: const [
                                    DropdownMenuItem(value: 'low', child: Text('Low')),
                                    DropdownMenuItem(value: 'medium', child: Text('Medium')),
                                    DropdownMenuItem(value: 'high', child: Text('High')),
                                  ],
                                  onChanged: (v) => setState(() => priority = v ?? 'medium'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: assignmentCategory,
                            decoration: InputDecoration(
                              labelText: 'Category (FR-06-04)',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              prefixIcon: const Icon(Icons.category),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'ad_hoc', child: Text('Ad hoc')),
                              DropdownMenuItem(value: 'regulatory_change', child: Text('Regulatory change')),
                              DropdownMenuItem(value: 'incident_related', child: Text('Incident related')),
                              DropdownMenuItem(value: 'new_hire_supplement', child: Text('New hire supplement')),
                              DropdownMenuItem(value: 'other', child: Text('Other')),
                            ],
                            onChanged: (v) => setState(() => assignmentCategory = v ?? 'ad_hoc'),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: reasonController,
                            decoration: InputDecoration(
                              labelText: 'Reason (Required)',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              prefixIcon: const Icon(Icons.description),
                              hintText: 'Enter assignment reason for audit trail',
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    // Actions
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: FilledButton.icon(
                                onPressed: () {
                                  final reason = reasonController.text.trim();
                                  if (reason.isEmpty) {
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                      const SnackBar(content: Text('Reason is required')),
                                    );
                                    return;
                                  }
                                  Navigator.pop(ctx, (dept != null || user != null) && version != null);
                                },
                                icon: const Icon(Icons.send),
                                label: const Text('Assign Training'),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: DesignColors.primary,
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
            },
          );
        },
      ),
    );

    if (ok != true || !mounted) return;

    final due = DateTime.tryParse(dueController.text) ?? DateTime.now().add(const Duration(days: 30));
    final reasonText = reasonController.text.trim();
    final reason = reasonText.isNotEmpty ? '[$assignmentCategory] $reasonText' : '[$assignmentCategory]';

    try {
      if (dept?.id != null && version?.id != null) {
        await client.admin.assignTrainingToDepartment(
          departmentId: dept!.id!,
          courseVersionId: version!.id!,
          assignedById: _assignedById,
          dueDate: due,
          reason: reason,
          source: 'manual',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Training assigned to department'),
                ],
              ),
              backgroundColor: DesignColors.success,
            ),
          );
        }
      } else if (user?.id != null && version?.id != null) {
        try {
          await client.training.assignTraining(
            userId: user!.id!,
            courseVersionId: version!.id!,
            assignedById: _assignedById,
            dueDate: due,
            priority: priority,
            reason: reason,
            source: 'manual',
            forceReassign: false,
          );
        } catch (e) {
          final msg = e.toString();
          if (mounted && msg.contains('active assignment') && msg.contains('forceReassign')) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Duplicate Assignment'),
                content: const Text(
                  'User already has an active assignment for this course. Do you want to reassign?',
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reassign')),
                ],
              ),
            );
            if (confirm == true && mounted) {
              await client.training.assignTraining(
                userId: user!.id!,
                courseVersionId: version!.id!,
                assignedById: _assignedById,
                dueDate: due,
                priority: priority,
                reason: reason,
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
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Training assigned to user'),
                ],
              ),
              backgroundColor: DesignColors.success,
            ),
          );
        }
      }
      ref.invalidate(departmentComplianceSummaryProvider);
      ref.invalidate(coursesProvider);
      ref.invalidate(recentAssignmentsProvider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ADM-WF-07: Terminate User
  // ════════════════════════════════════════════════════════════════════════════
  Future<void> _showTerminateUserDialog(protocol.PharmaUser user) async {
    final reasonController = TextEditingController();
    DateTime terminationDate = DateTime.now();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.destructive.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person_off, color: AppColors.destructive, size: 20),
                ),
                const SizedBox(width: 12),
                const Text('Terminate Employee'),
              ],
            ),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.destructive.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.destructive.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber, color: AppColors.destructive, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This action will revoke all sessions, cancel pending training, and block login access.',
                            style: TextStyle(color: AppColors.destructive, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Employee: ${user.firstName} ${user.lastName}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text('Email: ${user.email}', style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 20),
                  Text('Termination Date', style: Theme.of(ctx).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: terminationDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 90)),
                      );
                      if (picked != null) {
                        setState(() => terminationDate = picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 20),
                          const SizedBox(width: 12),
                          Text(DateFormat('yyyy-MM-dd').format(terminationDate)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: reasonController,
                    decoration: InputDecoration(
                      labelText: 'Termination Reason (Required)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      hintText: 'e.g., Resignation, End of contract',
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  if (reasonController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text('Termination reason is required')),
                    );
                    return;
                  }
                  Navigator.pop(ctx, true);
                },
                style: FilledButton.styleFrom(backgroundColor: AppColors.destructive),
                child: const Text('Terminate'),
              ),
            ],
          );
        },
      ),
    );

    if (confirmed != true || !mounted || user.id == null) return;

    try {
      await client.admin.terminateUser(
        userId: user.id!,
        terminationDate: terminationDate,
        reason: reasonController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Employee terminated successfully'),
              ],
            ),
            backgroundColor: AppColors.destructive,
          ),
        );
        ref.invalidate(usersProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ADM-WF-04: Generate Compliance Report
  // ════════════════════════════════════════════════════════════════════════════
  Future<void> _exportComplianceReport() async {
    try {
      final summary = await client.analytics.getDepartmentComplianceSummary();
      final pdf = pw.Document();
      final now = DateTime.now();
      final generatedBy = 'Admin';

      // Build report content based on template
      pdf.addPage(
        pw.MultiPage(
          build: (ctx) => [
            pw.Header(
              level: 0,
              child: pw.Text('Pharma LMS Compliance Report',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Paragraph(text: 'Report Type: ${_getReportTemplateName(_reportTemplate)}'),
            pw.Paragraph(text: 'Generated: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(now)} UTC'),
            if (_reportFromDate != null)
              pw.Paragraph(text: 'Date Range: ${DateFormat('yyyy-MM-dd').format(_reportFromDate!)} - ${_reportToDate != null ? DateFormat('yyyy-MM-dd').format(_reportToDate!) : 'Present'}'),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Department', 'Compliance Rate', 'Overdue', 'Total Employees'],
              data: summary.map((m) => [
                m.departmentName,
                '${m.complianceRate.toStringAsFixed(1)}%',
                '${m.overdue}',
                '${m.totalEmployees}',
              ]).toList(),
            ),
          ],
        ),
      );

      var bytes = await pdf.save();
      final hash = sha256.convert(bytes).toString();

      // Add watermark page with hash
      pdf.addPage(
        pw.Page(
          build: (ctx) => pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('OFFICIAL COMPLIANCE REPORT',
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Generated by $generatedBy on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(now)} UTC',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 10),
                pw.Text('Report Hash (SHA-256): $hash', style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ),
      );
      bytes = await pdf.save();

      // Log to audit trail (ADM-WF-04)
      try {
        await client.audit.logReportExport(
          reportType: _reportTemplate,
          hashSha256: hash,
        );
      } catch (_) {}

      final result = await FilePicker.platform.saveFile(
        fileName: 'compliance-report-${DateFormat('yyyy-MM-dd').format(now)}.pdf',
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(result != null ? 'Report saved with SHA-256 hash' : 'Report generated'),
              ],
            ),
            backgroundColor: DesignColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  String _getReportTemplateName(String template) {
    switch (template) {
      case 'dept_summary':
        return 'Department Summary';
      case 'individual_history':
        return 'Individual Training History';
      case 'matrix':
        return 'Training Matrix Report';
      default:
        return template;
    }
  }

  void _bulkImport() {
    context.push('/admin/bulk-import');
  }

  Future<void> _showSignatureMeaningsDialog() async {
    List<protocol.SignatureMeaning> meanings = [];
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

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Admin Control Center',
      icon: Icons.admin_panel_settings,
      child: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  tabBar: TabBar(
                    controller: _tabController,
                    labelColor: DesignColors.primary,
                    unselectedLabelColor: AppColors.slate600,
                    indicatorColor: DesignColors.primary,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    tabs: const [
                      Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
                      Tab(icon: Icon(Icons.people), text: 'User Management'),
                      Tab(icon: Icon(Icons.school), text: 'Training Ops'),
                      Tab(icon: Icon(Icons.security), text: 'System & Compliance'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            color: AppColors.slate50,
            child: TabBarView(
              controller: _tabController,
              children: [
                _OverviewTab(ref: ref),
                _UserManagementTab(
                  ref: ref,
                  onBulkImport: _bulkImport,
                  onTerminateUser: _showTerminateUserDialog,
                ),
                _TrainingOperationsTab(
                  ref: ref,
                  searchController: _searchController,
                  filterStatus: _filterStatus,
                  onFilterChanged: (v) => setState(() => _filterStatus = v),
                  onAssignTraining: _showAssignmentWizard,
                ),
                _SystemComplianceTab(
                  ref: ref,
                  reportTemplate: _reportTemplate,
                  reportFromDate: _reportFromDate,
                  reportToDate: _reportToDate,
                  onReportTemplateChanged: (v) => setState(() => _reportTemplate = v),
                  onFromDateChanged: (d) => setState(() => _reportFromDate = d),
                  onToDateChanged: (d) => setState(() => _reportToDate = d),
                  onExportReport: _exportComplianceReport,
                  onManageSignatureMeanings: _showSignatureMeaningsDialog,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 1: OVERVIEW
// ══════════════════════════════════════════════════════════════════════════════
class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(usersProvider);
    final coursesAsync = ref.watch(coursesProvider);
    final complianceAsync = ref.watch(departmentComplianceSummaryProvider);
    final nonCompliantAsync = ref.watch(nonCompliantEmployeesProvider);
    final pendingQaAsync = ref.watch(pendingQaApprovalsCountProvider);
    final openCapasAsync = ref.watch(openCapasRequiringTrainingProvider);
    final dlqAsync = ref.watch(dlqFailureCountProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(usersProvider);
        ref.invalidate(coursesProvider);
        ref.invalidate(departmentComplianceSummaryProvider);
        ref.invalidate(nonCompliantEmployeesProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Welcome Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [DesignColors.primary, DesignColors.primary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: DesignColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Training Administrator Portal',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Manage training assignments, compliance, and user accounts',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Main Stats Grid
          usersAsync.when(
            data: (users) {
              final courses = coursesAsync.valueOrNull ?? [];
              final compliance = complianceAsync.valueOrNull ?? [];
              final totalEmployees = users.length;
              final activeCourses = courses.where((c) => c.status == 'approved').length;
              final overallCompliance = compliance.isEmpty
                  ? 0.0
                  : compliance.map((c) => c.complianceRate).reduce((a, b) => a + b) / compliance.length;
              final totalOverdue = compliance.fold<int>(0, (s, c) => s + c.overdue);

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 2 : 1);
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.6,
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
            loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 24),

          // Secondary Stats Row
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              pendingQaAsync.when(
                data: (c) => SizedBox(
                  width: 160,
                  child: StatCard(
                    label: 'Pending QA',
                    value: '$c',
                    icon: Icons.pending_actions,
                    iconBackgroundColor: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              openCapasAsync.when(
                data: (list) => SizedBox(
                  width: 160,
                  child: StatCard(
                    label: 'Open CAPAs',
                    value: '${list.length}',
                    icon: Icons.assignment_late,
                    iconBackgroundColor: const Color(0xFFFEE2E2),
                    iconColor: AppColors.destructive,
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              dlqAsync.when(
                data: (c) => SizedBox(
                  width: 160,
                  child: StatCard(
                    label: 'System Alerts',
                    value: '$c',
                    icon: Icons.warning,
                    iconBackgroundColor: c > 0 ? const Color(0xFFFEE2E2) : AppColors.slate100,
                    iconColor: c > 0 ? AppColors.destructive : AppColors.slate600,
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Non-Compliant Employees
          nonCompliantAsync.when(
            data: (employees) {
              if (employees.isEmpty) return const SizedBox.shrink();
              return _SectionCard(
                title: 'Non-Compliant Employees',
                icon: Icons.person_off,
                iconColor: AppColors.destructive,
                child: Column(
                  children: employees.take(5).map((u) => ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: AppColors.destructive.withOpacity(0.1),
                      child: const Icon(Icons.person_off, color: AppColors.destructive, size: 18),
                    ),
                    title: Text('${u.firstName} ${u.lastName}'),
                    subtitle: Text(u.email),
                    trailing: const Icon(Icons.chevron_right),
                  )).toList(),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 24),

          // Compliance Heatmap
          _SectionCard(
            title: 'Department Compliance Heatmap',
            icon: Icons.grid_view,
            iconColor: DesignColors.primary,
            child: complianceAsync.when(
              data: (summary) {
                if (summary.isEmpty) {
                  return const EmptyState(message: 'No compliance data');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComplianceHeatmap(departments: summary, height: 200),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _HeatmapLegendItem(color: AppColors.success, label: '≥95%'),
                        const SizedBox(width: 16),
                        _HeatmapLegendItem(color: AppColors.warning, label: '90–95%'),
                        const SizedBox(width: 16),
                        _HeatmapLegendItem(color: AppColors.destructive, label: '<90%'),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 2: USER MANAGEMENT (ADM-WF-07)
// ══════════════════════════════════════════════════════════════════════════════
class _UserManagementTab extends StatelessWidget {
  const _UserManagementTab({
    required this.ref,
    required this.onBulkImport,
    required this.onTerminateUser,
  });

  final WidgetRef ref;
  final VoidCallback onBulkImport;
  final void Function(protocol.PharmaUser user) onTerminateUser;

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(usersProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(usersProvider),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  label: 'Bulk Import',
                  subtitle: 'CSV with column mapping',
                  icon: Icons.upload_file,
                  onPressed: onBulkImport,
                  backgroundColor: const Color(0xFFE0F2FE),
                  borderColor: const Color(0xFF7DD3FC),
                  iconColor: const Color(0xFF0284C7),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: QuickActionButton(
                  label: 'Add Single User',
                  subtitle: 'Manual user creation',
                  icon: Icons.person_add,
                  onPressed: () => context.push('/admin/add-user'),
                  backgroundColor: const Color(0xFFDCFCE7),
                  borderColor: const Color(0xFF86EFAC),
                  iconColor: const Color(0xFF16A34A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // User List
          _SectionCard(
            title: 'Employee Directory',
            icon: Icons.people,
            iconColor: DesignColors.primary,
            actions: [
              TextButton.icon(
                onPressed: () => ref.invalidate(usersProvider),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Refresh'),
              ),
            ],
            child: usersAsync.when(
              data: (users) {
                if (users.isEmpty) {
                  return const EmptyState(message: 'No users found');
                }
                return Column(
                  children: users.map((user) => _UserListTile(
                    user: user,
                    onTerminate: () => onTerminateUser(user),
                  )).toList(),
                );
              },
              loading: () => const Center(child: Padding(
                padding: EdgeInsets.all(48),
                child: CircularProgressIndicator(),
              )),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserListTile extends StatelessWidget {
  const _UserListTile({
    required this.user,
    required this.onTerminate,
  });

  final protocol.PharmaUser user;
  final VoidCallback onTerminate;

  @override
  Widget build(BuildContext context) {
    final isTerminated = user.status == 'terminated';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isTerminated ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTerminated ? Colors.grey.shade300 : AppColors.slate200,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isTerminated
                ? Colors.grey.shade300
                : DesignColors.primary.withOpacity(0.1),
            child: Text(
              '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}',
              style: TextStyle(
                color: isTerminated ? Colors.grey.shade600 : DesignColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isTerminated ? Colors.grey.shade600 : null,
                        decoration: isTerminated ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (isTerminated) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'TERMINATED',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 13,
                    color: isTerminated ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
                if (user.department?.name != null)
                  Text(
                    user.department!.name,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
              ],
            ),
          ),
          if (!isTerminated)
            TextButton(
              onPressed: onTerminate,
              style: TextButton.styleFrom(foregroundColor: AppColors.destructive),
              child: const Text('Terminate'),
            ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 3: TRAINING OPERATIONS (ADM-WF-01 & ADM-WF-02)
// ══════════════════════════════════════════════════════════════════════════════
class _TrainingOperationsTab extends StatelessWidget {
  const _TrainingOperationsTab({
    required this.ref,
    required this.searchController,
    required this.filterStatus,
    required this.onFilterChanged,
    required this.onAssignTraining,
  });

  final WidgetRef ref;
  final TextEditingController searchController;
  final String filterStatus;
  final void Function(String) onFilterChanged;
  final VoidCallback onAssignTraining;

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    final recentAssignAsync = ref.watch(recentAssignmentsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(coursesProvider);
        ref.invalidate(recentAssignmentsProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Assign Training CTA
          InkWell(
            onTap: onAssignTraining,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [DesignColors.primary, DesignColors.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: DesignColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.assignment_add, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assign Training',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ADM-WF-01 • Individual, Department, or Role-based',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Recent Assignments (ADM-WF-02: Cancel)
          _SectionCard(
            title: 'Recent Assignments',
            subtitle: 'ADM-WF-02 • Cancel assignments with mandatory reason',
            icon: Icons.assignment,
            iconColor: DesignColors.primary,
            child: recentAssignAsync.when(
              data: (assignments) {
                final active = assignments.where((a) => a.status == 'active').toList();
                if (active.isEmpty) {
                  return const EmptyState(message: 'No recent assignments');
                }
                return Column(
                  children: active.take(10).map((a) => _AssignmentRow(
                    assignment: a,
                    onCancel: () => _showCancelAssignmentDialog(context, ref, a),
                  )).toList(),
                );
              },
              loading: () => const Center(child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              )),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
          const SizedBox(height: 24),

          // Course Management
          _SectionCard(
            title: 'Course Management',
            icon: Icons.menu_book,
            iconColor: const Color(0xFF16A34A),
            actions: [
              TextButton.icon(
                onPressed: () => context.push('/trainer/course-builder'),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('New Course'),
              ),
            ],
            child: Column(
              children: [
                // Search and filter
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search courses...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.slate300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: filterStatus,
                        underline: const SizedBox.shrink(),
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('All Status')),
                          DropdownMenuItem(value: 'approved', child: Text('Approved')),
                          DropdownMenuItem(value: 'pending-qa', child: Text('Pending QA')),
                          DropdownMenuItem(value: 'draft', child: Text('Draft')),
                        ],
                        onChanged: (v) => v != null ? onFilterChanged(v) : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                coursesAsync.when(
                  data: (courses) {
                    var filtered = courses;
                    final term = searchController.text;
                    if (term.isNotEmpty) {
                      filtered = filtered.where((c) => c.title.toLowerCase().contains(term.toLowerCase())).toList();
                    }
                    if (filterStatus != 'all') {
                      filtered = filtered.where((c) => c.status == filterStatus).toList();
                    }
                    if (filtered.isEmpty) {
                      return const EmptyState(message: 'No courses match');
                    }
                    return Column(
                      children: filtered.take(10).map((course) => _CourseRow(
                        course: course,
                        onAssign: onAssignTraining,
                      )).toList(),
                    );
                  },
                  loading: () => const Center(child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(),
                  )),
                  error: (e, _) => Text('Error: $e'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseRow extends StatelessWidget {
  const _CourseRow({
    required this.course,
    required this.onAssign,
  });

  final protocol.Course course;
  final VoidCallback onAssign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getStatusColor(course.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.menu_book, color: _getStatusColor(course.status), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        course.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(course.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        course.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(course.status),
                        ),
                      ),
                    ),
                  ],
                ),
                if (course.description != null)
                  Text(
                    course.description!,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.push('/trainer/course-builder', extra: course),
                child: const Text('Edit'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: onAssign,
                child: const Text('Assign'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return const Color(0xFF16A34A);
      case 'pending-qa':
        return const Color(0xFFD97706);
      default:
        return AppColors.slate600;
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 4: SYSTEM & COMPLIANCE (ADM-WF-04)
// ══════════════════════════════════════════════════════════════════════════════
class _SystemComplianceTab extends StatelessWidget {
  const _SystemComplianceTab({
    required this.ref,
    required this.reportTemplate,
    required this.reportFromDate,
    required this.reportToDate,
    required this.onReportTemplateChanged,
    required this.onFromDateChanged,
    required this.onToDateChanged,
    required this.onExportReport,
    required this.onManageSignatureMeanings,
  });

  final WidgetRef ref;
  final String reportTemplate;
  final DateTime? reportFromDate;
  final DateTime? reportToDate;
  final void Function(String) onReportTemplateChanged;
  final void Function(DateTime?) onFromDateChanged;
  final void Function(DateTime?) onToDateChanged;
  final VoidCallback onExportReport;
  final VoidCallback onManageSignatureMeanings;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Generate Compliance Report (ADM-WF-04)
        _SectionCard(
          title: 'Generate Compliance Report',
          subtitle: 'ADM-WF-04 • SHA-256 hash, watermark, audit trail',
          icon: Icons.bar_chart,
          iconColor: const Color(0xFFD97706),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: reportTemplate,
                decoration: InputDecoration(
                  labelText: 'Report Template',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.description),
                ),
                items: const [
                  DropdownMenuItem(value: 'dept_summary', child: Text('Department Summary')),
                  DropdownMenuItem(value: 'individual_history', child: Text('Individual Training History')),
                  DropdownMenuItem(value: 'matrix', child: Text('Training Matrix Report')),
                ],
                onChanged: (v) => v != null ? onReportTemplateChanged(v) : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _DatePickerField(
                      label: 'From Date',
                      value: reportFromDate,
                      onChanged: onFromDateChanged,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DatePickerField(
                      label: 'To Date',
                      value: reportToDate,
                      onChanged: onToDateChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onExportReport,
                  icon: const Icon(Icons.download),
                  label: const Text('Generate & Export PDF'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFFD97706),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DesignColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: DesignColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: DesignColors.primary, size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Report will include SHA-256 hash, generation timestamp, and watermark per 21 CFR Part 11',
                        style: TextStyle(fontSize: 12, color: DesignColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Quick Actions Grid
        Text(
          'System Administration',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.0,
              children: [
                QuickActionButton(
                  label: 'E-Signature Meanings',
                  subtitle: '21 CFR Part 11 config',
                  icon: Icons.draw,
                  onPressed: onManageSignatureMeanings,
                  backgroundColor: const Color(0xFFE0E7FF),
                  borderColor: const Color(0xFFA5B4FC),
                  iconColor: const Color(0xFF4F46E5),
                ),
                QuickActionButton(
                  label: 'Inspection Management',
                  subtitle: 'Auditor tokens & packages',
                  icon: Icons.assignment,
                  onPressed: () => context.push('/inspection-management'),
                  backgroundColor: const Color(0xFFE0F2FE),
                  borderColor: const Color(0xFF7DD3FC),
                  iconColor: const Color(0xFF0284C7),
                ),
                QuickActionButton(
                  label: 'System Health',
                  subtitle: 'Jobs, DLQ, DB status',
                  icon: Icons.health_and_safety,
                  onPressed: () => context.push('/admin/health'),
                  backgroundColor: const Color(0xFFF0FDF4),
                  borderColor: const Color(0xFFBBF7D0),
                  iconColor: const Color(0xFF15803D),
                ),
                QuickActionButton(
                  label: 'Training Waivers',
                  subtitle: 'Request & approve waivers',
                  icon: Icons.verified_user,
                  onPressed: () => context.push('/admin/training-waivers'),
                  backgroundColor: const Color(0xFFDCFCE7),
                  borderColor: const Color(0xFF86EFAC),
                  iconColor: const Color(0xFF16A34A),
                ),
                QuickActionButton(
                  label: 'Training Matrix',
                  subtitle: 'Role-based curriculum',
                  icon: Icons.grid_view,
                  onPressed: () => context.push('/training-matrix'),
                  backgroundColor: const Color(0xFFFEF3C7),
                  borderColor: const Color(0xFFFCD34D),
                  iconColor: const Color(0xFFD97706),
                ),
                QuickActionButton(
                  label: 'Document Control',
                  subtitle: 'SOPs & QA classification',
                  icon: Icons.description,
                  onPressed: () => context.push('/documents'),
                  backgroundColor: const Color(0xFFE0E7FF),
                  borderColor: const Color(0xFFA5B4FC),
                  iconColor: const Color(0xFF4F46E5),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final void Function(DateTime?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        onChanged(picked);
      },
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          value != null ? DateFormat('yyyy-MM-dd').format(value!) : 'Select date',
          style: TextStyle(color: value != null ? null : Colors.grey.shade500),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height + 16;

  @override
  double get maxExtent => tabBar.preferredSize.height + 16;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: Colors.white,
        elevation: overlapsContent ? 4 : 0,
        child: tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
    this.subtitle,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                if (actions != null) ...actions!,
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.slate200),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _SelectionChip extends StatelessWidget {
  const _SelectionChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? DesignColors.primary.withOpacity(0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? DesignColors.primary : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: selected ? DesignColors.primary : Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? DesignColors.primary : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentRow extends StatelessWidget {
  const _AssignmentRow({
    required this.assignment,
    required this.onCancel,
  });

  final protocol.TrainingAssignment assignment;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final title = assignment.courseVersion?.course?.title ?? 'Course';
    final user = assignment.user;
    final userName = user != null ? '${user.firstName} ${user.lastName}' : 'User #${assignment.userId}';
    final dueDate = assignment.dueDate;
    final isOverdue = dueDate.isBefore(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isOverdue ? AppColors.destructive.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOverdue ? AppColors.destructive.withOpacity(0.3) : AppColors.slate200,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isOverdue
                ? AppColors.destructive.withOpacity(0.1)
                : DesignColors.primary.withOpacity(0.1),
            radius: 20,
            child: Icon(
              Icons.assignment,
              color: isOverdue ? AppColors.destructive : DesignColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(userName, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: isOverdue ? AppColors.destructive : Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${DateFormat('MMM d, yyyy').format(dueDate)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isOverdue ? AppColors.destructive : Colors.grey.shade500,
                        fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    if (isOverdue) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.destructive,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'OVERDUE',
                          style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(foregroundColor: AppColors.destructive),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

Future<void> _showCancelAssignmentDialog(
  BuildContext context,
  WidgetRef ref,
  protocol.TrainingAssignment assignment,
) async {
  final reasonController = TextEditingController();
  final cancelled = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.destructive.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.cancel, color: AppColors.destructive, size: 20),
          ),
          const SizedBox(width: 12),
          const Text('Cancel Assignment'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DesignColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: DesignColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: DesignColors.warning, size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'ADM-WF-02: Cancellation requires a reason and cascades to linked enrollments.',
                    style: TextStyle(fontSize: 12, color: DesignColors.warning),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Assignment: ${assignment.courseVersion?.course?.title ?? 'Course'}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            'Employee: ${assignment.user?.firstName ?? ''} ${assignment.user?.lastName ?? ''}',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: reasonController,
            decoration: InputDecoration(
              labelText: 'Cancellation Reason (Required)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              hintText: 'Enter reason for cancellation',
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Back'),
        ),
        FilledButton(
          onPressed: () {
            if (reasonController.text.trim().isEmpty) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Reason is required')),
              );
              return;
            }
            Navigator.pop(ctx, true);
          },
          style: FilledButton.styleFrom(backgroundColor: AppColors.destructive),
          child: const Text('Confirm Cancel'),
        ),
      ],
    ),
  );
  if (cancelled != true || !context.mounted || assignment.id == null) return;

  final user = await client.user.getUserByEmail('admin@pharmacorp.demo');
  final cancelledById = user?.id ?? 1;

  try {
    await client.training.cancelAssignment(
      assignmentId: assignment.id!,
      cancelledById: cancelledById,
      reason: reasonController.text.trim(),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Assignment cancelled'),
            ],
          ),
          backgroundColor: DesignColors.success,
        ),
      );
      ref.invalidate(recentAssignmentsProvider);
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
    }
  }
}

class _HeatmapLegendItem extends StatelessWidget {
  const _HeatmapLegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.slate600,
          ),
        ),
      ],
    );
  }
}

class _SignatureMeaningsDialog extends StatefulWidget {
  const _SignatureMeaningsDialog({
    required this.initialMeanings,
    required this.onCreate,
    required this.onUpdate,
  });

  final List<protocol.SignatureMeaning> initialMeanings;
  final Future<void> Function(String meaning, int orderIndex) onCreate;
  final Future<void> Function(
    int id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
  ) onUpdate;

  @override
  State<_SignatureMeaningsDialog> createState() => _SignatureMeaningsDialogState();
}

class _SignatureMeaningsDialogState extends State<_SignatureMeaningsDialog> {
  late List<protocol.SignatureMeaning> _meanings;
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
        final updated = await client.admin.listSignatureMeanings();
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

  Future<void> _toggleActive(protocol.SignatureMeaning m) async {
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
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.draw, color: Color(0xFF4F46E5), size: 20),
          ),
          const SizedBox(width: 12),
          const Text('E-Signature Meanings'),
        ],
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DesignColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Configure FDA-compliant signature meanings for 21 CFR Part 11.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              ..._meanings.map((m) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: m.isActive ? Colors.white : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.meaning, style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(
                            'Order: ${m.orderIndex} • ${m.isActive ? "Active" : "Inactive"}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: m.isActive,
                      onChanged: _saving ? null : (_) => _toggleActive(m),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _newMeaningController,
                      decoration: InputDecoration(
                        labelText: 'New meaning',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onSubmitted: (_) => _add(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
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
