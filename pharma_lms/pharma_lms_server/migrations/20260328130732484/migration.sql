BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "standalone_assignment" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint NOT NULL,
    "createdById" bigint NOT NULL,
    "title" text NOT NULL,
    "instructions" text,
    "dueAt" timestamp without time zone NOT NULL,
    "contentKind" text NOT NULL DEFAULT 'open_ended'::text,
    "questionBankId" bigint,
    "courseVersionId" bigint,
    "targetType" text NOT NULL DEFAULT 'individual'::text,
    "targetDepartmentId" bigint,
    "targetBatchId" bigint,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "publishedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "standalone_assignment_org_idx" ON "standalone_assignment" USING btree ("organizationId", "status", "dueAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "standalone_assignment_recipient" (
    "id" bigserial PRIMARY KEY,
    "assignmentId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "submittedAt" timestamp without time zone,
    "responseJson" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "standalone_assignment_recipient_user_idx" ON "standalone_assignment_recipient" USING btree ("userId", "assignmentId");
CREATE INDEX "standalone_assignment_recipient_assignment_idx" ON "standalone_assignment_recipient" USING btree ("assignmentId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "standalone_assignment"
    ADD CONSTRAINT "standalone_assignment_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "standalone_assignment"
    ADD CONSTRAINT "standalone_assignment_fk_1"
    FOREIGN KEY("createdById")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "standalone_assignment"
    ADD CONSTRAINT "standalone_assignment_fk_2"
    FOREIGN KEY("questionBankId")
    REFERENCES "question_bank"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "standalone_assignment"
    ADD CONSTRAINT "standalone_assignment_fk_3"
    FOREIGN KEY("courseVersionId")
    REFERENCES "course_version"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "standalone_assignment_recipient"
    ADD CONSTRAINT "standalone_assignment_recipient_fk_0"
    FOREIGN KEY("assignmentId")
    REFERENCES "standalone_assignment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "standalone_assignment_recipient"
    ADD CONSTRAINT "standalone_assignment_recipient_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "pharma_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pharma_lms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pharma_lms', '20260328130732484', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260328130732484', "timestamp" = now();

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
