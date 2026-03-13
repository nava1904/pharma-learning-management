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
import '../notifications/notification.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Log of notification delivery attempts. GMP.
abstract class NotificationLog implements _i1.SerializableModel {
  NotificationLog._({
    this.id,
    required this.notificationId,
    this.notification,
    DateTime? attemptedAt,
    required this.channel,
    String? status,
    this.errorMessage,
    int? retryCount,
    this.externalMessageId,
  }) : attemptedAt = attemptedAt ?? DateTime.now(),
       status = status ?? 'sent',
       retryCount = retryCount ?? 0;

  factory NotificationLog({
    int? id,
    required int notificationId,
    _i2.Notification? notification,
    DateTime? attemptedAt,
    required String channel,
    String? status,
    String? errorMessage,
    int? retryCount,
    String? externalMessageId,
  }) = _NotificationLogImpl;

  factory NotificationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotificationLog(
      id: jsonSerialization['id'] as int?,
      notificationId: jsonSerialization['notificationId'] as int,
      notification: jsonSerialization['notification'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Notification>(
              jsonSerialization['notification'],
            ),
      attemptedAt: jsonSerialization['attemptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['attemptedAt'],
            ),
      channel: jsonSerialization['channel'] as String,
      status: jsonSerialization['status'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      retryCount: jsonSerialization['retryCount'] as int?,
      externalMessageId: jsonSerialization['externalMessageId'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int notificationId;

  /// The notification record.
  _i2.Notification? notification;

  /// When the delivery was attempted.
  DateTime attemptedAt;

  /// Delivery channel: email, sms, in_app.
  String channel;

  /// Status: sent, failed, bounced, delivered.
  String status;

  /// Error message if failed.
  String? errorMessage;

  /// Retry count.
  int retryCount;

  /// External message ID (e.g., SendGrid ID).
  String? externalMessageId;

  /// Returns a shallow copy of this [NotificationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationLog copyWith({
    int? id,
    int? notificationId,
    _i2.Notification? notification,
    DateTime? attemptedAt,
    String? channel,
    String? status,
    String? errorMessage,
    int? retryCount,
    String? externalMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationLog',
      if (id != null) 'id': id,
      'notificationId': notificationId,
      if (notification != null) 'notification': notification?.toJson(),
      'attemptedAt': attemptedAt.toJson(),
      'channel': channel,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'retryCount': retryCount,
      if (externalMessageId != null) 'externalMessageId': externalMessageId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationLogImpl extends NotificationLog {
  _NotificationLogImpl({
    int? id,
    required int notificationId,
    _i2.Notification? notification,
    DateTime? attemptedAt,
    required String channel,
    String? status,
    String? errorMessage,
    int? retryCount,
    String? externalMessageId,
  }) : super._(
         id: id,
         notificationId: notificationId,
         notification: notification,
         attemptedAt: attemptedAt,
         channel: channel,
         status: status,
         errorMessage: errorMessage,
         retryCount: retryCount,
         externalMessageId: externalMessageId,
       );

  /// Returns a shallow copy of this [NotificationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationLog copyWith({
    Object? id = _Undefined,
    int? notificationId,
    Object? notification = _Undefined,
    DateTime? attemptedAt,
    String? channel,
    String? status,
    Object? errorMessage = _Undefined,
    int? retryCount,
    Object? externalMessageId = _Undefined,
  }) {
    return NotificationLog(
      id: id is int? ? id : this.id,
      notificationId: notificationId ?? this.notificationId,
      notification: notification is _i2.Notification?
          ? notification
          : this.notification?.copyWith(),
      attemptedAt: attemptedAt ?? this.attemptedAt,
      channel: channel ?? this.channel,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      retryCount: retryCount ?? this.retryCount,
      externalMessageId: externalMessageId is String?
          ? externalMessageId
          : this.externalMessageId,
    );
  }
}
