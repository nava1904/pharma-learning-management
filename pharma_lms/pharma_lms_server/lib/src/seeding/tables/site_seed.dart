import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

class SiteSeed {
  static const rows = <({String name, String code, String timezone})>[
    (name: 'Mumbai HQ', code: 'MUM', timezone: 'Asia/Kolkata'),
    (name: 'Pune Manufacturing', code: 'PUN', timezone: 'Asia/Kolkata'),
    (name: 'Hyderabad R&D', code: 'HYD', timezone: 'Asia/Kolkata'),
    (name: 'Ahmedabad API', code: 'AHM', timezone: 'Asia/Kolkata'),
    (name: 'Bengaluru Biotech', code: 'BLR', timezone: 'Asia/Kolkata'),
  ];

  static Future<List<int>> insertForOrganization(
    Session session,
    int orgId,
  ) async {
    final ids = <int>[];
    for (final row in rows) {
      final site = await Site.db.insertRow(
        session,
        Site(
          organizationId: orgId,
          name: row.name,
          code: row.code,
          timezone: row.timezone,
        ),
      );
      ids.add(site.id!);
    }
    return ids;
  }
}
