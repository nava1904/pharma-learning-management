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
        where: (t) =>
            t.userId.equals(user.id!) &
            t.status.notEquals('obsolete'),
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
  /// Returns: compliant, overdueCount, upcomingCount, complianceRate, waivedCount.
  /// ADM-07: Approved waivers count as satisfied for that course requirement.
  static Future<UserComplianceMetrics> getUserCompliance(
    Session session, {
    required int userId,
    DateTime? asOf,
  }) async {
    final cutoff = asOf ?? DateTime.now();

    final certs = await Certificate.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.status.notEquals('obsolete'),
    );

    final allWaivers = await TrainingWaiver.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('approved'),
    );
    final waivers = allWaivers.where((w) =>
        w.expiresAt == null || !w.expiresAt!.isBefore(cutoff)).toList();

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

    final totalCerts = certs.length;
    final waivedCount = waivers.length;

    final enrollments = await Enrollment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    final totalEnrollments = enrollments.length;
    final completedEnrollments = enrollments.where((e) => e.status == 'completed').length;

    final assignments = await TrainingAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
    );
    final overdueAssignments = assignments.where((a) =>
      a.dueDate.isBefore(cutoff)
    ).length;

    overdueCount += overdueAssignments;
    if (overdueAssignments > 0) compliant = false;

    final rate = totalEnrollments > 0
        ? (completedEnrollments / totalEnrollments * 100.0)
        : 100.0;

    return UserComplianceMetrics(
      compliant: compliant,
      overdueCount: overdueCount,
      upcomingCount: upcomingCount,
      complianceRate: rate,
      totalCertificates: totalCerts,
      waivedCount: waivedCount,
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
