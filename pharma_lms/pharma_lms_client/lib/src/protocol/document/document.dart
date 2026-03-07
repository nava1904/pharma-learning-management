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
import '../organization/organization.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Controlled document (SOP, policy).
abstract class Document implements _i1.SerializableModel {
  Document._({
    this.id,
    required this.title,
    required this.documentNumber,
    required this.documentType,
    required this.organizationId,
    this.organization,
  });

  factory Document({
    int? id,
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
    _i2.Organization? organization,
  }) = _DocumentImpl;

  factory Document.fromJson(Map<String, dynamic> jsonSerialization) {
    return Document(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      documentNumber: jsonSerialization['documentNumber'] as String,
      documentType: jsonSerialization['documentType'] as String,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Document title.
  String title;

  /// Document number (e.g., SOP-105).
  String documentNumber;

  /// Type: sop, policy, guideline.
  String documentType;

  int organizationId;

  /// Organization for multi-tenant.
  _i2.Organization? organization;

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Document copyWith({
    int? id,
    String? title,
    String? documentNumber,
    String? documentType,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'title': title,
      'documentNumber': documentNumber,
      'documentType': documentType,
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

class _DocumentImpl extends Document {
  _DocumentImpl({
    int? id,
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         title: title,
         documentNumber: documentNumber,
         documentType: documentType,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Document copyWith({
    Object? id = _Undefined,
    String? title,
    String? documentNumber,
    String? documentType,
    int? organizationId,
    Object? organization = _Undefined,
  }) {
    return Document(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      documentNumber: documentNumber ?? this.documentNumber,
      documentType: documentType ?? this.documentType,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}
