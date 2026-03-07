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

/// Dashboard configuration.
abstract class Dashboard implements _i1.SerializableModel {
  Dashboard._({
    this.id,
    required this.name,
    required this.widgetsJson,
    this.roleId,
    this.role,
  });

  factory Dashboard({
    int? id,
    required String name,
    required String widgetsJson,
    int? roleId,
    _i2.Role? role,
  }) = _DashboardImpl;

  factory Dashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dashboard(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      widgetsJson: jsonSerialization['widgetsJson'] as String,
      roleId: jsonSerialization['roleId'] as int?,
      role: jsonSerialization['role'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Role>(jsonSerialization['role']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Dashboard name.
  String name;

  /// Widgets configuration as JSON.
  String widgetsJson;

  int? roleId;

  /// Role this dashboard is for.
  _i2.Role? role;

  /// Returns a shallow copy of this [Dashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dashboard copyWith({
    int? id,
    String? name,
    String? widgetsJson,
    int? roleId,
    _i2.Role? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dashboard',
      if (id != null) 'id': id,
      'name': name,
      'widgetsJson': widgetsJson,
      if (roleId != null) 'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardImpl extends Dashboard {
  _DashboardImpl({
    int? id,
    required String name,
    required String widgetsJson,
    int? roleId,
    _i2.Role? role,
  }) : super._(
         id: id,
         name: name,
         widgetsJson: widgetsJson,
         roleId: roleId,
         role: role,
       );

  /// Returns a shallow copy of this [Dashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dashboard copyWith({
    Object? id = _Undefined,
    String? name,
    String? widgetsJson,
    Object? roleId = _Undefined,
    Object? role = _Undefined,
  }) {
    return Dashboard(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      widgetsJson: widgetsJson ?? this.widgetsJson,
      roleId: roleId is int? ? roleId : this.roleId,
      role: role is _i2.Role? ? role : this.role?.copyWith(),
    );
  }
}
