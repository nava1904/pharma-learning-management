import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Short-lived HMAC token for WebSocket upgrade (query `token=`).
class RealtimeWsAuth {
  static String issue(int userId, String secret) {
    if (secret.isEmpty) throw StateError('Missing realtime signing secret');
    final exp = DateTime.now().add(const Duration(minutes: 30)).millisecondsSinceEpoch ~/ 1000;
    final inner = base64Url.encode(utf8.encode(jsonEncode({'u': userId, 'e': exp})))
        .replaceAll('=', '');
    final sig = Hmac(sha256, utf8.encode(secret)).convert(utf8.encode(inner)).bytes;
    final sigB64 = base64Url.encode(sig).replaceAll('=', '');
    return '$inner.$sigB64';
  }

  /// Returns user id if valid and not expired; otherwise null.
  static int? verify(String token, String secret) {
    if (secret.isEmpty) return null;
    final dot = token.lastIndexOf('.');
    if (dot <= 0) return null;
    final payload = token.substring(0, dot);
    final sigPart = token.substring(dot + 1);
    try {
      final expected = Hmac(sha256, utf8.encode(secret)).convert(utf8.encode(payload)).bytes;
      final actual = base64Url.decode(_padBase64(sigPart));
      if (expected.length != actual.length) return null;
      for (var i = 0; i < expected.length; i++) {
        if (expected[i] != actual[i]) return null;
      }
      final json = jsonDecode(utf8.decode(base64Url.decode(_padBase64(payload)))) as Map<String, dynamic>;
      final exp = json['e'] as int?;
      final uid = json['u'] as int?;
      if (exp == null || uid == null) return null;
      if (exp < DateTime.now().millisecondsSinceEpoch ~/ 1000) return null;
      return uid;
    } catch (_) {
      return null;
    }
  }

  static String _padBase64(String s) {
    final pad = 4 - s.length % 4;
    if (pad == 4) return s;
    return '$s${'=' * pad}';
  }
}
