BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course_sop_link" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "documentId" bigint NOT NULL,
    "linkedById" bigint NOT NULL,
    "linkedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "unlinkedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_preference" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "preferenceKey" text NOT NULL,
    "preferenceValue" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "course_sop_link"
    ADD CONSTRAINT "course_sop_link_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_sop_link"
    ADD CONSTRAINT "course_sop_link_fk_1"
    FOREIGN KEY("documentId")
    REFERENCES "document"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_sop_link"
    ADD CONSTRAINT "course_sop_link_fk_2"
    FOREIGN KEY("linkedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_preference"
    ADD CONSTRAINT "user_preference_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260317015508598', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260317015508598', "timestamp" = now();

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
