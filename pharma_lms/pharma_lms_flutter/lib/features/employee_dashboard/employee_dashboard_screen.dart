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
          ref.invalidate(assignmentsProvider);
          ref.invalidate(certificatesProvider);
          ref.invalidate(recentActivityProvider);
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
    required this.assignmentsAsync,
    required this.certificatesAsync,
    required this.recentActivityAsync,
  });

  final PharmaUser user;
  final int userId;
  final AsyncValue<UserComplianceMetrics?> complianceAsync;
  final AsyncValue<List<Enrollment>> enrollmentsAsync;
  final AsyncValue<List<TrainingAssignment>> assignmentsAsync;
  final AsyncValue<List<Certificate>> certificatesAsync;
  final AsyncValue<List<Map<String, dynamic>>> recentActivityAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = assignmentsAsync.valueOrNull ?? [];
    final enrollments = enrollmentsAsync.valueOrNull ?? [];
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

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        complianceAsync.when(
          data: (c) {
            if (c == null) return const SizedBox.shrink();
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
                    progress: c.complianceRate / 100,
                    size: 80,
                    strokeWidth: 6,
                    showLabel: true,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${user.firstName}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.slate900,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your learning journey - $completedCount of $totalCount completed',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.slate600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        ComplianceWidget(
                          title: 'Compliance Health',
                          subtitle: '${user.departmentId} - ${user.jobRoleId}',
                          percentage: c.complianceRate,
                          completedLabel: '$completedCount of $totalCount completed',
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
          ],
        ),
        if (overdue.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: AppColors.destructive, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Overdue Training',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF991B1B),
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${overdue.length} overdue assignment(s). Complete them to maintain compliance.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFB91C1C),
                      ),
                ),
              ],
            ),
          ),
        ],
        if (dueThisWeek.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFCE8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFDE047)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.schedule,
                        color: Color(0xFF854D0E), size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Due This Week',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF854D0E),
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${dueThisWeek.length} assignment(s) due within 7 days.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF854D0E),
                      ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),
        SectionHeader(
          icon: Icons.school_rounded,
          title: 'My Learning Path',
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
                children: enrollments.map((e) {
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
                    onTap: () {
                      if (e.status == 'completed' && cert?.id != null) {
                        context.push('/certificate/${cert!.id}');
                      } else {
                        _openCourse(context, e, userId);
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
      ],
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
