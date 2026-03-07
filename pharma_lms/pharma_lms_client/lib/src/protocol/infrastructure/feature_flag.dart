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

/// Feature flag for gradual rollout.
abstract class FeatureFlag implements _i1.SerializableModel {
  FeatureFlag._({
    this.id,
    required this.key,
    bool? enabled,
    this.organizationId,
    this.organization,
  }) : enabled = enabled ?? false;

  factory FeatureFlag({
    int? id,
    required String key,
    bool? enabled,
    int? organizationId,
    _i2.Organization? organization,
  }) = _FeatureFlagImpl;

  factory FeatureFlag.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureFlag(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
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

  /// Flag key.
  String key;

  /// Whether enabled.
  bool enabled;

  int? organizationId;

  /// Organization (null for global).
  _i2.Organization? organization;

  /// Returns a shallow copy of this [FeatureFlag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureFlag copyWith({
    int? id,
    String? key,
    bool? enabled,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureFlag',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
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

class _FeatureFlagImpl extends FeatureFlag {
  _FeatureFlagImpl({
    int? id,
    required String key,
    bool? enabled,
    int? organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         key: key,
         enabled: enabled,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [FeatureFlag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureFlag copyWith({
    Object? id = _Undefined,
    String? key,
    bool? enabled,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
  }) {
    return FeatureFlag(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      enabled: enabled ?? this.enabled,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}
