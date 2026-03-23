import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import '../../core/client.dart';

/// Provider to fetch access reviews for a given windowId
final accessReviewProvider = FutureProvider.family<List<AccessReview>, int>((ref, windowId) async {
  // Use the global client from core/client.dart
  return await client.accessReview.getAccessReviews(windowId);
});
