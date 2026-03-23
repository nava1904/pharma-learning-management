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

/// Access Review Window (quarterly/periodic review instance)
abstract class AccessReviewWindow implements _i1.SerializableModel {
  AccessReviewWindow._({
    this.id,
    required this.windowId,
    required this.openDate,
    required this.closeDate,
    required this.totalRecords,
    this.jobId,
    String? status,
    DateTime? createdAt,
    this.migrationMarker,
  }) : status = status ?? 'ACTIVE',
       createdAt = createdAt ?? DateTime.now();

  factory AccessReviewWindow({
    int? id,
    required int windowId,
    required DateTime openDate,
    required DateTime closeDate,
    required int totalRecords,
    String? jobId,
    String? status,
    DateTime? createdAt,
    String? migrationMarker,
  }) = _AccessReviewWindowImpl;

  factory AccessReviewWindow.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessReviewWindow(
      id: jsonSerialization['id'] as int?,
      windowId: jsonSerialization['windowId'] as int,
      openDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['openDate'],
      ),
      closeDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['closeDate'],
      ),
      totalRecords: jsonSerialization['totalRecords'] as int,
      jobId: jsonSerialization['jobId'] as String?,
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      migrationMarker: jsonSerialization['migrationMarker'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Unique window ID
  int windowId;

  /// Open date
  DateTime openDate;

  /// Close date
  DateTime closeDate;

  /// Total records in this window
  int totalRecords;

  /// Triggering job ID
  String? jobId;

  /// Status (ACTIVE, CLOSED)
  String status;

  /// Created at
  DateTime createdAt;

  /// Temporary migration marker - remove after migration applied
  String? migrationMarker;

  /// Returns a shallow copy of this [AccessReviewWindow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessReviewWindow copyWith({
    int? id,
    int? windowId,
    DateTime? openDate,
    DateTime? closeDate,
    int? totalRecords,
    String? jobId,
    String? status,
    DateTime? createdAt,
    String? migrationMarker,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessReviewWindow',
      if (id != null) 'id': id,
      'windowId': windowId,
      'openDate': openDate.toJson(),
      'closeDate': closeDate.toJson(),
      'totalRecords': totalRecords,
      if (jobId != null) 'jobId': jobId,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessReviewWindowImpl extends AccessReviewWindow {
  _AccessReviewWindowImpl({
    int? id,
    required int windowId,
    required DateTime openDate,
    required DateTime closeDate,
    required int totalRecords,
    String? jobId,
    String? status,
    DateTime? createdAt,
    String? migrationMarker,
  }) : super._(
         id: id,
         windowId: windowId,
         openDate: openDate,
         closeDate: closeDate,
         totalRecords: totalRecords,
         jobId: jobId,
         status: status,
         createdAt: createdAt,
         migrationMarker: migrationMarker,
       );

  /// Returns a shallow copy of this [AccessReviewWindow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessReviewWindow copyWith({
    Object? id = _Undefined,
    int? windowId,
    DateTime? openDate,
    DateTime? closeDate,
    int? totalRecords,
    Object? jobId = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? migrationMarker = _Undefined,
  }) {
    return AccessReviewWindow(
      id: id is int? ? id : this.id,
      windowId: windowId ?? this.windowId,
      openDate: openDate ?? this.openDate,
      closeDate: closeDate ?? this.closeDate,
      totalRecords: totalRecords ?? this.totalRecords,
      jobId: jobId is String? ? jobId : this.jobId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      migrationMarker: migrationMarker is String?
          ? migrationMarker
          : this.migrationMarker,
    );
  }
}
