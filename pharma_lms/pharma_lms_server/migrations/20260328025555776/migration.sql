BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "assessment" ADD COLUMN "showAnswers" boolean NOT NULL DEFAULT false;
ALTER TABLE "assessment" ADD COLUMN "showSubmissionHistory" boolean NOT NULL DEFAULT false;
ALTER TABLE "assessment" ADD COLUMN "limitQuestions" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "assessment_result" ADD COLUMN "needsManualGrading" boolean NOT NULL DEFAULT false;
ALTER TABLE "assessment_result" ADD COLUMN "manualScore" bigint;
ALTER TABLE "assessment_result" ADD COLUMN "gradedById" bigint;
ALTER TABLE "assessment_result" ADD COLUMN "gradedAt" timestamp without time zone;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "assignment" (
    "id" bigserial PRIMARY KEY,
    "lessonId" bigint NOT NULL,
    "title" text NOT NULL,
    "instructions" text,
    "allowedFileTypes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "assignment_submission" (
    "id" bigserial PRIMARY KEY,
    "assignmentId" bigint NOT NULL,
    "userId" bigint,
    "submissionUrl" text,
    "storageKey" text,
    "fileName" text,
    "status" text NOT NULL DEFAULT 'submitted'::text,
    "grade" bigint,
    "feedback" text,
    "submittedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "gradedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "certificate" ALTER COLUMN "trainingRecordId" DROP NOT NULL;
ALTER TABLE "certificate" ALTER COLUMN "esignatureId" DROP NOT NULL;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "certificate_template" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "name" text NOT NULL,
    "htmlTemplate" text NOT NULL,
    "isDefault" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "course" ADD COLUMN "previewVideoUrl" text;
ALTER TABLE "course" ADD COLUMN "imageUrl" text;
ALTER TABLE "course" ADD COLUMN "tags" text;
ALTER TABLE "course" ADD COLUMN "publishedAt" timestamp without time zone;
ALTER TABLE "course" ADD COLUMN "disableSelfEnrollment" boolean NOT NULL DEFAULT false;
ALTER TABLE "course" ADD COLUMN "category" text;
ALTER TABLE "course" ADD COLUMN "featured" boolean NOT NULL DEFAULT false;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "lesson" ADD COLUMN "lessonType" text;
ALTER TABLE "lesson" ADD COLUMN "minEngagementMinutes" bigint;
ALTER TABLE "lesson" ADD COLUMN "prerequisiteMode" text;
ALTER TABLE "lesson" ADD COLUMN "instructorNotes" text;
ALTER TABLE "lesson" ADD COLUMN "includeInPreview" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "lesson_block" (
    "id" bigserial PRIMARY KEY,
    "lessonId" bigint NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0,
    "blockType" text NOT NULL,
    "contentJson" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "live_class" (
    "id" bigserial PRIMARY KEY,
    "batchId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "scheduledAt" timestamp without time zone NOT NULL,
    "durationMinutes" bigint NOT NULL DEFAULT 60,
    "meetingUrl" text,
    "autoRecording" boolean NOT NULL DEFAULT false,
    "createdById" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "material" ADD COLUMN "contentUrl" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "question" ALTER COLUMN "correctAnswer" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "training_batch" ADD COLUMN "startTime" text;
ALTER TABLE "training_batch" ADD COLUMN "endTime" text;
ALTER TABLE "training_batch" ADD COLUMN "medium" text;
ALTER TABLE "training_batch" ADD COLUMN "meetingUrl" text;
ALTER TABLE "training_batch" ADD COLUMN "category" text;
ALTER TABLE "training_batch" ADD COLUMN "description" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "assignment"
    ADD CONSTRAINT "assignment_fk_0"
    FOREIGN KEY("lessonId")
    REFERENCES "lesson"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "assignment_submission"
    ADD CONSTRAINT "assignment_submission_fk_0"
    FOREIGN KEY("assignmentId")
    REFERENCES "assignment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "assignment_submission"
    ADD CONSTRAINT "assignment_submission_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "certificate_template"
    ADD CONSTRAINT "certificate_template_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "lesson_block"
    ADD CONSTRAINT "lesson_block_fk_0"
    FOREIGN KEY("lessonId")
    REFERENCES "lesson"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "live_class"
    ADD CONSTRAINT "live_class_fk_0"
    FOREIGN KEY("batchId")
    REFERENCES "training_batch"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "live_class"
    ADD CONSTRAINT "live_class_fk_1"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260328025555776', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328025555776', "timestamp" = now();

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
