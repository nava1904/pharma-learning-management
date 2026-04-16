// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COMPONENT LIBRARY
// ═══════════════════════════════════════════════════════════════════════════════
//
// Reusable, atomic, documented widgets for the Employee Portal.
// All components use the design token system — no hardcoded values.
//
// Components:
// - StatusPill: Color-coded status indicator
// - ComplianceAlertBanner: Red urgency banner for overdue items
// - ProgressRing: Animated SVG-style progress ring
// - CourseCard: Training course card with status-specific styling
// - CredentialCard: Certificate/credential display card
// - StatCard: Dashboard stat card
// - EmptyState: Empty state with guidance
// - AppErrorWidget: Error state with retry
// - SkeletonLoader: Loading shimmer placeholder
// - ReadingTimerWidget: Countdown timer for minimum read time
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'tokens.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// STATUS PILL
// ═══════════════════════════════════════════════════════════════════════════════

/// Color-coded pill showing training status.
/// Uses [TrainingStatusDisplay] extension for colors and labels.
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.status,
    this.showDot = true,
  });

  final TrainingStatus status;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
      decoration: BoxDecoration(
        color: status.bgColor,
        borderRadius: AppRadius.br5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: status.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.s2),
          ],
          Text(
            status.label,
            style: AppTypography.caption.copyWith(
              color: status.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COMPLIANCE ALERT BANNER
// ═══════════════════════════════════════════════════════════════════════════════

/// Red urgency banner shown when user has overdue training.
/// Design: Red left border 4px, dangerLight bg (#FEF2F2), pulsing icon.
/// First element on dashboard, cannot be dismissed.
class ComplianceAlertBanner extends StatelessWidget {
  const ComplianceAlertBanner({
    super.key,
    required this.overdueCount,
    required this.onViewOverdue,
  });

  final int overdueCount;
  final VoidCallback onViewOverdue;

  @override
  Widget build(BuildContext context) {
    if (overdueCount <= 0) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s6, // 24px
        vertical: AppSpacing.s4,   // 16px
      ),
      decoration: BoxDecoration(
        color: AppColors.dangerLight, // #FEF2F2 — light red background
        borderRadius: AppRadius.br2,   // 10px radius
        border: const Border(
          left: BorderSide(color: AppColors.danger, width: 4), // Red left border 4px
        ),
      ),
      child: Row(
        children: [
          // Animated pulse icon
          _PulsingIcon(
            icon: Icons.warning_amber_rounded,
            color: AppColors.danger,
          ),
          const SizedBox(width: AppSpacing.s4), // 16px
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$overdueCount course${overdueCount == 1 ? '' : 's'} overdue',
                  style: AppTypography.label.copyWith(
                    color: AppColors.danger,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Regulatory action required — complete immediately',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.n700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s4),
          // CTA Button — min 48px (Fitts's Law)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: FilledButton(
              onPressed: onViewOverdue,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: AppColors.n0,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s5, // 20px
                  vertical: AppSpacing.s3,   // 12px
                ),
                minimumSize: const Size(0, 44), // Apple HIG min tap target
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Review Overdue'),
                  SizedBox(width: AppSpacing.s2),
                  Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingIcon extends StatefulWidget {
  const _PulsingIcon({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Icon(widget.icon, color: widget.color, size: 24),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PROGRESS RING
// ═══════════════════════════════════════════════════════════════════════════════

/// Animated circular progress indicator with value display.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.percent,
    this.size = 80,
    this.strokeWidth = 6,
    this.color,
    this.backgroundColor,
    this.label,
    this.sublabel,
    this.animate = true,
  });

  /// Progress value from 0.0 to 1.0
  final double percent;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final String? label;
  final String? sublabel;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ??
        (percent >= 1.0 ? AppColors.success : AppColors.blue);
    final effectiveBgColor = backgroundColor ?? AppColors.n200;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: 1.0,
              color: effectiveBgColor,
              strokeWidth: strokeWidth,
            ),
          ),
          // Progress ring
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: percent.clamp(0.0, 1.0)),
            duration: animate ? AppDurations.slow : Duration.zero,
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  progress: value,
                  color: effectiveColor,
                  strokeWidth: strokeWidth,
                ),
              );
            },
          ),
          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label ?? '${(percent * 100).round()}%',
                style: AppTypography.headline.copyWith(
                  fontSize: size * 0.22,
                  color: AppColors.n900,
                ),
              ),
              if (sublabel != null)
                Text(
                  sublabel!,
                  style: AppTypography.caption.copyWith(
                    fontSize: size * 0.12,
                    color: AppColors.n500,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT CARD
// ═══════════════════════════════════════════════════════════════════════════════

/// Dashboard statistic card with label, value, and optional trend.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.sublabel,
    this.icon,
    this.color,
    this.backgroundColor,
    this.trend,
    this.onTap,
  });

  final String label;
  final String value;
  final String? sublabel;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final String? trend;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.blue;
    final effectiveBgColor = backgroundColor ?? AppColors.n0;

    return Material(
      color: effectiveBgColor,
      borderRadius: AppRadius.br2,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br2,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s5),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br2,
            boxShadow: AppShadows.sh1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: effectiveColor.withValues(alpha: 0.1),
                        borderRadius: AppRadius.br1,
                      ),
                      child: Icon(icon, color: effectiveColor, size: 18),
                    ),
                    const SizedBox(width: AppSpacing.s3),
                  ],
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.n500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s3),
              Text(
                value,
                style: AppTypography.title.copyWith(
                  color: effectiveColor,
                ),
              ),
              if (sublabel != null || trend != null) ...[
                const SizedBox(height: AppSpacing.s1),
                Row(
                  children: [
                    if (sublabel != null)
                      Text(
                        sublabel!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.n500,
                        ),
                      ),
                    if (trend != null) ...[
                      const Spacer(),
                      Text(
                        trend!,
                        style: AppTypography.caption.copyWith(
                          color: trend!.startsWith('+')
                              ? AppColors.success
                              : (trend!.startsWith('-')
                                  ? AppColors.danger
                                  : AppColors.n500),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE CARD
// ═══════════════════════════════════════════════════════════════════════════════

/// Training course card with status-specific styling.
/// Visually differentiates by status using border, color, and button style.
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.status,
    required this.dueDate,
    required this.onTap,
    this.thumbnailUrl,
    this.courseType,
    this.progress = 0.0,
    this.moduleCount,
    this.estimatedMinutes,
    this.resumeLabel,
  });

  final String title;
  final TrainingStatus status;
  final DateTime dueDate;
  final VoidCallback onTap;
  final String? thumbnailUrl;
  final CourseType? courseType;
  final double progress;
  final int? moduleCount;
  final int? estimatedMinutes;
  final String? resumeLabel;

  @override
  Widget build(BuildContext context) {
    final isOverdue = status == TrainingStatus.overdue || dueDate.isOverdue;

    return Material(
      color: AppColors.n0,
      borderRadius: AppRadius.br2,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.br2,
            border: Border(
              left: BorderSide(
                color: isOverdue ? AppColors.danger : status.color,
                width: 4,
              ),
            ),
            boxShadow: AppShadows.sh1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail area
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isOverdue
                      ? AppColors.dangerLight
                      : status.bgColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    if (thumbnailUrl != null)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          thumbnailUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (_, _, _) => const SizedBox(),
                        ),
                      ),
                    // Content type tag
                    if (courseType != null)
                      Positioned(
                        top: AppSpacing.s3,
                        right: AppSpacing.s3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s2,
                            vertical: AppSpacing.s1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.n0.withValues(alpha: 0.9),
                            borderRadius: AppRadius.br1,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                courseType!.icon,
                                size: 12,
                                color: AppColors.n600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                courseType!.label,
                                style: AppTypography.caption.copyWith(
                                  fontSize: 10,
                                  color: AppColors.n600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Overdue badge
                    if (isOverdue)
                      Positioned(
                        top: AppSpacing.s3,
                        left: AppSpacing.s3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s2,
                            vertical: AppSpacing.s1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.danger,
                            borderRadius: AppRadius.br1,
                          ),
                          child: Text(
                            'OVERDUE',
                            style: AppTypography.caption.copyWith(
                              fontSize: 10,
                              color: AppColors.n0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status pill
                    StatusPill(status: status),
                    const SizedBox(height: AppSpacing.s3),
                    // Title
                    Text(
                      title,
                      style: AppTypography.label.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.n900,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.s2),
                    // Due date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: isOverdue ? AppColors.danger : AppColors.n500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            isOverdue
                                ? dueDate.fullDueDateLabel
                                : 'Due ${dueDate.humanDate}',
                            style: AppTypography.bodySmall.copyWith(
                              color:
                                  isOverdue ? AppColors.danger : AppColors.n500,
                              fontWeight:
                                  isOverdue ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Progress bar (if in progress)
                    if (status == TrainingStatus.inProgress) ...[
                      const SizedBox(height: AppSpacing.s3),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: AppRadius.br5,
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 4,
                                backgroundColor: AppColors.n200,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s2),
                          Text(
                            '${(progress * 100).round()}%',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                    // Resume label
                    if (resumeLabel != null &&
                        status == TrainingStatus.inProgress) ...[
                      const SizedBox(height: AppSpacing.s2),
                      Row(
                        children: [
                          Icon(
                            Icons.bookmark_outline_rounded,
                            size: 12,
                            color: AppColors.teal,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              resumeLabel!,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.teal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSpacing.s4),
                    // CTA Button
                    _CourseCardButton(
                      status: status,
                      isOverdue: isOverdue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseCardButton extends StatelessWidget {
  const _CourseCardButton({
    required this.status,
    required this.isOverdue,
  });

  final TrainingStatus status;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    // OVERDUE: Red button
    if (isOverdue || status == TrainingStatus.overdue) {
      return SizedBox(
        width: double.infinity,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: AppColors.n0,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
            ),
            child: Text(status.ctaLabel),
          ),
        ),
      );
    }

    // COMPLETED: Outlined teal button
    if (status == TrainingStatus.completed) {
      return SizedBox(
        width: double.infinity,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.teal,
              side: const BorderSide(color: AppColors.teal),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
            ),
            child: Text(status.ctaLabel),
          ),
        ),
      );
    }

    // IN_PROGRESS: Blue button
    if (status == TrainingStatus.inProgress) {
      return SizedBox(
        width: double.infinity,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.blue,
              foregroundColor: AppColors.n0,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
            ),
            child: Text(status.ctaLabel),
          ),
        ),
      );
    }

    // NOT_STARTED: Primary blue button
    return SizedBox(
      width: double.infinity,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.n0,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
          ),
          child: Text(status.ctaLabel),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EMPTY STATE
// ═══════════════════════════════════════════════════════════════════════════════

/// Empty state with icon, title, description, and optional action.
/// Always explains WHY it's empty and WHAT to do next.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.iconColor,
    this.action,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String description;
  final IconData? icon;
  final Color? iconColor;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.n400).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.inbox_outlined,
                size: 40,
                color: iconColor ?? AppColors.n400,
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            Text(
              title,
              style: AppTypography.headline.copyWith(
                color: AppColors.n700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s2),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                description,
                style: AppTypography.body.copyWith(
                  color: AppColors.n500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (action != null || (actionLabel != null && onAction != null)) ...[
              const SizedBox(height: AppSpacing.s6),
              action ??
                  FilledButton(
                    onPressed: onAction,
                    child: Text(actionLabel!),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ERROR WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

/// Error state with friendly message and retry button.
/// NEVER shows raw error messages or stack traces.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.title,
    this.icon,
    this.secondaryAction,
    this.secondaryLabel,
    this.onSecondaryAction,
  });

  final String message;
  final VoidCallback onRetry;
  final String? title;
  final IconData? icon;
  final Widget? secondaryAction;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.dangerLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.error_outline_rounded,
                size: 40,
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            Text(
              title ?? 'Something went wrong',
              style: AppTypography.headline.copyWith(
                color: AppColors.n700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s2),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                message,
                style: AppTypography.body.copyWith(
                  color: AppColors.n500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Try Again'),
            ),
            if (secondaryAction != null ||
                (secondaryLabel != null && onSecondaryAction != null)) ...[
              const SizedBox(height: AppSpacing.s3),
              secondaryAction ??
                  TextButton(
                    onPressed: onSecondaryAction,
                    child: Text(secondaryLabel!),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SKELETON LOADER
// ═══════════════════════════════════════════════════════════════════════════════

/// Shimmer placeholder for loading states.
/// Always show skeletons, NEVER show blank white screens.
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? AppRadius.br1,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                AppColors.n100,
                AppColors.n200,
                AppColors.n100,
              ],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// READING TIMER WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

/// Countdown timer for minimum read time enforcement.
class ReadingTimerWidget extends StatelessWidget {
  const ReadingTimerWidget({
    super.key,
    required this.totalSeconds,
    required this.elapsedSeconds,
    required this.isComplete,
    this.onComplete,
  });

  final int totalSeconds;
  final int elapsedSeconds;
  final bool isComplete;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final remaining = (totalSeconds - elapsedSeconds).clamp(0, totalSeconds);
    final progress = totalSeconds > 0 ? elapsedSeconds / totalSeconds : 1.0;

    if (isComplete) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: AppRadius.br2,
          border: Border.all(
            color: AppColors.success.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.s2),
            Text(
              'Reading complete',
              style: AppTypography.label.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: BoxDecoration(
        color: AppColors.n100,
        borderRadius: AppRadius.br2,
        border: Border.all(color: AppColors.n200),
      ),
      child: Row(
        children: [
          // Progress ring
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  strokeWidth: 3,
                  backgroundColor: AppColors.n200,
                  valueColor: const AlwaysStoppedAnimation(AppColors.teal),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTypography.caption.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reading progress',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.n600,
                  ),
                ),
                Text(
                  '${remaining.timerLabel} remaining',
                  style: AppTypography.label.copyWith(
                    color: AppColors.n700,
                  ),
                ),
              ],
            ),
          ),
          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: AppRadius.br5,
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: AppColors.n200,
                valueColor: const AlwaysStoppedAnimation(AppColors.teal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREDENTIAL CARD
// ═══════════════════════════════════════════════════════════════════════════════

/// Certificate/credential display card for Credentials Wallet.
class CredentialCard extends StatelessWidget {
  const CredentialCard({
    super.key,
    required this.title,
    required this.issuedDate,
    required this.expiryDate,
    required this.credentialId,
    required this.onDownload,
    required this.onShare,
    this.isExpired = false,
    this.isExpiringSoon = false,
    this.logoUrl,
  });

  final String title;
  final DateTime issuedDate;
  final DateTime? expiryDate;
  final String credentialId;
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final bool isExpired;
  final bool isExpiringSoon;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final hasExpiry = expiryDate != null;
    final expired = isExpired || (expiryDate?.isOverdue ?? false);
    final expiringSoon = isExpiringSoon || (expiryDate?.isExpiringSoon ?? false);

    Color borderColor = AppColors.success;
    Color bgColor = AppColors.successLight;
    if (expired) {
      borderColor = AppColors.danger;
      bgColor = AppColors.dangerLight;
    } else if (expiringSoon) {
      borderColor = AppColors.warning;
      bgColor = AppColors.warningLight;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
        boxShadow: AppShadows.sh1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status
          Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                // Certificate icon or logo
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.n0,
                    borderRadius: AppRadius.br2,
                    border: Border.all(color: AppColors.n200),
                  ),
                  child: logoUrl != null
                      ? ClipRRect(
                          borderRadius: AppRadius.br2,
                          child: Image.network(
                            logoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.workspace_premium_rounded,
                              color: borderColor,
                              size: 28,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.workspace_premium_rounded,
                          color: borderColor,
                          size: 28,
                        ),
                ),
                const SizedBox(width: AppSpacing.s3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (expired)
                        _CredentialStatusBadge(
                          label: 'EXPIRED',
                          color: AppColors.danger,
                        )
                      else if (expiringSoon)
                        _CredentialStatusBadge(
                          label: 'EXPIRING SOON',
                          color: AppColors.warning,
                        )
                      else
                        _CredentialStatusBadge(
                          label: 'VALID',
                          color: AppColors.success,
                        ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: AppTypography.label.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.n900,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Credential ID
                Row(
                  children: [
                    Icon(
                      Icons.tag_rounded,
                      size: 14,
                      color: AppColors.n500,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        credentialId,
                        style: AppTypography.code.copyWith(
                          fontSize: 11,
                          color: AppColors.n600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s3),
                // Dates
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Issued',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.n500,
                            ),
                          ),
                          Text(
                            issuedDate.humanDate,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.n700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (hasExpiry) ...[
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expires',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.n500,
                              ),
                            ),
                            Text(
                              expiryDate!.humanDate,
                              style: AppTypography.bodySmall.copyWith(
                                color: expired
                                    ? AppColors.danger
                                    : (expiringSoon
                                        ? AppColors.warning
                                        : AppColors.n700),
                                fontWeight: expired || expiringSoon
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.s4),
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onDownload,
                        icon: const Icon(Icons.download_rounded, size: 16),
                        label: const Text('Download'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.blue,
                          side: const BorderSide(color: AppColors.n200),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.s3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s3),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onShare,
                        icon: const Icon(Icons.share_rounded, size: 16),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.blue,
                          side: const BorderSide(color: AppColors.n200),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.s3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CredentialStatusBadge extends StatelessWidget {
  const _CredentialStatusBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: AppRadius.br1,
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE VIEWER SIDEBAR
// ═══════════════════════════════════════════════════════════════════════════════

/// Sidebar for course viewer showing lesson list with completion status.
class CourseViewerSidebar extends StatelessWidget {
  const CourseViewerSidebar({
    super.key,
    required this.courseTitle,
    required this.modules,
    required this.currentLessonId,
    required this.onLessonTap,
    this.overallProgress = 0.0,
  });

  final String courseTitle;
  final List<CourseModule> modules;
  final String currentLessonId;
  final void Function(String lessonId) onLessonTap;
  final double overallProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizing.courseOutlineWidth,
      color: AppColors.n0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.n200),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseTitle,
                  style: AppTypography.label.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.n900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.s3),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: AppRadius.br5,
                        child: LinearProgressIndicator(
                          value: overallProgress.clamp(0.0, 1.0),
                          minHeight: 4,
                          backgroundColor: AppColors.n200,
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s2),
                    Text(
                      '${(overallProgress * 100).round()}%',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Modules
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
              itemCount: modules.length,
              itemBuilder: (context, index) {
                final module = modules[index];
                return _ModuleSection(
                  module: module,
                  currentLessonId: currentLessonId,
                  onLessonTap: onLessonTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleSection extends StatelessWidget {
  const _ModuleSection({
    required this.module,
    required this.currentLessonId,
    required this.onLessonTap,
  });

  final CourseModule module;
  final String currentLessonId;
  final void Function(String lessonId) onLessonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Module title
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s2,
          ),
          child: Text(
            module.title,
            style: AppTypography.caption.copyWith(
              color: AppColors.n500,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        // Lessons
        ...module.lessons.map((lesson) {
          final isCurrent = lesson.id == currentLessonId;
          return _LessonItem(
            lesson: lesson,
            isCurrent: isCurrent,
            onTap: () => onLessonTap(lesson.id),
          );
        }),
        const SizedBox(height: AppSpacing.s2),
      ],
    );
  }
}

class _LessonItem extends StatefulWidget {
  const _LessonItem({
    required this.lesson,
    required this.isCurrent,
    required this.onTap,
  });

  final CourseLesson lesson;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  State<_LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<_LessonItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Material(
        color: widget.isCurrent ? AppColors.blueLight : Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.ease,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s3,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: widget.isCurrent ? AppColors.blue : Colors.transparent,
                  width: 3,
                ),
              ),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: AppColors.success.withOpacity(0.18), // light green shadow
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Completion indicator
                _LessonStatusIcon(
                  isComplete: widget.lesson.isCompleted,
                  isCurrent: widget.isCurrent,
                ),
                const SizedBox(width: AppSpacing.s3),
                // Title
                Expanded(
                  child: Text(
                    widget.lesson.title,
                    style: AppTypography.bodySmall.copyWith(
                      color: widget.isCurrent ? AppColors.blue : AppColors.n700,
                      fontWeight: widget.isCurrent ? FontWeight.w600 : FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Duration
                if (widget.lesson.durationMinutes != null)
                  Text(
                    widget.lesson.durationMinutes!.durationLabel,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.n500,
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

class _LessonStatusIcon extends StatelessWidget {
  const _LessonStatusIcon({
    required this.isComplete,
    required this.isCurrent,
  });

  final bool isComplete;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    if (isComplete) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: AppColors.n0,
          size: 14,
        ),
      );
    }

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.blue : AppColors.n0,
        border: Border.all(
          color: isCurrent ? AppColors.blue : AppColors.n300,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: isCurrent
          ? const Center(
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.n0,
                size: 12,
              ),
            )
          : null,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE MODULE/LESSON DATA CLASSES
// ═══════════════════════════════════════════════════════════════════════════════

/// Module within a course (e.g., "Module 1: Introduction")
class CourseModule {
  const CourseModule({
    required this.id,
    required this.title,
    required this.lessons,
  });

  final String id;
  final String title;
  final List<CourseLesson> lessons;
}

/// Lesson within a module
class CourseLesson {
  const CourseLesson({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.durationMinutes,
    this.contentType,
  });

  final String id;
  final String title;
  final bool isCompleted;
  final int? durationMinutes;
  final CourseType? contentType;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ASSESSMENT QUESTION WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

/// Assessment question with multiple choice answers.
class AssessmentQuestion extends StatelessWidget {
  const AssessmentQuestion({
    super.key,
    required this.questionNumber,
    required this.totalQuestions,
    required this.questionText,
    required this.options,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
    this.isSubmitted = false,
    this.correctOptionIndex,
    this.explanation,
  });

  final int questionNumber;
  final int totalQuestions;
  final String questionText;
  final List<String> options;
  final int? selectedOptionIndex;
  final void Function(int index) onOptionSelected;
  final bool isSubmitted;
  final int? correctOptionIndex;
  final String? explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br3,
        boxShadow: AppShadows.sh1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            decoration: const BoxDecoration(
              color: AppColors.n50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s3,
                    vertical: AppSpacing.s1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: AppRadius.br5,
                  ),
                  child: Text(
                    'Q$questionNumber',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.n0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s3),
                Text(
                  'of $totalQuestions',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.n500,
                  ),
                ),
                const Spacer(),
                // Progress
                ClipRRect(
                  borderRadius: AppRadius.br5,
                  child: SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(
                      value: questionNumber / totalQuestions,
                      minHeight: 4,
                      backgroundColor: AppColors.n200,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Question
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: Text(
              questionText,
              style: AppTypography.body.copyWith(
                color: AppColors.n900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Options
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s5,
              0,
              AppSpacing.s5,
              AppSpacing.s5,
            ),
            child: Column(
              children: List.generate(options.length, (index) {
                final isSelected = selectedOptionIndex == index;
                final isCorrect =
                    isSubmitted && correctOptionIndex == index;
                final isWrong = isSubmitted &&
                    isSelected &&
                    correctOptionIndex != index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s3),
                  child: _AnswerOption(
                    label: String.fromCharCode(65 + index), // A, B, C, D
                    text: options[index],
                    isSelected: isSelected,
                    isCorrect: isCorrect,
                    isWrong: isWrong,
                    isSubmitted: isSubmitted,
                    onTap: isSubmitted
                        ? null
                        : () => onOptionSelected(index),
                  ),
                );
              }),
            ),
          ),
          // Explanation (shown after submission)
          if (isSubmitted && explanation != null)
            Container(
              margin: const EdgeInsets.fromLTRB(
                AppSpacing.s5,
                0,
                AppSpacing.s5,
                AppSpacing.s5,
              ),
              padding: const EdgeInsets.all(AppSpacing.s4),
              decoration: BoxDecoration(
                color: AppColors.blueLight,
                borderRadius: AppRadius.br2,
                border: Border.all(
                  color: AppColors.blue.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline_rounded,
                    color: AppColors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: Text(
                      explanation!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.n700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.label,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.isSubmitted,
    this.onTap,
  });

  final String label;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isSubmitted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.n200;
    Color bgColor = AppColors.n0;
    Color labelBgColor = AppColors.n100;
    Color labelColor = AppColors.n600;

    if (isCorrect) {
      borderColor = AppColors.success;
      bgColor = AppColors.successLight;
      labelBgColor = AppColors.success;
      labelColor = AppColors.n0;
    } else if (isWrong) {
      borderColor = AppColors.danger;
      bgColor = AppColors.dangerLight;
      labelBgColor = AppColors.danger;
      labelColor = AppColors.n0;
    } else if (isSelected) {
      borderColor = AppColors.blue;
      bgColor = AppColors.blueLight;
      labelBgColor = AppColors.blue;
      labelColor = AppColors.n0;
    }

    return Material(
      color: bgColor,
      borderRadius: AppRadius.br2,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br2,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br2,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: labelBgColor,
                  borderRadius: AppRadius.br1,
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: AppTypography.label.copyWith(
                    color: labelColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s3),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    text,
                    style: AppTypography.body.copyWith(
                      color: AppColors.n800,
                    ),
                  ),
                ),
              ),
              if (isCorrect)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 24,
                )
              else if (isWrong)
                const Icon(
                  Icons.cancel_rounded,
                  color: AppColors.danger,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SKELETON LOADERS FOR SPECIFIC COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

/// Skeleton loader for course cards
class CourseCardSkeleton extends StatelessWidget {
  const CourseCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail area
          const SkeletonLoader(
            height: 120,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(width: 80, height: 24),
                const SizedBox(height: AppSpacing.s3),
                const SkeletonLoader(height: 20),
                const SizedBox(height: AppSpacing.s2),
                const SkeletonLoader(width: 150, height: 16),
                const SizedBox(height: AppSpacing.s4),
                const SkeletonLoader(height: 44),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton loader for stat cards
class StatCardSkeleton extends StatelessWidget {
  const StatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SkeletonLoader(width: 32, height: 32),
              SizedBox(width: AppSpacing.s3),
              Expanded(child: SkeletonLoader(height: 14)),
            ],
          ),
          SizedBox(height: AppSpacing.s3),
          SkeletonLoader(width: 60, height: 28),
          SizedBox(height: AppSpacing.s1),
          SkeletonLoader(width: 100, height: 14),
        ],
      ),
    );
  }
}

/// Skeleton loader for credential cards
class CredentialCardSkeleton extends StatelessWidget {
  const CredentialCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            color: AppColors.n100,
            child: const Row(
              children: [
                SkeletonLoader(width: 48, height: 48),
                SizedBox(width: AppSpacing.s3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLoader(width: 80, height: 20),
                      SizedBox(height: 4),
                      SkeletonLoader(height: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonLoader(width: 160, height: 14),
                SizedBox(height: AppSpacing.s3),
                Row(
                  children: [
                    Expanded(child: SkeletonLoader(height: 40)),
                    SizedBox(width: AppSpacing.s3),
                    Expanded(child: SkeletonLoader(height: 40)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
