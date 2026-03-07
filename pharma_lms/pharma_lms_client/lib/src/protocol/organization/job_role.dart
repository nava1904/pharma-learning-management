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
import '../organization/department.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Job role with training matrix for role-based training assignment.
abstract class JobRole implements _i1.SerializableModel {
  JobRole._({
    this.id,
    required this.departmentId,
    this.department,
    required this.name,
    required this.code,
    this.trainingMatrixJson,
  });

  factory JobRole({
    int? id,
    required int departmentId,
    _i2.Department? department,
    required String name,
    required String code,
    String? trainingMatrixJson,
  }) = _JobRoleImpl;

  factory JobRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobRole(
      id: jsonSerialization['id'] as int?,
      departmentId: jsonSerialization['departmentId'] as int,
      department: jsonSerialization['department'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Department>(
              jsonSerialization['department'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      trainingMatrixJson: jsonSerialization['trainingMatrixJson'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int departmentId;

  /// The department this job role belongs to.
  _i2.Department? department;

  /// Job role name.
  String name;

  /// Unique code for the job role.
  String code;

  /// JSON mapping of required course IDs for this role (training matrix).
  String? trainingMatrixJson;

  /// Returns a shallow copy of this [JobRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobRole copyWith({
    int? id,
    int? departmentId,
    _i2.Department? department,
    String? name,
    String? code,
    String? trainingMatrixJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobRole',
      if (id != null) 'id': id,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJson(),
      'name': name,
      'code': code,
      if (trainingMatrixJson != null) 'trainingMatrixJson': trainingMatrixJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobRoleImpl extends JobRole {
  _JobRoleImpl({
    int? id,
    required int departmentId,
    _i2.Department? department,
    required String name,
    required String code,
    String? trainingMatrixJson,
  }) : super._(
         id: id,
         departmentId: departmentId,
         department: department,
         name: name,
         code: code,
         trainingMatrixJson: trainingMatrixJson,
       );

  /// Returns a shallow copy of this [JobRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobRole copyWith({
    Object? id = _Undefined,
    int? departmentId,
    Object? department = _Undefined,
    String? name,
    String? code,
    Object? trainingMatrixJson = _Undefined,
  }) {
    return JobRole(
      id: id is int? ? id : this.id,
      departmentId: departmentId ?? this.departmentId,
      department: department is _i2.Department?
          ? department
          : this.department?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      trainingMatrixJson: trainingMatrixJson is String?
          ? trainingMatrixJson
          : this.trainingMatrixJson,
    );
  }
}
