import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// SYSTEM SETTINGS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminSystemSettingsScreen extends ConsumerStatefulWidget {
  const AdminSystemSettingsScreen({super.key});

  @override
  ConsumerState<AdminSystemSettingsScreen> createState() => _AdminSystemSettingsScreenState();
}

class _AdminSystemSettingsScreenState extends ConsumerState<AdminSystemSettingsScreen> {
  // Sample settings - in production would come from backend
  final Map<String, dynamic> _settings = {
    'orgName': 'PharmaCorp India Pvt Ltd',
    'timezone': 'Asia/Kolkata',
    'primaryLanguage': 'en-US',
    'dateFormat': 'DD/MM/YYYY',
    'passwordExpiryDays': 90,
    'sessionTimeoutMinutes': 30,
    'mfaEnabled': true,
    'auditRetentionYears': 7,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Settings Sections
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                child: Column(
                  children: [
                    _buildOrganizationSection(),
                    SizedBox(height: PharmaSpacing.md),
                    _buildLocalizationSection(),
                  ],
                ),
              ),
              SizedBox(width: PharmaSpacing.md),
              // Right Column
              Expanded(
                child: Column(
                  children: [
                    _buildSecuritySection(),
                    SizedBox(height: PharmaSpacing.md),
                    _buildComplianceSection(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('System Settings', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Organization profile, timezone, locale, and defaults',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings saved successfully')),
            );
          },
          icon: const Icon(Icons.save_outlined, size: 18),
          label: const Text('Save Changes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizationSection() {
    return _buildSettingsCard(
      title: 'Organization',
      icon: Icons.business_outlined,
      children: [
        _buildTextSetting('Organization Name', _settings['orgName'], (v) {}),
        SizedBox(height: PharmaSpacing.md),
        _buildTextSetting('Support Email', 'support@pharmacorp.com', (v) {}),
      ],
    );
  }

  Widget _buildLocalizationSection() {
    return _buildSettingsCard(
      title: 'Localization',
      icon: Icons.language_outlined,
      children: [
        _buildDropdownSetting(
          'Timezone',
          _settings['timezone'],
          ['Asia/Kolkata', 'America/New_York', 'Europe/London', 'UTC'],
          (v) {},
        ),
        SizedBox(height: PharmaSpacing.md),
        _buildDropdownSetting(
          'Primary Language',
          _settings['primaryLanguage'],
          ['en-US', 'en-GB', 'hi-IN', 'fr-FR', 'de-DE'],
          (v) {},
        ),
        SizedBox(height: PharmaSpacing.md),
        _buildDropdownSetting(
          'Date Format',
          _settings['dateFormat'],
          ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD'],
          (v) {},
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return _buildSettingsCard(
      title: 'Security',
      icon: Icons.security_outlined,
      children: [
        _buildNumberSetting('Password Expiry (days)', _settings['passwordExpiryDays'], (v) {}),
        SizedBox(height: PharmaSpacing.md),
        _buildNumberSetting('Session Timeout (minutes)', _settings['sessionTimeoutMinutes'], (v) {}),
        SizedBox(height: PharmaSpacing.md),
        _buildToggleSetting('Multi-Factor Authentication', _settings['mfaEnabled'], (v) {}),
      ],
    );
  }

  Widget _buildComplianceSection() {
    return _buildSettingsCard(
      title: 'Compliance',
      icon: Icons.verified_outlined,
      children: [
        _buildNumberSetting('Audit Log Retention (years)', _settings['auditRetentionYears'], (v) {}),
        SizedBox(height: PharmaSpacing.md),
        Container(
          padding: EdgeInsets.all(PharmaSpacing.sm),
          decoration: BoxDecoration(
            color: PharmaColors.infoBg,
            borderRadius: BorderRadius.circular(PharmaRadius.sm),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: PharmaColors.info),
              SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Text(
                  'FDA 21 CFR Part 11 compliant audit logging enabled',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.info),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: PharmaColors.emerald600),
              SizedBox(width: PharmaSpacing.sm),
              Text(title, style: PharmaTypography.headingSmall),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextSetting(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
        SizedBox(height: PharmaSpacing.xs),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(PharmaRadius.sm)),
            contentPadding: EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.sm),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSetting(String label, String value, List<String> options, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
        SizedBox(height: PharmaSpacing.xs),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(PharmaRadius.sm)),
            contentPadding: EdgeInsets.symmetric(horizontal: PharmaSpacing.md),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberSetting(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
        SizedBox(height: PharmaSpacing.xs),
        TextField(
          controller: TextEditingController(text: value.toString()),
          keyboardType: TextInputType.number,
          onChanged: (v) => onChanged(int.tryParse(v) ?? value),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(PharmaRadius.sm)),
            contentPadding: EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.sm),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSetting(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: PharmaTypography.body),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: PharmaColors.emerald600,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SYSTEM HEALTH SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminSystemHealthScreen extends ConsumerWidget {
  const AdminSystemHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System Health', style: PharmaTypography.displayLarge),
                  SizedBox(height: PharmaSpacing.xs),
                  Text(
                    'Service health, storage, queue lag, and response metrics',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
                    decoration: BoxDecoration(
                      color: PharmaColors.successBg,
                      borderRadius: BorderRadius.circular(PharmaRadius.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 14, color: PharmaColors.success),
                        const SizedBox(width: 4),
                        Text(
                          'All Systems Operational',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Refresh'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Health Metrics
          _buildHealthMetrics(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Services Status
          _buildServicesStatus(),
        ],
      ),
    );
  }

  Widget _buildHealthMetrics() {
    return Row(
      children: [
        _buildHealthCard('API Response', '45ms', Icons.speed_outlined, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildHealthCard('Database', '99.9%', Icons.storage_outlined, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildHealthCard('Queue Lag', '0.2s', Icons.queue_outlined, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildHealthCard('Storage Used', '45%', Icons.cloud_outlined, PharmaColors.info),
      ],
    );
  }

  Widget _buildHealthCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
          boxShadow: PharmaShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: PharmaSpacing.md),
            Text(value, style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesStatus() {
    final services = [
      {'name': 'Web Application', 'status': 'operational', 'uptime': '99.99%'},
      {'name': 'API Gateway', 'status': 'operational', 'uptime': '99.98%'},
      {'name': 'Database Cluster', 'status': 'operational', 'uptime': '99.99%'},
      {'name': 'File Storage', 'status': 'operational', 'uptime': '99.95%'},
      {'name': 'Email Service', 'status': 'operational', 'uptime': '99.90%'},
      {'name': 'Background Jobs', 'status': 'operational', 'uptime': '99.97%'},
    ];

    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Services Status', style: PharmaTypography.headingSmall),
          SizedBox(height: PharmaSpacing.md),
          ...services.map((s) => _buildServiceRow(s)),
        ],
      ),
    );
  }

  Widget _buildServiceRow(Map<String, String> service) {
    final isOperational = service['status'] == 'operational';
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PharmaSpacing.sm),
      child: Row(
        children: [
          Icon(
            isOperational ? Icons.check_circle : Icons.error,
            size: 18,
            color: isOperational ? PharmaColors.success : PharmaColors.danger,
          ),
          SizedBox(width: PharmaSpacing.md),
          Expanded(child: Text(service['name']!, style: PharmaTypography.body)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
            decoration: BoxDecoration(
              color: isOperational ? PharmaColors.successBg : PharmaColors.dangerBg,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Text(
              service['status']!.toUpperCase(),
              style: PharmaTypography.caption.copyWith(
                color: isOperational ? PharmaColors.success : PharmaColors.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          Text(
            service['uptime']!,
            style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// OTHER SYSTEM SCREENS - Placeholders
// ═══════════════════════════════════════════════════════════════════════════════

class AdminHrIntegrationScreen extends StatelessWidget {
  const AdminHrIntegrationScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SystemTemplate(
        title: 'HR Integration',
        subtitle: 'Manage SAP/Workday/Oracle sync connectivity and jobs.',
      );
}

class AdminApiKeysScreen extends StatelessWidget {
  const AdminApiKeysScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SystemTemplate(
        title: 'API Keys',
        subtitle: 'Create and rotate integration API credentials.',
      );
}

class AdminValidationDocsScreen extends StatelessWidget {
  const AdminValidationDocsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SystemTemplate(
        title: 'Validation Docs',
        subtitle: 'URS, FS, DQ, IQ, OQ, PQ validation records.',
      );
}

class AdminRetentionPolicyScreen extends StatelessWidget {
  const AdminRetentionPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SystemTemplate(
        title: 'Retention Policies',
        subtitle: 'Regulatory and legal data retention controls.',
      );
}

class AdminGdprScreen extends StatelessWidget {
  const AdminGdprScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SystemTemplate(
        title: 'GDPR / DSAR',
        subtitle: 'Data portability, erasure, and pseudonymization workflows.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// PLACEHOLDER TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════════

class _SystemTemplate extends StatelessWidget {
  const _SystemTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Coming Soon',
            child: AdminPlaceholderTable(
              columns: ['Feature', 'Status', 'ETA'],
              rows: [
                ['Full implementation', 'In Progress', 'Q2 2026'],
              ],
            ),
          ),
        ],
      );
}
