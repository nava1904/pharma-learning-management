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
import '../organization/user.dart' as _i2;
import '../assessment/assessment.dart' as _i3;
import '../training/enrollment.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// User attempt at an assessment.
abstract class AssessmentAttempt implements _i1.SerializableModel {
  AssessmentAttempt._({
    this.id,
    required this.userId,
    this.user,
    required this.assessmentId,
    this.assessment,
    this.enrollmentId,
    this.enrollment,
    DateTime? startedAt,
    this.completedAt,
    this.score,
  }) : startedAt = startedAt ?? DateTime.now();

  factory AssessmentAttempt({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int assessmentId,
    _i3.Assessment? assessment,
    int? enrollmentId,
    _i4.Enrollment? enrollment,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
  }) = _AssessmentAttemptImpl;

  factory AssessmentAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssessmentAttempt(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      assessmentId: jsonSerialization['assessmentId'] as int,
      assessment: jsonSerialization['assessment'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Assessment>(
              jsonSerialization['assessment'],
            ),
      enrollmentId: jsonSerialization['enrollmentId'] as int?,
      enrollment: jsonSerialization['enrollment'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Enrollment>(
              jsonSerialization['enrollment'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      score: jsonSerialization['score'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int assessmentId;

  /// The assessment.
  _i3.Assessment? assessment;

  int? enrollmentId;

  /// Enrollment this attempt is for.
  _i4.Enrollment? enrollment;

  /// When started.
  DateTime startedAt;

  /// When completed (null if in progress).
  DateTime? completedAt;

  /// Score achieved.
  int? score;

  /// Returns a shallow copy of this [AssessmentAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssessmentAttempt copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? assessmentId,
    _i3.Assessment? assessment,
    int? enrollmentId,
    _i4.Enrollment? enrollment,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssessmentAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'assessmentId': assessmentId,
      if (assessment != null) 'assessment': assessment?.toJson(),
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJson(),
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (score != null) 'score': score,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssessmentAttemptImpl extends AssessmentAttempt {
  _AssessmentAttemptImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int assessmentId,
    _i3.Assessment? assessment,
    int? enrollmentId,
    _i4.Enrollment? enrollment,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         assessmentId: assessmentId,
         assessment: assessment,
         enrollmentId: enrollmentId,
         enrollment: enrollment,
         startedAt: startedAt,
         completedAt: completedAt,
         score: score,
       );

  /// Returns a shallow copy of this [AssessmentAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssessmentAttempt copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? assessmentId,
    Object? assessment = _Undefined,
    Object? enrollmentId = _Undefined,
    Object? enrollment = _Undefined,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
    Object? score = _Undefined,
  }) {
    return AssessmentAttempt(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      assessmentId: assessmentId ?? this.assessmentId,
      assessment: assessment is _i3.Assessment?
          ? assessment
          : this.assessment?.copyWith(),
      enrollmentId: enrollmentId is int? ? enrollmentId : this.enrollmentId,
      enrollment: enrollment is _i4.Enrollment?
          ? enrollment
          : this.enrollment?.copyWith(),
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      score: score is int? ? score : this.score,
    );
  }
}
