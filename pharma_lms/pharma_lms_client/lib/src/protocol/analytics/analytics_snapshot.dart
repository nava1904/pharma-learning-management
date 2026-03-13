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

/// Organization-wide analytics snapshot for historical trending.
abstract class AnalyticsSnapshot implements _i1.SerializableModel {
  AnalyticsSnapshot._({
    this.id,
    DateTime? snapshotDate,
    required this.totalEmployees,
    required this.compliantCount,
    required this.overdueCount,
    required this.orgComplianceRate,
    required this.totalCertificates,
    required this.certsExpiring30d,
    required this.certsExpiring60d,
    required this.openAssignments,
    this.scheduledJobLogId,
    this.scheduledJobLog,
  }) : snapshotDate = snapshotDate ?? DateTime.now();

  factory AnalyticsSnapshot({
    int? id,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required double orgComplianceRate,
    required int totalCertificates,
    required int certsExpiring30d,
    required int certsExpiring60d,
    required int openAssignments,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) = _AnalyticsSnapshotImpl;

  factory AnalyticsSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsSnapshot(
      id: jsonSerialization['id'] as int?,
      snapshotDate: jsonSerialization['snapshotDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['snapshotDate'],
            ),
      totalEmployees: jsonSerialization['totalEmployees'] as int,
      compliantCount: jsonSerialization['compliantCount'] as int,
      overdueCount: jsonSerialization['overdueCount'] as int,
      orgComplianceRate: (jsonSerialization['orgComplianceRate'] as num)
          .toDouble(),
      totalCertificates: jsonSerialization['totalCertificates'] as int,
      certsExpiring30d: jsonSerialization['certsExpiring30d'] as int,
      certsExpiring60d: jsonSerialization['certsExpiring60d'] as int,
      openAssignments: jsonSerialization['openAssignments'] as int,
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

  /// When the snapshot was taken.
  DateTime snapshotDate;

  /// Total active employees.
  int totalEmployees;

  /// Total compliant employees.
  int compliantCount;

  /// Total overdue employees.
  int overdueCount;

  /// Organization-wide compliance rate (0-100).
  double orgComplianceRate;

  /// Total active certificates.
  int totalCertificates;

  /// Certificates expiring in 30 days.
  int certsExpiring30d;

  /// Certificates expiring in 60 days.
  int certsExpiring60d;

  /// Total open training assignments.
  int openAssignments;

  int? scheduledJobLogId;

  /// Job log reference.
  _i2.ScheduledJobLog? scheduledJobLog;

  /// Returns a shallow copy of this [AnalyticsSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalyticsSnapshot copyWith({
    int? id,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    double? orgComplianceRate,
    int? totalCertificates,
    int? certsExpiring30d,
    int? certsExpiring60d,
    int? openAssignments,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsSnapshot',
      if (id != null) 'id': id,
      'snapshotDate': snapshotDate.toJson(),
      'totalEmployees': totalEmployees,
      'compliantCount': compliantCount,
      'overdueCount': overdueCount,
      'orgComplianceRate': orgComplianceRate,
      'totalCertificates': totalCertificates,
      'certsExpiring30d': certsExpiring30d,
      'certsExpiring60d': certsExpiring60d,
      'openAssignments': openAssignments,
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

class _AnalyticsSnapshotImpl extends AnalyticsSnapshot {
  _AnalyticsSnapshotImpl({
    int? id,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required double orgComplianceRate,
    required int totalCertificates,
    required int certsExpiring30d,
    required int certsExpiring60d,
    required int openAssignments,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) : super._(
         id: id,
         snapshotDate: snapshotDate,
         totalEmployees: totalEmployees,
         compliantCount: compliantCount,
         overdueCount: overdueCount,
         orgComplianceRate: orgComplianceRate,
         totalCertificates: totalCertificates,
         certsExpiring30d: certsExpiring30d,
         certsExpiring60d: certsExpiring60d,
         openAssignments: openAssignments,
         scheduledJobLogId: scheduledJobLogId,
         scheduledJobLog: scheduledJobLog,
       );

  /// Returns a shallow copy of this [AnalyticsSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnalyticsSnapshot copyWith({
    Object? id = _Undefined,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    double? orgComplianceRate,
    int? totalCertificates,
    int? certsExpiring30d,
    int? certsExpiring60d,
    int? openAssignments,
    Object? scheduledJobLogId = _Undefined,
    Object? scheduledJobLog = _Undefined,
  }) {
    return AnalyticsSnapshot(
      id: id is int? ? id : this.id,
      snapshotDate: snapshotDate ?? this.snapshotDate,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      compliantCount: compliantCount ?? this.compliantCount,
      overdueCount: overdueCount ?? this.overdueCount,
      orgComplianceRate: orgComplianceRate ?? this.orgComplianceRate,
      totalCertificates: totalCertificates ?? this.totalCertificates,
      certsExpiring30d: certsExpiring30d ?? this.certsExpiring30d,
      certsExpiring60d: certsExpiring60d ?? this.certsExpiring60d,
      openAssignments: openAssignments ?? this.openAssignments,
      scheduledJobLogId: scheduledJobLogId is int?
          ? scheduledJobLogId
          : this.scheduledJobLogId,
      scheduledJobLog: scheduledJobLog is _i2.ScheduledJobLog?
          ? scheduledJobLog
          : this.scheduledJobLog?.copyWith(),
    );
  }
}
