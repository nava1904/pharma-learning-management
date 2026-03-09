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

abstract class KafkaEventProcessorProcessEmployeeTransferredModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  KafkaEventProcessorProcessEmployeeTransferredModel._({
    required this.userId,
    required this.oldDepartmentId,
    required this.newDepartmentId,
    required this.oldRoleId,
    required this.newRoleId,
  });

  factory KafkaEventProcessorProcessEmployeeTransferredModel({
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) = _KafkaEventProcessorProcessEmployeeTransferredModelImpl;

  factory KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return KafkaEventProcessorProcessEmployeeTransferredModel(
      userId: jsonSerialization['userId'] as String,
      oldDepartmentId: jsonSerialization['oldDepartmentId'] as String,
      newDepartmentId: jsonSerialization['newDepartmentId'] as String,
      oldRoleId: jsonSerialization['oldRoleId'] as String,
      newRoleId: jsonSerialization['newRoleId'] as String,
    );
  }

  String userId;

  String oldDepartmentId;

  String newDepartmentId;

  String oldRoleId;

  String newRoleId;

  /// Returns a shallow copy of this [KafkaEventProcessorProcessEmployeeTransferredModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KafkaEventProcessorProcessEmployeeTransferredModel copyWith({
    String? userId,
    String? oldDepartmentId,
    String? newDepartmentId,
    String? oldRoleId,
    String? newRoleId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KafkaEventProcessorProcessEmployeeTransferredModel',
      'userId': userId,
      'oldDepartmentId': oldDepartmentId,
      'newDepartmentId': newDepartmentId,
      'oldRoleId': oldRoleId,
      'newRoleId': newRoleId,
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

class _KafkaEventProcessorProcessEmployeeTransferredModelImpl
    extends KafkaEventProcessorProcessEmployeeTransferredModel {
  _KafkaEventProcessorProcessEmployeeTransferredModelImpl({
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) : super._(
         userId: userId,
         oldDepartmentId: oldDepartmentId,
         newDepartmentId: newDepartmentId,
         oldRoleId: oldRoleId,
         newRoleId: newRoleId,
       );

  /// Returns a shallow copy of this [KafkaEventProcessorProcessEmployeeTransferredModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KafkaEventProcessorProcessEmployeeTransferredModel copyWith({
    String? userId,
    String? oldDepartmentId,
    String? newDepartmentId,
    String? oldRoleId,
    String? newRoleId,
  }) {
    return KafkaEventProcessorProcessEmployeeTransferredModel(
      userId: userId ?? this.userId,
      oldDepartmentId: oldDepartmentId ?? this.oldDepartmentId,
      newDepartmentId: newDepartmentId ?? this.newDepartmentId,
      oldRoleId: oldRoleId ?? this.oldRoleId,
      newRoleId: newRoleId ?? this.newRoleId,
    );
  }
}
