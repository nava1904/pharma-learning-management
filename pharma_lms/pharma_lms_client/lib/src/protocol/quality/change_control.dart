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
import '../document/document_version.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Change control linking to document and training.
abstract class ChangeControl implements _i1.SerializableModel {
  ChangeControl._({
    this.id,
    required this.qualityEventId,
    this.qualityEvent,
    required this.documentVersionId,
    this.documentVersion,
    this.trainingTriggerId,
  });

  factory ChangeControl({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    required int documentVersionId,
    _i3.DocumentVersion? documentVersion,
    int? trainingTriggerId,
  }) = _ChangeControlImpl;

  factory ChangeControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChangeControl(
      id: jsonSerialization['id'] as int?,
      qualityEventId: jsonSerialization['qualityEventId'] as int,
      qualityEvent: jsonSerialization['qualityEvent'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.QualityEvent>(
              jsonSerialization['qualityEvent'],
            ),
      documentVersionId: jsonSerialization['documentVersionId'] as int,
      documentVersion: jsonSerialization['documentVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.DocumentVersion>(
              jsonSerialization['documentVersion'],
            ),
      trainingTriggerId: jsonSerialization['trainingTriggerId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int qualityEventId;

  /// The quality event.
  _i2.QualityEvent? qualityEvent;

  int documentVersionId;

  /// The document version changed.
  _i3.DocumentVersion? documentVersion;

  /// Training trigger/assignment ID.
  int? trainingTriggerId;

  /// Returns a shallow copy of this [ChangeControl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChangeControl copyWith({
    int? id,
    int? qualityEventId,
    _i2.QualityEvent? qualityEvent,
    int? documentVersionId,
    _i3.DocumentVersion? documentVersion,
    int? trainingTriggerId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChangeControl',
      if (id != null) 'id': id,
      'qualityEventId': qualityEventId,
      if (qualityEvent != null) 'qualityEvent': qualityEvent?.toJson(),
      'documentVersionId': documentVersionId,
      if (documentVersion != null) 'documentVersion': documentVersion?.toJson(),
      if (trainingTriggerId != null) 'trainingTriggerId': trainingTriggerId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChangeControlImpl extends ChangeControl {
  _ChangeControlImpl({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    required int documentVersionId,
    _i3.DocumentVersion? documentVersion,
    int? trainingTriggerId,
  }) : super._(
         id: id,
         qualityEventId: qualityEventId,
         qualityEvent: qualityEvent,
         documentVersionId: documentVersionId,
         documentVersion: documentVersion,
         trainingTriggerId: trainingTriggerId,
       );

  /// Returns a shallow copy of this [ChangeControl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChangeControl copyWith({
    Object? id = _Undefined,
    int? qualityEventId,
    Object? qualityEvent = _Undefined,
    int? documentVersionId,
    Object? documentVersion = _Undefined,
    Object? trainingTriggerId = _Undefined,
  }) {
    return ChangeControl(
      id: id is int? ? id : this.id,
      qualityEventId: qualityEventId ?? this.qualityEventId,
      qualityEvent: qualityEvent is _i2.QualityEvent?
          ? qualityEvent
          : this.qualityEvent?.copyWith(),
      documentVersionId: documentVersionId ?? this.documentVersionId,
      documentVersion: documentVersion is _i3.DocumentVersion?
          ? documentVersion
          : this.documentVersion?.copyWith(),
      trainingTriggerId: trainingTriggerId is int?
          ? trainingTriggerId
          : this.trainingTriggerId,
    );
  }
}
