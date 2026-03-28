BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260324202614601', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260324202614601', "timestamp" = now();

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
