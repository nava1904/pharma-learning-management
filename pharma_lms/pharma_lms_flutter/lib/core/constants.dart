/// Vyuh lms app constants.
class AppConstants {
  static const String appName = 'Vyuh lms';
  static const String complianceBanner = '21 CFR Part 11 & GxP Compliant';

  /// Realtime push WebSocket path on the Serverpod **web** server (not the API port).
  /// Full URL: `ws(s)://<host>:<webPort>/ws/realtime?token=<shortLivedToken>`.
  /// Dev: web server often 8082; ensure reverse proxy forwards `/ws` for production.
  static const String realtimeWebSocketPath = '/ws/realtime';
}
