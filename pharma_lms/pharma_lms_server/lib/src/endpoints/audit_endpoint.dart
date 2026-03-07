import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Audit & Validation domain endpoint - for QA and auditor access.
class AuditEndpoint extends Endpoint {
  Future<List<AuditTrail>> getAuditTrail(
    Session session, {
    String? entityType,
    String? entityId,
    int? userId,
    DateTime? from,
    DateTime? to,
    int limit = 100,
  }) async {
    var results = await AuditTrail.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit * 2,
      include: AuditTrail.include(user: PharmaUser.include()),
    );

    if (entityType != null) {
      results = results.where((r) => r.entityType == entityType).toList();
    }
    if (entityId != null) {
      results = results.where((r) => r.entityId == entityId).toList();
    }
    if (userId != null) {
      results = results.where((r) => r.userId == userId).toList();
    }
    if (from != null) {
      results =
          results.where((r) => !r.timestamp.isBefore(from!)).toList();
    }
    if (to != null) {
      results =
          results.where((r) => !r.timestamp.isAfter(to!)).toList();
    }

    return results.take(limit).toList();
  }

  Future<List<AccessLog>> getAccessLogs(
    Session session, {
    int? userId,
    DateTime? from,
    DateTime? to,
    int limit = 100,
  }) async {
    var results = await AccessLog.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit * 2,
    );

    if (userId != null) {
      results = results.where((r) => r.userId == userId).toList();
    }
    if (from != null) {
      results =
          results.where((r) => !r.timestamp.isBefore(from!)).toList();
    }
    if (to != null) {
      results =
          results.where((r) => !r.timestamp.isAfter(to!)).toList();
    }

    return results.take(limit).toList();
  }
}
