import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';

final auditFeedProvider = FutureProvider<List<AuditTrail>>((ref) async {
  return client.auditFeed.getRecentAuditEvents();
});
