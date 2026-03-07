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
import '../training/enrollment.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../course/course_version.dart' as _i4;
import '../shared/electronic_signature.dart' as _i5;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i6;

/// Training record - completion with e-signature. FDA 21 CFR Part 11.
abstract class TrainingRecord implements _i1.SerializableModel {
  TrainingRecord._({
    this.id,
    required this.enrollmentId,
    this.enrollment,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    DateTime? completedAt,
    this.score,
    required this.esignatureId,
    this.esignature,
  }) : completedAt = completedAt ?? DateTime.now();

  factory TrainingRecord({
    int? id,
    required int enrollmentId,
    _i2.Enrollment? enrollment,
    required int userId,
    _i3.PharmaUser? user,
    required int courseVersionId,
    _i4.CourseVersion? courseVersion,
    DateTime? completedAt,
    int? score,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
  }) = _TrainingRecordImpl;

  factory TrainingRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingRecord(
      id: jsonSerialization['id'] as int?,
      enrollmentId: jsonSerialization['enrollmentId'] as int,
      enrollment: jsonSerialization['enrollment'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Enrollment>(
              jsonSerialization['enrollment'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      score: jsonSerialization['score'] as int?,
      esignatureId: jsonSerialization['esignatureId'] as int,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int enrollmentId;

  /// The enrollment this completes.
  _i2.Enrollment? enrollment;

  int userId;

  /// The user.
  _i3.PharmaUser? user;

  int courseVersionId;

  /// The course version completed.
  _i4.CourseVersion? courseVersion;

  /// When completed.
  DateTime completedAt;

  /// Assessment score.
  int? score;

  int esignatureId;

  /// Electronic signature for compliance.
  _i5.ElectronicSignature? esignature;

  /// Returns a shallow copy of this [TrainingRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingRecord copyWith({
    int? id,
    int? enrollmentId,
    _i2.Enrollment? enrollment,
    int? userId,
    _i3.PharmaUser? user,
    int? courseVersionId,
    _i4.CourseVersion? courseVersion,
    DateTime? completedAt,
    int? score,
    int? esignatureId,
    _i5.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingRecord',
      if (id != null) 'id': id,
      'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'completedAt': completedAt.toJson(),
      if (score != null) 'score': score,
      'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingRecordImpl extends TrainingRecord {
  _TrainingRecordImpl({
    int? id,
    required int enrollmentId,
    _i2.Enrollment? enrollment,
    required int userId,
    _i3.PharmaUser? user,
    required int courseVersionId,
    _i4.CourseVersion? courseVersion,
    DateTime? completedAt,
    int? score,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         enrollmentId: enrollmentId,
         enrollment: enrollment,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         completedAt: completedAt,
         score: score,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [TrainingRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingRecord copyWith({
    Object? id = _Undefined,
    int? enrollmentId,
    Object? enrollment = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    DateTime? completedAt,
    Object? score = _Undefined,
    int? esignatureId,
    Object? esignature = _Undefined,
  }) {
    return TrainingRecord(
      id: id is int? ? id : this.id,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      enrollment: enrollment is _i2.Enrollment?
          ? enrollment
          : this.enrollment?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i4.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      completedAt: completedAt ?? this.completedAt,
      score: score is int? ? score : this.score,
      esignatureId: esignatureId ?? this.esignatureId,
      esignature: esignature is _i5.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}
