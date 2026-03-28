import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../design_system/pharma_components.dart';
import '../design_system/pharma_design_system.dart';

/// AdminShellV2 - The main layout shell for the admin portal
/// 
/// Features:
/// - Persistent sidebar with navigation
/// - Header with search, notifications, and user menu
/// - Responsive design (desktop/tablet/mobile)
/// 
/// Usage:
/// ```
/// ShellRoute(
///   builder: (context, state, child) => AdminShellV2(child: child, currentPath: state.uri.path),
///   routes: [...]
/// )
/// ```
class AdminShellV2 extends StatelessWidget {
  const AdminShellV2({
    super.key,
    required this.child,
    required this.currentPath,
  });

  final Widget child;
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < PortalLayout.breakpointTablet;

    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      appBar: isMobile ? _buildMobileAppBar(context) : null,
      drawer: isMobile ? _buildMobileDrawer(context, currentPath) : null,
      body: isMobile
          ? Padding(
              padding: const EdgeInsets.all(PortalLayout.contentPadding),
              child: child,
            )
          : Row(
              children: [
                _AdminSidebar(currentPath: currentPath),
                Expanded(
                  child: Column(
                    children: [
                      _AdminTopbar(currentPath: currentPath),
                      Expanded(
                        child: ColoredBox(
                          color: PharmaColors.pageBg,
                          child: child,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Admin Portal',
        style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: PharmaColors.cardBg,
      foregroundColor: PharmaColors.textPrimary,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          color: PharmaColors.textSecondary,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMobileDrawer(BuildContext context, String currentPath) {
    return SafeArea(
      child: Drawer(
        backgroundColor: PharmaColors.cardBg,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: PharmaColors.pageBg,
                border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    PharmaBrand.name,
                    style: PharmaTypography.headingMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text(
                    'Admin Portal',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.emerald600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, 'Dashboard', Icons.dashboard_outlined, '/admin', currentPath),
            _buildDrawerItem(context, 'Users', Icons.people_outlined, '/admin/users/directory', currentPath),
            _buildDrawerItem(context, 'Courses', Icons.school_outlined, '/admin/courses/catalogue', currentPath),
            _buildDrawerItem(context, 'Enrollments', Icons.assignment_outlined, '/admin/enrollments/list', currentPath),
            _buildDrawerItem(context, 'Compliance', Icons.check_circle_outline, '/admin/reports/compliance', currentPath),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(
    BuildContext context,
    String label,
    IconData icon,
    String route,
    String currentPath,
  ) {
    final isActive = currentPath.startsWith(route);
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
      selected: isActive,
      selectedTileColor: PharmaColors.emerald50,
      leading: Icon(icon, color: isActive ? PharmaColors.emerald700 : PharmaColors.textSecondary, size: 22),
      title: Text(
        label,
        style: PharmaTypography.bodyMedium.copyWith(
          color: isActive ? PharmaColors.emerald700 : PharmaColors.textPrimary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        context.push(route);
      },
    );
  }
}

class _AdminTopbar extends StatelessWidget {
  const _AdminTopbar({required this.currentPath});
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final segments = currentPath.split('/').where((s) => s.isNotEmpty).toList();
    final title = segments.isEmpty ? 'Dashboard' : segments.map((s) {
      final t = s.replaceAll('-', ' ');
      return t.isEmpty ? t : '${t[0].toUpperCase()}${t.substring(1)}';
    }).join(' · ');
    return Container(
      height: PortalLayout.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: PharmaTypography.headingSmall.copyWith(
                color: PharmaColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const PharmaSearchBar(hint: 'Search users, courses, reports…'),
              ),
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
          const PharmaExportButton(),
        ],
      ),
    );
  }
}

class _AdminSidebar extends StatelessWidget {
  const _AdminSidebar({required this.currentPath});
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    // Sidebar sections and items
    final sidebarSections = [
      {
        'label': 'Overview',
        'items': [
          {'label': 'Dashboard', 'icon': Icons.dashboard_outlined, 'route': '/admin'},
        ],
      },
      {
        'label': 'People & Identity',
        'items': [
          {'label': 'User Directory', 'icon': Icons.people_outline, 'route': '/admin/users/directory'},
          {'label': 'Access Review', 'icon': Icons.verified_user_outlined, 'route': '/admin/users/access-review'},
        ],
      },
      {
        'label': 'Training Content',
        'items': [
          {'label': 'Courses', 'icon': Icons.school_outlined, 'route': '/admin/courses/catalogue'},
        ],
      },
      {
        'label': 'Enrollments & Batches',
        'items': [
          {'label': 'Enrollments', 'icon': Icons.assignment_outlined, 'route': '/admin/enrollments/list'},
          {'label': 'Batches', 'icon': Icons.group_work_outlined, 'route': '/admin/batches/list'},
        ],
      },
      {
        'label': 'Specs & Assessments',
        'items': [
          {'label': 'Job Specs', 'icon': Icons.badge_outlined, 'route': '/admin/job-specs/list'},
          {'label': 'Assessments', 'icon': Icons.fact_check_outlined, 'route': '/admin/assessments/list'},
        ],
      },
      {
        'label': 'Certs & Docs',
        'items': [
          {'label': 'Certificates', 'icon': Icons.verified_outlined, 'route': '/admin/certificates/list'},
          {'label': 'Documents', 'icon': Icons.description_outlined, 'route': '/admin/documents/library'},
        ],
      },
      {
        'label': 'Compliance & Audit',
        'items': [
          {'label': 'Compliance', 'icon': Icons.check_circle_outline, 'route': '/admin/reports/compliance'},
          {'label': 'Audit Trail', 'icon': Icons.track_changes_outlined, 'route': '/admin/audit/trail'},
        ],
      },
      {
        'label': 'Communications',
        'items': [
          {'label': 'Notifications', 'icon': Icons.notifications_outlined, 'route': '/admin/notifications/templates'},
        ],
      },
      {
        'label': 'Analytics',
        'items': [
          {'label': 'Analytics', 'icon': Icons.bar_chart_outlined, 'route': '/admin/analytics/dashboard'},
        ],
      },
      {
        'label': 'System',
        'items': [
          {'label': 'System Settings', 'icon': Icons.settings_outlined, 'route': '/admin/system/settings'},
        ],
      },
      {
        'label': 'Profile',
        'items': [
          {'label': 'Profile', 'icon': Icons.account_circle_outlined, 'route': '/admin/profile'},
        ],
      },
    ];

    return Container(
      width: PortalLayout.sidebarWidth,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(right: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: Row(
              children: [
                const VyuhLogo(height: 32, width: 32, color: PharmaColors.emerald600),
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
                        'Admin Portal',
                        style: PharmaTypography.caption.copyWith(
                          color: PharmaColors.emerald600,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.sm, horizontal: PharmaSpacing.md),
              itemCount: sidebarSections.length,
              separatorBuilder: (context, idx) => const SizedBox(height: 8),
              itemBuilder: (context, sectionIdx) {
                final section = sidebarSections[sectionIdx];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: PharmaSpacing.sm, bottom: PharmaSpacing.xs, top: PharmaSpacing.xs),
                      child: Text(
                        (section['label'] as String).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: PharmaColors.textQuaternary,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    ...((section['items'] as List).map((item) {
                      final itemMap = item as Map;
                      final selected = currentPath == itemMap['route'] || currentPath.startsWith(itemMap['route']);
                      return ListTile(
                        leading: Icon(
                          itemMap['icon'] as IconData,
                          color: selected ? PharmaColors.emerald700 : PharmaColors.textSecondary,
                          size: 20,
                        ),
                        title: Text(
                          itemMap['label'] as String,
                          style: selected
                              ? PharmaTypography.navItemActive.copyWith(color: PharmaColors.emerald700)
                              : PharmaTypography.navItem,
                        ),
                        selected: selected,
                        selectedTileColor: PharmaColors.emerald50,
                        shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
                        onTap: () => context.go(itemMap['route'] as String),
                        contentPadding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: PharmaSpacing.xs),
                        dense: true,
                        minLeadingWidth: 28,
                      );
                    })),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


