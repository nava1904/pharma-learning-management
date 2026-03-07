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

/// Department compliance summary row.
abstract class DepartmentComplianceSummary implements _i1.SerializableModel {
  DepartmentComplianceSummary._({
    this.departmentId,
    this.departmentName,
    required this.totalEmployees,
    required this.compliant,
    required this.overdue,
    required this.upcoming,
    required this.complianceRate,
  });

  factory DepartmentComplianceSummary({
    int? departmentId,
    String? departmentName,
    required int totalEmployees,
    required int compliant,
    required int overdue,
    required int upcoming,
    required double complianceRate,
  }) = _DepartmentComplianceSummaryImpl;

  factory DepartmentComplianceSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DepartmentComplianceSummary(
      departmentId: jsonSerialization['departmentId'] as int?,
      departmentName: jsonSerialization['departmentName'] as String?,
      totalEmployees: jsonSerialization['totalEmployees'] as int,
      compliant: jsonSerialization['compliant'] as int,
      overdue: jsonSerialization['overdue'] as int,
      upcoming: jsonSerialization['upcoming'] as int,
      complianceRate: (jsonSerialization['complianceRate'] as num).toDouble(),
    );
  }

  int? departmentId;

  String? departmentName;

  int totalEmployees;

  int compliant;

  int overdue;

  int upcoming;

  double complianceRate;

  /// Returns a shallow copy of this [DepartmentComplianceSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DepartmentComplianceSummary copyWith({
    int? departmentId,
    String? departmentName,
    int? totalEmployees,
    int? compliant,
    int? overdue,
    int? upcoming,
    double? complianceRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DepartmentComplianceSummary',
      if (departmentId != null) 'departmentId': departmentId,
      if (departmentName != null) 'departmentName': departmentName,
      'totalEmployees': totalEmployees,
      'compliant': compliant,
      'overdue': overdue,
      'upcoming': upcoming,
      'complianceRate': complianceRate,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DepartmentComplianceSummaryImpl extends DepartmentComplianceSummary {
  _DepartmentComplianceSummaryImpl({
    int? departmentId,
    String? departmentName,
    required int totalEmployees,
    required int compliant,
    required int overdue,
    required int upcoming,
    required double complianceRate,
  }) : super._(
         departmentId: departmentId,
         departmentName: departmentName,
         totalEmployees: totalEmployees,
         compliant: compliant,
         overdue: overdue,
         upcoming: upcoming,
         complianceRate: complianceRate,
       );

  /// Returns a shallow copy of this [DepartmentComplianceSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DepartmentComplianceSummary copyWith({
    Object? departmentId = _Undefined,
    Object? departmentName = _Undefined,
    int? totalEmployees,
    int? compliant,
    int? overdue,
    int? upcoming,
    double? complianceRate,
  }) {
    return DepartmentComplianceSummary(
      departmentId: departmentId is int? ? departmentId : this.departmentId,
      departmentName: departmentName is String?
          ? departmentName
          : this.departmentName,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      compliant: compliant ?? this.compliant,
      overdue: overdue ?? this.overdue,
      upcoming: upcoming ?? this.upcoming,
      complianceRate: complianceRate ?? this.complianceRate,
    );
  }
}
