import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Compliance calculation service for department/site compliance metrics.
class ComplianceCalculatorService {
  /// Calculate compliance rate for a department.
  /// Returns: total employees, compliant count, overdue count, upcoming count, rate.
  static Future<ComplianceMetrics> getDepartmentCompliance(
    Session session, {
    required int departmentId,
    DateTime? asOf,
  }) async {
    final cutoff = asOf ?? DateTime.now();

    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.departmentId.equals(departmentId),
    );

    var compliant = 0;
    var overdue = 0;
    var upcoming = 0;

    for (final user in users) {
      final certs = await Certificate.db.find(
        session,
        where: (t) => t.userId.equals(user.id!),
      );

      var isCompliant = true;
      var hasOverdue = false;
      var hasUpcoming = false;

      for (final cert in certs) {
        if (cert.expiresAt != null) {
          if (cert.expiresAt!.isBefore(cutoff)) {
            hasOverdue = true;
            isCompliant = false;
          } else {
            final daysUntilExpiry =
                cert.expiresAt!.difference(cutoff).inDays;
            if (daysUntilExpiry <= 30) {
              hasUpcoming = true;
            }
          }
        }
      }

      if (isCompliant) compliant++;
      if (hasOverdue) overdue++;
      if (hasUpcoming) upcoming++;
    }

    final total = users.length;
    final rate = total > 0 ? (compliant / total * 100) : 0.0;

    return ComplianceMetrics(
      totalEmployees: total,
      compliant: compliant,
      overdue: overdue,
      upcoming: upcoming,
      complianceRate: rate,
    );
  }

  /// Get compliance status for a single user.
  /// Returns: compliant, overdueCount, upcomingCount, complianceRate.
  static Future<UserComplianceMetrics> getUserCompliance(
    Session session, {
    required int userId,
    DateTime? asOf,
  }) async {
    final cutoff = asOf ?? DateTime.now();

    final certs = await Certificate.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    var compliant = true;
    var overdueCount = 0;
    var upcomingCount = 0;

    for (final cert in certs) {
      if (cert.expiresAt != null) {
        if (cert.expiresAt!.isBefore(cutoff)) {
          overdueCount++;
          compliant = false;
        } else {
          final daysUntilExpiry = cert.expiresAt!.difference(cutoff).inDays;
          if (daysUntilExpiry <= 30) {
            upcomingCount++;
          }
        }
      }
    }

    final total = certs.length;
    final rate = total > 0 ? (compliant ? 100.0 : 0.0) : 100.0;

    return UserComplianceMetrics(
      compliant: compliant,
      overdueCount: overdueCount,
      upcomingCount: upcomingCount,
      complianceRate: rate,
      totalCertificates: total,
    );
  }

  /// Check if compliance is below threshold for a department.
  static Future<bool> isBelowThreshold(
    Session session, {
    required int departmentId,
    required double threshold,
  }) async {
    final metrics =
        await getDepartmentCompliance(session, departmentId: departmentId);
    return metrics.complianceRate < threshold;
  }
}
