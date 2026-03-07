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
import '../organization/user.dart' as _i2;
import '../organization/organization.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Course entity - learning program container.
abstract class Course implements _i1.SerializableModel {
  Course._({
    this.id,
    required this.title,
    this.sopNumber,
    this.description,
    String? status,
    this.createdById,
    this.createdBy,
    required this.organizationId,
    this.organization,
  }) : status = status ?? 'draft';

  factory Course({
    int? id,
    required String title,
    String? sopNumber,
    String? description,
    String? status,
    int? createdById,
    _i2.PharmaUser? createdBy,
    required int organizationId,
    _i3.Organization? organization,
  }) = _CourseImpl;

  factory Course.fromJson(Map<String, dynamic> jsonSerialization) {
    return Course(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      sopNumber: jsonSerialization['sopNumber'] as String?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as String?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Course title.
  String title;

  /// SOP number if linked to SOP (e.g., SOP-105).
  String? sopNumber;

  /// Description.
  String? description;

  /// Status: draft, pending_qa, approved, archived.
  String status;

  int? createdById;

  /// User who created the course.
  _i2.PharmaUser? createdBy;

  int organizationId;

  /// Organization for multi-tenant.
  _i3.Organization? organization;

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Course copyWith({
    int? id,
    String? title,
    String? sopNumber,
    String? description,
    String? status,
    int? createdById,
    _i2.PharmaUser? createdBy,
    int? organizationId,
    _i3.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      if (sopNumber != null) 'sopNumber': sopNumber,
      if (description != null) 'description': description,
      'status': status,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseImpl extends Course {
  _CourseImpl({
    int? id,
    required String title,
    String? sopNumber,
    String? description,
    String? status,
    int? createdById,
    _i2.PharmaUser? createdBy,
    required int organizationId,
    _i3.Organization? organization,
  }) : super._(
         id: id,
         title: title,
         sopNumber: sopNumber,
         description: description,
         status: status,
         createdById: createdById,
         createdBy: createdBy,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Course copyWith({
    Object? id = _Undefined,
    String? title,
    Object? sopNumber = _Undefined,
    Object? description = _Undefined,
    String? status,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
  }) {
    return Course(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      sopNumber: sopNumber is String? ? sopNumber : this.sopNumber,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i2.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}
