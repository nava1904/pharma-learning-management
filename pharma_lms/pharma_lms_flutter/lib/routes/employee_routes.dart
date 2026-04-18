// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE PORTAL ROUTES
// ═══════════════════════════════════════════════════════════════════════════════
// All routes under the /employee namespace, wrapped in EmployeeShellV2.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:go_router/go_router.dart';

import '../features/assessment/assessment_v2.dart';
import '../features/course_viewer/course_viewer_screen_v2.dart';
import '../features/my_learning/my_training_screen.dart';
import '../features/course_catalog/course_catalog_screen_redesigned.dart';
import '../features/training_history/training_history_v2.dart';
import '../features/auth/mfa_enrollment_screen.dart';
import '../features/credentials/certification_screen_v2.dart';
import '../features/profile/profile_settings_screen.dart';
import '../features/assessment/assessment_list_screen.dart';
import '../features/shared/messaging_inbox_screen.dart';
import '../features/waiver/training_waiver_screen.dart';
import '../features/downloads/downloads_screen.dart';
import '../features/employee_dashboard/batches/employee_batch_detail_screen.dart';
import '../features/employee_dashboard/batches/employee_my_batches_dashboard_screen.dart';
import '../features/employee_dashboard/batches/employee_assigned_training_screen.dart';
import '../features/employee_dashboard/standalone_assignments_screen.dart';
import '../features/employee_dashboard/operator_qualification_screen.dart';
import '../features/employee_dashboard/notifications/employee_notification_screen.dart';
import '../features/employee_dashboard/compliance/employee_compliance_detail_screen.dart';
import '../features/employee_dashboard/calendar/employee_training_calendar_screen.dart';
import '../features/employee_dashboard/documents/employee_document_screen.dart';
import '../features/employee_dashboard/employee_dashboard_v2.dart';
import '../layout/employee_shell_v2.dart';

Map<String, dynamic> _extraMap(Object? extra) {
  if (extra is Map<String, dynamic>) return extra;
  if (extra is Map) return Map<String, dynamic>.from(extra);
  return const {};
}

int? _extraInt(Map<String, dynamic> m, String key) {
  final v = m[key];
  if (v is int) return v;
  return int.tryParse(v?.toString() ?? '');
}

/// All Employee Portal routes (ShellRoute wrapping EmployeeShellV2).
List<RouteBase> get employeeRoutes => [
      ShellRoute(
        builder: (context, state, child) => EmployeeShellV2(
          currentPath: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/employee',
            builder: (context, state) => const EmployeeDashboardV2(),
            routes: [
              // Assessment under employee namespace
              GoRoute(
                path: 'assessment/:courseId',
                builder: (context, state) {
                  final m = _extraMap(state.extra);
                  final courseVersionId = _extraInt(m, 'courseVersionId');
                  final enrollmentId = _extraInt(m, 'enrollmentId');
                  final forceRetake = m['forceRetake'] == true;
                  return AssessmentScreenV2(
                    key: ValueKey(
                      'employee-assessment-${courseVersionId ?? 0}-$enrollmentId-$forceRetake',
                    ),
                    courseVersionId: courseVersionId ?? 0,
                    enrollmentId: enrollmentId,
                    forceRetake: forceRetake,
                  );
                },
              ),
              // Course viewer
              GoRoute(
                path: 'course/:courseId',
                builder: (context, state) {
                  final courseId = state.pathParameters['courseId'] ?? '';
                  final m = _extraMap(state.extra);
                  return CourseViewerScreenV2(
                    courseId: courseId,
                    courseVersionId: _extraInt(m, 'courseVersionId'),
                    enrollmentId: _extraInt(m, 'enrollmentId'),
                    userId: _extraInt(m, 'userId'),
                    courseTitle: m['courseTitle']?.toString(),
                    enrollmentStatus: m['enrollmentStatus']?.toString(),
                  );
                },
              ),
              GoRoute(
                path: 'my-training',
                builder: (context, state) => const MyTrainingScreen(),
              ),
              GoRoute(
                path: 'catalog',
                builder: (context, state) => const CourseCatalogScreenRedesigned(),
              ),
              GoRoute(
                path: 'training-history',
                builder: (context, state) => const TrainingHistoryV2(),
              ),
              GoRoute(
                path: 'mfa',
                builder: (context, state) => const MfaEnrollmentScreen(),
              ),
              GoRoute(
                path: 'credentials',
                builder: (context, state) => const CertificationScreenV2(),
              ),
              GoRoute(
                path: 'profile',
                builder: (context, state) => const ProfileSettingsScreen(),
              ),
              GoRoute(
                path: 'assessments',
                builder: (context, state) => const AssessmentListScreen(),
              ),
              GoRoute(
                path: 'lessons',
                builder: (context, state) => const MyTrainingScreen(),
              ),
              GoRoute(
                path: 'messages',
                builder: (context, state) => const MessagingInboxScreen(),
              ),
              GoRoute(
                path: 'waiver/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return TrainingWaiverScreen(waiverId: id);
                },
              ),
              GoRoute(
                path: 'downloads',
                builder: (context, state) => const DownloadsScreen(),
              ),
              // ILT: legacy list route redirects to cohort dashboard
              GoRoute(
                path: 'sessions',
                redirect: (context, state) => '/employee/my-batches',
              ),
              GoRoute(
                path: 'my-batches',
                builder: (context, state) =>
                    const EmployeeMyBatchesDashboardScreen(),
              ),
              GoRoute(
                path: 'assigned-training',
                builder: (context, state) =>
                    const EmployeeAssignedTrainingScreen(),
              ),
              GoRoute(
                path: 'standalone-assignments',
                builder: (context, state) =>
                    const EmployeeStandaloneAssignmentsScreen(),
                routes: [
                  GoRoute(
                    path: ':recipientId',
                    builder: (context, state) {
                      final id =
                          int.tryParse(
                            state.pathParameters['recipientId'] ?? '0',
                          ) ??
                          0;
                      return EmployeeStandaloneAssignmentDetailScreen(
                        recipientId: id,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'sessions/:batchId',
                builder: (context, state) {
                  final batchId =
                      int.tryParse(state.pathParameters['batchId'] ?? '0') ?? 0;
                  return EmployeeBatchDetailScreen(batchId: batchId);
                },
              ),
              GoRoute(
                path: 'operator',
                builder: (context, state) => const OperatorQualificationScreen(),
              ),
              // Gap-closing screens
              GoRoute(
                path: 'notifications',
                builder: (context, state) => const EmployeeNotificationScreen(),
              ),
              GoRoute(
                path: 'compliance',
                builder: (context, state) =>
                    const EmployeeComplianceDetailScreen(),
              ),
              GoRoute(
                path: 'calendar',
                builder: (context, state) =>
                    const EmployeeTrainingCalendarScreen(),
              ),
              GoRoute(
                path: 'documents',
                builder: (context, state) => const EmployeeDocumentScreen(),
              ),
            ],
          ),
        ],
      ),
    ];
