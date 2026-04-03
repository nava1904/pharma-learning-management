// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — PORTAL SHELL BASE
// ═══════════════════════════════════════════════════════════════════════════════
//
// Shared infrastructure for all 4 portal shells:
//   Employee, Trainer, Admin, QA/Auditor
//
// Provides:
//  1. PortalShellBase widget: responsive sidebar/drawer/bottom-nav scaffold
//  2. PortalSidebar: shared sidebar structure (logo, nav, footer)
//  3. PortalHeader: shared top bar (search, notifications, avatar)
//  4. PortalNavItem: unified nav item with active state
//  5. PortalSectionLabel: sidebar section label
//  6. IdleTimeoutMixin: session timeout logic (15-min with countdown)
//  7. Shared nav data model (PortalNavEntry, PortalNavSection)
//
// Each portal shell composes this base with its own nav items, accent color,
// and portal label — no sidebar/header code duplication.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/pharma_components.dart';
import '../design_system/pharma_design_system.dart';
import '../design_system/responsive.dart';
import '../providers/auth_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NAV DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────

/// A single navigation entry in a portal sidebar.
class PortalNavEntry {
  const PortalNavEntry({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    this.badge,
    this.badgeColor,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final String? badge;
  final Color? badgeColor;
}

/// A section of navigation entries with a label.
class PortalNavSection {
  const PortalNavSection({
    required this.label,
    required this.items,
  });

  final String label;
  final List<PortalNavEntry> items;
}

// ─────────────────────────────────────────────────────────────────────────────
// PORTAL SHELL BASE — Responsive scaffold shared by all portals
// ─────────────────────────────────────────────────────────────────────────────

/// Shared responsive scaffold used by Employee, Trainer, Admin, QA shells.
///
/// - Desktop (≥1024px): Sidebar + Header + Content
/// - Tablet (600–1024px): Collapsible drawer + Header + Content
/// - Mobile (<600px): Drawer + Header + Bottom Nav + Content
class PortalShellBase extends StatelessWidget {
  const PortalShellBase({
    super.key,
    required this.child,
    required this.currentPath,
    required this.portalLabel,
    required this.accentColor,
    required this.navSections,
    required this.scaffoldKey,
    this.bottomNavItems,
    this.headerActions,
    this.sessionProgressBar,
    this.onSearch,
    this.userName,
    this.userRole,
  });

  final Widget child;
  final String currentPath;
  final String portalLabel;
  final Color accentColor;
  final List<PortalNavSection> navSections;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<BottomNavigationBarItem>? bottomNavItems;
  final List<Widget>? headerActions;
  final Widget? sessionProgressBar;
  final ValueChanged<String>? onSearch;
  final String? userName;
  final String? userRole;

  @override
  Widget build(BuildContext context) {
    final bp = context.responsive;
    final isDesktop = bp == Breakpoint.desktop || bp == Breakpoint.wide;
    final isMobile = bp == Breakpoint.mobile;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: PharmaColors.pageBg,
      drawer: !isDesktop
          ? Drawer(
              backgroundColor: PharmaColors.cardBg,
              child: SafeArea(
                child: PortalSidebar(
                  currentPath: currentPath,
                  portalLabel: portalLabel,
                  accentColor: accentColor,
                  navSections: navSections,
                  onNavTap: (route) {
                    Navigator.of(context).pop(); // close drawer
                    context.go(route);
                  },
                ),
              ),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Persistent sidebar on desktop
          if (isDesktop)
            PortalSidebar(
              currentPath: currentPath,
              portalLabel: portalLabel,
              accentColor: accentColor,
              navSections: navSections,
              onNavTap: (route) => context.go(route),
            ),
          // Main content area
          Expanded(
            child: Column(
              children: [
                // Optional session progress bar (employee portal)
                ?sessionProgressBar,
                // Header
                PortalHeader(
                  portalLabel: portalLabel,
                  showMenuButton: !isDesktop,
                  onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
                  actions: headerActions,
                  userName: userName,
                  userRole: userRole,
                ),
                // Page content
                Expanded(
                  child: Container(
                    color: PharmaColors.pageBg,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Mobile bottom nav
      bottomNavigationBar: isMobile && bottomNavItems != null
          ? BottomNavigationBar(
              currentIndex: _currentBottomIndex(),
              onTap: (i) {
                if (bottomNavItems != null && i < bottomNavItems!.length) {
                  // Each portal defines its own bottom nav routes
                }
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: accentColor,
              unselectedItemColor: PharmaColors.gray400,
              backgroundColor: PharmaColors.cardBg,
              items: bottomNavItems!,
            )
          : null,
    );
  }

  int _currentBottomIndex() {
    // Subclasses override as needed
    return 0;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PORTAL SIDEBAR — shared sidebar structure
// ─────────────────────────────────────────────────────────────────────────────

class PortalSidebar extends StatelessWidget {
  const PortalSidebar({
    super.key,
    required this.currentPath,
    required this.portalLabel,
    required this.accentColor,
    required this.navSections,
    required this.onNavTap,
  });

  final String currentPath;
  final String portalLabel;
  final Color accentColor;
  final List<PortalNavSection> navSections;
  final ValueChanged<String> onNavTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PortalLayout.sidebarWidth,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(
          right: BorderSide(color: PharmaColors.borderLight, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo section
          _SidebarLogoSection(
            portalLabel: portalLabel,
            accentColor: accentColor,
          ),
          // Navigation
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: PharmaSpacing.lg,
                vertical: PharmaSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final section in navSections) ...[
                    PortalSectionLabel(label: section.label),
                    for (final item in section.items)
                      PortalNavItem(
                        icon: item.icon,
                        activeIcon: item.activeIcon,
                        label: item.label,
                        route: item.route,
                        currentPath: currentPath,
                        accentColor: accentColor,
                        badge: item.badge,
                        badgeColor: item.badgeColor,
                        onTap: () => onNavTap(item.route),
                      ),
                    const SizedBox(height: PharmaSpacing.md),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SIDEBAR LOGO SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _SidebarLogoSection extends StatelessWidget {
  const _SidebarLogoSection({
    required this.portalLabel,
    required this.accentColor,
  });

  final String portalLabel;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: PharmaColors.borderLight, width: 1),
        ),
      ),
      child: Row(
        children: [
          VyuhLogo(height: 32, width: 32, color: accentColor),
          const SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PharmaBrand.name,
                  style: PharmaTypography.headingMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  portalLabel,
                  style: PharmaTypography.caption.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PORTAL HEADER — shared top bar
// ─────────────────────────────────────────────────────────────────────────────

class PortalHeader extends StatelessWidget {
  const PortalHeader({
    super.key,
    required this.portalLabel,
    required this.showMenuButton,
    required this.onMenuPressed,
    this.actions,
    this.userName,
    this.userRole,
  });

  final String portalLabel;
  final bool showMenuButton;
  final VoidCallback onMenuPressed;
  final List<Widget>? actions;
  final String? userName;
  final String? userRole;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PortalLayout.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(
          bottom: BorderSide(color: PharmaColors.borderLight, width: 1),
        ),
      ),
      child: Row(
        children: [
          if (showMenuButton)
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              color: PharmaColors.textSecondary,
              onPressed: onMenuPressed,
            ),
          if (showMenuButton) const SizedBox(width: PharmaSpacing.sm),
          // Page title / breadcrumb area
          Expanded(
            child: Text(
              portalLabel,
              style: PharmaTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: PharmaColors.textSecondary,
              ),
            ),
          ),
          // Action buttons
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PORTAL NAV ITEM — shared sidebar navigation item
// ─────────────────────────────────────────────────────────────────────────────

class PortalNavItem extends StatelessWidget {
  const PortalNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.currentPath,
    required this.accentColor,
    this.badge,
    this.badgeColor,
    this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final String currentPath;
  final Color accentColor;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback? onTap;

  bool get _isActive {
    if (route == currentPath) return true;
    // Match parent path: /employee matches /employee/*
    if (route.endsWith('/') && currentPath.startsWith(route)) return true;
    // Match when current path starts with route and next char is /
    if (currentPath.startsWith('$route/')) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isActive;
    final effectiveColor = isActive ? accentColor : PharmaColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: isActive ? accentColor.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: PharmaRadius.cardRadius,
        child: InkWell(
          borderRadius: PharmaRadius.cardRadius,
          onTap: onTap ?? () => context.go(route),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PharmaSpacing.md,
              vertical: PharmaSpacing.sm + 2,
            ),
            child: Row(
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  size: 20,
                  color: effectiveColor,
                ),
                const SizedBox(width: PharmaSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: (isActive
                            ? PharmaTypography.navItemActive
                            : PharmaTypography.navItem)
                        .copyWith(color: effectiveColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor ?? accentColor,
                      borderRadius: PharmaRadius.pillRadius,
                    ),
                    child: Text(
                      badge!,
                      style: PharmaTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PORTAL SECTION LABEL
// ─────────────────────────────────────────────────────────────────────────────

class PortalSectionLabel extends StatelessWidget {
  const PortalSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: PharmaSpacing.md,
        bottom: PharmaSpacing.sm,
        top: PharmaSpacing.xs,
      ),
      child: Text(
        label,
        style: PharmaTypography.labelSmall.copyWith(
          color: PharmaColors.gray400,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// IDLE TIMEOUT MIXIN — shared session timeout logic
// ─────────────────────────────────────────────────────────────────────────────

/// Mixin for ConsumerState that adds idle timeout functionality.
///
/// Usage:
/// ```dart
/// class _MyShellState extends ConsumerState<MyShell> with IdleTimeoutMixin {
///   @override
///   int get idleTimeoutMinutes => 15;
///
///   @override
///   Widget build(BuildContext context) {
///     return Listener(
///       onPointerDown: (_) => resetIdleTimer(),
///       child: ...
///     );
///   }
/// }
/// ```
mixin IdleTimeoutMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  Timer? _idleTimer;
  Timer? _countdownTimer;
  int _countdownSeconds = 60;
  bool _showingTimeoutDialog = false;

  /// Override to set timeout duration in minutes. Default: 15.
  int get idleTimeoutMinutes => 15;

  /// Override for countdown seconds in the warning dialog. Default: 60.
  int get countdownDuration => 60;

  @override
  void initState() {
    super.initState();
    resetIdleTimer();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void resetIdleTimer() {
    if (_showingTimeoutDialog) return;
    _idleTimer?.cancel();
    _idleTimer = Timer(
      Duration(minutes: idleTimeoutMinutes),
      _showTimeoutWarning,
    );
  }

  void _showTimeoutWarning() {
    if (!mounted || _showingTimeoutDialog) return;
    _showingTimeoutDialog = true;
    _countdownSeconds = countdownDuration;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            _countdownTimer ??= Timer.periodic(
              const Duration(seconds: 1),
              (timer) {
                if (_countdownSeconds <= 0) {
                  timer.cancel();
                  _showingTimeoutDialog = false;
                  Navigator.of(dialogContext).pop();
                  logout(ref, context);
                } else {
                  setDialogState(() => _countdownSeconds--);
                }
              },
            );

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(PharmaRadius.xl),
              ),
              title: Row(
                children: [
                  Icon(Icons.timer_off_rounded, color: PharmaColors.warning, size: 24),
                  const SizedBox(width: 8),
                  Text('Session Timeout', style: PharmaTypography.headingMedium),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your session will expire due to inactivity.',
                    style: PharmaTypography.body,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Logging out in ${_countdownSeconds}s',
                    style: PharmaTypography.headingSmall.copyWith(
                      color: _countdownSeconds <= 10
                          ? PharmaColors.danger
                          : PharmaColors.warning,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _countdownTimer?.cancel();
                    _countdownTimer = null;
                    _showingTimeoutDialog = false;
                    Navigator.of(dialogContext).pop();
                    logout(ref, context);
                  },
                  child: Text('Sign Out', style: TextStyle(color: PharmaColors.danger)),
                ),
                FilledButton(
                  onPressed: () {
                    _countdownTimer?.cancel();
                    _countdownTimer = null;
                    _showingTimeoutDialog = false;
                    Navigator.of(dialogContext).pop();
                    resetIdleTimer();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                  ),
                  child: const Text('Stay Signed In'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _countdownTimer?.cancel();
      _countdownTimer = null;
      _showingTimeoutDialog = false;
    });
  }
}
