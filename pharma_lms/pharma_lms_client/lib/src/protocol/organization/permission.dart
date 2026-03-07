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
import '../organization/role.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Permission linked to a role for RBAC.
abstract class Permission implements _i1.SerializableModel {
  Permission._({
    this.id,
    required this.roleId,
    this.role,
    required this.resource,
    required this.action,
  });

  factory Permission({
    int? id,
    required int roleId,
    _i2.Role? role,
    required String resource,
    required String action,
  }) = _PermissionImpl;

  factory Permission.fromJson(Map<String, dynamic> jsonSerialization) {
    return Permission(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Role>(jsonSerialization['role']),
      resource: jsonSerialization['resource'] as String,
      action: jsonSerialization['action'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roleId;

  /// The role this permission belongs to.
  _i2.Role? role;

  /// Resource being protected (e.g., course, training, audit).
  String resource;

  /// Action allowed (e.g., read, write, approve).
  String action;

  /// Returns a shallow copy of this [Permission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Permission copyWith({
    int? id,
    int? roleId,
    _i2.Role? role,
    String? resource,
    String? action,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Permission',
      if (id != null) 'id': id,
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
      'resource': resource,
      'action': action,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PermissionImpl extends Permission {
  _PermissionImpl({
    int? id,
    required int roleId,
    _i2.Role? role,
    required String resource,
    required String action,
  }) : super._(
         id: id,
         roleId: roleId,
         role: role,
         resource: resource,
         action: action,
       );

  /// Returns a shallow copy of this [Permission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Permission copyWith({
    Object? id = _Undefined,
    int? roleId,
    Object? role = _Undefined,
    String? resource,
    String? action,
  }) {
    return Permission(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      role: role is _i2.Role? ? role : this.role?.copyWith(),
      resource: resource ?? this.resource,
      action: action ?? this.action,
    );
  }
}
