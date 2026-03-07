import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/stat_card.dart';

/// Trainer/SME Dashboard: stats, quick actions, my courses.
class TrainerDashboardScreen extends ConsumerWidget {
  const TrainerDashboardScreen({super.key});

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
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
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
                            onPressed: () =>
                                context.push('/trainer/course-builder'),
                            backgroundColor: AppColors.indigo50,
                            borderColor: AppColors.indigo200,
                            iconColor: AppColors.indigo600,
                          ),
                          QuickActionButton(
                            label: 'Upload Materials',
                            subtitle: 'SOPs, videos, documents',
                            icon: Icons.upload_file,
                            onPressed: () =>
                                context.push('/trainer/materials'),
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
                  const SizedBox(height: 24),

                  // My Courses
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Courses',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                            ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.push('/trainer/course-builder'),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('New Course'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (myCourses.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
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
                            onPressed: () =>
                                context.push('/trainer/course-builder'),
                            child: const Text('Create Your First Course'),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.slate200),
                      ),
                      child: Column(
                        children: myCourses.asMap().entries.map((entry) {
                          final index = entry.key;
                          final course = entry.value;
                          return Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.slate200,
                                  width:
                                      index < myCourses.length - 1 ? 1 : 0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            course.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.slate900,
                                                ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: course.status == 'approved'
                                                  ? const Color(0xFFDCFCE7)
                                                  : course.status ==
                                                          'pending_qa'
                                                      ? const Color(0xFFFEF3C7)
                                                      : AppColors.slate100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              course.status
                                                  .toUpperCase()
                                                  .replaceAll('_', ' '),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: course.status ==
                                                            'approved'
                                                        ? const Color(0xFF166534)
                                                        : course.status ==
                                                                'pending_qa'
                                                            ? const Color(
                                                                0xFF854D0E)
                                                            : AppColors
                                                                .slate700,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (course.description != null) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          course.description!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.slate600,
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () => context.push(
                                          '/trainer/course-builder',
                                          extra: course),
                                      child: const Text('Edit'),
                                    ),
                                    if (course.status == 'approved') ...[
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () => context.push(
                                            '/trainer/course-builder',
                                            extra: course),
                                        child: const Text('Update Version'),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
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
