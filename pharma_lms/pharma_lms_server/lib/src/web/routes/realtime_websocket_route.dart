import 'dart:async';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:web_socket/web_socket.dart';

import '../../services/realtime_hub.dart';
import '../../services/realtime_ws_auth.dart';

/// Browser-friendly WebSocket on the **web server** (port 8082): `/ws/realtime?token=...`.
/// Client sends JSON: `{"op":"subscribe","rooms":["qa_thread:cv:1"]}`.
class RealtimeWebSocketRoute extends Route {
  RealtimeWebSocketRoute(this.serverpod)
      : super(methods: {Method.get}, path: '/realtime');

  final Serverpod serverpod;

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final secret = serverpod.getPassword('serviceSecret') ?? '';
    if (secret.isEmpty) {
      return Response.internalServerError(
        body: Body.fromString('Realtime signing secret not configured'),
      );
    }
    final token = request.url.queryParameters['token'];
    final userId = token != null ? RealtimeWsAuth.verify(token, secret) : null;
    if (userId == null) {
      return Response.forbidden(body: Body.fromString('Invalid or missing token'));
    }

    return WebSocketUpgrade((webSocket) async {
      final out = StreamController<String>();
      final sub = out.stream.listen((msg) {
        try {
          webSocket.sendText(msg);
        } catch (_) {}
      });

      try {
        await for (final event in webSocket.events) {
          if (event is TextDataReceived) {
            try {
              final data = jsonDecode(event.text) as Map<String, dynamic>?;
              final op = data?['op'] as String?;
              if (op == 'subscribe') {
                final rooms = data?['rooms'] as List<dynamic>? ?? [];
                for (final r in rooms) {
                  RealtimeHub.instance.subscribe(r.toString(), out);
                }
              } else if (op == 'unsubscribe') {
                final rooms = data?['rooms'] as List<dynamic>? ?? [];
                for (final r in rooms) {
                  RealtimeHub.instance.unsubscribe(r.toString(), out);
                }
              }
            } catch (_) {}
          }
        }
      } finally {
        await sub.cancel();
        RealtimeHub.instance.removeFromAllRooms(out);
        await out.close();
      }
    });
  }
}
