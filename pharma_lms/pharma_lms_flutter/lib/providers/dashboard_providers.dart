import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
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
  return client.training.getEnrollmentsForUser(user!.id!);
});

/// Training assignments for current user.
final assignmentsProvider = FutureProvider<List<TrainingAssignment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.training.getAssignmentsForUser(user!.id!);
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
  return client.training.getCertificatesForUser(user!.id!);
});

/// Training records for current user (completion with score). Used for training history.
final trainingRecordsProvider = FutureProvider<List<TrainingRecord>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.training.getTrainingRecordsForUser(user!.id!);
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
