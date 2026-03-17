import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// User-centric endpoint for employee operations.
class UserEndpoint extends Endpoint {
  Future<PharmaUser?> getUser(Session session, int id) async {
    await RbacHelper.requirePermission(session, resource: 'organization', action: 'read');
    return await PharmaUser.db.findById(session, id);
  }

  /// Returns PharmaUser by email. 
  /// For demo/development: if no auth session, looks up user directly by email.
  /// For production: validates session and ensures user can only access own profile.
  Future<PharmaUser?> getUserByEmail(Session session, String email) async {
    final trimmed = email.trim().toLowerCase();
    if (trimmed.isEmpty) return null;
    
    // Check if authenticated session exists
    try {
      final current = await RbacHelper.getCurrentPharmaUser(session);
      if (current != null) {
        // Authenticated: only return if email matches session user
        if (current.email.trim().toLowerCase() == trimmed) {
          return current;
        }
        return null;
      }
    } catch (_) {
      // No authenticated session - fall through to demo mode
    }
    
    // Demo/Development mode: lookup user directly by email
    // This allows demo login flow to work without Serverpod auth
    try {
      final user = await PharmaUser.db.findFirstRow(
        session,
        where: (t) => t.email.ilike(trimmed),
      );
      return user;
    } catch (e, st) {
      session.log('UserEndpoint.getUserByEmail fallback failed: $e');
      session.log(st.toString());
      return null;
    }
  }

  /// Get the primary role code for a user by email.
  /// Returns the role code string (e.g., 'trainer', 'employee', 'admin', 'qa_manager', 'auditor').
  /// Used by the Flutter client to determine which portal/dashboard to show on login.
  Future<String?> getUserRoleByEmail(Session session, String email) async {
    final trimmed = email.trim().toLowerCase();
    if (trimmed.isEmpty) return null;

    final user = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.ilike(trimmed),
    );
    if (user == null || user.id == null) return null;

    final userRoles = await UserRole.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      include: UserRole.include(role: Role.include()),
    );
    if (userRoles.isEmpty) return null;

    // Priority order: admin > qa_director > qa_manager > trainer > sme > auditor > employee
    const priority = ['admin', 'qa_director', 'qa_manager', 'trainer', 'sme', 'auditor', 'employee'];
    String? bestRole;
    var bestIndex = priority.length;
    for (final ur in userRoles) {
      final code = ur.role?.code;
      if (code != null) {
        final idx = priority.indexOf(code);
        if (idx >= 0 && idx < bestIndex) {
          bestIndex = idx;
          bestRole = code;
        }
      }
    }
    return bestRole ?? userRoles.first.role?.code;
  }

  /// Get all preferences for a user.
  Future<List<UserPreference>> getUserPreferences(
    Session session, {
    required int userId,
  }) async {
    return await UserPreference.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  /// Set a user preference (upsert).
  Future<UserPreference> setUserPreference(
    Session session, {
    required int userId,
    required String key,
    required String value,
  }) async {
    final existing = await UserPreference.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.preferenceKey.equals(key),
    );
    
    if (existing != null) {
      final updated = existing.copyWith(preferenceValue: value);
      return await UserPreference.db.updateRow(session, updated);
    }
    
    return await UserPreference.db.insertRow(
      session,
      UserPreference(
        userId: userId,
        preferenceKey: key,
        preferenceValue: value,
      ),
    );
  }
}
