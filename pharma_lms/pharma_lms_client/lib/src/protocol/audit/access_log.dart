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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Access log for login, session, and access tracking.
abstract class AccessLog implements _i1.SerializableModel {
  AccessLog._({
    this.id,
    this.userId,
    this.user,
    required this.action,
    this.ipAddress,
    this.userAgent,
    DateTime? timestamp,
    bool? success,
  }) : timestamp = timestamp ?? DateTime.now(),
       success = success ?? true;

  factory AccessLog({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    required String action,
    String? ipAddress,
    String? userAgent,
    DateTime? timestamp,
    bool? success,
  }) = _AccessLogImpl;

  factory AccessLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      action: jsonSerialization['action'] as String,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      success: jsonSerialization['success'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? userId;

  /// User who accessed (nullable for failed login).
  _i2.PharmaUser? user;

  /// Action (login, logout, session_timeout).
  String action;

  /// IP address.
  String? ipAddress;

  /// User agent string.
  String? userAgent;

  /// Timestamp.
  DateTime timestamp;

  /// Whether the action succeeded.
  bool success;

  /// Returns a shallow copy of this [AccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessLog copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? action,
    String? ipAddress,
    String? userAgent,
    DateTime? timestamp,
    bool? success,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'action': action,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'timestamp': timestamp.toJson(),
      'success': success,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessLogImpl extends AccessLog {
  _AccessLogImpl({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    required String action,
    String? ipAddress,
    String? userAgent,
    DateTime? timestamp,
    bool? success,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         action: action,
         ipAddress: ipAddress,
         userAgent: userAgent,
         timestamp: timestamp,
         success: success,
       );

  /// Returns a shallow copy of this [AccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    Object? user = _Undefined,
    String? action,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    DateTime? timestamp,
    bool? success,
  }) {
    return AccessLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      action: action ?? this.action,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      timestamp: timestamp ?? this.timestamp,
      success: success ?? this.success,
    );
  }
}
