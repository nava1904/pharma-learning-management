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
import '../training/training_batch.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Instructor or admin post visible to batch roster (assignments, live session notes, general).
abstract class BatchAnnouncement implements _i1.SerializableModel {
  BatchAnnouncement._({
    this.id,
    required this.batchId,
    this.batch,
    required this.title,
    required this.body,
    String? kind,
    this.relatedLiveClassId,
    this.createdById,
    this.createdBy,
    DateTime? createdAt,
  }) : kind = kind ?? 'general',
       createdAt = createdAt ?? DateTime.now();

  factory BatchAnnouncement({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    required String body,
    String? kind,
    int? relatedLiveClassId,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) = _BatchAnnouncementImpl;

  factory BatchAnnouncement.fromJson(Map<String, dynamic> jsonSerialization) {
    return BatchAnnouncement(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      kind: jsonSerialization['kind'] as String?,
      relatedLiveClassId: jsonSerialization['relatedLiveClassId'] as int?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int batchId;

  _i2.TrainingBatch? batch;

  String title;

  String body;

  /// general | assignment | live_session
  String kind;

  int? relatedLiveClassId;

  int? createdById;

  _i3.PharmaUser? createdBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [BatchAnnouncement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchAnnouncement copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    String? title,
    String? body,
    String? kind,
    int? relatedLiveClassId,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BatchAnnouncement',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      'title': title,
      'body': body,
      'kind': kind,
      if (relatedLiveClassId != null) 'relatedLiveClassId': relatedLiveClassId,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchAnnouncementImpl extends BatchAnnouncement {
  _BatchAnnouncementImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    required String body,
    String? kind,
    int? relatedLiveClassId,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         title: title,
         body: body,
         kind: kind,
         relatedLiveClassId: relatedLiveClassId,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BatchAnnouncement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchAnnouncement copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    String? title,
    String? body,
    String? kind,
    Object? relatedLiveClassId = _Undefined,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
  }) {
    return BatchAnnouncement(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      title: title ?? this.title,
      body: body ?? this.body,
      kind: kind ?? this.kind,
      relatedLiveClassId: relatedLiveClassId is int?
          ? relatedLiveClassId
          : this.relatedLiveClassId,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
