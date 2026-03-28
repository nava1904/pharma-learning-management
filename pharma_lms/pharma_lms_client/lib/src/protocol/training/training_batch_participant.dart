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

/// User membership in an ILT training batch (roster).
abstract class TrainingBatchParticipant implements _i1.SerializableModel {
  TrainingBatchParticipant._({
    this.id,
    required this.batchId,
    this.batch,
    required this.userId,
    this.user,
    DateTime? enrolledAt,
    this.role,
  }) : enrolledAt = enrolledAt ?? DateTime.now();

  factory TrainingBatchParticipant({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required int userId,
    _i3.PharmaUser? user,
    DateTime? enrolledAt,
    String? role,
  }) = _TrainingBatchParticipantImpl;

  factory TrainingBatchParticipant.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingBatchParticipant(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      enrolledAt: jsonSerialization['enrolledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['enrolledAt']),
      role: jsonSerialization['role'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int batchId;

  /// Batch cohort.
  _i2.TrainingBatch? batch;

  int userId;

  /// Learner or mentor.
  _i3.PharmaUser? user;

  /// When added to roster.
  DateTime enrolledAt;

  /// Optional: learner, mentor.
  String? role;

  /// Returns a shallow copy of this [TrainingBatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingBatchParticipant copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    int? userId,
    _i3.PharmaUser? user,
    DateTime? enrolledAt,
    String? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingBatchParticipant',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'enrolledAt': enrolledAt.toJson(),
      if (role != null) 'role': role,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingBatchParticipantImpl extends TrainingBatchParticipant {
  _TrainingBatchParticipantImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required int userId,
    _i3.PharmaUser? user,
    DateTime? enrolledAt,
    String? role,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         userId: userId,
         user: user,
         enrolledAt: enrolledAt,
         role: role,
       );

  /// Returns a shallow copy of this [TrainingBatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingBatchParticipant copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    int? userId,
    Object? user = _Undefined,
    DateTime? enrolledAt,
    Object? role = _Undefined,
  }) {
    return TrainingBatchParticipant(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      enrolledAt: enrolledAt ?? this.enrolledAt,
      role: role is String? ? role : this.role,
    );
  }
}
