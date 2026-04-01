BEGIN;

--
-- ACTION ALTER TABLE
--
CREATE INDEX "learner_trainer_from_idx" ON "learner_trainer_message" USING btree ("fromUserId", "createdAt");
CREATE INDEX "learner_trainer_to_idx" ON "learner_trainer_message" USING btree ("toUserId", "readAt");
CREATE INDEX "learner_trainer_to_created_idx" ON "learner_trainer_message" USING btree ("toUserId", "createdAt");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "sme_review_comment" ADD COLUMN "readAt" timestamp without time zone;
CREATE INDEX "sme_comment_cv_idx" ON "sme_review_comment" USING btree ("courseVersionId", "createdAt");
CREATE INDEX "sme_comment_author_idx" ON "sme_review_comment" USING btree ("authorId", "createdAt");

--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260331192355059', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260331192355059', "timestamp" = now();

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
