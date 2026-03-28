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
import '../course/module.dart' as _i2;
import '../material/material.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Lesson within a module.
abstract class Lesson implements _i1.SerializableModel {
  Lesson._({
    this.id,
    required this.moduleId,
    this.module,
    required this.title,
    int? orderIndex,
    required this.materialId,
    this.material,
    this.durationMinutes,
    this.lessonType,
    this.minEngagementMinutes,
    this.prerequisiteMode,
    this.instructorNotes,
    bool? includeInPreview,
  }) : orderIndex = orderIndex ?? 0,
       includeInPreview = includeInPreview ?? false;

  factory Lesson({
    int? id,
    required int moduleId,
    _i2.Module? module,
    required String title,
    int? orderIndex,
    required int materialId,
    _i3.Material? material,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
    String? instructorNotes,
    bool? includeInPreview,
  }) = _LessonImpl;

  factory Lesson.fromJson(Map<String, dynamic> jsonSerialization) {
    return Lesson(
      id: jsonSerialization['id'] as int?,
      moduleId: jsonSerialization['moduleId'] as int,
      module: jsonSerialization['module'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Module>(jsonSerialization['module']),
      title: jsonSerialization['title'] as String,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Material>(
              jsonSerialization['material'],
            ),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      lessonType: jsonSerialization['lessonType'] as String?,
      minEngagementMinutes: jsonSerialization['minEngagementMinutes'] as int?,
      prerequisiteMode: jsonSerialization['prerequisiteMode'] as String?,
      instructorNotes: jsonSerialization['instructorNotes'] as String?,
      includeInPreview: jsonSerialization['includeInPreview'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['includeInPreview'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int moduleId;

  /// The module.
  _i2.Module? module;

  /// Lesson title.
  String title;

  /// Order index for display.
  int orderIndex;

  int materialId;

  /// Linked material for content.
  _i3.Material? material;

  /// Duration in minutes.
  int? durationMinutes;

  /// Lesson type: PDF, Video, SCORM, xAPI, HTML, Checklist, google_doc, google_sheet, google_slide.
  String? lessonType;

  /// Minimum engagement time in minutes (server-enforced read time).
  int? minEngagementMinutes;

  /// Prerequisite mode: none, previous (complete previous lesson first).
  String? prerequisiteMode;

  /// Instructor notes (not shown to learners).
  String? instructorNotes;

  /// Whether this lesson is included in the course preview.
  bool includeInPreview;

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Lesson copyWith({
    int? id,
    int? moduleId,
    _i2.Module? module,
    String? title,
    int? orderIndex,
    int? materialId,
    _i3.Material? material,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
    String? instructorNotes,
    bool? includeInPreview,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Lesson',
      if (id != null) 'id': id,
      'moduleId': moduleId,
      if (module != null) 'module': module?.toJson(),
      'title': title,
      'orderIndex': orderIndex,
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (lessonType != null) 'lessonType': lessonType,
      if (minEngagementMinutes != null)
        'minEngagementMinutes': minEngagementMinutes,
      if (prerequisiteMode != null) 'prerequisiteMode': prerequisiteMode,
      if (instructorNotes != null) 'instructorNotes': instructorNotes,
      'includeInPreview': includeInPreview,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonImpl extends Lesson {
  _LessonImpl({
    int? id,
    required int moduleId,
    _i2.Module? module,
    required String title,
    int? orderIndex,
    required int materialId,
    _i3.Material? material,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
    String? instructorNotes,
    bool? includeInPreview,
  }) : super._(
         id: id,
         moduleId: moduleId,
         module: module,
         title: title,
         orderIndex: orderIndex,
         materialId: materialId,
         material: material,
         durationMinutes: durationMinutes,
         lessonType: lessonType,
         minEngagementMinutes: minEngagementMinutes,
         prerequisiteMode: prerequisiteMode,
         instructorNotes: instructorNotes,
         includeInPreview: includeInPreview,
       );

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Lesson copyWith({
    Object? id = _Undefined,
    int? moduleId,
    Object? module = _Undefined,
    String? title,
    int? orderIndex,
    int? materialId,
    Object? material = _Undefined,
    Object? durationMinutes = _Undefined,
    Object? lessonType = _Undefined,
    Object? minEngagementMinutes = _Undefined,
    Object? prerequisiteMode = _Undefined,
    Object? instructorNotes = _Undefined,
    bool? includeInPreview,
  }) {
    return Lesson(
      id: id is int? ? id : this.id,
      moduleId: moduleId ?? this.moduleId,
      module: module is _i2.Module? ? module : this.module?.copyWith(),
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      materialId: materialId ?? this.materialId,
      material: material is _i3.Material?
          ? material
          : this.material?.copyWith(),
      durationMinutes: durationMinutes is int?
          ? durationMinutes
          : this.durationMinutes,
      lessonType: lessonType is String? ? lessonType : this.lessonType,
      minEngagementMinutes: minEngagementMinutes is int?
          ? minEngagementMinutes
          : this.minEngagementMinutes,
      prerequisiteMode: prerequisiteMode is String?
          ? prerequisiteMode
          : this.prerequisiteMode,
      instructorNotes: instructorNotes is String?
          ? instructorNotes
          : this.instructorNotes,
      includeInPreview: includeInPreview ?? this.includeInPreview,
    );
  }
}
