import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../features/admin_portal/dashboard/admin_dashboard_screen_v2.dart';
import '../features/admin_portal/users/users_screens.dart';
import '../features/admin_portal/modules/01_user_identity/user_create_screen.dart';
import '../features/admin_portal/modules/01_user_identity/user_edit_screen.dart';
import '../features/admin_portal/modules/01_user_identity/user_view_screen.dart';
import '../features/admin_portal/modules/01_user_identity/user_role_assignment_screen.dart';
import '../features/admin_portal/modules/01_user_identity/user_bulk_import_screen.dart';
import '../features/admin_portal/modules/01_user_identity/user_audit_trail_screen.dart';
import '../features/admin_portal/modules/01_user_identity/user_access_logs_screen.dart';
import '../features/admin_portal/courses/course_screens.dart';
import '../features/admin_portal/access_review/access_review_screen.dart';
import '../features/admin_portal/enrollments/enrollment_screens.dart';
import '../features/admin_portal/batches/batch_screens.dart';
import '../features/admin_portal/job_specs/job_spec_screens.dart';
import '../features/admin_portal/assessments/assessment_screens.dart';
import '../features/admin_portal/certificates/certificate_screens.dart';
import '../features/admin_portal/documents/document_screens.dart';
import '../features/admin_portal/reports/report_screens.dart';
import '../features/admin_portal/audit_capa/audit_capa_screens.dart';
import '../features/admin_portal/notifications/notification_screens.dart';
import '../features/admin_portal/analytics/analytics_screens.dart';
import '../features/admin_portal/system/system_screens.dart';
import '../features/analytics/analytics_dashboard_screen.dart';
import '../features/assessment/assessment_screen.dart';
import '../features/assessment/assessment_v2.dart';
// Old trainer screens superseded by V2 portal
// import '../features/assessment_builder/assessment_builder_screen.dart';
import '../features/audit/audit_trail_screen.dart';
import '../features/auditor_portal/auditor_portal_screen.dart';
import '../features/auditor_portal/employee_search_screen.dart';
import '../features/auditor_portal/esignature_verification_screen.dart';
import '../features/auditor_portal/config_change_history_screen.dart';
import '../features/auditor_portal/sop_coverage_screen.dart';
import '../features/auth/login_screen_redesign.dart';
import '../features/auth/mfa_enrollment_screen.dart';
import '../features/compliance/compliance_report_screen.dart';
import '../features/certificate/certificate_screen.dart';
// import '../features/course_builder/course_builder_screen.dart'; // superseded by course_builder_v2
import '../features/course_viewer/course_viewer_screen_v2.dart';
import '../features/credentials/certification_screen_v2.dart';
import '../features/documents/document_detail_screen.dart';
import '../features/documents/document_list_screen.dart';
import '../features/event_triggers/event_triggers_screen.dart';
import '../features/inspection/inspection_management_screen.dart';
import '../features/quality_events/quality_events_screen.dart';
// import '../features/material_upload/material_upload_screen.dart'; // superseded by material_upload_v2
import '../features/esignature/esignature_screen.dart';
// Legacy screens (replaced by redesigned versions)
// import '../features/employee_dashboard/employee_dashboard_screen_v2.dart';
// import '../features/employee_dashboard/training_history_screen.dart';
import '../features/profile/profile_settings_screen.dart';
// Redesigned Employee Portal screens
import '../layout/employee_shell_v2.dart';
import '../features/employee_dashboard/employee_dashboard_v2.dart';
import '../features/my_learning/my_training_screen.dart';
import '../features/course_catalog/course_catalog_screen_redesigned.dart';
import '../features/course_catalog/course_catalog_v2.dart';
import '../features/training_history/training_history_v2.dart';
import '../features/my_learning/lessons_screen.dart';
import '../features/assessment/assessment_list_screen.dart';
import '../features/certificate/public_verify_screen.dart';
import '../features/waiver/training_waiver_screen.dart';
import '../features/downloads/downloads_screen.dart';
import '../features/qa_compliance/qa_dashboard_screen.dart';
import '../features/trainer_dashboard/course_analytics_screen.dart';
// import '../features/trainer_dashboard/trainer_dashboard_screen.dart'; // superseded by trainer_dashboard_v2
import '../features/training_matrix/training_matrix_screen.dart';
// Trainer Portal V2 screens
import '../layout/trainer_shell_v2.dart';
import '../features/trainer_portal/trainer_dashboard_v2.dart';
import '../features/trainer_portal/course_list_screen.dart';
import '../features/trainer_portal/course_builder_v2_screen.dart';
import '../features/trainer_portal/course_versions_screen.dart';
import '../features/trainer_portal/material_upload_v2_screen.dart';
import '../features/trainer_portal/assessment_builder_v2_screen.dart';
import '../features/trainer_portal/trainer_assessments_hub_screen.dart';
import '../features/trainer_portal/grading_screen.dart';
import '../features/trainer_portal/qa_review_screen.dart';
import '../layout/qa_shell_v2.dart';
import '../features/trainer_portal/sop_linkage_screen.dart';
import '../features/trainer_portal/ai_question_generation_screen.dart';
import '../features/trainer_portal/exam_generator_screen.dart';
import '../features/trainer_portal/course_analytics_v2_screen.dart';
import '../features/trainer_portal/sop_document_library_screen.dart';
import '../features/trainer_portal/question_bank_library_screen.dart';
import '../features/trainer_portal/training_matrix_screen.dart' as trainer_matrix;
import '../features/trainer_portal/training_assignments_screen.dart';
import '../features/trainer_portal/standalone_assignment_wizard_screen.dart';
import '../features/trainer_portal/learner_progress_screen.dart';
import '../features/trainer_portal/audit_log_viewer_screen.dart';
import '../features/trainer_portal/trainer_profile_screen.dart';
import '../features/trainer_portal/analytics_overview_screen.dart';
import '../features/trainer_portal/qa_dashboard_screen.dart' as trainer_qa;
import '../features/trainer_portal/compliance_screen.dart';
import '../features/trainer_portal/notification_centre_screen.dart';
import '../features/trainer_portal/trainer_reports_screen.dart';
import '../features/trainer_portal/completion_matrix_screen.dart';
import '../features/trainer_portal/sme_collaboration_screen.dart';
import '../features/training_timeline/training_timeline_screen.dart';
import '../features/not_found/not_found_screen.dart';
// Employee Batch Screens
import '../features/employee_dashboard/batches/employee_batch_detail_screen.dart';
import '../features/employee_dashboard/batches/employee_my_batches_dashboard_screen.dart';
import '../features/employee_dashboard/batches/employee_assigned_training_screen.dart';
import '../features/employee_dashboard/standalone_assignments_screen.dart';
import '../features/employee_dashboard/operator_qualification_screen.dart';
// Trainer Batch Screens
import '../features/trainer_portal/batches/trainer_batch_list_screen.dart';
import '../features/trainer_portal/batches/trainer_batch_detail_screen.dart';
import '../layout/app_layout.dart';
import '../layout/admin_shell_v2.dart';
import '../providers/auth_provider.dart';
import '../widgets/auditor_watermark_wrapper.dart';

/// [GoRouterState.extra] is not always `Map<String, dynamic>`; normalize for safe lookups.
Map<String, dynamic> _routeExtraMap(Object? extra) {
  if (extra is Map<String, dynamic>) return extra;
  if (extra is Map) return Map<String, dynamic>.from(extra);
  return const {};
}

int? _extraInt(Map<String, dynamic> m, String key) {
  final v = m[key];
  if (v is int) return v;
  return int.tryParse(v?.toString() ?? '');
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: _RouterRefreshNotifier(ref),
    redirect: (context, state) {
      final currentRole = ref.read(selectedRoleProvider);
      final path = state.uri.path;
      if (path == '/' || path.isEmpty) {
        if (currentRole != null) {
          return pathForRole(currentRole);
        }
        return null;
      }
      if (currentRole == null) {
        if (path.startsWith('/verify/')) {
          return null;
        }
        final token = state.uri.queryParameters['token'];
        if (token != null &&
            (path == '/auditor' ||
                path.startsWith('/auditor/') ||
                path == '/audit-trail' ||
                path == '/compliance-report' ||
                path == '/esignature-verification' ||
                path == '/config-change-history')) {
          return null;
        }
        return '/';
      }
      if (!pathAllowedForRole(path, currentRole)) {
        return pathForRole(currentRole);
      }
      return null;
    },
    errorBuilder: (context, state) => NotFoundScreen(uri: state.uri),
    routes: _buildRoutes,
  );
});

class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(this._ref) {
    _ref.listen(selectedRoleProvider, (_, _) => notifyListeners());
  }
  final Ref _ref;
}

List<RouteBase> get _buildRoutes => [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    // Assessment V2: Modern assessment screen with real backend data
    GoRoute(
      path: '/assessment-v2/:courseVersionId',
      builder: (context, state) {
        final courseVersionId = int.tryParse(state.pathParameters['courseVersionId'] ?? '0') ?? 0;
        final m = _routeExtraMap(state.extra);
        final enrollmentId = _extraInt(m, 'enrollmentId');
        final forceRetake = m['forceRetake'] == true;
        return AssessmentScreenV2(
          key: ValueKey('assessment-v2-$courseVersionId-$enrollmentId-$forceRetake'),
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
          forceRetake: forceRetake,
        );
      },
    ),
    // Assessment: full-screen NTA-style test window (no sidebar/layout) - legacy
    GoRoute(
      path: '/assessment/:courseId',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId'] ?? '';
        final extra = state.extra;
        int? courseVersionId;
        int? enrollmentId;
        int? userId;
        String? courseTitle;
        if (extra is Map<String, dynamic>) {
          courseVersionId = extra['courseVersionId'] as int?;
          enrollmentId = extra['enrollmentId'] as int?;
          userId = extra['userId'] as int?;
          courseTitle = extra['courseTitle'] as String?;
        }
        return AssessmentScreen(
          courseId: courseId,
          courseTitle: courseTitle,
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
          userId: userId,
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) => AppLayout(
        currentPath: state.uri.path,
        breadcrumbItems: buildBreadcrumbItems(state.uri.path),
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/courses',
          builder: (context, state) => const CourseCatalogV2(),
        ),
        GoRoute(
          path: '/learning',
          builder: (context, state) => const MyTrainingScreen(),
        ),
        GoRoute(
          path: '/training-timeline',
          builder: (context, state) => const TrainingTimelineScreen(),
        ),
        GoRoute(
          path: '/assessments',
          redirect: (_, __) => '/employee/assessments',
        ),
        GoRoute(
          path: '/certificates',
          redirect: (_, __) => '/employee',
        ),
        // Course Viewer V2 (full Serverpod wiring) - inside AppLayout shell
        GoRoute(
          path: '/course-viewer/:courseId',
          builder: (context, state) {
            final courseId = state.pathParameters['courseId'] ?? '';
            final extra = state.extra;
            int? courseVersionId;
            int? enrollmentId;
            int? userId;
            String? courseTitle;
            String? enrollmentStatus;
            if (extra is Map<String, dynamic>) {
              courseVersionId = int.tryParse(extra['courseVersionId']?.toString() ?? '');
              enrollmentId = int.tryParse(extra['enrollmentId']?.toString() ?? '');
              userId = int.tryParse(extra['userId']?.toString() ?? '');
              courseTitle = extra['courseTitle']?.toString();
              enrollmentStatus = extra['enrollmentStatus']?.toString();
            }
            return CourseViewerScreenV2(
              courseId: courseId,
              courseVersionId: courseVersionId,
              enrollmentId: enrollmentId,
              userId: userId,
              courseTitle: courseTitle,
              enrollmentStatus: enrollmentStatus,
            );
          },
        ),
      ],
    ),
    // ═══════════════════════════════════════════════════════════════════════════
    // EMPLOYEE PORTAL ROUTES — Uses EmployeeShellV2 (React-style layout)
    // This prevents duplicate sidebars/notifications/profiles
    // ═══════════════════════════════════════════════════════════════════════════
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
            // Assessment route under employee namespace - uses V2 screen with PharmaColors
            GoRoute(
              path: 'assessment/:courseId',
              builder: (context, state) {
                final m = _routeExtraMap(state.extra);
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
            // Course route for employee - redirects to course-viewer
            GoRoute(
              path: 'course/:courseId',
              builder: (context, state) {
                final courseId = state.pathParameters['courseId'] ?? '';
                final m = _routeExtraMap(state.extra);
                final courseVersionId = _extraInt(m, 'courseVersionId');
                final enrollmentId = _extraInt(m, 'enrollmentId');
                final userId = _extraInt(m, 'userId');
                final courseTitle = m['courseTitle']?.toString();
                final enrollmentStatus = m['enrollmentStatus']?.toString();
                return CourseViewerScreenV2(
                  courseId: courseId,
                  courseVersionId: courseVersionId,
                  enrollmentId: enrollmentId,
                  userId: userId,
                  courseTitle: courseTitle,
                  enrollmentStatus: enrollmentStatus,
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
              builder: (context, state) => const LessonsScreen(),
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
              builder: (context, state) => const EmployeeMyBatchesDashboardScreen(),
            ),
            GoRoute(
              path: 'assigned-training',
              builder: (context, state) => const EmployeeAssignedTrainingScreen(),
            ),
            GoRoute(
              path: 'standalone-assignments',
              builder: (context, state) => const EmployeeStandaloneAssignmentsScreen(),
              routes: [
                GoRoute(
                  path: ':recipientId',
                  builder: (context, state) {
                    final id =
                        int.tryParse(state.pathParameters['recipientId'] ?? '0') ?? 0;
                    return EmployeeStandaloneAssignmentDetailScreen(recipientId: id);
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'sessions/:batchId',
              builder: (context, state) {
                final batchId = int.tryParse(state.pathParameters['batchId'] ?? '0') ?? 0;
                return EmployeeBatchDetailScreen(batchId: batchId);
              },
            ),
            GoRoute(
              path: 'operator',
              builder: (context, state) => const OperatorQualificationScreen(),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AdminShellV2(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminDashboardScreenV2(),
        ),
        // Canonical redirects (sidebar / legacy links)
        GoRoute(
          path: '/admin/users',
          redirect: (context, state) => '/admin/users/directory',
        ),
        GoRoute(
          path: '/admin/compliance',
          redirect: (context, state) => '/admin/reports/compliance',
        ),
        GoRoute(
          path: '/admin/courses',
          redirect: (context, state) => '/admin/courses/catalogue',
        ),
        GoRoute(
          path: '/admin/enrollments',
          redirect: (context, state) => '/admin/enrollments/list',
        ),
        GoRoute(
          path: '/admin/profile',
          builder: (context, state) => const ProfileSettingsScreen(),
        ),
        // Module 1: User & Identity Management
        GoRoute(
          path: '/admin/users/directory',
          builder: (context, state) => const AdminUserDirectoryScreen(),
          routes: [
            GoRoute(
              path: 'create',
              builder: (context, state) => const UserCreateScreen(),
            ),
            GoRoute(
              path: 'view/:userId',
              builder: (context, state) {
                final userId = int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
                return UserViewScreen(userId: userId);
              },
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final userId = int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
                    return UserEditScreen(userId: userId);
                  },
                ),
                GoRoute(
                  path: 'roles',
                  builder: (context, state) {
                    final userId = int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
                    final userName = state.extra as String? ?? 'User';
                    return UserRoleAssignmentScreen(
                      userId: userId,
                      userName: userName,
                    );
                  },
                ),
                GoRoute(
                  path: 'audit-trail',
                  builder: (context, state) {
                    final userId = int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
                    final userName = state.extra as String? ?? 'User';
                    return UserAuditTrailScreen(
                      userId: userId,
                      userName: userName,
                    );
                  },
                ),
                GoRoute(
                  path: 'access-logs',
                  builder: (context, state) {
                    final userId = int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
                    final userName = state.extra as String? ?? 'User';
                    return UserAccessLogsScreen(
                      userId: userId,
                      userName: userName,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'import',
              builder: (context, state) => const UserBulkImportScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/admin/users/org-tree',
          builder: (context, state) => const AdminOrgHierarchyScreen(),
        ),
        GoRoute(
          path: '/admin/users/access-review',
          builder: (context, state) => const AccessReviewScreen(),
        ),
        GoRoute(
          path: '/admin/courses/catalogue',
          builder: (context, state) => const AdminCourseCatalogueScreen(),
        ),
        GoRoute(
          path: '/admin/courses/create',
          builder: (context, state) => const AdminCourseCreateScreen(),
        ),
        GoRoute(
          path: '/admin/courses/approval',
          builder: (context, state) => const AdminCourseApprovalScreen(),
        ),
        GoRoute(
          path: '/admin/enrollments/list',
          builder: (context, state) => const AdminEnrollmentListScreen(),
        ),
        GoRoute(
          path: '/admin/enrollments/create',
          builder: (context, state) => const AdminEnrollmentCreateScreen(),
        ),
        GoRoute(
          path: '/admin/enrollments/bulk',
          builder: (context, state) => const AdminEnrollmentBulkScreen(),
        ),
        GoRoute(
          path: '/admin/enrollments/rules',
          builder: (context, state) => const AdminEnrollmentRulesScreen(),
        ),
        GoRoute(
          path: '/admin/enrollments/transcript',
          builder: (context, state) => const AdminTranscriptViewerScreen(),
        ),
        GoRoute(
          path: '/admin/batches/list',
          builder: (context, state) => const AdminBatchListScreen(),
        ),
        GoRoute(
          path: '/admin/batches/create',
          builder: (context, state) => const AdminBatchCreateScreen(),
        ),
        GoRoute(
          path: '/admin/batches/detail',
          builder: (context, state) => const AdminBatchDetailScreen(),
        ),
        GoRoute(
          path: '/admin/job-specs/list',
          builder: (context, state) => const AdminJobSpecListScreen(),
        ),
        GoRoute(
          path: '/admin/job-specs/create',
          builder: (context, state) => const AdminJobSpecCreateScreen(),
        ),
        GoRoute(
          path: '/admin/job-specs/matrix',
          builder: (context, state) => const AdminTrainingMatrixScreen(),
        ),
        GoRoute(
          path: '/admin/job-specs/gap-analysis',
          builder: (context, state) => const AdminGapAnalysisScreen(),
        ),
        GoRoute(
          path: '/admin/assessments/question-bank',
          builder: (context, state) => const AdminQuestionBankScreen(),
        ),
        GoRoute(
          path: '/admin/assessments/list',
          builder: (context, state) => const AdminAssessmentListScreen(),
        ),
        GoRoute(
          path: '/admin/assessments/create',
          builder: (context, state) => const AdminAssessmentCreateScreen(),
        ),
        GoRoute(
          path: '/admin/assessments/attempt-review',
          builder: (context, state) => const AdminAttemptReviewScreen(),
        ),
        GoRoute(
          path: '/admin/certificates/list',
          builder: (context, state) => const AdminCertificateListScreen(),
        ),
        GoRoute(
          path: '/admin/certificates/templates',
          builder: (context, state) => const AdminCertificateTemplateScreen(),
        ),
        GoRoute(
          path: '/admin/certificates/expiry',
          builder: (context, state) => const AdminCertificateExpiryScreen(),
        ),
        GoRoute(
          path: '/admin/documents/library',
          builder: (context, state) => const AdminDocumentLibraryScreen(),
        ),
        GoRoute(
          path: '/admin/documents/upload',
          builder: (context, state) => const AdminDocumentUploadScreen(),
        ),
        GoRoute(
          path: '/admin/documents/ack',
          builder: (context, state) => const AdminDocumentAcknowledgementScreen(),
        ),
        GoRoute(
          path: '/admin/reports/compliance',
          builder: (context, state) => const AdminComplianceReportDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/reports/gap',
          builder: (context, state) => const AdminGapReportScreen(),
        ),
        GoRoute(
          path: '/admin/reports/regulatory',
          builder: (context, state) => const AdminRegulatoryReportScreen(),
        ),
        GoRoute(
          path: '/admin/reports/scheduled',
          builder: (context, state) => const AdminScheduledReportScreen(),
        ),
        GoRoute(
          path: '/admin/audit/trail',
          builder: (context, state) => const AdminAuditTrailScreen(),
        ),
        GoRoute(
          path: '/admin/audit/integrity',
          builder: (context, state) => const AdminIntegrityCheckScreen(),
        ),
        GoRoute(
          path: '/admin/audit/capa',
          builder: (context, state) => const AdminCapaRegisterScreen(),
        ),
        GoRoute(
          path: '/admin/notifications/templates',
          builder: (context, state) => const AdminNotificationTemplateScreen(),
        ),
        GoRoute(
          path: '/admin/notifications/rules',
          builder: (context, state) => const AdminReminderRulesScreen(),
        ),
        GoRoute(
          path: '/admin/notifications/broadcast',
          builder: (context, state) => const AdminBroadcastScreen(),
        ),
        GoRoute(
          path: '/admin/analytics/dashboard',
          builder: (context, state) => const AdminAnalyticsDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/analytics/report-builder',
          builder: (context, state) => const AdminReportBuilderScreen(),
        ),
        GoRoute(
          path: '/admin/sla-policies',
          redirect: (context, state) => '/admin/analytics/dashboard',
        ),
        GoRoute(
          path: '/admin/system/settings',
          builder: (context, state) => const AdminSystemSettingsScreen(),
        ),
        GoRoute(
          path: '/admin/system/hr-integration',
          builder: (context, state) => const AdminHrIntegrationScreen(),
        ),
        GoRoute(
          path: '/admin/system/api-keys',
          builder: (context, state) => const AdminApiKeysScreen(),
        ),
        GoRoute(
          path: '/admin/system/health',
          builder: (context, state) => const AdminSystemHealthScreen(),
        ),
        GoRoute(
          path: '/admin/system/validation-docs',
          builder: (context, state) => const AdminValidationDocsScreen(),
        ),
        GoRoute(
          path: '/admin/system/retention',
          builder: (context, state) => const AdminRetentionPolicyScreen(),
        ),
        GoRoute(
          path: '/admin/system/gdpr',
          builder: (context, state) => const AdminGdprScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/training-matrix',
      builder: (context, state) => const TrainingMatrixScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => QAShellV2(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/qa',
          redirect: (context, state) {
            if (state.uri.path == '/qa') {
              return '/qa/dashboard';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'dashboard',
              builder: (context, state) => const QACommandCenterScreen(),
            ),
            GoRoute(
              path: 'course/:courseId/review',
              builder: (context, state) {
                final courseId =
                    int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return QAReviewScreen(
                  courseId: courseId,
                  mode: CourseQaReviewMode.qa,
                );
              },
            ),
          ],
        ),
      ],
    ),
    // ═══════════════════════════════════════════════════════════════════════════
    // TRAINER / SME PORTAL ROUTES — Uses TrainerShellV2
    // Full trainer portal with sidebar, header, and all TRN-01 to TRN-16 screens
    // ═══════════════════════════════════════════════════════════════════════════
    ShellRoute(
      builder: (context, state, child) => TrainerShellV2(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/trainer',
          builder: (context, state) => const TrainerDashboardV2(),
          routes: [
            // TRN-10: Course List
            GoRoute(
              path: 'courses',
              builder: (context, state) => CourseListScreen(
                initialSearch: state.uri.queryParameters['search'],
              ),
            ),
            // TRN-01: Course Builder V2
            GoRoute(
              path: 'courses/:courseId/builder',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return CourseBuilderV2Screen(courseId: courseId);
              },
            ),
            // TRN-05: Course Versions
            GoRoute(
              path: 'courses/:courseId/versions',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return CourseVersionsScreen(courseId: courseId);
              },
            ),
            // TRN-02: Material Upload V2
            GoRoute(
              path: 'courses/:courseId/material',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return MaterialUploadV2Screen(courseId: courseId);
              },
            ),
            // TRN-03: Assessment Builder V2
            GoRoute(
              path: 'courses/:courseId/assessment',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return AssessmentBuilderV2Screen(courseId: courseId);
              },
            ),
            // TRN-04: QA Review / Submit
            GoRoute(
              path: 'courses/:courseId/qa-review',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return QAReviewScreen(
                  courseId: courseId,
                  mode: CourseQaReviewMode.trainer,
                );
              },
            ),
            // TRN-06: SOP Linkage
            GoRoute(
              path: 'courses/:courseId/sop-links',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return SopLinkageScreen(courseId: courseId);
              },
            ),
            GoRoute(
              path: 'courses/:courseId/sme',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return SmeCollaborationScreen(courseId: courseId);
              },
            ),
            // TRN-08: Course Analytics V2
            GoRoute(
              path: 'courses/:courseId/analytics',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return CourseAnalyticsV2Screen(courseId: courseId);
              },
            ),
            // TRN-03: Pick a course, then open Assessment Builder for that course
            GoRoute(
              path: 'assessments',
              builder: (context, state) => const TrainerAssessmentsHubScreen(),
            ),
            // TRN-07: AI Question Generation
            GoRoute(
              path: 'assessments/ai-generate',
              builder: (context, state) => const AiQuestionGenerationScreen(),
            ),
            GoRoute(
              path: 'assessments/grading/:assessmentId',
              builder: (context, state) {
                final assessmentId =
                    int.tryParse(state.pathParameters['assessmentId'] ?? '') ?? 0;
                return GradingScreen(assessmentId: assessmentId);
              },
            ),
            GoRoute(
              path: 'exam-generator',
              builder: (context, state) => const ExamGeneratorScreen(),
            ),
            // Legacy: materials route (fallback)
            GoRoute(
              path: 'materials',
              builder: (context, state) => const MaterialUploadV2Screen(courseId: 0),
            ),
            // TRN-11: SOP Document Library
            GoRoute(
              path: 'sop-documents',
              builder: (context, state) => const SopDocumentLibraryScreen(),
            ),
            // TRN-12: Question Bank Library
            GoRoute(
              path: 'question-bank',
              builder: (context, state) => const QuestionBankLibraryScreen(),
            ),
            // TRN-13: Training Matrix Manager
            GoRoute(
              path: 'training-matrix',
              builder: (context, state) => const trainer_matrix.TrainingMatrixScreen(),
            ),
            // TRN-14: Training Assignments
            GoRoute(
              path: 'assignments',
              builder: (context, state) => const TrainingAssignmentsScreen(),
            ),
            GoRoute(
              path: 'assignment-campaigns/new',
              builder: (context, state) => const StandaloneAssignmentWizardScreen(),
            ),
            // Reports hub + Learner Progress
            GoRoute(
              path: 'reports',
              builder: (context, state) => const TrainerReportsScreen(),
              routes: [
                GoRoute(
                  path: 'learner-progress',
                  builder: (context, state) => const LearnerProgressScreen(),
                ),
                GoRoute(
                  path: 'completion-matrix',
                  builder: (context, state) => const CompletionMatrixScreen(),
                ),
              ],
            ),
            // TRN-16: Audit Log Viewer
            GoRoute(
              path: 'audit-log',
              builder: (context, state) => const AuditLogViewerScreen(),
            ),
            // Analytics Overview
            GoRoute(
              path: 'analytics',
              builder: (context, state) => const AnalyticsOverviewScreen(),
            ),
            // QA Dashboard (Trainer)
            GoRoute(
              path: 'qa-dashboard',
              builder: (context, state) => const trainer_qa.TrainerQADashboardScreen(),
            ),
            // Compliance
            GoRoute(
              path: 'compliance',
              builder: (context, state) => const TrainerComplianceScreen(),
            ),
            // Notification Centre
            GoRoute(
              path: 'notifications',
              builder: (context, state) => const NotificationCentreScreen(),
            ),
            // TRN-17: Trainer Profile
            GoRoute(
              path: 'profile',
              builder: (context, state) => const TrainerProfileScreen(),
            ),
            // TRN-BATCH: Trainer Batches (Instructor-led Training)
            GoRoute(
              path: 'batches',
              builder: (context, state) => const TrainerBatchListScreen(),
            ),
            GoRoute(
              path: 'batches/:batchId',
              builder: (context, state) {
                final batchId = int.tryParse(state.pathParameters['batchId'] ?? '0') ?? 0;
                return TrainerBatchDetailScreen(batchId: batchId);
              },
            ),
            // Legacy: course-builder route (backward compat)
            GoRoute(
              path: 'course-builder',
              builder: (context, state) {
                final extra = state.extra;
                final courseId = extra is Course ? extra.id ?? 0 : 0;
                return CourseBuilderV2Screen(courseId: courseId);
              },
            ),
            // Legacy: course-analytics route (backward compat)
            GoRoute(
              path: 'course-analytics/:courseVersionId',
              builder: (context, state) {
                final courseVersionId =
                    int.tryParse(state.pathParameters['courseVersionId'] ?? '') ?? 0;
                final extra = state.extra;
                final courseTitle =
                    extra is Map<String, dynamic>
                        ? extra['courseTitle'] as String?
                        : null;
                return CourseAnalyticsScreen(
                  courseVersionId: courseVersionId,
                  courseTitle: courseTitle,
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/auditor',
      builder: (context, state) {
        final token = state.uri.queryParameters['token'];
        return AuditorPortalScreen(auditorToken: token);
      },
      routes: [
        GoRoute(
          path: 'employee-search',
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            return AuditorWatermarkWrapper(
              auditorToken: token,
              pageUrl: '/auditor/employee-search',
              pageTitle: 'Employee Search',
              child: const EmployeeSearchScreen(),
            );
          },
        ),
        GoRoute(
          path: 'sop-coverage',
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            return AuditorWatermarkWrapper(
              auditorToken: token,
              pageUrl: '/auditor/sop-coverage',
              pageTitle: 'SOP Coverage',
              child: const SopCoverageScreen(),
            );
          },
        ),
        GoRoute(
          path: 'config-change-history',
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            return AuditorWatermarkWrapper(
              auditorToken: token,
              pageUrl: '/auditor/config-change-history',
              pageTitle: 'Config Change History',
              child: const ConfigChangeHistoryScreen(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/audit-trail',
      builder: (context, state) {
        final token = state.uri.queryParameters['token'];
        return AuditorWatermarkWrapper(
          auditorToken: token,
          pageUrl: '/audit-trail',
          pageTitle: 'Audit Trail',
          child: const AuditTrailScreen(),
        );
      },
    ),
    GoRoute(
      path: '/compliance-report',
      builder: (context, state) {
        final token = state.uri.queryParameters['token'];
        final deptId = int.tryParse(state.uri.queryParameters['departmentId'] ?? '');
        return AuditorWatermarkWrapper(
          auditorToken: token,
          pageUrl: '/compliance-report',
          pageTitle: 'Compliance Report',
          child: ComplianceReportScreen(departmentId: (deptId ?? 0) > 0 ? deptId : null),
        );
      },
    ),
    GoRoute(
      path: '/esignature-verification',
      builder: (context, state) {
        final token = state.uri.queryParameters['token'];
        return AuditorWatermarkWrapper(
          auditorToken: token,
          pageUrl: '/esignature-verification',
          pageTitle: 'E-Signature Verification',
          child: const EsignatureVerificationScreen(),
        );
      },
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsDashboardScreen(),
    ),
    GoRoute(
      path: '/quality-events',
      builder: (context, state) => const QualityEventsScreen(),
    ),
    GoRoute(
      path: '/event-triggers',
      builder: (context, state) => const EventTriggersScreen(),
    ),
    GoRoute(
      path: '/inspection-management',
      builder: (context, state) => const InspectionManagementScreen(),
    ),
    GoRoute(
      path: '/documents',
      builder: (context, state) => const DocumentListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            final extra = state.extra;
            return DocumentDetailScreen(
              documentId: id,
              document: extra is Document ? extra : null,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/course/:courseId',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId'] ?? '';
        final extra = state.extra;
        int? courseVersionId;
        int? enrollmentId;
        int? userId;
        String? courseTitle;
        String? enrollmentStatus;
        if (extra is Map<String, dynamic>) {
          courseVersionId = int.tryParse(extra['courseVersionId']?.toString() ?? '');
          enrollmentId = int.tryParse(extra['enrollmentId']?.toString() ?? '');
          userId = int.tryParse(extra['userId']?.toString() ?? '');
          courseTitle = extra['courseTitle']?.toString();
          enrollmentStatus = extra['enrollmentStatus']?.toString();
        }
        return CourseViewerScreenV2(
          courseId: courseId,
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
          userId: userId,
          courseTitle: courseTitle,
          enrollmentStatus: enrollmentStatus,
        );
      },
    ),
    GoRoute(
      path: '/certificate/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        final extra = state.extra;
        return CertificateScreen(
          certificateId: id,
          certificate: extra is Certificate ? extra : null,
        );
      },
    ),
    GoRoute(
      path: '/esignature',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Map<String, dynamic>) {
          return EsignatureScreen(
            entityType: extra['entityType'] as String? ?? 'training_record',
            entityId: extra['entityId'] as String? ?? '',
            signatureMeaning: extra['signatureMeaning'] as String?,
            userId: extra['userId'] as int?,
          );
        }
        return const EsignatureScreen(
          entityType: 'training_record',
          entityId: '',
        );
      },
    ),
    // SCR-17: Public Certificate Verification (no auth required)
    GoRoute(
      path: '/verify/:token',
      builder: (context, state) {
        final token = state.pathParameters['token'] ?? '';
        return PublicVerifyScreen(token: token);
      },
    ),
  ];
