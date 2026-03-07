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
  }) : orderIndex = orderIndex ?? 0;

  factory Lesson({
    int? id,
    required int moduleId,
    _i2.Module? module,
    required String title,
    int? orderIndex,
    required int materialId,
    _i3.Material? material,
    int? durationMinutes,
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
  }) : super._(
         id: id,
         moduleId: moduleId,
         module: module,
         title: title,
         orderIndex: orderIndex,
         materialId: materialId,
         material: material,
         durationMinutes: durationMinutes,
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
    );
  }
}
