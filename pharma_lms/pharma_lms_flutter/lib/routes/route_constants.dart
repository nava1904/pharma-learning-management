// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — ROUTE CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════════
//
// Single source of truth for all route paths.
// NEVER hardcode route strings outside this file.
//
// Usage:
//   context.go(Routes.employee.dashboard);
//   context.go(Routes.trainer.courseBuilder(courseId));
// ═══════════════════════════════════════════════════════════════════════════════

/// Top-level route paths organized by portal.
abstract class Routes {
  Routes._();

  static const String login = '/';
  static const String notFound = '/404';

  // Public routes (no auth)
  static String publicVerify(String token) => '/verify/$token';

  static const employee = _EmployeeRoutes();
  static const trainer = _TrainerRoutes();
  static const admin = _AdminRoutes();
  static const qa = _QARoutes();
  static const auditor = _AuditorRoutes();
}

// ─────────────────────────────────────────────────────────────────────────────
// EMPLOYEE PORTAL
// ─────────────────────────────────────────────────────────────────────────────

class _EmployeeRoutes {
  const _EmployeeRoutes();

  String get root => '/employee';
  String get dashboard => '/employee';
  String get myTraining => '/employee/my-training';
  String get catalog => '/employee/catalog';
  String get trainingHistory => '/employee/training-history';
  String get credentials => '/employee/credentials';
  String get assessments => '/employee/assessments';
  String get lessons => '/employee/lessons';
  String get profile => '/employee/profile';
  String get mfa => '/employee/mfa';
  String get messages => '/employee/messages';
  String get downloads => '/employee/downloads';
  String get myBatches => '/employee/my-batches';
  String get assignedTraining => '/employee/assigned-training';
  String get standaloneAssignments => '/employee/standalone-assignments';
  String get operator => '/employee/operator';
  String get notifications => '/employee/notifications';
  String get compliance => '/employee/compliance';
  String get calendar => '/employee/calendar';
  String get documents => '/employee/documents';

  String course(String courseId) => '/employee/course/$courseId';
  String assessment(String courseId) => '/employee/assessment/$courseId';
  String batchDetail(int batchId) => '/employee/sessions/$batchId';
  String waiver(String id) => '/employee/waiver/$id';
  String assignmentDetail(int recipientId) =>
      '/employee/standalone-assignments/$recipientId';
}

// ─────────────────────────────────────────────────────────────────────────────
// TRAINER PORTAL
// ─────────────────────────────────────────────────────────────────────────────

class _TrainerRoutes {
  const _TrainerRoutes();

  String get root => '/trainer';
  String get dashboard => '/trainer';
  String get courses => '/trainer/courses';
  String get assessments => '/trainer/assessments';
  String get aiGenerate => '/trainer/assessments/ai-generate';
  String get materials => '/trainer/materials';
  String get sopDocuments => '/trainer/sop-documents';
  String get questionBank => '/trainer/question-bank';
  String get trainingMatrix => '/trainer/training-matrix';
  String get assignments => '/trainer/assignments';
  String get newCampaign => '/trainer/assignment-campaigns/new';
  String get reports => '/trainer/reports';
  String get learnerProgress => '/trainer/reports/learner-progress';
  String get completionMatrix => '/trainer/reports/completion-matrix';
  String get auditLog => '/trainer/audit-log';
  String get analytics => '/trainer/analytics';
  String get qaDashboard => '/trainer/qa-dashboard';
  String get compliance => '/trainer/compliance';
  String get notifications => '/trainer/notifications';
  String get profile => '/trainer/profile';
  String get messages => '/trainer/messages';
  String get batches => '/trainer/batches';

  // Parameterized routes
  String courseBuilder(int courseId) => '/trainer/courses/$courseId/builder';
  String courseVersions(int courseId) => '/trainer/courses/$courseId/versions';
  String courseMaterial(int courseId) => '/trainer/courses/$courseId/material';
  String courseAssessment(int courseId) => '/trainer/courses/$courseId/assessment';
  String courseQAReview(int courseId) => '/trainer/courses/$courseId/qa-review';
  String courseSopLinks(int courseId) => '/trainer/courses/$courseId/sop-links';
  String courseSme(int courseId) => '/trainer/courses/$courseId/sme';
  String courseAnalytics(int courseId) => '/trainer/courses/$courseId/analytics';
  String grading(int assessmentId) => '/trainer/assessments/grading/$assessmentId';
  String previewCourse(String courseId) => '/trainer/preview-course/$courseId';
  String batchDetail(int batchId) => '/trainer/batches/$batchId';
}

// ─────────────────────────────────────────────────────────────────────────────
// ADMIN PORTAL
// ─────────────────────────────────────────────────────────────────────────────

class _AdminRoutes {
  const _AdminRoutes();

  String get root => '/admin';
  String get dashboard => '/admin';
  String get profile => '/admin/profile';

  // Module 1: User & Identity
  String get usersDirectory => '/admin/users/directory';
  String get usersOrgTree => '/admin/users/org-tree';
  String get usersAccessReview => '/admin/users/access-review';
  String userView(int userId) => '/admin/users/directory/view/$userId';
  String userEdit(int userId) => '/admin/users/directory/view/$userId/edit';
  String userRoles(int userId) => '/admin/users/directory/view/$userId/roles';
  String userAuditTrail(int userId) => '/admin/users/directory/view/$userId/audit-trail';
  String userAccessLogs(int userId) => '/admin/users/directory/view/$userId/access-logs';
  String get userCreate => '/admin/users/directory/create';
  String get userImport => '/admin/users/directory/import';

  // Module 2: Courses
  String get coursesCatalogue => '/admin/courses/catalogue';
  String get coursesCreate => '/admin/courses/create';
  String get coursesApproval => '/admin/courses/approval';

  // Module 3: Enrollments
  String get enrollmentsList => '/admin/enrollments/list';
  String get enrollmentsCreate => '/admin/enrollments/create';
  String get enrollmentsBulk => '/admin/enrollments/bulk';
  String get enrollmentsRules => '/admin/enrollments/rules';
  String get enrollmentsTranscript => '/admin/enrollments/transcript';

  // Module 4: Batches
  String get batchesList => '/admin/batches/list';
  String get batchesCreate => '/admin/batches/create';
  String get batchesDetail => '/admin/batches/detail';

  // Module 5: Job Specs
  String get jobSpecsList => '/admin/job-specs/list';
  String get jobSpecsCreate => '/admin/job-specs/create';
  String get jobSpecsMatrix => '/admin/job-specs/matrix';
  String get jobSpecsGapAnalysis => '/admin/job-specs/gap-analysis';

  // Module 6: Assessments
  String get assessmentsQuestionBank => '/admin/assessments/question-bank';
  String get assessmentsList => '/admin/assessments/list';
  String get assessmentsCreate => '/admin/assessments/create';
  String get assessmentsAttemptReview => '/admin/assessments/attempt-review';

  // Module 7: Certificates
  String get certificatesList => '/admin/certificates/list';
  String get certificatesTemplates => '/admin/certificates/templates';
  String get certificatesExpiry => '/admin/certificates/expiry';

  // Module 8: Documents
  String get documentsLibrary => '/admin/documents/library';
  String get documentsUpload => '/admin/documents/upload';
  String get documentsAck => '/admin/documents/ack';

  // Module 9: Reports
  String get reportsCompliance => '/admin/reports/compliance';
  String get reportsGap => '/admin/reports/gap';
  String get reportsRegulatory => '/admin/reports/regulatory';
  String get reportsScheduled => '/admin/reports/scheduled';

  // Module 10: Audit & CAPA
  String get auditTrail => '/admin/audit/trail';
  String get auditIntegrity => '/admin/audit/integrity';
  String get auditCapa => '/admin/audit/capa';

  // Module 11: Notifications
  String get notificationsTemplates => '/admin/notifications/templates';
  String get notificationsRules => '/admin/notifications/rules';
  String get notificationsBroadcast => '/admin/notifications/broadcast';

  // Module 12: Analytics
  String get analyticsDashboard => '/admin/analytics/dashboard';
  String get analyticsReportBuilder => '/admin/analytics/report-builder';

  // Module 13: System
  String get systemSettings => '/admin/system/settings';
  String get systemHrIntegration => '/admin/system/hr-integration';
  String get systemApiKeys => '/admin/system/api-keys';
  String get systemHealth => '/admin/system/health';
  String get systemValidationDocs => '/admin/system/validation-docs';
  String get systemRetention => '/admin/system/retention';
  String get systemGdpr => '/admin/system/gdpr';
}

// ─────────────────────────────────────────────────────────────────────────────
// QA PORTAL
// ─────────────────────────────────────────────────────────────────────────────

class _QARoutes {
  const _QARoutes();

  String get root => '/qa';
  String get dashboard => '/qa/dashboard';
  String get messages => '/qa/messages';

  String courseReview(int courseId) => '/qa/course/$courseId/review';
}

// ─────────────────────────────────────────────────────────────────────────────
// AUDITOR PORTAL
// ─────────────────────────────────────────────────────────────────────────────

class _AuditorRoutes {
  const _AuditorRoutes();

  String get root => '/auditor';
  String get employeeSearch => '/auditor/employee-search';
  String get sopCoverage => '/auditor/sop-coverage';
  String get configChangeHistory => '/auditor/config-change-history';

  // Shared auditor routes (top-level)
  String get auditTrail => '/audit-trail';
  String get complianceReport => '/compliance-report';
  String get esignatureVerification => '/esignature-verification';
}
