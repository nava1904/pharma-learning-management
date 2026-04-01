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

/// Summary row for QA/SME review inbox (trainer ↔ QA threads).
abstract class SmeThreadSummary implements _i1.SerializableModel {
  SmeThreadSummary._({
    required this.courseVersionId,
    required this.courseId,
    required this.courseTitle,
    required this.lastCommentBody,
    required this.lastCommentAt,
    required this.lastFromUserId,
    required this.lastFromName,
    required this.commentCount,
    required this.unresolvedCount,
    required this.unreadCount,
  });

  factory SmeThreadSummary({
    required int courseVersionId,
    required int courseId,
    required String courseTitle,
    required String lastCommentBody,
    required DateTime lastCommentAt,
    required int lastFromUserId,
    required String lastFromName,
    required int commentCount,
    required int unresolvedCount,
    required int unreadCount,
  }) = _SmeThreadSummaryImpl;

  factory SmeThreadSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return SmeThreadSummary(
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseId: jsonSerialization['courseId'] as int,
      courseTitle: jsonSerialization['courseTitle'] as String,
      lastCommentBody: jsonSerialization['lastCommentBody'] as String,
      lastCommentAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastCommentAt'],
      ),
      lastFromUserId: jsonSerialization['lastFromUserId'] as int,
      lastFromName: jsonSerialization['lastFromName'] as String,
      commentCount: jsonSerialization['commentCount'] as int,
      unresolvedCount: jsonSerialization['unresolvedCount'] as int,
      unreadCount: jsonSerialization['unreadCount'] as int,
    );
  }

  int courseVersionId;

  int courseId;

  String courseTitle;

  String lastCommentBody;

  DateTime lastCommentAt;

  int lastFromUserId;

  String lastFromName;

  int commentCount;

  int unresolvedCount;

  int unreadCount;

  /// Returns a shallow copy of this [SmeThreadSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SmeThreadSummary copyWith({
    int? courseVersionId,
    int? courseId,
    String? courseTitle,
    String? lastCommentBody,
    DateTime? lastCommentAt,
    int? lastFromUserId,
    String? lastFromName,
    int? commentCount,
    int? unresolvedCount,
    int? unreadCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SmeThreadSummary',
      'courseVersionId': courseVersionId,
      'courseId': courseId,
      'courseTitle': courseTitle,
      'lastCommentBody': lastCommentBody,
      'lastCommentAt': lastCommentAt.toJson(),
      'lastFromUserId': lastFromUserId,
      'lastFromName': lastFromName,
      'commentCount': commentCount,
      'unresolvedCount': unresolvedCount,
      'unreadCount': unreadCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SmeThreadSummaryImpl extends SmeThreadSummary {
  _SmeThreadSummaryImpl({
    required int courseVersionId,
    required int courseId,
    required String courseTitle,
    required String lastCommentBody,
    required DateTime lastCommentAt,
    required int lastFromUserId,
    required String lastFromName,
    required int commentCount,
    required int unresolvedCount,
    required int unreadCount,
  }) : super._(
         courseVersionId: courseVersionId,
         courseId: courseId,
         courseTitle: courseTitle,
         lastCommentBody: lastCommentBody,
         lastCommentAt: lastCommentAt,
         lastFromUserId: lastFromUserId,
         lastFromName: lastFromName,
         commentCount: commentCount,
         unresolvedCount: unresolvedCount,
         unreadCount: unreadCount,
       );

  /// Returns a shallow copy of this [SmeThreadSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SmeThreadSummary copyWith({
    int? courseVersionId,
    int? courseId,
    String? courseTitle,
    String? lastCommentBody,
    DateTime? lastCommentAt,
    int? lastFromUserId,
    String? lastFromName,
    int? commentCount,
    int? unresolvedCount,
    int? unreadCount,
  }) {
    return SmeThreadSummary(
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      lastCommentBody: lastCommentBody ?? this.lastCommentBody,
      lastCommentAt: lastCommentAt ?? this.lastCommentAt,
      lastFromUserId: lastFromUserId ?? this.lastFromUserId,
      lastFromName: lastFromName ?? this.lastFromName,
      commentCount: commentCount ?? this.commentCount,
      unresolvedCount: unresolvedCount ?? this.unresolvedCount,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
