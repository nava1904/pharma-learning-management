// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE SHELL (3-COLUMN DESKTOP LAYOUT)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Modern SaaS 3-column architecture inspired by Linear, Vercel, and Odoo:
//
// ┌──────────────────────────────────────────────────────────────────────────────┐
// │                              TOP BAR (48px)                                  │
// ├──────────┬──────────────────────────────────────┬───────────────────────────┤
// │  SIDEBAR │           CENTER CANVAS              │     CONTEXT PANEL         │
// │  (240px) │           (Expanded)                 │        (300px)            │
// │          │                                      │                           │
// │ Nav Rail │  - Page Content                      │ - Profile Summary         │
// │  Items   │  - Dashboard / Training / etc        │ - Compliance Donut        │
// │          │                                      │ - Up Next / Urgent        │
// └──────────┴──────────────────────────────────────┴───────────────────────────┘
//
// DESIGN TOKENS:
// - Sidebar: Pure white, flat ListTiles, active = indigo50 bg + indigo text
// - Center: slate50 background (F8FAFC)
// - Context: Pure white, left border slate200
// - Soft shadows: color: black.withOpacity(0.04), blurRadius: 24
// - Full rounded corners: 16-20px
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../core/client.dart';
import '../design_system/pharma_components.dart';
import '../design_system/pharma_design_system.dart';
import '../providers/dashboard_providers.dart';
import '../providers/user_provider.dart';

// ─── LAYOUT CONSTANTS ────────────────────────────────────────────────────────

const double _kTopBarHeight = 48.0;
const double _kSidebarWidth = 240.0;
const double _kContextPanelWidth = 300.0;
const double _kBreakpointDesktop = 1200.0;
const double _kBreakpointTablet = 768.0;

// ─── DESIGN COLORS (Dribbble-style SaaS Aesthetic) ───────────────────────────

class _ShellColors {
  // Soft gray canvas background (Dribbble aesthetic)
  static const Color canvasBg = Color(0xFFF8F9FA);
  
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  
  // Light mode nav: subtle gray bg for active state
  static const Color navActiveBg = Color(0xFFF3F4F6);
  static const Color navActiveText = Color(0xFF1F2937);
  static const Color navInactiveText = Color(0xFF6B7280);
  static const Color navInactiveIcon = Color(0xFF9CA3AF);
  static const Color sectionLabel = Color(0xFF9CA3AF);
  
  static const Color indigo50 = Color(0xFFEEF2FF);
  static const Color indigo100 = Color(0xFFE0E7FF);
  static const Color indigo500 = Color(0xFF6366F1);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color indigo700 = Color(0xFF4338CA);
  
  static const Color emerald500 = Color(0xFF10B981);
  static const Color red500 = Color(0xFFEF4444);
  static const Color amber500 = Color(0xFFF59E0B);
}

// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE SHELL - MAIN WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

class EmployeeShell extends ConsumerStatefulWidget {
  const EmployeeShell({
    super.key,
    required this.child,
    this.currentPath,
  });

  final Widget child;
  final String? currentPath;

  @override
  ConsumerState<EmployeeShell> createState() => _EmployeeShellState();
}

class _EmployeeShellState extends ConsumerState<EmployeeShell> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= _kBreakpointDesktop;
    final isTablet = width >= _kBreakpointTablet && width < _kBreakpointDesktop;
    final isMobile = width < _kBreakpointTablet;

    return Scaffold(
      // Dribbble-style soft gray canvas background
      backgroundColor: _ShellColors.canvasBg,
      drawer: isMobile ? _MobileDrawer(currentPath: widget.currentPath) : null,
      bottomNavigationBar: isMobile
          ? _MobileBottomNav(currentPath: widget.currentPath ?? '')
          : null,
      body: Column(
        children: [
          // Top Bar - flat white with subtle border
          _TopBar(
            onMenuPressed: isMobile
                ? () => Scaffold.of(context).openDrawer()
                : null,
          ),
          
          // Main Content Area
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Sidebar (Desktop & Tablet) - pure white
                if (!isMobile)
                  _Sidebar(
                    currentPath: widget.currentPath ?? '',
                    isCompact: isTablet,
                  ),
                
                // Center Canvas - soft gray background
                Expanded(
                  child: Container(
                    color: _ShellColors.canvasBg,
                    child: widget.child,
                  ),
                ),
                
                // Right Context Panel (Desktop only)
                if (isDesktop)
                  _ContextPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════════════════════════════════════════

class _TopBar extends ConsumerWidget {
  const _TopBar({this.onMenuPressed});

  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final complianceAsync = ref.watch(userComplianceProvider);
    
    return Container(
      height: 64, // Taller for breathing room (Dribbble style)
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        // Subtle 1px bottom border instead of shadow
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: [
          // Mobile menu button
          if (onMenuPressed != null) ...[
            IconButton(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu_rounded),
              iconSize: 20,
              color: _ShellColors.slate600,
              tooltip: 'Menu',
            ),
            const SizedBox(width: 8),
          ],
          
          // Logo
          VyuhLogo(height: 28, width: 28),
          const SizedBox(width: 10),
          Text(
            PharmaBrand.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _ShellColors.slate800,
              letterSpacing: -0.3,
            ),
          ),
          
          // Search
          const SizedBox(width: 32),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _SearchField(),
            ),
          ),
          
          const Spacer(),
          
          // Notifications
          _NotificationBell(
            count: complianceAsync.valueOrNull?.overdueCount ?? 0,
          ),
          
          const SizedBox(width: 12),
          
          // Profile Avatar
          _ProfileAvatar(
            initials: _getInitials(userAsync.valueOrNull?.email),
            onTap: () => _showProfileMenu(context, ref),
          ),
        ],
      ),
    );
  }

  String _getInitials(String? email) {
    if (email == null || email.isEmpty) return 'U';
    final parts = email.split('@').first.split('.');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return email[0].toUpperCase();
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ProfileMenuOverlay(
        onDismiss: () => entry.remove(),
        onSignOut: () {
          entry.remove();
          client.auth.signOutDevice();
          context.go('/');
        },
        onProfile: () {
          entry.remove();
          context.go('/employee/profile');
        },
      ),
    );
    overlay.insert(entry);
  }
}

class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xFF185FA5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xFF1D9E75),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: _ShellColors.slate50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _ShellColors.slate200, width: 0.5),
      ),
      child: TextField(
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Search courses, SOPs…',
          hintStyle: TextStyle(
            fontSize: 12,
            color: _ShellColors.slate400,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 18,
            color: _ShellColors.slate400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _ShellColors.slate50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _ShellColors.slate200, width: 0.5),
          ),
          child: Icon(
            Icons.notifications_outlined,
            size: 18,
            color: _ShellColors.slate600,
          ),
        ),
        if (count > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              constraints: const BoxConstraints(minWidth: 16),
              decoration: BoxDecoration(
                color: _ShellColors.red500,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.initials,
    required this.onTap,
  });

  final String initials;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _ShellColors.indigo600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Online dot
          Positioned(
            bottom: -1,
            right: -1,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _ShellColors.emerald500,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuOverlay extends StatelessWidget {
  const _ProfileMenuOverlay({
    required this.onDismiss,
    required this.onSignOut,
    required this.onProfile,
  });

  final VoidCallback onDismiss;
  final VoidCallback onSignOut;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: _kTopBarHeight + 4,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _ShellColors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MenuTile(
                    icon: Icons.person_outline_rounded,
                    label: 'Profile & Settings',
                    onTap: onProfile,
                  ),
                  Divider(color: _ShellColors.slate100, height: 1),
                  _MenuTile(
                    icon: Icons.logout_rounded,
                    label: 'Sign Out',
                    labelColor: _ShellColors.red500,
                    onTap: onSignOut,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final color = labelColor ?? _ShellColors.slate700;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SIDEBAR (LEFT PANE)
// ═══════════════════════════════════════════════════════════════════════════════

class _Sidebar extends ConsumerWidget {
  const _Sidebar({
    required this.currentPath,
    this.isCompact = false,
  });

  final String currentPath;
  final bool isCompact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complianceAsync = ref.watch(userComplianceProvider);
    final overdueCount = complianceAsync.valueOrNull?.overdueCount ?? 0;

    return Container(
      width: isCompact ? 64 : _kSidebarWidth,
      decoration: BoxDecoration(
        color: Colors.white, // Pure white (Dribbble style)
        border: Border(
          right: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          
          // Section label
          if (!isCompact)
            _SectionLabel('NAVIGATION'),
          
          // Nav Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  route: '/employee',
                  currentPath: currentPath,
                  isCompact: isCompact,
                  matchExact: true,
                ),
                _NavItem(
                  icon: Icons.school_outlined,
                  activeIcon: Icons.school_rounded,
                  label: 'My Training',
                  route: '/employee/lessons',
                  currentPath: currentPath,
                  isCompact: isCompact,
                  badge: overdueCount > 0 ? overdueCount : null,
                  badgeColor: _ShellColors.red500,
                ),
                _NavItem(
                  icon: Icons.menu_book_outlined,
                  activeIcon: Icons.menu_book_rounded,
                  label: 'Course Catalog',
                  route: '/employee/catalog',
                  currentPath: currentPath,
                  isCompact: isCompact,
                ),
                _NavItem(
                  icon: Icons.quiz_outlined,
                  activeIcon: Icons.quiz_rounded,
                  label: 'Assessments',
                  route: '/assessments',
                  currentPath: currentPath,
                  isCompact: isCompact,
                ),
                
                const SizedBox(height: 16),
                if (!isCompact) 
                  _SectionLabel('COMPLIANCE'),
                const SizedBox(height: 8),
                
                _NavItem(
                  icon: Icons.verified_outlined,
                  activeIcon: Icons.verified_rounded,
                  label: 'Credentials',
                  route: '/employee/credentials',
                  currentPath: currentPath,
                  isCompact: isCompact,
                ),
                _NavItem(
                  icon: Icons.history_outlined,
                  activeIcon: Icons.history_rounded,
                  label: 'Training History',
                  route: '/employee/training-history',
                  currentPath: currentPath,
                  isCompact: isCompact,
                ),
                _NavItem(
                  icon: Icons.grid_view_outlined,
                  activeIcon: Icons.grid_view_rounded,
                  label: 'Training Matrix',
                  route: '/employee/matrix',
                  currentPath: currentPath,
                  isCompact: isCompact,
                ),
              ],
            ),
          ),
          
          // Bottom: Profile
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black.withOpacity(0.05)),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: _NavItem(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
              route: '/employee/profile',
              currentPath: currentPath,
              isCompact: isCompact,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section label for sidebar grouping (Dribbble style)
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        label,
        style: TextStyle(
          color: _ShellColors.sectionLabel,
          letterSpacing: 1.2,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.currentPath,
    this.isCompact = false,
    this.badge,
    this.badgeColor,
    this.matchExact = false,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final String currentPath;
  final bool isCompact;
  final int? badge;
  final Color? badgeColor;
  final bool matchExact;

  bool get isActive {
    if (matchExact) {
      return currentPath == route || currentPath == '$route/dashboard';
    }
    return currentPath.startsWith(route);
  }

  @override
  Widget build(BuildContext context) {
    final tile = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(12), // Dribbble-style pill shape
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 12 : 16,
            vertical: 12, // More padding for breathing room
          ),
          decoration: BoxDecoration(
            // Pill shape with subtle gray active state
            color: isActive ? _ShellColors.navActiveBg : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: isCompact 
                ? MainAxisAlignment.center 
                : MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isActive ? activeIcon : icon,
                    size: 20,
                    // Dark for active, light gray for inactive
                    color: isActive
                        ? _ShellColors.navActiveText
                        : _ShellColors.navInactiveIcon,
                  ),
                  if (badge != null && isCompact)
                    Positioned(
                      top: -6,
                      right: -8,
                      child: _Badge(count: badge!, color: badgeColor),
                    ),
                ],
              ),
              if (!isCompact) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive
                          ? _ShellColors.navActiveText
                          : _ShellColors.navInactiveText,
                    ),
                  ),
                ),
                if (badge != null)
                  _Badge(count: badge!, color: badgeColor),
              ],
            ],
          ),
        ),
      ),
    );

    if (isCompact) {
      return Tooltip(
        message: label,
        preferBelow: false,
        child: tile,
      );
    }
    return tile;
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count, this.color});

  final int count;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      constraints: const BoxConstraints(minWidth: 18),
      decoration: BoxDecoration(
        color: color ?? _ShellColors.red500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CONTEXT PANEL (RIGHT PANE)
// ═══════════════════════════════════════════════════════════════════════════════

class _ContextPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: _kContextPanelWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: _ShellColors.slate200, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Summary
            _ProfileSummaryCard(),
            
            const SizedBox(height: 20),
            
            // Compliance Donut
            _ComplianceDonutCard(),
            
            const SizedBox(height: 20),
            
            // Up Next / Urgent
            _UpNextCard(),
          ],
        ),
      ),
    );
  }
}

class _ProfileSummaryCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    
    return userAsync.when(
      data: (user) {
        if (user == null) return const SizedBox.shrink();
        
        final initials = _getInitials(user.email);
        final name = '${user.firstName} ${user.lastName}';
        final role = user.jobRole?.name ?? 'Employee';
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _ShellColors.indigo600,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _ShellColors.slate800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 12,
                        color: _ShellColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => _SkeletonCard(height: 80),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  String _getInitials(String? email) {
    if (email == null || email.isEmpty) return 'U';
    final parts = email.split('@').first.split('.');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return email[0].toUpperCase();
  }
}

class _ComplianceDonutCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complianceAsync = ref.watch(userComplianceProvider);
    
    return complianceAsync.when(
      data: (compliance) {
        if (compliance == null) return const SizedBox.shrink();
        
        final rate = compliance.complianceRate;
        final color = rate >= 80 
            ? _ShellColors.emerald500 
            : rate >= 60 
                ? _ShellColors.amber500 
                : _ShellColors.red500;
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Compliance Rate',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _ShellColors.slate500,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 120,
                height: 80,
                child: CustomPaint(
                  painter: _SemiCircleDonutPainter(
                    progress: rate / 100,
                    color: color,
                    backgroundColor: _ShellColors.slate100,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        '${rate.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _MiniStat(
                    label: 'Overdue',
                    value: '${compliance.overdueCount}',
                    color: _ShellColors.red500,
                  ),
                  _MiniStat(
                    label: 'Upcoming',
                    value: '${compliance.upcomingCount}',
                    color: _ShellColors.amber500,
                  ),
                  _MiniStat(
                    label: 'Certs',
                    value: '${compliance.totalCertificates}',
                    color: _ShellColors.emerald500,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => _SkeletonCard(height: 200),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: _ShellColors.slate400,
          ),
        ),
      ],
    );
  }
}

class _SemiCircleDonutPainter extends CustomPainter {
  _SemiCircleDonutPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  final double progress;
  final Color color;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background arc (180 degrees = PI)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, // Start from left
      math.pi, // Sweep 180 degrees
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, // Start from left
      math.pi * progress, // Sweep based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SemiCircleDonutPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _UpNextCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final assignmentsAsync = ref.watch(assignmentsProvider);
    final userAsync = ref.watch(currentUserProvider);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.priority_high_rounded,
                size: 16,
                color: _ShellColors.red500,
              ),
              const SizedBox(width: 6),
              Text(
                'Up Next',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _ShellColors.slate700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Urgent items list
          enrollmentsAsync.when(
            data: (enrollments) {
              final user = userAsync.valueOrNull;
              final assignments = assignmentsAsync.valueOrNull ?? [];
              
              if (user?.id == null) {
                return _EmptyUpNext();
              }
              
              final now = DateTime.now();
              final urgent = enrollments.where((e) {
                if (e.status == 'completed') return false;
                final assignment = assignments
                    .where((a) => a.courseVersionId == e.courseVersionId && a.userId == user!.id)
                    .firstOrNull;
                if (assignment?.dueDate == null) return false;
                final daysUntilDue = assignment!.dueDate.difference(now).inDays;
                return daysUntilDue <= 7; // Due within 7 days or overdue
              }).take(3).toList();
              
              if (urgent.isEmpty) {
                return _EmptyUpNext();
              }
              
              return Column(
                children: urgent.map((e) {
                  final assignment = assignments
                      .where((a) => a.courseVersionId == e.courseVersionId && a.userId == user!.id)
                      .firstOrNull;
                  final daysOverdue = assignment?.dueDate != null
                      ? now.difference(assignment!.dueDate).inDays
                      : 0;
                  
                  // Get course title from courseVersion relation or fallback
                  final courseTitle = e.courseVersion?.course?.title ?? 
                      e.courseVersion?.version ?? 
                      'Untitled Course';
                  
                  // Calculate progress based on status
                  final progress = e.status == 'completed' 
                      ? 100.0 
                      : e.status == 'in_progress' 
                          ? 50.0 
                          : 0.0;
                  
                  return _UpNextItem(
                    title: courseTitle,
                    daysOverdue: daysOverdue,
                    progress: progress,
                    onTap: () => context.go('/employee/lessons'),
                  );
                }).toList(),
              );
            },
            loading: () => Column(
              children: List.generate(2, (_) => _SkeletonItem()),
            ),
            error: (_, __) => _EmptyUpNext(),
          ),
        ],
      ),
    );
  }
}

class _UpNextItem extends StatelessWidget {
  const _UpNextItem({
    required this.title,
    required this.daysOverdue,
    required this.progress,
    required this.onTap,
  });

  final String title;
  final int daysOverdue;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isOverdue = daysOverdue > 0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isOverdue 
                ? const Color(0xFFFEF2F2) 
                : _ShellColors.slate50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isOverdue 
                  ? const Color(0xFFFECACA) 
                  : _ShellColors.slate200,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isOverdue 
                      ? _ShellColors.red500 
                      : _ShellColors.slate700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                isOverdue 
                    ? '$daysOverdue day${daysOverdue == 1 ? '' : 's'} overdue'
                    : 'Due in ${-daysOverdue} day${daysOverdue == -1 ? '' : 's'}',
                style: TextStyle(
                  fontSize: 10,
                  color: isOverdue 
                      ? const Color(0xFFDC2626) 
                      : _ShellColors.slate500,
                ),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: _ShellColors.slate200,
                valueColor: AlwaysStoppedAnimation(
                  isOverdue ? _ShellColors.red500 : _ShellColors.indigo500,
                ),
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyUpNext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _ShellColors.slate50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 20,
            color: _ShellColors.emerald500,
          ),
          const SizedBox(width: 10),
          Text(
            'All caught up!',
            style: TextStyle(
              fontSize: 12,
              color: _ShellColors.slate500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: _ShellColors.slate100,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: _ShellColors.slate100,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOBILE DRAWER
// ═══════════════════════════════════════════════════════════════════════════════

class _MobileDrawer extends ConsumerWidget {
  const _MobileDrawer({this.currentPath});

  final String? currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: _Sidebar(
        currentPath: currentPath ?? '',
        isCompact: false,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOBILE BOTTOM NAV
// ═══════════════════════════════════════════════════════════════════════════════

class _MobileBottomNav extends ConsumerWidget {
  const _MobileBottomNav({required this.currentPath});

  final String currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complianceAsync = ref.watch(userComplianceProvider);
    final overdueCount = complianceAsync.valueOrNull?.overdueCount ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: _ShellColors.slate200, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
                isActive: currentPath == '/employee' || 
                          currentPath == '/employee/dashboard',
                onTap: () => context.go('/employee'),
              ),
              _BottomNavItem(
                icon: Icons.school_outlined,
                activeIcon: Icons.school_rounded,
                label: 'Training',
                isActive: currentPath.startsWith('/employee/lessons'),
                badge: overdueCount > 0 ? overdueCount : null,
                onTap: () => context.go('/employee/lessons'),
              ),
              _BottomNavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book_rounded,
                label: 'Catalog',
                isActive: currentPath.startsWith('/employee/catalog'),
                onTap: () => context.go('/employee/catalog'),
              ),
              _BottomNavItem(
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: 'Profile',
                isActive: currentPath == '/employee/profile',
                onTap: () => context.go('/employee/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  size: 24,
                  color: isActive 
                      ? _ShellColors.indigo600 
                      : _ShellColors.slate400,
                ),
                if (badge != null)
                  Positioned(
                    top: -6,
                    right: -8,
                    child: _Badge(count: badge!),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive 
                    ? _ShellColors.indigo600 
                    : _ShellColors.slate400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// REUSABLE CONTEXT PANEL WIDGET (for external use)
// ═══════════════════════════════════════════════════════════════════════════════

/// Standalone context panel widget that can be used in other layouts
class EmployeeContextPanel extends ConsumerWidget {
  const EmployeeContextPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ContextPanel();
  }
}
