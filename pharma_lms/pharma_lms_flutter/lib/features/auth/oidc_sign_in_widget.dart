import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// Sign-in button for OIDC SSO (Auth0, Okta, Azure AD).
/// Only visible when OIDC is configured on the server.
class OidcSignInWidget extends StatefulWidget {
  const OidcSignInWidget({
    required this.onAuthenticated,
    this.onError,
    super.key,
  });

  final VoidCallback onAuthenticated;
  final void Function(Object error)? onError;

  @override
  State<OidcSignInWidget> createState() => _OidcSignInWidgetState();
}

class _OidcSignInWidgetState extends State<OidcSignInWidget> {
  OidcClientConfig? _config;
  bool _loading = true;
  bool _signingIn = false;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    try {
      final config = await client.oidcIdp.getClientConfig();
      if (mounted) {
        setState(() {
          _config = config;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _config = OidcClientConfig(enabled: false);
          _loading = false;
        });
      }
    }
  }

  Future<void> _signInWithOidc() async {
    final config = _config;
    if (config == null ||
        !config.enabled ||
        config.authorizationEndpoint == null ||
        config.clientId == null ||
        config.redirectUri == null) {
      return;
    }
    setState(() => _signingIn = true);
    try {
      final oauth2Config = OAuth2PkceProviderClientConfig(
        authorizationEndpoint: Uri.parse(config.authorizationEndpoint!),
        clientId: config.clientId!,
        redirectUri: config.redirectUri!,
        callbackUrlScheme: Uri.parse(config.redirectUri!).scheme,
        defaultScopes: ['openid', 'profile', 'email'],
      );
      final oauth2Util = OAuth2PkceUtil(config: oauth2Config);
      final result = await oauth2Util.authorize(
        scopes: ['openid', 'profile', 'email'],
      );
      if (result.codeVerifier == null) {
        throw Exception('PKCE verifier missing');
      }
      await client.oidcIdp.login(
        code: result.code,
        codeVerifier: result.codeVerifier!,
        redirectUri: config.redirectUri!,
      );
      if (mounted) {
        widget.onAuthenticated();
      }
    } on OAuth2PkceUserCancelledException {
      if (mounted) setState(() => _signingIn = false);
    } catch (e) {
      if (mounted) {
        setState(() => _signingIn = false);
        widget.onError?.call(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // While loading OIDC config, show nothing (no extra spinner on landing page).
    if (_loading || _config == null || !_config!.enabled) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _signingIn ? null : _signInWithOidc,
        icon: _signingIn
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.login, size: 20),
        label: Text(_signingIn ? 'Signing in...' : 'Sign in with SSO'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.slate700,
          side: const BorderSide(color: AppColors.slate300),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
