import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../features/admin_panel/admin_dashboard_screen.dart';
import '../features/admin_panel/health_dashboard_screen.dart';
import '../features/admin_panel/training_waivers_screen.dart';
import '../features/analytics/analytics_dashboard_screen.dart';
import '../features/assessment/assessment_screen.dart';
import '../features/assessment_builder/assessment_builder_screen.dart';
import '../features/audit/audit_trail_screen.dart';
import '../features/auditor_portal/auditor_portal_screen.dart';
import '../features/auditor_portal/employee_search_screen.dart';
import '../features/auditor_portal/esignature_verification_screen.dart';
import '../features/auditor_portal/config_change_history_screen.dart';
import '../features/auditor_portal/sop_coverage_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/compliance/compliance_report_screen.dart';
import '../features/certificate/certificate_screen.dart';
import '../features/course_builder/course_builder_screen.dart';
import '../features/course_viewer/course_viewer_screen.dart';
import '../features/documents/document_detail_screen.dart';
import '../features/documents/document_list_screen.dart';
import '../features/event_triggers/event_triggers_screen.dart';
import '../features/inspection/inspection_management_screen.dart';
import '../features/quality_events/quality_events_screen.dart';
import '../features/material_upload/material_upload_screen.dart';
import '../features/esignature/esignature_screen.dart';
import '../features/employee_dashboard/employee_dashboard_screen.dart';
import '../features/employee_dashboard/training_history_screen.dart';
import '../features/qa_compliance/qa_dashboard_screen.dart';
import '../features/trainer_dashboard/course_analytics_screen.dart';
import '../features/trainer_dashboard/trainer_dashboard_screen.dart';
import '../features/training_matrix/training_matrix_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/auditor_watermark_wrapper.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Routes allowed per role. Paths not listed are allowed for all logged-in roles.
bool _pathAllowedForRole(String path, AppRole role) {
  if (path == '/' || path.isEmpty) return true;
  if (path.startsWith('/employee')) return role == AppRole.employee;
  if (path.startsWith('/admin')) {
    if (path.contains('training-waivers')) {
      return role == AppRole.admin || role == AppRole.qa;
    }
    return role == AppRole.admin;
  }
  if (path.startsWith('/qa')) return role == AppRole.qa;
  if (path.startsWith('/trainer')) return role == AppRole.trainer;
  if (path.startsWith('/auditor')) return role == AppRole.auditor || role == AppRole.qa;
  if (path.startsWith('/training-matrix')) return role == AppRole.admin;
  if (path.startsWith('/audit-trail')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.auditor;
  }
  if (path.startsWith('/compliance-report')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.auditor;
  }
  if (path.startsWith('/esignature-verification')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.auditor;
  }
  if (path.startsWith('/analytics')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.analytics;
  }
  if (path.startsWith('/documents')) {
    return role == AppRole.admin || role == AppRole.qa;
  }
  if (path.startsWith('/quality-events')) {
    return role == AppRole.qa;
  }
  if (path.startsWith('/event-triggers')) {
    return role == AppRole.admin || role == AppRole.qa;
  }
  if (path.startsWith('/inspection-management')) {
    return role == AppRole.admin || role == AppRole.qa;
  }
  // /course, /assessment, /certificate, /esignature - employee, admin, trainer
  if (path.startsWith('/course') || path.startsWith('/assessment') ||
      path.startsWith('/certificate') || path.startsWith('/esignature')) {
    return role == AppRole.employee ||
        role == AppRole.admin ||
        role == AppRole.trainer;
  }
  return true;
}

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
      if (!_pathAllowedForRole(path, currentRole)) {
        return pathForRole(currentRole);
      }
      return null;
    },
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
    GoRoute(
      path: '/employee',
      builder: (context, state) => const EmployeeDashboardScreen(),
      routes: [
        GoRoute(
          path: 'training-history',
          builder: (context, state) => const TrainingHistoryScreen(),
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
      ],
    ),
    GoRoute(
      path: '/training-matrix',
      builder: (context, state) => const TrainingMatrixScreen(),
    ),
    GoRoute(
      path: '/qa',
      builder: (context, state) => const QADashboardScreen(),
    ),
    GoRoute(
      path: '/trainer',
      builder: (context, state) => const TrainerDashboardScreen(),
      routes: [
        GoRoute(
          path: 'course-builder',
          builder: (context, state) {
            final extra = state.extra;
            final courseId = extra is Course ? extra.id : null;
            return CourseBuilderScreen(courseId: courseId);
          },
        ),
        GoRoute(
          path: 'materials',
          builder: (context, state) => const MaterialUploadScreen(),
        ),
        GoRoute(
          path: 'assessments',
          builder: (context, state) => const AssessmentBuilderScreen(),
        ),
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
        return AuditorWatermarkWrapper(
          auditorToken: token,
          pageUrl: '/compliance-report',
          pageTitle: 'Compliance Report',
          child: const ComplianceReportScreen(),
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
        if (extra is Map<String, dynamic>) {
          courseVersionId = extra['courseVersionId'] as int?;
          enrollmentId = extra['enrollmentId'] as int?;
          userId = extra['userId'] as int?;
        }
        return CourseViewerScreen(
          courseId: courseId,
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
          userId: userId,
        );
      },
    ),
    GoRoute(
      path: '/assessment/:courseId',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId'] ?? '';
        final extra = state.extra;
        int? courseVersionId;
        int? enrollmentId;
        int? userId;
        if (extra is Map<String, dynamic>) {
          courseVersionId = extra['courseVersionId'] as int?;
          enrollmentId = extra['enrollmentId'] as int?;
          userId = extra['userId'] as int?;
        }
        return AssessmentScreen(
          courseId: courseId,
          courseVersionId: courseVersionId,
          enrollmentId: enrollmentId,
          userId: userId,
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
  ];
