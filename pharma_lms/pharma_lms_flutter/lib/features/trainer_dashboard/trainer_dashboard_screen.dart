import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/course_card.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';
import 'new_course_dialog.dart';

/// Trainer/SME Dashboard: stats, quick actions, my courses.
class TrainerDashboardScreen extends ConsumerWidget {
  const TrainerDashboardScreen({super.key});

  /// TRN-WF-01: Open New Course Dialog and navigate to builder if created
  static Future<void> _openNewCourseDialog(
    BuildContext context,
    WidgetRef ref, {
    required int organizationId,
    required int createdById,
  }) async {
    final course = await NewCourseDialog.show(
      context,
      organizationId: organizationId,
      createdById: createdById,
    );

    if (course != null && context.mounted) {
      // Refresh the courses list
      ref.invalidate(coursesProvider);
      // Navigate to course builder with the new course
      context.push('/trainer/course-builder', extra: course);
    }
  }

  static Future<void> _openAnalytics(BuildContext context, Course course) async {
    if (course.id == null) return;
    try {
      final versions = await client.course.getCourseVersions(course.id!);
      final effective = versions
          .where((v) => v.status == 'effective')
          .toList()
        ..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      final versionId = effective.isNotEmpty ? effective.first.id : null;
      if (versionId != null && context.mounted) {
        context.push(
          '/trainer/course-analytics/$versionId',
          extra: {'courseTitle': course.title},
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No effective course version for analytics'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final coursesAsync = ref.watch(coursesProvider);

    return AppShell(
      title: 'Subject Matter Expert Portal',
      child: userAsync.when(
        data: (_) => coursesAsync.when(
          data: (allCourses) {
            final user = userAsync.valueOrNull;
            final userId = user?.id;
            final myCourses = userId != null
                ? allCourses.where((c) => c.createdById == userId).toList()
                : <Course>[];
            final draftCount =
                myCourses.where((c) => c.status == 'draft').length;
            final pendingCount =
                myCourses.where((c) => c.status == 'pending_qa').length;
            final approvedCount =
                myCourses.where((c) => c.status == 'approved').length;

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(currentUserProvider);
                ref.invalidate(coursesProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    'Create & Measure',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.slate600,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // 4 stat cards
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600
                          ? 4
                          : (constraints.maxWidth > 400 ? 2 : 1);
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          StatCard(
                            label: 'Total Courses',
                            value: '${myCourses.length}',
                            icon: Icons.menu_book,
                            iconBackgroundColor: AppColors.indigo100,
                            iconColor: AppColors.indigo600,
                          ),
                          StatCard(
                            label: 'Drafts',
                            value: '$draftCount',
                            icon: Icons.description,
                            iconBackgroundColor: AppColors.slate100,
                            iconColor: AppColors.slate600,
                          ),
                          StatCard(
                            label: 'Pending QA',
                            value: '$pendingCount',
                            icon: Icons.schedule,
                            iconBackgroundColor: const Color(0xFFFEF3C7),
                            iconColor: const Color(0xFFD97706),
                          ),
                          StatCard(
                            label: 'Approved',
                            value: '$approvedCount',
                            icon: Icons.check_circle_rounded,
                            iconBackgroundColor: const Color(0xFFDCFCE7),
                            iconColor: AppColors.success,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Quick Actions
                  SectionHeader(
                    icon: Icons.flash_on,
                    title: 'Quick Actions',
                    color: AppColors.indigo600,
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600
                          ? 3
                          : (constraints.maxWidth > 400 ? 2 : 1);
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 2.2,
                        children: [
                          QuickActionButton(
                            label: 'Create New Course',
                            subtitle: 'Build training content',
                            icon: Icons.add,
                            onPressed: () => _openNewCourseDialog(
                              context,
                              ref,
                              organizationId: user?.organizationId ?? 1,
                              createdById: userId ?? 1,
                            ),
                            backgroundColor: AppColors.teal50,
                            borderColor: AppColors.teal100,
                            iconColor: AppColors.teal600,
                          ),
                          QuickActionButton(
                            label: 'Upload Materials',
                            subtitle: 'SOPs, videos, documents',
                            icon: Icons.upload_file,
                            onPressed: () => context.push(
                              '/trainer/materials',
                              extra: {'organizationId': user?.organizationId ?? 1},
                            ),
                            backgroundColor: const Color(0xFFDCFCE7),
                            borderColor: const Color(0xFF86EFAC),
                            iconColor: AppColors.success,
                          ),
                          QuickActionButton(
                            label: 'Create Assessment',
                            subtitle: 'Build quiz questions',
                            icon: Icons.quiz,
                            onPressed: () =>
                                context.push('/trainer/assessments'),
                            backgroundColor: const Color(0xFFFEF3C7),
                            borderColor: const Color(0xFFFDE047),
                            iconColor: const Color(0xFFD97706),
                          ),
                        ],
                      );
                    },
                  ),
                  if (pendingCount > 0) ...[
                    const SizedBox(height: 24),
                    SectionHeader(
                      icon: Icons.schedule,
                      title: 'Courses Awaiting QA',
                      color: AppColors.warning,
                    ),
                    const SizedBox(height: 16),
                    ...myCourses
                        .where((c) => c.status == 'pending_qa')
                        .map((course) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: const Icon(Icons.pending_actions,
                                    color: AppColors.warning),
                                title: Text(course.title),
                                subtitle: const Text('Submitted for review'),
                                trailing: TextButton(
                                  onPressed: () => context.push(
                                    '/trainer/course-builder',
                                    extra: course,
                                  ),
                                  child: const Text('View'),
                                ),
                                tileColor: AppColors.warning.withValues(alpha: 0.08),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: AppColors.warning.withValues(alpha: 0.3),
                                  ),
                                ),
                              ),
                            )),
                  ],
                  const SizedBox(height: 24),

                  // My Courses - Odoo-inspired card grid
                  SectionHeader(
                    icon: Icons.menu_book,
                    title: 'My Courses',
                    color: AppColors.teal600,
                    action: ElevatedButton.icon(
                      onPressed: () => _openNewCourseDialog(
                        context,
                        ref,
                        organizationId: user?.organizationId ?? 1,
                        createdById: userId ?? 1,
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('New Course'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (myCourses.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.slate200),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.menu_book,
                              size: 48, color: AppColors.slate400),
                          const SizedBox(height: 16),
                          Text(
                            'No Courses Yet',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.slate900,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start creating training content for your department.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.slate600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => _openNewCourseDialog(
                              context,
                              ref,
                              organizationId: user?.organizationId ?? 1,
                              createdById: userId ?? 1,
                            ),
                            child: const Text('Create Your First Course'),
                          ),
                        ],
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
                          children: myCourses.map((course) {
                            return Stack(
                              children: [
                                CourseCard(
                                  title: course.title,
                                  subtitle: course.description,
                                  status: course.status
                                      .toUpperCase()
                                      .replaceAll('_', ' '),
                                  onTap: () => context.push(
                                    '/trainer/course-builder',
                                    extra: course,
                                  ),
                                  ctaLabel: 'Edit',
                                ),
                                if (course.status == 'approved')
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        onPressed: () =>
                                            _openAnalytics(context, course),
                                        icon: const Icon(Icons.analytics,
                                            size: 20),
                                        tooltip: 'Analytics',
                                        style: IconButton.styleFrom(
                                          backgroundColor: AppColors.slate100,
                                          foregroundColor: AppColors.slate700,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  const SizedBox(height: 24),

                  // Guidelines
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SME Content Creation Guidelines',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E3A8A),
                              ),
                        ),
                        const SizedBox(height: 16),
                        _GuidelineItem(
                          text:
                              'Ensure all SOP content aligns with current approved procedures',
                        ),
                        _GuidelineItem(
                          text:
                              'Create assessments with randomized question pools to prevent answer-sharing',
                        ),
                        _GuidelineItem(
                          text:
                              'Set appropriate minimum reading times to ensure comprehension',
                        ),
                        _GuidelineItem(
                          text:
                              'All courses require QA approval before release to production',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _GuidelineItem extends StatelessWidget {
  const _GuidelineItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded,
              size: 18, color: Color(0xFF2563EB)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF1E40AF),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
