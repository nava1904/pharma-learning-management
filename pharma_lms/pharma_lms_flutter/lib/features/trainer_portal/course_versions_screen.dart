// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE VERSIONS (TRN-05)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/versions
// Published versions are LOCKED — must create new version to update.
// Version history is permanent — no version can be hard-deleted.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';

class CourseVersionsScreen extends StatefulWidget {
  const CourseVersionsScreen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseVersionsScreen> createState() => _CourseVersionsScreenState();
}

class _CourseVersionsScreenState extends State<CourseVersionsScreen> {
  Course? _course;
  List<CourseVersion> _versions = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final course = await client.course.getCourse(widget.courseId);
      final versions = await client.course.getCourseVersions(widget.courseId);
      if (mounted) {
        setState(() {
          _course = course;
          _versions = versions..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        // Header
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/trainer/courses'),
              icon: const Icon(Icons.arrow_back, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course Versions', style: PharmaTypography.headingLarge.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w800,
                  )),
                  if (_course != null)
                    Text(_course!.title, style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: _showCreateVersionDialog,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create New Version'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ],
        ),

        const SizedBox(height: PharmaSpacing.sectionGap),

        // Content
        if (_loading)
          const Center(child: Padding(padding: EdgeInsets.all(48), child: CircularProgressIndicator()))
        else if (_error != null)
          Center(child: Text(_error!, style: TextStyle(color: PharmaColors.danger)))
        else
          Container(
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(color: PharmaColors.borderLight),
              boxShadow: PharmaShadows.sm,
            ),
            child: _versions.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        Icon(Icons.history, size: 48, color: PharmaColors.gray300),
                        const SizedBox(height: 12),
                        Text('No versions yet', style: PharmaTypography.headingSmall),
                      ],
                    ),
                  )
                : DataTable(
                    headingRowHeight: 44,
                    dataRowMinHeight: 56,
                    dataRowMaxHeight: 64,
                    columnSpacing: 24,
                    headingTextStyle: PharmaTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w600, color: PharmaColors.textTertiary,
                      fontSize: 11, letterSpacing: 0.5,
                    ),
                    columns: const [
                      DataColumn(label: Text('VERSION')),
                      DataColumn(label: Text('STATUS')),
                      DataColumn(label: Text('CHANGE SUMMARY')),
                      DataColumn(label: Text('ACTIONS')),
                    ],
                    rows: _versions.map((v) => DataRow(cells: [
                      DataCell(Text('v${v.version}', style: PharmaTypography.bodyMedium.copyWith(fontFamily: 'monospace'))),
                      DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _VersionStatusChip(status: v.status),
                          const SizedBox(height: 4),
                          PharmaWorkflowStepper(
                            currentStatus: v.status,
                            steps: const ['draft', 'pending_approval', 'effective'],
                          ),
                        ],
                      )),
                      DataCell(
                        Text(v.changeSummary ?? 'Original version', style: PharmaTypography.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      DataCell(Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (v.status == 'draft')
                            IconButton(
                              onPressed: () => context.go('/trainer/courses/${widget.courseId}/builder'),
                              icon: const Icon(Icons.edit_outlined, size: 18),
                              tooltip: 'Edit',
                              color: PharmaColors.textTertiary,
                            ),
                          IconButton(
                            onPressed: () => context.go('/trainer/courses/${widget.courseId}/builder'),
                            icon: const Icon(Icons.visibility_outlined, size: 18),
                            tooltip: 'View',
                            color: PharmaColors.textTertiary,
                          ),
                          if (v.status == 'approved' || v.status == 'effective')
                            IconButton(
                              onPressed: () => _showQAReviewHistory(v),
                              icon: const Icon(Icons.verified_outlined, size: 18),
                              tooltip: 'View QA Approval',
                              color: PharmaColors.emerald600,
                            ),
                        ],
                      )),
                    ])).toList(),
                  ),
          ),
      ],
    );
  }

  Future<void> _showQAReviewHistory(CourseVersion version) async {
    try {
      final reviews = await client.qa.getCourseReviews(courseVersionId: version.id!);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
          title: Row(
            children: [
              Icon(Icons.verified_outlined, color: PharmaColors.emerald600, size: 20),
              const SizedBox(width: 8),
              Text('QA Review History — v${version.version}'),
            ],
          ),
          content: SizedBox(
            width: 420,
            child: reviews.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.assignment_outlined, size: 40, color: PharmaColors.gray300),
                        const SizedBox(height: 8),
                        Text('No reviews yet', style: PharmaTypography.body),
                      ],
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: reviews.map((r) => ListTile(
                      leading: Icon(
                        r.decision == 'approved'
                            ? Icons.check_circle
                            : r.decision == 'rejected'
                                ? Icons.cancel
                                : Icons.replay,
                        color: r.decision == 'approved'
                            ? PharmaColors.emerald600
                            : r.decision == 'rejected'
                                ? PharmaColors.danger
                                : PharmaColors.warning,
                      ),
                      title: Text(r.decision ?? 'Pending'),
                      subtitle: Text(r.comments ?? ''),
                      trailing: Text(
                        r.reviewedAt?.toString().substring(0, 10) ?? '',
                        style: PharmaTypography.caption,
                      ),
                    )).toList(),
                  ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading reviews: $e')),
        );
      }
    }
  }

  void _showCreateVersionDialog() {
    final changeNotesController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Create New Version'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_versions.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PharmaColors.emerald50,
                    borderRadius: PharmaRadius.cardRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: PharmaColors.emerald600),
                      const SizedBox(width: 8),
                      Text('Base: v${_versions.first.version}', style: PharmaTypography.bodyMedium),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Text('Change Notes (required)', style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
              const SizedBox(height: 8),
              TextField(
                controller: changeNotesController,
                maxLines: 4,
                maxLength: 1000,
                decoration: InputDecoration(
                  hintText: 'Describe what changed and why...',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await client.courseBuilder.createCourseVersion(
                  courseId: widget.courseId,
                  version: _nextVersion(),
                  status: 'draft',
                  changeSummary: changeNotesController.text,
                );
                _load();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
            child: const Text('Create Draft'),
          ),
        ],
      ),
    );
  }

  String _nextVersion() {
    if (_versions.isEmpty) return '1.0';
    final latest = _versions.first.version;
    final parts = latest.split('.');
    final major = int.tryParse(parts[0]) ?? 1;
    return '${major + 1}.0';
  }
}

class _VersionStatusChip extends StatelessWidget {
  const _VersionStatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    String label;
    switch (status) {
      case 'draft':
        bg = PharmaColors.gray100; fg = PharmaColors.gray700; label = 'DRAFT'; break;
      case 'pending_qa': case 'under_review':
        bg = PharmaColors.warningBg; fg = PharmaColors.warningText; label = 'UNDER REVIEW'; break;
      case 'approved': case 'published': case 'effective':
        bg = PharmaColors.successBg; fg = PharmaColors.successText; label = 'PUBLISHED'; break;
      case 'superseded':
        bg = PharmaColors.gray100; fg = PharmaColors.gray500; label = 'SUPERSEDED'; break;
      default:
        bg = PharmaColors.gray100; fg = PharmaColors.gray600; label = status.toUpperCase(); break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg, letterSpacing: 0.5)),
    );
  }
}
