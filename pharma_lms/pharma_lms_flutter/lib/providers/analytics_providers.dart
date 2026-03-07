import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';

/// Department compliance summary.
final departmentComplianceSummaryProvider =
    FutureProvider<List<DepartmentComplianceSummary>>((ref) async {
  return client.analytics.getDepartmentComplianceSummary();
});

/// Audit readiness score.
final auditReadinessScoreProvider = FutureProvider<AuditReadinessScore?>((ref) async {
  return client.analytics.getAuditReadinessScore();
});
