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
import '../organization/department.dart' as _i2;
import '../infrastructure/scheduled_job_log.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Historical snapshot of department compliance metrics for trending.
abstract class DepartmentComplianceSnapshot implements _i1.SerializableModel {
  DepartmentComplianceSnapshot._({
    this.id,
    required this.departmentId,
    this.department,
    DateTime? snapshotDate,
    required this.totalEmployees,
    required this.compliantCount,
    required this.overdueCount,
    required this.upcomingCount,
    required this.complianceRate,
    this.scheduledJobLogId,
    this.scheduledJobLog,
  }) : snapshotDate = snapshotDate ?? DateTime.now();

  factory DepartmentComplianceSnapshot({
    int? id,
    required int departmentId,
    _i2.Department? department,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required int upcomingCount,
    required double complianceRate,
    int? scheduledJobLogId,
    _i3.ScheduledJobLog? scheduledJobLog,
  }) = _DepartmentComplianceSnapshotImpl;

  factory DepartmentComplianceSnapshot.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DepartmentComplianceSnapshot(
      id: jsonSerialization['id'] as int?,
      departmentId: jsonSerialization['departmentId'] as int,
      department: jsonSerialization['department'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Department>(
              jsonSerialization['department'],
            ),
      snapshotDate: jsonSerialization['snapshotDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['snapshotDate'],
            ),
      totalEmployees: jsonSerialization['totalEmployees'] as int,
      compliantCount: jsonSerialization['compliantCount'] as int,
      overdueCount: jsonSerialization['overdueCount'] as int,
      upcomingCount: jsonSerialization['upcomingCount'] as int,
      complianceRate: (jsonSerialization['complianceRate'] as num).toDouble(),
      scheduledJobLogId: jsonSerialization['scheduledJobLogId'] as int?,
      scheduledJobLog: jsonSerialization['scheduledJobLog'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.ScheduledJobLog>(
              jsonSerialization['scheduledJobLog'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int departmentId;

  /// The department.
  _i2.Department? department;

  /// When the snapshot was taken.
  DateTime snapshotDate;

  /// Total employees in department at snapshot time.
  int totalEmployees;

  /// Compliant employee count.
  int compliantCount;

  /// Overdue employee count.
  int overdueCount;

  /// Upcoming expiry count.
  int upcomingCount;

  /// Compliance percentage (0-100).
  double complianceRate;

  int? scheduledJobLogId;

  /// Job log reference.
  _i3.ScheduledJobLog? scheduledJobLog;

  /// Returns a shallow copy of this [DepartmentComplianceSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DepartmentComplianceSnapshot copyWith({
    int? id,
    int? departmentId,
    _i2.Department? department,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    int? upcomingCount,
    double? complianceRate,
    int? scheduledJobLogId,
    _i3.ScheduledJobLog? scheduledJobLog,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DepartmentComplianceSnapshot',
      if (id != null) 'id': id,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJson(),
      'snapshotDate': snapshotDate.toJson(),
      'totalEmployees': totalEmployees,
      'compliantCount': compliantCount,
      'overdueCount': overdueCount,
      'upcomingCount': upcomingCount,
      'complianceRate': complianceRate,
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

class _DepartmentComplianceSnapshotImpl extends DepartmentComplianceSnapshot {
  _DepartmentComplianceSnapshotImpl({
    int? id,
    required int departmentId,
    _i2.Department? department,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required int upcomingCount,
    required double complianceRate,
    int? scheduledJobLogId,
    _i3.ScheduledJobLog? scheduledJobLog,
  }) : super._(
         id: id,
         departmentId: departmentId,
         department: department,
         snapshotDate: snapshotDate,
         totalEmployees: totalEmployees,
         compliantCount: compliantCount,
         overdueCount: overdueCount,
         upcomingCount: upcomingCount,
         complianceRate: complianceRate,
         scheduledJobLogId: scheduledJobLogId,
         scheduledJobLog: scheduledJobLog,
       );

  /// Returns a shallow copy of this [DepartmentComplianceSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DepartmentComplianceSnapshot copyWith({
    Object? id = _Undefined,
    int? departmentId,
    Object? department = _Undefined,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    int? upcomingCount,
    double? complianceRate,
    Object? scheduledJobLogId = _Undefined,
    Object? scheduledJobLog = _Undefined,
  }) {
    return DepartmentComplianceSnapshot(
      id: id is int? ? id : this.id,
      departmentId: departmentId ?? this.departmentId,
      department: department is _i2.Department?
          ? department
          : this.department?.copyWith(),
      snapshotDate: snapshotDate ?? this.snapshotDate,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      compliantCount: compliantCount ?? this.compliantCount,
      overdueCount: overdueCount ?? this.overdueCount,
      upcomingCount: upcomingCount ?? this.upcomingCount,
      complianceRate: complianceRate ?? this.complianceRate,
      scheduledJobLogId: scheduledJobLogId is int?
          ? scheduledJobLogId
          : this.scheduledJobLogId,
      scheduledJobLog: scheduledJobLog is _i3.ScheduledJobLog?
          ? scheduledJobLog
          : this.scheduledJobLog?.copyWith(),
    );
  }
}
