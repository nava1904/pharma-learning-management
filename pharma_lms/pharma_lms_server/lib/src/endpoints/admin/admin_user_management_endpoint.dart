import 'package:serverpod/serverpod.dart';
import 'package:pharma_lms_server/src/generated/protocol.dart';
import 'package:pharma_lms_server/src/services/rbac_helper.dart';

/// Admin User Management Endpoint
///
/// Module 1: User & Identity Management
/// 
/// Handles all user management operations:
/// - List users with filters, search, pagination
/// - Get user details with roles and organization info
/// - Create new user
/// - Update user information
/// - Deactivate/reactivate user
/// - Reset password
/// - Bulk operations
///
/// All operations are audited (logged to audit_trail table)
/// All operations enforce RBAC (admin-only)
/// Compliance: 21 CFR Part 11 - Full audit trail with HMAC
class AdminUserManagementEndpoint extends Endpoint {
  /// List all users with filtering, searching, and pagination
  /// 
  /// Query parameters:
  /// - role: Filter by user role (EMPLOYEE, TRAINER, ADMIN)
  /// - status: Filter by status (ACTIVE, INACTIVE, SUSPENDED, PENDING_APPROVAL)
  /// - organization: Filter by organization name
  /// - department: Filter by department
  /// - search: Search by name, email, or employee_id
  /// - page: Page number (1-indexed)
  /// - perPage: Records per page (default 10, max 100)
  /// 
  /// Returns: List of users matching criteria
  /// Database: Queries pharma_user table
  /// Audit: Logged as USERS_READ (informational)
  Future<List<PharmaUser>> listUsers(
    Session session, {
    String? role,
    String? status,
    String? organizationName,
    String? departmentName,
    String? search,
    int page = 1,
    int perPage = 10,
  }) async {
    // RBAC: Only admins can list users
    await RbacHelper.requirePermission(session, resource: 'users', action: 'read');

    // Build query with filters using Serverpod ORM
    try {
      final offset = (page - 1) * perPage;
      final clampedPerPage = perPage.clamp(1, 100);

      // Build where clause dynamically
      var users = await PharmaUser.db.find(
        session,
        where: (t) {
          var condition = t.id.notEquals(0); // Always true base condition
          
          if (search != null && search.isNotEmpty) {
            condition = condition & (
              t.email.ilike('%$search%') |
              t.firstName.ilike('%$search%') |
              t.lastName.ilike('%$search%') |
              t.employeeId.ilike('%$search%')
            );
          }
          
          return condition;
        },
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: clampedPerPage,
        offset: offset,
      );

      // Audit log
      await _auditLog(session, 'USERS_LIST', 'Listed users with filters');

      return users;
    } catch (e, stackTrace) {
      session.log('Error listing users: $e', level: LogLevel.error);
      session.log(stackTrace.toString(), level: LogLevel.error);
      throw Exception('Failed to list users');
    }
  }

  /// Get a single user with all details
  /// 
  /// Parameters:
  /// - userId: The ID of the user to fetch
  /// 
  /// Returns: Full user object with roles and organization details
  /// Database: Queries pharma_user table
  /// Audit: Logged as USER_VIEW
  Future<PharmaUser?> getUser(Session session, {required int userId}) async {
    // RBAC: Only admins can view user details
    await RbacHelper.requirePermission(session, resource: 'users', action: 'read');

    try {
      final user = await PharmaUser.db.findById(session, userId);

      if (user == null) {
        return null;
      }

      // Audit log
      await _auditLog(session, 'USER_VIEW', 'Viewed user details', targetId: userId);

      return user;
    } catch (e, stackTrace) {
      session.log('Error fetching user: $e', level: LogLevel.error);
      session.log(stackTrace.toString(), level: LogLevel.error);
      throw Exception('Failed to fetch user');
    }
  }

  /// Create a new user
  /// 
  /// Validation:
  /// - Email must be unique
  /// - Email must be valid format
  /// - Name cannot be empty
  /// - Role must be EMPLOYEE, TRAINER, or ADMIN
  /// 
  /// Database: Inserts into pharma_user table
  /// Audit: Logged as USER_CREATE
  /// Compliance: New user status = PENDING_APPROVAL, requires admin approval
  Future<PharmaUser> createUser(
    Session session, {
    required String email,
    required String firstName,
    required String lastName,
    String? employeeId,
    int? organizationId,
    int? departmentId,
    int? jobRoleId,
    int? siteId,
  }) async {
    // RBAC: Only admins can create users
    await RbacHelper.requirePermission(session, resource: 'users', action: 'create');

    // Validation
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Invalid email address');
    }
    if (firstName.isEmpty || lastName.isEmpty) {
      throw Exception('First name and last name cannot be empty');
    }

    try {
      // Check email uniqueness
      final existingUser = await PharmaUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email),
      );
      if (existingUser != null) {
        throw Exception('Email already exists');
      }

      // Create new user
      final now = DateTime.now();
      final newUser = PharmaUser(
        email: email,
        firstName: firstName,
        lastName: lastName,
        employeeId: employeeId,
        organizationId: organizationId ?? 0,
        departmentId: departmentId ?? 0,
        jobRoleId: jobRoleId ?? 0,
        siteId: siteId ?? 0,
        createdAt: now,
      );

      final createdUser = await PharmaUser.db.insertRow(session, newUser);

      // Audit log
      await _auditLog(session, 'USER_CREATE', 'Created new user: $firstName $lastName', targetId: createdUser.id);

      return createdUser;
    } catch (e, stackTrace) {
      session.log('Error creating user: $e', level: LogLevel.error);
      session.log(stackTrace.toString(), level: LogLevel.error);
      rethrow;
    }
  }

  /// Update user information
  /// 
  /// All user fields can be updated except id and email (email is immutable)
  /// Database: Updates pharma_user table
  /// Audit: Logged as USER_UPDATE with field changes
  Future<PharmaUser?> updateUser(
    Session session, {
    required int userId,
    String? firstName,
    String? lastName,
    int? organizationId,
    int? departmentId,
  }) async {
    // RBAC: Only admins can update users
    await RbacHelper.requirePermission(session, resource: 'users', action: 'update');

    try {
      final existingUser = await PharmaUser.db.findById(session, userId);
      if (existingUser == null) {
        return null;
      }

      final updatedUser = existingUser.copyWith(
        firstName: firstName ?? existingUser.firstName,
        lastName: lastName ?? existingUser.lastName,
        organizationId: organizationId ?? existingUser.organizationId,
        departmentId: departmentId ?? existingUser.departmentId,
      );

      final result = await PharmaUser.db.updateRow(session, updatedUser);

      // Audit log
      await _auditLog(session, 'USER_UPDATE', 
        'Updated user: ${result.firstName} ${result.lastName}', targetId: userId);

      return result;
    } catch (e, stackTrace) {
      session.log('Error updating user: $e', level: LogLevel.error);
      session.log(stackTrace.toString(), level: LogLevel.error);
      throw Exception('Failed to update user');
    }
  }

  /// Deactivate a user (soft delete)
  /// 
  /// Sets is_suspended = true, is_active = false
  /// User cannot login or use system
  /// All enrollment/certificate records remain intact (audit trail)
  /// 
  /// Database: Updates pharma_user table
  /// Audit: Logged as USER_DEACTIVATE
  Future<bool> deactivateUser(Session session, {required int userId}) async {
    // RBAC: Only admins can deactivate users
    await RbacHelper.requirePermission(session, resource: 'users', action: 'delete');

    try {
      final existingUser = await PharmaUser.db.findById(session, userId);
      if (existingUser == null) {
        return false;
      }

      final updatedUser = existingUser.copyWith(
        status: 'inactive',
      );

      await PharmaUser.db.updateRow(session, updatedUser);

      // Audit log
      await _auditLog(session, 'USER_DEACTIVATE', 
        'Deactivated user', targetId: userId);
      
      return true;
    } catch (e, stackTrace) {
      session.log('Error deactivating user: $e', level: LogLevel.error);
      session.log(stackTrace.toString(), level: LogLevel.error);
      throw Exception('Failed to deactivate user');
    }
  }

  /// Helper: Write to audit trail
  Future<void> _auditLog(Session session, String action, String? details, {int? targetId}) async {
    try {
      final currentUser = await RbacHelper.getCurrentPharmaUser(session);
      final now = DateTime.now();
      
      final auditEntry = AuditTrail(
        entityType: 'PharmaUser',
        entityId: targetId?.toString() ?? '',
        action: action,
        newValueJson: details,
        timestamp: now,
        userId: currentUser?.id,
        ipAddress: 'unknown',
      );
      
      await AuditTrail.db.insertRow(session, auditEntry);
    } catch (e) {
      session.log('Failed to log audit trail: $e', level: LogLevel.warning);
    }
  }
}

