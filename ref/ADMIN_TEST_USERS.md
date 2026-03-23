# 🔐 Admin Portal Test Users — Complete Guide

## Overview
These 5 admin users cover all major Admin Portal modules (US-ADM-* specifications). Use these credentials to fully test the Admin Portal functionality.

**Seed Password for All Users**: `Pharma@2024!Secure`

---

## 1️⃣ Super Admin — Complete System Access

| Property | Value |
|----------|-------|
| **Email** | `super.admin@pharmacorp.demo` |
| **First Name** | Super |
| **Last Name** | Administrator |
| **Employee ID** | ADM-001 |
| **Role** | SUPER_ADMIN |
| **Password** | `Pharma@2024!Secure` |
| **User ID** | 1 |
| **Permissions** | `*` (all resources, all actions) |
| **Organization** | PharmaTech India Pvt Ltd |
| **Site** | Mumbai HQ |
| **Department** | Quality Assurance |

### What This User Can Do (All 14 Modules)
- ✅ **Module 1**: Create/deactivate users, manage roles, SSO/LDAP config, security policy, org hierarchy, access reviews
- ✅ **Module 2**: Create courses, upload SCORM, manage versions, approval workflows, catalogues, retire courses, SOP linking
- ✅ **Module 3**: Individual enrollments, bulk enrollments, auto-enrollment rules, modify enrollments, cancel, re-enroll, transcripts
- ✅ **Module 4**: Create batches, activate, monitor progress, add/remove members, clone, generate reports
- ✅ **Module 5**: Create job specs, assign specs, training matrix, gap analysis, renewal schedules, compliance reports
- ✅ **Module 6**: Build question bank, create assessments, review attempts, override results, min time enforcement, proctoring, analytics
- ✅ **Module 7**: Manage cert templates, configure auto-issuance, manual issuance, revocation, expiry monitoring, bulk register
- ✅ **Module 8**: Upload SOPs, approval workflows, department assignments, track acknowledgements, supersession, reports, retention
- ✅ **Module 9**: Compliance dashboards, gap reports, regulatory reports, scheduled reports, CAPA impact analysis, traceability matrix
- ✅ **Module 10**: Audit trail search, HMAC integrity verification, CAPA management, e-signature verification, session audit, inspection package
- ✅ **Module 11**: Notification templates, reminder rules, broadcast announcements, escalation chains, delivery logs, preferences
- ✅ **Module 12**: Analytics dashboards, custom reports, predictive forecasting, ROI analysis, benchmarking
- ✅ **Module 13**: System config (branding, timezone), HR integration, API key management, Kafka config, system health, validation docs, backup/DR
- ✅ **Module 14**: Data retention policies, GDPR/DSAR handling, data export, data classification, lineage reporting

### Test Scenario
```
Login with super.admin@pharmacorp.demo / Pharma@2024!Secure
→ Verify all menu items visible
→ Create a test user (Module 1)
→ Create a test course (Module 2)
→ Enroll test user in course (Module 3)
→ Generate compliance report (Module 9)
→ Export audit trail (Module 10)
```

---

## 2️⃣ Content Administrator — Course & Assessment Management

| Property | Value |
|----------|-------|
| **Email** | `content.admin@pharmacorp.demo` |
| **First Name** | Content |
| **Last Name** | Administrator |
| **Employee ID** | ADM-002 |
| **Role** | CONTENT_ADMIN |
| **Password** | `Pharma@2024!Secure` |
| **User ID** | 2 |
| **Permissions** | `write:courses, write:assessments, write:materials, read:*` |
| **Organization** | PharmaTech India Pvt Ltd |
| **Site** | Mumbai HQ |
| **Department** | Training & Development |

### What This User Can Do
- ✅ **Module 2**: Create courses, upload SCORM, manage versions, approval workflows, catalogues, retire courses, link to SOPs
- ✅ **Module 5**: Create job specs, training matrix editing, version control
- ✅ **Module 6**: Build question bank, create assessments, view analytics
- ✅ **Module 8**: Upload SOPs, manage document workflows (as Author), link courses to SOPs
- ✅ **Module 12**: Analytics dashboards (read-only)
- ❌ Cannot: Create users, manage enrollments, override assessments, revoke certificates

### Test Scenario
```
Login with content.admin@pharmacorp.demo / Pharma@2024!Secure
→ Create a new SCORM course (Module 2 - US-ADM-CRS-001)
→ Upload a SCORM package (Module 2 - US-ADM-CRS-002)
→ Create assessment questions (Module 6 - US-ADM-ASS-001)
→ View question difficulty analytics (Module 6 - US-ADM-ASS-007)
→ Create job specification (Module 5 - US-ADM-JOB-001)
```

---

## 3️⃣ QA Manager — Quality & Compliance Authority

| Property | Value |
|----------|-------|
| **Email** | `qa.manager@pharmacorp.demo` |
| **First Name** | Quality|
| **Last Name** | Manager |
| **Employee ID** | ADM-003 |
| **Role** | QA_REVIEWER |
| **Password** | `Pharma@2024!Secure` |
| **User ID** | 3 |
| **Permissions** | `write:quality_events, write:certificates, write:compliance, read:*` |
| **Organization** | PharmaTech India Pvt Ltd |
| **Site** | Pune Manufacturing |
| **Department** | Quality Assurance |

### What This User Can Do
- ✅ **Module 2**: Approve/reject course versions in workflow
- ✅ **Module 6**: Override assessment results (with two-person rule), view all attempts
- ✅ **Module 7**: Issue manual certificates, revoke certificates (with two-person rule), manage cert registers
- ✅ **Module 8**: Approve SOP workflows, manage document acknowledgements
- ✅ **Module 9**: Generate compliance reports, CAPA-linked impact analysis, traceability matrix
- ✅ **Module 10**: CAPA management, create CAPAs, close CAPAs, view audit trail
- ✅ **Module 12**: View compliance analytics and dashboards
- ❌ Cannot: Create users, create enrollments (can only view), modify system config

### Test Scenario
```
Login with qa.manager@pharmacorp.demo / Pharma@2024!Secure
→ Approve a pending course version (Module 2)
→ Review an assessment override request (Module 6)
→ Issue a manual certificate (Module 7)
→ Create and track a CAPA (Module 10 - US-ADM-AUD-003)
→ Generate compliance gap report (Module 9 - US-ADM-RPT-002)
→ Review audit trail for integrity (Module 10 - US-ADM-AUD-001)
```

---

## 4️⃣ Training Administrator — Enrollment & Batch Management

| Property | Value |
|----------|-------|
| **Email** | `training.admin@pharmacorp.demo` |
| **First Name** | Training |
| **Last Name** | Administrator |
| **Employee ID** | ADM-004 |
| **Role** | ADMIN |
| **Password** | `Pharma@2024!Secure` |
| **User ID** | 4 |
| **Permissions** | `write:enrollments, write:batches, read:courses, read:users, read:*` |
| **Organization** | PharmaTech India Pvt Ltd |
| **Site** | Hyderabad R&D |
| **Department** | Training & Development |

### What This User Can Do
- ✅ **Module 1**: View and manage users (cannot create super admins)
- ✅ **Module 3**: Individual enrollments, bulk CSV enrollments, modify/cancel enrollments, re-enroll, view transcripts
- ✅ **Module 4**: Create training batches, activate batches, monitor progress, add/remove members, clone batches, generate reports
- ✅ **Module 5**: Assign job specs to employees, view training matrix, run gap analysis, manage renewal schedules
- ✅ **Module 9**: Compliance dashboards, gap reports, view scheduled reports
- ✅ **Module 11**: Send batch reminders, announcements
- ✅ **Module 12**: View training analytics
- ❌ Cannot: Create courses, approve course versions, override assessments, modify system config

### Test Scenario
```
Login with training.admin@pharmacorp.demo / Pharma@2024!Secure
→ Create a training batch (Module 4 - US-ADM-BAT-001)
→ Bulk-enroll employees via CSV (Module 3 - US-ADM-ENR-003)
→ Activate batch and view progress (Module 4 - US-ADM-BAT-002 & BAT-003)
→ Assign job spec to employee (Module 5 - US-ADM-JOB-002)
→ Run gap analysis (Module 5 - US-ADM-JOB-004)
→ Send overdue reminder (Module 11)
```

---

## 5️⃣ Audit & Compliance Officer — Regulatory & Governance

| Property | Value |
|----------|-------|
| **Email** | `audit.officer@pharmacorp.demo` |
| **First Name** | Audit |
| **Last Name** | Officer |
| **Employee ID** | ADM-005 |
| **Role** | AUDITOR |
| **Password** | `Pharma@2024!Secure` |
| **User ID** | 5 |
| **Permissions** | `read:*, write:audit_trail, write:reports` |
| **Organization** | PharmaTech India Pvt Ltd |
| **Site** | Bengaluru Biotech |
| **Department** | Regulatory Affairs |

### What This User Can Do
- ✅ **Module 9**: Generate all compliance reports, regulatory reports, traceability matrix, scheduled reports (read-only config)
- ✅ **Module 10**: Search audit trail, run HMAC integrity verification, view e-signature records, generate inspection packages, session audit reports
- ✅ **Module 12**: View all analytics dashboards and custom reports
- ✅ **Module 13**: View system health and validation documentation
- ✅ **Module 14**: View data lineage reports, generate GDPR data exports, data classification review
- ✅ **Module 8**: View SOP acknowledgement reports (read-only)
- ✅ **Module 7**: View certificate registers (read-only)
- ❌ Cannot: Modify anything, create users, modify courses, approve workflows, override assessments

### Test Scenario
```
Login with audit.officer@pharmacorp.demo / Pharma@2024!Secure
→ Search audit trail for a specific event (Module 10 - US-ADM-AUD-001)
→ Run HMAC integrity verification (Module 10 - US-ADM-AUD-002)
→ Generate FDA inspection package (Module 10 - US-ADM-AUD-006)
→ Export certificate register (Module 7 - US-ADM-CRT-006)
→ View compliance dashboard (Module 9 - US-ADM-RPT-001)
→ Generate regulatory traceability matrix (Module 9 - US-ADM-RPT-006)
→ Check system health and validation docs (Module 13 - US-ADM-SYS-005 & SYS-006)
```

---

## Quick Login Reference Table

```
╔════════════════════════════════════════════════════════════════════════════════╗
║ Role             │ Email                          │ Password                   ║
╠════════════════════════════════════════════════════════════════════════════════╣
║ SUPER_ADMIN      │ super.admin@pharmacorp.demo    │ Pharma@2024!Secure       ║
║ CONTENT_ADMIN    │ content.admin@pharmacorp.demo   │ Pharma@2024!Secure       ║
║ QA_REVIEWER      │ qa.manager@pharmacorp.demo     │ Pharma@2024!Secure       ║
║ ADMIN            │ training.admin@pharmacorp.demo │ Pharma@2024!Secure       ║
║ AUDITOR          │ audit.officer@pharmacorp.demo  │ Pharma@2024!Secure       ║
╚════════════════════════════════════════════════════════════════════════════════╝
```

---

## Module Coverage by User

| Module | Super Admin | Content Admin | QA Manager | Training Admin | Auditor |
|--------|:-----------:|:-------------:|:----------:|:--------------:|:-------:|
| 1 - Users & Identity | ✅ Full | — | — | ⚠️ View | — |
| 2 - Courses & Content | ✅ Full | ✅ Full | ✅ Approve | — | ⚠️ View |
| 3 - Enrollments | ✅ Full | — | — | ✅ Full | ⚠️ View |
| 4 - Batches & Cohorts | ✅ Full | — | — | ✅ Full | ⚠️ View |
| 5 - Job Specs & Matrix | ✅ Full | ✅ Full | — | ✅ Full | ⚠️ View |
| 6 - Assessments | ✅ Full | ✅ Full | ✅ Override | — | ⚠️ View |
| 7 - Certificates | ✅ Full | — | ✅ Full | — | ⚠️ View |
| 8 - SOPs & Documents | ✅ Full | ✅ Create | ✅ Approve | — | ⚠️ View |
| 9 - Compliance & Gaps | ✅ Full | ⚠️ View | ✅ Full | ⚠️ View | ✅ Full |
| 10 - Audit & CAPA | ✅ Full | — | ✅ CAPA | — | ✅ Full |
| 11 - Notifications | ✅ Full | — | — | ✅ Send | ⚠️ View |
| 12 - Analytics & BI | ✅ Full | ⚠️ View | ⚠️ View | ⚠️ View | ✅ Full |
| 13 - System Config | ✅ Full | — | — | — | ⚠️ View |
| 14 - Data Governance | ✅ Full | — | — | — | ✅ Full |

Legend: ✅ Full = Full access | ⚠️ View = Read-only | — = No access

---

## Test Execution Order (Recommended)

### 1. **Foundation Setup** (Use: Super Admin)
```
1. Module 13 - System Config (timezone, branding, HR integration)
2. Module 1 - Create departments, sites, users
3. Module 13 - Validate system health
```

### 2. **Content Creation** (Use: Content Admin)
```
1. Module 2 - Create courses and upload SCORM
2. Module 6 - Build question bank and assessments
3. Module 5 - Create job specifications
4. Module 8 - Upload SOPs
```

### 3. **Quality Assurance** (Use: QA Manager)
```
1. Module 2 - Approve course versions
2. Module 8 - Approve SOP workflows
3. Module 7 - Issue a manual certificate
4. Module 10 - Create test CAPA
```

### 4. **Training Delivery** (Use: Training Admin)
```
1. Module 3 - Enroll test users individually
2. Module 3 - Bulk enroll via CSV
3. Module 4 - Create and activate a training batch
4. Module 5 - Assign job spec to employee
5. Module 9 - Run gap analysis
```

### 5. **Compliance Verification** (Use: Audit Officer)
```
1. Module 10 - Search audit trail for all changes
2. Module 10 - Run HMAC integrity verification
3. Module 9 - Generate compliance report
4. Module 10 - Generate inspection package
```

---

## Additional Test Data Available

When you run the seed, these entities are also created:

### Courses (12 total, ready for enrollment)
- GMP Fundamentals
- Quality Systems & Procedures
- Environmental Monitoring
- Microbiology Essentials
- HVAC & Cleanroom Management
- Laboratory Quality Systems
- Complaint Handling & CAPA
- Document Control & SOP Management
- Safety & Hazard Communication
- Validation & Change Control
- Equipment Maintenance & Qualification
- Regulatory Affairs & Compliance

### Sites (5 total)
- Mumbai HQ
- Pune Manufacturing
- Hyderabad R&D
- Ahmedabad API
- Bengaluru Biotech

### Departments (10 total)
- Quality Assurance
- Manufacturing
- Research & Development
- Regulatory Affairs
- Training & Development
- Operations
- Safety & Hygiene
- Microbiology
- Warehousing & Logistics
- Administration

### Learner Employees (100 total)
- EMP-001 to EMP-100
- Pre-enrolled in various courses
- Mix of completed, in-progress, and overdue statuses

---

## 🔑 Important Notes

1. **Password**: All users have the same seed password: `Pharma@2024!Secure`
   - Users should change password on first login (enforced by MFA policy)

2. **Two-Person Rule**:
   - Certificate revocation requires approval from different admin
   - SUPER_ADMIN role assignment requires dual approval
   - Assessment override requires QA_REVIEWER + SUPER_ADMIN approval

3. **Audit Trail**:
   - Every action by these admins is logged in audit_trail table
   - Search via Module 10 - US-ADM-AUD-001

4. **HMAC Integrity**:
   - All audit records use HMAC-SHA256 for tamper detection
   - Verify with Module 10 - US-ADM-AUD-002

5. **Session Timeout**:
   - Default idle timeout: 15 minutes
   - MFA enforced for ADMIN, AUDITOR, QA_REVIEWER roles
   - Failed login lockout: 3 attempts

---

## Quick Start Commands

### For Backend Testing
```bash
# Apply migrations and seed data
cd pharma_lms/pharma_lms_server
dart run bin/main.dart --apply-migrations

# Run seed
curl -X POST http://localhost:8080/seed/runComprehensiveSeed
```

### For Frontend Testing
```bash
# Start Flutter web app
cd pharma_lms/pharma_lms_flutter
flutter run -d chrome

# Navigate to Admin Portal
# http://localhost:5000/admin
```

---

## Verification Checklist

After running seed, verify:

- [ ] All 5 admin users exist in database
- [ ] Super Admin can access all 14 modules
- [ ] Content Admin can create courses but not enroll users
- [ ] QA Manager can approve workflows but not create courses
- [ ] Training Admin can enroll users but not create courses
- [ ] Audit Officer can view reports but not modify data
- [ ] Audit trail contains seed events (HMAC verified)
- [ ] Each user sees correct menu items based on role
- [ ] 100 learner employees created with enrollments
- [ ] 12 courses in ACTIVE status
- [ ] 5 sites with timezones configured
- [ ] 10 departments with heads assigned
- [ ] 12 SOPs in ACTIVE status
- [ ] 2 standalone question banks created
- [ ] Compliance dashboard shows data

---

## Support

If you encounter issues:

1. Check audit trail (Module 10) for error events
2. Review system health dashboard (Module 13)
3. Verify HMAC integrity (Module 10 - US-ADM-AUD-002)
4. Check database connection and S3/MinIO access
5. Verify Kafka consumer lag is healthy

---

**Generated**: 21 March 2026  
**For**: PharmaTech India Pvt Ltd - Admin Portal Complete Testing  
**Compliance**: 21 CFR Part 11, GMP Annex 11, ICH Q10
