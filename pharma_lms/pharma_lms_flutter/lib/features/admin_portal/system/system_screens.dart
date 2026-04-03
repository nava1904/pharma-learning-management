import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show Organization;
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// SYSTEM SETTINGS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

/// Keys stored in `system_configuration` for the signed-in organization.
abstract final class _OrgSettingKeys {
  static const supportEmail = 'support_email';
  static const timezone = 'timezone';
  static const primaryLanguage = 'primary_language';
  static const dateFormat = 'date_format';
  static const passwordExpiryDays = 'password_expiry_days';
  static const sessionTimeoutMinutes = 'session_timeout_minutes';
  static const mfaRequired = 'mfa_required';
  static const auditRetentionYears = 'audit_retention_years';
}

abstract final class _OrgSettingDefaults {
  static String val(String key) => switch (key) {
        _OrgSettingKeys.supportEmail => '',
        _OrgSettingKeys.timezone => 'UTC',
        _OrgSettingKeys.primaryLanguage => 'en-US',
        _OrgSettingKeys.dateFormat => 'YYYY-MM-DD',
        _OrgSettingKeys.passwordExpiryDays => '90',
        _OrgSettingKeys.sessionTimeoutMinutes => '30',
        _OrgSettingKeys.mfaRequired => 'false',
        _OrgSettingKeys.auditRetentionYears => '7',
        _ => '',
      };
}

class AdminSystemSettingsScreen extends ConsumerStatefulWidget {
  const AdminSystemSettingsScreen({super.key});

  @override
  ConsumerState<AdminSystemSettingsScreen> createState() => _AdminSystemSettingsScreenState();
}

class _AdminSystemSettingsScreenState extends ConsumerState<AdminSystemSettingsScreen> {
  int? _organizationId;

  final _orgName = TextEditingController();
  final _orgCode = TextEditingController();
  final _supportEmail = TextEditingController();
  final _passwordExpiryDays = TextEditingController();
  final _sessionTimeoutMinutes = TextEditingController();
  final _auditRetentionYears = TextEditingController();

  String _timezone = _OrgSettingDefaults.val(_OrgSettingKeys.timezone);
  String _primaryLanguage = _OrgSettingDefaults.val(_OrgSettingKeys.primaryLanguage);
  String _dateFormat = _OrgSettingDefaults.val(_OrgSettingKeys.dateFormat);
  bool _mfaRequired = false;

  bool _loading = true;
  bool _saving = false;
  String? _loadError;

  static const _timezones = ['UTC', 'Asia/Kolkata', 'America/New_York', 'Europe/London'];
  static const _languages = ['en-US', 'en-GB', 'hi-IN', 'fr-FR', 'de-DE'];
  static const _dateFormats = ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _orgName.dispose();
    _orgCode.dispose();
    _supportEmail.dispose();
    _passwordExpiryDays.dispose();
    _sessionTimeoutMinutes.dispose();
    _auditRetentionYears.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) {
        setState(() {
          _loading = false;
          _loadError = 'Not signed in';
        });
        return;
      }
      final orgId = user.organizationId;
      final org = await client.organization.getOrganization(orgId);
      final rows = await client.organization.listOrganizationSettings(orgId);
      final map = {for (final r in rows) r.key: r.value};

      String pick(String key) => (map[key] != null && map[key]!.isNotEmpty) ? map[key]! : _OrgSettingDefaults.val(key);

      if (!mounted) return;
      setState(() {
        _organizationId = orgId;
        _orgName.text = org?.name ?? '';
        _orgCode.text = org?.code ?? '';
        _supportEmail.text = pick(_OrgSettingKeys.supportEmail);
        _passwordExpiryDays.text = pick(_OrgSettingKeys.passwordExpiryDays);
        _sessionTimeoutMinutes.text = pick(_OrgSettingKeys.sessionTimeoutMinutes);
        _auditRetentionYears.text = pick(_OrgSettingKeys.auditRetentionYears);
        _timezone = pick(_OrgSettingKeys.timezone);
        if (!_timezones.contains(_timezone)) _timezone = _timezones.first;
        _primaryLanguage = pick(_OrgSettingKeys.primaryLanguage);
        if (!_languages.contains(_primaryLanguage)) _primaryLanguage = _languages.first;
        _dateFormat = pick(_OrgSettingKeys.dateFormat);
        if (!_dateFormats.contains(_dateFormat)) _dateFormat = _dateFormats.first;
        _mfaRequired = pick(_OrgSettingKeys.mfaRequired).toLowerCase() == 'true';
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadError = '$e';
        });
      }
    }
  }

  Future<void> _save() async {
    final orgId = _organizationId;
    if (orgId == null) return;
    setState(() => _saving = true);
    try {
      await client.organization.updateOrganization(
        organizationId: orgId,
        name: _orgName.text.trim().isEmpty ? null : _orgName.text.trim(),
        code: _orgCode.text.trim().isEmpty ? null : _orgCode.text.trim(),
      );

      Future<void> put(String key, String value) =>
          client.organization.upsertOrganizationSetting(organizationId: orgId, key: key, value: value);

      await put(_OrgSettingKeys.supportEmail, _supportEmail.text.trim());
      await put(_OrgSettingKeys.timezone, _timezone);
      await put(_OrgSettingKeys.primaryLanguage, _primaryLanguage);
      await put(_OrgSettingKeys.dateFormat, _dateFormat);
      await put(_OrgSettingKeys.passwordExpiryDays, _passwordExpiryDays.text.trim());
      await put(_OrgSettingKeys.sessionTimeoutMinutes, _sessionTimeoutMinutes.text.trim());
      await put(_OrgSettingKeys.mfaRequired, _mfaRequired ? 'true' : 'false');
      await put(_OrgSettingKeys.auditRetentionYears, _auditRetentionYears.text.trim());

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_loadError!, style: TextStyle(color: PharmaColors.danger)),
            TextButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(),
          SizedBox(height: PharmaSpacing.sectionGap),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              'Organization profile and org-scoped configuration (database)',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: _saving ? null : _save,
          icon: _saving
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.save_outlined, size: 18),
          label: Text(_saving ? 'Saving…' : 'Save Changes'),
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
        _buildLabeledField('Organization name', _orgName),
        SizedBox(height: PharmaSpacing.md),
        _buildLabeledField('Organization code', _orgCode),
        SizedBox(height: PharmaSpacing.md),
        _buildLabeledField('Support email', _supportEmail),
      ],
    );
  }

  Widget _buildLocalizationSection() {
    return _buildSettingsCard(
      title: 'Localization',
      icon: Icons.language_outlined,
      children: [
        _buildDropdown('Timezone', _timezone, _timezones, (v) => setState(() => _timezone = v ?? _timezone)),
        SizedBox(height: PharmaSpacing.md),
        _buildDropdown('Primary language', _primaryLanguage, _languages, (v) => setState(() => _primaryLanguage = v ?? _primaryLanguage)),
        SizedBox(height: PharmaSpacing.md),
        _buildDropdown('Date format', _dateFormat, _dateFormats, (v) => setState(() => _dateFormat = v ?? _dateFormat)),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return _buildSettingsCard(
      title: 'Security',
      icon: Icons.security_outlined,
      children: [
        _buildLabeledField('Password expiry (days)', _passwordExpiryDays, number: true),
        SizedBox(height: PharmaSpacing.md),
        _buildLabeledField('Session timeout (minutes)', _sessionTimeoutMinutes, number: true),
        SizedBox(height: PharmaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Require MFA (policy flag)', style: PharmaTypography.body),
            Switch(
              value: _mfaRequired,
              onChanged: (v) => setState(() => _mfaRequired = v),
              activeThumbColor: PharmaColors.emerald600,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildComplianceSection() {
    return _buildSettingsCard(
      title: 'Compliance',
      icon: Icons.verified_outlined,
      children: [
        _buildLabeledField('Audit log retention (years)', _auditRetentionYears, number: true),
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
                  'Values persist in system_configuration. MFA enforcement still depends on auth/MFA services.',
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

  Widget _buildLabeledField(String label, TextEditingController c, {bool number = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
        SizedBox(height: PharmaSpacing.xs),
        TextField(
          controller: c,
          keyboardType: number ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(PharmaRadius.sm)),
            contentPadding: EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.sm),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options, void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
        SizedBox(height: PharmaSpacing.xs),
        DropdownButtonFormField<String>(
          initialValue: options.contains(value) ? value : options.first,
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// SYSTEM HEALTH SCREEN (live: analytics.getSystemHealth)
// ═══════════════════════════════════════════════════════════════════════════════

class AdminSystemHealthScreen extends ConsumerStatefulWidget {
  const AdminSystemHealthScreen({super.key});

  @override
  ConsumerState<AdminSystemHealthScreen> createState() => _AdminSystemHealthScreenState();
}

class _AdminSystemHealthScreenState extends ConsumerState<AdminSystemHealthScreen> {
  Map<String, String>? _health;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final h = await client.analytics.getSystemHealth();
      if (mounted) {
        setState(() {
          _health = h.map((k, v) => MapEntry(k, v.toString()));
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = '$e';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System Health', style: PharmaTypography.displayLarge),
                  SizedBox(height: PharmaSpacing.xs),
                  Text(
                    'Database connectivity, job queue (DLQ), and recent scheduled jobs (IT-02).',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: _loading ? null : _load,
                icon: _loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh, size: 18),
                label: const Text('Refresh'),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.sectionGap),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(_error!, style: TextStyle(color: PharmaColors.danger)),
            )
          else if (_loading && _health == null)
            const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
          else if (_health != null) ...[
            _buildMetricRow(context),
            SizedBox(height: PharmaSpacing.sectionGap),
            _buildRecentJobs(_health!),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context) {
    final h = _health!;
    final dbOk = h['databaseConnected'] == 'true';
    final dlq = int.tryParse(h['dlqCount'] ?? '');
    final lag = h['kafkaConsumerLag'];
    return Wrap(
      spacing: PharmaSpacing.md,
      runSpacing: PharmaSpacing.md,
      children: [
        _buildHealthCard(
          'Database',
          dbOk ? 'Connected' : 'Unreachable',
          Icons.storage_outlined,
          dbOk ? PharmaColors.success : PharmaColors.danger,
        ),
        _buildHealthCard(
          'Dead-letter queue',
          dlq == null ? '—' : '$dlq unresolved',
          Icons.queue_outlined,
          (dlq != null && dlq > 0) ? PharmaColors.warningText : PharmaColors.success,
        ),
        _buildHealthCard(
          'Event consumer lag',
          lag == null ? '—' : '$lag',
          Icons.hub_outlined,
          PharmaColors.info,
        ),
      ],
    );
  }

  Widget _buildHealthCard(String label, String value, IconData icon, Color color) {
    return SizedBox(
      width: 200,
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
            Icon(icon, size: 20, color: color),
            SizedBox(height: PharmaSpacing.md),
            Text(value, style: PharmaTypography.headingSmall),
            SizedBox(height: PharmaSpacing.xs),
            Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentJobs(Map<String, String> h) {
    final raw = h['recentJobs'];
    List<dynamic> jobs = [];
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) jobs = decoded;
      } catch (_) {}
    }
    final rows = <List<String>>[];
    for (final j in jobs) {
      if (j is! Map) continue;
      final name = j['jobName']?.toString() ?? '';
      final status = j['status']?.toString() ?? '';
      final started = j['startedAt']?.toString() ?? '';
      rows.add([name, status, started]);
    }
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
          Text('Recent scheduled jobs', style: PharmaTypography.headingSmall),
          SizedBox(height: PharmaSpacing.md),
          if (rows.isEmpty)
            Text(
              'No recent job logs.',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            )
          else
            AdminDataTable(
              columns: const ['Job', 'Status', 'Started'],
              rows: rows,
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INTEGRATION & POLICY (org context + links to implemented admin modules)
// ═══════════════════════════════════════════════════════════════════════════════

class AdminHrIntegrationScreen extends ConsumerWidget {
  const AdminHrIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SystemIntegrationFrame(
      title: 'HR Integration',
      subtitle:
          'HRIS connectors are deployed outside this UI (Serverpod + your IdP). Below is live organization context from the database.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orgSummary(ref),
          SizedBox(height: PharmaSpacing.md),
          Wrap(
            spacing: PharmaSpacing.sm,
            runSpacing: PharmaSpacing.sm,
            children: [
              OutlinedButton(
                onPressed: () => context.push('/admin/system/settings'),
                child: const Text('Session & org settings'),
              ),
              OutlinedButton(
                onPressed: () => context.push('/admin/users/import'),
                child: const Text('Bulk user import'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminApiKeysScreen extends ConsumerWidget {
  const AdminApiKeysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SystemIntegrationFrame(
      title: 'API Keys',
      subtitle:
          'Production API keys are issued via your API gateway or infrastructure — not stored in this Flutter client. Organization context is loaded live.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orgSummary(ref),
          SizedBox(height: PharmaSpacing.md),
          OutlinedButton(
            onPressed: () => context.push('/admin/system/settings'),
            child: const Text('Organization settings'),
          ),
        ],
      ),
    );
  }
}

class AdminValidationDocsScreen extends ConsumerWidget {
  const AdminValidationDocsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SystemIntegrationFrame(
      title: 'Validation Docs',
      subtitle:
          'Store URS/FS/IQ/OQ/PQ evidence in your QMS. Use the audit trail integrity check in Admin for CSV computerized system verification.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orgSummary(ref),
          SizedBox(height: PharmaSpacing.md),
          Wrap(
            spacing: PharmaSpacing.sm,
            runSpacing: PharmaSpacing.sm,
            children: [
              OutlinedButton(
                onPressed: () => context.push('/admin/audit/integrity'),
                child: const Text('Audit trail integrity check'),
              ),
              OutlinedButton(
                onPressed: () => context.push('/admin/audit/trail'),
                child: const Text('Audit trail'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminRetentionPolicyScreen extends ConsumerWidget {
  const AdminRetentionPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SystemIntegrationFrame(
      title: 'Retention Policies',
      subtitle:
          'Configure audit log retention (years) in System Settings; exports respect organization scope.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orgSummary(ref),
          SizedBox(height: PharmaSpacing.md),
          OutlinedButton(
            onPressed: () => context.push('/admin/system/settings'),
            child: const Text('Open retention & audit settings'),
          ),
        ],
      ),
    );
  }
}

class AdminGdprScreen extends ConsumerWidget {
  const AdminGdprScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SystemIntegrationFrame(
      title: 'GDPR / DSAR',
      subtitle:
          'User records are partitioned by organization in the database. Process DSAR through your DPO workflow; use Admin to locate users.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orgSummary(ref),
          SizedBox(height: PharmaSpacing.md),
          OutlinedButton(
            onPressed: () => context.push('/admin/users/directory'),
            child: const Text('User directory'),
          ),
        ],
      ),
    );
  }
}

Widget _orgSummary(WidgetRef ref) {
  return FutureBuilder<Organization?>(
    future: ref.read(currentUserProvider.future).then((u) async {
      if (u == null) return null;
      return client.organization.getOrganization(u.organizationId);
    }),
    builder: (context, snap) {
      if (snap.connectionState == ConnectionState.waiting) {
        return Text(
          'Loading organization…',
          style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
        );
      }
      if (snap.hasError || !snap.hasData) {
        return Text(
          'Sign in to view organization context.',
          style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
        );
      }
      final org = snap.data;
      if (org == null) {
        return const Text('Organization not found.');
      }
      return AdminDataTable(
        columns: const ['Field', 'Value'],
        rows: [
          ['Organization', org.name],
          ['Code', org.code],
          ['Created', org.createdAt.toLocal().toString().split('.').first],
        ],
      );
    },
  );
}

class _SystemIntegrationFrame extends StatelessWidget {
  const _SystemIntegrationFrame({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: title,
      subtitle: subtitle,
      children: [
        AdminSectionCard(
          title: 'Organization context',
          child: child,
        ),
      ],
    );
  }
}
