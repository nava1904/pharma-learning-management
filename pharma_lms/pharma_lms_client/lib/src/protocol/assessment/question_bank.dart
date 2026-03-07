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

/// Question bank for assessments.
abstract class QuestionBank implements _i1.SerializableModel {
  QuestionBank._({
    this.id,
    required this.name,
    required this.organizationId,
    this.organization,
    this.tagsJson,
  });

  factory QuestionBank({
    int? id,
    required String name,
    required int organizationId,
    _i2.Organization? organization,
    String? tagsJson,
  }) = _QuestionBankImpl;

  factory QuestionBank.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionBank(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      tagsJson: jsonSerialization['tagsJson'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Bank name.
  String name;

  int organizationId;

  /// Organization for multi-tenant.
  _i2.Organization? organization;

  /// Tags as JSON (e.g., GMP, Sterility).
  String? tagsJson;

  /// Returns a shallow copy of this [QuestionBank]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuestionBank copyWith({
    int? id,
    String? name,
    int? organizationId,
    _i2.Organization? organization,
    String? tagsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionBank',
      if (id != null) 'id': id,
      'name': name,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (tagsJson != null) 'tagsJson': tagsJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionBankImpl extends QuestionBank {
  _QuestionBankImpl({
    int? id,
    required String name,
    required int organizationId,
    _i2.Organization? organization,
    String? tagsJson,
  }) : super._(
         id: id,
         name: name,
         organizationId: organizationId,
         organization: organization,
         tagsJson: tagsJson,
       );

  /// Returns a shallow copy of this [QuestionBank]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuestionBank copyWith({
    Object? id = _Undefined,
    String? name,
    int? organizationId,
    Object? organization = _Undefined,
    Object? tagsJson = _Undefined,
  }) {
    return QuestionBank(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      tagsJson: tagsJson is String? ? tagsJson : this.tagsJson,
    );
  }
}
