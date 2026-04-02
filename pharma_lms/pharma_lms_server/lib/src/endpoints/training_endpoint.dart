import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'course_endpoint.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';
import '../services/event_service.dart';
import '../services/rbac_helper.dart';
import '../services/realtime_hub.dart';
import '../services/training_assignment_service.dart';

/// Training Assignment domain endpoint.
class TrainingEndpoint extends Endpoint {
  /// List active signature meanings for e-signature dropdown (21 CFR Part 11).
  Future<List<SignatureMeaning>> listSignatureMeanings(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await TrainingAssignment.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.status.equals('active'),
      include: TrainingAssignment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
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
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
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
    final enrollment = await TrainingAssignmentService.createEnrollment(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignmentId: assignment.id!,
    );

    // Create in-app notification for the assigned user
    try {
      String courseTitle = 'a training course';
      final cv = await CourseVersion.db.findById(session, courseVersionId);
      if (cv != null) {
        final c = await Course.db.findById(session, cv.courseId);
        if (c != null) courseTitle = c.title;
      }
      await Notification.db.insertRow(
        session,
        Notification(
          userId: userId,
          type: 'training_assigned',
          body: 'You have been assigned to "$courseTitle". Please complete it before the due date.',
          enrollmentId: enrollment.id,
          sentAt: DateTime.now(),
          deliveryStatus: 'delivered',
          channel: 'in_app',
          createdAt: DateTime.now(),
        ),
      );
      // Push realtime notification so employee sees it instantly
      RealtimeHub.instance.broadcast('notifications:user:$userId', {
        'event': 'notification',
        'type': 'training_assigned',
        'courseTitle': courseTitle,
        'enrollmentId': enrollment.id,
        'dueDate': dueDate.toIso8601String(),
        'message': 'You have been assigned to "$courseTitle". Please complete it before the due date.',
        'ts': DateTime.now().toUtc().toIso8601String(),
      });
    } catch (_) {}

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
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
    return TrainingAssignmentService.updateAssignment(
      session,
      assignmentId: assignmentId,
      dueDate: dueDate,
      priority: priority,
      updatedById: updatedById,
    );
  }

  /// Cancel an assignment (ADM-WF-02).
  /// Requires a mandatory reason and cascades cancellation to linked active enrollments.
  Future<TrainingAssignment> cancelAssignment(
    Session session, {
    required int assignmentId,
    required int cancelledById,
    required String reason,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await Enrollment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Resume position for in-progress enrollment (e.g. "Module 2, Lesson 3").
  Future<String?> getEnrollmentResumePosition(
    Session session,
    int enrollmentId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return null;
    final enrollment = await Enrollment.db.findById(session, enrollmentId);
    if (enrollment == null || enrollment.status == 'completed') return null;

    final courseEndpoint = CourseEndpoint();
    final modules = await courseEndpoint.getModulesForCourseVersion(
      session,
      enrollment.courseVersionId,
    );
    for (var mi = 0; mi < modules.length; mi++) {
      final m = modules[mi];
      if (m.id == null) continue;
      final lessons = await courseEndpoint.getLessonsForModule(session, m.id!);
      for (var li = 0; li < lessons.length; li++) {
        final lesson = lessons[li];
        final progress = await MaterialProgress.db.findFirstRow(
          session,
          where: (t) =>
              t.userId.equals(enrollment.userId) &
              t.materialId.equals(lesson.materialId) &
              t.enrollmentId.equals(enrollmentId),
        );
        final completed = progress != null &&
            (progress.readTimeMet == true ||
                progress.progressPct >= 100 ||
                progress.completedAt != null);
        if (!completed) {
          return '${m.title}, ${lesson.title}';
        }
      }
    }
    return null;
  }

  /// Get enrollment by ID for course viewer (e.g. to check retraining gate).
  Future<Enrollment?> getEnrollmentById(
    Session session,
    int enrollmentId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return null;
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
    String? passwordPlaintext,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
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
      passwordPlaintext: passwordPlaintext,
      ipAddress: null,
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await Certificate.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: Certificate.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Training records for user (enrollment completions with score). Used for training history.
  Future<List<TrainingRecord>> getTrainingRecordsForUser(
    Session session,
    int userId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return null;
    return await Certificate.db.findById(
      session,
      certificateId,
      include: Certificate.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Get a training waiver by ID. Returns the waiver only if the current user is the waiver owner (employee view).
  Future<TrainingWaiver?> getWaiverById(Session session, int waiverId) async {
    final currentUser = await RbacHelper.getCurrentPharmaUser(session);
    if (currentUser?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return null;
    final waiver = await TrainingWaiver.db.findById(
      session,
      waiverId,
      include: TrainingWaiver.include(
        user: PharmaUser.include(),
        course: Course.include(),
        requestedBy: PharmaUser.include(),
        approvedBy: PharmaUser.include(),
      ),
    );
    if (waiver == null || waiver.userId != currentUser!.id) return null;
    return waiver;
  }

  /// Get signature with integrity verification. Returns null signature if not found.
  /// integrityViolation is true when HMAC mismatch (tampering detected).
  Future<SignatureVerificationResult> getSignatureWithIntegrityCheck(
    Session session,
    int signatureId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return SignatureVerificationResult(signature: null, integrityViolation: false);
    }
    await RbacHelper.requirePermission(session, resource: 'audit', action: 'read');
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'audit', action: 'read');
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

  /// Issue a short-lived biometric token after password verification (plan 6B).
  Future<String> issueBiometricToken(
    Session session, {
    required int userId,
    required String passwordPlaintext,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    return EsignatureService.issueBiometricToken(
      session,
      userId: userId,
      passwordPlaintext: passwordPlaintext,
    );
  }

  /// Create electronic signature for training completion (called after e-sign UI).
  /// passwordPlaintext: plaintext password for re-authentication (sent over HTTPS); verified server-side, never stored.
  /// biometricToken: short-lived token from issueBiometricToken (plan 6B).
  Future<int> createTrainingSignature(
    Session session, {
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordPlaintext,
    String? biometricToken,
    String? ipAddress,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    final signature = await EsignatureService.sign(
      session,
      userId: userId,
      signatureMeaning: signatureMeaning,
      entityType: entityType,
      entityId: entityId,
      passwordPlaintext: passwordPlaintext,
      biometricToken: biometricToken,
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
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
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

    await EventService.emitEnrollmentCompleted(
      session,
      enrollmentId: enrollmentId,
      userId: userId,
      courseVersionId: courseVersionId,
      completedAt: now,
      score: score,
    );
    await EventService.emitCertificateIssued(
      session,
      certificateId: certificate.id!,
      userId: userId,
      courseVersionId: courseVersionId,
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
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
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
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
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

  /// QA-WF-06: Revoke an electronic signature (QA role).
  /// This invalidates the signature and any linked certificates.
  Future<void> revokeSignature(
    Session session, {
    required int signatureId,
    required String reason,
    required String passwordPlaintext,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');

    final signature = await ElectronicSignature.db.findById(session, signatureId);
    if (signature == null) throw Exception('Signature not found');
    if (signature.isValid == false) throw Exception('Signature already revoked');

    // Get the current user for the revoking signature
    final revoker = await RbacHelper.getCurrentPharmaUser(session);
    if (revoker == null) throw Exception('User not authenticated');

    // Create the revoking signature
    final revokingSignature = await EsignatureService.sign(
      session,
      userId: revoker.id!,
      signatureMeaning: 'I am revoking this signature for the stated reason: $reason',
      entityType: 'electronic_signature',
      entityId: signatureId.toString(),
      passwordPlaintext: passwordPlaintext,
    );

    // Update the original signature
    final updated = signature.copyWith(
      isValid: false,
      revokedReason: reason,
      revokedBySignatureId: revokingSignature.id,
    );
    await ElectronicSignature.db.updateRow(session, updated);

    // Invalidate any linked certificates
    final certificates = await Certificate.db.find(
      session,
      where: (t) => t.esignatureId.equals(signatureId),
    );

    for (final cert in certificates) {
      final updatedCert = cert.copyWith(status: 'revoked');
      await Certificate.db.updateRow(session, updatedCert);

      await AuditService.log(
        session,
        entityType: 'certificate',
        entityId: cert.id.toString(),
        action: 'CertificateRevoked',
        newValueJson: '{"reason":"Linked signature revoked","signatureId":$signatureId}',
        userId: revoker.id,
      );
    }

    await AuditService.log(
      session,
      entityType: 'electronic_signature',
      entityId: signatureId.toString(),
      action: 'SignatureRevoked',
      newValueJson: '{"reason":"$reason","revokedBySignatureId":${revokingSignature.id}}',
      userId: revoker.id,
    );
  }

  // ─── QA Approval Gating ────────────────────────────────────────────

  /// QA approves a training assignment (allows learner to begin).
  /// Sets assignment status from 'pending_qa' to 'active'.
  Future<TrainingAssignment> qaApproveAssignment(
    Session session, {
    required int assignmentId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? comments,
  }) async {
    final qa = await RbacHelper.getCurrentPharmaUser(session);
    if (qa?.id == null) throw Exception('Not authenticated');
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');

    final assignment = await TrainingAssignment.db.findById(session, assignmentId);
    if (assignment == null) throw Exception('Assignment not found');
    if (assignment.status != 'pending_qa') {
      throw Exception('Assignment is not in pending_qa status. Current: ${assignment.status}');
    }

    // QA e-signature
    final sig = await EsignatureService.sign(
      session,
      userId: qa!.id!,
      signatureMeaning: signatureMeaning,
      entityType: 'qa_approval',
      entityId: assignmentId.toString(),
      passwordPlaintext: passwordPlaintext,
    );

    final updated = assignment.copyWith(status: 'active');
    final result = await TrainingAssignment.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'training_assignment',
      entityId: assignmentId.toString(),
      action: 'QaApproved',
      newValueJson:
          '{"qaUserId":${qa.id},"esignatureId":${sig.id},"comments":"${comments ?? ""}"}',
      userId: qa.id,
    );

    // Notify the learner
    try {
      await Notification.db.insertRow(
        session,
        Notification(
          userId: assignment.userId,
          type: 'qa_approval',
          body: 'Your training assignment has been approved by QA. You may now begin.',
          channel: 'in_app',
          createdAt: DateTime.now(),
        ),
      );
    } catch (_) {}

    return result;
  }

  /// QA rejects/holds a training assignment. Learner cannot begin until resubmitted.
  Future<TrainingAssignment> qaRejectAssignment(
    Session session, {
    required int assignmentId,
    required String reason,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) async {
    final qa = await RbacHelper.getCurrentPharmaUser(session);
    if (qa?.id == null) throw Exception('Not authenticated');
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');

    final assignment = await TrainingAssignment.db.findById(session, assignmentId);
    if (assignment == null) throw Exception('Assignment not found');
    if (assignment.status != 'pending_qa') {
      throw Exception('Assignment is not in pending_qa status. Current: ${assignment.status}');
    }

    final sig = await EsignatureService.sign(
      session,
      userId: qa!.id!,
      signatureMeaning: signatureMeaning,
      entityType: 'qa_rejection',
      entityId: assignmentId.toString(),
      passwordPlaintext: passwordPlaintext,
    );

    final updated = assignment.copyWith(status: 'qa_rejected');
    final result = await TrainingAssignment.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'training_assignment',
      entityId: assignmentId.toString(),
      action: 'QaRejected',
      newValueJson:
          '{"qaUserId":${qa.id},"esignatureId":${sig.id},"reason":"$reason"}',
      userId: qa.id,
    );

    // Notify the assigner
    try {
      await Notification.db.insertRow(
        session,
        Notification(
          userId: assignment.assignedById,
          type: 'qa_rejection',
          body: 'Training assignment #$assignmentId was rejected by QA. Reason: $reason',
          channel: 'in_app',
          createdAt: DateTime.now(),
        ),
      );
    } catch (_) {}

    return result;
  }

  /// Submit assignment for QA approval (trainer/admin sets status to pending_qa).
  Future<TrainingAssignment> submitForQaApproval(
    Session session, {
    required int assignmentId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'training', action: 'assign');

    final assignment = await TrainingAssignment.db.findById(session, assignmentId);
    if (assignment == null) throw Exception('Assignment not found');

    final updated = assignment.copyWith(status: 'pending_qa');
    final result = await TrainingAssignment.db.updateRow(session, updated);

    await AuditService.log(
      session,
      entityType: 'training_assignment',
      entityId: assignmentId.toString(),
      action: 'SubmittedForQaApproval',
      newValueJson: '{"assignmentId":$assignmentId}',
    );

    // Notify QA users
    try {
      final qaRoles = await JobRole.db.find(
        session,
        where: (t) => t.name.ilike('%qa%') | t.name.ilike('%quality%'),
      );
      final qaRoleIds = qaRoles.map((r) => r.id).whereType<int>().toList();
      if (qaRoleIds.isNotEmpty) {
        final qaUsers = await PharmaUser.db.find(
          session,
          where: (t) => t.jobRoleId.inSet(qaRoleIds.toSet()),
          limit: 10,
        );
        for (final qa in qaUsers) {
          if (qa.id == null) continue;
          await Notification.db.insertRow(
            session,
            Notification(
              userId: qa.id!,
              type: 'qa_review_needed',
              body: 'Training assignment #$assignmentId requires QA approval.',
              channel: 'in_app',
              createdAt: DateTime.now(),
            ),
          );
        }
      }
    } catch (_) {}

    return result;
  }

  /// Self-enrollment for employee-initiated course enrollment.
  /// Creates a "self" source assignment and associated enrollment.
  /// Returns the created enrollment.
  Future<Enrollment> selfEnroll(
    Session session, {
    required int userId,
    required int courseVersionId,
  }) async {
    final user = await RbacHelper.getCurrentPharmaUser(session);
    if (user == null) throw Exception('User not authenticated');
    if (user.id != userId) throw Exception('Cannot enroll another user');

    // Check if user already has an active enrollment
    final hasActive = await TrainingAssignmentService.hasActiveEnrollment(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
    );
    if (hasActive) {
      throw Exception('You are already enrolled in this course.');
    }

    // Create a self-assigned assignment with a default due date of 30 days
    final dueDate = DateTime.now().add(const Duration(days: 30));
    final assignment = await TrainingAssignmentService.assign(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignedById: userId, // Self-assigned
      dueDate: dueDate,
      priority: 'medium',
      reason: 'Self-enrollment via course catalog',
      source: 'self',
    );

    // Create the enrollment
    final enrollment = await TrainingAssignmentService.createEnrollment(
      session,
      userId: userId,
      courseVersionId: courseVersionId,
      assignmentId: assignment.id!,
    );

    await AuditService.log(
      session,
      entityType: 'enrollment',
      entityId: enrollment.id.toString(),
      action: 'SelfEnrolled',
      newValueJson: '{"courseVersionId":$courseVersionId,"assignmentId":${assignment.id}}',
      userId: userId,
    );

    return enrollment;
  }

  /// Users who have an enrollment on any version of a course you created and published
  /// (same rules as [CourseEndpoint.listTrainerPublishedCoursesForAssignment]).
  ///
  /// When [search] and [limit] are both omitted, returns every distinct learner (legacy).
  /// When either is set, runs a bounded DB query (search uses ILIKE on name, email, employee id).
  Future<List<PharmaUser>> listLearnersEnrolledInTrainerPublishedCourses(
    Session session, {
    String? search,
    int? limit,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    final self = me!;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'assign')) {
      return [];
    }

    final courseEndpoint = CourseEndpoint();
    final courses =
        await courseEndpoint.listTrainerPublishedCoursesForAssignment(session);
    if (courses.isEmpty) return [];

    final courseIds = courses.map((c) => c.id!).toSet();
    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.inSet(courseIds),
    );
    final versionIds = versions.map((v) => v.id!).toList();
    if (versionIds.isEmpty) return [];

    final useBoundedQuery = search != null || limit != null;
    if (!useBoundedQuery) {
      final versionIdSet = versionIds.toSet();
      final enrollments = await Enrollment.db.find(
        session,
        where: (t) => t.courseVersionId.inSet(versionIdSet),
        include: Enrollment.include(user: PharmaUser.include()),
      );

      final byId = <int, PharmaUser>{};
      for (final e in enrollments) {
        final u = e.user;
        if (u?.id == null) continue;
        if (u!.organizationId != self.organizationId) continue;
        byId[u.id!] = u;
      }
      final list = byId.values.toList();
      list.sort(
        (a, b) =>
            '${a.firstName} ${a.lastName}'
                .compareTo('${b.firstName} ${b.lastName}'),
      );
      return list;
    }

    final lim = (limit ?? 100).clamp(1, 500);
    final inClause = versionIds.map((id) => id.toString()).join(',');
    final orgId = self.organizationId;
    final trimmed = search?.trim();
    final useText = trimmed != null && trimmed.isNotEmpty;
    final pat = useText ? '%${_escapeIlikePattern(trimmed)}%' : '';

    final DatabaseResult result;
    if (useText) {
      result = await session.db.unsafeQuery(
        '''
SELECT DISTINCT u.id, u."firstName", u."lastName"
FROM enrollment e
INNER JOIN pharma_user u ON u.id = e."userId"
WHERE e."courseVersionId" IN ($inClause)
  AND u."organizationId" = @orgId
  AND u.status = 'active'
  AND (
    u."firstName" ILIKE @pat OR u."lastName" ILIKE @pat
    OR u.email ILIKE @pat OR COALESCE(u."employeeId", '') ILIKE @pat
  )
ORDER BY u."firstName", u."lastName"
LIMIT @lim
''',
        parameters: QueryParameters.named({
          'orgId': orgId,
          'pat': pat,
          'lim': lim,
        }),
      );
    } else {
      result = await session.db.unsafeQuery(
        '''
SELECT DISTINCT u.id, u."firstName", u."lastName"
FROM enrollment e
INNER JOIN pharma_user u ON u.id = e."userId"
WHERE e."courseVersionId" IN ($inClause)
  AND u."organizationId" = @orgId
  AND u.status = 'active'
ORDER BY u."firstName", u."lastName"
LIMIT @lim
''',
        parameters: QueryParameters.named({
          'orgId': orgId,
          'lim': lim,
        }),
      );
    }

    final orderedIds = <int>[];
    for (final row in result) {
      final raw = row[0];
      if (raw is int) {
        orderedIds.add(raw);
      } else if (raw is BigInt) {
        orderedIds.add(raw.toInt());
      }
    }
    if (orderedIds.isEmpty) return [];

    final idSet = orderedIds.toSet();
    final users = await PharmaUser.db.find(
      session,
      where: (u) => u.id.inSet(idSet),
    );
    final byId = {for (final u in users) if (u.id != null) u.id!: u};
    return orderedIds.map((id) => byId[id]).whereType<PharmaUser>().toList();
  }

  static String _escapeIlikePattern(String s) {
    return s
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }

  /// Get all enrollments for a specific course version (trainer view).
  Future<List<Enrollment>> getEnrollmentsForCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await Enrollment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Get all assignments for a specific course version (trainer view).
  Future<List<TrainingAssignment>> getAssignmentsForCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await TrainingAssignment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: TrainingAssignment.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Get all assignments across all courses in an organization (trainer overview).
  Future<List<TrainingAssignment>> getAllAssignments(
    Session session, {
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    final assignments = await TrainingAssignment.db.find(
      session,
      include: TrainingAssignment.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
    if (organizationId != null) {
      return assignments.where((a) =>
        a.courseVersion?.course?.organizationId == organizationId
      ).toList();
    }
    return assignments;
  }

  /// Get training records for a specific course version (for analytics/learner progress).
  Future<List<TrainingRecord>> getTrainingRecordsForCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await TrainingRecord.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
  }

  /// Get enrollment progress as a fraction: completedLessons / totalLessons.
  /// Returns a map with keys: completedLessons, totalLessons, progressPct.
  Future<Map<String, String>> getEnrollmentProgress(
    Session session,
    int enrollmentId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return {'completedLessons': '0', 'totalLessons': '0', 'progressPct': '0.0'};
    }

    final enrollment = await Enrollment.db.findById(session, enrollmentId);
    if (enrollment == null) {
      return {'completedLessons': '0', 'totalLessons': '0', 'progressPct': '0.0'};
    }

    if (enrollment.status == 'completed') {
      final modules = await Module.db.find(
        session,
        where: (t) => t.courseVersionId.equals(enrollment.courseVersionId),
      );
      var total = 0;
      for (final m in modules) {
        final lessons = await Lesson.db.find(
          session,
          where: (t) => t.moduleId.equals(m.id!),
        );
        total += lessons.length;
      }
      return {'completedLessons': total.toString(), 'totalLessons': total.toString(), 'progressPct': '100.0'};
    }

    final modules = await Module.db.find(
      session,
      where: (t) => t.courseVersionId.equals(enrollment.courseVersionId),
    );

    var totalLessons = 0;
    var completedLessons = 0;
    for (final m in modules) {
      final lessons = await Lesson.db.find(
        session,
        where: (t) => t.moduleId.equals(m.id!),
      );
      totalLessons += lessons.length;
      for (final l in lessons) {
        final progress = await MaterialProgress.db.findFirstRow(
          session,
          where: (t) =>
              t.userId.equals(enrollment.userId) &
              t.materialId.equals(l.materialId),
        );
        if (progress != null && (progress.progressPct ?? 0) >= 100) {
          completedLessons++;
        }
      }
    }

    final pct = totalLessons > 0 ? (completedLessons / totalLessons * 100.0) : 0.0;
    return {
      'completedLessons': completedLessons.toString(),
      'totalLessons': totalLessons.toString(),
      'progressPct': pct.toStringAsFixed(1),
    };
  }

  /// Check if all lessons are completed for a course version by a user.
  Future<bool> isCourseContentComplete(
    Session session, {
    required int userId,
    required int courseVersionId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;

    final modules = await Module.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    for (final m in modules) {
      final lessons = await Lesson.db.find(
        session,
        where: (t) => t.moduleId.equals(m.id!),
      );
      for (final l in lessons) {
        final progress = await MaterialProgress.db.findFirstRow(
          session,
          where: (t) =>
              t.userId.equals(userId) &
              t.materialId.equals(l.materialId),
        );
        if (progress == null || (progress.progressPct ?? 0) < 100) {
          return false;
        }
      }
    }
    return true;
  }

  /// Get all certificates for a course version (trainer view).
  Future<List<Certificate>> getCertificatesForCourseVersion(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    return await Certificate.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: Certificate.include(
        user: PharmaUser.include(),
      ),
    );
  }
}
