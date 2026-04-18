// ═══════════════════════════════════════════════════════════════════════════════
// QA PORTAL ROUTES
// ═══════════════════════════════════════════════════════════════════════════════
// All routes under the /qa namespace, wrapped in QAShellV2.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:go_router/go_router.dart';

import '../features/qa_compliance/qa_dashboard_screen.dart';
import '../features/trainer_portal/qa_review_screen.dart';
import '../features/shared/messaging_inbox_screen.dart';
import '../layout/qa_shell_v2.dart';

/// All QA Portal routes (ShellRoute wrapping QAShellV2).
List<RouteBase> get qaRoutes => [
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
              GoRoute(
                path: 'messages',
                builder: (context, state) => const MessagingInboxScreen(),
              ),
            ],
          ),
        ],
      ),
    ];
