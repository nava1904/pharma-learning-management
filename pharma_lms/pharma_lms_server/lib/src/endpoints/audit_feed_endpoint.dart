import 'package:serverpod/serverpod.dart';
import '../generated/audit/audit_trail.dart';

class AuditFeedEndpoint extends Endpoint {
  // Returns the last 10 audit events, newest first
  Future<List<AuditTrail>> getRecentAuditEvents(Session session) async {
    return await AuditTrail.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: 10,
    );
  }
}
