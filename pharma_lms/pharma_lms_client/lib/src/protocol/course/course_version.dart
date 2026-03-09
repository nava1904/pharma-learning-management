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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Versioned course - immutable history for compliance.
abstract class CourseVersion implements _i1.SerializableModel {
  CourseVersion._({
    this.id,
    required this.courseId,
    this.course,
    required this.version,
    this.effectiveDate,
    this.obsoleteDate,
    String? status,
    this.supersededByVersionId,
    this.changeSummary,
  }) : status = status ?? 'draft';

  factory CourseVersion({
    int? id,
    required int courseId,
    _i2.Course? course,
    required String version,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    String? status,
    int? supersededByVersionId,
    String? changeSummary,
  }) = _CourseVersionImpl;

  factory CourseVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseVersion(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      version: jsonSerialization['version'] as String,
      effectiveDate: jsonSerialization['effectiveDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectiveDate'],
            ),
      obsoleteDate: jsonSerialization['obsoleteDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['obsoleteDate'],
            ),
      status: jsonSerialization['status'] as String?,
      supersededByVersionId: jsonSerialization['supersededByVersionId'] as int?,
      changeSummary: jsonSerialization['changeSummary'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  /// The course.
  _i2.Course? course;

  /// Version string (e.g., 1.0, 2.0).
  String version;

  /// When this version becomes effective.
  DateTime? effectiveDate;

  /// When this version is obsolete.
  DateTime? obsoleteDate;

  /// Status: draft, approved, effective, obsolete.
  String status;

  /// Version that supersedes this one (when obsolete).
  int? supersededByVersionId;

  /// Change summary when creating new version from existing (TRN-05).
  String? changeSummary;

  /// Returns a shallow copy of this [CourseVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseVersion copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    String? version,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    String? status,
    int? supersededByVersionId,
    String? changeSummary,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseVersion',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'version': version,
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
      if (obsoleteDate != null) 'obsoleteDate': obsoleteDate?.toJson(),
      'status': status,
      if (supersededByVersionId != null)
        'supersededByVersionId': supersededByVersionId,
      if (changeSummary != null) 'changeSummary': changeSummary,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseVersionImpl extends CourseVersion {
  _CourseVersionImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    required String version,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    String? status,
    int? supersededByVersionId,
    String? changeSummary,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         version: version,
         effectiveDate: effectiveDate,
         obsoleteDate: obsoleteDate,
         status: status,
         supersededByVersionId: supersededByVersionId,
         changeSummary: changeSummary,
       );

  /// Returns a shallow copy of this [CourseVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseVersion copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    String? version,
    Object? effectiveDate = _Undefined,
    Object? obsoleteDate = _Undefined,
    String? status,
    Object? supersededByVersionId = _Undefined,
    Object? changeSummary = _Undefined,
  }) {
    return CourseVersion(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      version: version ?? this.version,
      effectiveDate: effectiveDate is DateTime?
          ? effectiveDate
          : this.effectiveDate,
      obsoleteDate: obsoleteDate is DateTime?
          ? obsoleteDate
          : this.obsoleteDate,
      status: status ?? this.status,
      supersededByVersionId: supersededByVersionId is int?
          ? supersededByVersionId
          : this.supersededByVersionId,
      changeSummary: changeSummary is String?
          ? changeSummary
          : this.changeSummary,
    );
  }
}
