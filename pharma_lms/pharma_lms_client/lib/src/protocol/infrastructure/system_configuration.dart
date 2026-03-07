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

/// System configuration key-value.
abstract class SystemConfiguration implements _i1.SerializableModel {
  SystemConfiguration._({
    this.id,
    required this.key,
    required this.value,
    this.organizationId,
    this.organization,
  });

  factory SystemConfiguration({
    int? id,
    required String key,
    required String value,
    int? organizationId,
    _i2.Organization? organization,
  }) = _SystemConfigurationImpl;

  factory SystemConfiguration.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemConfiguration(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      organizationId: jsonSerialization['organizationId'] as int?,
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

  /// Configuration key.
  String key;

  /// Configuration value.
  String value;

  int? organizationId;

  /// Organization (null for global).
  _i2.Organization? organization;

  /// Returns a shallow copy of this [SystemConfiguration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemConfiguration copyWith({
    int? id,
    String? key,
    String? value,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemConfiguration',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemConfigurationImpl extends SystemConfiguration {
  _SystemConfigurationImpl({
    int? id,
    required String key,
    required String value,
    int? organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         key: key,
         value: value,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [SystemConfiguration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemConfiguration copyWith({
    Object? id = _Undefined,
    String? key,
    String? value,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
  }) {
    return SystemConfiguration(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}
