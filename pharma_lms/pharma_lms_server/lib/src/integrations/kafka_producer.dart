import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Kafka producer integration.
///
/// When KAFKA_REST_URL is set (e.g. http://localhost:8082), publishes to
/// Confluent Kafka REST Proxy. When not set, no-op (events remain in outbox).
///
/// Topics: pharma.training.enrollment, pharma.training.assessment,
///         pharma.training.assignment, pharma.training.certificate,
///         pharma.training.progress, pharma.sop.updated, pharma.quality.capa,
///         pharma.analytics.compliance, pharma.course.lifecycle
class KafkaProducer {
  static String? _restUrl;
  static String? get _baseUrl {
    _restUrl ??= Platform.environment['KAFKA_REST_URL'];
    return _restUrl;
  }

  static bool get isEnabled => _baseUrl != null && _baseUrl!.isNotEmpty;

  /// Publish a message to Kafka via REST Proxy.
  /// No-op when KAFKA_REST_URL is not set.
  static Future<void> publish(String topic, String payloadJson) async {
    final base = _baseUrl;
    if (base == null || base.isEmpty) return;

    try {
      final uri = Uri.parse('$base/topics/$topic');
      final body = jsonEncode({
        'records': [
          {'value': jsonDecode(payloadJson)},
        ],
      });
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/vnd.kafka.json.v2+json',
          'Accept': 'application/vnd.kafka.v2+json',
        },
        body: body,
      );
      if (response.statusCode >= 400) {
        throw Exception('Kafka REST error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
