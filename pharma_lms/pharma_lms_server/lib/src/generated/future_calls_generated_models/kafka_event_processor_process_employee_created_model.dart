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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class KafkaEventProcessorProcessEmployeeCreatedModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  KafkaEventProcessorProcessEmployeeCreatedModel._({
    required this.userId,
    required this.departmentId,
    required this.roleId,
  });

  factory KafkaEventProcessorProcessEmployeeCreatedModel({
    required String userId,
    required String departmentId,
    required String roleId,
  }) = _KafkaEventProcessorProcessEmployeeCreatedModelImpl;

  factory KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return KafkaEventProcessorProcessEmployeeCreatedModel(
      userId: jsonSerialization['userId'] as String,
      departmentId: jsonSerialization['departmentId'] as String,
      roleId: jsonSerialization['roleId'] as String,
    );
  }

  String userId;

  String departmentId;

  String roleId;

  /// Returns a shallow copy of this [KafkaEventProcessorProcessEmployeeCreatedModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KafkaEventProcessorProcessEmployeeCreatedModel copyWith({
    String? userId,
    String? departmentId,
    String? roleId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KafkaEventProcessorProcessEmployeeCreatedModel',
      'userId': userId,
      'departmentId': departmentId,
      'roleId': roleId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _KafkaEventProcessorProcessEmployeeCreatedModelImpl
    extends KafkaEventProcessorProcessEmployeeCreatedModel {
  _KafkaEventProcessorProcessEmployeeCreatedModelImpl({
    required String userId,
    required String departmentId,
    required String roleId,
  }) : super._(
         userId: userId,
         departmentId: departmentId,
         roleId: roleId,
       );

  /// Returns a shallow copy of this [KafkaEventProcessorProcessEmployeeCreatedModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KafkaEventProcessorProcessEmployeeCreatedModel copyWith({
    String? userId,
    String? departmentId,
    String? roleId,
  }) {
    return KafkaEventProcessorProcessEmployeeCreatedModel(
      userId: userId ?? this.userId,
      departmentId: departmentId ?? this.departmentId,
      roleId: roleId ?? this.roleId,
    );
  }
}
