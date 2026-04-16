import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'core/client.dart';
import 'core/theme/app_theme.dart';
import 'core/webview_platform_registrar.dart';
import 'design_system/pharma_design_system.dart';
import 'routes/app_router.dart';
import 'widgets/session_timeout_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerWebViewPlatformForWeb();

  // Ignore clipboard paste_fail on web (browser blocks clipboard without user gesture).
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception.toString().contains('paste_fail') &&
        details.exception.toString().contains('Clipboard.getData')) {
      return;
    }
    FlutterError.presentError(details);
  };

  // Prevent "flutter/lifecycle channel was discarded" warnings on web.
  ui.channelBuffers.resize('flutter/lifecycle', 8);

  String serverUrl;
  try {
    serverUrl = await getServerUrl().timeout(
      const Duration(seconds: 10),
      onTimeout: () => 'http://localhost:8080/',
    );
  } catch (_) {
    serverUrl = 'http://localhost:8080/';
  }

  try {
    await initClient(serverUrl);
  } catch (_) {
    // Still run app so user sees UI; client may reconnect later.
  }

  runApp(
    const ProviderScope(
      child: PharmaLmsApp(),
    ),
  );
}

class PharmaLmsApp extends ConsumerWidget {
  const PharmaLmsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return SessionTimeoutWrapper(
      child: MaterialApp.router(
        title: PharmaBrand.name,
        theme: AppTheme.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
