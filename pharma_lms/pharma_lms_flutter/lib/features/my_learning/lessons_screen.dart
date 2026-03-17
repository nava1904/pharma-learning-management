// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — LESSONS SCREEN — Matches React ref2 Lessons.tsx
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/lessons
// Design: List of lesson items with progress bars, course info, action buttons
// Backend: enrollmentsProvider + enrollmentResumeLabelsProvider (Serverpod)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';

class LessonsScreen extends ConsumerWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final resumeLabelsAsync = ref.watch(enrollmentResumeLabelsProvider);

    return RefreshIndicator(
      color: PharmaColors.emerald600,
      onRefresh: () async {
        ref.invalidate(enrollmentsProvider);
        ref.invalidate(enrollmentResumeLabelsProvider);
        await Future.wait([
          ref.refresh(enrollmentsProvider.future),
          ref.refresh(enrollmentResumeLabelsProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('My Lessons', style: PharmaTypography.headingLarge),
            const SizedBox(height: 8),
            Text(
              'Track your lesson progress across all courses',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: PharmaSpacing.sectionGap),

            // Lessons list
            _buildLessonsList(context, enrollmentsAsync, resumeLabelsAsync, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonsList(
    BuildContext context,
    AsyncValue<List<Enrollment>> enrollmentsAsync,
    AsyncValue<Map<int, String>> resumeLabelsAsync,
    WidgetRef ref,
  ) {
    return enrollmentsAsync.when(
      loading: () => _buildSkeleton(),
      error: (e, _) => _buildError(ref),
      data: (enrollments) {
        final resumeLabels = resumeLabelsAsync.valueOrNull ?? {};

        // Build lesson items from enrollments
        final lessons = <_LessonItem>[];
        for (int i = 0; i < enrollments.length; i++) {
          final e = enrollments[i];
          final courseName = e.courseVersion?.course?.title ?? 'Course #${e.courseVersionId}';
          final resumeLabel = resumeLabels[e.id] ?? '';
          final isCompleted = e.status == 'completed';
          final progress = _estimateProgress(e);

          lessons.add(_LessonItem(
            index: i + 1,
            title: resumeLabel.isNotEmpty ? resumeLabel : courseName,
            courseName: courseName,
            duration: _estimateDuration(e),
            completed: isCompleted,
            progress: progress,
            enrollmentId: e.id,
            courseVersionId: e.courseVersionId,
            userId: e.userId,
          ));
        }

        if (lessons.isEmpty) {
          return _buildEmpty();
        }

        return Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(
            children: lessons.asMap().entries.map((entry) {
              final isLast = entry.key == lessons.length - 1;
              return _LessonRow(
                item: entry.value,
                showBorder: !isLast,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  double _estimateProgress(Enrollment e) {
    if (e.status == 'completed') return 100;
    if (e.status == 'in_progress') return 50; // Default estimate
    return 0;
  }

  String _estimateDuration(Enrollment e) {
    // Estimate based on course version if available
    return '45 min'; // Default estimate
  }

  Widget _buildSkeleton() {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        children: List.generate(5, (i) => Container(
          padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
          decoration: BoxDecoration(
            border: i < 4
                ? const Border(bottom: BorderSide(color: PharmaColors.borderLight))
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: PharmaColors.gray100,
                  borderRadius: BorderRadius.circular(PharmaRadius.lg),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, width: 200, color: PharmaColors.gray100),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 150, color: PharmaColors.gray100),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.menu_book_rounded, size: 48, color: PharmaColors.textQuaternary),
            const SizedBox(height: 16),
            Text('No Lessons Available', style: PharmaTypography.headingMedium),
            const SizedBox(height: 8),
            Text(
              'Enroll in a course to start your lessons.',
              style: PharmaTypography.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 40, color: PharmaColors.dangerText),
            const SizedBox(height: 12),
            Text('Failed to load lessons', style: PharmaTypography.headingSmall),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(enrollmentsProvider);
                ref.invalidate(enrollmentResumeLabelsProvider);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// LESSON ROW — Matches React: p-6 hover:bg-gray-50 border-b
// ═══════════════════════════════════════════════════════════════════════════════

class _LessonRow extends StatelessWidget {
  final _LessonItem item;
  final bool showBorder;

  const _LessonRow({
    required this.item,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(bottom: BorderSide(color: PharmaColors.borderLight))
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (item.enrollmentId != null) {
              context.push(
                '/employee/course/${item.courseVersionId}',
                extra: {
                  'courseVersionId': item.courseVersionId,
                  'enrollmentId': item.enrollmentId,
                  'userId': item.userId,
                  'courseTitle': item.courseName,
                },
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            child: Row(
              children: [
                // Lesson number
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PharmaColors.emerald100,
                    borderRadius: BorderRadius.circular(PharmaRadius.lg),
                  ),
                  child: Center(
                    child: Text(
                      '${item.index}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PharmaColors.emerald700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: PharmaSpacing.sectionGap),

                // Lesson info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: PharmaTypography.headingMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.completed)
                            Icon(
                              Icons.check_circle_rounded,
                              size: 20,
                              color: PharmaColors.emerald600,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Meta info
                      Row(
                        children: [
                          Icon(Icons.menu_book_rounded, size: 14, color: PharmaColors.textTertiary),
                          const SizedBox(width: 6),
                          Text(item.courseName, style: PharmaTypography.body),
                          const SizedBox(width: 16),
                          Icon(Icons.schedule_rounded, size: 14, color: PharmaColors.textTertiary),
                          const SizedBox(width: 6),
                          Text(item.duration, style: PharmaTypography.body),
                        ],
                      ),

                      // Progress bar (only for in-progress)
                      if (item.progress > 0 && item.progress < 100) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Progress', style: PharmaTypography.body),
                            Text(
                              '${item.progress.toInt()}%',
                              style: PharmaTypography.bodyMedium.copyWith(
                                color: PharmaColors.emerald600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(PharmaRadius.full),
                          child: LinearProgressIndicator(
                            value: item.progress / 100,
                            backgroundColor: PharmaColors.gray200,
                            valueColor: AlwaysStoppedAnimation(PharmaColors.emerald600),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Action button
                ElevatedButton(
                  onPressed: () {
                    if (item.enrollmentId != null) {
                      context.push(
                        '/employee/course/${item.courseVersionId}',
                        extra: {
                          'courseVersionId': item.courseVersionId,
                          'enrollmentId': item.enrollmentId,
                          'userId': item.userId,
                          'courseTitle': item.courseName,
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    item.completed ? 'Review' : 'Continue',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DATA MODEL
// ═══════════════════════════════════════════════════════════════════════════════

class _LessonItem {
  final int index;
  final String title;
  final String courseName;
  final String duration;
  final bool completed;
  final double progress;
  final int? enrollmentId;
  final int courseVersionId;
  final int userId;

  _LessonItem({
    required this.index,
    required this.title,
    required this.courseName,
    required this.duration,
    required this.completed,
    required this.progress,
    this.enrollmentId,
    required this.courseVersionId,
    required this.userId,
  });
}
