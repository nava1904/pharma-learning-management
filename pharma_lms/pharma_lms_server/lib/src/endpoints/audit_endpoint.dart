import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// Audit & Validation domain endpoint - for QA and auditor access.
class AuditEndpoint extends Endpoint {
  /// Log report export with integrity hash (21 CFR Part 11). Creates ReportExport record.
  Future<void> logReportExport(
    Session session, {
    required String reportType,
    required String hashSha256,
    int? exportedById,
    String? filterParamsJson,
    int? recordCount,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'audit', action: 'read');
    final userId = exportedById;
    if (userId != null) {
      await ReportExport.db.insertRow(
        session,
        ReportExport(
          exportedById: userId,
          reportType: reportType,
          filterParamsJson: filterParamsJson,
          recordCount: recordCount,
          fileHash: hashSha256,
          exportedAt: DateTime.now(),
        ),
      );
    }
    await AuditService.log(
      session,
      entityType: 'report_export',
      entityId: DateTime.now().toIso8601String(),
      action: 'ReportExported',
      newValueJson: '{"reportType":"$reportType","hashSha256":"$hashSha256"}',
      userId: userId,
    );
  }
  Future<List<AuditTrail>> getAuditTrail(
    Session session, {
    String? entityType,
    String? entityId,
    int? userId,
    DateTime? from,
    DateTime? to,
    int limit = 100,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'audit', action: 'read');
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
          results.where((r) => !r.timestamp.isBefore(from)).toList();
    }
    if (to != null) {
      results =
          results.where((r) => !r.timestamp.isAfter(to)).toList();
    }

    return results.take(limit).toList();
  }

  /// Config change log - filter AuditTrail where action=='ConfigChanged' or entityType matches config entities.
  Future<List<AuditTrail>> getConfigChangeLog(
    Session session, {
    String? entityType,
    int limit = 100,
    DateTime? from,
    DateTime? to,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'audit', action: 'read');
    const configEntityTypes = {
      'system_configuration',
      'signature_meaning',
      'training_matrix',
      'job_role',
      'assessment',
      'role',
    };
    var results = await AuditTrail.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit * 2,
      include: AuditTrail.include(user: PharmaUser.include()),
    );
    results = results.where((r) {
      if (r.action == 'ConfigChanged') return true;
      if (configEntityTypes.contains(r.entityType)) return true;
      return false;
    }).toList();
    if (entityType != null) {
      results = results.where((r) => r.entityType == entityType).toList();
    }
    if (from != null) {
      results = results.where((r) => !r.timestamp.isBefore(from)).toList();
    }
    if (to != null) {
      results = results.where((r) => !r.timestamp.isAfter(to)).toList();
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
          results.where((r) => !r.timestamp.isBefore(from)).toList();
    }
    if (to != null) {
      results =
          results.where((r) => !r.timestamp.isAfter(to)).toList();
    }

    return results.take(limit).toList();
  }

  /// Export audit trail as CSV string. Logs the export per 21 CFR Part 11.
  Future<String> exportAuditCsv(
    Session session, {
    String? entityType,
    int? userId,
    DateTime? from,
    DateTime? to,
    int limit = 1000,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'audit', action: 'read');
    
    final trails = await getAuditTrail(
      session,
      entityType: entityType,
      userId: userId,
      from: from,
      to: to,
      limit: limit,
    );
    
    final buffer = StringBuffer();
    buffer.writeln('Timestamp,Entity Type,Entity ID,Action,User ID,Reason,IP Address,Row Hash');
    
    for (final t in trails) {
      final ts = t.timestamp.toIso8601String();
      final et = t.entityType.replaceAll(',', ';');
      final eid = t.entityId.replaceAll(',', ';');
      final act = t.action.replaceAll(',', ';');
      final uid = t.userId?.toString() ?? '';
      final reason = (t.reason ?? '').replaceAll(',', ';').replaceAll('\n', ' ');
      final ip = t.ipAddress ?? '';
      final hash = t.rowHash ?? '';
      buffer.writeln('$ts,$et,$eid,$act,$uid,$reason,$ip,$hash');
    }
    
    await logReportExport(
      session,
      reportType: 'audit_trail_csv',
      hashSha256: 'csv-export-${DateTime.now().millisecondsSinceEpoch}',
      filterParamsJson: '{"entityType":"$entityType","userId":$userId,"limit":$limit}',
      recordCount: trails.length,
    );
    
    return buffer.toString();
  }
}
