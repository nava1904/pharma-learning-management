// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER PORTAL ROUTES
// ═══════════════════════════════════════════════════════════════════════════════
// Includes both full-screen routes (course builder, material upload, etc.)
// and the TrainerShellV2-wrapped sidebar routes.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../features/assessment/assessment_v2.dart';
import '../features/course_viewer/course_viewer_screen_v2.dart';
import '../features/trainer_portal/trainer_dashboard_v2.dart';
import '../features/trainer_portal/course_list_screen.dart';
import '../features/trainer_portal/course_builder_v2_screen.dart';
import '../features/trainer_portal/course_versions_screen.dart';
import '../features/trainer_portal/material_upload_v2_screen.dart';
import '../features/trainer_portal/assessment_builder_v2_screen.dart';
import '../features/trainer_portal/trainer_assessments_hub_screen.dart';
import '../features/trainer_portal/grading_screen.dart';
import '../features/trainer_portal/qa_review_screen.dart';
import '../features/trainer_portal/sop_linkage_screen.dart';
import '../features/trainer_portal/ai_question_generation_screen.dart';
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
import '../features/trainer_portal/batches/trainer_batch_list_screen.dart';
import '../features/trainer_portal/batches/trainer_batch_detail_screen.dart';
import '../features/trainer_dashboard/course_analytics_screen.dart';
import '../features/shared/messaging_inbox_screen.dart';
import '../layout/trainer_shell_v2.dart';

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

/// All Trainer Portal routes: full-screen tool routes + TrainerShellV2 sidebar routes.
List<RouteBase> get trainerRoutes => [
      // ── Full-screen tool routes (no sidebar) ──────────────────────────────
      GoRoute(
        path: '/trainer/courses/:courseId/builder',
        builder: (context, state) {
          final courseId =
              int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
          return Scaffold(body: CourseBuilderV2Screen(courseId: courseId));
        },
      ),
      GoRoute(
        path: '/trainer/courses/:courseId/versions',
        builder: (context, state) {
          final courseId =
              int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
          return Scaffold(body: CourseVersionsScreen(courseId: courseId));
        },
      ),
      GoRoute(
        path: '/trainer/courses/:courseId/material',
        builder: (context, state) {
          final courseId =
              int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
          return Scaffold(body: MaterialUploadV2Screen(courseId: courseId));
        },
      ),
      GoRoute(
        path: '/trainer/courses/:courseId/assessment',
        builder: (context, state) {
          final courseId =
              int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
          return Scaffold(body: AssessmentBuilderV2Screen(courseId: courseId));
        },
      ),
      GoRoute(
        path: '/trainer/courses/:courseId/qa-review',
        builder: (context, state) {
          final courseId =
              int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
          return Scaffold(
            body: QAReviewScreen(
              courseId: courseId,
              mode: CourseQaReviewMode.trainer,
            ),
          );
        },
      ),
      GoRoute(
        path: '/trainer/preview-course/:courseId',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId'] ?? '';
          final m = _extraMap(state.extra);
          return CourseViewerScreenV2(
            courseId: courseId,
            courseVersionId: _extraInt(m, 'courseVersionId'),
            previewMode: true,
          );
        },
      ),
      // ── Sidebar (TrainerShellV2) routes ───────────────────────────────────
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
              GoRoute(
                path: 'courses',
                builder: (context, state) => CourseListScreen(
                  initialSearch: state.uri.queryParameters['search'],
                ),
              ),
              GoRoute(
                path: 'courses/:courseId/sop-links',
                builder: (context, state) {
                  final courseId =
                      int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                  return SopLinkageScreen(courseId: courseId);
                },
              ),
              GoRoute(
                path: 'courses/:courseId/sme',
                builder: (context, state) {
                  final courseId =
                      int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                  return SmeCollaborationScreen(courseId: courseId);
                },
              ),
              GoRoute(
                path: 'courses/:courseId/analytics',
                builder: (context, state) {
                  final courseId =
                      int.tryParse(state.pathParameters['courseId'] ?? '') ?? 0;
                  return CourseAnalyticsV2Screen(courseId: courseId);
                },
              ),
              GoRoute(
                path: 'assessments',
                builder: (context, state) => const TrainerAssessmentsHubScreen(),
              ),
              GoRoute(
                path: 'assessments/ai-generate',
                builder: (context, state) => const AiQuestionGenerationScreen(),
              ),
              GoRoute(
                path: 'assessments/grading/:assessmentId',
                builder: (context, state) {
                  final assessmentId =
                      int.tryParse(
                        state.pathParameters['assessmentId'] ?? '',
                      ) ??
                      0;
                  return GradingScreen(assessmentId: assessmentId);
                },
              ),
              GoRoute(
                path: 'materials',
                builder: (context, state) =>
                    const MaterialUploadV2Screen(courseId: 0),
              ),
              GoRoute(
                path: 'sop-documents',
                builder: (context, state) => const SopDocumentLibraryScreen(),
              ),
              GoRoute(
                path: 'question-bank',
                builder: (context, state) => const QuestionBankLibraryScreen(),
              ),
              GoRoute(
                path: 'training-matrix',
                builder: (context, state) =>
                    const trainer_matrix.TrainingMatrixScreen(),
              ),
              GoRoute(
                path: 'assignments',
                builder: (context, state) => const TrainingAssignmentsScreen(),
              ),
              GoRoute(
                path: 'assignment-campaigns/new',
                builder: (context, state) =>
                    const StandaloneAssignmentWizardScreen(),
              ),
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
              GoRoute(
                path: 'audit-log',
                builder: (context, state) => const AuditLogViewerScreen(),
              ),
              GoRoute(
                path: 'analytics',
                builder: (context, state) => const AnalyticsOverviewScreen(),
              ),
              GoRoute(
                path: 'qa-dashboard',
                builder: (context, state) =>
                    const trainer_qa.TrainerQADashboardScreen(),
              ),
              GoRoute(
                path: 'compliance',
                builder: (context, state) => const TrainerComplianceScreen(),
              ),
              GoRoute(
                path: 'notifications',
                builder: (context, state) => const NotificationCentreScreen(),
              ),
              GoRoute(
                path: 'profile',
                builder: (context, state) => const TrainerProfileScreen(),
              ),
              GoRoute(
                path: 'messages',
                builder: (context, state) => const MessagingInboxScreen(),
              ),
              GoRoute(
                path: 'batches',
                builder: (context, state) => const TrainerBatchListScreen(),
              ),
              GoRoute(
                path: 'batches/:batchId',
                builder: (context, state) {
                  final batchId =
                      int.tryParse(state.pathParameters['batchId'] ?? '0') ?? 0;
                  return TrainerBatchDetailScreen(batchId: batchId);
                },
              ),
              // Legacy backward-compat routes
              GoRoute(
                path: 'course-builder',
                builder: (context, state) {
                  final extra = state.extra;
                  final courseId = extra is Course ? extra.id ?? 0 : 0;
                  return CourseBuilderV2Screen(courseId: courseId);
                },
              ),
              GoRoute(
                path: 'course-analytics/:courseVersionId',
                builder: (context, state) {
                  final courseVersionId =
                      int.tryParse(
                        state.pathParameters['courseVersionId'] ?? '',
                      ) ??
                      0;
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
    ];
