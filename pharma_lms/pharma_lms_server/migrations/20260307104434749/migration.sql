BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "capa" ADD COLUMN "status" text NOT NULL DEFAULT 'Initiation'::text;
ALTER TABLE "capa" ADD COLUMN "rcaCompletedAt" timestamp without time zone;
ALTER TABLE "capa" ADD COLUMN "effectivenessCheckDue" timestamp without time zone;
ALTER TABLE "capa" ADD COLUMN "closedAt" timestamp without time zone;
ALTER TABLE "capa" ADD COLUMN "closedById" bigint;

--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260307104434749', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260307104434749', "timestamp" = now();

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
