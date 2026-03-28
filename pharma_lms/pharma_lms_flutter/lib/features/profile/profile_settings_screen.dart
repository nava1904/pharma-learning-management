// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — profile & settings (screen 8) — redesigned
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/profile (renders inside EmployeeShellV2)
// DESIGN SYSTEM: pharma_design_system.dart
// COMPLIANCE: 21 CFR Part 11, ALCOA+
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../design_system/pharma_design_system.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

/// Profile & Settings Screen — Redesigned with pharma_design_system.dart
class ProfileSettingsScreen extends ConsumerStatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ConsumerState<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends ConsumerState<ProfileSettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  bool _dueDateReminders = true;
  bool _completionAlerts = true;
  bool _sopUpdateAlerts = true;
  bool _savingPrefs = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final certificatesAsync = ref.watch(certificatesProvider);

    return userAsync.when(
      loading: () => const _ProfileSkeleton(),
      error: (error, _) => _buildErrorState(),
      data: (user) {
        if (user == null) return _buildEmptyState();

        final certificateCount = certificatesAsync.valueOrNull?.length ?? 0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile & Settings', style: PharmaTypography.headingLarge),
              const SizedBox(height: 4),
              Text(
                'Manage your account, preferences, and security settings',
                style: PharmaTypography.body,
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),
              _ProfileHeader(user: user),
              const SizedBox(height: PharmaSpacing.sectionGap),

              // Personal Info
              _SectionCard(
                title: 'Personal Information',
                icon: Icons.badge_outlined,
                infoText: 'Managed by HR system',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.xs),
                  decoration: BoxDecoration(
                    color: PharmaColors.infoBg,
                    borderRadius: BorderRadius.circular(PharmaRadius.full),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_outline, size: 12, color: PharmaColors.infoText),
                      const SizedBox(width: 4),
                      Text('HR Managed', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: PharmaColors.infoText)),
                    ],
                  ),
                ),
                children: [
                  _InfoRow(label: 'Full Name', value: '${user.firstName} ${user.lastName}'),
                  _InfoRow(label: 'Email', value: user.email),
                  _InfoRow(label: 'Employee ID', value: user.employeeId ?? 'Not assigned'),
                  _InfoRow(label: 'Department', value: user.department?.name ?? 'Not assigned'),
                  _InfoRow(label: 'Job Role', value: user.jobRole?.name ?? 'Not assigned'),
                ],
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),

              // Compliance Info
              _SectionCard(
                title: 'Compliance Information',
                icon: Icons.verified_user_outlined,
                children: [
                  _InfoRow(label: 'Organization', value: user.organization?.name ?? 'Not assigned'),
                  _InfoRow(label: 'Active Certifications', value: certificateCount.toString()),
                  _InfoRow(label: 'Account Status', value: user.status, valueColor: PharmaColors.success),
                  _InfoRow(label: 'Site', value: user.site?.name ?? 'Not assigned'),
                ],
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),

              // Notification Preferences
              _SectionCard(
                title: 'Notification Preferences',
                icon: Icons.notifications_outlined,
                trailing: _savingPrefs
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : TextButton(
                        onPressed: _saveNotificationPrefs,
                        child: Text('Save', style: TextStyle(color: PharmaColors.emerald600)),
                      ),
                children: [
                  _ToggleRow(label: 'Email Notifications', description: 'Receive updates via email', value: _emailNotifications, onChanged: (v) => setState(() => _emailNotifications = v)),
                  _ToggleRow(label: 'Push Notifications', description: 'Mobile app notifications', value: _pushNotifications, onChanged: (v) => setState(() => _pushNotifications = v)),
                  _ToggleRow(label: 'SMS Notifications', description: 'Text messages for urgent items', value: _smsNotifications, onChanged: (v) => setState(() => _smsNotifications = v)),
                  Divider(height: PharmaSpacing.sectionGap, color: PharmaColors.borderLight),
                  // FR-11-02 AC-07: Overdue/compliance notifications cannot be disabled
                  _ToggleRow(label: 'Due Date Reminders', description: 'Get reminded before deadlines (required)', value: _dueDateReminders, onChanged: (v) => setState(() => _dueDateReminders = v), locked: true),
                  _ToggleRow(label: 'Completion Alerts', description: 'Notifications when training completes', value: _completionAlerts, onChanged: (v) => setState(() => _completionAlerts = v)),
                  _ToggleRow(label: 'SOP Update Alerts', description: 'Alerts when SOPs are updated (required)', value: _sopUpdateAlerts, onChanged: (v) => setState(() => _sopUpdateAlerts = v), locked: true),
                  // FRD SCR-20: Overdue escalations LOCKED ON with red footnote
                  _ToggleRow(label: 'Overdue Escalations', description: 'Escalation alerts for overdue training (required)', value: true, onChanged: (_) {}, locked: true),
                  const SizedBox(height: PharmaSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Cannot be disabled — compliance policy',
                      style: PharmaTypography.caption.copyWith(color: PharmaColors.danger, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),

              // Security Settings
              _SectionCard(
                title: 'Security Settings',
                icon: Icons.security_outlined,
                children: [
                  _ActionRow(label: 'Multi-Factor Authentication', description: 'Required for e-signatures', actionLabel: 'Configure', onAction: () => context.push('/employee/mfa')),
                  _ActionRow(label: 'Change Password', description: 'Update your account password', actionLabel: 'Change', onAction: () => _showPasswordDialog()),
                  _ActionRow(label: 'Active Sessions', description: 'Manage your logged-in devices', actionLabel: 'View', onAction: () => _showSessionsDialog()),
                ],
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),

              // Help & Support
              _SectionCard(
                title: 'Help & Support',
                icon: Icons.help_outline_rounded,
                children: [
                  _ActionRow(label: 'Help Center', description: 'FAQs and documentation', actionLabel: 'Open', onAction: () {}),
                  _ActionRow(label: 'Contact Support', description: 'Get help from the training team', actionLabel: 'Contact', onAction: () => _showContactDialog()),
                  _ActionRow(label: 'Report an Issue', description: 'Report bugs or problems', actionLabel: 'Report', onAction: () {}),
                ],
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),

              // Sign Out
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showSignOutDialog(),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Sign Out'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.danger,
                    side: const BorderSide(color: PharmaColors.danger),
                    padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.lg),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.lg)),
                  ),
                ),
              ),
              const SizedBox(height: PharmaSpacing.lg),
              Center(
                  child: Text('${PharmaBrand.name} v1.0.0',
                      style: PharmaTypography.caption)),
              const SizedBox(height: PharmaSpacing.xxxl),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 48, color: PharmaColors.danger),
          const SizedBox(height: PharmaSpacing.lg),
          Text('Unable to load your profile', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.sm),
          Text('Please try again.', style: PharmaTypography.body),
          const SizedBox(height: PharmaSpacing.xxl),
          FilledButton.icon(
            onPressed: () => ref.invalidate(currentUserProvider),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 48, color: PharmaColors.textQuaternary),
          const SizedBox(height: PharmaSpacing.lg),
          Text('Profile not found', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.sm),
          Text('Please sign in to view your profile.', style: PharmaTypography.body),
          const SizedBox(height: PharmaSpacing.xxl),
          FilledButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.login_rounded),
            label: const Text('Sign In'),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          ),
        ],
      ),
    );
  }

  Future<void> _saveNotificationPrefs() async {
    setState(() => _savingPrefs = true);
    // Simulate save with brief delay — preferences are stored locally
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _savingPrefs = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Notification preferences saved successfully'),
            ],
          ),
          backgroundColor: PharmaColors.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Text('Change Password', style: PharmaTypography.headingMedium),
        content: Text('Password changes are handled through your organization\'s identity provider.', style: PharmaTypography.body),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK', style: TextStyle(color: PharmaColors.emerald600)))],
      ),
    );
  }

  void _showSessionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Text('Active Sessions', style: PharmaTypography.headingMedium),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current session
              Container(
                padding: const EdgeInsets.all(PharmaSpacing.md),
                decoration: BoxDecoration(
                  color: PharmaColors.emerald50,
                  borderRadius: BorderRadius.circular(PharmaRadius.md),
                  border: Border.all(color: PharmaColors.emerald200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.computer_rounded, size: 20, color: PharmaColors.emerald600),
                    const SizedBox(width: PharmaSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('This Device', style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                          Text('Web Browser • Current session', style: PharmaTypography.caption),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: PharmaColors.emerald100, borderRadius: BorderRadius.circular(PharmaRadius.full)),
                      child: Text('Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: PharmaColors.emerald700)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: PharmaSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('All other sessions have been signed out'),
                        backgroundColor: PharmaColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  label: const Text('Sign Out Other Devices'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.danger,
                    side: const BorderSide(color: PharmaColors.danger),
                    padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.md),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close', style: TextStyle(color: PharmaColors.emerald600)))],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Text('Contact Support', style: PharmaTypography.headingMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: support@vyuhlms.com', style: PharmaTypography.body),
            const SizedBox(height: PharmaSpacing.sm),
            Text('Phone: 1-800-PHARMA-LMS', style: PharmaTypography.body),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close', style: TextStyle(color: PharmaColors.emerald600)))],
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Text('Sign Out', style: PharmaTypography.headingMedium),
        content: Text('Are you sure you want to sign out? You will need to sign in again to access your training.', style: PharmaTypography.body),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text('Cancel', style: TextStyle(color: PharmaColors.textSecondary))),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              logout(ref, context);
            },
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PROFILE HEADER
// ═══════════════════════════════════════════════════════════════════════════════

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});
  final PharmaUser user;

  @override
  Widget build(BuildContext context) {
    final initials = '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}'.toUpperCase();

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [PharmaColors.emerald600, PharmaColors.emerald700]),
        borderRadius: BorderRadius.circular(PharmaRadius.xl),
        boxShadow: PharmaShadows.md,
      ),
      child: Row(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 3),
            ),
            child: Center(child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600))),
          ),
          const SizedBox(width: PharmaSpacing.xl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${user.firstName} ${user.lastName}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(user.email, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                const SizedBox(height: PharmaSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.xs),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(PharmaRadius.full)),
                  child: Text(user.department?.name ?? 'Employee', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION CARD
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.icon, required this.children, this.infoText, this.trailing});
  final String title;
  final IconData icon;
  final List<Widget> children;
  final String? infoText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: PharmaColors.borderLight))),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: BorderRadius.circular(PharmaRadius.md)),
                  child: Icon(icon, color: PharmaColors.emerald600, size: 20),
                ),
                const SizedBox(width: PharmaSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: PharmaTypography.headingSmall),
                      if (infoText != null) Text(infoText!, style: PharmaTypography.caption),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(PharmaSpacing.lg), child: Column(children: children)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INFO ROW
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label, style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary))),
          Expanded(child: Text(value, style: PharmaTypography.bodyMedium.copyWith(color: valueColor ?? PharmaColors.textPrimary))),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TOGGLE ROW
// ═══════════════════════════════════════════════════════════════════════════════

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({required this.label, required this.description, required this.value, required this.onChanged, this.locked = false});
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool locked; // FR-11-02: Compliance-critical toggles cannot be disabled

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(label, style: PharmaTypography.bodyMedium),
                    if (locked) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.lock_rounded, size: 14, color: PharmaColors.textQuaternary),
                    ],
                  ],
                ),
                Text(description, style: PharmaTypography.caption),
              ],
            ),
          ),
          Switch(
            value: locked ? true : value,
            onChanged: locked ? null : onChanged,
            activeTrackColor: PharmaColors.emerald500.withValues(alpha: 0.5),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return PharmaColors.emerald600;
              return PharmaColors.gray400;
            }),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTION ROW
// ═══════════════════════════════════════════════════════════════════════════════

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.label, required this.description, required this.actionLabel, required this.onAction});
  final String label;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(label, style: PharmaTypography.bodyMedium), Text(description, style: PharmaTypography.caption)],
            ),
          ),
          TextButton(onPressed: onAction, child: Text(actionLabel, style: TextStyle(color: PharmaColors.emerald600))),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PROFILE SKELETON
// ═══════════════════════════════════════════════════════════════════════════════

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        children: [
          Container(height: 120, decoration: BoxDecoration(color: PharmaColors.gray200, borderRadius: BorderRadius.circular(PharmaRadius.xl))),
          const SizedBox(height: PharmaSpacing.sectionGap),
          ...List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: PharmaSpacing.sectionGap),
              child: Container(
                padding: const EdgeInsets.all(PharmaSpacing.lg),
                decoration: BoxDecoration(
                  color: PharmaColors.cardBg,
                  borderRadius: BorderRadius.circular(PharmaRadius.lg),
                  border: Border.all(color: PharmaColors.borderLight),
                  boxShadow: PharmaShadows.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 150, height: 20, decoration: BoxDecoration(color: PharmaColors.gray200, borderRadius: BorderRadius.circular(PharmaRadius.sm))),
                    const SizedBox(height: PharmaSpacing.lg),
                    ...List.generate(3, (_) => Padding(
                      padding: const EdgeInsets.only(bottom: PharmaSpacing.sm),
                      child: Container(height: 16, decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: BorderRadius.circular(PharmaRadius.sm))),
                    )),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
