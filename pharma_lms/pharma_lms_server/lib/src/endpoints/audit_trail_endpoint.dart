import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

class AuditTrailEndpoint extends Endpoint {
  Future<void> logAction(
    Session session, {
    required String action,
    required String entityType,
    required String entityId,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? ipAddress,
    String? rowHash,
  }) async {
    final user = await RbacHelper.getCurrentPharmaUser(session);
    if (user == null) return;

    await AuditTrail.db.insertRow(
      session,
      AuditTrail(
        entityType: entityType,
        entityId: entityId,
        action: action,
        oldValueJson: oldValueJson,
        newValueJson: newValueJson,
        reason: reason,
        ipAddress: ipAddress,
        rowHash: rowHash,
        userId: user.id,
      ),
    );
  }
}
