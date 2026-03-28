import 'dart:async';
import 'dart:convert';

/// In-process pub/sub for WebSocket rooms (monolith). See [realtime_websocket_route].
class RealtimeHub {
  RealtimeHub._();
  static final RealtimeHub instance = RealtimeHub._();

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
    if (list.isEmpty) _rooms.remove(room);
  }

  void broadcast(String room, Map<String, dynamic> event) {
    final json = jsonEncode(event);
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
}
