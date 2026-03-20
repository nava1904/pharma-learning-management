# Employee Portal — Screen Layouts, Navigation & Data Tables

For each employee portal screen this document gives: **layout** (UI structure), **navigation** (from/to routes), **data tables** (read/write), and **per-section** which **DB/API** calls each part of the layout uses. Use it for UX, QA, and data-flow audits.

**Related:** [EMPLOYEE_PORTAL_DATABASE_ACCESS.md](./EMPLOYEE_PORTAL_DATABASE_ACCESS.md), [EMPLOYEE_PORTAL_SYSTEM_DESIGN.md](./EMPLOYEE_PORTAL_SYSTEM_DESIGN.md).

---

## Navigation overview (all screens)

```
/ (Login)
  └─ role=employee → /employee

/employee (Dashboard)          ← Shell: sidebar + header + child
  ├─ /employee/my-training
  ├─ /employee/catalog
  ├─ /employee/lessons
  ├─ /employee/assessments
  ├─ /employee/training-history
  ├─ /employee/credentials
  ├─ /employee/downloads
  ├─ /employee/profile
  ├─ /employee/mfa
  ├─ /employee/waiver/:id
  ├─ /employee/course/:courseId        (from catalog, my-training, dashboard, lessons)
  └─ /employee/assessment/:courseId   (from course viewer, assessments list, my-training)
```

---

## 1. Login (`/`)

| Item | Detail |
|------|--------|
| **Route** | `/` |
| **Widget** | LoginScreen (`auth/login_screen_redesign.dart`) |
| **Navigation from** | App start; after logout from any portal |
| **Navigation to** | `/employee`, `/trainer`, `/admin`, `/qa`, `/auditor` by role |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header** | App logo / title | — |
| **Form** | Email, password (and optional role selector for demo) | — |
| **Sign In button** | Submit credentials | **Read:** `client.user.getUserRoleByEmail(email)` → pharma_user, user_role, role. **Write:** (session only if real auth) |
| **MFA code input** | Shown if getMfaStatus() says MFA enabled | **Read:** user_mfa. **Write:** `client.mfa.verifyMfa(code)` → mfa_verified_session (insert) |
| **Error / loading** | Message or spinner | — |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, user_role, role, user_mfa, mfa_verified_session | (session only; no app tables) |

---

## 2. Employee shell (layout wrapper)

| Item | Detail |
|------|--------|
| **Route** | Wraps all `/employee/*` (not a route itself) |
| **Widget** | EmployeeShellV2 (`layout/employee_shell_v2.dart`) |
| **Navigation** | Sidebar and header links to every employee route; Sign Out → `/` |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Session bar** | 2px progress bar (session time left) | — (local timer) |
| **Sidebar (desktop)** | Logo; OVERVIEW → Dashboard; TRAINING → Course Catalogue, My Learning, Assessments; RECORDS → Training History, Certifications, Downloads; ACCOUNT → Profile; Sign Out | Navigation only (context.go) |
| **Header** | Menu (mobile), search placeholder, notifications icon, profile dropdown | **Read:** currentUserProvider → getUserByEmail → pharma_user; notificationsProvider → getInAppNotifications → notification (+ assignments, enrollments, courses for build). **Write:** markNotificationRead → notification.readAt (if implemented) |
| **Profile dropdown** | Sign Out | **Write:** client.auth.signOutDevice() (session) |
| **Timeout dialog** | “Session Timeout”, countdown, Stay / Sign Out | **Write:** logout → signOutDevice (session) |
| **Main area** | Child widget (current route screen) | — |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, notification (and assignment/enrollment/course for notification build) | notification (readAt), session (signOut) |

---

## 3. Dashboard (`/employee`)

| Item | Detail |
|------|--------|
| **Route** | `/employee` |
| **Widget** | EmployeeDashboardV2 (`employee_dashboard/employee_dashboard_v2.dart`) |
| **Navigation from** | Login (role=employee); sidebar “Dashboard”; any employee screen via shell |
| **Navigation to** | `/employee/lessons`, `/employee/credentials`, `/employee/course/:id` (with extra) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Pull-to-refresh** | RefreshIndicator | **Read:** ref.invalidate(dashboardSummaryProvider) → re-runs all providers below |
| **0. Compliance banners** | Conditional: Overdue (red), Cert revoked (red), SOP retraining (orange). Each has “View Overdue” / “View Details” / “Start Retraining” | **Read:** summary.compliance (userComplianceProvider → certificate, training_waiver, enrollment, training_assignment), summary.complianceAlerts (analytics). **Write:** none. **Nav:** context.go('/employee/lessons') or '/employee/credentials' |
| **1. Welcome card** | “Hello {name}”, email, stats (e.g. compliance %, certs), avatar | **Read:** summary.user (pharma_user), summary.compliance (compliance tables), summary.assignments/certificates. **Write:** none |
| **2. Charts row** | Hours spent (bar), Performance (area + mini-stats) | **Read:** summary.monthlyHours (getMonthlyTrainingHours → training_record etc.), summary.weeklyProgress, summary.averageQuizScore, summary.learningStreak (analytics). **Write:** none |
| **3. Continue learning** | Up to 3 cards: in-progress/to-do enrollments, image, progress, “Continue” | **Read:** summary.inProgress, summary.toDo (enrollment). **Write:** none. **Nav:** context.go('/employee/course/…', extra: courseVersionId, enrollmentId, …) |
| **4. Upcoming deadlines + Recent activity** | Two columns: due dates list; recent activity list | **Read:** summary.upcomingDueDates (getUpcomingDueDates), summary.recentActivity (getRecentActivity). **Write:** none. **Nav:** “View Overdue” → /employee/lessons |
| **5. Compliance alerts** | Expiring certs (30/60/90), SOP retraining queue | **Read:** summary.complianceAlerts (getComplianceAlerts), summary.compliance.overdueCount. **Write:** none |
| **6. Last updated** | “Last updated just now” / “Xm ago” | **Read:** employeeDashboardLastUpdatedProvider (set when dashboardSummaryProvider completes). **Write:** none |
| **Error state** | Retry button | **Read:** ref.invalidate(dashboardSummaryProvider). **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, enrollment, training_assignment, certificate, training_record, material_progress, training_waiver, department (via compliance/analytics), audit_trail, dashboard, sla_breach, analytics tables | None |

---

## 4. My Training (`/employee/my-training`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/my-training` |
| **Widget** | MyTrainingScreen (`my_learning/my_training_screen.dart`) |
| **Navigation from** | Sidebar “My Learning”; dashboard “Continue learning” / “View Overdue” |
| **Navigation to** | `/employee/credentials` (completed), `/employee/course/:id` (resume/start) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Pull-to-refresh** | RefreshIndicator | **Read:** invalidate enrollmentsProvider, assignmentsProvider, enrollmentResumeLabelsProvider, userComplianceProvider → getEnrollmentsForUser, getAssignmentsForUser, getEnrollmentResumePosition, getUserCompliance |
| **SOP retraining alert** | Card if enrollments have retrainingChangeSummary and no acknowledgedAt | **Read:** enrollment (retrainingChangeSummary, acknowledgedAt). **Write:** none |
| **Compliance banner** | If overdueCount > 0 | **Read:** userComplianceProvider → certificate, enrollment, training_assignment, training_waiver. **Write:** none |
| **Header** | “My Training”, “X courses assigned” | **Read:** enrollments.length. **Write:** none |
| **Filter row** | Status (All/Overdue/In progress/Not started/Completed), Sort (Due date/Name), Search | **Read:** local filter on enrollments (no extra API). **Write:** none |
| **Course list** | _TrainingCard per enrollment: title, status pill, due date, progress bar, Resume/Start/View certificate | **Read:** enrollmentsProvider → enrollment; assignmentsProvider → training_assignment (dueDate); enrollmentResumeLabelsProvider → getEnrollmentResumePosition → material_progress, lesson, module; userComplianceProvider; client.training.getEnrollmentProgress(enrollmentId) per in-progress card → material_progress. **Write:** none. **Nav:** tap → /employee/credentials or /employee/course/… with extra |
| **Empty state** | “No Matching Courses” / “Clear Filters” | **Read:** none. **Write:** none (local filter clear) |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, enrollment, training_assignment, certificate, training_record, material_progress, training_waiver, course_version, course, lesson, module | None |

---

## 5. Course catalog (`/employee/catalog`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/catalog` |
| **Widget** | CourseCatalogScreenRedesigned (`course_catalog/course_catalog_screen_redesigned.dart`) |
| **Navigation from** | Sidebar “Course Catalogue”; dashboard |
| **Navigation to** | `/employee/course/:id` (View/Continue) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header** | “Course Catalog”, subtitle | — |
| **Filter bar** | Search (title, description, SOP), Category (status), Sort (title/status) | **Read:** local filter/sort on courses. **Write:** none |
| **Count** | “X courses available” | **Read:** filtered list length. **Write:** none |
| **Course grid** | _CourseCard per course: image, title, SOP#, description, “Continue” (if enrolled) or “Enroll” | **Read:** coursesProvider → client.course.listCourses() → course; enrollmentsProvider → enrollment (for _enrolledCourseIds). **Write:** none for View. **Enroll:** client.course.getCourseVersions(courseId) → course_version; then client.training.selfEnroll(userId, courseVersionId) → **Write:** training_assignment (insert), enrollment (insert), audit_trail (SelfEnrolled). Then ref.invalidate(enrollmentsProvider) |
| **Enroll dialog** | Confirm “Enroll in {title}?” Cancel / Enroll | **Read:** currentUserProvider (user.id). **Write:** (on Enroll) as above |
| **Empty state** | “No Courses Found”, “Clear Filters” | **Read:** none. **Write:** none |
| **Error** | Retry | **Read:** invalidate coursesProvider, enrollmentsProvider. **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| course, course_version, enrollment (for isEnrolled) | training_assignment, enrollment, audit_trail (on Enroll) |

---

## 6. Course viewer (`/employee/course/:courseId`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/course/:courseId` (extra: courseVersionId, enrollmentId, userId, courseTitle, enrollmentStatus) |
| **Widget** | CourseViewerScreenV2 (`course_viewer/course_viewer_screen_v2.dart`) |
| **Navigation from** | Dashboard “Continue”, My Training card, Catalog “Continue”, Lessons “Resume” |
| **Navigation to** | `/employee/assessment/:courseId` (Take assessment) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Load (init)** | _load() | **Read:** client.training.getEnrollmentById(enrollmentId) → enrollment; client.course.getCourseVersion(versionId) → course_version; client.course.getModulesForCourseVersion(versionId) → module; client.course.getLessonsForModule(moduleId) → lesson; client.material.getLessonWithMaterial(lessonId) → lesson, material; client.material.getProgress(...) → material_progress; client.training.listSignatureMeanings() → signature_meaning |
| **Outline / sidebar** | List of modules and lessons | **Read:** _modules, _lessons (from above). **Write:** none |
| **Content area** | Current lesson: title, material (PDF/video/SCORM/WebView) | **Read:** _currentLessonWithMaterial (getLessonWithMaterial). **Write:** none |
| **Progress / engagement** | Heartbeat or “Mark complete” / next | **Read:** — **Write:** client.material.recordEngagement(...) or client.material.updateProgress(...) → material_progress (insert/update), enrollment (update) |
| **Next / Previous** | Change current lesson | **Read:** getLessonWithMaterial for new lesson. **Write:** (optional) updateProgress when leaving lesson |
| **Take assessment** | Button when assessment linked | **Read:** — **Write:** none. **Nav:** context.push('/employee/assessment/…', extra: courseVersionId, enrollmentId) |
| **getMaterialViewUrl** | If material is file/video URL | **Read:** material. **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| enrollment, course_version, course, module, lesson, material, material_version, material_progress, signature_meaning | material_progress, enrollment |

---

## 7. Assessments list (`/employee/assessments`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/assessments` |
| **Widget** | AssessmentListScreen (`assessment/assessment_list_screen.dart`) |
| **Navigation from** | Sidebar “Assessments”; dashboard |
| **Navigation to** | `/employee/training-history`, `/employee/assessment/:courseId` (Start/Retake) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header row** | “Assessments”, “Training History” link | **Read:** — **Nav:** Training History → /employee/training-history |
| **Retry / refresh** | On error or refresh | **Read:** ref.invalidate(userAssessmentsProvider) → getAssessmentForCourse + getAttemptCount per enrollment |
| **Assessment cards** | Per enrollment with assessment: course image, title, progress, status badge, “Start” / “Retake” / “View certificate” | **Read:** userAssessmentsProvider → enrollmentsProvider → enrollment; for each: getAssessmentForCourse(courseVersionId) → assessment; getAttemptCount(...) → assessment_attempt. **Write:** none. **Nav:** tap → /employee/assessment/… with extra |
| **Stats row** | Total assessments, Completed, Average score | **Read:** derived from userAssessmentsProvider (same data). **Write:** none |
| **Empty state** | No assessments | **Read:** — **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, enrollment, assessment, assessment_attempt, question_bank, question (metadata) | None |

---

## 8. Assessment take (`/employee/assessment/:courseId`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/assessment/:courseId` (extra: courseVersionId, enrollmentId) |
| **Widget** | AssessmentScreenV2 (`assessment/assessment_v2.dart`) |
| **Navigation from** | Course viewer “Take assessment”; Assessments list “Start”/“Retake”; My Training (for completed view) |
| **Navigation to** | `/employee/credentials`, `/employee` (back), same route (Retake) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Load** | getAssessmentForCourse, getQuestions, getAttemptCount, getEnrollmentById | **Read:** assessment, question_bank, question, assessment_attempt, enrollment. **Write:** none |
| **Start screen** | Instructions, “Start” button | **Read:** — **Write:** client.assessment.startAttempt(enrollmentId, assessmentId) → assessment_attempt (insert) |
| **Question area** | Question text, options (tap to select) | **Read:** questions from load. **Write:** (on submit or per answer) client.assessment.recordAnswer(attemptId, questionId, selectedOptionId) → assessment_result (insert) |
| **Prev / Next** | Navigate questions | **Read:** — **Write:** none (local state) |
| **Submit** | Submit attempt | **Read:** — **Write:** client.assessment.submitAttempt(attemptId) → assessment_attempt (update) |
| **E-signature dialog** | After pass: meaning, password (if required), “Sign Now” | **Read:** — **Write:** client.training.createTrainingSignature(...) → electronic_signature (insert) |
| **Complete** | After sign: “Continue” | **Read:** — **Write:** client.training.completeTraining(enrollmentId, userId, courseVersionId, esignatureId, score) → training_record (insert), certificate (insert), enrollment (update), audit_trail |
| **Result screen** | Pass/fail, score, “View Certificates”, “Retake” | **Read:** — **Write:** Retake → startAttempt again (assessment_attempt insert). **Nav:** View Certificates → /employee/credentials |
| **Exit / Back** | Close or confirm exit | **Read:** — **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| enrollment, assessment, question_bank, question, assessment_attempt, assessment_result, training_record | assessment_attempt, assessment_result, training_record, certificate, enrollment, electronic_signature, audit_trail |

---

## 9. Training history (`/employee/training-history`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/training-history` |
| **Widget** | TrainingHistoryV2 (`training_history/training_history_v2.dart`) |
| **Navigation from** | Sidebar “Training History”; Assessments list “Training History” link |
| **Navigation to** | Sidebar to other employee routes |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header** | “Training History”, “Download PDF” button | **Read:** — **Write:** (on Download) see below |
| **Tabs** | All Records / Completed / In Progress / Not Started | **Read:** local filter on enrollments/records. **Write:** none |
| **Table / list** | Rows: course image, name, date, status badge, action (expand/details) | **Read:** trainingRecordsProvider → training_record; enrollmentsProvider → enrollment; certificatesProvider → certificate; getEnrollmentProgress(enrollmentId) for in-progress → material_progress. **Write:** none |
| **Download PDF** | Build PDF from records + enrollments + certs, hash, then logReportExport, save file | **Read:** currentUserProvider (pharma_user), trainingRecordsProvider, enrollmentsProvider, certificatesProvider (already loaded). **Write:** client.audit.logReportExport(reportType: 'employee_training_history', hashSha256) → report_export (insert), audit_trail (ReportExported) |
| **Pull-to-refresh** | RefreshIndicator | **Read:** invalidate trainingRecordsProvider, enrollmentsProvider, certificatesProvider |
| **Nav buttons** | Links to Dashboard, Catalog, etc. | **Read:** — **Write:** none |
| **ALCOA+ footer** | Compliance text | — |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, training_record, enrollment, certificate, material_progress, course_version, course | report_export, audit_trail (on Download PDF) |

---

## 10. Credentials (`/employee/credentials`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/credentials` |
| **Widget** | CertificationScreenV2 (`credentials/certification_screen_v2.dart`) |
| **Navigation from** | Sidebar “Certifications”; Dashboard “View Details”; Assessment result “View Certificates”; My Training (completed) |
| **Navigation to** | Sidebar; certificate download (if implemented) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header** | “Certifications”, subtitle | — |
| **Stats row** | Earned, Expiring soon, Total (from certs + enrollments) | **Read:** certificatesProvider → certificate; enrollmentsProvider → enrollment. **Write:** none |
| **Cert list** | Cards: icon, course title, date, status, progress, Download | **Read:** certificatesProvider (certificate, course_version, course, training_record); enrollmentsProvider. **Write:** none (download may read certificate/file store only) |
| **Pull-to-refresh** | RefreshIndicator | **Read:** invalidate certificatesProvider, enrollmentsProvider |
| **ALCOA+ footer** | Compliance text | — |

### Data tables

| Read | Write |
|------|--------|
| certificate, enrollment, course_version, course, training_record | None |

---

## 11. Profile (`/employee/profile`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/profile` |
| **Widget** | ProfileSettingsScreen (`profile/profile_settings_screen.dart`) |
| **Navigation from** | Sidebar “Profile & Settings” |
| **Navigation to** | `/` (Sign Out) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header** | “Profile & Settings”, subtitle | — |
| **Profile header card** | Avatar, name, email, cert count | **Read:** currentUserProvider → getUserByEmail → pharma_user; certificatesProvider → certificate. **Write:** none |
| **Personal information** | Full name, email, employee ID, department, job role | **Read:** user (pharma_user, department, jobRole). **Write:** none (HR managed) |
| **Compliance information** | Cert count, compliance info | **Read:** certificates (certificate). **Write:** none |
| **Sign Out** | Button / list tile | **Read:** — **Write:** logout → client.auth.signOutDevice() (session) |
| **Sign Out other devices** | (if present) | **Read:** — **Write:** auth (session) |

### Data tables

| Read | Write |
|------|--------|
| pharma_user, certificate, department, role (for jobRole) | None (session only on sign out) |

---

## 12. MFA enrollment (`/employee/mfa`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/mfa` |
| **Widget** | MfaEnrollmentScreen (`auth/mfa_enrollment_screen.dart`) |
| **Navigation from** | Sidebar or profile (if MFA entry point in nav) |
| **Navigation to** | Back to profile or previous |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Status** | Show current MFA status (enabled/disabled) | **Read:** client.mfa.getMfaStatus() → user_mfa. **Write:** none |
| **Enroll** | Setup TOTP, “Enroll” | **Read:** — **Write:** client.mfa.enrollMfa() → user_mfa (insert/update) |
| **Verify enrollment** | Code input, “Verify” | **Read:** user_mfa. **Write:** client.mfa.verifyMfaEnrollment(code) → mfa_verified_session (insert), user_mfa (update) |
| **Disable** | “Disable MFA” | **Read:** — **Write:** client.mfa.disableMfa() → user_mfa (update) |
| **Verify (login)** | (On login screen) code → verifyMfa | **Read:** user_mfa. **Write:** client.mfa.verifyMfa(code) → mfa_verified_session (insert) |

### Data tables

| Read | Write |
|------|--------|
| user_mfa, mfa_verified_session | user_mfa, mfa_verified_session |

---

## 13. Waiver (`/employee/waiver/:id`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/waiver/:id` |
| **Widget** | TrainingWaiverScreen (`waiver/training_waiver_screen.dart`) |
| **Navigation from** | Link from notification or other screen (waiver ID in URL) |
| **Navigation to** | Back or sidebar |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Content** | Waiver details: status, reason, course, dates, approver | **Read:** client.training.getWaiverById(waiverId) → training_waiver. **Write:** none (view only) |

### Data tables

| Read | Write |
|------|--------|
| training_waiver | None |

---

## 14. Lessons (`/employee/lessons`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/lessons` |
| **Widget** | LessonsScreen (`my_learning/lessons_screen.dart`) |
| **Navigation from** | Sidebar “My Learning”; Dashboard “View Overdue” / “Start Retraining” |
| **Navigation to** | `/employee/course/:id` (Resume/Start) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **Header** | “My Lessons”, subtitle | — |
| **Lessons list** | Cards: course name, resume label, duration, progress, “Resume” / “Start” | **Read:** enrollmentsProvider → getEnrollmentsForUser → enrollment; enrollmentResumeLabelsProvider → getEnrollmentResumePosition per in-progress → material_progress, lesson, module. **Write:** none. **Nav:** tap → context.go('/employee/course/…', extra: courseVersionId, enrollmentId, …) |
| **Pull-to-refresh** | RefreshIndicator | **Read:** invalidate enrollmentsProvider, enrollmentResumeLabelsProvider |
| **Empty** | No lessons | **Read:** — **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| enrollment, material_progress, lesson, module, course_version, course | None |

---

## 15. Downloads (`/employee/downloads`)

| Item | Detail |
|------|--------|
| **Route** | `/employee/downloads` |
| **Widget** | DownloadsScreen (`downloads/downloads_screen.dart`) |
| **Navigation from** | Sidebar “Downloads” |
| **Navigation to** | Sidebar; download file (local save) |

### Layout

| Zone | Description | DB/API (read/write) |
|------|-------------|----------------------|
| **List** | Download items from certificates: name, type (PDF), size, date, Download button | **Read:** certificatesProvider → getCertificatesForUser → certificate (course_version, course, training_record). **Write:** none (download reads cert/data; may use certificate_pdf_service or file_download) |
| **Loading / error** | Spinner or error + message | **Read:** — **Write:** none |

### Data tables

| Read | Write |
|------|--------|
| certificate, course_version, course, training_record | None |

---

## Summary: data tables by screen

| Screen | Tables read | Tables written |
|--------|-------------|----------------|
| Login | pharma_user, user_role, role, user_mfa, mfa_verified_session | (session) |
| Shell | pharma_user, notification, assignment, enrollment, course | notification (readAt), session |
| Dashboard | pharma_user, enrollment, training_assignment, certificate, training_record, material_progress, training_waiver, department, analytics/audit/dashboard/sla_breach | — |
| My Training | pharma_user, enrollment, training_assignment, certificate, training_record, material_progress, training_waiver, course_version, course, lesson, module | — |
| Course catalog | course, course_version, enrollment | training_assignment, enrollment, audit_trail (on Enroll) |
| Course viewer | enrollment, course_version, course, module, lesson, material, material_version, material_progress, signature_meaning | material_progress, enrollment |
| Assessments list | pharma_user, enrollment, assessment, assessment_attempt, question_bank, question | — |
| Assessment take | enrollment, assessment, question_bank, question, assessment_attempt, assessment_result, training_record | assessment_attempt, assessment_result, training_record, certificate, enrollment, electronic_signature, audit_trail |
| Training history | pharma_user, training_record, enrollment, certificate, material_progress, course_version, course | report_export, audit_trail (on Download PDF) |
| Credentials | certificate, enrollment, course_version, course, training_record | — |
| Profile | pharma_user, certificate, department, role | (session on sign out) |
| MFA | user_mfa, mfa_verified_session | user_mfa, mfa_verified_session |
| Waiver | training_waiver | — |
| Lessons | enrollment, material_progress, lesson, module, course_version, course | — |
| Downloads | certificate, course_version, course, training_record | — |

---

*For table-level detail and endpoint mapping see [EMPLOYEE_PORTAL_DATABASE_ACCESS.md](./EMPLOYEE_PORTAL_DATABASE_ACCESS.md). For full system design and data flow see [EMPLOYEE_PORTAL_SYSTEM_DESIGN.md](./EMPLOYEE_PORTAL_SYSTEM_DESIGN.md).*
