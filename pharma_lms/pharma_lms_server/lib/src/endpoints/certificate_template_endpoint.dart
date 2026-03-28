import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// CRUD for certificate templates (Admin Portal).
class CertificateTemplateEndpoint extends Endpoint {
  Future<List<CertificateTemplate>> listTemplates(
    Session session, {
    required int organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'read')) return [];

    return await CertificateTemplate.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  Future<CertificateTemplate?> getTemplate(Session session, int id) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'certificate', action: 'read')) return null;
    return await CertificateTemplate.db.findById(session, id);
  }

  Future<CertificateTemplate> createTemplate(
    Session session, {
    required int organizationId,
    required String name,
    required String htmlTemplate,
    bool isDefault = false,
  }) async {
    final user = await RbacHelper.getCurrentPharmaUser(session);
    await RbacHelper.requirePermission(session, resource: 'certificate', action: 'write');

    if (isDefault) {
      await _clearDefaults(session, organizationId);
    }

    final template = CertificateTemplate(
      organizationId: organizationId,
      name: name,
      htmlTemplate: htmlTemplate,
      isDefault: isDefault,
    );

    final result = await CertificateTemplate.db.insertRow(session, template);

    await AuditService.log(
      session,
      entityType: 'certificate_template',
      entityId: result.id.toString(),
      action: 'CertificateTemplateCreated',
      newValueJson: '{"name":"$name","isDefault":$isDefault}',
      userId: user?.id,
    );

    return result;
  }

  Future<CertificateTemplate> updateTemplate(
    Session session, {
    required int templateId,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'certificate', action: 'write');

    final existing = await CertificateTemplate.db.findById(session, templateId);
    if (existing == null) throw Exception('Template not found');

    if (isDefault == true) {
      await _clearDefaults(session, existing.organizationId);
    }

    final updated = existing.copyWith(
      name: name ?? existing.name,
      htmlTemplate: htmlTemplate ?? existing.htmlTemplate,
      isDefault: isDefault ?? existing.isDefault,
    );

    return await CertificateTemplate.db.updateRow(session, updated);
  }

  Future<bool> deleteTemplate(Session session, int templateId) async {
    await RbacHelper.requirePermission(session, resource: 'certificate', action: 'write');

    final existing = await CertificateTemplate.db.findById(session, templateId);
    if (existing == null) return false;

    await CertificateTemplate.db.deleteRow(session, existing);
    return true;
  }

  /// Preview: merge sample data into template HTML and return the resulting HTML string.
  Future<String> previewTemplate(
    Session session, {
    required String htmlTemplate,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return '';
    return _mergeSampleData(htmlTemplate);
  }

  Future<void> _clearDefaults(Session session, int organizationId) async {
    final existing = await CertificateTemplate.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId) & t.isDefault.equals(true),
    );
    for (final tpl in existing) {
      await CertificateTemplate.db.updateRow(session, tpl.copyWith(isDefault: false));
    }
  }

  String _mergeSampleData(String html) {
    return html
        .replaceAll('{{learnerName}}', 'Jane Doe')
        .replaceAll('{{courseName}}', 'GMP Fundamentals')
        .replaceAll('{{issueDate}}', DateTime.now().toIso8601String().split('T').first)
        .replaceAll('{{expiryDate}}', DateTime.now().add(Duration(days: 365)).toIso8601String().split('T').first)
        .replaceAll('{{evaluator}}', 'Dr. Smith')
        .replaceAll('{{qrCode}}', 'https://verify.example.com/cert/SAMPLE')
        .replaceAll('{{organizationName}}', 'PharmaCorp Inc.');
  }
}
