import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';

/// User Role Assignment Screen
/// 
/// Module 1: User & Identity Management
/// Screen 5/8: Manage User Roles
/// 
/// Allows admins to assign/revoke roles for users:
/// - EMPLOYEE: Basic learner access
/// - TRAINER: Can create/manage courses
/// - ADMIN: Full system access
/// 
/// Features:
/// - Toggle role assignments
/// - View role descriptions
/// - Manage multiple roles per user
/// - Audit trail of role changes
class UserRoleAssignmentScreen extends ConsumerStatefulWidget {
  final int userId;
  final String userName;

  const UserRoleAssignmentScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  ConsumerState<UserRoleAssignmentScreen> createState() =>
      _UserRoleAssignmentScreenState();
}

class _UserRoleAssignmentScreenState
    extends ConsumerState<UserRoleAssignmentScreen> {
  late Map<String, bool> roleAssignments = {
    'EMPLOYEE': true,
    'TRAINER': false,
    'ADMIN': false,
  };

  final roleDescriptions = {
    'EMPLOYEE': 'Can access assigned courses and complete training',
    'TRAINER': 'Can create and manage courses, view learner progress',
    'ADMIN': 'Full system access, user management, reporting, configuration',
  };

  final rolePermissions = {
    'EMPLOYEE': [
      'View assigned courses',
      'Complete training modules',
      'View certificates',
      'Access training materials',
    ],
    'TRAINER': [
      'Create and edit courses',
      'Manage training materials',
      'View learner progress',
      'Generate reports',
      'Assign courses to users',
    ],
    'ADMIN': [
      'Full system access',
      'Manage users (create, edit, deactivate)',
      'Manage roles and permissions',
      'Configure system settings',
      'View audit logs',
      'Generate compliance reports',
    ],
  };

  bool isLoading = false;

  Future<void> _saveRoles() async {
    setState(() => isLoading = true);

    try {
      // TODO: Call backend endpoint to update roles
      // await ref.read(assignRoleProvider.notifier).assignRoles(
      //   widget.userId,
      //   roles: roleAssignments.entries
      //       .where((e) => e.value)
      //       .map((e) => e.key)
      //       .toList(),
      // );

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Roles updated for ${widget.userName}'),
            backgroundColor: PharmaColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating roles: $e'),
            backgroundColor: PharmaColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Roles'),
        elevation: 0,
        backgroundColor: PharmaColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Header
            Container(
              padding: EdgeInsets.all(PharmaSpacing.md),
              decoration: BoxDecoration(
                color: PharmaColors.infoBg,
                borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                border: Border.all(color: PharmaColors.info),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User: ${widget.userName}',
                    style: PharmaTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.xs),
                  Text(
                    'Select one or more roles to assign to this user',
                    style: PharmaTypography.caption,
                  ),
                ],
              ),
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Roles List
            Text(
              'Available Roles',
              style: PharmaTypography.headingMedium.copyWith(
                color: PharmaColors.primary,
              ),
            ),
            SizedBox(height: PharmaSpacing.md),
            ...roleAssignments.keys.map((role) => _buildRoleCard(role)),

            SizedBox(height: PharmaSpacing.lg),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PharmaColors.background,
                    foregroundColor: PharmaColors.textPrimary,
                    side: BorderSide(color: PharmaColors.border),
                  ),
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: PharmaSpacing.md),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PharmaColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isLoading ? null : _saveRoles,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text('Save Roles'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(String role) {
    final isSelected = roleAssignments[role]!;
    final permissions = rolePermissions[role] ?? [];

    return Card(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? PharmaColors.primary : PharmaColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(PharmaSpacing.sm),
          color: isSelected ? PharmaColors.emerald50 : PharmaColors.cardBg,
        ),
        child: Column(
          children: [
            // Role Header with Toggle
            Padding(
              padding: EdgeInsets.all(PharmaSpacing.md),
              child: Row(
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        roleAssignments[role] = value ?? false;
                      });
                    },
                    activeColor: PharmaColors.primary,
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          role,
                          style: PharmaTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? PharmaColors.primary
                                : PharmaColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: PharmaSpacing.xs),
                        Text(
                          roleDescriptions[role] ?? '',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Permissions List
            if (isSelected) ...[
              Divider(height: 0, color: PharmaColors.borderLight),
              Padding(
                padding: EdgeInsets.all(PharmaSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permissions',
                      style: PharmaTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: PharmaColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: PharmaSpacing.sm),
                    ...permissions.map(
                      (permission) => Padding(
                        padding: EdgeInsets.only(bottom: PharmaSpacing.xs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: PharmaColors.success,
                            ),
                            SizedBox(width: PharmaSpacing.sm),
                            Text(
                              permission,
                              style: PharmaTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
