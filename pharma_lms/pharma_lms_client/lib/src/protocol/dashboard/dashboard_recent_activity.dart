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

abstract class DashboardRecentActivity implements _i1.SerializableModel {
  DashboardRecentActivity._({
    required this.timestamp,
    required this.action,
    required this.entityType,
    this.detail,
  });

  factory DashboardRecentActivity({
    required DateTime timestamp,
    required String action,
    required String entityType,
    String? detail,
  }) = _DashboardRecentActivityImpl;

  factory DashboardRecentActivity.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DashboardRecentActivity(
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      action: jsonSerialization['action'] as String,
      entityType: jsonSerialization['entityType'] as String,
      detail: jsonSerialization['detail'] as String?,
    );
  }

  DateTime timestamp;

  String action;

  String entityType;

  String? detail;

  /// Returns a shallow copy of this [DashboardRecentActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardRecentActivity copyWith({
    DateTime? timestamp,
    String? action,
    String? entityType,
    String? detail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardRecentActivity',
      'timestamp': timestamp.toJson(),
      'action': action,
      'entityType': entityType,
      if (detail != null) 'detail': detail,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardRecentActivityImpl extends DashboardRecentActivity {
  _DashboardRecentActivityImpl({
    required DateTime timestamp,
    required String action,
    required String entityType,
    String? detail,
  }) : super._(
         timestamp: timestamp,
         action: action,
         entityType: entityType,
         detail: detail,
       );

  /// Returns a shallow copy of this [DashboardRecentActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardRecentActivity copyWith({
    DateTime? timestamp,
    String? action,
    String? entityType,
    Object? detail = _Undefined,
  }) {
    return DashboardRecentActivity(
      timestamp: timestamp ?? this.timestamp,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      detail: detail is String? ? detail : this.detail,
    );
  }
}
