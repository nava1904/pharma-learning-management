BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "abac_policy" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "ruleJson" text NOT NULL,
    "effect" text NOT NULL
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "approval_workflow" (
    "id" bigserial PRIMARY KEY,
    "documentVersionId" bigint NOT NULL,
    "step" bigint NOT NULL,
    "approverId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "signedAt" timestamp without time zone,
    "esignatureId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "assessment" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "questionBankId" bigint NOT NULL,
    "passingScore" bigint NOT NULL,
    "randomize" boolean NOT NULL DEFAULT true,
    "timeLimitMinutes" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "assessment_attempt" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "assessmentId" bigint NOT NULL,
    "enrollmentId" bigint NOT NULL,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone,
    "score" bigint
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "ipAddress" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "capa" (
    "id" bigserial PRIMARY KEY,
    "qualityEventId" bigint NOT NULL,
    "description" text,
    "rootCause" text,
    "trainingRequired" boolean NOT NULL DEFAULT false,
    "trainingAssignmentId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "certificate" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "trainingRecordId" bigint NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "qrCode" text,
    "esignatureId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "change_control" (
    "id" bigserial PRIMARY KEY,
    "qualityEventId" bigint NOT NULL,
    "documentVersionId" bigint NOT NULL,
    "trainingTriggerId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "competency" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "level" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "sopNumber" text,
    "description" text,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "createdById" bigint NOT NULL,
    "organizationId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course_competency" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "competencyId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course_version" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "version" text NOT NULL,
    "effectiveDate" timestamp without time zone,
    "obsoleteDate" timestamp without time zone,
    "status" text NOT NULL DEFAULT 'draft'::text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dashboard" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "widgetsJson" text NOT NULL,
    "roleId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "delegated_authority" (
    "id" bigserial PRIMARY KEY,
    "delegatorId" bigint NOT NULL,
    "delegateeId" bigint NOT NULL,
    "scope" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "department" (
    "id" bigserial PRIMARY KEY,
    "siteId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "document" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "documentNumber" text NOT NULL,
    "documentType" text NOT NULL,
    "organizationId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "document_lifecycle" (
    "id" bigserial PRIMARY KEY,
    "documentVersionId" bigint NOT NULL,
    "state" text NOT NULL,
    "changedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "changedById" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "document_version" (
    "id" bigserial PRIMARY KEY,
    "documentId" bigint NOT NULL,
    "version" text NOT NULL,
    "storageKey" text NOT NULL,
    "effectiveDate" timestamp without time zone,
    "obsoleteDate" timestamp without time zone
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "electronic_signature" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "signatureMeaning" text NOT NULL,
    "passwordReauthHash" text,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "ipAddress" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "enrollment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseVersionId" bigint NOT NULL,
    "assignmentId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'not_started'::text,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "error_log" (
    "id" bigserial PRIMARY KEY,
    "message" text NOT NULL,
    "stackTrace" text,
    "contextJson" text,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_flag" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "enabled" boolean NOT NULL DEFAULT false,
    "organizationId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "inspection_report" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "inspector" text,
    "inspectionDate" timestamp without time zone,
    "findingsJson" text,
    "status" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_role" (
    "id" bigserial PRIMARY KEY,
    "departmentId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "trainingMatrixJson" text
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "material" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "materialType" text NOT NULL,
    "storageKey" text,
    "organizationId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "material_progress" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "materialId" bigint NOT NULL,
    "progressPct" bigint NOT NULL DEFAULT 0,
    "completedAt" timestamp without time zone,
    "interactionJson" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "material_version" (
    "id" bigserial PRIMARY KEY,
    "materialId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "storageKey" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "media_asset" (
    "id" bigserial PRIMARY KEY,
    "materialId" bigint NOT NULL,
    "assetType" text NOT NULL,
    "url" text NOT NULL,
    "durationSeconds" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "module" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "title" text NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "outbox_message" (
    "id" bigserial PRIMARY KEY,
    "topic" text NOT NULL,
    "payloadJson" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sentAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "permission" (
    "id" bigserial PRIMARY KEY,
    "roleId" bigint NOT NULL,
    "resource" text NOT NULL,
    "action" text NOT NULL
);

--
-- ACTION CREATE TABLE
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
    "authUserId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quality_event" (
    "id" bigserial PRIMARY KEY,
    "eventType" text NOT NULL,
    "referenceId" text,
    "title" text NOT NULL,
    "status" text NOT NULL,
    "siteId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question" (
    "id" bigserial PRIMARY KEY,
    "questionBankId" bigint NOT NULL,
    "text" text NOT NULL,
    "questionType" text NOT NULL,
    "optionsJson" text NOT NULL,
    "correctAnswer" text NOT NULL,
    "difficulty" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question_bank" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "organizationId" bigint NOT NULL,
    "tagsJson" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "report_definition" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "reportType" text NOT NULL,
    "querySql" text,
    "paramsJson" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "role" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "site" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "timezone" text NOT NULL DEFAULT 'UTC'::text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sla_breach" (
    "id" bigserial PRIMARY KEY,
    "slaPolicyId" bigint NOT NULL,
    "breachedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sla_policy" (
    "id" bigserial PRIMARY KEY,
    "metric" text NOT NULL,
    "threshold" double precision NOT NULL,
    "alertRoleId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "system_configuration" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" text NOT NULL,
    "organizationId" bigint
);

--
-- ACTION CREATE TABLE
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
    "source" text NOT NULL DEFAULT 'manual'::text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_expiration" (
    "id" bigserial PRIMARY KEY,
    "certificateId" bigint NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "reminderSentAt" timestamp without time zone,
    "renewalAssignmentId" bigint
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "user_competency" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "competencyId" bigint NOT NULL,
    "achievedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_role" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "access_log"
    ADD CONSTRAINT "access_log_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "audit_trail"
    ADD CONSTRAINT "audit_trail_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "course_version"
    ADD CONSTRAINT "course_version_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dashboard"
    ADD CONSTRAINT "dashboard_fk_0"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "department"
    ADD CONSTRAINT "department_fk_0"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "document"
    ADD CONSTRAINT "document_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "document_version"
    ADD CONSTRAINT "document_version_fk_0"
    FOREIGN KEY("documentId")
    REFERENCES "document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "electronic_signature"
    ADD CONSTRAINT "electronic_signature_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_flag"
    ADD CONSTRAINT "feature_flag_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_role"
    ADD CONSTRAINT "job_role_fk_0"
    FOREIGN KEY("departmentId")
    REFERENCES "department"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "material"
    ADD CONSTRAINT "material_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "material_version"
    ADD CONSTRAINT "material_version_fk_0"
    FOREIGN KEY("materialId")
    REFERENCES "material"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "media_asset"
    ADD CONSTRAINT "media_asset_fk_0"
    FOREIGN KEY("materialId")
    REFERENCES "material"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "module"
    ADD CONSTRAINT "module_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "permission"
    ADD CONSTRAINT "permission_fk_0"
    FOREIGN KEY("roleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "quality_event"
    ADD CONSTRAINT "quality_event_fk_0"
    FOREIGN KEY("siteId")
    REFERENCES "site"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "question"
    ADD CONSTRAINT "question_fk_0"
    FOREIGN KEY("questionBankId")
    REFERENCES "question_bank"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "question_bank"
    ADD CONSTRAINT "question_bank_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "site"
    ADD CONSTRAINT "site_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sla_breach"
    ADD CONSTRAINT "sla_breach_fk_0"
    FOREIGN KEY("slaPolicyId")
    REFERENCES "sla_policy"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sla_policy"
    ADD CONSTRAINT "sla_policy_fk_0"
    FOREIGN KEY("alertRoleId")
    REFERENCES "role"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "system_configuration"
    ADD CONSTRAINT "system_configuration_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260306114647081', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260306114647081', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
