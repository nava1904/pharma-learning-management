/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../organization/user.dart' as _i2;
import '../organization/role.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Links users to RBAC roles (many-to-many).
abstract class UserRole implements _i1.SerializableModel {
  UserRole._({
    this.id,
    required this.userId,
    this.user,
    required this.roleId,
    this.role,
  });

  factory UserRole({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
  }) = _UserRoleImpl;

  factory UserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRole(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Role>(jsonSerialization['role']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int roleId;

  /// The role assigned.
  _i3.Role? role;

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRole copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? roleId,
    _i3.Role? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoleImpl extends UserRole {
  _UserRoleImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         roleId: roleId,
         role: role,
       );

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRole copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? roleId,
    Object? role = _Undefined,
  }) {
    return UserRole(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      roleId: roleId ?? this.roleId,
      role: role is _i3.Role? ? role : this.role?.copyWith(),
    );
  }
}
