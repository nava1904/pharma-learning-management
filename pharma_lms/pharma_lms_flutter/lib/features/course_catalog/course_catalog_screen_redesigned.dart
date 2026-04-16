import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/tokens.dart';
import '../../design_system/components.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/realtime_progress_provider.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';
import 'course_catalog_metadata.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE CATALOG SCREEN (S5) — SERVERPOD WIRED
// ═══════════════════════════════════════════════════════════════════════════════

class CourseCatalogScreenRedesigned extends ConsumerStatefulWidget {
  const CourseCatalogScreenRedesigned({super.key});

  @override
  ConsumerState<CourseCatalogScreenRedesigned> createState() => _CourseCatalogScreenRedesignedState();
}

class _CourseCatalogScreenRedesignedState extends ConsumerState<CourseCatalogScreenRedesigned> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedStatus = 'All';
  String _selectedRegulatory = 'All';
  String _sortBy = 'title';
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    // Refresh progress data every time the catalog screen is visited
    // so it reflects the latest course completion from the viewer.
    Future.microtask(() {
      ref.invalidate(enrollmentProgressProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final progressMap = ref.watch(mergedEnrollmentProgressProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(coursesProvider);
        ref.invalidate(enrollmentsProvider);
        ref.invalidate(enrollmentProgressProvider);
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
            progressMap: progressMap,
            searchQuery: _searchQuery,
            selectedCategory: _selectedCategory,
            selectedStatus: _selectedStatus,
            selectedRegulatory: _selectedRegulatory,
            sortBy: _sortBy,
            sortAscending: _sortAscending,
            onSearchChanged: (v) => setState(() => _searchQuery = v),
            onCategoryChanged: (c) => setState(() => _selectedCategory = c),
            onStatusChanged: (s) => setState(() => _selectedStatus = s),
            onRegulatoryChanged: (r) => setState(() => _selectedRegulatory = r),
            onSortChanged: (by, asc) => setState(() {
              _sortBy = by;
              _sortAscending = asc;
            }),
            onEnroll: _handleEnroll,
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
          const SkeletonLoader(height: 32, width: 200),
          const SizedBox(height: AppSpacing.s2),
          const SkeletonLoader(height: 20, width: 300),
          const SizedBox(height: AppSpacing.s6),
          const SkeletonLoader(height: 48),
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
            itemBuilder: (_, _) => const SkeletonLoader(height: 200),
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
        const SnackBar(content: Text('Please log in to enroll'), backgroundColor: AppColors.danger),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enroll in Course'),
        content: Text('Would you like to enroll in "${course.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Enroll')),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        final versions = await client.course.getCourseVersions(course.id!);
        if (versions.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No course version available.'), backgroundColor: AppColors.danger),
            );
          }
          return;
        }
        CourseVersion version = versions.firstWhere(
          (v) => v.status == 'effective' || v.status == 'approved',
          orElse: () => versions.firstWhere((v) => v.status != 'obsolete', orElse: () => versions.first),
        );
        
        await client.training.selfEnroll(userId: user!.id!, courseVersionId: version.id!);
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully enrolled in ${course.title}'), backgroundColor: AppColors.success),
        );
        ref.invalidate(enrollmentsProvider);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Enrollment failed: ${e.toString().replaceAll('Exception: ', '')}'), backgroundColor: AppColors.danger),
          );
        }
      }
    }
  }

  Future<void> _handleView(Course course) async {
    final versions = await client.course.getCourseVersions(course.id!);
    if (versions.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No course version available to view.'), backgroundColor: AppColors.danger),
        );
      }
      return;
    }
    
    CourseVersion version = versions.firstWhere(
      (v) => v.status == 'effective' || v.status == 'approved',
      orElse: () => versions.firstWhere((v) => v.status != 'obsolete', orElse: () => versions.first),
    );
    
    final courseVersionId = version.id!;
    final user = ref.read(currentUserProvider).valueOrNull;
    int? enrollmentId;
    String? enrollmentStatus;
    
    if (user?.id != null) {
      try {
        final enrollments = await client.training.getEnrollmentsForUser(user!.id!);
        for (final e in enrollments) {
          if (e.courseVersionId == courseVersionId) {
            enrollmentId = e.id;
            enrollmentStatus = e.status;
            break;
          }
        }
      } catch (_) {}
    }
    
    if (!mounted) return;
    context.go('/course/${course.id}', extra: {
      'courseVersionId': courseVersionId.toString(),
      if (enrollmentId != null) 'enrollmentId': enrollmentId.toString(),
      'enrollmentStatus': ?enrollmentStatus,
      if (user?.id != null) 'userId': user!.id!.toString(),
    });
  }
}

class _CatalogContent extends StatelessWidget {
  const _CatalogContent({
    required this.courses,
    required this.enrollments,
    required this.progressMap,
    required this.searchQuery,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.selectedRegulatory,
    required this.sortBy,
    required this.sortAscending,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onStatusChanged,
    required this.onRegulatoryChanged,
    required this.onSortChanged,
    required this.onEnroll,
    required this.onView,
  });

  final List<Course> courses;
  final List<Enrollment> enrollments;
  final Map<int, double> progressMap;
  final String searchQuery;
  final String selectedCategory;
  final String selectedStatus;
  final String selectedRegulatory;
  final String sortBy;
  final bool sortAscending;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onRegulatoryChanged;
  final void Function(String, bool) onSortChanged;
  final ValueChanged<Course> onEnroll;
  final ValueChanged<Course> onView;

  Set<int> get _enrolledCourseIds => enrollments.map((e) => e.courseVersion?.course?.id).whereType<int>().toSet();

  /// Build dropdown items dynamically from the actual course data.
  Map<String, String> get _categoryItems {
    final cats = courses
        .map((c) => c.category?.trim() ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return {
      'All': 'Category: All',
      for (final c in cats) c: 'Category: $c',
      if (cats.isEmpty) ...{
        'GMP': 'Category: GMP',
        'SOP': 'Category: SOP',
        'Compliance': 'Category: Compliance',
        'Safety': 'Category: Safety',
      },
    };
  }

  Map<String, String> get _statusItems {
    final statuses = courses.map((c) => c.status.trim()).toSet().toList()..sort();
    return {
      'All': 'Status: All',
      for (final s in statuses) s: 'Status: ${_statusLabel(s)}',
    };
  }

  Map<String, String> get _regulatoryItems {
    final regTags = <String>{};
    for (final c in courses) {
      final tags = (c.tags ?? '').split(',').map((t) => t.trim()).where((t) => t.isNotEmpty);
      for (final t in tags) {
        if (t == 'GMP' || t == '21 CFR' || t == 'ICH' || t == 'FDA' || t == 'EMA' || t == 'WHO' || t == 'Mandatory' || t == 'Optional') {
          regTags.add(t);
        }
      }
    }
    final sorted = regTags.toList()..sort();
    return {
      'All': 'Regulatory: All',
      for (final r in sorted) r: 'Regulatory: $r',
      if (sorted.isEmpty) ...{
        'GMP': 'Regulatory: GMP',
        '21 CFR': 'Regulatory: 21 CFR',
        'Mandatory': 'Regulatory: Mandatory',
      },
    };
  }

  static String _statusLabel(String status) {
    switch (status) {
      case 'draft': return 'Draft';
      case 'approved': return 'Approved';
      case 'effective': return 'Effective';
      case 'published': return 'Published';
      case 'under_review': return 'Under Review';
      case 'pending_qa': return 'Pending QA';
      case 'rejected': return 'Rejected';
      case 'archived': return 'Archived';
      case 'obsolete': return 'Obsolete';
      default: return status[0].toUpperCase() + status.substring(1);
    }
  }

  List<Course> get _filteredCourses {
    var filtered = courses.toList();

    // Search filter
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((c) {
        return c.title.toLowerCase().contains(query) ||
            (c.description?.toLowerCase().contains(query) ?? false) ||
            (c.sopNumber?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Category filter
    if (selectedCategory != 'All') {
      filtered = filtered.where((c) =>
          (c.category?.trim() ?? '') == selectedCategory).toList();
    }

    // Status filter
    if (selectedStatus != 'All') {
      filtered = filtered.where((c) => c.status.trim() == selectedStatus).toList();
    }

    // Regulatory / tag filter
    if (selectedRegulatory != 'All') {
      filtered = filtered.where((c) {
        final tags = (c.tags ?? '').split(',').map((t) => t.trim()).toSet();
        return tags.contains(selectedRegulatory);
      }).toList();
    }

    // Sort
    switch (sortBy) {
      case 'title':
        filtered.sort((a, b) => sortAscending ? a.title.compareTo(b.title) : b.title.compareTo(a.title));
        break;
      case 'status':
        filtered.sort((a, b) => sortAscending ? a.status.compareTo(b.status) : b.status.compareTo(a.status));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCourses;
    
    final totalCourses = filtered.length;
    final enrolledCount = enrollments.where((e) => e.status != 'completed').length;
    final mandatoryCount = filtered.where((c) => (c.tags ?? '').contains('Mandatory')).length;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Course catalog',
                style: AppTypography.display.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                width: 280,
                height: 40,
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: AppTypography.body.copyWith(color: AppColors.n400),
                    prefixIcon: const Icon(Icons.search, color: AppColors.n400, size: 20),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.xxl),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.xxl),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.xxl),
                      borderSide: const BorderSide(color: AppColors.blue, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Filters
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _FilterDropdown(value: selectedCategory, items: _categoryItems, onChanged: onCategoryChanged),
              _FilterDropdown(value: selectedStatus, items: _statusItems, onChanged: onStatusChanged),
              _FilterDropdown(value: selectedRegulatory, items: _regulatoryItems, onChanged: onRegulatoryChanged),
              _FilterDropdown(value: sortBy, items: const {'title': 'Sort: Title A-Z', 'status': 'Sort: Status'}, onChanged: (v) => onSortChanged(v, true)),
            ],
          ),
          const SizedBox(height: 24),
          
          // Summary
          Text(
            '$totalCourses courses · $enrolledCount enrolled · $mandatoryCount mandatory',
            style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          
          // Grid
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                mainAxisExtent: 240, 
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final course = filtered[index];
                final isEnrolled = course.id != null && _enrolledCourseIds.contains(course.id);
                Enrollment? courseEnrollment;
                
                for (final e in enrollments) {
                  if (e.courseVersion?.course?.id == course.id || e.courseVersionId == course.id) {
                    courseEnrollment = e;
                    break;
                  }
                }
                
                return _CourseCard(
                  course: course,
                  enrollment: courseEnrollment,
                  isEnrolled: isEnrolled,
                  progressPct: courseEnrollment?.id != null
                      ? (progressMap[courseEnrollment!.id!] ?? 0.0)
                      : 0.0,
                  onEnroll: () => onEnroll(course),
                  onView: () => onView(course),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({required this.value, required this.items, required this.onChanged});
  
  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
          ),
          style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
          items: items.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
          onChanged: (v) { if (v != null) onChanged(v); },
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    this.enrollment,
    required this.isEnrolled,
    required this.progressPct,
    required this.onEnroll,
    required this.onView,
  });

  final Course course;
  final Enrollment? enrollment;
  final bool isEnrolled;
  final double progressPct;
  final VoidCallback onEnroll;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    final meta = CourseCatalogMetadata.fromCourse(course);
    final tags = (course.tags ?? '').split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    
  final bool isMandatory = meta.isMandatory ?? tags.contains('Mandatory');
  final bool isContentApproved = tags.contains('Content approved');
    
    final List<String> regulatoryTags = tags.where((t) => t == 'GMP' || t == '21 CFR').toList();
    
    final status = enrollment?.status ?? 'not_started';
    final isCompleted = status.toLowerCase() == 'completed';
    // Use real progress from server+realtime merged provider
    final progress = isCompleted ? 100.0 : progressPct;
    final isEnrolledLocally = isEnrolled || status != 'not_started'; 
    final hasSop = course.sopNumber?.isNotEmpty == true;

    // Get the cover photo URL from the backend model
    final coverage = course.imageUrl?.trim() ?? '';

    // Due Date mapping from backend
    final DateTime? dueDate = enrollment?.assignment?.dueDate;
    final String dueDateFormatted = dueDate != null ? DateFormat('MMM d, yyyy').format(dueDate) : 'No due date';

    // Fallback Contextual Icon Logic
    IconData courseIcon = Icons.science_outlined;
    if (course.title.toLowerCase().contains('aseptic')) {
      courseIcon = Icons.science_outlined; 
    } else if (course.title.toLowerCase().contains('audit')) {
      courseIcon = Icons.fact_check_outlined; 
    } else {
      courseIcon = Icons.article_outlined; 
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP SECTION: Cover Photo/Icon + Title/Badges
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(PharmaRadius.lg),
                ),
                clipBehavior: Clip.hardEdge, 
                child: coverage.isNotEmpty
                    ? Image.network(
                        coverage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Center(
                          child: Icon(courseIcon, color: Colors.grey.shade600, size: 28),
                        ),
                      )
                    : Center(
                        child: Icon(courseIcon, color: Colors.grey.shade600, size: 28),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black87, height: 1.2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (isMandatory)
                          _StatusBadge(label: 'Mandatory', bgColor: const Color(0xFFFFEBEE), textColor: const Color(0xFFC62828)),
                        if (!isMandatory)
                          _StatusBadge(label: 'Optional', bgColor: Colors.grey.shade100, textColor: Colors.grey.shade800),
                        if (isContentApproved)
                          _StatusBadge(
                            label: 'Content approved', 
                            bgColor: const Color(0xFFE8F5E9), 
                            textColor: const Color(0xFF2E7D32),
                            icon: Icons.check_circle,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // 2. MIDDLE SECTION: Due Date & SOP
          Row(
            children: [
              Text(
                'Due: $dueDateFormatted',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800, fontWeight: FontWeight.w500),
              ),
              if (hasSop) ...[
                const SizedBox(width: 12),
                Icon(Icons.article_outlined, size: 14, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(
                  course.sopNumber!,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 3. PROGRESS TEXT & BAR
          Text(
            isCompleted ? 'Completed' : (isEnrolledLocally ? 'In progress · ${progress.toInt()}%' : 'Not started'),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (progress.clamp(0.0, 100.0)) / 100.0,
              minHeight: 4,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(isCompleted ? Colors.green : AppColors.blue),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 4. BOTTOM SECTION: Tags & Action Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: regulatoryTags.map((tag) {
                    final is21Cfr = tag.contains('21 CFR');
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: is21Cfr ? Colors.blue.shade50 : Colors.orange.shade50, 
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text(
                        tag, 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w700, 
                          color: is21Cfr ? Colors.blue.shade800 : Colors.orange.shade800
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 34,
                child: isCompleted
                    ? SizedBox(
                        width: 96,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.grey.shade600,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text('Completed', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      )
                    : isEnrolledLocally
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Chat with trainer button
                              if ((enrollment?.courseVersionId ?? course.id) != null)
                                SizedBox(
                                  width: 34,
                                  height: 34,
                                  child: IconButton(
                                    tooltip: 'Message trainer',
                                    onPressed: () {
                                      final cvId = enrollment?.courseVersionId ?? course.id!;
                                      openLearnerInstructorChat(
                                        context,
                                        courseVersionId: cvId,
                                        courseTitle: course.title,
                                      );
                                    },
                                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                                    color: AppColors.blue,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: AppColors.blue.withOpacity(0.3)),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 96,
                                child: ElevatedButton(
                                  onPressed: onView,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text('Continue', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            width: 96,
                            child: OutlinedButton(
                              onPressed: onEnroll,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.blue,
                                side: const BorderSide(color: AppColors.blue, width: 1.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text('Enroll', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final IconData? icon;

  const _StatusBadge({
    required this.label, 
    required this.bgColor, 
    required this.textColor, 
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
        ],
      ),
    );
  }
}