BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "course" ADD COLUMN "customMetadataJson" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "curriculum" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "code" text NOT NULL,
    "description" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "curriculum_course" (
    "id" bigserial PRIMARY KEY,
    "curriculumId" bigint NOT NULL,
    "courseId" bigint NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "pharma_user" ADD COLUMN "customMetadataJson" text;
ALTER TABLE "pharma_user" ADD COLUMN "biometricCredentialId" text;
--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "training_batch" ADD COLUMN "facilityId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "curriculum"
    ADD CONSTRAINT "curriculum_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "facility"
    ADD CONSTRAINT "facility_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "simulation_attempt"
    ADD CONSTRAINT "simulation_attempt_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_batch"
    ADD CONSTRAINT "training_batch_fk_3"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260324191751704', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260324191751704', "timestamp" = now();

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
