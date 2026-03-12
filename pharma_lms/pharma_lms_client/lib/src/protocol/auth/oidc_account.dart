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

/// OIDC provider account. Links to serverpod auth user by UUID.
/// Supports Auth0, Okta, Azure AD via OIDC discovery.
abstract class OidcAccount implements _i1.SerializableModel {
  OidcAccount._({
    this.id,
    required this.authUserId,
    required this.providerId,
    this.email,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OidcAccount({
    int? id,
    required String authUserId,
    required String providerId,
    String? email,
    DateTime? createdAt,
  }) = _OidcAccountImpl;

  factory OidcAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return OidcAccount(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      providerId: jsonSerialization['providerId'] as String,
      email: jsonSerialization['email'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Serverpod auth user ID (UUID).
  String authUserId;

  /// OIDC provider subject (sub claim).
  String providerId;

  /// User email from OIDC userinfo.
  String? email;

  /// Creation timestamp.
  DateTime createdAt;

  /// Returns a shallow copy of this [OidcAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OidcAccount copyWith({
    int? id,
    String? authUserId,
    String? providerId,
    String? email,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OidcAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'providerId': providerId,
      if (email != null) 'email': email,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OidcAccountImpl extends OidcAccount {
  _OidcAccountImpl({
    int? id,
    required String authUserId,
    required String providerId,
    String? email,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         providerId: providerId,
         email: email,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OidcAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OidcAccount copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? providerId,
    Object? email = _Undefined,
    DateTime? createdAt,
  }) {
    return OidcAccount(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      providerId: providerId ?? this.providerId,
      email: email is String? ? email : this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
