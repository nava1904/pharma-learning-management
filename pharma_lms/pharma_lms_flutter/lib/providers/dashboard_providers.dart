import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'repository_providers.dart';
import 'user_provider.dart';

// ─── Enrollment metrics (single source for dashboard widgets) ─────────────────

/// Matches [ComplianceCalculatorService.getUserCompliance]: completion ratio.
double computeComplianceScorePercent(List<Enrollment> enrollments) {
  if (enrollments.isEmpty) return 100.0;
  final completed =
      enrollments.where((e) => e.status == 'completed').length;
  return completed / enrollments.length * 100.0;
}

/// Legend buckets: complete | in-progress pipeline | overdue (each enrollment once).
({int complete, int inProgress, int overdue}) computeEnrollmentStatusBuckets({
  required List<Enrollment> enrollments,
  required List<TrainingAssignment> assignments,
}) {
  final now = DateTime.now();
  final overdueCvIds = <int>{};
  for (final a in assignments) {
    // Align with server: active assignments past due only (see getAssignmentsForUser).
    if (a.status == 'active' && a.dueDate.isBefore(now)) {
      overdueCvIds.add(a.courseVersionId);
    }
  }

  var complete = 0;
  var inProgress = 0;
  var overdue = 0;

  for (final e in enrollments) {
    if (e.status == 'completed') {
      complete++;
      continue;
    }
    final assignmentOverdue = overdueCvIds.contains(e.courseVersionId);
    if (e.status == 'overdue' || assignmentOverdue) {
      overdue++;
    } else {
      inProgress++;
    }
  }

  return (complete: complete, inProgress: inProgress, overdue: overdue);
}

void _logDashboardAnalytics(String name, Object error, StackTrace stackTrace) {
  debugPrint('[Dashboard] $name failed: $error');
  debugPrint('$stackTrace');
}

/// Same row shape as [AnalyticsEndpoint.getOverdueDashboardItems] when the analytics
/// call fails or returns empty but training/certificate data is available locally.
List<Map<String, dynamic>> buildOverdueItemsFallback({
  required List<TrainingAssignment> assignments,
  required List<Certificate> certificates,
}) {
  final now = DateTime.now();
  final items = <Map<String, dynamic>>[];
  for (final a in assignments) {
    if (a.status != 'active') continue;
    if (!a.dueDate.isBefore(now)) continue;
    final course = a.courseVersion?.course;
    final daysOverdue = now.difference(a.dueDate).inDays;
    final sop = course?.sopNumber;
    items.add({
      'kind': 'assignment',
      'assignmentId': a.id,
      'courseTitle': course?.title ?? 'Training',
      'courseCategory': course?.category,
      'sopNumber': sop,
      'regulatoryTag': course?.category ??
          (sop != null && sop.isNotEmpty ? sop : 'GMP'),
      'daysOverdue': daysOverdue,
      'isOverdue': true,
    });
  }
  for (final c in certificates) {
    if (c.status == 'obsolete') continue;
    if (c.expiresAt == null || !c.expiresAt!.isBefore(now)) continue;
    final course = c.courseVersion?.course;
    final daysOverdue = now.difference(c.expiresAt!).inDays;
    items.add({
      'kind': 'certificate_expired',
      'certificateId': c.id,
      'courseTitle': course?.title ?? 'Certificate',
      'courseCategory': course?.category,
      'sopNumber': course?.sopNumber,
      'regulatoryTag': course?.category ?? 'Compliance',
      'daysOverdue': daysOverdue,
      'isOverdue': true,
    });
  }
  items.sort(
    (a, b) => (b['daysOverdue'] as int).compareTo(a['daysOverdue'] as int),
  );
  return items;
}

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
  } catch (e, st) {
    _logDashboardAnalytics('getMonthlyTrainingHours', e, st);
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
  } catch (e, st) {
    _logDashboardAnalytics('getWeeklyLearningProgress', e, st);
    return [];
  }
});

/// User's average assessment score (legacy field name: averageQuizScore on server).
final userAverageQuizScoreProvider = FutureProvider<double>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return 0.0;
  try {
    return await client.analytics.getUserAverageQuizScore(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getUserAverageQuizScore', e, st);
    return 0.0;
  }
});

/// Completed assessment attempts count (for N/A vs real 0% performance).
final userCompletedAssessmentAttemptCountProvider =
    FutureProvider<int>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return 0;
  try {
    return await client.analytics
        .getUserCompletedAssessmentAttemptCount(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getUserCompletedAssessmentAttemptCount', e, st);
    return 0;
  }
});

/// E-signature readiness rows for learner dashboard.
final esignatureSummaryProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.compliance.getEsignatureSummaryForUser(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getEsignatureSummaryForUser', e, st);
    return [];
  }
});

/// Compliance alerts for current user.
final complianceAlertsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getComplianceAlerts(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getComplianceAlerts', e, st);
    return [];
  }
});

/// Upcoming due dates for current user.
final upcomingDueDatesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getUpcomingDueDates(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getUpcomingDueDates', e, st);
    return [];
  }
});

/// Recent activity for current user (last 5 training actions).
final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getRecentActivity(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getRecentActivity', e, st);
    return [];
  }
});

/// Overdue assignments + expired certificates (aligned with compliance overdue count).
final overdueDashboardItemsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.analytics.getOverdueDashboardItems(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getOverdueDashboardItems', e, st);
    return [];
  }
});

/// User's learning streak (consecutive days of activity).
final learningStreakProvider = FutureProvider<int>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return 0;
  try {
    return await client.analytics.getUserLearningStreak(user!.id!);
  } catch (e, st) {
    _logDashboardAnalytics('getUserLearningStreak', e, st);
    return 0;
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// CONSOLIDATED DASHBOARD SUMMARY
// ═══════════════════════════════════════════════════════════════════════════════

/// Invalidates every provider [dashboardSummaryProvider] depends on, then the summary.
/// Use on pull-to-refresh: Riverpod keeps cached [FutureProvider] results unless
/// those providers are invalidated — invalidating only the summary does not refetch.
void invalidateEmployeeDashboard(WidgetRef ref) {
  ref.invalidate(enrollmentsProvider);
  ref.invalidate(userComplianceProvider);
  ref.invalidate(assignmentsProvider);
  ref.invalidate(monthlyTrainingHoursProvider);
  ref.invalidate(complianceAlertsProvider);
  ref.invalidate(userAverageQuizScoreProvider);
  ref.invalidate(userCompletedAssessmentAttemptCountProvider);
  ref.invalidate(upcomingDueDatesProvider);
  ref.invalidate(recentActivityProvider);
  ref.invalidate(weeklyLearningProgressProvider);
  ref.invalidate(learningStreakProvider);
  ref.invalidate(esignatureSummaryProvider);
  ref.invalidate(overdueDashboardItemsProvider);
  ref.invalidate(certificatesProvider);
  ref.invalidate(dashboardSummaryProvider);
}

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
  /// Mean score across completed attempts; use [hasAssessmentScores] before display.
  final int completedAssessmentAttemptCount;
  final bool hasAssessmentScores;
  /// Clamped 0–100; null when [hasAssessmentScores] is false.
  final double? performanceScorePercent;
  /// Same formula as server compliance rate: completed/total×100 or 100 if none.
  final double complianceScorePercent;
  final int enrollmentCompleteCount;
  final int enrollmentInProgressCount;
  final int enrollmentOverdueCount;
  final List<Map<String, dynamic>> upcomingDueDates;
  /// Same source as banner overdue count: active assignments past due + expired certs.
  final List<Map<String, dynamic>> overdueItems;
  final List<Map<String, dynamic>> recentActivity;
  final List<Map<String, dynamic>> weeklyProgress;
  final List<Map<String, dynamic>> esignatureSummary;
  final int learningStreak;
  final double totalHoursThisYear;
  final DateTime fetchedAt;
  /// Server compliance reports overdue items, but no rows were returned from analytics
  /// and local assignment/certificate fallback could not build a list either.
  final bool overdueDetailIncomplete;

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
    this.completedAssessmentAttemptCount = 0,
    this.hasAssessmentScores = false,
    this.performanceScorePercent,
    this.complianceScorePercent = 0.0,
    this.enrollmentCompleteCount = 0,
    this.enrollmentInProgressCount = 0,
    this.enrollmentOverdueCount = 0,
    this.upcomingDueDates = const [],
    this.overdueItems = const [],
    this.recentActivity = const [],
    this.weeklyProgress = const [],
    this.esignatureSummary = const [],
    this.learningStreak = 0,
    this.totalHoursThisYear = 0.0,
    DateTime? fetchedAt,
    this.overdueDetailIncomplete = false,
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
    ref.watch(userCompletedAssessmentAttemptCountProvider.future),
    ref.watch(upcomingDueDatesProvider.future),
    ref.watch(recentActivityProvider.future),
    ref.watch(weeklyLearningProgressProvider.future),
    ref.watch(learningStreakProvider.future),
    ref.watch(esignatureSummaryProvider.future),
    ref.watch(overdueDashboardItemsProvider.future),
    ref.watch(certificatesProvider.future),
  ]);

  final enrollments = results[0] as List<Enrollment>;
  final compliance = results[1] as UserComplianceMetrics?;
  final assignments = results[2] as List<TrainingAssignment>;
  final monthlyHours = results[3] as List<Map<String, dynamic>>;
  final alerts = results[4] as List<Map<String, dynamic>>;
  final avgScore = results[5] as double;
  final attemptCount = results[6] as int;
  final dueDates = results[7] as List<Map<String, dynamic>>;
  final activity = results[8] as List<Map<String, dynamic>>;
  final weeklyProg = results[9] as List<Map<String, dynamic>>;
  final streak = results[10] as int;
  final esignatureRows = results[11] as List<Map<String, dynamic>>;
  final overdueItemsRaw = results[12] as List<Map<String, dynamic>>;
  final certificates = results[13] as List<Certificate>;

  var mergedOverdue = overdueItemsRaw;
  if (overdueItemsRaw.isEmpty) {
    mergedOverdue = buildOverdueItemsFallback(
      assignments: assignments,
      certificates: certificates,
    );
  }

  final rawComplianceOverdue = compliance?.overdueCount ?? 0;
  final overdueDetailIncomplete =
      mergedOverdue.isEmpty && rawComplianceOverdue > 0;
  final displayOverdueCount = mergedOverdue.isNotEmpty
      ? mergedOverdue.length
      : rawComplianceOverdue;

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

  final enrollmentBasedRate = computeComplianceScorePercent(enrollments);
  final buckets = computeEnrollmentStatusBuckets(
    enrollments: enrollments,
    assignments: assignments,
  );
  final hasScores = attemptCount > 0;
  final perf = hasScores ? avgScore.clamp(0.0, 100.0) : null;

  final effectiveCompliance = compliance != null
      ? UserComplianceMetrics(
          compliant: compliance.compliant,
          overdueCount: displayOverdueCount,
          upcomingCount: compliance.upcomingCount,
          complianceRate: enrollmentBasedRate,
          totalCertificates: compliance.totalCertificates,
          waivedCount: compliance.waivedCount,
        )
      : UserComplianceMetrics(
          compliant: completed.length == enrollments.length && enrollments.isNotEmpty,
          overdueCount: displayOverdueCount,
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
    completedAssessmentAttemptCount: attemptCount,
    hasAssessmentScores: hasScores,
    performanceScorePercent: perf,
    complianceScorePercent: enrollmentBasedRate,
    enrollmentCompleteCount: buckets.complete,
    enrollmentInProgressCount: buckets.inProgress,
    enrollmentOverdueCount: buckets.overdue,
    upcomingDueDates: dueDates,
    overdueItems: mergedOverdue,
    recentActivity: activity,
    weeklyProgress: weeklyProg,
    esignatureSummary: esignatureRows,
    learningStreak: streak,
    totalHoursThisYear: totalHours,
    overdueDetailIncomplete: overdueDetailIncomplete,
  );
});
