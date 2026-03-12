# Pharma LMS Enterprise Implementation Roadmap

Enterprise-grade compliance LMS for pharmaceutical companies. Built for FDA 21 CFR Part 11, GxP, EU Annex 11, and ALCOA+ data integrity.

---

## Phase 1: Authentication & Security

### 1.1 Password Policy ✓
- **Status**: Complete
- **Implementation**: `PasswordPolicyService` in `pharma_lms_server/lib/src/services/password_policy_service.dart`
- **Requirements**: Min 12 chars, uppercase, lowercase, digit, special character (21 CFR Part 11)
- **Hashing**: Serverpod uses Argon2id (OWASP-recommended)

### 1.2 Account Lockout ✓
- **Status**: Complete
- **Implementation**: `FailedLoginLockoutWorker` in `pharma_lms_server/lib/src/workers/failed_login_lockout_worker.dart`
- **Behavior**: Locks account after 5 failed attempts within 5 minutes
- **Schedule**: Self-reschedules every minute

### 1.3 RBAC Enforcement ✓
- **Status**: Complete
- **Implementation**: `RbacHelper` in `pharma_lms_server/lib/src/services/rbac_helper.dart`
- **API**: `requirePermission(session, resource, action)` returns `PharmaUser`
- **Roles**: Admin, QA Director, QA, Employee with granular permissions
- **Wildcard**: Admin has `*:*` for full access

### 1.4 MFA (TOTP) ✓
- **Status**: Complete
- **Implementation**: `MfaEndpoint`, `UserMfa`, `MfaVerifiedSession` tables
- **Flow**: Enroll → Verify → Disable; MFA verification after login
- **Client**: `mfa_enrollment_screen.dart`, MFA dialog on login

### 1.5 SSO via OIDC ✓
- **Status**: Complete
- **Implementation**: Custom OIDC IdP using OAuth2 PKCE utilities
- **Providers**: Auth0, Okta, Azure AD (OIDC discovery URL)
- **Config**: `passwords.yaml` — oidcClientId, oidcClientSecret, oidcDiscoveryUrl, oidcRedirectUri
- **Docs**: `docs/SSO_OIDC.md`, `docs/SSO_OIDC_INTEGRATION.md`

---

## Phase 2: Notifications & Validation

### 2.1 Email Service ✓
- **Status**: Complete
- **Implementation**: `EmailService` in `pharma_lms_server/lib/src/services/email_service.dart`
- **Uses**: `mailer` package, SMTP from `passwords.yaml`
- **Functions**: Registration code, password reset, training reminders
- **Docs**: `docs/EMAIL_SERVICE.md`

### 2.2 Validation Documents ✓
- **Status**: Complete
- **Implementation**: `ValidationEndpoint` — URS, FS, DS, IQ, OQ, PQ, Traceability Matrix
- **Output**: Markdown templates with placeholders

---

## Phase 3: Storage & Content

### 3.1 S3/MinIO Storage ✓
- **Status**: Complete
- **Config**: `config/production.yaml`
- **Docs**: `docs/STORAGE_S3.md`

### 3.2 SCORM Runtime ✓
- **Status**: Complete
- **Implementation**: WebView loads SCORM packages; completion via read-time
- **Storage**: `materials/{id}/scorm/index.html`
- **Upload**: `zip` allowed in material upload

---

## Phase 4: Data & Monitoring

### 4.1 Data Retention ✓
- **Status**: Complete
- **Implementation**: `RetentionPolicy`, `RetentionArchive`, `DataRetentionService`, `RetentionArchivalWorker`
- **Defaults**: audit_trail 7 years, access_log 7 years

### 4.2 Prometheus Metrics ✓
- **Status**: Complete
- **Implementation**: `MetricsRoute` at `/metrics`
- **Metrics**: `pharma_lms_request_count`, `pharma_lms_request_latency_seconds`

---

## Phase 5: UI & UX

### 5.1 Global Layout ✓
- **Status**: Complete
- **Implementation**: `AppLayout` in `lib/layout/app_layout.dart`
- **Components**: Top bar, sidebar (260px), main content, context panel
- **Nav**: Dashboard, Learning, Courses, Assessments, Certificates, Training Matrix, SOP Documents, Quality Events, Compliance, Analytics, Audit Trail, Administration

### 5.2 Material Upload ✓
- **Status**: Complete
- **Design**: Odoo-style — type chips (PDF, Video, SCORM), drop zone, preview thumbnails

### 5.3 PDF & Video Viewer ✓
- **Status**: Complete
- **Implementation**: Native `VideoPlayer` for video; WebView for PDF/SCORM
- **Dependencies**: `video_player`, `webview_flutter`

### 5.4 Design System ✓
- **Status**: Complete
- **Location**: `lib/design_system/` — colors, typography, spacing
- **Widgets**: `ComplianceGauge`, `AuditTimeline`, `SOPViewer`
- **Colors**: Primary #1E4DB7, Success #22C55E, Warning #F59E0B, Danger #EF4444

### 5.5 Additional Screens ✓
- **Status**: Complete
- **Screens**: CourseCatalogScreen, MyLearningScreen, TrainingTimelineScreen
- **Routes**: `/courses`, `/learning`, `/training-timeline`

---

## Post-Implementation Checklist

- [ ] Run migrations for new tables (oidc_account, user_mfa, mfa_verified_session, retention_policy, retention_archive)
- [ ] Configure SMTP in `passwords.yaml` for email delivery
- [ ] Configure S3 in `config/production.yaml` for production storage
- [ ] Configure OIDC in `passwords.yaml` for SSO (Auth0/Okta/Azure AD)
- [ ] Optionally expand ShellRoute to wrap all authenticated routes

---

## Tech Stack

- **Frontend**: Flutter 3.x, Riverpod, GoRouter, Material 3
- **Backend**: Serverpod (Dart), PostgreSQL, Redis
- **Event Bus**: Kafka (optional)
- **Storage**: S3/MinIO for documents

---

## Domains

1. **Organization & Identity** — Multi-tenant, sites, departments, users
2. **Course & Curriculum** — Versioned courses, modules, lessons
3. **Training Assignment** — Assignments, enrollments, certificates
4. **Assessment Engine** — Question banks, assessments, attempts
5. **Document Control** — Documents, versions, lifecycle
6. **Compliance Engine** — Department compliance, SLA policies
7. **Quality Event** — CAPA, change control, inspections
8. **Audit & Validation** — Immutable audit trail, access logs
