import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// Notification Template management endpoint for Admin Portal.
/// Manages notification templates for various training events.
class NotificationTemplateEndpoint extends Endpoint {
  /// List all notification templates for an organization.
  Future<List<NotificationTemplate>> listTemplates(
    Session session, {
    required int organizationId,
    String? status,
    String? type,
    String? channel,
    int? limit,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'read')) return [];
    
    var whereExpr = NotificationTemplate.t.organizationId.equals(organizationId);
    
    if (status != null && status.isNotEmpty) {
      whereExpr = whereExpr & NotificationTemplate.t.status.equals(status);
    }
    
    if (type != null && type.isNotEmpty) {
      whereExpr = whereExpr & NotificationTemplate.t.type.equals(type);
    }
    
    if (channel != null && channel.isNotEmpty) {
      whereExpr = whereExpr & NotificationTemplate.t.channel.equals(channel);
    }
    
    return await NotificationTemplate.db.find(
      session,
      where: (t) => whereExpr,
      include: NotificationTemplate.include(
        organization: Organization.include(),
        createdBy: PharmaUser.include(),
      ),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Get a single notification template by ID.
  Future<NotificationTemplate?> getTemplate(Session session, int templateId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'read')) return null;
    
    return await NotificationTemplate.db.findById(
      session,
      templateId,
      include: NotificationTemplate.include(
        organization: Organization.include(),
        createdBy: PharmaUser.include(),
      ),
    );
  }

  /// Create a new notification template.
  Future<NotificationTemplate?> createTemplate(
    Session session, {
    required int organizationId,
    required String name,
    required String type,
    required String channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    String status = 'draft',
  }) async {
    final currentUser = await RbacHelper.getCurrentPharmaUser(session);
    if (currentUser == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'create')) return null;
    
    final template = NotificationTemplate(
      organizationId: organizationId,
      name: name,
      type: type,
      channel: channel,
      triggerEvent: triggerEvent,
      subject: subject,
      bodyTemplate: bodyTemplate,
      status: status,
      createdById: currentUser.id!,
    );
    
    return await NotificationTemplate.db.insertRow(session, template);
  }

  /// Update a notification template.
  Future<NotificationTemplate?> updateTemplate(
    Session session,
    int templateId, {
    String? name,
    String? type,
    String? channel,
    String? triggerEvent,
    String? subject,
    String? bodyTemplate,
    String? status,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'update')) return null;
    
    final existing = await NotificationTemplate.db.findById(session, templateId);
    if (existing == null) return null;
    
    final updated = existing.copyWith(
      name: name ?? existing.name,
      type: type ?? existing.type,
      channel: channel ?? existing.channel,
      triggerEvent: triggerEvent ?? existing.triggerEvent,
      subject: subject ?? existing.subject,
      bodyTemplate: bodyTemplate ?? existing.bodyTemplate,
      status: status ?? existing.status,
      updatedAt: DateTime.now(),
    );
    
    return await NotificationTemplate.db.updateRow(session, updated);
  }

  /// Delete a notification template.
  Future<bool> deleteTemplate(Session session, int templateId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'delete')) return false;
    
    final deleted = await NotificationTemplate.db.deleteWhere(
      session,
      where: (t) => t.id.equals(templateId),
    );
    
    return deleted.isNotEmpty;
  }

  /// Get template statistics for dashboard.
  Future<Map<String, int>> getTemplateStats(Session session, int organizationId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return {};
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'read')) return {};
    
    final templates = await NotificationTemplate.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    
    return {
      'total': templates.length,
      'active': templates.where((t) => t.status == 'active').length,
      'draft': templates.where((t) => t.status == 'draft').length,
      'inactive': templates.where((t) => t.status == 'inactive').length,
      'email': templates.where((t) => t.channel == 'email').length,
      'push': templates.where((t) => t.channel == 'push').length,
      'sms': templates.where((t) => t.channel == 'sms').length,
      'in_app': templates.where((t) => t.channel == 'in_app').length,
    };
  }
  
  /// Duplicate a template.
  Future<NotificationTemplate?> duplicateTemplate(
    Session session, 
    int templateId, {
    String? newName,
  }) async {
    final currentUser = await RbacHelper.getCurrentPharmaUser(session);
    if (currentUser == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'create')) return null;
    
    final existing = await NotificationTemplate.db.findById(session, templateId);
    if (existing == null) return null;
    
    final duplicate = NotificationTemplate(
      organizationId: existing.organizationId,
      name: newName ?? '${existing.name} (Copy)',
      type: existing.type,
      channel: existing.channel,
      triggerEvent: existing.triggerEvent,
      subject: existing.subject,
      bodyTemplate: existing.bodyTemplate,
      status: 'draft',
      createdById: currentUser.id!,
    );
    
    return await NotificationTemplate.db.insertRow(session, duplicate);
  }
}
