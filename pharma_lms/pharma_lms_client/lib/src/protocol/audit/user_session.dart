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

/// User session for login tracking. FDA 21 CFR Part 11.
abstract class UserSession implements _i1.SerializableModel {
  UserSession._({
    this.id,
    required this.userId,
    this.user,
    DateTime? startedAt,
    this.endedAt,
    this.ipAddress,
    this.userAgent,
    this.deviceFingerprint,
    this.endReason,
    bool? isMfaVerified,
  }) : startedAt = startedAt ?? DateTime.now(),
       isMfaVerified = isMfaVerified ?? false;

  factory UserSession({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? ipAddress,
    String? userAgent,
    String? deviceFingerprint,
    String? endReason,
    bool? isMfaVerified,
  }) = _UserSessionImpl;

  factory UserSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      deviceFingerprint: jsonSerialization['deviceFingerprint'] as String?,
      endReason: jsonSerialization['endReason'] as String?,
      isMfaVerified: jsonSerialization['isMfaVerified'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMfaVerified']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  /// When session started.
  DateTime startedAt;

  /// When session ended.
  DateTime? endedAt;

  /// IP address at login.
  String? ipAddress;

  /// User agent string.
  String? userAgent;

  /// Device fingerprint.
  String? deviceFingerprint;

  /// How session ended: manual_logout, timeout, admin_revoke.
  String? endReason;

  /// Whether MFA was verified.
  bool isMfaVerified;

  /// Returns a shallow copy of this [UserSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSession copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? ipAddress,
    String? userAgent,
    String? deviceFingerprint,
    String? endReason,
    bool? isMfaVerified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSession',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (deviceFingerprint != null) 'deviceFingerprint': deviceFingerprint,
      if (endReason != null) 'endReason': endReason,
      'isMfaVerified': isMfaVerified,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSessionImpl extends UserSession {
  _UserSessionImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? ipAddress,
    String? userAgent,
    String? deviceFingerprint,
    String? endReason,
    bool? isMfaVerified,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         startedAt: startedAt,
         endedAt: endedAt,
         ipAddress: ipAddress,
         userAgent: userAgent,
         deviceFingerprint: deviceFingerprint,
         endReason: endReason,
         isMfaVerified: isMfaVerified,
       );

  /// Returns a shallow copy of this [UserSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSession copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    Object? deviceFingerprint = _Undefined,
    Object? endReason = _Undefined,
    bool? isMfaVerified,
  }) {
    return UserSession(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      deviceFingerprint: deviceFingerprint is String?
          ? deviceFingerprint
          : this.deviceFingerprint,
      endReason: endReason is String? ? endReason : this.endReason,
      isMfaVerified: isMfaVerified ?? this.isMfaVerified,
    );
  }
}
