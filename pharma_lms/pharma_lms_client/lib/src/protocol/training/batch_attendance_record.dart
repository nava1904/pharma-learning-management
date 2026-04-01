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
import '../training/live_class.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Batch attendance record for ILT sessions.
abstract class BatchAttendanceRecord implements _i1.SerializableModel {
  BatchAttendanceRecord._({
    this.id,
    required this.batchId,
    this.batch,
    this.liveClassId,
    this.liveClass,
    required this.userId,
    this.user,
    String? status,
    DateTime? markedAt,
    required this.markedById,
    this.markedBy,
    this.notes,
  }) : status = status ?? 'present',
       markedAt = markedAt ?? DateTime.now();

  factory BatchAttendanceRecord({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    int? liveClassId,
    _i3.LiveClass? liveClass,
    required int userId,
    _i4.PharmaUser? user,
    String? status,
    DateTime? markedAt,
    required int markedById,
    _i4.PharmaUser? markedBy,
    String? notes,
  }) = _BatchAttendanceRecordImpl;

  factory BatchAttendanceRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BatchAttendanceRecord(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      liveClassId: jsonSerialization['liveClassId'] as int?,
      liveClass: jsonSerialization['liveClass'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.LiveClass>(
              jsonSerialization['liveClass'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['user'],
            ),
      status: jsonSerialization['status'] as String?,
      markedAt: jsonSerialization['markedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['markedAt']),
      markedById: jsonSerialization['markedById'] as int,
      markedBy: jsonSerialization['markedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['markedBy'],
            ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int batchId;

  /// The training batch.
  _i2.TrainingBatch? batch;

  int? liveClassId;

  /// The live class session (if applicable).
  _i3.LiveClass? liveClass;

  int userId;

  /// The user who attended.
  _i4.PharmaUser? user;

  /// Attendance status: present, absent, excused, late.
  String status;

  /// When attendance was marked.
  DateTime markedAt;

  int markedById;

  /// Who marked attendance (instructor/admin).
  _i4.PharmaUser? markedBy;

  /// Notes (reason for absence, etc.).
  String? notes;

  /// Returns a shallow copy of this [BatchAttendanceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchAttendanceRecord copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    int? liveClassId,
    _i3.LiveClass? liveClass,
    int? userId,
    _i4.PharmaUser? user,
    String? status,
    DateTime? markedAt,
    int? markedById,
    _i4.PharmaUser? markedBy,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BatchAttendanceRecord',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      if (liveClassId != null) 'liveClassId': liveClassId,
      if (liveClass != null) 'liveClass': liveClass?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'status': status,
      'markedAt': markedAt.toJson(),
      'markedById': markedById,
      if (markedBy != null) 'markedBy': markedBy?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchAttendanceRecordImpl extends BatchAttendanceRecord {
  _BatchAttendanceRecordImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    int? liveClassId,
    _i3.LiveClass? liveClass,
    required int userId,
    _i4.PharmaUser? user,
    String? status,
    DateTime? markedAt,
    required int markedById,
    _i4.PharmaUser? markedBy,
    String? notes,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         liveClassId: liveClassId,
         liveClass: liveClass,
         userId: userId,
         user: user,
         status: status,
         markedAt: markedAt,
         markedById: markedById,
         markedBy: markedBy,
         notes: notes,
       );

  /// Returns a shallow copy of this [BatchAttendanceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchAttendanceRecord copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    Object? liveClassId = _Undefined,
    Object? liveClass = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? status,
    DateTime? markedAt,
    int? markedById,
    Object? markedBy = _Undefined,
    Object? notes = _Undefined,
  }) {
    return BatchAttendanceRecord(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      liveClassId: liveClassId is int? ? liveClassId : this.liveClassId,
      liveClass: liveClass is _i3.LiveClass?
          ? liveClass
          : this.liveClass?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i4.PharmaUser? ? user : this.user?.copyWith(),
      status: status ?? this.status,
      markedAt: markedAt ?? this.markedAt,
      markedById: markedById ?? this.markedById,
      markedBy: markedBy is _i4.PharmaUser?
          ? markedBy
          : this.markedBy?.copyWith(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
