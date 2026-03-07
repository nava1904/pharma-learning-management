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
import '../organization/site.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Department within a site.
abstract class Department implements _i1.SerializableModel {
  Department._({
    this.id,
    required this.siteId,
    this.site,
    required this.name,
    required this.code,
  });

  factory Department({
    int? id,
    required int siteId,
    _i2.Site? site,
    required String name,
    required String code,
  }) = _DepartmentImpl;

  factory Department.fromJson(Map<String, dynamic> jsonSerialization) {
    return Department(
      id: jsonSerialization['id'] as int?,
      siteId: jsonSerialization['siteId'] as int,
      site: jsonSerialization['site'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Site>(jsonSerialization['site']),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int siteId;

  /// The site this department belongs to.
  _i2.Site? site;

  /// Department name.
  String name;

  /// Unique code for the department.
  String code;

  /// Returns a shallow copy of this [Department]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Department copyWith({
    int? id,
    int? siteId,
    _i2.Site? site,
    String? name,
    String? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Department',
      if (id != null) 'id': id,
      'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'name': name,
      'code': code,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DepartmentImpl extends Department {
  _DepartmentImpl({
    int? id,
    required int siteId,
    _i2.Site? site,
    required String name,
    required String code,
  }) : super._(
         id: id,
         siteId: siteId,
         site: site,
         name: name,
         code: code,
       );

  /// Returns a shallow copy of this [Department]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Department copyWith({
    Object? id = _Undefined,
    int? siteId,
    Object? site = _Undefined,
    String? name,
    String? code,
  }) {
    return Department(
      id: id is int? ? id : this.id,
      siteId: siteId ?? this.siteId,
      site: site is _i2.Site? ? site : this.site?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}
