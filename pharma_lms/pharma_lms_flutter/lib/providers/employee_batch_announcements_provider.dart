import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import '../core/client.dart';

/// Announcements for a given batch (for employee view)
final employeeBatchAnnouncementsProvider = FutureProvider.family<List<BatchAnnouncement>, int>((ref, batchId) async {
  try {
    return await client.batchAnnouncement.listForBatch(batchId);
  } catch (_) {
    return [];
  }
});
