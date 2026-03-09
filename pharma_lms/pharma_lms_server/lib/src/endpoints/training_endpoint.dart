import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';
import '../services/training_assignment_service.dart';

/// Training Assignment domain endpoint.
class TrainingEndpoint extends Endpoint {
  /// List active signature meanings for e-signature dropdown (21 CFR Part 11).
  Future<List<SignatureMeaning>> listSignatureMeanings(Session session) async {
    return await SignatureMeaning.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<List<TrainingAssignment>> getAssignmentsForUser(
    Session session,
    int userId,
  ) async {
    return await TrainingAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  Future<TrainingAssignment> assignTraining(
    Session session, {
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String priority = 'medium',
    String? reason,
    String source = 'manual',
    bool forceReassign = false,
  }) async {
    int? oldAssignmentId;
    if (forceReassign) {
      final oldEnrollments = await Enrollment.db.find(
        session,
        where: (t) =>
            t.userId.equals(userId) &
            t.courseVersionId.equals(courseVersionId) &
            t.status.notEquals('completed'),
      );
      for (final e in oldEnrollments) {
        if (e.assignmentId != null) {
          oldAssignmentId = e.assignmentId;
          break;
        }
      }
    } else {
      final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
        session,
        userId: userId,
        courseVersionId: courseVersionId,
      );
      if (hasActive) {
        throw Exception(
          'User already has an active assignment for this course. '
          'Use forceReassign to reassign.',
        );
      }
    }

    final assignment = await TrainingAssignmentService.assign(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignedById: assignedById,
      dueDate: dueDate,
      priority: priority,
      reason: reason,
      source: source,
    );
    await TrainingAssignmentService.createEnrollment(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignmentId: assignment.id!,
    );

    if (forceReassign && oldAssignmentId != null) {
      await AuditService.log(
        session,
        entityType: 'training_assignment',
        entityId: oldAssignmentId.toString(),
        action: 'AssignmentReassigned',
        oldValueJson: '{"oldAssignmentId":$oldAssignmentId}',
        newValueJson:
            '{"newAssignmentId":${assignment.id},"courseVersionId":$courseVersionId,"userId":$userId}',
        userId: assignedById,
      );
    }

    return assignment;
  }

  /// Update assignment due date or priority.
  Future<TrainingAssignment> updateAssignment(
    Session session, {
    required int assignmentId,
    DateTime? dueDate,
    String? priority,
    required int updatedById,
  }) async {
    return TrainingAssignmentService.updateAssignment(
      session,
      assignmentId: assignmentId,
      dueDate: dueDate,
      priority: priority,
      updatedById: updatedById,
    );
  }

  /// Cancel an assignment.
  Future<TrainingAssignment> cancelAssignment(
    Session session, {
    required int assignmentId,
    required int cancelledById,
    String? reason,
  }) async {
    return TrainingAssignmentService.cancelAssignment(
      session,
      assignmentId: assignmentId,
      cancelledById: cancelledById,
      reason: reason,
    );
  }

  Future<List<Enrollment>> getEnrollmentsForUser(
    Session session,
    int userId,
  ) async {
    return await Enrollment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Get enrollment by ID for course viewer (e.g. to check retraining gate).
  Future<Enrollment?> getEnrollmentById(
    Session session,
    int enrollmentId,
  ) async {
    return await Enrollment.db.findById(
      session,
      enrollmentId,
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Acknowledge retraining change summary with e-signature.
  /// Requires: enrollment has retrainingChangeSummary, acknowledgedAt is null, userId matches.
  Future<Enrollment> acknowledgeRetraining(
    Session session, {
    required int enrollmentId,
    required int userId,
    required String signatureMeaning,
    String? passwordReauthHash,
  }) async {
    final enrollment = await Enrollment.db.findById(session, enrollmentId);
    if (enrollment == null) throw Exception('Enrollment not found');
    if (enrollment.userId != userId) {
      throw Exception('Enrollment does not belong to this user');
    }
    if (enrollment.retrainingChangeSummary == null ||
        enrollment.retrainingChangeSummary!.isEmpty) {
      throw Exception('Enrollment does not require retraining acknowledgement');
    }
    if (enrollment.acknowledgedAt != null) {
      throw Exception('Retraining already acknowledged');
    }

    final signature = await EsignatureService.sign(
      session,
      userId: userId,
      signatureMeaning: signatureMeaning,
      entityType: 'enrollment_retraining_ack',
      entityId: enrollmentId.toString(),
      passwordReauthHash: passwordReauthHash,
    );

    final now = DateTime.now();
    final updated = enrollment.copyWith(
      acknowledgedAt: now,
      acknowledgementEsignatureId: signature.id,
    );
    return await Enrollment.db.updateRow(session, updated);
  }

  Future<List<Certificate>> getCertificatesForUser(
    Session session,
    int userId,
  ) async {
    return await Certificate.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  /// Training records for user (enrollment completions with score). Used for training history.
  Future<List<TrainingRecord>> getTrainingRecordsForUser(
    Session session,
    int userId,
  ) async {
    return await TrainingRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  /// Get certificate by ID for verification and direct links.
  Future<Certificate?> getCertificateById(
    Session session,
    int certificateId,
  ) async {
    return await Certificate.db.findById(
      session,
      certificateId,
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Get signature with integrity verification. Returns null signature if not found.
  /// integrityViolation is true when HMAC mismatch (tampering detected).
  Future<SignatureVerificationResult> getSignatureWithIntegrityCheck(
    Session session,
    int signatureId,
  ) async {
    final sig = await ElectronicSignature.db.findById(
      session,
      signatureId,
      include: ElectronicSignature.include(user: PharmaUser.include()),
    );
    if (sig == null) {
      return SignatureVerificationResult(signature: null, integrityViolation: false);
    }
    final ok = EsignatureService.verifyIntegrity(sig);
    return SignatureVerificationResult(
      signature: sig,
      integrityViolation: !ok,
    );
  }

  /// List electronic signatures for auditor verification (21 CFR Part 11).
  Future<List<ElectronicSignature>> listElectronicSignatures(
    Session session, {
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    int limit = 100,
  }) async {
    var results = await ElectronicSignature.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit * 2,
      include: ElectronicSignature.include(user: PharmaUser.include()),
    );

    if (from != null) {
      results =
          results.where((r) => !r.timestamp.isBefore(from)).toList();
    }
    if (to != null) {
      results =
          results.where((r) => !r.timestamp.isAfter(to)).toList();
    }
    if (entityType != null) {
      results = results.where((r) => r.entityType == entityType).toList();
    }
    if (userId != null) {
      results = results.where((r) => r.userId == userId).toList();
    }

    return results.take(limit).toList();
  }

  /// Create electronic signature for training completion (called after e-sign UI).
  Future<int> createTrainingSignature(
    Session session, {
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordReauthHash,
    String? ipAddress,
  }) async {
    final signature = await EsignatureService.sign(
      session,
      userId: userId,
      signatureMeaning: signatureMeaning,
      entityType: entityType,
      entityId: entityId,
      passwordReauthHash: passwordReauthHash,
      ipAddress: ipAddress,
    );
    return signature.id!;
  }

  /// Complete training: create TrainingRecord, Certificate, update Enrollment.
  /// Call after assessment pass and e-signature.
  /// Idempotent: returns existing certificate if already completed for this enrollment.
  Future<Certificate> completeTraining(
    Session session, {
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required int esignatureId,
    int? score,
  }) async {
    final enrollment = await Enrollment.db.findById(session, enrollmentId);
    if (enrollment == null) throw Exception('Enrollment not found');

    // Idempotency: if already completed, return existing certificate
    if (enrollment.status == 'completed') {
      final records = await TrainingRecord.db.find(
        session,
        where: (t) => t.enrollmentId.equals(enrollmentId),
      );
      if (records.isNotEmpty && records.first.id != null) {
        final cert = await Certificate.db.findFirstRow(
          session,
          where: (t) => t.trainingRecordId.equals(records.first.id!),
        );
        if (cert != null) return cert;
      }
    }

    final now = DateTime.now();
    final expiresAt = now.add(const Duration(days: 365));

    final trainingRecord = await TrainingRecord.db.insertRow(
      session,
      TrainingRecord(
        enrollmentId: enrollmentId,
        userId: userId,
        courseVersionId: courseVersionId,
        esignatureId: esignatureId,
        score: score,
      ),
    );

    final qrCode =
        'CERT-$enrollmentId-${Random().nextInt(999999).toString().padLeft(6, '0')}';

    final certificate = await Certificate.db.insertRow(
      session,
      Certificate(
        userId: userId,
        courseVersionId: courseVersionId,
        trainingRecordId: trainingRecord.id!,
        expiresAt: expiresAt,
        qrCode: qrCode,
        esignatureId: esignatureId,
      ),
    );

    await Enrollment.db.updateRow(
      session,
      enrollment.copyWith(
        status: 'completed',
        completedAt: now,
      ),
    );

    if (enrollment.assignmentId != null) {
      await AuditService.log(
        session,
        entityType: 'training_assignment',
        entityId: enrollment.assignmentId.toString(),
        action: 'AssignmentCompleted',
        newValueJson:
            '{"enrollmentId":$enrollmentId,"certificateId":${certificate.id},"completedAt":"${now.toIso8601String()}"}',
        userId: userId,
      );
    }

    await AuditService.log(
      session,
      entityType: 'training_record',
      entityId: trainingRecord.id.toString(),
      action: 'TrainingCompleted',
      newValueJson: '{"certificateId": ${certificate.id}}',
      userId: userId,
    );

    await AuditService.log(
      session,
      entityType: 'certificate',
      entityId: certificate.id.toString(),
      action: 'CertificateIssued',
      userId: userId,
    );

    if (enrollment.assignmentId != null) {
      final capas = await Capa.db.find(
        session,
        where: (t) => t.trainingAssignmentId.equals(enrollment.assignmentId!),
      );
      if (capas.isNotEmpty && capas.first.id != null) {
        await Capa.db.updateRow(
          session,
          capas.first.copyWith(
            effectivenessCheckDue: now.add(const Duration(days: 30)),
            status: 'Verification',
          ),
        );
      }
    }

    return certificate;
  }

  /// QA-08: List annotations for a training record.
  Future<List<TrainingRecordAnnotation>> listAnnotations(
    Session session,
    int trainingRecordId,
  ) async {
    return await TrainingRecordAnnotation.db.find(
      session,
      where: (t) => t.trainingRecordId.equals(trainingRecordId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: TrainingRecordAnnotation.include(
        author: PharmaUser.include(),
      ),
    );
  }

  /// QA-08: Add annotation to a training record (QA role).
  Future<TrainingRecordAnnotation> addAnnotation(
    Session session, {
    required int trainingRecordId,
    required int authorId,
    required String note,
  }) async {
    final record =
        await TrainingRecord.db.findById(session, trainingRecordId);
    if (record == null) throw Exception('Training record not found');
    return await TrainingRecordAnnotation.db.insertRow(
      session,
      TrainingRecordAnnotation(
        trainingRecordId: trainingRecordId,
        authorId: authorId,
        note: note,
      ),
    );
  }
}
