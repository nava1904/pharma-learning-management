import 'dart:async';
import 'dart:convert';

/// Pub/sub hub for WebSocket rooms. Delivers messages to all local subscribers
/// within the same Serverpod process.
///
/// When Redis is enabled in production, Serverpod uses it for distributed
/// caching and session management automatically. This hub handles the
/// application-level WebSocket broadcast layer.
///
/// For multi-instance horizontal scaling, replace [_deliverLocal] calls with
/// a raw `redis` package Pub/Sub channel — the architecture below is structured
/// to make that a single-point swap.
class RealtimeHub {
  RealtimeHub._();
  static final RealtimeHub instance = RealtimeHub._();

  /// Local sinks per room.
  final Map<String, List<StreamController<String>>> _rooms = {};

  void subscribe(String room, StreamController<String> sink) {
    final list = _rooms.putIfAbsent(room, () => []);
    if (!list.contains(sink)) list.add(sink);
  }

  /// Remove [sink] from every room (WebSocket disconnect).
  void removeFromAllRooms(StreamController<String> sink) {
    for (final key in _rooms.keys.toList()) {
      unsubscribe(key, sink);
    }
  }

  void unsubscribe(String room, StreamController<String> sink) {
    final list = _rooms[room];
    if (list == null) return;
    list.remove(sink);
    if (list.isEmpty) {
      _rooms.remove(room);
    }
  }

  /// Broadcast [event] to all local subscribers of [room].
  ///
  /// TODO(multi-instance): Publish to Redis channel `rt:<room>` here and
  /// deliver via a Redis subscription listener instead of calling
  /// [_deliverLocal] directly. This ensures every Serverpod instance receives
  /// the broadcast.
  void broadcast(String room, Map<String, dynamic> event) {
    final json = jsonEncode(event);
    _deliverLocal(room, json);
  }

  // ──────────── private helpers ────────────

  void _deliverLocal(String room, String json) {
    final list = _rooms[room];
    if (list == null) return;
    for (final c in List<StreamController<String>>.from(list)) {
      if (!c.isClosed) {
        try {
          c.add(json);
        } catch (_) {}
      }
    }
  }

  /// Statistics for monitoring.
  Map<String, int> get stats => {
        'rooms': _rooms.length,
        'totalSubscriptions':
            _rooms.values.fold<int>(0, (sum, list) => sum + list.length),
      };
}
