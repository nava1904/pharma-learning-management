BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AbacPolicy as table abac_policy
--
CREATE TABLE "abac_policy" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "ruleJson" text NOT NULL,
    "effect" text NOT NULL
);

--
-- Class AccessLog as table access_log
--
CREATE TABLE "access_log" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "action" text NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "success" boolean NOT NULL DEFAULT true
);

--
-- Class AccessReview as table access_review
--
CREATE TABLE "access_review" (
    "id" bigserial PRIMARY KEY,
    "windowId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL,
    "decision" text NOT NULL DEFAULT 'PENDING'::text,
    "justification" text,
    "reviewedById" bigint,
    "reviewedAt" timestamp without time zone,
    "signedAt" timestamp without time zone,
    "signatureId" bigint,
    "windowOpen" timestamp without time zone NOT NULL,
    "windowClose" timestamp without time zone NOT NULL,
    "jobId" text,
    "status" text NOT NULL DEFAULT 'ACTIVE'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "migrationMarker" text
);

--
-- Class AccessReviewWindow as table access_review_window
--
CREATE TABLE "access_review_window" (
    "id" bigserial PRIMARY KEY,
    "windowId" bigint NOT NULL,
    "openDate" timestamp without time zone NOT NULL,
    "closeDate" timestamp without time zone NOT NULL,
    "totalRecords" bigint NOT NULL,
    "jobId" text,
    "status" text NOT NULL DEFAULT 'ACTIVE'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "migrationMarker" text
);

--
-- Class AnalyticsSnapshot as table analytics_snapshot
--
CREATE TABLE "analytics_snapshot" (
    "id" bigserial PRIMARY KEY,
    "snapshotDate" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "totalEmployees" bigint NOT NULL,
    "compliantCount" bigint NOT NULL,
    "overdueCount" bigint NOT NULL,
    "orgComplianceRate" double precision NOT NULL,
    "totalCertificates" bigint NOT NULL,
    "certsExpiring30d" bigint NOT NULL,
    "certsExpiring60d" bigint NOT NULL,
    "openAssignments" bigint NOT NULL,
    "scheduledJobLogId" bigint
);

--
-- Class ApprovalWorkflow as table approval_workflow
--
CREATE TABLE "approval_workflow" (
    "id" bigserial PRIMARY KEY,
    "documentVersionId" bigint NOT NULL,
    "step" bigint NOT NULL,
    "approverId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "signedAt" timestamp without time zone,
    "esignatureId" bigint
);

--
-- Class Assessment as table assessment
--
CREATE TABLE "assessment" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "questionBankId" bigint NOT NULL,
    "passingScore" bigint NOT NULL,
    "randomize" boolean NOT NULL DEFAULT true,
    "timeLimitMinutes" bigint,
    "maxAttempts" bigint,
    "questionsToDisplay" bigint
);

--
-- Class AssessmentAttempt as table assessment_attempt
--
CREATE TABLE "assessment_attempt" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "assessmentId" bigint NOT NULL,
    "enrollmentId" bigint,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone,
    "score" bigint
);

--
-- Class AssessmentResult as table assessment_result
--
CREATE TABLE "assessment_result" (
    "id" bigserial PRIMARY KEY,
    "attemptId" bigint NOT NULL,
    "questionId" bigint NOT NULL,
    "answer" text NOT NULL,
    "correct" boolean NOT NULL,
    "points" bigint
);

--
-- Class AuditIntegrityResult as table audit_integrity_result
--
CREATE TABLE "audit_integrity_result" (
    "id" bigserial PRIMARY KEY,
    "checkedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "recordsChecked" bigint NOT NULL,
    "hashMismatches" bigint NOT NULL,
    "sequenceGaps" bigint NOT NULL,
    "result" text NOT NULL,
    "failureDetailsJson" text,
    "scheduledJobLogId" bigint
);

--
-- Class AuditTrail as table audit_trail
--
CREATE TABLE "audit_trail" (
    "id" bigserial PRIMARY KEY,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "action" text NOT NULL,
    "oldValueJson" text,
    "newValueJson" text,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" bigint,
    "reason" text,
    "ipAddress" text,
    "rowHash" text
);

--
-- Class AuditorPageLog as table auditor_page_log
--
CREATE TABLE "auditor_page_log" (
    "id" bigserial PRIMARY KEY,
    "auditorSessionId" bigint NOT NULL,
    "pageUrl" text NOT NULL,
    "pageTitle" text,
    "entityType" text,
    "entityId" text,
    "viewedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "timeOnPageSeconds" bigint,
    "exported" boolean NOT NULL DEFAULT false
);

--
-- Class AuditorSession as table auditor_session
--
CREATE TABLE "auditor_session" (
    "id" bigserial PRIMARY KEY,
    "inspectionRecordId" bigint NOT NULL,
    "auditorUserId" bigint,
    "accessType" text NOT NULL,
    "accessToken" text,
    "tokenIssuedAt" timestamp without time zone,
    "tokenExpiresAt" timestamp without time zone,
    "scopeStartDate" timestamp without time zone,
    "scopeEndDate" timestamp without time zone,
    "scopeSitesJson" text,
    "scopeDepartmentsJson" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "endedAt" timestamp without time zone,
    "endedReason" text,
    "pagesViewedCount" bigint NOT NULL DEFAULT 0,
    "lastActivityAt" timestamp without time zone
);

--
-- Class Capa as table capa
--
CREATE TABLE "capa" (
    "id" bigserial PRIMARY KEY,
    "qualityEventId" bigint NOT NULL,
    "description" text,
    "rootCause" text,
    "trainingRequired" boolean NOT NULL DEFAULT false,
    "trainingAssignmentId" bigint,
    "status" text NOT NULL DEFAULT 'Initiation'::text,
    "rcaCompletedAt" timestamp without time zone,
    "effectivenessCheckDue" timestamp without time zone,
    "closedAt" timestamp without time zone,
    "closedById" bigint
);

--
-- Class Certificate as table certificate
--
CREATE TABLE "certificate" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "trainingRecordId" bigint NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "qrCode" text,
    "esignatureId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text
);

--
-- Class ChangeControl as table change_control
--
CREATE TABLE "change_control" (
    "id" bigserial PRIMARY KEY,
    "qualityEventId" bigint NOT NULL,
    "documentVersionId" bigint NOT NULL,
    "trainingTriggerId" bigint
);

--
-- Class Competency as table competency
--
CREATE TABLE "competency" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "level" bigint
);

--
-- Class Course as table course
--
CREATE TABLE "course" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "sopNumber" text,
    "description" text,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "createdById" bigint,
    "organizationId" bigint NOT NULL,
    "customMetadataJson" text
);

--
-- Class CourseCompetency as table course_competency
--
CREATE TABLE "course_competency" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "competencyId" bigint NOT NULL
);

--
-- Class CourseReview as table course_review
--
CREATE TABLE "course_review" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "reviewerId" bigint NOT NULL,
    "reviewType" text NOT NULL DEFAULT 'initial'::text,
    "decision" text NOT NULL,
    "comments" text,
    "reviewChecklistJson" text,
    "reviewedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "esignatureId" bigint
);

--
-- Class CourseSopLink as table course_sop_link
--
CREATE TABLE "course_sop_link" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "documentId" bigint NOT NULL,
    "linkedById" bigint NOT NULL,
    "linkedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "unlinkedAt" timestamp without time zone
);

--
-- Class CourseVersion as table course_version
--
CREATE TABLE "course_version" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "version" text NOT NULL,
    "effectiveDate" timestamp without time zone,
    "obsoleteDate" timestamp without time zone,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "supersededByVersionId" bigint,
    "changeSummary" text
);

--
-- Class Curriculum as table curriculum
--
CREATE TABLE "curriculum" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "description" text
);

--
-- Class CurriculumCourse as table curriculum_course
--
CREATE TABLE "curriculum_course" (
    "id" bigserial PRIMARY KEY,
    "curriculumId" bigint NOT NULL,
    "courseId" bigint NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0
);

--
-- Class Dashboard as table dashboard
--
CREATE TABLE "dashboard" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "widgetsJson" text NOT NULL,
    "roleId" bigint
);

--
-- Class DeadLetterQueue as table dead_letter_queue
--
CREATE TABLE "dead_letter_queue" (
    "id" bigserial PRIMARY KEY,
    "outboxMessageId" bigint,
    "failedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "failureReason" text,
    "retryCount" bigint NOT NULL DEFAULT 0,
    "manuallyResolved" boolean NOT NULL DEFAULT false,
    "resolvedById" bigint,
    "resolvedAt" timestamp without time zone,
    "resolutionNotes" text
);

--
-- Class DelegatedAuthority as table delegated_authority
--
CREATE TABLE "delegated_authority" (
    "id" bigserial PRIMARY KEY,
    "delegatorId" bigint NOT NULL,
    "delegateeId" bigint NOT NULL,
    "scope" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

--
-- Class Department as table department
--
CREATE TABLE "department" (
    "id" bigserial PRIMARY KEY,
    "siteId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL
);

--
-- Class DepartmentComplianceSnapshot as table department_compliance_snapshot
--
CREATE TABLE "department_compliance_snapshot" (
    "id" bigserial PRIMARY KEY,
    "departmentId" bigint NOT NULL,
    "snapshotDate" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "totalEmployees" bigint NOT NULL,
    "compliantCount" bigint NOT NULL,
    "overdueCount" bigint NOT NULL,
    "upcomingCount" bigint NOT NULL,
    "complianceRate" double precision NOT NULL,
    "scheduledJobLogId" bigint
);

--
-- Class Document as table document
--
CREATE TABLE "document" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "documentNumber" text NOT NULL,
    "documentType" text NOT NULL,
    "organizationId" bigint NOT NULL,
    "affectedDepartmentIdsJson" text,
    "affectedRoleIdsJson" text,
    "trainingRequiredByQa" text
);

--
-- Class DocumentLifecycle as table document_lifecycle
--
CREATE TABLE "document_lifecycle" (
    "id" bigserial PRIMARY KEY,
    "documentVersionId" bigint NOT NULL,
    "state" text NOT NULL,
    "changedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "changedById" bigint NOT NULL
);

--
-- Class DocumentVersion as table document_version
--
CREATE TABLE "document_version" (
    "id" bigserial PRIMARY KEY,
    "documentId" bigint NOT NULL,
    "version" text NOT NULL,
    "versionMajor" bigint,
    "versionMinor" bigint,
    "isMajorVersion" boolean,
    "storageKey" text NOT NULL,
    "effectiveDate" timestamp without time zone,
    "obsoleteDate" timestamp without time zone
);

--
-- Class DomainEvent as table domain_event
--
CREATE TABLE "domain_event" (
    "id" bigserial PRIMARY KEY,
    "eventType" text NOT NULL,
    "aggregateId" text NOT NULL,
    "payloadJson" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" timestamp without time zone,
    "kafkaOffset" text
);

--
-- Class ElectronicSignature as table electronic_signature
--
CREATE TABLE "electronic_signature" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "signatureMeaning" text NOT NULL,
    "passwordPlaintext" text,
    "passwordReauthHash" text,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "ipAddress" text,
    "integrityHash" text,
    "isValid" boolean NOT NULL DEFAULT true,
    "revokedReason" text,
    "revokedBySignatureId" bigint
);

--
-- Class Enrollment as table enrollment
--
CREATE TABLE "enrollment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "assignmentId" bigint,
    "status" text NOT NULL DEFAULT 'not_started'::text,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "retrainingChangeSummary" text,
    "acknowledgedAt" timestamp without time zone,
    "acknowledgementEsignatureId" bigint
);

--
-- Class ErrorLog as table error_log
--
CREATE TABLE "error_log" (
    "id" bigserial PRIMARY KEY,
    "message" text NOT NULL,
    "stackTrace" text,
    "contextJson" text,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class Facility as table facility
--
CREATE TABLE "facility" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "maxCapacity" bigint NOT NULL DEFAULT 10,
    "isValidatedSpace" boolean DEFAULT false
);

--
-- Class FeatureFlag as table feature_flag
--
CREATE TABLE "feature_flag" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "enabled" boolean NOT NULL DEFAULT false,
    "organizationId" bigint
);

--
-- Class ImportLog as table import_log
--
CREATE TABLE "import_log" (
    "id" bigserial PRIMARY KEY,
    "importedById" bigint NOT NULL,
    "importType" text NOT NULL,
    "filename" text,
    "recordCount" bigint,
    "successCount" bigint,
    "failureCount" bigint,
    "failureDetailsJson" text,
    "importedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class InspectionPackage as table inspection_package
--
CREATE TABLE "inspection_package" (
    "id" bigserial PRIMARY KEY,
    "inspectionRecordId" bigint NOT NULL,
    "generatedById" bigint NOT NULL,
    "generatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "scopeDescription" text,
    "includedRecordsCount" bigint,
    "fileHash" text,
    "storageUrl" text,
    "watermarkText" text,
    "isOfficial" boolean NOT NULL DEFAULT false,
    "officialEsignatureId" bigint
);

--
-- Class InspectionRecord as table inspection_record
--
CREATE TABLE "inspection_record" (
    "id" bigserial PRIMARY KEY,
    "inspectionType" text NOT NULL,
    "scheduledDate" timestamp without time zone,
    "inspectorNames" text,
    "scopeDescription" text,
    "siteId" bigint,
    "status" text NOT NULL DEFAULT 'scheduled'::text,
    "inspectionAccessToken" text,
    "tokenExpiresAt" timestamp without time zone,
    "briefingPackHash" text,
    "briefingPackGeneratedAt" timestamp without time zone,
    "outcome" text,
    "findingsCount" bigint,
    "createdById" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class InspectionReport as table inspection_report
--
CREATE TABLE "inspection_report" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "siteId" bigint,
    "inspector" text,
    "inspectionDate" timestamp without time zone,
    "findingsJson" text,
    "status" text NOT NULL
);

--
-- Class JobRole as table job_role
--
CREATE TABLE "job_role" (
    "id" bigserial PRIMARY KEY,
    "departmentId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "trainingMatrixJson" text
);

--
-- Class Lesson as table lesson
--
CREATE TABLE "lesson" (
    "id" bigserial PRIMARY KEY,
    "moduleId" bigint NOT NULL,
    "title" text NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0,
    "materialId" bigint NOT NULL,
    "durationMinutes" bigint
);

--
-- Class Material as table material
--
CREATE TABLE "material" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "materialType" text NOT NULL,
    "storageKey" text,
    "organizationId" bigint NOT NULL
);

--
-- Class MaterialProgress as table material_progress
--
CREATE TABLE "material_progress" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "materialId" bigint NOT NULL,
    "progressPct" bigint NOT NULL DEFAULT 0,
    "completedAt" timestamp without time zone,
    "interactionJson" text,
    "materialVersionId" bigint,
    "enrollmentId" bigint,
    "timeSpentSeconds" bigint,
    "lastHeartbeat" timestamp without time zone,
    "readTimeMet" boolean
);

--
-- Class MaterialVersion as table material_version
--
CREATE TABLE "material_version" (
    "id" bigserial PRIMARY KEY,
    "materialId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "storageKey" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fileHash" text,
    "virusScanStatus" text DEFAULT 'pending'::text,
    "virusScanAt" timestamp without time zone,
    "fileSizeBytes" bigint
);

--
-- Class MediaAsset as table media_asset
--
CREATE TABLE "media_asset" (
    "id" bigserial PRIMARY KEY,
    "materialId" bigint NOT NULL,
    "assetType" text NOT NULL,
    "url" text NOT NULL,
    "durationSeconds" bigint
);

--
-- Class MfaVerifiedSession as table mfa_verified_session
--
CREATE TABLE "mfa_verified_session" (
    "id" bigserial PRIMARY KEY,
    "authUserId" text NOT NULL,
    "sessionId" text NOT NULL,
    "verifiedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class Module as table module
--
CREATE TABLE "module" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "title" text NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0
);

--
-- Class Notification as table notification
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "body" text,
    "enrollmentId" bigint,
    "sentAt" timestamp without time zone,
    "deliveryStatus" text,
    "readAt" timestamp without time zone,
    "channel" text NOT NULL DEFAULT 'in_app'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class NotificationLog as table notification_log
--
CREATE TABLE "notification_log" (
    "id" bigserial PRIMARY KEY,
    "notificationId" bigint NOT NULL,
    "attemptedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "channel" text NOT NULL,
    "status" text NOT NULL DEFAULT 'sent'::text,
    "errorMessage" text,
    "retryCount" bigint NOT NULL DEFAULT 0,
    "externalMessageId" text
);

--
-- Class NotificationTemplate as table notification_template
--
CREATE TABLE "notification_template" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "channel" text NOT NULL DEFAULT 'email'::text,
    "triggerEvent" text,
    "subject" text,
    "bodyTemplate" text NOT NULL,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "createdById" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone
);

--
-- Class OidcAccount as table oidc_account
--
CREATE TABLE "oidc_account" (
    "id" bigserial PRIMARY KEY,
    "authUserId" text NOT NULL,
    "providerId" text NOT NULL,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "oidc_account_provider_id" ON "oidc_account" USING btree ("providerId");

--
-- Class Organization as table organization
--
CREATE TABLE "organization" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class OutboxMessage as table outbox_message
--
CREATE TABLE "outbox_message" (
    "id" bigserial PRIMARY KEY,
    "topic" text NOT NULL,
    "payloadJson" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sentAt" timestamp without time zone,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "retryCount" bigint NOT NULL DEFAULT 0,
    "lastError" text
);

--
-- Class Permission as table permission
--
CREATE TABLE "permission" (
    "id" bigserial PRIMARY KEY,
    "roleId" bigint NOT NULL,
    "resource" text NOT NULL,
    "action" text NOT NULL
);

--
-- Class PharmaUser as table pharma_user
--
CREATE TABLE "pharma_user" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "departmentId" bigint NOT NULL,
    "jobRoleId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "organizationId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" bigint,
    "employeeId" text,
    "hireDate" timestamp without time zone,
    "managerId" bigint,
    "preferredLanguage" text,
    "timezone" text DEFAULT 'UTC'::text,
    "lastLogin" timestamp without time zone,
    "authType" text,
    "mfaEnabled" boolean DEFAULT false,
    "compliancePercent" double precision DEFAULT 0.0,
    "roles" json,
    "customMetadataJson" text,
    "biometricCredentialId" text
);

--
-- Class QualityEvent as table quality_event
--
CREATE TABLE "quality_event" (
    "id" bigserial PRIMARY KEY,
    "eventType" text NOT NULL,
    "referenceId" text,
    "title" text NOT NULL,
    "status" text NOT NULL,
    "siteId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class Question as table question
--
CREATE TABLE "question" (
    "id" bigserial PRIMARY KEY,
    "questionBankId" bigint NOT NULL,
    "text" text NOT NULL,
    "questionType" text NOT NULL,
    "optionsJson" text NOT NULL,
    "correctAnswer" text NOT NULL,
    "difficulty" text,
    "regulatoryTag" text
);

--
-- Class QuestionBank as table question_bank
--
CREATE TABLE "question_bank" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "organizationId" bigint NOT NULL,
    "tagsJson" text
);

--
-- Class ReportDefinition as table report_definition
--
CREATE TABLE "report_definition" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "reportType" text NOT NULL,
    "querySql" text,
    "paramsJson" text
);

--
-- Class ReportExport as table report_export
--
CREATE TABLE "report_export" (
    "id" bigserial PRIMARY KEY,
    "exportedById" bigint NOT NULL,
    "reportType" text NOT NULL,
    "filterParamsJson" text,
    "recordCount" bigint,
    "fileHash" text,
    "storageUrl" text,
    "watermarkText" text,
    "exportedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone
);

--
-- Class RetentionArchive as table retention_archive
--
CREATE TABLE "retention_archive" (
    "id" bigserial PRIMARY KEY,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "rowJson" text NOT NULL,
    "archivedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class RetentionPolicy as table retention_policy
--
CREATE TABLE "retention_policy" (
    "id" bigserial PRIMARY KEY,
    "entityType" text NOT NULL,
    "retentionYears" bigint NOT NULL DEFAULT 7,
    "archiveEnabled" boolean NOT NULL DEFAULT true,
    "lastArchivedAt" timestamp without time zone
);

--
-- Class Role as table role
--
CREATE TABLE "role" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL
);

--
-- Class RoleHistory as table role_history
--
CREATE TABLE "role_history" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL,
    "action" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "performedById" bigint,
    "reason" text,
    "grantRecordId" bigint,
    "ipAddress" text,
    "hmacHash" text,
    "migrationMarker" text
);

--
-- Class ScheduledJobLog as table scheduled_job_log
--
CREATE TABLE "scheduled_job_log" (
    "id" bigserial PRIMARY KEY,
    "jobName" text NOT NULL,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone,
    "status" text NOT NULL DEFAULT 'running'::text,
    "recordsProcessed" bigint,
    "recordsAffected" bigint,
    "errorDetails" text
);

--
-- Class SignatureMeaning as table signature_meaning
--
CREATE TABLE "signature_meaning" (
    "id" bigserial PRIMARY KEY,
    "meaning" text NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "orderIndex" bigint NOT NULL DEFAULT 0,
    "applicableTo" text
);

--
-- Class SimulationAttempt as table simulation_attempt
--
CREATE TABLE "simulation_attempt" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "scenarioTitle" text NOT NULL,
    "scorePercent" double precision,
    "metricsJson" text,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone
);

--
-- Class Site as table site
--
CREATE TABLE "site" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "timezone" text NOT NULL DEFAULT 'UTC'::text
);

--
-- Class SlaBreach as table sla_breach
--
CREATE TABLE "sla_breach" (
    "id" bigserial PRIMARY KEY,
    "slaPolicyId" bigint NOT NULL,
    "breachedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" timestamp without time zone
);

--
-- Class SlaPolicy as table sla_policy
--
CREATE TABLE "sla_policy" (
    "id" bigserial PRIMARY KEY,
    "metric" text NOT NULL,
    "threshold" double precision NOT NULL,
    "alertRoleId" bigint NOT NULL
);

--
-- Class SmeAssignment as table sme_assignment
--
CREATE TABLE "sme_assignment" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "courseVersionId" bigint,
    "smeUserId" bigint NOT NULL,
    "invitedById" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'invited'::text,
    "invitedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "sme_assignment_course_sme_unique_idx" ON "sme_assignment" USING btree ("courseId", "smeUserId");

--
-- Class SmeReviewComment as table sme_review_comment
--
CREATE TABLE "sme_review_comment" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "sectionRef" text NOT NULL,
    "severity" text NOT NULL DEFAULT 'note'::text,
    "body" text NOT NULL,
    "resolved" boolean NOT NULL DEFAULT false,
    "trainerResponse" text,
    "resolvedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class SystemConfiguration as table system_configuration
--
CREATE TABLE "system_configuration" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" text NOT NULL,
    "organizationId" bigint
);

--
-- Class TrainingAssignment as table training_assignment
--
CREATE TABLE "training_assignment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "assignedById" bigint NOT NULL,
    "assignedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dueDate" timestamp without time zone NOT NULL,
    "priority" text NOT NULL DEFAULT 'medium'::text,
    "reason" text,
    "source" text NOT NULL DEFAULT 'manual'::text,
    "assignmentType" text NOT NULL DEFAULT 'individual'::text,
    "targetRoleId" bigint,
    "targetDepartmentId" bigint,
    "targetUserId" bigint,
    "status" text NOT NULL DEFAULT 'active'::text,
    "cancelledAt" timestamp without time zone,
    "cancelledById" bigint,
    "cancellationReason" text
);

--
-- Class TrainingBatch as table training_batch
--
CREATE TABLE "training_batch" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "name" text NOT NULL,
    "instructorId" bigint NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "capacity" bigint NOT NULL DEFAULT 30,
    "enrolledCount" bigint NOT NULL DEFAULT 0,
    "completedCount" bigint NOT NULL DEFAULT 0,
    "status" text NOT NULL DEFAULT 'scheduled'::text,
    "location" text,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "facilityId" bigint
);

--
-- Class TrainingBatchParticipant as table training_batch_participant
--
CREATE TABLE "training_batch_participant" (
    "id" bigserial PRIMARY KEY,
    "batchId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "enrolledAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "role" text
);

-- Indexes
CREATE UNIQUE INDEX "batch_user_unique_idx" ON "training_batch_participant" USING btree ("batchId", "userId");

--
-- Class TrainingExpiration as table training_expiration
--
CREATE TABLE "training_expiration" (
    "id" bigserial PRIMARY KEY,
    "certificateId" bigint NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "reminderSentAt" timestamp without time zone,
    "renewalAssignmentId" bigint,
    "expiryStage" text
);

--
-- Class TrainingMatrix as table training_matrix
--
CREATE TABLE "training_matrix" (
    "id" bigserial PRIMARY KEY,
    "jobRoleId" bigint NOT NULL,
    "courseId" bigint NOT NULL,
    "siteId" bigint,
    "isMandatory" boolean NOT NULL DEFAULT true,
    "dueDaysFromHire" bigint NOT NULL DEFAULT 60,
    "retrainingIntervalDays" bigint,
    "createdById" bigint,
    "approvedById" bigint,
    "effectiveDate" timestamp without time zone
);

--
-- Class TrainingRecord as table training_record
--
CREATE TABLE "training_record" (
    "id" bigserial PRIMARY KEY,
    "enrollmentId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "completedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "score" bigint,
    "esignatureId" bigint NOT NULL
);

--
-- Class TrainingRecordAnnotation as table training_record_annotation
--
CREATE TABLE "training_record_annotation" (
    "id" bigserial PRIMARY KEY,
    "trainingRecordId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "note" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class TrainingWaiver as table training_waiver
--
CREATE TABLE "training_waiver" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseId" bigint NOT NULL,
    "requestedById" bigint NOT NULL,
    "requestedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestReason" text NOT NULL,
    "evidenceStoragePath" text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "approvedById" bigint,
    "approvedAt" timestamp without time zone,
    "rejectionReason" text,
    "expiresAt" timestamp without time zone
);

--
-- Class UserCompetency as table user_competency
--
CREATE TABLE "user_competency" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "competencyId" bigint NOT NULL,
    "achievedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone
);

--
-- Class UserMfa as table user_mfa
--
CREATE TABLE "user_mfa" (
    "id" bigserial PRIMARY KEY,
    "authUserId" text NOT NULL,
    "mfaSecretBase32" text NOT NULL,
    "mfaEnabled" boolean NOT NULL DEFAULT false,
    "enrolledAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

--
-- Class UserPreference as table user_preference
--
CREATE TABLE "user_preference" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "preferenceKey" text NOT NULL,
    "preferenceValue" text NOT NULL
);

--
-- Class UserRole as table user_role
--
CREATE TABLE "user_role" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL
);

--
-- Class UserSession as table user_session
--
CREATE TABLE "user_session" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endedAt" timestamp without time zone,
    "ipAddress" text,
    "userAgent" text,
    "deviceFingerprint" text,
    "endReason" text,
    "isMfaVerified" boolean NOT NULL DEFAULT false
);

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "nonce", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "access_log" table
--
ALTER TABLE ONLY "access_log"
    ADD CONSTRAINT "access_log_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "access_review" table
--
ALTER TABLE ONLY "access_review"
    ADD CONSTRAINT "access_review_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "access_review"
    ADD CONSTRAINT "access_review_fk_1"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "access_review"
    ADD CONSTRAINT "access_review_fk_2"
    FOREIGN KEY("reviewedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "access_review"
    ADD CONSTRAINT "access_review_fk_3"
    FOREIGN KEY("signatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "analytics_snapshot" table
--
ALTER TABLE ONLY "analytics_snapshot"
    ADD CONSTRAINT "analytics_snapshot_fk_0"
    FOREIGN KEY("scheduledJobLogId")
    REFERENCES "scheduled_job_log"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "approval_workflow" table
--
ALTER TABLE ONLY "approval_workflow"
    ADD CONSTRAINT "approval_workflow_fk_0"
    FOREIGN KEY("documentVersionId")
    REFERENCES "document_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "approval_workflow"
    ADD CONSTRAINT "approval_workflow_fk_1"
    FOREIGN KEY("approverId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "approval_workflow"
    ADD CONSTRAINT "approval_workflow_fk_2"
    FOREIGN KEY("esignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "assessment" table
--
ALTER TABLE ONLY "assessment"
    ADD CONSTRAINT "assessment_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "assessment"
    ADD CONSTRAINT "assessment_fk_1"
    FOREIGN KEY("questionBankId")
    REFERENCES "question_bank"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "assessment_attempt" table
--
ALTER TABLE ONLY "assessment_attempt"
    ADD CONSTRAINT "assessment_attempt_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "assessment_attempt"
    ADD CONSTRAINT "assessment_attempt_fk_1"
    FOREIGN KEY("assessmentId")
    REFERENCES "assessment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "assessment_attempt"
    ADD CONSTRAINT "assessment_attempt_fk_2"
    FOREIGN KEY("enrollmentId")
    REFERENCES "enrollment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "assessment_result" table
--
ALTER TABLE ONLY "assessment_result"
    ADD CONSTRAINT "assessment_result_fk_0"
    FOREIGN KEY("attemptId")
    REFERENCES "assessment_attempt"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "assessment_result"
    ADD CONSTRAINT "assessment_result_fk_1"
    FOREIGN KEY("questionId")
    REFERENCES "question"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "audit_integrity_result" table
--
ALTER TABLE ONLY "audit_integrity_result"
    ADD CONSTRAINT "audit_integrity_result_fk_0"
    FOREIGN KEY("scheduledJobLogId")
    REFERENCES "scheduled_job_log"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "audit_trail" table
--
ALTER TABLE ONLY "audit_trail"
    ADD CONSTRAINT "audit_trail_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "auditor_page_log" table
--
ALTER TABLE ONLY "auditor_page_log"
    ADD CONSTRAINT "auditor_page_log_fk_0"
    FOREIGN KEY("auditorSessionId")
    REFERENCES "auditor_session"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "auditor_session" table
--
ALTER TABLE ONLY "auditor_session"
    ADD CONSTRAINT "auditor_session_fk_0"
    FOREIGN KEY("inspectionRecordId")
    REFERENCES "inspection_record"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "auditor_session"
    ADD CONSTRAINT "auditor_session_fk_1"
    FOREIGN KEY("auditorUserId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "capa" table
--
ALTER TABLE ONLY "capa"
    ADD CONSTRAINT "capa_fk_0"
    FOREIGN KEY("qualityEventId")
    REFERENCES "quality_event"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "capa"
    ADD CONSTRAINT "capa_fk_1"
    FOREIGN KEY("trainingAssignmentId")
    REFERENCES "training_assignment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "certificate" table
--
ALTER TABLE ONLY "certificate"
    ADD CONSTRAINT "certificate_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "certificate"
    ADD CONSTRAINT "certificate_fk_1"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "certificate"
    ADD CONSTRAINT "certificate_fk_2"
    FOREIGN KEY("trainingRecordId")
    REFERENCES "training_record"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "certificate"
    ADD CONSTRAINT "certificate_fk_3"
    FOREIGN KEY("esignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "change_control" table
--
ALTER TABLE ONLY "change_control"
    ADD CONSTRAINT "change_control_fk_0"
    FOREIGN KEY("qualityEventId")
    REFERENCES "quality_event"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "change_control"
    ADD CONSTRAINT "change_control_fk_1"
    FOREIGN KEY("documentVersionId")
    REFERENCES "document_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "course" table
--
ALTER TABLE ONLY "course"
    ADD CONSTRAINT "course_fk_0"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course"
    ADD CONSTRAINT "course_fk_1"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "course_competency" table
--
ALTER TABLE ONLY "course_competency"
    ADD CONSTRAINT "course_competency_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_competency"
    ADD CONSTRAINT "course_competency_fk_1"
    FOREIGN KEY("competencyId")
    REFERENCES "competency"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "course_review" table
--
ALTER TABLE ONLY "course_review"
    ADD CONSTRAINT "course_review_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_review"
    ADD CONSTRAINT "course_review_fk_1"
    FOREIGN KEY("reviewerId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_review"
    ADD CONSTRAINT "course_review_fk_2"
    FOREIGN KEY("esignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "course_sop_link" table
--
ALTER TABLE ONLY "course_sop_link"
    ADD CONSTRAINT "course_sop_link_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_sop_link"
    ADD CONSTRAINT "course_sop_link_fk_1"
    FOREIGN KEY("documentId")
    REFERENCES "document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_sop_link"
    ADD CONSTRAINT "course_sop_link_fk_2"
    FOREIGN KEY("linkedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "course_version" table
--
ALTER TABLE ONLY "course_version"
    ADD CONSTRAINT "course_version_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "curriculum" table
--
ALTER TABLE ONLY "curriculum"
    ADD CONSTRAINT "curriculum_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "curriculum_course" table
--
ALTER TABLE ONLY "curriculum_course"
    ADD CONSTRAINT "curriculum_course_fk_0"
    FOREIGN KEY("curriculumId")
    REFERENCES "curriculum"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "curriculum_course"
    ADD CONSTRAINT "curriculum_course_fk_1"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "dashboard" table
--
ALTER TABLE ONLY "dashboard"
    ADD CONSTRAINT "dashboard_fk_0"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "delegated_authority" table
--
ALTER TABLE ONLY "delegated_authority"
    ADD CONSTRAINT "delegated_authority_fk_0"
    FOREIGN KEY("delegatorId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "delegated_authority"
    ADD CONSTRAINT "delegated_authority_fk_1"
    FOREIGN KEY("delegateeId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "department" table
--
ALTER TABLE ONLY "department"
    ADD CONSTRAINT "department_fk_0"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "department_compliance_snapshot" table
--
ALTER TABLE ONLY "department_compliance_snapshot"
    ADD CONSTRAINT "department_compliance_snapshot_fk_0"
    FOREIGN KEY("departmentId")
    REFERENCES "department"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "department_compliance_snapshot"
    ADD CONSTRAINT "department_compliance_snapshot_fk_1"
    FOREIGN KEY("scheduledJobLogId")
    REFERENCES "scheduled_job_log"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "document" table
--
ALTER TABLE ONLY "document"
    ADD CONSTRAINT "document_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "document_lifecycle" table
--
ALTER TABLE ONLY "document_lifecycle"
    ADD CONSTRAINT "document_lifecycle_fk_0"
    FOREIGN KEY("documentVersionId")
    REFERENCES "document_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "document_lifecycle"
    ADD CONSTRAINT "document_lifecycle_fk_1"
    FOREIGN KEY("changedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "document_version" table
--
ALTER TABLE ONLY "document_version"
    ADD CONSTRAINT "document_version_fk_0"
    FOREIGN KEY("documentId")
    REFERENCES "document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "electronic_signature" table
--
ALTER TABLE ONLY "electronic_signature"
    ADD CONSTRAINT "electronic_signature_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "enrollment" table
--
ALTER TABLE ONLY "enrollment"
    ADD CONSTRAINT "enrollment_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "enrollment"
    ADD CONSTRAINT "enrollment_fk_1"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "enrollment"
    ADD CONSTRAINT "enrollment_fk_2"
    FOREIGN KEY("assignmentId")
    REFERENCES "training_assignment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "enrollment"
    ADD CONSTRAINT "enrollment_fk_3"
    FOREIGN KEY("acknowledgementEsignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "facility" table
--
ALTER TABLE ONLY "facility"
    ADD CONSTRAINT "facility_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_flag" table
--
ALTER TABLE ONLY "feature_flag"
    ADD CONSTRAINT "feature_flag_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "import_log" table
--
ALTER TABLE ONLY "import_log"
    ADD CONSTRAINT "import_log_fk_0"
    FOREIGN KEY("importedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "inspection_package" table
--
ALTER TABLE ONLY "inspection_package"
    ADD CONSTRAINT "inspection_package_fk_0"
    FOREIGN KEY("inspectionRecordId")
    REFERENCES "inspection_record"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "inspection_package"
    ADD CONSTRAINT "inspection_package_fk_1"
    FOREIGN KEY("generatedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "inspection_package"
    ADD CONSTRAINT "inspection_package_fk_2"
    FOREIGN KEY("officialEsignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "inspection_record" table
--
ALTER TABLE ONLY "inspection_record"
    ADD CONSTRAINT "inspection_record_fk_0"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "inspection_record"
    ADD CONSTRAINT "inspection_record_fk_1"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "inspection_report" table
--
ALTER TABLE ONLY "inspection_report"
    ADD CONSTRAINT "inspection_report_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "inspection_report"
    ADD CONSTRAINT "inspection_report_fk_1"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "job_role" table
--
ALTER TABLE ONLY "job_role"
    ADD CONSTRAINT "job_role_fk_0"
    FOREIGN KEY("departmentId")
    REFERENCES "department"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "lesson" table
--
ALTER TABLE ONLY "lesson"
    ADD CONSTRAINT "lesson_fk_0"
    FOREIGN KEY("moduleId")
    REFERENCES "module"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "lesson"
    ADD CONSTRAINT "lesson_fk_1"
    FOREIGN KEY("materialId")
    REFERENCES "material"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "material" table
--
ALTER TABLE ONLY "material"
    ADD CONSTRAINT "material_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "material_progress" table
--
ALTER TABLE ONLY "material_progress"
    ADD CONSTRAINT "material_progress_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "material_progress"
    ADD CONSTRAINT "material_progress_fk_1"
    FOREIGN KEY("materialId")
    REFERENCES "material"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "material_version" table
--
ALTER TABLE ONLY "material_version"
    ADD CONSTRAINT "material_version_fk_0"
    FOREIGN KEY("materialId")
    REFERENCES "material"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "media_asset" table
--
ALTER TABLE ONLY "media_asset"
    ADD CONSTRAINT "media_asset_fk_0"
    FOREIGN KEY("materialId")
    REFERENCES "material"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "module" table
--
ALTER TABLE ONLY "module"
    ADD CONSTRAINT "module_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "notification" table
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_1"
    FOREIGN KEY("enrollmentId")
    REFERENCES "enrollment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "notification_log" table
--
ALTER TABLE ONLY "notification_log"
    ADD CONSTRAINT "notification_log_fk_0"
    FOREIGN KEY("notificationId")
    REFERENCES "notification"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "notification_template" table
--
ALTER TABLE ONLY "notification_template"
    ADD CONSTRAINT "notification_template_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "notification_template"
    ADD CONSTRAINT "notification_template_fk_1"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "permission" table
--
ALTER TABLE ONLY "permission"
    ADD CONSTRAINT "permission_fk_0"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "pharma_user" table
--
ALTER TABLE ONLY "pharma_user"
    ADD CONSTRAINT "pharma_user_fk_0"
    FOREIGN KEY("departmentId")
    REFERENCES "department"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pharma_user"
    ADD CONSTRAINT "pharma_user_fk_1"
    FOREIGN KEY("jobRoleId")
    REFERENCES "job_role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pharma_user"
    ADD CONSTRAINT "pharma_user_fk_2"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "pharma_user"
    ADD CONSTRAINT "pharma_user_fk_3"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "quality_event" table
--
ALTER TABLE ONLY "quality_event"
    ADD CONSTRAINT "quality_event_fk_0"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "question" table
--
ALTER TABLE ONLY "question"
    ADD CONSTRAINT "question_fk_0"
    FOREIGN KEY("questionBankId")
    REFERENCES "question_bank"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "question_bank" table
--
ALTER TABLE ONLY "question_bank"
    ADD CONSTRAINT "question_bank_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "report_export" table
--
ALTER TABLE ONLY "report_export"
    ADD CONSTRAINT "report_export_fk_0"
    FOREIGN KEY("exportedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "role_history" table
--
ALTER TABLE ONLY "role_history"
    ADD CONSTRAINT "role_history_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "role_history"
    ADD CONSTRAINT "role_history_fk_1"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "role_history"
    ADD CONSTRAINT "role_history_fk_2"
    FOREIGN KEY("performedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "simulation_attempt" table
--
ALTER TABLE ONLY "simulation_attempt"
    ADD CONSTRAINT "simulation_attempt_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "site" table
--
ALTER TABLE ONLY "site"
    ADD CONSTRAINT "site_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "sla_breach" table
--
ALTER TABLE ONLY "sla_breach"
    ADD CONSTRAINT "sla_breach_fk_0"
    FOREIGN KEY("slaPolicyId")
    REFERENCES "sla_policy"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "sla_policy" table
--
ALTER TABLE ONLY "sla_policy"
    ADD CONSTRAINT "sla_policy_fk_0"
    FOREIGN KEY("alertRoleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "sme_assignment" table
--
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_1"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_2"
    FOREIGN KEY("smeUserId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_3"
    FOREIGN KEY("invitedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "sme_review_comment" table
--
ALTER TABLE ONLY "sme_review_comment"
    ADD CONSTRAINT "sme_review_comment_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_review_comment"
    ADD CONSTRAINT "sme_review_comment_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "system_configuration" table
--
ALTER TABLE ONLY "system_configuration"
    ADD CONSTRAINT "system_configuration_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_assignment" table
--
ALTER TABLE ONLY "training_assignment"
    ADD CONSTRAINT "training_assignment_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_assignment"
    ADD CONSTRAINT "training_assignment_fk_1"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_assignment"
    ADD CONSTRAINT "training_assignment_fk_2"
    FOREIGN KEY("assignedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_batch" table
--
ALTER TABLE ONLY "training_batch"
    ADD CONSTRAINT "training_batch_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_batch"
    ADD CONSTRAINT "training_batch_fk_1"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_batch"
    ADD CONSTRAINT "training_batch_fk_2"
    FOREIGN KEY("instructorId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_batch"
    ADD CONSTRAINT "training_batch_fk_3"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_batch_participant" table
--
ALTER TABLE ONLY "training_batch_participant"
    ADD CONSTRAINT "training_batch_participant_fk_0"
    FOREIGN KEY("batchId")
    REFERENCES "training_batch"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_batch_participant"
    ADD CONSTRAINT "training_batch_participant_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_expiration" table
--
ALTER TABLE ONLY "training_expiration"
    ADD CONSTRAINT "training_expiration_fk_0"
    FOREIGN KEY("certificateId")
    REFERENCES "certificate"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_expiration"
    ADD CONSTRAINT "training_expiration_fk_1"
    FOREIGN KEY("renewalAssignmentId")
    REFERENCES "training_assignment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_matrix" table
--
ALTER TABLE ONLY "training_matrix"
    ADD CONSTRAINT "training_matrix_fk_0"
    FOREIGN KEY("jobRoleId")
    REFERENCES "job_role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_matrix"
    ADD CONSTRAINT "training_matrix_fk_1"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_matrix"
    ADD CONSTRAINT "training_matrix_fk_2"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_matrix"
    ADD CONSTRAINT "training_matrix_fk_3"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_matrix"
    ADD CONSTRAINT "training_matrix_fk_4"
    FOREIGN KEY("approvedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_record" table
--
ALTER TABLE ONLY "training_record"
    ADD CONSTRAINT "training_record_fk_0"
    FOREIGN KEY("enrollmentId")
    REFERENCES "enrollment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_record"
    ADD CONSTRAINT "training_record_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_record"
    ADD CONSTRAINT "training_record_fk_2"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_record"
    ADD CONSTRAINT "training_record_fk_3"
    FOREIGN KEY("esignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_record_annotation" table
--
ALTER TABLE ONLY "training_record_annotation"
    ADD CONSTRAINT "training_record_annotation_fk_0"
    FOREIGN KEY("trainingRecordId")
    REFERENCES "training_record"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_record_annotation"
    ADD CONSTRAINT "training_record_annotation_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_waiver" table
--
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_1"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_2"
    FOREIGN KEY("requestedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_3"
    FOREIGN KEY("approvedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_competency" table
--
ALTER TABLE ONLY "user_competency"
    ADD CONSTRAINT "user_competency_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_competency"
    ADD CONSTRAINT "user_competency_fk_1"
    FOREIGN KEY("competencyId")
    REFERENCES "competency"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_preference" table
--
ALTER TABLE ONLY "user_preference"
    ADD CONSTRAINT "user_preference_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_role" table
--
ALTER TABLE ONLY "user_role"
    ADD CONSTRAINT "user_role_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_role"
    ADD CONSTRAINT "user_role_fk_1"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_session" table
--
ALTER TABLE ONLY "user_session"
    ADD CONSTRAINT "user_session_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260325134017693', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260325134017693', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260129181059877', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181059877', "timestamp" = now();


COMMIT;
