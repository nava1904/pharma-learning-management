import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod_auth_idp_server/core.dart';

import 'oidc_idp.dart';

/// OIDC identity provider configuration. Fetches token/userinfo endpoints
/// from discovery URL (Auth0, Okta, Azure AD).
class OidcIdpConfig extends IdentityProviderBuilder<OidcIdp> {
  OidcIdpConfig({
    required this.clientId,
    required this.clientSecret,
    required this.discoveryUrl,
    required this.redirectUri,
  });

  final String clientId;
  final String clientSecret;
  final String discoveryUrl;
  final String redirectUri;

  OAuth2PkceServerConfig? _oauth2Config;
  String? _userinfoEndpoint;
  String? _authorizationEndpoint;

  /// Fetches OIDC discovery document and builds OAuth2 config.
  Future<void> _ensureDiscovery() async {
    if (_oauth2Config != null) return;
    final uri = Uri.parse(discoveryUrl);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw OidcConfigException('Failed to fetch OIDC discovery: ${response.statusCode}');
    }
    final doc = jsonDecode(response.body) as Map<String, dynamic>;
    final tokenEndpoint = doc['token_endpoint'] as String?;
    _userinfoEndpoint = doc['userinfo_endpoint'] as String?;
    _authorizationEndpoint = doc['authorization_endpoint'] as String?;
    if (tokenEndpoint == null || tokenEndpoint.isEmpty) {
      throw OidcConfigException('OIDC discovery missing token_endpoint');
    }
    _oauth2Config = OAuth2PkceServerConfig(
      tokenEndpointUrl: Uri.parse(tokenEndpoint),
      clientId: clientId,
      clientSecret: clientSecret,
      credentialsLocation: OAuth2CredentialsLocation.header,
      parseTokenResponse: _parseTokenResponse,
    );
  }

  OAuth2PkceServerConfig get oauth2Config {
    if (_oauth2Config == null) {
      throw StateError(
        'OidcIdpConfig not initialized. Call ensureDiscovery() before use.',
      );
    }
    return _oauth2Config!;
  }

  String get userinfoEndpoint {
    if (_userinfoEndpoint == null) {
      throw StateError(
        'OidcIdpConfig not initialized. Call ensureDiscovery() before use.',
      );
    }
    return _userinfoEndpoint!;
  }

  String? get authorizationEndpoint => _authorizationEndpoint;

  Future<void> ensureDiscovery() => _ensureDiscovery();

  static OAuth2PkceTokenResponse _parseTokenResponse(Map<String, dynamic> response) {
    final error = response['error'] as String?;
    if (error != null) {
      final description = response['error_description'] as String?;
      throw OAuth2InvalidResponseException(
        'OIDC error: $error${description != null ? ' - $description' : ''}',
      );
    }
    final token = response['access_token'] as String?;
    if (token == null) {
      throw const OAuth2MissingAccessTokenException('No access token in OIDC response');
    }
    return OAuth2PkceTokenResponse(accessToken: token);
  }

  @override
  OidcIdp build({
    required TokenManager tokenManager,
    required AuthUsers authUsers,
    required UserProfiles userProfiles,
  }) {
    return OidcIdp(
      config: this,
      tokenIssuer: tokenManager,
      authUsers: authUsers,
      userProfiles: userProfiles,
    );
  }
}

class OidcConfigException implements Exception {
  OidcConfigException(this.message);
  final String message;
  @override
  String toString() => 'OidcConfigException: $message';
}
