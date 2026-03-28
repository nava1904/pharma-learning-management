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
import '../course/lesson.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Assignment within a lesson for student submissions.
abstract class Assignment implements _i1.SerializableModel {
  Assignment._({
    this.id,
    required this.lessonId,
    this.lesson,
    required this.title,
    this.instructions,
    this.allowedFileTypes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Assignment({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required String title,
    String? instructions,
    String? allowedFileTypes,
    DateTime? createdAt,
  }) = _AssignmentImpl;

  factory Assignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Assignment(
      id: jsonSerialization['id'] as int?,
      lessonId: jsonSerialization['lessonId'] as int,
      lesson: jsonSerialization['lesson'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Lesson>(jsonSerialization['lesson']),
      title: jsonSerialization['title'] as String,
      instructions: jsonSerialization['instructions'] as String?,
      allowedFileTypes: jsonSerialization['allowedFileTypes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int lessonId;

  /// The lesson this assignment belongs to.
  _i2.Lesson? lesson;

  /// Assignment title.
  String title;

  /// Instructions for the assignment.
  String? instructions;

  /// Allowed file types as JSON array (e.g. ["pdf","doc","png"]).
  String? allowedFileTypes;

  /// Created timestamp.
  DateTime createdAt;

  /// Returns a shallow copy of this [Assignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Assignment copyWith({
    int? id,
    int? lessonId,
    _i2.Lesson? lesson,
    String? title,
    String? instructions,
    String? allowedFileTypes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Assignment',
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJson(),
      'title': title,
      if (instructions != null) 'instructions': instructions,
      if (allowedFileTypes != null) 'allowedFileTypes': allowedFileTypes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssignmentImpl extends Assignment {
  _AssignmentImpl({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required String title,
    String? instructions,
    String? allowedFileTypes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         lessonId: lessonId,
         lesson: lesson,
         title: title,
         instructions: instructions,
         allowedFileTypes: allowedFileTypes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Assignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Assignment copyWith({
    Object? id = _Undefined,
    int? lessonId,
    Object? lesson = _Undefined,
    String? title,
    Object? instructions = _Undefined,
    Object? allowedFileTypes = _Undefined,
    DateTime? createdAt,
  }) {
    return Assignment(
      id: id is int? ? id : this.id,
      lessonId: lessonId ?? this.lessonId,
      lesson: lesson is _i2.Lesson? ? lesson : this.lesson?.copyWith(),
      title: title ?? this.title,
      instructions: instructions is String? ? instructions : this.instructions,
      allowedFileTypes: allowedFileTypes is String?
          ? allowedFileTypes
          : this.allowedFileTypes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
