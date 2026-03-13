BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "assessment" ADD COLUMN "maxAttempts" bigint;
ALTER TABLE "assessment" ADD COLUMN "questionsToDisplay" bigint;
--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "audit_trail" ADD COLUMN "rowHash" text;
--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "material_version" ADD COLUMN "fileHash" text;
ALTER TABLE "material_version" ADD COLUMN "virusScanStatus" text DEFAULT 'pending'::text;
ALTER TABLE "material_version" ADD COLUMN "virusScanAt" timestamp without time zone;
ALTER TABLE "material_version" ADD COLUMN "fileSizeBytes" bigint;
--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "question" ADD COLUMN "regulatoryTag" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "analytics_snapshot"
    ADD CONSTRAINT "analytics_snapshot_fk_0"
    FOREIGN KEY("scheduledJobLogId")
    REFERENCES "scheduled_job_log"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "audit_integrity_result"
    ADD CONSTRAINT "audit_integrity_result_fk_0"
    FOREIGN KEY("scheduledJobLogId")
    REFERENCES "scheduled_job_log"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification_log"
    ADD CONSTRAINT "notification_log_fk_0"
    FOREIGN KEY("notificationId")
    REFERENCES "notification"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260312224019886', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260312224019886', "timestamp" = now();

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
