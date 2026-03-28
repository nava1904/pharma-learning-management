import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

class OrganizationSeed {
  static const orgName = 'PharmaTech India Pvt Ltd';
  static const orgCode = 'PTI';

  static Future<Organization> insert(Session session) async {
    return Organization.db.insertRow(
      session,
      Organization(name: orgName, code: orgCode),
    );
  }
}
