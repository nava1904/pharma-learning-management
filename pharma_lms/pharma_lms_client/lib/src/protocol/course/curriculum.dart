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

/// Groups courses into a named curriculum (credit / requirements roadmap).
abstract class Curriculum implements _i1.SerializableModel {
  Curriculum._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.code,
    this.description,
  });

  factory Curriculum({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? description,
  }) = _CurriculumImpl;

  factory Curriculum.fromJson(Map<String, dynamic> jsonSerialization) {
    return Curriculum(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      description: jsonSerialization['description'] as String?,
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

  String? description;

  /// Returns a shallow copy of this [Curriculum]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Curriculum copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? code,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Curriculum',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'code': code,
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurriculumImpl extends Curriculum {
  _CurriculumImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? description,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         code: code,
         description: description,
       );

  /// Returns a shallow copy of this [Curriculum]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Curriculum copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? code,
    Object? description = _Undefined,
  }) {
    return Curriculum(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      description: description is String? ? description : this.description,
    );
  }
}
