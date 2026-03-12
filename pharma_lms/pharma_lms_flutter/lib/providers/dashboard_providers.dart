import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'repository_providers.dart';
import 'user_provider.dart';

/// User compliance metrics.
final userComplianceProvider = FutureProvider<UserComplianceMetrics?>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return null;
  return client.compliance.getUserCompliance(user!.id!);
});

/// Enrollments for current user.
final enrollmentsProvider = FutureProvider<List<Enrollment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.getEnrollmentsForUser(user!.id!);
});

/// Resume labels for in-progress enrollments (e.g. "Module 2, Lesson 3").
final enrollmentResumeLabelsProvider =
    FutureProvider<Map<int, String>>((ref) async {
  final enrollments = await ref.watch(enrollmentsProvider.future);
  final inProgress =
      enrollments.where((e) => e.status == 'in_progress' && e.id != null).toList();
  if (inProgress.isEmpty) return {};
  final repo = ref.watch(trainingRepositoryProvider);
  final entries = await Future.wait(
    inProgress.map((e) async {
      final label = await repo.getEnrollmentResumePosition(e.id!);
      return MapEntry(e.id!, label ?? '');
    }),
  );
  return Map.fromEntries(entries.where((e) => e.value.isNotEmpty));
});

/// Training assignments for current user.
final assignmentsProvider = FutureProvider<List<TrainingAssignment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.getAssignmentsForUser(user!.id!);
});

/// Training completion rate by department.
final trainingCompletionRateProvider =
    FutureProvider<Map<String, double>>((ref) async {
  return client.analytics.getTrainingCompletionRate();
});

/// Certificates for current user.
final certificatesProvider = FutureProvider<List<Certificate>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.getCertificatesForUser(user!.id!);
});

/// Training records for current user (completion with score). Used for training history.
final trainingRecordsProvider = FutureProvider<List<TrainingRecord>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.getTrainingRecordsForUser(user!.id!);
});

/// Organizations for admin.
final organizationsProvider = FutureProvider<List<Organization>>((ref) async {
  return client.organization.listOrganizations();
});

/// Courses list.
final coursesProvider = FutureProvider<List<Course>>((ref) async {
  return client.course.listCourses();
});

/// Pending course versions for QA.
final pendingCourseVersionsProvider =
    FutureProvider<List<CourseVersion>>((ref) async {
  return client.qa.listPendingCourseVersions();
});

/// All users for admin (total employees count).
final usersProvider = FutureProvider<List<PharmaUser>>((ref) async {
  return client.organization.listUsers();
});

/// Last refresh time for employee dashboard (5-min cache TTL per FR-07-01 AC-08).
final employeeDashboardLastUpdatedProvider =
    StateProvider<DateTime?>((ref) => null);
