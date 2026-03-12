import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'oidc_idp.dart';
import 'oidc_idp_config.dart';

/// OIDC identity provider endpoint. Supports Auth0, Okta, Azure AD.
class OidcIdpEndpoint extends IdpBaseEndpoint {
  OidcIdp get oidcIdp => AuthServices.getIdentityProvider<OidcIdp>();

  @override
  Future<bool> hasAccount(Session session) async {
    final authUserId = session.authenticated?.userIdentifier;
    if (authUserId == null) return false;
    final account = await OidcAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return account != null;
  }

  /// Returns OIDC client config for Flutter when SSO is configured.
  /// Call this to get authorization endpoint, client ID, redirect URI.
  Future<OidcClientConfig> getClientConfig(Session session) async {
    try {
      final idp = oidcIdp;
      await idp.config.ensureDiscovery();
      final authEndpoint = idp.config.authorizationEndpoint;
      if (authEndpoint == null || authEndpoint.isEmpty) {
        return OidcClientConfig(enabled: false);
      }
      return OidcClientConfig(
        enabled: true,
        authorizationEndpoint: authEndpoint,
        clientId: idp.config.clientId,
        redirectUri: idp.config.redirectUri,
      );
    } catch (_) {
      return OidcClientConfig(enabled: false);
    }
  }

  Future<AuthSuccess> login(
    Session session, {
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) async {
    try {
      return await oidcIdp.login(
        session,
        code: code,
        codeVerifier: codeVerifier,
        redirectUri: redirectUri,
      );
    } on OAuth2Exception catch (e) {
      session.log(
        'OIDC OAuth2 error: ${e.message}',
        level: LogLevel.error,
      );
      throw Exception('Authentication failed');
    } on OidcAuthException catch (e) {
      session.log('OIDC error: ${e.message}', level: LogLevel.error);
      throw Exception('Authentication failed');
    } on OidcConfigException catch (e) {
      session.log('OIDC config error: ${e.message}', level: LogLevel.error);
      throw Exception('SSO configuration error');
    }
  }
}
