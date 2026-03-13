import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';

/// Central audit logging service for FDA 21 CFR Part 11 compliance.
/// Every mutation must log to the immutable audit trail.
/// Use [AuditEventType] constants for action values.
class AuditService {
  /// Log an audit trail entry. Append-only - no updates or deletes.
  /// [action] should be from [AuditEventType] for full coverage.
  /// Automatically computes SHA-256 row hash for integrity verification (SYS-WF-08).
  static Future<void> log(
    Session session, {
    required String entityType,
    required String entityId,
    required String action,
    String? oldValueJson,
    String? newValueJson,
    int? userId,
    String? reason,
    String? ipAddress,
  }) async {
    if (!AuditEventType.isKnown(action)) {
      session.log('Audit: unknown action "$action" - consider adding to AuditEventType');
    }
    
    final timestamp = DateTime.now();
    
    // Compute SHA-256 hash of critical fields for integrity verification (21 CFR Part 11)
    final rowHash = _computeRowHash(
      entityType: entityType,
      entityId: entityId,
      action: action,
      timestamp: timestamp,
      userId: userId,
      oldValueJson: oldValueJson,
      newValueJson: newValueJson,
      reason: reason,
    );
    
    final audit = AuditTrail(
      entityType: entityType,
      entityId: entityId,
      action: action,
      timestamp: timestamp,
      oldValueJson: oldValueJson,
      newValueJson: newValueJson,
      reason: reason,
      ipAddress: ipAddress,
      userId: userId,
      rowHash: rowHash,
    );
    await AuditTrail.db.insertRow(session, audit);
  }
  
  /// Compute SHA-256 hash of critical audit trail fields.
  /// Used for integrity verification per 21 CFR Part 11.
  static String _computeRowHash({
    required String entityType,
    required String entityId,
    required String action,
    required DateTime timestamp,
    int? userId,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
  }) {
    final dataToHash = [
      entityType,
      entityId,
      action,
      timestamp.toIso8601String(),
      userId?.toString() ?? 'null',
      oldValueJson ?? '',
      newValueJson ?? '',
      reason ?? '',
    ].join('|');

    final bytes = utf8.encode(dataToHash);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Log access (login, logout, session).
  static Future<void> logAccess(
    Session session, {
    int? userId,
    required String action,
    String? ipAddress,
    String? userAgent,
    bool success = true,
  }) async {
    final log = AccessLog(
      action: action,
      ipAddress: ipAddress,
      userAgent: userAgent,
      success: success,
      userId: userId,
    );
    await AccessLog.db.insertRow(session, log);
  }

  /// Log an error.
  static Future<void> logError(
    Session session, {
    required String message,
    String? stackTrace,
    String? contextJson,
  }) async {
    await ErrorLog.db.insertRow(
      session,
      ErrorLog(
        message: message,
        stackTrace: stackTrace,
        contextJson: contextJson,
      ),
    );
  }
}
