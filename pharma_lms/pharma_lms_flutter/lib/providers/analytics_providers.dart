import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'user_provider.dart';

/// Department compliance summary.
final departmentComplianceSummaryProvider =
    FutureProvider<List<DepartmentComplianceSummary>>((ref) async {
  return client.analytics.getDepartmentComplianceSummary();
});

/// Audit readiness score.
final auditReadinessScoreProvider = FutureProvider<AuditReadinessScore?>((ref) async {
  return client.analytics.getAuditReadinessScore();
});

/// Non-compliant employees.
final nonCompliantEmployeesProvider =
    FutureProvider<List<PharmaUser>>((ref) async {
  return client.analytics.getNonCompliantEmployees();
});

/// Upcoming expirations by department.
final upcomingExpirationsByDeptProvider =
    FutureProvider<Map<String, List<Certificate>>>((ref) async {
  return client.analytics.getUpcomingExpirationsByDepartment();
});

/// Recent assignments (last 10).
final recentAssignmentsProvider =
    FutureProvider<List<TrainingAssignment>>((ref) async {
  return client.analytics.getRecentAssignments(limit: 10);
});

/// Open CAPAs requiring training.
final openCapasRequiringTrainingProvider =
    FutureProvider<List<Capa>>((ref) async {
  return client.analytics.getOpenCapasRequiringTraining();
});

/// Pending QA approvals count.
final pendingQaApprovalsCountProvider = FutureProvider<int>((ref) async {
  return client.analytics.getPendingQaApprovalsCount();
});

/// SOP retraining queue.
final sopRetrainingQueueProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return client.analytics.getSopRetrainingQueue();
});

/// DLQ failure count (system alerts).
final dlqFailureCountProvider = FutureProvider<int>((ref) async {
  return client.analytics.getDlqFailureCount();
});

/// Recent activity for current user.
final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.analytics.getRecentActivity(user!.id!);
});

/// Real-time analytics stream. Use with StreamBuilder for live dashboard updates.
/// Channel: 'compliance', 'dept:{deptId}', 'course:{courseVersionId}', 'audit_readiness'.
final analyticsStreamProvider = StreamProvider.family<AnalyticsEvent, String>((ref, channel) {
  return client.analytics.streamAnalytics(channel);
});
