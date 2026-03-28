import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/features/admin_portal/widgets/admin_page_frame.dart';

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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Error loading certificates', style: PharmaTypography.body),
            SizedBox(height: PharmaSpacing.xs),
            Text(err.toString(), style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(adminCertificatesProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
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
                error: (_, __) => const SizedBox.shrink(),
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
              onPressed: () {},
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
                color: color.withOpacity(0.1),
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
              style: PharmaTypography.body.copyWith(fontFamily: 'monospace', fontSize: 11),
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

class AdminCertificateTemplateScreen extends StatelessWidget {
  const AdminCertificateTemplateScreen({super.key});
  @override
  Widget build(BuildContext context) => const _CertificateTemplate(
        title: 'Certificate Templates',
        subtitle: 'Template branding and metadata controls.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// CERTIFICATE EXPIRY DASHBOARD SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminCertificateExpiryScreen extends StatelessWidget {
  const AdminCertificateExpiryScreen({super.key});
  @override
  Widget build(BuildContext context) => const _CertificateTemplate(
        title: 'Expiry Dashboard',
        subtitle: 'Upcoming and overdue certificate expirations.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ═══════════════════════════════════════════════════════════════════════════════

class _CertificateTemplate extends StatelessWidget {
  const _CertificateTemplate({required this.title, required this.subtitle});
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
