import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../features/admin_panel/admin_dashboard_screen.dart';
import '../features/analytics/analytics_dashboard_screen.dart';
import '../features/assessment/assessment_screen.dart';
import '../features/assessment_builder/assessment_builder_screen.dart';
import '../features/audit/audit_trail_screen.dart';
import '../features/auditor_portal/auditor_portal_screen.dart';
import '../features/auditor_portal/esignature_verification_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/compliance/compliance_report_screen.dart';
import '../features/certificate/certificate_screen.dart';
import '../features/course_builder/course_builder_screen.dart';
import '../features/course_viewer/course_viewer_screen.dart';
import '../features/material_upload/material_upload_screen.dart';
import '../features/esignature/esignature_screen.dart';
import '../features/employee_dashboard/employee_dashboard_screen.dart';
import '../features/qa_compliance/qa_dashboard_screen.dart';
import '../features/trainer_dashboard/trainer_dashboard_screen.dart';
import '../features/training_matrix/training_matrix_screen.dart';
import '../providers/auth_provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Routes allowed per role. Paths not listed are allowed for all logged-in roles.
bool _pathAllowedForRole(String path, AppRole role) {
  if (path == '/' || path.isEmpty) return true;
  if (path.startsWith('/employee')) return role == AppRole.employee;
  if (path.startsWith('/admin')) return role == AppRole.admin;
  if (path.startsWith('/qa')) return role == AppRole.qa;
  if (path.startsWith('/trainer')) return role == AppRole.trainer;
  if (path.startsWith('/auditor')) return role == AppRole.auditor;
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
      if (currentRole == null) return '/';
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
    _ref.listen(selectedRoleProvider, (_, __) => notifyListeners());
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
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardScreen(),
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
      ],
    ),
    GoRoute(
      path: '/auditor',
      builder: (context, state) => const AuditorPortalScreen(),
    ),
    GoRoute(
      path: '/audit-trail',
      builder: (context, state) => const AuditTrailScreen(),
    ),
    GoRoute(
      path: '/compliance-report',
      builder: (context, state) => const ComplianceReportScreen(),
    ),
    GoRoute(
      path: '/esignature-verification',
      builder: (context, state) => const EsignatureVerificationScreen(),
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsDashboardScreen(),
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
            signatureMeaning: extra['signatureMeaning'] as String? ??
                'I have read and understood',
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
