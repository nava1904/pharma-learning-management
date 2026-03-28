// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — QA PORTAL SHELL V2
// ═══════════════════════════════════════════════════════════════════════════════
//
// Persistent layout for QA workflows: Command Center, course QA review, etc.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/pharma_components.dart';
import '../design_system/pharma_design_system.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

/// QA Portal — sidebar + header wrapping nested `/qa/...` routes.
class QAShellV2 extends ConsumerWidget {
  const QAShellV2({
    super.key,
    required this.child,
    this.currentPath,
  });

  final Widget child;
  final String? currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= PortalLayout.breakpointDesktop;
    final isMobile = width < PortalLayout.breakpointTablet;
    final path = currentPath ?? '';

    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      drawer: isMobile ? Drawer(child: SafeArea(child: _QaSidebar(currentPath: path))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isDesktop) _QaSidebar(currentPath: path),
          Expanded(
            child: Column(
              children: [
                _QaHeader(
                  showMenuButton: !isDesktop,
                  onMenuPressed: () => Scaffold.of(context).openDrawer(),
                ),
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
    );
  }
}

class _QaSidebar extends StatelessWidget {
  const _QaSidebar({required this.currentPath});

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
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: PharmaColors.borderLight, width: 1),
              ),
            ),
            child: Row(
              children: [
                VyuhLogo(height: 32, width: 32, color: PharmaColors.info),
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
                      'QA Portal',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.info,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: PharmaSpacing.lg,
                vertical: PharmaSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _QaSectionLabel(label: 'OVERVIEW'),
                  _QaNavItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard_rounded,
                    label: 'Command Center',
                    route: '/qa/dashboard',
                    currentPath: currentPath,
                    matchExact: true,
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

class _QaSectionLabel extends StatelessWidget {
  const _QaSectionLabel({required this.label});

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

class _QaNavItem extends StatefulWidget {
  const _QaNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.currentPath,
    this.matchExact = false,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final String currentPath;
  final bool matchExact;

  @override
  State<_QaNavItem> createState() => _QaNavItemState();
}

class _QaNavItemState extends State<_QaNavItem> {
  bool _hover = false;

  bool get _active {
    if (widget.matchExact) {
      return widget.currentPath == widget.route;
    }
    return widget.currentPath.startsWith(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
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
            color: _active
                ? PharmaColors.info.withValues(alpha: 0.08)
                : _hover
                    ? PharmaColors.gray50
                    : Colors.transparent,
            borderRadius: PharmaRadius.buttonRadius,
            border: _active
                ? Border.all(
                    color: PharmaColors.info.withValues(alpha: 0.35),
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                _active ? widget.activeIcon : widget.icon,
                size: 20,
                color: _active ? PharmaColors.info : PharmaColors.textSecondary,
              ),
              const SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Text(
                  widget.label,
                  style: _active
                      ? PharmaTypography.navItemActive.copyWith(
                          color: PharmaColors.info,
                        )
                      : PharmaTypography.navItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QaHeader extends ConsumerWidget {
  const _QaHeader({
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

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
          if (showMenuButton) ...[
            IconButton(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu_rounded),
              iconSize: 20,
              color: PharmaColors.textSecondary,
            ),
            const SizedBox(width: PharmaSpacing.sm),
          ],
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PharmaColors.info.withValues(alpha: 0.1),
              borderRadius: PharmaRadius.pillRadius,
              border: Border.all(
                color: PharmaColors.info.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_rounded, size: 14, color: PharmaColors.info),
                const SizedBox(width: 4),
                Text(
                  'QA Portal',
                  style: PharmaTypography.labelMedium.copyWith(
                    color: PharmaColors.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: PharmaSpacing.lg),
          userAsync.when(
            data: (user) => PopupMenuButton<String>(
              offset: const Offset(0, 40),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: PharmaColors.info.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (user?.firstName ?? 'Q').substring(0, 1).toUpperCase(),
                    style: PharmaTypography.bodyMedium.copyWith(
                      color: PharmaColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  enabled: false,
                  child: Text(
                    '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim().isEmpty
                        ? 'QA'
                        : '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim(),
                    style: PharmaTypography.bodyMedium,
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'signout',
                  onTap: () => logout(ref, context),
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18, color: PharmaColors.danger),
                      const SizedBox(width: 8),
                      Text('Sign Out', style: TextStyle(color: PharmaColors.danger)),
                    ],
                  ),
                ),
              ],
            ),
            loading: () => const SizedBox(width: 36, height: 36),
            error: (_, _) => const Icon(Icons.person, size: 20),
          ),
        ],
      ),
    );
  }
}
