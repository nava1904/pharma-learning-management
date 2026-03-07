import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/compliance_widget.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/status_badge.dart';

class EmployeeDashboardScreen extends ConsumerWidget {
  const EmployeeDashboardScreen({super.key});

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
          ref.invalidate(assignmentsProvider);
          ref.invalidate(certificatesProvider);
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
  });

  final PharmaUser user;
  final int userId;
  final AsyncValue<UserComplianceMetrics?> complianceAsync;
  final AsyncValue<List<Enrollment>> enrollmentsAsync;
  final AsyncValue<List<TrainingAssignment>> assignmentsAsync;
  final AsyncValue<List<Certificate>> certificatesAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = assignmentsAsync.valueOrNull ?? [];
    final enrollments = enrollmentsAsync.valueOrNull ?? [];
    final certificates = certificatesAsync.valueOrNull ?? [];

    final completedCount =
        enrollments.where((e) => e.status == 'completed').length;
    final totalCount = enrollments.length;
    final activeCount =
        enrollments.where((e) => e.status == 'in_progress').length;

    final dueSoon = assignments.where((a) {
      final due = a.dueDate;
      return due.isAfter(DateTime.now()) &&
          due.difference(DateTime.now()).inDays <= 7;
    }).toList();
    final overdue =
        assignments.where((a) => a.dueDate.isBefore(DateTime.now())).toList();

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        complianceAsync.when(
          data: (c) {
            if (c == null) return const SizedBox.shrink();
            return ComplianceWidget(
              title: 'Compliance Health',
              subtitle: '${user.departmentId} - ${user.jobRoleId}',
              percentage: c.complianceRate,
              completedLabel: '$completedCount of $totalCount completed',
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
        if (dueSoon.isNotEmpty || overdue.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: AppColors.destructive, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Urgent Training Required',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF991B1B),
                            ),
                      ),
                      Text(
                        'You have training due within the next 7 days. Complete them to maintain your compliance status.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFB91C1C),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
              Text(
                'My Training Assignments',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate900,
                    ),
              ),
              const SizedBox(height: 16),
              if (enrollments.isEmpty)
                const EmptyState(message: 'No assigned trainings')
              else
                ...enrollments.map((e) => _EnrollmentTile(
                      enrollment: e,
                      assignment: assignments
                          .where((a) =>
                              a.courseVersionId == e.courseVersionId &&
                              a.userId == userId)
                          .firstOrNull,
                      certificates: certificates,
                      onTap: () => _openCourse(context, e, userId),
                    )),
            ],
          ),
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
              Text(
                'My Certifications',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate900,
                    ),
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

class _EnrollmentTile extends StatelessWidget {
  const _EnrollmentTile({
    required this.enrollment,
    required this.assignment,
    required this.certificates,
    required this.onTap,
  });

  final Enrollment enrollment;
  final TrainingAssignment? assignment;
  final List<Certificate> certificates;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final status = enrollment.status;
    final isCompleted = status == 'completed';
    final title =
        enrollment.courseVersion?.course?.title ?? 'Course v${enrollment.courseVersion?.version ?? '?'}';
    final course = enrollment.courseVersion?.course;

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(status: status),
                    if (assignment?.priority == 'high')
                      const Icon(Icons.priority_high, color: AppColors.destructive, size: 16),
                  ],
                ),
                if (course?.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    course!.description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (course?.sopNumber != null)
                      Text(
                        '${course!.sopNumber} v${enrollment.courseVersion?.version ?? '?'}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.slate500,
                            ),
                      ),
                    if (assignment != null) ...[
                      const SizedBox(width: 16),
                      Text(
                        'Due: ${assignment!.dueDate.toIso8601String().split('T').first}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.slate500,
                            ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isCompleted)
            Builder(
              builder: (context) {
                Certificate? cert;
                for (final c in certificates) {
                  if (c.courseVersionId == enrollment.courseVersionId &&
                      c.userId == enrollment.userId) {
                    cert = c;
                    break;
                  }
                }
                if (cert == null || cert.id == null) return const SizedBox.shrink();
                final certId = cert.id!;
                return TextButton(
                  onPressed: () => context.push('/certificate/$certId'),
                  child: const Text('View Certificate'),
                );
              },
            )
          else
            ElevatedButton(
              onPressed: onTap,
              child: Text(
                status == 'in_progress' ? 'Continue' : 'Start Training',
              ),
            ),
        ],
      ),
    );
  }
}
