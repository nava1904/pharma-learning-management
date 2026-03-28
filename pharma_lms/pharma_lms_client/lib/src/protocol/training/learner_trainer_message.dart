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
import '../course/course_version.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../training/learner_trainer_message.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Message between a learner and the course trainer for a given course version.
abstract class LearnerTrainerMessage implements _i1.SerializableModel {
  LearnerTrainerMessage._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.fromUserId,
    this.fromUser,
    required this.toUserId,
    this.toUser,
    required this.body,
    this.parentMessageId,
    this.parentMessage,
    this.readAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory LearnerTrainerMessage({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int fromUserId,
    _i3.PharmaUser? fromUser,
    required int toUserId,
    _i3.PharmaUser? toUser,
    required String body,
    int? parentMessageId,
    _i4.LearnerTrainerMessage? parentMessage,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _LearnerTrainerMessageImpl;

  factory LearnerTrainerMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LearnerTrainerMessage(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      fromUserId: jsonSerialization['fromUserId'] as int,
      fromUser: jsonSerialization['fromUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['fromUser'],
            ),
      toUserId: jsonSerialization['toUserId'] as int,
      toUser: jsonSerialization['toUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['toUser'],
            ),
      body: jsonSerialization['body'] as String,
      parentMessageId: jsonSerialization['parentMessageId'] as int?,
      parentMessage: jsonSerialization['parentMessage'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.LearnerTrainerMessage>(
              jsonSerialization['parentMessage'],
            ),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseVersionId;

  _i2.CourseVersion? courseVersion;

  int fromUserId;

  _i3.PharmaUser? fromUser;

  int toUserId;

  _i3.PharmaUser? toUser;

  String body;

  int? parentMessageId;

  _i4.LearnerTrainerMessage? parentMessage;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [LearnerTrainerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LearnerTrainerMessage copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? fromUserId,
    _i3.PharmaUser? fromUser,
    int? toUserId,
    _i3.PharmaUser? toUser,
    String? body,
    int? parentMessageId,
    _i4.LearnerTrainerMessage? parentMessage,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LearnerTrainerMessage',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'fromUserId': fromUserId,
      if (fromUser != null) 'fromUser': fromUser?.toJson(),
      'toUserId': toUserId,
      if (toUser != null) 'toUser': toUser?.toJson(),
      'body': body,
      if (parentMessageId != null) 'parentMessageId': parentMessageId,
      if (parentMessage != null) 'parentMessage': parentMessage?.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LearnerTrainerMessageImpl extends LearnerTrainerMessage {
  _LearnerTrainerMessageImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int fromUserId,
    _i3.PharmaUser? fromUser,
    required int toUserId,
    _i3.PharmaUser? toUser,
    required String body,
    int? parentMessageId,
    _i4.LearnerTrainerMessage? parentMessage,
    DateTime? readAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         fromUserId: fromUserId,
         fromUser: fromUser,
         toUserId: toUserId,
         toUser: toUser,
         body: body,
         parentMessageId: parentMessageId,
         parentMessage: parentMessage,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LearnerTrainerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LearnerTrainerMessage copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? fromUserId,
    Object? fromUser = _Undefined,
    int? toUserId,
    Object? toUser = _Undefined,
    String? body,
    Object? parentMessageId = _Undefined,
    Object? parentMessage = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return LearnerTrainerMessage(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      fromUserId: fromUserId ?? this.fromUserId,
      fromUser: fromUser is _i3.PharmaUser?
          ? fromUser
          : this.fromUser?.copyWith(),
      toUserId: toUserId ?? this.toUserId,
      toUser: toUser is _i3.PharmaUser? ? toUser : this.toUser?.copyWith(),
      body: body ?? this.body,
      parentMessageId: parentMessageId is int?
          ? parentMessageId
          : this.parentMessageId,
      parentMessage: parentMessage is _i4.LearnerTrainerMessage?
          ? parentMessage
          : this.parentMessage?.copyWith(),
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
