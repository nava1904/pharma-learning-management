// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE DASHBOARD (S1) — SERVERPOD WIRED
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/dashboard
// The primary screen employees see after login.
//
// DESIGN PRINCIPLES APPLIED:
// ┌─────────────────────────────────────────────────────────────────────────────┐
// │ Apple HIG         │ 4-layer depth system, 44pt min tap targets            │
// │ Refactoring UI    │ Hierarchy through size+weight+color, no decorative    │
// │ Don't Make Me Think│ Self-evident in 3 seconds, one primary action        │
// │ Laws of UX        │ Fitts (48px CTAs), Hick (max 7 nav), Miller (4 stats) │
// │ UI is Communication│ OVERDUE = RED always, COMPLETED = GREEN + checkmark  │
// │ Atomic Design     │ StatusPill, CourseCard, ProgressRing molecules        │
// │ Practical UI      │ 32px page padding, 24px section gap, scroll is free   │
// └─────────────────────────────────────────────────────────────────────────────┘
//
// LAYOUT (1440px frame):
// - Compliance Alert Banner (RED left border 4px, pulsing, only if overdue > 0)
// - 4-stat row (Compliance %, Overdue, Due This Month, Certificates)
// - Hero "Up Next" card (navy gradient, animated progress ring right)
// - Tabbed course list (In Progress / To Do / Completed with count badges)
//
// DESIGN TOKENS:
// - Page bg: N100 (#F1F5F9)
// - Card bg: white, sh1 shadow
// - Hero gradient: #0F172A → #1E293B
// - Danger red: #DC2626 for overdue badge
// - Success green: #16A34A for completed
// - Blue: #1A56DB for tab active
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../design_system/tokens.dart';
import '../../design_system/components.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/notification_provider.dart';
import '../../providers/realtime_progress_provider.dart';
import '../../providers/user_provider.dart';

/// Employee Dashboard with compliance-focused design - SERVERPOD WIRED
class EmployeeDashboardRedesigned extends ConsumerStatefulWidget {
  const EmployeeDashboardRedesigned({super.key});

  @override
  ConsumerState<EmployeeDashboardRedesigned> createState() =>
      _EmployeeDashboardRedesignedState();
}

class _EmployeeDashboardRedesignedState
    extends ConsumerState<EmployeeDashboardRedesigned>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Refresh all dashboard data
  Future<void> _refreshData() async {
    ref.invalidate(currentUserProvider);
    ref.invalidate(userComplianceProvider);
    ref.invalidate(enrollmentsProvider);
    ref.invalidate(enrollmentResumeLabelsProvider);
    ref.invalidate(enrollmentProgressProvider);
    ref.invalidate(assignmentsProvider);
    ref.invalidate(certificatesProvider);
    ref.invalidate(notificationsProvider);
    await Future.wait([
      ref.refresh(currentUserProvider.future),
      ref.refresh(userComplianceProvider.future),
      ref.refresh(enrollmentsProvider.future),
      ref.refresh(enrollmentResumeLabelsProvider.future),
      ref.refresh(enrollmentProgressProvider.future),
      ref.refresh(assignmentsProvider.future),
      ref.refresh(certificatesProvider.future),
    ]);
    ref.read(employeeDashboardLastUpdatedProvider.notifier).state = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final complianceAsync = ref.watch(userComplianceProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final resumeLabelsAsync = ref.watch(enrollmentResumeLabelsProvider);
    final assignmentsAsync = ref.watch(assignmentsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);
    final lastUpdated = ref.watch(employeeDashboardLastUpdatedProvider);
    // Activate realtime subscriptions for live progress + notification updates
    final progressMap = ref.watch(mergedEnrollmentProgressProvider);
    ref.watch(notificationRealtimeProvider);

    return RefreshIndicator(
      onRefresh: _refreshData,
      color: AppColors.blue,
      child: userAsync.when(
        data: (user) {
          if (user == null || user.id == null) {
            return _buildEmptyState('Employee user not found. Please sign in again.');
          }

          return _DashboardContent(
            user: user,
            userId: user.id!,
            complianceAsync: complianceAsync,
            enrollmentsAsync: enrollmentsAsync,
            resumeLabelsAsync: resumeLabelsAsync,
            assignmentsAsync: assignmentsAsync,
            certificatesAsync: certificatesAsync,
            tabController: _tabController,
            lastUpdated: lastUpdated,
            progressMap: progressMap,
          );
        },
        loading: () => _buildLoadingState(),
        error: (e, _) => _buildErrorState(e.toString()),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: AppEmptyState(
        icon: Icons.person_off_outlined,
        title: 'User Not Found',
        description: message,
        actionLabel: 'Sign In',
        onAction: () => context.go('/'),
      ),
    );
  }

  Widget _buildLoadingState() {
    // Doherty Threshold: skeleton <100ms perceived load
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.s7), // 32px page padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skeleton header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(height: 36, width: 240), // Display size
                    const SizedBox(height: AppSpacing.s2),
                    SkeletonLoader(height: 16, width: 180),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s6), // 24px section gap

          // Skeleton stat cards (4-col grid)
          Row(
            children: List.generate(
              4,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 3 ? AppSpacing.s4 : 0),
                  child: StatCardSkeleton(),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s7), // 32px before hero

          // Skeleton hero card
          SkeletonLoader(height: 220, borderRadius: AppRadius.br3),
          const SizedBox(height: AppSpacing.s7),

          // Skeleton tab bar + courses
          SkeletonLoader(height: 24, width: 120),
          const SizedBox(height: AppSpacing.s4),
          SkeletonLoader(height: 52, borderRadius: AppRadius.br2), // Tab bar
          const SizedBox(height: AppSpacing.s5),
          Row(
            children: List.generate(
              2,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 1 ? AppSpacing.s4 : 0),
                  child: CourseCardSkeleton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    // Don't Make Me Think: Errors explain HOW to fix
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s7), // 32px page padding
      child: AppErrorWidget(
        title: 'Unable to Load Dashboard',
        message: 'There was a problem loading your training data. Pull down to refresh or check your connection.',
        onRetry: _refreshData,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DASHBOARD CONTENT - Uses real data from providers
// ═══════════════════════════════════════════════════════════════════════════════

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.user,
    required this.userId,
    required this.complianceAsync,
    required this.enrollmentsAsync,
    required this.resumeLabelsAsync,
    required this.assignmentsAsync,
    required this.certificatesAsync,
    required this.tabController,
    this.lastUpdated,
    this.progressMap = const {},
  });

  final PharmaUser user;
  final int userId;
  final AsyncValue<UserComplianceMetrics?> complianceAsync;
  final AsyncValue<List<Enrollment>> enrollmentsAsync;
  final AsyncValue<Map<int, String>> resumeLabelsAsync;
  final AsyncValue<List<TrainingAssignment>> assignmentsAsync;
  final AsyncValue<List<Certificate>> certificatesAsync;
  final TabController tabController;
  final DateTime? lastUpdated;
  /// Live-updating progress map: enrollmentId → 0–100%.
  final Map<int, double> progressMap;

  /// Get compliance metrics with fallback
  UserComplianceMetrics get _compliance =>
      complianceAsync.valueOrNull ??
      UserComplianceMetrics(
        compliant: true,
        overdueCount: 0,
        upcomingCount: 0,
        complianceRate: 100.0,
        totalCertificates: 0,
      );

  List<Enrollment> get _enrollments => enrollmentsAsync.valueOrNull ?? [];
  List<TrainingAssignment> get _assignments => assignmentsAsync.valueOrNull ?? [];
  Map<int, String> get _resumeLabels => resumeLabelsAsync.valueOrNull ?? {};

  /// Get enrollments by status
  List<Enrollment> get _inProgress =>
      _enrollments.where((e) => e.status == 'in_progress').toList();

  List<Enrollment> get _toDo => _enrollments
      .where((e) => e.status != 'in_progress' && e.status != 'completed')
      .toList();

  List<Enrollment> get _completed =>
      _enrollments.where((e) => e.status == 'completed').toList();

  /// Count overdue in to-do list
  int get _toDoOverdueCount {
    final now = DateTime.now();
    return _toDo.where((e) {
      final assignment = _getAssignment(e);
      return assignment != null && assignment.dueDate.isBefore(now);
    }).length;
  }

  /// Get assignment for enrollment
  TrainingAssignment? _getAssignment(Enrollment enrollment) {
    return _assignments
        .where((a) =>
            a.courseVersionId == enrollment.courseVersionId && a.userId == userId)
        .firstOrNull;
  }

  /// Get due date for enrollment
  DateTime _getDueDate(Enrollment enrollment) {
    final assignment = _getAssignment(enrollment);
    return assignment?.dueDate ?? DateTime.now().add(const Duration(days: 365));
  }

  /// Check if enrollment is overdue
  bool _isOverdue(Enrollment enrollment) {
    if (enrollment.status == 'completed') return false;
    return _getDueDate(enrollment).isBefore(DateTime.now());
  }

  /// Get the most urgent "Up Next" enrollment
  Enrollment? get _upNext {
    // Priority 1: SOP retraining requiring acknowledgement
    final retraining = _enrollments
        .where((e) =>
            e.retrainingChangeSummary != null &&
            e.retrainingChangeSummary!.isNotEmpty &&
            e.acknowledgedAt == null)
        .toList();
    if (retraining.isNotEmpty) {
      retraining.sort((a, b) => _getDueDate(a).compareTo(_getDueDate(b)));
      return retraining.first;
    }

    // Priority 2: Overdue in-progress
    final overdueInProgress = _inProgress.where(_isOverdue).toList();
    if (overdueInProgress.isNotEmpty) {
      overdueInProgress.sort((a, b) => _getDueDate(a).compareTo(_getDueDate(b)));
      return overdueInProgress.first;
    }

    // Priority 3: Closest due date
    final pending = [..._toDo, ..._inProgress];
    if (pending.isEmpty) return null;

    pending.sort((a, b) {
      final aOverdue = _isOverdue(a);
      final bOverdue = _isOverdue(b);
      if (aOverdue != bOverdue) return aOverdue ? -1 : 1;
      return _getDueDate(a).compareTo(_getDueDate(b));
    });
    return pending.first;
  }

  /// Convert enrollment status to TrainingStatus enum
  TrainingStatus _getTrainingStatus(Enrollment enrollment) {
    if (enrollment.retrainingChangeSummary != null &&
        enrollment.retrainingChangeSummary!.isNotEmpty &&
        enrollment.acknowledgedAt == null) {
      return TrainingStatus.sopUpdate;
    }
    if (_isOverdue(enrollment)) return TrainingStatus.overdue;
    switch (enrollment.status) {
      case 'completed':
        return TrainingStatus.completed;
      case 'in_progress':
        return TrainingStatus.inProgress;
      default:
        return TrainingStatus.notStarted;
    }
  }

  /// Sort enrollments by due date (overdue first)
  List<Enrollment> _sortByDue(List<Enrollment> list) {
    final sorted = List<Enrollment>.from(list);
    sorted.sort((a, b) {
      final aOverdue = _isOverdue(a);
      final bOverdue = _isOverdue(b);
      if (aOverdue != bOverdue) return aOverdue ? -1 : 1;
      return _getDueDate(a).compareTo(_getDueDate(b));
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s7), // 32px page padding (Practical UI)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── COMPLIANCE ALERT BANNER (Red left border 4px, pulsing) ───
          // Only shown when overdueCount > 0 — cannot be dismissed
          if (_compliance.overdueCount > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s6), // 24px section gap
              child: ComplianceAlertBanner(
                overdueCount: _compliance.overdueCount,
                onViewOverdue: () => tabController.animateTo(1),
              ),
            ),

          // ─── HEADER ───
          _buildHeader(context),
          const SizedBox(height: AppSpacing.s6), // 24px section gap

          // ─── STAT CARDS ROW (Miller's Law: max 4) ───
          _buildStatCardsRow(),
          const SizedBox(height: AppSpacing.s7), // 32px before hero

          // ─── HERO "UP NEXT" CARD (Navy gradient, progress ring right) ───
          if (_upNext != null) _buildUpNextCard(context),
          if (_upNext != null) const SizedBox(height: AppSpacing.s7),

          // ─── TABBED COURSE LIST (Count badges, red if overdue) ───
          _buildTabbedCourseList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final displayName = user.firstName.isNotEmpty
        ? user.firstName
        : user.email.split('@').first;

    // Get job title from jobRole relation or fallback to email
    final jobTitle = user.jobRole?.name ?? user.email;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display: 36px / 700 (Bricolage Grotesque)
              Text(
                'Welcome back, $displayName',
                style: AppTypography.display,
              ),
              const SizedBox(height: AppSpacing.s1), // 4px micro gap
              // Body: 16px / 400 (DM Sans)
              Text(
                jobTitle,
                style: AppTypography.body.copyWith(
                  color: AppColors.n500,
                ),
              ),
            ],
          ),
        ),
        // Last updated timestamp — human format "Mar 11, 2026"
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s3,
            vertical: AppSpacing.s2,
          ),
          decoration: BoxDecoration(
            color: AppColors.n100,
            borderRadius: AppRadius.br5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.update_rounded,
                size: 14,
                color: AppColors.n400,
              ),
              const SizedBox(width: AppSpacing.s1),
              Text(
                lastUpdated?.humanDate ?? DateTime.now().humanDate,
                style: AppTypography.caption.copyWith(
                  color: AppColors.n500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Miller's Law: max 4 stat cards, visual hierarchy through size+weight+color
  Widget _buildStatCardsRow() {
    final complianceRate = _compliance.complianceRate;

    return Row(
      children: [
        // Compliance Rate — semantic color based on value
        Expanded(
          child: _StatCard(
            label: 'Compliance Rate',
            value: '${complianceRate.toInt()}%',
            icon: Icons.verified_outlined,
            color: complianceRate >= 80
                ? AppColors.success
                : complianceRate >= 60
                    ? AppColors.warning
                    : AppColors.danger,
          ),
        ),
        const SizedBox(width: AppSpacing.s4), // 16px gap
        // Overdue — ALWAYS RED if > 0 (UI is Communication)
        Expanded(
          child: _StatCard(
            label: 'Overdue',
            value: '${_compliance.overdueCount}',
            icon: Icons.warning_amber_outlined,
            color: _compliance.overdueCount > 0 ? AppColors.danger : AppColors.n400,
            isUrgent: _compliance.overdueCount > 0,
          ),
        ),
        const SizedBox(width: AppSpacing.s4),
        // Due This Month — Blue (in motion)
        Expanded(
          child: _StatCard(
            label: 'Due This Month',
            value: '${_compliance.upcomingCount}',
            icon: Icons.calendar_month_outlined,
            color: AppColors.blue,
          ),
        ),
        const SizedBox(width: AppSpacing.s4),
        // Certificates — Teal (achievement)
        Expanded(
          child: _StatCard(
            label: 'Certificates',
            value: '${_compliance.totalCertificates}',
            icon: Icons.workspace_premium_outlined,
            color: AppColors.teal,
          ),
        ),
      ],
    );
  }

  /// Hero "Up Next" card — Navy gradient, CTA min 48px (Fitts's Law)
  Widget _buildUpNextCard(BuildContext context) {
    final enrollment = _upNext!;
    final course = enrollment.courseVersion?.course;
    final status = _getTrainingStatus(enrollment);
    final isOverdue = status == TrainingStatus.overdue || status == TrainingStatus.sopUpdate;
    final dueDate = _getDueDate(enrollment);

    // Calculate progress from real enrollment progress data (realtime + server merged)
    final progress = enrollment.status == 'completed'
        ? 1.0
        : enrollment.status == 'in_progress'
            ? (progressMap[enrollment.id] ?? 0.0) / 100.0
            : 0.0;

    // Get course metadata
    final title = course?.title ?? 'Training Course';
    final courseType = 'Mixed'; // Would come from course materials
    final estimatedMinutes = 45; // Would come from course metadata
    final resumeLabel = _resumeLabels[enrollment.id];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Navy gradient as per design spec
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A), // N900 / Navy
            Color(0xFF1E293B), // N800 / Slate
          ],
        ),
        borderRadius: AppRadius.br3, // 14px radius
        boxShadow: AppShadows.sh2, // Elevation layer 2
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s6), // 24px inner padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left content (2-col grid: left content + right progress ring)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status badge — pill style
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s3, // 12px
                      vertical: AppSpacing.s1,   // 4px
                    ),
                    decoration: BoxDecoration(
                      color: isOverdue
                          ? AppColors.danger.withValues(alpha: 0.2)
                          : AppColors.blue.withValues(alpha: 0.2),
                      borderRadius: AppRadius.br5, // Pill
                    ),
                    child: Text(
                      status == TrainingStatus.sopUpdate
                          ? 'SOP UPDATE'
                          : isOverdue
                              ? 'OVERDUE'
                              : 'UP NEXT',
                      style: AppTypography.caption.copyWith(
                        color: isOverdue ? AppColors.danger : AppColors.blue,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s4), // 16px

                  // Course title — Title: 24px / 600
                  Text(
                    title,
                    style: AppTypography.title.copyWith(
                      color: AppColors.n0,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3), // 12px

                  // Due date — Human format "Due Mar 11, 2026"
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_outlined,
                        size: 16,
                        color: isOverdue ? AppColors.danger : AppColors.n400,
                      ),
                      const SizedBox(width: AppSpacing.s2), // 8px
                      Text(
                        isOverdue
                            ? dueDate.fullDueDateLabel
                            : 'Due ${dueDate.humanDate}',
                        style: AppTypography.bodySmall.copyWith(
                          color: isOverdue ? AppColors.danger : AppColors.n400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s2), // 8px

                  // Course metadata chips
                  Row(
                    children: [
                      _CourseMetaChip(
                        icon: Icons.description_outlined,
                        label: courseType,
                      ),
                      const SizedBox(width: AppSpacing.s3),
                      _CourseMetaChip(
                        icon: Icons.timer_outlined,
                        label: '~$estimatedMinutes min',
                      ),
                      if (resumeLabel != null) ...[
                        const SizedBox(width: AppSpacing.s3),
                        _CourseMetaChip(
                          icon: Icons.bookmark_outlined,
                          label: resumeLabel,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s6), // 24px before CTA

                  // CTA Button — Min 48px tall (Fitts's Law)
                  FilledButton.icon(
                    onPressed: () {
                      // Navigate to course viewer with proper params
                      context.go(
                        '/employee/course/${course?.id ?? enrollment.courseVersionId}',
                        extra: {
                          'courseVersionId': enrollment.courseVersionId.toString(),
                          'enrollmentId': enrollment.id?.toString(),
                        },
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          isOverdue ? AppColors.danger : AppColors.blue,
                      foregroundColor: AppColors.n0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s6, // 24px
                        vertical: AppSpacing.s4,   // 16px
                      ),
                      minimumSize: const Size(0, 48), // Fitts's Law: min 48px
                    ),
                    icon: Icon(
                      enrollment.status == 'in_progress'
                          ? Icons.play_arrow_rounded
                          : Icons.play_arrow_rounded,
                      size: 20,
                    ),
                    label: Text(
                      enrollment.status == 'in_progress'
                          ? 'Resume Course'
                          : status == TrainingStatus.sopUpdate
                              ? 'Review Changes'
                              : 'Start Now',
                      style: AppTypography.button.copyWith(
                        color: AppColors.n0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right side: Animated Progress ring
            const SizedBox(width: AppSpacing.s6), // 24px gap
            ProgressRing(
              percent: progress,
              size: 120,
              strokeWidth: 10,
              color: isOverdue ? AppColors.danger : AppColors.blue,
              backgroundColor: AppColors.n700,
              label: '${(progress * 100).toInt()}%',
              sublabel: 'complete',
            ),
          ],
        ),
      ),
    );
  }

  /// Tabbed course list with count badges — Hick's Law: max 3 tabs
  Widget _buildTabbedCourseList(BuildContext context) {
    final sortedInProgress = _sortByDue(_inProgress);
    final sortedToDo = _sortByDue(_toDo);
    final sortedCompleted = _sortByDue(_completed);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header — Headline: 20px / 600
        Text(
          'My Courses',
          style: AppTypography.headline,
        ),
        const SizedBox(height: AppSpacing.s4), // 16px

        // Tab bar with count badges — custom styled container
        Container(
          decoration: BoxDecoration(
            color: AppColors.n100, // Layer 0 background
            borderRadius: AppRadius.br2, // 10px radius
          ),
          padding: const EdgeInsets.all(4),
          child: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: AppColors.n0, // White active tab
              borderRadius: AppRadius.br2,
              boxShadow: AppShadows.sh1,
            ),
            labelColor: AppColors.n900,
            unselectedLabelColor: AppColors.n500,
            labelStyle: AppTypography.label.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: AppTypography.label,
            tabs: [
              _TabWithBadge(
                label: 'In Progress',
                count: sortedInProgress.length,
                badgeColor: sortedInProgress.isNotEmpty ? AppColors.blue : null,
              ),
              _TabWithBadge(
                label: 'To Do',
                count: sortedToDo.length,
                // RED badge if any overdue (UI is Communication)
                badgeColor: _toDoOverdueCount > 0 ? AppColors.danger : null,
              ),
              _TabWithBadge(
                label: 'Completed',
                count: sortedCompleted.length,
                // GREEN badge for completed (UI is Communication)
                badgeColor: sortedCompleted.isNotEmpty ? AppColors.success : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s5), // 20px

        // Tab content — course cards grid
        SizedBox(
          height: 420, // Fixed height for tab content
          child: TabBarView(
            controller: tabController,
            children: [
              _buildCourseGrid(context, sortedInProgress),
              _buildCourseGrid(context, sortedToDo),
              _buildCourseGrid(context, sortedCompleted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourseGrid(BuildContext context, List<Enrollment> enrollments) {
    if (enrollments.isEmpty) {
      // Empty state explains WHY and WHAT to do next
      return AppEmptyState(
        icon: Icons.school_outlined,
        title: 'No courses here',
        description: 'Courses in this category will appear here. Browse the catalog to get started.',
        actionLabel: 'Browse Catalog',
        onAction: () => context.go('/employee/catalog'),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid — min card width 280px
        final crossAxisCount = constraints.maxWidth > 900
            ? 3
            : constraints.maxWidth > 600
                ? 2
                : 1;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: AppSpacing.s4,  // 16px vertical gap
            crossAxisSpacing: AppSpacing.s4, // 16px horizontal gap
            childAspectRatio: 1.4,           // Card proportions
          ),
          itemCount: enrollments.length,
          itemBuilder: (context, index) {
            final enrollment = enrollments[index];
            final course = enrollment.courseVersion?.course;
            final status = _getTrainingStatus(enrollment);
            final dueDate = _getDueDate(enrollment);
            final resumeLabel = _resumeLabels[enrollment.id];

            // Calculate progress from real data
            final progress = enrollment.status == 'completed'
                ? 1.0
                : enrollment.status == 'in_progress'
                    ? (progressMap[enrollment.id] ?? 0.0) / 100.0
                    : 0.0;

            return CourseCard(
              title: course?.title ?? 'Training Course',
              status: status,
              progress: progress,
              dueDate: dueDate,
              resumeLabel: resumeLabel,
              onTap: () {
                context.go(
                  '/employee/course/${course?.id ?? enrollment.courseVersionId}',
                  extra: {
                    'courseVersionId': enrollment.courseVersionId.toString(),
                    'enrollmentId': enrollment.id?.toString(),
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SUPPORTING WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

/// Stat card with icon, value, and label — Refactoring UI hierarchy
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isUrgent = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s5), // 20px inner padding
      decoration: BoxDecoration(
        color: AppColors.n0, // Layer 1: white card
        borderRadius: AppRadius.br2, // 10px radius
        boxShadow: AppShadows.sh1, // Subtle elevation
        border: isUrgent
            ? Border.all(color: color.withValues(alpha: 0.3), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon row with optional urgency dot
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.s2), // 8px
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: AppRadius.br2,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (isUrgent) ...[
                const Spacer(),
                // Pulsing urgency indicator
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.6, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: value),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.s3), // 12px
          // Value — large, colored, prominent
          Text(
            value,
            style: AppTypography.display.copyWith(
              color: color,
              fontSize: 32, // Larger for hierarchy
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.s1), // 4px micro gap
          // Label — caption style
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.n500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Course metadata chip — icon + label in muted style
class _CourseMetaChip extends StatelessWidget {
  const _CourseMetaChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.n400),
        const SizedBox(width: 4), // 4px micro gap
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.n400,
          ),
        ),
      ],
    );
  }
}

/// Tab with count badge — badge color indicates status
class _TabWithBadge extends StatelessWidget {
  const _TabWithBadge({
    required this.label,
    required this.count,
    this.badgeColor,
  });

  final String label;
  final int count;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: AppSpacing.s2), // 8px
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s2, // 8px
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: badgeColor ?? AppColors.n200,
              borderRadius: AppRadius.br5, // Pill
            ),
            child: Text(
              '$count',
              style: AppTypography.caption.copyWith(
                color: badgeColor != null ? AppColors.n0 : AppColors.n600,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
