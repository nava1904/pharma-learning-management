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
import '../organization/user.dart' as _i2;
import '../material/material.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// User progress on material (video watch, scroll depth).
abstract class MaterialProgress implements _i1.SerializableModel {
  MaterialProgress._({
    this.id,
    required this.userId,
    this.user,
    required this.materialId,
    this.material,
    int? progressPct,
    this.completedAt,
    this.interactionJson,
  }) : progressPct = progressPct ?? 0;

  factory MaterialProgress({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int materialId,
    _i3.Material? material,
    int? progressPct,
    DateTime? completedAt,
    String? interactionJson,
  }) = _MaterialProgressImpl;

  factory MaterialProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialProgress(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Material>(
              jsonSerialization['material'],
            ),
      progressPct: jsonSerialization['progressPct'] as int?,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      interactionJson: jsonSerialization['interactionJson'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int materialId;

  /// The material.
  _i3.Material? material;

  /// Progress percentage 0-100.
  int progressPct;

  /// When completed (null if in progress).
  DateTime? completedAt;

  /// Interaction data as JSON (watch/pause, scroll depth).
  String? interactionJson;

  /// Returns a shallow copy of this [MaterialProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialProgress copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? materialId,
    _i3.Material? material,
    int? progressPct,
    DateTime? completedAt,
    String? interactionJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialProgress',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      'progressPct': progressPct,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (interactionJson != null) 'interactionJson': interactionJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialProgressImpl extends MaterialProgress {
  _MaterialProgressImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int materialId,
    _i3.Material? material,
    int? progressPct,
    DateTime? completedAt,
    String? interactionJson,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         materialId: materialId,
         material: material,
         progressPct: progressPct,
         completedAt: completedAt,
         interactionJson: interactionJson,
       );

  /// Returns a shallow copy of this [MaterialProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialProgress copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? materialId,
    Object? material = _Undefined,
    int? progressPct,
    Object? completedAt = _Undefined,
    Object? interactionJson = _Undefined,
  }) {
    return MaterialProgress(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      materialId: materialId ?? this.materialId,
      material: material is _i3.Material?
          ? material
          : this.material?.copyWith(),
      progressPct: progressPct ?? this.progressPct,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      interactionJson: interactionJson is String?
          ? interactionJson
          : this.interactionJson,
    );
  }
}
