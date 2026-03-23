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
import '../organization/role.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Append-only role history for revocations and grants
abstract class RoleHistory implements _i1.SerializableModel {
  RoleHistory._({
    this.id,
    required this.userId,
    this.user,
    required this.roleId,
    this.role,
    required this.action,
    DateTime? timestamp,
    this.performedById,
    this.performedBy,
    this.reason,
    this.grantRecordId,
    this.ipAddress,
    this.hmacHash,
    this.migrationMarker,
  }) : timestamp = timestamp ?? DateTime.now();

  factory RoleHistory({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    required String action,
    DateTime? timestamp,
    int? performedById,
    _i2.PharmaUser? performedBy,
    String? reason,
    int? grantRecordId,
    String? ipAddress,
    String? hmacHash,
    String? migrationMarker,
  }) = _RoleHistoryImpl;

  factory RoleHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoleHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Role>(jsonSerialization['role']),
      action: jsonSerialization['action'] as String,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      performedById: jsonSerialization['performedById'] as int?,
      performedBy: jsonSerialization['performedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['performedBy'],
            ),
      reason: jsonSerialization['reason'] as String?,
      grantRecordId: jsonSerialization['grantRecordId'] as int?,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      hmacHash: jsonSerialization['hmacHash'] as String?,
      migrationMarker: jsonSerialization['migrationMarker'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user affected
  _i2.PharmaUser? user;

  int roleId;

  /// The role affected
  _i3.Role? role;

  /// Action (GRANTED, REVOKED)
  String action;

  /// Timestamp of the action
  DateTime timestamp;

  int? performedById;

  /// Who performed the action (admin or SYSTEM)
  _i2.PharmaUser? performedBy;

  /// Reason for the action
  String? reason;

  /// Original grant record ID (for revocations)
  int? grantRecordId;

  /// IP address
  String? ipAddress;

  /// HMAC hash for audit chain
  String? hmacHash;

  /// Temporary migration marker - remove after migration applied
  String? migrationMarker;

  /// Returns a shallow copy of this [RoleHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoleHistory copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? roleId,
    _i3.Role? role,
    String? action,
    DateTime? timestamp,
    int? performedById,
    _i2.PharmaUser? performedBy,
    String? reason,
    int? grantRecordId,
    String? ipAddress,
    String? hmacHash,
    String? migrationMarker,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoleHistory',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
      'action': action,
      'timestamp': timestamp.toJson(),
      if (performedById != null) 'performedById': performedById,
      if (performedBy != null) 'performedBy': performedBy?.toJson(),
      if (reason != null) 'reason': reason,
      if (grantRecordId != null) 'grantRecordId': grantRecordId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (hmacHash != null) 'hmacHash': hmacHash,
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoleHistoryImpl extends RoleHistory {
  _RoleHistoryImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    required String action,
    DateTime? timestamp,
    int? performedById,
    _i2.PharmaUser? performedBy,
    String? reason,
    int? grantRecordId,
    String? ipAddress,
    String? hmacHash,
    String? migrationMarker,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         roleId: roleId,
         role: role,
         action: action,
         timestamp: timestamp,
         performedById: performedById,
         performedBy: performedBy,
         reason: reason,
         grantRecordId: grantRecordId,
         ipAddress: ipAddress,
         hmacHash: hmacHash,
         migrationMarker: migrationMarker,
       );

  /// Returns a shallow copy of this [RoleHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoleHistory copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? roleId,
    Object? role = _Undefined,
    String? action,
    DateTime? timestamp,
    Object? performedById = _Undefined,
    Object? performedBy = _Undefined,
    Object? reason = _Undefined,
    Object? grantRecordId = _Undefined,
    Object? ipAddress = _Undefined,
    Object? hmacHash = _Undefined,
    Object? migrationMarker = _Undefined,
  }) {
    return RoleHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      roleId: roleId ?? this.roleId,
      role: role is _i3.Role? ? role : this.role?.copyWith(),
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      performedById: performedById is int? ? performedById : this.performedById,
      performedBy: performedBy is _i2.PharmaUser?
          ? performedBy
          : this.performedBy?.copyWith(),
      reason: reason is String? ? reason : this.reason,
      grantRecordId: grantRecordId is int? ? grantRecordId : this.grantRecordId,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      hmacHash: hmacHash is String? ? hmacHash : this.hmacHash,
      migrationMarker: migrationMarker is String?
          ? migrationMarker
          : this.migrationMarker,
    );
  }
}
