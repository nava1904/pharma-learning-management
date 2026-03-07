import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Training assignment service for creating and managing assignments.
class TrainingAssignmentService {
  /// Assign a course version to a user.
  static Future<TrainingAssignment> assign(
    Session session, {
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String priority = 'medium',
    String? reason,
    String source = 'manual',
  }) async {
    final assignment = TrainingAssignment(
      userId: userId,
      courseVersionId: courseVersionId,
      assignedById: assignedById,
      dueDate: dueDate,
      priority: priority,
      reason: reason,
      source: source,
    );
    return await TrainingAssignment.db.insertRow(session, assignment);
  }

  /// Create enrollment from assignment.
  static Future<Enrollment> createEnrollment(
    Session session, {
    required int userId,
    required int courseVersionId,
    required int assignmentId,
  }) async {
    final enrollment = Enrollment(
      userId: userId,
      courseVersionId: courseVersionId,
      assignmentId: assignmentId,
      status: 'not_started',
    );
    return await Enrollment.db.insertRow(session, enrollment);
  }

  /// Assign training to all users in a department for a course version.
  static Future<List<TrainingAssignment>> assignToDepartment(
    Session session, {
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    String source = 'manual',
  }) async {
    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.departmentId.equals(departmentId),
    );

    final assignments = <TrainingAssignment>[];
    for (final user in users) {
      if (user.id != null) {
        final assignment = await assign(
          session,
          userId: user.id!,
          courseVersionId: courseVersionId,
          assignedById: assignedById,
          dueDate: dueDate,
          reason: reason,
          source: source,
        );
        assignments.add(assignment);

        await createEnrollment(
          session,
          userId: user.id!,
          courseVersionId: courseVersionId,
          assignmentId: assignment.id!,
        );
      }
    }
    return assignments;
  }
}
