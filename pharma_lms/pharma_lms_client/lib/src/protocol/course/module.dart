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
import '../course/course_version.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Module within a course version.
abstract class Module implements _i1.SerializableModel {
  Module._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.title,
    int? orderIndex,
  }) : orderIndex = orderIndex ?? 0;

  factory Module({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required String title,
    int? orderIndex,
  }) = _ModuleImpl;

  factory Module.fromJson(Map<String, dynamic> jsonSerialization) {
    return Module(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      title: jsonSerialization['title'] as String,
      orderIndex: jsonSerialization['orderIndex'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseVersionId;

  /// The course version.
  _i2.CourseVersion? courseVersion;

  /// Module title.
  String title;

  /// Order index for display.
  int orderIndex;

  /// Returns a shallow copy of this [Module]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Module copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    String? title,
    int? orderIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Module',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'title': title,
      'orderIndex': orderIndex,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModuleImpl extends Module {
  _ModuleImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required String title,
    int? orderIndex,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         title: title,
         orderIndex: orderIndex,
       );

  /// Returns a shallow copy of this [Module]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Module copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    String? title,
    int? orderIndex,
  }) {
    return Module(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
