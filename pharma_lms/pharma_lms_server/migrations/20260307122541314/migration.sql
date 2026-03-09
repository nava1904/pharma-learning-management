BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "material_progress" ADD COLUMN "materialVersionId" bigint;
ALTER TABLE "material_progress" ADD COLUMN "enrollmentId" bigint;
ALTER TABLE "material_progress" ADD COLUMN "timeSpentSeconds" bigint;
ALTER TABLE "material_progress" ADD COLUMN "readTimeMet" boolean;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "enrollmentId" bigint,
    "sentAt" timestamp without time zone,
    "deliveryStatus" text,
    "readAt" timestamp without time zone,
    "channel" text NOT NULL DEFAULT 'in_app'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "outbox_message" ADD COLUMN "status" text NOT NULL DEFAULT 'pending'::text;
ALTER TABLE "outbox_message" ADD COLUMN "retryCount" bigint NOT NULL DEFAULT 0;
ALTER TABLE "outbox_message" ADD COLUMN "lastError" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "pharma_user" ADD COLUMN "employeeId" text;
ALTER TABLE "pharma_user" ADD COLUMN "hireDate" timestamp without time zone;
ALTER TABLE "pharma_user" ADD COLUMN "managerId" bigint;
ALTER TABLE "pharma_user" ADD COLUMN "preferredLanguage" text;
ALTER TABLE "pharma_user" ADD COLUMN "timezone" text DEFAULT 'UTC'::text;
--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "signature_meaning" ADD COLUMN "applicableTo" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "training_assignment" ADD COLUMN "assignmentType" text NOT NULL DEFAULT 'individual'::text;
ALTER TABLE "training_assignment" ADD COLUMN "targetRoleId" bigint;
ALTER TABLE "training_assignment" ADD COLUMN "targetDepartmentId" bigint;
ALTER TABLE "training_assignment" ADD COLUMN "targetUserId" bigint;
ALTER TABLE "training_assignment" ADD COLUMN "status" text NOT NULL DEFAULT 'active'::text;
ALTER TABLE "training_assignment" ADD COLUMN "cancelledAt" timestamp without time zone;
ALTER TABLE "training_assignment" ADD COLUMN "cancelledById" bigint;
ALTER TABLE "training_assignment" ADD COLUMN "cancellationReason" text;
--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "auditor_page_log"
    ADD CONSTRAINT "auditor_page_log_fk_0"
    FOREIGN KEY("auditorSessionId")
    REFERENCES "auditor_session"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "import_log"
    ADD CONSTRAINT "import_log_fk_0"
    FOREIGN KEY("importedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "report_export"
    ADD CONSTRAINT "report_export_fk_0"
    FOREIGN KEY("exportedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_session"
    ADD CONSTRAINT "user_session_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260307122541314', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260307122541314', "timestamp" = now();

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
