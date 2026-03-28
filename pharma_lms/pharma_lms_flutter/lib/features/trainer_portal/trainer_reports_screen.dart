// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINER REPORTS HUB
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/reports
// Single place to access and export trainer reports: learner progress,
// compliance, analytics, audit log.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

class TrainerReportsScreen extends ConsumerStatefulWidget {
  const TrainerReportsScreen({super.key});

  @override
  ConsumerState<TrainerReportsScreen> createState() =>
      _TrainerReportsScreenState();
}

class _TrainerReportsScreenState extends ConsumerState<TrainerReportsScreen> {
  bool _exportingLearnerProgress = false;
  bool _exportingAudit = false;
  bool _exportingMatrix = false;
  bool _exportingAssessment = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: PharmaColors.emerald600, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reports',
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Access and export compliance, progress, and audit reports',
                    style: PharmaTypography.body
                        .copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _ReportCard(
          icon: Icons.people_outlined,
          title: 'Learner Progress',
          subtitle: 'Per-learner training history, compliance status, certifications',
          onOpen: () => context.go('/trainer/reports/learner-progress'),
          onExport: _exportLearnerProgressCsv,
          exportLabel: 'Save CSV file',
          exporting: _exportingLearnerProgress,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.grid_on_outlined,
          title: 'Completion matrix',
          subtitle: 'Employees × courses grid — who completed which training',
          onOpen: () => context.go('/trainer/reports/completion-matrix'),
          onExport: _exportCompletionMatrixCsv,
          exportLabel: 'Save CSV file',
          exporting: _exportingMatrix,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.assessment_outlined,
          title: 'Assessment performance',
          subtitle: 'Per-learner scores for a course version (TrainingRecord export)',
          onOpen: () => context.go('/trainer/analytics'),
          onExport: _exportAssessmentPerformanceCsv,
          exportLabel: 'Save CSV file',
          exporting: _exportingAssessment,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.shield_outlined,
          title: 'Compliance',
          subtitle: 'Department and role compliance rates, overdue training',
          onOpen: () => context.go('/trainer/compliance'),
          exportLabel: null,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.analytics_outlined,
          title: 'Analytics',
          subtitle: 'Course analytics, completion rates, score distribution',
          onOpen: () => context.go('/trainer/analytics'),
          exportLabel: null,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.history_outlined,
          title: 'Audit Log',
          subtitle: 'Immutable audit trail — 21 CFR Part 11 compliant',
          onOpen: () => context.go('/trainer/audit-log'),
          onExport: _exportAuditCsv,
          exportLabel: 'Save CSV file',
          exporting: _exportingAudit,
        ),
      ],
    );
  }

  Future<void> _exportLearnerProgressCsv() async {
    setState(() => _exportingLearnerProgress = true);
    try {
      final user = await ref.read(currentUserProvider.future);
      final csv = await client.analytics.exportLearnerProgressCsv(
        organizationId: user?.organizationId,
      );
      if (!mounted) return;
      final bytes = Uint8List.fromList(utf8.encode(csv));
      await saveBytesToFile(bytes, 'learner_progress.csv');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved learner_progress.csv')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingLearnerProgress = false);
    }
  }

  Future<void> _exportCompletionMatrixCsv() async {
    setState(() => _exportingMatrix = true);
    try {
      final user = await ref.read(currentUserProvider.future);
      final csv = await client.analytics.exportCompletionMatrixCsv(
        organizationId: user?.organizationId,
      );
      if (!mounted) return;
      final bytes = Uint8List.fromList(utf8.encode(csv));
      await saveBytesToFile(bytes, 'completion_matrix.csv');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved completion_matrix.csv')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingMatrix = false);
    }
  }

  Future<void> _exportAssessmentPerformanceCsv() async {
    final user = await ref.read(currentUserProvider.future);
    if (user == null) return;
    final courses =
        await client.course.listCourses(organizationId: user.organizationId);
    if (!mounted) return;
    final picked = await showDialog<_AssessmentCsvSelection>(
      context: context,
      builder: (ctx) => _AssessmentCsvPickerDialog(courses: courses),
    );
    if (picked?.version.id == null) return;
    setState(() => _exportingAssessment = true);
    try {
      final csv = await client.analytics.exportCourseAnalyticsCsv(
        courseVersionId: picked!.version.id!,
      );
      if (!mounted) return;
      final bytes = Uint8List.fromList(utf8.encode(csv));
      final slug =
          '${picked.course.title}_v${picked.version.version}'
              .replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
      await saveBytesToFile(bytes, '${slug}_assessment_performance.csv');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assessment performance CSV saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingAssessment = false);
    }
  }

  Future<void> _exportAuditCsv() async {
    setState(() => _exportingAudit = true);
    try {
      final csv = await client.audit.exportAuditCsv(
        from: DateTime.now().subtract(const Duration(days: 30)),
        to: DateTime.now(),
        limit: 1000,
      );
      if (!mounted) return;
      final bytes = Uint8List.fromList(utf8.encode(csv));
      await saveBytesToFile(bytes, 'audit_log_30d.csv');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved audit_log_30d.csv')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingAudit = false);
    }
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onOpen,
    this.onExport,
    this.exportLabel,
    this.exporting = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onOpen;
  final VoidCallback? onExport;
  final String? exportLabel;
  final bool exporting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: PharmaColors.emerald50,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(icon, size: 24, color: PharmaColors.emerald600),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: PharmaTypography.caption
                      .copyWith(color: PharmaColors.textTertiary),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: onOpen,
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
              foregroundColor: PharmaColors.cardBg,
            ),
            child: const Text('Open'),
          ),
          if (exportLabel != null && onExport != null) ...[
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: exporting ? null : onExport,
              child: exporting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(exportLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

class _AssessmentCsvSelection {
  const _AssessmentCsvSelection({
    required this.course,
    required this.version,
  });

  final Course course;
  final CourseVersion version;
}

class _AssessmentCsvPickerDialog extends StatefulWidget {
  const _AssessmentCsvPickerDialog({required this.courses});

  final List<Course> courses;

  @override
  State<_AssessmentCsvPickerDialog> createState() =>
      _AssessmentCsvPickerDialogState();
}

class _AssessmentCsvPickerDialogState extends State<_AssessmentCsvPickerDialog> {
  Course? _course;
  List<CourseVersion> _versions = [];
  CourseVersion? _version;
  bool _loadingVers = false;

  Future<void> _onCourse(Course? c) async {
    setState(() {
      _course = c;
      _version = null;
      _versions = [];
      _loadingVers = c?.id != null;
    });
    if (c?.id == null) return;
    final v = await client.course.getCourseVersions(c!.id!);
    if (!mounted) return;
    setState(() {
      _versions = v;
      _version = v.isNotEmpty ? v.first : null;
      _loadingVers = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export assessment CSV'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Course>(
              initialValue: _course,
              items: widget.courses
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c.title, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: _onCourse,
              decoration: const InputDecoration(labelText: 'Course'),
              isExpanded: true,
            ),
            const SizedBox(height: 12),
            if (_loadingVers)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else if (_versions.isNotEmpty)
              DropdownButtonFormField<CourseVersion>(
                initialValue: _version,
                items: _versions
                    .map(
                      (v) => DropdownMenuItem(
                        value: v,
                        child: Text('v${v.version} (${v.status})'),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _version = v),
                decoration: const InputDecoration(labelText: 'Version'),
                isExpanded: true,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _version?.id == null || _course == null
              ? null
              : () => Navigator.pop(
                    context,
                    _AssessmentCsvSelection(
                      course: _course!,
                      version: _version!,
                    ),
                  ),
          child: const Text('Export'),
        ),
      ],
    );
  }
}
