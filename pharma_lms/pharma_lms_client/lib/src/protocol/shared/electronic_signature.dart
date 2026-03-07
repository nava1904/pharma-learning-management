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

/// Electronic signature for 21 CFR Part 11 compliance.
abstract class ElectronicSignature implements _i1.SerializableModel {
  ElectronicSignature._({
    this.id,
    required this.userId,
    this.user,
    DateTime? timestamp,
    required this.signatureMeaning,
    this.passwordReauthHash,
    required this.entityType,
    required this.entityId,
    this.ipAddress,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ElectronicSignature({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? timestamp,
    required String signatureMeaning,
    String? passwordReauthHash,
    required String entityType,
    required String entityId,
    String? ipAddress,
  }) = _ElectronicSignatureImpl;

  factory ElectronicSignature.fromJson(Map<String, dynamic> jsonSerialization) {
    return ElectronicSignature(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      signatureMeaning: jsonSerialization['signatureMeaning'] as String,
      passwordReauthHash: jsonSerialization['passwordReauthHash'] as String?,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String,
      ipAddress: jsonSerialization['ipAddress'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// User who signed.
  _i2.PharmaUser? user;

  /// Timestamp of signature (NTP-synced).
  DateTime timestamp;

  /// Signature meaning: "I have read and understood", "Verification", "Approval".
  String signatureMeaning;

  /// Hash of password re-authentication (for verification).
  String? passwordReauthHash;

  /// Entity type signed (e.g., training_record, certificate).
  String entityType;

  /// Entity ID signed.
  String entityId;

  /// IP address at time of signature.
  String? ipAddress;

  /// Returns a shallow copy of this [ElectronicSignature]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ElectronicSignature copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    DateTime? timestamp,
    String? signatureMeaning,
    String? passwordReauthHash,
    String? entityType,
    String? entityId,
    String? ipAddress,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ElectronicSignature',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'timestamp': timestamp.toJson(),
      'signatureMeaning': signatureMeaning,
      if (passwordReauthHash != null) 'passwordReauthHash': passwordReauthHash,
      'entityType': entityType,
      'entityId': entityId,
      if (ipAddress != null) 'ipAddress': ipAddress,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ElectronicSignatureImpl extends ElectronicSignature {
  _ElectronicSignatureImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? timestamp,
    required String signatureMeaning,
    String? passwordReauthHash,
    required String entityType,
    required String entityId,
    String? ipAddress,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         timestamp: timestamp,
         signatureMeaning: signatureMeaning,
         passwordReauthHash: passwordReauthHash,
         entityType: entityType,
         entityId: entityId,
         ipAddress: ipAddress,
       );

  /// Returns a shallow copy of this [ElectronicSignature]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ElectronicSignature copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    DateTime? timestamp,
    String? signatureMeaning,
    Object? passwordReauthHash = _Undefined,
    String? entityType,
    String? entityId,
    Object? ipAddress = _Undefined,
  }) {
    return ElectronicSignature(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      timestamp: timestamp ?? this.timestamp,
      signatureMeaning: signatureMeaning ?? this.signatureMeaning,
      passwordReauthHash: passwordReauthHash is String?
          ? passwordReauthHash
          : this.passwordReauthHash,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
    );
  }
}
