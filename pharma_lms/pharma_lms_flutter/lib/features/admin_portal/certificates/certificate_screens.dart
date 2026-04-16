import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../widgets/admin_page_frame.dart';
import '../widgets/admin_page_scaffold.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// CERTIFICATE REGISTER SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCertificateListScreen extends ConsumerStatefulWidget {
  const AdminCertificateListScreen({super.key});

  @override
  ConsumerState<AdminCertificateListScreen> createState() => _AdminCertificateListScreenState();
}

class _AdminCertificateListScreenState extends ConsumerState<AdminCertificateListScreen> {
  String _statusFilter = 'all';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final certificatesAsync = ref.watch(adminCertificatesProvider);
    final statsAsync = ref.watch(adminCertificateStatsProvider);

    return certificatesAsync.when(
      loading: () => const AdminPageLoading(cardCount: 4),
      error: (err, stack) => AdminPageError(
        message: 'Error loading certificates: $err',
        onRetry: () => ref.invalidate(adminCertificatesProvider),
      ),
      data: (certificates) {
        final filteredCerts = certificates.where((c) {
          // Determine certificate status
          final certStatus = _getCertificateStatus(c);
          final matchesStatus = _statusFilter == 'all' || certStatus == _statusFilter;
          
          // Search filter
          final userName = c.user != null ? '${c.user!.firstName} ${c.user!.lastName}' : '';
          final userEmail = c.user?.email ?? '';
          final courseTitle = c.courseVersion?.course?.title ?? '';
          final certNumber = c.qrCode ?? '';
          
          final matchesSearch = _searchQuery.isEmpty ||
              userName.toLowerCase().contains(_searchQuery) ||
              courseTitle.toLowerCase().contains(_searchQuery) ||
              userEmail.toLowerCase().contains(_searchQuery) ||
              certNumber.toLowerCase().contains(_searchQuery);
          return matchesStatus && matchesSearch;
        }).toList();

        return SingleChildScrollView(
          padding: EdgeInsets.all(PharmaSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header
              _buildPageHeader(context),
              SizedBox(height: PharmaSpacing.sectionGap),

              // Stats Row
              statsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (stats) => _buildStatsRow(stats),
              ),
              SizedBox(height: PharmaSpacing.md),

              // Filters
              _buildFiltersRow(),
              SizedBox(height: PharmaSpacing.md),

              // Certificates Table
              _buildCertificatesTable(filteredCerts),
            ],
          ),
        );
      },
    );
  }

  String _getCertificateStatus(Certificate cert) {
    if (cert.status == 'revoked') return 'revoked';
    if (cert.status == 'expired') return 'expired';
    
    final now = DateTime.now();
    if (cert.expiresAt != null) {
      if (cert.expiresAt!.isBefore(now)) return 'expired';
      if (cert.expiresAt!.isBefore(now.add(const Duration(days: 30)))) return 'expiring_soon';
    }
    return 'valid';
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Certificate Register', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Issued and revoked certificate records',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => _showExportDialog(context),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Export'),
            ),
            SizedBox(width: PharmaSpacing.sm),
            ElevatedButton.icon(
              onPressed: () => _showIssueCertificateDialog(context),
              icon: const Icon(Icons.add_circle_outline, size: 18),
              label: const Text('Issue Certificate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow(CertificateStats stats) {
    return Row(
      children: [
        _buildStatCard('Total Issued', stats.total.toString(), Icons.card_membership, PharmaColors.info),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Active', stats.active.toString(), Icons.check_circle_outline, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Expiring Soon', stats.expiringIn30Days.toString(), Icons.warning_amber_outlined, PharmaColors.warning),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Expired', stats.expired.toString(), Icons.cancel_outlined, PharmaColors.danger),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Revoked', stats.revoked.toString(), Icons.block, PharmaColors.gray500),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: PharmaSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: PharmaTypography.headingSmall),
                Text(label, style: PharmaTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search by learner, course, or certificate number...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.sm),
              ),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          // Status Filter
          Text('Status:', style: PharmaTypography.bodyMedium),
          SizedBox(width: PharmaSpacing.sm),
          ...['all', 'valid', 'expiring_soon', 'expired', 'revoked'].map((status) => Padding(
            padding: EdgeInsets.only(right: PharmaSpacing.xs),
            child: ChoiceChip(
              label: Text(_statusLabel(status)),
              selected: _statusFilter == status,
              onSelected: (s) => setState(() => _statusFilter = status),
              selectedColor: PharmaColors.emerald100,
            ),
          )),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'all': return 'All';
      case 'valid': return 'Active';
      case 'expiring_soon': return 'Expiring';
      case 'expired': return 'Expired';
      case 'revoked': return 'Revoked';
      default: return status;
    }
  }

  Widget _buildCertificatesTable(List<Certificate> certs) {
    if (certs.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No certificates found',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
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
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.all(PharmaSpacing.md),
            decoration: BoxDecoration(
              color: PharmaColors.gray50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(PharmaRadius.md)),
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Learner', style: PharmaTypography.bodyMedium)),
                Expanded(flex: 2, child: Text('Course', style: PharmaTypography.bodyMedium)),
                Expanded(flex: 2, child: Text('Certificate #', style: PharmaTypography.bodyMedium)),
                Expanded(child: Text('Issued', style: PharmaTypography.bodyMedium)),
                Expanded(child: Text('Expires', style: PharmaTypography.bodyMedium)),
                Expanded(child: Text('Status', style: PharmaTypography.bodyMedium)),
                const SizedBox(width: 80),
              ],
            ),
          ),
          // Table Rows
          ...certs.map((cert) => _buildCertificateRow(cert)),
        ],
      ),
    );
  }

  Widget _buildCertificateRow(Certificate cert) {
    final userName = cert.user != null ? '${cert.user!.firstName} ${cert.user!.lastName}' : 'Unknown';
    final userEmail = cert.user?.email ?? '';
    final courseTitle = cert.courseVersion?.course?.title ?? 'Course';
    final certNumber = cert.qrCode ?? 'N/A';
    final status = _getCertificateStatus(cert);
    
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: PharmaTypography.body),
                Text(userEmail, style: PharmaTypography.caption),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(courseTitle, style: PharmaTypography.body)),
          Expanded(
            flex: 2,
            child: Text(
              certNumber.length > 20 ? '${certNumber.substring(0, 20)}...' : certNumber,
              style: PharmaTypography.body.copyWith(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          Expanded(child: Text(_formatDate(cert.issuedAt), style: PharmaTypography.body)),
          Expanded(
            child: Text(
              cert.expiresAt != null ? _formatDate(cert.expiresAt!) : '-',
              style: PharmaTypography.body,
            ),
          ),
          Expanded(child: _buildStatusBadge(status)),
          SizedBox(
            width: 80,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  onPressed: () {},
                  tooltip: 'View',
                ),
                IconButton(
                  icon: const Icon(Icons.download_outlined, size: 18),
                  onPressed: () {},
                  tooltip: 'Download',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case 'valid':
        bgColor = PharmaColors.successBg;
        textColor = PharmaColors.success;
        label = 'Active';
        break;
      case 'expiring_soon':
        bgColor = PharmaColors.warningBg;
        textColor = PharmaColors.warning;
        label = 'Expiring';
        break;
      case 'expired':
        bgColor = PharmaColors.dangerBg;
        textColor = PharmaColors.danger;
        label = 'Expired';
        break;
      case 'revoked':
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.gray600;
        label = 'Revoked';
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(
        label,
        style: PharmaTypography.caption.copyWith(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _showIssueCertificateDialog(BuildContext context) {
    final userIdController = TextEditingController();
    final courseVersionIdController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Issue Certificate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(labelText: 'User ID', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: PharmaSpacing.md),
            TextField(
              controller: courseVersionIdController,
              decoration: const InputDecoration(labelText: 'Course Version ID', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final userId = int.tryParse(userIdController.text.trim());
              final cvId = int.tryParse(courseVersionIdController.text.trim());
              if (userId == null || cvId == null) return;
              Navigator.pop(ctx);
              try {
                await client.certificate.issueCertificate(
                  userId: userId,
                  courseVersionId: cvId,
                );
                ref.invalidate(adminCertificatesProvider);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Certificate issued successfully')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e'), backgroundColor: PharmaColors.danger),
                  );
                }
              }
            },
            child: const Text('Issue'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Certificates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('CSV Export'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting certificates to CSV...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF Report'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating PDF report...')),
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// CERTIFICATE TEMPLATE SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCertificateTemplateScreen extends ConsumerStatefulWidget {
  const AdminCertificateTemplateScreen({super.key});

  @override
  ConsumerState<AdminCertificateTemplateScreen> createState() => _AdminCertificateTemplateScreenState();
}

class _AdminCertificateTemplateScreenState extends ConsumerState<AdminCertificateTemplateScreen> {
  List<Map<String, dynamic>> _templates = [];
  bool _loading = true;
  final _nameController = TextEditingController();
  final _htmlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _htmlController.dispose();
    super.dispose();
  }

  Future<void> _loadTemplates() async {
    try {
      final me = await ref.read(currentUserProvider.future);
      if (me == null) return;
      final templates = await client.certificateTemplate.listTemplates(
        organizationId: me.organizationId,
      );
      if (mounted) {
        setState(() {
          _templates = templates.map((t) => {
            'id': t.id,
            'name': t.name,
            'isDefault': t.isDefault,
            'createdAt': t.createdAt,
          }).toList();
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showCreateTemplateDialog() {
    _nameController.clear();
    _htmlController.text = _defaultTemplateHtml();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Certificate Template'),
        content: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Template Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              Container(
                padding: EdgeInsets.all(PharmaSpacing.sm),
                decoration: BoxDecoration(
                  color: PharmaColors.gray100,
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Merge Fields:', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(height: PharmaSpacing.xs),
                    Wrap(
                      spacing: 8,
                      children: ['{{learnerName}}', '{{courseName}}', '{{issueDate}}', '{{expiryDate}}', '{{evaluator}}', '{{qrCode}}', '{{organizationName}}']
                          .map((f) => Chip(label: Text(f, style: PharmaTypography.caption), visualDensity: VisualDensity.compact))
                          .toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              SizedBox(
                height: 200,
                child: TextField(
                  controller: _htmlController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    labelText: 'HTML Template',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  style: PharmaTypography.body.copyWith(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              if (_nameController.text.trim().isEmpty) return;
              Navigator.pop(ctx);
              try {
                final me = await ref.read(currentUserProvider.future);
                if (me == null) return;
                await client.certificateTemplate.createTemplate(
                  organizationId: me.organizationId,
                  name: _nameController.text.trim(),
                  htmlTemplate: _htmlController.text,
                  isDefault: false,
                );
                _loadTemplates();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Template created')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  String _defaultTemplateHtml() {
    return '''<div style="text-align:center;padding:60px;font-family:Georgia,serif;border:4px double #333;margin:20px;">
  <h1 style="color:#1a5276;">Certificate of Completion</h1>
  <p style="font-size:18px;margin:30px 0;">This certifies that</p>
  <h2 style="color:#2c3e50;font-size:28px;">{{learnerName}}</h2>
  <p style="font-size:18px;margin:20px 0;">has successfully completed</p>
  <h3 style="color:#1a5276;">{{courseName}}</h3>
  <p style="margin:30px 0;">Issue Date: {{issueDate}}</p>
  <p>Expiry Date: {{expiryDate}}</p>
  <p style="margin-top:40px;font-size:12px;color:#666;">{{organizationName}}</p>
</div>''';
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Certificate Templates',
      subtitle: 'Create and manage certificate templates with merge fields.',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: _showCreateTemplateDialog,
              icon: const Icon(Icons.add_circle_outline, size: 18),
              label: const Text('Create Template'),
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: PharmaSpacing.md),
        if (_loading)
          const Center(child: CircularProgressIndicator())
        else if (_templates.isEmpty)
          AdminSectionCard(
            title: 'No Templates',
            child: Text(
              'Create your first certificate template to get started.',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
            ),
          )
        else
          AdminSectionCard(
            title: 'Templates (${_templates.length})',
            child: AdminDataTable(
              columns: const ['Name', 'Default', 'Created'],
              rows: _templates.map((t) => [
                t['name'] as String,
                (t['isDefault'] as bool) ? 'Yes' : 'No',
                (t['createdAt'] as DateTime).toLocal().toString().split('.').first,
              ]).toList(),
            ),
          ),
      ],
    );
  }
}

class AdminCertificateExpiryScreen extends ConsumerStatefulWidget {
  const AdminCertificateExpiryScreen({super.key});

  @override
  ConsumerState<AdminCertificateExpiryScreen> createState() => _AdminCertificateExpiryScreenState();
}

class _AdminCertificateExpiryScreenState extends ConsumerState<AdminCertificateExpiryScreen> {
  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = Future.wait([
      client.analytics.getCertificationExpiryRiskCount(),
      client.analytics.getUpcomingExpirationsByDepartment(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Expiry Dashboard',
      subtitle: 'Certificates expiring by horizon and department.',
      children: [
        FutureBuilder<List<dynamic>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Text('${snap.error}');
            }
            final risk = snap.data![0] as int;
            final byDept = snap.data![1] as Map<String, List<Certificate>>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminSectionCard(
                  title: 'Risk overview',
                  child: Text(
                    'Certificates expiring in the next 30 days (org risk count): $risk',
                    style: PharmaTypography.bodyMedium,
                  ),
                ),
                AdminSectionCard(
                  title: 'Upcoming expirations by department bucket',
                  child: AdminDataTable(
                    columns: const ['Bucket / department key', 'Certificate count', 'Next expiry'],
                    rows: byDept.entries.map((e) {
                      final certs = e.value;
                      final next = certs
                          .map((c) => c.expiresAt)
                          .whereType<DateTime>()
                          .fold<DateTime?>(null, (a, b) => a == null || b.isBefore(a) ? b : a);
                      return [
                        e.key,
                        '${certs.length}',
                        next?.toLocal().toString().split('.').first ?? '—',
                      ];
                    }).toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => setState(_reload),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
