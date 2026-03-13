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
    this.fileHash,
    String? virusScanStatus,
    this.virusScanAt,
    this.fileSizeBytes,
  }) : createdAt = createdAt ?? DateTime.now(),
       virusScanStatus = virusScanStatus ?? 'pending';

  factory MaterialVersion({
    int? id,
    required int materialId,
    _i2.Material? material,
    required int version,
    required String storageKey,
    DateTime? createdAt,
    String? fileHash,
    String? virusScanStatus,
    DateTime? virusScanAt,
    int? fileSizeBytes,
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
      fileHash: jsonSerialization['fileHash'] as String?,
      virusScanStatus: jsonSerialization['virusScanStatus'] as String?,
      virusScanAt: jsonSerialization['virusScanAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['virusScanAt'],
            ),
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int?,
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

  /// SHA-256 file hash for integrity verification (TRN-WF-02).
  String? fileHash;

  /// Virus scan status: pending, clean, quarantined (TRN-WF-02).
  String? virusScanStatus;

  /// When virus scan completed.
  DateTime? virusScanAt;

  /// File size in bytes.
  int? fileSizeBytes;

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
    String? fileHash,
    String? virusScanStatus,
    DateTime? virusScanAt,
    int? fileSizeBytes,
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
      if (fileHash != null) 'fileHash': fileHash,
      if (virusScanStatus != null) 'virusScanStatus': virusScanStatus,
      if (virusScanAt != null) 'virusScanAt': virusScanAt?.toJson(),
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
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
    String? fileHash,
    String? virusScanStatus,
    DateTime? virusScanAt,
    int? fileSizeBytes,
  }) : super._(
         id: id,
         materialId: materialId,
         material: material,
         version: version,
         storageKey: storageKey,
         createdAt: createdAt,
         fileHash: fileHash,
         virusScanStatus: virusScanStatus,
         virusScanAt: virusScanAt,
         fileSizeBytes: fileSizeBytes,
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
    Object? fileHash = _Undefined,
    Object? virusScanStatus = _Undefined,
    Object? virusScanAt = _Undefined,
    Object? fileSizeBytes = _Undefined,
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
      fileHash: fileHash is String? ? fileHash : this.fileHash,
      virusScanStatus: virusScanStatus is String?
          ? virusScanStatus
          : this.virusScanStatus,
      virusScanAt: virusScanAt is DateTime? ? virusScanAt : this.virusScanAt,
      fileSizeBytes: fileSizeBytes is int? ? fileSizeBytes : this.fileSizeBytes,
    );
  }
}
