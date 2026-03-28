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

/// Learning material (PDF, video, SCORM).
abstract class Material implements _i1.SerializableModel {
  Material._({
    this.id,
    required this.title,
    required this.materialType,
    this.storageKey,
    this.contentUrl,
    required this.organizationId,
    this.organization,
  });

  factory Material({
    int? id,
    required String title,
    required String materialType,
    String? storageKey,
    String? contentUrl,
    required int organizationId,
    _i2.Organization? organization,
  }) = _MaterialImpl;

  factory Material.fromJson(Map<String, dynamic> jsonSerialization) {
    return Material(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      materialType: jsonSerialization['materialType'] as String,
      storageKey: jsonSerialization['storageKey'] as String?,
      contentUrl: jsonSerialization['contentUrl'] as String?,
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

  /// Material title.
  String title;

  /// Type: pdf, video, scorm.
  String materialType;

  /// S3/MinIO storage key.
  String? storageKey;

  /// URL for embedded content (Google Docs/Sheets/Slides, external video links).
  String? contentUrl;

  int organizationId;

  /// Organization for multi-tenant.
  _i2.Organization? organization;

  /// Returns a shallow copy of this [Material]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Material copyWith({
    int? id,
    String? title,
    String? materialType,
    String? storageKey,
    String? contentUrl,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Material',
      if (id != null) 'id': id,
      'title': title,
      'materialType': materialType,
      if (storageKey != null) 'storageKey': storageKey,
      if (contentUrl != null) 'contentUrl': contentUrl,
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

class _MaterialImpl extends Material {
  _MaterialImpl({
    int? id,
    required String title,
    required String materialType,
    String? storageKey,
    String? contentUrl,
    required int organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         title: title,
         materialType: materialType,
         storageKey: storageKey,
         contentUrl: contentUrl,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [Material]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Material copyWith({
    Object? id = _Undefined,
    String? title,
    String? materialType,
    Object? storageKey = _Undefined,
    Object? contentUrl = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
  }) {
    return Material(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      materialType: materialType ?? this.materialType,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      contentUrl: contentUrl is String? ? contentUrl : this.contentUrl,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}
