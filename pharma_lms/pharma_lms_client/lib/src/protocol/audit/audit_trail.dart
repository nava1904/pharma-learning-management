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

/// Immutable audit trail - append-only, no updates/deletes. FDA 21 CFR Part 11.
abstract class AuditTrail implements _i1.SerializableModel {
  AuditTrail._({
    this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    this.oldValueJson,
    this.newValueJson,
    DateTime? timestamp,
    this.userId,
    this.user,
    this.reason,
    this.ipAddress,
  }) : timestamp = timestamp ?? DateTime.now();

  factory AuditTrail({
    int? id,
    required String entityType,
    required String entityId,
    required String action,
    String? oldValueJson,
    String? newValueJson,
    DateTime? timestamp,
    int? userId,
    _i2.PharmaUser? user,
    String? reason,
    String? ipAddress,
  }) = _AuditTrailImpl;

  factory AuditTrail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditTrail(
      id: jsonSerialization['id'] as int?,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String,
      action: jsonSerialization['action'] as String,
      oldValueJson: jsonSerialization['oldValueJson'] as String?,
      newValueJson: jsonSerialization['newValueJson'] as String?,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      userId: jsonSerialization['userId'] as int?,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      reason: jsonSerialization['reason'] as String?,
      ipAddress: jsonSerialization['ipAddress'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Entity type (e.g., course, training_record, document).
  String entityType;

  /// Entity ID.
  String entityId;

  /// Action performed (create, update, delete, approve).
  String action;

  /// Old value as JSON before change.
  String? oldValueJson;

  /// New value as JSON after change.
  String? newValueJson;

  /// Timestamp of the action.
  DateTime timestamp;

  int? userId;

  /// User who performed the action.
  _i2.PharmaUser? user;

  /// Reason for change (required for certain actions).
  String? reason;

  /// IP address.
  String? ipAddress;

  /// Returns a shallow copy of this [AuditTrail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditTrail copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? action,
    String? oldValueJson,
    String? newValueJson,
    DateTime? timestamp,
    int? userId,
    _i2.PharmaUser? user,
    String? reason,
    String? ipAddress,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditTrail',
      if (id != null) 'id': id,
      'entityType': entityType,
      'entityId': entityId,
      'action': action,
      if (oldValueJson != null) 'oldValueJson': oldValueJson,
      if (newValueJson != null) 'newValueJson': newValueJson,
      'timestamp': timestamp.toJson(),
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (reason != null) 'reason': reason,
      if (ipAddress != null) 'ipAddress': ipAddress,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditTrailImpl extends AuditTrail {
  _AuditTrailImpl({
    int? id,
    required String entityType,
    required String entityId,
    required String action,
    String? oldValueJson,
    String? newValueJson,
    DateTime? timestamp,
    int? userId,
    _i2.PharmaUser? user,
    String? reason,
    String? ipAddress,
  }) : super._(
         id: id,
         entityType: entityType,
         entityId: entityId,
         action: action,
         oldValueJson: oldValueJson,
         newValueJson: newValueJson,
         timestamp: timestamp,
         userId: userId,
         user: user,
         reason: reason,
         ipAddress: ipAddress,
       );

  /// Returns a shallow copy of this [AuditTrail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditTrail copyWith({
    Object? id = _Undefined,
    String? entityType,
    String? entityId,
    String? action,
    Object? oldValueJson = _Undefined,
    Object? newValueJson = _Undefined,
    DateTime? timestamp,
    Object? userId = _Undefined,
    Object? user = _Undefined,
    Object? reason = _Undefined,
    Object? ipAddress = _Undefined,
  }) {
    return AuditTrail(
      id: id is int? ? id : this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      oldValueJson: oldValueJson is String? ? oldValueJson : this.oldValueJson,
      newValueJson: newValueJson is String? ? newValueJson : this.newValueJson,
      timestamp: timestamp ?? this.timestamp,
      userId: userId is int? ? userId : this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      reason: reason is String? ? reason : this.reason,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
    );
  }
}
