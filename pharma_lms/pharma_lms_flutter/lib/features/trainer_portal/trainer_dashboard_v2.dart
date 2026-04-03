// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINER DASHBOARD V2 (TRN-09)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer
// Zones: Stat cards · Courses requiring action · Recent activity · Quick actions
// FDA 21 CFR Part 11 · GMP Annex 11 · ALCOA+
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';
import 'widgets/trainer_page_scaffold.dart';

// ─── PROVIDERS ───────────────────────────────────────────────────────────────

final trainerCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  try {
    final allCourses = await client.course.listCourses(
      organizationId: user.organizationId,
    );
    return allCourses.where((c) => c.createdById == user.id).toList();
  } catch (_) {
    return [];
  }
});

final allOrgCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  try {
    return await client.course.listCourses(
      organizationId: user.organizationId,
    );
  } catch (_) {
    return [];
  }
});

final _trainerAuditProvider = FutureProvider<List<AuditTrail>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  try {
    return await client.audit.getMyAuditTrail(
      limit: 10,
      userId: user.id,
    );
  } catch (_) {
    return [];
  }
});

final _trainerAvgPassRateProvider = FutureProvider<double?>((ref) async {
  final courses = await ref.watch(trainerCoursesProvider.future);
  if (courses.isEmpty) return null;
  try {
    var totalPassRate = 0.0;
    var count = 0;
    for (final course in courses) {
      if (course.id == null) continue;
      final versions = await client.course.getCourseVersions(course.id!);
      for (final cv in versions) {
        if (cv.id == null) continue;
        final analytics = await client.analytics.getCourseAnalytics(cv.id!);
        if (analytics.totalAttempts > 0) {
          totalPassRate += analytics.passRate;
          count++;
        }
      }
    }
    if (count == 0) return null;
    return totalPassRate / count;
  } catch (_) {
    return null;
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER DASHBOARD V2
// ═══════════════════════════════════════════════════════════════════════════════

class TrainerDashboardV2 extends ConsumerWidget {
  const TrainerDashboardV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final coursesAsync = ref.watch(trainerCoursesProvider);

    return userAsync.when(
      loading: () => const TrainerPageLoading(cardCount: 4),
      error: (e, _) => TrainerPageError(
        message: '$e',
        onRetry: () => ref.invalidate(currentUserProvider),
      ),
      data: (user) => coursesAsync.when(
        loading: () => const _DashboardSkeleton(),
        error: (e, _) => TrainerPageError(
          message: '$e',
          onRetry: () => ref.invalidate(trainerCoursesProvider),
        ),
        data: (myCourses) => _DashboardContent(
          user: user,
          myCourses: myCourses,
        ),
      ),
    );
  }
}

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent({
    required this.user,
    required this.myCourses,
  });

  final dynamic user;
  final List<Course> myCourses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draftCount = myCourses.where((c) => c.status == 'draft').length;
    final pendingQACount =
        myCourses.where((c) => c.status == 'pending_qa' || c.status == 'under_review').length;
    final publishedCount =
        myCourses.where((c) => c.status == 'approved' || c.status == 'published' || c.status == 'effective').length;

    final avgPassRateAsync = ref.watch(_trainerAvgPassRateProvider);
    final passRateDisplay = avgPassRateAsync.whenOrNull(
      data: (rate) =>
          rate != null ? '${(rate * 100).toStringAsFixed(0)}%' : '—',
    ) ?? '…';

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(trainerCoursesProvider);
        ref.invalidate(currentUserProvider);
        ref.invalidate(_trainerAuditProvider);
        ref.invalidate(_trainerAvgPassRateProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          // ── PAGE HEADER ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, ${user?.firstName ?? 'Trainer'}',
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage your courses, assessments, and training content. Create new courses from the Courses page.',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ],
          ),

          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── ZONE 1: STAT CARDS ──
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 5
                  : constraints.maxWidth > 600
                      ? 3
                      : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.6,
                children: [
                  _StatCard(
                    label: 'My Courses',
                    value: '${myCourses.length}',
                    icon: Icons.menu_book_rounded,
                    color: PharmaColors.emerald600,
                    bgColor: PharmaColors.emerald50,
                    onTap: () => context.go('/trainer/courses'),
                  ),
                  _StatCard(
                    label: 'Pending QA',
                    value: '$pendingQACount',
                    icon: Icons.pending_actions_rounded,
                    color: PharmaColors.warning,
                    bgColor: PharmaColors.warningBg,
                    isAlert: pendingQACount > 0,
                    onTap: () => context.go('/trainer/courses'),
                  ),
                  _StatCard(
                    label: 'Published',
                    value: '$publishedCount',
                    icon: Icons.check_circle_rounded,
                    color: PharmaColors.emerald600,
                    bgColor: PharmaColors.successBg,
                    onTap: () => context.go('/trainer/courses'),
                  ),
                  _StatCard(
                    label: 'Drafts',
                    value: '$draftCount',
                    icon: Icons.edit_note_rounded,
                    color: PharmaColors.gray600,
                    bgColor: PharmaColors.gray100,
                    onTap: () => context.go('/trainer/courses'),
                  ),
                  _StatCard(
                    label: 'Avg. Pass Rate',
                    value: passRateDisplay,
                    icon: Icons.trending_up_rounded,
                    color: PharmaColors.emerald600,
                    bgColor: PharmaColors.emerald50,
                    onTap: () => context.go('/trainer/analytics'),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── ZONE 2: COURSES REQUIRING ACTION ──
          _buildCoursesRequiringAction(context, myCourses),

          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── ZONE 3 + ZONE 4: Activity + Quick Actions (side by side on desktop) ──
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _RecentActivitySection()),
                    const SizedBox(width: PharmaSpacing.gridGap),
                    Expanded(flex: 2, child: _buildQuickActions(context)),
                  ],
                );
              }
              return Column(
                children: [
                  _RecentActivitySection(),
                  const SizedBox(height: PharmaSpacing.sectionGap),
                  _buildQuickActions(context),
                ],
              );
            },
          ),

          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── GUIDELINES PANEL ──
          _buildGuidelinesPanel(context),
        ],
      ),
    );
  }

  // ── ZONE 2: Courses requiring action ──
  Widget _buildCoursesRequiringAction(BuildContext context, List<Course> courses) {
    final actionCourses = courses.where((c) =>
        c.status == 'pending_qa' ||
        c.status == 'under_review' ||
        c.status == 'rejected' ||
        c.status == 'draft').toList();

    return _SectionCard(
      title: 'Courses Requiring Action',
      icon: Icons.warning_amber_rounded,
      iconColor: PharmaColors.warning,
      trailing: Text(
        '${actionCourses.length} items',
        style: PharmaTypography.caption,
      ),
      child: actionCourses.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(Icons.check_circle_outline, size: 48, color: PharmaColors.emerald500),
                  const SizedBox(height: 12),
                  Text(
                    'All caught up!',
                    style: PharmaTypography.headingSmall.copyWith(
                      color: PharmaColors.emerald700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No courses require your attention right now.',
                    style: PharmaTypography.body,
                  ),
                ],
              ),
            )
          : ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: actionCourses.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: PharmaColors.borderLight,
              ),
              itemBuilder: (context, index) {
                final course = actionCourses[index];
                return _ActionCourseRow(course: course);
              },
            ),
            ),
    );
  }

  // ── ZONE 4: Quick Actions Panel ──
  Widget _buildQuickActions(BuildContext context) {
    return _SectionCard(
      title: 'Quick Actions',
      icon: Icons.bolt_rounded,
      iconColor: PharmaColors.warning,
      child: Column(
        children: [
          _QuickActionTile(
            icon: Icons.menu_book_outlined,
            label: 'Courses',
            subtitle: 'View list, create new courses, and open the builder',
            color: PharmaColors.emerald600,
            onTap: () => context.go('/trainer/courses'),
          ),
          _QuickActionTile(
            icon: Icons.auto_awesome,
            label: 'Generate Questions from SOP',
            subtitle: 'AI-assisted question generation',
            color: PharmaColors.purple,
            onTap: () => context.go('/trainer/ai-generate'),
          ),
          _QuickActionTile(
            icon: Icons.analytics_outlined,
            label: 'View Analytics',
            subtitle: 'Course performance metrics',
            color: PharmaColors.info,
            onTap: () => context.go('/trainer/analytics'),
          ),
          _QuickActionTile(
            icon: Icons.description_outlined,
            label: 'Review Pending SOPs',
            subtitle: 'SOP documents library',
            color: PharmaColors.warning,
            onTap: () => context.go('/trainer/sop-documents'),
          ),
          _QuickActionTile(
            icon: Icons.assignment_ind_outlined,
            label: 'Assign Training',
            subtitle: 'Bulk or individual assignment',
            color: PharmaColors.orange,
            onTap: () => context.go('/trainer/assignments'),
          ),
        ],
      ),
    );
  }

  // ── GUIDELINES PANEL ──
  Widget _buildGuidelinesPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.infoBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.infoBg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: PharmaColors.infoText),
              const SizedBox(width: 8),
              Text(
                'Trainer Content Creation Guidelines',
                style: PharmaTypography.headingSmall.copyWith(
                  color: PharmaColors.infoText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _GuidelineRow('All content follows DRAFT → UNDER REVIEW → QA APPROVED workflow'),
          _GuidelineRow('Every upload computes SHA-256 hash for ALCOA+ compliance'),
          _GuidelineRow('Assessment question pools must be ≥ 2× display count (anti-cheating)'),
          _GuidelineRow('AI-generated questions always labeled — require trainer review before active'),
          _GuidelineRow('QA approval requires e-signature under 21 CFR §11.50'),
          _GuidelineRow('Published course versions are immutable — create new version to update'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ZONE 3: RECENT ACTIVITY (real data)
// ═══════════════════════════════════════════════════════════════════════════════

class _RecentActivitySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditAsync = ref.watch(_trainerAuditProvider);

    return _SectionCard(
      title: 'Recent Activity',
      icon: Icons.history_rounded,
      iconColor: PharmaColors.info,
      trailing: TextButton(
        onPressed: () => context.go('/trainer/audit-log'),
        child: Text(
          'View full audit log',
          style: PharmaTypography.caption.copyWith(
            color: PharmaColors.emerald600,
          ),
        ),
      ),
      child: auditAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Unable to load recent activity',
            style: PharmaTypography.body.copyWith(
              color: PharmaColors.textTertiary,
            ),
          ),
        ),
        data: (entries) {
          if (entries.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                Icon(Icons.history, size: 40, color: PharmaColors.gray300),
                const SizedBox(height: 8),
                Text(
                  'No recent activity',
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This feed lists audit events for your user (course edits, QA submissions, etc.). '
                  'The demo trainer account gets sample rows after running comprehensive seed. '
                  'New trainers will see entries as they work in the course builder.',
                  textAlign: TextAlign.center,
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textQuaternary,
                  ),
                ),
              ]),
            );
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 360),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: entries.map((entry) {
                  final icon = _iconForAuditAction(entry.action);
                  final color = _colorForAuditAction(entry.action);
                  final title = _titleForAuditAction(entry.action);
                  final subtitle =
                      '${entry.entityType} #${entry.entityId}';
                  final timeAgo = _formatTimeAgo(entry.timestamp);

                  return _ActivityItem(
                    icon: icon,
                    iconColor: color,
                    title: title,
                    subtitle: subtitle,
                    time: timeAgo,
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  static IconData _iconForAuditAction(String action) {
    final lower = action.toLowerCase();
    if (lower.contains('create')) return Icons.add_circle_outline;
    if (lower.contains('submit') || lower.contains('pending')) {
      return Icons.send_rounded;
    }
    if (lower.contains('approv') || lower.contains('publish')) {
      return Icons.check_circle;
    }
    if (lower.contains('upload')) return Icons.upload_file;
    if (lower.contains('question') || lower.contains('ai')) {
      return Icons.auto_awesome;
    }
    if (lower.contains('reject')) return Icons.cancel_outlined;
    if (lower.contains('update') || lower.contains('edit')) {
      return Icons.edit_outlined;
    }
    if (lower.contains('delete')) return Icons.delete_outline;
    return Icons.history;
  }

  static Color _colorForAuditAction(String action) {
    final lower = action.toLowerCase();
    if (lower.contains('create')) return PharmaColors.emerald600;
    if (lower.contains('submit') || lower.contains('pending')) {
      return PharmaColors.warning;
    }
    if (lower.contains('approv') || lower.contains('publish')) {
      return PharmaColors.success;
    }
    if (lower.contains('upload')) return PharmaColors.info;
    if (lower.contains('question') || lower.contains('ai')) {
      return PharmaColors.purple;
    }
    if (lower.contains('reject') || lower.contains('delete')) {
      return PharmaColors.danger;
    }
    return PharmaColors.gray500;
  }

  static String _titleForAuditAction(String action) {
    return action
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (m) => ' ${m.group(0)}',
        )
        .trim();
  }

  static String _formatTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(timestamp);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// REUSABLE COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _StatCard extends StatefulWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.bgColor,
    this.isAlert = false,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final bool isAlert;
  final VoidCallback? onTap;

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          padding: const EdgeInsets.all(PharmaSpacing.md),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(
              color: widget.isAlert
                  ? widget.color.withValues(alpha: 0.4)
                  : PharmaColors.borderLight,
            ),
            boxShadow: _hovered ? PharmaShadows.md : PharmaShadows.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: widget.bgColor,
                      borderRadius: BorderRadius.circular(PharmaRadius.md),
                    ),
                    child: Icon(widget.icon, size: 16, color: widget.color),
                  ),
                  if (widget.isAlert)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                widget.value,
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: PharmaTypography.caption.copyWith(fontSize: 11),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Row(
              children: [
                Icon(icon, size: 18, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
                ),
                const Spacer(),
                ?trailing,
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          child,
        ],
      ),
    );
  }
}

class _ActionCourseRow extends StatelessWidget {
  const _ActionCourseRow({required this.course});

  final Course course;

  Color get _statusColor {
    switch (course.status) {
      case 'pending_qa':
      case 'under_review':
        return PharmaColors.warning;
      case 'rejected':
        return PharmaColors.danger;
      case 'draft':
        return PharmaColors.gray500;
      default:
        return PharmaColors.gray500;
    }
  }

  Color get _statusBg {
    switch (course.status) {
      case 'pending_qa':
      case 'under_review':
        return PharmaColors.warningBg;
      case 'rejected':
        return PharmaColors.dangerBg;
      default:
        return PharmaColors.gray100;
    }
  }

  String get _statusLabel {
    switch (course.status) {
      case 'pending_qa':
      case 'under_review':
        return 'UNDER REVIEW';
      case 'rejected':
        return 'REJECTED';
      case 'draft':
        return 'DRAFT';
      default:
        return course.status.toUpperCase();
    }
  }

  String get _actionLabel {
    switch (course.status) {
      case 'pending_qa':
      case 'under_review':
        return 'Awaiting QA feedback';
      case 'rejected':
        return 'Changes requested — review feedback';
      case 'draft':
        return 'Continue editing';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PharmaSpacing.lg,
        vertical: PharmaSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => context.go('/trainer/courses/${course.id}/builder'),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _statusBg,
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                    ),
                    child: Icon(Icons.menu_book_rounded, size: 18, color: _statusColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: PharmaTypography.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        PharmaWorkflowStepper(
                          currentStatus: course.status,
                          steps: const ['draft', 'pending_approval', 'effective'],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _actionLabel,
                          style: PharmaTypography.caption.copyWith(
                            color: _statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusBg,
                      borderRadius: PharmaRadius.pillRadius,
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, size: 18, color: PharmaColors.textQuaternary),
                ],
              ),
            ),
          ),
          if (course.id != null)
            IconButton(
              tooltip: 'QA thread',
              icon: const Icon(Icons.forum_outlined),
              onPressed: () => openCourseQaThreadForCourse(
                context,
                courseId: course.id!,
                courseTitle: course.title,
              ),
            ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PharmaSpacing.lg,
        vertical: PharmaSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PharmaTypography.bodyMedium.copyWith(fontSize: 13)),
                Text(subtitle, style: PharmaTypography.caption),
              ],
            ),
          ),
          Text(time, style: PharmaTypography.caption.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatefulWidget {
  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: PharmaSpacing.lg,
            vertical: PharmaSpacing.md,
          ),
          color: _hovered ? PharmaColors.gray50 : Colors.transparent,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PharmaRadius.lg),
                ),
                child: Icon(widget.icon, size: 18, color: widget.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.label, style: PharmaTypography.bodyMedium.copyWith(fontSize: 13)),
                    Text(widget.subtitle, style: PharmaTypography.caption),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: PharmaColors.textQuaternary),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuidelineRow extends StatelessWidget {
  const _GuidelineRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, size: 16, color: PharmaColors.infoText),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.infoText,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── SKELETON LOADER ──

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Container(
          height: 48,
          width: 300,
          decoration: BoxDecoration(
            color: PharmaColors.gray100,
            borderRadius: PharmaRadius.cardRadius,
          ),
        ),
        const SizedBox(height: PharmaSpacing.sectionGap),
        Row(
          children: List.generate(
            4,
            (_) => Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: PharmaColors.gray100,
                  borderRadius: PharmaRadius.cardRadius,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: PharmaSpacing.sectionGap),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: PharmaColors.gray100,
            borderRadius: PharmaRadius.cardRadius,
          ),
        ),
      ],
    );
  }
}
