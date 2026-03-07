BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "approval_workflow" ALTER COLUMN "esignatureId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "assessment_attempt" ALTER COLUMN "enrollmentId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "capa" ALTER COLUMN "trainingAssignmentId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "course" ALTER COLUMN "createdById" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "dashboard" ALTER COLUMN "roleId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "enrollment" ALTER COLUMN "assignmentId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "inspection_report" ALTER COLUMN "siteId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "quality_event" ALTER COLUMN "siteId" DROP NOT NULL;

--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260306160048680', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260306160048680', "timestamp" = now();

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
