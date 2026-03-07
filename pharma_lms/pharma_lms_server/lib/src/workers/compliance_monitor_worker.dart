import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';

/// Background worker that monitors department compliance and creates
/// SLA breaches when below threshold.
class ComplianceMonitorWorker extends FutureCall {
  Future<void> run(Session session) async {
    final policies = await SlaPolicy.db.find(session);

    for (final policy in policies) {
      final departments = await Department.db.find(session);

      for (final dept in departments) {
        if (dept.id == null) continue;

        final isBelow = await ComplianceCalculatorService.isBelowThreshold(
          session,
          departmentId: dept.id!,
          threshold: policy.threshold,
        );

        if (isBelow) {
          final existing = await SlaBreach.db.find(
            session,
            where: (t) => t.slaPolicyId.equals(policy.id!),
          );
          final unresolved = existing.where((b) => b.resolvedAt == null);

          if (unresolved.isEmpty) {
            await SlaBreach.db.insertRow(
              session,
              SlaBreach(slaPolicyId: policy.id!),
            );
          }
        }
      }
    }
  }
}
