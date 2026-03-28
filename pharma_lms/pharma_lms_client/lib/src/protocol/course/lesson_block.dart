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

/// Ordered content block within a lesson (text, video, quiz, assignment, upload, etc.).
abstract class LessonBlock implements _i1.SerializableModel {
  LessonBlock._({
    this.id,
    required this.lessonId,
    this.lesson,
    int? orderIndex,
    required this.blockType,
    required this.contentJson,
    DateTime? createdAt,
  }) : orderIndex = orderIndex ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory LessonBlock({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    int? orderIndex,
    required String blockType,
    required String contentJson,
    DateTime? createdAt,
  }) = _LessonBlockImpl;

  factory LessonBlock.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonBlock(
      id: jsonSerialization['id'] as int?,
      lessonId: jsonSerialization['lessonId'] as int,
      lesson: jsonSerialization['lesson'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Lesson>(jsonSerialization['lesson']),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      blockType: jsonSerialization['blockType'] as String,
      contentJson: jsonSerialization['contentJson'] as String,
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

  /// The lesson this block belongs to.
  _i2.Lesson? lesson;

  /// Display order within the lesson.
  int orderIndex;

  /// Block type: text, heading, video, upload, quiz, assignment, google_doc, google_sheet, google_slide, code_sandbox, audio.
  String blockType;

  /// JSON payload (schema varies by block type).
  String contentJson;

  /// Created timestamp.
  DateTime createdAt;

  /// Returns a shallow copy of this [LessonBlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonBlock copyWith({
    int? id,
    int? lessonId,
    _i2.Lesson? lesson,
    int? orderIndex,
    String? blockType,
    String? contentJson,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LessonBlock',
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJson(),
      'orderIndex': orderIndex,
      'blockType': blockType,
      'contentJson': contentJson,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonBlockImpl extends LessonBlock {
  _LessonBlockImpl({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    int? orderIndex,
    required String blockType,
    required String contentJson,
    DateTime? createdAt,
  }) : super._(
         id: id,
         lessonId: lessonId,
         lesson: lesson,
         orderIndex: orderIndex,
         blockType: blockType,
         contentJson: contentJson,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LessonBlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonBlock copyWith({
    Object? id = _Undefined,
    int? lessonId,
    Object? lesson = _Undefined,
    int? orderIndex,
    String? blockType,
    String? contentJson,
    DateTime? createdAt,
  }) {
    return LessonBlock(
      id: id is int? ? id : this.id,
      lessonId: lessonId ?? this.lessonId,
      lesson: lesson is _i2.Lesson? ? lesson : this.lesson?.copyWith(),
      orderIndex: orderIndex ?? this.orderIndex,
      blockType: blockType ?? this.blockType,
      contentJson: contentJson ?? this.contentJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
