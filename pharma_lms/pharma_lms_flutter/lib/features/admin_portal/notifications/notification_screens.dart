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
// NOTIFICATION TEMPLATES SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminNotificationTemplateScreen extends ConsumerStatefulWidget {
  const AdminNotificationTemplateScreen({super.key});

  @override
  ConsumerState<AdminNotificationTemplateScreen> createState() => _AdminNotificationTemplateScreenState();
}

class _AdminNotificationTemplateScreenState extends ConsumerState<AdminNotificationTemplateScreen> {
  String _selectedChannel = 'all';
  String _selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final templatesAsync = ref.watch(adminNotificationTemplatesProvider);
    final statsAsync = ref.watch(adminNotificationTemplateStatsProvider);

    return templatesAsync.when(
      loading: () => const AdminPageLoading(cardCount: 3),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Error loading templates', style: PharmaTypography.body),
            SizedBox(height: PharmaSpacing.xs),
            Text(err.toString(), style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(adminNotificationTemplatesProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (templates) {
        final filteredTemplates = templates.where((t) {
          final matchesChannel = _selectedChannel == 'all' || t.channel == _selectedChannel;
          final matchesStatus = _selectedStatus == 'all' || t.status == _selectedStatus;
          return matchesChannel && matchesStatus;
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

              // Filter Row
              _buildFiltersRow(templates),
              SizedBox(height: PharmaSpacing.md),

              // Templates List
              _buildTemplatesList(filteredTemplates),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notification Templates', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Template content, branding, and variables',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => _showCreateTemplateDialog(context),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Template'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(NotificationTemplateStats stats) {
    return Row(
      children: [
        _buildStatCard('Total Templates', stats.total.toString(), Icons.description_outlined, PharmaColors.info),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Active', stats.active.toString(), Icons.check_circle_outline, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Draft', stats.draft.toString(), Icons.edit_note_outlined, PharmaColors.warning),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Email', stats.emailTemplates.toString(), Icons.email_outlined, PharmaColors.info),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Push', stats.pushTemplates.toString(), Icons.notifications_outlined, PharmaColors.purple),
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

  Widget _buildFiltersRow(List<NotificationTemplate> templates) {
    final activeCount = templates.where((t) => t.status == 'active').length;
    
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Channel Filter
          Text('Channel:', style: PharmaTypography.bodyMedium),
          SizedBox(width: PharmaSpacing.md),
          ...['all', 'email', 'push', 'sms', 'in_app'].map((channel) => Padding(
            padding: EdgeInsets.only(right: PharmaSpacing.sm),
            child: ChoiceChip(
              label: Text(_channelLabel(channel)),
              selected: _selectedChannel == channel,
              onSelected: (s) => setState(() => _selectedChannel = channel),
              selectedColor: PharmaColors.emerald100,
            ),
          )),
          const Spacer(),
          // Status filter
          Text('Status:', style: PharmaTypography.bodyMedium),
          SizedBox(width: PharmaSpacing.sm),
          ...['all', 'active', 'draft', 'inactive'].map((status) => Padding(
            padding: EdgeInsets.only(right: PharmaSpacing.sm),
            child: ChoiceChip(
              label: Text(_statusLabel(status)),
              selected: _selectedStatus == status,
              onSelected: (s) => setState(() => _selectedStatus = status),
              selectedColor: PharmaColors.emerald100,
            ),
          )),
          // Info
          Container(
            padding: EdgeInsets.all(PharmaSpacing.sm),
            decoration: BoxDecoration(
              color: PharmaColors.infoBg,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 16, color: PharmaColors.info),
                SizedBox(width: PharmaSpacing.xs),
                Text(
                  '$activeCount active templates',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.info),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _channelLabel(String channel) {
    switch (channel) {
      case 'all': return 'All';
      case 'email': return 'Email';
      case 'push': return 'Push';
      case 'sms': return 'SMS';
      case 'in_app': return 'In-App';
      default: return channel;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'all': return 'All';
      case 'active': return 'Active';
      case 'draft': return 'Draft';
      case 'inactive': return 'Inactive';
      default: return status;
    }
  }

  Widget _buildTemplatesList(List<NotificationTemplate> templates) {
    if (templates.isEmpty) {
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
                'No templates found',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              SizedBox(height: PharmaSpacing.xs),
              Text(
                'Create a new notification template to get started',
                style: PharmaTypography.caption,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: templates.map((t) => _buildTemplateCard(t)).toList(),
    );
  }

  Widget _buildTemplateCard(NotificationTemplate template) {
    final isActive = template.status == 'active';
    
    return Container(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getChannelColor(template.channel).withOpacity(0.1),
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(
              _getChannelIcon(template.channel),
              color: _getChannelColor(template.channel),
              size: 24,
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(template.name, style: PharmaTypography.headingSmall, overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(width: PharmaSpacing.sm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive ? PharmaColors.successBg : PharmaColors.gray100,
                        borderRadius: BorderRadius.circular(PharmaRadius.sm),
                      ),
                      child: Text(
                        template.status.toUpperCase(),
                        style: PharmaTypography.caption.copyWith(
                          color: isActive ? PharmaColors.success : PharmaColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: PharmaSpacing.xs),
                if (template.triggerEvent != null)
                  Text(
                    'Trigger: ${template.triggerEvent}',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                  ),
                if (template.subject != null)
                  Text(
                    'Subject: ${template.subject}',
                    style: PharmaTypography.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: PharmaSpacing.xs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.xs, vertical: 1),
                      decoration: BoxDecoration(
                        color: _getChannelColor(template.channel).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        template.channel.toUpperCase(),
                        style: PharmaTypography.caption.copyWith(
                          color: _getChannelColor(template.channel),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(width: PharmaSpacing.sm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.xs, vertical: 1),
                      decoration: BoxDecoration(
                        color: PharmaColors.infoBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        template.type.toUpperCase(),
                        style: PharmaTypography.caption.copyWith(
                          color: PharmaColors.info,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(width: PharmaSpacing.md),
                    Text(
                      'Created: ${_formatDate(template.createdAt)}',
                      style: PharmaTypography.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {},
                tooltip: 'Edit Template',
              ),
              IconButton(
                icon: const Icon(Icons.content_copy_outlined, size: 20),
                onPressed: () {},
                tooltip: 'Duplicate',
              ),
              IconButton(
                icon: Icon(
                  isActive ? Icons.pause_circle_outline : Icons.play_circle_outline,
                  size: 20,
                ),
                onPressed: () {},
                tooltip: isActive ? 'Deactivate' : 'Activate',
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getChannelIcon(String channel) {
    switch (channel) {
      case 'email': return Icons.email_outlined;
      case 'push': return Icons.notifications_outlined;
      case 'sms': return Icons.sms_outlined;
      case 'in_app': return Icons.chat_outlined;
      default: return Icons.message_outlined;
    }
  }

  Color _getChannelColor(String channel) {
    switch (channel) {
      case 'email': return PharmaColors.info;
      case 'push': return PharmaColors.warning;
      case 'sms': return PharmaColors.purple;
      case 'in_app': return PharmaColors.success;
      default: return PharmaColors.textTertiary;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _showCreateTemplateDialog(BuildContext context) {
    final nameCtl = TextEditingController();
    final bodyCtl = TextEditingController();
    final subjectCtl = TextEditingController();
    var type = 'general';
    var channel = 'in_app';
    var status = 'draft';

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer(
        builder: (ctx, ref, _) {
          return StatefulBuilder(
            builder: (context, setLocal) {
              return AlertDialog(
                title: const Text('Create notification template'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Name')),
                      TextField(
                        controller: subjectCtl,
                        decoration: const InputDecoration(labelText: 'Subject (optional)'),
                      ),
                      TextField(
                        controller: bodyCtl,
                        maxLines: 4,
                        decoration: const InputDecoration(labelText: 'Body template'),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Type'),
                        initialValue: type,
                        items: const [
                          DropdownMenuItem(value: 'general', child: Text('general')),
                          DropdownMenuItem(value: 'reminder', child: Text('reminder')),
                          DropdownMenuItem(value: 'alert', child: Text('alert')),
                        ],
                        onChanged: (v) => setLocal(() => type = v ?? type),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Channel'),
                        initialValue: channel,
                        items: const [
                          DropdownMenuItem(value: 'in_app', child: Text('in_app')),
                          DropdownMenuItem(value: 'email', child: Text('email')),
                        ],
                        onChanged: (v) => setLocal(() => channel = v ?? channel),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Status'),
                        initialValue: status,
                        items: const [
                          DropdownMenuItem(value: 'draft', child: Text('draft')),
                          DropdownMenuItem(value: 'active', child: Text('active')),
                        ],
                        onChanged: (v) => setLocal(() => status = v ?? status),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
                  FilledButton(
                    onPressed: () async {
                      final user = await ref.read(currentUserProvider.future);
                      if (user?.id == null) return;
                      try {
                        await client.notificationTemplate.createTemplate(
                          organizationId: user!.organizationId,
                          name: nameCtl.text.trim(),
                          type: type,
                          channel: channel,
                          subject: subjectCtl.text.trim().isEmpty ? null : subjectCtl.text.trim(),
                          bodyTemplate: bodyCtl.text.trim(),
                          status: status,
                        );
                        ref.invalidate(adminNotificationTemplatesProvider);
                        if (dialogContext.mounted) Navigator.pop(dialogContext);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Template created')));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
                          );
                        }
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// REMINDER RULES SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminReminderRulesScreen extends ConsumerWidget {
  const AdminReminderRulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminNotificationTemplatesProvider);

    return AdminPageFrame(
      title: 'Reminder Rules',
      subtitle: 'Templates tagged as reminders (type or name filter).',
      children: [
        AdminSectionCard(
          title: 'Reminder templates',
          child: async.when(
            loading: () => const AdminPageLoading(cardCount: 3),
            error: (e, _) => Text('$e'),
            data: (templates) {
              final rows = templates
                  .where(
                    (t) =>
                        t.type.toLowerCase().contains('remind') ||
                        t.name.toLowerCase().contains('remind'),
                  )
                  .map(
                    (t) => [t.name, t.type, t.channel, t.status, t.triggerEvent ?? '—'],
                  )
                  .toList();
              if (rows.isEmpty) {
                return Text(
                  'No reminder-style templates. Create one from Notification Templates.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                );
              }
              return AdminDataTable(
                columns: const ['Name', 'Type', 'Channel', 'Status', 'Trigger'],
                rows: rows,
              );
            },
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// BROADCAST SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBroadcastScreen extends ConsumerStatefulWidget {
  const AdminBroadcastScreen({super.key});

  @override
  ConsumerState<AdminBroadcastScreen> createState() => _AdminBroadcastScreenState();
}

class _AdminBroadcastScreenState extends ConsumerState<AdminBroadcastScreen> {
  final _message = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _busy = true);
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) throw Exception('Not authenticated');
      final n = await client.notification.broadcastInAppToOrganization(
        organizationId: user.organizationId,
        message: _message.text,
        type: 'admin_broadcast',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Queued in-app notifications: $n')),
      );
      _message.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Broadcast',
      subtitle: 'Send an in-app notification to every user in your organization.',
      children: [
        AdminSectionCard(
          title: 'Message',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _message,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              FilledButton(
                onPressed: _busy ? null : _send,
                child: Text(_busy ? 'Sending…' : 'Broadcast to organization'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
