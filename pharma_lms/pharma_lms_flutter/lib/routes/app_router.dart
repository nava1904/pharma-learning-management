import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../features/admin_panel/admin_dashboard_screen.dart';
import '../features/admin_panel/bulk_import_screen.dart';
import '../features/admin_panel/health_dashboard_screen.dart';
import '../features/admin_panel/training_waivers_screen.dart';
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
import '../features/trainer_portal/qa_review_screen.dart';
import '../features/trainer_portal/sop_linkage_screen.dart';
import '../features/trainer_portal/ai_question_generation_screen.dart';
import '../features/trainer_portal/exam_generator_screen.dart';
import '../features/trainer_portal/course_analytics_v2_screen.dart';
import '../features/trainer_portal/sop_document_library_screen.dart';
import '../features/trainer_portal/question_bank_library_screen.dart';
import '../features/trainer_portal/training_matrix_screen.dart' as trainer_matrix;
import '../features/trainer_portal/training_assignments_screen.dart';
import '../features/trainer_portal/learner_progress_screen.dart';
import '../features/trainer_portal/audit_log_viewer_screen.dart';
import '../features/trainer_portal/trainer_profile_screen.dart';
import '../features/trainer_portal/analytics_overview_screen.dart';
import '../features/trainer_portal/qa_dashboard_screen.dart' as trainer_qa;
import '../features/trainer_portal/compliance_screen.dart';
import '../features/trainer_portal/notification_centre_screen.dart';
import '../features/trainer_portal/trainer_reports_screen.dart';
import '../features/my_learning/my_learning_screen.dart';
import '../features/training_timeline/training_timeline_screen.dart';
import '../features/not_found/not_found_screen.dart';
import '../layout/app_layout.dart';
import '../providers/auth_provider.dart';
import '../widgets/auditor_watermark_wrapper.dart';

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
        final extra = state.extra;
        int? enrollmentId;
        if (extra is Map<String, dynamic>) {
          enrollmentId = extra['enrollmentId'] as int?;
        }
        return AssessmentScreenV2(
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
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
          builder: (context, state) => const MyLearningScreen(),
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
                final extra = state.extra;
                int? courseVersionId;
                int? enrollmentId;
                if (extra is Map<String, dynamic>) {
                  courseVersionId = extra['courseVersionId'] as int?;
                  enrollmentId = extra['enrollmentId'] as int?;
                }
                return AssessmentScreenV2(
                  courseVersionId: courseVersionId ?? 0,
                  enrollmentId: enrollmentId,
                );
              },
            ),
            // Course route for employee - redirects to course-viewer
            GoRoute(
              path: 'course/:courseId',
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
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardScreen(),
      routes: [
        GoRoute(
          path: 'training-waivers',
          builder: (context, state) => const TrainingWaiversScreen(),
        ),
        GoRoute(
          path: 'health',
          builder: (context, state) => const HealthDashboardScreen(),
        ),
        GoRoute(
          path: 'bulk-import',
          builder: (context, state) => const BulkImportScreen(),
        ),
        GoRoute(
          path: 'sop-coverage',
          builder: (context, state) => const SopCoverageScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/training-matrix',
      builder: (context, state) => const TrainingMatrixScreen(),
    ),
    GoRoute(
      path: '/qa',
      builder: (context, state) => const QACommandCenterScreen(),
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
              builder: (context, state) => const CourseListScreen(),
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
                return QAReviewScreen(courseId: courseId);
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
            // TRN-08: Course Analytics V2
            GoRoute(
              path: 'courses/:courseId/analytics',
              builder: (context, state) {
                final courseId = int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                return CourseAnalyticsV2Screen(courseId: courseId);
              },
            ),
            // TRN-03 alternate: Assessment builder at /assessments
            GoRoute(
              path: 'assessments',
              builder: (context, state) => const AssessmentBuilderV2Screen(courseId: 0),
            ),
            // TRN-07: AI Question Generation
            GoRoute(
              path: 'assessments/ai-generate',
              builder: (context, state) => const AiQuestionGenerationScreen(),
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
            // Reports hub + Learner Progress
            GoRoute(
              path: 'reports',
              builder: (context, state) => const TrainerReportsScreen(),
              routes: [
                GoRoute(
                  path: 'learner-progress',
                  builder: (context, state) => const LearnerProgressScreen(),
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
        String? enrollmentStatus;
        if (extra is Map<String, dynamic>) {
          courseVersionId = extra['courseVersionId'] as int?;
          enrollmentId = extra['enrollmentId'] as int?;
          userId = extra['userId'] as int?;
          enrollmentStatus = extra['enrollmentStatus']?.toString();
        }
        return CourseViewerScreenV2(
          courseId: courseId,
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
          userId: userId,
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
