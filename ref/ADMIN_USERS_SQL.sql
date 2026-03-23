-- ═══════════════════════════════════════════════════════════════════════════════
-- SQL Script: Manually Insert 5 Admin Users to Database
-- ═══════════════════════════════════════════════════════════════════════════════
-- Use this script if you prefer to add admin users directly to PostgreSQL
-- instead of using the seed endpoint.
-- ═══════════════════════════════════════════════════════════════════════════════

-- Step 1: Connect to the database
-- psql -h localhost -U postgres -d pharma_lms

-- ═══════════════════════════════════════════════════════════════════════════════
-- STEP 1: Verify Organization Exists
-- ═══════════════════════════════════════════════════════════════════════════════

SELECT id as org_id, name, code FROM organization 
WHERE name = 'PharmaTech India Pvt Ltd';

-- Expected result: org_id = 1 (or some integer)
-- If no result: Run the seed first to create organization

-- ═══════════════════════════════════════════════════════════════════════════════
-- STEP 2: Get Required IDs from Database
-- ═══════════════════════════════════════════════════════════════════════════════

-- Get all site IDs (need 5 sites)
SELECT 
  ROW_NUMBER() OVER (ORDER BY id) - 1 as site_idx,
  id as site_id, 
  name, 
  code
FROM site 
WHERE "organizationId" = 1
LIMIT 5;

-- Expected:
-- site_idx | site_id | name                  | code
--    0     |    1    | Mumbai HQ             | MUM
--    1     |    2    | Pune Manufacturing    | PUN
--    2     |    3    | Hyderabad R&D         | HYD
--    3     |    4    | Ahmedabad API         | AHM
--    4     |    5    | Bengaluru Biotech     | BLR

-- Get all department IDs (need 10 departments)
SELECT 
  ROW_NUMBER() OVER (ORDER BY id) - 1 as dept_idx,
  id as dept_id, 
  name, 
  code
FROM department 
WHERE "siteId" IN (SELECT id FROM site WHERE "organizationId" = 1)
LIMIT 10;

-- Expected:
-- dept_idx | dept_id | name                      | code
--    0     |    1    | Quality Assurance         | QA
--    1     |    2    | Quality Control           | QC
--    2     |    3    | Manufacturing             | MFG
--    3     |    4    | Regulatory Affairs        | RA
--    4     |    5    | Pharmacovigilance         | PV
--    5     |    6    | Research & Development   | RD
--    6     |    7    | Information Technology   | IT
--    7     |    8    | Learning & Development   | LD
--    8     |    9    | Supply Chain             | SCM
--    9     |   10    | Engineering              | ENG

-- Get all role IDs (need admin, qa_manager, auditor)
SELECT id as role_id, name, code 
FROM role 
WHERE code IN ('admin', 'qa_manager', 'auditor');

-- Expected:
-- role_id | name       | code
--    1    | Admin      | admin
--    2    | QA Manager | qa_manager
--    7    | Auditor    | auditor

-- Get first job role ID
SELECT id as job_role_id, name, code 
FROM job_role 
LIMIT 1;

-- Expected:
-- job_role_id | name         | code
--    1        | QA Specialist| QA-SPEC

-- ═══════════════════════════════════════════════════════════════════════════════
-- STEP 3: INSERT ADMIN USERS
-- ═══════════════════════════════════════════════════════════════════════════════
-- NOTE: Replace these variables with values from STEP 2:
-- - org_id = 1
-- - site_ids = [1, 2, 3, 4, 5]
-- - dept_ids = [1, 8, 1, 8, 4]
-- - role_ids: admin=1, qa_manager=2, auditor=7
-- - job_role_id = 1

-- Insert Admin User 1: Super Administrator (ADMIN role)
-- Email: super.admin@pharmacorp.demo
-- Site: Mumbai HQ (site_id=1)
-- Department: Quality Assurance (dept_id=1)
INSERT INTO pharma_user (
  email, 
  "firstName", 
  "lastName", 
  "employeeId",
  "siteId", 
  "departmentId", 
  "jobRoleId", 
  "organizationId",
  status, 
  "hireDate"
) 
VALUES (
  'super.admin@pharmacorp.demo', 
  'Super', 
  'Administrator', 
  'ADM-001',
  1,                    -- Mumbai HQ
  1,                    -- Quality Assurance
  1,                    -- Job Role
  1,                    -- PharmaTech India
  'active', 
  NOW() - INTERVAL '730 days'
)
RETURNING id as user_id;

-- Copy the returned user_id, then link role:
INSERT INTO user_role (userId, roleId) 
VALUES (
  (SELECT id FROM pharma_user WHERE email = 'super.admin@pharmacorp.demo'),
  1  -- admin role
);

-- ─────────────────────────────────────────────────────────────────────────────

-- Insert Admin User 2: Content Administrator (ADMIN role)
-- Email: content.admin@pharmacorp.demo
-- Site: Mumbai HQ (site_id=1)
-- Department: Learning & Development (dept_id=8)
INSERT INTO pharma_user (
  email, 
  "firstName", 
  "lastName", 
  "employeeId",
  "siteId", 
  "departmentId", 
  "jobRoleId", 
  "organizationId",
  status, 
  "hireDate"
) 
VALUES (
  'content.admin@pharmacorp.demo', 
  'Content', 
  'Administrator', 
  'ADM-002',
  1,                    -- Mumbai HQ
  8,                    -- Learning & Development
  1,                    -- Job Role
  1,                    -- PharmaTech India
  'active', 
  NOW() - INTERVAL '730 days'
)
RETURNING id as user_id;

INSERT INTO user_role (userId, roleId) 
VALUES (
  (SELECT id FROM pharma_user WHERE email = 'content.admin@pharmacorp.demo'),
  1  -- admin role
);

-- ─────────────────────────────────────────────────────────────────────────────

-- Insert Admin User 3: Quality Manager (QA_MANAGER role)
-- Email: qa.manager@pharmacorp.demo
-- Site: Pune Manufacturing (site_id=2)
-- Department: Quality Assurance (dept_id=1)
INSERT INTO pharma_user (
  email, 
  "firstName", 
  "lastName", 
  "employeeId",
  "siteId", 
  "departmentId", 
  "jobRoleId", 
  "organizationId",
  status, 
  "hireDate"
) 
VALUES (
  'qa.manager@pharmacorp.demo', 
  'Quality', 
  'Manager', 
  'ADM-003',
  2,                    -- Pune Manufacturing
  1,                    -- Quality Assurance
  1,                    -- Job Role
  1,                    -- PharmaTech India
  'active', 
  NOW() - INTERVAL '730 days'
)
RETURNING id as user_id;

INSERT INTO user_role (userId, roleId) 
VALUES (
  (SELECT id FROM pharma_user WHERE email = 'qa.manager@pharmacorp.demo'),
  2  -- qa_manager role
);

-- ─────────────────────────────────────────────────────────────────────────────

-- Insert Admin User 4: Training Administrator (ADMIN role)
-- Email: training.admin@pharmacorp.demo
-- Site: Hyderabad R&D (site_id=3)
-- Department: Learning & Development (dept_id=8)
INSERT INTO pharma_user (
  email, 
  "firstName", 
  "lastName", 
  "employeeId",
  "siteId", 
  "departmentId", 
  "jobRoleId", 
  "organizationId",
  status, 
  "hireDate"
) 
VALUES (
  'training.admin@pharmacorp.demo', 
  'Training', 
  'Administrator', 
  'ADM-004',
  3,                    -- Hyderabad R&D
  8,                    -- Learning & Development
  1,                    -- Job Role
  1,                    -- PharmaTech India
  'active', 
  NOW() - INTERVAL '730 days'
)
RETURNING id as user_id;

INSERT INTO user_role (userId, roleId) 
VALUES (
  (SELECT id FROM pharma_user WHERE email = 'training.admin@pharmacorp.demo'),
  1  -- admin role
);

-- ─────────────────────────────────────────────────────────────────────────────

-- Insert Admin User 5: Audit Officer (AUDITOR role)
-- Email: audit.officer@pharmacorp.demo
-- Site: Bengaluru Biotech (site_id=5)
-- Department: Regulatory Affairs (dept_id=4)
INSERT INTO pharma_user (
  email, 
  "firstName", 
  "lastName", 
  "employeeId",
  "siteId", 
  "departmentId", 
  "jobRoleId", 
  "organizationId",
  status, 
  "hireDate"
) 
VALUES (
  'audit.officer@pharmacorp.demo', 
  'Audit', 
  'Officer', 
  'ADM-005',
  5,                    -- Bengaluru Biotech
  4,                    -- Regulatory Affairs
  1,                    -- Job Role
  1,                    -- PharmaTech India
  'active', 
  NOW() - INTERVAL '730 days'
)
RETURNING id as user_id;

INSERT INTO user_role (userId, roleId) 
VALUES (
  (SELECT id FROM pharma_user WHERE email = 'audit.officer@pharmacorp.demo'),
  7  -- auditor role
);

-- ═══════════════════════════════════════════════════════════════════════════════
-- STEP 4: VERIFY ALL ADMINS WERE CREATED
-- ═══════════════════════════════════════════════════════════════════════════════

SELECT 
  pu.id,
  pu.email,
  pu."firstName",
  pu."lastName",
  pu."employeeId",
  s.name as site,
  d.name as department,
  r.name as role,
  pu.status,
  pu."hireDate"
FROM pharma_user pu
LEFT JOIN site s ON pu."siteId" = s.id
LEFT JOIN department d ON pu."departmentId" = d.id
LEFT JOIN user_role ur ON pu.id = ur."userId"
LEFT JOIN role r ON ur."roleId" = r.id
WHERE pu.email LIKE '%@pharmacorp.demo' AND pu."employeeId" LIKE 'ADM-%'
ORDER BY pu."employeeId";

-- Expected result:
-- id | email                          | firstName | lastName       | employeeId | site           | department           | role       | status | hireDate
-- 106| super.admin@pharmacorp.demo    | Super     | Administrator | ADM-001    | Mumbai HQ      | Quality Assurance    | Admin      | active | ...
-- 107| content.admin@pharmacorp.demo  | Content   | Administrator | ADM-002    | Mumbai HQ      | Learning & Development | Admin    | active | ...
-- 108| qa.manager@pharmacorp.demo     | Quality   | Manager       | ADM-003    | Pune Mfg       | Quality Assurance    | QA Manager | active | ...
-- 109| training.admin@pharmacorp.demo | Training  | Administrator | ADM-004    | Hyderabad R&D  | Learning & Development | Admin    | active | ...
-- 110| audit.officer@pharmacorp.demo  | Audit     | Officer       | ADM-005    | Bengaluru Bio  | Regulatory Affairs   | Auditor    | active | ...

-- ═══════════════════════════════════════════════════════════════════════════════
-- STEP 5: CREATE AUTH ACCOUNTS (Required for Login)
-- ═══════════════════════════════════════════════════════════════════════════════
-- NOTE: This requires the Serverpod auth system to be running
-- Use the seed endpoint instead if possible:
--   curl -X POST http://localhost:8080/api/seed/provisionAuthAccounts
--
-- If you must do it manually, use the Serverpod auth API in your Dart code.
-- Database inserts alone won't create password hashes.

-- ═══════════════════════════════════════════════════════════════════════════════
-- STEP 6: COUNT TOTAL USERS
-- ═══════════════════════════════════════════════════════════════════════════════

SELECT 
  COUNT(*) as total_users,
  SUM(CASE WHEN "employeeId" LIKE 'ADM-%' THEN 1 ELSE 0 END) as admin_users,
  SUM(CASE WHEN "employeeId" LIKE 'TRN-%' THEN 1 ELSE 0 END) as trainer_users,
  SUM(CASE WHEN "employeeId" LIKE 'EMP-%' THEN 1 ELSE 0 END) as employee_users,
  SUM(CASE WHEN "employeeId" LIKE 'DEMO-%' THEN 1 ELSE 0 END) as demo_users
FROM pharma_user
WHERE "organizationId" = 1;

-- Expected:
-- total_users | admin_users | trainer_users | employee_users | demo_users
--    126      |      5      |       15      |      100       |     6

-- ═══════════════════════════════════════════════════════════════════════════════
-- TROUBLESHOOTING
-- ═══════════════════════════════════════════════════════════════════════════════

-- Check if organization exists
SELECT COUNT(*) FROM organization WHERE name = 'PharmaTech India Pvt Ltd';

-- Check if sites were created
SELECT COUNT(*) FROM site WHERE "organizationId" = 1;

-- Check if departments were created
SELECT COUNT(*) FROM department;

-- Check if roles exist
SELECT COUNT(*) FROM role WHERE code IN ('admin', 'qa_manager', 'auditor');

-- Check if any user_role mappings exist
SELECT COUNT(*) FROM user_role;

-- Check if auth users were created
SELECT COUNT(*) FROM serverpod_auth_core_user;

-- Check if auth profiles were created
SELECT COUNT(*) FROM serverpod_auth_core_profile;

-- List all authentication users
SELECT 
  id,
  email
FROM serverpod_auth_core_user
WHERE email LIKE '%@pharmacorp.demo'
ORDER BY email;

-- ═══════════════════════════════════════════════════════════════════════════════
-- CLEANUP (If you need to delete admins and reseed)
-- ═══════════════════════════════════════════════════════════════════════════════

-- Delete admin users
-- DELETE FROM pharma_user WHERE "employeeId" LIKE 'ADM-%';
-- DELETE FROM user_role WHERE "userId" IN (
--   SELECT id FROM pharma_user WHERE "employeeId" LIKE 'ADM-%'
-- );

-- Delete all auth users (careful!)
-- DELETE FROM serverpod_auth_core_profile WHERE email LIKE '%@pharmacorp.demo';
-- DELETE FROM serverpod_auth_core_user WHERE email LIKE '%@pharmacorp.demo';

-- ═══════════════════════════════════════════════════════════════════════════════
-- END OF SCRIPT
-- ═══════════════════════════════════════════════════════════════════════════════
