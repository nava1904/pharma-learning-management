// ═══════════════════════════════════════════════════════════════════════════════
// ASSIGNED TRAINING — TrainingAssignment + Enrollment (active assignments only)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import 'employee_batch_providers.dart';

/// Maps courseVersionId → enrollment for the current user.
final employeeEnrollmentByCourseVersionProvider =
    FutureProvider<Map<int, Enrollment>>((ref) async {
  final list = await ref.watch(employeeUserEnrollmentsProvider.future);
  return {for (final e in list) e.courseVersionId: e};
});

/// UI model for Assigned Training screen + urgent banner + compliance.
final employeeAssignedTrainingModelProvider =
    FutureProvider<EmployeeAssignedTrainingModel>((ref) async {
  final assignments = await ref.watch(employeeUserAssignmentsProvider.future);
  final enrollmentsByCv = await ref.watch(employeeEnrollmentByCourseVersionProvider.future);

  final now = DateTime.now();
  final soon = now.add(const Duration(days: 3));

  final candidates = <TrainingAssignment>[];
  for (final a in assignments) {
    final e = enrollmentsByCv[a.courseVersionId];
    if (e != null && e.status == 'completed') continue;
    final overdue = a.dueDate.isBefore(now);
    final dueSoon = !a.dueDate.isBefore(now) && a.dueDate.isBefore(soon);
    if (overdue || dueSoon) candidates.add(a);
  }
  candidates.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  final urgent = candidates.isEmpty ? null : candidates.first;

  var completed = 0;
  for (final a in assignments) {
    final e = enrollmentsByCv[a.courseVersionId];
    if (e != null && e.status == 'completed') completed++;
  }

  final total = assignments.length;
  final compliancePct = total == 0 ? 0.0 : (completed / total * 100.0);

  return EmployeeAssignedTrainingModel(
    assignments: assignments,
    enrollmentByCourseVersionId: enrollmentsByCv,
    urgentAssignment: urgent,
    completedCount: completed,
    totalCount: total,
    compliancePct: compliancePct,
  );
});

class EmployeeAssignedTrainingModel {
  final List<TrainingAssignment> assignments;
  final Map<int, Enrollment> enrollmentByCourseVersionId;
  final TrainingAssignment? urgentAssignment;
  final int completedCount;
  final int totalCount;
  final double compliancePct;

  EmployeeAssignedTrainingModel({
    required this.assignments,
    required this.enrollmentByCourseVersionId,
    required this.urgentAssignment,
    required this.completedCount,
    required this.totalCount,
    required this.compliancePct,
  });

  Enrollment? enrollmentFor(TrainingAssignment a) =>
      enrollmentByCourseVersionId[a.courseVersionId];

  String statusLabel(TrainingAssignment a) {
    final e = enrollmentFor(a);
    if (e == null) return 'Not started';
    switch (e.status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In progress';
      case 'overdue':
        return 'Overdue';
      default:
        return 'Not started';
    }
  }
}
