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

/// Validated space / cleanroom / training room for ILT capacity control.
abstract class Facility implements _i1.SerializableModel {
  Facility._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.code,
    int? maxCapacity,
    bool? isValidatedSpace,
  }) : maxCapacity = maxCapacity ?? 10,
       isValidatedSpace = isValidatedSpace ?? false;

  factory Facility({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    int? maxCapacity,
    bool? isValidatedSpace,
  }) = _FacilityImpl;

  factory Facility.fromJson(Map<String, dynamic> jsonSerialization) {
    return Facility(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      maxCapacity: jsonSerialization['maxCapacity'] as int?,
      isValidatedSpace: jsonSerialization['isValidatedSpace'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['isValidatedSpace'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  _i2.Organization? organization;

  String name;

  String code;

  int maxCapacity;

  bool? isValidatedSpace;

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Facility copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? code,
    int? maxCapacity,
    bool? isValidatedSpace,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'code': code,
      'maxCapacity': maxCapacity,
      if (isValidatedSpace != null) 'isValidatedSpace': isValidatedSpace,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityImpl extends Facility {
  _FacilityImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    int? maxCapacity,
    bool? isValidatedSpace,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         code: code,
         maxCapacity: maxCapacity,
         isValidatedSpace: isValidatedSpace,
       );

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Facility copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? code,
    int? maxCapacity,
    Object? isValidatedSpace = _Undefined,
  }) {
    return Facility(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      isValidatedSpace: isValidatedSpace is bool?
          ? isValidatedSpace
          : this.isValidatedSpace,
    );
  }
}
