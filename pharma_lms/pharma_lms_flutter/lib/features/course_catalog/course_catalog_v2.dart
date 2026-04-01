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
import 'course_catalog_metadata.dart';
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
          onOpenCourse: _openCourse,
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

  Future<void> _openCourse(Course course, Enrollment? enrollment) async {
    var courseVersionId = enrollment?.courseVersionId ?? 0;
    if (courseVersionId == 0) {
      final versions = await client.course.getCourseVersions(course.id!);
      if (versions.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No course version available to view.'),
              backgroundColor: PharmaColors.danger,
            ),
          );
        }
        return;
      }
      final version = versions.firstWhere(
        (v) => v.status == 'effective' || v.status == 'approved',
        orElse: () => versions.firstWhere(
          (v) => v.status != 'obsolete',
          orElse: () => versions.first,
        ),
      );
      courseVersionId = version.id!;
    }
    final user = ref.read(currentUserProvider).valueOrNull;
    if (!mounted) return;
    context.go('/course/${course.id}', extra: {
      'courseVersionId': courseVersionId.toString(),
      if (enrollment?.id != null) 'enrollmentId': enrollment!.id!.toString(),
      if (enrollment != null) 'enrollmentStatus': enrollment.status,
      if (user?.id != null) 'userId': user!.id!.toString(),
    });
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
    required this.onOpenCourse,
  });

  final List<Course> courses;
  final List<Enrollment> enrollments;
  final String filter;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<Course> onEnroll;
  final Future<void> Function(Course course, Enrollment? enrollment) onOpenCourse;

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
                    // Taller cells than 0.75 — image + title + 2-line desc + meta + CTA/progress
                    // was overflowing by ~9px on typical breakpoints.
                    childAspectRatio: 0.68,
                  ),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];
                    final enrollment = enrollmentMap[course.id];
                    return _CourseCardV2(
                      course: course,
                      enrollment: enrollment,
                      onTap: () => onOpenCourse(course, enrollment),
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
    final isEnrolled = widget.enrollment != null;
    // Use CourseCatalogMetadata for custom fields
    // Helper to parse due date from metadata if available
    DateTime? metaJsonDate(CourseCatalogMetadata meta) {
      // If you store due date in customMetadataJson, parse here
      // Example: meta.dueDate (if you add it to CourseCatalogMetadata)
      return null;
    }

    // Helper to get progress from enrollment or fallback
    double enrollmentProgress(Enrollment? e, String status) {
      // If you store progress in enrollment, use it; else fallback
      // Example: e?.progressPercent ?? _calculateProgress(status)
      return _calculateProgress(status);
    }

    final meta = CourseCatalogMetadata.fromCourse(widget.course);
    final tags = (widget.course.tags ?? '').split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    final isMandatory = meta.isMandatory ?? tags.contains('Mandatory');
    final isContentApproved = tags.contains('Content approved');
    final regulatoryTags = tags.where((t) => t == 'GMP' || t == '21 CFR').toList();
    // Fallback: try meta, then null
    final dueDate = metaJsonDate(meta);
    final sopNumber = widget.course.sopNumber;
    final progress = enrollmentProgress(widget.enrollment, status);

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
              // Cover image and status badge
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    (widget.course.imageUrl != null && widget.course.imageUrl!.trim().isNotEmpty)
                        ? Image.network(
                            widget.course.imageUrl!.trim(),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (_, __, ___) => _courseCardImageFallback(),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _courseCardImageFallback();
                            },
                          )
                        : _courseCardImageFallback(),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _StatusBadgeV2(status: status),
                    ),
                  ],
                ),
              ),
              // Tags row
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
                child: Row(
                  children: [
                    if (isMandatory)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Mandatory', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    if (!isMandatory)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Optional', style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    if (isContentApproved)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 14),
                            const SizedBox(width: 4),
                            Text('Content approved', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    for (final tag in regulatoryTags)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: PharmaColors.gray100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(tag, style: TextStyle(color: PharmaColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    const Spacer(),
                    if (isEnrolled)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: PharmaColors.emerald100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 14, color: PharmaColors.emerald600),
                            const SizedBox(width: 4),
                            Text('Enrolled', style: PharmaTypography.caption.copyWith(color: PharmaColors.emerald600, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
                child: Text(
                  widget.course.title,
                  style: PharmaTypography.headingSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Metadata row: Due date, SOP, Progress
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
                child: Row(
                  children: [
                    if (dueDate != null)
                      Text('Due: ', style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
                    if (dueDate != null)
                      Text(
                        '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}',
                        style: PharmaTypography.caption.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    if (sopNumber != null) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.description_outlined, size: 14, color: PharmaColors.textTertiary),
                      const SizedBox(width: 2),
                      Text(sopNumber, style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
                    ],
                    const Spacer(),
                    if (progress > 0)
                      Text('In progress : ${progress.toInt()}%', style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
                    if (progress == 0)
                      Text('Not started', style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
                  ],
                ),
              ),
              // Progress bar
              if (progress > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress / 100.0,
                      minHeight: 6,
                      backgroundColor: PharmaColors.gray200,
                      valueColor: AlwaysStoppedAnimation<Color>(PharmaColors.primary),
                    ),
                  ),
                ),
              // Description
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Text(
                    widget.course.description ?? 'No description available',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Spacer(),
              // CTA
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
                child: Row(
                  children: [
                    const Spacer(),
                    if (isEnrolled)
                      FilledButton(
                        onPressed: widget.onTap,
                        style: FilledButton.styleFrom(
                          backgroundColor: PharmaColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Continue', style: TextStyle(fontSize: 12)),
                      )
                    else
                      OutlinedButton(
                        onPressed: widget.onEnroll,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PharmaColors.primary,
                          side: BorderSide(color: PharmaColors.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Enroll', style: TextStyle(fontSize: 12)),
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

  Widget _courseCardImageFallback() {
    return Container(
      decoration: BoxDecoration(
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
