// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINING ASSIGNMENTS (TRN-14)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/assignments
// Assign courses to employees/groups with due dates and priority.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:intl/intl.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

// ─── PROVIDERS ───────────────────────────────────────────────────────────────

final _assignmentsProvider =
    FutureProvider.autoDispose<List<TrainingAssignment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  return client.training.getAllAssignments(
    organizationId: user.organizationId,
  );
});

final _orgCoursesProvider =
    FutureProvider.autoDispose<List<Course>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  return client.course.listCourses(organizationId: user.organizationId);
});

final _orgUsersProvider =
    FutureProvider.autoDispose<List<PharmaUser>>((ref) async {
  return client.organization.listUsers();
});

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class TrainingAssignmentsScreen extends ConsumerStatefulWidget {
  const TrainingAssignmentsScreen({super.key});

  @override
  ConsumerState<TrainingAssignmentsScreen> createState() =>
      _TrainingAssignmentsScreenState();
}

class _TrainingAssignmentsScreenState
    extends ConsumerState<TrainingAssignmentsScreen> {
  String _filterStatus = 'All';
  String _searchQuery = '';
  TrainingAssignment? _selectedAssignment;

  List<TrainingAssignment> _applyFilters(List<TrainingAssignment> all) {
    return all.where((a) {
      if (_filterStatus != 'All' &&
          a.status.toLowerCase() != _filterStatus.toLowerCase()) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final courseName =
            a.courseVersion?.course?.title.toLowerCase() ?? '';
        final userName =
            '${a.user?.firstName ?? ''} ${a.user?.lastName ?? ''}'
                .toLowerCase();
        if (!courseName.contains(q) && !userName.contains(q)) return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final assignmentsAsync = ref.watch(_assignmentsProvider);

    return assignmentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text('Failed to load assignments',
                style: PharmaTypography.headingSmall),
            const SizedBox(height: 4),
            Text('$e', style: PharmaTypography.caption),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(_assignmentsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (assignments) => _buildContent(assignments),
    );
  }

  Widget _buildContent(List<TrainingAssignment> assignments) {
    final filtered = _applyFilters(assignments);
    final active =
        assignments.where((a) => a.status == 'active').length;
    final overdue = assignments.where((a) {
      return a.status == 'active' && a.dueDate.isBefore(DateTime.now());
    }).length;
    final completed =
        assignments.where((a) => a.status == 'completed').length;
    final cancelled =
        assignments.where((a) => a.status == 'cancelled' || a.status == 'superseded').length;

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(_assignmentsProvider),
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildStatsRow(active, overdue, completed, assignments.length),
          const SizedBox(height: 16),
          _buildFilters(),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...filtered.map((a) => _buildAssignmentCard(a)),
                            if (filtered.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(48),
                        decoration: BoxDecoration(
                          color: PharmaColors.cardBg,
                          borderRadius: PharmaRadius.cardRadius,
                          border: Border.all(color: PharmaColors.borderLight),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.assignment_outlined,
                                size: 48, color: PharmaColors.gray300),
                            const SizedBox(height: 8),
                            Text('No assignments match filters',
                                style: PharmaTypography.bodyMedium),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (_selectedAssignment != null) ...[
                const SizedBox(width: 24),
                SizedBox(
                  width: 360,
                  child: _buildAssignmentDetailPanel(_selectedAssignment!),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentDetailPanel(TrainingAssignment a) {
    final courseName =
        a.courseVersion?.course?.title ?? 'Course #${a.courseVersionId}';
    final userName =
        '${a.user?.firstName ?? ''} ${a.user?.lastName ?? ''}'.trim();
    final assigneeName = userName.isNotEmpty ? userName : 'User #${a.userId}';
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
                  'Assignment details',
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedAssignment = null),
                icon: const Icon(Icons.close, size: 18),
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(courseName,
              style: PharmaTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Assigned to: $assigneeName',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          const SizedBox(height: 8),
          Text(
            'Due: ${DateFormat('MMM d, yyyy').format(a.dueDate)}',
            style: PharmaTypography.body,
          ),
          if (a.reason != null && a.reason!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Reason: ${a.reason}',
                style: PharmaTypography.caption),
          ],
          const SizedBox(height: 20),
          if (a.status == 'active' || a.status == 'completed') ...[
            OutlinedButton(
              onPressed: () => _onAssignmentAction('extend', a),
              child: const Text('Extend deadline'),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.assignment, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Training Assignments',
                  style: PharmaTypography.headingLarge
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Assign and track training for employees and teams',
                  style: PharmaTypography.body
                      .copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        FilledButton.icon(
          onPressed: _showNewAssignmentDialog,
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Assignment'),
          style: FilledButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: PharmaColors.cardBg,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(
      int active, int overdue, int completed, int total) {
    return Row(
      children: [
        _stat('Active', '$active', Icons.pending_actions, PharmaColors.info),
        _stat(
            'Overdue', '$overdue', Icons.warning_amber, PharmaColors.danger),
        _stat('Completed', '$completed', Icons.check_circle,
            PharmaColors.emerald600),
        _stat('Total', '$total', Icons.assignment, PharmaColors.gray600),
      ]
          .map((w) => Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 12), child: w)))
          .toList(),
    );
  }

  Widget _stat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value,
              style: PharmaTypography.statNumber.copyWith(fontSize: 20)),
          Text(label,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
        ]),
      ]),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Search by course or assignee…',
              prefixIcon: const Icon(Icons.search, size: 18),
              filled: true,
              fillColor: PharmaColors.pageBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ...['All', 'Active', 'Completed', 'Cancelled'].map((s) {
          final isActive = _filterStatus == s;
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: FilterChip(
              label: Text(s),
              selected: isActive,
              onSelected: (_) => setState(() => _filterStatus = s),
              selectedColor: PharmaColors.emerald50,
              checkmarkColor: PharmaColors.emerald600,
              labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? PharmaColors.emerald600
                      : PharmaColors.textSecondary),
              side: BorderSide(
                  color: isActive
                      ? PharmaColors.emerald600
                      : PharmaColors.borderLight),
            ),
          );
        }),
      ]),
    );
  }

  String _resolveStatus(TrainingAssignment a) {
    if (a.status == 'cancelled' || a.status == 'superseded') {
      return 'cancelled';
    }
    if (a.status == 'completed') return 'completed';
    if (a.status == 'active' && a.dueDate.isBefore(DateTime.now())) {
      return 'overdue';
    }
    return 'active';
  }

  Widget _buildAssignmentCard(TrainingAssignment a) {
    final resolvedStatus = _resolveStatus(a);
    final courseName =
        a.courseVersion?.course?.title ?? 'Course #${a.courseVersionId}';
    final userName =
        '${a.user?.firstName ?? ''} ${a.user?.lastName ?? ''}'.trim();
    final assigneeName = userName.isNotEmpty ? userName : 'User #${a.userId}';
    final priority = a.priority;

    Color statusColor;
    String statusLabel;
    switch (resolvedStatus) {
      case 'active':
        statusColor = PharmaColors.info;
        statusLabel = 'ACTIVE';
        break;
      case 'overdue':
        statusColor = PharmaColors.danger;
        statusLabel = 'OVERDUE';
        break;
      case 'completed':
        statusColor = PharmaColors.emerald600;
        statusLabel = 'COMPLETED';
        break;
      case 'cancelled':
        statusColor = PharmaColors.gray500;
        statusLabel = 'CANCELLED';
        break;
      default:
        statusColor = PharmaColors.gray500;
        statusLabel = a.status.toUpperCase();
        break;
    }

    Color priorityColor;
    switch (priority) {
      case 'critical':
        priorityColor = PharmaColors.danger;
        break;
      case 'high':
        priorityColor = PharmaColors.warningText;
        break;
      default:
        priorityColor = PharmaColors.gray500;
        break;
    }

    final dueDateStr = DateFormat('MMM d, yyyy').format(a.dueDate);

    return GestureDetector(
      onTap: () => setState(() => _selectedAssignment = a),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(
              color: resolvedStatus == 'overdue'
                  ? PharmaColors.danger.withValues(alpha: 0.3)
                  : _selectedAssignment?.id == a.id
                      ? PharmaColors.emerald600
                      : PharmaColors.borderLight),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.person, size: 18, color: PharmaColors.textTertiary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courseName,
                      style: PharmaTypography.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text('Assigned to: $assigneeName',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary)),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: PharmaRadius.pillRadius),
              child: Text(statusLabel,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                      letterSpacing: 0.5)),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: PharmaRadius.pillRadius),
              child: Text(priority.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                      letterSpacing: 0.5)),
            ),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (a.reason != null && a.reason!.isNotEmpty)
                    Text('Reason: ${a.reason}',
                        style: PharmaTypography.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  Text(
                      'Source: ${a.source} · Assigned ${DateFormat('MMM d').format(a.assignedAt)}',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Due',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary)),
                  Text(dueDateStr,
                      style: PharmaTypography.bodyMedium.copyWith(
                          color: resolvedStatus == 'overdue'
                              ? PharmaColors.danger
                              : PharmaColors.textPrimary,
                          fontWeight: FontWeight.w500)),
                ]),
            const SizedBox(width: 12),
            if (resolvedStatus == 'active' || resolvedStatus == 'overdue')
              PopupMenuButton<String>(
                itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: 'extend', child: Text('Extend Deadline')),
                  const PopupMenuItem(
                      value: 'priority', child: Text('Change Priority')),
                  const PopupMenuItem(
                      value: 'cancel', child: Text('Cancel Assignment')),
                ],
                onSelected: (v) => _onAssignmentAction(v, a),
                icon: Icon(Icons.more_vert,
                    size: 18, color: PharmaColors.textTertiary),
              ),
          ]),
        ],
      ),
      ),
    );
  }

  // ─── ACTIONS ─────────────────────────────────────────────────────────────

  Future<void> _onAssignmentAction(
      String action, TrainingAssignment assignment) async {
    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null || assignment.id == null) return;

    switch (action) {
      case 'extend':
        await _showExtendDeadlineDialog(assignment, user!.id!);
        break;
      case 'priority':
        await _showChangePriorityDialog(assignment, user!.id!);
        break;
      case 'cancel':
        await _showCancelDialog(assignment, user!.id!);
        break;
    }
  }

  Future<void> _showExtendDeadlineDialog(
      TrainingAssignment assignment, int updatedById) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: assignment.dueDate.add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;

    try {
      await client.training.updateAssignment(
        assignmentId: assignment.id!,
        dueDate: picked,
        updatedById: updatedById,
      );
      ref.invalidate(_assignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deadline extended')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _showChangePriorityDialog(
      TrainingAssignment assignment, int updatedById) async {
    final priorities = ['critical', 'high', 'medium', 'low'];
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Change Priority'),
        children: priorities.map((p) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, p),
            child: Text(p[0].toUpperCase() + p.substring(1)),
          );
        }).toList(),
      ),
    );
    if (result == null || !mounted) return;

    try {
      await client.training.updateAssignment(
        assignmentId: assignment.id!,
        priority: result,
        updatedById: updatedById,
      );
      ref.invalidate(_assignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Priority changed to $result')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _showCancelDialog(
      TrainingAssignment assignment, int cancelledById) async {
    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Cancel Assignment'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This will cancel the assignment and any linked active enrollments.',
                style: PharmaTypography.body,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Cancellation Reason (required)',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(
                      borderRadius: PharmaRadius.inputRadius),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Keep')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Cancel Assignment'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final reason = reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cancellation reason is required')),
      );
      return;
    }

    try {
      await client.training.cancelAssignment(
        assignmentId: assignment.id!,
        cancelledById: cancelledById,
        reason: reason,
      );
      ref.invalidate(_assignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment cancelled')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  // ─── NEW ASSIGNMENT DIALOG ───────────────────────────────────────────────

  void _showNewAssignmentDialog() {
    showDialog(
      context: context,
      builder: (ctx) => _NewAssignmentDialog(
        onCreated: () => ref.invalidate(_assignmentsProvider),
        coursesAsync: ref.read(_orgCoursesProvider),
        usersAsync: ref.read(_orgUsersProvider),
        currentUserFuture: ref.read(currentUserProvider.future),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// NEW ASSIGNMENT DIALOG
// ═══════════════════════════════════════════════════════════════════════════════

class _NewAssignmentDialog extends StatefulWidget {
  const _NewAssignmentDialog({
    required this.onCreated,
    required this.coursesAsync,
    required this.usersAsync,
    required this.currentUserFuture,
  });

  final VoidCallback onCreated;
  final AsyncValue<List<Course>> coursesAsync;
  final AsyncValue<List<PharmaUser>> usersAsync;
  final Future<PharmaUser?> currentUserFuture;

  @override
  State<_NewAssignmentDialog> createState() => _NewAssignmentDialogState();
}

class _NewAssignmentDialogState extends State<_NewAssignmentDialog> {
  Course? _selectedCourse;
  CourseVersion? _selectedVersion;
  PharmaUser? _selectedUser;
  String _priority = 'medium';
  DateTime? _dueDate;
  String _reason = '';
  bool _submitting = false;
  List<CourseVersion> _versions = [];
  bool _loadingVersions = false;

  Future<void> _loadVersions(int courseId) async {
    setState(() => _loadingVersions = true);
    try {
      final versions = await client.course.getCourseVersions(courseId);
      if (mounted) {
        setState(() {
          _versions = versions;
          _selectedVersion = versions.isNotEmpty ? versions.first : null;
          _loadingVersions = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingVersions = false);
    }
  }

  Future<void> _submit() async {
    if (_selectedVersion == null ||
        _selectedUser == null ||
        _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      final currentUser = await widget.currentUserFuture;
      await client.training.assignTraining(
        userId: _selectedUser!.id!,
        courseVersionId: _selectedVersion!.id!,
        assignedById: currentUser!.id!,
        dueDate: _dueDate!,
        priority: _priority,
        reason: _reason.isNotEmpty ? _reason : null,
        source: 'manual',
        forceReassign: false,
      );
      widget.onCreated();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = widget.coursesAsync.valueOrNull ?? [];
    final users = widget.usersAsync.valueOrNull ?? [];

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PharmaRadius.xl)),
      title: const Text('New Training Assignment'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Course selection
            DropdownButtonFormField<Course>(
              initialValue: _selectedCourse,
              items: courses
                  .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(c.title,
                          overflow: TextOverflow.ellipsis)))
                  .toList(),
              onChanged: (c) {
                setState(() {
                  _selectedCourse = c;
                  _selectedVersion = null;
                  _versions = [];
                });
                if (c?.id != null) _loadVersions(c!.id!);
              },
              decoration: InputDecoration(
                labelText: 'Select Course *',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
              isExpanded: true,
            ),
            const SizedBox(height: 12),

            // Version selection
            if (_loadingVersions)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (_selectedCourse != null)
              DropdownButtonFormField<CourseVersion>(
                initialValue: _selectedVersion,
                items: _versions
                    .map((v) => DropdownMenuItem(
                        value: v,
                        child: Text(
                            'v${v.version} (${v.status})')))
                    .toList(),
                onChanged: (v) => setState(() => _selectedVersion = v),
                decoration: InputDecoration(
                  labelText: 'Select Version *',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(
                      borderRadius: PharmaRadius.inputRadius),
                ),
                isExpanded: true,
              ),
            const SizedBox(height: 12),

            // User selection
            DropdownButtonFormField<PharmaUser>(
              initialValue: _selectedUser,
              items: users
                  .where((u) => u.status == 'active')
                  .map((u) => DropdownMenuItem(
                      value: u,
                      child: Text(
                          '${u.firstName} ${u.lastName} (${u.email})',
                          overflow: TextOverflow.ellipsis)))
                  .toList(),
              onChanged: (u) => setState(() => _selectedUser = u),
              decoration: InputDecoration(
                labelText: 'Assign To *',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
              isExpanded: true,
            ),
            const SizedBox(height: 12),

            // Priority + Due Date
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _priority,
                  items: ['critical', 'high', 'medium', 'low']
                      .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                              p[0].toUpperCase() + p.substring(1))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _priority = v);
                  },
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    filled: true,
                    fillColor: PharmaColors.pageBg,
                    border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Due Date *',
                    hintText: _dueDate != null
                        ? DateFormat('MMM d, yyyy').format(_dueDate!)
                        : 'Select date',
                    suffixIcon:
                        const Icon(Icons.calendar_today, size: 16),
                    filled: true,
                    fillColor: PharmaColors.pageBg,
                    border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: _dueDate != null
                        ? DateFormat('MMM d, yyyy').format(_dueDate!)
                        : '',
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now().add(const Duration(days: 14)),
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => _dueDate = picked);
                    }
                  },
                ),
              ),
            ]),
            const SizedBox(height: 12),

            // Reason
            TextField(
              onChanged: (v) => _reason = v,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Reason (optional)',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          style:
              FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          child: _submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child:
                      CircularProgressIndicator(strokeWidth: 2, color: PharmaColors.cardBg))
              : const Text('Create Assignment'),
        ),
      ],
    );
  }
}
