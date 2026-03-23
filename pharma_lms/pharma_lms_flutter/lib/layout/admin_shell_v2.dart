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
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      appBar: isMobile ? _buildMobileAppBar(context) : null,
      drawer: isMobile ? _buildMobileDrawer(context, currentPath) : null,
      body: isMobile
          ? Padding(
              padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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
                            child: Padding(
                              padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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
      title: const Text('Admin Portal'),
      elevation: 0,
      backgroundColor: PharmaColors.cardBg,
      foregroundColor: PharmaColors.textPrimary,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
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
              decoration: BoxDecoration(color: PharmaColors.pageBg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Pharma LMS',
                    style: PharmaTypography.headingMedium,
                  ),
                  Text(
                    'Admin Portal',
                    style: PharmaTypography.caption,
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, 'Dashboard', Icons.dashboard_outlined, '/admin', currentPath),
            _buildDrawerItem(context, 'Users', Icons.people_outlined, '/admin/users', currentPath),
            _buildDrawerItem(context, 'Courses', Icons.school_outlined, '/admin/courses', currentPath),
            _buildDrawerItem(context, 'Enrollments', Icons.assignment_outlined, '/admin/enrollments', currentPath),
            _buildDrawerItem(context, 'Compliance', Icons.check_circle_outline, '/admin/compliance', currentPath),
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
      leading: Icon(icon, color: isActive ? PharmaColors.emerald600 : PharmaColors.textSecondary),
      title: Text(
        label,
        style: PharmaTypography.bodyMedium.copyWith(
          color: isActive ? PharmaColors.emerald600 : PharmaColors.textPrimary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
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
    final title = currentPath.split('/').where((s) => s.isNotEmpty).join(' / ');
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          Text(
            title.isEmpty ? 'admin' : title,
            style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textSecondary),
          ),
          const Spacer(),
          const SizedBox(width: 320, child: PharmaSearchBar(hint: 'Search users, courses, reports...')),
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
          {'label': 'Compliance', 'icon': Icons.check_circle_outline, 'route': '/admin/compliance'},
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
      width: 260,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(right: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            child: Row(
              children: [
                const VyuhLogo(height: 28, width: 28, color: Colors.white),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(PharmaBrand.name, style: PharmaTypography.bodyMedium),
                    Text('Admin Portal', style: PharmaTypography.caption),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              itemCount: sidebarSections.length,
              separatorBuilder: (context, idx) => const SizedBox(height: 8),
              itemBuilder: (context, sectionIdx) {
                final section = sidebarSections[sectionIdx];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 4),
                      child: Text(
                        section['label'] as String,
                        style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ...((section['items'] as List).map((item) {
                      final itemMap = item as Map;
                      final selected = currentPath == itemMap['route'] || currentPath.startsWith(itemMap['route']);
                      return ListTile(
                        leading: Icon(itemMap['icon'] as IconData, color: selected ? PharmaColors.emerald600 : PharmaColors.textSecondary, size: 20),
                        title: Text(
                          itemMap['label'] as String,
                          style: PharmaTypography.body.copyWith(
                            color: selected ? PharmaColors.emerald700 : PharmaColors.textPrimary,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        selected: selected,
                        selectedTileColor: PharmaColors.emerald50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        onTap: () => context.go(itemMap['route'] as String),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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


