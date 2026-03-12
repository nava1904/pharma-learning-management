# SSO OIDC Integration Guide

Pharma LMS uses Serverpod auth. There is no dedicated serverpod_auth_idp_oidc package.
Use the built-in OAuth2 PKCE utilities in serverpod_auth_idp_server to implement OIDC.

## Integration Points

1. Server: Create OIDC Idp endpoint extending IdpBaseEndpoint using OAuth2PkceServerConfig
2. Register in server.dart identityProviderBuilders
3. Client: Use OAuth2PkceUtil from serverpod_auth_idp_flutter
4. OIDC UserInfo: Call provider userinfo endpoint after token exchange
5. passwords.yaml: oidcClientId, oidcClientSecret
6. Web: auth.html callback for OAuth redirect
7. MFA: Works with OIDC - getMfaStatus/verifyMfa apply after OIDC login

## References

- docs.serverpod.dev/concepts/authentication/providers/custom-providers/oauth2-utility/setup
- GitHub IDP as reference implementation
