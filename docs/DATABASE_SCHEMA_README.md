# Pharma LMS — Database Schema & Protocol Classes Reference

This document lists **all protocol classes** used in the Pharma LMS app, with their **database table** (when persisted) and **all fields** in each class. Source: `pharma_lms_server/lib/src/protocol/**/*.spy.yaml`. Generated types live in `pharma_lms_server/lib/src/generated/` and `pharma_lms_client/lib/src/protocol/`.

---

## Table of contents

1. [Admin](#admin)
2. [Analytics](#analytics)
3. [Assessment](#assessment)
4. [Audit](#audit)
5. [Auth](#auth)
6. [Course](#course)
7. [Document](#document)
8. [Events](#events)
9. [Infrastructure](#infrastructure)
10. [Material](#material)
11. [MFA](#mfa)
12. [Notifications](#notifications)
13. [Organization](#organization)
14. [Quality](#quality)
15. [Security](#security)
16. [Shared](#shared)
17. [Training](#training)
18. [DTOs / non-table classes](#dtos--non-table-classes)

---

## Admin

### ImportLog  
**Table:** `import_log`  
**Description:** Import log for bulk operations. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| importedBy | PharmaUser?, relation | Who performed the import |
| importType | String | employee, course, assignment |
| filename | String? | Original filename |
| recordCount | int? | Total records in file |
| successCount | int? | Successfully imported count |
| failureCount | int? | Failed count |
| failureDetailsJson | String? | Failure details as JSON |
| importedAt | DateTime | default=now |

### BulkImportResult  
**Table:** *(none — response DTO)*  
**Description:** Result of bulk user import.

| Field | Type |
|-------|------|
| imported | int |
| errors | List\<String\> |

---

## Analytics

### AnalyticsSnapshot  
**Table:** `analytics_snapshot`  
**Description:** Organization-wide analytics snapshot for historical trending.

| Field | Type | Notes |
|-------|------|--------|
| snapshotDate | DateTime | default=now |
| totalEmployees | int | |
| compliantCount | int | |
| overdueCount | int | |
| orgComplianceRate | double | 0-100 |
| totalCertificates | int | |
| certsExpiring30d | int | |
| certsExpiring60d | int | |
| openAssignments | int | |
| scheduledJobLog | ScheduledJobLog?, relation(optional) | |

### Dashboard  
**Table:** `dashboard`  
**Description:** Dashboard configuration.

| Field | Type | Notes |
|-------|------|--------|
| name | String | |
| widgetsJson | String | Widgets configuration |
| role | Role?, relation(optional) | |

### DepartmentComplianceSnapshot  
**Table:** `department_compliance_snapshot`  
**Description:** Historical snapshot of department compliance metrics.

| Field | Type | Notes |
|-------|------|--------|
| department | Department?, relation | |
| snapshotDate | DateTime | default=now |
| totalEmployees | int | |
| compliantCount | int | |
| overdueCount | int | |
| upcomingCount | int | |
| complianceRate | double | 0-100 |
| scheduledJobLog | ScheduledJobLog?, relation(optional) | |

### ReportDefinition  
**Table:** `report_definition`  
**Description:** Report definition for analytics.

| Field | Type | Notes |
|-------|------|--------|
| name | String | |
| reportType | String | |
| querySql | String? | |
| paramsJson | String? | |

### SlaBreach  
**Table:** `sla_breach`  
**Description:** SLA breach record.

| Field | Type | Notes |
|-------|------|--------|
| slaPolicy | SlaPolicy?, relation | |
| breachedAt | DateTime | default=now |
| resolvedAt | DateTime? | null if open |

### SlaPolicy  
**Table:** `sla_policy`  
**Description:** SLA policy for compliance monitoring.

| Field | Type | Notes |
|-------|------|--------|
| metric | String | e.g. compliance_rate |
| threshold | double | e.g. 90 for 90% |
| alertRole | Role?, relation | |

### AnalyticsEvent  
**Table:** *(none)*  
**Description:** Real-time analytics event for streaming (not persisted).

| Field | Type |
|-------|------|
| channel | String |
| eventType | String |
| payloadJson | String |
| occurredAt | DateTime |

### AuditReadinessScore  
**Table:** *(none)*  

| Field | Type |
|-------|------|
| complianceScore | double |
| auditTrailActive | bool |
| departmentCount | int |
| overallScore | double |

### ComplianceMetrics  
**Table:** *(none)*  

| Field | Type |
|-------|------|
| totalEmployees | int |
| compliant | int |
| overdue | int |
| upcoming | int |
| complianceRate | double |

### CourseAnalytics  
**Table:** *(none)*  

| Field | Type |
|-------|------|
| courseVersionId | int |
| passRate | double |
| totalAttempts | int |
| passedCount | int |
| scoreDistributionJson | String? |

### DepartmentComplianceSummary  
**Table:** *(none)*  

| Field | Type |
|-------|------|
| departmentId | int? |
| departmentName | String? |
| totalEmployees | int |
| compliant | int |
| overdue | int |
| upcoming | int |
| complianceRate | double |

### UserComplianceMetrics  
**Table:** *(none)*  

| Field | Type | Notes |
|-------|------|--------|
| compliant | bool | |
| overdueCount | int | |
| upcomingCount | int | |
| complianceRate | double | |
| totalCertificates | int | |
| waivedCount | int | default=0 |

---

## Assessment

### Assessment  
**Table:** `assessment`  
**Description:** Assessment linked to course version.

| Field | Type | Notes |
|-------|------|--------|
| courseVersion | CourseVersion?, relation | |
| questionBank | QuestionBank?, relation | |
| passingScore | int | e.g. 80 |
| randomize | bool | default=true |
| timeLimitMinutes | int? | |
| maxAttempts | int? | 0 = unlimited |
| questionsToDisplay | int? | |

### AssessmentAttempt  
**Table:** `assessment_attempt`  
**Description:** User attempt at an assessment.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| assessment | Assessment?, relation | |
| enrollment | Enrollment?, relation(optional) | |
| startedAt | DateTime | default=now |
| completedAt | DateTime? | null if in progress |
| score | int? | |

### AssessmentResult  
**Table:** `assessment_result`  
**Description:** Individual question result within an attempt.

| Field | Type | Notes |
|-------|------|--------|
| attempt | AssessmentAttempt?, relation | |
| question | Question?, relation | |
| answer | String | |
| correct | bool | |
| points | int? | |

### Question  
**Table:** `question`  
**Description:** Question in a question bank.

| Field | Type | Notes |
|-------|------|--------|
| questionBank | QuestionBank?, relation | |
| text | String | |
| questionType | String | multiple_choice, true_false |
| optionsJson | String | |
| correctAnswer | String | |
| difficulty | String? | easy, medium, hard |
| regulatoryTag | String? | e.g. 21 CFR 11, GMP |

### QuestionBank  
**Table:** `question_bank`  
**Description:** Question bank for assessments.

| Field | Type | Notes |
|-------|------|--------|
| name | String | |
| organization | Organization?, relation | |
| tagsJson | String? | e.g. GMP, Sterility |

---

## Audit

### AccessLog  
**Table:** `access_log`  
**Description:** Access log for login, session, and access tracking.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation(optional) | nullable for failed login |
| action | String | login, logout, session_timeout |
| ipAddress | String? | |
| userAgent | String? | |
| timestamp | DateTime | default=now |
| success | bool | default=true |

### AuditTrail  
**Table:** `audit_trail`  
**Description:** Immutable audit trail. FDA 21 CFR Part 11. Append-only.

| Field | Type | Notes |
|-------|------|--------|
| entityType | String | e.g. course, training_record, document |
| entityId | String | |
| action | String | create, update, delete, approve |
| oldValueJson | String? | |
| newValueJson | String? | |
| timestamp | DateTime | default=now |
| user | PharmaUser?, relation(optional) | |
| reason | String? | |
| ipAddress | String? | |
| rowHash | String? | SHA-256 for integrity |

### AuditorPageLog  
**Table:** `auditor_page_log`  
**Description:** Auditor page view log. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| auditorSession | AuditorSession?, relation | |
| pageUrl | String | |
| pageTitle | String? | |
| entityType | String? | training_record, certificate, etc. |
| entityId | String? | |
| viewedAt | DateTime | default=now |
| timeOnPageSeconds | int? | |
| exported | bool | default=false |

### AuditorSession  
**Table:** `auditor_session`  
**Description:** Auditor session for time-limited read-only access.

| Field | Type | Notes |
|-------|------|--------|
| inspectionRecord | InspectionRecord?, relation | |
| auditorUser | PharmaUser?, relation(optional) | |
| accessType | String | internal, external_fda, external_ema, customer |
| accessToken | String? | hashed |
| tokenIssuedAt | DateTime? | |
| tokenExpiresAt | DateTime? | |
| scopeStartDate | DateTime? | |
| scopeEndDate | DateTime? | |
| scopeSitesJson | String? | |
| scopeDepartmentsJson | String? | |
| isActive | bool | default=true |
| endedAt | DateTime? | |
| endedReason | String? | expired, manual_revoke, completed |
| pagesViewedCount | int | default=0 |
| lastActivityAt | DateTime? | |

### ErrorLog  
**Table:** `error_log`  
**Description:** Error log for system failures and exceptions.

| Field | Type | Notes |
|-------|------|--------|
| message | String | |
| stackTrace | String? | |
| contextJson | String? | |
| timestamp | DateTime | default=now |

### InspectionPackage  
**Table:** `inspection_package`  
**Description:** Inspection package - compliance evidence bundle.

| Field | Type | Notes |
|-------|------|--------|
| inspectionRecord | InspectionRecord?, relation | |
| generatedBy | PharmaUser?, relation | |
| generatedAt | DateTime | default=now |
| scopeDescription | String? | |
| includedRecordsCount | int? | |
| fileHash | String? | SHA-256 |
| storageUrl | String? | |
| watermarkText | String? | |
| isOfficial | bool | default=false |
| officialEsignature | ElectronicSignature?, relation(optional) | |

### InspectionRecord  
**Table:** `inspection_record`  
**Description:** Inspection record for auditor access. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| inspectionType | String | fda, ema, internal, customer |
| scheduledDate | DateTime? | |
| inspectorNames | String? | |
| scopeDescription | String? | |
| site | Site?, relation(optional) | |
| status | String | default='scheduled' |
| inspectionAccessToken | String? | |
| tokenExpiresAt | DateTime? | |
| briefingPackHash | String? | |
| briefingPackGeneratedAt | DateTime? | |
| outcome | String? | no_findings, observations, warning_letter |
| findingsCount | int? | |
| createdBy | PharmaUser?, relation(optional) | |
| createdAt | DateTime | default=now |

### ReportExport  
**Table:** `report_export`  
**Description:** Report export record for audit. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| exportedBy | PharmaUser?, relation | |
| reportType | String | compliance, training_matrix, audit_trail, etc. |
| filterParamsJson | String? | |
| recordCount | int? | |
| fileHash | String? | SHA-256 |
| storageUrl | String? | |
| watermarkText | String? | |
| exportedAt | DateTime | default=now |
| expiresAt | DateTime? | |

### UserSession  
**Table:** `user_session`  
**Description:** User session for login tracking. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| startedAt | DateTime | default=now |
| endedAt | DateTime? | |
| ipAddress | String? | |
| userAgent | String? | |
| deviceFingerprint | String? | |
| endReason | String? | manual_logout, timeout, admin_revoke |
| isMfaVerified | bool | default=false |

---

## Auth

### OidcAccount  
**Table:** `oidc_account`  
**Description:** OIDC provider account. Links to serverpod auth user by UUID.

| Field | Type | Notes |
|-------|------|--------|
| authUserId | String | Serverpod auth user ID (UUID) |
| providerId | String | OIDC subject (sub claim). **Unique index** |
| email | String? | |
| createdAt | DateTime | default=now |

### OidcClientConfig  
**Table:** *(none)*  
**Description:** OIDC client config for Flutter (SSO).

| Field | Type |
|-------|------|
| enabled | bool |
| authorizationEndpoint | String? |
| clientId | String? |
| redirectUri | String? |

---

## Course

### Competency  
**Table:** `competency`  
**Description:** Competency/skill definition.

| Field | Type | Notes |
|-------|------|--------|
| name | String | |
| code | String | unique |
| level | int? | 1, 2, 3, etc. |

### Course  
**Table:** `course`  
**Description:** Course entity - learning program container.

| Field | Type | Notes |
|-------|------|--------|
| title | String | |
| sopNumber | String? | e.g. SOP-105 |
| description | String? | |
| status | String | default='draft' |
| createdBy | PharmaUser?, relation(optional) | |
| organization | Organization?, relation | |

### CourseCompetency  
**Table:** `course_competency`  
**Description:** Links courses to competencies.

| Field | Type |
|-------|------|
| course | Course?, relation |
| competency | Competency?, relation |

### CourseReview  
**Table:** `course_review`  
**Description:** Course review record - QA approval workflow. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| courseVersion | CourseVersion?, relation | |
| reviewer | PharmaUser?, relation | |
| reviewType | String | default='initial' |
| decision | String | approved, rejected, returned_for_changes |
| comments | String? | |
| reviewChecklistJson | String? | |
| reviewedAt | DateTime | default=now |
| esignature | ElectronicSignature?, relation(optional) | |

### CourseSopLink  
**Table:** `course_sop_link`  
**Description:** Explicit many-to-many SOP-Course linkage.

| Field | Type | Notes |
|-------|------|--------|
| course | Course?, relation | |
| document | Document?, relation | |
| linkedBy | PharmaUser?, relation | |
| linkedAt | DateTime | default=now |
| unlinkedAt | DateTime? | soft-delete |

### CourseVersion  
**Table:** `course_version`  
**Description:** Versioned course - immutable history for compliance.

| Field | Type | Notes |
|-------|------|--------|
| course | Course?, relation | |
| version | String | e.g. 1.0, 2.0 |
| effectiveDate | DateTime? | |
| obsoleteDate | DateTime? | |
| status | String | default='draft' |
| supersededByVersionId | int? | |
| changeSummary | String? | |

### Lesson  
**Table:** `lesson`  
**Description:** Lesson within a module.

| Field | Type | Notes |
|-------|------|--------|
| module | Module?, relation | |
| title | String | |
| orderIndex | int | default=0 |
| material | Material?, relation | |
| durationMinutes | int? | |

### Module  
**Table:** `module`  
**Description:** Module within a course version.

| Field | Type | Notes |
|-------|------|--------|
| courseVersion | CourseVersion?, relation | |
| title | String | |
| orderIndex | int | default=0 |

### UserCompetency  
**Table:** `user_competency`  
**Description:** User's achieved competency with expiry.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| competency | Competency?, relation | |
| achievedAt | DateTime | default=now |
| expiresAt | DateTime? | |

### QaValidationResult  
**Table:** *(none)*  
**Description:** Result of TRN-WF-04 validateForQaSubmission.

| Field | Type |
|-------|------|
| courseVersionId | int |
| courseTitle | String |
| version | String |
| allPassed | bool |
| passedCount | int |
| totalRules | int |
| validationResults | List\<QaValidationRuleResult\> |

### QaValidationRuleResult  
**Table:** *(none)*  

| Field | Type |
|-------|------|
| rule | String |
| description | String |
| passed | bool |
| detail | String |

---

## Document

### ApprovalWorkflow  
**Table:** `approval_workflow`  
**Description:** Approval workflow step for document version.

| Field | Type | Notes |
|-------|------|--------|
| documentVersion | DocumentVersion?, relation | |
| step | int | |
| approver | PharmaUser?, relation | |
| status | String | default='pending' |
| signedAt | DateTime? | |
| esignature | ElectronicSignature?, relation(optional) | |

### Document  
**Table:** `document`  
**Description:** Controlled document (SOP, policy).

| Field | Type | Notes |
|-------|------|--------|
| title | String | |
| documentNumber | String | e.g. SOP-105 |
| documentType | String | sop, policy, guideline |
| organization | Organization?, relation | |
| affectedDepartmentIdsJson | String? | retraining scope |
| affectedRoleIdsJson | String? | retraining scope |
| trainingRequiredByQa | String? | training_required, no_training_required |

### DocumentLifecycle  
**Table:** `document_lifecycle`  
**Description:** Document lifecycle state tracking.

| Field | Type | Notes |
|-------|------|--------|
| documentVersion | DocumentVersion?, relation | |
| state | String | draft, review, approved, effective, obsolete |
| changedAt | DateTime | default=now |
| changedBy | PharmaUser?, relation | |

### DocumentVersion  
**Table:** `document_version`  
**Description:** Versioned document for lifecycle control.

| Field | Type | Notes |
|-------|------|--------|
| document | Document?, relation | |
| version | String | e.g. 1.0, 2.3 |
| versionMajor | int? | |
| versionMinor | int? | |
| isMajorVersion | bool? | triggers SOP_UPDATED retraining |
| storageKey | String | S3/MinIO |
| effectiveDate | DateTime? | |
| obsoleteDate | DateTime? | |

---

## Events

### DeadLetterQueue  
**Table:** `dead_letter_queue`  
**Description:** Dead letter queue for failed event publishing.

| Field | Type | Notes |
|-------|------|--------|
| outboxMessageId | int? | |
| failedAt | DateTime | default=now |
| failureReason | String? | |
| retryCount | int | default=0 |
| manuallyResolved | bool | default=false |
| resolvedById | int? | |
| resolvedAt | DateTime? | |
| resolutionNotes | String? | |

### DomainEvent  
**Table:** `domain_event`  
**Description:** Domain event for event-driven workflows.

| Field | Type | Notes |
|-------|------|--------|
| eventType | String | |
| aggregateId | String | |
| payloadJson | String | |
| createdAt | DateTime | default=now |
| processedAt | DateTime? | |
| kafkaOffset | String? | |

### OutboxMessage  
**Table:** `outbox_message`  
**Description:** Outbox pattern for reliable event publishing.

| Field | Type | Notes |
|-------|------|--------|
| topic | String | Kafka topic |
| payloadJson | String | |
| createdAt | DateTime | default=now |
| sentAt | DateTime? | |
| status | String | default='pending' |
| retryCount | int | default=0 |
| lastError | String? | |

---

## Infrastructure

### AuditIntegrityResult  
**Table:** `audit_integrity_result`  
**Description:** Result of audit trail integrity check (SYS-WF-08).

| Field | Type | Notes |
|-------|------|--------|
| checkedAt | DateTime | default=now |
| recordsChecked | int | |
| hashMismatches | int | |
| sequenceGaps | int | |
| result | String | passed, failed |
| failureDetailsJson | String? | |
| scheduledJobLog | ScheduledJobLog?, relation(optional) | |

### FeatureFlag  
**Table:** `feature_flag`  
**Description:** Feature flag for gradual rollout.

| Field | Type | Notes |
|-------|------|--------|
| key | String | |
| enabled | bool | default=false |
| organization | Organization?, relation(optional) | null = global |

### RetentionArchive  
**Table:** `retention_archive`  
**Description:** Archived records per retention policy.

| Field | Type | Notes |
|-------|------|--------|
| entityType | String | e.g. audit_trail |
| entityId | String | |
| rowJson | String | full row snapshot |
| archivedAt | DateTime | default=now |

### RetentionPolicy  
**Table:** `retention_policy`  
**Description:** Retention policy for data archival.

| Field | Type | Notes |
|-------|------|--------|
| entityType | String | e.g. audit_trail, access_log |
| retentionYears | int | default=7 |
| archiveEnabled | bool | default=true |
| lastArchivedAt | DateTime? | |

### ScheduledJobLog  
**Table:** `scheduled_job_log`  
**Description:** Scheduled job execution log. GMP.

| Field | Type | Notes |
|-------|------|--------|
| jobName | String | CertExpiryCheck, ComplianceCalc, etc. |
| startedAt | DateTime | default=now |
| completedAt | DateTime? | |
| status | String | default='running' |
| recordsProcessed | int? | |
| recordsAffected | int? | |
| errorDetails | String? | |

### SystemConfiguration  
**Table:** `system_configuration`  
**Description:** System configuration key-value.

| Field | Type | Notes |
|-------|------|--------|
| key | String | |
| value | String | |
| organization | Organization?, relation(optional) | null = global |

---

## Material

### Material  
**Table:** `material`  
**Description:** Learning material (PDF, video, SCORM).

| Field | Type | Notes |
|-------|------|--------|
| title | String | |
| materialType | String | pdf, video, scorm |
| storageKey | String? | S3/MinIO |
| organization | Organization?, relation | |

### MaterialProgress  
**Table:** `material_progress`  
**Description:** User progress on material (video watch, scroll depth).

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| material | Material?, relation | |
| progressPct | int | default=0, 0-100 |
| completedAt | DateTime? | |
| interactionJson | String? | watch/pause, scroll depth |
| materialVersionId | int? | |
| enrollmentId | int? | |
| timeSpentSeconds | int? | |
| lastHeartbeat | DateTime? | |
| readTimeMet | bool? | server-set |

### MaterialVersion  
**Table:** `material_version`  
**Description:** Versioned material for document control.

| Field | Type | Notes |
|-------|------|--------|
| material | Material?, relation | |
| version | int | |
| storageKey | String | |
| createdAt | DateTime | default=now |
| fileHash | String? | SHA-256 |
| virusScanStatus | String? | default='pending' |
| virusScanAt | DateTime? | |
| fileSizeBytes | int? | |

### MediaAsset  
**Table:** `media_asset`  
**Description:** Media asset (video, image) linked to material.

| Field | Type | Notes |
|-------|------|--------|
| material | Material?, relation | |
| assetType | String | video, image |
| url | String | |
| durationSeconds | int? | for video |

---

## MFA

### MfaVerifiedSession  
**Table:** `mfa_verified_session`  
**Description:** Tracks MFA verification for a session.

| Field | Type | Notes |
|-------|------|--------|
| authUserId | String | Serverpod auth user ID (UUID) |
| sessionId | String | e.g. JWT jti or device fingerprint |
| verifiedAt | DateTime | default=now |

### UserMfa  
**Table:** `user_mfa`  
**Description:** MFA settings for a user. Links to serverpod auth user by UUID.

| Field | Type | Notes |
|-------|------|--------|
| authUserId | String | |
| mfaSecretBase32 | String | TOTP secret |
| mfaEnabled | bool | default=false |
| enrolledAt | DateTime? | default=now |

### MfaEnrollResult  
**Table:** *(none)*  
**Description:** Result of enrollMfa - secret and otpauth URL for QR.

| Field | Type |
|-------|------|
| secretBase32 | String |
| otpauthUrl | String |

### MfaStatusResult  
**Table:** *(none)*  

| Field | Type |
|-------|------|
| mfaEnabled | bool |
| enrolledAt | DateTime? |

---

## Notifications

### Notification  
**Table:** `notification`  
**Description:** Notification record for delivery tracking. GMP.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| type | String | assignment, reminder_*, overdue, cert_expiry, etc. |
| enrollment | Enrollment?, relation(optional) | |
| sentAt | DateTime? | |
| deliveryStatus | String? | sent, failed, bounced |
| readAt | DateTime? | in-app |
| channel | String | default='in_app' |
| createdAt | DateTime | default=now |

### NotificationLog  
**Table:** `notification_log`  
**Description:** Log of notification delivery attempts.

| Field | Type | Notes |
|-------|------|--------|
| notification | Notification?, relation | |
| attemptedAt | DateTime | default=now |
| channel | String | email, sms, in_app |
| status | String | default='sent' |
| errorMessage | String? | |
| retryCount | int | default=0 |
| externalMessageId | String? | e.g. SendGrid ID |

### InAppNotification  
**Table:** *(none)*  
**Description:** In-app notification (assignment due/overdue).

| Field | Type |
|-------|------|
| type | String |
| assignmentId | int? |
| courseTitle | String |
| dueDate | String |
| message | String |

---

## Organization

### Organization  
**Table:** `organization`  
**Description:** Multi-tenant root entity.

| Field | Type | Notes |
|-------|------|--------|
| name | String | |
| code | String | unique |
| createdAt | DateTime | default=now |

### Site  
**Table:** `site`  
**Description:** Physical site within an organization.

| Field | Type | Notes |
|-------|------|--------|
| organization | Organization?, relation | |
| name | String | |
| code | String | unique |
| timezone | String | default='UTC' |

### Department  
**Table:** `department`  
**Description:** Department within a site.

| Field | Type | Notes |
|-------|------|--------|
| site | Site?, relation | |
| name | String | |
| code | String | unique |

### PharmaUser  
**Table:** `pharma_user`  
**Description:** Pharma LMS user - links identity to organization hierarchy.

| Field | Type | Notes |
|-------|------|--------|
| email | String | primary for login/notifications |
| firstName | String | |
| lastName | String | |
| department | Department?, relation | |
| jobRole | JobRole?, relation | |
| site | Site?, relation | |
| organization | Organization?, relation | |
| status | String | default='active' |
| createdAt | DateTime | default=now |
| authUserId | int? | link to serverpod auth |
| employeeId | String? | HR system |
| hireDate | DateTime? | |
| managerId | int? | |
| preferredLanguage | String? | |
| timezone | String? | default='UTC' |

### Role  
**Table:** `role`  
**Description:** RBAC role for access control.

| Field | Type | Notes |
|-------|------|--------|
| name | String | e.g. employee, admin, qa, sme |
| code | String | unique |

### UserRole  
**Table:** `user_role`  
**Description:** Links users to RBAC roles (many-to-many).

| Field | Type |
|-------|------|
| user | PharmaUser?, relation |
| role | Role?, relation |

### Permission  
**Table:** `permission`  
**Description:** Permission linked to a role for RBAC.

| Field | Type | Notes |
|-------|------|--------|
| role | Role?, relation | |
| resource | String | e.g. course, training, audit |
| action | String | e.g. read, write, approve |

### JobRole  
**Table:** `job_role`  
**Description:** Job role with training matrix.

| Field | Type | Notes |
|-------|------|--------|
| department | Department?, relation | |
| name | String | |
| code | String | unique |
| trainingMatrixJson | String? | required course IDs |

### UserPreference  
**Table:** `user_preference`  
**Description:** Per-user key/value preferences.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| preferenceKey | String | email_notifications, dark_mode, etc. |
| preferenceValue | String | |

---

## Quality

### QualityEvent  
**Table:** `quality_event`  
**Description:** Quality event (deviation, CAPA, change control).

| Field | Type | Notes |
|-------|------|--------|
| eventType | String | deviation, capa, change_control |
| referenceId | String? | |
| title | String | |
| status | String | |
| site | Site?, relation(optional) | |
| createdAt | DateTime | default=now |

### Capa  
**Table:** `capa`  
**Description:** CAPA - Corrective and Preventive Action.

| Field | Type | Notes |
|-------|------|--------|
| qualityEvent | QualityEvent?, relation | |
| description | String? | |
| rootCause | String? | |
| trainingRequired | bool | default=false |
| trainingAssignment | TrainingAssignment?, relation(optional) | |
| status | String | default='Initiation' |
| rcaCompletedAt | DateTime? | |
| effectivenessCheckDue | DateTime? | |
| closedAt | DateTime? | |
| closedById | int? | |

### ChangeControl  
**Table:** `change_control`  
**Description:** Change control linking to document and training.

| Field | Type | Notes |
|-------|------|--------|
| qualityEvent | QualityEvent?, relation | |
| documentVersion | DocumentVersion?, relation | |
| trainingTriggerId | int? | |

### InspectionReport  
**Table:** `inspection_report`  
**Description:** Inspection report (FDA, etc.).

| Field | Type | Notes |
|-------|------|--------|
| organization | Organization?, relation | |
| site | Site?, relation(optional) | |
| inspector | String? | |
| inspectionDate | DateTime? | |
| findingsJson | String? | |
| status | String | |

---

## Security

### AbacPolicy  
**Table:** `abac_policy`  
**Description:** ABAC policy for attribute-based access control.

| Field | Type | Notes |
|-------|------|--------|
| name | String | |
| ruleJson | String | |
| effect | String | allow, deny |

### DelegatedAuthority  
**Table:** `delegated_authority`  
**Description:** Delegated authority (e.g. supervisor delegates to delegatee).

| Field | Type | Notes |
|-------|------|--------|
| delegator | PharmaUser?, relation | |
| delegatee | PharmaUser?, relation | |
| scope | String | |
| expiresAt | DateTime | |

---

## Shared

### ElectronicSignature  
**Table:** `electronic_signature`  
**Description:** Electronic signature for 21 CFR Part 11 compliance.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| timestamp | DateTime | default=now |
| signatureMeaning | String | e.g. "I have read and understood" |
| passwordPlaintext | String? | never persisted |
| passwordReauthHash | String? | server-only |
| entityType | String | e.g. training_record, certificate |
| entityId | String | |
| ipAddress | String? | |
| integrityHash | String? | HMAC |
| isValid | bool | default=true |
| revokedReason | String? | |
| revokedBySignatureId | int? | |

### SignatureMeaning  
**Table:** `signature_meaning`  
**Description:** Configurable e-signature meaning. 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| meaning | String | |
| isActive | bool | default=true |
| orderIndex | int | default=0 |
| applicableTo | String? | training_completion, course_approval, etc. |

### SignatureVerificationResult  
**Table:** *(none)*  
**Description:** Result of e-signature integrity verification.

| Field | Type | Notes |
|-------|------|--------|
| signature | ElectronicSignature? | |
| integrityViolation | bool | default=false, tampering detected |

---

## Training

### TrainingAssignment  
**Table:** `training_assignment`  
**Description:** Training assignment to user for a course version.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| courseVersion | CourseVersion?, relation | |
| assignedBy | PharmaUser?, relation | |
| assignedAt | DateTime | default=now |
| dueDate | DateTime | |
| priority | String | default='medium' |
| reason | String? | |
| source | String | default='manual' |
| assignmentType | String | default='individual' |
| targetRoleId | int? | |
| targetDepartmentId | int? | |
| targetUserId | int? | |
| status | String | default='active' |
| cancelledAt | DateTime? | |
| cancelledById | int? | |
| cancellationReason | String? | |

### Enrollment  
**Table:** `enrollment`  
**Description:** User's progress in a course version.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| courseVersion | CourseVersion?, relation | |
| assignment | TrainingAssignment?, relation(optional) | |
| status | String | default='not_started' |
| startedAt | DateTime? | |
| completedAt | DateTime? | |
| retrainingChangeSummary | String? | |
| acknowledgedAt | DateTime? | |
| acknowledgementEsignature | ElectronicSignature?, relation(optional) | |

### Certificate  
**Table:** `certificate`  
**Description:** Certificate issued after successful training.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| courseVersion | CourseVersion?, relation | |
| trainingRecord | TrainingRecord?, relation | |
| issuedAt | DateTime | default=now |
| expiresAt | DateTime? | |
| qrCode | String? | |
| esignature | ElectronicSignature?, relation | |
| status | String | default='active' |

### TrainingRecord  
**Table:** `training_record`  
**Description:** Training record - completion with e-signature. FDA 21 CFR Part 11.

| Field | Type | Notes |
|-------|------|--------|
| enrollment | Enrollment?, relation | |
| user | PharmaUser?, relation | |
| courseVersion | CourseVersion?, relation | |
| completedAt | DateTime | default=now |
| score | int? | |
| esignature | ElectronicSignature?, relation | |

### TrainingExpiration  
**Table:** `training_expiration`  
**Description:** Tracks certification expiry and renewal.

| Field | Type | Notes |
|-------|------|--------|
| certificate | Certificate?, relation | |
| expiresAt | DateTime | |
| reminderSentAt | DateTime? | |
| renewalAssignment | TrainingAssignment?, relation(optional) | |
| expiryStage | String? | 90d, 60d, 30d, 7d, expired |

### TrainingMatrix  
**Table:** `training_matrix`  
**Description:** Training matrix - role to course mapping. GMP.

| Field | Type | Notes |
|-------|------|--------|
| jobRole | JobRole?, relation | |
| course | Course?, relation | |
| site | Site?, relation(optional) | org-wide if null |
| isMandatory | bool | default=true |
| dueDaysFromHire | int | default=60 |
| retrainingIntervalDays | int? | |
| createdBy | PharmaUser?, relation(optional) | |
| approvedBy | PharmaUser?, relation(optional) | |
| effectiveDate | DateTime? | |

### TrainingWaiver  
**Table:** `training_waiver`  
**Description:** Training waiver - exempt user from course requirement. ADM-07.

| Field | Type | Notes |
|-------|------|--------|
| user | PharmaUser?, relation | |
| course | Course?, relation | |
| requestedBy | PharmaUser?, relation | |
| requestedAt | DateTime | default=now |
| requestReason | String | |
| evidenceStoragePath | String? | |
| status | String | default='pending' |
| approvedBy | PharmaUser?, relation(optional) | |
| approvedAt | DateTime? | |
| rejectionReason | String? | |
| expiresAt | DateTime? | |

### TrainingRecordAnnotation  
**Table:** `training_record_annotation`  
**Description:** QA annotation on a training record.

| Field | Type | Notes |
|-------|------|--------|
| trainingRecord | TrainingRecord?, relation | |
| author | PharmaUser?, relation | |
| note | String | |
| createdAt | DateTime | default=now |

---

## DTOs / non-table classes

These types are used in API requests/responses but do not have a database table:

- **BulkImportResult** — imported (int), errors (List\<String\>)
- **AnalyticsEvent** — channel, eventType, payloadJson, occurredAt
- **AuditReadinessScore** — complianceScore, auditTrailActive, departmentCount, overallScore
- **ComplianceMetrics** — totalEmployees, compliant, overdue, upcoming, complianceRate
- **CourseAnalytics** — courseVersionId, passRate, totalAttempts, passedCount, scoreDistributionJson
- **DepartmentComplianceSummary** — departmentId, departmentName, totalEmployees, compliant, overdue, upcoming, complianceRate
- **UserComplianceMetrics** — compliant, overdueCount, upcomingCount, complianceRate, totalCertificates, waivedCount
- **OidcClientConfig** — enabled, authorizationEndpoint, clientId, redirectUri
- **QaValidationResult** — courseVersionId, courseTitle, version, allPassed, passedCount, totalRules, validationResults
- **QaValidationRuleResult** — rule, description, passed, detail
- **InAppNotification** — type, assignmentId, courseTitle, dueDate, message
- **MfaEnrollResult** — secretBase32, otpauthUrl
- **MfaStatusResult** — mfaEnabled, enrolledAt
- **SignatureVerificationResult** — signature, integrityViolation

---

## Regenerating this doc

Protocol classes are defined in `pharma_lms_server/lib/src/protocol/**/*.spy.yaml`. After adding or changing types, run:

```bash
cd pharma_lms/pharma_lms_server
dart run serverpod_cli:serverpod generate
```

Migrations are in `pharma_lms_server/migrations/`. Apply with:

```bash
dart run bin/main.dart --apply-migrations
```

---

*Last generated from protocol .spy.yaml files. For RPC endpoints and methods, see `pharma_lms_server/lib/src/generated/protocol.yaml`.*
