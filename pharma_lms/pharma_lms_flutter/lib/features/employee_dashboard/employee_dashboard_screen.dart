import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/compliance_widget.dart';
import '../../widgets/course_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/progress_ring.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';

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
            return _EmployeeDashboardContent(
              user: user,
              userId: user.id!,
              complianceAsync: complianceAsync,
              enrollmentsAsync: enrollmentsAsync,
              resumeLabelsAsync: ref.watch(enrollmentResumeLabelsProvider),
              assignmentsAsync: assignmentsAsync,
              certificatesAsync: certificatesAsync,
              recentActivityAsync: recentActivityAsync,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = assignmentsAsync.valueOrNull ?? [];
    final enrollments = enrollmentsAsync.valueOrNull ?? [];
    final resumeLabels = resumeLabelsAsync.valueOrNull ?? {};
    final allCertificates = certificatesAsync.valueOrNull ?? [];
    final certificates = allCertificates
        .where((c) => (c.status ?? 'active') != 'obsolete')
        .toList();

    final completedCount =
        enrollments.where((e) => e.status == 'completed').length;
    final totalCount = enrollments.length;
    final activeCount =
        enrollments.where((e) => e.status == 'in_progress').length;

    final overdue =
        assignments.where((a) => a.dueDate.isBefore(DateTime.now())).toList();
    final dueThisWeek = assignments.where((a) {
      final due = a.dueDate;
      return due.isAfter(DateTime.now()) &&
          due.difference(DateTime.now()).inDays <= 7;
    }).toList();

    final expiringCerts = allCertificates.where((c) {
      if (c.expiresAt == null) return false;
      final days = c.expiresAt!.difference(DateTime.now()).inDays;
      return days >= 0 && days <= 90;
    }).toList();

    final retrainingEnrollments = enrollments.where((e) =>
        e.retrainingChangeSummary != null &&
        e.retrainingChangeSummary!.isNotEmpty &&
        e.acknowledgedAt == null).toList();

    final sortedEnrollments = List<Enrollment>.from(enrollments)
      ..sort((a, b) {
        final aAssign = assignments
            .where((x) =>
                x.courseVersionId == a.courseVersionId && x.userId == userId)
            .firstOrNull;
        final bAssign = assignments
            .where((x) =>
                x.courseVersionId == b.courseVersionId && x.userId == userId)
            .firstOrNull;
        final aDue = aAssign?.dueDate ?? DateTime.now().add(const Duration(days: 365));
        final bDue = bAssign?.dueDate ?? DateTime.now().add(const Duration(days: 365));
        final aOverdue = aDue.isBefore(DateTime.now());
        final bOverdue = bDue.isBefore(DateTime.now());
        if (aOverdue != bOverdue) return aOverdue ? -1 : 1;
        final aDueSoon = aDue.difference(DateTime.now()).inDays <= 7;
        final bDueSoon = bDue.difference(DateTime.now()).inDays <= 7;
        if (aDueSoon != bDueSoon) return aDueSoon ? -1 : 1;
        return aDue.compareTo(bDue);
      });

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        complianceAsync.when(
          data: (c) {
            if (c == null) return const SizedBox.shrink();
            final rate = c.complianceRate;
            final ringColor = rate >= 95
                ? AppColors.success
                : rate >= 80
                    ? AppColors.warning
                    : AppColors.destructive;
            return Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ProgressRing(
                    progress: rate / 100,
                    size: 90,
                    strokeWidth: 6,
                    showLabel: true,
                    progressColor: ringColor,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Learning Journey',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.slate900,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Learning is a journey — track your progress',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.slate500,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$completedCount of $totalCount completed',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.slate600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        ComplianceWidget(
                          title: 'Compliance Health',
                          subtitle: '${user.departmentId} - ${user.jobRoleId}',
                          percentage: rate,
                          completedLabel: '$completedCount of $totalCount completed',
                        ),
                        if (totalCount > 0 && completedCount < totalCount)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: TextButton.icon(
                              onPressed: () {
                                final next = enrollments
                                    .where((e) => e.status != 'completed')
                                    .firstOrNull;
                                if (next != null) {
                                  final needsAck = next.retrainingChangeSummary != null &&
                                      next.retrainingChangeSummary!.isNotEmpty &&
                                      next.acknowledgedAt == null;
                                  if (needsAck) {
                                    _showRetrainingAcknowledgementDialog(
                                        context, ref, next, userId);
                                  } else {
                                    _openCourse(context, next, userId);
                                  }
                                }
                              },
                              icon: const Icon(Icons.play_arrow_rounded, size: 18),
                              label: const Text('Continue'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'Active Training',
                value: '$activeCount',
                icon: Icons.menu_book_rounded,
                iconBackgroundColor: const Color(0xFFDBEAFE),
                iconColor: const Color(0xFF2563EB),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                label: 'Completed',
                value: '$completedCount',
                icon: Icons.check_circle_rounded,
                iconBackgroundColor: const Color(0xFFDCFCE7),
                iconColor: const Color(0xFF16A34A),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatCard(
                label: 'Certifications',
                value: '${certificates.length}',
                icon: Icons.workspace_premium_rounded,
                iconBackgroundColor: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFD97706),
              ),
            ),
            if (overdue.isNotEmpty) ...[
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  label: 'Overdue',
                  value: '${overdue.length}',
                  icon: Icons.warning_amber_rounded,
                  iconBackgroundColor: const Color(0xFFFEE2E2),
                  iconColor: AppColors.destructive,
                ),
              ),
            ],
          ],
        ),
        if (overdue.isNotEmpty || dueThisWeek.isNotEmpty) ...[
          const SizedBox(height: 24),
          Row(
            children: [
              if (overdue.isNotEmpty)
                Expanded(
                  child: _UrgencyCard(
                    icon: Icons.warning_amber_rounded,
                    count: overdue.length,
                    message: '${overdue.length} overdue',
                    color: AppColors.destructive,
                  ),
                ),
              if (overdue.isNotEmpty && dueThisWeek.isNotEmpty)
                const SizedBox(width: 16),
              if (dueThisWeek.isNotEmpty)
                Expanded(
                  child: _UrgencyCard(
                    icon: Icons.schedule,
                    count: dueThisWeek.length,
                    message: '${dueThisWeek.length} due this week',
                    color: AppColors.warning,
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(height: 24),
        SectionHeader(
          icon: Icons.school_rounded,
          title: 'Your path to compliance',
          color: AppColors.teal600,
          action: TextButton.icon(
            onPressed: () => context.push('/employee/training-history'),
            icon: const Icon(Icons.history_rounded, size: 18),
            label: const Text('View History'),
          ),
        ),
        const SizedBox(height: 16),
        if (enrollments.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate200),
            ),
            child: const EmptyState(
              message: 'No assigned trainings',
              icon: Icons.menu_book_rounded,
              headline: 'No Training Assignments',
              subtext: 'Your assigned courses will appear here.',
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 4
                  : (constraints.maxWidth > 600
                      ? 3
                      : (constraints.maxWidth > 400 ? 2 : 1));
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: sortedEnrollments.map((e) {
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
                          _showRetrainingAcknowledgementDialog(
                              context, ref, e, userId);
                        } else {
                          _openCourse(context, e, userId);
                        }
                      }
                    },
                    ctaLabel: e.status == 'completed'
                        ? 'View Certificate'
                        : (e.status == 'in_progress' ? 'Continue' : 'Start'),
                  );
                }).toList(),
              );
            },
          ),
        if (expiringCerts.isNotEmpty) ...[
          const SizedBox(height: 24),
          SectionHeader(
            icon: Icons.schedule_rounded,
            title: 'Certifications Expiring Soon',
            color: AppColors.warning,
          ),
          const SizedBox(height: 16),
          ...expiringCerts.take(5).map((cert) {
            final days = cert.expiresAt?.difference(DateTime.now()).inDays ?? 0;
            final bucket = days <= 30 ? '30d' : (days <= 60 ? '60d' : '90d');
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium_rounded,
                        color: AppColors.warning, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cert.courseVersion?.course?.title ?? 'Course',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Expires in $days days ($bucket)',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.warning,
                                ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/certificate/${cert.id}'),
                      child: const Text('Renew'),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
        if (retrainingEnrollments.isNotEmpty) ...[
          const SizedBox(height: 24),
          SectionHeader(
            icon: Icons.update_rounded,
            title: 'Retraining Required',
            color: AppColors.warning,
          ),
          const SizedBox(height: 16),
          ...retrainingEnrollments.map((e) {
            final title = e.courseVersion?.course?.title ?? 'Course';
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.warning),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded,
                        color: AppColors.warning, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            e.retrainingChangeSummary ?? 'SOP updated',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showRetrainingAcknowledgementDialog(
                        context,
                        ref,
                        e,
                        userId,
                      ),
                      child: const Text('Acknowledge & Begin'),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
        recentActivityAsync.when(
          data: (activities) {
            if (activities.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.slate200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        icon: Icons.history,
                        title: 'Recent Activity',
                        color: AppColors.slate600,
                      ),
                      const SizedBox(height: 16),
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
                ),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.slate200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                icon: Icons.workspace_premium_rounded,
                title: 'My Certifications',
                color: const Color(0xFFD97706),
              ),
              const SizedBox(height: 16),
              if (certificates.isEmpty)
                const EmptyState(message: 'No certifications yet')
              else
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: certificates.map((cert) {
                    final expiringSoon = cert.expiresAt != null &&
                        cert.expiresAt!
                            .difference(DateTime.now())
                            .inDays <= 30;
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: expiringSoon
                            ? const Color(0xFFFEFCE8)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: expiringSoon
                              ? const Color(0xFFFDE047)
                              : AppColors.slate200,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => context.push('/certificate/${cert.id}'),
                        child: Row(
                          children: [
                            const Icon(Icons.workspace_premium_rounded,
                                color: Color(0xFFD97706), size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cert.courseVersion?.course?.title ?? 'Course',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (cert.expiresAt != null)
                                    Text(
                                      'Expires: ${cert.expiresAt!.toIso8601String().split('T').first}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: expiringSoon
                                                ? const Color(0xFF854D0E)
                                                : AppColors.slate500,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 12),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ref.watch(employeeDashboardLastUpdatedProvider) != null
                  ? 'Last updated: ${_formatLastUpdated(ref.watch(employeeDashboardLastUpdatedProvider)!)}'
                  : 'Pull to refresh',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.mutedForeground,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _formatLastUpdated(DateTime dt) {
    final now = DateTime.now();
    if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return dt.toIso8601String().split('T').first;
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
              '/course/$courseId',
              extra: {
                'courseVersionId': courseVersionId,
                'enrollmentId': enrollmentId,
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
        '/course/$courseId',
        extra: {
          'courseVersionId': courseVersionId,
          'enrollmentId': enrollmentId,
          'userId': userId,
        },
      );
    });
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
        passwordReauth: password,
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
                      value: _selectedMeaning,
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

/// Compact Odoo-style urgency card for overdue/due soon.
class _UrgencyCard extends StatelessWidget {
  const _UrgencyCard({
    required this.icon,
    required this.count,
    required this.message,
    required this.color,
  });

  final IconData icon;
  final int count;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                ),
                Text(
                  message,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
