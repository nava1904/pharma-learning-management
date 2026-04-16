import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds 5 QA users with realistic pharma QA roles.
class QaUsersSeed {
  static const _qaUsers = <({
    String email,
    String firstName,
    String lastName,
    String employeeId,
    int siteIdx,
    int deptIdx,
    int jobRoleIdx,
    String roleCode,
  })>[
    (
      email: 'ananya.kulkarni@pharmatech.in',
      firstName: 'Ananya',
      lastName: 'Kulkarni',
      employeeId: 'QA-001',
      siteIdx: 0,
      deptIdx: 0, // Quality Assurance
      jobRoleIdx: 0, // QA Specialist
      roleCode: 'qa_director',
    ),
    (
      email: 'rajeev.menon@pharmatech.in',
      firstName: 'Rajeev',
      lastName: 'Menon',
      employeeId: 'QA-002',
      siteIdx: 1,
      deptIdx: 0,
      jobRoleIdx: 0,
      roleCode: 'qa_manager',
    ),
    (
      email: 'priti.deshmukh@pharmatech.in',
      firstName: 'Priti',
      lastName: 'Deshmukh',
      employeeId: 'QA-003',
      siteIdx: 2,
      deptIdx: 1, // Quality Control
      jobRoleIdx: 1, // QC Analyst
      roleCode: 'qa_manager',
    ),
    (
      email: 'sudhir.joshi@pharmatech.in',
      firstName: 'Sudhir',
      lastName: 'Joshi',
      employeeId: 'QA-004',
      siteIdx: 0,
      deptIdx: 0,
      jobRoleIdx: 0,
      roleCode: 'qa_manager',
    ),
    (
      email: 'nisha.agarwal@pharmatech.in',
      firstName: 'Nisha',
      lastName: 'Agarwal',
      employeeId: 'QA-005',
      siteIdx: 3,
      deptIdx: 1,
      jobRoleIdx: 1,
      roleCode: 'qa_director',
    ),
  ];

  static Future<List<int>> insert(Session session, SeedContext ctx) async {
    final ids = <int>[];
    for (final q in _qaUsers) {
      final user = await PharmaUser.db.insertRow(
        session,
        PharmaUser(
          email: q.email,
          firstName: q.firstName,
          lastName: q.lastName,
          employeeId: q.employeeId,
          siteId: ctx.siteIds[q.siteIdx],
          departmentId: ctx.deptIds[q.deptIdx],
          jobRoleId: ctx.jobRoleIds[q.jobRoleIdx],
          organizationId: ctx.orgId,
          status: 'active',
          hireDate: ctx.dt(-900 + ids.length * 60),
        ),
      );
      ids.add(user.id!);

      await UserRole.db.insertRow(
        session,
        UserRole(userId: user.id!, roleId: ctx.roleIds[q.roleCode]!),
      );
    }
    return ids;
  }
}
