import 'package:flutter/material.dart';

import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';

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
  bool _loading = true;
  String? _error;
  List<String> _roles = const [];
  String? _selectedRoleCode;
  final _reasonController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final roles = await client.adminUserManagement.listPortalRoles();
      final current = await client.adminUserManagement.getUserPortalRoles(userId: widget.userId);
      setState(() {
        _roles = roles.map((r) => r.code).toList()..sort();
        _selectedRoleCode = current.isNotEmpty ? current.first : null;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _saveRoles() async {
    setState(() => isLoading = true);

    try {
      final selected = _selectedRoleCode;
      if (selected == null || selected.trim().isEmpty) {
        throw Exception('Select a role');
      }

      final me = await ref.read(currentUserProvider.future);
      if (me?.id == null) throw Exception('Not authenticated');

      await client.adminUserManagement.setUserPortalRole(
        userId: widget.userId,
        roleCode: selected,
        reason: _reasonController.text.trim().isEmpty ? null : _reasonController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Role updated for ${widget.userName}'),
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
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Roles'),
          elevation: 0,
          backgroundColor: PharmaColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Roles'),
          elevation: 0,
          backgroundColor: PharmaColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Center(child: Text('Failed to load roles: $_error')),
      );
    }

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
            ..._roles.map(
              (code) => RadioListTile<String>(
                title: Text(code),
                value: code,
                groupValue: _selectedRoleCode,
                onChanged: isLoading ? null : (v) => setState(() => _selectedRoleCode = v),
              ),
            ),

            SizedBox(height: PharmaSpacing.md),
            TextField(
              controller: _reasonController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Reason (recommended for regulated changes)',
                border: OutlineInputBorder(),
              ),
            ),

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
}
