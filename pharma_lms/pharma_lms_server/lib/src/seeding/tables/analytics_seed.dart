import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds analytics snapshots and department compliance snapshots
/// for realistic trending charts over the past 6 months.
class AnalyticsSeed {
  /// Insert 6 monthly org-wide analytics snapshots.
  static Future<void> insertAnalyticsSnapshots(
    Session session,
    SeedContext ctx,
  ) async {
    final rng = Random(42);
    final totalEmployees = ctx.learnerIds.length +
        ctx.trainerIds.length +
        ctx.qaUserIds.length +
        ctx.adminUserIds.length;

    for (var month = 5; month >= 0; month--) {
      // Compliance improves over time (realistic upward trend)
      final complianceBase = 72.0 + (5 - month) * 4.5;
      final compliantCount =
          (totalEmployees * (complianceBase / 100)).round();
      final overdueCount = totalEmployees - compliantCount - rng.nextInt(5);
      final certExpiring30 = 3 + rng.nextInt(8);
      final certExpiring60 = certExpiring30 + 2 + rng.nextInt(5);

      await AnalyticsSnapshot.db.insertRow(
        session,
        AnalyticsSnapshot(
          snapshotDate: ctx.dt(-30 * month),
          totalEmployees: totalEmployees,
          compliantCount: compliantCount,
          overdueCount: overdueCount.clamp(0, totalEmployees),
          orgComplianceRate:
              double.parse(complianceBase.toStringAsFixed(1)),
          totalCertificates: 40 + (5 - month) * 35 + rng.nextInt(20),
          certsExpiring30d: certExpiring30,
          certsExpiring60d: certExpiring60,
          openAssignments: 60 - month * 8 + rng.nextInt(10),
        ),
      );
    }
  }

  /// Insert department compliance snapshots for all 10 departments × 6 months.
  static Future<void> insertDeptComplianceSnapshots(
    Session session,
    SeedContext ctx,
  ) async {
    final rng = Random(99);
    // Employees per department (learners distributed round-robin across 10 depts)
    final empPerDept = ctx.learnerIds.length ~/ ctx.deptIds.length;

    for (var month = 5; month >= 0; month--) {
      for (var d = 0; d < ctx.deptIds.length; d++) {
        // Each department has slightly different compliance trajectory
        final deptBonus = (d % 3 == 0) ? 5.0 : (d % 3 == 1 ? 0.0 : -3.0);
        final rate = (70.0 + (5 - month) * 4.0 + deptBonus + rng.nextInt(6))
            .clamp(50.0, 100.0);
        final compliant = (empPerDept * rate / 100).round();
        final overdue = (empPerDept * (1 - rate / 100) * 0.6).round();
        final upcoming = empPerDept - compliant - overdue;

        await DepartmentComplianceSnapshot.db.insertRow(
          session,
          DepartmentComplianceSnapshot(
            departmentId: ctx.deptIds[d],
            snapshotDate: ctx.dt(-30 * month),
            totalEmployees: empPerDept,
            compliantCount: compliant,
            overdueCount: overdue.clamp(0, empPerDept),
            upcomingCount: upcoming.clamp(0, empPerDept),
            complianceRate: double.parse(rate.toStringAsFixed(1)),
          ),
        );
      }
    }
  }
}
