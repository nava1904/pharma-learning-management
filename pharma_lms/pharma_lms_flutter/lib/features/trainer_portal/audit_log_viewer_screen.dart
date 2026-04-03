// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — AUDIT LOG VIEWER (TRN-16)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/audit-log
// Permanent, immutable audit trail. 21 CFR Part 11 compliant.
// Columns: Timestamp, User, Action, Entity, Details, IP Address.
// All data loaded from backend via real API calls.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import 'widgets/trainer_page_scaffold.dart';

class AuditLogViewerScreen extends ConsumerStatefulWidget {
  const AuditLogViewerScreen({super.key});

  @override
  ConsumerState<AuditLogViewerScreen> createState() =>
      _AuditLogViewerScreenState();
}

class _AuditLogViewerScreenState extends ConsumerState<AuditLogViewerScreen> {
  String _searchQuery = '';
  String _filterAction = 'All';
  String _filterEntity = 'All';
  String _dateRange = 'Last 7 days';

  bool _loading = true;
  String? _error;
  List<AuditTrail> _entries = [];
  AuditTrail? _selectedEntry;

  static const int _pageSize = 100;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  DateTime? get _fromDate {
    final now = DateTime.now();
    switch (_dateRange) {
      case 'Last 7 days':
        return now.subtract(const Duration(days: 7));
      case 'Last 30 days':
        return now.subtract(const Duration(days: 30));
      case 'Last 90 days':
        return now.subtract(const Duration(days: 90));
      default:
        return null;
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final entityType = _filterEntity == 'All' ? null : _filterEntity;
      final entries = await client.audit.getAuditTrail(
        entityType: entityType,
        from: _fromDate,
        to: DateTime.now(),
        limit: _pageSize,
      );

      setState(() {
        _entries = entries;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to load audit trail: $e';
      });
    }
  }

  List<AuditTrail> get _filtered {
    return _entries.where((e) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesEntity = e.entityType.toLowerCase().contains(q) ||
            e.entityId.toLowerCase().contains(q);
        final matchesAction = e.action.toLowerCase().contains(q);
        final matchesReason =
            e.reason != null && e.reason!.toLowerCase().contains(q);
        final matchesIp =
            e.ipAddress != null && e.ipAddress!.toLowerCase().contains(q);
        final matchesUser = e.user != null &&
            ('${e.user!.firstName} ${e.user!.lastName}')
                .toLowerCase()
                .contains(q);
        if (!matchesEntity &&
            !matchesAction &&
            !matchesReason &&
            !matchesIp &&
            !matchesUser) {
          return false;
        }
      }
      if (_filterAction != 'All' && e.action != _filterAction) return false;
      return true;
    }).toList();
  }

  Set<String> get _availableActions =>
      _entries.map((e) => e.action).toSet();

  Set<String> get _availableEntities =>
      _entries.map((e) => e.entityType).toSet();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        _buildComplianceBanner(),
        const SizedBox(height: 16),
        _buildFilters(),
        const SizedBox(height: 16),
        if (_loading)
          const TrainerPageLoading(cardCount: 4)
        else if (_error != null)
          _buildErrorCard()
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTable()),
              if (_selectedEntry != null) ...[
                const SizedBox(width: 24),
                SizedBox(
                  width: 360,
                  child: _buildEntryDetailPanel(_selectedEntry!),
                ),
              ],
            ],
          ),
      ],
    );
  }

  Widget _buildEntryDetailPanel(AuditTrail e) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Audit entry',
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedEntry = null),
                icon: const Icon(Icons.close, size: 18),
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(_formatTimestamp(e.timestamp),
              style: PharmaTypography.caption.copyWith(
                  fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(_formatUser(e), style: PharmaTypography.bodyMedium),
          const SizedBox(height: 4),
          Text('${e.action} · ${e.entityType} · ${e.entityId}',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          if (e.reason != null && e.reason!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Reason', style: PharmaTypography.labelMedium),
            const SizedBox(height: 4),
            Text(e.reason!, style: PharmaTypography.body),
          ],
          if (e.ipAddress != null && e.ipAddress!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('IP: ${e.ipAddress}',
                style: PharmaTypography.caption
                    .copyWith(fontFamily: 'monospace')),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.security, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Audit Log',
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Immutable audit trail — 21 CFR Part 11 compliant',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _loadData,
          icon: const Icon(Icons.refresh, size: 20),
          tooltip: 'Refresh',
        ),
        const SizedBox(width: 4),
        OutlinedButton.icon(
          onPressed: _exportAuditCsv,
          icon: const Icon(Icons.download, size: 16),
          label: const Text('Export CSV'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _showPrintableAuditLog,
          icon: const Icon(Icons.print, size: 16),
          label: const Text('Print'),
        ),
      ],
    );
  }

  Future<void> _exportAuditCsv() async {
    try {
      final entityType = _filterEntity == 'All' ? null : _filterEntity;
      final csv = await client.audit.exportAuditCsv(
        entityType: entityType,
        from: _fromDate,
        to: DateTime.now(),
        limit: 1000,
      );
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(children: [
            const Icon(Icons.download_done, size: 20),
            const SizedBox(width: 8),
            const Text('Audit Log CSV'),
          ]),
          content: SizedBox(
            width: 600,
            height: 400,
            child: SelectableText(
              csv,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: csv));
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
              },
              child: const Text('Copy to Clipboard'),
            ),
            FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  void _showPrintableAuditLog() {
    final filtered = _filtered;
    final buffer = StringBuffer();
    buffer.writeln('AUDIT LOG — $_dateRange');
    buffer.writeln('Generated: ${_formatTimestamp(DateTime.now())}');
    buffer.writeln('=' * 80);
    buffer.writeln('');
    buffer.writeln('Timestamp | User | Action | Entity Type | Entity ID | Reason | IP');
    buffer.writeln('-' * 80);
    for (final e in filtered) {
      buffer.writeln(
        '${_formatTimestamp(e.timestamp)} | ${_formatUser(e)} | ${e.action} | '
        '${e.entityType} | ${e.entityId} | ${e.reason ?? '—'} | ${e.ipAddress ?? '—'}',
      );
    }
    buffer.writeln('');
    buffer.writeln('Total entries: ${filtered.length}');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          const Icon(Icons.print, size: 20),
          const SizedBox(width: 8),
          const Text('Print-Ready Audit Log'),
        ]),
        content: SizedBox(
          width: 700,
          height: 500,
          child: SelectableText(
            buffer.toString(),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: buffer.toString()));
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
            child: const Text('Copy to Clipboard'),
          ),
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildComplianceBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: PharmaColors.emerald50,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(
          color: PharmaColors.emerald600.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_user,
            size: 18,
            color: PharmaColors.emerald600,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All records are permanent and immutable',
                  style: PharmaTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PharmaColors.emerald600,
                  ),
                ),
                Text(
                  'Audit trail entries cannot be modified or deleted per FDA 21 CFR Part 11, EU GMP Annex 11, and ALCOA+ data integrity requirements.',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textSecondary,
                  ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search audit log…',
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: PharmaColors.pageBg,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _dropdown(
            'Action',
            _filterAction,
            ['All', ..._availableActions],
            (v) => setState(() => _filterAction = v),
          ),
          const SizedBox(width: 8),
          _dropdown(
            'Entity',
            _filterEntity,
            ['All', ..._availableEntities],
            (v) {
              setState(() => _filterEntity = v);
              _loadData();
            },
          ),
          const SizedBox(width: 8),
          _dropdown(
            'Period',
            _dateRange,
            ['Last 7 days', 'Last 30 days', 'Last 90 days', 'All time'],
            (v) {
              setState(() => _dateRange = v);
              _loadData();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.danger.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 36, color: PharmaColors.danger),
          const SizedBox(height: 12),
          Text(
            _error ?? 'Unknown error',
            style: PharmaTypography.body.copyWith(color: PharmaColors.danger),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final filtered = _filtered;

    if (filtered.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 40,
              color: PharmaColors.gray300,
            ),
            const SizedBox(height: 12),
            Text(
              'No audit entries found',
              style: PharmaTypography.headingSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Try adjusting your filters or date range.',
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              '${filtered.length} entries',
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 44,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 64,
              columnSpacing: 20,
              headingTextStyle: PharmaTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: PharmaColors.textTertiary,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
              columns: const [
                DataColumn(label: Text('TIMESTAMP')),
                DataColumn(label: Text('USER')),
                DataColumn(label: Text('ACTION')),
                DataColumn(label: Text('ENTITY TYPE')),
                DataColumn(label: Text('ENTITY ID')),
                DataColumn(label: Text('REASON')),
                DataColumn(label: Text('IP ADDRESS')),
                DataColumn(label: Text('INTEGRITY')),
              ],
              rows: filtered
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            _formatTimestamp(e.timestamp),
                            style: PharmaTypography.caption.copyWith(
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                          onTap: () => setState(() => _selectedEntry = e),
                        ),
                        DataCell(
                          Text(
                            _formatUser(e),
                            style: PharmaTypography.body,
                            maxLines: 1,
                          ),
                        ),
                        DataCell(_ActionChip(action: e.action)),
                        DataCell(
                          Text(
                            e.entityType,
                            style: PharmaTypography.bodyMedium,
                          ),
                        ),
                        DataCell(
                          Text(
                            e.entityId,
                            style: PharmaTypography.caption.copyWith(
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 200,
                            child: Text(
                              e.reason ?? '—',
                              style: PharmaTypography.caption,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            e.ipAddress ?? '—',
                            style: PharmaTypography.caption.copyWith(
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          e.rowHash != null
                              ? Tooltip(
                                  message: e.rowHash!,
                                  child: Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: PharmaColors.emerald600,
                                  ),
                                )
                              : Icon(
                                  Icons.remove_circle_outline,
                                  size: 16,
                                  color: PharmaColors.gray400,
                                ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatUser(AuditTrail entry) {
    if (entry.user != null) {
      return '${entry.user!.firstName} ${entry.user!.lastName}';
    }
    if (entry.userId != null) {
      return 'User #${entry.userId}';
    }
    return '—';
  }

  String _formatTimestamp(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: PharmaRadius.inputRadius,
      ),
      child: DropdownButton<String>(
        value: items.contains(value) ? value : items.first,
        underline: const SizedBox.shrink(),
        isDense: true,
        style: PharmaTypography.caption.copyWith(
          color: PharmaColors.textPrimary,
        ),
        items: items
            .map(
              (i) => DropdownMenuItem(
                value: i,
                child: Text(i, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.action});
  final String action;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    final upper = action.toUpperCase();
    if (upper.contains('CREATE') ||
        upper.contains('PUBLISH') ||
        upper.contains('APPROVE')) {
      bg = PharmaColors.successBg;
      fg = PharmaColors.successText;
    } else if (upper.contains('SIGN') || upper.contains('SIGNATURE')) {
      bg = PharmaColors.emerald50;
      fg = PharmaColors.emerald600;
    } else if (upper.contains('DELETE') ||
        upper.contains('REJECT') ||
        upper.contains('FAIL')) {
      bg = PharmaColors.dangerBg;
      fg = PharmaColors.danger;
    } else if (upper.contains('UPDATE') ||
        upper.contains('UPLOAD') ||
        upper.contains('SUBMIT') ||
        upper.contains('LINK')) {
      bg = PharmaColors.infoBg;
      fg = PharmaColors.infoText;
    } else {
      bg = PharmaColors.gray100;
      fg = PharmaColors.gray600;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        action.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
