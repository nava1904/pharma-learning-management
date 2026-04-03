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
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';
import '../trainer_dashboard/new_course_dialog.dart';
import 'widgets/trainer_page_scaffold.dart';

class CourseListScreen extends ConsumerStatefulWidget {
  const CourseListScreen({super.key, this.initialSearch});

  final String? initialSearch;

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen> {
  List<Course> _courses = [];
  bool _loading = true;
  String? _error;
  String _filter = 'all';
  String _searchQuery = '';
  Course? _selectedCourse;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.initialSearch ?? '';
    _load();
  }

  @override
  void didUpdateWidget(covariant CourseListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSearch != oldWidget.initialSearch) {
      _searchQuery = widget.initialSearch ?? '';
      _load();
    }
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
        search: _searchQuery.isNotEmpty ? _searchQuery : null,
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
    return filtered;
  }

  static final _dateFmt = DateFormat.yMMMd();

  String _publishedLabel(Course course) {
    final p = course.publishedAt;
    if (p != null) return _dateFmt.format(p);
    return '—';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        // ── HEADER ──
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courses',
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (_searchQuery.isNotEmpty)
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          'Search results for "$_searchQuery" · ${_courses.length} found',
                          style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setState(() => _searchQuery = '');
                            _load();
                          },
                          icon: const Icon(Icons.close, size: 14),
                          label: const Text('Clear'),
                          style: TextButton.styleFrom(
                            foregroundColor: PharmaColors.textSecondary,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    )
                  else
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

        // ── TABLE + SIDE PANEL (table stretches to available width) ──
        LayoutBuilder(
          builder: (context, outerConstraints) {
            final panelOpen = _selectedCourse != null;
            final tableMaxWidth = panelOpen
                ? (outerConstraints.maxWidth - 360 - 24).clamp(320.0, double.infinity)
                : outerConstraints.maxWidth;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(PharmaSpacing.lg),
                    decoration: BoxDecoration(
                      color: PharmaColors.cardBg,
                      borderRadius: PharmaRadius.cardRadius,
                      border: Border.all(color: PharmaColors.borderLight),
                      boxShadow: PharmaShadows.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _FilterTab('All', 'all'),
                              _FilterTab('My Courses', 'mine'),
                              _FilterTab('Under Review', 'under_review'),
                              _FilterTab('Published', 'published'),
                              _FilterTab('Archived', 'archived'),
                            ],
                          ),
                        ),
                        const SizedBox(height: PharmaSpacing.lg),
                        Divider(height: 1, color: PharmaColors.borderLight),
                        if (_loading)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 48),
                            child: TrainerPageLoading(cardCount: 3),
                          )
                        else if (_error != null)
                          TrainerPageError(
                            message: _error!,
                            onRetry: _load,
                          )
                        else if (_filteredCourses.isEmpty)
                          PharmaEmptyState(
                            icon: Icons.menu_book_outlined,
                            title: 'No courses found',
                            subtitle: 'Create your first course to get started.',
                            action: FilledButton.icon(
                              onPressed: _createNewCourse,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Create Course'),
                              style: FilledButton.styleFrom(
                                backgroundColor: PharmaColors.emerald600,
                                foregroundColor: PharmaColors.cardBg,
                              ),
                            ),
                          )
                        else
                          LayoutBuilder(
                            builder: (context, c) {
                              final w = c.maxWidth > 0 ? c.maxWidth : tableMaxWidth;
                              return ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 520),
                                child: SingleChildScrollView(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(minWidth: w),
                                      child: _buildCourseTable(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                if (panelOpen) ...[
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 360,
                    child: _buildCourseDetailPanel(_selectedCourse!),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCourseDetailPanel(Course course) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Course details',
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedCourse = null),
                icon: const Icon(Icons.close, size: 18),
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            course.title,
            style: PharmaTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (course.sopNumber != null) ...[
            const SizedBox(height: 4),
            Text(
              'SOP #${course.sopNumber}',
              style: PharmaTypography.caption.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ],
          const SizedBox(height: 8),
          _StatusChip(status: course.status),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => context.go('/trainer/courses/${course.id}/builder'),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Open builder'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
              ),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.go('/trainer/courses/${course.id}/versions'),
            icon: const Icon(Icons.history, size: 18),
            label: const Text('Versions'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PharmaColors.emerald700,
              side: const BorderSide(color: PharmaColors.emerald200),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.go('/trainer/courses/${course.id}/analytics'),
            icon: const Icon(Icons.analytics_outlined, size: 18),
            label: const Text('Analytics'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PharmaColors.emerald700,
              side: const BorderSide(color: PharmaColors.emerald200),
            ),
          ),
        ],
      ),
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
      dataRowMaxHeight: 72,
      columnSpacing: 20,
      horizontalMargin: 12,
      dividerThickness: 1,
      border: TableBorder(
        horizontalInside: BorderSide(color: PharmaColors.borderLight.withValues(alpha: 0.6)),
      ),
      headingRowColor: WidgetStatePropertyAll(PharmaColors.gray50),
      headingTextStyle: PharmaTypography.labelMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: PharmaColors.textTertiary,
        fontSize: 11,
        letterSpacing: 0.6,
      ),
      columns: const [
        DataColumn(label: Text('COURSE')),
        DataColumn(label: Text('SOP #')),
        DataColumn(label: Text('STATUS')),
        DataColumn(label: Text('PUBLISHED')),
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
              onTap: () => setState(() => _selectedCourse = course),
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
            DataCell(
              Text(
                _publishedLabel(course),
                style: PharmaTypography.caption.copyWith(fontSize: 12),
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
      builder: (ctx) => PharmaDialog(
        title: 'Delete Course',
        titleIcon: Icons.delete_outline,
        content: Text(
          'Are you sure you want to delete "${course.title}"? This cannot be undone.',
          style: PharmaTypography.body,
        ),
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
