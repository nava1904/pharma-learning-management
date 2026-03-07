import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../routes/app_router.dart';

/// Wraps the app to enforce 15-minute idle session timeout (21 CFR Part 11).
/// Resets on pointer/touch activity. Logs out when idle exceeds 15 minutes.
class SessionTimeoutWrapper extends ConsumerStatefulWidget {
  const SessionTimeoutWrapper({
    super.key,
    required this.child,
    this.idleDuration = const Duration(minutes: 15),
    this.checkInterval = const Duration(seconds: 30),
  });

  final Widget child;
  final Duration idleDuration;
  final Duration checkInterval;

  @override
  ConsumerState<SessionTimeoutWrapper> createState() =>
      _SessionTimeoutWrapperState();
}

class _SessionTimeoutWrapperState extends ConsumerState<SessionTimeoutWrapper> {
  DateTime _lastActivity = DateTime.now();
  Timer? _checkTimer;
  AppRole? _lastRole;

  @override
  void initState() {
    super.initState();
    _scheduleCheck();
  }

  void _resetActivity() {
    _lastActivity = DateTime.now();
  }

  void _scheduleCheck() {
    _checkTimer?.cancel();
    _checkTimer = Timer.periodic(widget.checkInterval, (_) {
      final role = ref.read(selectedRoleProvider);
      if (role == null) {
        _lastRole = null;
        return;
      }
      _lastRole = role;
      final idle = DateTime.now().difference(_lastActivity);
      if (idle >= widget.idleDuration) {
        _checkTimer?.cancel();
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

    return Listener(
      onPointerDown: (_) => _resetActivity(),
      onPointerMove: (_) => _resetActivity(),
      child: widget.child,
    );
  }
}
