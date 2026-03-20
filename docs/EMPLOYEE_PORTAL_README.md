# Employee Portal — Complete Reference

This document describes the **entire employee portal**: all **classes**, **methods**, **relations**, **schema** (data classes and fields), and **every button** with the data it reads and writes. Use it for onboarding, audits, and impact analysis.

**Related:** [EMPLOYEE_PORTAL_DATABASE_ACCESS.md](./EMPLOYEE_PORTAL_DATABASE_ACCESS.md) (tables per screen), [DATABASE_SCHEMA_README.md](./DATABASE_SCHEMA_README.md) (full schema).

---

## Table of contents

1. [Scope & routes](#1-scope--routes)
2. [Shared data classes (protocol / schema)](#2-shared-data-classes-protocol--schema)
3. [Providers & client methods](#3-providers--client-methods)
4. [Layout: Employee shell](#4-layout-employee-shell)
5. [Screens: classes, methods, buttons](#5-screens-classes-methods-buttons)
6. [Relations overview](#6-relations-overview)

---

## 1. Scope & routes

All employee portal screens live under the **EmployeeShellV2** layout. Routes:

| Route | Screen widget | File |
|-------|----------------|------|
| `/` | LoginScreen | `auth/login_screen_redesign.dart` |
| `/employee` | EmployeeDashboardV2 | `employee_dashboard/employee_dashboard_v2.dart` |
| `/employee/my-training` | MyTrainingScreen | `my_learning/my_training_screen.dart` |
| `/employee/catalog` | CourseCatalogScreenRedesigned | `course_catalog/course_catalog_screen_redesigned.dart` |
| `/employee/course/:courseId` | CourseViewerScreenV2 | `course_viewer/course_viewer_screen_v2.dart` |
| `/employee/assessment/:courseId` | AssessmentScreenV2 | `assessment/assessment_v2.dart` |
| `/employee/assessments` | AssessmentListScreen | `assessment/assessment_list_screen.dart` |
| `/employee/training-history` | TrainingHistoryV2 | `training_history/training_history_v2.dart` |
| `/employee/credentials` | CertificationScreenV2 | `credentials/certification_screen_v2.dart` |
| `/employee/profile` | ProfileSettingsScreen | `profile/profile_settings_screen.dart` |
| `/employee/mfa` | MfaEnrollmentScreen | `auth/mfa_enrollment_screen.dart` |
| `/employee/lessons` | LessonsScreen | `my_learning/lessons_screen.dart` |
| `/employee/waiver/:id` | TrainingWaiverScreen | `waiver/training_waiver_screen.dart` |
| `/employee/downloads` | DownloadsScreen | `downloads/downloads_screen.dart` |

---

## 2. Shared data classes (protocol / schema)

These are the **protocol types** (from `pharma_lms_client`) used across the employee portal. Key fields that screens **read** or **write** are listed.

### PharmaUser  
**Table:** `pharma_user`  
**Key fields:** `id`, `email`, `fullName`, `departmentId`, `jobRoleId`, `user` (relation), `organizationId`.

### UserRole / Role  
**Tables:** `user_role`, `role`  
**Key fields:** `userId`, `roleId`, `role.code` (e.g. `employee`, `trainer`, `admin`).

### Enrollment  
**Table:** `enrollment`  
**Key fields:** `id`, `userId`, `courseVersionId`, `assignmentId`, `status` (not_started | in_progress | completed | assigned), `startedAt`, `completedAt`, `retrainingChangeSummary`, `acknowledgedAt`, `courseVersion` (relation), `assignment` (relation).

### TrainingAssignment  
**Table:** `training_assignment`  
**Key fields:** `id`, `userId`, `courseVersionId`, `assignedById`, `dueDate`, `priority`, `status`, `source` (e.g. self, manual, sop_update).

### Course  
**Table:** `course`  
**Key fields:** `id`, `title`, `sopNumber`, `description`, `status`, `organizationId`.

### CourseVersion  
**Table:** `course_version`  
**Key fields:** `id`, `courseId`, `status` (draft | approved | effective | obsolete), `versionNumber`, `changeSummary`, `course` (relation).

### Module / Lesson  
**Tables:** `module`, `lesson`  
**Key fields:** `id`, `courseVersionId`, `moduleId` (for lesson), `title`, `orderIndex`.

### Material / MaterialProgress  
**Tables:** `material`, `material_progress`  
**Key fields (MaterialProgress):** `id`, `enrollmentId`, `lessonId`, `materialId`, `progressPct`, `lastPositionSeconds`, `completedAt`; **writes:** `progressPct`, `lastPositionSeconds`, `completedAt`.

### Certificate  
**Table:** `certificate`  
**Key fields:** `id`, `userId`, `courseVersionId`, `trainingRecordId`, `expiresAt`, `qrCode`, `status`, `esignatureId`.

### TrainingRecord  
**Table:** `training_record`  
**Key fields:** `id`, `enrollmentId`, `userId`, `courseVersionId`, `esignatureId`, `score`, `completedAt`.

### Assessment / AssessmentAttempt / AssessmentResult  
**Tables:** `assessment`, `assessment_attempt`, `assessment_result`  
**Key fields (Attempt):** `id`, `enrollmentId`, `assessmentId`, `status`, `startedAt`, `submittedAt`, `score`; **Result:** `attemptId`, `questionId`, `selectedOptionId`, `isCorrect`.

### Question / QuestionBank  
**Tables:** `question`, `question_bank`  
**Key fields (Question):** `id`, `questionBankId`, `questionText`, `options` (JSON), `correctOptionId`.

### UserComplianceMetrics (DTO)  
**No table.**  
**Fields:** `compliant`, `overdueCount`, `upcomingCount`, `complianceRate`, `totalCertificates`, `waivedCount`.

### Notification  
**Table:** `notification`  
**Key fields:** `id`, `userId`, `title`, `body`, `readAt`, `createdAt`; **write:** `readAt`.

### UserMfa / MfaVerifiedSession  
**Tables:** `user_mfa`, `mfa_verified_session`  
**Key fields (UserMfa):** `id`, `userId`, `secret`, `enabled`; **writes:** insert/update on enroll, update on disable.

### TrainingWaiver  
**Table:** `training_waiver`  
**Key fields:** `id`, `userId`, `courseVersionId`, `status`, `reason`, `expiresAt`, `approvedAt`, `approvedById`.

### ElectronicSignature  
**Table:** `electronic_signature`  
**Key fields:** `id`, `userId`, `signatureMeaning`, `entityType`, `entityId`, `signedAt`; **write:** insert on training complete.

### ReportExport / AuditTrail  
**Tables:** `report_export`, `audit_trail`  
**ReportExport write:** `exportedById`, `reportType`, `fileHash`, `exportedAt`, `filterParamsJson`, `recordCount`.

### DashboardSummary (in-memory)  
**No table.** Aggregates: `PharmaUser user`, `List<Enrollment> inProgress/toDo/completed`, `UserComplianceMetrics compliance`, `List<TrainingAssignment> assignments`, `monthlyHours`, `complianceAlerts`, `upcomingDueDates`, `recentActivity`, `weeklyProgress`, `learningStreak`, `averageQuizScore`, `totalHoursThisYear`, `fetchedAt`.

---

## 3. Providers & client methods

| Provider | Client / repository method | Backend endpoint | Tables read |
|----------|----------------------------|------------------|-------------|
| currentUserProvider | user.getUserByEmail(email) | UserEndpoint.getUserByEmail | pharma_user |
| selectedRoleProvider | (from auth + user.getUserRoleByEmail) | UserEndpoint.getUserRoleByEmail | pharma_user, user_role, role |
| enrollmentsProvider | trainingRepository.getEnrollmentsForUser(userId) | TrainingEndpoint.getEnrollmentsForUser | enrollment (+ course_version, course) |
| assignmentsProvider | trainingRepository.getAssignmentsForUser(userId) | TrainingEndpoint.getAssignmentsForUser | training_assignment |
| enrollmentResumeLabelsProvider | trainingRepository.getEnrollmentResumePosition(enrollmentId) | TrainingEndpoint.getEnrollmentResumePosition | material_progress, lesson, module |
| userComplianceProvider | client.compliance.getUserCompliance(userId) | ComplianceEndpoint.getUserCompliance | certificate, training_waiver, enrollment, training_assignment |
| certificatesProvider | trainingRepository.getCertificatesForUser(userId) | TrainingEndpoint.getCertificatesForUser | certificate |
| trainingRecordsProvider | trainingRepository.getTrainingRecordsForUser(userId) | TrainingEndpoint.getTrainingRecordsForUser | training_record |
| coursesProvider | client.course.listCourses() | CourseEndpoint.listCourses | course |
| dashboardSummaryProvider | (combines enrollments, compliance, assignments, monthlyTrainingHours, complianceAlerts, userAverageQuizScore, upcomingDueDates, recentActivity, weeklyLearningProgress, learningStreak) | training + compliance + analytics | enrollment, training_assignment, certificate, pharma_user, department, etc. |
| monthlyTrainingHoursProvider | client.analytics.getMonthlyTrainingHours(userId) | AnalyticsEndpoint | training_record, etc. |
| complianceAlertsProvider | client.analytics.getComplianceAlerts(userId) | AnalyticsEndpoint | certificate, enrollment, etc. |
| upcomingDueDatesProvider | client.analytics.getUpcomingDueDates(userId) | AnalyticsEndpoint | training_assignment, enrollment |
| recentActivityProvider | client.analytics.getRecentActivity(userId) | AnalyticsEndpoint | training_record, enrollment |
| weeklyLearningProgressProvider | client.analytics.getWeeklyLearningProgress(userId) | AnalyticsEndpoint | material_progress, etc. |
| learningStreakProvider | client.analytics.getUserLearningStreak(userId) | AnalyticsEndpoint | — |
| userAverageQuizScoreProvider | client.analytics.getUserAverageQuizScore(userId) | AnalyticsEndpoint | assessment_result, assessment_attempt |
| inAppNotificationsProvider | client.notification.getInAppNotifications(userId) | NotificationEndpoint | notification (+ assignments, enrollments, courses) |
| userAssessmentsProvider | (enrollments + assessment.getAssessmentForCourse + getAttemptCount per enrollment) | TrainingEndpoint, AssessmentEndpoint | enrollment, assessment, assessment_attempt |

**Client methods used for writes (employee portal):**

| Method | Endpoint | Tables written |
|--------|----------|----------------|
| client.training.selfEnroll(userId, courseVersionId) | TrainingEndpoint.selfEnroll | training_assignment, enrollment, audit_trail |
| client.material.updateProgress(...) | MaterialEndpoint.updateProgress | material_progress, enrollment |
| client.material.recordEngagement(...) | MaterialEndpoint.recordEngagement | material_progress, enrollment |
| client.assessment.startAttempt(enrollmentId, assessmentId) | AssessmentEndpoint.startAttempt | assessment_attempt |
| client.assessment.recordAnswer(attemptId, questionId, selectedOptionId) | AssessmentEndpoint.recordAnswer | assessment_result |
| client.assessment.submitAttempt(attemptId) | AssessmentEndpoint.submitAttempt | assessment_attempt |
| client.training.createTrainingSignature(...) | TrainingEndpoint.createTrainingSignature | electronic_signature |
| client.training.completeTraining(...) | TrainingEndpoint.completeTraining | training_record, certificate, enrollment, audit_trail |
| client.notification.markNotificationRead(notificationId) | NotificationEndpoint.markNotificationRead | notification (readAt) |
| client.audit.logReportExport(...) | AuditEndpoint.logReportExport | report_export, audit_trail |
| client.mfa.enrollMfa(...) / verifyMfaEnrollment / disableMfa / verifyMfa | MfaEndpoint | user_mfa, mfa_verified_session |
| client.auth.signOutDevice() | Auth | session (no app table) |

---

## 4. Layout: Employee shell

### 4.1 Classes

| Class | File | Description |
|-------|------|-------------|
| EmployeeShellV2 | employee_shell_v2.dart | ConsumerStatefulWidget; holds child, session timer, idle timeout. |
| _EmployeeShellV2State | employee_shell_v2.dart | Session bar, idle timer, session timeout dialog. |
| _SidebarV2 | employee_shell_v2.dart | Desktop sidebar: logo, nav items. |
| _NavItemV2 | employee_shell_v2.dart | Single nav link (route, label, icon). |
| _SidebarSectionLabel | employee_shell_v2.dart | Section heading (e.g. OVERVIEW, TRAINING). |
| _HeaderV2 | employee_shell_v2.dart | Top bar: menu (mobile), search, notifications, profile. |
| _MobileDrawerV2 | employee_shell_v2.dart | Mobile drawer with same nav. |
| _MobileBottomNavV2 | employee_shell_v2.dart | Bottom nav (Dashboard, Courses, etc.). |

### 4.2 Methods (state / handlers)

- `_resetIdleTimer()` — resets 15-min idle timer and session bar.
- `_startSessionBar()` — 2px progress bar (session time remaining).
- `_showSessionTimeoutWarning()` — dialog: "Session Timeout", countdown, "Sign Out" / "Stay Signed In".
- `logout(ref, context)` — from auth_provider: `client.auth.signOutDevice()`, clear role, `context.go('/')`.

### 4.3 Data read/write

- **Read:** currentUserProvider → `user.getUserByEmail` → pharma_user; inAppNotificationsProvider → notification (+ related).
- **Write:** markNotificationRead → notification.readAt; signOut → session only.

### 4.4 Buttons & actions

| Location | Label / Action | Reads | Writes |
|----------|----------------|-------|--------|
| Sidebar / Drawer / Bottom nav | Dashboard | — | — |
| | Course Catalogue | — | — |
| | My Training | — | — |
| | Assessments | — | — |
| | Training History | — | — |
| | Credentials | — | — |
| | Lessons | — | — |
| | Downloads | — | — |
| | Profile | — | — |
| | MFA (if shown) | — | — |
| Sidebar footer | Sign Out | currentUserProvider (PharmaUser) | auth.signOutDevice (session) |
| Session timeout dialog | Sign Out | — | auth.signOutDevice |
| Session timeout dialog | Stay Signed In | — | — (resets idle timer) |
| Header | Notifications icon → list | inAppNotificationsProvider (Notification) | — |
| Header | Mark notification read | Notification.id | notification.readAt |
| Header | Profile menu → Sign Out | — | auth.signOutDevice |

---

## 5. Screens: classes, methods, buttons

### 5.1 Login (`/`)

**Classes:** LoginScreen (ConsumerStatefulWidget), _LoginScreenState.

**Methods:** Submit → getRole (getUserRoleByEmail or roleForEmailLocal), MFA flow (getMfaStatus, verifyMfa), then pathForRole → go to /employee, /trainer, or /admin.

**Data:** Reads pharma_user, user_role, role, user_mfa; no app table writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Sign In | email, password (form) | — (auth session) |
| MFA code Submit | user_mfa, session | mfa_verified_session (verify path) |

---

### 5.2 Employee dashboard (`/employee`)

**Classes:** EmployeeDashboardV2 (ConsumerWidget), _DashboardContent, _ComplianceBanner, _WelcomeCard, _HoursSpentChart, _PerformanceChart, _ContinueLearningSection, _UpcomingDeadlinesCard, _RecentActivityCard, _ComplianceAlertsSection.

**Methods:** Ref.watch(dashboardSummaryProvider); onRefresh → ref.invalidate(dashboardSummaryProvider).

**Data:** Reads from dashboardSummaryProvider (see Providers): user, enrollments, assignments, certificates, compliance, analytics (monthlyHours, complianceAlerts, upcomingDueDates, recentActivity, weeklyProgress, learningStreak, averageQuizScore). No direct writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Retry (error state) | — | — (invalidates dashboardSummaryProvider) |
| Pull-to-refresh | — | — (invalidates dashboardSummaryProvider) |
| View Overdue (banner) | summary.compliance.overdueCount | — |
| View Details (cert revoked) | summary.complianceAlerts (type cert_revoked) | — |
| Start Retraining (SOP banner) | summary.complianceAlerts (type sop_retraining) | — |
| Continue Learning card tap | enrollment.id, enrollment.courseVersionId, course.id | — |
| View Overdue (deadlines) | summary.upcomingDueDates | — |
| View All (recent activity) | summary.recentActivity | — |
| Last updated | employeeDashboardLastUpdatedProvider | — |

Navigation from buttons: context.go('/employee/lessons'), context.go('/employee/credentials'), context.go('/employee/course/...') with extra courseVersionId, enrollmentId, etc.

---

### 5.3 My Training (`/employee/my-training`)

**Classes:** MyTrainingScreen (ConsumerStatefulWidget), _MyTrainingScreenState, _MyTrainingContent, _TrainingCard (or similar).

**Methods:** _loadProgressForEnrollments → client.training.getEnrollmentProgress(enrollmentId) → reads material_progress; onRefresh invalidates enrollmentsProvider, assignmentsProvider, enrollmentResumeLabelsProvider, userComplianceProvider. Filter/sort: statusFilter, sortBy, searchQuery (local state).

**Data:** Reads Enrollment (id, status, courseVersionId, courseVersion.course.title), TrainingAssignment (dueDate), UserComplianceMetrics (overdueCount), getEnrollmentProgress → progressPct. No writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Pull-to-refresh | — | — (invalidates providers) |
| Retry (error) | — | — (invalidates enrollmentsProvider, assignmentsProvider) |
| Course card tap (Resume / Start / View Certificate) | enrollment.id, status, courseVersionId, course.id, assignment.dueDate | — |
| Status filter (All / Overdue / In Progress / Not Started / Completed) | enrollments, _getStatus(enrollment) | — |
| Sort (Due date / Title) | enrollments, assignment.dueDate, courseVersion.course.title | — |
| Search | enrollments, courseVersion.course.title, description | — |

Navigation: context.go('/employee/credentials') for completed; context.go('/employee/course/...') or context.go('/employee/assessment/...') for resume/start.

---

### 5.4 Course catalog (`/employee/catalog`)

**Classes:** CourseCatalogScreenRedesigned (ConsumerStatefulWidget), _CourseCatalogScreenRedesignedState, _CatalogContent, _CourseCard.

**Methods:** _handleView(Course) → client.course.getCourseVersions(course.id) → context.go('/employee/course/...', extra: courseVersionId). _handleEnroll(Course) → confirm dialog → client.course.getCourseVersions(course.id) → client.training.selfEnroll(userId, courseVersionId) → ref.invalidate(enrollmentsProvider).

**Data:** Reads Course (id, title, sopNumber, description, status), Enrollment (to derive _enrolledCourseIds), getCourseVersions → course_version. Writes: selfEnroll → training_assignment, enrollment, audit_trail.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Retry (error) | — | — (invalidates coursesProvider, enrollmentsProvider) |
| Clear Filters | — | — (local state) |
| Continue (course card, when enrolled) | course.id, enrollments (courseVersion.course.id) | — |
| Enroll (course card, when not enrolled) | currentUserProvider (user.id), course.id, course.title | training_assignment (insert), enrollment (insert), audit_trail (SelfEnrolled) |
| Enroll dialog Cancel | — | — |
| Enroll dialog Enroll | user.id, course.id, getCourseVersions → courseVersion.id | training_assignment, enrollment, audit_trail |
| Sort (title / status) | courses (title, status) | — |
| Category filter | courses (status) | — |
| Search | courses (title, description, sopNumber) | — |

---

### 5.5 Course viewer (`/employee/course/:courseId`)

**Classes:** CourseViewerScreenV2 (ConsumerStatefulWidget), _CourseViewerScreenV2State.

**Methods:** getEnrollmentById, getCourseVersion, getModulesForCourseVersion, getLessonsForModule, getLessonWithMaterial, getProgress, recordEngagement, updateProgress, getMaterialViewUrl. Navigation to assessment: context.push('/employee/assessment/...', extra: courseVersionId, enrollmentId).

**Data:** Reads enrollment, course_version, module, lesson, material, material_progress, signature_meaning. Writes: material_progress (insert/update), enrollment (status/last position via updateProgress/recordEngagement).

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Back (outline) | current lesson index | — |
| Next / Previous lesson | lesson order, current index | — |
| Mark as viewed / Update progress | enrollmentId, lessonId, materialId, progressPct, lastPositionSeconds | material_progress (insert/update), enrollment (update) |
| Record engagement (e.g. video heartbeat) | enrollmentId, lessonId, materialId | material_progress, enrollment |
| Take assessment / Start assessment | enrollment.id, courseVersionId, assessment linked to course | — |
| Play / Pause (video) | — | — (local only or engagement) |

---

### 5.6 Assessments list (`/employee/assessments`)

**Classes:** AssessmentListScreen (ConsumerWidget), _AssessmentListContent, _AssessmentCard (or similar).

**Methods:** userAssessmentsProvider (enrollments + per-enrollment getAssessmentForCourse, getAttemptCount). Ref.invalidate(userAssessmentsProvider) on Retry/refresh.

**Data:** Reads pharma_user, enrollment, assessment, assessment_attempt. No writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Retry / Refresh | — | — (invalidates userAssessmentsProvider) |
| Training History link | — | — |
| Start / Retake assessment | enrollment.id, courseVersionId, courseId, courseTitle, getAssessmentForCourse, getAttemptCount | — |
| Exit confirmation Cancel | — | — |
| Exit confirmation Exit | — | — |

Navigation: context.go('/employee/assessment/...', extra: courseVersionId, enrollmentId).

---

### 5.7 Assessment take (`/employee/assessment/:courseId`)

**Classes:** AssessmentScreenV2 (ConsumerStatefulWidget), _AssessmentScreenV2State, question/answer UI components, e-signature dialog, result view.

**Methods:** getAssessmentForCourse, getQuestions, getAttemptCount, startAttempt, recordAnswer, submitAttempt, getEnrollmentById, getTrainingRecordsForUser, completeTraining, createTrainingSignature. State: current attempt, selected answers, e-signature flow.

**Data:** Reads enrollment, assessment, question_bank, question, assessment_attempt, assessment_result, training_record. Writes: assessment_attempt (insert, update on submit), assessment_result (insert per answer), training_record, certificate, enrollment (completeTraining), electronic_signature, audit_trail.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Exit / Close | — | — |
| Exit confirmation: Stay | — | — |
| Exit confirmation: Exit | — | — (navigate away) |
| Start assessment | enrollmentId, assessmentId, getAttemptCount | assessment_attempt (insert) |
| Previous / Next question | attemptId, question index | — |
| Select answer (option tap) | questionId, options | — (local state; recordAnswer on submit or per answer) |
| Submit attempt | attemptId, selected answers | assessment_result (insert), assessment_attempt (update submittedAt, score) |
| Sign Now (e-signature) | userId, signature meaning, entityType/Id | electronic_signature (insert) |
| Continue (after sign) | enrollmentId, userId, courseVersionId, esignatureId | training_record (insert), certificate (insert), enrollment (update status, completedAt), audit_trail |
| View Certificates | — | — |
| Retake | enrollmentId, assessmentId | assessment_attempt (insert new), assessment_result (insert) |
| Retry (error) | — | — |
| Back (from result) | — | — |

---

### 5.8 Training history (`/employee/training-history`)

**Classes:** TrainingHistoryV2 (ConsumerStatefulWidget), _TrainingHistoryV2State.

**Methods:** _downloadPdf → build PDF from trainingRecordsProvider, enrollmentsProvider, certificatesProvider → SHA-256 hash → client.audit.logReportExport(reportType: 'employee_training_history', hashSha256) → save file. _loadProgressForEnrollments → getEnrollmentProgress. Tab switch: _selectedTab (All / Completed / In Progress / Not Started).

**Data:** Reads training_record, enrollment, certificate, material_progress (getEnrollmentProgress). Writes: logReportExport → report_export, audit_trail.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Pull-to-refresh | — | — (invalidates trainingRecordsProvider, enrollmentsProvider, certificatesProvider) |
| Download PDF | currentUserProvider (user.id), trainingRecordsProvider, enrollmentsProvider, certificatesProvider (Certificate.id, courseVersionId, userId, expiresAt; TrainingRecord; Enrollment) | report_export (insert), audit_trail (ReportExported) |
| Tab (All Records / Completed / In Progress / Not Started) | enrollments (status), training records | — |
| Expand row (if any) | record, enrollment, certificate | — |
| Nav: Dashboard / Course Catalogue / etc. | — | — |

---

### 5.9 Credentials (`/employee/credentials`)

**Classes:** CertificationScreenV2 (ConsumerWidget).

**Methods:** certificatesProvider, enrollmentsProvider; certificate PDF download (if implemented) may call backend or file service.

**Data:** Reads certificate, enrollment, course_version, course, training_record. No writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Pull-to-refresh (if present) | — | — (invalidates certificatesProvider, enrollmentsProvider) |
| Certificate card / Download | Certificate (id, userId, courseVersionId, expiresAt, qrCode), course title | — |

---

### 5.10 Profile (`/employee/profile`)

**Classes:** ProfileSettingsScreen (ConsumerStatefulWidget), _ProfileSettingsScreenState.

**Methods:** currentUserProvider (getUserByEmail), certificatesProvider; logout(ref, context) → client.auth.signOutDevice().

**Data:** Reads pharma_user, certificate. No app table writes (signOut is session only).

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Sign Out | — | auth.signOutDevice (session) |
| Sign Out Other Devices (if present) | — | auth (session) |
| Sign Out confirmation: Cancel | — | — |
| Sign Out confirmation: Sign Out | — | auth.signOutDevice |

---

### 5.11 MFA enrollment (`/employee/mfa`)

**Classes:** MfaEnrollmentScreen (ConsumerStatefulWidget), _MfaEnrollmentScreenState.

**Methods:** getMfaStatus, enrollMfa, verifyMfaEnrollment, verifyMfa, disableMfa.

**Data:** Reads user_mfa, mfa_verified_session. Writes user_mfa (insert/update), mfa_verified_session (insert).

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Enroll MFA | user_mfa (getMfaStatus) | user_mfa (insert/update) |
| Verify enrollment (code) | user_mfa | mfa_verified_session (insert), user_mfa (update) |
| Verify (login flow) | user_mfa, mfa_verified_session | mfa_verified_session (insert) |
| Disable MFA | user_mfa | user_mfa (update enabled) |

---

### 5.12 Waiver (`/employee/waiver/:id`)

**Classes:** TrainingWaiverScreen (StatefulWidget), _TrainingWaiverScreenState.

**Methods:** client.training.getWaiverById(waiverId) or equivalent.

**Data:** Reads training_waiver. No writes (view only).

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| (View waiver details) | training_waiver (id, userId, courseVersionId, status, reason, expiresAt, approvedAt) | — |

---

### 5.13 Lessons (`/employee/lessons`)

**Classes:** LessonsScreen (ConsumerWidget).

**Methods:** enrollmentsProvider, enrollmentResumeLabelsProvider (getEnrollmentResumePosition). Navigation to course viewer.

**Data:** Reads enrollment, material_progress (resume position). No writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Resume / Start (per enrollment) | enrollment.id, courseVersionId, course.id, resume label | — |
| Pull-to-refresh (if present) | — | — (invalidates enrollmentsProvider, enrollmentResumeLabelsProvider) |

---

### 5.14 Downloads (`/employee/downloads`)

**Classes:** DownloadsScreen (ConsumerWidget).

**Methods:** certificatesProvider (getCertificatesForUser). Download file (if implemented) may use certificate ID or URL from backend.

**Data:** Reads certificate, training_record, course_version. No writes.

| Button / Action | Reads | Writes |
|-----------------|-------|--------|
| Download (per certificate) | Certificate (id, userId, courseVersionId, qrCode, etc.) | — |

---

## 6. Relations overview

```
Login
  → user.getUserRoleByEmail(email)     → pharma_user, user_role, role
  → mfa.getMfaStatus / verifyMfa       → user_mfa, mfa_verified_session

EmployeeShellV2
  → currentUserProvider                → pharma_user
  → inAppNotificationsProvider         → notification
  → markNotificationRead               → notification (readAt)
  → logout                             → auth (session)

EmployeeDashboardV2
  → dashboardSummaryProvider           → enrollments, assignments, certificates, compliance, analytics (many tables)
  → Navigation buttons                 → no extra read/write

MyTrainingScreen
  → enrollmentsProvider, assignmentsProvider, enrollmentResumeLabelsProvider, userComplianceProvider
  → getEnrollmentProgress(enrollmentId) → material_progress
  → Card tap                           → navigate (no write)

CourseCatalogScreenRedesigned
  → coursesProvider, enrollmentsProvider
  → getCourseVersions(courseId)        → course_version
  → selfEnroll(userId, courseVersionId)→ training_assignment, enrollment, audit_trail

CourseViewerScreenV2
  → getEnrollmentById, getCourseVersion, getModules, getLessons, getLessonWithMaterial, getProgress
  → updateProgress / recordEngagement  → material_progress, enrollment
  → Navigate to assessment             → no write

AssessmentListScreen
  → userAssessmentsProvider            → enrollment, assessment, assessment_attempt
  → Card tap                           → navigate

AssessmentScreenV2
  → startAttempt                       → assessment_attempt (insert)
  → recordAnswer                       → assessment_result (insert)
  → submitAttempt                      → assessment_attempt (update)
  → createTrainingSignature            → electronic_signature (insert)
  → completeTraining                   → training_record, certificate, enrollment (update), audit_trail

TrainingHistoryV2
  → trainingRecordsProvider, enrollmentsProvider, certificatesProvider
  → logReportExport                    → report_export, audit_trail

CertificationScreenV2 / ProfileSettingsScreen / LessonsScreen / DownloadsScreen / TrainingWaiverScreen
  → Read-only or session (logout)      → see tables in EMPLOYEE_PORTAL_DATABASE_ACCESS.md

MfaEnrollmentScreen
  → getMfaStatus, enrollMfa, verifyMfaEnrollment, verifyMfa, disableMfa → user_mfa, mfa_verified_session
```

---

*For table-level detail per screen see [EMPLOYEE_PORTAL_DATABASE_ACCESS.md](./EMPLOYEE_PORTAL_DATABASE_ACCESS.md). For full schema of all protocol classes and fields see [DATABASE_SCHEMA_README.md](./DATABASE_SCHEMA_README.md).*
