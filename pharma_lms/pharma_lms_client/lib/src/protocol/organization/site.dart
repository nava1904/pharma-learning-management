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

/// Physical site within an organization.
abstract class Site implements _i1.SerializableModel {
  Site._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.code,
    String? timezone,
  }) : timezone = timezone ?? 'UTC';

  factory Site({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? timezone,
  }) = _SiteImpl;

  factory Site.fromJson(Map<String, dynamic> jsonSerialization) {
    return Site(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      timezone: jsonSerialization['timezone'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  /// The organization this site belongs to.
  _i2.Organization? organization;

  /// Site name.
  String name;

  /// Unique code for the site.
  String code;

  /// Timezone for the site (e.g., America/New_York).
  String timezone;

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Site copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? code,
    String? timezone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'code': code,
      'timezone': timezone,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteImpl extends Site {
  _SiteImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? timezone,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         code: code,
         timezone: timezone,
       );

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Site copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? code,
    String? timezone,
  }) {
    return Site(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      timezone: timezone ?? this.timezone,
    );
  }
}
