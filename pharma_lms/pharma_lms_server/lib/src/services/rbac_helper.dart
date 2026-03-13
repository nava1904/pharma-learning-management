import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// RBAC helper: requirePermission enforces resource:action checks on endpoints.
/// Uses pharma_user -> user_role -> role -> permission chain.
/// Throws [RbacException] if not authenticated or permission denied.
class RbacHelper {
  RbacHelper._();

  /// Requires the current user to have [resource]:[action] permission.
  /// Throws [RbacException] if not authenticated or permission denied.
  /// Returns the [PharmaUser] for use in the endpoint.
  static Future<PharmaUser> requirePermission(
    Session session, {
    required String resource,
    required String action,
  }) async {
    final user = await _getCurrentPharmaUser(session);
    if (user == null) {
      throw RbacException('Authentication required');
    }
    final hasPermission = await _hasPermission(session, user.id!, resource, action);
    if (!hasPermission) {
      throw RbacException('Permission denied: $resource:$action');
    }
    return user;
  }

  /// Requires the current user to be authenticated.
  /// Returns the [PharmaUser] or throws if not authenticated.
  static Future<PharmaUser> requireAuthenticated(Session session) async {
    final user = await _getCurrentPharmaUser(session);
    if (user == null) {
      throw RbacException('Authentication required');
    }
    return user;
  }

  /// Returns the current [PharmaUser] from session, or null if not authenticated.
  static Future<PharmaUser?> getCurrentPharmaUser(Session session) async {
    return _getCurrentPharmaUser(session);
  }

  /// Returns true if the current user has [resource]:[action]. False if not authenticated or no permission.
  static Future<bool> hasPermission(
    Session session, {
    required String resource,
    required String action,
  }) async {
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
      } catch (_) {
        // Ignore: profile table may differ by Serverpod version
      }
      if (email == null || email.isEmpty) {
        try {
          final result = await session.db.unsafeQuery(
            r'SELECT email FROM serverpod_auth_idp_email_account WHERE "authUserId"::text = @authUserId LIMIT 1',
            parameters: QueryParameters.named({'authUserId': userIdentifier}),
          );
          if (result.isNotEmpty) {
            email = result.first[0]?.toString();
          }
        } catch (_) {
          // Ignore
        }
      }
      if (email == null || email.isEmpty) return null;

      // Case-insensitive match so auth profile (e.g. Alice@) matches pharma_user (alice@).
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

  /// Matches permission: supports '*' for resource or action (admin-style).
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
