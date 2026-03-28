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

/// Live class session within a training batch.
abstract class LiveClass implements _i1.SerializableModel {
  LiveClass._({
    this.id,
    required this.batchId,
    this.batch,
    required this.title,
    this.description,
    required this.scheduledAt,
    int? durationMinutes,
    this.meetingUrl,
    bool? autoRecording,
    this.createdById,
    this.createdBy,
    DateTime? createdAt,
  }) : durationMinutes = durationMinutes ?? 60,
       autoRecording = autoRecording ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory LiveClass({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    String? description,
    required DateTime scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) = _LiveClassImpl;

  factory LiveClass.fromJson(Map<String, dynamic> jsonSerialization) {
    return LiveClass(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      scheduledAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledAt'],
      ),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      meetingUrl: jsonSerialization['meetingUrl'] as String?,
      autoRecording: jsonSerialization['autoRecording'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['autoRecording']),
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

  /// The training batch.
  _i2.TrainingBatch? batch;

  /// Session title.
  String title;

  /// Session description.
  String? description;

  /// When the session is scheduled.
  DateTime scheduledAt;

  /// Duration in minutes.
  int durationMinutes;

  /// Meeting/conference URL.
  String? meetingUrl;

  /// Whether auto-recording is enabled.
  bool autoRecording;

  int? createdById;

  /// User who created this session.
  _i3.PharmaUser? createdBy;

  /// Created timestamp.
  DateTime createdAt;

  /// Returns a shallow copy of this [LiveClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LiveClass copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    String? title,
    String? description,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LiveClass',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'scheduledAt': scheduledAt.toJson(),
      'durationMinutes': durationMinutes,
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      'autoRecording': autoRecording,
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

class _LiveClassImpl extends LiveClass {
  _LiveClassImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    String? description,
    required DateTime scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         title: title,
         description: description,
         scheduledAt: scheduledAt,
         durationMinutes: durationMinutes,
         meetingUrl: meetingUrl,
         autoRecording: autoRecording,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LiveClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LiveClass copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    String? title,
    Object? description = _Undefined,
    DateTime? scheduledAt,
    int? durationMinutes,
    Object? meetingUrl = _Undefined,
    bool? autoRecording,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
  }) {
    return LiveClass(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      meetingUrl: meetingUrl is String? ? meetingUrl : this.meetingUrl,
      autoRecording: autoRecording ?? this.autoRecording,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
