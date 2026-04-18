// ═══════════════════════════════════════════════════════════════════════════════
// ADMIN PORTAL ROUTES
// ═══════════════════════════════════════════════════════════════════════════════
// All routes under the /admin namespace, wrapped in AdminShellV2.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:go_router/go_router.dart';

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
import '../features/profile/profile_settings_screen.dart';
import '../layout/admin_shell_v2.dart';

/// All Admin Portal routes (ShellRoute wrapping AdminShellV2).
List<RouteBase> get adminRoutes => [
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
          // Canonical redirects
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
                  final userId =
                      int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
                  return UserViewScreen(userId: userId);
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) {
                      final userId =
                          int.tryParse(
                            state.pathParameters['userId'] ?? '0',
                          ) ??
                          0;
                      return UserEditScreen(userId: userId);
                    },
                  ),
                  GoRoute(
                    path: 'roles',
                    builder: (context, state) {
                      final userId =
                          int.tryParse(
                            state.pathParameters['userId'] ?? '0',
                          ) ??
                          0;
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
                      final userId =
                          int.tryParse(
                            state.pathParameters['userId'] ?? '0',
                          ) ??
                          0;
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
                      final userId =
                          int.tryParse(
                            state.pathParameters['userId'] ?? '0',
                          ) ??
                          0;
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
          // Module 2: Courses
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
          // Module 3: Enrollments
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
          // Module 4: Batches
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
          // Module 5: Job Specs
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
          // Module 6: Assessments
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
          // Module 7: Certificates
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
          // Module 8: Documents
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
            builder: (context, state) =>
                const AdminDocumentAcknowledgementScreen(),
          ),
          // Module 9: Reports
          GoRoute(
            path: '/admin/reports/compliance',
            builder: (context, state) =>
                const AdminComplianceReportDashboardScreen(),
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
          // Module 10: Audit & CAPA
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
          // Module 11: Notifications
          GoRoute(
            path: '/admin/notifications/templates',
            builder: (context, state) =>
                const AdminNotificationTemplateScreen(),
          ),
          GoRoute(
            path: '/admin/notifications/rules',
            builder: (context, state) => const AdminReminderRulesScreen(),
          ),
          GoRoute(
            path: '/admin/notifications/broadcast',
            builder: (context, state) => const AdminBroadcastScreen(),
          ),
          // Module 12: Analytics
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
          // Module 13: System
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
    ];
