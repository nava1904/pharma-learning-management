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

/// Retention policy configuration for data archival.
/// Defines how long to retain data before archiving to cold storage.
abstract class RetentionPolicy implements _i1.SerializableModel {
  RetentionPolicy._({
    this.id,
    required this.entityType,
    int? retentionYears,
    bool? archiveEnabled,
    this.lastArchivedAt,
  }) : retentionYears = retentionYears ?? 7,
       archiveEnabled = archiveEnabled ?? true;

  factory RetentionPolicy({
    int? id,
    required String entityType,
    int? retentionYears,
    bool? archiveEnabled,
    DateTime? lastArchivedAt,
  }) = _RetentionPolicyImpl;

  factory RetentionPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return RetentionPolicy(
      id: jsonSerialization['id'] as int?,
      entityType: jsonSerialization['entityType'] as String,
      retentionYears: jsonSerialization['retentionYears'] as int?,
      archiveEnabled: jsonSerialization['archiveEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['archiveEnabled']),
      lastArchivedAt: jsonSerialization['lastArchivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastArchivedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Entity type (e.g., audit_trail, access_log, notification).
  String entityType;

  /// Retention period in years before archival.
  int retentionYears;

  /// Whether to archive (move to cold storage) or only enforce retention.
  bool archiveEnabled;

  /// Last run timestamp.
  DateTime? lastArchivedAt;

  /// Returns a shallow copy of this [RetentionPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RetentionPolicy copyWith({
    int? id,
    String? entityType,
    int? retentionYears,
    bool? archiveEnabled,
    DateTime? lastArchivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RetentionPolicy',
      if (id != null) 'id': id,
      'entityType': entityType,
      'retentionYears': retentionYears,
      'archiveEnabled': archiveEnabled,
      if (lastArchivedAt != null) 'lastArchivedAt': lastArchivedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RetentionPolicyImpl extends RetentionPolicy {
  _RetentionPolicyImpl({
    int? id,
    required String entityType,
    int? retentionYears,
    bool? archiveEnabled,
    DateTime? lastArchivedAt,
  }) : super._(
         id: id,
         entityType: entityType,
         retentionYears: retentionYears,
         archiveEnabled: archiveEnabled,
         lastArchivedAt: lastArchivedAt,
       );

  /// Returns a shallow copy of this [RetentionPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RetentionPolicy copyWith({
    Object? id = _Undefined,
    String? entityType,
    int? retentionYears,
    bool? archiveEnabled,
    Object? lastArchivedAt = _Undefined,
  }) {
    return RetentionPolicy(
      id: id is int? ? id : this.id,
      entityType: entityType ?? this.entityType,
      retentionYears: retentionYears ?? this.retentionYears,
      archiveEnabled: archiveEnabled ?? this.archiveEnabled,
      lastArchivedAt: lastArchivedAt is DateTime?
          ? lastArchivedAt
          : this.lastArchivedAt,
    );
  }
}
