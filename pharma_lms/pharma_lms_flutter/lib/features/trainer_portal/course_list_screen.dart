// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE LIST (TRN-10)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses
// Filter tabs: All | My Courses | Under Review | Published | Archived
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';
import '../trainer_dashboard/new_course_dialog.dart';

class CourseListScreen extends ConsumerStatefulWidget {
  const CourseListScreen({super.key});

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen> {
  List<Course> _courses = [];
  bool _loading = true;
  String? _error;
  String _filter = 'all';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) throw Exception('User not found');
      final courses = await client.course.listCourses(
        organizationId: user.organizationId,
      );
      if (mounted) {
        setState(() {
          _courses = courses;
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

  List<Course> get _filteredCourses {
    var filtered = _courses;
    final user = ref.read(currentUserProvider).valueOrNull;
    switch (_filter) {
      case 'mine':
        filtered = filtered.where((c) => c.createdById == user?.id).toList();
        break;
      case 'under_review':
        filtered = filtered
            .where((c) => c.status == 'pending_qa' || c.status == 'under_review')
            .toList();
        break;
      case 'published':
        filtered = filtered
            .where((c) =>
                c.status == 'approved' ||
                c.status == 'published' ||
                c.status == 'effective')
            .toList();
        break;
      case 'archived':
        filtered = filtered.where((c) => c.status == 'archived').toList();
        break;
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered
          .where((c) =>
              c.title.toLowerCase().contains(q) ||
              (c.sopNumber?.toLowerCase().contains(q) ?? false))
          .toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        // ── HEADER ──
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Courses', style: PharmaTypography.headingLarge.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5,
                  )),
                  const SizedBox(height: 4),
                  Text(
                    '${_courses.length} total courses',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: () => _createNewCourse(),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create New Course'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
              ),
            ),
          ],
        ),

        const SizedBox(height: PharmaSpacing.sectionGap),

        // ── FILTER TABS + SEARCH ──
        Container(
          padding: const EdgeInsets.all(PharmaSpacing.lg),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
            boxShadow: PharmaShadows.sm,
          ),
          child: Column(
            children: [
              // Filter tabs
              Row(
                children: [
                  _FilterTab('All', 'all'),
                  _FilterTab('My Courses', 'mine'),
                  _FilterTab('Under Review', 'under_review'),
                  _FilterTab('Published', 'published'),
                  _FilterTab('Archived', 'archived'),
                  const Spacer(),
                  // Search
                  SizedBox(
                    width: 250,
                    height: 36,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Search by title or SOP...',
                        hintStyle: PharmaTypography.caption,
                        prefixIcon: const Icon(Icons.search, size: 18),
                        filled: true,
                        fillColor: PharmaColors.pageBg,
                        border: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius,
                          borderSide: BorderSide(color: PharmaColors.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius,
                          borderSide: BorderSide(color: PharmaColors.borderLight),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                      style: PharmaTypography.body.copyWith(fontSize: 13),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: PharmaSpacing.lg),
              Divider(height: 1, color: PharmaColors.borderLight),

              // ── TABLE ──
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(48),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_error != null)
                Padding(
                  padding: const EdgeInsets.all(48),
                  child: Center(
                    child: Column(
                      children: [
                        Text(_error!, style: TextStyle(color: PharmaColors.danger)),
                        const SizedBox(height: 12),
                        FilledButton(onPressed: _load, child: const Text('Retry')),
                      ],
                    ),
                  ),
                )
              else if (_filteredCourses.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    children: [
                      Icon(Icons.menu_book_outlined, size: 48, color: PharmaColors.gray300),
                      const SizedBox(height: 12),
                      Text('No courses found', style: PharmaTypography.headingSmall),
                      const SizedBox(height: 4),
                      Text(
                        'Create your first course to get started.',
                        style: PharmaTypography.body,
                      ),
                    ],
                  ),
                )
              else
                _buildCourseTable(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _FilterTab(String label, String value) {
    final isActive = _filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: TextButton(
        onPressed: () => setState(() => _filter = value),
        style: TextButton.styleFrom(
          backgroundColor: isActive ? PharmaColors.emerald50 : Colors.transparent,
          foregroundColor: isActive ? PharmaColors.emerald700 : PharmaColors.textTertiary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: PharmaRadius.buttonRadius,
            side: isActive
                ? BorderSide(color: PharmaColors.emerald200)
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildCourseTable() {
    return DataTable(
      headingRowHeight: 44,
      dataRowMinHeight: 56,
      dataRowMaxHeight: 64,
      columnSpacing: 16,
      horizontalMargin: 0,
      headingTextStyle: PharmaTypography.labelMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: PharmaColors.textTertiary,
        fontSize: 11,
        letterSpacing: 0.5,
      ),
      columns: const [
        DataColumn(label: Text('COURSE')),
        DataColumn(label: Text('SOP #')),
        DataColumn(label: Text('STATUS')),
        DataColumn(label: Text('CREATED')),
        DataColumn(label: Text('ACTIONS')),
      ],
      rows: _filteredCourses.map((course) {
        return DataRow(
          cells: [
            // Course title
            DataCell(
              Text(
                course.title,
                style: PharmaTypography.bodyMedium.copyWith(fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => context.go('/trainer/courses/${course.id}/builder'),
            ),
            // SOP Number
            DataCell(
              Text(
                course.sopNumber ?? '—',
                style: PharmaTypography.caption.copyWith(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            // Status chip + workflow stepper
            DataCell(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatusChip(status: course.status),
                const SizedBox(height: 4),
                PharmaWorkflowStepper(
                  currentStatus: course.status,
                  steps: const ['draft', 'pending_approval', 'effective'],
                ),
              ],
            )),
            // Created date
            DataCell(
              Text(
                'Recently',
                style: PharmaTypography.caption,
              ),
            ),
            // Actions
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () =>
                        context.go('/trainer/courses/${course.id}/builder'),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    tooltip: 'Edit',
                    color: PharmaColors.textTertiary,
                  ),
                  IconButton(
                    onPressed: () =>
                        context.go('/trainer/courses/${course.id}/versions'),
                    icon: const Icon(Icons.history, size: 18),
                    tooltip: 'Versions',
                    color: PharmaColors.textTertiary,
                  ),
                  IconButton(
                    onPressed: () =>
                        context.go('/trainer/courses/${course.id}/analytics'),
                    icon: const Icon(Icons.analytics_outlined, size: 18),
                    tooltip: 'Analytics',
                    color: PharmaColors.textTertiary,
                  ),
                  IconButton(
                    onPressed: () => _confirmDeleteCourse(course),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    tooltip: 'Delete',
                    color: PharmaColors.danger,
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Future<void> _confirmDeleteCourse(Course course) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Course'),
        content: Text('Are you sure you want to delete "${course.title}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      try {
        await client.course.deleteCourse(courseId: course.id!);
        _load();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('"${course.title}" deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting course: $e')),
          );
        }
      }
    }
  }

  Future<void> _createNewCourse() async {
    final user = ref.read(currentUserProvider).valueOrNull;
    if (user == null) return;
    final course = await NewCourseDialog.show(
      context,
      organizationId: user.organizationId,
      createdById: user.id!,
    );
    if (course != null && mounted) {
      _load();
      context.go('/trainer/courses/${course.id}/builder');
    }
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;
    switch (status) {
      case 'draft':
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray700;
        label = 'DRAFT';
        break;
      case 'pending_qa':
      case 'under_review':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        label = 'UNDER REVIEW';
        break;
      case 'approved':
      case 'published':
      case 'effective':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'QA APPROVED';
        break;
      case 'rejected':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.dangerText;
        label = 'REJECTED';
        break;
      case 'archived':
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray500;
        label = 'ARCHIVED';
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = status.toUpperCase();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
