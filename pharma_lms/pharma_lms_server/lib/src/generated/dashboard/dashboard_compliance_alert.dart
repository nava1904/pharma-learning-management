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

abstract class DashboardComplianceAlert
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardComplianceAlert._({
    required this.alertType,
    required this.message,
    this.courseTitle,
    this.dueDate,
    this.severity,
  });

  factory DashboardComplianceAlert({
    required String alertType,
    required String message,
    String? courseTitle,
    DateTime? dueDate,
    String? severity,
  }) = _DashboardComplianceAlertImpl;

  factory DashboardComplianceAlert.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DashboardComplianceAlert(
      alertType: jsonSerialization['alertType'] as String,
      message: jsonSerialization['message'] as String,
      courseTitle: jsonSerialization['courseTitle'] as String?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      severity: jsonSerialization['severity'] as String?,
    );
  }

  String alertType;

  String message;

  String? courseTitle;

  DateTime? dueDate;

  String? severity;

  /// Returns a shallow copy of this [DashboardComplianceAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardComplianceAlert copyWith({
    String? alertType,
    String? message,
    String? courseTitle,
    DateTime? dueDate,
    String? severity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardComplianceAlert',
      'alertType': alertType,
      'message': message,
      if (courseTitle != null) 'courseTitle': courseTitle,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (severity != null) 'severity': severity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardComplianceAlert',
      'alertType': alertType,
      'message': message,
      if (courseTitle != null) 'courseTitle': courseTitle,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (severity != null) 'severity': severity,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardComplianceAlertImpl extends DashboardComplianceAlert {
  _DashboardComplianceAlertImpl({
    required String alertType,
    required String message,
    String? courseTitle,
    DateTime? dueDate,
    String? severity,
  }) : super._(
         alertType: alertType,
         message: message,
         courseTitle: courseTitle,
         dueDate: dueDate,
         severity: severity,
       );

  /// Returns a shallow copy of this [DashboardComplianceAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardComplianceAlert copyWith({
    String? alertType,
    String? message,
    Object? courseTitle = _Undefined,
    Object? dueDate = _Undefined,
    Object? severity = _Undefined,
  }) {
    return DashboardComplianceAlert(
      alertType: alertType ?? this.alertType,
      message: message ?? this.message,
      courseTitle: courseTitle is String? ? courseTitle : this.courseTitle,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      severity: severity is String? ? severity : this.severity,
    );
  }
}
