import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show AuditTrail;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/core/file_download.dart';
import 'dart:convert';
import 'dart:typed_data';

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
  bool _exporting = false;

  // Helper list for the dropdown; actual events are always loaded from backend.
  final List<String> _actionTypeOptions = const [
    'USER_CREATE',
    'USER_UPDATE',
    'USER_DEACTIVATE',
    'ACCESS_RECERTIFIED',
    'ACCESS_REVOKED',
    'USERS_LIST',
  ];

  @override
  Widget build(BuildContext context) {
    final auditsAsync = ref.watch(
      adminAuditTrailProvider(
        AuditTrailParams(
          userId: widget.userId,
          from: startDate,
          to: endDate,
          limit: 500,
        ),
      ),
    );

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
                ..._actionTypeOptions
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

            TextField(
              decoration: InputDecoration(
                labelText: 'Search (reason, entity, json)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                ),
              ),
              onChanged: (v) => setState(() => searchQuery = v),
            ),
            SizedBox(height: PharmaSpacing.md),

            Wrap(
              spacing: PharmaSpacing.md,
              runSpacing: PharmaSpacing.md,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      initialDate: startDate ?? DateTime.now().subtract(const Duration(days: 30)),
                    );
                    if (picked == null) return;
                    setState(() => startDate = DateTime(picked.year, picked.month, picked.day));
                  },
                  icon: const Icon(Icons.date_range),
                  label: Text(startDate == null ? 'From date' : 'From: ${startDate!.toIso8601String().split('T').first}'),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(const Duration(days: 1)),
                      initialDate: endDate ?? DateTime.now(),
                    );
                    if (picked == null) return;
                    setState(() => endDate = DateTime(picked.year, picked.month, picked.day, 23, 59, 59));
                  },
                  icon: const Icon(Icons.date_range),
                  label: Text(endDate == null ? 'To date' : 'To: ${endDate!.toIso8601String().split('T').first}'),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    selectedActionType = null;
                    startDate = null;
                    endDate = null;
                    searchQuery = '';
                  }),
                  child: const Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: PharmaSpacing.md),

            // Export Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.download),
                label: Text(_exporting ? 'Exporting...' : 'Export to CSV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: _exporting
                    ? null
                    : () async {
                        setState(() => _exporting = true);
                        try {
                          final csv = await client.audit.exportAuditCsv(
                            userId: widget.userId,
                            entityType: null,
                            from: startDate,
                            to: endDate,
                            limit: 5000,
                          );
                          final bytes = Uint8List.fromList(utf8.encode(csv));
                          await saveBytesToFile(bytes, 'user_${widget.userId}_audit.csv');
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Audit CSV saved')),
                          );
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Export failed: $e'),
                              backgroundColor: PharmaColors.danger,
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => _exporting = false);
                        }
                      },
              ),
            ),
            SizedBox(height: PharmaSpacing.lg),

            // Audit Trail List
            auditsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error loading audit trail: $e'),
              data: (events) {
                final filtered = _filterEvents(events);
                final actionTypes = filtered.map((e) => e.action).toSet().toList()..sort();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Keep dropdown options fresh without throwing setState during build.
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${filtered.length} Events',
                      style: PharmaTypography.headingMedium.copyWith(
                        color: PharmaColors.primary,
                      ),
                    ),
                    SizedBox(height: PharmaSpacing.md),
                    // Timeline
                    ...filtered.map((event) => _buildAuditEvent(event)),
                    if (filtered.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: PharmaSpacing.md),
                        child: Text(
                          'No audit events found for the selected filters.',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<AuditTrail> _filterEvents(List<AuditTrail> events) {
    return events.where((e) {
      if (selectedActionType != null && e.action != selectedActionType) return false;
      if (searchQuery.trim().isNotEmpty) {
        final q = searchQuery.trim().toLowerCase();
        final hay = <String?>[
          e.entityType,
          e.entityId,
          e.action,
          e.reason,
          e.oldValueJson,
          e.newValueJson,
          e.ipAddress,
        ].whereType<String>().join(' ').toLowerCase();
        if (!hay.contains(q)) return false;
      }
      return true;
    }).toList();
  }

  Widget _buildAuditEvent(AuditTrail event) {
    final actionColor = _getActionColor(event.action);

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
                    _getActionIcon(event.action),
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
                          event.action,
                          style: PharmaTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: PharmaSpacing.xs),
                    Text(
                      event.timestamp.toLocal().toString(),
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
                  _buildDetailRow('Entity', '${event.entityType}:${event.entityId}'),
                  _buildDetailRow('Reason', event.reason ?? '-'),
                  _buildDetailRow('IP Address', event.ipAddress ?? '-'),
                  if ((event.oldValueJson ?? '').isNotEmpty)
                    _buildDetailRow('Old Value', event.oldValueJson!),
                  if ((event.newValueJson ?? '').isNotEmpty)
                    _buildDetailRow('New Value', event.newValueJson!),
                  if (event.id != null) _buildDetailRow('Event ID', '#${event.id}'),
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
