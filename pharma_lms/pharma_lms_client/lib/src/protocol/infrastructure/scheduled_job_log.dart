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

/// Scheduled job execution log. GMP.
abstract class ScheduledJobLog implements _i1.SerializableModel {
  ScheduledJobLog._({
    this.id,
    required this.jobName,
    DateTime? startedAt,
    this.completedAt,
    String? status,
    this.recordsProcessed,
    this.recordsAffected,
    this.errorDetails,
  }) : startedAt = startedAt ?? DateTime.now(),
       status = status ?? 'running';

  factory ScheduledJobLog({
    int? id,
    required String jobName,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
    int? recordsProcessed,
    int? recordsAffected,
    String? errorDetails,
  }) = _ScheduledJobLogImpl;

  factory ScheduledJobLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduledJobLog(
      id: jsonSerialization['id'] as int?,
      jobName: jsonSerialization['jobName'] as String,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      status: jsonSerialization['status'] as String?,
      recordsProcessed: jsonSerialization['recordsProcessed'] as int?,
      recordsAffected: jsonSerialization['recordsAffected'] as int?,
      errorDetails: jsonSerialization['errorDetails'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Job name: CertExpiryCheck, ComplianceCalc, NotificationWorker, CapaEffectivenessCheck.
  String jobName;

  /// When started.
  DateTime startedAt;

  /// When completed.
  DateTime? completedAt;

  /// Status: running, completed, failed.
  String status;

  /// Records processed.
  int? recordsProcessed;

  /// Records affected.
  int? recordsAffected;

  /// Error details if failed.
  String? errorDetails;

  /// Returns a shallow copy of this [ScheduledJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledJobLog copyWith({
    int? id,
    String? jobName,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
    int? recordsProcessed,
    int? recordsAffected,
    String? errorDetails,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduledJobLog',
      if (id != null) 'id': id,
      'jobName': jobName,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'status': status,
      if (recordsProcessed != null) 'recordsProcessed': recordsProcessed,
      if (recordsAffected != null) 'recordsAffected': recordsAffected,
      if (errorDetails != null) 'errorDetails': errorDetails,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledJobLogImpl extends ScheduledJobLog {
  _ScheduledJobLogImpl({
    int? id,
    required String jobName,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
    int? recordsProcessed,
    int? recordsAffected,
    String? errorDetails,
  }) : super._(
         id: id,
         jobName: jobName,
         startedAt: startedAt,
         completedAt: completedAt,
         status: status,
         recordsProcessed: recordsProcessed,
         recordsAffected: recordsAffected,
         errorDetails: errorDetails,
       );

  /// Returns a shallow copy of this [ScheduledJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledJobLog copyWith({
    Object? id = _Undefined,
    String? jobName,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
    String? status,
    Object? recordsProcessed = _Undefined,
    Object? recordsAffected = _Undefined,
    Object? errorDetails = _Undefined,
  }) {
    return ScheduledJobLog(
      id: id is int? ? id : this.id,
      jobName: jobName ?? this.jobName,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      status: status ?? this.status,
      recordsProcessed: recordsProcessed is int?
          ? recordsProcessed
          : this.recordsProcessed,
      recordsAffected: recordsAffected is int?
          ? recordsAffected
          : this.recordsAffected,
      errorDetails: errorDetails is String? ? errorDetails : this.errorDetails,
    );
  }
}
