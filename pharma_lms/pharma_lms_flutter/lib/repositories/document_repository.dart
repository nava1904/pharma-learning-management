import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';

/// Repository for documents and lifecycle. Decouples UI from client.document API.
class DocumentRepository {
  DocumentRepository([this._api]);

  dynamic get api => _api ?? client;
  final dynamic _api;

  Future<List<Document>> listDocuments({
    int? organizationId,
    String? status,
    String? search,
    int? limit,
  }) =>
      api.document.listDocuments(
        organizationId: organizationId,
        status: status,
        search: search,
        limit: limit,
      );

  Future<Document?> getDocument(int id) => api.document.getDocument(id);

  Future<Document> createDocument({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
  }) =>
      api.document.createDocument(
        title: title,
        organizationId: organizationId,
        sopNumber: sopNumber,
        description: description,
      );

  Future<Document> updateDocumentQaClassification({
    required int documentId,
    required String classification,
  }) =>
      api.document.updateDocumentQaClassification(
        documentId: documentId,
        classification: classification,
      );

  Future<List<DocumentVersion>> getDocumentVersions(int documentId) =>
      api.document.getDocumentVersions(documentId);

  Future<DocumentLifecycle?> getDocumentLifecycle(int versionId) =>
      api.document.getDocumentLifecycle(versionId);

  Future<DocumentLifecycle> transitionDocumentLifecycle({
    required int versionId,
    required String transition,
    int? userId,
    String? passwordReauth,
  }) =>
      api.document.transitionDocumentLifecycle(
        versionId: versionId,
        transition: transition,
        userId: userId,
        passwordReauth: passwordReauth,
      );
}
