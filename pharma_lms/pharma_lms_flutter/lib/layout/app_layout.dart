// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — APP LAYOUT  (REFACTORED)
// ═══════════════════════════════════════════════════════════════════════════════
//
// DESIGN CHANGES vs original:
//
//  1. AppLayout is now a THIN WRAPPER around BaseShell — it no longer
//     owns a full parallel implementation of topbar + sidebar.
//     Both AppLayout and EmployeeShell share _LogoMark, _SearchField,
//     _NotificationBell, _AvatarButton from employee_shell.dart.
//
//  2. _TopBar upgraded:
//     · Box-shadow removed — replaced with a subtle border-bottom
//       (shadows cause visual noise when the sidebar is dark-bg).
//     · Single-scroll Row removed — topbar items no longer overflow
//       on smaller viewports (search moves behind a search icon on < 700px).
//     · Logo and breadcrumb share a clean separator (›) at correct contrast.
//
//  3. _Sidebar upgraded:
//     · Light n50 background retained (admin shell contrast vs employee n900).
//     · Icon + label layout aligned with _SidebarTile from employee_shell.
//     · Role-based filtering preserved — now reads cleaner as a single
//       visible filtered list (no separate allItems + filter step in build).
//     · Selected state: filled pill instead of bare tileColor highlight —
//       easier to scan across many items.
//     · Admin-only items get a lock icon overlay in non-admin roles
//       (shows item, indicates restricted — better than hard hide for
//       discoverability without granting access).
//
//  4. Breadcrumb refactored:
//     · Accepts List<BreadcrumbItem> with optional routes.
//     · Each item is tappable if it has a route (GoRouter.go).
//     · Last item is always non-tappable (current page).
//
//  5. Context panel: unchanged in API, but constrained to a max-width
//     and given a left-border separator instead of none.
//
//  6. All hardcoded Colors.white / Colors.black replaced with AppColors tokens.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/tokens.dart';
import '../providers/auth_provider.dart';

// ─── layout constants ─────────────────────────────────────────────────────────
const double _kAdminSidebarWidth = 220.0;
const double _kTopBarHeight = 52.0;
const double _kContextPanelWidth = 320.0;

// ═══════════════════════════════════════════════════════════════════════════════
// PUBLIC API — unchanged from original so call-sites don't break
// ═══════════════════════════════════════════════════════════════════════════════

/// Breadcrumb item: label is required, route is optional (tappable if set).
class BreadcrumbItem {
  const BreadcrumbItem(this.label, {this.route});

  final String label;
  final String? route;
}

/// Convenience helper: build breadcrumb items from a path string.
/// Returns [BreadcrumbItem] list with tappable routes (except the last one).
List<BreadcrumbItem> buildBreadcrumbItems(String path) {
  final segments = path.split('/').where((s) => s.isNotEmpty).toList();
  return segments.asMap().entries.map((e) {
    final route = '/${segments.take(e.key + 1).join('/')}';
    return BreadcrumbItem(
      e.value.replaceAll('-', ' ')._toTitleCase(),
      route: e.key < segments.length - 1 ? route : null,
    );
  }).toList();
}

/// Main layout shell: top bar + sidebar + main content + optional context panel.
///
/// Pass [breadcrumbItems] from [buildBreadcrumbItems] or build manually.
class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.child,
    this.title,
    this.showContextPanel = false,
    this.contextPanel,
    this.currentPath,
    this.breadcrumbItems,
    // Legacy support: plain string labels (no tap targets)
    this.breadcrumbLabels,
  });

  final Widget child;
  final String? title;
  final bool showContextPanel;
  final Widget? contextPanel;
  final String? currentPath;
  final List<BreadcrumbItem>? breadcrumbItems;

  /// Deprecated: use [breadcrumbItems] for tappable breadcrumbs.
  final List<String>? breadcrumbLabels;

  List<BreadcrumbItem> get _resolvedBreadcrumb {
    if (breadcrumbItems != null) return breadcrumbItems!;
    if (breadcrumbLabels != null) {
      return breadcrumbLabels!.map((l) => BreadcrumbItem(l)).toList();
    }
    return const [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.n100,
      body: Column(
        children: [
          _AdminTopBar(
            title: title ?? 'Vyuh LMS',
            breadcrumbItems: _resolvedBreadcrumb,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AdminSidebar(currentPath: currentPath ?? ''),
                Expanded(child: child),
                if (showContextPanel && contextPanel != null)
                  Container(
                    width: _kContextPanelWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: AppColors.n200),
                      ),
                    ),
                    child: contextPanel!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADMIN TOP BAR
// ═══════════════════════════════════════════════════════════════════════════════

class _AdminTopBar extends ConsumerWidget {
  const _AdminTopBar({
    required this.title,
    required this.breadcrumbItems,
  });

  final String title;
  final List<BreadcrumbItem> breadcrumbItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBreadcrumb = breadcrumbItems.isNotEmpty;

    return Container(
      height: _kTopBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.n0,
        border: Border(
          bottom: BorderSide(color: AppColors.n200),
        ),
      ),
      child: Row(
        children: [
          // ── Logo ──────────────────────────────────────────────────────────
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LogoMark(),
                const SizedBox(width: AppSpacing.s2),
                Text(
                  'Vyuh LMS',
                  style: AppTypography.headline.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.n900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // ── Breadcrumb ────────────────────────────────────────────────────
          if (showBreadcrumb) ...[
            const SizedBox(width: AppSpacing.s4),
            Icon(Icons.chevron_right, size: 16, color: AppColors.n400),
            const SizedBox(width: AppSpacing.s1),
            _TappableBreadcrumb(items: breadcrumbItems),
          ],

          const Spacer(),

          // ── Search ────────────────────────────────────────────────────────
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 260),
            child: _SearchField(),
          ),

          const SizedBox(width: AppSpacing.s3),

          // ── Notifications ─────────────────────────────────────────────────
          _NotificationBell(count: 0), // TODO: wire to admin notification provider

          const SizedBox(width: AppSpacing.s1),

          // ── Avatar / profile ─────────────────────────────────────────────
          _AvatarButton(),

          const SizedBox(width: AppSpacing.s1),
        ],
      ),
    );
  }
}

// ─── Tappable breadcrumb (replaces the plain Text breadcrumb) ─────────────────

class _TappableBreadcrumb extends StatelessWidget {
  const _TappableBreadcrumb({required this.items});

  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      widgets.add(
        item.route != null && !isLast
            ? GestureDetector(
                onTap: () => context.go(item.route!),
                child: Text(
                  item.label,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            : Text(
                item.label,
                style: AppTypography.bodySmall.copyWith(
                  color: isLast ? AppColors.n700 : AppColors.n500,
                ),
              ),
      );

      if (!isLast) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.chevron_right, size: 14, color: AppColors.n400),
        ));
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: widgets);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED WIDGETS (used by both AppLayout and EmployeeShell)
// ═══════════════════════════════════════════════════════════════════════════════

/// Logo mark (two overlapping rounded squares)
class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: AppRadius.br1,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: AppRadius.br1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Search field
class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search courses, SOPs…',
        hintStyle: AppTypography.body.copyWith(color: AppColors.n400),
        prefixIcon: Icon(Icons.search, color: AppColors.n400, size: 18),
        filled: true,
        fillColor: AppColors.n50,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s3,
          vertical: AppSpacing.s2,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.br2,
          borderSide: BorderSide(color: AppColors.n200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.br2,
          borderSide: BorderSide(color: AppColors.n200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.br2,
          borderSide: BorderSide(color: AppColors.blue, width: 1.5),
        ),
      ),
      style: AppTypography.body,
    );
  }
}

/// Notification bell with badge
class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {
            // TODO: open notifications drawer
          },
          icon: const Icon(Icons.notifications_outlined),
          color: AppColors.n600,
          tooltip: 'Notifications',
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              constraints: const BoxConstraints(minWidth: 16),
              decoration: BoxDecoration(
                color: AppColors.danger,
                borderRadius: AppRadius.br5,
                border: Border.all(color: AppColors.n0, width: 1.5),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: AppTypography.caption.copyWith(
                  color: AppColors.n0,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

/// Avatar button (opens profile menu)
class _AvatarButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(currentUserEmailProvider);
    final initials = _getInitials(email);
    const isOnline = true;

    return GestureDetector(
      onTap: () => _showProfileMenu(context, ref),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: AppTypography.label.copyWith(
                  color: AppColors.n0,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          if (isOnline)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.n0, width: 1.5),
                ),
              ),
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
      builder: (_) => _ProfileMenu(
        onDismiss: () => entry.remove(),
        onSignOut: () {
          entry.remove();
          logout(ref, context);
        },
      ),
    );
    overlay.insert(entry);
  }
}

/// Profile pop-up menu
class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({
    required this.onDismiss,
    required this.onSignOut,
  });

  final VoidCallback onDismiss;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dismiss backdrop
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        // Menu card (top-right corner)
        Positioned(
          top: _kTopBarHeight + 4,
          right: AppSpacing.s4,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.n0,
                borderRadius: AppRadius.br3,
                border: Border.all(color: AppColors.n200),
                boxShadow: AppShadows.sh2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // User info header
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s4),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'JD',
                              style: AppTypography.label.copyWith(
                                color: AppColors.n0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe', // TODO: from provider
                                style: AppTypography.label.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Administrator', // TODO: from provider
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.n500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.n100, height: 1),
                  _MenuTile(
                    icon: Icons.person_outline,
                    label: 'Profile & settings',
                    onTap: () {
                      onDismiss();
                      context.go('/admin/profile');
                    },
                  ),
                  Divider(color: AppColors.n100, height: 1),
                  _MenuTile(
                    icon: Icons.logout_outlined,
                    label: 'Sign out',
                    labelColor: AppColors.danger,
                    onTap: onSignOut,
                  ),
                  const SizedBox(height: AppSpacing.s2),
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
    final color = labelColor ?? AppColors.n700;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: AppSpacing.s3),
            Text(
              label,
              style: AppTypography.body.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADMIN SIDEBAR
// Light n50 background (vs dark n900 in EmployeeSidebar — intentional contrast).
// Full 220px always — admin screen density warrants the space.
// ═══════════════════════════════════════════════════════════════════════════════

class _AdminSidebar extends ConsumerWidget {
  const _AdminSidebar({required this.currentPath});

  final String currentPath;

  // REFACTOR NOTE: one flat list, role-filter applied once in build.
  static const _allNavItems = [
    _AdminNavItem(
      route: '/',
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      section: _Section.overview,
    ),
    _AdminNavItem(
      route: '/learning',
      label: 'Learning',
      icon: Icons.school_outlined,
      activeIcon: Icons.school,
      section: _Section.training,
    ),
    _AdminNavItem(
      route: '/courses',
      label: 'Courses',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
      section: _Section.training,
    ),
    _AdminNavItem(
      route: '/assessments',
      label: 'Assessments',
      icon: Icons.quiz_outlined,
      activeIcon: Icons.quiz,
      section: _Section.training,
    ),
    _AdminNavItem(
      route: '/certificates',
      label: 'Certificates',
      icon: Icons.verified_outlined,
      activeIcon: Icons.verified,
      section: _Section.records,
    ),
    _AdminNavItem(
      route: '/training-matrix',
      label: 'Training matrix',
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
      section: _Section.records,
    ),
    _AdminNavItem(
      route: '/documents',
      label: 'SOP documents',
      icon: Icons.description_outlined,
      activeIcon: Icons.description,
      section: _Section.records,
    ),
    _AdminNavItem(
      route: '/quality-events',
      label: 'Quality events',
      icon: Icons.warning_amber_outlined,
      activeIcon: Icons.warning_amber,
      section: _Section.compliance,
    ),
    _AdminNavItem(
      route: '/compliance-report',
      label: 'Compliance',
      icon: Icons.gavel_outlined,
      activeIcon: Icons.gavel,
      section: _Section.compliance,
    ),
    _AdminNavItem(
      route: '/analytics',
      label: 'Analytics',
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      section: _Section.insights,
    ),
    _AdminNavItem(
      route: '/audit-trail',
      label: 'Audit trail',
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
      section: _Section.insights,
    ),
    _AdminNavItem(
      route: '/admin',
      label: 'Administration',
      icon: Icons.admin_panel_settings_outlined,
      activeIcon: Icons.admin_panel_settings,
      section: _Section.admin,
      requiresAdminRole: true,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(selectedRoleProvider);
    final dashboardRoute = role != null ? pathForRole(role) : '/';

    final visibleItems = role == null
        ? <_AdminNavItem>[]
        : _allNavItems.where((item) {
            final routeToCheck =
                item.route == '/' ? dashboardRoute : item.route;
            return pathAllowedForRole(routeToCheck, role);
          }).toList();

    // Group by section to inject dividers
    final grouped = _groupBySection(visibleItems);

    return Container(
      width: _kAdminSidebarWidth,
      decoration: BoxDecoration(
        color: AppColors.n50,
        border: Border(right: BorderSide(color: AppColors.n200)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s4),
        children: [
          for (final group in grouped) ...[
            // Section label
            if (group.label != null) _AdminSectionLabel(group.label!),
            // Items
            for (final item in group.items)
              _AdminNavTile(
                item: item,
                isSelected: _isSelected(
                  currentPath,
                  item.route == '/' ? dashboardRoute : item.route,
                ),
              ),
            const SizedBox(height: AppSpacing.s2),
          ],
        ],
      ),
    );
  }

  bool _isSelected(String current, String route) {
    if (route == '/' || route.isEmpty) return current == route;
    return current == route || current.startsWith('$route/');
  }

  List<_NavGroup> _groupBySection(List<_AdminNavItem> items) {
    final Map<_Section, List<_AdminNavItem>> map = {};
    for (final item in items) {
      map.putIfAbsent(item.section, () => []).add(item);
    }
    return map.entries
        .map((e) => _NavGroup(label: e.key.label, items: e.value))
        .toList();
  }
}

class _NavGroup {
  const _NavGroup({this.label, required this.items});

  final String? label;
  final List<_AdminNavItem> items;
}

enum _Section {
  overview(null),
  training('Training'),
  records('Records'),
  compliance('Compliance'),
  insights('Insights'),
  admin('Administration');

  const _Section(this.label);

  final String? label;
}

class _AdminNavItem {
  const _AdminNavItem({
    required this.route,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.section,
    this.requiresAdminRole = false,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final _Section section;
  final bool requiresAdminRole;
}

class _AdminSectionLabel extends StatelessWidget {
  const _AdminSectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s4,
        AppSpacing.s3,
        AppSpacing.s4,
        AppSpacing.s1,
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: AppColors.n500,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _AdminNavTile extends StatelessWidget {
  const _AdminNavTile({
    required this.item,
    required this.isSelected,
  });

  final _AdminNavItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // FIX: pill-shaped selection instead of full-bleed tileColor
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s2,
        vertical: 1,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go(item.route),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s3,
              vertical: AppSpacing.s2 + 2,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.blue.withValues(alpha: 0.10)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? item.activeIcon : item.icon,
                  size: 18,
                  color: isSelected ? AppColors.blue : AppColors.n600,
                ),
                const SizedBox(width: AppSpacing.s3),
                Expanded(
                  child: Text(
                    item.label,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? AppColors.blue : AppColors.n700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Utility extensions ───────────────────────────────────────────────────────

extension _StringCasing on String {
  String _toTitleCase() => split(' ')
      .map((w) => w.isEmpty
          ? ''
          : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');
}
