BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mfa_verified_session" (
    "id" bigserial PRIMARY KEY,
    "authUserId" text NOT NULL,
    "sessionId" text NOT NULL,
    "verifiedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_mfa" (
    "id" bigserial PRIMARY KEY,
    "authUserId" text NOT NULL,
    "mfaSecretBase32" text NOT NULL,
    "mfaEnabled" boolean NOT NULL DEFAULT false,
    "enrolledAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260310131427046', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260310131427046', "timestamp" = now();

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
