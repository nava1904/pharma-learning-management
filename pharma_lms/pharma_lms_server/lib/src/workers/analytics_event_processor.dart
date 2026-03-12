import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Consumes domain events (from Outbox after publish or from Kafka) and
/// updates analytics. Extend with snapshot tables for pre-aggregated metrics.
class AnalyticsEventProcessor {
  /// Process a single outbox message payload. Call after successful Kafka publish
  /// or when processing from outbox directly.
  static Future<void> processPayload(
    Session session,
    String topic,
    String payloadJson,
  ) async {
    try {
      final payload = jsonDecode(payloadJson) as Map<String, dynamic>?;
      if (payload == null) return;

      final eventType = payload['eventType'] as String?;
      if (eventType == null) return;

      switch (eventType) {
        case 'enrollment.completed':
          await _onEnrollmentCompleted(session, payload);
          break;
        case 'assessment.completed':
          await _onAssessmentCompleted(session, payload);
          break;
        case 'material.progress':
          await _onMaterialProgress(session, payload);
          break;
        case 'assignment.created':
        case 'assignment.overdue':
          await _onAssignmentEvent(session, payload);
          break;
        case 'compliance.breach':
          await _onComplianceBreach(session, payload);
          break;
        case 'certificate.issued':
        case 'certificate.expiring':
          await _onCertificateEvent(session, payload);
          break;
        default:
          break;
      }
    } catch (_) {
      // Log but don't fail - event is already in outbox
    }
  }

  static Future<void> _onEnrollmentCompleted(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    // Hook for snapshot: increment completion count, update dept compliance
    // Existing ComplianceCalculatorService computes on-demand; add snapshot later
    _ignore(session, payload);
  }

  static Future<void> _onAssessmentCompleted(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    // Hook for snapshot: update course pass rate, score distribution
    _ignore(session, payload);
  }

  static Future<void> _onMaterialProgress(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    // Hook for snapshot: update course progress distribution
    _ignore(session, payload);
  }

  static Future<void> _onAssignmentEvent(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    // Hook for snapshot: increment overdue count
    _ignore(session, payload);
  }

  static void _ignore(Object? a, Object? b) {}

  static Future<void> _onComplianceBreach(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    final policyId = payload['policyId'] as int?;
    if (policyId == null) return;

    final existing = await SlaBreach.db.findFirstRow(
      session,
      where: (t) =>
          t.slaPolicyId.equals(policyId) &
          t.resolvedAt.equals(null),
    );
    if (existing != null) return;

    await SlaBreach.db.insertRow(
      session,
      SlaBreach(slaPolicyId: policyId),
    );
  }

  static Future<void> _onCertificateEvent(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    _ignore(session, payload);
  }
}
