# Employee Portal — Database Access by Screen

This document lists **which database tables** each **employee portal screen** reads from and writes to. Use it for security reviews, data-flow audits, and understanding impact of schema changes.

**Reference:** Table names and protocol classes are defined in [DATABASE_SCHEMA_README.md](./DATABASE_SCHEMA_README.md).

---

## Summary

| Screen | Main reads | Main writes |
|--------|------------|-------------|
| Login | `pharma_user`, `user_role`, `role`, `user_mfa` | (auth session only) |
| Employee shell | `pharma_user`, `notification` | `notification` (mark read) |
| Employee dashboard | `pharma_user`, `enrollment`, `training_assignment`, `certificate`, `training_record`, `department`, `pharma_user` (dept), `training_waiver`, `audit_trail`, `dashboard`, `sla_breach`, `training_assignment`, `enrollment`, `pharma_user`, `certificate`, `capa`, `document` | — |
| My Training | `enrollment`, `training_assignment`, `certificate`, `training_record`, `material_progress`, `training_waiver`, `pharma_user`, `department` | — |
| Course catalog | `course`, `course_version`, `enrollment`, `training_assignment` | `training_assignment`, `enrollment`, `audit_trail` |
| Course viewer | `enrollment`, `course_version`, `module`, `lesson`, `material`, `material_progress`, `signature_meaning` | `material_progress`, `enrollment` (progress/status) |
| Assessments list | `pharma_user`, `enrollment`, `assessment`, `assessment_attempt` | — |
| Assessment (take) | `enrollment`, `assessment`, `question_bank`, `question`, `assessment_attempt`, `assessment_result`, `training_record` | `assessment_attempt`, `assessment_result`, `training_record`, `certificate`, `enrollment`, `electronic_signature`, `audit_trail` |
| Training history | `training_record`, `enrollment`, `certificate`, `material_progress` | `report_export`, `audit_trail` |
| Credentials | `certificate`, `enrollment` | — |
| Profile | `pharma_user`, `certificate` | — |
| MFA enrollment | `user_mfa`, `mfa_verified_session` | `user_mfa`, `mfa_verified_session` |
| Waiver | `training_waiver` | — |
| Lessons | `enrollment`, `material_progress` | — |
| Downloads | `certificate` | — |

---

## 1. Login

**UI:** `login_screen_redesign.dart` / `login_screen.dart`  
**Endpoints:** Auth (session), `user.getUserRoleByEmail`, `mfa.getMfaStatus`, `mfa.verifyMfa` (when MFA required).

| Operation | Tables |
|-----------|--------|
| **Read** | `pharma_user`, `user_role`, `role`, `user_mfa`, `mfa_verified_session` (for MFA flow) |
| **Write** | None (auth session is managed by Serverpod; no app tables written on login) |

---

## 2. Employee Shell (layout / header)

**UI:** `employee_shell_v2.dart`  
**Endpoints:** `user.getUserByEmail`, `notification.getInAppNotifications`, `notification.markNotificationRead`, `auth.signOut`.

| Operation | Tables |
|-----------|--------|
| **Read** | `pharma_user`, `notification` (and related notification build from assignments/enrollments/courses) |
| **Write** | `notification` (update `readAt` when marking as read) |

---

## 3. Employee Dashboard

**UI:** `employee_dashboard_v2.dart` / `employee_dashboard_redesigned.dart`  
**Endpoints:** `user.getUserByEmail`, `training.getAssignmentsForUser`, `training.getEnrollmentsForUser`, `training.getCertificatesForUser`, `training.getTrainingRecordsForUser`, `compliance.getUserCompliance`, `compliance.getDepartmentCompliance`, `analytics.getDashboardSummary` (or equivalent), `training.getWaiverById` (if shown).

| Operation | Tables |
|-----------|--------|
| **Read** | `pharma_user`, `user_role`, `role`, `enrollment`, `training_assignment`, `certificate`, `training_record`, `material_progress`, `department`, `training_waiver`, `audit_trail`, `dashboard`, `sla_breach`, `capa`, `document` (via analytics/compliance services) |
| **Write** | None |

---

## 4. My Training

**UI:** `my_training_screen.dart` / `my_learning_screen.dart`  
**Endpoints:** `training.getEnrollmentsForUser`, `training.getAssignmentsForUser`, `training.getEnrollmentProgress`, `compliance.getUserCompliance`, course/enrollment resume labels.

| Operation | Tables |
|-----------|--------|
| **Read** | `enrollment`, `training_assignment`, `certificate`, `training_record`, `material_progress`, `training_waiver`, `pharma_user`, `department` (via compliance) |
| **Write** | None |

---

## 5. Course Catalog

**UI:** `course_catalog_screen_v2.dart` / `course_catalog_screen_redesigned.dart`  
**Endpoints:** `course.listCourses`, `course.getCourseVersions`, `training.getEnrollmentsForUser`, `training.selfEnroll`.

| Operation | Tables |
|-----------|--------|
| **Read** | `course`, `course_version`, `enrollment`, `training_assignment` (to check existing enrollments) |
| **Write** | `training_assignment` (insert on self-enroll), `enrollment` (insert), `audit_trail` (SelfEnrolled) |

---

## 6. Course Viewer

**UI:** `course_viewer_screen_v2.dart` / `course_viewer_screen_redesigned.dart`  
**Endpoints:** `training.getEnrollmentById`, `training.listSignatureMeanings`, `course.getCourseVersion`, `course.getModulesForCourseVersion`, `course.getLessonsForModule`, `material.getLessonWithMaterial`, `material.getProgress`, `material.recordEngagement`, `material.updateProgress`, `material.getMaterialViewUrl`.

| Operation | Tables |
|-----------|--------|
| **Read** | `enrollment`, `course_version`, `course`, `module`, `lesson`, `material`, `material_version`, `material_progress`, `signature_meaning` |
| **Write** | `material_progress` (insert/update), `enrollment` (update status/last position when progress is updated) |

---

## 7. Assessments List

**UI:** `assessment_list_screen.dart`  
**Endpoints:** `user.getUserByEmail`, `training.getEnrollmentsForUser`, `assessment.getAssessmentForCourse`, `assessment.getAttemptCount`.

| Operation | Tables |
|-----------|--------|
| **Read** | `pharma_user`, `enrollment`, `assessment`, `assessment_attempt`, `question_bank`, `question` (for assessment metadata) |
| **Write** | None |

---

## 8. Assessment (Take)

**UI:** `assessment_screen_redesigned.dart` / `assessment_v2.dart`  
**Endpoints:** `training.getEnrollmentById`, `training.getTrainingRecordsForUser`, `assessment.getAssessmentForCourse`, `assessment.getQuestions`, `assessment.getAttemptCount`, `assessment.startAttempt`, `assessment.recordAnswer`, `assessment.submitAttempt`, `training.completeTraining` (after pass + e-signature), `training.createTrainingSignature`.

| Operation | Tables |
|-----------|--------|
| **Read** | `enrollment`, `assessment`, `question_bank`, `question`, `assessment_attempt`, `assessment_result`, `training_record`, `pharma_user` (for e-signature) |
| **Write** | `assessment_attempt` (insert, update on submit), `assessment_result` (insert per answer), `training_record` (insert on complete), `certificate` (insert), `enrollment` (update status/completedAt), `electronic_signature` (insert via createTrainingSignature), `audit_trail` (training/assignment/certificate events) |

---

## 9. Training History

**UI:** `training_history_screen_redesigned.dart` / `training_history_v2.dart`  
**Endpoints:** `training.getTrainingRecordsForUser`, `training.getEnrollmentsForUser`, `training.getCertificatesForUser`, `material.getProgress` (or equivalent for enrollment progress), `audit.logReportExport` (when user exports report).

| Operation | Tables |
|-----------|--------|
| **Read** | `training_record`, `enrollment`, `certificate`, `material_progress`, `course_version`, `course` (via includes) |
| **Write** | `report_export` (insert when exporting), `audit_trail` (ReportExported) |

---

## 10. Credentials

**UI:** `credentials_wallet_screen.dart` / `certification_screen_v2.dart`  
**Endpoints:** `training.getCertificatesForUser`, `training.getEnrollmentsForUser`.

| Operation | Tables |
|-----------|--------|
| **Read** | `certificate`, `enrollment`, `course_version`, `course`, `training_record` (via includes) |
| **Write** | None |

---

## 11. Profile

**UI:** `profile_settings_screen.dart`  
**Endpoints:** `user.getUserByEmail`, `training.getCertificatesForUser`, `auth.signOut`.

| Operation | Tables |
|-----------|--------|
| **Read** | `pharma_user`, `certificate` |
| **Write** | None |

---

## 12. MFA Enrollment

**UI:** MFA flow in login or dedicated MFA screen  
**Endpoints:** `mfa.getMfaStatus`, `mfa.enrollMfa`, `mfa.verifyMfaEnrollment`, `mfa.verifyMfa`, `mfa.disableMfa`.

| Operation | Tables |
|-----------|--------|
| **Read** | `user_mfa`, `mfa_verified_session` |
| **Write** | `user_mfa` (insert/update for enroll, update for disable), `mfa_verified_session` (insert on verify) |

---

## 13. Waiver

**UI:** `training_waiver_screen.dart`  
**Endpoints:** `training.getWaiverById` (or list waivers for user).

| Operation | Tables |
|-----------|--------|
| **Read** | `training_waiver` |
| **Write** | None (employee only views waiver status; approval is admin/trainer) |

---

## 14. Lessons

**UI:** `lessons_screen.dart`  
**Endpoints:** `training.getEnrollmentsForUser`, `training.getEnrollmentResumePosition` (or equivalent progress API).

| Operation | Tables |
|-----------|--------|
| **Read** | `enrollment`, `material_progress`, `course_version`, `module`, `lesson` (for resume position/labels) |
| **Write** | None |

---

## 15. Downloads

**UI:** `downloads_screen.dart`  
**Endpoints:** `training.getCertificatesForUser` (and possibly file/download APIs that resolve certificate assets).

| Operation | Tables |
|-----------|--------|
| **Read** | `certificate`, `training_record`, `course_version` (for display/metadata) |
| **Write** | None |

---

## Table index (employee portal only)

Tables **read** by at least one employee screen:

- `pharma_user`
- `user_role`
- `role`
- `user_mfa`
- `mfa_verified_session`
- `notification`
- `enrollment`
- `training_assignment`
- `certificate`
- `training_record`
- `material_progress`
- `course`
- `course_version`
- `module`
- `lesson`
- `material`
- `material_version`
- `signature_meaning`
- `assessment`
- `assessment_attempt`
- `assessment_result`
- `question_bank`
- `question`
- `training_waiver`
- `electronic_signature`
- `audit_trail`
- `report_export`
- `department`
- `dashboard`
- `sla_breach`
- `capa`
- `document`

Tables **written** by at least one employee screen:

- `notification` (mark read)
- `training_assignment` (self-enroll)
- `enrollment` (self-enroll, progress, complete)
- `material_progress` (progress/engagement)
- `assessment_attempt`
- `assessment_result`
- `training_record`
- `certificate`
- `electronic_signature`
- `user_mfa`
- `mfa_verified_session`
- `report_export`
- `audit_trail` (via AuditService from several flows)

---

*Generated from endpoint usage and server endpoint implementations. For full schema details see [DATABASE_SCHEMA_README.md](./DATABASE_SCHEMA_README.md).*
