import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/course_card.dart';
import '../../widgets/empty_state.dart';

/// My Learning: assigned courses + in progress.
class MyLearningScreen extends ConsumerWidget {
  const MyLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(assignmentsProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final userAsync = ref.watch(currentUserProvider);

    return AppShell(
      title: 'My Learning',
      icon: Icons.school_rounded,
      child: assignmentsAsync.when(
        data: (assignments) {
          final enrollments = enrollmentsAsync.valueOrNull ?? [];
          final user = userAsync.valueOrNull;
          final userId = user?.id ?? 0;

          if (assignments.isEmpty && enrollments.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: EmptyState(
                message: 'No assigned courses. Check back later.',
                icon: Icons.assignment_outlined,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(assignmentsProvider);
              ref.invalidate(enrollmentsProvider);
              await ref.read(assignmentsProvider.future);
              await ref.read(enrollmentsProvider.future);
            },
            child: FutureBuilder<List<_LearningItem>>(
              future: _buildLearningItems(assignments, enrollments),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CourseCard(
                        title: item.title,
                        subtitle: item.subtitle,
                        progress: item.progress,
                        status: item.status,
                        onTap: () {
                          context.push(
                            '/course/${item.courseId}',
                            extra: {
                              'courseVersionId': item.courseVersionId,
                              'enrollmentId': item.enrollmentId,
                              'userId': userId,
                            },
                          );
                        },
                        ctaLabel: item.progress != null && item.progress! > 0
                            ? 'Continue'
                            : 'Start',
                      ),
                    );
                  },
                );
              },
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
                onPressed: () => ref.invalidate(assignmentsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<_LearningItem>> _buildLearningItems(
  List<TrainingAssignment> assignments,
  List<Enrollment> enrollments,
) async {
  final items = <_LearningItem>[];
  final seen = <int>{};

  for (final a in assignments) {
    if (seen.contains(a.courseVersionId)) continue;
    seen.add(a.courseVersionId);
    final version = await client.course.getCourseVersion(a.courseVersionId);
    final courseId = version?.courseId;
    if (courseId == null) continue;
    final title = version?.course?.title ?? 'Course';
    final enrollment = enrollments
        .where((e) => e.courseVersionId == a.courseVersionId)
        .firstOrNull;
    double? progress;
    if (enrollment != null) {
      final records = await client.training.getTrainingRecordsForUser(a.userId ?? 0);
      final completed = records.any((r) =>
          r.courseVersionId == a.courseVersionId);
      progress = completed ? 1.0 : 0.0;
    }
    items.add(_LearningItem(
      courseId: courseId.toString(),
      courseVersionId: a.courseVersionId,
      enrollmentId: enrollment?.id,
      title: title,
      subtitle: 'Assigned',
      progress: progress,
      status: enrollment?.status ?? 'assigned',
    ));
  }

  for (final e in enrollments) {
    if (seen.contains(e.courseVersionId)) continue;
    seen.add(e.courseVersionId);
    final version = await client.course.getCourseVersion(e.courseVersionId);
    final courseId = version?.courseId;
    if (courseId == null) continue;
    items.add(_LearningItem(
      courseId: courseId.toString(),
      courseVersionId: e.courseVersionId,
      enrollmentId: e.id,
      title: version?.course?.title ?? 'Course',
      subtitle: 'In progress',
      progress: e.status == 'completed' ? 1.0 : 0.0,
      status: e.status ?? 'in_progress',
    ));
  }

  return items;
}

class _LearningItem {
  _LearningItem({
    required this.courseId,
    required this.courseVersionId,
    this.enrollmentId,
    required this.title,
    required this.subtitle,
    this.progress,
    required this.status,
  });

  final String courseId;
  final int courseVersionId;
  final int? enrollmentId;
  final String title;
  final String subtitle;
  final double? progress;
  final String status;
}
