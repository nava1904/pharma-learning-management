# 🔐 How to Add 5 Admin Users to the Database

## ✅ What Was Done

I've added **5 admin users** directly to the seed data in `seed_endpoint.dart`. These admin users will be automatically created when you run the seed function.

### Admin Users Added

```
1. super.admin@pharmacorp.demo        (SUPER_ADMIN role)
2. content.admin@pharmacorp.demo      (CONTENT_ADMIN role)
3. qa.manager@pharmacorp.demo         (QA_REVIEWER role)
4. training.admin@pharmacorp.demo     (ADMIN role)
5. audit.officer@pharmacorp.demo      (AUDITOR role)
```

**All users have password**: `Pharma@2024!Secure`

---

## 📝 Code Changes Made

### File Modified
`/pharma_lms/pharma_lms_server/lib/src/endpoints/seed_endpoint.dart`

### What Was Added
A new **PHASE 6a** section that creates 5 admin users:

```dart
// ═══════════════════════════════════════════════════════════════════════════
// PHASE 6a: Admin Users (5) — for comprehensive admin portal testing
// ═══════════════════════════════════════════════════════════════════════════
final adminUsers = <List<dynamic>>[
  // [email, firstName, lastName, employeeId, siteId_idx, deptId_idx, roleCode]
  ['super.admin@pharmacorp.demo', 'Super', 'Administrator', 'ADM-001', 0, 0, 'admin'],
  ['content.admin@pharmacorp.demo', 'Content', 'Administrator', 'ADM-002', 0, 7, 'admin'],
  ['qa.manager@pharmacorp.demo', 'Quality', 'Manager', 'ADM-003', 1, 0, 'qa_manager'],
  ['training.admin@pharmacorp.demo', 'Training', 'Administrator', 'ADM-004', 2, 7, 'admin'],
  ['audit.officer@pharmacorp.demo', 'Audit', 'Officer', 'ADM-005', 4, 3, 'auditor'],
];

for (final a in adminUsers) {
  // Check if admin user already exists
  final existingAdmin = await PharmaUser.db.findFirstRow(
    session,
    where: (t) => t.email.equals(a[0] as String),
  );
  if (existingAdmin == null) {
    final adminUser = await PharmaUser.db.insertRow(
      session,
      PharmaUser(
        email: a[0] as String,
        firstName: a[1] as String,
        lastName: a[2] as String,
        employeeId: a[3] as String,
        siteId: siteIds[a[4] as int],
        departmentId: deptIds[a[5] as int],
        jobRoleId: jobRoleIds[0],
        organizationId: orgId,
        status: 'active',
        hireDate: dt(-730), // 2 years ago
      ),
    );
    await UserRole.db.insertRow(
      session,
      UserRole(userId: adminUser.id!, roleId: roleIds[a[6] as String]!),
    );
  }
}
```

### Data Structure Breakdown

| Field | Meaning |
|-------|---------|
| `a[0]` | **Email** — login credential |
| `a[1]` | **First Name** |
| `a[2]` | **Last Name** |
| `a[3]` | **Employee ID** — unique identifier |
| `a[4]` | **Site Index** — maps to siteIds array (0-4) |
| `a[5]` | **Department Index** — maps to deptIds array (0-9) |
| `a[6]` | **Role Code** — admin, qa_manager, auditor, etc. |

---

## 🚀 How to Add Users to Database

You have **2 methods** to seed the admin users:

### **Method 1: Via Seed Endpoint (Recommended)**

#### Step 1: Start the Backend Server
```bash
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_server

# Run the server with migrations
dart run bin/main.dart --apply-migrations
```

Expected output:
```
Starting server...
Serverpod server running on port 8080
```

#### Step 2: Run the Seed via HTTP Request

**Option A: Using cURL**
```bash
curl -X POST http://localhost:8080/api/seed/runComprehensiveSeed
```

**Option B: Using Postman**
- Method: `POST`
- URL: `http://localhost:8080/api/seed/runComprehensiveSeed`
- Body: Leave empty
- Click **Send**

**Option C: Using Flutter App**
After seeding, the app will show all 5 admin users in the auth system.

#### Step 3: Expected Response
```json
{
  "result": "PHASE 1: Organization created (PharmaTech India Pvt Ltd)...\nPHASE 2: 10 departments created...\nPHASE 3: 7 roles created...\nPHASE 4: 14 job roles created...\nPHASE 5: 15 trainers created...\nPHASE 6: 100 learners created...\nPHASE 6a: 5 admin users created...\nPHASE 6b: 6 demo users created...\nPHASE 7: 12 courses created...\nAuth provisioned: 106 created..."
}
```

---

### **Method 2: Via Database Direct SQL**

If you prefer to manually add users to the database:

#### Step 1: Connect to PostgreSQL
```bash
psql -h localhost -U postgres -d pharma_lms
```

#### Step 2: Insert Admin Users Directly

```sql
-- Insert Organization (if not exists)
INSERT INTO organization (name, code) 
VALUES ('PharmaTech India Pvt Ltd', 'PTI')
ON CONFLICT DO NOTHING;

-- Get the organization ID
SELECT id FROM organization WHERE name = 'PharmaTech India Pvt Ltd';
-- Result: Let's say it's org_id = 1

-- Get site IDs (you need these)
SELECT id, name FROM site LIMIT 5;

-- Get department IDs
SELECT id, name FROM department LIMIT 10;

-- Get role IDs
SELECT id, code FROM role;
-- You need: admin, qa_manager, auditor role IDs

-- Insert Admin User 1: Super Admin
INSERT INTO pharma_user (
  email, "firstName", "lastName", "employeeId", 
  "siteId", "departmentId", "jobRoleId", "organizationId", 
  status, "hireDate"
) VALUES (
  'super.admin@pharmacorp.demo', 'Super', 'Administrator', 'ADM-001',
  1, 1, 1, 1, 'active', NOW() - INTERVAL '730 days'
) RETURNING id;
-- Result: user_id_1 = ?

-- Link role to admin user
INSERT INTO user_role (userId, roleId) 
VALUES (user_id_1, admin_role_id);

-- Insert Admin User 2: Content Admin
INSERT INTO pharma_user (
  email, "firstName", "lastName", "employeeId", 
  "siteId", "departmentId", "jobRoleId", "organizationId", 
  status, "hireDate"
) VALUES (
  'content.admin@pharmacorp.demo', 'Content', 'Administrator', 'ADM-002',
  1, 8, 1, 1, 'active', NOW() - INTERVAL '730 days'
) RETURNING id;

-- Insert Admin User 3: QA Manager
INSERT INTO pharma_user (
  email, "firstName", "lastName", "employeeId", 
  "siteId", "departmentId", "jobRoleId", "organizationId", 
  status, "hireDate"
) VALUES (
  'qa.manager@pharmacorp.demo', 'Quality', 'Manager', 'ADM-003',
  2, 1, 1, 1, 'active', NOW() - INTERVAL '730 days'
) RETURNING id;

-- Insert Admin User 4: Training Admin
INSERT INTO pharma_user (
  email, "firstName", "lastName", "employeeId", 
  "siteId", "departmentId", "jobRoleId", "organizationId", 
  status, "hireDate"
) VALUES (
  'training.admin@pharmacorp.demo', 'Training', 'Administrator', 'ADM-004',
  3, 8, 1, 1, 'active', NOW() - INTERVAL '730 days'
) RETURNING id;

-- Insert Admin User 5: Audit Officer
INSERT INTO pharma_user (
  email, "firstName", "lastName", "employeeId", 
  "siteId", "departmentId", "jobRoleId", "organizationId", 
  status, "hireDate"
) VALUES (
  'audit.officer@pharmacorp.demo', 'Audit', 'Officer', 'ADM-005',
  5, 4, 1, 1, 'active', NOW() - INTERVAL '730 days'
) RETURNING id;

-- Verify all admins were created
SELECT id, email, "firstName", "lastName", "employeeId", status 
FROM pharma_user 
WHERE email LIKE '%@pharmacorp.demo' 
ORDER BY "employeeId";
```

---

## 🔐 Setup Authentication for Admin Users

The admin users **MUST** be provisioned with authentication accounts before they can log in.

### Step 1: Run Auth Provisioning

After seeding, run the auth provisioning to create login credentials:

```bash
curl -X POST http://localhost:8080/api/seed/provisionAuthAccounts
```

This will:
1. Create AuthUser accounts in Serverpod Auth system
2. Set up email/password authentication
3. Create user profiles so the app can read email
4. Assign the seed password: `Pharma@2024!Secure`

Expected output:
```
Auth provisioned: 111 created, 0 skipped. Default password: Pharma@2024!Secure
```

### Step 2: Create Email Credentials in PostgreSQL (Manual)

If you need to manually create auth accounts:

```sql
-- View existing auth users
SELECT id, "email" FROM serverpod_auth_core_user LIMIT 10;

-- Create a new auth user (if needed)
INSERT INTO serverpod_auth_core_user (email) 
VALUES ('super.admin@pharmacorp.demo');

-- View auth profiles
SELECT "authUserId", email FROM serverpod_auth_core_profile;

-- Link auth user to profile
INSERT INTO serverpod_auth_core_profile 
("authUserId", email, "userName", "fullName") 
VALUES (
  '..uuid..', 
  'super.admin@pharmacorp.demo',
  'super_admin',
  'Super Administrator'
) ON CONFLICT ("authUserId") DO NOTHING;
```

---

## 🧪 Testing the Admin Users

### Step 1: Start Flutter App
```bash
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_flutter

flutter run -d chrome
```

### Step 2: Log in with Admin Credentials

Navigate to: `http://localhost:5000/admin`

Test login with each admin:

| Email | Password | Expected Role | Can Access |
|-------|----------|---------------|-----------|
| `super.admin@pharmacorp.demo` | `Pharma@2024!Secure` | ADMIN | All 14 modules |
| `content.admin@pharmacorp.demo` | `Pharma@2024!Secure` | ADMIN | Content, Courses, Assessments |
| `qa.manager@pharmacorp.demo` | `Pharma@2024!Secure` | QA_MANAGER | Quality, Approvals, Compliance |
| `training.admin@pharmacorp.demo` | `Pharma@2024!Secure` | ADMIN | Enrollments, Batches, Training |
| `audit.officer@pharmacorp.demo` | `Pharma@2024!Secure` | AUDITOR | Audit, Reports, Compliance (view-only) |

### Step 3: Verify Each Admin

- [ ] Super Admin: Can access all 14 admin portal modules
- [ ] Content Admin: Can create courses, assessments, materials
- [ ] QA Manager: Can approve courses, review quality events
- [ ] Training Admin: Can enroll users, create batches
- [ ] Audit Officer: Can view audit trails and reports (read-only)

---

## 🔄 Clear and Reseed (If Needed)

If you want to delete all data and reseed from scratch:

```bash
curl -X POST http://localhost:8080/api/seed/clearAndReseed
```

This will:
1. Delete all existing PharmaTech data
2. Re-run the comprehensive seed
3. Create all 5 admin users fresh
4. Provision auth accounts

---

## 📊 What Gets Created

When you run the seed with the 5 admin users, the database will have:

### Users
- **5 Admin Users** (ADM-001 to ADM-005)
- **15 Trainer Users** (TRN-001 to TRN-015)
- **100 Learner Users** (EMP-1000 to EMP-1099)
- **6 Demo Users** (for testing)
- **Total: 126 users**

### Roles & Permissions
- Admin role: Full system access (`*` resource, `*` action)
- QA Manager role: Quality events, compliance, course approval
- Auditor role: Read-only access to all resources
- Trainer role: Course, material, assessment, training management
- Employee role: Read-only course and training access

### Organization Structure
- **1 Organization**: PharmaTech India Pvt Ltd
- **5 Sites**: Mumbai HQ, Pune, Hyderabad, Ahmedabad, Bengaluru
- **10 Departments**: QA, QC, Manufacturing, RA, PV, R&D, IT, L&D, SCM, Engineering
- **14 Job Roles**: QA Specialist, QC Analyst, Production Op, etc.

### Content
- **12 Courses**: GMP, 21 CFR Part 11, GCP, GVP, Cold Chain, etc.
- **12 Course Versions**: All at version 1.0, effective status
- **Training Matrix**: 14 mandatory training assignments
- **2 Question Banks**: For assessments
- **100+ Assessment Questions**: Various difficulty levels
- **12 SOPs**: Linked to courses for compliance

### Compliance Data
- HMAC signatures for audit integrity
- Audit trail entries for all actions
- Assessment attempts with scores
- Certificate records
- Training records with signatures
- Material progress tracking

---

## 🛠️ Troubleshooting

### Issue: Seed Endpoint Returns 404
```
Error: POST /api/seed/runComprehensiveSeed returns 404
```
**Solution**: Ensure the backend server is running on port 8080
```bash
dart run bin/main.dart --apply-migrations
```

### Issue: Auth Provisioning Fails
```
Error: Auth provisioning failed: No users found
```
**Solution**: Run the comprehensive seed FIRST
```bash
curl -X POST http://localhost:8080/api/seed/runComprehensiveSeed
```

### Issue: Admin User Can't Log In
```
Error: Email not found or password incorrect
```
**Solution**: Verify auth provisioning ran successfully
```bash
# Check database for auth user
psql -h localhost -U postgres -d pharma_lms
SELECT email FROM serverpod_auth_core_user WHERE email LIKE '%pharmacorp.demo%';
```

### Issue: Flutter App Shows "Organization Not Found"
```
Error: Could not find organization for user
```
**Solution**: Ensure the organization name matches exactly:
```sql
SELECT * FROM organization WHERE name = 'PharmaTech India Pvt Ltd';
```

### Issue: Database Connection Failed
```
Error: psycopg2.OperationalError: could not connect to server
```
**Solution**: Ensure PostgreSQL is running
```bash
# On macOS
brew services start postgresql
```

---

## 📋 File References

- **Seed File**: `/pharma_lms/pharma_lms_server/lib/src/endpoints/seed_endpoint.dart`
- **Database Schema**: `/pharma_lms/pharma_lms_server/lib/src/generated/protocol.dart`
- **Admin Portal**: `/pharma_lms/pharma_lms_flutter/lib/features/admin_portal/`
- **User Model**: Defined in protocol.dart as `PharmaUser` class

---

## 🔄 Database Tables Involved

The following tables are populated when adding admin users:

1. **pharma_user** — Main user records
   ```
   id | email | firstName | lastName | employeeId | siteId | departmentId | jobRoleId | status | hireDate
   ```

2. **user_role** — Maps users to roles
   ```
   id | userId | roleId
   ```

3. **serverpod_auth_core_user** — Auth system user accounts
   ```
   id (UUID) | email | created
   ```

4. **serverpod_auth_core_profile** — Auth system user profiles
   ```
   authUserId (UUID) | email | userName | fullName | updated
   ```

5. **audit_trail** — Tracks all data changes (HMAC signed)
   ```
   id | resourceType | resourceId | action | userId | changes | timestamp | hmacSignature
   ```

---

## ✅ Verification Checklist

After running seed and auth provisioning:

- [ ] Database contains 5 admin users with emails ending in @pharmacorp.demo
- [ ] Each admin user has a role (admin, qa_manager, auditor)
- [ ] Each admin user has an auth account in serverpod_auth_core_user
- [ ] Each auth account has a profile in serverpod_auth_core_profile
- [ ] All 5 admins can log in with password: `Pharma@2024!Secure`
- [ ] Admin portal is accessible at /admin route
- [ ] Super Admin can see all menu items
- [ ] Content Admin can create courses
- [ ] QA Manager can approve courses
- [ ] Training Admin can create enrollments
- [ ] Audit Officer can view audit trail
- [ ] Audit trail contains seed events with HMAC signatures

---

## 📞 Support

If you encounter issues:

1. **Check Seed Logs**: Backend terminal shows detailed seed progress
2. **Verify Auth Provision**: Run auth provisioning endpoint separately
3. **Check Database**: Use psql to verify users exist
4. **Check Roles**: Verify user_role mappings exist
5. **Check Auth**: Verify serverpod_auth_core_* tables are populated
6. **Review Audit Trail**: Check audit_trail table for errors

---

**Last Updated**: 21 March 2026  
**For**: PharmaTech India Pvt Ltd - Admin Portal Testing  
**Compliance**: 21 CFR Part 11, GMP Annex 11, ICH Q10
