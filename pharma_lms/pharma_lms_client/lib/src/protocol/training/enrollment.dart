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
import '../course/course_version.dart' as _i3;
import '../training/training_assignment.dart' as _i4;
import '../shared/electronic_signature.dart' as _i5;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i6;

/// Enrollment - user's progress in a course version.
abstract class Enrollment implements _i1.SerializableModel {
  Enrollment._({
    this.id,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    this.assignmentId,
    this.assignment,
    String? status,
    this.startedAt,
    this.completedAt,
    this.retrainingChangeSummary,
    this.acknowledgedAt,
    this.acknowledgementEsignatureId,
    this.acknowledgementEsignature,
  }) : status = status ?? 'not_started';

  factory Enrollment({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignmentId,
    _i4.TrainingAssignment? assignment,
    String? status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? retrainingChangeSummary,
    DateTime? acknowledgedAt,
    int? acknowledgementEsignatureId,
    _i5.ElectronicSignature? acknowledgementEsignature,
  }) = _EnrollmentImpl;

  factory Enrollment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Enrollment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      assignmentId: jsonSerialization['assignmentId'] as int?,
      assignment: jsonSerialization['assignment'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.TrainingAssignment>(
              jsonSerialization['assignment'],
            ),
      status: jsonSerialization['status'] as String?,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      retrainingChangeSummary:
          jsonSerialization['retrainingChangeSummary'] as String?,
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      acknowledgementEsignatureId:
          jsonSerialization['acknowledgementEsignatureId'] as int?,
      acknowledgementEsignature:
          jsonSerialization['acknowledgementEsignature'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ElectronicSignature>(
              jsonSerialization['acknowledgementEsignature'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int courseVersionId;

  /// The course version.
  _i3.CourseVersion? courseVersion;

  int? assignmentId;

  /// The assignment that created this enrollment.
  _i4.TrainingAssignment? assignment;

  /// Status: not_started, in_progress, completed, overdue.
  String status;

  /// When started.
  DateTime? startedAt;

  /// When completed.
  DateTime? completedAt;

  /// For retraining: change summary from document/course version (EMP-10).
  String? retrainingChangeSummary;

  /// When user acknowledged retraining change summary.
  DateTime? acknowledgedAt;

  int? acknowledgementEsignatureId;

  /// E-signature for retraining acknowledgement.
  _i5.ElectronicSignature? acknowledgementEsignature;

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Enrollment copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignmentId,
    _i4.TrainingAssignment? assignment,
    String? status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? retrainingChangeSummary,
    DateTime? acknowledgedAt,
    int? acknowledgementEsignatureId,
    _i5.ElectronicSignature? acknowledgementEsignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Enrollment',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      if (assignmentId != null) 'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJson(),
      'status': status,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (retrainingChangeSummary != null)
        'retrainingChangeSummary': retrainingChangeSummary,
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (acknowledgementEsignatureId != null)
        'acknowledgementEsignatureId': acknowledgementEsignatureId,
      if (acknowledgementEsignature != null)
        'acknowledgementEsignature': acknowledgementEsignature?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EnrollmentImpl extends Enrollment {
  _EnrollmentImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignmentId,
    _i4.TrainingAssignment? assignment,
    String? status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? retrainingChangeSummary,
    DateTime? acknowledgedAt,
    int? acknowledgementEsignatureId,
    _i5.ElectronicSignature? acknowledgementEsignature,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         assignmentId: assignmentId,
         assignment: assignment,
         status: status,
         startedAt: startedAt,
         completedAt: completedAt,
         retrainingChangeSummary: retrainingChangeSummary,
         acknowledgedAt: acknowledgedAt,
         acknowledgementEsignatureId: acknowledgementEsignatureId,
         acknowledgementEsignature: acknowledgementEsignature,
       );

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Enrollment copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    Object? assignmentId = _Undefined,
    Object? assignment = _Undefined,
    String? status,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? retrainingChangeSummary = _Undefined,
    Object? acknowledgedAt = _Undefined,
    Object? acknowledgementEsignatureId = _Undefined,
    Object? acknowledgementEsignature = _Undefined,
  }) {
    return Enrollment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      assignmentId: assignmentId is int? ? assignmentId : this.assignmentId,
      assignment: assignment is _i4.TrainingAssignment?
          ? assignment
          : this.assignment?.copyWith(),
      status: status ?? this.status,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      retrainingChangeSummary: retrainingChangeSummary is String?
          ? retrainingChangeSummary
          : this.retrainingChangeSummary,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      acknowledgementEsignatureId: acknowledgementEsignatureId is int?
          ? acknowledgementEsignatureId
          : this.acknowledgementEsignatureId,
      acknowledgementEsignature:
          acknowledgementEsignature is _i5.ElectronicSignature?
          ? acknowledgementEsignature
          : this.acknowledgementEsignature?.copyWith(),
    );
  }
}
