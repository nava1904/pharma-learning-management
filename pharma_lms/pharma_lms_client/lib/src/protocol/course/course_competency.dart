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
import '../course/competency.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Links courses to competencies.
abstract class CourseCompetency implements _i1.SerializableModel {
  CourseCompetency._({
    this.id,
    required this.courseId,
    this.course,
    required this.competencyId,
    this.competency,
  });

  factory CourseCompetency({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int competencyId,
    _i3.Competency? competency,
  }) = _CourseCompetencyImpl;

  factory CourseCompetency.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseCompetency(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Competency>(
              jsonSerialization['competency'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  /// The course.
  _i2.Course? course;

  int competencyId;

  /// The competency.
  _i3.Competency? competency;

  /// Returns a shallow copy of this [CourseCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseCompetency copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    int? competencyId,
    _i3.Competency? competency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseCompetency',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseCompetencyImpl extends CourseCompetency {
  _CourseCompetencyImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int competencyId,
    _i3.Competency? competency,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         competencyId: competencyId,
         competency: competency,
       );

  /// Returns a shallow copy of this [CourseCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseCompetency copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
  }) {
    return CourseCompetency(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i3.Competency?
          ? competency
          : this.competency?.copyWith(),
    );
  }
}
