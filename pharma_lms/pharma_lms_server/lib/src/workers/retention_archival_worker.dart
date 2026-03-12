import 'package:serverpod/serverpod.dart';

import '../services/data_retention_service.dart';

/// Background worker for data retention and archival.
/// Runs periodically to archive records per retention policies (e.g. audit_trail 7 years).
/// Self-reschedules daily.
class RetentionArchivalWorker extends FutureCall {
  static const Duration _rescheduleInterval = Duration(hours: 24);

  Future<void> run(Session session) async {
    // Schedule next run
    await session.serverpod.endpoints.futureCalls!
        .callWithDelay(_rescheduleInterval)
        .retentionArchivalWorker
        .run();

    await _doWork(session);
  }

  Future<void> _doWork(Session session) async {
    await DataRetentionService.ensurePolicies(session);

    var totalArchived = 0;

    // Archive audit_trail records older than retention period
    final auditCount = await DataRetentionService.archiveAuditTrail(session);
    totalArchived += auditCount;
    if (auditCount > 0) {
      await DataRetentionService.updateLastArchived(session, 'audit_trail');
    }

    if (totalArchived > 0) {
      session.log(
        '[RetentionArchivalWorker] Archived $totalArchived records (audit_trail: $auditCount)',
      );
    }
  }
}
