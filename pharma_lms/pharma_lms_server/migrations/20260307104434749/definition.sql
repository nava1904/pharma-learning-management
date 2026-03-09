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
    "timeLimitMinutes" bigint
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
    "ipAddress" text
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
    "esignatureId" bigint NOT NULL
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
    "organizationId" bigint NOT NULL
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
-- Class CourseVersion as table course_version
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
-- Class Dashboard as table dashboard
--
CREATE TABLE "dashboard" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "widgetsJson" text NOT NULL,
    "roleId" bigint
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
    "passwordReauthHash" text,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "ipAddress" text
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
    "completedAt" timestamp without time zone
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
-- Class FeatureFlag as table feature_flag
--
CREATE TABLE "feature_flag" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "enabled" boolean NOT NULL DEFAULT false,
    "organizationId" bigint
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
    "interactionJson" text
);

--
-- Class MaterialVersion as table material_version
--
CREATE TABLE "material_version" (
    "id" bigserial PRIMARY KEY,
    "materialId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "storageKey" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
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
-- Class Module as table module
--
CREATE TABLE "module" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "title" text NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0
);

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
    "sentAt" timestamp without time zone
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
    "authUserId" bigint
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
    "difficulty" text
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
-- Class Role as table role
--
CREATE TABLE "role" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "code" text NOT NULL
);

--
-- Class SignatureMeaning as table signature_meaning
--
CREATE TABLE "signature_meaning" (
    "id" bigserial PRIMARY KEY,
    "meaning" text NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "orderIndex" bigint NOT NULL DEFAULT 0
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
    "source" text NOT NULL DEFAULT 'manual'::text
);

--
-- Class TrainingExpiration as table training_expiration
--
CREATE TABLE "training_expiration" (
    "id" bigserial PRIMARY KEY,
    "certificateId" bigint NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "reminderSentAt" timestamp without time zone,
    "renewalAssignmentId" bigint
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
-- Class UserRole as table user_role
--
CREATE TABLE "user_role" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "roleId" bigint NOT NULL
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
-- Foreign relations for "access_log" table
--
ALTER TABLE ONLY "access_log"
    ADD CONSTRAINT "access_log_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
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
-- Foreign relations for "audit_trail" table
--
ALTER TABLE ONLY "audit_trail"
    ADD CONSTRAINT "audit_trail_fk_0"
    FOREIGN KEY("userId")
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
-- Foreign relations for "course_version" table
--
ALTER TABLE ONLY "course_version"
    ADD CONSTRAINT "course_version_fk_0"
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
    VALUES ('pharma_lms', '20260307104434749', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260307104434749', "timestamp" = now();

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


COMMIT;
