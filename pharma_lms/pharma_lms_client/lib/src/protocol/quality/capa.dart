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
import '../quality/quality_event.dart' as _i2;
import '../training/training_assignment.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// CAPA - Corrective and Preventive Action.
abstract class Capa implements _i1.SerializableModel {
  Capa._({
    this.id,
    required this.qualityEventId,
    this.qualityEvent,
    this.description,
    this.rootCause,
    bool? trainingRequired,
    this.trainingAssignmentId,
    this.trainingAssignment,
  }) : trainingRequired = trainingRequired ?? false;

  factory Capa({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    String? description,
    String? rootCause,
    bool? trainingRequired,
    int? trainingAssignmentId,
    _i3.TrainingAssignment? trainingAssignment,
  }) = _CapaImpl;

  factory Capa.fromJson(Map<String, dynamic> jsonSerialization) {
    return Capa(
      id: jsonSerialization['id'] as int?,
      qualityEventId: jsonSerialization['qualityEventId'] as int,
      qualityEvent: jsonSerialization['qualityEvent'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.QualityEvent>(
              jsonSerialization['qualityEvent'],
            ),
      description: jsonSerialization['description'] as String?,
      rootCause: jsonSerialization['rootCause'] as String?,
      trainingRequired: jsonSerialization['trainingRequired'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['trainingRequired'],
            ),
      trainingAssignmentId: jsonSerialization['trainingAssignmentId'] as int?,
      trainingAssignment: jsonSerialization['trainingAssignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.TrainingAssignment>(
              jsonSerialization['trainingAssignment'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int qualityEventId;

  /// The quality event.
  _i2.QualityEvent? qualityEvent;

  /// Description.
  String? description;

  /// Root cause analysis.
  String? rootCause;

  /// Whether training is required.
  bool trainingRequired;

  int? trainingAssignmentId;

  /// Training assignment if created.
  _i3.TrainingAssignment? trainingAssignment;

  /// Returns a shallow copy of this [Capa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Capa copyWith({
    int? id,
    int? qualityEventId,
    _i2.QualityEvent? qualityEvent,
    String? description,
    String? rootCause,
    bool? trainingRequired,
    int? trainingAssignmentId,
    _i3.TrainingAssignment? trainingAssignment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Capa',
      if (id != null) 'id': id,
      'qualityEventId': qualityEventId,
      if (qualityEvent != null) 'qualityEvent': qualityEvent?.toJson(),
      if (description != null) 'description': description,
      if (rootCause != null) 'rootCause': rootCause,
      'trainingRequired': trainingRequired,
      if (trainingAssignmentId != null)
        'trainingAssignmentId': trainingAssignmentId,
      if (trainingAssignment != null)
        'trainingAssignment': trainingAssignment?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CapaImpl extends Capa {
  _CapaImpl({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    String? description,
    String? rootCause,
    bool? trainingRequired,
    int? trainingAssignmentId,
    _i3.TrainingAssignment? trainingAssignment,
  }) : super._(
         id: id,
         qualityEventId: qualityEventId,
         qualityEvent: qualityEvent,
         description: description,
         rootCause: rootCause,
         trainingRequired: trainingRequired,
         trainingAssignmentId: trainingAssignmentId,
         trainingAssignment: trainingAssignment,
       );

  /// Returns a shallow copy of this [Capa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Capa copyWith({
    Object? id = _Undefined,
    int? qualityEventId,
    Object? qualityEvent = _Undefined,
    Object? description = _Undefined,
    Object? rootCause = _Undefined,
    bool? trainingRequired,
    Object? trainingAssignmentId = _Undefined,
    Object? trainingAssignment = _Undefined,
  }) {
    return Capa(
      id: id is int? ? id : this.id,
      qualityEventId: qualityEventId ?? this.qualityEventId,
      qualityEvent: qualityEvent is _i2.QualityEvent?
          ? qualityEvent
          : this.qualityEvent?.copyWith(),
      description: description is String? ? description : this.description,
      rootCause: rootCause is String? ? rootCause : this.rootCause,
      trainingRequired: trainingRequired ?? this.trainingRequired,
      trainingAssignmentId: trainingAssignmentId is int?
          ? trainingAssignmentId
          : this.trainingAssignmentId,
      trainingAssignment: trainingAssignment is _i3.TrainingAssignment?
          ? trainingAssignment
          : this.trainingAssignment?.copyWith(),
    );
  }
}
