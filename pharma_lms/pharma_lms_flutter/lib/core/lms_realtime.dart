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
/// Includes auto-reconnect with exponential backoff for reliability at scale.
class LmsRealtime {
  LmsRealtime._();
  static WebSocketChannel? _channel;
  static StreamSubscription<dynamic>? _listenSub;
  static final StreamController<Map<String, dynamic>> _events =
      StreamController<Map<String, dynamic>>.broadcast();
  static final Set<String> _activeRooms = {};
  static int _reconnectAttempts = 0;
  static Timer? _reconnectTimer;
  static bool _intentionalDisconnect = false;

  static Stream<Map<String, dynamic>> get events => _events.stream;

  static Future<void> ensureConnected() async {
    if (_channel != null) return;
    _intentionalDisconnect = false;
    try {
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
        onError: (e) {

          _scheduleReconnect();
        },
        onDone: () {

          _channel = null;
          _listenSub = null;
          if (!_intentionalDisconnect) {
            _scheduleReconnect();
          }
        },
      );
      // Re-subscribe to all active rooms after reconnect
      if (_activeRooms.isNotEmpty) {
        _channel!.sink.add(jsonEncode({'op': 'subscribe', 'rooms': _activeRooms.toList()}));
      }
      _reconnectAttempts = 0; // Reset backoff on successful connect

    } catch (e) {

      _channel = null;
      _listenSub = null;
      _scheduleReconnect();
    }
  }

  /// Exponential backoff reconnect: 1s, 2s, 4s, 8s, 16s, 30s max.
  static void _scheduleReconnect() {
    if (_intentionalDisconnect) return;
    _reconnectTimer?.cancel();
    final delay = Duration(
      seconds: (_reconnectAttempts < 5
              ? (1 << _reconnectAttempts)
              : 30)
          .clamp(1, 30),
    );
    _reconnectAttempts++;

    _reconnectTimer = Timer(delay, () async {
      _channel = null;
      _listenSub = null;
      await ensureConnected();
    });
  }

  static void subscribeRooms(Iterable<String> rooms) {
    _activeRooms.addAll(rooms);
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode({'op': 'subscribe', 'rooms': rooms.toList()}));
  }

  static void unsubscribeRooms(Iterable<String> rooms) {
    _activeRooms.removeAll(rooms);
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode({'op': 'unsubscribe', 'rooms': rooms.toList()}));
  }

  static Future<void> disconnect() async {
    _intentionalDisconnect = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _activeRooms.clear();
    await _listenSub?.cancel();
    _listenSub = null;
    await _channel?.sink.close();
    _channel = null;
    _reconnectAttempts = 0;
  }
}
