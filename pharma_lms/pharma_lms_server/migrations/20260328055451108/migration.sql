BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "batch_announcement" (
    "id" bigserial PRIMARY KEY,
    "batchId" bigint NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "kind" text NOT NULL DEFAULT 'general'::text,
    "relatedLiveClassId" bigint,
    "createdById" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "batch_announcement_batch_idx" ON "batch_announcement" USING btree ("batchId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "learner_trainer_message" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "fromUserId" bigint NOT NULL,
    "toUserId" bigint NOT NULL,
    "body" text NOT NULL,
    "parentMessageId" bigint,
    "readAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "learner_trainer_cv_idx" ON "learner_trainer_message" USING btree ("courseVersionId", "createdAt");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "sme_review_comment" ADD COLUMN "parentCommentId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "batch_announcement"
    ADD CONSTRAINT "batch_announcement_fk_0"
    FOREIGN KEY("batchId")
    REFERENCES "training_batch"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "batch_announcement"
    ADD CONSTRAINT "batch_announcement_fk_1"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "learner_trainer_message"
    ADD CONSTRAINT "learner_trainer_message_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "learner_trainer_message"
    ADD CONSTRAINT "learner_trainer_message_fk_1"
    FOREIGN KEY("fromUserId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "learner_trainer_message"
    ADD CONSTRAINT "learner_trainer_message_fk_2"
    FOREIGN KEY("toUserId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "learner_trainer_message"
    ADD CONSTRAINT "learner_trainer_message_fk_3"
    FOREIGN KEY("parentMessageId")
    REFERENCES "learner_trainer_message"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sme_review_comment"
    ADD CONSTRAINT "sme_review_comment_fk_2"
    FOREIGN KEY("parentCommentId")
    REFERENCES "sme_review_comment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260328055451108', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328055451108', "timestamp" = now();

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
