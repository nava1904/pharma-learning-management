import 'package:serverpod/serverpod.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';

/// Central audit logging service for FDA 21 CFR Part 11 compliance.
/// Every mutation must log to the immutable audit trail.
/// Use [AuditEventType] constants for action values.
class AuditService {
  /// Log an audit trail entry. Append-only - no updates or deletes.
  /// [action] should be from [AuditEventType] for full coverage.
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
    final audit = AuditTrail(
      entityType: entityType,
      entityId: entityId,
      action: action,
      oldValueJson: oldValueJson,
      newValueJson: newValueJson,
      reason: reason,
      ipAddress: ipAddress,
      userId: userId,
    );
    await AuditTrail.db.insertRow(session, audit);
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
