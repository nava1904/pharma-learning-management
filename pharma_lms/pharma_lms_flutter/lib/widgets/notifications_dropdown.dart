import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../providers/notifications_provider.dart';

/// Notifications dropdown overlay.
class NotificationsDropdown extends ConsumerStatefulWidget {
  const NotificationsDropdown({super.key});

  @override
  ConsumerState<NotificationsDropdown> createState() =>
      _NotificationsDropdownState();
}

class _NotificationsDropdownState extends ConsumerState<NotificationsDropdown> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _toggle() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {});
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
          setState(() {});
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Positioned(
              width: 384,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(-320, 56),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 400),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Notifications',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.slate900,
                                ),
                          ),
                        ),
                        const Divider(height: 1),
                        Flexible(
                          child: _NotificationsList(
                            onDismiss: () {
                              _overlayEntry?.remove();
                              _overlayEntry = null;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final count = notificationsAsync.valueOrNull?.length ?? 0;

    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        onPressed: _toggle,
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.notifications_outlined, color: AppColors.slate600),
            if (count > 0)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        tooltip: 'Notifications',
      ),
    );
  }
}

class _NotificationsList extends ConsumerWidget {
  const _NotificationsList({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsProvider);

    return async.when(
      data: (list) {
        if (list.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No notifications',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate600,
                  ),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, i) {
            final n = list[i];
            return InkWell(
              onTap: onDismiss,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      n.type == 'overdue' ? Icons.warning : Icons.calendar_today,
                      size: 20,
                      color: n.type == 'overdue'
                          ? AppColors.destructive
                          : AppColors.indigo600,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            n.type == 'overdue'
                                ? 'Retraining Required'
                                : 'New Training Assigned',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.slate900,
                                ),
                          ),
                          Text(
                            n.message,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate600,
                                ),
                          ),
                          Text(
                            'Due: ${n.dueDate}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.slate500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(24),
        child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
