import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

late final Client client;

/// Connection timeout for all API calls (login, etc.). Serverpod default is 20s;
/// use 90s so slow networks or cold server don't cause login to fail.
const Duration _connectionTimeout = Duration(seconds: 90);

Future<void> initClient(String serverUrl) async {
  client = Client(
    serverUrl,
    connectionTimeout: _connectionTimeout,
  )
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();
}
