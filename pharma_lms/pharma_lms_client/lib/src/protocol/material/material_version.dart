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
import '../material/material.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Versioned material for document control.
abstract class MaterialVersion implements _i1.SerializableModel {
  MaterialVersion._({
    this.id,
    required this.materialId,
    this.material,
    required this.version,
    required this.storageKey,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory MaterialVersion({
    int? id,
    required int materialId,
    _i2.Material? material,
    required int version,
    required String storageKey,
    DateTime? createdAt,
  }) = _MaterialVersionImpl;

  factory MaterialVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialVersion(
      id: jsonSerialization['id'] as int?,
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Material>(
              jsonSerialization['material'],
            ),
      version: jsonSerialization['version'] as int,
      storageKey: jsonSerialization['storageKey'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int materialId;

  /// The material.
  _i2.Material? material;

  /// Version number.
  int version;

  /// Storage key for this version.
  String storageKey;

  /// When created.
  DateTime createdAt;

  /// Returns a shallow copy of this [MaterialVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialVersion copyWith({
    int? id,
    int? materialId,
    _i2.Material? material,
    int? version,
    String? storageKey,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialVersion',
      if (id != null) 'id': id,
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      'version': version,
      'storageKey': storageKey,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialVersionImpl extends MaterialVersion {
  _MaterialVersionImpl({
    int? id,
    required int materialId,
    _i2.Material? material,
    required int version,
    required String storageKey,
    DateTime? createdAt,
  }) : super._(
         id: id,
         materialId: materialId,
         material: material,
         version: version,
         storageKey: storageKey,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MaterialVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialVersion copyWith({
    Object? id = _Undefined,
    int? materialId,
    Object? material = _Undefined,
    int? version,
    String? storageKey,
    DateTime? createdAt,
  }) {
    return MaterialVersion(
      id: id is int? ? id : this.id,
      materialId: materialId ?? this.materialId,
      material: material is _i2.Material?
          ? material
          : this.material?.copyWith(),
      version: version ?? this.version,
      storageKey: storageKey ?? this.storageKey,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
