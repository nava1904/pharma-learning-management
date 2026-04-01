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
import '../sme/sme_review_comment.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Threaded SME review comment on a course version.
abstract class SmeReviewComment implements _i1.SerializableModel {
  SmeReviewComment._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.authorId,
    this.author,
    required this.sectionRef,
    String? severity,
    required this.body,
    bool? resolved,
    this.trainerResponse,
    this.resolvedAt,
    DateTime? createdAt,
    this.parentCommentId,
    this.parentComment,
    this.readAt,
  }) : severity = severity ?? 'note',
       resolved = resolved ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory SmeReviewComment({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int authorId,
    _i3.PharmaUser? author,
    required String sectionRef,
    String? severity,
    required String body,
    bool? resolved,
    String? trainerResponse,
    DateTime? resolvedAt,
    DateTime? createdAt,
    int? parentCommentId,
    _i4.SmeReviewComment? parentComment,
    DateTime? readAt,
  }) = _SmeReviewCommentImpl;

  factory SmeReviewComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SmeReviewComment(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      authorId: jsonSerialization['authorId'] as int,
      author: jsonSerialization['author'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['author'],
            ),
      sectionRef: jsonSerialization['sectionRef'] as String,
      severity: jsonSerialization['severity'] as String?,
      body: jsonSerialization['body'] as String,
      resolved: jsonSerialization['resolved'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['resolved']),
      trainerResponse: jsonSerialization['trainerResponse'] as String?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      parentCommentId: jsonSerialization['parentCommentId'] as int?,
      parentComment: jsonSerialization['parentComment'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.SmeReviewComment>(
              jsonSerialization['parentComment'],
            ),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseVersionId;

  /// Course version being reviewed.
  _i2.CourseVersion? courseVersion;

  int authorId;

  /// Author (usually the SME).
  _i3.PharmaUser? author;

  /// Section reference (e.g. module label or lesson id).
  String sectionRef;

  /// note, major, critical
  String severity;

  /// Comment body.
  String body;

  /// Trainer marked resolved.
  bool resolved;

  /// Trainer response when resolving.
  String? trainerResponse;

  /// When resolved.
  DateTime? resolvedAt;

  /// Created timestamp.
  DateTime createdAt;

  int? parentCommentId;

  /// Optional parent comment for threaded QA / trainer replies.
  _i4.SmeReviewComment? parentComment;

  /// When the recipient read this comment (null = unread).
  DateTime? readAt;

  /// Returns a shallow copy of this [SmeReviewComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SmeReviewComment copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? authorId,
    _i3.PharmaUser? author,
    String? sectionRef,
    String? severity,
    String? body,
    bool? resolved,
    String? trainerResponse,
    DateTime? resolvedAt,
    DateTime? createdAt,
    int? parentCommentId,
    _i4.SmeReviewComment? parentComment,
    DateTime? readAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SmeReviewComment',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'authorId': authorId,
      if (author != null) 'author': author?.toJson(),
      'sectionRef': sectionRef,
      'severity': severity,
      'body': body,
      'resolved': resolved,
      if (trainerResponse != null) 'trainerResponse': trainerResponse,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
      if (parentComment != null) 'parentComment': parentComment?.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SmeReviewCommentImpl extends SmeReviewComment {
  _SmeReviewCommentImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int authorId,
    _i3.PharmaUser? author,
    required String sectionRef,
    String? severity,
    required String body,
    bool? resolved,
    String? trainerResponse,
    DateTime? resolvedAt,
    DateTime? createdAt,
    int? parentCommentId,
    _i4.SmeReviewComment? parentComment,
    DateTime? readAt,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         authorId: authorId,
         author: author,
         sectionRef: sectionRef,
         severity: severity,
         body: body,
         resolved: resolved,
         trainerResponse: trainerResponse,
         resolvedAt: resolvedAt,
         createdAt: createdAt,
         parentCommentId: parentCommentId,
         parentComment: parentComment,
         readAt: readAt,
       );

  /// Returns a shallow copy of this [SmeReviewComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SmeReviewComment copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? authorId,
    Object? author = _Undefined,
    String? sectionRef,
    String? severity,
    String? body,
    bool? resolved,
    Object? trainerResponse = _Undefined,
    Object? resolvedAt = _Undefined,
    DateTime? createdAt,
    Object? parentCommentId = _Undefined,
    Object? parentComment = _Undefined,
    Object? readAt = _Undefined,
  }) {
    return SmeReviewComment(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      authorId: authorId ?? this.authorId,
      author: author is _i3.PharmaUser? ? author : this.author?.copyWith(),
      sectionRef: sectionRef ?? this.sectionRef,
      severity: severity ?? this.severity,
      body: body ?? this.body,
      resolved: resolved ?? this.resolved,
      trainerResponse: trainerResponse is String?
          ? trainerResponse
          : this.trainerResponse,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      createdAt: createdAt ?? this.createdAt,
      parentCommentId: parentCommentId is int?
          ? parentCommentId
          : this.parentCommentId,
      parentComment: parentComment is _i4.SmeReviewComment?
          ? parentComment
          : this.parentComment?.copyWith(),
      readAt: readAt is DateTime? ? readAt : this.readAt,
    );
  }
}
