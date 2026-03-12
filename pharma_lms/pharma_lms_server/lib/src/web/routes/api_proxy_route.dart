import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import 'metrics_route.dart';

/// Proxies API requests from the web server to the API server.
/// Enables same-origin requests when the Flutter app is served from the web server.
/// Expects requests at /api/* and forwards to the API server at the same path without /api.
class ApiProxyRoute extends Route {
  final String apiBaseUrl;

  ApiProxyRoute({required this.apiBaseUrl})
      : super(methods: {Method.get, Method.post, Method.options}, path: '/**');

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final path = request.url.path;
    final apiPath = path.startsWith('/api') ? path.substring(4) : path;
    final apiUrl = apiBaseUrl.endsWith('/')
        ? '$apiBaseUrl${apiPath.startsWith('/') ? apiPath.substring(1) : apiPath}'
        : '$apiBaseUrl$apiPath';
    final uri = Uri.parse(apiUrl);

    if (request.method == Method.options) {
      return Response.ok(
        headers: Headers.build((mh) {
          mh.accessControlAllowOrigin =
              const AccessControlAllowOriginHeader.wildcard();
          mh.accessControlAllowMethods =
              AccessControlAllowMethodsHeader.methods([Method.post, Method.get]);
          mh.accessControlAllowHeaders = AccessControlAllowHeadersHeader
              .headers(['Content-Type', 'Authorization', 'Accept']);
        }),
      );
    }

    try {
      final stopwatch = Stopwatch()..start();
      final authHeader = request.getAuthorizationHeaderValue(false);
      final headers = <String, String>{
        'Content-Type': 'application/json',
        ...(authHeader != null ? {'Authorization': authHeader} : {}),
      };

      final body = await request.readAsString();
      final response = request.method == Method.post
          ? await http
              .post(uri, headers: headers, body: body)
              .timeout(const Duration(seconds: 30))
          : await http
              .get(uri, headers: headers)
              .timeout(const Duration(seconds: 30));

      stopwatch.stop();
      MetricsStore.recordRequest(stopwatch.elapsed);

      return Response(
        response.statusCode,
        body: Body.fromString(response.body, mimeType: MimeType.json),
        headers: Headers.build((mh) {
          mh.accessControlAllowOrigin =
              const AccessControlAllowOriginHeader.wildcard();
        }),
      );
    } catch (e) {
      return Response.internalServerError(
        body: Body.fromString(
          jsonEncode({'error': e.toString()}),
          mimeType: MimeType.json,
        ),
      );
    }
  }
}
