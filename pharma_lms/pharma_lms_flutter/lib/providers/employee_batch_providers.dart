// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE BATCH PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════
// Providers for employee-facing batch/training session views.
// Employees see batches they are enrolled in.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'user_provider.dart';

// ─── EMPLOYEE BATCHES PROVIDER ────────────────────────────────────────────────
/// Fetches batches the current employee is enrolled in.
/// Note: This requires batch enrollment linking to be fully implemented.
/// For now, returns all scheduled/active batches for the organization.
final employeeBatchesProvider = FutureProvider<List<TrainingBatch>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  
  try {
    // In production, this would filter by user's enrollment
    // For now, get all batches with status scheduled or in_progress
    final allBatches = await client.trainingBatch.listBatches(
      organizationId: user.organizationId,
    );
    
    // Filter to scheduled and active batches (employee would see upcoming and current training)
    return allBatches.where((b) => 
      b.status == 'scheduled' || 
      b.status == 'in_progress' ||
      b.status == 'active'
    ).toList();
  } catch (e) {
    print('Error fetching employee batches: $e');
    return [];
  }
});

// ─── EMPLOYEE UPCOMING SESSIONS PROVIDER ──────────────────────────────────────
/// Fetches upcoming training sessions for the employee.
final employeeUpcomingSessionsProvider = FutureProvider<List<TrainingBatch>>((ref) async {
  final batches = await ref.watch(employeeBatchesProvider.future);
  final now = DateTime.now();
  
  return batches
    .where((b) => b.startDate.isAfter(now) && b.status == 'scheduled')
    .toList()
    ..sort((a, b) => a.startDate.compareTo(b.startDate));
});

// ─── EMPLOYEE BATCH STATS PROVIDER ────────────────────────────────────────────
/// Gets stats for employee's enrolled batches.
final employeeBatchStatsProvider = FutureProvider<EmployeeBatchStats>((ref) async {
  final batches = await ref.watch(employeeBatchesProvider.future);
  final now = DateTime.now();
  
  return EmployeeBatchStats(
    totalEnrolled: batches.length,
    upcomingSessions: batches.where((b) => 
      b.status == 'scheduled' && b.startDate.isAfter(now)
    ).length,
    inProgress: batches.where((b) => 
      b.status == 'in_progress' || b.status == 'active'
    ).length,
    completed: batches.where((b) => b.status == 'completed').length,
  );
});

// ─── EMPLOYEE BATCH DETAIL PROVIDER ───────────────────────────────────────────
/// Fetches details for a specific batch.
final employeeBatchDetailProvider = FutureProvider.family<TrainingBatch?, int>((ref, batchId) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  
  try {
    return await client.trainingBatch.getBatch(batchId);
  } catch (e) {
    print('Error fetching batch detail: $e');
    return null;
  }
});

// ─── EMPLOYEE SESSION ENROLLMENT PROVIDER ─────────────────────────────────────
/// Gets the employee's enrollment status for a specific batch.
/// Note: Requires batch enrollment linking.
final employeeSessionEnrollmentProvider = FutureProvider.family<EmployeeSessionEnrollment?, int>((ref, batchId) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  
  // In production, this would fetch from batch_enrollment table
  // For now, return a default enrolled status
  return EmployeeSessionEnrollment(
    batchId: batchId,
    userId: user.id ?? 0,
    status: 'enrolled',
    enrolledAt: DateTime.now().subtract(const Duration(days: 7)),
    progressPercent: 0,
    attended: false,
  );
});

// ─── STATS MODEL ──────────────────────────────────────────────────────────────
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

// ─── ENROLLMENT MODEL ─────────────────────────────────────────────────────────
class EmployeeSessionEnrollment {
  final int batchId;
  final int userId;
  final String status; // enrolled, in_progress, completed, cancelled
  final DateTime enrolledAt;
  final double progressPercent;
  final DateTime? completedAt;
  final bool attended;
  final int? score;

  EmployeeSessionEnrollment({
    required this.batchId,
    required this.userId,
    required this.status,
    required this.enrolledAt,
    required this.progressPercent,
    this.completedAt,
    this.attended = false,
    this.score,
  });
}
