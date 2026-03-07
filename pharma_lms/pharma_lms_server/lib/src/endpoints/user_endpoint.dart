import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// User-centric endpoint for employee operations.
class UserEndpoint extends Endpoint {
  Future<PharmaUser?> getUser(Session session, int id) async {
    return await PharmaUser.db.findById(session, id);
  }

  Future<PharmaUser?> getUserByEmail(Session session, String email) async {
    return await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
  }
}
