import 'package:serverpod/serverpod.dart';

/// Builds the API base URL from a [ServerConfig].
String apiUrlFromConfig(ServerConfig c) =>
    Uri(scheme: c.publicScheme, host: c.publicHost, port: c.publicPort)
        .toString();

/// Tunnel host suffixes (ngrok, Cloudflare, localtunnel, etc.) that indicate
/// the request came through a public URL. When detected, apiUrl uses the
/// request's Host so the app works when accessed via tunnel for testing.
const _tunnelHostSuffixes = [
  'ngrok-free.dev',
  'ngrok-free.app',
  'ngrok.io',
  'trycloudflare.com',
  'loca.lt',
];

bool _isTunnelHost(String host) {
  final lower = host.toLowerCase();
  return _tunnelHostSuffixes.any((s) => lower.endsWith(s) || lower.contains(s));
}

class AppConfigWidget extends JsonWidget {
  final String apiUrl;

  AppConfigWidget({
    required this.apiUrl,
  }) : super(object: {'apiUrl': apiUrl});
}

class AppConfigRoute extends WidgetRoute {
  final ServerConfig apiConfig;
  final ServerConfig? webConfig;

  /// When [webConfig] is provided, apiUrl is set to the web server URL + /api/,
  /// enabling same-origin API calls via the web server's proxy. When the
  /// request comes through a tunnel (ngrok, etc.), uses the request's Host
  /// so the app works for remote testing.
  AppConfigRoute({
    required this.apiConfig,
    this.webConfig,
  });

  @override
  Future<WebWidget> build(Session session, Request request) async {
    final apiUrl = _resolveApiUrl(request);
    return AppConfigWidget(apiUrl: apiUrl);
  }

  String _resolveApiUrl(Request request) {
    if (webConfig == null) {
      return apiUrlFromConfig(apiConfig);
    }

    final hostHeader = request.headers.host;
    if (hostHeader != null && _isTunnelHost(hostHeader.host)) {
      final scheme = request.headers.forwarded?.elements.firstOrNull?.proto ??
          request.headers['x-forwarded-proto']?.firstOrNull ??
          'https';
      return Uri(
        scheme: scheme,
        host: hostHeader.host,
        port: hostHeader.port,
        path: 'api/',
      ).toString();
    }

    return Uri(
      scheme: webConfig!.publicScheme,
      host: webConfig!.publicHost,
      port: webConfig!.publicPort,
      path: 'api/',
    ).toString();
  }
}
