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

abstract class DashboardEsignatureSummary implements _i1.SerializableModel {
  DashboardEsignatureSummary._({
    required this.total,
    required this.pending,
    required this.completed,
    required this.overdue,
  });

  factory DashboardEsignatureSummary({
    required int total,
    required int pending,
    required int completed,
    required int overdue,
  }) = _DashboardEsignatureSummaryImpl;

  factory DashboardEsignatureSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DashboardEsignatureSummary(
      total: jsonSerialization['total'] as int,
      pending: jsonSerialization['pending'] as int,
      completed: jsonSerialization['completed'] as int,
      overdue: jsonSerialization['overdue'] as int,
    );
  }

  int total;

  int pending;

  int completed;

  int overdue;

  /// Returns a shallow copy of this [DashboardEsignatureSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardEsignatureSummary copyWith({
    int? total,
    int? pending,
    int? completed,
    int? overdue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardEsignatureSummary',
      'total': total,
      'pending': pending,
      'completed': completed,
      'overdue': overdue,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardEsignatureSummaryImpl extends DashboardEsignatureSummary {
  _DashboardEsignatureSummaryImpl({
    required int total,
    required int pending,
    required int completed,
    required int overdue,
  }) : super._(
         total: total,
         pending: pending,
         completed: completed,
         overdue: overdue,
       );

  /// Returns a shallow copy of this [DashboardEsignatureSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardEsignatureSummary copyWith({
    int? total,
    int? pending,
    int? completed,
    int? overdue,
  }) {
    return DashboardEsignatureSummary(
      total: total ?? this.total,
      pending: pending ?? this.pending,
      completed: completed ?? this.completed,
      overdue: overdue ?? this.overdue,
    );
  }
}
