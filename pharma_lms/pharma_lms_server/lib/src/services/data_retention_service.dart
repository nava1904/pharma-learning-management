import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Data retention and archival service.
/// Applies retention policies (e.g. audit_trail 7 years) and archives old data.
class DataRetentionService {
  /// Default retention policies when none are configured.
  static const Map<String, int> defaultPolicies = {
    'audit_trail': 7,
    'access_log': 7,
    'scheduled_job_log': 2,
    'notification': 2,
  };

  /// Get effective retention years for an entity type.
  static Future<int> getRetentionYears(Session session, String entityType) async {
    final policy = await RetentionPolicy.db.findFirstRow(
      session,
      where: (t) => t.entityType.equals(entityType),
    );
    if (policy != null) return policy.retentionYears;
    return defaultPolicies[entityType] ?? 7;
  }

  /// Ensure retention policies exist in DB. Seeds defaults if empty.
  static Future<void> ensurePolicies(Session session) async {
    final existing = await RetentionPolicy.db.find(session);
    if (existing.isNotEmpty) return;

    for (final entry in defaultPolicies.entries) {
      await RetentionPolicy.db.insertRow(
        session,
        RetentionPolicy(
          entityType: entry.key,
          retentionYears: entry.value,
          archiveEnabled: true,
        ),
      );
    }
  }

  /// Archive audit_trail records older than retention period.
  /// Copies to retention_archive; does not delete (21 CFR Part 11 compliance).
  static Future<int> archiveAuditTrail(Session session) async {
    final retentionYears = await getRetentionYears(session, 'audit_trail');
    final cutoff = DateTime.now().subtract(Duration(days: retentionYears * 365));

    final toArchive = await AuditTrail.db.find(
      session,
      where: (t) => t.timestamp < cutoff,
      limit: 500,
    );

    var count = 0;
    for (final row in toArchive) {
      final existing = await RetentionArchive.db.findFirstRow(
        session,
        where: (t) =>
            t.entityType.equals('audit_trail') &
            t.entityId.equals(row.id.toString()),
      );
      if (existing != null) continue;

      await RetentionArchive.db.insertRow(
        session,
        RetentionArchive(
          entityType: 'audit_trail',
          entityId: row.id.toString(),
          rowJson: _auditTrailToJson(row),
        ),
      );
      count++;
    }
    return count;
  }

  static String _auditTrailToJson(AuditTrail row) {
    return jsonEncode(row.toJson());
  }

  /// Update lastArchivedAt for a policy.
  static Future<void> updateLastArchived(
    Session session,
    String entityType,
  ) async {
    final policy = await RetentionPolicy.db.findFirstRow(
      session,
      where: (t) => t.entityType.equals(entityType),
    );
    if (policy != null) {
      await RetentionPolicy.db.updateRow(
        session,
        policy.copyWith(lastArchivedAt: DateTime.now()),
      );
    }
  }
}
