// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — ASSESSMENT LIST SCREEN (REACT REFERENCE MATCH)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Matches React ref2: Assessments.tsx
// Shows all assessments with module progress, stats summary, and action buttons
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../design_system/pharma_design_system.dart';
import '../../core/client.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════

/// Fetches all assessments for the current user's enrollments
final userAssessmentsProvider = FutureProvider<List<_AssessmentData>>((ref) async {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user?.id == null) return [];

  final enrollments = ref.watch(enrollmentsProvider).valueOrNull ?? [];
  final assessments = <_AssessmentData>[];

  for (final enrollment in enrollments) {
    try {
      final assessment = await client.assessment.getAssessmentForCourse(
        enrollment.courseVersionId,
      );
      if (assessment != null) {
        // Get attempt count for this assessment
        int attemptCount = 0;
        try {
          attemptCount = await client.assessment.getAttemptCount(
            assessmentId: assessment.id!,
            userId: user!.id!,
            enrollmentId: enrollment.id,
          );
        } catch (_) {}

        final course = enrollment.courseVersion?.course;
        final isCompleted = enrollment.status == 'completed';

        final maxAttempts = assessment.maxAttempts == 0 ? null : assessment.maxAttempts;
        assessments.add(_AssessmentData(
          assessment: assessment,
          enrollment: enrollment,
          courseTitle: course?.title ?? 'Unknown Course',
          courseDescription: course?.description ?? '',
          attemptCount: attemptCount,
          maxAttempts: maxAttempts,
          status: _deriveStatus(enrollment.status),
          progress: _deriveProgress(attemptCount, maxAttempts, isCompleted),
        ));
      }
    } catch (_) {
      // Skip assessments that can't be fetched
    }
  }

  return assessments;
});

String _deriveStatus(String? enrollmentStatus) {
  if (enrollmentStatus == 'completed') return 'completed';
  if (enrollmentStatus == 'in_progress') return 'in_progress';
  return 'not_started';
}

double _deriveProgress(int attemptCount, int? maxAttempts, bool isCompleted) {
  if (isCompleted) return 100.0;
  if (maxAttempts != null && maxAttempts > 0) {
    return (attemptCount / maxAttempts * 100).clamp(0.0, 100.0);
  }
  return 0.0;
}

class _AssessmentData {
  final Assessment assessment;
  final Enrollment enrollment;
  final String courseTitle;
  final String courseDescription;
  final int attemptCount;
  final int? maxAttempts;
  final String status;
  final double progress;

  const _AssessmentData({
    required this.assessment,
    required this.enrollment,
    required this.courseTitle,
    required this.courseDescription,
    required this.attemptCount,
    this.maxAttempts,
    required this.status,
    required this.progress,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AssessmentListScreen extends ConsumerWidget {
  const AssessmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assessmentsAsync = ref.watch(userAssessmentsProvider);

    return assessmentsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: PharmaColors.emerald500),
      ),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: PharmaColors.danger),
            const SizedBox(height: 16),
            Text('Unable to load assessments', style: PharmaTypography.headingSmall),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => ref.invalidate(userAssessmentsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: TextButton.styleFrom(foregroundColor: PharmaColors.emerald600),
            ),
          ],
        ),
      ),
      data: (assessments) => _AssessmentListContent(assessments: assessments),
    );
  }
}

class _AssessmentListContent extends StatelessWidget {
  const _AssessmentListContent({required this.assessments});

  final List<_AssessmentData> assessments;

  @override
  Widget build(BuildContext context) {
    final completedCount = assessments.where((a) => a.status == 'completed').length;
    final totalAttempts = assessments.fold<int>(0, (sum, a) => sum + a.attemptCount);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─────────────────────────────────────────────────────────────────
          // HEADER
          // From React: title + "View History" button
          // ─────────────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Assessments', style: PharmaTypography.headingLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Test your knowledge and earn certifications',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                  ),
                ],
              ),
              _OutlineButton(
                icon: Icons.access_time_rounded,
                label: 'View History',
                onTap: () => context.go('/employee/training-history'),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ─────────────────────────────────────────────────────────────────
          // ASSESSMENT CARDS
          // From React: space-y-6 assessment cards with modules
          // ─────────────────────────────────────────────────────────────────
          if (assessments.isEmpty)
            _EmptyState()
          else
            ...assessments.map((data) => Padding(
              padding: const EdgeInsets.only(bottom: PharmaSpacing.gridGap),
              child: _AssessmentCard(data: data),
            )),

          const SizedBox(height: PharmaSpacing.sectionGap),

          // ─────────────────────────────────────────────────────────────────
          // STATS CARDS
          // From React: grid-cols-3 stats (Total, Completed, Average Score)
          // ─────────────────────────────────────────────────────────────────
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 1 : 3;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: PharmaSpacing.gridGap,
                crossAxisSpacing: PharmaSpacing.gridGap,
                childAspectRatio: 2.5,
                children: [
                  _StatCard(
                    title: 'Total Assessments',
                    value: '${assessments.length}',
                    subtitle: 'Across all courses',
                    icon: Icons.description_outlined,
                    iconColor: PharmaColors.textTertiary,
                  ),
                  _StatCard(
                    title: 'Completed',
                    value: '$completedCount',
                    subtitle: assessments.isEmpty
                        ? 'No assessments yet'
                        : '$totalAttempts total attempts',
                    icon: Icons.workspace_premium_outlined,
                    iconColor: PharmaColors.emerald600,
                  ),
                  _StatCard(
                    title: 'Average Score',
                    value: completedCount > 0 ? "Pass" : "—",
                    subtitle: completedCount > 0 ? 'Excellent performance' : 'Complete assessments to see score',
                    icon: Icons.workspace_premium_outlined,
                    iconColor: PharmaColors.textTertiary,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ASSESSMENT CARD
// From React: Card with image, title, progress, modules, action button
// ═══════════════════════════════════════════════════════════════════════════════

class _AssessmentCard extends StatefulWidget {
  const _AssessmentCard({required this.data});

  final _AssessmentData data;

  @override
  State<_AssessmentCard> createState() => _AssessmentCardState();
}

class _AssessmentCardState extends State<_AssessmentCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final statusBadge = _getStatusBadge(data.status);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: PharmaDurations.fast,
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
          boxShadow: _isHovered ? PharmaShadows.cardHoverShadow : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header Row: Image + Info + Progress + Badge ───
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course image placeholder
                  Container(
                    width: 192,
                    height: 128,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [PharmaColors.emerald100, PharmaColors.emerald200],
                      ),
                      borderRadius: PharmaRadius.buttonRadius,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.assignment_rounded,
                        size: 48,
                        color: PharmaColors.emerald600,
                      ),
                    ),
                  ),
                  const SizedBox(width: PharmaSpacing.cardPadding),

                  // Info section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title row with status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.courseTitle,
                                    style: PharmaTypography.headingMedium.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Assessment for ${data.courseTitle}',
                                    style: PharmaTypography.caption.copyWith(
                                      color: PharmaColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                // Attempts display
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Attempts',
                                      style: PharmaTypography.caption.copyWith(
                                        color: PharmaColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      data.maxAttempts != null
                                          ? '${data.attemptCount} / ${data.maxAttempts}'
                                          : '${data.attemptCount} / ∞',
                                      style: PharmaTypography.headingSmall.copyWith(
                                        color: PharmaColors.emerald600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                statusBadge,
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Progress bar
                        ClipRRect(
                          borderRadius: PharmaRadius.pillRadius,
                          child: LinearProgressIndicator(
                            value: data.progress / 100,
                            backgroundColor: PharmaColors.gray200,
                            valueColor: AlwaysStoppedAnimation<Color>(PharmaColors.emerald600),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ─── Action Button ───
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: _buildActionButton(context, data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, _AssessmentData data) {
    final isCompleted = data.status == 'completed';
    final isLocked = !isCompleted && data.progress < 100.0;

    if (isCompleted) {
      return TextButton(
        onPressed: () {
          context.go(
            '/assessment-v2/${data.enrollment.courseVersionId}',
            extra: {
              'enrollmentId': data.enrollment.id,
              'reviewMode': true,
            },
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: PharmaColors.emerald600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: PharmaSpacing.cardPadding,
            vertical: PharmaSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
        ),
        child: const Text(
          'Review Assessment',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    if (isLocked) {
      return Tooltip(
        message: 'Complete all lessons first',
        child: TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Assessment Locked'),
                content: const Text(
                  'Complete the course content first to unlock the assessment.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.lock_outline, size: 16),
          label: const Text(
            'Start Assessment',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          style: TextButton.styleFrom(
            backgroundColor: PharmaColors.gray200,
            foregroundColor: PharmaColors.textTertiary,
            padding: const EdgeInsets.symmetric(
              horizontal: PharmaSpacing.cardPadding,
              vertical: PharmaSpacing.md,
            ),
            shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
          ),
        ),
      );
    }

    return TextButton(
      onPressed: () {
        context.go(
          '/assessment-v2/${data.enrollment.courseVersionId}',
          extra: {'enrollmentId': data.enrollment.id},
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: PharmaColors.emerald600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: PharmaSpacing.cardPadding,
          vertical: PharmaSpacing.md,
        ),
        shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
      ),
      child: const Text(
        'Start Assessment',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _getStatusBadge(String status) {
    final (bgColor, textColor, label) = switch (status) {
      'completed' => (PharmaColors.successBg, PharmaColors.successText, 'Completed'),
      'in_progress' => (PharmaColors.infoBg, PharmaColors.infoText, 'In Progress'),
      _ => (PharmaColors.gray100, PharmaColors.gray700, 'Not Started'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT CARD
// From React: white card with icon, title, value, subtitle
// ═══════════════════════════════════════════════════════════════════════════════

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: PharmaTypography.headingLarge.copyWith(fontSize: 28)),
          const SizedBox(height: 4),
          Text(subtitle, style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// OUTLINE BUTTON
// ═══════════════════════════════════════════════════════════════════════════════

class _OutlineButton extends StatefulWidget {
  const _OutlineButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? PharmaColors.gray50 : Colors.transparent,
            borderRadius: PharmaRadius.buttonRadius,
            border: Border.all(color: PharmaColors.borderMedium),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: PharmaColors.textSecondary),
              const SizedBox(width: 8),
              Text(widget.label, style: PharmaTypography.button),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EMPTY STATE
// ═══════════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding * 2),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assignment_outlined, size: 64, color: PharmaColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              'No assessments available',
              style: PharmaTypography.headingSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Enroll in courses to unlock assessments',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
