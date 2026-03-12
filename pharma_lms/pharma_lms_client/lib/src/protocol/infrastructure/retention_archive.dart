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

/// Archived records moved from hot tables per retention policy.
/// Stores snapshot of record at archival time for compliance.
abstract class RetentionArchive implements _i1.SerializableModel {
  RetentionArchive._({
    this.id,
    required this.entityType,
    required this.entityId,
    required this.rowJson,
    DateTime? archivedAt,
  }) : archivedAt = archivedAt ?? DateTime.now();

  factory RetentionArchive({
    int? id,
    required String entityType,
    required String entityId,
    required String rowJson,
    DateTime? archivedAt,
  }) = _RetentionArchiveImpl;

  factory RetentionArchive.fromJson(Map<String, dynamic> jsonSerialization) {
    return RetentionArchive(
      id: jsonSerialization['id'] as int?,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String,
      rowJson: jsonSerialization['rowJson'] as String,
      archivedAt: jsonSerialization['archivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['archivedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Source entity type (e.g., audit_trail).
  String entityType;

  /// Original entity ID.
  String entityId;

  /// Full row data as JSON snapshot.
  String rowJson;

  /// When archived.
  DateTime archivedAt;

  /// Returns a shallow copy of this [RetentionArchive]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RetentionArchive copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? rowJson,
    DateTime? archivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RetentionArchive',
      if (id != null) 'id': id,
      'entityType': entityType,
      'entityId': entityId,
      'rowJson': rowJson,
      'archivedAt': archivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RetentionArchiveImpl extends RetentionArchive {
  _RetentionArchiveImpl({
    int? id,
    required String entityType,
    required String entityId,
    required String rowJson,
    DateTime? archivedAt,
  }) : super._(
         id: id,
         entityType: entityType,
         entityId: entityId,
         rowJson: rowJson,
         archivedAt: archivedAt,
       );

  /// Returns a shallow copy of this [RetentionArchive]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RetentionArchive copyWith({
    Object? id = _Undefined,
    String? entityType,
    String? entityId,
    String? rowJson,
    DateTime? archivedAt,
  }) {
    return RetentionArchive(
      id: id is int? ? id : this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      rowJson: rowJson ?? this.rowJson,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }
}
