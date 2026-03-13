import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/compliance_gauge.dart';
import '../../widgets/course_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';

/// Employee dashboard with Coursera/Udemy-style layout: welcome row + compliance
/// gauge, hero "Up Next" card, sticky tabs (In Progress / To Do / Completed), and
/// responsive course grids. All data from Riverpod providers and [client]; no mock data.
class EmployeeDashboardScreen extends ConsumerWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final complianceAsync = ref.watch(userComplianceProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final assignmentsAsync = ref.watch(assignmentsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);
    final recentActivityAsync = ref.watch(recentActivityProvider);

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
                  message: 'Employee user not found. Run seed first.',
                  icon: Icons.person_off_rounded,
                ),
              );
            }
            return DefaultTabController(
              length: 3,
              child: _EmployeeDashboardContent(
                user: user,
                userId: user.id!,
                complianceAsync: complianceAsync,
                enrollmentsAsync: enrollmentsAsync,
                resumeLabelsAsync: ref.watch(enrollmentResumeLabelsProvider),
                assignmentsAsync: assignmentsAsync,
                certificatesAsync: certificatesAsync,
                recentActivityAsync: recentActivityAsync,
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $e', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(currentUserProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmployeeDashboardContent extends ConsumerWidget {
  const _EmployeeDashboardContent({
    required this.user,
    required this.userId,
    required this.complianceAsync,
    required this.enrollmentsAsync,
    required this.resumeLabelsAsync,
    required this.assignmentsAsync,
    required this.certificatesAsync,
    required this.recentActivityAsync,
  });

  final PharmaUser user;
  final int userId;
  final AsyncValue<UserComplianceMetrics?> complianceAsync;
  final AsyncValue<List<Enrollment>> enrollmentsAsync;
  final AsyncValue<Map<int, String>> resumeLabelsAsync;
  final AsyncValue<List<TrainingAssignment>> assignmentsAsync;
  final AsyncValue<List<Certificate>> certificatesAsync;
  final AsyncValue<List<Map<String, dynamic>>> recentActivityAsync;

  /// Hero "Up Next" priority: (1) Unacknowledged SOP retraining, (2) Overdue in_progress
  /// (by assignment dueDate), (3) Closest due not_started. Uses [enrollmentsProvider]
  /// and [assignmentsProvider] only.
  ({Enrollment? enrollment, String? badge}) _getUpNext(
    List<Enrollment> enrollments,
    List<TrainingAssignment> assignments,
  ) {
    final now = DateTime.now();

    final retraining = enrollments.where((e) =>
        e.retrainingChangeSummary != null &&
        e.retrainingChangeSummary!.isNotEmpty &&
        e.acknowledgedAt == null).toList();
    if (retraining.isNotEmpty) {
      final withAssign = retraining.map((e) {
        final a = assignments.where((a) =>
            a.courseVersionId == e.courseVersionId && a.userId == userId).firstOrNull;
        return (e: e, due: a?.dueDate ?? now.add(const Duration(days: 365)));
      }).toList();
      withAssign.sort((a, b) => a.due.compareTo(b.due));
      return (enrollment: withAssign.first.e, badge: 'SOP UPDATE - ACTION REQUIRED');
    }

    final inProgress = enrollments.where((e) => e.status == 'in_progress').toList();
    final overdueInProgress = inProgress.map((e) {
      final a = assignments.where((a) =>
          a.courseVersionId == e.courseVersionId && a.userId == userId).firstOrNull;
      return (e: e, due: a?.dueDate ?? now);
    }).where((x) => x.due.isBefore(now)).toList();
    if (overdueInProgress.isNotEmpty) {
      overdueInProgress.sort((a, b) => a.due.compareTo(b.due));
      return (enrollment: overdueInProgress.first.e, badge: 'OVERDUE');
    }

    final toDo = enrollments.where((e) =>
        e.status != 'in_progress' && e.status != 'completed').toList();
    if (toDo.isEmpty && inProgress.isEmpty) return (enrollment: null, badge: null);
    final toDoWithDue = (toDo.isEmpty ? inProgress : toDo).map((e) {
      final a = assignments.where((a) =>
          a.courseVersionId == e.courseVersionId && a.userId == userId).firstOrNull;
      return (e: e, due: a?.dueDate ?? now.add(const Duration(days: 365)));
    }).toList();
    toDoWithDue.sort((a, b) => a.due.compareTo(b.due));
    final first = toDoWithDue.first;
    final isOverdue = first.due.isBefore(now);
    return (
      enrollment: first.e,
      badge: isOverdue ? 'OVERDUE' : null,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = assignmentsAsync.valueOrNull ?? [];
    final enrollments = enrollmentsAsync.valueOrNull ?? [];
    final resumeLabels = resumeLabelsAsync.valueOrNull ?? {};
    final allCertificates = certificatesAsync.valueOrNull ?? [];
    final certificates = allCertificates
        .where((c) => (c.status ?? 'active') != 'obsolete')
        .toList();

    final inProgressList = enrollments.where((e) => e.status == 'in_progress').toList();
    final toDoList = enrollments.where((e) =>
        e.status != 'in_progress' && e.status != 'completed').toList();
    final completedList = enrollments.where((e) => e.status == 'completed').toList();

    final upNext = _getUpNext(enrollments, assignments);
    final sortedInProgress = _sortByDue(inProgressList, assignments, userId);
    final sortedToDo = _sortByDue(toDoList, assignments, userId);
    final sortedCompleted = _sortByDue(completedList, assignments, userId);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome,',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.slate600,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.firstName.isNotEmpty
                              ? user.firstName
                              : (user.email.split('@').first),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.slate900,
                              ),
                        ),
                      ],
                    ),
                  ),
                  complianceAsync.when(
                    data: (c) {
                      if (c == null) return const SizedBox.shrink();
                      final rate = c.complianceRate.clamp(0.0, 100.0);
                      return ComplianceGauge(
                        percentage: rate,
                        size: 60,
                        strokeWidth: 5,
                        showValue: true,
                      );
                    },
                    loading: () => const SizedBox(width: 60, height: 60),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _HeroCourseCard(
                  enrollment: upNext.enrollment,
                  badge: upNext.badge,
                  userId: userId,
                  assignments: assignments,
                  resumeLabels: resumeLabels,
                  allCertificates: allCertificates,
                  onRetrainingTap: (e) => _showRetrainingAcknowledgementDialog(
                    context,
                    ref,
                    e,
                    userId,
                  ),
                  onStartResumeTap: (e) => _openCourse(context, e, userId),
                ),
              ),
            ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: TabBar(
                  labelColor: AppColors.indigo600,
                  unselectedLabelColor: AppColors.slate600,
                  indicatorColor: AppColors.indigo600,
                  tabs: const [
                    Tab(text: 'In Progress'),
                    Tab(text: 'To Do'),
                    Tab(text: 'Completed'),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
          children: [
            _EnrollmentListTab(
              enrollments: sortedInProgress,
              userId: userId,
              assignments: assignments,
              resumeLabels: resumeLabels,
              allCertificates: allCertificates,
              emptyHeadline: 'No courses in progress',
              emptySubtext: 'Start one from the To Do tab.',
              onRetrainingTap: (e) => _showRetrainingAcknowledgementDialog(
                context,
                ref,
                e,
                userId,
              ),
              onCourseTap: (e) => _openCourse(context, e, userId),
              extraSlivers: [
                _buildRecentActivitySliver(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => context.push('/employee/training-history'),
                          icon: const Icon(Icons.history_rounded, size: 18),
                          label: const Text('View History'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _EnrollmentListTab(
              enrollments: sortedToDo,
              userId: userId,
              assignments: assignments,
              resumeLabels: resumeLabels,
              allCertificates: allCertificates,
              emptyHeadline: 'You are fully caught up!',
              emptySubtext: 'No new assignments right now.',
              onRetrainingTap: (e) => _showRetrainingAcknowledgementDialog(
                context,
                ref,
                e,
                userId,
              ),
              onCourseTap: (e) => _openCourse(context, e, userId),
            ),
            _EnrollmentListTab(
              enrollments: sortedCompleted,
              userId: userId,
              assignments: assignments,
              resumeLabels: resumeLabels,
              allCertificates: allCertificates,
              emptyHeadline: 'No completed courses yet',
              emptySubtext: 'Your completed trainings will appear here.',
              onRetrainingTap: (e) => _showRetrainingAcknowledgementDialog(
                context,
                ref,
                e,
                userId,
              ),
              onCourseTap: (e) => _openCourse(context, e, userId),
            ),
          ],
        ),
    );
  }

  List<Enrollment> _sortByDue(
    List<Enrollment> list,
    List<TrainingAssignment> assignments,
    int userId,
  ) {
    final now = DateTime.now();
    final withDue = list.map((e) {
      final a = assignments.where((a) =>
          a.courseVersionId == e.courseVersionId && a.userId == userId).firstOrNull;
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

  Widget _buildRecentActivitySliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: recentActivityAsync.when(
        data: (activities) {
          if (activities.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  icon: Icons.history,
                  title: 'Recent Activity',
                  color: AppColors.slate600,
                ),
                const SizedBox(height: 12),
                ...activities.take(5).map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.history, size: 16, color: AppColors.slate500),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${a['action'] ?? 'Activity'}${a['courseTitle'] != null ? ' - ${a['courseTitle']}' : ''}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          if (a['timestamp'] != null)
                            Text(
                              _formatActivityTime(a['timestamp']),
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.slate500,
                                  ),
                            ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  String _formatActivityTime(dynamic ts) {
    if (ts == null) return '';
    if (ts is String) {
      try {
        final dt = DateTime.tryParse(ts);
        if (dt != null) {
          final now = DateTime.now();
          final diff = now.difference(dt);
          if (diff.inDays > 0) return '${diff.inDays}d ago';
          if (diff.inHours > 0) return '${diff.inHours}h ago';
          if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
          return 'Just now';
        }
      } catch (_) {}
    }
    return ts.toString();
  }

  /// Retraining gate: show modal; on submit call [client.training.acknowledgeRetraining]
  /// then navigate to course.
  void _showRetrainingAcknowledgementDialog(
    BuildContext context,
    WidgetRef ref,
    Enrollment enrollment,
    int userId,
  ) {
    final courseVersionId = enrollment.courseVersionId;
    final enrollmentId = enrollment.id;
    if (enrollmentId == null) return;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _RetrainingAcknowledgementDialog(
        enrollment: enrollment,
        userId: userId,
        onSuccess: () {
          Navigator.of(ctx).pop();
          ref.invalidate(enrollmentsProvider);
          client.course.getCourseVersion(courseVersionId).then((v) {
            final courseId = v?.courseId;
            if (courseId == null) return;
            if (!context.mounted) return;
            context.push(
              '/course/$courseId?enrollmentId=$enrollmentId',
              extra: {
                'userId': userId,
              },
            );
          });
        },
      ),
    );
  }

  void _openCourse(BuildContext context, Enrollment enrollment, int userId) {
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
        extra: {
          'userId': userId,
        },
      );
    });
  }
}

/// Sticky delegate for TabBar inside NestedScrollView.
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

/// Hero "Up Next" card: highest-priority enrollment with status badge and CTA.
class _HeroCourseCard extends StatelessWidget {
  const _HeroCourseCard({
    required this.enrollment,
    required this.badge,
    required this.userId,
    required this.assignments,
    required this.resumeLabels,
    required this.allCertificates,
    required this.onRetrainingTap,
    required this.onStartResumeTap,
  });

  final Enrollment? enrollment;
  final String? badge;
  final int userId;
  final List<TrainingAssignment> assignments;
  final Map<int, String> resumeLabels;
  final List<Certificate> allCertificates;
  final void Function(Enrollment) onRetrainingTap;
  final void Function(Enrollment) onStartResumeTap;

  @override
  Widget build(BuildContext context) {
    if (enrollment == null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 28),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.indigo900,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Up Next',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.indigo200,
                    letterSpacing: 0.5,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'No pending training',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'You’re all set. New assignments will appear here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.indigo200,
                  ),
            ),
          ],
        ),
      );
    }

    final e = enrollment!;
    final assignment = assignments
        .where((a) =>
            a.courseVersionId == e.courseVersionId && a.userId == userId)
        .firstOrNull;
    final title =
        e.courseVersion?.course?.title ??
        'Course v${e.courseVersion?.version ?? '?'}';
    final dueStr = assignment != null
        ? 'Due: ${assignment.dueDate.toIso8601String().split('T').first}'
        : null;
    final isRetraining = e.retrainingChangeSummary != null &&
        e.retrainingChangeSummary!.isNotEmpty &&
        e.acknowledgedAt == null;
    final isOverdue =
        assignment != null && assignment.dueDate.isBefore(DateTime.now());

    final badgeColor = badge == 'SOP UPDATE - ACTION REQUIRED'
        ? AppColors.destructive
        : AppColors.warning;
    final badgeText = badge ?? (isOverdue ? 'OVERDUE' : dueStr);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.indigo900,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Up Next',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.indigo200,
                      letterSpacing: 0.5,
                    ),
              ),
              if (badgeText != null && badgeText.isNotEmpty) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: badgeColor),
                  ),
                  child: Text(
                    badgeText,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: badgeColor,
                        ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 22,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (dueStr != null && badge != 'SOP UPDATE - ACTION REQUIRED') ...[
            const SizedBox(height: 6),
            Text(
              dueStr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.indigo200,
                  ),
            ),
          ],
          if (e.id != null && resumeLabels[e.id!] != null &&
              (resumeLabels[e.id!] ?? '').isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Resume: ${resumeLabels[e.id!]}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.teal500,
                  ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isRetraining) {
                  onRetrainingTap(e);
                } else {
                  onStartResumeTap(e);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.indigo900,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 2,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isRetraining
                    ? 'Acknowledge & Begin'
                    : (e.status == 'in_progress' ? 'Resume Course' : 'Start Course'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnrollmentListTab extends StatelessWidget {
  const _EnrollmentListTab({
    required this.enrollments,
    required this.userId,
    required this.assignments,
    required this.resumeLabels,
    required this.allCertificates,
    required this.emptyHeadline,
    required this.emptySubtext,
    required this.onRetrainingTap,
    required this.onCourseTap,
    this.extraSlivers = const [],
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
  final List<Widget> extraSlivers;

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
              : SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 320,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final e = enrollments[index];
                      final assignment = assignments
                          .where((a) =>
                              a.courseVersionId == e.courseVersionId &&
                              a.userId == userId)
                          .firstOrNull;
                      final progress = e.status == 'completed'
                          ? 1.0
                          : e.status == 'in_progress'
                              ? 0.5
                              : 0.0;
                      final title =
                          e.courseVersion?.course?.title ??
                          'Course v${e.courseVersion?.version ?? '?'}';
                      final dueStr = assignment != null
                          ? 'Due: ${assignment.dueDate.toIso8601String().split('T').first}'
                          : null;
                      Certificate? cert;
                      if (e.status == 'completed') {
                        for (final c in allCertificates) {
                          if (c.courseVersionId == e.courseVersionId &&
                              c.userId == e.userId) {
                            cert = c;
                            break;
                          }
                        }
                      }
                      return CourseCard(
                        key: ValueKey('enrollment-${e.id}-$index'),
                        title: title,
                        subtitle: dueStr,
                        progress: progress,
                        status: e.status.replaceAll('_', ' '),
                        resumeLabel: e.id != null ? resumeLabels[e.id!] : null,
                        onTap: () {
                          if (e.status == 'completed' && cert?.id != null) {
                            context.push('/certificate/${cert!.id}');
                          } else {
                            final needsAck = e.retrainingChangeSummary != null &&
                                e.retrainingChangeSummary!.isNotEmpty &&
                                e.acknowledgedAt == null;
                            if (needsAck) {
                              onRetrainingTap(e);
                            } else {
                              onCourseTap(e);
                            }
                          }
                        },
                        ctaLabel: e.status == 'completed'
                            ? 'View Certificate'
                            : (e.status == 'in_progress' ? 'Continue' : 'Start'),
                      );
                    },
                    childCount: enrollments.length,
                  ),
                ),
        ),
        ...extraSlivers,
      ],
    );
  }
}

/// EMP-WF-08: Modal to acknowledge SOP retraining before opening course.
class _RetrainingAcknowledgementDialog extends StatefulWidget {
  const _RetrainingAcknowledgementDialog({
    required this.enrollment,
    required this.userId,
    required this.onSuccess,
  });

  final Enrollment enrollment;
  final int userId;
  final VoidCallback onSuccess;

  @override
  State<_RetrainingAcknowledgementDialog> createState() =>
      _RetrainingAcknowledgementDialogState();
}

class _RetrainingAcknowledgementDialogState
    extends State<_RetrainingAcknowledgementDialog> {
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
      title: const Text('Acknowledge Retraining'),
      content: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Change summary',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Text(summary),
                  ),
                  const SizedBox(height: 20),
                  if (_meanings.isNotEmpty)
                    DropdownButtonFormField<String>(
                      initialValue: _selectedMeaning,
                      decoration: const InputDecoration(
                        labelText: 'Signature meaning',
                      ),
                      items: _meanings
                          .map((m) => DropdownMenuItem(
                                value: m.meaning,
                                child: Text(m.meaning),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _selectedMeaning = v),
                    ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password (re-authentication)',
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      style: TextStyle(color: AppColors.destructive),
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
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.check, size: 18),
          label: Text(_submitting ? 'Signing...' : 'Acknowledge & Begin'),
        ),
      ],
    );
  }
}
