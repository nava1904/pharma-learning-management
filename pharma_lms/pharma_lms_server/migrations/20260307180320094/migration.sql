BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_waiver" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "courseId" bigint NOT NULL,
    "requestedById" bigint NOT NULL,
    "requestedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestReason" text NOT NULL,
    "evidenceStoragePath" text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "approvedById" bigint,
    "approvedAt" timestamp without time zone,
    "rejectionReason" text,
    "expiresAt" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_1"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_2"
    FOREIGN KEY("requestedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_waiver"
    ADD CONSTRAINT "training_waiver_fk_3"
    FOREIGN KEY("approvedById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260307180320094', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260307180320094', "timestamp" = now();

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
