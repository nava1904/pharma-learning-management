import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/web/routes/api_proxy_route.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

const _apiEndpointPaths = [
  'emailIdp', 'jwtRefresh', 'admin', 'analytics', 'assessmentBuilder',
  'assessment', 'audit', 'compliance', 'courseBuilder', 'course',
  'document', 'event', 'material', 'notification', 'organization',
  'qa', 'qualityEvent', 'seed', 'training', 'user', 'greeting',
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
      // Session timeout: access token 30 min, refresh 7 days.
      JwtConfigFromPasswords(
        accessTokenLifetime: Duration(minutes: 30),
        refreshTokenLifetime: Duration(days: 7),
      ),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

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
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // NOTE: Here you call your mail service to send the verification code to
  // the user. For testing, we will just log the verification code.
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // NOTE: Here you call your mail service to send the verification code to
  // the user. For testing, we will just log the verification code.
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
}
