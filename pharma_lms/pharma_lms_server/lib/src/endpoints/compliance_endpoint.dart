import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';

/// Compliance Engine domain endpoint.
class ComplianceEndpoint extends Endpoint {
  Future<ComplianceMetrics> getDepartmentCompliance(
    Session session,
    int departmentId, {
    DateTime? asOf,
  }) async {
    return await ComplianceCalculatorService.getDepartmentCompliance(
      session,
      departmentId: departmentId,
      asOf: asOf,
    );
  }

  Future<UserComplianceMetrics> getUserCompliance(
    Session session,
    int userId, {
    DateTime? asOf,
  }) async {
    return await ComplianceCalculatorService.getUserCompliance(
      session,
      userId: userId,
      asOf: asOf,
    );
  }

  Future<bool> isDepartmentBelowThreshold(
    Session session, {
    required int departmentId,
    required double threshold,
  }) async {
    return await ComplianceCalculatorService.isBelowThreshold(
      session,
      departmentId: departmentId,
      threshold: threshold,
    );
  }
}
