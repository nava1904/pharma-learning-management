import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/colors.dart';
import '../design_system/spacing.dart';
import '../providers/auth_provider.dart';
import '../widgets/breadcrumb.dart';

/// Main layout shell: top bar, sidebar, main content, optional context panel.
class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.child,
    this.title,
    this.showContextPanel = false,
    this.contextPanel,
    this.currentPath,
    this.breadcrumbItems,
  });

  final Widget child;
  final String? title;
  final bool showContextPanel;
  final Widget? contextPanel;
  final String? currentPath;
  /// Breadcrumb labels for top bar (e.g. from [breadcrumbFromPath]).
  final List<String>? breadcrumbItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _TopBar(
            title: title ?? 'Pharma LMS',
            breadcrumbItems: breadcrumbItems,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Sidebar(currentPath: currentPath ?? ''),
                Expanded(child: child),
                if (showContextPanel && contextPanel != null)
                  SizedBox(
                    width: DesignSpacing.contextPanelWidth,
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

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, this.breadcrumbItems});

  final String title;
  final List<String>? breadcrumbItems;

  @override
  Widget build(BuildContext context) {
    final showBreadcrumb =
        breadcrumbItems != null && breadcrumbItems!.isNotEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 56,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.science,
                            color: DesignColors.primary, size: 28),
                        const SizedBox(width: DesignSpacing.sm),
                        Text(
                          'Pharma LMS',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: DesignColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (showBreadcrumb) ...[
                    const SizedBox(width: DesignSpacing.lg),
                    Icon(Icons.chevron_right,
                        size: 20, color: DesignColors.neutral400),
                    const SizedBox(width: DesignSpacing.sm),
                    Breadcrumb(items: breadcrumbItems!),
                  ],
                  const SizedBox(width: DesignSpacing.lg),
                  // Search
                  SizedBox(
                    width: 240,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: DesignSpacing.md,
                          vertical: DesignSpacing.sm,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: DesignSpacing.md),
                  // Notifications
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                  const SizedBox(width: DesignSpacing.xs),
                  // Profile
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () {},
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

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.currentPath});

  final String currentPath;

  static const _navItems = [
    _NavItem(route: '/', label: 'Dashboard', icon: Icons.dashboard_outlined),
    _NavItem(route: '/learning', label: 'Learning', icon: Icons.school_outlined),
    _NavItem(route: '/courses', label: 'Courses', icon: Icons.menu_book_outlined),
    _NavItem(route: '/assessments', label: 'Assessments', icon: Icons.quiz_outlined),
    _NavItem(route: '/certificates', label: 'Certificates', icon: Icons.verified_outlined),
    _NavItem(route: '/training-matrix', label: 'Training Matrix', icon: Icons.grid_view_outlined),
    _NavItem(route: '/documents', label: 'SOP Documents', icon: Icons.description_outlined),
    _NavItem(route: '/quality-events', label: 'Quality Events', icon: Icons.warning_amber_outlined),
    _NavItem(route: '/compliance-report', label: 'Compliance', icon: Icons.gavel_outlined),
    _NavItem(route: '/analytics', label: 'Analytics', icon: Icons.analytics_outlined),
    _NavItem(route: '/audit-trail', label: 'Audit Trail', icon: Icons.history_outlined),
    _NavItem(route: '/admin', label: 'Administration', icon: Icons.admin_panel_settings_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(selectedRoleProvider);
    final dashboardRoute = role != null ? pathForRole(role) : '/';

    // Filter nav items by role: only show items the user has permission to access
    final visibleItems = role == null
        ? <_NavItem>[]
        : _navItems.where((item) {
            final pathToCheck = item.route == '/' ? dashboardRoute : item.route;
            return pathAllowedForRole(pathToCheck, role);
          }).toList();

    return Container(
      width: DesignSpacing.sidebarWidth,
      decoration: BoxDecoration(
        color: DesignColors.neutral50,
        border: Border(
          right: BorderSide(color: DesignColors.neutral200),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: DesignSpacing.md),
        children: visibleItems
            .map((item) {
              final route = item.route == '/' ? dashboardRoute : item.route;
              return _NavTile(
                item: _NavItem(route: route, label: item.label, icon: item.icon),
                isSelected: currentPath.startsWith(route) &&
                    (route == '/' || currentPath == route || currentPath.startsWith('$route/')),
              );
            })
            .toList(),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.route, required this.label, required this.icon});

  final String route;
  final String label;
  final IconData icon;
}

class _NavTile extends StatelessWidget {
  const _NavTile({required this.item, required this.isSelected});

  final _NavItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        item.icon,
        size: 20,
        color: isSelected ? DesignColors.primary : DesignColors.neutral600,
      ),
      title: Text(
        item.label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? DesignColors.primary : DesignColors.neutral700,
        ),
      ),
      selected: isSelected,
      selectedTileColor: DesignColors.primary.withValues(alpha: 0.1),
      onTap: () => context.go(item.route),
    );
  }
}
