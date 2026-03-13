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
import '../infrastructure/scheduled_job_log.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Result of audit trail integrity check (SYS-WF-08).
abstract class AuditIntegrityResult implements _i1.SerializableModel {
  AuditIntegrityResult._({
    this.id,
    DateTime? checkedAt,
    required this.recordsChecked,
    required this.hashMismatches,
    required this.sequenceGaps,
    required this.result,
    this.failureDetailsJson,
    this.scheduledJobLogId,
    this.scheduledJobLog,
  }) : checkedAt = checkedAt ?? DateTime.now();

  factory AuditIntegrityResult({
    int? id,
    DateTime? checkedAt,
    required int recordsChecked,
    required int hashMismatches,
    required int sequenceGaps,
    required String result,
    String? failureDetailsJson,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) = _AuditIntegrityResultImpl;

  factory AuditIntegrityResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AuditIntegrityResult(
      id: jsonSerialization['id'] as int?,
      checkedAt: jsonSerialization['checkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkedAt']),
      recordsChecked: jsonSerialization['recordsChecked'] as int,
      hashMismatches: jsonSerialization['hashMismatches'] as int,
      sequenceGaps: jsonSerialization['sequenceGaps'] as int,
      result: jsonSerialization['result'] as String,
      failureDetailsJson: jsonSerialization['failureDetailsJson'] as String?,
      scheduledJobLogId: jsonSerialization['scheduledJobLogId'] as int?,
      scheduledJobLog: jsonSerialization['scheduledJobLog'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.ScheduledJobLog>(
              jsonSerialization['scheduledJobLog'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// When the check was performed.
  DateTime checkedAt;

  /// Number of records checked.
  int recordsChecked;

  /// Number of hash mismatches found.
  int hashMismatches;

  /// Number of sequence gaps found.
  int sequenceGaps;

  /// Overall result: passed, failed.
  String result;

  /// Details of any failures as JSON array.
  String? failureDetailsJson;

  int? scheduledJobLogId;

  /// Job log reference.
  _i2.ScheduledJobLog? scheduledJobLog;

  /// Returns a shallow copy of this [AuditIntegrityResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditIntegrityResult copyWith({
    int? id,
    DateTime? checkedAt,
    int? recordsChecked,
    int? hashMismatches,
    int? sequenceGaps,
    String? result,
    String? failureDetailsJson,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditIntegrityResult',
      if (id != null) 'id': id,
      'checkedAt': checkedAt.toJson(),
      'recordsChecked': recordsChecked,
      'hashMismatches': hashMismatches,
      'sequenceGaps': sequenceGaps,
      'result': result,
      if (failureDetailsJson != null) 'failureDetailsJson': failureDetailsJson,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null) 'scheduledJobLog': scheduledJobLog?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditIntegrityResultImpl extends AuditIntegrityResult {
  _AuditIntegrityResultImpl({
    int? id,
    DateTime? checkedAt,
    required int recordsChecked,
    required int hashMismatches,
    required int sequenceGaps,
    required String result,
    String? failureDetailsJson,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) : super._(
         id: id,
         checkedAt: checkedAt,
         recordsChecked: recordsChecked,
         hashMismatches: hashMismatches,
         sequenceGaps: sequenceGaps,
         result: result,
         failureDetailsJson: failureDetailsJson,
         scheduledJobLogId: scheduledJobLogId,
         scheduledJobLog: scheduledJobLog,
       );

  /// Returns a shallow copy of this [AuditIntegrityResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditIntegrityResult copyWith({
    Object? id = _Undefined,
    DateTime? checkedAt,
    int? recordsChecked,
    int? hashMismatches,
    int? sequenceGaps,
    String? result,
    Object? failureDetailsJson = _Undefined,
    Object? scheduledJobLogId = _Undefined,
    Object? scheduledJobLog = _Undefined,
  }) {
    return AuditIntegrityResult(
      id: id is int? ? id : this.id,
      checkedAt: checkedAt ?? this.checkedAt,
      recordsChecked: recordsChecked ?? this.recordsChecked,
      hashMismatches: hashMismatches ?? this.hashMismatches,
      sequenceGaps: sequenceGaps ?? this.sequenceGaps,
      result: result ?? this.result,
      failureDetailsJson: failureDetailsJson is String?
          ? failureDetailsJson
          : this.failureDetailsJson,
      scheduledJobLogId: scheduledJobLogId is int?
          ? scheduledJobLogId
          : this.scheduledJobLogId,
      scheduledJobLog: scheduledJobLog is _i2.ScheduledJobLog?
          ? scheduledJobLog
          : this.scheduledJobLog?.copyWith(),
    );
  }
}
