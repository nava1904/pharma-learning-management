# ⚡ Command Reference - 5 Admin Users

## Copy-Paste Commands

### 1️⃣ Start Backend Server

```bash
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_server
dart run bin/main.dart --apply-migrations
```

**Expected Output**:
```
Serverpod server running on port 8080
```

---

### 2️⃣ Seed All Data (Creates 5 Admins)

```bash
curl -X POST http://localhost:8080/api/seed/runComprehensiveSeed
```

**Expected Output**:
```json
{
  "result": "PHASE 1: Organization created...\nPHASE 6a: 5 admin users created..."
}
```

---

### 3️⃣ Provision Auth Accounts (Create Login Credentials)

```bash
curl -X POST http://localhost:8080/api/seed/provisionAuthAccounts
```

**Expected Output**:
```json
{
  "result": "Auth provisioned: 111 created, 0 skipped. Default password: Pharma@2024!Secure"
}
```

---

### 4️⃣ Start Flutter App

```bash
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_flutter
flutter run -d chrome
```

**Navigate to**: `http://localhost:5000/admin`

---

## 5 Admin Credentials

```
┌────────────────────────────────────────────────────────────┐
│              LOGIN CREDENTIALS (Copy-Paste)                │
├────────────────────────────────────────────────────────────┤
│                                                            │
│ 1. SUPER ADMIN                                            │
│    Email:    super.admin@pharmacorp.demo                 │
│    Password: Pharma@2024!Secure                           │
│                                                            │
│ 2. CONTENT ADMIN                                          │
│    Email:    content.admin@pharmacorp.demo               │
│    Password: Pharma@2024!Secure                           │
│                                                            │
│ 3. QA MANAGER                                             │
│    Email:    qa.manager@pharmacorp.demo                  │
│    Password: Pharma@2024!Secure                           │
│                                                            │
│ 4. TRAINING ADMIN                                         │
│    Email:    training.admin@pharmacorp.demo              │
│    Password: Pharma@2024!Secure                           │
│                                                            │
│ 5. AUDIT OFFICER                                          │
│    Email:    audit.officer@pharmacorp.demo               │
│    Password: Pharma@2024!Secure                           │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

## Database Verification Commands

### Check if Admins Were Created

```bash
psql -h localhost -U postgres -d pharma_lms -c \
"SELECT email, \"firstName\", \"lastName\", \"employeeId\" FROM pharma_user 
WHERE email LIKE '%@pharmacorp.demo' AND \"employeeId\" LIKE 'ADM-%' 
ORDER BY \"employeeId\";"
```

**Expected Output**:
```
              email               | firstName |  lastName  | employeeId
----------------------------------+-----------+------------+----------
 super.admin@pharmacorp.demo      | Super     | Adm...     | ADM-001
 content.admin@pharmacorp.demo    | Content   | Adm...     | ADM-002
 qa.manager@pharmacorp.demo       | Quality   | Manager    | ADM-003
 training.admin@pharmacorp.demo   | Training  | Adm...     | ADM-004
 audit.officer@pharmacorp.demo    | Audit     | Officer    | ADM-005
(5 rows)
```

### Check Auth Accounts

```bash
psql -h localhost -U postgres -d pharma_lms -c \
"SELECT email FROM serverpod_auth_core_user 
WHERE email LIKE '%@pharmacorp.demo%' AND email LIKE 'ADM-%';"
```

---

## Reset / Reseed Database

### Clear Everything and Reseed

```bash
curl -X POST http://localhost:8080/api/seed/clearAndReseed
```

This will:
1. Delete all PharmaTech data
2. Re-seed everything fresh
3. Create all 5 admin users again
4. Provision auth accounts

---

## URLs Reference

| Service | URL |
|---------|-----|
| Backend API | `http://localhost:8080` |
| Seed Endpoint | `http://localhost:8080/api/seed/runComprehensiveSeed` |
| Auth Endpoint | `http://localhost:8080/api/seed/provisionAuthAccounts` |
| Admin Portal | `http://localhost:5000/admin` |
| Employee Portal | `http://localhost:5000/employee` |
| Trainer Portal | `http://localhost:5000/trainer` |

---

## Troubleshooting Commands

### Check if Backend is Running

```bash
curl http://localhost:8080/api/seed/runComprehensiveSeed -v
```

If it returns 404 → Backend not running → Start with Step 1

### Check Database Connection

```bash
psql -h localhost -U postgres -d pharma_lms -c "SELECT 1;"
```

If it fails → PostgreSQL not running
```bash
brew services start postgresql
```

### View Server Logs

In terminal where backend is running, you'll see:
- Seed progress
- Auth provisioning logs
- Any errors with details

### Count Total Users

```bash
psql -h localhost -U postgres -d pharma_lms -c \
"SELECT COUNT(*) as total_users FROM pharma_user WHERE \"organizationId\" = 1;"
```

Expected: `126` (5 admin + 15 trainer + 100 learner + 6 demo)

---

## Files Created

1. **QUICK_START_ADMINS.md** — Quick start guide
2. **ADD_ADMIN_USERS_GUIDE.md** — Detailed step-by-step guide
3. **ADMIN_USERS_SQL.sql** — SQL script for manual insertion
4. **ADMIN_TEST_USERS.md** — Admin testing guide with 14 modules
5. **ADMIN_USERS_SUMMARY.md** — Complete implementation summary
6. **ADMIN_USERS_VISUAL_GUIDE.md** — Visual diagrams and flows
7. **QUICK_COMMAND_REFERENCE.md** — This file

---

## Modified Files

**File**: `/pharma_lms/pharma_lms_server/lib/src/endpoints/seed_endpoint.dart`

**Change**: Added PHASE 6a with 5 admin users
- Lines: ~410-450 (approximately)
- Status: ✅ No compilation errors

---

## One-Liner Commands

### Quick Test (All 3 Steps in Order)

```bash
# Step 1: Backend (in Terminal 1)
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_server && \
dart run bin/main.dart --apply-migrations

# Step 2: Seed (in Terminal 2, wait 10 seconds for backend to start)
sleep 10 && curl -X POST http://localhost:8080/api/seed/runComprehensiveSeed && \
echo "\n\n✅ Seed completed!\n" && \
curl -X POST http://localhost:8080/api/seed/provisionAuthAccounts && \
echo "\n\n✅ Auth provisioned!"

# Step 3: Flutter App (in Terminal 3)
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_flutter && \
flutter run -d chrome
```

---

## Test Flow Checklist

- [ ] Backend started on port 8080
- [ ] Seed completed successfully
- [ ] Auth provisioning completed
- [ ] Flutter app running on port 5000
- [ ] Navigate to http://localhost:5000/admin
- [ ] Log in with super.admin@pharmacorp.demo / Pharma@2024!Secure
- [ ] Verify Super Admin sees all menu items
- [ ] Log out
- [ ] Log in with content.admin@pharmacorp.demo
- [ ] Verify Content Admin sees course creation menu
- [ ] Log out
- [ ] Log in with qa.manager@pharmacorp.demo
- [ ] Verify QA Manager sees approval workflows
- [ ] Log out
- [ ] Log in with training.admin@pharmacorp.demo
- [ ] Verify Training Admin sees enrollment menu
- [ ] Log out
- [ ] Log in with audit.officer@pharmacorp.demo
- [ ] Verify Audit Officer sees audit trail and reports
- [ ] ✅ All 5 admins working!

---

## Quick Facts

- **Total Admins**: 5
- **Total Users Created**: 126 (all roles)
- **Default Password**: `Pharma@2024!Secure`
- **Backend Port**: 8080
- **Frontend Port**: 5000
- **Database**: pharma_lms (PostgreSQL)
- **Compilation Status**: ✅ 0 errors
- **Ready for Testing**: ✅ Yes

---

**That's it! You're all set.** 🎉

Copy any command above and paste in your terminal to proceed.
