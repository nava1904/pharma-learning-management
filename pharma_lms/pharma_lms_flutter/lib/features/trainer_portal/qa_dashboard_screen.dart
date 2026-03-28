// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — QA REVIEW DASHBOARD (TRN-QA)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/qa-dashboard
// Lists the trainer's courses and QA workflow status (draft → review → approved).
// Opens trainer-only submission/validation at /trainer/courses/:id/qa-review (not QA sign-off).
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';

class TrainerQADashboardScreen extends ConsumerStatefulWidget {
  const TrainerQADashboardScreen({super.key});

  @override
  ConsumerState<TrainerQADashboardScreen> createState() =>
      _TrainerQADashboardScreenState();
}

class _TrainerQADashboardScreenState
    extends ConsumerState<TrainerQADashboardScreen> {
  bool _loading = true;
  String? _error;
  List<Course> _courses = [];
  final Map<int, List<CourseVersion>> _versionsByCourse = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      final courses = await client.course.listCourses(
        organizationId: user?.organizationId,
      );

      final versionMap = <int, List<CourseVersion>>{};
      for (final course in courses) {
        if (course.id == null) continue;
        try {
          final versions =
              await client.course.getCourseVersions(course.id!);
          versionMap[course.id!] = versions;
        } catch (_) {
          versionMap[course.id!] = [];
        }
      }

      if (mounted) {
        setState(() {
          _courses = courses;
          _versionsByCourse
            ..clear()
            ..addAll(versionMap);
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  String _latestStatus(int courseId) {
    final versions = _versionsByCourse[courseId] ?? [];
    if (versions.isEmpty) return 'draft';
    return versions.first.status;
  }

  int _pendingQaCount() {
    int count = 0;
    for (final entry in _versionsByCourse.entries) {
      for (final v in entry.value) {
        if (v.status == 'pending_qa' || v.status == 'under_review') {
          count++;
          break;
        }
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text(_error!, style: PharmaTypography.body),
            const SizedBox(height: 12),
            FilledButton(onPressed: _loadData, child: const Text('Retry')),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        _buildSummaryCards(),
        const SizedBox(height: 24),
        _buildCourseList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.rate_review, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course QA status',
                style: PharmaTypography.headingLarge
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text(
                'Track draft and in-review versions. Formal QA sign-off is done in the QA Portal.',
                style: PharmaTypography.body
                    .copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: _loadData,
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Refresh'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.emerald600,
            side: BorderSide(color: PharmaColors.emerald200),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    final total = _courses.length;
    final pending = _pendingQaCount();
    final approved = _courses
        .where((c) => c.id != null && _latestStatus(c.id!) == 'approved' ||
            _latestStatus(c.id!) == 'effective' ||
            _latestStatus(c.id!) == 'published')
        .length;
    final drafts = _courses
        .where((c) => c.id != null && _latestStatus(c.id!) == 'draft')
        .length;

    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Total Courses',
            value: '$total',
            icon: Icons.menu_book,
            color: PharmaColors.info,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Pending QA',
            value: '$pending',
            icon: Icons.pending_actions,
            color: PharmaColors.warning,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'QA Approved',
            value: '$approved',
            icon: Icons.check_circle,
            color: PharmaColors.emerald600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Drafts',
            value: '$drafts',
            icon: Icons.edit_note,
            color: PharmaColors.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseList() {
    if (_courses.isEmpty) {
      return PharmaCard(
        child: PharmaEmptyState(
          icon: Icons.menu_book_outlined,
          title: 'No Courses',
          subtitle: 'Create courses to track their QA status here.',
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Course QA Status',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
        const SizedBox(height: 12),
        ..._courses.map((course) {
          final courseId = course.id ?? 0;
          final versions = _versionsByCourse[courseId] ?? [];
          final latestVersion = versions.isNotEmpty ? versions.first : null;
          final status = latestVersion?.status ?? 'draft';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(color: PharmaColors.borderLight),
            ),
            child: InkWell(
              onTap: () =>
                  context.go('/trainer/courses/$courseId/qa-review'),
              borderRadius: BorderRadius.circular(PharmaRadius.md),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: PharmaTypography.bodyMedium
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              if (course.sopNumber != null) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: PharmaColors.gray100,
                                    borderRadius: PharmaRadius.pillRadius,
                                  ),
                                  child: Text(
                                    course.sopNumber!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: PharmaColors.gray600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (latestVersion != null)
                                Text(
                                  'v${latestVersion.version}',
                                  style: PharmaTypography.caption.copyWith(
                                    fontFamily: 'monospace',
                                    color: PharmaColors.textTertiary,
                                  ),
                                ),
                              const SizedBox(width: 8),
                              Text(
                                '${versions.length} version${versions.length == 1 ? '' : 's'}',
                                style: PharmaTypography.caption
                                    .copyWith(color: PharmaColors.textTertiary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PharmaWorkflowStepper(
                      currentStatus: status,
                      steps: const [
                        'draft',
                        'pending_qa',
                        'approved',
                      ],
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.chevron_right,
                        size: 20, color: PharmaColors.gray400),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PharmaRadius.lg),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: PharmaTypography.headingMedium
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Text(
                label,
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
