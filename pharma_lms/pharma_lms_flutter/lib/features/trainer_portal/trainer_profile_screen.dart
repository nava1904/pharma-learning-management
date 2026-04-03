// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINER PROFILE (TRN-17)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/profile
// Profile info, activity summary, settings, sign-out.
// Data sourced from: currentUserProvider, organization, courses, audit trail.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/trainer_page_scaffold.dart';

// ─── PROVIDERS ───────────────────────────────────────────────────────────────

final _trainerOrgProvider = FutureProvider<Organization?>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  try {
    return await client.organization.getOrganization(user.organizationId);
  } catch (_) {
    return null;
  }
});

final _trainerCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  try {
    final allCourses = await client.course.listCourses(
      organizationId: user.organizationId,
    );
    return allCourses.where((c) => c.createdById == user.id).toList();
  } catch (_) {
    return [];
  }
});

final _trainerAuditProvider = FutureProvider<List<AuditTrail>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  try {
    return await client.audit.getAuditTrail(
      userId: user.id,
      limit: 10,
    );
  } catch (_) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER PROFILE SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class TrainerProfileScreen extends ConsumerStatefulWidget {
  const TrainerProfileScreen({super.key});

  @override
  ConsumerState<TrainerProfileScreen> createState() => _TrainerProfileScreenState();
}

class _TrainerProfileScreenState extends ConsumerState<TrainerProfileScreen> {
  bool _emailNotifications = true;
  bool _autoSaveDrafts = true;
  bool _darkMode = false;
  bool _prefsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null || user.id == null) return;
      final prefs = await client.user.getUserPreferences(userId: user.id!);
      if (!mounted) return;
      setState(() {
        for (final p in prefs) {
          if (p.preferenceKey == 'email_notifications') _emailNotifications = p.preferenceValue == 'true';
          if (p.preferenceKey == 'auto_save_drafts') _autoSaveDrafts = p.preferenceValue == 'true';
          if (p.preferenceKey == 'dark_mode') _darkMode = p.preferenceValue == 'true';
        }
        _prefsLoaded = true;
      });
    } catch (_) {
      if (mounted) setState(() => _prefsLoaded = true);
    }
  }

  Future<void> _setPreference(String key, bool enabled) async {
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null || user.id == null) return;
      await client.user.setUserPreference(
        userId: user.id!,
        key: key,
        value: enabled ? 'true' : 'false',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save preference: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final email = ref.watch(currentUserEmailProvider) ?? '';

    return userAsync.when(
      loading: () => const TrainerPageLoading(cardCount: 3),
      error: (e, _) => TrainerPageError(
        message: 'Could not load profile: $e',
        onRetry: () => ref.invalidate(currentUserProvider),
      ),
      data: (user) => _buildContent(context, ref, user, email),
    );
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, dynamic user, String email) {
    final displayName = user != null
        ? '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim()
        : email
            .split('@')
            .first
            .replaceAll('.', ' ')
            .split(' ')
            .map((w) => w.isNotEmpty
                ? '${w[0].toUpperCase()}${w.substring(1)}'
                : '')
            .join(' ');
    final displayEmail = user?.email ?? email;
    final initials = displayName.isNotEmpty
        ? displayName.substring(0, 2).toUpperCase()
        : 'TR';

    final orgAsync = ref.watch(_trainerOrgProvider);
    final coursesAsync = ref.watch(_trainerCoursesProvider);
    final auditAsync = ref.watch(_trainerAuditProvider);

    final orgName = orgAsync.whenOrNull(data: (org) => org?.name) ?? '—';

    final employeeId = user?.employeeId ?? 'Not assigned';

    final memberSince = user?.createdAt != null
        ? DateFormat('MMM yyyy').format(user.createdAt as DateTime)
        : (user?.hireDate != null
            ? DateFormat('MMM yyyy').format(user.hireDate as DateTime)
            : '—');

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Row(
          children: [
            Icon(Icons.person_outline,
                color: PharmaColors.emerald600, size: 24),
            const SizedBox(width: 10),
            Text(
              'Trainer Profile',
              style: PharmaTypography.headingLarge.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            SizedBox(
              width: 320,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: PharmaColors.cardBg,
                  borderRadius: PharmaRadius.cardRadius,
                  border: Border.all(color: PharmaColors.borderLight),
                ),
                child: Column(children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: PharmaColors.emerald50,
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: PharmaColors.emerald600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayName.isNotEmpty ? displayName : 'Trainer',
                    style: PharmaTypography.headingSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayEmail,
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald50,
                      borderRadius: PharmaRadius.pillRadius,
                    ),
                    child: Text(
                      'TRAINER / SME',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PharmaColors.emerald600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  _profileRow(Icons.business, 'Organization', orgName),
                  _profileRow(Icons.badge, 'Employee ID', employeeId),
                  _profileRow(Icons.calendar_today, 'Member Since', memberSince),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        logout(ref, context);
                      },
                      icon: const Icon(Icons.logout, size: 16),
                      label: const Text('Sign Out'),
                      style: FilledButton.styleFrom(
                        backgroundColor: PharmaColors.danger,
                        foregroundColor: PharmaColors.cardBg,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(width: 24),
            // Activity & Settings
            Expanded(
              child: Column(children: [
                // Activity Summary
                _buildActivitySummary(coursesAsync, auditAsync),
                const SizedBox(height: 16),
                // Recent Actions
                _buildRecentActions(auditAsync),
                const SizedBox(height: 16),
                // Preferences
                _buildPreferences(),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivitySummary(
    AsyncValue<List<Course>> coursesAsync,
    AsyncValue<List<AuditTrail>> auditAsync,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Summary',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 16),
          coursesAsync.when(
            loading: () => const TrainerPageLoading(cardCount: 1),
            error: (_, __) => Row(children: [
              _activityStat('Courses Created', '—', Icons.school,
                  PharmaColors.emerald600),
              const SizedBox(width: 16),
              _activityStat('Published', '—', Icons.check_circle,
                  PharmaColors.info),
              const SizedBox(width: 16),
              _activityStat('Drafts', '—', Icons.edit_note,
                  PharmaColors.warningText),
              const SizedBox(width: 16),
              _activityStat('Audit Events', '—', Icons.history,
                  PharmaColors.emerald600),
            ]),
            data: (courses) {
              final totalCourses = courses.length;
              final published = courses
                  .where((c) =>
                      c.status == 'approved' ||
                      c.status == 'published' ||
                      c.status == 'effective')
                  .length;
              final drafts =
                  courses.where((c) => c.status == 'draft').length;
              final auditCount = auditAsync.whenOrNull(
                    data: (entries) => entries.length,
                  ) ??
                  0;

              return Row(children: [
                _activityStat('Courses Created', '$totalCourses', Icons.school,
                    PharmaColors.emerald600),
                const SizedBox(width: 16),
                _activityStat('Published', '$published', Icons.check_circle,
                    PharmaColors.info),
                const SizedBox(width: 16),
                _activityStat('Drafts', '$drafts', Icons.edit_note,
                    PharmaColors.warningText),
                const SizedBox(width: 16),
                _activityStat('Audit Events', '$auditCount', Icons.history,
                    PharmaColors.emerald600),
              ]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActions(AsyncValue<List<AuditTrail>> auditAsync) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Actions',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 16),
          auditAsync.when(
            loading: () => const TrainerPageLoading(cardCount: 2),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Unable to load recent actions',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ),
            data: (entries) {
              if (entries.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Icon(Icons.history,
                        size: 32, color: PharmaColors.gray300),
                    const SizedBox(height: 8),
                    Text(
                      'No recent actions',
                      style: PharmaTypography.body.copyWith(
                        color: PharmaColors.textTertiary,
                      ),
                    ),
                  ]),
                );
              }
              return Column(
                children: entries.take(5).map((entry) {
                  final icon = _iconForAction(entry.action);
                  final color = _colorForAction(entry.action);
                  final timeAgo = _formatTimeAgo(entry.timestamp);
                  return _actionRow(
                    '${entry.action} — ${entry.entityType}',
                    timeAgo,
                    icon,
                    color,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value: _emailNotifications,
            onChanged: (enabled) {
              setState(() => _emailNotifications = enabled);
              _setPreference('email_notifications', enabled);
            },
            title:
                Text('Email Notifications', style: PharmaTypography.bodyMedium),
            subtitle: Text('Receive email when QA review is completed',
                style: PharmaTypography.caption),
            activeThumbColor: PharmaColors.emerald600,
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            value: _autoSaveDrafts,
            onChanged: (enabled) {
              setState(() => _autoSaveDrafts = enabled);
              _setPreference('auto_save_drafts', enabled);
            },
            title: Text('Auto-save Drafts', style: PharmaTypography.bodyMedium),
            subtitle: Text(
                'Automatically save course builder changes every 60 seconds',
                style: PharmaTypography.caption),
            activeThumbColor: PharmaColors.emerald600,
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            value: _darkMode,
            onChanged: (enabled) {
              setState(() => _darkMode = enabled);
              _setPreference('dark_mode', enabled);
            },
            title: Text('Dark Mode', style: PharmaTypography.bodyMedium),
            subtitle: Text('Use dark theme for the trainer portal',
                style: PharmaTypography.caption),
            activeThumbColor: PharmaColors.emerald600,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  static IconData _iconForAction(String action) {
    final lower = action.toLowerCase();
    if (lower.contains('create') || lower.contains('created')) {
      return Icons.add_circle;
    }
    if (lower.contains('publish') || lower.contains('approved')) {
      return Icons.check_circle;
    }
    if (lower.contains('submit') || lower.contains('sent')) return Icons.send;
    if (lower.contains('upload')) return Icons.cloud_upload;
    if (lower.contains('delete') || lower.contains('removed')) {
      return Icons.delete_outline;
    }
    if (lower.contains('update') || lower.contains('edit')) return Icons.edit;
    return Icons.history;
  }

  static Color _colorForAction(String action) {
    final lower = action.toLowerCase();
    if (lower.contains('create') || lower.contains('publish') ||
        lower.contains('approved')) {
      return PharmaColors.emerald600;
    }
    if (lower.contains('submit') || lower.contains('sent')) {
      return PharmaColors.info;
    }
    if (lower.contains('upload')) return PharmaColors.warningText;
    if (lower.contains('delete') || lower.contains('reject')) {
      return PharmaColors.danger;
    }
    return PharmaColors.gray500;
  }

  static String _formatTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(timestamp);
  }

  static Widget _profileRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Icon(icon, size: 16, color: PharmaColors.textTertiary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
            ),
          ),
        ),
        Text(
          value,
          style: PharmaTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }

  static Widget _activityStat(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: PharmaRadius.cardRadius,
        ),
        child: Column(children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 6),
          Text(value, style: PharmaTypography.statNumber.copyWith(fontSize: 20)),
          Text(
            label,
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  static Widget _actionRow(
      String text, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: PharmaTypography.body)),
        Text(
          time,
          style: PharmaTypography.caption.copyWith(
            color: PharmaColors.textTertiary,
          ),
        ),
      ]),
    );
  }
}
