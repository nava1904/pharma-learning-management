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
import '../document/document.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Explicit many-to-many SOP-Course linkage. Replaces implicit sopNumber matching.
abstract class CourseSopLink implements _i1.SerializableModel {
  CourseSopLink._({
    this.id,
    required this.courseId,
    this.course,
    required this.documentId,
    this.document,
    required this.linkedById,
    this.linkedBy,
    DateTime? linkedAt,
    this.unlinkedAt,
  }) : linkedAt = linkedAt ?? DateTime.now();

  factory CourseSopLink({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int documentId,
    _i3.Document? document,
    required int linkedById,
    _i4.PharmaUser? linkedBy,
    DateTime? linkedAt,
    DateTime? unlinkedAt,
  }) = _CourseSopLinkImpl;

  factory CourseSopLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSopLink(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      documentId: jsonSerialization['documentId'] as int,
      document: jsonSerialization['document'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Document>(
              jsonSerialization['document'],
            ),
      linkedById: jsonSerialization['linkedById'] as int,
      linkedBy: jsonSerialization['linkedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['linkedBy'],
            ),
      linkedAt: jsonSerialization['linkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['linkedAt']),
      unlinkedAt: jsonSerialization['unlinkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['unlinkedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  /// The course linked to the SOP.
  _i2.Course? course;

  int documentId;

  /// The SOP document linked.
  _i3.Document? document;

  int linkedById;

  /// Who created the link.
  _i4.PharmaUser? linkedBy;

  /// When the link was created.
  DateTime linkedAt;

  /// When the link was removed (soft-delete).
  DateTime? unlinkedAt;

  /// Returns a shallow copy of this [CourseSopLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseSopLink copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    int? documentId,
    _i3.Document? document,
    int? linkedById,
    _i4.PharmaUser? linkedBy,
    DateTime? linkedAt,
    DateTime? unlinkedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSopLink',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'documentId': documentId,
      if (document != null) 'document': document?.toJson(),
      'linkedById': linkedById,
      if (linkedBy != null) 'linkedBy': linkedBy?.toJson(),
      'linkedAt': linkedAt.toJson(),
      if (unlinkedAt != null) 'unlinkedAt': unlinkedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseSopLinkImpl extends CourseSopLink {
  _CourseSopLinkImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int documentId,
    _i3.Document? document,
    required int linkedById,
    _i4.PharmaUser? linkedBy,
    DateTime? linkedAt,
    DateTime? unlinkedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         documentId: documentId,
         document: document,
         linkedById: linkedById,
         linkedBy: linkedBy,
         linkedAt: linkedAt,
         unlinkedAt: unlinkedAt,
       );

  /// Returns a shallow copy of this [CourseSopLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseSopLink copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? documentId,
    Object? document = _Undefined,
    int? linkedById,
    Object? linkedBy = _Undefined,
    DateTime? linkedAt,
    Object? unlinkedAt = _Undefined,
  }) {
    return CourseSopLink(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      documentId: documentId ?? this.documentId,
      document: document is _i3.Document?
          ? document
          : this.document?.copyWith(),
      linkedById: linkedById ?? this.linkedById,
      linkedBy: linkedBy is _i4.PharmaUser?
          ? linkedBy
          : this.linkedBy?.copyWith(),
      linkedAt: linkedAt ?? this.linkedAt,
      unlinkedAt: unlinkedAt is DateTime? ? unlinkedAt : this.unlinkedAt,
    );
  }
}
