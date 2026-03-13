import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Central service for emitting domain events to the transactional outbox.
/// All write operations should call EventService.emit() to publish events
/// for real-time analytics, Kafka, and downstream consumers.
class EventService {
  /// Emit a domain event to the outbox. Uses transactional outbox pattern:
  /// insert into OutboxMessage in the same DB transaction as business logic.
  static Future<void> emit(
    Session session, {
    required String topic,
    required String eventType,
    required String aggregateId,
    required Map<String, dynamic> payload,
  }) async {
    final payloadWithMeta = {
      'eventType': eventType,
      'aggregateId': aggregateId,
      'occurredAt': DateTime.now().toIso8601String(),
      ...payload,
    };
    await OutboxMessage.db.insertRow(
      session,
      OutboxMessage(
        topic: topic,
        payloadJson: jsonEncode(payloadWithMeta),
      ),
    );
  }

  // --- Training lifecycle events ---

  static Future<void> emitAssignmentCreated(
    Session session, {
    required int assignmentId,
    required int userId,
    required int courseVersionId,
    required DateTime dueDate,
    required String source,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.assignment',
      eventType: 'assignment.created',
      aggregateId: assignmentId.toString(),
      payload: {
        'assignmentId': assignmentId,
        'userId': userId,
        'courseVersionId': courseVersionId,
        'dueDate': dueDate.toIso8601String(),
        'source': source,
      },
    );
  }

  static Future<void> emitEnrollmentStarted(
    Session session, {
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required DateTime startedAt,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.enrollment',
      eventType: 'enrollment.started',
      aggregateId: enrollmentId.toString(),
      payload: {
        'enrollmentId': enrollmentId,
        'userId': userId,
        'courseVersionId': courseVersionId,
        'startedAt': startedAt.toIso8601String(),
      },
    );
  }

  static Future<void> emitEnrollmentCompleted(
    Session session, {
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required DateTime completedAt,
    int? score,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.enrollment',
      eventType: 'enrollment.completed',
      aggregateId: enrollmentId.toString(),
      payload: {
        'enrollmentId': enrollmentId,
        'userId': userId,
        'courseVersionId': courseVersionId,
        'completedAt': completedAt.toIso8601String(),
        'score': ?score,
      },
    );
  }

  static Future<void> emitCertificateIssued(
    Session session, {
    required int certificateId,
    required int userId,
    required int courseVersionId,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.certificate',
      eventType: 'certificate.issued',
      aggregateId: certificateId.toString(),
      payload: {
        'certificateId': certificateId,
        'userId': userId,
        'courseVersionId': courseVersionId,
      },
    );
  }

  static Future<void> emitMaterialProgress(
    Session session, {
    required int userId,
    required int materialId,
    required int progressPct,
    DateTime? completedAt,
    int? enrollmentId,
    int? lessonId,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.progress',
      eventType: 'material.progress',
      aggregateId: '${userId}_$materialId',
      payload: {
        'userId': userId,
        'materialId': materialId,
        'progressPct': progressPct,
        if (completedAt != null) 'completedAt': completedAt.toIso8601String(),
        'enrollmentId': ?enrollmentId,
        'lessonId': ?lessonId,
      },
    );
  }

  static Future<void> emitAssessmentStarted(
    Session session, {
    required int userId,
    required int attemptId,
    required int assessmentId,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.assessment',
      eventType: 'assessment.started',
      aggregateId: attemptId.toString(),
      payload: {
        'userId': userId,
        'attemptId': attemptId,
        'assessmentId': assessmentId,
      },
    );
  }

  static Future<void> emitCourseVersionApproved(
    Session session, {
    required int courseVersionId,
    required int courseId,
  }) async {
    await emit(
      session,
      topic: 'pharma.course.lifecycle',
      eventType: 'course.version.approved',
      aggregateId: courseVersionId.toString(),
      payload: {
        'courseVersionId': courseVersionId,
        'courseId': courseId,
      },
    );
  }

  static Future<void> emitCourseVersionEffective(
    Session session, {
    required int courseVersionId,
  }) async {
    await emit(
      session,
      topic: 'pharma.course.lifecycle',
      eventType: 'course.version.effective',
      aggregateId: courseVersionId.toString(),
      payload: {'courseVersionId': courseVersionId},
    );
  }

  static Future<void> emitWaiverApproved(
    Session session, {
    required int waiverId,
    required int userId,
    required int courseId,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.waiver',
      eventType: 'waiver.approved',
      aggregateId: waiverId.toString(),
      payload: {
        'waiverId': waiverId,
        'userId': userId,
        'courseId': courseId,
      },
    );
  }

  /// Emit when a document version goes effective and is a major version (plan 3B).
  /// Downstream (e.g. Kafka consumer) can call processSopUpdated for retraining.
  static Future<void> emitSopUpdated(
    Session session, {
    required int documentId,
    required int documentVersionId,
    required bool isMajorVersion,
  }) async {
    await emit(
      session,
      topic: 'pharma.document.lifecycle',
      eventType: 'SOP_UPDATED',
      aggregateId: documentVersionId.toString(),
      payload: {
        'documentId': documentId,
        'documentVersionId': documentVersionId,
        'isMajorVersion': isMajorVersion,
      },
    );
  }

  static Future<void> emitAssessmentCompleted(
    Session session, {
    required int userId,
    required int attemptId,
    required bool passed,
    required int score,
  }) async {
    await emit(
      session,
      topic: 'pharma.training.assessment',
      eventType: 'assessment.completed',
      aggregateId: attemptId.toString(),
      payload: {
        'userId': userId,
        'attemptId': attemptId,
        'passed': passed,
        'score': score,
      },
    );
  }
}
