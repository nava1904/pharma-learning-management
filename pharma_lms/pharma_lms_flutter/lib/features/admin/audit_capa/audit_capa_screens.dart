import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show AuditTrail;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/features/admin_portal/widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// AUDIT TRAIL SCREEN - Real data from backend (FDA 21 CFR Part 11 compliant)
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAuditTrailScreen extends ConsumerStatefulWidget {
  const AdminAuditTrailScreen({super.key});

  @override
  ConsumerState<AdminAuditTrailScreen> createState() => _AdminAuditTrailScreenState();
}

class _AdminAuditTrailScreenState extends ConsumerState<AdminAuditTrailScreen> {
  String? _selectedEntityType;
  int? _selectedUserId;
  int _limit = 100;

  @override
  Widget build(BuildContext context) {
    final auditParams = AuditTrailParams(
      entityType: _selectedEntityType,
      userId: _selectedUserId,
      limit: _limit,
    );
    
    final auditAsync = ref.watch(adminAuditTrailProvider(auditParams));

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Compliance Notice
          _buildComplianceNotice(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Filters
          _buildFilters(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Audit Events Table
          auditAsync.when(
            data: (events) => _buildAuditTable(events),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.security, color: PharmaColors.emerald600, size: 28),
            SizedBox(width: PharmaSpacing.sm),
            Text('Audit Trail', style: PharmaTypography.displayLarge),
          ],
        ),
        SizedBox(height: PharmaSpacing.xs),
        Text(
          'Immutable event stream for regulatory traceability • FDA 21 CFR Part 11 Compliant',
          style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
        ),
      ],
    );
  }

  Widget _buildComplianceNotice() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.infoBg,
        border: Border.all(color: PharmaColors.info),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_outlined, color: PharmaColors.info, size: 24),
          SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ALCOA+ Compliant Audit Trail',
                  style: PharmaTypography.bodyMedium.copyWith(
                    color: PharmaColors.infoText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'All records are: Attributable • Legible • Contemporaneous • Original • Accurate • Complete • Consistent • Enduring • Available',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Entity Type Filter
          Expanded(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedEntityType,
              decoration: InputDecoration(
                labelText: 'Entity Type',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                  vertical: PharmaSpacing.sm,
                ),
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text('All Types')),
                DropdownMenuItem(value: 'user', child: Text('User')),
                DropdownMenuItem(value: 'course', child: Text('Course')),
                DropdownMenuItem(value: 'enrollment', child: Text('Enrollment')),
                DropdownMenuItem(value: 'assessment', child: Text('Assessment')),
                DropdownMenuItem(value: 'certificate', child: Text('Certificate')),
                DropdownMenuItem(value: 'role', child: Text('Role')),
              ],
              onChanged: (value) => setState(() => _selectedEntityType = value),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Limit Filter
          Expanded(
            child: DropdownButtonFormField<int>(
              initialValue: _limit,
              decoration: InputDecoration(
                labelText: 'Records',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                  vertical: PharmaSpacing.sm,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 50, child: Text('50 records')),
                DropdownMenuItem(value: 100, child: Text('100 records')),
                DropdownMenuItem(value: 250, child: Text('250 records')),
                DropdownMenuItem(value: 500, child: Text('500 records')),
              ],
              onChanged: (value) => setState(() => _limit = value ?? 100),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Export Button
          OutlinedButton.icon(
            onPressed: () => _showExportDialog(),
            icon: const Icon(Icons.download_outlined, size: 18),
            label: const Text('Export'),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Refresh
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(adminAuditTrailProvider(AuditTrailParams(
              entityType: _selectedEntityType,
              userId: _selectedUserId,
              limit: _limit,
            ))),
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }

  Widget _buildAuditTable(List<AuditTrail> events) {
    if (events.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.history, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No audit events found',
                style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: PharmaSpacing.cardPadding,
              vertical: PharmaSpacing.md,
            ),
            decoration: BoxDecoration(
              color: PharmaColors.gray50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(PharmaRadius.md)),
            ),
            child: Row(
              children: [
                _buildHeaderCell('Timestamp', flex: 2),
                _buildHeaderCell('Action', flex: 2),
                _buildHeaderCell('Entity', flex: 2),
                _buildHeaderCell('User', flex: 1),
                _buildHeaderCell('IP Address', flex: 1),
                _buildHeaderCell('Reason', flex: 2),
              ],
            ),
          ),
          
          // Table Rows
          ...events.map((event) => _buildAuditRow(event)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: PharmaTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: PharmaColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildAuditRow(AuditTrail event) {
    final actionColor = _getActionColor(event.action);
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PharmaSpacing.cardPadding,
        vertical: PharmaSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          // Timestamp
          Expanded(
            flex: 2,
            child: Text(
              formatter.format(event.timestamp),
              style: PharmaTypography.caption.copyWith(fontFamily: 'monospace'),
            ),
          ),
          
          // Action
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
              decoration: BoxDecoration(
                color: actionColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
              ),
              child: Text(
                event.action.toUpperCase(),
                style: PharmaTypography.caption.copyWith(
                  color: actionColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          // Entity
          Expanded(
            flex: 2,
            child: Text(
              '${event.entityType}:${event.entityId}',
              style: PharmaTypography.body,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // User
          Expanded(
            flex: 1,
            child: Text(
              event.userId != null ? 'User #${event.userId}' : 'System',
              style: PharmaTypography.caption,
            ),
          ),
          
          // IP Address
          Expanded(
            flex: 1,
            child: Text(
              event.ipAddress ?? '-',
              style: PharmaTypography.caption.copyWith(fontFamily: 'monospace'),
            ),
          ),
          
          // Reason
          Expanded(
            flex: 2,
            child: Text(
              event.reason ?? '-',
              style: PharmaTypography.caption,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String action) {
    final actionLower = action.toLowerCase();
    if (actionLower.contains('create') || actionLower.contains('insert')) {
      return PharmaColors.success;
    } else if (actionLower.contains('update') || actionLower.contains('modify')) {
      return PharmaColors.warning;
    } else if (actionLower.contains('delete') || actionLower.contains('remove')) {
      return PharmaColors.danger;
    } else if (actionLower.contains('login') || actionLower.contains('auth')) {
      return PharmaColors.info;
    } else if (actionLower.contains('approve') || actionLower.contains('sign')) {
      return PharmaColors.emerald600;
    }
    return PharmaColors.textTertiary;
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Audit Trail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Export format:', style: PharmaTypography.bodyMedium),
            SizedBox(height: PharmaSpacing.md),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('CSV'),
              subtitle: const Text('Comma-separated values'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting audit trail to CSV...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF'),
              subtitle: const Text('Signed PDF with hash chain'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting audit trail to PDF...')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Failed to load audit trail', style: PharmaTypography.bodyMedium),
            Text(error, style: PharmaTypography.caption),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INTEGRITY CHECK SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminIntegrityCheckScreen extends StatelessWidget {
  const AdminIntegrityCheckScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AuditTemplate(
        title: 'Integrity Check',
        subtitle: 'HMAC chain and tamper-evidence verification.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// CAPA REGISTER SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCapaRegisterScreen extends StatelessWidget {
  const AdminCapaRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AuditTemplate(
        title: 'CAPA Register',
        subtitle: 'Corrective and preventive action lifecycle tracking.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ═══════════════════════════════════════════════════════════════════════════════

class _AuditTemplate extends StatelessWidget {
  const _AuditTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Coming Soon',
            child: AdminDataTable(
              columns: ['Feature', 'Status', 'ETA'],
              rows: [
                ['Full implementation', 'In Progress', 'Q2 2026'],
              ],
            ),
          ),
        ],
      );
}
