BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "batch_attendance_record" (
    "id" bigserial PRIMARY KEY,
    "batchId" bigint NOT NULL,
    "liveClassId" bigint,
    "userId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'present'::text,
    "markedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "markedById" bigint NOT NULL,
    "notes" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "observation_log" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "evaluatorId" bigint NOT NULL,
    "competencyId" bigint NOT NULL,
    "checklistItemId" bigint NOT NULL,
    "result" text NOT NULL DEFAULT 'pending'::text,
    "notes" text,
    "observedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "evaluatorEsignatureId" bigint,
    "traineeEsignatureId" bigint,
    "organizationId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "practical_checklist_item" (
    "id" bigserial PRIMARY KEY,
    "competencyId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "orderIndex" bigint NOT NULL DEFAULT 0,
    "isCritical" boolean NOT NULL DEFAULT false,
    "organizationId" bigint NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "standalone_assignment_recipient" ADD COLUMN "grade" bigint;
ALTER TABLE "standalone_assignment_recipient" ADD COLUMN "feedback" text;
ALTER TABLE "standalone_assignment_recipient" ADD COLUMN "gradedAt" timestamp without time zone;
ALTER TABLE "standalone_assignment_recipient" ADD COLUMN "gradedById" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "batch_attendance_record"
    ADD CONSTRAINT "batch_attendance_record_fk_0"
    FOREIGN KEY("batchId")
    REFERENCES "training_batch"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "batch_attendance_record"
    ADD CONSTRAINT "batch_attendance_record_fk_1"
    FOREIGN KEY("liveClassId")
    REFERENCES "live_class"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "batch_attendance_record"
    ADD CONSTRAINT "batch_attendance_record_fk_2"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "batch_attendance_record"
    ADD CONSTRAINT "batch_attendance_record_fk_3"
    FOREIGN KEY("markedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "observation_log"
    ADD CONSTRAINT "observation_log_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "observation_log"
    ADD CONSTRAINT "observation_log_fk_1"
    FOREIGN KEY("evaluatorId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "observation_log"
    ADD CONSTRAINT "observation_log_fk_2"
    FOREIGN KEY("competencyId")
    REFERENCES "competency"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "observation_log"
    ADD CONSTRAINT "observation_log_fk_3"
    FOREIGN KEY("checklistItemId")
    REFERENCES "practical_checklist_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "practical_checklist_item"
    ADD CONSTRAINT "practical_checklist_item_fk_0"
    FOREIGN KEY("competencyId")
    REFERENCES "competency"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260329192036258', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329192036258', "timestamp" = now();

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
