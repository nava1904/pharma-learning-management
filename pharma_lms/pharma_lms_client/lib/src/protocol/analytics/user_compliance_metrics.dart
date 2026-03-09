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

/// User compliance metrics.
abstract class UserComplianceMetrics implements _i1.SerializableModel {
  UserComplianceMetrics._({
    required this.compliant,
    required this.overdueCount,
    required this.upcomingCount,
    required this.complianceRate,
    required this.totalCertificates,
    int? waivedCount,
  }) : waivedCount = waivedCount ?? 0;

  factory UserComplianceMetrics({
    required bool compliant,
    required int overdueCount,
    required int upcomingCount,
    required double complianceRate,
    required int totalCertificates,
    int? waivedCount,
  }) = _UserComplianceMetricsImpl;

  factory UserComplianceMetrics.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserComplianceMetrics(
      compliant: _i1.BoolJsonExtension.fromJson(jsonSerialization['compliant']),
      overdueCount: jsonSerialization['overdueCount'] as int,
      upcomingCount: jsonSerialization['upcomingCount'] as int,
      complianceRate: (jsonSerialization['complianceRate'] as num).toDouble(),
      totalCertificates: jsonSerialization['totalCertificates'] as int,
      waivedCount: jsonSerialization['waivedCount'] as int?,
    );
  }

  bool compliant;

  int overdueCount;

  int upcomingCount;

  double complianceRate;

  int totalCertificates;

  /// ADM-07: Count of approved waivers (waived status in compliance).
  int waivedCount;

  /// Returns a shallow copy of this [UserComplianceMetrics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserComplianceMetrics copyWith({
    bool? compliant,
    int? overdueCount,
    int? upcomingCount,
    double? complianceRate,
    int? totalCertificates,
    int? waivedCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserComplianceMetrics',
      'compliant': compliant,
      'overdueCount': overdueCount,
      'upcomingCount': upcomingCount,
      'complianceRate': complianceRate,
      'totalCertificates': totalCertificates,
      'waivedCount': waivedCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserComplianceMetricsImpl extends UserComplianceMetrics {
  _UserComplianceMetricsImpl({
    required bool compliant,
    required int overdueCount,
    required int upcomingCount,
    required double complianceRate,
    required int totalCertificates,
    int? waivedCount,
  }) : super._(
         compliant: compliant,
         overdueCount: overdueCount,
         upcomingCount: upcomingCount,
         complianceRate: complianceRate,
         totalCertificates: totalCertificates,
         waivedCount: waivedCount,
       );

  /// Returns a shallow copy of this [UserComplianceMetrics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserComplianceMetrics copyWith({
    bool? compliant,
    int? overdueCount,
    int? upcomingCount,
    double? complianceRate,
    int? totalCertificates,
    int? waivedCount,
  }) {
    return UserComplianceMetrics(
      compliant: compliant ?? this.compliant,
      overdueCount: overdueCount ?? this.overdueCount,
      upcomingCount: upcomingCount ?? this.upcomingCount,
      complianceRate: complianceRate ?? this.complianceRate,
      totalCertificates: totalCertificates ?? this.totalCertificates,
      waivedCount: waivedCount ?? this.waivedCount,
    );
  }
}
