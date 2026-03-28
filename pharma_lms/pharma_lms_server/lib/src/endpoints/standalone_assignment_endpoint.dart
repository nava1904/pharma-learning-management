import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// Standalone trainer assignments (not tied to a course lesson).
class StandaloneAssignmentEndpoint extends Endpoint {
  bool _sameOrg(PharmaUser me, int organizationId) {
    final oid = me.organizationId;
    if (oid == 0) return true; // dev bypass user
    return oid == organizationId;
  }

  Future<StandaloneAssignment?> createStandaloneAssignment(
    Session session, {
    required int organizationId,
    required String title,
    String? instructions,
    required DateTime dueAt,
    String contentKind = 'open_ended',
    int? questionBankId,
    int? courseVersionId,
    String targetType = 'individual',
    int? targetDepartmentId,
    int? targetBatchId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'assign') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'create')) {
      return null;
    }
    if (!_sameOrg(me!, organizationId)) return null;

    if (questionBankId != null) {
      final qb = await QuestionBank.db.findById(session, questionBankId);
      if (qb == null || !_sameOrg(me, qb.organizationId)) return null;
    }

    final row = StandaloneAssignment(
      organizationId: organizationId,
      createdById: me.id!,
      title: title,
      instructions: instructions,
      dueAt: dueAt,
      contentKind: contentKind,
      questionBankId: questionBankId,
      courseVersionId: courseVersionId,
      targetType: targetType,
      targetDepartmentId: targetDepartmentId,
      targetBatchId: targetBatchId,
      status: 'draft',
    );
    return StandaloneAssignment.db.insertRow(session, row);
  }

  Future<StandaloneAssignment?> updateStandaloneAssignment(
    Session session,
    int assignmentId, {
    String? title,
    String? instructions,
    DateTime? dueAt,
    String? contentKind,
    int? questionBankId,
    int? courseVersionId,
    String? targetType,
    int? targetDepartmentId,
    int? targetBatchId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'assign') &&
        !await RbacHelper.hasPermission(session, resource: 'training', action: 'update')) {
      return null;
    }

    final existing = await StandaloneAssignment.db.findById(session, assignmentId);
    if (existing == null || !_sameOrg(me!, existing.organizationId)) return null;
    if (existing.status != 'draft') return existing;

    if (questionBankId != null) {
      final qb = await QuestionBank.db.findById(session, questionBankId);
      if (qb == null || !_sameOrg(me, qb.organizationId)) return null;
    }

    return StandaloneAssignment.db.updateRow(
      session,
      existing.copyWith(
        title: title ?? existing.title,
        instructions: instructions ?? existing.instructions,
        dueAt: dueAt ?? existing.dueAt,
        contentKind: contentKind ?? existing.contentKind,
        questionBankId: questionBankId ?? existing.questionBankId,
        courseVersionId: courseVersionId ?? existing.courseVersionId,
        targetType: targetType ?? existing.targetType,
        targetDepartmentId: targetDepartmentId ?? existing.targetDepartmentId,
        targetBatchId: targetBatchId ?? existing.targetBatchId,
      ),
    );
  }

  /// Publishes a draft assignment and creates recipient rows + in-app notifications.
  Future<StandaloneAssignment?> publishStandaloneAssignment(
    Session session,
    int assignmentId, {
    List<int>? individualUserIds,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'assign')) {
      return null;
    }

    final a = await StandaloneAssignment.db.findById(session, assignmentId);
    if (a == null || !_sameOrg(me!, a.organizationId)) return null;
    if (a.status != 'draft') return a;

    final userIds = <int>{};
    switch (a.targetType) {
      case 'individual':
        if (individualUserIds == null || individualUserIds.isEmpty) {
          throw Exception('individualUserIds required when targetType is individual');
        }
        userIds.addAll(individualUserIds);
        break;
      case 'batch':
        if (a.targetBatchId == null) {
          throw Exception('targetBatchId required when targetType is batch');
        }
        final batch = await TrainingBatch.db.findById(session, a.targetBatchId!);
        if (batch == null || batch.organizationId != a.organizationId) {
          throw Exception('Invalid batch for this organization');
        }
        final parts = await TrainingBatchParticipant.db.find(
          session,
          where: (t) => t.batchId.equals(a.targetBatchId!),
        );
        userIds.addAll(parts.map((p) => p.userId));
        break;
      case 'department':
        if (a.targetDepartmentId == null) {
          throw Exception('targetDepartmentId required when targetType is department');
        }
        final deptUsers = await PharmaUser.db.find(
          session,
          where: (t) =>
              t.organizationId.equals(a.organizationId) &
              t.departmentId.equals(a.targetDepartmentId!),
        );
        userIds.addAll(deptUsers.map((u) => u.id!).whereType<int>());
        break;
      default:
        throw Exception('Unknown targetType: ${a.targetType}');
    }

    final valid = <int>[];
    for (final uid in userIds) {
      final u = await PharmaUser.db.findById(session, uid);
      if (u != null && u.organizationId == a.organizationId) {
        valid.add(uid);
      }
    }

    if (valid.isEmpty) {
      throw Exception('No recipients resolved for this assignment');
    }

    final now = DateTime.now();
    var published = await StandaloneAssignment.db.updateRow(
      session,
      a.copyWith(
        status: 'published',
        publishedAt: now,
      ),
    );

    final existing = await StandaloneAssignmentRecipient.db.find(
      session,
      where: (t) => t.assignmentId.equals(assignmentId),
    );
    final existingUserIds = existing.map((e) => e.userId).toSet();

    for (final uid in valid) {
      if (existingUserIds.contains(uid)) continue;
      await StandaloneAssignmentRecipient.db.insertRow(
        session,
        StandaloneAssignmentRecipient(
          assignmentId: assignmentId,
          userId: uid,
          status: 'pending',
        ),
      );
      try {
        await Notification.db.insertRow(
          session,
          Notification(
            userId: uid,
            type: 'standalone_assignment_assigned',
            body:
                'New assignment: "${a.title}". Due ${a.dueAt.toIso8601String().split('T').first}.',
            sentAt: now,
            deliveryStatus: 'delivered',
            channel: 'in_app',
            createdAt: now,
          ),
        );
      } catch (_) {}
    }

    return published;
  }

  Future<List<StandaloneAssignment>> listStandaloneAssignmentsForOrganization(
    Session session,
    int organizationId, {
    String? status,
    int? limit,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return [];
    }
    if (!_sameOrg(me!, organizationId)) return [];

    var whereExpr = StandaloneAssignment.t.organizationId.equals(organizationId);
    if (status != null && status.isNotEmpty) {
      whereExpr = whereExpr & StandaloneAssignment.t.status.equals(status);
    }

    return StandaloneAssignment.db.find(
      session,
      where: (_) => whereExpr,
      orderBy: (t) => t.dueAt,
      orderDescending: true,
      limit: limit ?? 200,
      include: StandaloneAssignment.include(
        questionBank: QuestionBank.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        createdBy: PharmaUser.include(),
      ),
    );
  }

  Future<StandaloneAssignment?> getStandaloneAssignment(Session session, int assignmentId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return null;
    }
    final a = await StandaloneAssignment.db.findById(
      session,
      assignmentId,
      include: StandaloneAssignment.include(
        questionBank: QuestionBank.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        createdBy: PharmaUser.include(),
      ),
    );
    if (a == null || !_sameOrg(me!, a.organizationId)) return null;
    return a;
  }

  /// Recipients for the current user (employee), with assignment embedded.
  Future<List<StandaloneAssignmentRecipient>> listMyStandaloneAssignmentRecipients(
    Session session,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return [];
    }

    return StandaloneAssignmentRecipient.db.find(
      session,
      where: (t) => t.userId.equals(me!.id!),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: StandaloneAssignmentRecipient.include(
        assignment: StandaloneAssignment.include(
          questionBank: QuestionBank.include(),
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      ),
    );
  }

  Future<StandaloneAssignmentRecipient?> getStandaloneAssignmentRecipient(
    Session session,
    int recipientId,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) {
      return null;
    }

    final row = await StandaloneAssignmentRecipient.db.findById(
      session,
      recipientId,
      include: StandaloneAssignmentRecipient.include(
        assignment: StandaloneAssignment.include(
          questionBank: QuestionBank.include(),
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
        user: PharmaUser.include(),
      ),
    );
    if (row == null) return null;
    final a = await StandaloneAssignment.db.findById(session, row.assignmentId);
    if (a == null) return null;

    if (row.userId == me!.id) {
      return row;
    }
    if (!_sameOrg(me, a.organizationId)) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'assign')) {
      return null;
    }
    return row;
  }

  Future<StandaloneAssignmentRecipient?> submitStandaloneAssignment(
    Session session,
    int recipientId, {
    required String responseJson,
  }) async {
    final me = await RbacHelper.requireAuthenticated(session);
    final row = await StandaloneAssignmentRecipient.db.findById(session, recipientId);
    if (row == null || row.userId != me.id) {
      throw RbacException('Not allowed to submit this assignment');
    }
    final a = await StandaloneAssignment.db.findById(session, row.assignmentId);
    if (a == null || a.status != 'published') {
      throw Exception('Assignment is not available for submission');
    }

    final now = DateTime.now();
    return StandaloneAssignmentRecipient.db.updateRow(
      session,
      row.copyWith(
        status: 'submitted',
        submittedAt: now,
        responseJson: responseJson,
      ),
    );
  }
}
