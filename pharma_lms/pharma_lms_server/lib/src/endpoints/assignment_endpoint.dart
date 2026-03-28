import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

class AssignmentEndpoint extends Endpoint {
  Future<Assignment> createAssignment(
    Session session, {
    required int lessonId,
    required String title,
    String? instructions,
    String? allowedFileTypes,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final assignment = Assignment(
      lessonId: lessonId,
      title: title,
      instructions: instructions,
      allowedFileTypes: allowedFileTypes,
    );
    final result = await Assignment.db.insertRow(session, assignment);
    await AuditService.log(
      session,
      entityType: 'assignment',
      entityId: result.id.toString(),
      action: 'AssignmentCreated',
      newValueJson: '{"lessonId":$lessonId,"title":"$title"}',
    );
    return result;
  }

  Future<Assignment?> getAssignment(Session session, int assignmentId) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    return await Assignment.db.findById(session, assignmentId);
  }

  Future<List<Assignment>> listByLesson(
    Session session, {
    required int lessonId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    return await Assignment.db.find(
      session,
      where: (t) => t.lessonId.equals(lessonId),
    );
  }

  Future<Assignment> updateAssignment(
    Session session, {
    required int assignmentId,
    String? title,
    String? instructions,
    String? allowedFileTypes,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final assignment = await Assignment.db.findById(session, assignmentId);
    if (assignment == null) throw Exception('Assignment not found');
    final updated = assignment.copyWith(
      title: title ?? assignment.title,
      instructions: instructions ?? assignment.instructions,
      allowedFileTypes: allowedFileTypes ?? assignment.allowedFileTypes,
    );
    return await Assignment.db.updateRow(session, updated);
  }

  Future<bool> deleteAssignment(
    Session session, {
    required int assignmentId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final assignment = await Assignment.db.findById(session, assignmentId);
    if (assignment == null) throw Exception('Assignment not found');
    await Assignment.db.deleteRow(session, assignment);
    return true;
  }

  // Submission methods

  Future<AssignmentSubmission> submitAssignment(
    Session session, {
    required int assignmentId,
    int? userId,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
  }) async {
    final submission = AssignmentSubmission(
      assignmentId: assignmentId,
      userId: userId,
      submissionUrl: submissionUrl,
      storageKey: storageKey,
      fileName: fileName,
      status: 'submitted',
    );
    final result = await AssignmentSubmission.db.insertRow(session, submission);
    await AuditService.log(
      session,
      entityType: 'assignment_submission',
      entityId: result.id.toString(),
      action: 'AssignmentSubmitted',
      newValueJson: '{"assignmentId":$assignmentId,"userId":$userId}',
    );
    return result;
  }

  Future<List<AssignmentSubmission>> listSubmissions(
    Session session, {
    required int assignmentId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    return await AssignmentSubmission.db.find(
      session,
      where: (t) => t.assignmentId.equals(assignmentId),
    );
  }

  Future<AssignmentSubmission> gradeSubmission(
    Session session, {
    required int submissionId,
    required int grade,
    String? feedback,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final submission = await AssignmentSubmission.db.findById(session, submissionId);
    if (submission == null) throw Exception('Submission not found');
    final updated = submission.copyWith(
      grade: grade,
      feedback: feedback,
      status: 'graded',
      gradedAt: DateTime.now(),
    );
    final result = await AssignmentSubmission.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'assignment_submission',
      entityId: submissionId.toString(),
      action: 'AssignmentGraded',
      newValueJson: '{"grade":$grade}',
    );
    return result;
  }
}
