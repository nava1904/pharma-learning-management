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

/// Media asset (video, image) linked to material.
abstract class MediaAsset implements _i1.SerializableModel {
  MediaAsset._({
    this.id,
    required this.materialId,
    this.material,
    required this.assetType,
    required this.url,
    this.durationSeconds,
  });

  factory MediaAsset({
    int? id,
    required int materialId,
    _i2.Material? material,
    required String assetType,
    required String url,
    int? durationSeconds,
  }) = _MediaAssetImpl;

  factory MediaAsset.fromJson(Map<String, dynamic> jsonSerialization) {
    return MediaAsset(
      id: jsonSerialization['id'] as int?,
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Material>(
              jsonSerialization['material'],
            ),
      assetType: jsonSerialization['assetType'] as String,
      url: jsonSerialization['url'] as String,
      durationSeconds: jsonSerialization['durationSeconds'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int materialId;

  /// The material.
  _i2.Material? material;

  /// Type (video, image).
  String assetType;

  /// URL or storage path.
  String url;

  /// Duration in seconds for video.
  int? durationSeconds;

  /// Returns a shallow copy of this [MediaAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MediaAsset copyWith({
    int? id,
    int? materialId,
    _i2.Material? material,
    String? assetType,
    String? url,
    int? durationSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MediaAsset',
      if (id != null) 'id': id,
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      'assetType': assetType,
      'url': url,
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MediaAssetImpl extends MediaAsset {
  _MediaAssetImpl({
    int? id,
    required int materialId,
    _i2.Material? material,
    required String assetType,
    required String url,
    int? durationSeconds,
  }) : super._(
         id: id,
         materialId: materialId,
         material: material,
         assetType: assetType,
         url: url,
         durationSeconds: durationSeconds,
       );

  /// Returns a shallow copy of this [MediaAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MediaAsset copyWith({
    Object? id = _Undefined,
    int? materialId,
    Object? material = _Undefined,
    String? assetType,
    String? url,
    Object? durationSeconds = _Undefined,
  }) {
    return MediaAsset(
      id: id is int? ? id : this.id,
      materialId: materialId ?? this.materialId,
      material: material is _i2.Material?
          ? material
          : this.material?.copyWith(),
      assetType: assetType ?? this.assetType,
      url: url ?? this.url,
      durationSeconds: durationSeconds is int?
          ? durationSeconds
          : this.durationSeconds,
    );
  }
}
