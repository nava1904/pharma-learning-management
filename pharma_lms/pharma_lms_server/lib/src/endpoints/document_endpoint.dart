import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/esignature_service.dart';

/// Document Control domain endpoint.
class DocumentEndpoint extends Endpoint {
  Future<List<Document>> listDocuments(
    Session session, {
    int? organizationId,
    String? documentType,
  }) async {
    if (organizationId != null) {
      var results = await Document.db.find(
        session,
        where: (t) => t.organizationId.equals(organizationId),
      );
      if (documentType != null) {
        results = results.where((d) => d.documentType == documentType).toList();
      }
      return results;
    }
    var results = await Document.db.find(session);
    if (documentType != null) {
      results = results.where((d) => d.documentType == documentType).toList();
    }
    return results;
  }

  Future<Document?> getDocument(Session session, int id) async {
    return await Document.db.findById(session, id);
  }

  /// QA gate: classify SOP update as training_required or no_training_required.
  Future<Document> updateDocumentQaClassification(
    Session session, {
    required int documentId,
    required String trainingRequiredByQa,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
  }) async {
    final doc = await Document.db.findById(session, documentId);
    if (doc == null) throw Exception('Document not found');
    var updated = doc.copyWith(trainingRequiredByQa: trainingRequiredByQa);
    if (affectedDepartmentIdsJson != null) {
      updated = updated.copyWith(affectedDepartmentIdsJson: affectedDepartmentIdsJson);
    }
    if (affectedRoleIdsJson != null) {
      updated = updated.copyWith(affectedRoleIdsJson: affectedRoleIdsJson);
    }
    final result = await Document.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'document',
      entityId: documentId.toString(),
      action: 'DocumentQaClassificationUpdated',
      newValueJson: '{"trainingRequiredByQa":"$trainingRequiredByQa"}',
    );
    return result;
  }

  Future<List<DocumentVersion>> getDocumentVersions(
    Session session,
    int documentId,
  ) async {
    return await DocumentVersion.db.find(
      session,
      where: (t) => t.documentId.equals(documentId),
    );
  }

  Future<Document> createDocument(
    Session session, {
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
  }) async {
    final doc = Document(
      title: title,
      documentNumber: documentNumber,
      documentType: documentType,
      organizationId: organizationId,
    );
    return await Document.db.insertRow(session, doc);
  }

  Future<DocumentVersion> createDocumentVersion(
    Session session, {
    required int documentId,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  }) async {
    final docVersion = DocumentVersion(
      documentId: documentId,
      version: version,
      storageKey: storageKey,
      effectiveDate: effectiveDate,
      obsoleteDate: obsoleteDate,
    );
    return await DocumentVersion.db.insertRow(session, docVersion);
  }

  Future<List<DocumentLifecycle>> getDocumentLifecycle(
    Session session,
    int documentVersionId,
  ) async {
    return await DocumentLifecycle.db.find(
      session,
      where: (t) => t.documentVersionId.equals(documentVersionId),
    );
  }

  /// Transition document version lifecycle (QA-02). Enforces: draft→review→approved→effective→obsolete.
  /// Approved/Effective require QA e-sign. Obsolete requires reason.
  Future<DocumentLifecycle> transitionDocumentLifecycle(
    Session session, {
    required int documentVersionId,
    required String newState,
    String? obsoleteReason,
    required int userId,
    required String signatureMeaning,
    String? passwordReauthHash,
    String? ipAddress,
  }) async {
    final validTransitions = {
      'draft': ['review'],
      'review': ['approved'],
      'approved': ['effective'],
      'effective': ['obsolete'],
      'obsolete': [],
    };

    final versions = await DocumentLifecycle.db.find(
      session,
      where: (t) => t.documentVersionId.equals(documentVersionId),
      orderBy: (t) => t.changedAt,
      orderDescending: true,
      limit: 1,
    );
    final currentState = versions.isNotEmpty ? versions.first.state : 'draft';

    final allowed = validTransitions[currentState];
    if (allowed == null || !allowed.contains(newState)) {
      throw Exception('Invalid transition: $currentState → $newState');
    }

    if (newState == 'obsolete' &&
        (obsoleteReason == null || obsoleteReason.trim().isEmpty)) {
      throw Exception('Obsolete transition requires obsoleteReason');
    }

    if (newState == 'approved' || newState == 'effective') {
      await EsignatureService.sign(
        session,
        userId: userId,
        signatureMeaning: signatureMeaning,
        entityType: 'document_lifecycle',
        entityId: documentVersionId.toString(),
        passwordReauthHash: passwordReauthHash,
        ipAddress: ipAddress,
      );
      final lifecycle = DocumentLifecycle(
        documentVersionId: documentVersionId,
        state: newState,
        changedById: userId,
      );
      final inserted = await DocumentLifecycle.db.insertRow(session, lifecycle);
      if (newState == 'effective') {
        final dv = await DocumentVersion.db.findById(session, documentVersionId);
        if (dv != null) {
          await DocumentVersion.db.updateRow(
            session,
            dv.copyWith(effectiveDate: DateTime.now()),
          );
        }
      }
      if (newState == 'obsolete') {
        final dv = await DocumentVersion.db.findById(session, documentVersionId);
        if (dv != null) {
          await DocumentVersion.db.updateRow(
            session,
            dv.copyWith(obsoleteDate: DateTime.now()),
          );
        }
      }
      await AuditService.log(
        session,
        entityType: 'document_version',
        entityId: documentVersionId.toString(),
        action: 'DocumentLifecycleTransition',
        newValueJson: '{"state":"$newState","changedById":$userId}',
        userId: userId,
      );
      return inserted;
    }

    final lifecycle = DocumentLifecycle(
      documentVersionId: documentVersionId,
      state: newState,
      changedById: userId,
    );
    final inserted = await DocumentLifecycle.db.insertRow(session, lifecycle);
    if (newState == 'obsolete') {
      final dv = await DocumentVersion.db.findById(session, documentVersionId);
      if (dv != null) {
        await DocumentVersion.db.updateRow(
          session,
          dv.copyWith(obsoleteDate: DateTime.now()),
        );
      }
    }
    final reasonEscaped = obsoleteReason != null
        ? obsoleteReason.replaceAll('\\', '\\\\').replaceAll('"', '\\"')
        : '';
    await AuditService.log(
      session,
      entityType: 'document_version',
      entityId: documentVersionId.toString(),
      action: 'DocumentLifecycleTransition',
      newValueJson: newState == 'obsolete'
          ? '{"state":"obsolete","obsoleteReason":"$reasonEscaped","changedById":$userId}'
          : '{"state":"$newState","changedById":$userId}',
      userId: userId,
    );
    return inserted;
  }

  Future<ApprovalWorkflow> createApprovalStep(
    Session session, {
    required int documentVersionId,
    required int step,
    required int approverId,
    String status = 'pending',
    int? esignatureId,
  }) async {
    final workflow = ApprovalWorkflow(
      documentVersionId: documentVersionId,
      step: step,
      approverId: approverId,
      status: status,
      esignatureId: esignatureId,
    );
    return await ApprovalWorkflow.db.insertRow(session, workflow);
  }
}
