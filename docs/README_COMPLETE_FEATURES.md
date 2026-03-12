# Pharma LMS — Complete Implemented Features

Enterprise-grade compliance LMS for pharmaceutical companies. Built for FDA 21 CFR Part 11, GxP, EU Annex 11, and ALCOA+ data integrity.

---

## 1. Authentication & Security

### 1.1 Email/Password Login

- **SignInWidget** — Email + password authentication
- **Password policy** — Min 12 chars, uppercase, lowercase, digit, special character (21 CFR Part 11)
- **Hashing** — Argon2id (OWASP-recommended)
- **Implementation**: `PasswordPolicyService`, `EmailIdpConfigFromPasswords`

### 1.2 Account Lockout

- **FailedLoginLockoutWorker** — Locks account after 5 failed attempts within 5 minutes
- **Schedule** — Self-reschedules every minute
- **Audit** — Logs `UserLocked` to audit trail

### 1.3 Role-Based Access Control (RBAC)

- **RbacHelper** — `requirePermission(session, resource, action)` returns `PharmaUser`
- **Roles**: Admin, QA Director, QA, Employee
- **Permissions**: Granular resource:action (e.g. `training:read`, `course:write`)
- **Admin wildcard**: `*:`* for full access
- **Enforcement**: All endpoints protected

### 1.4 Multi-Factor Authentication (MFA)

- **MfaEndpoint** — enrollMfa, verifyMfaEnrollment, verifyMfa, disableMfa, getMfaStatus, isMfaVerified
- **Tables**: UserMfa, MfaVerifiedSession
- **TOTP** — Uses `otp` package
- **Screens**: MfaEnrollmentScreen, MFA verification dialog on login

### 1.5 SSO via OIDC

- **OidcIdpEndpoint** — Custom OIDC IdP using OAuth2 PKCE
- **Providers**: Auth0, Okta, Azure AD (discovery URL)
- **Config**: passwords.yaml — oidcClientId, oidcClientSecret, oidcDiscoveryUrl, oidcRedirectUri
- **OidcSignInWidget** — "Sign in with SSO" on login screen when configured
- **Web callback**: auth.html for flutter_web_auth_2

### 1.6 JWT Tokens

- **JwtConfigFromPasswords** — Access token 30 min, refresh 7 days
- **JwtRefreshEndpoint** — Token refresh flow

---

## 2. Organization & Identity

### 2.1 Organization Structure

- **Organizations** — Multi-tenant
- **Sites** — Per organization
- **Departments** — Per site
- **Job Roles** — Per department
- **PharmaUser** — Links to auth via authUserId

### 2.2 User Management

- **UserEndpoint** — getUserByEmail
- **OrganizationEndpoint** — listOrganizations, listSites, listDepartments, listUsers, listJobRoles
- **Admin** — lockUserByEmail, unlockUserByEmail

---

## 3. Course & Curriculum

### 3.1 Course Builder

- **CourseBuilderEndpoint** — createModule, createLesson, link materials
- **CourseBuilderScreen** — Drag-drop modules/lessons, material picker
- **Course versions** — Draft → Pending QA → Approved → Effective

### 3.2 Course Catalog & Learning

- **CourseCatalogScreen** — Browse courses
- **MyLearningScreen** — Assignments and enrollments
- **TrainingTimelineScreen** — Timeline view
- **CourseViewerScreen** — Modules, lessons, materials, read-time tracking

### 3.3 Materials

- **Material types**: PDF, Video (mp4, webm), SCORM (zip)
- **MaterialUploadScreen** — Type chips, file picker, direct upload
- **Storage**: materials/{id}/v1.{ext}
- **Viewing**: PDF/SCORM in WebView; Video in native VideoPlayer
- **Progress**: Minimum read time, scroll depth (PDF), video watched % (90% for completion)

---

## 4. Training Assignment & Completion

### 4.1 Assignments

- **TrainingEndpoint** — assignTraining, assignTrainingToDepartment, getAssignmentsForUser, getEnrollmentsForUser
- **Admin** — assignTrainingToDepartment, bulk import
- **Sources**: ad_hoc, role_based, sop_update

### 4.2 Enrollments & Certificates

- **Enrollment** — not_started, in_progress, completed
- **Certificate** — Issued on assessment pass
- **CertificateScreen** — View certificate
- **Training records** — Completion with score, e-signature

### 4.3 Training Waivers

- **AdminEndpoint** — requestTrainingWaiver, approveTrainingWaiver, rejectTrainingWaiver, listTrainingWaivers
- **TrainingWaiversScreen** — Request, approve, reject

### 4.4 Retraining

- **Acknowledge retraining** — When SOP changes, user must acknowledge
- **Retraining gate** — Blocks course until acknowledged

---

## 5. Assessment Engine

### 5.1 Question Banks & Assessments

- **AssessmentBuilderEndpoint** — createQuestion, createAssessment, listQuestionBanks
- **AssessmentEndpoint** — getAssessmentForCourse, getQuestions, startAttempt, recordAnswer, submitAttempt
- **AssessmentBuilderScreen** — Create questions, link to courses
- **AssessmentScreen** — Take quiz, pass/fail, certificate on pass

### 5.2 Attempts & Results

- **AssessmentAttempt** — Per user per assessment
- **AssessmentResult** — Score, passed, timestamp
- **Passing score** — Configurable per assessment

---

## 6. Document Control

### 6.1 Documents

- **DocumentEndpoint** — listDocuments, getDocument, getDocumentVersions, createDocument, updateDocumentQaClassification, transitionDocumentLifecycle
- **DocumentListScreen** — List, filter, create
- **DocumentDetailScreen** — Versions, lifecycle, QA classification

### 6.2 Document Lifecycle

- **States**: draft, pending_approval, approved, effective, obsolete
- **Approval workflow** — DocumentVersion, ApprovalWorkflow

### 6.3 SOP Coverage

- **SopCoverageScreen** — Document-to-course mapping
- **Auditor** — SOP coverage view with watermark

---

## 7. Compliance Engine

### 7.1 Compliance Metrics

- **ComplianceEndpoint** — getUserCompliance
- **ComplianceCalculatorService** — Department compliance, overdue, upcoming
- **ComplianceReportScreen** — Department summary, non-compliant employees, export PDF

### 7.2 SLA Policies & Breaches

- **SlaPolicy** — Threshold, entity type
- **SlaBreach** — Created when below threshold
- **ComplianceMonitorWorker** — Monitors and creates breaches (triggered manually)

---

## 8. Quality Events

### 8.1 Quality Events & CAPA

- **QualityEventEndpoint** — listQualityEvents, createQualityEvent, listCapas, createCapa, updateCapaStatus, closeCapa
- **QualityEventsScreen** — Create events, CAPAs, effectiveness check
- **CapaEffectivenessWorker** — Notifies QA when effectiveness check due

---

## 9. Audit & Validation

### 9.1 Audit Trail

- **AuditEndpoint** — getAuditTrail, getAccessLogs, logReportExport
- **AuditTrailScreen** — Search, filter, export
- **Immutable** — Append-only log

### 9.2 Access Logs

- **User sessions** — Login, IP, timestamps
- **Report export** — Logged for audit

### 9.3 Config Change History

- **ConfigChangeHistoryScreen** — Config change log for auditors

### 9.4 Validation Documents

- **ValidationEndpoint** — generateUrs, generateFs, generateDs, generateIq, generateOq, generatePq, generateTraceabilityMatrix
- **Output**: Markdown templates for GxP validation

---

## 10. Electronic Signatures

### 10.1 E-Signature Flow

- **EsignatureScreen** — Entity type, meaning, password
- **TrainingEndpoint** — createTrainingSignature, listSignatureMeanings, listElectronicSignatures, getSignatureWithIntegrityCheck
- **Signature meanings** — Admin-defined (e.g. "Training Completed")

### 10.2 E-Signature Verification

- **EsignatureVerificationScreen** — Verify signature integrity (auditor)

---

## 11. Inspector/Auditor Portal

### 11.1 Auditor Portal

- **AuditorPortalScreen** — Token-based access (no login)
- **InspectionEndpoint** — validateAuditorToken, logAuditorPageView, searchEmployeesForAudit, generateEvidencePackageForAuditor
- **Watermark** — "AUDIT COPY" on all auditor pages

### 11.2 Auditor Screens

- **EmployeeSearchScreen** — Search employees, view training chain
- **SopCoverageScreen** — Document-to-course mapping
- **ConfigChangeHistoryScreen** — Config changes
- **AuditTrailScreen** — Audit trail
- **ComplianceReportScreen** — Compliance
- **EsignatureVerificationScreen** — E-signature verification

### 11.3 Inspection Management

- **InspectionEndpoint** — Create inspection records, schedule
- **InspectionManagementScreen** — Manage inspections

---

## 12. Analytics & Reporting

### 12.1 Analytics Dashboard

- **AnalyticsEndpoint** — getTrainingCompletionRate, getDepartmentComplianceSummary, getCertificationExpiryRiskCount, getAuditReadinessScore, getOpenSlaBreaches, getComplianceTrend, getSopRetrainingVelocity, getTrainingVsDeviationCorrelation, getComplianceDeviationOverlay, getSlaSummary
- **AnalyticsDashboardScreen** — Charts, KPIs, compliance heatmap

### 12.2 Course Analytics

- **getCourseAnalytics** — Pass rate, score distribution
- **CourseAnalyticsScreen** — Per-course analytics (trainer)

### 12.3 System Health

- **getSystemHealth** — DB connectivity, DLQ count, job logs
- **HealthDashboardScreen** — System health, manual job trigger

### 12.4 Prometheus Metrics

- **MetricsRoute** — `/metrics`
- **Metrics**: pharma_lms_request_count, pharma_lms_request_latency_seconds

---

## 13. Notifications

### 13.1 Email Service

- **EmailService** — sendRegistrationCode, sendPasswordResetCode, sendNotificationEmail
- **SMTP** — Config from passwords.yaml
- **Training reminders** — AssignmentNotificationWorker ladder

### 13.2 In-App Notifications

- **NotificationEndpoint** — getInAppNotifications
- **Types**: reminder_30d, reminder_14d, reminder_7d, reminder_3d, assignment_due, overdue_1d, etc.

---

## 14. Background Workers & Automation

### 14.1 Scheduled Workers (Auto-Run)


| Worker                       | Schedule     | Purpose                                  |
| ---------------------------- | ------------ | ---------------------------------------- |
| **FailedLoginLockoutWorker** | Every 1 min  | Lock after 5 failed logins               |
| **RetentionArchivalWorker**  | Every 24 hrs | Archive audit trail per retention policy |


### 14.2 Event-Driven Automation


| Event                    | Trigger                                          | Purpose                    |
| ------------------------ | ------------------------------------------------ | -------------------------- |
| **SOP Updated**          | EventEndpoint.triggerSopUpdated / Kafka          | Assign retraining          |
| **Employee Created**     | EventEndpoint.triggerEmployeeCreated / Kafka     | Assign role-based training |
| **Employee Transferred** | EventEndpoint.triggerEmployeeTransferred / Kafka | Assign delta training      |


### 14.3 Manual-Trigger Workers


| Worker                           | Purpose                                         |
| -------------------------------- | ----------------------------------------------- |
| **CertificationExpiryWorker**    | Cert expiry ladder (90d, 60d, 30d, 7d, expired) |
| **ComplianceMonitorWorker**      | Create SLA breaches when below threshold        |
| **CapaEffectivenessWorker**      | Notify QA for CAPA effectiveness check          |
| **AssignmentNotificationWorker** | Training reminder ladder (-30d to +14d overdue) |


### 14.4 Event Processing

- **EventService** — Emit to OutboxMessage (transactional outbox)
- **KafkaEventProcessor** — processSopUpdated, processEmployeeCreated, processEmployeeTransferred, processOutbox
- **AnalyticsEventProcessor** — enrollment.completed, assessment.completed, compliance.breach, etc.

---

## 15. Data Retention

### 15.1 Retention Policies

- **RetentionPolicy** — entityType, retentionYears, archiveEnabled
- **RetentionArchive** — Archived records
- **DataRetentionService** — ensurePolicies, archiveAuditTrail
- **Defaults**: audit_trail 7 years, access_log 7 years

---

## 16. Storage

### 16.1 Material Storage

- **Direct upload** — getUploadDescription, FileUploader, verifyUpload
- **View URL** — getMaterialViewUrl (public URL for PDF/video/SCORM)
- **Storage ID**: public

### 16.2 S3/MinIO

- **Config**: config/production.yaml
- **Docs**: docs/STORAGE_S3.md

---

## 17. UI & UX

### 17.1 Global Layout

- **AppLayout** — Top bar, sidebar (260px), main content, optional context panel
- **Sidebar nav**: Dashboard, Learning, Courses, Assessments, Certificates, Training Matrix, SOP Documents, Quality Events, Compliance, Analytics, Audit Trail, Administration

### 17.2 Design System

- **Colors** — Primary #1E4DB7, Success #22C55E, Warning #F59E0B, Danger #EF4444
- **Typography** — lib/design_system/typography.dart
- **Spacing** — lib/design_system/spacing.dart
- **Widgets**: ComplianceGauge, AuditTimeline, SOPViewer

### 17.3 Role Dashboards


| Role      | Dashboard                | Path            |
| --------- | ------------------------ | --------------- |
| Employee  | EmployeeDashboardScreen  | /employee       |
| Admin     | AdminDashboardScreen     | /admin          |
| QA        | QADashboardScreen        | /qa             |
| Trainer   | TrainerDashboardScreen   | /trainer        |
| Auditor   | AuditorPortalScreen      | /auditor?token= |
| Analytics | AnalyticsDashboardScreen | /analytics      |


---

## 18. Screens (Complete List)

### Auth

- LoginScreen
- MfaEnrollmentScreen
- OidcSignInWidget (SSO button)

### Employee

- EmployeeDashboardScreen
- TrainingHistoryScreen
- CourseCatalogScreen
- MyLearningScreen
- TrainingTimelineScreen
- CourseViewerScreen
- AssessmentScreen
- CertificateScreen
- EsignatureScreen

### Admin

- AdminDashboardScreen
- TrainingWaiversScreen
- HealthDashboardScreen
- BulkImportScreen
- TrainingMatrixScreen

### QA

- QADashboardScreen
- QualityEventsScreen
- ComplianceReportScreen
- DocumentListScreen
- DocumentDetailScreen
- InspectionManagementScreen
- EventTriggersScreen

### Trainer

- TrainerDashboardScreen
- CourseBuilderScreen
- MaterialUploadScreen
- AssessmentBuilderScreen
- CourseAnalyticsScreen

### Auditor

- AuditorPortalScreen
- EmployeeSearchScreen
- SopCoverageScreen
- ConfigChangeHistoryScreen
- AuditTrailScreen
- ComplianceReportScreen
- EsignatureVerificationScreen

### Analytics

- AnalyticsDashboardScreen

---

## 19. API Endpoints (Complete List)


| Endpoint          | Purpose                                                                          |
| ----------------- | -------------------------------------------------------------------------------- |
| emailIdp          | Email/password login, registration, password reset                               |
| jwtRefresh        | JWT token refresh                                                                |
| oidcIdp           | OIDC SSO login, getClientConfig, hasAccount                                      |
| admin             | Training assignment, waivers, bulk import, signature meanings, lock/unlock users |
| analytics         | Compliance, KPIs, system health, manual job trigger                              |
| assessment        | Get assessment, questions, start/submit attempt                                  |
| assessmentBuilder | Question banks, create question/assessment                                       |
| audit             | Audit trail, access logs, report export, config change log                       |
| compliance        | User compliance metrics                                                          |
| course            | Courses, versions, modules, lessons, materials                                   |
| courseBuilder     | Create modules, lessons                                                          |
| document          | Documents, versions, lifecycle, QA classification                                |
| event             | Trigger SOP updated, employee created/transferred                                |
| inspection        | Auditor token, employee search, evidence package, page logging                   |
| material          | Create material, upload, view URL, progress, engagement                          |
| mfa               | Enroll, verify, disable MFA                                                      |
| notification      | In-app notifications                                                             |
| organization      | Orgs, sites, departments, users, job roles                                       |
| qa                | Pending course versions, approve/reject                                          |
| qualityEvent      | Quality events, CAPAs                                                            |
| seed              | runSeed, runMvpSeed                                                              |
| training          | Assignments, enrollments, certificates, signatures, annotations                  |
| user              | getUserByEmail                                                                   |
| validation        | URS, FS, DS, IQ, OQ, PQ, traceability matrix                                     |
| greeting          | Hello world                                                                      |


---

## 20. Tech Stack

- **Frontend**: Flutter 3.x, Riverpod, GoRouter, Material 3
- **Backend**: Serverpod (Dart), PostgreSQL, Redis
- **Auth**: Serverpod Auth (JWT, email IdP, custom OIDC)
- **Storage**: S3/MinIO (production), local (development)
- **Event Bus**: Kafka (optional), transactional outbox
- **Metrics**: Prometheus `/metrics`

---

## 21. Compliance Standards

- **21 CFR Part 11** — Electronic records, electronic signatures
- **EU GMP Annex 11** — Computerised systems
- **ALCOA+** — Data integrity
- **GxP** — Good practice guidelines

