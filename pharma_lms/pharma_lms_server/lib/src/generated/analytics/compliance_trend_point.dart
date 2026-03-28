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
import 'package:serverpod/serverpod.dart' as _i1;

/// One month bucket for compliance trend charts (serializable DTO).
abstract class ComplianceTrendPoint
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ComplianceTrendPoint._({
    required this.monthLabel,
    required this.complianceRatePercent,
    required this.fromSnapshot,
  });

  factory ComplianceTrendPoint({
    required String monthLabel,
    required double complianceRatePercent,
    required bool fromSnapshot,
  }) = _ComplianceTrendPointImpl;

  factory ComplianceTrendPoint.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ComplianceTrendPoint(
      monthLabel: jsonSerialization['monthLabel'] as String,
      complianceRatePercent: (jsonSerialization['complianceRatePercent'] as num)
          .toDouble(),
      fromSnapshot: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['fromSnapshot'],
      ),
    );
  }

  /// Calendar month label YYYY-MM.
  String monthLabel;

  /// Organization-wide compliance 0–100 (from snapshots or computed).
  double complianceRatePercent;

  /// True when derived from [AnalyticsSnapshot] rows for that month.
  bool fromSnapshot;

  /// Returns a shallow copy of this [ComplianceTrendPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ComplianceTrendPoint copyWith({
    String? monthLabel,
    double? complianceRatePercent,
    bool? fromSnapshot,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ComplianceTrendPoint',
      'monthLabel': monthLabel,
      'complianceRatePercent': complianceRatePercent,
      'fromSnapshot': fromSnapshot,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ComplianceTrendPoint',
      'monthLabel': monthLabel,
      'complianceRatePercent': complianceRatePercent,
      'fromSnapshot': fromSnapshot,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ComplianceTrendPointImpl extends ComplianceTrendPoint {
  _ComplianceTrendPointImpl({
    required String monthLabel,
    required double complianceRatePercent,
    required bool fromSnapshot,
  }) : super._(
         monthLabel: monthLabel,
         complianceRatePercent: complianceRatePercent,
         fromSnapshot: fromSnapshot,
       );

  /// Returns a shallow copy of this [ComplianceTrendPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ComplianceTrendPoint copyWith({
    String? monthLabel,
    double? complianceRatePercent,
    bool? fromSnapshot,
  }) {
    return ComplianceTrendPoint(
      monthLabel: monthLabel ?? this.monthLabel,
      complianceRatePercent:
          complianceRatePercent ?? this.complianceRatePercent,
      fromSnapshot: fromSnapshot ?? this.fromSnapshot,
    );
  }
}
