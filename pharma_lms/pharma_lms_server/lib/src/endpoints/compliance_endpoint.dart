import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';
import '../services/rbac_helper.dart';

/// Compliance Engine domain endpoint.
class ComplianceEndpoint extends Endpoint {
  Future<ComplianceMetrics> getDepartmentCompliance(
    Session session,
    int departmentId, {
    DateTime? asOf,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return ComplianceMetrics(
        totalEmployees: 0,
        compliant: 0,
        overdue: 0,
        upcoming: 0,
        complianceRate: 0.0,
      );
    }
    await RbacHelper.requirePermission(session, resource: 'compliance', action: 'read');
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return UserComplianceMetrics(
        compliant: true,
        overdueCount: 0,
        upcomingCount: 0,
        complianceRate: 0.0,
        totalCertificates: 0,
      );
    }
    await RbacHelper.requirePermission(session, resource: 'compliance', action: 'read');
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    await RbacHelper.requirePermission(session, resource: 'compliance', action: 'read');
    return await ComplianceCalculatorService.isBelowThreshold(
      session,
      departmentId: departmentId,
      threshold: threshold,
    );
  }
}
