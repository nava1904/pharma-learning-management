import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'client.dart';
import 'constants.dart';

/// WebSocket URL on the **Serverpod web server** (dev: port 8082).
Uri lmsRealtimeWsUri(String apiHost) {
  final s = apiHost.trim();
  final u = Uri.parse(s.endsWith('/') ? s : '$s/');
  final scheme = u.scheme == 'https' ? 'wss' : 'ws';
  final usesWebProxy = u.path.contains('api');
  final port = u.port;
  final path = AppConstants.realtimeWebSocketPath;
  if (usesWebProxy || port == 8082) {
    return Uri(scheme: scheme, host: u.host, port: port, path: path);
  }
  if (port == 8080) {
    return Uri(scheme: scheme, host: u.host, port: 8082, path: path);
  }
  return Uri(scheme: scheme, host: u.host, port: port, path: path);
}

/// Singleton push channel: connect once, subscribe per screen.
class LmsRealtime {
  LmsRealtime._();
  static WebSocketChannel? _channel;
  static StreamSubscription<dynamic>? _listenSub;
  static final StreamController<Map<String, dynamic>> _events =
      StreamController<Map<String, dynamic>>.broadcast();

  static Stream<Map<String, dynamic>> get events => _events.stream;

  static Future<void> ensureConnected() async {
    if (_channel != null) return;
    final token = await client.realtime.getConnectionToken();
    final uri = lmsRealtimeWsUri(client.host).replace(queryParameters: {'token': token});
    _channel = WebSocketChannel.connect(uri);
    _listenSub = _channel!.stream.listen(
      (raw) {
        if (raw is String) {
          try {
            final m = jsonDecode(raw) as Map<String, dynamic>;
            if (!_events.isClosed) _events.add(m);
          } catch (_) {}
        }
      },
      onError: (_) {},
      onDone: () {
        _channel = null;
        _listenSub = null;
      },
    );
  }

  static void subscribeRooms(Iterable<String> rooms) {
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode({'op': 'subscribe', 'rooms': rooms.toList()}));
  }

  static void unsubscribeRooms(Iterable<String> rooms) {
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode({'op': 'unsubscribe', 'rooms': rooms.toList()}));
  }

  static Future<void> disconnect() async {
    await _listenSub?.cancel();
    _listenSub = null;
    await _channel?.sink.close();
    _channel = null;
  }
}
