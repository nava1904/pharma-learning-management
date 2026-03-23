# ⚡ Quick Start — Add 5 Admin Users to Database

## TL;DR — 3 Steps

### Step 1: Start Backend Server
```bash
cd /Users/navadeepreddy/Pharma\ Lms/pharma_learning_management/pharma_lms/pharma_lms_server
dart run bin/main.dart --apply-migrations
```

### Step 2: Run Seed (Creates All Users)
```bash
curl -X POST http://localhost:8080/api/seed/runComprehensiveSeed
```

### Step 3: Provision Auth (Create Login Credentials)
```bash
curl -X POST http://localhost:8080/api/seed/provisionAuthAccounts
```

---

## ✅ Done! Your 5 Admin Users Are Ready

| # | Email | Password | Role | User ID |
|---|-------|----------|------|---------|
| 1 | `super.admin@pharmacorp.demo` | `Pharma@2024!Secure` | ADMIN | ADM-001 |
| 2 | `content.admin@pharmacorp.demo` | `Pharma@2024!Secure` | ADMIN | ADM-002 |
| 3 | `qa.manager@pharmacorp.demo` | `Pharma@2024!Secure` | QA_MANAGER | ADM-003 |
| 4 | `training.admin@pharmacorp.demo` | `Pharma@2024!Secure` | ADMIN | ADM-004 |
| 5 | `audit.officer@pharmacorp.demo` | `Pharma@2024!Secure` | AUDITOR | ADM-005 |

---

## 🌐 Access Admin Portal

```
App: http://localhost:5000/admin
Backend: http://localhost:8080
```

### Test Login
1. Enter email: `super.admin@pharmacorp.demo`
2. Enter password: `Pharma@2024!Secure`
3. Click Login

---

## 📁 What Was Modified

**File**: `/pharma_lms/pharma_lms_server/lib/src/endpoints/seed_endpoint.dart`

**Added**: PHASE 6a section with 5 admin users

The seed now creates:
- ✅ 5 Admin Users
- ✅ 15 Trainers
- ✅ 100 Learners
- ✅ 6 Demo Users
- ✅ 12 Courses
- ✅ Full Compliance Data

---

## 🗄️ Database Info

**Database**: `pharma_lms`
**Server**: `localhost:5432`
**Tables Updated**:
- `pharma_user` (5 new admin rows)
- `user_role` (5 new role mappings)
- `serverpod_auth_core_user` (5 new auth users)
- `serverpod_auth_core_profile` (5 new profiles)

---

## 🔄 Reset Database (If Needed)

```bash
# Clear everything and reseed
curl -X POST http://localhost:8080/api/seed/clearAndReseed
```

---

## 📖 Full Guide

See: `/ADD_ADMIN_USERS_GUIDE.md` for detailed instructions and troubleshooting

---

## ✨ Admin Permissions

### Super Admin (ADM-001)
- ✅ Access all 14 admin modules
- ✅ Create/delete users
- ✅ Create courses
- ✅ Configure system
- ✅ View all reports

### Content Admin (ADM-002)
- ✅ Create & manage courses
- ✅ Create assessments
- ✅ Upload materials
- ✅ Link SOPs

### QA Manager (ADM-003)
- ✅ Approve course versions
- ✅ Override assessments
- ✅ Issue certificates
- ✅ Manage CAPAs

### Training Admin (ADM-004)
- ✅ Enroll users
- ✅ Create batches
- ✅ Assign training
- ✅ View training analytics

### Audit Officer (ADM-005)
- ✅ View audit trail
- ✅ Generate compliance reports
- ✅ View e-signatures
- ✅ Export inspection packages
- ❌ Cannot modify any data

---

**All Done!** 🎉 Your admin users are seeded and ready to test the admin portal.
