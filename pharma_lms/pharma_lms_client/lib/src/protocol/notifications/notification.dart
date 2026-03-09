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
import '../organization/user.dart' as _i2;
import '../training/enrollment.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Notification record for delivery tracking. GMP.
abstract class Notification implements _i1.SerializableModel {
  Notification._({
    this.id,
    required this.userId,
    this.user,
    required this.type,
    this.enrollmentId,
    this.enrollment,
    this.sentAt,
    this.deliveryStatus,
    this.readAt,
    String? channel,
    DateTime? createdAt,
  }) : channel = channel ?? 'in_app',
       createdAt = createdAt ?? DateTime.now();

  factory Notification({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String type,
    int? enrollmentId,
    _i3.Enrollment? enrollment,
    DateTime? sentAt,
    String? deliveryStatus,
    DateTime? readAt,
    String? channel,
    DateTime? createdAt,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      type: jsonSerialization['type'] as String,
      enrollmentId: jsonSerialization['enrollmentId'] as int?,
      enrollment: jsonSerialization['enrollment'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Enrollment>(
              jsonSerialization['enrollment'],
            ),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      deliveryStatus: jsonSerialization['deliveryStatus'] as String?,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      channel: jsonSerialization['channel'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user to notify.
  _i2.PharmaUser? user;

  /// Type: assignment, reminder_30d, reminder_14d, reminder_7d, reminder_3d, overdue, cert_expiry, cert_expiry_90d, cert_expiry_60d, cert_expiry_30d, cert_expiry_7d, cert_expired, compliance_alert.
  String type;

  int? enrollmentId;

  /// Enrollment this notification relates to.
  _i3.Enrollment? enrollment;

  /// When sent.
  DateTime? sentAt;

  /// Delivery status: sent, failed, bounced.
  String? deliveryStatus;

  /// When read (in-app).
  DateTime? readAt;

  /// Channel: email, in_app, sms.
  String channel;

  /// When created.
  DateTime createdAt;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? type,
    int? enrollmentId,
    _i3.Enrollment? enrollment,
    DateTime? sentAt,
    String? deliveryStatus,
    DateTime? readAt,
    String? channel,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'type': type,
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (deliveryStatus != null) 'deliveryStatus': deliveryStatus,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'channel': channel,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String type,
    int? enrollmentId,
    _i3.Enrollment? enrollment,
    DateTime? sentAt,
    String? deliveryStatus,
    DateTime? readAt,
    String? channel,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         type: type,
         enrollmentId: enrollmentId,
         enrollment: enrollment,
         sentAt: sentAt,
         deliveryStatus: deliveryStatus,
         readAt: readAt,
         channel: channel,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? type,
    Object? enrollmentId = _Undefined,
    Object? enrollment = _Undefined,
    Object? sentAt = _Undefined,
    Object? deliveryStatus = _Undefined,
    Object? readAt = _Undefined,
    String? channel,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      type: type ?? this.type,
      enrollmentId: enrollmentId is int? ? enrollmentId : this.enrollmentId,
      enrollment: enrollment is _i3.Enrollment?
          ? enrollment
          : this.enrollment?.copyWith(),
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      deliveryStatus: deliveryStatus is String?
          ? deliveryStatus
          : this.deliveryStatus,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      channel: channel ?? this.channel,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
