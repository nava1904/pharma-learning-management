import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

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
