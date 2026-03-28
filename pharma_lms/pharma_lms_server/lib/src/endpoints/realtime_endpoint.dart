import 'package:serverpod/serverpod.dart';

import '../services/rbac_helper.dart';
import '../services/realtime_ws_auth.dart';

/// Issues short-lived tokens for the WebSocket realtime connection (web server /ws/realtime).
class RealtimeEndpoint extends Endpoint {
  Future<String> getConnectionToken(Session session) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) {
      throw Exception('Authentication required');
    }
    final secret = session.serverpod.getPassword('serviceSecret') ?? '';
    if (secret.isEmpty) {
      throw Exception('serviceSecret not configured');
    }
    return RealtimeWsAuth.issue(me!.id!, secret);
  }
}
