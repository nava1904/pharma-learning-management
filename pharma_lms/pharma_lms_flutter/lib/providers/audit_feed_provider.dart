import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'admin_providers.dart';

final auditFeedProvider = FutureProvider<List<AuditTrail>>((ref) async {
  final client = ref.watch(serverpodClientProvider);
  // Call the backend endpoint to get the last 10 audit events
  return await client.auditFeed.getRecentAuditEvents();
});
