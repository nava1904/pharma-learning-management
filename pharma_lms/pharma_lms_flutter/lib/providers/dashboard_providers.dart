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

/// Monthly training hours for dashboard chart (last 5 months).
final monthlyTrainingHoursProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getMonthlyTrainingHours(user!.id!);
  } catch (_) {
    return [];
  }
});

/// Weekly learning progress for dashboard area chart.
final weeklyLearningProgressProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getWeeklyLearningProgress(user!.id!);
  } catch (_) {
    return [];
  }
});

/// User's average quiz score.
final userAverageQuizScoreProvider = FutureProvider<double>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return 0.0;
  try {
    return await client.analytics.getUserAverageQuizScore(user!.id!);
  } catch (_) {
    return 0.0;
  }
});

/// Compliance alerts for current user.
final complianceAlertsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getComplianceAlerts(user!.id!);
  } catch (_) {
    return [];
  }
});

/// Upcoming due dates for current user.
final upcomingDueDatesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getUpcomingDueDates(user!.id!);
  } catch (_) {
    return [];
  }
});

/// Recent activity for current user (last 5 training actions).
final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getRecentActivity(user!.id!);
  } catch (_) {
    return [];
  }
});

/// User's learning streak (consecutive days of activity).
final learningStreakProvider = FutureProvider<int>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return 0;
  try {
    return await client.analytics.getUserLearningStreak(user!.id!);
  } catch (_) {
    return 0;
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// CONSOLIDATED DASHBOARD SUMMARY
// ═══════════════════════════════════════════════════════════════════════════════

/// Consolidated dashboard data for the Employee Dashboard screen.
/// FR-07-01: Learner Dashboard — compliance score, urgency-sorted assignments,
/// expiring certs, recent activity, SOP queue.
class DashboardSummary {
  final PharmaUser user;
  final List<Enrollment> inProgress;
  final List<Enrollment> toDo;
  final List<Enrollment> completed;
  final UserComplianceMetrics compliance;
  final List<TrainingAssignment> assignments;
  final List<Map<String, dynamic>> monthlyHours;
  final List<Map<String, dynamic>> complianceAlerts;
  final double averageQuizScore;
  final List<Map<String, dynamic>> upcomingDueDates;
  final List<Map<String, dynamic>> recentActivity;
  final List<Map<String, dynamic>> weeklyProgress;
  final int learningStreak;
  final double totalHoursThisYear;
  final DateTime fetchedAt;

  DashboardSummary({
    required this.user,
    required this.inProgress,
    required this.toDo,
    required this.completed,
    required this.compliance,
    required this.assignments,
    this.monthlyHours = const [],
    this.complianceAlerts = const [],
    this.averageQuizScore = 0.0,
    this.upcomingDueDates = const [],
    this.recentActivity = const [],
    this.weeklyProgress = const [],
    this.learningStreak = 0,
    this.totalHoursThisYear = 0.0,
    DateTime? fetchedAt,
  }) : fetchedAt = fetchedAt ?? DateTime.now();
}

/// Combined provider that fetches all employee dashboard data in one place.
/// FR-07-01 AC-07: Dashboard loads within 3s P95.
/// FR-07-01 AC-08: Data freshness ≤ 5 min cache TTL.
final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  // Fetch user
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) {
    throw Exception('User not logged in');
  }

  // Fetch all data in parallel for performance (FR-07-01 AC-07)
  final results = await Future.wait([
    ref.watch(enrollmentsProvider.future),
    ref.watch(userComplianceProvider.future),
    ref.watch(assignmentsProvider.future),
    ref.watch(monthlyTrainingHoursProvider.future),
    ref.watch(complianceAlertsProvider.future),
    ref.watch(userAverageQuizScoreProvider.future),
    ref.watch(upcomingDueDatesProvider.future),
    ref.watch(recentActivityProvider.future),
    ref.watch(weeklyLearningProgressProvider.future),
    ref.watch(learningStreakProvider.future),
  ]);

  final enrollments = results[0] as List<Enrollment>;
  final compliance = results[1] as UserComplianceMetrics?;
  final assignments = results[2] as List<TrainingAssignment>;
  final monthlyHours = results[3] as List<Map<String, dynamic>>;
  final alerts = results[4] as List<Map<String, dynamic>>;
  final avgScore = results[5] as double;
  final dueDates = results[6] as List<Map<String, dynamic>>;
  final activity = results[7] as List<Map<String, dynamic>>;
  final weeklyProg = results[8] as List<Map<String, dynamic>>;
  final streak = results[9] as int;

  // Categorize enrollments
  final inProgress = enrollments.where((e) => e.status == 'in_progress').toList();
  final toDo = enrollments.where((e) => e.status == 'assigned' || e.status == 'not_started').toList();
  final completed = enrollments.where((e) => e.status == 'completed').toList();

  // Compute total hours this year from monthly data
  final totalHours = monthlyHours.fold<double>(
    0.0,
    (sum, m) => sum + ((m['hours'] as num?)?.toDouble() ?? 0.0),
  );

  // Update last-refreshed timestamp (FR-07-01 AC-08)
  ref.read(employeeDashboardLastUpdatedProvider.notifier).state = DateTime.now();

  // Compute enrollment-based compliance rate client-side for accuracy
  final enrollmentBasedRate = enrollments.isNotEmpty
      ? (completed.length / enrollments.length * 100.0)
      : 0.0;

  final effectiveCompliance = compliance != null
      ? UserComplianceMetrics(
          compliant: compliance.compliant,
          overdueCount: compliance.overdueCount,
          upcomingCount: compliance.upcomingCount,
          complianceRate: enrollmentBasedRate,
          totalCertificates: compliance.totalCertificates,
          waivedCount: compliance.waivedCount,
        )
      : UserComplianceMetrics(
          compliant: completed.length == enrollments.length,
          overdueCount: 0,
          upcomingCount: 0,
          complianceRate: enrollmentBasedRate,
          totalCertificates: 0,
          waivedCount: 0,
        );

  return DashboardSummary(
    user: user,
    inProgress: inProgress,
    toDo: toDo,
    completed: completed,
    compliance: effectiveCompliance,
    assignments: assignments,
    monthlyHours: monthlyHours,
    complianceAlerts: alerts,
    averageQuizScore: avgScore,
    upcomingDueDates: dueDates,
    recentActivity: activity,
    weeklyProgress: weeklyProg,
    learningStreak: streak,
    totalHoursThisYear: totalHours,
  );
});
