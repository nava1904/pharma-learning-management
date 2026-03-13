import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';
import '../esignature/esignature_screen.dart' show showEsignatureModal;

/// ════════════════════════════════════════════════════════════════════════════
/// INSPECTION MANAGEMENT SCREEN
/// ────────────────────────────────────────────────────────────────────────────
/// ADM-WF-08: Generate Inspection Briefing Pack workflow.
/// Two-column layout: Create Inspection | Active Inspections
/// ════════════════════════════════════════════════════════════════════════════
class InspectionManagementScreen extends StatefulWidget {
  const InspectionManagementScreen({super.key});

  @override
  State<InspectionManagementScreen> createState() =>
      _InspectionManagementScreenState();
}

class _InspectionManagementScreenState extends State<InspectionManagementScreen> {
  // ─────────────────────────────────────────────────────────────────────────────
  // State
  // ─────────────────────────────────────────────────────────────────────────────
  List<InspectionRecord> _records = [];
  bool _loading = true;
  bool _creating = false;
  List<Organization> _orgs = [];
  List<Site> _sites = [];
  Organization? _selectedOrg;
  Site? _selectedSite;
  final _typeController = TextEditingController(text: 'fda');
  final _scopeController = TextEditingController();
  final _inspectorController = TextEditingController();
  DateTime? _scheduledDate;
  int _tokenHours = 48;
  int? _createdById;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _typeController.dispose();
    _scopeController.dispose();
    _inspectorController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Data Loading
  // ─────────────────────────────────────────────────────────────────────────────
  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final records = await client.inspection.listInspectionRecords(limit: 50);
      final orgs = await client.organization.listOrganizations();
      final user = await client.user.getUserByEmail('admin@pharmacorp.demo');
      if (mounted) {
        setState(() {
          _records = records;
          _orgs = orgs;
          _createdById = user?.id;
          _loading = false;
          if (_orgs.isNotEmpty && _selectedOrg == null) {
            _selectedOrg = _orgs.first;
            _loadSites(_orgs.first.id!);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _loadSites(int orgId) async {
    try {
      final sites = await client.organization.listSites(orgId);
      if (mounted) {
        setState(() {
          _sites = sites;
          _selectedSite = sites.isNotEmpty ? sites.first : null;
        });
      }
    } catch (_) {}
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Create Inspection
  // ─────────────────────────────────────────────────────────────────────────────
  Future<void> _createInspection() async {
    if (_selectedSite?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a site'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _creating = true);
    try {
      final result = await client.inspection.createInspectionRecord(
        inspectionType: _typeController.text.trim().isEmpty
            ? 'fda'
            : _typeController.text.trim(),
        siteId: _selectedSite!.id!,
        scopeDescription: _scopeController.text.trim().isEmpty
            ? null
            : _scopeController.text.trim(),
        scheduledDate: _scheduledDate,
        inspectorNames: _inspectorController.text.trim().isEmpty
            ? null
            : _inspectorController.text.trim(),
        tokenHoursValid: _tokenHours,
        createdById: _createdById,
      );
      if (mounted) {
        setState(() => _creating = false);
        await _load();
        if (!mounted) return;
        final baseUrl = Uri.base.origin;
        final inviteUrl = '$baseUrl/auditor?token=${result['accessToken']}';
        await _showTokenDialog(inviteUrl, result['expiresAt']);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _creating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _showTokenDialog(String inviteUrl, dynamic expiresAt) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check_circle, color: AppColors.success),
            ),
            const SizedBox(width: 12),
            const Text('Inspection Record Created'),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.info.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: AppColors.info),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Share this secure link with the auditor. Valid until $expiresAt.',
                        style: TextStyle(fontSize: 13, color: AppColors.info),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: SelectableText(
                  inviteUrl,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: inviteUrl));
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('Link copied to clipboard'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.copy, size: 18),
                label: const Text('Copy to Clipboard'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // ADM-WF-08: Generate Briefing Pack
  // ─────────────────────────────────────────────────────────────────────────────
  Future<void> _generatePackage(InspectionRecord record) async {
    if (record.id == null || _createdById == null) return;
    try {
      final result = await client.inspection.generateInspectionPackage(
        inspectionRecordId: record.id!,
        generatedById: _createdById!,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Package generated: ${result['includedRecordsCount']} records, SHA-256: ${(result['fileHash'] as String).substring(0, 16)}...',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        _showPackagesDialog(record);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _showPackagesDialog(InspectionRecord record) async {
    if (record.id == null) return;
    try {
      final packages = await client.inspection.listInspectionPackages(
        inspectionRecordId: record.id!,
        limit: 20,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => _PackagesDialog(
          record: record,
          packages: packages,
          userId: _createdById,
          onRefresh: () async {
            final updated = await client.inspection.listInspectionPackages(
              inspectionRecordId: record.id!,
              limit: 20,
            );
            return updated;
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load packages: $e'),
            backgroundColor: AppColors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return AppShell(
      title: 'Inspection Management',
      icon: Icons.fact_check,
      child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ═══════════════════════════════════════════════════════════════════
          // LEFT COLUMN: Create Inspection Record
          // ═══════════════════════════════════════════════════════════════════
          Expanded(
            flex: 2,
            child: _buildCreateInspectionCard(),
          ),
          const SizedBox(width: 24),
          // ═══════════════════════════════════════════════════════════════════
          // RIGHT COLUMN: Active Inspections
          // ═══════════════════════════════════════════════════════════════════
          Expanded(
            flex: 3,
            child: _buildActiveInspectionsCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCreateInspectionCard(),
        const SizedBox(height: 24),
        _buildActiveInspectionsCard(),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Create Inspection Card
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildCreateInspectionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.indigo600.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add_task,
                      color: AppColors.indigo600, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Inspection Record',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate800,
                        ),
                      ),
                      Text(
                        'Generate secure auditor access token',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Form
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Organization & Site
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<Organization>(
                        value: _selectedOrg,
                        decoration: InputDecoration(
                          labelText: 'Organization',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.business),
                        ),
                        items: _orgs
                            .map((o) => DropdownMenuItem(
                                  value: o,
                                  child: Text(o.name),
                                ))
                            .toList(),
                        onChanged: (o) {
                          if (o?.id != null) _loadSites(o!.id!);
                          setState(() => _selectedOrg = o);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<Site>(
                        value: _selectedSite,
                        decoration: InputDecoration(
                          labelText: 'Site',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        items: _sites
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s.name),
                                ))
                            .toList(),
                        onChanged: (s) => setState(() => _selectedSite = s),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Inspection Type
                DropdownButtonFormField<String>(
                  value: _typeController.text,
                  decoration: InputDecoration(
                    labelText: 'Inspection Type',
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.category),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'fda', child: Text('FDA Inspection')),
                    DropdownMenuItem(value: 'ema', child: Text('EMA Inspection')),
                    DropdownMenuItem(
                        value: 'internal', child: Text('Internal Audit')),
                    DropdownMenuItem(
                        value: 'customer', child: Text('Customer Audit')),
                  ],
                  onChanged: (v) =>
                      setState(() => _typeController.text = v ?? 'fda'),
                ),
                const SizedBox(height: 16),
                // Scope
                TextFormField(
                  controller: _scopeController,
                  decoration: InputDecoration(
                    labelText: 'Scope Description',
                    hintText: 'e.g., GMP Training Records Review',
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                // Inspector Names
                TextFormField(
                  controller: _inspectorController,
                  decoration: InputDecoration(
                    labelText: 'Inspector Names',
                    hintText: 'e.g., John Smith, Jane Doe',
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.badge),
                  ),
                ),
                const SizedBox(height: 16),
                // Token Duration & Scheduled Date
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _tokenHours,
                        decoration: InputDecoration(
                          labelText: 'Token Validity',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.timer),
                        ),
                        items: [24, 48, 72, 168]
                            .map((h) => DropdownMenuItem(
                                  value: h,
                                  child: Text(h < 168 ? '$h hours' : '7 days'),
                                ))
                            .toList(),
                        onChanged: (h) =>
                            setState(() => _tokenHours = h ?? 48),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setState(() => _scheduledDate = date);
                          }
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Scheduled Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            _scheduledDate != null
                                ? _scheduledDate!.toString().split(' ')[0]
                                : 'Select date',
                            style: TextStyle(
                              color: _scheduledDate != null
                                  ? AppColors.slate800
                                  : AppColors.slate500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Submit Button
                FilledButton.icon(
                  onPressed: _creating ? null : _createInspection,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.indigo600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _creating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.vpn_key, size: 20),
                  label: Text(
                    _creating ? 'Creating...' : 'Create & Generate Token',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Active Inspections Card
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildActiveInspectionsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.teal50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      Icon(Icons.fact_check, color: AppColors.teal600, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Inspections',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate800,
                        ),
                      ),
                      Text(
                        '${_records.length} inspection records',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _load,
                  icon: Icon(Icons.refresh, color: AppColors.slate500),
                  tooltip: 'Refresh',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // List
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(48),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_records.isEmpty)
            const Padding(
              padding: EdgeInsets.all(48),
              child: EmptyState(
                message: 'No inspection records yet',
                icon: Icons.inbox,
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _records.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final record = _records[index];
                return _InspectionRecordTile(
                  record: record,
                  onGeneratePackage: () => _generatePackage(record),
                  onViewPackages: () => _showPackagesDialog(record),
                );
              },
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INSPECTION RECORD TILE
// ═══════════════════════════════════════════════════════════════════════════════
class _InspectionRecordTile extends StatelessWidget {
  const _InspectionRecordTile({
    required this.record,
    required this.onGeneratePackage,
    required this.onViewPackages,
  });

  final InspectionRecord record;
  final VoidCallback onGeneratePackage;
  final VoidCallback onViewPackages;

  @override
  Widget build(BuildContext context) {
    final isExpired = record.tokenExpiresAt?.isBefore(DateTime.now()) ?? false;
    final statusColor = _getStatusColor(record.status);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getTypeIcon(record.inspectionType),
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      record.inspectionType.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        record.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    if (isExpired) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.destructive.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'EXPIRED',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.destructive,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  record.site?.name ?? 'Site ${record.siteId}',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.slate600,
                  ),
                ),
                if (record.scopeDescription != null &&
                    record.scopeDescription!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    record.scopeDescription!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.slate500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  'Expires: ${record.tokenExpiresAt?.toString().split('.').first ?? "N/A"}',
                  style: TextStyle(
                    fontSize: 11,
                    color: isExpired ? AppColors.destructive : AppColors.slate500,
                  ),
                ),
              ],
            ),
          ),
          // Actions
          const SizedBox(width: 12),
          Column(
            children: [
              // Generate Briefing Pack Button (ADM-WF-08)
              FilledButton.icon(
                onPressed: onGeneratePackage,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.teal600,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.inventory_2, size: 16),
                label: const Text(
                  'Generate Briefing Pack',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: onViewPackages,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.slate700,
                  side: BorderSide(color: AppColors.slate300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.folder_open, size: 16),
                label: const Text(
                  'View Packages',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'completed':
        return AppColors.info;
      case 'closed':
        return AppColors.slate500;
      default:
        return AppColors.slate600;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'fda':
        return Icons.medical_services;
      case 'ema':
        return Icons.euro;
      case 'internal':
        return Icons.home_work;
      case 'customer':
        return Icons.handshake;
      default:
        return Icons.assignment;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADM-WF-08: PACKAGES DIALOG
// ═══════════════════════════════════════════════════════════════════════════════
class _PackagesDialog extends StatefulWidget {
  const _PackagesDialog({
    required this.record,
    required this.packages,
    required this.userId,
    required this.onRefresh,
  });

  final InspectionRecord record;
  final List<InspectionPackage> packages;
  final int? userId;
  final Future<List<InspectionPackage>> Function() onRefresh;

  @override
  State<_PackagesDialog> createState() => _PackagesDialogState();
}

class _PackagesDialogState extends State<_PackagesDialog> {
  late List<InspectionPackage> _packages;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _packages = widget.packages;
  }

  Future<void> _refresh() async {
    setState(() => _loading = true);
    try {
      final updated = await widget.onRefresh();
      if (mounted) {
        setState(() {
          _packages = updated;
          _loading = false;
        });
      }
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _signAsOfficial(InspectionPackage pkg) async {
    if (widget.userId == null || pkg.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _SignPackageDialog(
        package: pkg,
        userId: widget.userId!,
      ),
    );

    if (confirmed == true && mounted) {
      await _refresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.verified, color: Colors.white, size: 18),
                const SizedBox(width: 12),
                const Text('Package signed as OFFICIAL'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.inventory_2,
                        color: AppColors.indigo600, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Inspection Packages',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate800,
                          ),
                        ),
                        Text(
                          'ADM-WF-08 • ${widget.record.inspectionType.toUpperCase()} - ${widget.record.site?.name ?? ""}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.slate600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: AppColors.slate500,
                  ),
                ],
              ),
            ),

            // Compliance Notice
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.info.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.gpp_good, size: 20, color: AppColors.info),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '21 CFR Part 11: Only OFFICIAL packages with e-signature are valid for regulatory submission.',
                      style: TextStyle(fontSize: 12, color: AppColors.info),
                    ),
                  ),
                ],
              ),
            ),

            // Packages List
            Flexible(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _packages.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(48),
                          child: EmptyState(
                            message: 'No packages yet. Generate one first.',
                            icon: Icons.folder_off,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _packages.length,
                          itemBuilder: (ctx, i) {
                            final pkg = _packages[i];
                            return _PackageCard(
                              package: pkg,
                              canSign: widget.userId != null && !pkg.isOfficial,
                              onSign: () => _signAsOfficial(pkg),
                            );
                          },
                        ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Refresh'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PACKAGE CARD (with SHA-256 Hash)
// ═══════════════════════════════════════════════════════════════════════════════
class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.package,
    required this.canSign,
    required this.onSign,
  });

  final InspectionPackage package;
  final bool canSign;
  final VoidCallback onSign;

  @override
  Widget build(BuildContext context) {
    final hash = package.fileHash ?? '';
    final truncatedHash = hash.length > 24 ? '${hash.substring(0, 24)}...' : hash;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: package.isOfficial
            ? AppColors.success.withOpacity(0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: package.isOfficial
              ? AppColors.success.withOpacity(0.3)
              : AppColors.slate200,
          width: package.isOfficial ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: package.isOfficial
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.slate100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  package.isOfficial ? Icons.verified : Icons.description,
                  size: 20,
                  color: package.isOfficial
                      ? AppColors.success
                      : AppColors.slate600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Package #${package.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // OFFICIAL Badge (ADM-WF-08)
                        if (package.isOfficial)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.verified,
                                    size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                                const Text(
                                  'OFFICIAL',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Generated: ${package.generatedAt.toString().split('.').first}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Hash Display (prominent SHA-256)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Row(
              children: [
                Icon(Icons.fingerprint, size: 18, color: AppColors.indigo600),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SHA-256 Hash',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SelectableText(
                        truncatedHash.isNotEmpty ? truncatedHash : 'N/A',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: hash.isNotEmpty
                      ? () {
                          Clipboard.setData(ClipboardData(text: hash));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('SHA-256 hash copied'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      : null,
                  icon: Icon(Icons.copy, size: 16, color: AppColors.slate500),
                  tooltip: 'Copy full hash',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Stats Row
          Row(
            children: [
              _StatBadge(
                icon: Icons.article,
                label: '${package.includedRecordsCount ?? 0} records',
              ),
              const SizedBox(width: 12),
              if (package.generatedBy != null)
                _StatBadge(
                  icon: Icons.person,
                  label:
                      '${package.generatedBy!.firstName} ${package.generatedBy!.lastName}',
                ),
              const Spacer(),
              // Sign as Official Button (ADM-WF-08)
              if (canSign)
                FilledButton.icon(
                  onPressed: onSign,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.indigo600,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.draw, size: 16),
                  label: const Text(
                    'Sign as Official',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
            ],
          ),

          // Signed By Info
          if (package.isOfficial && package.officialEsignature != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.success.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified_user, size: 16, color: AppColors.success),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Signed by ${package.officialEsignature!.user?.firstName ?? ""} ${package.officialEsignature!.user?.lastName ?? ""} on ${package.officialEsignature!.timestamp.toString().split('.').first}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.slate100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.slate600),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.slate600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADM-WF-08: SIGN PACKAGE DIALOG (with showEsignatureModal)
// ═══════════════════════════════════════════════════════════════════════════════
class _SignPackageDialog extends StatefulWidget {
  const _SignPackageDialog({
    required this.package,
    required this.userId,
  });

  final InspectionPackage package;
  final int userId;

  @override
  State<_SignPackageDialog> createState() => _SignPackageDialogState();
}

class _SignPackageDialogState extends State<_SignPackageDialog> {
  bool _signing = false;
  String? _error;

  static const String _requiredMeaning =
      'I certify this inspection package is accurate and complete';

  Future<void> _sign() async {
    setState(() {
      _signing = true;
      _error = null;
    });

    try {
      // ADM-WF-08: Use showEsignatureModal with exact required meaning
      final esignatureId = await showEsignatureModal(
        context,
        entityType: 'inspection_package',
        entityId: widget.package.id.toString(),
        signatureMeaning: _requiredMeaning,
        userId: widget.userId,
      );

      if (esignatureId == null) {
        if (mounted) {
          setState(() {
            _signing = false;
            _error = 'E-signature cancelled';
          });
        }
        return;
      }

      // Call backend to mark package as official with e-signature
      await client.inspection.signInspectionPackageAsOfficial(
        packageId: widget.package.id!,
        userId: widget.userId,
        signatureMeaning: _requiredMeaning,
        passwordPlaintext: '', // Not needed when using esignature modal
      );

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _signing = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hash = widget.package.fileHash ?? '';
    final truncatedHash = hash.length > 32 ? '${hash.substring(0, 32)}...' : hash;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.indigo600,
                    AppColors.indigo700,
                  ],
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.draw, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign as Official',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'ADM-WF-08 • 21 CFR Part 11 Compliance',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Package Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.inventory_2,
                                size: 18, color: AppColors.slate600),
                            const SizedBox(width: 8),
                            Text(
                              'Package #${widget.package.id}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.fingerprint,
                                size: 16, color: AppColors.indigo600),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                truncatedHash,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: AppColors.slate600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Signature Meaning (fixed)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.warning.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.edit_note,
                                size: 18, color: AppColors.warning),
                            const SizedBox(width: 8),
                            Text(
                              'Required Signature Meaning',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '"$_requiredMeaning"',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: AppColors.slate700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Compliance Notice
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.info.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.gpp_good, size: 20, color: AppColors.info),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This action creates an irrevocable electronic signature record per 21 CFR Part 11 requirements.',
                            style:
                                TextStyle(fontSize: 12, color: AppColors.info),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.destructive.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.destructive.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              size: 18, color: AppColors.destructive),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.destructive,
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

            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _signing ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: _signing ? null : _sign,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: _signing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.verified, size: 18),
                      label: Text(
                        _signing ? 'Signing...' : 'Sign & Certify as Official',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
