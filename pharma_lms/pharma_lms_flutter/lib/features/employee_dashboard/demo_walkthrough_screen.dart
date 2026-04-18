// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE PORTAL DEMO WALKTHROUGH
// ═══════════════════════════════════════════════════════════════════════════════
//
// An interactive step-by-step tour that demonstrates every key feature of the
// employee portal. Designed for demos, onboarding, and sales presentations.
//
// Usage:
//   context.go('/employee/demo');
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design_system/pharma_design_system.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _WalkthroughStep {
  final String sectionLabel;
  final IconData icon;
  final Color accentColor;
  final String title;
  final String description;
  final List<_Feature> features;
  final String route;
  final String ctaLabel;

  const _WalkthroughStep({
    required this.sectionLabel,
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.description,
    required this.features,
    required this.route,
    this.ctaLabel = 'Explore live',
  });
}

class _Feature {
  final IconData icon;
  final String label;
  final String detail;

  const _Feature({required this.icon, required this.label, required this.detail});
}

// ─────────────────────────────────────────────────────────────────────────────
// WALKTHROUGH STEPS — every screen in the employee portal
// ─────────────────────────────────────────────────────────────────────────────

const _steps = <_WalkthroughStep>[
  _WalkthroughStep(
    sectionLabel: 'Overview',
    icon: Icons.dashboard_rounded,
    accentColor: Color(0xFF059669),
    title: 'Smart Dashboard',
    description:
        'The landing page gives every employee an instant picture of their training health — '
        'no hunting through menus.',
    features: [
      _Feature(
        icon: Icons.shield_rounded,
        label: 'Live compliance score',
        detail: 'Calculated as completed ÷ assigned-due × 100 and colour-coded green / amber / red.',
      ),
      _Feature(
        icon: Icons.trending_up_rounded,
        label: 'Stats at a glance',
        detail: 'Active courses, pending assessments, earned certifications and overdue items in one row.',
      ),
      _Feature(
        icon: Icons.warning_amber_rounded,
        label: 'Urgency-sorted deadlines',
        detail: 'Overdue items surface to the top; upcoming due dates shown with countdown.',
      ),
      _Feature(
        icon: Icons.workspace_premium_rounded,
        label: 'Expiring certificates panel',
        detail: 'Shows certs expiring in 30, 60 and 90 days so employees re-qualify in time.',
      ),
      _Feature(
        icon: Icons.history_rounded,
        label: 'Recent activity feed',
        detail: 'Last 5 completed courses with dates — instant proof of ongoing learning.',
      ),
    ],
    route: '/employee',
    ctaLabel: 'Open dashboard',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.menu_book_rounded,
    accentColor: Color(0xFF2563EB),
    title: 'Course Catalogue',
    description:
        'A searchable, filterable library of all published GMP / regulatory courses available '
        'to the employee\'s organisation.',
    features: [
      _Feature(
        icon: Icons.grid_view_rounded,
        label: 'Rich course cards',
        detail: 'Cover image, Mandatory / Optional badge, SOP number, progress bar and enrol CTA.',
      ),
      _Feature(
        icon: Icons.touch_app_rounded,
        label: 'One-tap self-enrolment',
        detail: 'Confirmation dialog → backend creates an enrollment record instantly.',
      ),
      _Feature(
        icon: Icons.label_rounded,
        label: 'Regulatory tags',
        detail: 'GMP, 21 CFR, Content Approved labels help employees prioritise compliance courses.',
      ),
      _Feature(
        icon: Icons.devices_rounded,
        label: 'Responsive 1 / 2 / 3-column grid',
        detail: 'Adapts from mobile to widescreen without a separate layout.',
      ),
    ],
    route: '/employee/catalog',
    ctaLabel: 'Browse catalogue',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.play_lesson_rounded,
    accentColor: Color(0xFF7C3AED),
    title: 'My Learning',
    description:
        'All active enrolments in one place — the employee\'s personal learning hub.',
    features: [
      _Feature(
        icon: Icons.ondemand_video_rounded,
        label: 'Module & lesson viewer',
        detail: 'Video lessons, PDF materials, rich-text blocks — all in a clean two-panel layout.',
      ),
      _Feature(
        icon: Icons.check_circle_rounded,
        label: 'Lesson completion tracking',
        detail: 'Each lesson auto-marks complete when finished; overall course progress updates.',
      ),
      _Feature(
        icon: Icons.sort_rounded,
        label: 'Ordered curriculum',
        detail: 'Modules and lessons respect the trainer-set order index for a guided learning path.',
      ),
    ],
    route: '/employee/lessons',
    ctaLabel: 'View my courses',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.assignment_rounded,
    accentColor: Color(0xFFD97706),
    title: 'Assessments',
    description:
        'Knowledge tests that gate certification — randomised, time-limited and attempt-tracked.',
    features: [
      _Feature(
        icon: Icons.shuffle_rounded,
        label: 'Randomised question sets',
        detail: 'Questions drawn from a pool — configurable display count < pool size.',
      ),
      _Feature(
        icon: Icons.timer_rounded,
        label: 'Time-limited attempts',
        detail: 'Countdown timer visible during the attempt; auto-submits on expiry.',
      ),
      _Feature(
        icon: Icons.replay_rounded,
        label: 'Attempt counter',
        detail: 'Progress bar shows attempts used vs. maximum allowed (e.g. 2 / 3) at a glance.',
      ),
      _Feature(
        icon: Icons.visibility_rounded,
        label: 'Answer review mode',
        detail: 'Trainers can unlock "show answers after submission" per assessment.',
      ),
      _Feature(
        icon: Icons.lock_rounded,
        label: 'Course-gated access',
        detail: 'Assessment unlocks only after all lessons in the course are completed.',
      ),
    ],
    route: '/employee/assessments',
    ctaLabel: 'View assessments',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.groups_rounded,
    accentColor: Color(0xFF0891B2),
    title: 'My Batches',
    description:
        'Instructor-led and virtual classroom training — schedules, live sessions and attendance.',
    features: [
      _Feature(
        icon: Icons.event_rounded,
        label: 'Upcoming sessions dashboard',
        detail: 'Cards show course name, date, venue / meeting link and enrolment status.',
      ),
      _Feature(
        icon: Icons.video_call_rounded,
        label: 'Live class links',
        detail: 'One-click join for virtual sessions; physical venue shown for on-site training.',
      ),
      _Feature(
        icon: Icons.how_to_reg_rounded,
        label: 'Attendance tracking',
        detail: 'Attendance marked per session; feeds into the completion record.',
      ),
    ],
    route: '/employee/my-batches',
    ctaLabel: 'Open my batches',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.assignment_turned_in_rounded,
    accentColor: Color(0xFFDB2777),
    title: 'Assigned Training',
    description:
        'Courses and curricula pushed by a trainer or manager — the employee\'s mandatory queue.',
    features: [
      _Feature(
        icon: Icons.flag_rounded,
        label: 'Due-date prioritisation',
        detail: 'Items sorted by urgency; overdue items highlighted in red.',
      ),
      _Feature(
        icon: Icons.auto_stories_rounded,
        label: 'Curriculum bundles',
        detail: 'Multiple courses grouped as a single curriculum assignment.',
      ),
      _Feature(
        icon: Icons.notifications_active_rounded,
        label: 'Deadline reminders',
        detail: 'Automatic notifications sent before and on due dates.',
      ),
    ],
    route: '/employee/assigned-training',
    ctaLabel: 'View assigned training',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.edit_rounded,
    accentColor: Color(0xFF9333EA),
    title: 'Standalone Assignments',
    description:
        'Written tasks, case studies, SOPs or mixed question sets sent directly to the employee.',
    features: [
      _Feature(
        icon: Icons.quiz_rounded,
        label: 'Multi-type questions',
        detail: 'MCQ, True/False, Short Answer and Open-Ended — all in one assignment.',
      ),
      _Feature(
        icon: Icons.rate_review_rounded,
        label: 'Trainer grading & feedback',
        detail: 'Trainer scores and comments displayed in a graded result banner.',
      ),
      _Feature(
        icon: Icons.history_edu_rounded,
        label: 'Submission history',
        detail: 'Previous responses preserved so the employee can review their progress.',
      ),
    ],
    route: '/employee/standalone-assignments',
    ctaLabel: 'View assignments',
  ),

  _WalkthroughStep(
    sectionLabel: 'Training',
    icon: Icons.qr_code_scanner_rounded,
    accentColor: Color(0xFF0F766E),
    title: 'Operator Qualification Check',
    description:
        'Instant QR-scan verification that an operator is qualified to perform a specific task.',
    features: [
      _Feature(
        icon: Icons.verified_user_rounded,
        label: 'Real-time qualification status',
        detail: 'Green / red result shown within seconds of scanning the operator\'s QR.',
      ),
      _Feature(
        icon: Icons.article_rounded,
        label: 'Linked competency record',
        detail: 'Drill-down shows which courses or certificates back the qualification.',
      ),
    ],
    route: '/employee/operator',
    ctaLabel: 'Open operator check',
  ),

  _WalkthroughStep(
    sectionLabel: 'Records',
    icon: Icons.history_edu_rounded,
    accentColor: Color(0xFF1D4ED8),
    title: 'Training History',
    description:
        'A permanent, auditable record of every course the employee has ever completed.',
    features: [
      _Feature(
        icon: Icons.table_chart_rounded,
        label: 'Full completion transcript',
        detail: 'Date, course name, version, score and certificate number in one searchable table.',
      ),
      _Feature(
        icon: Icons.filter_alt_rounded,
        label: 'Date-range filters',
        detail: 'Filter by time period — useful for annual performance reviews.',
      ),
      _Feature(
        icon: Icons.download_rounded,
        label: 'Printable transcript',
        detail: 'Export history as a PDF for external audits or HR records.',
      ),
    ],
    route: '/employee/training-history',
    ctaLabel: 'View history',
  ),

  _WalkthroughStep(
    sectionLabel: 'Records',
    icon: Icons.workspace_premium_rounded,
    accentColor: Color(0xFFF59E0B),
    title: 'Certifications',
    description:
        'Digital certificates for every completed course — downloadable, verifiable and tamper-proof.',
    features: [
      _Feature(
        icon: Icons.picture_as_pdf_rounded,
        label: 'PDF certificate download',
        detail: 'Branded certificate with QR code, employee name, score and trainer signature.',
      ),
      _Feature(
        icon: Icons.qr_code_rounded,
        label: 'Public verification link',
        detail: 'Anyone can verify authenticity by scanning the QR — no login required.',
      ),
      _Feature(
        icon: Icons.notifications_rounded,
        label: 'Expiry reminders',
        detail: 'Alerts at 90, 60 and 30 days before expiry prompt re-qualification.',
      ),
      _Feature(
        icon: Icons.wallet_rounded,
        label: 'Credentials wallet',
        detail: 'All certificates in one place — share with a recruiter or auditor in one tap.',
      ),
    ],
    route: '/employee/credentials',
    ctaLabel: 'Open credentials',
  ),

  _WalkthroughStep(
    sectionLabel: 'Records',
    icon: Icons.fact_check_rounded,
    accentColor: Color(0xFFDC2626),
    title: 'Compliance Overview',
    description:
        'A personal compliance dashboard — know your status before the auditor does.',
    features: [
      _Feature(
        icon: Icons.percent_rounded,
        label: 'Compliance percentage',
        detail: 'Colour-coded score based on completed vs. due training obligations.',
      ),
      _Feature(
        icon: Icons.schedule_rounded,
        label: 'Overdue items list',
        detail: 'Every overdue item with days overdue and a quick-enrol CTA.',
      ),
      _Feature(
        icon: Icons.upcoming_rounded,
        label: 'Upcoming obligations',
        detail: 'What\'s due in the next 30/60/90 days — plan ahead, stay compliant.',
      ),
    ],
    route: '/employee/compliance',
    ctaLabel: 'View compliance',
  ),

  _WalkthroughStep(
    sectionLabel: 'Records',
    icon: Icons.description_rounded,
    accentColor: Color(0xFF475569),
    title: 'Documents & SOPs',
    description:
        'All controlled documents and SOPs the employee needs to read and acknowledge.',
    features: [
      _Feature(
        icon: Icons.folder_rounded,
        label: 'Organised by category',
        detail: 'SOPs, work instructions, policies — grouped for fast access.',
      ),
      _Feature(
        icon: Icons.how_to_reg_rounded,
        label: 'Read & acknowledge',
        detail: 'Employee confirms they\'ve read a document; timestamp stored for audit trail.',
      ),
      _Feature(
        icon: Icons.search_rounded,
        label: 'Full-text search',
        detail: 'Find any document by title or document number instantly.',
      ),
    ],
    route: '/employee/documents',
    ctaLabel: 'View documents',
  ),

  _WalkthroughStep(
    sectionLabel: 'Records',
    icon: Icons.download_rounded,
    accentColor: Color(0xFF64748B),
    title: 'Downloads',
    description:
        'A single place for all files the employee has downloaded or has access to.',
    features: [
      _Feature(
        icon: Icons.insert_drive_file_rounded,
        label: 'Course materials',
        detail: 'PDFs, handouts and reference documents from completed courses.',
      ),
      _Feature(
        icon: Icons.workspace_premium_rounded,
        label: 'Certificate PDFs',
        detail: 'Re-download any earned certificate at any time.',
      ),
    ],
    route: '/employee/downloads',
    ctaLabel: 'View downloads',
  ),

  _WalkthroughStep(
    sectionLabel: 'Account',
    icon: Icons.notifications_rounded,
    accentColor: Color(0xFFEA580C),
    title: 'Notifications',
    description:
        'Real-time alerts that keep the employee informed without email overload.',
    features: [
      _Feature(
        icon: Icons.mark_email_read_rounded,
        label: 'Unread badge',
        detail: 'Red badge on the bell icon shows unread count; clears on open.',
      ),
      _Feature(
        icon: Icons.category_rounded,
        label: 'Typed alerts',
        detail: 'Deadline reminders, new assignments, batch invites, grading results.',
      ),
      _Feature(
        icon: Icons.done_all_rounded,
        label: 'Mark all as read',
        detail: 'One-tap to clear the entire inbox.',
      ),
    ],
    route: '/employee/notifications',
    ctaLabel: 'View notifications',
  ),

  _WalkthroughStep(
    sectionLabel: 'Account',
    icon: Icons.calendar_month_rounded,
    accentColor: Color(0xFF0369A1),
    title: 'Training Calendar',
    description:
        'A monthly view of all upcoming training events, batch sessions and deadlines.',
    features: [
      _Feature(
        icon: Icons.event_available_rounded,
        label: 'Visual calendar',
        detail: 'Colour-coded events by type — live session, assessment, deadline.',
      ),
      _Feature(
        icon: Icons.touch_app_rounded,
        label: 'Tap to navigate',
        detail: 'Tap any event to jump directly to the relevant course or batch.',
      ),
    ],
    route: '/employee/calendar',
    ctaLabel: 'Open calendar',
  ),

  _WalkthroughStep(
    sectionLabel: 'Account',
    icon: Icons.chat_bubble_rounded,
    accentColor: Color(0xFF15803D),
    title: 'Messages',
    description:
        'Direct messaging between employees, trainers and administrators.',
    features: [
      _Feature(
        icon: Icons.inbox_rounded,
        label: 'Threaded inbox',
        detail: 'Conversations grouped by contact — easy to follow.',
      ),
      _Feature(
        icon: Icons.send_rounded,
        label: 'Reply inline',
        detail: 'Respond directly from the notification or inbox — no page reload.',
      ),
    ],
    route: '/employee/messages',
    ctaLabel: 'Open messages',
  ),

  _WalkthroughStep(
    sectionLabel: 'Account',
    icon: Icons.manage_accounts_rounded,
    accentColor: Color(0xFF7C3AED),
    title: 'Profile & Settings',
    description:
        'Employee profile, notification preferences and security settings.',
    features: [
      _Feature(
        icon: Icons.badge_rounded,
        label: 'Employee details',
        detail: 'Name, role, department, employee ID — sourced from HR integration.',
      ),
      _Feature(
        icon: Icons.security_rounded,
        label: 'MFA setup',
        detail: 'Enrol in multi-factor authentication for 21 CFR Part 11 compliance.',
      ),
      _Feature(
        icon: Icons.tune_rounded,
        label: 'Notification preferences',
        detail: 'Choose which alert types to receive and how (in-app / email).',
      ),
    ],
    route: '/employee/profile',
    ctaLabel: 'View profile',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class DemoWalkthroughScreen extends StatefulWidget {
  const DemoWalkthroughScreen({super.key});

  @override
  State<DemoWalkthroughScreen> createState() => _DemoWalkthroughScreenState();
}

class _DemoWalkthroughScreenState extends State<DemoWalkthroughScreen>
    with TickerProviderStateMixin {
  int _current = 0;
  late final PageController _pageCtrl;
  late final AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= _steps.length) return;
    _fadeCtrl.reverse().then((_) {
      _pageCtrl.jumpToPage(index);
      setState(() => _current = index);
      _fadeCtrl.forward();
    });
  }

  void _next() => _goTo(_current + 1);
  void _prev() => _goTo(_current - 1);

  @override
  Widget build(BuildContext context) {
    final step = _steps[_current];
    final isLast = _current == _steps.length - 1;
    final isFirst = _current == 0;

    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      body: Column(
        children: [
          _TopBar(step: step, current: _current, total: _steps.length),
          Expanded(
            child: PageView.builder(
              controller: _pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _steps.length,
              itemBuilder: (_, i) => FadeTransition(
                opacity: _fadeAnim,
                child: _StepBody(step: _steps[i]),
              ),
            ),
          ),
          _BottomBar(
            step: step,
            current: _current,
            total: _steps.length,
            isFirst: isFirst,
            isLast: isLast,
            onPrev: _prev,
            onNext: _next,
            onJumpToIndex: _goTo,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.step, required this.current, required this.total});

  final _WalkthroughStep step;
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          // Logo / title area
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: PharmaColors.emerald600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.science_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Pharma LMS', style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
                  Text(
                    'Employee Portal — Feature Walkthrough',
                    style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Step counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PharmaColors.gray100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Step ${current + 1} of $total',
              style: PharmaTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: PharmaColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Close
          IconButton(
            icon: const Icon(Icons.close_rounded),
            color: PharmaColors.textTertiary,
            onPressed: () => context.go('/employee'),
            tooltip: 'Exit demo',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP BODY
// ─────────────────────────────────────────────────────────────────────────────

class _StepBody extends StatelessWidget {
  const _StepBody({required this.step});

  final _WalkthroughStep step;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        return SingleChildScrollView(
          padding: EdgeInsets.all(isWide ? 40 : 20),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _HeroPanel(step: step)),
                    const SizedBox(width: 32),
                    Expanded(flex: 3, child: _FeatureList(step: step)),
                  ],
                )
              : Column(
                  children: [
                    _HeroPanel(step: step),
                    const SizedBox(height: 24),
                    _FeatureList(step: step),
                  ],
                ),
        );
      },
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.step});

  final _WalkthroughStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: step.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: step.accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                step.sectionLabel.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: step.accentColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Giant icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: step.accentColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(step.icon, color: step.accentColor, size: 44),
        ),
        const SizedBox(height: 20),

        // Title
        Text(
          step.title,
          style: PharmaTypography.headingLarge.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          step.description,
          style: PharmaTypography.body.copyWith(
            color: PharmaColors.textSecondary,
            height: 1.6,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 24),

        // CTA to live screen
        FilledButton.icon(
          onPressed: () => context.go(step.route),
          icon: const Icon(Icons.open_in_browser_rounded, size: 18),
          label: Text(step.ctaLabel),
          style: FilledButton.styleFrom(
            backgroundColor: step.accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList({required this.step});

  final _WalkthroughStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: PharmaTypography.headingSmall.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: PharmaColors.textTertiary,
          ),
        ),
        const SizedBox(height: 12),
        ...step.features.map((f) => _FeatureCard(feature: f, accent: step.accentColor)),
      ],
    );
  }
}

class _FeatureCard extends StatefulWidget {
  const _FeatureCard({required this.feature, required this.accent});

  final _Feature feature;
  final Color accent;

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _expanded ? widget.accent.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _expanded ? widget.accent.withOpacity(0.3) : PharmaColors.borderLight,
          ),
          boxShadow: _expanded ? [] : PharmaShadows.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: widget.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.feature.icon, color: widget.accent, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.feature.label,
                    style: PharmaTypography.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: PharmaColors.textTertiary,
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 46),
                child: Text(
                  widget.feature.detail,
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textSecondary,
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM BAR
// ─────────────────────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.step,
    required this.current,
    required this.total,
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onNext,
    required this.onJumpToIndex,
  });

  final _WalkthroughStep step;
  final int current;
  final int total;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<int> onJumpToIndex;

  @override
  Widget build(BuildContext context) {
    // Group dots by section
    const sections = ['Overview', 'Training', 'Records', 'Account'];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dot navigator grouped by section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(total, (i) {
              final isActive = i == current;
              return GestureDetector(
                onTap: () => onJumpToIndex(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? step.accentColor : PharmaColors.gray200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),
          // Navigation buttons
          Row(
            children: [
              // Prev
              if (!isFirst)
                OutlinedButton.icon(
                  onPressed: onPrev,
                  icon: const Icon(Icons.arrow_back_rounded, size: 16),
                  label: const Text('Previous'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.textSecondary,
                    side: BorderSide(color: PharmaColors.borderMedium),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                )
              else
                const SizedBox(width: 1),
              const Spacer(),
              // Section label
              Text(
                '${current + 1} / $total · ${step.sectionLabel}',
                style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
              ),
              const Spacer(),
              // Next / Finish
              if (!isLast)
                FilledButton.icon(
                  onPressed: onNext,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: const Text('Next'),
                  style: FilledButton.styleFrom(
                    backgroundColor: step.accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                )
              else
                FilledButton.icon(
                  onPressed: () => context.go('/employee'),
                  icon: const Icon(Icons.check_circle_rounded, size: 16),
                  label: const Text('Go to Dashboard'),
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
