import 'package:flutter/material.dart';

import '../design_system/colors.dart';
import '../design_system/spacing.dart';

/// Chronological timeline of audit events.
class AuditTimeline extends StatelessWidget {
  const AuditTimeline({
    super.key,
    required this.events,
    this.onEventTap,
  });

  final List<AuditTimelineEvent> events;
  final void Function(AuditTimelineEvent)? onEventTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isFirst = index == 0;
        final isLast = index == events.length - 1;

        return _TimelineItem(
          event: event,
          isFirst: isFirst,
          isLast: isLast,
          onTap: onEventTap != null ? () => onEventTap!(event) : null,
        );
      },
    );
  }
}

/// Single audit event for the timeline.
class AuditTimelineEvent {
  const AuditTimelineEvent({
    required this.timestamp,
    required this.title,
    this.subtitle,
    this.detail,
    this.icon,
    this.type = AuditEventType.info,
  });

  final DateTime timestamp;
  final String title;
  final String? subtitle;
  final String? detail;
  final IconData? icon;
  final AuditEventType type;
}

enum AuditEventType { info, success, warning, danger }

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.event,
    required this.isFirst,
    required this.isLast,
    this.onTap,
  });

  final AuditTimelineEvent event;
  final bool isFirst;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = _colorForType(event.type);
    final icon = event.icon ?? _defaultIconForType(event.type);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: DesignColors.neutral200,
                    ),
                  ),
                Center(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2),
                    ),
                    child: Icon(icon, size: 12, color: color),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: DesignColors.neutral200,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: DesignSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: DesignSpacing.lg),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(DesignSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                event.title,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Text(
                              _formatTime(event.timestamp),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: DesignColors.neutral500,
                                  ),
                            ),
                          ],
                        ),
                        if (event.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            event.subtitle!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: DesignColors.neutral600,
                                ),
                          ),
                        ],
                        if (event.detail != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            event.detail!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: DesignColors.neutral500,
                                  fontSize: 11,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForType(AuditEventType type) {
    switch (type) {
      case AuditEventType.success:
        return DesignColors.success;
      case AuditEventType.warning:
        return DesignColors.warning;
      case AuditEventType.danger:
        return DesignColors.danger;
      default:
        return DesignColors.primary;
    }
  }

  IconData _defaultIconForType(AuditEventType type) {
    switch (type) {
      case AuditEventType.success:
        return Icons.check_circle_outline;
      case AuditEventType.warning:
        return Icons.warning_amber_outlined;
      case AuditEventType.danger:
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.month}/${dt.day}/${dt.year}';
  }
}
