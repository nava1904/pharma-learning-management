import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';

/// Analytics & Reporting domain endpoint.
class AnalyticsEndpoint extends Endpoint {
  /// Training completion rate by department.
  Future<Map<String, double>> getTrainingCompletionRate(
    Session session, {
    int? organizationId,
  }) async {
    final departments = await Department.db.find(session);
    final result = <String, double>{};

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      result[dept.name] = metrics.complianceRate;
    }
    return result;
  }

  /// Department compliance summary.
  Future<List<DepartmentComplianceSummary>> getDepartmentComplianceSummary(
    Session session,
  ) async {
    final departments = await Department.db.find(session);
    final result = <DepartmentComplianceSummary>[];

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      result.add(DepartmentComplianceSummary(
        departmentId: dept.id,
        departmentName: dept.name,
        totalEmployees: metrics.totalEmployees,
        compliant: metrics.compliant,
        overdue: metrics.overdue,
        upcoming: metrics.upcoming,
        complianceRate: metrics.complianceRate,
      ));
    }
    return result;
  }

  /// Certification expiry risk - count of certs expiring in next 30 days.
  Future<int> getCertificationExpiryRiskCount(
    Session session, {
    int? organizationId,
  }) async {
    final now = DateTime.now();
    final threshold = now.add(const Duration(days: 30));

    final certs = await Certificate.db.find(session);
    var count = 0;
    for (final cert in certs) {
      if (cert.expiresAt != null &&
          cert.expiresAt!.isAfter(now) &&
          cert.expiresAt!.isBefore(threshold)) {
        count++;
      }
    }
    return count;
  }

  /// Audit readiness score - based on compliance and audit trail completeness.
  Future<AuditReadinessScore> getAuditReadinessScore(
    Session session, {
    int? organizationId,
  }) async {
    final departments = await Department.db.find(session);
    var totalCompliance = 0.0;
    var deptCount = 0;

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      totalCompliance += metrics.complianceRate;
      deptCount++;
    }

    final avgCompliance = deptCount > 0 ? totalCompliance / deptCount : 0.0;
    final auditTrailCount = await AuditTrail.db.find(session, limit: 1);
    final hasAuditTrail = auditTrailCount.isNotEmpty;

    return AuditReadinessScore(
      complianceScore: avgCompliance,
      auditTrailActive: hasAuditTrail,
      departmentCount: deptCount,
      overallScore: avgCompliance * (hasAuditTrail ? 1.0 : 0.9),
    );
  }

  Future<List<ReportDefinition>> listReportDefinitions(
    Session session,
  ) async {
    return await ReportDefinition.db.find(session);
  }

  Future<List<Dashboard>> listDashboards(
    Session session, {
    int? roleId,
  }) async {
    var results = await Dashboard.db.find(session);
    if (roleId != null) {
      results = results.where((d) => d.roleId == roleId).toList();
    }
    return results;
  }

  Future<List<SlaBreach>> getOpenSlaBreaches(Session session) async {
    final breaches = await SlaBreach.db.find(session);
    return breaches.where((b) => b.resolvedAt == null).toList();
  }
}
