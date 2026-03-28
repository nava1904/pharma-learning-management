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

/// Summary row for trainer "Messages" inbox (learner ↔ instructor threads).
abstract class LearnerSupportThreadSummary implements _i1.SerializableModel {
  LearnerSupportThreadSummary._({
    required this.courseVersionId,
    required this.courseId,
    required this.courseTitle,
    required this.lastMessageBody,
    required this.lastMessageAt,
    required this.lastFromUserId,
    required this.lastFromName,
    required this.messageCount,
    required this.unreadForTrainer,
  });

  factory LearnerSupportThreadSummary({
    required int courseVersionId,
    required int courseId,
    required String courseTitle,
    required String lastMessageBody,
    required DateTime lastMessageAt,
    required int lastFromUserId,
    required String lastFromName,
    required int messageCount,
    required int unreadForTrainer,
  }) = _LearnerSupportThreadSummaryImpl;

  factory LearnerSupportThreadSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LearnerSupportThreadSummary(
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseId: jsonSerialization['courseId'] as int,
      courseTitle: jsonSerialization['courseTitle'] as String,
      lastMessageBody: jsonSerialization['lastMessageBody'] as String,
      lastMessageAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastMessageAt'],
      ),
      lastFromUserId: jsonSerialization['lastFromUserId'] as int,
      lastFromName: jsonSerialization['lastFromName'] as String,
      messageCount: jsonSerialization['messageCount'] as int,
      unreadForTrainer: jsonSerialization['unreadForTrainer'] as int,
    );
  }

  int courseVersionId;

  int courseId;

  String courseTitle;

  String lastMessageBody;

  DateTime lastMessageAt;

  int lastFromUserId;

  String lastFromName;

  int messageCount;

  int unreadForTrainer;

  /// Returns a shallow copy of this [LearnerSupportThreadSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LearnerSupportThreadSummary copyWith({
    int? courseVersionId,
    int? courseId,
    String? courseTitle,
    String? lastMessageBody,
    DateTime? lastMessageAt,
    int? lastFromUserId,
    String? lastFromName,
    int? messageCount,
    int? unreadForTrainer,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LearnerSupportThreadSummary',
      'courseVersionId': courseVersionId,
      'courseId': courseId,
      'courseTitle': courseTitle,
      'lastMessageBody': lastMessageBody,
      'lastMessageAt': lastMessageAt.toJson(),
      'lastFromUserId': lastFromUserId,
      'lastFromName': lastFromName,
      'messageCount': messageCount,
      'unreadForTrainer': unreadForTrainer,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LearnerSupportThreadSummaryImpl extends LearnerSupportThreadSummary {
  _LearnerSupportThreadSummaryImpl({
    required int courseVersionId,
    required int courseId,
    required String courseTitle,
    required String lastMessageBody,
    required DateTime lastMessageAt,
    required int lastFromUserId,
    required String lastFromName,
    required int messageCount,
    required int unreadForTrainer,
  }) : super._(
         courseVersionId: courseVersionId,
         courseId: courseId,
         courseTitle: courseTitle,
         lastMessageBody: lastMessageBody,
         lastMessageAt: lastMessageAt,
         lastFromUserId: lastFromUserId,
         lastFromName: lastFromName,
         messageCount: messageCount,
         unreadForTrainer: unreadForTrainer,
       );

  /// Returns a shallow copy of this [LearnerSupportThreadSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LearnerSupportThreadSummary copyWith({
    int? courseVersionId,
    int? courseId,
    String? courseTitle,
    String? lastMessageBody,
    DateTime? lastMessageAt,
    int? lastFromUserId,
    String? lastFromName,
    int? messageCount,
    int? unreadForTrainer,
  }) {
    return LearnerSupportThreadSummary(
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      lastMessageBody: lastMessageBody ?? this.lastMessageBody,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastFromUserId: lastFromUserId ?? this.lastFromUserId,
      lastFromName: lastFromName ?? this.lastFromName,
      messageCount: messageCount ?? this.messageCount,
      unreadForTrainer: unreadForTrainer ?? this.unreadForTrainer,
    );
  }
}
