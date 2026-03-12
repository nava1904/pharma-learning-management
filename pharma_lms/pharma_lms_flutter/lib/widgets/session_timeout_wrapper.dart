import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../routes/app_router.dart';

/// Wraps the app to enforce 15-minute idle session timeout (21 CFR Part 11).
/// Shows warning at 13 min with "I'm still here" button. Logs out when idle exceeds 15 minutes.
class SessionTimeoutWrapper extends ConsumerStatefulWidget {
  const SessionTimeoutWrapper({
    super.key,
    required this.child,
    this.idleDuration = const Duration(minutes: 15),
    this.warningThreshold = const Duration(minutes: 13),
    this.checkInterval = const Duration(seconds: 30),
  });

  final Widget child;
  final Duration idleDuration;
  final Duration warningThreshold;
  final Duration checkInterval;

  @override
  ConsumerState<SessionTimeoutWrapper> createState() =>
      _SessionTimeoutWrapperState();
}

class _SessionTimeoutWrapperState extends ConsumerState<SessionTimeoutWrapper> {
  DateTime _lastActivity = DateTime.now();
  Timer? _checkTimer;
  AppRole? _lastRole;
  bool _showWarning = false;

  @override
  void initState() {
    super.initState();
    _scheduleCheck();
  }

  void _resetActivity() {
    _lastActivity = DateTime.now();
    if (_showWarning && mounted) {
      setState(() => _showWarning = false);
    }
  }

  void _scheduleCheck() {
    _checkTimer?.cancel();
    _checkTimer = Timer.periodic(widget.checkInterval, (_) {
      final role = ref.read(selectedRoleProvider);
      if (role == null) {
        _lastRole = null;
        if (_showWarning && mounted) setState(() => _showWarning = false);
        return;
      }
      _lastRole = role;
      final idle = DateTime.now().difference(_lastActivity);

      if (idle >= widget.idleDuration) {
        _checkTimer?.cancel();
        if (mounted) setState(() => _showWarning = false);
        ref.read(selectedRoleProvider.notifier).state = null;
        final ctx = rootNavigatorKey.currentContext;
        if (ctx != null && ctx.mounted) {
          ctx.go('/');
          ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(
              content: Text('Session expired due to inactivity (15 min).'),
            ),
          );
        }
      } else if (idle >= widget.warningThreshold && !_showWarning && mounted) {
        HapticFeedback.heavyImpact();
        setState(() => _showWarning = true);
      }
    });
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedRoleProvider, (prev, next) {
      if (next == null) {
        _checkTimer?.cancel();
        if (_showWarning && mounted) setState(() => _showWarning = false);
      } else {
        _resetActivity();
        _scheduleCheck();
      }
    });
    final role = ref.watch(selectedRoleProvider);
    if (role != null && _lastRole == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _resetActivity();
        _scheduleCheck();
      });
    }
    _lastRole = role;

    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        Listener(
          onPointerDown: (_) => _resetActivity(),
          onPointerMove: (_) => _resetActivity(),
          child: widget.child,
        ),
        if (_showWarning)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your session will expire in 2 minutes.',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap "I\'m still here" to continue.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => _resetActivity(),
                          icon: const Icon(Icons.touch_app, size: 20),
                          label: const Text('I\'m still here'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
