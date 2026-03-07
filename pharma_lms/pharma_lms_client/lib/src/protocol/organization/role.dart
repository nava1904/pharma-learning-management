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

/// RBAC role for access control.
abstract class Role implements _i1.SerializableModel {
  Role._({
    this.id,
    required this.name,
    required this.code,
  });

  factory Role({
    int? id,
    required String name,
    required String code,
  }) = _RoleImpl;

  factory Role.fromJson(Map<String, dynamic> jsonSerialization) {
    return Role(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Role name (e.g., employee, admin, qa, sme).
  String name;

  /// Unique code for the role.
  String code;

  /// Returns a shallow copy of this [Role]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Role copyWith({
    int? id,
    String? name,
    String? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Role',
      if (id != null) 'id': id,
      'name': name,
      'code': code,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoleImpl extends Role {
  _RoleImpl({
    int? id,
    required String name,
    required String code,
  }) : super._(
         id: id,
         name: name,
         code: code,
       );

  /// Returns a shallow copy of this [Role]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Role copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
  }) {
    return Role(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}
