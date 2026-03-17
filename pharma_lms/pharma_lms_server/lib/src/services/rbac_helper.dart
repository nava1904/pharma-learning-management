import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// RBAC helper: requirePermission enforces resource:action checks on endpoints.
/// Uses pharma_user -> user_role -> role -> permission chain.
/// Throws [RbacException] if not authenticated or permission denied.
///
/// **Demo/Development mode**: When no Serverpod auth session exists (i.e. the
/// Flutter client is using demo login without real Serverpod authentication),
/// all permission checks are bypassed. In production, Serverpod's own auth
/// middleware rejects unauthenticated requests before they reach endpoints.
class RbacHelper {
  RbacHelper._();

  static bool _hasNoAuthSession(Session session) =>
      session.authenticated?.userIdentifier == null;

  static final _devBypassUser = PharmaUser(
    email: '_dev_bypass_@system',
    firstName: 'Dev',
    lastName: 'Mode',
    employeeId: 'DEV-0',
    status: 'active',
    siteId: 0,
    departmentId: 0,
    jobRoleId: 0,
    organizationId: 0,
  );

  /// Requires the current user to have [resource]:[action] permission.
  /// Throws [RbacException] if not authenticated or permission denied.
  /// Returns the [PharmaUser] for use in the endpoint.
  static Future<PharmaUser> requirePermission(
    Session session, {
    required String resource,
    required String action,
  }) async {
    if (_hasNoAuthSession(session)) return _devBypassUser;

    final user = await _getCurrentPharmaUser(session);
    if (user == null) {
      throw RbacException('Authentication required');
    }
    final hasPerm = await _hasPermission(session, user.id!, resource, action);
    if (!hasPerm) {
      throw RbacException('Permission denied: $resource:$action');
    }
    return user;
  }

  /// Requires the current user to be authenticated.
  /// Returns the [PharmaUser] or throws if not authenticated.
  static Future<PharmaUser> requireAuthenticated(Session session) async {
    if (_hasNoAuthSession(session)) return _devBypassUser;

    final user = await _getCurrentPharmaUser(session);
    if (user == null) {
      throw RbacException('Authentication required');
    }
    return user;
  }

  /// Returns the current [PharmaUser] from session, or null if not authenticated.
  /// In demo mode (no auth session), returns a synthetic bypass user so that
  /// endpoint guards like `if (getCurrentPharmaUser == null) return []` pass.
  static Future<PharmaUser?> getCurrentPharmaUser(Session session) async {
    if (_hasNoAuthSession(session)) return _devBypassUser;
    return _getCurrentPharmaUser(session);
  }

  /// Returns true if the current user has [resource]:[action].
  /// In demo mode (no auth session), returns true.
  static Future<bool> hasPermission(
    Session session, {
    required String resource,
    required String action,
  }) async {
    if (_hasNoAuthSession(session)) return true;

    final user = await _getCurrentPharmaUser(session);
    if (user == null || user.id == null) return false;
    return _hasPermission(session, user.id!, resource, action);
  }

  static Future<PharmaUser?> _getCurrentPharmaUser(Session session) async {
    try {
      final userIdentifier = session.authenticated?.userIdentifier;
      if (userIdentifier == null || userIdentifier.isEmpty) return null;

      String? email;
      try {
        final result = await session.db.unsafeQuery(
          r'SELECT email FROM serverpod_auth_core_profile WHERE "authUserId"::text = @authUserId LIMIT 1',
          parameters: QueryParameters.named({'authUserId': userIdentifier}),
        );
        if (result.isNotEmpty) {
          email = result.first[0]?.toString();
        }
      } catch (_) {}
      if (email == null || email.isEmpty) {
        try {
          final result = await session.db.unsafeQuery(
            r'SELECT email FROM serverpod_auth_idp_email_account WHERE "authUserId"::text = @authUserId LIMIT 1',
            parameters: QueryParameters.named({'authUserId': userIdentifier}),
          );
          if (result.isNotEmpty) {
            email = result.first[0]?.toString();
          }
        } catch (_) {}
      }
      if (email == null || email.isEmpty) return null;

      final normalized = email.trim().toLowerCase();
      final rows = await session.db.unsafeQuery(
        r'SELECT id FROM pharma_user WHERE lower(trim(email)) = @email LIMIT 1',
        parameters: QueryParameters.named({'email': normalized}),
      );
      if (rows.isEmpty || rows.first.isEmpty) return null;
      final id = rows.first[0];
      if (id == null) return null;
      final userId = id is int ? id : int.tryParse(id.toString());
      if (userId == null) return null;
      return PharmaUser.db.findById(session, userId);
    } catch (e, st) {
      session.log('RbacHelper._getCurrentPharmaUser failed: $e');
      session.log(st.toString());
      return null;
    }
  }

  static Future<bool> _hasPermission(
    Session session,
    int userId,
    String resource,
    String action,
  ) async {
    final userRoles = await UserRole.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: UserRole.include(role: Role.include()),
    );
    final roleIds = userRoles.map((ur) => ur.roleId).toList();
    if (roleIds.isEmpty) return false;

    final permissions = await Permission.db.find(
      session,
      where: (t) => t.roleId.inSet(roleIds.toSet()),
    );

    for (final p in permissions) {
      if (_matches(p.resource, p.action, resource, action)) return true;
    }
    return false;
  }

  static bool _matches(String permResource, String permAction, String reqResource, String reqAction) {
    final resourceMatch = permResource == '*' || permResource == reqResource;
    final actionMatch = permAction == '*' || permAction == reqAction;
    return resourceMatch && actionMatch;
  }
}

/// Thrown when RBAC check fails (not authenticated or permission denied).
class RbacException implements Exception {
  RbacException(this.message);
  final String message;
  @override
  String toString() => 'RbacException: $message';
}
