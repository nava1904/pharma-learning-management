import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';

/// Repository for training, enrollment, certificates, and e-signatures.
/// Decouples UI from client.training API.
class TrainingRepository {
  TrainingRepository([this._api]);

  dynamic get api => _api ?? client;
  final dynamic _api;

  Future<List<SignatureMeaning>> listSignatureMeanings() =>
      api.training.listSignatureMeanings();

  Future<List<TrainingAssignment>> getAssignmentsForUser(int userId) =>
      api.training.getAssignmentsForUser(userId);

  Future<List<Enrollment>> getEnrollmentsForUser(int userId) =>
      api.training.getEnrollmentsForUser(userId);

  Future<String?> getEnrollmentResumePosition(int enrollmentId) =>
      api.training.getEnrollmentResumePosition(enrollmentId);

  Future<Enrollment?> getEnrollmentById(int enrollmentId) =>
      api.training.getEnrollmentById(enrollmentId);

  Future<Enrollment> acknowledgeRetraining({
    required int enrollmentId,
    required int userId,
    required String signatureMeaning,
    String? passwordReauth,
  }) =>
      api.training.acknowledgeRetraining(
        enrollmentId: enrollmentId,
        userId: userId,
        signatureMeaning: signatureMeaning,
        passwordReauth: passwordReauth,
      );

  Future<List<Certificate>> getCertificatesForUser(int userId) =>
      api.training.getCertificatesForUser(userId);

  Future<List<TrainingRecord>> getTrainingRecordsForUser(int userId) =>
      api.training.getTrainingRecordsForUser(userId);

  Future<Certificate?> getCertificateById(int certificateId) =>
      api.training.getCertificateById(certificateId);

  Future<int> createTrainingSignature({
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordReauth,
  }) =>
      api.training.createTrainingSignature(
        userId: userId,
        signatureMeaning: signatureMeaning,
        entityType: entityType,
        entityId: entityId,
        passwordReauth: passwordReauth,
      );

  Future<Certificate> completeTraining({
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required int esignatureId,
    int? score,
  }) =>
      api.training.completeTraining(
        enrollmentId: enrollmentId,
        userId: userId,
        courseVersionId: courseVersionId,
        esignatureId: esignatureId,
        score: score,
      );

  Future<TrainingAssignment> assignTraining({
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String priority = 'medium',
    String? reason,
    String source = 'manual',
    bool forceReassign = false,
  }) =>
      api.training.assignTraining(
        userId: userId,
        courseVersionId: courseVersionId,
        assignedById: assignedById,
        dueDate: dueDate,
        priority: priority,
        reason: reason,
        source: source,
        forceReassign: forceReassign,
      );

  Future<TrainingAssignment> cancelAssignment({
    required int assignmentId,
    required int cancelledById,
    String? reason,
  }) =>
      api.training.cancelAssignment(
        assignmentId: assignmentId,
        cancelledById: cancelledById,
        reason: reason,
      );

  Future<List<ElectronicSignature>> listElectronicSignatures({
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    int limit = 100,
  }) =>
      api.training.listElectronicSignatures(
        from: from,
        to: to,
        entityType: entityType,
        userId: userId,
        limit: limit,
      );

  Future<SignatureVerificationResult> getSignatureWithIntegrityCheck(
    int signatureId,
  ) =>
      api.training.getSignatureWithIntegrityCheck(signatureId);

  Future<List<TrainingRecordAnnotation>> listAnnotations(
    int trainingRecordId,
  ) =>
      api.training.listAnnotations(trainingRecordId);

  Future<TrainingRecordAnnotation> addAnnotation({
    required int trainingRecordId,
    required int authorId,
    required String note,
  }) =>
      api.training.addAnnotation(
        trainingRecordId: trainingRecordId,
        authorId: authorId,
        note: note,
      );
}
