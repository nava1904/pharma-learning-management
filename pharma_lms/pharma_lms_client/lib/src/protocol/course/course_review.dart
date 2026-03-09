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
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Course review record - QA approval workflow. FDA 21 CFR Part 11.
abstract class CourseReview implements _i1.SerializableModel {
  CourseReview._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.reviewerId,
    this.reviewer,
    String? reviewType,
    required this.decision,
    this.comments,
    this.reviewChecklistJson,
    DateTime? reviewedAt,
    this.esignatureId,
    this.esignature,
  }) : reviewType = reviewType ?? 'initial',
       reviewedAt = reviewedAt ?? DateTime.now();

  factory CourseReview({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int reviewerId,
    _i3.PharmaUser? reviewer,
    String? reviewType,
    required String decision,
    String? comments,
    String? reviewChecklistJson,
    DateTime? reviewedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) = _CourseReviewImpl;

  factory CourseReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseReview(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      reviewerId: jsonSerialization['reviewerId'] as int,
      reviewer: jsonSerialization['reviewer'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['reviewer'],
            ),
      reviewType: jsonSerialization['reviewType'] as String?,
      decision: jsonSerialization['decision'] as String,
      comments: jsonSerialization['comments'] as String?,
      reviewChecklistJson: jsonSerialization['reviewChecklistJson'] as String?,
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      esignatureId: jsonSerialization['esignatureId'] as int?,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseVersionId;

  /// The course version reviewed.
  _i2.CourseVersion? courseVersion;

  int reviewerId;

  /// QA reviewer.
  _i3.PharmaUser? reviewer;

  /// Review type: initial, re_review_after_changes.
  String reviewType;

  /// Decision: approved, rejected, returned_for_changes.
  String decision;

  /// Review comments.
  String? comments;

  /// Review checklist as JSON.
  String? reviewChecklistJson;

  /// When reviewed.
  DateTime reviewedAt;

  int? esignatureId;

  /// E-signature for approval.
  _i4.ElectronicSignature? esignature;

  /// Returns a shallow copy of this [CourseReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseReview copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? reviewerId,
    _i3.PharmaUser? reviewer,
    String? reviewType,
    String? decision,
    String? comments,
    String? reviewChecklistJson,
    DateTime? reviewedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseReview',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'reviewerId': reviewerId,
      if (reviewer != null) 'reviewer': reviewer?.toJson(),
      'reviewType': reviewType,
      'decision': decision,
      if (comments != null) 'comments': comments,
      if (reviewChecklistJson != null)
        'reviewChecklistJson': reviewChecklistJson,
      'reviewedAt': reviewedAt.toJson(),
      if (esignatureId != null) 'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseReviewImpl extends CourseReview {
  _CourseReviewImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int reviewerId,
    _i3.PharmaUser? reviewer,
    String? reviewType,
    required String decision,
    String? comments,
    String? reviewChecklistJson,
    DateTime? reviewedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         reviewerId: reviewerId,
         reviewer: reviewer,
         reviewType: reviewType,
         decision: decision,
         comments: comments,
         reviewChecklistJson: reviewChecklistJson,
         reviewedAt: reviewedAt,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [CourseReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseReview copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? reviewerId,
    Object? reviewer = _Undefined,
    String? reviewType,
    String? decision,
    Object? comments = _Undefined,
    Object? reviewChecklistJson = _Undefined,
    DateTime? reviewedAt,
    Object? esignatureId = _Undefined,
    Object? esignature = _Undefined,
  }) {
    return CourseReview(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      reviewerId: reviewerId ?? this.reviewerId,
      reviewer: reviewer is _i3.PharmaUser?
          ? reviewer
          : this.reviewer?.copyWith(),
      reviewType: reviewType ?? this.reviewType,
      decision: decision ?? this.decision,
      comments: comments is String? ? comments : this.comments,
      reviewChecklistJson: reviewChecklistJson is String?
          ? reviewChecklistJson
          : this.reviewChecklistJson,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      esignatureId: esignatureId is int? ? esignatureId : this.esignatureId,
      esignature: esignature is _i4.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}
