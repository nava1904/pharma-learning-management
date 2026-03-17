import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// SOP-Course linkage management endpoint.
class SopLinkageEndpoint extends Endpoint {
  /// Link a SOP document to a course.
  Future<CourseSopLink> linkSopToCourse(
    Session session, {
    required int courseId,
    required int documentId,
    int? linkedById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    
    final existing = await CourseSopLink.db.findFirstRow(
      session,
      where: (t) =>
          t.courseId.equals(courseId) &
          t.documentId.equals(documentId) &
          t.unlinkedAt.equals(null),
    );
    if (existing != null) {
      throw Exception('SOP is already linked to this course');
    }
    
    final link = await CourseSopLink.db.insertRow(
      session,
      CourseSopLink(
        courseId: courseId,
        documentId: documentId,
        linkedById: linkedById ?? 0,
      ),
    );
    
    await AuditService.log(
      session,
      entityType: 'course_sop_link',
      entityId: link.id.toString(),
      action: 'SopLinkedToCourse',
      newValueJson: '{"courseId":$courseId,"documentId":$documentId}',
      userId: linkedById,
    );
    
    return link;
  }

  /// Unlink a SOP document from a course (soft-delete).
  Future<CourseSopLink> unlinkSopFromCourse(
    Session session, {
    required int linkId,
    int? unlinkedById,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    
    final link = await CourseSopLink.db.findById(session, linkId);
    if (link == null) throw Exception('Link not found');
    if (link.unlinkedAt != null) throw Exception('Link already removed');
    
    final updated = link.copyWith(unlinkedAt: DateTime.now());
    final result = await CourseSopLink.db.updateRow(session, updated);
    
    await AuditService.log(
      session,
      entityType: 'course_sop_link',
      entityId: linkId.toString(),
      action: 'SopUnlinkedFromCourse',
      oldValueJson: '{"courseId":${link.courseId},"documentId":${link.documentId}}',
      userId: unlinkedById,
    );
    
    return result;
  }

  /// Get all active SOP links for a course.
  Future<List<CourseSopLink>> getLinkedSops(
    Session session, {
    required int courseId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    
    return await CourseSopLink.db.find(
      session,
      where: (t) => t.courseId.equals(courseId) & t.unlinkedAt.equals(null),
      include: CourseSopLink.include(
        document: Document.include(),
        linkedBy: PharmaUser.include(),
      ),
    );
  }

  /// Get all courses linked to a specific SOP document.
  Future<List<CourseSopLink>> getCoursesForSop(
    Session session, {
    required int documentId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    
    return await CourseSopLink.db.find(
      session,
      where: (t) => t.documentId.equals(documentId) & t.unlinkedAt.equals(null),
      include: CourseSopLink.include(
        course: Course.include(),
        linkedBy: PharmaUser.include(),
      ),
    );
  }
}
