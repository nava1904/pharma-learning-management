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
import '../course/curriculum.dart' as _i2;
import '../course/course.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Membership of a course in a curriculum.
abstract class CurriculumCourse implements _i1.SerializableModel {
  CurriculumCourse._({
    this.id,
    required this.curriculumId,
    this.curriculum,
    required this.courseId,
    this.course,
    int? sortOrder,
  }) : sortOrder = sortOrder ?? 0;

  factory CurriculumCourse({
    int? id,
    required int curriculumId,
    _i2.Curriculum? curriculum,
    required int courseId,
    _i3.Course? course,
    int? sortOrder,
  }) = _CurriculumCourseImpl;

  factory CurriculumCourse.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurriculumCourse(
      id: jsonSerialization['id'] as int?,
      curriculumId: jsonSerialization['curriculumId'] as int,
      curriculum: jsonSerialization['curriculum'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Curriculum>(
              jsonSerialization['curriculum'],
            ),
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Course>(jsonSerialization['course']),
      sortOrder: jsonSerialization['sortOrder'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int curriculumId;

  _i2.Curriculum? curriculum;

  int courseId;

  _i3.Course? course;

  int sortOrder;

  /// Returns a shallow copy of this [CurriculumCourse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurriculumCourse copyWith({
    int? id,
    int? curriculumId,
    _i2.Curriculum? curriculum,
    int? courseId,
    _i3.Course? course,
    int? sortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumCourse',
      if (id != null) 'id': id,
      'curriculumId': curriculumId,
      if (curriculum != null) 'curriculum': curriculum?.toJson(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'sortOrder': sortOrder,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurriculumCourseImpl extends CurriculumCourse {
  _CurriculumCourseImpl({
    int? id,
    required int curriculumId,
    _i2.Curriculum? curriculum,
    required int courseId,
    _i3.Course? course,
    int? sortOrder,
  }) : super._(
         id: id,
         curriculumId: curriculumId,
         curriculum: curriculum,
         courseId: courseId,
         course: course,
         sortOrder: sortOrder,
       );

  /// Returns a shallow copy of this [CurriculumCourse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurriculumCourse copyWith({
    Object? id = _Undefined,
    int? curriculumId,
    Object? curriculum = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? sortOrder,
  }) {
    return CurriculumCourse(
      id: id is int? ? id : this.id,
      curriculumId: curriculumId ?? this.curriculumId,
      curriculum: curriculum is _i2.Curriculum?
          ? curriculum
          : this.curriculum?.copyWith(),
      courseId: courseId ?? this.courseId,
      course: course is _i3.Course? ? course : this.course?.copyWith(),
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
