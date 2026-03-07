import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'core/client.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';
import 'widgets/session_timeout_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serverUrl = await getServerUrl();
  await initClient(serverUrl);

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
        title: 'Pharma LMS',
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
