# Quick Start: Building Module 1 Screens (Session 18+)

## Template for Each Module 1 Screen (Copy & Paste)

### Pattern
Every screen in Module 1 follows this exact structure:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers.dart';

/// Module 1: User & Identity Management
/// Screen N/8: [SCREEN_NAME]
/// 
/// Description: [1-2 sentences about what this screen does]
/// User Stories: [List relevant US-ADM-USR-XXX]
/// Database Tables: [Which tables this screen reads/writes]
class [SCREEN_NAME]Screen extends ConsumerWidget {
  const [SCREEN_NAME]Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch provider
    final dataAsync = ref.watch([PROVIDER_NAME]);

    return Scaffold(
      appBar: AppBar(title: const Text('[SCREEN_TITLE]')),
      body: dataAsync.when(
        data: (data) => _buildContent(context, ref, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, dynamic data) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Title', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.md),
            
            // Content
            // TODO: Add your content here
          ],
        ),
      ),
    );
  }
}
```

## Files to Create for Each Screen

| Screen | File Path | Status |
|--------|-----------|--------|
| User Management | ✅ `modules/01_user_identity/user_management_screen.dart` | DONE |
| User Create | 📄 `modules/01_user_identity/user_create_screen.dart` | TODO |
| User Edit | 📄 `modules/01_user_identity/user_edit_screen.dart` | TODO |
| User View | 📄 `modules/01_user_identity/user_view_screen.dart` | TODO |
| User Role Assignment | 📄 `modules/01_user_identity/user_role_assignment_screen.dart` | TODO |
| Bulk User Import | 📄 `modules/01_user_identity/user_bulk_import_screen.dart` | TODO |
| User Audit Trail | 📄 `modules/01_user_identity/user_audit_screen.dart` | TODO |
| User Access Logs | 📄 `modules/01_user_identity/user_access_logs_screen.dart` | TODO |

## Endpoints to Add to `admin_endpoint.dart`

Add these methods to the existing `AdminEndpoint` class (around line 1000+):

### Method Template
```dart
/// [ACTION]: [DESCRIPTION]
/// 
/// User Stories: [US-ADM-XXX]
/// Database: [TABLE NAMES]
/// Audit: Logged as [ACTION_TYPE]
Future<[RETURN_TYPE]> [methodName](
  Session session, {
  required [TYPE] param1,
  String? optionalParam,
}) async {
  // 1. RBAC check
  await RbacHelper.requirePermission(session, resource: 'user', action: 'read');

  // 2. Validation
  if (param1.isEmpty) throw Exception('param1 required');

  // 3. Query/Mutation
  final result = await PharmaUser.db.find(
    session,
    where: (t) => t.id.equals(1),
  );

  // 4. Audit log
  await AuditService.log(
    session,
    entityType: 'pharma_user',
    entityId: result.id.toString(),
    action: AuditEventType.entityRead,
  );

  return result;
}
```

## Routes to Add to GoRouter

Add to your router configuration (main.dart or router.dart):

```dart
GoRoute(
  path: '/admin/users',
  pageBuilder: (context, state) => const MaterialPage(
    child: UserManagementScreen(),
  ),
  routes: [
    GoRoute(
      path: 'create',
      pageBuilder: (context, state) => const MaterialPage(
        child: UserCreateScreen(),
      ),
    ),
    GoRoute(
      path: ':id/edit',
      pageBuilder: (context, state) {
        final userId = int.parse(state.pathParameters['id']!);
        return MaterialPage(
          child: UserEditScreen(userId: userId),
        );
      },
    ),
    GoRoute(
      path: ':id/view',
      pageBuilder: (context, state) {
        final userId = int.parse(state.pathParameters['id']!);
        return MaterialPage(
          child: UserViewScreen(userId: userId),
        );
      },
    ),
    GoRoute(
      path: ':id/roles',
      pageBuilder: (context, state) {
        final userId = int.parse(state.pathParameters['id']!);
        return MaterialPage(
          child: UserRoleAssignmentScreen(userId: userId),
        );
      },
    ),
    GoRoute(
      path: 'audit',
      pageBuilder: (context, state) => const MaterialPage(
        child: UserAuditScreen(),
      ),
    ),
    GoRoute(
      path: 'access-logs',
      pageBuilder: (context, state) => const MaterialPage(
        child: UserAccessLogsScreen(),
      ),
    ),
    GoRoute(
      path: 'bulk-import',
      pageBuilder: (context, state) => const MaterialPage(
        child: UserBulkImportScreen(),
      ),
    ),
  ],
)
```

## Checklist for Each New Screen

Before committing, verify:

- [ ] **Imports:** Design system, providers, router all imported
- [ ] **Colors:** All colors use `PharmaColors.*` tokens
- [ ] **Spacing:** All padding/margins use `PharmaSpacing.*`
- [ ] **Typography:** All text styles use `PharmaTypography.*`
- [ ] **Compilation:** Run `flutter analyze` - 0 errors
- [ ] **Provider:** Connected to correct provider with `ref.watch()`
- [ ] **Loading State:** Shows `CircularProgressIndicator` while loading
- [ ] **Error State:** Shows error message if query fails
- [ ] **Empty State:** Shows empty state if no data
- [ ] **Responsive:** Layout adjusts for mobile/tablet/desktop
- [ ] **Accessibility:** All buttons have `tooltip:` and proper `onPressed`
- [ ] **Form Validation:** Input fields validate on submit
- [ ] **Success Toast:** Show snackbar on successful mutation
- [ ] **Audit Logging:** Endpoint logs all mutations to audit_trail

## Common Color Usage

```dart
// Status indicators
PharmaColors.success        // Green - Active, Approved
PharmaColors.warning        // Orange - Pending, Warning
PharmaColors.danger         // Red - Error, Deactivated
PharmaColors.info           // Blue - Info, In Progress

// Light backgrounds (chips, tags)
PharmaColors.successBg      // Light green
PharmaColors.warningBg      // Light orange
PharmaColors.dangerBg       // Light red
PharmaColors.infoBg         // Light blue

// Cards & containers
PharmaColors.cardBg         // White
PharmaColors.pageBg         // Light gray

// Text
PharmaColors.textPrimary    // Dark gray - Headings
PharmaColors.textSecondary  // Medium gray - Body text
PharmaColors.textTertiary   // Light gray - Helper text

// Buttons & CTAs
PharmaColors.primary        // Emerald - Primary action
```

## Common Spacing Usage

```dart
// Gaps between sections
PharmaSpacing.sectionGap    // 32px - Between major sections

// Gaps between elements
PharmaSpacing.md            // 16px - Between rows, form fields
PharmaSpacing.sm            // 8px - Small gaps
PharmaSpacing.xs            // 4px - Minimal gaps

// Card/Container padding
PharmaSpacing.cardPadding   // 24px - Inside cards, dialogs

// Use examples:
SizedBox(height: PharmaSpacing.sectionGap)
EdgeInsets.all(PharmaSpacing.cardPadding)
EdgeInsets.symmetric(horizontal: PharmaSpacing.md)
```

## Common Provider Pattern

```dart
// Read-only (fetch data)
final usersAsync = ref.watch(adminUsersListProvider);

// Mutations (create/update/delete)
ref.watch(adminCreateUserProvider);

// Usage in UI:
usersAsync.when(
  data: (users) => _buildUserList(users),
  loading: () => const CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

## Form Validation Example

```dart
// Validate email
if (!email.contains('@')) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Invalid email')),
  );
  return;
}

// Validate non-empty
if (name.trim().isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Name required')),
  );
  return;
}

// Call endpoint
try {
  await ref.read(adminCreateUserProvider.notifier).createUser(
    email: email,
    name: name,
  );
  if (context.mounted) {
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User created successfully')),
    );
  }
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')),
  );
}
```

## DataTable Example (User Management)

```dart
DataTable(
  columns: const [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('Status')),
    DataColumn(label: Text('Actions')),
  ],
  rows: users.map((user) {
    return DataRow(
      cells: [
        DataCell(Text(user.name)),
        DataCell(Text(user.email)),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: PharmaSpacing.sm,
              vertical: PharmaSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: user.isActive ? PharmaColors.successBg : PharmaColors.warningBg,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Text(
              user.isActive ? 'Active' : 'Inactive',
              style: PharmaTypography.caption,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push('/admin/users/${user.id}/edit'),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outlined),
                onPressed: () => _confirmDelete(context, user),
              ),
            ],
          ),
        ),
      ],
    );
  }).toList(),
)
```

## Testing Endpoints Locally

```bash
# 1. Start local Serverpod server
cd pharma_lms/pharma_lms_server
dart run serverpod serve --mode development

# 2. In Flutter app, test endpoint
final result = await client.admin.listUsers(
  role: null,
  status: 'active',
  department: null,
  page: 1,
  perPage: 10,
);
print('Users: ${result.length}');
```

## Quick Command Reference

```bash
# Format all Dart files
dart format lib/

# Check for compilation errors
flutter analyze

# Run app
flutter run -d chrome

# Run specific screen
flutter run --target lib/main.dart

# Clean build
flutter clean && flutter pub get && flutter run
```

## Important Notes

1. **Always use Design System tokens** - Never hardcode colors, spacing, fonts
2. **Always add RBAC checks** - `RbacHelper.requirePermission()`
3. **Always log mutations** - `AuditService.log()`
4. **Always handle loading/error** - Show spinners and error messages
5. **Always validate input** - Check email format, non-empty, etc.
6. **Always test UI** - Run `flutter analyze` before commit
7. **Always document user stories** - Put US-ADM-XXX in comments

## Pro Tips

✅ Copy `user_management_screen.dart` as template for other list screens
✅ Copy existing form patterns from trainer portal for speed
✅ Test backend endpoints in isolation before wiring to UI
✅ Use `ref.refresh()` to manually refresh provider after mutation
✅ Use `context.pop()` to navigate back after create/edit
✅ Add `clearOnReassert` if provider should auto-refresh
✅ Test with real data from database (not mocks)
✅ Verify audit trail entries appear in database
