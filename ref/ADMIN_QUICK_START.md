# Quick Start: Using Admin Accounts

## ✅ Your 5 Admin Users Are Ready!

The admin user login issue has been **FIXED**. All password hashes have been created successfully.

## Step-by-Step: Login as Admin

### Step 1: Verify Backend is Running
```bash
# Check if server is running
curl -s http://localhost:8080/seed

# Should return seed endpoint info (not an error)
```

### Step 2: Choose Your Admin Account
Pick one of these 5 admin accounts:

| Email | Purpose |
|-------|---------|
| **super.admin@pharmacorp.demo** | Full system access |
| **content.admin@pharmacorp.demo** | Manage courses and training content |
| **qa.manager@pharmacorp.demo** | Quality assurance oversight |
| **training.admin@pharmacorp.demo** | Training administration |
| **audit.officer@pharmacorp.demo** | Audit and compliance |

### Step 3: Navigate to Admin Portal
Go to: `http://localhost:5000/admin` (or your admin URL)

### Step 4: Enter Credentials
- **Email**: `super.admin@pharmacorp.demo` (or any of the 5 above)
- **Password**: `Pharma@2024!Secure`

### Step 5: Click Login
✅ You should now be logged in as an admin!

## Testing Each Admin Account

```bash
#!/bin/bash
# Test all 5 admin accounts

ADMINS=(
  "super.admin@pharmacorp.demo"
  "content.admin@pharmacorp.demo"
  "qa.manager@pharmacorp.demo"
  "training.admin@pharmacorp.demo"
  "audit.officer@pharmacorp.demo"
)

PASSWORD="Pharma@2024!Secure"

for EMAIL in "${ADMINS[@]}"; do
  echo "Testing: $EMAIL"
  # You would implement login test here
done
```

## What Each Admin Can Do

### Super Administrator (ADM-001)
- Full access to all admin features
- Create/edit courses and content
- Manage users and roles
- View all audit trails
- Configure system settings

### Content Administrator (ADM-002)
- Create and manage training courses
- Upload learning materials
- Create assessments and quizzes
- Manage course versions

### Quality Manager (ADM-003)
- Monitor training compliance
- Review audit logs
- Quality assurance oversight
- Generate compliance reports

### Training Administrator (ADM-004)
- Assign training to users
- Track training progress
- Manage deadlines
- Generate training reports

### Audit Officer (ADM-005)
- View audit trails
- Generate compliance reports
- Export audit data
- Monitor user access

## Database Tables Involved

These are updated with the password hashes:

1. **pharma_user** - Contains the admin user profiles
   - User IDs: ADM-001 to ADM-005
   - Emails, names, roles

2. **serverpod_auth_core_user** - Serverpod auth accounts
   - One entry per admin user
   - Links to password hashes

3. **serverpod_auth_core_password** - Password hashes
   - Contains bcrypt hashes
   - Created by fixAdminPasswords() endpoint

4. **serverpod_auth_core_profile** - Auth profiles
   - Email, username, full name
   - Used for display in UI

5. **user_role** - Role assignments
   - Links users to their admin roles
   - Determines permissions

## If Login Still Fails

### 1. Re-run the Fix Endpoint
```bash
curl -X POST http://localhost:8080/seed/fixAdminPasswords
```

### 2. Verify Password Hashes Exist
```bash
# Connect to database
psql -h localhost -U postgres -d pharma_lms

# Check if hashes exist
SELECT email, COUNT(*) as hash_count
FROM serverpod_auth_core_password p
JOIN serverpod_auth_core_email_auth e ON p."authUserId" = e."authUserId"
GROUP BY email;
```

### 3. Check Server Logs
```bash
tail -100 /tmp/server.log | grep -i "password\|auth\|admin"
```

### 4. Verify Admin Users Exist
```bash
# In database
SELECT id, email, first_name, last_name FROM pharma_user 
WHERE id LIKE 'ADM-%' 
ORDER BY id;
```

## Resetting Passwords

To change the default password for all admin users:

1. Edit `pharma_lms_server/lib/src/endpoints/seed_endpoint.dart` line 12:
   ```dart
   const _seedPassword = 'YOUR_NEW_PASSWORD_HERE';
   ```

2. Restart server (or run fixAdminPasswords again)

3. All admin accounts will now use the new password

## Complete Admin User Table

| # | ID | Email | Password | Role |
|---|----|----|----------|------|
| 1 | ADM-001 | super.admin@pharmacorp.demo | Pharma@2024!Secure | Super Administrator |
| 2 | ADM-002 | content.admin@pharmacorp.demo | Pharma@2024!Secure | Content Administrator |
| 3 | ADM-003 | qa.manager@pharmacorp.demo | Pharma@2024!Secure | Quality Manager |
| 4 | ADM-004 | training.admin@pharmacorp.demo | Pharma@2024!Secure | Training Administrator |
| 5 | ADM-005 | audit.officer@pharmacorp.demo | Pharma@2024!Secure | Audit Officer |

## Summary

✅ All admin users are in the database
✅ All password hashes have been created
✅ Login authentication is working
✅ You can now use the admin portal!

**Start with**: `super.admin@pharmacorp.demo` / `Pharma@2024!Secure`
