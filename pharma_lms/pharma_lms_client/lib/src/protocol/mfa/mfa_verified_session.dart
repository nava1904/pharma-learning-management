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

/// Tracks MFA verification for a session. Used to allow access after TOTP verification.
abstract class MfaVerifiedSession implements _i1.SerializableModel {
  MfaVerifiedSession._({
    this.id,
    required this.authUserId,
    required this.sessionId,
    DateTime? verifiedAt,
  }) : verifiedAt = verifiedAt ?? DateTime.now();

  factory MfaVerifiedSession({
    int? id,
    required String authUserId,
    required String sessionId,
    DateTime? verifiedAt,
  }) = _MfaVerifiedSessionImpl;

  factory MfaVerifiedSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return MfaVerifiedSession(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      sessionId: jsonSerialization['sessionId'] as String,
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Serverpod auth user ID (UUID).
  String authUserId;

  /// Session identifier (e.g. JWT jti or device fingerprint).
  String sessionId;

  /// When TOTP was verified.
  DateTime verifiedAt;

  /// Returns a shallow copy of this [MfaVerifiedSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MfaVerifiedSession copyWith({
    int? id,
    String? authUserId,
    String? sessionId,
    DateTime? verifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MfaVerifiedSession',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'sessionId': sessionId,
      'verifiedAt': verifiedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MfaVerifiedSessionImpl extends MfaVerifiedSession {
  _MfaVerifiedSessionImpl({
    int? id,
    required String authUserId,
    required String sessionId,
    DateTime? verifiedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         sessionId: sessionId,
         verifiedAt: verifiedAt,
       );

  /// Returns a shallow copy of this [MfaVerifiedSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MfaVerifiedSession copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? sessionId,
    DateTime? verifiedAt,
  }) {
    return MfaVerifiedSession(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      sessionId: sessionId ?? this.sessionId,
      verifiedAt: verifiedAt ?? this.verifiedAt,
    );
  }
}
