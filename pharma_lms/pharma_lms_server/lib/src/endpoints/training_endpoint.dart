import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';
import '../services/training_assignment_service.dart';

/// Training Assignment domain endpoint.
class TrainingEndpoint extends Endpoint {
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
  }) async {
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
    return assignment;
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

  Future<List<Certificate>> getCertificatesForUser(
    Session session,
    int userId,
  ) async {
    return await Certificate.db.find(
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

    return certificate;
  }
}
