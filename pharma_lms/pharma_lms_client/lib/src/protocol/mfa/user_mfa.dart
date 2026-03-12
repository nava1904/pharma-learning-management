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

/// MFA settings for a user. Links to serverpod auth user by UUID.
abstract class UserMfa implements _i1.SerializableModel {
  UserMfa._({
    this.id,
    required this.authUserId,
    required this.mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  }) : mfaEnabled = mfaEnabled ?? false,
       enrolledAt = enrolledAt ?? DateTime.now();

  factory UserMfa({
    int? id,
    required String authUserId,
    required String mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  }) = _UserMfaImpl;

  factory UserMfa.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserMfa(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      mfaSecretBase32: jsonSerialization['mfaSecretBase32'] as String,
      mfaEnabled: jsonSerialization['mfaEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['mfaEnabled']),
      enrolledAt: jsonSerialization['enrolledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['enrolledAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Serverpod auth user ID (UUID).
  String authUserId;

  /// Base32-encoded TOTP secret.
  String mfaSecretBase32;

  /// Whether MFA is enabled for this user.
  bool mfaEnabled;

  /// When MFA was enrolled.
  DateTime? enrolledAt;

  /// Returns a shallow copy of this [UserMfa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserMfa copyWith({
    int? id,
    String? authUserId,
    String? mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserMfa',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'mfaSecretBase32': mfaSecretBase32,
      'mfaEnabled': mfaEnabled,
      if (enrolledAt != null) 'enrolledAt': enrolledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserMfaImpl extends UserMfa {
  _UserMfaImpl({
    int? id,
    required String authUserId,
    required String mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         mfaSecretBase32: mfaSecretBase32,
         mfaEnabled: mfaEnabled,
         enrolledAt: enrolledAt,
       );

  /// Returns a shallow copy of this [UserMfa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserMfa copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? mfaSecretBase32,
    bool? mfaEnabled,
    Object? enrolledAt = _Undefined,
  }) {
    return UserMfa(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      mfaSecretBase32: mfaSecretBase32 ?? this.mfaSecretBase32,
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      enrolledAt: enrolledAt is DateTime? ? enrolledAt : this.enrolledAt,
    );
  }
}
