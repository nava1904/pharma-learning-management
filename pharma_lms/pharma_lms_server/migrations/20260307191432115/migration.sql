BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "enrollment" ADD COLUMN "retrainingChangeSummary" text;
ALTER TABLE "enrollment" ADD COLUMN "acknowledgedAt" timestamp without time zone;
ALTER TABLE "enrollment" ADD COLUMN "acknowledgementEsignatureId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "enrollment"
    ADD CONSTRAINT "enrollment_fk_3"
    FOREIGN KEY("acknowledgementEsignatureId")
    REFERENCES "electronic_signature"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260307191432115', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260307191432115', "timestamp" = now();

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
