BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "retention_archive" (
    "id" bigserial PRIMARY KEY,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    "rowJson" text NOT NULL,
    "archivedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "retention_policy" (
    "id" bigserial PRIMARY KEY,
    "entityType" text NOT NULL,
    "retentionYears" bigint NOT NULL DEFAULT 7,
    "archiveEnabled" boolean NOT NULL DEFAULT true,
    "lastArchivedAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260310132728721', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260310132728721', "timestamp" = now();

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
