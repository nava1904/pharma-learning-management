import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/course_card.dart';
import '../../widgets/empty_state.dart';

/// Course catalog: grid of CourseCards for browsing.
class CourseCatalogScreen extends ConsumerWidget {
  const CourseCatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

    return AppShell(
      title: 'Course Catalog',
      icon: Icons.menu_book_rounded,
      child: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: EmptyState(
                message: 'No courses available.',
                icon: Icons.menu_book_rounded,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(coursesProvider.future),
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return CourseCard(
                  title: course.title,
                  subtitle: course.description,
                  onTap: () async {
                    final user = await ref.read(currentUserProvider.future);
                    final userId = user?.id;
                    final versions = await client.course.getCourseVersions(course.id!);
                    final version = versions.isNotEmpty ? versions.first : null;
                    if (version != null && context.mounted) {
                      context.push(
                        '/course/${course.id}',
                        extra: {
                          'courseVersionId': version.id,
                          'enrollmentId': null,
                          'userId': userId,
                        },
                      );
                    }
                  },
                  ctaLabel: 'View',
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
                onPressed: () => ref.invalidate(coursesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
