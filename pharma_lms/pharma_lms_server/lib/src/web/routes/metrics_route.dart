import 'package:serverpod/serverpod.dart';

/// In-memory metrics for Prometheus /metrics endpoint.
/// Exposes request_count and request_latency_seconds.
class MetricsStore {
  static int _requestCount = 0;
  static final List<double> _recentLatencies = [];
  static const int _maxLatencies = 1000;

  static void recordRequest(Duration latency) {
    _requestCount++;
    _recentLatencies.add(latency.inMicroseconds / 1e6);
    if (_recentLatencies.length > _maxLatencies) {
      _recentLatencies.removeAt(0);
    }
  }

  static int get requestCount => _requestCount;

  static double get averageLatencySeconds {
    if (_recentLatencies.isEmpty) return 0;
    return _recentLatencies.reduce((a, b) => a + b) / _recentLatencies.length;
  }

  static String toPrometheus() {
    final buffer = StringBuffer();
    buffer.writeln('# HELP pharma_lms_request_count Total number of requests');
    buffer.writeln('# TYPE pharma_lms_request_count counter');
    buffer.writeln('pharma_lms_request_count $requestCount');

    buffer.writeln('# HELP pharma_lms_request_latency_seconds Request latency in seconds');
    buffer.writeln('# TYPE pharma_lms_request_latency_seconds gauge');
    buffer.writeln('pharma_lms_request_latency_seconds $averageLatencySeconds');
    return buffer.toString();
  }
}

/// Prometheus /metrics route. Exposes request_count and request_latency_seconds.
class MetricsRoute extends Route {
  MetricsRoute() : super(methods: {Method.get}, path: '/metrics');

  @override
  Future<Result> handleCall(Session session, Request request) async {
    return Response.ok(
      body: Body.fromString(
        MetricsStore.toPrometheus(),
        mimeType: MimeType.plainText,
      ),
    );
  }
}
