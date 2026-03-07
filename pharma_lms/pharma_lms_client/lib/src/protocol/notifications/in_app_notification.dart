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

/// In-app notification (assignment due/overdue).
abstract class InAppNotification implements _i1.SerializableModel {
  InAppNotification._({
    required this.type,
    this.assignmentId,
    required this.courseTitle,
    required this.dueDate,
    required this.message,
  });

  factory InAppNotification({
    required String type,
    int? assignmentId,
    required String courseTitle,
    required String dueDate,
    required String message,
  }) = _InAppNotificationImpl;

  factory InAppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return InAppNotification(
      type: jsonSerialization['type'] as String,
      assignmentId: jsonSerialization['assignmentId'] as int?,
      courseTitle: jsonSerialization['courseTitle'] as String,
      dueDate: jsonSerialization['dueDate'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String type;

  int? assignmentId;

  String courseTitle;

  String dueDate;

  String message;

  /// Returns a shallow copy of this [InAppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InAppNotification copyWith({
    String? type,
    int? assignmentId,
    String? courseTitle,
    String? dueDate,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InAppNotification',
      'type': type,
      if (assignmentId != null) 'assignmentId': assignmentId,
      'courseTitle': courseTitle,
      'dueDate': dueDate,
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InAppNotificationImpl extends InAppNotification {
  _InAppNotificationImpl({
    required String type,
    int? assignmentId,
    required String courseTitle,
    required String dueDate,
    required String message,
  }) : super._(
         type: type,
         assignmentId: assignmentId,
         courseTitle: courseTitle,
         dueDate: dueDate,
         message: message,
       );

  /// Returns a shallow copy of this [InAppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InAppNotification copyWith({
    String? type,
    Object? assignmentId = _Undefined,
    String? courseTitle,
    String? dueDate,
    String? message,
  }) {
    return InAppNotification(
      type: type ?? this.type,
      assignmentId: assignmentId is int? ? assignmentId : this.assignmentId,
      courseTitle: courseTitle ?? this.courseTitle,
      dueDate: dueDate ?? this.dueDate,
      message: message ?? this.message,
    );
  }
}
