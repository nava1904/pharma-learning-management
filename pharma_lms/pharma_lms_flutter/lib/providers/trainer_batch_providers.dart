// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER BATCH PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════
// Providers for trainer-specific batch/cohort management.
// Trainers see batches they are assigned to instruct.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'user_provider.dart';

// ─── TRAINER BATCHES PROVIDER ─────────────────────────────────────────────────
/// Fetches batches assigned to the current trainer/instructor.
final trainerBatchesProvider = FutureProvider<List<TrainingBatch>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  
  try {
    // Fetch all batches for the organization
    final allBatches = await client.trainingBatch.listBatches(
      organizationId: user.organizationId,
    );
    
    // Filter to batches where this user is the instructor
    return allBatches.where((b) => b.instructorId == user.id).toList();
  } catch (e) {
    print('Error fetching trainer batches: $e');
    return [];
  }
});

// ─── TRAINER BATCH STATS PROVIDER ─────────────────────────────────────────────
/// Gets stats for trainer's assigned batches.
final trainerBatchStatsProvider = FutureProvider<TrainerBatchStats>((ref) async {
  final batches = await ref.watch(trainerBatchesProvider.future);
  
  final now = DateTime.now();
  
  return TrainerBatchStats(
    totalBatches: batches.length,
    activeBatches: batches.where((b) => b.status == 'in_progress' || b.status == 'active').length,
    upcomingBatches: batches.where((b) => 
      b.status == 'scheduled' && b.startDate.isAfter(now)
    ).length,
    completedBatches: batches.where((b) => b.status == 'completed').length,
    totalParticipants: batches.fold(0, (sum, b) => sum + b.enrolledCount),
    completedParticipants: batches.fold(0, (sum, b) => sum + b.completedCount),
  );
});

// ─── TRAINER BATCH DETAIL PROVIDER ────────────────────────────────────────────
/// Fetches details for a specific batch.
final trainerBatchDetailProvider = FutureProvider.family<TrainingBatch?, int>((ref, batchId) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  
  try {
    return await client.trainingBatch.getBatch(batchId);
  } catch (e) {
    print('Error fetching batch detail: $e');
    return null;
  }
});

// ─── BATCH PARTICIPANTS PROVIDER ──────────────────────────────────────────────
/// Fetches participants enrolled in a batch.
/// Note: This requires a batch enrollment table/endpoint to be implemented.
/// For now returns mock data structure.
final batchParticipantsProvider = FutureProvider.family<List<BatchParticipant>, int>((ref, batchId) async {
  // In production, this would call an endpoint like:
  // client.trainingBatch.getBatchParticipants(batchId)
  // For now, return empty list - will be implemented when enrollment linking is ready
  return [];
});

// ─── STATS MODEL ──────────────────────────────────────────────────────────────
class TrainerBatchStats {
  final int totalBatches;
  final int activeBatches;
  final int upcomingBatches;
  final int completedBatches;
  final int totalParticipants;
  final int completedParticipants;

  TrainerBatchStats({
    required this.totalBatches,
    required this.activeBatches,
    required this.upcomingBatches,
    required this.completedBatches,
    required this.totalParticipants,
    required this.completedParticipants,
  });
  
  double get completionRate => 
    totalParticipants > 0 ? (completedParticipants / totalParticipants * 100) : 0;
}

// ─── PARTICIPANT MODEL ────────────────────────────────────────────────────────
class BatchParticipant {
  final int userId;
  final String name;
  final String email;
  final String department;
  final String status; // enrolled, in_progress, completed, absent
  final double progressPercent;
  final DateTime? completedAt;
  final bool attended;

  BatchParticipant({
    required this.userId,
    required this.name,
    required this.email,
    required this.department,
    required this.status,
    required this.progressPercent,
    this.completedAt,
    this.attended = false,
  });
}
