import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/auth/oidc_idp_config.dart';
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/services/email_service.dart';
import 'src/services/password_policy_service.dart';
import 'src/web/routes/api_proxy_route.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/metrics_route.dart';
import 'src/web/routes/root.dart';

const _apiEndpointPaths = [
  'emailIdp', 'jwtRefresh', 'oidcIdp', 'admin', 'analytics', 'assessmentBuilder',
  'assessment', 'audit', 'compliance', 'courseBuilder', 'course',
  'document', 'event', 'material', 'mfa', 'notification', 'organization',
  'qa', 'qualityEvent', 'seed', 'training', 'user', 'greeting',
  'validation',
];

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      // Session timeout: access token 15 min (21 CFR Part 11), refresh 7 days.
      JwtConfigFromPasswords(
        accessTokenLifetime: Duration(minutes: 15),
        refreshTokenLifetime: Duration(days: 7),
      ),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      // Password policy: min 12 chars, uppercase, lowercase, digit, special (21 CFR Part 11).
      // Serverpod uses Argon2id for hashing (OWASP-recommended).
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
        passwordValidationFunction: PasswordPolicyService.passwordValidationFunction,
      ),
      // OIDC SSO (Auth0, Okta, Azure AD). Add when oidcDiscoveryUrl etc. in passwords.yaml.
      // See docs/SSO_OIDC.md for integration instructions.
      ..._buildOidcProvider(pod),
    ],
  );

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // Prometheus /metrics for request_count and request_latency_seconds
  pod.webServer.addRoute(MetricsRoute(), '/metrics');

  // Serve all files in the web/static relative directory under /.
  // These are used by the default web page.
  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  // API proxy: forward API requests to the API server for same-origin requests.
  // Supports both /api/* (e.g. /api/seed) and root-level paths (e.g. /seed) for
  // Flutter dev server (localhost:port) and production (localhost:8082/app).
  final apiProxy = ApiProxyRoute(apiBaseUrl: apiUrlFromConfig(pod.config.apiServer));
  pod.webServer.addRoute(apiProxy, 'api');
  for (final name in _apiEndpointPaths) {
    pod.webServer.addRoute(apiProxy, name);
  }

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app. Uses web server + /api/ for same-origin when served from web.
  pod.webServer.addRoute(
    AppConfigRoute(
      apiConfig: pod.config.apiServer,
      webConfig: pod.config.webServer,
    ),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // Start the server.
  await pod.start();

  // Schedule failed-login lockout worker (21 CFR Part 11: lock after 5 attempts).
  // Self-reschedules every minute.
  pod.endpoints.futureCalls
      ?.callWithDelay(Duration.zero)
      .failedLoginLockoutWorker
      .run();

  // Schedule retention archival worker (audit_trail 7 years, etc.).
  // Self-reschedules daily.
  pod.endpoints.futureCalls
      ?.callWithDelay(Duration.zero)
      .retentionArchivalWorker
      .run();

  // Schedule outbox processor (transactional outbox -> Kafka).
  // Self-reschedules every 45 seconds.
  pod.endpoints.futureCalls
      ?.callWithDelay(Duration.zero)
      .kafkaEventProcessor
      .processOutbox();
}

List<IdentityProviderBuilder> _buildOidcProvider(Serverpod pod) {
  final discoveryUrl = pod.getPassword('oidcDiscoveryUrl');
  final clientId = pod.getPassword('oidcClientId');
  final clientSecret = pod.getPassword('oidcClientSecret');
  final redirectUri = pod.getPassword('oidcRedirectUri');
  if (discoveryUrl == null ||
      discoveryUrl.isEmpty ||
      clientId == null ||
      clientId.isEmpty ||
      clientSecret == null ||
      clientSecret.isEmpty ||
      redirectUri == null ||
      redirectUri.isEmpty) {
    return [];
  }
  return [
    OidcIdpConfig(
      clientId: clientId,
      clientSecret: clientSecret,
      discoveryUrl: discoveryUrl,
      redirectUri: redirectUri,
    ),
  ];
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  EmailService.sendRegistrationCode(
    session,
    email: email,
    verificationCode: verificationCode,
  );
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  EmailService.sendPasswordResetCode(
    session,
    email: email,
    verificationCode: verificationCode,
  );
}
