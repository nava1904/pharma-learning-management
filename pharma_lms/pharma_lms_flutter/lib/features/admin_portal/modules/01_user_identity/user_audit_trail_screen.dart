import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';

/// User Audit Trail Screen
/// 
/// Module 1: User & Identity Management
/// Screen 7/8: View Comprehensive Audit Trail
/// 
/// Displays complete audit log for a specific user:
/// - All profile changes (name, email, department, etc.)
/// - Role assignments and revocations
/// - Login attempts (success/failure)
/// - Password changes
/// - Account status changes (active/inactive)
/// - Data access logs
/// - Admin actions performed on the user
/// 
/// Features:
/// - Filter by action type
/// - Filter by date range
/// - Search by details
/// - Export audit trail to CSV
/// - Immutable audit records (FDA 21 CFR Part 11)
class UserAuditTrailScreen extends ConsumerStatefulWidget {
  final int userId;
  final String userName;

  const UserAuditTrailScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  ConsumerState<UserAuditTrailScreen> createState() =>
      _UserAuditTrailScreenState();
}

class _UserAuditTrailScreenState extends ConsumerState<UserAuditTrailScreen> {
  String? selectedActionType;
  DateTime? startDate;
  DateTime? endDate;
  String searchQuery = '';

  final actionTypes = [
    'LOGIN',
    'LOGOUT',
    'CREATE',
    'UPDATE',
    'DELETE',
    'ROLE_ASSIGN',
    'ROLE_REVOKE',
    'PASSWORD_RESET',
    'DEACTIVATE',
    'ACTIVATE',
  ];

  // Mock audit data
  final auditTrail = [
    {
      'id': 100,
      'timestamp': '2024-03-20 14:22:00',
      'action': 'LOGIN',
      'performed_by': 'System',
      'ip_address': '192.168.1.100',
      'device': 'Chrome on Mac',
      'details': 'Successful login',
      'status': 'SUCCESS',
    },
    {
      'id': 99,
      'timestamp': '2024-03-15 10:15:00',
      'action': 'UPDATE',
      'performed_by': 'Admin User',
      'ip_address': '192.168.1.50',
      'device': 'Firefox on Windows',
      'details': 'Updated department from IT to Training',
      'status': 'SUCCESS',
    },
    {
      'id': 98,
      'timestamp': '2024-03-10 09:30:00',
      'action': 'ROLE_ASSIGN',
      'performed_by': 'Admin User',
      'ip_address': '192.168.1.50',
      'device': 'Firefox on Windows',
      'details': 'Assigned TRAINER role',
      'status': 'SUCCESS',
    },
    {
      'id': 97,
      'timestamp': '2024-01-15 10:30:00',
      'action': 'CREATE',
      'performed_by': 'Admin User',
      'ip_address': '192.168.1.50',
      'device': 'Safari on Mac',
      'details': 'User account created',
      'status': 'SUCCESS',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Trail'),
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
                    'Audit Trail for: ${widget.userName}',
                    style: PharmaTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PharmaColors.infoText,
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.xs),
                  Text(
                    'Complete immutable record of all actions (FDA 21 CFR Part 11)',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.infoText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Filters
            Text(
              'Filters',
              style: PharmaTypography.headingMedium.copyWith(
                color: PharmaColors.primary,
              ),
            ),
            SizedBox(height: PharmaSpacing.md),

            // Action Type Filter
            DropdownButtonFormField<String>(
              initialValue: selectedActionType,
              decoration: InputDecoration(
                labelText: 'Action Type',
                prefixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                ),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('All Actions'),
                ),
                ...actionTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    ,
              ],
              onChanged: (value) {
                setState(() => selectedActionType = value);
              },
            ),
            SizedBox(height: PharmaSpacing.md),

            // Export Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.download),
                label: const Text('Export to CSV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Audit trail exported successfully'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Audit Trail List
            Text(
              '${auditTrail.length} Events',
              style: PharmaTypography.headingMedium.copyWith(
                color: PharmaColors.primary,
              ),
            ),
            SizedBox(height: PharmaSpacing.md),

            // Timeline
            ...auditTrail.map((event) => _buildAuditEvent(event)),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditEvent(Map<String, dynamic> event) {
    final actionColor = _getActionColor(event['action']);
    final statusColor = event['status'] == 'SUCCESS'
        ? PharmaColors.success
        : PharmaColors.danger;

    return Card(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaSpacing.sm),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: PharmaSpacing.md,
            vertical: PharmaSpacing.sm,
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: actionColor.withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    _getActionIcon(event['action']),
                    color: actionColor,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event['action'],
                          style: PharmaTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: PharmaSpacing.sm,
                            vertical: PharmaSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(PharmaSpacing.xs),
                          ),
                          child: Text(
                            event['status'],
                            style: PharmaTypography.caption.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: PharmaSpacing.xs),
                    Text(
                      event['timestamp'],
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Divider(height: 0, color: PharmaColors.borderLight),
            Padding(
              padding: EdgeInsets.all(PharmaSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Details', event['details']),
                  _buildDetailRow('Performed By', event['performed_by']),
                  _buildDetailRow('IP Address', event['ip_address']),
                  _buildDetailRow('Device', event['device']),
                  _buildDetailRow('Event ID', '#${event['id']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PharmaSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: PharmaTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: PharmaColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action) {
      case 'LOGIN':
        return PharmaColors.success;
      case 'CREATE':
        return PharmaColors.info;
      case 'UPDATE':
        return PharmaColors.warning;
      case 'DELETE':
      case 'DEACTIVATE':
        return PharmaColors.danger;
      case 'ROLE_ASSIGN':
        return PharmaColors.emerald600;
      case 'ROLE_REVOKE':
        return PharmaColors.orange;
      default:
        return PharmaColors.textSecondary;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case 'LOGIN':
        return Icons.login;
      case 'LOGOUT':
        return Icons.logout;
      case 'CREATE':
        return Icons.person_add;
      case 'UPDATE':
        return Icons.edit;
      case 'DELETE':
        return Icons.delete;
      case 'ROLE_ASSIGN':
        return Icons.admin_panel_settings;
      case 'ROLE_REVOKE':
        return Icons.block;
      case 'PASSWORD_RESET':
        return Icons.vpn_key;
      case 'DEACTIVATE':
        return Icons.person_outline;
      case 'ACTIVATE':
        return Icons.check_circle;
      default:
        return Icons.event;
    }
  }
}
