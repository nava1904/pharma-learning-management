// ═══════════════════════════════════════════════════════════════════════════════
// VYUH LMS - Employee Dashboard V2
// ═══════════════════════════════════════════════════════════════════════════════
//
// FLAW AUDIT FIXES APPLIED:
// ─────────────────────────
// MA4: Data contradiction - Replaced 100% ring with labeled stat cards
// MA5: Missing urgency - Red banner for overdue/SOP updates
// MO1: Navigation visibility - Persistent breadcrumb
// MO3: Hero oversized - Compact, medium-emphasis card
// MO8: Redundant labeling - Single status source of truth
// MO9: Sidebar labels - Full text labels always visible
// MO10: Tab count indicators - (3), (2), (1) counts
// M1: Date format - Human readable "Mar 11, 2026"
// M2: Badge colors - Status-differentiated (red, amber, blue, green)
// M3: Enum display - Title case with spaces
// M4: Compliance ring removed - Explicit fraction "14/17 completed"
// M8: Focus state - Tab receives focus on navigation
// M9: Past due date indicator - Red text/icon for overdue
// M10: View details link - Obvious button affordance
//
// Design references:
// - Refactoring UI: Spacing scale, color hierarchy, visual weight
// - Don't Make Me Think: Clear navigation, obvious actions
// - Laws of UX: Fitts's Law (larger targets), Hick's Law (reduce choices)
// - Practical UI: Empty states, loading states, feedback
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/employee_portal_tokens.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';

/// Employee Dashboard V2 - Redesigned based on comprehensive flaw audit
/// Key changes:
/// - Urgency banner for overdue items (MA5)
/// - Labeled stat cards instead of confusing rings (MA4, M4)
/// - Compact hero card (MO3)
/// - Tab counts (MO10)
/// - Human-readable dates (M1)
class EmployeeDashboardScreenV2 extends ConsumerWidget {
  const EmployeeDashboardScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final complianceAsync = ref.watch(userComplianceProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final assignmentsAsync = ref.watch(assignmentsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);

    return AppShell(
      title: 'Employee Portal',
      icon: Icons.menu_book_rounded,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentUserProvider);
          ref.invalidate(userComplianceProvider);
          ref.invalidate(enrollmentsProvider);
          ref.invalidate(enrollmentResumeLabelsProvider);
          ref.invalidate(assignmentsProvider);
          ref.invalidate(certificatesProvider);
          ref.invalidate(recentActivityProvider);
          await Future.wait([
            ref.refresh(currentUserProvider.future),
            ref.refresh(userComplianceProvider.future),
            ref.refresh(enrollmentsProvider.future),
            ref.refresh(enrollmentResumeLabelsProvider.future),
            ref.refresh(assignmentsProvider.future),
            ref.refresh(certificatesProvider.future),
            ref.refresh(recentActivityProvider.future),
          ]);
          ref.read(employeeDashboardLastUpdatedProvider.notifier).state =
              DateTime.now();
        },
        child: userAsync.when(
          data: (user) {
            if (user == null || user.id == null) {
              return const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: EmptyState(
                  message: 'Employee user not found. Please sign in again.',
                  icon: Icons.person_off_rounded,
                ),
              );
            }
            return DefaultTabController(
              length: 3,
              child: _DashboardContent(
                user: user,
                userId: user.id!,
                complianceAsync: complianceAsync,
                enrollmentsAsync: enrollmentsAsync,
                resumeLabelsAsync: ref.watch(enrollmentResumeLabelsProvider),
                assignmentsAsync: assignmentsAsync,
                certificatesAsync: certificatesAsync,
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: EmployeePortalTokens.danger,
                ),
                const SizedBox(height: 16),
                Text(
                  'Unable to load dashboard',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: EmployeePortalTokens.textTertiary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(currentUserProvider),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent({
    required this.user,
    required this.userId,
    required this.complianceAsync,
    required this.enrollmentsAsync,
    required this.resumeLabelsAsync,
    required this.assignmentsAsync,
    required this.certificatesAsync,
  });

  final PharmaUser user;
  final int userId;
  final AsyncValue<UserComplianceMetrics?> complianceAsync;
  final AsyncValue<List<Enrollment>> enrollmentsAsync;
  final AsyncValue<Map<int, String>> resumeLabelsAsync;
  final AsyncValue<List<TrainingAssignment>> assignmentsAsync;
  final AsyncValue<List<Certificate>> certificatesAsync;

  /// Calculate urgent items count (overdue + SOP updates requiring acknowledgement)
  int _getUrgentCount(
    List<Enrollment> enrollments,
    List<TrainingAssignment> assignments,
  ) {
    final now = DateTime.now();
    int count = 0;

    // Count SOP updates requiring acknowledgement
    count += enrollments
        .where((e) =>
            e.retrainingChangeSummary != null &&
            e.retrainingChangeSummary!.isNotEmpty &&
            e.acknowledgedAt == null)
        .length;

    // Count overdue items
    for (final e in enrollments) {
      if (e.status == 'completed') continue;
      final assignment = assignments
          .where((a) => a.courseVersionId == e.courseVersionId && a.userId == userId)
          .firstOrNull;
      if (assignment != null && assignment.dueDate.isBefore(now)) {
        // Don't double-count if it's also an SOP update
        if (e.retrainingChangeSummary == null ||
            e.retrainingChangeSummary!.isEmpty ||
            e.acknowledgedAt != null) {
          count++;
        }
      }
    }

    return count;
  }

  /// Get hero "Up Next" priority: (1) SOP retraining, (2) Overdue, (3) Closest due
  ({Enrollment? enrollment, String? badge, bool isUrgent}) _getUpNext(
    List<Enrollment> enrollments,
    List<TrainingAssignment> assignments,
  ) {
    final now = DateTime.now();

    // Priority 1: SOP retraining requiring acknowledgement
    final retraining = enrollments
        .where((e) =>
            e.retrainingChangeSummary != null &&
            e.retrainingChangeSummary!.isNotEmpty &&
            e.acknowledgedAt == null)
        .toList();
    if (retraining.isNotEmpty) {
      final withAssign = retraining.map((e) {
        final a = assignments
            .where((a) => a.courseVersionId == e.courseVersionId && a.userId == userId)
            .firstOrNull;
        return (e: e, due: a?.dueDate ?? now.add(const Duration(days: 365)));
      }).toList();
      withAssign.sort((a, b) => a.due.compareTo(b.due));
      return (enrollment: withAssign.first.e, badge: 'SOP Update', isUrgent: true);
    }

    // Priority 2: Overdue in-progress
    final inProgress = enrollments.where((e) => e.status == 'in_progress').toList();
    final overdueInProgress = inProgress.map((e) {
      final a = assignments
          .where((a) => a.courseVersionId == e.courseVersionId && a.userId == userId)
          .firstOrNull;
      return (e: e, due: a?.dueDate ?? now);
    }).where((x) => x.due.isBefore(now)).toList();
    if (overdueInProgress.isNotEmpty) {
      overdueInProgress.sort((a, b) => a.due.compareTo(b.due));
      return (enrollment: overdueInProgress.first.e, badge: 'Overdue', isUrgent: true);
    }

    // Priority 3: Closest due date (not started or in progress)
    final toDo = enrollments
        .where((e) => e.status != 'in_progress' && e.status != 'completed')
        .toList();
    if (toDo.isEmpty && inProgress.isEmpty) {
      return (enrollment: null, badge: null, isUrgent: false);
    }
    final toDoWithDue = (toDo.isEmpty ? inProgress : toDo).map((e) {
      final a = assignments
          .where((a) => a.courseVersionId == e.courseVersionId && a.userId == userId)
          .firstOrNull;
      return (e: e, due: a?.dueDate ?? now.add(const Duration(days: 365)));
    }).toList();
    toDoWithDue.sort((a, b) => a.due.compareTo(b.due));
    final first = toDoWithDue.first;
    final isOverdue = first.due.isBefore(now);
    return (
      enrollment: first.e,
      badge: isOverdue ? 'Overdue' : null,
      isUrgent: isOverdue,
    );
  }

  List<Enrollment> _sortByDue(
    List<Enrollment> list,
    List<TrainingAssignment> assignments,
  ) {
    final now = DateTime.now();
    final withDue = list.map((e) {
      final a = assignments
          .where((a) => a.courseVersionId == e.courseVersionId && a.userId == userId)
          .firstOrNull;
      final due = a?.dueDate ?? now.add(const Duration(days: 365));
      return (e: e, due: due);
    }).toList();
    withDue.sort((a, b) {
      final aOverdue = a.due.isBefore(now);
      final bOverdue = b.due.isBefore(now);
      if (aOverdue != bOverdue) return aOverdue ? -1 : 1;
      return a.due.compareTo(b.due);
    });
    return withDue.map((x) => x.e).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = assignmentsAsync.valueOrNull ?? [];
    final enrollments = enrollmentsAsync.valueOrNull ?? [];
    final resumeLabels = resumeLabelsAsync.valueOrNull ?? {};
    final allCertificates = certificatesAsync.valueOrNull ?? [];
    final compliance = complianceAsync.valueOrNull;

    final inProgressList =
        enrollments.where((e) => e.status == 'in_progress').toList();
    final toDoList = enrollments
        .where((e) => e.status != 'in_progress' && e.status != 'completed')
        .toList();
    final completedList =
        enrollments.where((e) => e.status == 'completed').toList();

    final upNext = _getUpNext(enrollments, assignments);
    final urgentCount = _getUrgentCount(enrollments, assignments);
    final sortedInProgress = _sortByDue(inProgressList, assignments);
    final sortedToDo = _sortByDue(toDoList, assignments);
    final sortedCompleted = _sortByDue(completedList, assignments);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          // FIX MA5: Urgency banner for overdue/SOP items
          if (urgentCount > 0)
            SliverToBoxAdapter(
              child: _UrgencyBanner(
                urgentCount: urgentCount,
                onTap: () {
                  // Focus the "To Do" tab which contains urgent items
                  DefaultTabController.of(context).animateTo(1);
                },
              ),
            ),

          // Header: Welcome + Stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: EmployeePortalTokens.brandPrimaryLight,
                        child: Text(
                          (user.firstName.isNotEmpty
                                  ? user.firstName[0]
                                  : user.email[0])
                              .toUpperCase(),
                          style: TextStyle(
                            color: EmployeePortalTokens.brandPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back,',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: EmployeePortalTokens.textTertiary,
                                  ),
                            ),
                            Text(
                              user.firstName.isNotEmpty
                                  ? user.firstName
                                  : user.email.split('@').first,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: EmployeePortalTokens.textPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // FIX MA4, M4: Labeled stat cards instead of 100% ring
                  _StatCards(
                    compliance: compliance,
                    inProgressCount: inProgressList.length,
                    toDoCount: toDoList.length,
                    completedCount: completedList.length,
                  ),
                ],
              ),
            ),
          ),

          // FIX MO3: Compact hero card
          if (upNext.enrollment != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _CompactHeroCard(
                  enrollment: upNext.enrollment!,
                  badge: upNext.badge,
                  isUrgent: upNext.isUrgent,
                  userId: userId,
                  assignments: assignments,
                  resumeLabels: resumeLabels,
                  onRetrainingTap: (e) => _showRetrainingDialog(context, ref, e),
                  onStartResumeTap: (e) => _openCourse(context, e),
                ),
              ),
            ),

          // FIX MO10: Tabs with counts
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: TabBar(
                  labelColor: EmployeePortalTokens.brandPrimary,
                  unselectedLabelColor: EmployeePortalTokens.textTertiary,
                  indicatorColor: EmployeePortalTokens.brandPrimary,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(text: 'In Progress (${sortedInProgress.length})'),
                    Tab(text: 'To Do (${sortedToDo.length})'),
                    Tab(text: 'Completed (${sortedCompleted.length})'),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        children: [
          _EnrollmentList(
            enrollments: sortedInProgress,
            userId: userId,
            assignments: assignments,
            resumeLabels: resumeLabels,
            allCertificates: allCertificates,
            emptyHeadline: 'No courses in progress',
            emptySubtext: 'Start a course from the "To Do" tab.',
            onRetrainingTap: (e) => _showRetrainingDialog(context, ref, e),
            onCourseTap: (e) => _openCourse(context, e),
          ),
          _EnrollmentList(
            enrollments: sortedToDo,
            userId: userId,
            assignments: assignments,
            resumeLabels: resumeLabels,
            allCertificates: allCertificates,
            emptyHeadline: 'All caught up!',
            emptySubtext: 'No pending assignments. Great work!',
            onRetrainingTap: (e) => _showRetrainingDialog(context, ref, e),
            onCourseTap: (e) => _openCourse(context, e),
          ),
          _EnrollmentList(
            enrollments: sortedCompleted,
            userId: userId,
            assignments: assignments,
            resumeLabels: resumeLabels,
            allCertificates: allCertificates,
            emptyHeadline: 'No completed courses yet',
            emptySubtext: 'Your completed training will appear here.',
            onRetrainingTap: (e) => _showRetrainingDialog(context, ref, e),
            onCourseTap: (e) => _openCourse(context, e),
            showViewHistoryButton: true,
          ),
        ],
      ),
    );
  }

  void _showRetrainingDialog(
    BuildContext context,
    WidgetRef ref,
    Enrollment enrollment,
  ) {
    final enrollmentId = enrollment.id;
    if (enrollmentId == null) return;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _RetrainingDialog(
        enrollment: enrollment,
        userId: userId,
        onSuccess: () {
          Navigator.of(ctx).pop();
          ref.invalidate(enrollmentsProvider);
          _openCourse(context, enrollment);
        },
      ),
    );
  }

  void _openCourse(BuildContext context, Enrollment enrollment) {
    if (enrollment.status == 'completed') return;
    final courseVersionId = enrollment.courseVersionId;
    final enrollmentId = enrollment.id;
    if (enrollmentId == null) return;

    client.course.getCourseVersion(courseVersionId).then((version) {
      final courseId = version?.courseId;
      if (courseId == null) return;
      if (!context.mounted) return;
      context.push(
        '/course/$courseId?enrollmentId=$enrollmentId',
        extra: {'userId': userId},
      );
    });
  }
}

/// FIX MA5: Red urgency banner for overdue items
class _UrgencyBanner extends StatelessWidget {
  const _UrgencyBanner({
    required this.urgentCount,
    required this.onTap,
  });

  final int urgentCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EmployeePortalTokens.danger,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: EmployeePortalTokens.neutral0,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$urgentCount item${urgentCount == 1 ? '' : 's'} require${urgentCount == 1 ? 's' : ''} immediate attention',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: EmployeePortalTokens.neutral0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: EmployeePortalTokens.neutral0,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// FIX MA4, M4: Labeled stat cards replacing misleading percentage ring
class _StatCards extends StatelessWidget {
  const _StatCards({
    required this.compliance,
    required this.inProgressCount,
    required this.toDoCount,
    required this.completedCount,
  });

  final UserComplianceMetrics? compliance;
  final int inProgressCount;
  final int toDoCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    // Calculate compliance display value
    // Using totalCertificates - overdueCount as "completed"
    final completedTrainings = compliance != null
        ? (compliance!.totalCertificates - compliance!.overdueCount)
            .clamp(0, compliance!.totalCertificates)
        : 0;
    final totalTrainings = compliance?.totalCertificates ?? 0;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Compliance',
            value: compliance != null ? '$completedTrainings/$totalTrainings' : '—',
            subtext: 'completed',
            color: compliance?.compliant == true
                ? EmployeePortalTokens.success
                : EmployeePortalTokens.danger,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'In Progress',
            value: '$inProgressCount',
            subtext: 'courses',
            color: EmployeePortalTokens.brandPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'To Do',
            value: '$toDoCount',
            subtext: 'assigned',
            color: toDoCount > 0
                ? EmployeePortalTokens.warning
                : EmployeePortalTokens.neutral400,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.subtext,
    required this.color,
  });

  final String label;
  final String value;
  final String subtext;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EmployeePortalTokens.neutral0,
        borderRadius: BorderRadius.circular(EmployeePortalTokens.radiusLg),
        border: Border.all(color: EmployeePortalTokens.neutral200),
        boxShadow: EmployeePortalTokens.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: EmployeePortalTokens.textTertiary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
          ),
          Text(
            subtext,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: EmployeePortalTokens.textQuaternary,
                ),
          ),
        ],
      ),
    );
  }
}

/// FIX MO3: Compact hero card (medium-emphasis, not giant)
class _CompactHeroCard extends StatelessWidget {
  const _CompactHeroCard({
    required this.enrollment,
    required this.badge,
    required this.isUrgent,
    required this.userId,
    required this.assignments,
    required this.resumeLabels,
    required this.onRetrainingTap,
    required this.onStartResumeTap,
  });

  final Enrollment enrollment;
  final String? badge;
  final bool isUrgent;
  final int userId;
  final List<TrainingAssignment> assignments;
  final Map<int, String> resumeLabels;
  final void Function(Enrollment) onRetrainingTap;
  final void Function(Enrollment) onStartResumeTap;

  @override
  Widget build(BuildContext context) {
    final assignment = assignments
        .where((a) =>
            a.courseVersionId == enrollment.courseVersionId && a.userId == userId)
        .firstOrNull;
    final title = enrollment.courseVersion?.course?.title ??
        'Course v${enrollment.courseVersion?.version ?? '?'}';

    // FIX M1: Human-readable date format
    final dueDate = assignment?.dueDate;
    final isOverdue = dueDate != null && dueDate.isBefore(DateTime.now());
    final dueDateStr = dueDate?.toHumanDate();

    final isRetraining = enrollment.retrainingChangeSummary != null &&
        enrollment.retrainingChangeSummary!.isNotEmpty &&
        enrollment.acknowledgedAt == null;

    final resumeLabel =
        enrollment.id != null ? resumeLabels[enrollment.id!] : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isUrgent
            ? EmployeePortalTokens.dangerLight
            : EmployeePortalTokens.brandPrimaryLight,
        borderRadius: BorderRadius.circular(EmployeePortalTokens.radiusLg),
        border: Border.all(
          color: isUrgent
              ? EmployeePortalTokens.danger.withValues(alpha: 0.3)
              : EmployeePortalTokens.brandPrimary.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isRetraining) {
              onRetrainingTap(enrollment);
            } else {
              onStartResumeTap(enrollment);
            }
          },
          borderRadius: BorderRadius.circular(EmployeePortalTokens.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isUrgent
                        ? EmployeePortalTokens.danger
                        : EmployeePortalTokens.brandPrimary,
                    borderRadius:
                        BorderRadius.circular(EmployeePortalTokens.radiusMd),
                  ),
                  child: Icon(
                    isRetraining
                        ? Icons.update_rounded
                        : Icons.play_arrow_rounded,
                    color: EmployeePortalTokens.neutral0,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge and "Up Next" label
                      Row(
                        children: [
                          Text(
                            'Up Next',
                            style:
                                Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: EmployeePortalTokens.textTertiary,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: 8),
                            // FIX M2: Status-differentiated badge colors
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: isUrgent
                                    ? EmployeePortalTokens.danger
                                    : EmployeePortalTokens.warning,
                                borderRadius: BorderRadius.circular(
                                    EmployeePortalTokens.radiusFull),
                              ),
                              child: Text(
                                badge!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: EmployeePortalTokens.neutral0,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Title
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: EmployeePortalTokens.textPrimary,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Due date and resume label
                      Row(
                        children: [
                          if (dueDateStr != null) ...[
                            // FIX M9: Red text for overdue
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 12,
                              color: isOverdue
                                  ? EmployeePortalTokens.danger
                                  : EmployeePortalTokens.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Due $dueDateStr',
                              style:
                                  Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: isOverdue
                                            ? EmployeePortalTokens.danger
                                            : EmployeePortalTokens.textTertiary,
                                        fontWeight: isOverdue
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                            ),
                          ],
                          if (resumeLabel != null && resumeLabel.isNotEmpty) ...[
                            if (dueDateStr != null)
                              const SizedBox(width: 12),
                            Icon(
                              Icons.bookmark_outline_rounded,
                              size: 12,
                              color: EmployeePortalTokens.teal,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                resumeLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: EmployeePortalTokens.teal,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Arrow
                Icon(
                  Icons.arrow_forward_rounded,
                  color: isUrgent
                      ? EmployeePortalTokens.danger
                      : EmployeePortalTokens.brandPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Enrollment list with course cards
class _EnrollmentList extends StatelessWidget {
  const _EnrollmentList({
    required this.enrollments,
    required this.userId,
    required this.assignments,
    required this.resumeLabels,
    required this.allCertificates,
    required this.emptyHeadline,
    required this.emptySubtext,
    required this.onRetrainingTap,
    required this.onCourseTap,
    this.showViewHistoryButton = false,
  });

  final List<Enrollment> enrollments;
  final int userId;
  final List<TrainingAssignment> assignments;
  final Map<int, String> resumeLabels;
  final List<Certificate> allCertificates;
  final String emptyHeadline;
  final String emptySubtext;
  final void Function(Enrollment) onRetrainingTap;
  final void Function(Enrollment) onCourseTap;
  final bool showViewHistoryButton;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: enrollments.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: EmptyState(
                      headline: emptyHeadline,
                      subtext: emptySubtext,
                      icon: Icons.menu_book_rounded,
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final e = enrollments[index];
                      return _CourseListItem(
                        enrollment: e,
                        userId: userId,
                        assignments: assignments,
                        resumeLabels: resumeLabels,
                        allCertificates: allCertificates,
                        onRetrainingTap: onRetrainingTap,
                        onCourseTap: onCourseTap,
                      );
                    },
                    childCount: enrollments.length,
                  ),
                ),
        ),
        // FIX M10: View details button for completed tab
        if (showViewHistoryButton && enrollments.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: OutlinedButton.icon(
                onPressed: () => context.push('/employee/training-history'),
                icon: const Icon(Icons.history_rounded, size: 18),
                label: const Text('View Full Training History'),
              ),
            ),
          ),
      ],
    );
  }
}

/// FIX M1, M2, M3, M9: Course list item with proper formatting
class _CourseListItem extends StatelessWidget {
  const _CourseListItem({
    required this.enrollment,
    required this.userId,
    required this.assignments,
    required this.resumeLabels,
    required this.allCertificates,
    required this.onRetrainingTap,
    required this.onCourseTap,
  });

  final Enrollment enrollment;
  final int userId;
  final List<TrainingAssignment> assignments;
  final Map<int, String> resumeLabels;
  final List<Certificate> allCertificates;
  final void Function(Enrollment) onRetrainingTap;
  final void Function(Enrollment) onCourseTap;

  @override
  Widget build(BuildContext context) {
    final assignment = assignments
        .where((a) =>
            a.courseVersionId == enrollment.courseVersionId && a.userId == userId)
        .firstOrNull;
    final title = enrollment.courseVersion?.course?.title ??
        'Course v${enrollment.courseVersion?.version ?? '?'}';

    // FIX M1: Human-readable date
    final dueDate = assignment?.dueDate;
    final isOverdue = dueDate != null &&
        dueDate.isBefore(DateTime.now()) &&
        enrollment.status != 'completed';
    final dueDateStr = dueDate?.toHumanDate();

    // FIX M3: Title case status
    final status = _formatStatus(enrollment.status);

    // Check for SOP update
    final needsAck = enrollment.retrainingChangeSummary != null &&
        enrollment.retrainingChangeSummary!.isNotEmpty &&
        enrollment.acknowledgedAt == null;

    // Get certificate if completed
    Certificate? cert;
    if (enrollment.status == 'completed') {
      for (final c in allCertificates) {
        if (c.courseVersionId == enrollment.courseVersionId &&
            c.userId == enrollment.userId) {
          cert = c;
          break;
        }
      }
    }

    final resumeLabel =
        enrollment.id != null ? resumeLabels[enrollment.id!] : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: EmployeePortalTokens.neutral0,
          borderRadius: BorderRadius.circular(EmployeePortalTokens.radiusLg),
          border: Border.all(
            color: isOverdue || needsAck
                ? EmployeePortalTokens.danger.withValues(alpha: 0.3)
                : EmployeePortalTokens.neutral200,
          ),
          boxShadow: EmployeePortalTokens.shadowSm,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (enrollment.status == 'completed' && cert?.id != null) {
                context.push('/certificate/${cert!.id}');
              } else if (needsAck) {
                onRetrainingTap(enrollment);
              } else {
                onCourseTap(enrollment);
              }
            },
            borderRadius: BorderRadius.circular(EmployeePortalTokens.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status indicator
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getStatusColor(enrollment.status, isOverdue, needsAck)
                          .withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(EmployeePortalTokens.radiusMd),
                    ),
                    child: Icon(
                      _getStatusIcon(enrollment.status, needsAck),
                      color: _getStatusColor(enrollment.status, isOverdue, needsAck),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: EmployeePortalTokens.textPrimary,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Meta row
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            // FIX M2: Status badge with appropriate color
                            _StatusBadge(
                              status: needsAck ? 'SOP Update' : status,
                              isUrgent: isOverdue || needsAck,
                              isCompleted: enrollment.status == 'completed',
                            ),
                            // FIX M9: Due date with red for overdue
                            if (dueDateStr != null &&
                                enrollment.status != 'completed')
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 12,
                                    color: isOverdue
                                        ? EmployeePortalTokens.danger
                                        : EmployeePortalTokens.textTertiary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    dueDateStr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: isOverdue
                                              ? EmployeePortalTokens.danger
                                              : EmployeePortalTokens.textTertiary,
                                          fontWeight: isOverdue
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        // Resume label
                        if (resumeLabel != null && resumeLabel.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.bookmark_outline_rounded,
                                size: 12,
                                color: EmployeePortalTokens.teal,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  resumeLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: EmployeePortalTokens.teal,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // CTA
                  Text(
                    enrollment.status == 'completed'
                        ? 'View'
                        : (enrollment.status == 'in_progress'
                            ? 'Continue'
                            : 'Start'),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: EmployeePortalTokens.brandPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: EmployeePortalTokens.brandPrimary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // FIX M3: Format status as title case with spaces
  String _formatStatus(String status) {
    return status
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join(' ');
  }

  Color _getStatusColor(String status, bool isOverdue, bool needsAck) {
    if (needsAck || isOverdue) return EmployeePortalTokens.danger;
    switch (status) {
      case 'completed':
        return EmployeePortalTokens.success;
      case 'in_progress':
        return EmployeePortalTokens.brandPrimary;
      default:
        return EmployeePortalTokens.neutral500;
    }
  }

  IconData _getStatusIcon(String status, bool needsAck) {
    if (needsAck) return Icons.update_rounded;
    switch (status) {
      case 'completed':
        return Icons.check_circle_rounded;
      case 'in_progress':
        return Icons.play_circle_rounded;
      default:
        return Icons.circle_outlined;
    }
  }
}

/// FIX M2: Status badge with differentiated colors
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
    required this.isUrgent,
    required this.isCompleted,
  });

  final String status;
  final bool isUrgent;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final Color bgColor;
    final Color textColor;

    if (isUrgent) {
      bgColor = EmployeePortalTokens.dangerLight;
      textColor = EmployeePortalTokens.danger;
    } else if (isCompleted) {
      bgColor = EmployeePortalTokens.successLight;
      textColor = EmployeePortalTokens.success;
    } else if (status == 'In Progress') {
      bgColor = EmployeePortalTokens.brandPrimaryLight;
      textColor = EmployeePortalTokens.brandPrimary;
    } else {
      bgColor = EmployeePortalTokens.neutral100;
      textColor = EmployeePortalTokens.textTertiary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(EmployeePortalTokens.radiusFull),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

/// Sticky tab bar delegate
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabBarDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) => false;
}

/// Retraining acknowledgement dialog
class _RetrainingDialog extends StatefulWidget {
  const _RetrainingDialog({
    required this.enrollment,
    required this.userId,
    required this.onSuccess,
  });

  final Enrollment enrollment;
  final int userId;
  final VoidCallback onSuccess;

  @override
  State<_RetrainingDialog> createState() => _RetrainingDialogState();
}

class _RetrainingDialogState extends State<_RetrainingDialog> {
  List<SignatureMeaning> _meanings = [];
  String? _selectedMeaning;
  final _passwordController = TextEditingController();
  bool _loading = true;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMeanings();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadMeanings() async {
    try {
      final meanings = await client.training.listSignatureMeanings();
      if (mounted) {
        setState(() {
          _meanings = meanings;
          _selectedMeaning = meanings.isNotEmpty
              ? meanings.first.meaning
              : 'I have read and understood';
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _meanings = [];
          _selectedMeaning = 'I have read and understood';
          _loading = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Password is required for re-authentication.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await client.training.acknowledgeRetraining(
        enrollmentId: widget.enrollment.id!,
        userId: widget.userId,
        signatureMeaning: _selectedMeaning ?? 'I have read and understood',
        passwordPlaintext: password,
      );
      if (mounted) widget.onSuccess();
    } catch (e) {
      if (mounted) {
        setState(() {
          _submitting = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary =
        widget.enrollment.retrainingChangeSummary ?? 'SOP has been updated.';
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.update_rounded,
            color: EmployeePortalTokens.danger,
            size: 24,
          ),
          const SizedBox(width: 12),
          const Text('SOP Update'),
        ],
      ),
      content: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'This course has been updated. Please review the changes below and acknowledge before continuing.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: EmployeePortalTokens.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: EmployeePortalTokens.warningLight,
                      borderRadius:
                          BorderRadius.circular(EmployeePortalTokens.radiusMd),
                      border: Border.all(
                        color: EmployeePortalTokens.warning.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change Summary',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: EmployeePortalTokens.textSecondary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          summary,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_meanings.isNotEmpty)
                    DropdownButtonFormField<String>(
                      initialValue: _selectedMeaning,
                      decoration: const InputDecoration(
                        labelText: 'Signature meaning',
                        border: OutlineInputBorder(),
                      ),
                      items: _meanings
                          .map((m) => DropdownMenuItem(
                                value: m.meaning,
                                child: Text(m.meaning),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedMeaning = v),
                    ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password (re-authentication)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: EmployeePortalTokens.dangerLight,
                        borderRadius:
                            BorderRadius.circular(EmployeePortalTokens.radiusMd),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: EmployeePortalTokens.danger,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: TextStyle(
                                color: EmployeePortalTokens.danger,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submitting || _loading ? null : _submit,
          icon: _submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.check_rounded, size: 18),
          label: Text(_submitting ? 'Signing...' : 'Acknowledge & Begin'),
        ),
      ],
    );
  }
}
