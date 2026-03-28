BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "notification" ADD COLUMN "body" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "sme_assignment" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "courseVersionId" bigint,
    "smeUserId" bigint NOT NULL,
    "invitedById" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'invited'::text,
    "invitedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "sme_assignment_course_sme_unique_idx" ON "sme_assignment" USING btree ("courseId", "smeUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sme_review_comment" (
    "id" bigserial PRIMARY KEY,
    "courseVersionId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "sectionRef" text NOT NULL,
    "severity" text NOT NULL DEFAULT 'note'::text,
    "body" text NOT NULL,
    "resolved" boolean NOT NULL DEFAULT false,
    "trainerResponse" text,
    "resolvedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_1"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_2"
    FOREIGN KEY("smeUserId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_assignment"
    ADD CONSTRAINT "sme_assignment_fk_3"
    FOREIGN KEY("invitedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sme_review_comment"
    ADD CONSTRAINT "sme_review_comment_fk_0"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sme_review_comment"
    ADD CONSTRAINT "sme_review_comment_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260325134017693', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260325134017693', "timestamp" = now();

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
