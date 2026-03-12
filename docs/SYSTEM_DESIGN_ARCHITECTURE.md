# Pharma LMS — System Design & Architecture

Enterprise-grade compliance LMS for pharmaceutical companies. This document covers system design, backend architecture, and UI/UX architecture.

---

## 1. System Design

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CLIENT LAYER                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐ │
│  │  Flutter Web App (pharma_lms_flutter)                                        │ │
│  │  • Material 3 • Riverpod • GoRouter • pharma_lms_client                       │ │
│  └─────────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        │ HTTPS / WebSocket
                                        ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              SERVER LAYER                                         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐              │
│  │  Web Server      │  │  API Server      │  │  Insights Server  │              │
│  │  (port 8080)     │  │  (port 8081)     │  │  (port 8082)      │              │
│  │  Static, /metrics│  │  RPC endpoints   │  │  Analytics        │              │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘              │
└─────────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              DATA & MESSAGING LAYER                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │  PostgreSQL  │  │  Redis       │  │  Kafka       │  │  S3 / MinIO   │         │
│  │  Primary DB  │  │  Cache/Session│  │  Events      │  │  File Storage│         │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘         │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Client** | Flutter 3.x | Cross-platform web app |
| **State** | Riverpod | State management |
| **Routing** | GoRouter | Declarative routing with role-based access |
| **API Client** | pharma_lms_client | Generated Serverpod client |
| **Backend** | Serverpod (Dart) | API server, web server, workers |
| **Database** | PostgreSQL | Primary data store |
| **Cache** | Redis | Session, caching |
| **Messaging** | Kafka | Event streaming, analytics |
| **Storage** | S3 / MinIO | Materials, documents, exports |
| **Auth** | JWT + OIDC | Access/refresh tokens, SSO |

### 1.3 Data Flow

1. **Client → Server**: Flutter app uses `pharma_lms_client` to call Serverpod endpoints over HTTPS. JWT access token sent in `Authorization` header.
2. **Authentication**: Login (email/password or OIDC) → JWT issued → Client stores tokens → Refresh before expiry.
3. **Authorization**: Each endpoint calls `RbacHelper.requirePermission(session, resource, action)` → returns `PharmaUser` or throws.
4. **File Upload**: Materials/documents uploaded via endpoint → stored in S3/MinIO → metadata in PostgreSQL.
5. **Events**: Domain events (e.g. training completed) → Kafka producer → Kafka topic → Workers process (analytics, notifications).
6. **Audit**: All mutations logged to `audit_trail` table; auditor sessions tracked for read-only access.

### 1.4 Deployment

| Component | Port | Config |
|-----------|------|--------|
| Web Server | 8080 | `config/development.yaml` |
| API Server | 8081 | `config/development.yaml` |
| Insights Server | 8082 | `config/development.yaml` |

- **Passwords**: `config/passwords.yaml` — DB credentials, JWT secrets, OIDC, email, S3, Kafka.
- **Production**: Use environment variables or secrets manager; run behind reverse proxy (nginx) with TLS.

---

## 2. Backend Architecture

### 2.1 Serverpod Project Structure

```
pharma_lms_server/lib/
├── server.dart                 # Entry point, auth init, workers, routes
├── src/
│   ├── auth/                  # OIDC IdP config, custom email IdP
│   │   ├── oidc_idp_config.dart
│   │   ├── oidc_idp_endpoint.dart
│   │   └── email_idp_endpoint.dart
│   ├── endpoints/             # RPC endpoints (one per domain)
│   │   ├── admin_endpoint.dart
│   │   ├── analytics_endpoint.dart
│   │   ├── assessment_endpoint.dart
│   │   ├── assessment_builder_endpoint.dart
│   │   ├── audit_endpoint.dart
│   │   ├── course_endpoint.dart
│   │   ├── course_builder_endpoint.dart
│   │   ├── document_endpoint.dart
│   │   ├── event_endpoint.dart
│   │   ├── inspection_endpoint.dart
│   │   ├── material_endpoint.dart
│   │   ├── mfa_endpoint.dart
│   │   ├── notification_endpoint.dart
│   │   ├── organization_endpoint.dart
│   │   ├── qa_endpoint.dart
│   │   ├── quality_event_endpoint.dart
│   │   ├── seed_endpoint.dart
│   │   ├── training_endpoint.dart
│   │   ├── user_endpoint.dart
│   │   └── validation_endpoint.dart
│   ├── services/              # Business logic
│   │   ├── audit_service.dart
│   │   ├── compliance_calculator_service.dart
│   │   ├── data_retention_service.dart
│   │   ├── email_service.dart
│   │   ├── esignature_service.dart
│   │   ├── event_service.dart
│   │   ├── password_policy_service.dart
│   │   ├── rbac_helper.dart
│   │   └── training_assignment_service.dart
│   ├── workers/               # Background jobs
│   │   ├── analytics_event_processor.dart
│   │   ├── capa_effectiveness_worker.dart
│   │   ├── certification_expiry_worker.dart
│   │   ├── compliance_monitor_worker.dart
│   │   ├── failed_login_lockout_worker.dart
│   │   ├── kafka_event_processor.dart
│   │   └── retention_archival_worker.dart
│   ├── integrations/         # External systems
│   │   └── kafka_producer.dart
│   ├── web/                   # Web routes
│   │   ├── routes/
│   │   │   ├── api_proxy_route.dart
│   │   │   ├── app_config_route.dart
│   │   │   ├── metrics_route.dart
│   │   │   └── root.dart
│   │   └── static/
│   └── generated/             # Protocol, endpoints, models (auto-generated)
│       ├── protocol.dart
│       ├── endpoints.dart
│       ├── future_calls.dart
│       └── [domain]/          # e.g. course/, training/, audit/
```

### 2.2 Endpoint Summary

| Endpoint | Purpose | Key Methods |
|----------|---------|-------------|
| **admin** | Admin panel, waivers, bulk import, health | assignTrainingToDepartment, requestTrainingWaiver, bulkImportUsers |
| **analytics** | Dashboards, reports, SLA | getDashboard, getComplianceMetrics, getSlaBreaches |
| **assessment** | Take assessments | submitAssessment, getAssessmentForEnrollment |
| **assessment_builder** | Create assessments | createAssessment, addQuestion |
| **audit** | Audit trail, auditor sessions | getAuditTrail, createAuditorSession |
| **course** | Course catalog, enrollments | listCourses, enroll, getEnrollment |
| **course_builder** | Course authoring | createModule, createLesson, linkMaterial |
| **document** | SOP documents | listDocuments, getDocument |
| **event** | Domain events | publishEvent |
| **inspection** | Inspections | listInspections |
| **material** | Materials (PDF, video, SCORM) | uploadMaterial, getMaterial |
| **mfa** | MFA enrollment/verification | enrollMfa, verifyMfa |
| **notification** | In-app notifications | listNotifications |
| **organization** | Org structure | listOrganizations, listSites, listDepartments |
| **qa** | QA dashboard, quality events | getQaDashboard, listQualityEvents |
| **quality_event** | Quality events CRUD | createQualityEvent |
| **seed** | Seed data | seedAll |
| **training** | Assignments, enrollments | assignTraining, getAssignmentsForUser |
| **user** | User lookup | getUserByEmail |
| **validation** | URS, FS, DS, IQ, OQ, PQ | generateValidationDocument |

### 2.3 Services

| Service | Responsibility |
|---------|----------------|
| **AuditService** | Write audit trail entries, access logs |
| **ComplianceCalculatorService** | Compute compliance %, due dates |
| **DataRetentionService** | Retention policy, archival |
| **EmailService** | Registration, password reset, reminders |
| **EsignatureService** | E-signature capture, verification |
| **EventService** | Publish domain events to Kafka |
| **PasswordPolicyService** | Password validation (21 CFR Part 11) |
| **RbacHelper** | `requirePermission` — RBAC enforcement |
| **TrainingAssignmentService** | Assignment logic, due dates |

### 2.4 Protocol & Models

- **Protocol**: Defined in `lib/src/protocol/` (YAML) → generated to `generated/protocol.dart`.
- **Models**: Domain entities (Course, User, TrainingRecord, Certificate, etc.) in `generated/[domain]/`.
- **Future calls**: `FutureCalls` for workers (e.g. `failedLoginLockoutWorker.run()`).

### 2.5 Workers

| Worker | Schedule | Purpose |
|--------|----------|---------|
| **FailedLoginLockoutWorker** | Every minute | Lock accounts after 5 failed attempts |
| **RetentionArchivalWorker** | Daily | Archive audit_trail per retention policy |
| **CertificationExpiryWorker** | Daily | Flag expiring certifications |
| **ComplianceMonitorWorker** | Periodic | Check compliance thresholds |
| **CapaEffectivenessWorker** | Periodic | CAPA effectiveness metrics |
| **KafkaEventProcessor** | On message | Process Kafka events (analytics, notifications) |
| **AnalyticsEventProcessor** | On message | Process analytics events |

### 2.6 Authentication Flow

```
┌─────────────┐     ┌─────────────────┐     ┌──────────────────┐
│   Client    │────▶│  EmailIdp /     │────▶│  JwtConfig       │
│  (Login)    │     │  OidcIdp        │     │  Access + Refresh │
└─────────────┘     └─────────────────┘     └──────────────────┘
       │                      │                        │
       │                      ▼                        ▼
       │             ┌─────────────────┐     ┌──────────────────┐
       └────────────▶│  PharmaUser     │     │  Authorization   │
                     │  (RbacHelper)   │     │  Header: Bearer   │
                     └─────────────────┘     └──────────────────┘
```

---

## 3. UI/UX Architecture

### 3.1 Flutter Project Structure

```
pharma_lms_flutter/lib/
├── main.dart                 # App entry, providers, router
├── core/                     # Shared utilities
│   ├── theme/                # AppTheme, AppColors, AppTypography
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   ├── file_io.dart          # Platform file I/O (stub/io)
│   └── ...
├── design_system/            # Design tokens
│   ├── colors.dart           # DesignColors (primary, success, warning, neutrals)
│   └── spacing.dart          # DesignSpacing (xs–xxl, sidebarWidth, contextPanelWidth)
├── features/                 # Feature modules (one per screen/domain)
│   ├── admin_panel/
│   ├── analytics/
│   ├── assessment/
│   ├── assessment_builder/
│   ├── audit/
│   ├── auditor_portal/
│   ├── auth/
│   ├── certificate/
│   ├── compliance/
│   ├── course_builder/
│   ├── course_catalog/
│   ├── course_viewer/
│   ├── documents/
│   ├── employee_dashboard/
│   ├── esignature/
│   ├── event_triggers/
│   ├── inspection/
│   ├── material_upload/
│   ├── my_learning/
│   ├── qa_compliance/
│   ├── quality_events/
│   ├── trainer_dashboard/
│   ├── training_matrix/
│   └── training_timeline/
├── layout/
│   └── app_layout.dart       # TopBar, Sidebar, main content, context panel
├── providers/                # Riverpod providers
│   ├── auth_provider.dart
│   ├── analytics_providers.dart
│   ├── auditor_session_provider.dart
│   ├── dashboard_providers.dart
│   └── ...
├── routes/
│   └── app_router.dart       # GoRouter, role-based redirect
└── widgets/                  # Reusable components
    ├── auditor_watermark_wrapper.dart
    ├── course_card.dart
    └── ...
```

### 3.2 Feature Screens by Role

| Role | Primary Screens |
|------|-----------------|
| **Employee** | EmployeeDashboard, MyLearning, CourseCatalog, TrainingTimeline, CourseViewer, Assessment, Certificate |
| **Admin** | AdminDashboard, TrainingMatrix, TrainingWaivers, HealthDashboard, BulkImport, SopCoverage |
| **Trainer** | TrainerDashboard, CourseBuilder, MaterialUpload, AssessmentBuilder, CourseAnalytics |
| **QA** | QADashboard, QualityEvents, EventTriggers, InspectionManagement, Documents, ComplianceReport |
| **Auditor** | AuditorPortal, EmployeeSearch, SopCoverage, ConfigChangeHistory, AuditTrail, EsignatureVerification |
| **Analytics** | AnalyticsDashboard |

### 3.3 Routing Architecture

- **GoRouter** with `ShellRoute` wrapping `AppLayout` for all authenticated routes.
- **Role-based redirect**: `_pathAllowedForRole(path, role)` — paths not allowed redirect to role home.
- **Role homes**: `pathForRole(role)` → `/employee`, `/admin`, `/qa`, `/trainer`, `/auditor`, `/analytics`.
- **Auditor token**: Query param `?token=` for read-only auditor access (no login).
- **Nested routes**: e.g. `/employee/training-history`, `/admin/training-waivers`, `/trainer/course-builder`.

### 3.4 Layout Components

| Component | Description |
|-----------|-------------|
| **AppLayout** | Scaffold with TopBar + Sidebar + main content + optional context panel |
| **_TopBar** | Logo, search, notifications, profile (56px height) |
| **_Sidebar** | Fixed 260px, nav items (Dashboard, Learning, Courses, etc.) |
| **Context panel** | Optional 320px right panel for detail views |

### 3.5 Design System

| Token | Values |
|-------|--------|
| **Colors** | primary (#1E4DB7), success, warning, danger, neutral50–900 |
| **Spacing** | xs(4), sm(8), md(16), lg(24), xl(32), xxl(48) |
| **Layout** | sidebarWidth: 260, contextPanelWidth: 320 |
| **Theme** | Material 3, AppColors (indigo/slate), AppTypography |

### 3.6 Providers

| Provider | Purpose |
|----------|---------|
| **auth_provider** | selectedRoleProvider, login state |
| **analytics_providers** | Dashboard data, metrics |
| **auditor_session_provider** | Auditor token, session |
| **dashboard_providers** | User-specific dashboard data |

### 3.7 Key Widgets

- **AuditorWatermarkWrapper** — Wraps auditor screens with watermark + page URL/title.
- **CourseCard** — Course list item with progress, status.
- **ComplianceGauge**, **AuditTimeline**, **SOPViewer** — Design system components (see README_COMPLETE_FEATURES).

### 3.8 UI Patterns

- **Material upload**: Odoo-style — type selector chips, drag-drop, preview.
- **Course viewer**: Coursera/Udemy style — native PDF, VideoPlayer (no WebView for media).
- **Auditor portal**: Token-based access, watermark on all pages, read-only.

---

## 4. Cross-Cutting Concerns

### 4.1 Compliance (21 CFR Part 11, GxP, ALCOA+)

- **Audit trail**: All mutations logged with user, timestamp, before/after.
- **E-signatures**: Electronic signatures with meaning, verification.
- **Password policy**: Min 12 chars, complexity, lockout.
- **Data integrity**: Immutable audit logs, retention archival.

### 4.2 Observability

- **Prometheus**: `/metrics` endpoint — request_count, request_latency_seconds.
- **Error logs**: Stored in database, queryable via audit endpoint.
- **Kafka**: Event streaming for analytics and async processing.

### 4.3 Security

- **JWT**: Short-lived access, refresh tokens.
- **RBAC**: Permission-based access on every endpoint.
- **MFA**: TOTP optional per user.
- **OIDC**: SSO with Auth0, Okta, Azure AD.

---

## 5. References

- [README_COMPLETE_FEATURES.md](./README_COMPLETE_FEATURES.md) — Implemented features
- [PHARMA_LMS_ENTERPRISE_ROADMAP.md](./PHARMA_LMS_ENTERPRISE_ROADMAP.md) — Roadmap
- [SSO_OIDC.md](./SSO_OIDC.md) — OIDC integration
- [STORAGE_S3.md](./STORAGE_S3.md) — S3/MinIO configuration
