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

/// Certificate template with HTML layout and merge fields.
abstract class CertificateTemplate implements _i1.SerializableModel {
  CertificateTemplate._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory CertificateTemplate({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) = _CertificateTemplateImpl;

  factory CertificateTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return CertificateTemplate(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      htmlTemplate: jsonSerialization['htmlTemplate'] as String,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  /// Organization this template belongs to.
  _i2.Organization? organization;

  /// Template name.
  String name;

  /// HTML template with merge fields like {{learnerName}}, {{courseName}}, etc.
  String htmlTemplate;

  /// Whether this is the default template for the organization.
  bool isDefault;

  /// Created timestamp.
  DateTime createdAt;

  /// Returns a shallow copy of this [CertificateTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CertificateTemplate copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CertificateTemplate',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'htmlTemplate': htmlTemplate,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CertificateTemplateImpl extends CertificateTemplate {
  _CertificateTemplateImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         htmlTemplate: htmlTemplate,
         isDefault: isDefault,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CertificateTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CertificateTemplate copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return CertificateTemplate(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      htmlTemplate: htmlTemplate ?? this.htmlTemplate,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
