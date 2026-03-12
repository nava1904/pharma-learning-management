import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// Organization & Identity domain endpoint.
class OrganizationEndpoint extends Endpoint {
  Future<List<Organization>> listOrganizations(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await Organization.db.find(session);
  }

  Future<Organization?> getOrganization(Session session, int id) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await Organization.db.findById(session, id);
  }

  Future<Organization> createOrganization(
    Session session, {
    required String name,
    required String code,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    final org = Organization(name: name, code: code);
    return await Organization.db.insertRow(session, org);
  }

  Future<List<Site>> listSites(Session session, int organizationId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await Site.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
  }

  Future<List<Department>> listDepartments(
    Session session,
    int siteId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await Department.db.find(
      session,
      where: (t) => t.siteId.equals(siteId),
    );
  }

  Future<List<JobRole>> listJobRoles(
    Session session,
    int departmentId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await JobRole.db.find(
      session,
      where: (t) => t.departmentId.equals(departmentId),
    );
  }

  Future<List<PharmaUser>> listUsers(
    Session session, {
    int? organizationId,
    int? departmentId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    if (organizationId != null && departmentId != null) {
      return await PharmaUser.db.find(
        session,
        where: (t) =>
            t.organizationId.equals(organizationId) &
            t.departmentId.equals(departmentId),
      );
    }
    if (organizationId != null) {
      return await PharmaUser.db.find(
        session,
        where: (t) => t.organizationId.equals(organizationId),
      );
    }
    if (departmentId != null) {
      return await PharmaUser.db.find(
        session,
        where: (t) => t.departmentId.equals(departmentId),
      );
    }
    return await PharmaUser.db.find(session);
  }
}
