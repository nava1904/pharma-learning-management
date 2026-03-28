import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

class DepartmentSeed {
  static const rows = <({String name, String code})>[
    (name: 'Quality Assurance', code: 'QA'),
    (name: 'Quality Control', code: 'QC'),
    (name: 'Manufacturing', code: 'MFG'),
    (name: 'Regulatory Affairs', code: 'RA'),
    (name: 'Pharmacovigilance', code: 'PV'),
    (name: 'Research & Development', code: 'RD'),
    (name: 'Information Technology', code: 'IT'),
    (name: 'Learning & Development', code: 'LD'),
    (name: 'Supply Chain', code: 'SCM'),
    (name: 'Engineering', code: 'ENG'),
  ];

  static Future<List<int>> insertForDefaultSite(
    Session session,
    int siteId,
  ) async {
    final ids = <int>[];
    for (final row in rows) {
      final dept = await Department.db.insertRow(
        session,
        Department(siteId: siteId, name: row.name, code: row.code),
      );
      ids.add(dept.id!);
    }
    return ids;
  }
}
