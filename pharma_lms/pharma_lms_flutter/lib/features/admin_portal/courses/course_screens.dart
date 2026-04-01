import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show Course;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE CATALOGUE SCREEN - Real data from backend
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCourseCatalogueScreen extends ConsumerStatefulWidget {
  const AdminCourseCatalogueScreen({super.key});

  @override
  ConsumerState<AdminCourseCatalogueScreen> createState() => _AdminCourseCatalogueScreenState();
}

class _AdminCourseCatalogueScreenState extends ConsumerState<AdminCourseCatalogueScreen> {
  String _searchQuery = '';
  String? _selectedStatus;
  int _currentPage = 1;
  final int _perPage = 20;

  @override
  Widget build(BuildContext context) {
    final courseParams = CourseListParams(
      page: _currentPage,
      perPage: _perPage,
      search: _searchQuery.isNotEmpty ? _searchQuery : null,
      status: _selectedStatus,
    );
    
    final coursesAsync = ref.watch(adminCoursesListProvider(courseParams));
    final allCoursesAsync = ref.watch(adminCoursesProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(context, allCoursesAsync),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Search & Filters
          _buildSearchAndFilters(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Courses Table
          coursesAsync.when(
            data: (courses) => _buildCoursesTable(context, courses),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),

          // Pagination
          SizedBox(height: PharmaSpacing.sectionGap),
          _buildPagination(allCoursesAsync),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, AsyncValue<List<Course>> coursesAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Course Catalogue', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            coursesAsync.when(
              data: (courses) => Text(
                '${courses.length} total courses',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              loading: () => Text(
                'Loading...',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => context.push('/admin/courses/create'),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Course'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Search Box
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (value) => setState(() {
                _searchQuery = value;
                _currentPage = 1;
              }),
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                  vertical: PharmaSpacing.sm,
                ),
              ),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Status Filter
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'Status',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                  vertical: PharmaSpacing.sm,
                ),
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text('All')),
                DropdownMenuItem(value: 'draft', child: Text('Draft')),
                DropdownMenuItem(value: 'pending_qa', child: Text('Pending QA')),
                DropdownMenuItem(value: 'effective', child: Text('Effective')),
                DropdownMenuItem(value: 'retired', child: Text('Retired')),
              ],
              onChanged: (value) => setState(() {
                _selectedStatus = value;
                _currentPage = 1;
              }),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Clear Filters
          TextButton.icon(
            onPressed: () => setState(() {
              _searchQuery = '';
              _selectedStatus = null;
              _currentPage = 1;
            }),
            icon: const Icon(Icons.clear, size: 18),
            label: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesTable(BuildContext context, List<Course> courses) {
    if (courses.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.school_outlined, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No courses found',
                style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textTertiary),
              ),
              if (_searchQuery.isNotEmpty || _selectedStatus != null)
                TextButton(
                  onPressed: () => setState(() {
                    _searchQuery = '';
                    _selectedStatus = null;
                  }),
                  child: const Text('Clear filters'),
                ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: PharmaSpacing.cardPadding,
              vertical: PharmaSpacing.md,
            ),
            decoration: BoxDecoration(
              color: PharmaColors.gray50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(PharmaRadius.md)),
            ),
            child: Row(
              children: [
                _buildHeaderCell('Course Title', flex: 3),
                _buildHeaderCell('Status', flex: 1),
                _buildHeaderCell('SOP #', flex: 1),
                _buildHeaderCell('Actions', flex: 1),
              ],
            ),
          ),
          
          // Table Rows
          ...courses.map((course) => _buildCourseRow(context, course)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: PharmaTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: PharmaColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildCourseRow(BuildContext context, Course course) {
    final statusColor = _getStatusColor(course.status);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PharmaSpacing.cardPadding,
        vertical: PharmaSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          // Course Title & Description
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: PharmaColors.emerald50,
                    borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  ),
                  child: Icon(Icons.school_outlined, size: 20, color: PharmaColors.emerald600),
                ),
                SizedBox(width: PharmaSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: PharmaTypography.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (course.description != null)
                        Text(
                          course.description!,
                          style: PharmaTypography.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Status Badge
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
              ),
              child: Text(
                _formatStatus(course.status),
                style: PharmaTypography.caption.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          // SOP Number (instead of Updated Date)
          Expanded(
            flex: 1,
            child: Text(
              course.sopNumber ?? '-',
              style: PharmaTypography.caption,
            ),
          ),
          
          // Actions
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  onPressed: () => context.push('/admin/courses/${course.id}'),
                  tooltip: 'View Details',
                  color: PharmaColors.info,
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => context.push('/admin/courses/${course.id}/edit'),
                  tooltip: 'Edit Course',
                  color: PharmaColors.textTertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatStatus(String status) {
    return status.replaceAll('_', ' ').toUpperCase();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'effective':
      case 'published':
        return PharmaColors.success;
      case 'draft':
        return PharmaColors.textTertiary;
      case 'pending_qa':
      case 'under_review':
        return PharmaColors.warning;
      case 'retired':
        return PharmaColors.danger;
      default:
        return PharmaColors.textSecondary;
    }
  }

  Widget _buildPagination(AsyncValue<List<Course>> coursesAsync) {
    return coursesAsync.when(
      data: (courses) {
        final totalPages = (courses.length / _perPage).ceil();
        if (totalPages <= 1) return const SizedBox.shrink();
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _currentPage > 1 
                  ? () => setState(() => _currentPage--) 
                  : null,
            ),
            Text('Page $_currentPage of $totalPages'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _currentPage < totalPages 
                  ? () => setState(() => _currentPage++) 
                  : null,
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text(
              'Failed to load courses',
              style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.dangerText),
            ),
            Text(error, style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton(
              onPressed: () => ref.invalidate(adminCoursesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE APPROVAL QUEUE SCREEN - Real data
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCourseApprovalScreen extends ConsumerWidget {
  const AdminCourseApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingCoursesAsync = ref.watch(adminPendingApprovalCoursesProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Course Approval Queue', style: PharmaTypography.displayLarge),
              SizedBox(height: PharmaSpacing.xs),
              Text(
                'Review and approve courses pending QA sign-off',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Pending Courses
          pendingCoursesAsync.when(
            data: (courses) => _buildPendingCoursesList(context, ref, courses),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(
              child: Text('Error loading courses: $e'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingCoursesList(BuildContext context, WidgetRef ref, List<Course> courses) {
    if (courses.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.successBg,
          border: Border.all(color: PharmaColors.success),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.check_circle_outline, size: 48, color: PharmaColors.success),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'All caught up!',
                style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.successText),
              ),
              Text(
                'No courses pending approval',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: courses.map((course) => _buildApprovalCard(context, ref, course)).toList(),
    );
  }

  Widget _buildApprovalCard(BuildContext context, WidgetRef ref, Course course) {
    return Container(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.warning),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PharmaColors.warningBg,
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                child: Icon(Icons.pending_actions, size: 24, color: PharmaColors.warning),
              ),
              SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title, style: PharmaTypography.headingSmall),
                    if (course.description != null)
                      Text(
                        course.description!,
                        style: PharmaTypography.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
                decoration: BoxDecoration(
                  color: PharmaColors.warningBg,
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                child: Text(
                  course.status.replaceAll('_', ' ').toUpperCase(),
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.warningText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          Divider(color: PharmaColors.borderLight),
          SizedBox(height: PharmaSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () => context.push('/admin/courses/${course.id}'),
                icon: const Icon(Icons.visibility_outlined, size: 18),
                label: const Text('Review'),
              ),
              SizedBox(width: PharmaSpacing.md),
              ElevatedButton.icon(
                onPressed: () => _showApprovalDialog(context, ref, course),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Approve'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.success,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showApprovalDialog(BuildContext context, WidgetRef ref, Course course) {
    final passwordController = TextEditingController();
    final meaningController = TextEditingController(
      text: 'I approve this course version as accurate and compliant',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Approve "${course.title}"? This will publish the latest pending version.'),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password (e-signature)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: meaningController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Signature meaning',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final me = await ref.read(currentUserProvider.future);
                if (me?.id == null) throw Exception('Not authenticated');
                final courseId = course.id;
                if (courseId == null) throw Exception('Missing course id');

                final versions = await client.course.getCourseVersions(courseId);
                final pending = versions.where((v) => v.status == 'pending_approval').toList();
                if (pending.isEmpty) {
                  throw Exception('No pending_approval course version found for this course');
                }
                pending.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
                final versionId = pending.first.id;
                if (versionId == null) throw Exception('Missing course version id');

                await client.qa.approveCourseVersion(
                  courseVersionId: versionId,
                  passwordPlaintext: passwordController.text,
                  signatureMeaning: meaningController.text,
                  approverId: me!.id!,
                );

                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Course "${course.title}" approved')),
                );
                ref.invalidate(adminPendingApprovalCoursesProvider);
                ref.invalidate(adminCoursesProvider);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Approve failed: $e')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PharmaColors.success,
            ),
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE COURSE SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCourseCreateScreen extends ConsumerStatefulWidget {
  const AdminCourseCreateScreen({super.key});

  @override
  ConsumerState<AdminCourseCreateScreen> createState() => _AdminCourseCreateScreenState();
}

class _AdminCourseCreateScreenState extends ConsumerState<AdminCourseCreateScreen> {
  final _title = TextEditingController();
  final _sop = TextEditingController();
  final _desc = TextEditingController();
  bool _saving = false;

  Future<void> _create() async {
    setState(() => _saving = true);
    try {
      final me = await ref.read(currentUserProvider.future);
      if (me?.id == null) throw Exception('Not authenticated');

      final created = await client.course.createCourseWithVersion(
        title: _title.text.trim(),
        sopNumber: _sop.text.trim().isEmpty ? null : _sop.text.trim(),
        description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
        organizationId: me!.organizationId,
        createdById: me.id!,
      );

      final courseData = created['course'];
      Course? course;
      if (courseData is Course) {
        course = courseData;
      } else if (courseData is Map<String, dynamic>) {
        course = Course.fromJson(courseData);
      }
      if (!mounted) return;
      ref.invalidate(adminCoursesProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Created course "${course?.title ?? _title.text.trim()}"')),
      );
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Create failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Create Course',
      subtitle: 'Create new training content (Course + initial version).',
      children: [
        AdminSectionCard(
          title: 'Course Details',
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              TextField(
                controller: _sop,
                decoration: const InputDecoration(
                  labelText: 'SOP Number (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              TextField(
                controller: _desc,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _saving ? null : _create,
                  child: Text(_saving ? 'Creating...' : 'Create'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
