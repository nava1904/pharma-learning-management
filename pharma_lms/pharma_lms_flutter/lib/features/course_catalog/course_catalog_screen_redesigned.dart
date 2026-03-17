// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE CATALOG SCREEN (S5) — SERVERPOD WIRED
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/course-catalog
// Browse all available courses and enroll
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/tokens.dart';
import '../../design_system/components.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

/// Course Catalog screen with Serverpod wiring
class CourseCatalogScreenRedesigned extends ConsumerStatefulWidget {
  const CourseCatalogScreenRedesigned({super.key});

  @override
  ConsumerState<CourseCatalogScreenRedesigned> createState() =>
      _CourseCatalogScreenRedesignedState();
}

class _CourseCatalogScreenRedesignedState
    extends ConsumerState<CourseCatalogScreenRedesigned> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _sortBy = 'title';
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(coursesProvider);
        ref.invalidate(enrollmentsProvider);
        await Future.wait([
          ref.refresh(coursesProvider.future),
          ref.refresh(enrollmentsProvider.future),
        ]);
      },
      child: coursesAsync.when(
        data: (courses) {
          final enrollments = enrollmentsAsync.valueOrNull ?? [];
          return _CatalogContent(
            courses: courses,
            enrollments: enrollments,
            searchQuery: _searchQuery,
            selectedCategory: _selectedCategory,
            sortBy: _sortBy,
            sortAscending: _sortAscending,
            onSearchChanged: (v) => setState(() => _searchQuery = v),
            onCategoryChanged: (c) => setState(() => _selectedCategory = c),
            onSortChanged: (by, asc) => setState(() {
              _sortBy = by;
              _sortAscending = asc;
            }),
            onEnroll: (course) => _handleEnroll(course),
            onView: _handleView,
          );
        },
        loading: () => _buildLoadingState(),
        error: (e, _) => _buildErrorState(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoader(height: 32, width: 200),
          const SizedBox(height: AppSpacing.s2),
          SkeletonLoader(height: 20, width: 300),
          const SizedBox(height: AppSpacing.s6),
          SkeletonLoader(height: 48),
          const SizedBox(height: AppSpacing.s6),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.s4,
              crossAxisSpacing: AppSpacing.s4,
              childAspectRatio: 1.2,
            ),
            itemCount: 6,
            itemBuilder: (_, __) => const SkeletonLoader(height: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: AppErrorWidget(
        title: 'Unable to Load Courses',
        message: 'There was a problem loading the course catalog.',
        onRetry: () {
          ref.invalidate(coursesProvider);
          ref.invalidate(enrollmentsProvider);
        },
      ),
    );
  }

  Future<void> _handleEnroll(Course course) async {
    final user = ref.read(currentUserProvider).valueOrNull;
    if (user?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to enroll'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enroll in Course'),
        content: Text('Would you like to enroll in "${course.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
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
                backgroundColor: AppColors.danger,
              ),
            );
          }
          return;
        }
        // Prefer effective or approved, else first non-obsolete
        CourseVersion version = versions.firstWhere(
          (v) => v.status == 'effective' || v.status == 'approved',
          orElse: () => versions.firstWhere(
            (v) => v.status != 'obsolete',
            orElse: () => versions.first,
          ),
        );
        final courseVersionId = version.id!;
        await client.training.selfEnroll(
          userId: user!.id!,
          courseVersionId: courseVersionId,
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully enrolled in ${course.title}'),
            backgroundColor: AppColors.success,
          ),
        );
        ref.invalidate(enrollmentsProvider);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Enrollment failed: ${e.toString().replaceAll('Exception: ', '')}'),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  /// Resolve a course version for viewing (catalog shows Course; viewer needs courseVersionId).
  Future<void> _handleView(Course course) async {
    final versions = await client.course.getCourseVersions(course.id!);
    if (versions.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No course version available to view.'),
            backgroundColor: AppColors.danger,
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
    final courseVersionId = version.id!;
    if (!mounted) return;
    context.go('/employee/course/${course.id}', extra: {
      'courseVersionId': courseVersionId.toString(),
    });
  }
}

class _CatalogContent extends StatelessWidget {
  const _CatalogContent({
    required this.courses,
    required this.enrollments,
    required this.searchQuery,
    required this.selectedCategory,
    required this.sortBy,
    required this.sortAscending,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onSortChanged,
    required this.onEnroll,
    required this.onView,
  });

  final List<Course> courses;
  final List<Enrollment> enrollments;
  final String searchQuery;
  final String selectedCategory;
  final String sortBy;
  final bool sortAscending;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onCategoryChanged;
  final void Function(String, bool) onSortChanged;
  final ValueChanged<Course> onEnroll;
  final ValueChanged<Course> onView;

  /// Course ids for which the user has at least one enrollment (enrollments include courseVersion.course).
  Set<int> get _enrolledCourseIds {
    return enrollments
        .map((e) => e.courseVersion?.course?.id)
        .whereType<int>()
        .toSet();
  }

  // Use status as filtering option
  List<String> get _statusFilters {
    final statuses = courses
        .map((c) => c.status)
        .toSet()
        .toList();
    statuses.sort();
    return ['All', ...statuses];
  }

  List<Course> get _filteredCourses {
    var filtered = courses.toList();

    // Filter by status
    if (selectedCategory != 'All') {
      filtered = filtered
          .where((c) => c.status == selectedCategory)
          .toList();
    }

    // Filter by search
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((c) {
        return c.title.toLowerCase().contains(query) ||
            (c.description?.toLowerCase().contains(query) ?? false) ||
            (c.sopNumber?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Sort
    switch (sortBy) {
      case 'title':
        filtered.sort((a, b) => sortAscending
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
        break;
      case 'status':
        filtered.sort((a, b) {
          final aStatus = a.status;
          final bStatus = b.status;
          return sortAscending ? aStatus.compareTo(bStatus) : bStatus.compareTo(aStatus);
        });
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCourses;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSpacing.s6),
          _buildFilterBar(),
          const SizedBox(height: AppSpacing.s5),
          Row(
            children: [
              Text(
                '${filtered.length} course${filtered.length == 1 ? '' : 's'} available',
                style: AppTypography.bodySmall.copyWith(color: AppColors.n500),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppSpacing.s4),
          if (filtered.isEmpty)
            AppEmptyState(
              icon: Icons.search_off_outlined,
              title: 'No Courses Found',
              description: 'Try adjusting your filters or search terms.',
              actionLabel: 'Clear Filters',
              onAction: () {
                onSearchChanged('');
                onCategoryChanged('All');
              },
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 800
                        ? 3
                        : constraints.maxWidth > 500
                            ? 2
                            : 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: AppSpacing.s4,
                    crossAxisSpacing: AppSpacing.s4,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final course = filtered[index];
                    final isEnrolled = course.id != null && _enrolledCourseIds.contains(course.id);
                    return _CourseCard(
                      course: course,
                      isEnrolled: isEnrolled,
                      onEnroll: () => onEnroll(course),
                      onView: () => onView(course),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Catalog',
          style: AppTypography.display.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.s2),
        Text(
          'Browse available courses and enroll in training',
          style: AppTypography.body.copyWith(color: AppColors.n500),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Wrap(
        spacing: AppSpacing.s4,
        runSpacing: AppSpacing.s3,
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search courses by title, description, or SOP...',
                hintStyle: AppTypography.body.copyWith(color: AppColors.n400),
                prefixIcon: Icon(Icons.search, color: AppColors.n400, size: 20),
                filled: true,
                fillColor: AppColors.n50,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s4,
                  vertical: AppSpacing.s3,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.br2,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.br2,
                  borderSide: BorderSide(color: AppColors.n200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.br2,
                  borderSide: BorderSide(color: AppColors.blue, width: 2),
                ),
              ),
              style: AppTypography.body,
            ),
          ),
          _FilterDropdown(
            value: selectedCategory,
            items: {for (var c in _statusFilters) c: c},
            onChanged: onCategoryChanged,
            label: 'Status',
          ),
          _FilterDropdown(
            value: sortBy,
            items: const {
              'title': 'Title',
              'status': 'Status',
            },
            onChanged: (v) => onSortChanged(v, sortAscending),
            label: 'Sort By',
          ),
          IconButton(
            onPressed: () => onSortChanged(sortBy, !sortAscending),
            icon: Icon(
              sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 20,
              color: AppColors.n500,
            ),
            tooltip: sortAscending ? 'Sort Ascending' : 'Sort Descending',
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s1),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        border: Border.all(color: AppColors.n200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          style: AppTypography.body.copyWith(color: AppColors.n700),
          items: items.entries.map((e) {
            return DropdownMenuItem(value: e.key, child: Text(e.value));
          }).toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.isEnrolled,
    required this.onEnroll,
    required this.onView,
  });

  final Course course;
  final bool isEnrolled;
  final VoidCallback onEnroll;
  final VoidCallback onView;

  Color _getStatusColor() {
    final status = course.status.toLowerCase();
    if (status == 'approved') return AppColors.success;
    if (status == 'pending_qa') return AppColors.warning;
    if (status == 'archived') return AppColors.n500;
    return AppColors.blue; // draft
  }

  String _getStatusLabel() {
    switch (course.status.toLowerCase()) {
      case 'approved':
        return 'Approved';
      case 'pending_qa':
        return 'Pending QA';
      case 'archived':
        return 'Archived';
      case 'draft':
        return 'Draft';
      default:
        return course.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.n0,
      borderRadius: AppRadius.br2,
      child: InkWell(
        onTap: onView,
        borderRadius: AppRadius.br2,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br2,
            border: Border.all(
              color: isEnrolled ? AppColors.success.withValues(alpha: 0.5) : AppColors.n200,
              width: isEnrolled ? 2 : 1,
            ),
            boxShadow: AppShadows.sh1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s2,
                      vertical: AppSpacing.s1,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withValues(alpha: 0.1),
                      borderRadius: AppRadius.br1,
                    ),
                    child: Text(
                      _getStatusLabel(),
                      style: AppTypography.caption.copyWith(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isEnrolled)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s2,
                        vertical: AppSpacing.s1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: AppRadius.br1,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, size: 14, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text(
                            'Enrolled',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.s3),
              Text(
                course.title,
                style: AppTypography.title.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.s2),
              if (course.sopNumber != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                  child: Text(
                    course.sopNumber!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (course.description != null)
                Expanded(
                  child: Text(
                    course.description!,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.n500),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  if (isEnrolled)
                    FilledButton(
                      onPressed: onView,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s3,
                          vertical: AppSpacing.s2,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Continue', style: TextStyle(fontSize: 12)),
                    )
                  else
                    OutlinedButton(
                      onPressed: onEnroll,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.blue,
                        side: BorderSide(color: AppColors.blue),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s3,
                          vertical: AppSpacing.s2,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Enroll', style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
