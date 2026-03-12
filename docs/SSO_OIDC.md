# SSO OIDC Integration Guide

Pharma LMS uses Serverpod auth. There is no dedicated `serverpod_auth_idp_oidc` package on pub.dev. Use the built-in OAuth2 PKCE utilities in `serverpod_auth_idp_server` to implement OIDC (OpenID Connect) with providers such as Auth0, Okta, and Azure AD.

## Implemented OIDC SSO

Pharma LMS includes a custom OIDC identity provider using OAuth2 PKCE utilities. Configure in `passwords.yaml`:

```yaml
oidcClientId: 'your-client-id'
oidcClientSecret: 'your-client-secret'
oidcDiscoveryUrl: 'https://your-provider/.well-known/openid-configuration'
oidcRedirectUri: 'https://your-app/app/auth.html'  # Web: /app/auth.html
```

- **Server**: `OidcIdpEndpoint`, `OidcIdp`, `OidcAccount` table
- **Client**: `OidcSignInWidget` on login screen; "Sign in with SSO" when configured
- **Web callback**: `web/auth.html` (flutter_web_auth_2)

## Current Integration (OAuth2 Utilities)

Until a dedicated OIDC package exists, use the generic OAuth2 utilities:

### 1. Server-Side

- **OAuth2PkceUtil** in `serverpod_auth_idp_server` for exchanging authorization codes
- Create a custom Idp endpoint extending `IdpBaseEndpoint` with `OAuth2PkceServerConfig`
- OIDC providers (Auth0, Okta, Azure AD) are OAuth2-compliant; use their authorization and token endpoints

### 2. Provider-Specific Endpoints

| Provider   | Discovery URL (replace {tenant})           | Notes                    |
|-----------|---------------------------------------------|--------------------------|
| Auth0     | `https://{domain}/.well-known/openid-configuration` | Use your Auth0 domain    |
| Okta      | `https://{org}.okta.com/.well-known/openid-configuration` | Use your Okta org        |
| Azure AD  | `https://login.microsoftonline.com/{tenant}/v2.0/.well-known/openid-configuration` | tenant = common or GUID |

### 3. Configuration (passwords.yaml)

```yaml
oidcClientId: 'your-client-id'
oidcClientSecret: 'your-client-secret'
oidcDiscoveryUrl: 'https://your-provider/.well-known/openid-configuration'
oidcRedirectUri: 'https://your-app/api/oidc/callback'
```

### 4. Client-Side

- Use `OAuth2PkceUtil` from `serverpod_auth_idp_flutter` for the authorization flow
- After token exchange, call the provider's UserInfo endpoint to get user claims (sub, email, name)
- Map OIDC claims to Serverpod user fields

### 5. Web Callback

- Add `auth.html` or equivalent callback route for OAuth redirect
- Handle `code` and `state` query parameters, complete PKCE exchange

### 6. MFA Compatibility

- MFA (getMfaStatus, verifyMfa) works with OIDC; apply after OIDC login completes

## References

- [Serverpod OAuth2 Utility Setup](https://docs.serverpod.dev/concepts/authentication/providers/custom-providers/oauth2-utility/setup)
- [GitHub IDP](https://github.com/serverpod/serverpod/tree/main/modules/auth_idp_server) as reference implementation
- [OIDC Core Spec](https://openid.net/specs/openid-connect-core-1_0.html)
