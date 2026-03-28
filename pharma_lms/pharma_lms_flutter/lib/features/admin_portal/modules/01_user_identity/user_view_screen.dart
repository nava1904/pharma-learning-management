import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';

/// User View Screen
/// 
/// Module 1: User & Identity Management
/// Screen 4/8: View User Details
/// 
/// Read-only display of comprehensive user information:
/// - User profile (name, email, employee ID, phone)
/// - Organization & Department
/// - Role assignments
/// - Account status (active, inactive, pending)
/// - Hire date and employment history
/// - Associated roles (EMPLOYEE, TRAINER, ADMIN)
/// - Audit trail (recent activity)
/// - Last login information
/// 
/// Actions available:
/// - Edit User (navigates to UserEditScreen)
/// - Deactivate User (with confirmation)
/// - Reset Password
/// - View Audit Trail
/// - View Access Logs
class UserViewScreen extends ConsumerStatefulWidget {
  final int userId;

  const UserViewScreen({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<UserViewScreen> createState() => _UserViewScreenState();
}

class _UserViewScreenState extends ConsumerState<UserViewScreen> {
  bool isLoading = true;
  String? errorMessage;
  
  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await ref.read(adminUserDetailProvider(widget.userId).future);
      if (mounted) {
        if (user == null) {
          setState(() {
            errorMessage = 'User not found';
            isLoading = false;
          });
        } else {
          setState(() {
            userData = {
              'id': user.id,
              'employee_id': user.employeeId,
              'first_name': user.firstName,
              'last_name': user.lastName,
              'email': user.email,
              // 'phone': user.phone ?? '', // PharmaUser has no phone field
              'organization': user.organizationId.toString(),
              'department': user.departmentId.toString(),
              'role': user.jobRole?.name ?? '',
              'status': user.status,
              'hire_date': user.hireDate?.toString() ?? '',
              'created_at': user.createdAt.toString(),
              'last_login': user.lastLogin?.toString() ?? '',
            };
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to load user: $e';
          isLoading = false;
        });
      }
    }
  }

  void _showDeactivateDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Deactivate User'),
        content: Text(
          'Deactivate ${userData['first_name']} ${userData['last_name']}? '
          'They will not be able to login.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PharmaColors.danger,
            ),
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(adminDeactivateUserProvider(widget.userId).future);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${userData['first_name']} has been deactivated',
                  ),
                  backgroundColor: PharmaColors.warning,
                ),
              );
            },
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Password'),
        content: Text(
          'Send password reset email to ${userData['email']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await client.emailIdp.startPasswordReset(
                  email: userData['email'] as String,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password reset email requested for ${userData['email']}'),
                    backgroundColor: PharmaColors.success,
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to request password reset: $e'),
                    backgroundColor: PharmaColors.danger,
                  ),
                );
              }
            },
            child: const Text('Send Reset Email'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
          elevation: 0,
          backgroundColor: PharmaColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
          elevation: 0,
          backgroundColor: PharmaColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Center(child: Text(errorMessage!)),
      );
    }

    final statusColor = userData['status'] == 'active'
        ? PharmaColors.success
        : PharmaColors.warning;
    final statusLabel = userData['status'] == 'active' ? 'Active' : 'Inactive';

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        elevation: 0,
        backgroundColor: PharmaColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit User',
            onPressed: () {
              context.push('/admin/users/directory/view/${widget.userId}/edit');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More Options',
            onPressed: () => _showMoreMenu(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card
            _buildProfileCard(),
            SizedBox(height: PharmaSpacing.lg),

            // User Information Section
            _buildSection(
              'User Information',
              [
                _buildInfoRow('Email', userData['email']),
                _buildInfoRow('Employee ID', userData['employee_id']),
                _buildInfoRow('Status', statusLabel, statusColor),
              ],
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Organization Information Section
            _buildSection(
              'Organization & Department',
              [
                _buildInfoRow('Organization', userData['organization']),
                _buildInfoRow('Department', userData['department']),
                _buildInfoRow('Role', userData['role']),
              ],
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Employment Details Section
            _buildSection(
              'Employment Details',
              [
                _buildInfoRow('Hire Date', _formatDate(userData['hire_date'])),
                _buildInfoRow('Created Date', _formatDateTime(userData['created_at'])),
                _buildInfoRow('Last Login', _formatDateTime(userData['last_login'])),
              ],
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Action Buttons Section
            _buildActionsSection(),
            SizedBox(height: PharmaSpacing.lg),

            // Audit Trail Preview
            _buildAuditTrailPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaSpacing.sm),
        boxShadow: PharmaShadows.sm,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PharmaColors.emerald100,
            ),
            child: Center(
              child: Text(
                _getInitials(userData['first_name'], userData['last_name']),
                style: PharmaTypography.displayLarge.copyWith(
                  color: PharmaColors.emerald600,
                ),
              ),
            ),
          ),
          SizedBox(width: PharmaSpacing.lg),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userData['first_name']} ${userData['last_name']}',
                  style: PharmaTypography.headingLarge,
                ),
                SizedBox(height: PharmaSpacing.xs),
                Text(
                  userData['email'],
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textSecondary,
                  ),
                ),
                SizedBox(height: PharmaSpacing.sm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: PharmaSpacing.sm,
                        vertical: PharmaSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: _getRoleColor(userData['role']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                      ),
                      child: Text(
                        userData['role'],
                        style: PharmaTypography.caption.copyWith(
                          color: _getRoleColor(userData['role']),
                        ),
                      ),
                    ),
                    SizedBox(width: PharmaSpacing.md),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: PharmaSpacing.sm,
                        vertical: PharmaSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: userData['status'] == 'active'
                            ? PharmaColors.successBg
                            : PharmaColors.warningBg,
                        borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                      ),
                      child: Text(
                        userData['status'].toUpperCase(),
                        style: PharmaTypography.caption.copyWith(
                          color: userData['status'] == 'active'
                              ? PharmaColors.successText
                              : PharmaColors.warningText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PharmaTypography.headingMedium.copyWith(
            color: PharmaColors.primary,
          ),
        ),
        SizedBox(height: PharmaSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            border: Border.all(color: PharmaColors.borderLight),
            borderRadius: BorderRadius.circular(PharmaSpacing.sm),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => Column(
                children: [
                  items[index],
                  if (index < items.length - 1)
                    Divider(
                      height: 0,
                      color: PharmaColors.borderLight,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: EdgeInsets.all(PharmaSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: PharmaTypography.bodyMedium.copyWith(
              color: PharmaColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: PharmaTypography.bodyMedium.copyWith(
              color: valueColor ?? PharmaColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.gray50,
        borderRadius: BorderRadius.circular(PharmaSpacing.sm),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actions',
            style: PharmaTypography.headingSmall.copyWith(
              color: PharmaColors.primary,
            ),
          ),
          SizedBox(height: PharmaSpacing.md),
          Wrap(
            spacing: PharmaSpacing.md,
            runSpacing: PharmaSpacing.md,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.push('/admin/users/directory/view/${widget.userId}/edit');
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.vpn_key),
                label: const Text('Reset Password'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.info,
                  foregroundColor: Colors.white,
                ),
                onPressed: _showResetPasswordDialog,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text('Audit Trail'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.purple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.push(
                    '/admin/users/directory/view/${widget.userId}/audit-trail',
                    extra: '${userData['first_name']} ${userData['last_name']}',
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Access Logs'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.push(
                    '/admin/users/directory/view/${widget.userId}/access-logs',
                    extra: '${userData['first_name']} ${userData['last_name']}',
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.block),
                label: const Text('Deactivate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.danger,
                  foregroundColor: Colors.white,
                ),
                onPressed: _showDeactivateDialog,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuditTrailPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: PharmaTypography.headingMedium.copyWith(
            color: PharmaColors.primary,
          ),
        ),
        SizedBox(height: PharmaSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            border: Border.all(color: PharmaColors.borderLight),
            borderRadius: BorderRadius.circular(PharmaSpacing.sm),
          ),
          child: Column(
            children: [
              _buildAuditItem(
                'User Login',
                '2024-03-20 14:22:00',
                'IP: 192.168.1.100',
                Colors.green,
              ),
              Divider(height: 0, color: PharmaColors.borderLight),
              _buildAuditItem(
                'Profile Updated',
                '2024-03-15 10:15:00',
                'Name and department changed',
                Colors.blue,
              ),
              Divider(height: 0, color: PharmaColors.borderLight),
              _buildAuditItem(
                'User Created',
                '2024-01-15 10:30:00',
                'Initial user creation',
                Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditItem(
    String action,
    String timestamp,
    String details,
    Color iconColor,
  ) {
    return Padding(
      padding: EdgeInsets.all(PharmaSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
            ),
            child: Center(
              child: Icon(Icons.event, color: iconColor, size: 20),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: PharmaTypography.bodyMedium,
                ),
                Text(
                  timestamp,
                  style: PharmaTypography.caption,
                ),
                Text(
                  details,
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 50,
        kToolbarHeight,
        0,
        0,
      ),
      items: [
        const PopupMenuItem(
          value: 'audit',
          child: Text('View Audit Trail'),
        ),
        const PopupMenuItem(
          value: 'logs',
          child: Text('View Access Logs'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'deactivate',
          child: Text('Deactivate User'),
        ),
      ],
    ).then((value) {
      if (value == 'deactivate') {
        _showDeactivateDialog();
      }
    });
  }

  String _getInitials(String firstName, String lastName) {
    return '${firstName[0]}${lastName[0]}'.toUpperCase();
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'ADMIN':
        return PharmaColors.danger;
      case 'TRAINER':
        return PharmaColors.info;
      case 'EMPLOYEE':
      default:
        return PharmaColors.success;
    }
  }

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return '${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return date;
    }
  }

  String _formatDateTime(String dateTime) {
    try {
      final parsed = DateTime.parse(dateTime);
      return '${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')} '
          '${parsed.hour.toString().padLeft(2, '0')}:${parsed.minute.toString().padLeft(2, '0')}:${parsed.second.toString().padLeft(2, '0')}';
    } catch (_) {
      return dateTime;
    }
  }
}
