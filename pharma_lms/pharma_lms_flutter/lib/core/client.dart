import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

late final Client client;

Future<void> initClient(String serverUrl) async {
  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();
}
