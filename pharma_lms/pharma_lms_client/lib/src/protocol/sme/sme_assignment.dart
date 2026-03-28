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
import '../course/course.dart' as _i2;
import '../course/course_version.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// SME invited to review a course (subject-matter expert collaboration).
abstract class SmeAssignment implements _i1.SerializableModel {
  SmeAssignment._({
    this.id,
    required this.courseId,
    this.course,
    this.courseVersionId,
    this.courseVersion,
    required this.smeUserId,
    this.smeUser,
    required this.invitedById,
    this.invitedBy,
    String? status,
    DateTime? invitedAt,
  }) : status = status ?? 'invited',
       invitedAt = invitedAt ?? DateTime.now();

  factory SmeAssignment({
    int? id,
    required int courseId,
    _i2.Course? course,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int smeUserId,
    _i4.PharmaUser? smeUser,
    required int invitedById,
    _i4.PharmaUser? invitedBy,
    String? status,
    DateTime? invitedAt,
  }) = _SmeAssignmentImpl;

  factory SmeAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SmeAssignment(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      courseVersionId: jsonSerialization['courseVersionId'] as int?,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      smeUserId: jsonSerialization['smeUserId'] as int,
      smeUser: jsonSerialization['smeUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['smeUser'],
            ),
      invitedById: jsonSerialization['invitedById'] as int,
      invitedBy: jsonSerialization['invitedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['invitedBy'],
            ),
      status: jsonSerialization['status'] as String?,
      invitedAt: jsonSerialization['invitedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['invitedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  /// Course under review.
  _i2.Course? course;

  int? courseVersionId;

  /// Optional: scoped to a specific version.
  _i3.CourseVersion? courseVersion;

  int smeUserId;

  /// SME (reviewer) user.
  _i4.PharmaUser? smeUser;

  int invitedById;

  /// Trainer who sent the invite.
  _i4.PharmaUser? invitedBy;

  /// invited, active, completed
  String status;

  /// When invited.
  DateTime invitedAt;

  /// Returns a shallow copy of this [SmeAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SmeAssignment copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? smeUserId,
    _i4.PharmaUser? smeUser,
    int? invitedById,
    _i4.PharmaUser? invitedBy,
    String? status,
    DateTime? invitedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SmeAssignment',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      if (courseVersionId != null) 'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'smeUserId': smeUserId,
      if (smeUser != null) 'smeUser': smeUser?.toJson(),
      'invitedById': invitedById,
      if (invitedBy != null) 'invitedBy': invitedBy?.toJson(),
      'status': status,
      'invitedAt': invitedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SmeAssignmentImpl extends SmeAssignment {
  _SmeAssignmentImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int smeUserId,
    _i4.PharmaUser? smeUser,
    required int invitedById,
    _i4.PharmaUser? invitedBy,
    String? status,
    DateTime? invitedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         smeUserId: smeUserId,
         smeUser: smeUser,
         invitedById: invitedById,
         invitedBy: invitedBy,
         status: status,
         invitedAt: invitedAt,
       );

  /// Returns a shallow copy of this [SmeAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SmeAssignment copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    Object? courseVersionId = _Undefined,
    Object? courseVersion = _Undefined,
    int? smeUserId,
    Object? smeUser = _Undefined,
    int? invitedById,
    Object? invitedBy = _Undefined,
    String? status,
    DateTime? invitedAt,
  }) {
    return SmeAssignment(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      courseVersionId: courseVersionId is int?
          ? courseVersionId
          : this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      smeUserId: smeUserId ?? this.smeUserId,
      smeUser: smeUser is _i4.PharmaUser? ? smeUser : this.smeUser?.copyWith(),
      invitedById: invitedById ?? this.invitedById,
      invitedBy: invitedBy is _i4.PharmaUser?
          ? invitedBy
          : this.invitedBy?.copyWith(),
      status: status ?? this.status,
      invitedAt: invitedAt ?? this.invitedAt,
    );
  }
}
