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

/// OIDC client config for Flutter (authorization endpoint, client ID, redirect URI).
/// Returned when SSO is configured. Null/empty when not configured.
abstract class OidcClientConfig implements _i1.SerializableModel {
  OidcClientConfig._({
    required this.enabled,
    this.authorizationEndpoint,
    this.clientId,
    this.redirectUri,
  });

  factory OidcClientConfig({
    required bool enabled,
    String? authorizationEndpoint,
    String? clientId,
    String? redirectUri,
  }) = _OidcClientConfigImpl;

  factory OidcClientConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return OidcClientConfig(
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      authorizationEndpoint:
          jsonSerialization['authorizationEndpoint'] as String?,
      clientId: jsonSerialization['clientId'] as String?,
      redirectUri: jsonSerialization['redirectUri'] as String?,
    );
  }

  /// Whether OIDC SSO is enabled.
  bool enabled;

  /// OIDC authorization endpoint URL (from discovery).
  String? authorizationEndpoint;

  /// OAuth client ID (public, safe to send to client).
  String? clientId;

  /// Redirect URI for OAuth callback.
  String? redirectUri;

  /// Returns a shallow copy of this [OidcClientConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OidcClientConfig copyWith({
    bool? enabled,
    String? authorizationEndpoint,
    String? clientId,
    String? redirectUri,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OidcClientConfig',
      'enabled': enabled,
      if (authorizationEndpoint != null)
        'authorizationEndpoint': authorizationEndpoint,
      if (clientId != null) 'clientId': clientId,
      if (redirectUri != null) 'redirectUri': redirectUri,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OidcClientConfigImpl extends OidcClientConfig {
  _OidcClientConfigImpl({
    required bool enabled,
    String? authorizationEndpoint,
    String? clientId,
    String? redirectUri,
  }) : super._(
         enabled: enabled,
         authorizationEndpoint: authorizationEndpoint,
         clientId: clientId,
         redirectUri: redirectUri,
       );

  /// Returns a shallow copy of this [OidcClientConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OidcClientConfig copyWith({
    bool? enabled,
    Object? authorizationEndpoint = _Undefined,
    Object? clientId = _Undefined,
    Object? redirectUri = _Undefined,
  }) {
    return OidcClientConfig(
      enabled: enabled ?? this.enabled,
      authorizationEndpoint: authorizationEndpoint is String?
          ? authorizationEndpoint
          : this.authorizationEndpoint,
      clientId: clientId is String? ? clientId : this.clientId,
      redirectUri: redirectUri is String? ? redirectUri : this.redirectUri,
    );
  }
}
