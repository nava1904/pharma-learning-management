import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../core/client.dart';

/// Role for demo login flow.
enum AppRole {
  employee,
  admin,
  qa,
  trainer,
  auditor,
  analytics,
}

/// Maps role to demo user email.
String emailForRole(AppRole role) {
  switch (role) {
    case AppRole.employee:
      return 'employee@pharmacorp.demo';
    case AppRole.admin:
      return 'admin@pharmacorp.demo';
    case AppRole.qa:
      return 'qa@pharmacorp.demo';
    case AppRole.trainer:
      return 'trainer@pharmacorp.demo';
    case AppRole.auditor:
      return 'auditor@pharmacorp.demo';
    case AppRole.analytics:
      return 'analytics@pharmacorp.demo';
  }
}

/// Maps email to role for real auth (known demo emails or default employee).
/// Includes MVP seed users: alice, bob, carol, dave, emma, sme, sme2, etc.
AppRole roleForEmail(String email) {
  final lower = email.toLowerCase();
  switch (lower) {
    case 'admin@pharmacorp.demo':
    case 'it@pharmacorp.demo':
      return AppRole.admin;
    case 'employee@pharmacorp.demo':
    case 'alice@pharmacorp.demo':
    case 'bob@pharmacorp.demo':
    case 'carol@pharmacorp.demo':
    case 'dave@pharmacorp.demo':
    case 'emma@pharmacorp.demo':
    case 'locked@pharmacorp.demo':
    case 'ex.employee@pharmacorp.demo':
      return AppRole.employee;
    case 'qa@pharmacorp.demo':
    case 'qa.director@pharmacorp.demo':
      return AppRole.qa;
    case 'sme@pharmacorp.demo':
    case 'sme2@pharmacorp.demo':
      return AppRole.trainer;
    case 'auditor@pharmacorp.demo':
      return AppRole.auditor;
    case 'analytics@pharmacorp.demo':
      return AppRole.analytics;
    default:
      if (lower.startsWith('employee') && lower.endsWith('@pharmacorp.demo')) {
        return AppRole.employee;
      }
      return AppRole.employee;
  }
}

/// Path for role dashboard.
String pathForRole(AppRole role) {
  switch (role) {
    case AppRole.employee:
      return '/employee';
    case AppRole.admin:
      return '/admin';
    case AppRole.qa:
      return '/qa';
    case AppRole.trainer:
      return '/trainer';
    case AppRole.auditor:
      return '/auditor';
    case AppRole.analytics:
      return '/analytics';
  }
}

/// Routes allowed per role. Used for sidebar filtering and route guards.
bool pathAllowedForRole(String path, AppRole role) {
  if (path == '/' || path.isEmpty) return true;
  if (path.startsWith('/employee') ||
      path.startsWith('/courses') ||
      path.startsWith('/learning') ||
      path.startsWith('/training-timeline')) {
    return role == AppRole.employee ||
        role == AppRole.admin ||
        role == AppRole.trainer;
  }
  if (path.startsWith('/admin')) {
    if (path.contains('training-waivers')) {
      return role == AppRole.admin || role == AppRole.qa;
    }
    return role == AppRole.admin;
  }
  if (path.startsWith('/qa')) return role == AppRole.qa;
  if (path.startsWith('/trainer')) return role == AppRole.trainer;
  if (path.startsWith('/auditor')) return role == AppRole.auditor || role == AppRole.qa;
  if (path.startsWith('/training-matrix')) return role == AppRole.admin;
  if (path.startsWith('/audit-trail')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.auditor;
  }
  if (path.startsWith('/compliance-report')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.auditor;
  }
  if (path.startsWith('/esignature-verification')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.auditor;
  }
  if (path.startsWith('/analytics')) {
    return role == AppRole.admin || role == AppRole.qa || role == AppRole.analytics;
  }
  if (path.startsWith('/documents')) {
    return role == AppRole.admin || role == AppRole.qa;
  }
  if (path.startsWith('/quality-events')) {
    return role == AppRole.qa;
  }
  if (path.startsWith('/event-triggers')) {
    return role == AppRole.admin || role == AppRole.qa;
  }
  if (path.startsWith('/inspection-management')) {
    return role == AppRole.admin || role == AppRole.qa;
  }
  if (path.startsWith('/course') || path.startsWith('/assessment') ||
      path.startsWith('/certificate') || path.startsWith('/esignature')) {
    return role == AppRole.employee ||
        role == AppRole.admin ||
        role == AppRole.trainer;
  }
  if (path.startsWith('/assessments') || path.startsWith('/certificates')) {
    return role == AppRole.employee ||
        role == AppRole.admin ||
        role == AppRole.trainer;
  }
  return true;
}

/// Current selected role (for demo login or real auth). Null = not logged in.
final selectedRoleProvider = StateProvider<AppRole?>((ref) => null);

/// When using real auth, holds the authenticated user's email. Null when using demo mode.
final authenticatedUserEmailProvider = StateProvider<String?>((ref) => null);

/// Provider for current user email: real auth email or demo role email.
final currentUserEmailProvider = Provider<String?>((ref) {
  final authEmail = ref.watch(authenticatedUserEmailProvider);
  if (authEmail != null) return authEmail;
  final role = ref.watch(selectedRoleProvider);
  return role != null ? emailForRole(role) : null;
});

/// Log in with role and navigate to dashboard (demo mode).
void loginWithRole(WidgetRef ref, BuildContext context, AppRole role) {
  ref.read(authenticatedUserEmailProvider.notifier).state = null;
  ref.read(selectedRoleProvider.notifier).state = role;
  context.go(pathForRole(role));
}

/// Log out and navigate to login.
void logout(WidgetRef ref, BuildContext context) {
  ref.read(selectedRoleProvider.notifier).state = null;
  ref.read(authenticatedUserEmailProvider.notifier).state = null;
  if (client.auth.isAuthenticated) {
    try {
      client.auth.signOutDevice();
    } catch (_) {}
  }
  context.go('/');
}

/// Log in with real auth (email/password). Call after SignInWidget/EmailSignInWidget succeeds.
Future<void> loginWithAuthEmail(
  WidgetRef ref,
  BuildContext context,
  String email,
) async {
  final role = roleForEmail(email);
  ref.read(selectedRoleProvider.notifier).state = role;
  ref.read(authenticatedUserEmailProvider.notifier).state = email;
  context.go(pathForRole(role));
}
