// ═══════════════════════════════════════════════════════════════════════════════
// AUDITOR PORTAL ROUTES
// ═══════════════════════════════════════════════════════════════════════════════
// Auditor routes are token-protected, full-screen (no portal shell).
// Each screen is wrapped in AuditorWatermarkWrapper.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:go_router/go_router.dart';

import '../features/auditor_portal/auditor_portal_screen.dart';
import '../features/auditor_portal/employee_search_screen.dart';
import '../features/auditor_portal/esignature_verification_screen.dart';
import '../features/auditor_portal/config_change_history_screen.dart';
import '../features/auditor_portal/sop_coverage_screen.dart';
import '../features/audit/audit_trail_screen.dart';
import '../features/compliance/compliance_report_screen.dart';
import '../widgets/auditor_watermark_wrapper.dart';

/// All Auditor Portal routes (no shell, token-gated).
List<RouteBase> get auditorRoutes => [
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
          final deptId =
              int.tryParse(state.uri.queryParameters['departmentId'] ?? '');
          return AuditorWatermarkWrapper(
            auditorToken: token,
            pageUrl: '/compliance-report',
            pageTitle: 'Compliance Report',
            child: ComplianceReportScreen(
              departmentId: (deptId ?? 0) > 0 ? deptId : null,
            ),
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
    ];
