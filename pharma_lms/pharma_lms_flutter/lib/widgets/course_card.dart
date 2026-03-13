import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'progress_ring.dart';
import 'status_badge.dart';

/// Reusable course card - thumbnail, title, progress ring, status badge, CTA.
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    this.subtitle,
    this.progress,
    this.status,
    this.onTap,
    this.versionCount,
    this.lastUpdated,
    this.isCreateCard = false,
    this.ctaLabel,
    this.resumeLabel,
  });

  final String title;
  final String? subtitle;
  /// Resume position for in-progress (e.g. "Module 2, Lesson 3").
  final String? resumeLabel;
  final double? progress;
  final String? status;
  final VoidCallback? onTap;
  final int? versionCount;
  final String? lastUpdated;
  final bool isCreateCard;
  final String? ctaLabel;

  @override
  Widget build(BuildContext context) {
    if (isCreateCard) {
      return _CreateCourseCard(onTap: onTap);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.slate200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxH = constraints.maxHeight.isFinite ? constraints.maxHeight : 300.0;
              final contentHeight = (maxH - 120).clamp(0.0, double.infinity);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.indigo50,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 48,
                        color: AppColors.indigo600.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: contentHeight,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.slate900,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (progress != null)
                            ProgressRing(
                              progress: progress!,
                              size: 40,
                              strokeWidth: 3,
                            ),
                        ],
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.slate600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (resumeLabel != null && resumeLabel!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Resume: $resumeLabel',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.teal600,
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (versionCount != null || lastUpdated != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (versionCount != null)
                              Text(
                                '$versionCount version(s)',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.slate500,
                                    ),
                              ),
                            if (versionCount != null && lastUpdated != null)
                              Text(
                                ' • ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.slate500,
                                    ),
                              ),
                            if (lastUpdated != null)
                              Text(
                                lastUpdated!,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.slate500,
                                    ),
                              ),
                          ],
                        ),
                      ],
                      if (status != null) ...[
                        const SizedBox(height: 8),
                        StatusBadge(status: status!),
                      ],
                      if (onTap != null) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: onTap,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: Text(
                              ctaLabel ??
                                  (progress != null && progress! > 0
                                      ? 'Continue'
                                      : 'Start'),
                            ),
                          ),
                        ),
                      ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CreateCourseCard extends StatelessWidget {
  const _CreateCourseCard({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.slate50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.slate300,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 48,
                color: AppColors.indigo600,
              ),
              const SizedBox(height: 12),
              Text(
                'Create Course',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Build new training content',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.slate500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
