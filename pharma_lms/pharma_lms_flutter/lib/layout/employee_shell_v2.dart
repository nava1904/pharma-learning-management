// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — employee shell v2 (React reference match)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Layout extracted from React reference: DashboardLayout.tsx
//
// ┌──────────────────────────────────────────────────────────────────────────────┐
// │ SIDEBAR (256px)  │              MAIN AREA                                    │
// │  ┌────────────┐  │  ┌──────────────────────────────────────────────────────┐ │
// │  │   LOGO     │  │  │  HEADER (search, bell, edit, avatar)                 │ │
// │  ├────────────┤  │  ├──────────────────────────────────────────────────────┤ │
// │  │   NAV      │  │  │                                                      │ │
// │  │  ● Home    │  │  │               PAGE CONTENT                           │ │
// │  │  ○ Courses │  │  │               (gray-50 bg)                           │ │
// │  │  ○ Assess  │  │  │                                                      │ │
// │  │  ○ History │  │  └──────────────────────────────────────────────────────┘ │
// │  │  ○ Certs   │  │                                                          │
// │  │            │  │                                                          │
// │  │────────────│  │                                                          │
// │  │ ● Help     │  │                                                          │
// │  └────────────┘  │                                                          │
// └──────────────────────────────────────────────────────────────────────────────┘
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/pharma_components.dart';
import '../design_system/pharma_design_system.dart';
import '../providers/auth_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/user_provider.dart';

// ─── LAYOUT CONSTANTS ────────────────────────────────────────────────────────

const int _kIdleTimeoutMinutes = 15; // FR-01-04: 15-min idle timeout

// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE SHELL — MAIN WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

class EmployeeShellV2 extends ConsumerStatefulWidget {
  const EmployeeShellV2({
    super.key,
    required this.child,
    this.currentPath,
  });

  final Widget child;
  final String? currentPath;

  @override
  ConsumerState<EmployeeShellV2> createState() => _EmployeeShellV2State();
}

class _EmployeeShellV2State extends ConsumerState<EmployeeShellV2> {
  Timer? _idleTimer;
  bool _sessionWarningShown = false;
  double _sessionProgress = 1.0; // 1.0 = full, 0.0 = expired
  Timer? _sessionBarTimer;

  @override
  void initState() {
    super.initState();
    _resetIdleTimer();
    _startSessionBar();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _sessionBarTimer?.cancel();
    super.dispose();
  }

  /// SCR-22: Session timer bar — 2px bar at top showing remaining time
  void _startSessionBar() {
    _sessionBarTimer?.cancel();
    _sessionProgress = 1.0;
    const totalSeconds = _kIdleTimeoutMinutes * 60;
    var elapsed = 0;
    _sessionBarTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsed++;
      if (mounted) {
        setState(() {
          _sessionProgress = 1.0 - (elapsed / totalSeconds);
          if (_sessionProgress < 0) _sessionProgress = 0;
        });
      }
      if (elapsed >= totalSeconds) timer.cancel();
    });
  }

  /// EMP-WF-07: Reset idle timer on any user interaction
  void _resetIdleTimer() {
    _idleTimer?.cancel();
    _sessionWarningShown = false;
    _startSessionBar(); // Reset session progress bar
    _idleTimer = Timer(const Duration(minutes: _kIdleTimeoutMinutes), () {
      if (mounted && !_sessionWarningShown) {
        _sessionWarningShown = true;
        _showSessionTimeoutWarning();
      }
    });
  }

  void _showSessionTimeoutWarning() {
    if (!mounted) return;
    int countdown = 60; // 60 seconds to respond
    Timer? countdownTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            countdownTimer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
              if (countdown <= 0) {
                timer.cancel();
                Navigator.of(dialogContext).pop();
                // Auto-logout
                logout(ref, context);
              } else {
                setDialogState(() => countdown--);
              }
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
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
                    'Logging out in ${countdown}s',
                    style: PharmaTypography.headingSmall.copyWith(
                      color: countdown <= 10 ? PharmaColors.danger : PharmaColors.warning,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    logout(ref, context);
                  },
                  child: Text('Sign Out', style: TextStyle(color: PharmaColors.danger)),
                ),
                FilledButton(
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _resetIdleTimer();
                  },
                  style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
                  child: const Text('Stay Signed In'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= PortalLayout.breakpointDesktop;
    final isMobile = width < PortalLayout.breakpointTablet;

    return Listener(
      onPointerDown: (_) => _resetIdleTimer(),
      onPointerMove: (_) => _resetIdleTimer(),
      child: Scaffold(
        backgroundColor: PharmaColors.pageBg,
        drawer: isMobile ? _MobileDrawerV2(currentPath: widget.currentPath ?? '') : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─────────────────────────────────────────────────────────────────
            // LEFT SIDEBAR (Desktop only)
            // From React: w-64 bg-white border-r border-gray-200
            // ─────────────────────────────────────────────────────────────────
            if (isDesktop)
              _SidebarV2(currentPath: widget.currentPath ?? ''),
            
            // ─────────────────────────────────────────────────────────────────
            // MAIN CONTENT AREA
            // ─────────────────────────────────────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  // SCR-22: 2px session timer bar at top — emerald → amber → red
                  LinearProgressIndicator(
                    value: _sessionProgress,
                    minHeight: 2,
                    backgroundColor: PharmaColors.gray200,
                    valueColor: AlwaysStoppedAnimation(
                      _sessionProgress > 0.3
                          ? PharmaColors.emerald500
                          : _sessionProgress > 0.1
                              ? PharmaColors.warning
                              : PharmaColors.danger,
                    ),
                  ),
                  // Header
                  _HeaderV2(
                    showMenuButton: !isDesktop,
                    onMenuPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  
                  // Page Content
                  Expanded(
                    child: Container(
                      color: PharmaColors.pageBg,
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Mobile bottom navigation
        bottomNavigationBar: isMobile
            ? _MobileBottomNavV2(currentPath: widget.currentPath ?? '')
            : null,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SIDEBAR (Desktop)
// From React: DashboardLayout.tsx - Sidebar component
// ═══════════════════════════════════════════════════════════════════════════════

class _SidebarV2 extends StatelessWidget {
  const _SidebarV2({required this.currentPath});

  final String currentPath;

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
          // ─────────────────────────────────────────────────────────────────
          // LOGO SECTION
          // From React: p-6 border-b border-gray-200, flex items-center gap-2
          // ─────────────────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: PharmaColors.borderLight, width: 1),
              ),
            ),
            child: Row(
              children: [
                VyuhLogo(
                  height: 32,
                  width: 32,
                  color: PharmaColors.emerald600,
                ),
                const SizedBox(width: PharmaSpacing.md),
                Column(
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
                      'Employee Portal',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.emerald600,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // ─────────────────────────────────────────────────────────────────
          // NAVIGATION (FRD: Sidebar section labels)
          // From React ref2: DashboardLayout.tsx - navItems array
          // ─────────────────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: PharmaSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── OVERVIEW SECTION ──
                  _SidebarSectionLabel(label: 'OVERVIEW'),
                  _NavItemV2(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard_rounded,
                    label: 'Dashboard',
                    route: '/employee',
                    currentPath: currentPath,
                    matchExact: true,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── TRAINING SECTION ──
                  _SidebarSectionLabel(label: 'TRAINING'),
                  _NavItemV2(
                    icon: Icons.menu_book_outlined,
                    activeIcon: Icons.menu_book_rounded,
                    label: 'Course Catalogue',
                    route: '/employee/catalog',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.school_outlined,
                    activeIcon: Icons.school_rounded,
                    label: 'My Learning',
                    route: '/employee/lessons',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.assignment_outlined,
                    activeIcon: Icons.assignment_rounded,
                    label: 'Assessments',
                    route: '/employee/assessments',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.groups_outlined,
                    activeIcon: Icons.groups_rounded,
                    label: 'My Batches',
                    route: '/employee/my-batches',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.task_alt_outlined,
                    activeIcon: Icons.task_alt_rounded,
                    label: 'Assignments',
                    route: '/employee/standalone-assignments',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.assignment_turned_in_outlined,
                    activeIcon: Icons.assignment_turned_in_rounded,
                    label: 'Assigned training',
                    route: '/employee/assigned-training',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.qr_code_scanner_outlined,
                    activeIcon: Icons.qr_code_scanner,
                    label: 'Operator check',
                    route: '/employee/operator',
                    currentPath: currentPath,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── RECORDS SECTION ──
                  _SidebarSectionLabel(label: 'RECORDS'),
                  _NavItemV2(
                    icon: Icons.history_outlined,
                    activeIcon: Icons.history_rounded,
                    label: 'Training History',
                    route: '/employee/training-history',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.workspace_premium_outlined,
                    activeIcon: Icons.workspace_premium_rounded,
                    label: 'Certifications',
                    route: '/employee/credentials',
                    currentPath: currentPath,
                  ),
                  _NavItemV2(
                    icon: Icons.download_outlined,
                    activeIcon: Icons.download_rounded,
                    label: 'Downloads',
                    route: '/employee/downloads',
                    currentPath: currentPath,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── ACCOUNT SECTION ──
                  _SidebarSectionLabel(label: 'ACCOUNT'),
                  _NavItemV2(
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'Profile & Settings',
                    route: '/employee/profile',
                    currentPath: currentPath,
                  ),
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
// SIDEBAR SECTION LABEL (FRD: 10px/700/UC/ls.07em)
// ─────────────────────────────────────────────────────────────────────────────

class _SidebarSectionLabel extends StatelessWidget {
  const _SidebarSectionLabel({required this.label});

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
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: PharmaColors.textQuaternary,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NAV ITEM
// From React: className={isActive ? 'bg-gray-100 text-gray-900' : 'text-gray-600 hover:bg-gray-50'}
// ─────────────────────────────────────────────────────────────────────────────

class _NavItemV2 extends StatefulWidget {
  const _NavItemV2({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.currentPath,
    this.badge, // ignore: unused_element_parameter
    this.matchExact = false,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final String currentPath;
  final int? badge;
  final bool matchExact;

  @override
  State<_NavItemV2> createState() => _NavItemV2State();
}

class _NavItemV2State extends State<_NavItemV2> {
  bool _isHovered = false;

  bool get isActive {
    if (widget.matchExact) {
      return widget.currentPath == widget.route ||
             widget.currentPath == '${widget.route}/dashboard';
    }
    return widget.currentPath.startsWith(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          margin: const EdgeInsets.only(bottom: PharmaSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: PharmaSpacing.md,
            vertical: PharmaSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? PharmaColors.emerald50
                : _isHovered
                    ? PharmaColors.gray50
                    : Colors.transparent,
            borderRadius: PharmaRadius.buttonRadius,
            border: isActive
                ? Border.all(color: PharmaColors.emerald200, width: 1)
                : null,
          ),
          child: Row(
            children: [
              Icon(
                isActive ? widget.activeIcon : widget.icon,
                size: 20,
                color: isActive
                    ? PharmaColors.emerald700
                    : PharmaColors.textSecondary,
              ),
              const SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Text(
                  widget.label,
                  style: isActive
                      ? PharmaTypography.navItemActive.copyWith(
                          color: PharmaColors.emerald700,
                        )
                      : PharmaTypography.navItem,
                ),
              ),
              if (widget.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: PharmaColors.dangerBg,
                    borderRadius: PharmaRadius.pillRadius,
                  ),
                  child: Text(
                    '${widget.badge}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: PharmaColors.dangerText,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HEADER
// From React: DashboardLayout.tsx - Header component
// ═══════════════════════════════════════════════════════════════════════════════

class _HeaderV2 extends ConsumerWidget {
  const _HeaderV2({
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    // Start the auto-refresh timer
    ref.watch(notificationRefreshTimerProvider);

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
          // Mobile menu button
          if (showMenuButton) ...[
            IconButton(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu_rounded),
              iconSize: 20,
              color: PharmaColors.textSecondary,
            ),
            const SizedBox(width: PharmaSpacing.sm),
          ],
          
          // ─────────────────────────────────────────────────────────────────
          // SEARCH BAR — Navigates to course catalog with search query
          // ─────────────────────────────────────────────────────────────────
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: PharmaColors.pageBg,
                  borderRadius: PharmaRadius.inputRadius,
                  border: Border.all(color: PharmaColors.borderLight),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: PharmaSpacing.md),
                    Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: PharmaColors.textQuaternary,
                    ),
                    const SizedBox(width: PharmaSpacing.sm),
                    Expanded(
                      child: TextField(
                        style: PharmaTypography.body.copyWith(
                          color: PharmaColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search courses...',
                          hintStyle: PharmaTypography.body.copyWith(
                            color: PharmaColors.textQuaternary,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        onSubmitted: (query) {
                          if (query.trim().isNotEmpty) {
                            context.go('/employee/catalog');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(width: PharmaSpacing.lg),
          
          // ─────────────────────────────────────────────────────────────────
          // HEADER ACTIONS — Profile and Notification Bell with real data
          // ─────────────────────────────────────────────────────────────────
          _HeaderIconButton(
            icon: Icons.settings_outlined,
            onPressed: () => context.go('/employee/profile'),
          ),
          const SizedBox(width: PharmaSpacing.sm),
          // Notification bell with unread badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              _HeaderIconButton(
                icon: Icons.notifications_outlined,
                onPressed: () => _showNotificationPanel(context, ref),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    decoration: const BoxDecoration(
                      color: PharmaColors.danger,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 9 ? '9+' : '$unreadCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: PharmaSpacing.lg),
          
          // Avatar
          GestureDetector(
            onTap: () => _showProfileMenu(context, ref),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: PharmaColors.emerald600,
                borderRadius: PharmaRadius.avatarRadius,
              ),
              child: userAsync.when(
                data: (user) {
                  final initials = _getInitials(user?.firstName, user?.lastName, user?.email);
                  return Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String? firstName, String? lastName, String? email) {
    if (firstName != null && firstName.isNotEmpty) {
      final first = firstName[0];
      final last = (lastName != null && lastName.isNotEmpty) ? lastName[0] : '';
      return '$first$last'.toUpperCase();
    }
    if (email == null || email.isEmpty) return 'U';
    final parts = email.split('@').first.split('.');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return email[0].toUpperCase();
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: const ColoredBox(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: PortalLayout.headerHeight + 4,
            right: PharmaSpacing.cardPadding,
            child: Material(
              color: Colors.transparent,
              child: _ProfileMenuV2(
                onSignOut: () {
                  Navigator.of(ctx).pop();
                  logout(ref, context);
                },
                onProfile: () {
                  Navigator.of(ctx).pop();
                  context.go('/employee/profile');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationPanel(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: const ColoredBox(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: PortalLayout.headerHeight + 4,
            right: PharmaSpacing.cardPadding,
            child: Material(
              color: Colors.transparent,
              child: _NotificationPanel(ref: ref),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatefulWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_HeaderIconButton> createState() => _HeaderIconButtonState();
}

class _HeaderIconButtonState extends State<_HeaderIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _isHovered ? PharmaColors.gray100 : Colors.transparent,
            borderRadius: PharmaRadius.buttonRadius,
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: PharmaColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuV2 extends StatelessWidget {
  const _ProfileMenuV2({
    required this.onSignOut,
    required this.onProfile,
  });

  final VoidCallback onSignOut;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.elevated,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ProfileMenuItem(
            icon: Icons.person_outline_rounded,
            label: 'Profile & Settings',
            onTap: onProfile,
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          _ProfileMenuItem(
            icon: Icons.history_rounded,
            label: 'Training History',
            onTap: () {
              Navigator.of(context).pop();
              context.go('/employee/training-history');
            },
          ),
          _ProfileMenuItem(
            icon: Icons.workspace_premium_outlined,
            label: 'Certifications',
            onTap: () {
              Navigator.of(context).pop();
              context.go('/employee/credentials');
            },
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          _ProfileMenuItem(
            icon: Icons.logout_rounded,
            label: 'Sign Out',
            onTap: onSignOut,
            isDanger: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatefulWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDanger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDanger;

  @override
  State<_ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<_ProfileMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isDanger ? PharmaColors.danger : PharmaColors.textPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: PharmaSpacing.lg,
            vertical: PharmaSpacing.md,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? PharmaColors.gray50 : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(widget.icon, size: 18, color: color),
              const SizedBox(width: PharmaSpacing.md),
              Text(
                widget.label,
                style: PharmaTypography.body.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// NOTIFICATION PANEL — Real-time notifications from Serverpod
// ═══════════════════════════════════════════════════════════════════════════════

class _NotificationPanel extends StatelessWidget {
  const _NotificationPanel({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Container(
      width: 380,
      constraints: const BoxConstraints(maxHeight: 500),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.elevated,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_rounded, size: 20, color: PharmaColors.emerald600),
                const SizedBox(width: PharmaSpacing.sm),
                Text('Notifications', style: PharmaTypography.headingSmall),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    ref.invalidate(notificationsProvider);
                  },
                  child: const Icon(Icons.refresh_rounded, size: 18, color: PharmaColors.textTertiary),
                ),
              ],
            ),
          ),
          // Content
          Flexible(
            child: notificationsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(PharmaSpacing.xxl),
                child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: PharmaColors.emerald500)),
              ),
              error: (_, __) => Padding(
                padding: const EdgeInsets.all(PharmaSpacing.xxl),
                child: Center(
                  child: Text('Unable to load notifications', style: PharmaTypography.body),
                ),
              ),
              data: (notifications) {
                if (notifications.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(PharmaSpacing.xxl),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_none_rounded, size: 40, color: PharmaColors.textQuaternary),
                          const SizedBox(height: PharmaSpacing.md),
                          Text('No notifications', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
                          const SizedBox(height: PharmaSpacing.xs),
                          Text('You\'re all caught up!', style: PharmaTypography.caption),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: notifications.length.clamp(0, 10),
                  separatorBuilder: (_, __) => Divider(height: 1, color: PharmaColors.borderLight),
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return _NotificationRow(notif: notif);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.notif});
  final NotificationItem notif;

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor, bgColor) = _getNotifStyle(notif.type, notif.severity);

    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        // Navigate based on type
        if (notif.type == 'cert_expiring') {
          context.go('/employee/credentials');
        } else if (notif.type == 'training_assigned' || notif.type == 'overdue' || notif.type == 'due_soon') {
          context.go('/employee/lessons');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: PharmaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notif.title, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(notif.message, style: PharmaTypography.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            if (notif.severity == 'critical')
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: PharmaColors.danger, shape: BoxShape.circle),
              ),
          ],
        ),
      ),
    );
  }

  (IconData, Color, Color) _getNotifStyle(String type, String severity) {
    switch (type) {
      case 'overdue':
        return (Icons.warning_amber_rounded, PharmaColors.danger, PharmaColors.dangerBg);
      case 'due_soon':
        return (Icons.schedule_rounded, PharmaColors.warning, PharmaColors.warningBg);
      case 'cert_expiring':
        return (Icons.workspace_premium_rounded, PharmaColors.info, PharmaColors.infoBg);
      case 'training_assigned':
        return (Icons.assignment_ind_rounded, PharmaColors.emerald600, PharmaColors.emerald50);
      case 'assessment_complete':
        return (Icons.check_circle_rounded, PharmaColors.success, PharmaColors.successBg);
      case 'sop_update':
        return (Icons.description_rounded, PharmaColors.warning, PharmaColors.warningBg);
      default:
        return (Icons.info_outline_rounded, PharmaColors.textTertiary, PharmaColors.gray100);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOBILE COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _MobileDrawerV2 extends StatelessWidget {
  const _MobileDrawerV2({required this.currentPath});

  final String currentPath;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: PharmaColors.cardBg,
      child: _SidebarV2(currentPath: currentPath),
    );
  }
}

class _MobileBottomNavV2 extends StatelessWidget {
  const _MobileBottomNavV2({required this.currentPath});

  final String currentPath;

  int get _currentIndex {
    if (currentPath == '/employee' || currentPath == '/employee/dashboard') return 0;
    if (currentPath.startsWith('/employee/lessons') || currentPath.startsWith('/employee/assessments')) return 1;
    if (currentPath.startsWith('/employee/catalog')) return 2;
    if (currentPath.startsWith('/employee/training-history')) return 3;
    if (currentPath.startsWith('/employee/profile') || currentPath.startsWith('/employee/credentials')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(
          top: BorderSide(color: PharmaColors.borderLight, width: 1),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MobileNavItem(
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard_rounded,
                label: 'Dashboard',
                isActive: _currentIndex == 0,
                onTap: () => context.go('/employee'),
              ),
              _MobileNavItem(
                icon: Icons.school_outlined,
                activeIcon: Icons.school_rounded,
                label: 'Training',
                isActive: _currentIndex == 1,
                onTap: () => context.go('/employee/lessons'),
              ),
              _MobileNavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book_rounded,
                label: 'Catalog',
                isActive: _currentIndex == 2,
                onTap: () => context.go('/employee/catalog'),
              ),
              _MobileNavItem(
                icon: Icons.history_outlined,
                activeIcon: Icons.history_rounded,
                label: 'History',
                isActive: _currentIndex == 3,
                onTap: () => context.go('/employee/training-history'),
              ),
              _MobileNavItem(
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: 'Profile',
                isActive: _currentIndex == 4,
                onTap: () => context.go('/employee/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 24,
              color: isActive
                  ? PharmaColors.emerald600
                  : PharmaColors.textTertiary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? PharmaColors.emerald600
                    : PharmaColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
