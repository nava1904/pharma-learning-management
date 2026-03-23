// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINER / SME SHELL V2
// ═══════════════════════════════════════════════════════════════════════════════
//
// Trainer Portal layout matching the spec: TRN-01 to TRN-16
//
// ┌──────────────────────────────────────────────────────────────────────────────┐
// │ SIDEBAR (256px)  │              MAIN AREA                                    │
// │  ┌────────────┐  │  ┌──────────────────────────────────────────────────────┐ │
// │  │   LOGO     │  │  │  HEADER (search, pending QA badge, avatar)           │ │
// │  ├────────────┤  │  ├──────────────────────────────────────────────────────┤ │
// │  │   NAV      │  │  │                                                      │ │
// │  │  ● Dashbrd │  │  │               PAGE CONTENT                           │ │
// │  │  ○ Courses │  │  │               (gray-50 bg)                           │ │
// │  │  ○ Assess  │  │  │                                                      │ │
// │  │  ○ Analyt  │  │  └──────────────────────────────────────────────────────┘ │
// │  │  ○ Users   │  │                                                          │
// │  │  ○ SOPs    │  │                                                          │
// │  │────────────│  │                                                          │
// │  │ ● Profile  │  │                                                          │
// │  └────────────┘  │                                                          │
// └──────────────────────────────────────────────────────────────────────────────┘
//
// Principles:
//  1. Content integrity over speed — auto-save + explicit save
//  2. Workflow state always visible — DRAFT → UNDER REVIEW → QA APPROVED
//  3. Dual-panel on builder screens
//  4. Preview as Employee on every builder
//  5. Compliance-first data capture
//  6. AI assistance with human review gate
//  7. Role-appropriate actions
//  8. Progressive complexity
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/pharma_components.dart';
import '../design_system/pharma_design_system.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

// ─── LAYOUT CONSTANTS ────────────────────────────────────────────────────────

const double _kSidebarWidth = 256.0;
const double _kHeaderHeight = 64.0;
const double _kBreakpointDesktop = 1024.0;
const double _kBreakpointTablet = 768.0;

// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER SHELL — MAIN WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

class TrainerShellV2 extends ConsumerStatefulWidget {
  const TrainerShellV2({
    super.key,
    required this.child,
    this.currentPath,
  });

  final Widget child;
  final String? currentPath;

  @override
  ConsumerState<TrainerShellV2> createState() => _TrainerShellV2State();
}

class _TrainerShellV2State extends ConsumerState<TrainerShellV2> {
  static const _idleTimeout = Duration(minutes: 15);
  static const _countdownDuration = 60;

  Timer? _idleTimer;
  Timer? _countdownTimer;
  int _countdownSeconds = _countdownDuration;
  bool _showTimeoutWarning = false;

  @override
  void initState() {
    super.initState();
    _resetIdleTimer();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _resetIdleTimer() {
    if (_showTimeoutWarning) return;
    _idleTimer?.cancel();
    _idleTimer = Timer(_idleTimeout, _showTimeoutDialog);
  }

  void _showTimeoutDialog() {
    if (!mounted) return;
    setState(() {
      _showTimeoutWarning = true;
      _countdownSeconds = _countdownDuration;
    });
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _countdownSeconds--);
      if (_countdownSeconds <= 0) {
        timer.cancel();
        _performLogout();
      }
    });
  }

  void _dismissTimeoutWarning() {
    _countdownTimer?.cancel();
    setState(() => _showTimeoutWarning = false);
    _resetIdleTimer();
  }

  void _performLogout() {
    _countdownTimer?.cancel();
    _idleTimer?.cancel();
    if (mounted) {
      setState(() => _showTimeoutWarning = false);
      logout(ref, context);
    }
  }

  void _onUserActivity() {
    if (!_showTimeoutWarning) {
      _resetIdleTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= _kBreakpointDesktop;
    final isMobile = width < _kBreakpointTablet;

    return Listener(
      onPointerDown: (_) => _onUserActivity(),
      onPointerMove: (_) => _onUserActivity(),
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: PharmaColors.pageBg,
            drawer: isMobile
                ? _TrainerMobileDrawer(currentPath: widget.currentPath ?? '')
                : null,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isDesktop)
                  _TrainerSidebar(currentPath: widget.currentPath ?? ''),
                Expanded(
                  child: Column(
                    children: [
                      _TrainerHeader(
                        showMenuButton: !isDesktop,
                        onMenuPressed: () => Scaffold.of(context).openDrawer(),
                      ),
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
            bottomNavigationBar: isMobile
                ? _TrainerMobileBottomNav(currentPath: widget.currentPath ?? '')
                : null,
          ),
          if (_showTimeoutWarning) _buildTimeoutOverlay(),
        ],
      ),
    );
  }

  Widget _buildTimeoutOverlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            boxShadow: PharmaShadows.cardHoverShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer_outlined,
                  size: 48, color: PharmaColors.warning),
              const SizedBox(height: 16),
              Text(
                'Session Timeout Warning',
                style: PharmaTypography.headingMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Your session has been idle for 15 minutes. You will be automatically logged out for security.',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _countdownSeconds <= 10
                      ? PharmaColors.dangerBg
                      : PharmaColors.warningBg,
                ),
                child: Center(
                  child: Text(
                    '$_countdownSeconds',
                    style: PharmaTypography.headingLarge.copyWith(
                      color: _countdownSeconds <= 10
                          ? PharmaColors.danger
                          : PharmaColors.warningText,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'seconds remaining',
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: _performLogout,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PharmaColors.danger,
                      side: BorderSide(color: PharmaColors.danger),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Log Out Now'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _dismissTimeoutWarning,
                    style: FilledButton.styleFrom(
                      backgroundColor: PharmaColors.emerald600,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Continue Session'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SIDEBAR (Desktop)
// ═══════════════════════════════════════════════════════════════════════════════

class _TrainerSidebar extends StatelessWidget {
  const _TrainerSidebar({required this.currentPath});

  final String currentPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kSidebarWidth,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(
          right: BorderSide(color: PharmaColors.borderLight, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO SECTION
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: PharmaColors.borderLight, width: 1),
              ),
            ),
            child: Row(
              children: [
                VyuhLogo(height: 32, width: 32, color: Colors.white),
                const SizedBox(width: PharmaSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      PharmaBrand.name,
                      style: PharmaTypography.headingMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Trainer Portal',
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

          // NAVIGATION
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: PharmaSpacing.lg,
                vertical: PharmaSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── OVERVIEW ──
                  _SidebarSection(label: 'OVERVIEW'),
                  _TrainerNavItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard_rounded,
                    label: 'Dashboard',
                    route: '/trainer',
                    currentPath: currentPath,
                    matchExact: true,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── CONTENT MANAGEMENT ──
                  _SidebarSection(label: 'CONTENT'),
                  _TrainerNavItem(
                    icon: Icons.menu_book_outlined,
                    activeIcon: Icons.menu_book_rounded,
                    label: 'Courses',
                    route: '/trainer/courses',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.quiz_outlined,
                    activeIcon: Icons.quiz_rounded,
                    label: 'Assessments',
                    route: '/trainer/assessments',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.auto_awesome_outlined,
                    activeIcon: Icons.auto_awesome_rounded,
                    label: 'AI Question Gen',
                    route: '/trainer/assessments/ai-generate',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.upload_file_outlined,
                    activeIcon: Icons.upload_file_rounded,
                    label: 'Materials',
                    route: '/trainer/materials',
                    currentPath: currentPath,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── COMPLIANCE ──
                  _SidebarSection(label: 'COMPLIANCE'),
                  _TrainerNavItem(
                    icon: Icons.description_outlined,
                    activeIcon: Icons.description_rounded,
                    label: 'SOP Documents',
                    route: '/trainer/sop-documents',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.grid_view_outlined,
                    activeIcon: Icons.grid_view_rounded,
                    label: 'Training Matrix',
                    route: '/trainer/training-matrix',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.question_answer_outlined,
                    activeIcon: Icons.question_answer_rounded,
                    label: 'Question Bank',
                    route: '/trainer/question-bank',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.description_outlined,
                    activeIcon: Icons.description_rounded,
                    label: 'Exam generator',
                    route: '/trainer/exam-generator',
                    currentPath: currentPath,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── MANAGEMENT ──
                  _SidebarSection(label: 'MANAGEMENT'),
                  _TrainerNavItem(
                    icon: Icons.groups_outlined,
                    activeIcon: Icons.groups_rounded,
                    label: 'My Batches',
                    route: '/trainer/batches',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.assignment_ind_outlined,
                    activeIcon: Icons.assignment_ind_rounded,
                    label: 'Assignments',
                    route: '/trainer/assignments',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.summarize_outlined,
                    activeIcon: Icons.summarize_rounded,
                    label: 'Reports',
                    route: '/trainer/reports',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.analytics_outlined,
                    activeIcon: Icons.analytics_rounded,
                    label: 'Analytics',
                    route: '/trainer/analytics',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.people_outlined,
                    activeIcon: Icons.people_rounded,
                    label: 'Learner Progress',
                    route: '/trainer/reports/learner-progress',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.rate_review_outlined,
                    activeIcon: Icons.rate_review_rounded,
                    label: 'QA Review',
                    route: '/trainer/qa-dashboard',
                    currentPath: currentPath,
                  ),

                  const SizedBox(height: PharmaSpacing.md),

                  // ── AUDIT ──
                  _SidebarSection(label: 'AUDIT'),
                  _TrainerNavItem(
                    icon: Icons.history_outlined,
                    activeIcon: Icons.history_rounded,
                    label: 'Audit Log',
                    route: '/trainer/audit-log',
                    currentPath: currentPath,
                  ),
                  _TrainerNavItem(
                    icon: Icons.shield_outlined,
                    activeIcon: Icons.shield_rounded,
                    label: 'Compliance',
                    route: '/trainer/compliance',
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
// SIDEBAR SECTION LABEL
// ─────────────────────────────────────────────────────────────────────────────

class _SidebarSection extends StatelessWidget {
  const _SidebarSection({required this.label});

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
// ─────────────────────────────────────────────────────────────────────────────

class _TrainerNavItem extends StatefulWidget {
  const _TrainerNavItem({
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
  State<_TrainerNavItem> createState() => _TrainerNavItemState();
}

class _TrainerNavItemState extends State<_TrainerNavItem> {
  bool _isHovered = false;

  bool get isActive {
    if (widget.matchExact) {
      return widget.currentPath == widget.route;
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
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HEADER
// ═══════════════════════════════════════════════════════════════════════════════

class _TrainerHeader extends ConsumerStatefulWidget {
  const _TrainerHeader({
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  @override
  ConsumerState<_TrainerHeader> createState() => _TrainerHeaderState();
}

class _TrainerHeaderState extends ConsumerState<_TrainerHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    context.go('/trainer/courses?search=${Uri.encodeComponent(trimmed)}');
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Container(
      height: _kHeaderHeight,
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
          if (widget.showMenuButton) ...[
            IconButton(
              onPressed: widget.onMenuPressed,
              icon: const Icon(Icons.menu_rounded),
              iconSize: 20,
              color: PharmaColors.textSecondary,
            ),
            const SizedBox(width: PharmaSpacing.sm),
          ],

          // SEARCH BAR
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
                    Icon(Icons.search, size: 18, color: PharmaColors.textQuaternary),
                    const SizedBox(width: PharmaSpacing.sm),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: _onSearchSubmitted,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search courses, questions, SOPs...',
                          hintStyle: PharmaTypography.body.copyWith(
                            color: PharmaColors.textQuaternary,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: PharmaTypography.body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),

          // Workflow state badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PharmaColors.emerald50,
              borderRadius: PharmaRadius.pillRadius,
              border: Border.all(color: PharmaColors.emerald200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_rounded, size: 14, color: PharmaColors.emerald600),
                const SizedBox(width: 4),
                Text(
                  'Trainer Portal',
                  style: PharmaTypography.labelMedium.copyWith(
                    color: PharmaColors.emerald700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: PharmaSpacing.lg),

          // Notifications with unread badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 20),
                color: PharmaColors.textSecondary,
                onPressed: () => context.go('/trainer/notifications'),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: PharmaColors.danger,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),

          // User avatar
          userAsync.when(
            data: (user) => GestureDetector(
              onTap: () => _showProfileMenu(context, ref, user),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: PharmaColors.emerald100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (user?.firstName ?? 'T').substring(0, 1).toUpperCase(),
                    style: PharmaTypography.bodyMedium.copyWith(
                      color: PharmaColors.emerald700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            loading: () => const SizedBox(width: 36, height: 36),
            error: (_, __) => const Icon(Icons.person, size: 20),
          ),
        ],
      ),
    );
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref, dynamic user) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(button.size.width - 200, button.size.height),
            ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim().isEmpty
                    ? 'Trainer'
                    : '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim(),
                style: PharmaTypography.bodyMedium,
              ),
              Text(
                user?.email ?? '',
                style: PharmaTypography.caption,
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'profile',
          onTap: () => context.go('/trainer/profile'),
          child: const Row(
            children: [
              Icon(Icons.person_outline, size: 18),
              SizedBox(width: 8),
              Text('Profile & Settings'),
            ],
          ),
        ),
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
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOBILE DRAWER
// ═══════════════════════════════════════════════════════════════════════════════

class _TrainerMobileDrawer extends StatelessWidget {
  const _TrainerMobileDrawer({required this.currentPath});

  final String currentPath;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: _TrainerSidebar(currentPath: currentPath),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOBILE BOTTOM NAV
// ═══════════════════════════════════════════════════════════════════════════════

class _TrainerMobileBottomNav extends StatelessWidget {
  const _TrainerMobileBottomNav({required this.currentPath});

  final String currentPath;

  int get _currentIndex {
    if (currentPath == '/trainer') return 0;
    if (currentPath.startsWith('/trainer/courses')) return 1;
    if (currentPath.startsWith('/trainer/assessments') ||
        currentPath.startsWith('/trainer/question-bank')) {
      return 2;
    }
    if (currentPath.startsWith('/trainer/reports')) {
      return 3;
    }
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
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: PharmaColors.cardBg,
        selectedItemColor: PharmaColors.emerald600,
        unselectedItemColor: PharmaColors.textTertiary,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        elevation: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/trainer');
              break;
            case 1:
              context.go('/trainer/courses');
              break;
            case 2:
              context.go('/trainer/assessments');
              break;
            case 3:
              context.go('/trainer/reports/learner-progress');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book_rounded),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Icon(Icons.quiz_rounded),
            label: 'Assessments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics_rounded),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
