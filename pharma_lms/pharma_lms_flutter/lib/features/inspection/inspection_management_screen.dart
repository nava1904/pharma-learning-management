import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_shell.dart';

/// Admin/QA screen to create inspection records and generate auditor tokens.
class InspectionManagementScreen extends StatefulWidget {
  const InspectionManagementScreen({super.key});

  @override
  State<InspectionManagementScreen> createState() =>
      _InspectionManagementScreenState();
}

class _InspectionManagementScreenState extends State<InspectionManagementScreen> {
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
          SnackBar(content: Text('Failed to load: $e')),
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

  Future<void> _createInspection() async {
    if (_selectedSite?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a site')),
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
        final inviteUrl =
            '$baseUrl/auditor?token=${result['accessToken']}';
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Inspection Record Created'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share this link with the auditor (valid ${result['expiresAt']}):',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    inviteUrl,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      FilledButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: inviteUrl));
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text('Link copied to clipboard'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text('Copy'),
                      ),
                    ],
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
    } catch (e) {
      if (mounted) {
        setState(() => _creating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

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
            content: Text(
              'Package generated: ${result['includedRecordsCount']} records, '
              'hash: ${(result['fileHash'] as String).substring(0, 12)}...',
            ),
          ),
        );
        _showPackagesDialog(record);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
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
          onSigned: () => Navigator.pop(ctx),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load packages: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Inspection Management',
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Inspection Record',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Organization>(
                    value: _selectedOrg,
                    decoration: const InputDecoration(
                      labelText: 'Organization',
                      border: OutlineInputBorder(),
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
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Site>(
                    value: _selectedSite,
                    decoration: const InputDecoration(
                      labelText: 'Site',
                      border: OutlineInputBorder(),
                    ),
                    items: _sites
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.name),
                            ))
                        .toList(),
                    onChanged: (s) => setState(() => _selectedSite = s),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _typeController,
                    decoration: const InputDecoration(
                      labelText: 'Inspection Type',
                      hintText: 'fda, ema, internal, customer',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _scopeController,
                    decoration: const InputDecoration(
                      labelText: 'Scope Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _inspectorController,
                    decoration: const InputDecoration(
                      labelText: 'Inspector Names',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _tokenHours,
                          decoration: const InputDecoration(
                            labelText: 'Token Valid (hours)',
                            border: OutlineInputBorder(),
                          ),
                          items: [24, 48, 72]
                              .map((h) => DropdownMenuItem(
                                    value: h,
                                    child: Text('$h hours'),
                                  ))
                              .toList(),
                          onChanged: (h) => setState(() => _tokenHours = h ?? 48),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              setState(() => _scheduledDate = date);
                            }
                          },
                          child: Text(
                            _scheduledDate != null
                                ? _scheduledDate!
                                    .toString()
                                    .split(' ')[0]
                                : 'Set Scheduled Date',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _creating ? null : _createInspection,
                    child: _creating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Create & Generate Token'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Recent Inspection Records',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_records.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No inspection records yet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                ),
              ),
            )
          else
            ..._records.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.assignment),
                    title: Text(
                      '${r.inspectionType} - ${r.site?.name ?? "Site ${r.siteId}"}',
                    ),
                    subtitle: Text(
                      '${r.status} • Expires: ${r.tokenExpiresAt?.toString().split(' ').take(2).join(' ') ?? "N/A"}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.folder_open),
                          onPressed: () => _showPackagesDialog(r),
                          tooltip: 'View packages',
                        ),
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () => _generatePackage(r),
                          tooltip: 'Generate inspection package',
                        ),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}

class _PackagesDialog extends StatefulWidget {
  const _PackagesDialog({
    required this.record,
    required this.packages,
    required this.userId,
    required this.onSigned,
  });

  final InspectionRecord record;
  final List<InspectionPackage> packages;
  final int? userId;
  final VoidCallback onSigned;

  @override
  State<_PackagesDialog> createState() => _PackagesDialogState();
}

class _PackagesDialogState extends State<_PackagesDialog> {
  List<InspectionPackage> _packages = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _packages = widget.packages;
  }

  Future<void> _signAsOfficial(InspectionPackage pkg) async {
    if (widget.userId == null || pkg.id == null) return;
    final meanings = await client.training.listSignatureMeanings();
    if (!mounted) return;
    final meaning = meanings.isNotEmpty
        ? meanings.first.meaning
        : 'I have reviewed and approve';
    final signed = await showDialog<bool>(
      context: context,
      builder: (ctx) => _SignPackageDialog(
        packageId: pkg.id!,
        userId: widget.userId!,
        defaultMeaning: meaning,
      ),
    );
    if (signed == true && mounted) {
      setState(() => _loading = true);
      try {
        final packages = await client.inspection.listInspectionPackages(
          inspectionRecordId: widget.record.id!,
          limit: 20,
        );
        if (mounted) {
          setState(() {
            _packages = packages;
            _loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Package signed as official')),
          );
        }
      } catch (e) {
        setState(() => _loading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to refresh: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Inspection Packages - ${widget.record.inspectionType}'),
      content: SizedBox(
        width: 400,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _packages.isEmpty
                ? const Text('No packages yet. Generate one first.')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _packages.length,
                    itemBuilder: (ctx, i) {
                      final p = _packages[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            p.isOfficial ? Icons.verified : Icons.description,
                            color: p.isOfficial
                                ? AppColors.success
                                : AppColors.slate600,
                          ),
                          title: Row(
                            children: [
                              Text(
                                '${p.generatedAt?.toString().split('.').first ?? "N/A"}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              if (p.isOfficial) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'OFFICIAL',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          subtitle: Text(
                            '${p.includedRecordsCount ?? 0} records • '
                            'hash: ${(p.fileHash ?? "").length > 12 ? "${(p.fileHash ?? "").substring(0, 12)}..." : p.fileHash ?? "—"}',
                          ),
                          trailing: !p.isOfficial && widget.userId != null
                              ? TextButton.icon(
                                  icon: const Icon(Icons.draw, size: 18),
                                  label: const Text('Sign as Official'),
                                  onPressed: () => _signAsOfficial(p),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _SignPackageDialog extends StatefulWidget {
  const _SignPackageDialog({
    required this.packageId,
    required this.userId,
    required this.defaultMeaning,
  });

  final int packageId;
  final int userId;
  final String defaultMeaning;

  @override
  State<_SignPackageDialog> createState() => _SignPackageDialogState();
}

class _SignPackageDialogState extends State<_SignPackageDialog> {
  final _meaningController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _signing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _meaningController.text = widget.defaultMeaning;
  }

  @override
  void dispose() {
    _meaningController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _hashPassword(String password) {
    if (password.isEmpty) return null;
    // ignore: depend_on_referenced_packages
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _sign() async {
    final password = _passwordController.text.trim();
    final meaning = _meaningController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Password required for re-authentication');
      return;
    }
    if (meaning.isEmpty) {
      setState(() => _error = 'Signature meaning required');
      return;
    }
    setState(() {
      _signing = true;
      _error = null;
    });
    try {
      await client.inspection.signInspectionPackageAsOfficial(
        packageId: widget.packageId,
        userId: widget.userId,
        signatureMeaning: meaning,
        passwordReauthHash: _hashPassword(password),
      );
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _signing = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign as Official'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'QA Director e-signature required. 21 CFR Part 11 compliant.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _meaningController,
              decoration: const InputDecoration(
                labelText: 'Signature Meaning',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password (re-authentication)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sign(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Colors.red[700])),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _signing ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _signing ? null : _sign,
          child: _signing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Sign'),
        ),
      ],
    );
  }
}
