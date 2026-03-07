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

abstract class KafkaEventProcessorProcessSopUpdatedModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  KafkaEventProcessorProcessSopUpdatedModel._({
    required this.documentId,
    required this.courseVersionId,
    required this.reason,
  });

  factory KafkaEventProcessorProcessSopUpdatedModel({
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) = _KafkaEventProcessorProcessSopUpdatedModelImpl;

  factory KafkaEventProcessorProcessSopUpdatedModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return KafkaEventProcessorProcessSopUpdatedModel(
      documentId: jsonSerialization['documentId'] as String,
      courseVersionId: jsonSerialization['courseVersionId'] as String,
      reason: jsonSerialization['reason'] as String,
    );
  }

  String documentId;

  String courseVersionId;

  String reason;

  /// Returns a shallow copy of this [KafkaEventProcessorProcessSopUpdatedModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KafkaEventProcessorProcessSopUpdatedModel copyWith({
    String? documentId,
    String? courseVersionId,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KafkaEventProcessorProcessSopUpdatedModel',
      'documentId': documentId,
      'courseVersionId': courseVersionId,
      'reason': reason,
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

class _KafkaEventProcessorProcessSopUpdatedModelImpl
    extends KafkaEventProcessorProcessSopUpdatedModel {
  _KafkaEventProcessorProcessSopUpdatedModelImpl({
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) : super._(
         documentId: documentId,
         courseVersionId: courseVersionId,
         reason: reason,
       );

  /// Returns a shallow copy of this [KafkaEventProcessorProcessSopUpdatedModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KafkaEventProcessorProcessSopUpdatedModel copyWith({
    String? documentId,
    String? courseVersionId,
    String? reason,
  }) {
    return KafkaEventProcessorProcessSopUpdatedModel(
      documentId: documentId ?? this.documentId,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      reason: reason ?? this.reason,
    );
  }
}
