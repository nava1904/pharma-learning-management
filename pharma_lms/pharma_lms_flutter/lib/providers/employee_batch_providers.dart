// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE BATCH PROVIDERS (roster-backed; no org-wide batch leakage)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'user_provider.dart';

/// Batches the signed-in user appears on in [training_batch_participant].
final employeeBatchesProvider = FutureProvider<List<TrainingBatch>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  try {
    return await client.trainingBatch.listBatchesForCurrentUser();
  } catch (_) {
    return [];
  }
});

/// Upcoming (scheduled, future start) among roster batches.
final employeeUpcomingSessionsProvider = FutureProvider<List<TrainingBatch>>((ref) async {
  final batches = await ref.watch(employeeBatchesProvider.future);
  final now = DateTime.now();
  return batches
      .where((b) => b.startDate.isAfter(now) && b.status == 'scheduled')
      .toList()
    ..sort((a, b) => a.startDate.compareTo(b.startDate));
});

final employeeBatchStatsProvider = FutureProvider<EmployeeBatchStats>((ref) async {
  final batches = await ref.watch(employeeBatchesProvider.future);
  final now = DateTime.now();
  return EmployeeBatchStats(
    totalEnrolled: batches.length,
    upcomingSessions: batches.where((b) => b.status == 'scheduled' && b.startDate.isAfter(now)).length,
    inProgress: batches.where((b) => b.status == 'in_progress' || b.status == 'active').length,
    completed: batches.where((b) => b.status == 'completed').length,
  );
});

final employeeBatchDetailProvider = FutureProvider.family<TrainingBatch?, int>((ref, batchId) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  try {
    return await client.trainingBatch.getBatch(batchId);
  } catch (_) {
    return null;
  }
});

final employeeBatchParticipantsProvider =
    FutureProvider.autoDispose.family<List<BatchParticipantInfo>, int>((ref, batchId) async {
  return client.trainingBatch.listBatchParticipantsForEmployee(batchId);
});

final employeeBatchCohortProgressProvider =
    FutureProvider.autoDispose.family<Map<String, dynamic>, int>((ref, batchId) async {
  return client.trainingBatch.getBatchCohortProgress(batchId);
});

/// All enrollments for the current user (for batch course progress + due dates).
final employeeUserEnrollmentsProvider = FutureProvider<List<Enrollment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.training.getEnrollmentsForUser(user!.id!);
  } catch (_) {
    return [];
  }
});

/// Active assignments for the current user (server filters status).
final employeeUserAssignmentsProvider = FutureProvider<List<TrainingAssignment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  try {
    return await client.training.getAssignmentsForUser(user!.id!);
  } catch (_) {
    return [];
  }
});

class EmployeeBatchStats {
  final int totalEnrolled;
  final int upcomingSessions;
  final int inProgress;
  final int completed;

  EmployeeBatchStats({
    required this.totalEnrolled,
    required this.upcomingSessions,
    required this.inProgress,
    required this.completed,
  });
}
