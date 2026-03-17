// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE CATALOG V2 (REACT REFERENCE MATCH)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Reverse-engineered from React reference: Courses.tsx
// Uses real data from Serverpod via coursesProvider
//
// Layout:
// ┌─────────────────────────────────────────────────────────────────────────────┐
// │  My Courses                                      [All Courses] [In Progress]│
// │  Continue your pharmaceutical training journey                              │
// ├─────────────────────────────────────────────────────────────────────────────┤
// │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                       │
// │  │   IMAGE      │  │   IMAGE      │  │   IMAGE      │                       │
// │  │   [Badge]    │  │   [Badge]    │  │   [Badge]    │                       │
// │  ├──────────────┤  ├──────────────┤  ├──────────────┤                       │
// │  │ Title        │  │ Title        │  │ Title        │                       │
// │  │ Description  │  │ Description  │  │ Description  │                       │
// │  │ ⏰ 8h 👥 1250│  │ ⏰ 6h 👥 980 │  │ ⏰ 10h👥1420 │                       │
// │  │ ████████░░   │  │ ████░░░░░░   │  │ ██░░░░░░░░   │                       │
// │  └──────────────┘  └──────────────┘  └──────────────┘                       │
// └─────────────────────────────────────────────────────────────────────────────┘
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../design_system/pharma_design_system.dart';
import '../../core/client.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class CourseCatalogV2 extends ConsumerStatefulWidget {
  const CourseCatalogV2({super.key});

  @override
  ConsumerState<CourseCatalogV2> createState() => _CourseCatalogV2State();
}

class _CourseCatalogV2State extends ConsumerState<CourseCatalogV2> {
  String _filter = 'all'; // 'all', 'in_progress', 'completed'

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);

    return coursesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: PharmaColors.emerald500),
      ),
      error: (e, _) => _ErrorState(
        onRetry: () => ref.invalidate(coursesProvider),
      ),
      data: (courses) {
        final enrollments = enrollmentsAsync.valueOrNull ?? [];
        return _CourseCatalogContent(
          courses: courses,
          enrollments: enrollments,
          filter: _filter,
          onFilterChanged: (f) => setState(() => _filter = f),
          onEnroll: (course) => _handleEnroll(course),
        );
      },
    );
  }

  Future<void> _handleEnroll(Course course) async {
    final user = ref.read(currentUserProvider).valueOrNull;
    if (user?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to enroll'),
          backgroundColor: PharmaColors.danger,
        ),
      );
      return;
    }

    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: PharmaRadius.cardRadius),
        title: Text('Enroll in Course', style: PharmaTypography.headingSmall),
        content: Text(
          'Would you like to enroll in "${course.title}"?',
          style: PharmaTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: TextStyle(color: PharmaColors.textSecondary)),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
            ),
            child: const Text('Enroll'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        // Resolve course version: backend expects courseVersionId, not course id
        final versions = await client.course.getCourseVersions(course.id!);
        if (versions.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No course version available to enroll.'),
                backgroundColor: PharmaColors.danger,
              ),
            );
          }
          return;
        }
        CourseVersion version = versions.firstWhere(
          (v) => v.status == 'effective' || v.status == 'approved',
          orElse: () => versions.firstWhere(
            (v) => v.status != 'obsolete',
            orElse: () => versions.first,
          ),
        );
        await client.training.selfEnroll(
          userId: user!.id!,
          courseVersionId: version.id!,
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully enrolled in ${course.title}'),
            backgroundColor: PharmaColors.success,
          ),
        );
        ref.invalidate(enrollmentsProvider);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Enrollment failed: ${e.toString().replaceAll('Exception: ', '')}'),
              backgroundColor: PharmaColors.danger,
            ),
          );
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CONTENT
// ═══════════════════════════════════════════════════════════════════════════════

class _CourseCatalogContent extends StatelessWidget {
  const _CourseCatalogContent({
    required this.courses,
    required this.enrollments,
    required this.filter,
    required this.onFilterChanged,
    required this.onEnroll,
  });

  final List<Course> courses;
  final List<Enrollment> enrollments;
  final String filter;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<Course> onEnroll;

  @override
  Widget build(BuildContext context) {
    // Create a map of course ID to enrollment for quick lookup
    final enrollmentMap = <int, Enrollment>{};
    for (final e in enrollments) {
      final courseId = e.courseVersion?.course?.id ?? e.courseVersionId;
      enrollmentMap[courseId] = e;
    }

    // Filter courses based on selected filter
    List<Course> filteredCourses = courses;
    if (filter == 'in_progress') {
      filteredCourses = courses.where((c) {
        final enrollment = enrollmentMap[c.id];
        return enrollment?.status == 'in_progress';
      }).toList();
    } else if (filter == 'completed') {
      filteredCourses = courses.where((c) {
        final enrollment = enrollmentMap[c.id];
        return enrollment?.status == 'completed';
      }).toList();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─────────────────────────────────────────────────────────────────
          // HEADER ROW
          // From React: title + filter buttons
          // ─────────────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Courses',
                    style: PharmaTypography.headingLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Continue your pharmaceutical training journey',
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textSecondary,
                    ),
                  ),
                ],
              ),
              _FilterButtons(
                currentFilter: filter,
                onFilterChanged: onFilterChanged,
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ─────────────────────────────────────────────────────────────────
          // COURSE GRID
          // From React: grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6
          // ─────────────────────────────────────────────────────────────────
          if (filteredCourses.isEmpty)
            _EmptyState(filter: filter)
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth < 600
                    ? 1
                    : constraints.maxWidth < 900
                        ? 2
                        : 3;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: PharmaSpacing.gridGap,
                    crossAxisSpacing: PharmaSpacing.gridGap,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];
                    final enrollment = enrollmentMap[course.id];
                    return _CourseCardV2(
                      course: course,
                      enrollment: enrollment,
                      onTap: () => _navigateToCourse(context, course, enrollment),
                      onEnroll: () => onEnroll(course),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  void _navigateToCourse(BuildContext context, Course course, Enrollment? enrollment) {
    context.go('/employee/course/${course.id}', extra: {
      'courseVersionId': enrollment?.courseVersionId.toString() ?? course.id.toString(),
      'enrollmentId': enrollment?.id?.toString(),
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// FILTER BUTTONS
// From React: All Courses | In Progress buttons
// ═══════════════════════════════════════════════════════════════════════════════

class _FilterButtons extends StatelessWidget {
  const _FilterButtons({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final String currentFilter;
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterButton(
          label: 'All Courses',
          isActive: currentFilter == 'all',
          onTap: () => onFilterChanged('all'),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'In Progress',
          isActive: currentFilter == 'in_progress',
          isPrimary: true,
          onTap: () => onFilterChanged('in_progress'),
        ),
      ],
    );
  }
}

class _FilterButton extends StatefulWidget {
  const _FilterButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActiveOrHovered = widget.isActive || _isHovered;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: PharmaSpacing.lg,
            vertical: PharmaSpacing.md,
          ),
          decoration: BoxDecoration(
            color: widget.isPrimary && widget.isActive
                ? PharmaColors.emerald600
                : isActiveOrHovered
                    ? PharmaColors.gray50
                    : Colors.transparent,
            borderRadius: PharmaRadius.buttonRadius,
            border: Border.all(
              color: widget.isPrimary && widget.isActive
                  ? PharmaColors.emerald600
                  : PharmaColors.borderMedium,
            ),
          ),
          child: Text(
            widget.label,
            style: PharmaTypography.button.copyWith(
              color: widget.isPrimary && widget.isActive
                  ? Colors.white
                  : PharmaColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE CARD
// From React: Course card with image, status badge, progress bar
// ═══════════════════════════════════════════════════════════════════════════════

class _CourseCardV2 extends StatefulWidget {
  const _CourseCardV2({
    required this.course,
    required this.onTap,
    required this.onEnroll,
    this.enrollment,
  });

  final Course course;
  final Enrollment? enrollment;
  final VoidCallback onTap;
  final VoidCallback onEnroll;

  @override
  State<_CourseCardV2> createState() => _CourseCardV2State();
}

class _CourseCardV2State extends State<_CourseCardV2> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final status = widget.enrollment?.status ?? 'not_enrolled';
    // Calculate progress based on status (since progressPercentage isn't in the model)
    final progress = _calculateProgress(status);
    final isEnrolled = widget.enrollment != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: isEnrolled ? widget.onTap : widget.onEnroll,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
            boxShadow: _isHovered
                ? PharmaShadows.cardHoverShadow
                : PharmaShadows.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─────────────────────────────────────────────────────────────
              // COURSE IMAGE
              // From React: aspect-video with status badge
              // ─────────────────────────────────────────────────────────────
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    // Image/Placeholder
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            PharmaColors.emerald100,
                            PharmaColors.emerald200,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getCourseIcon(widget.course.title),
                          size: 48,
                          color: PharmaColors.emerald600,
                        ),
                      ),
                    ),
                    
                    // Status badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _StatusBadgeV2(status: status),
                    ),
                  ],
                ),
              ),

              // ─────────────────────────────────────────────────────────────
              // COURSE INFO
              // From React: p-5 with title, description, metadata, progress
              // ─────────────────────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(PharmaSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.course.title,
                        style: PharmaTypography.headingSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Description
                      Expanded(
                        child: Text(
                          widget.course.description ?? 'No description available',
                          style: PharmaTypography.body.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Metadata row
                      const SizedBox(height: PharmaSpacing.lg),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: PharmaColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '8 hours',
                            style: PharmaTypography.caption,
                          ),
                          const SizedBox(width: PharmaSpacing.lg),
                          Icon(
                            Icons.people_outline_rounded,
                            size: 16,
                            color: PharmaColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '1,250',
                            style: PharmaTypography.caption,
                          ),
                        ],
                      ),
                      
                      // Progress bar (only if enrolled and has progress)
                      if (isEnrolled && progress > 0) ...[
                        const SizedBox(height: PharmaSpacing.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progress',
                              style: PharmaTypography.caption.copyWith(
                                color: PharmaColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${progress.toInt()}%',
                              style: PharmaTypography.caption.copyWith(
                                color: PharmaColors.emerald600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: PharmaRadius.pillRadius,
                          child: LinearProgressIndicator(
                            value: progress / 100,
                            backgroundColor: PharmaColors.gray200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              PharmaColors.emerald600,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ],
                      
                      // Enroll button if not enrolled
                      if (!isEnrolled) ...[
                        const SizedBox(height: PharmaSpacing.lg),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: widget.onEnroll,
                            style: TextButton.styleFrom(
                              backgroundColor: PharmaColors.emerald600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: PharmaSpacing.md,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: PharmaRadius.buttonRadius,
                              ),
                            ),
                            child: const Text('Enroll Now'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCourseIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('gmp') || lowerTitle.contains('manufacturing')) {
      return Icons.factory_rounded;
    }
    if (lowerTitle.contains('safety') || lowerTitle.contains('sop')) {
      return Icons.health_and_safety_rounded;
    }
    if (lowerTitle.contains('quality')) {
      return Icons.verified_rounded;
    }
    if (lowerTitle.contains('regulatory') || lowerTitle.contains('compliance')) {
      return Icons.gavel_rounded;
    }
    if (lowerTitle.contains('cleanroom')) {
      return Icons.clean_hands_rounded;
    }
    if (lowerTitle.contains('validation')) {
      return Icons.checklist_rounded;
    }
    return Icons.menu_book_rounded;
  }

  /// Calculate progress based on status (since progressPercentage isn't in the model)
  double _calculateProgress(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 100.0;
      case 'in_progress':
        return 50.0; // Default to 50% for in-progress
      case 'not_started':
      case 'assigned':
        return 0.0;
      default:
        return 0.0;
    }
  }
}

class _StatusBadgeV2 extends StatelessWidget {
  const _StatusBadgeV2({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, label) = _getStatusStyle(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PharmaSpacing.md,
        vertical: PharmaSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  (Color, Color, String) _getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return (PharmaColors.successBg, PharmaColors.successText, 'Completed');
      case 'in_progress':
        return (PharmaColors.infoBg, PharmaColors.infoText, 'In Progress');
      case 'not_started':
      case 'assigned':
        return (PharmaColors.gray100, PharmaColors.gray700, 'Not Started');
      default:
        return (PharmaColors.gray100, PharmaColors.gray700, 'Not Enrolled');
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EMPTY & ERROR STATES
// ═══════════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.filter});

  final String filter;

  @override
  Widget build(BuildContext context) {
    String message;
    if (filter == 'in_progress') {
      message = 'No courses in progress. Start learning today!';
    } else if (filter == 'completed') {
      message = 'No completed courses yet. Keep learning!';
    } else {
      message = 'No courses available at the moment.';
    }

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 64,
              color: PharmaColors.textTertiary,
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Text(
              message,
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: PharmaColors.danger,
          ),
          const SizedBox(height: PharmaSpacing.lg),
          Text(
            'Unable to load courses',
            style: PharmaTypography.headingSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again.',
            style: PharmaTypography.caption,
          ),
          const SizedBox(height: PharmaSpacing.xxl),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: TextButton.styleFrom(
              foregroundColor: PharmaColors.emerald600,
            ),
          ),
        ],
      ),
    );
  }
}
