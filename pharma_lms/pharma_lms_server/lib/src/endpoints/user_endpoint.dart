import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// User-centric endpoint for employee operations.
class UserEndpoint extends Endpoint {
  Future<PharmaUser?> getUser(Session session, int id) async {
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await PharmaUser.db.findById(session, id);
  }

  /// Returns PharmaUser by email. If the session is authenticated but has no
  /// PharmaUser (e.g. no profile yet), returns null instead of throwing 500.
  Future<PharmaUser?> getUserByEmail(Session session, String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return null;
    try {
      final current = await RbacHelper.getCurrentPharmaUser(session);
      if (current == null) return null;
      if (current.email.trim().toLowerCase() != trimmed.toLowerCase()) return null;
      return current;
    } catch (e, st) {
      session.log('UserEndpoint.getUserByEmail failed: $e');
      session.log(st.toString());
      return null;
    }
  }
}
