// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE BATCH DETAIL SCREEN (EMP-BATCH-02)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Detailed view for a training session the employee is enrolled in.
// Shows session info, trainer details, schedule, and allows joining.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/employee_batch_providers.dart';
import '../../shared/communication_sheets.dart';

class EmployeeBatchDetailScreen extends ConsumerWidget {
  const EmployeeBatchDetailScreen({super.key, required this.batchId});

  final int batchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchAsync = ref.watch(employeeBatchDetailProvider(batchId));

    return batchAsync.when(
      data: (batch) {
        if (batch == null) {
          return _buildNotFoundState(context);
        }
        return _SessionDetailContent(batch: batch);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _buildErrorState(context, ref, e.toString()),
    );
  }

  Widget _buildNotFoundState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: PharmaColors.gray400),
          const SizedBox(height: PharmaSpacing.md),
          Text(
            'Session Not Found',
            style: PharmaTypography.headingMedium,
          ),
          const SizedBox(height: PharmaSpacing.sm),
          Text(
            'The requested training session could not be found.',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => context.go('/employee/my-batches'),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Back to My Batches'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 64, color: PharmaColors.danger),
          const SizedBox(height: PharmaSpacing.md),
          Text('Failed to load session', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.sm),
          Text(error, style: PharmaTypography.caption),
          const SizedBox(height: PharmaSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => ref.invalidate(employeeBatchDetailProvider(batchId)),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _SessionDetailContent extends StatelessWidget {
  const _SessionDetailContent({required this.batch});

  final TrainingBatch batch;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');
    final now = DateTime.now();

    final isUpcoming = batch.startDate.isAfter(now) && batch.status == 'scheduled';
    final isActive = batch.status == 'in_progress' || batch.status == 'active';
    final isCompleted = batch.status == 'completed';
    final isToday = batch.startDate.year == now.year &&
        batch.startDate.month == now.month &&
        batch.startDate.day == now.day;

    // Calculate days until session
    final daysUntil = batch.startDate.difference(now).inDays;
    final hoursUntil = batch.startDate.difference(now).inHours % 24;

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        // ── BACK BUTTON + PAGE HEADER ──
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/employee/my-batches'),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Back to My Batches',
            ),
            const SizedBox(width: PharmaSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    batch.courseVersion?.course?.title ?? 'Training Session',
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    batch.name,
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            _buildStatusBadge(batch.status, isToday),
          ],
        ),
        const SizedBox(height: PharmaSpacing.sectionGap),

        // ── COUNTDOWN CARD (for upcoming sessions) ──
        if (isUpcoming && daysUntil <= 7)
          _buildCountdownCard(daysUntil, hoursUntil, isToday),
        if (isUpcoming && daysUntil <= 7) const SizedBox(height: PharmaSpacing.md),

        // ── SESSION INFO CARDS ──
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Session Details
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildSessionInfoCard(dateFormat, timeFormat),
                  const SizedBox(height: PharmaSpacing.md),
                  _buildInstructorCard(),
                ],
              ),
            ),
            const SizedBox(width: PharmaSpacing.md),
            // Right Column - Actions & Status
            Expanded(
              child: Column(
                children: [
                  _buildActionCard(context, isUpcoming, isActive, isCompleted, isToday),
                  const SizedBox(height: PharmaSpacing.md),
                  _buildEnrollmentStatusCard(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: PharmaSpacing.sectionGap),

        // ── COURSE DESCRIPTION ──
        _buildDescriptionCard(),
        const SizedBox(height: PharmaSpacing.md),

        // ── WHAT TO BRING / PREPARE ──
        _buildPreparationCard(),

        if (batch.id != null) ...[
          const SizedBox(height: PharmaSpacing.sectionGap),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              border: Border.all(color: PharmaColors.borderLight),
              borderRadius: BorderRadius.circular(PharmaRadius.md),
            ),
            child: EmployeeBatchFeedSection(batchId: batch.id!),
          ),
        ],
      ],
    );
  }

  Widget _buildCountdownCard(int daysUntil, int hoursUntil, bool isToday) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [PharmaColors.emerald600, PharmaColors.emerald500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.md,
      ),
      child: Row(
        children: [
          Icon(
            isToday ? Icons.celebration_rounded : Icons.schedule_rounded,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isToday ? 'Training is TODAY!' : 'Training Session Starting Soon',
                  style: PharmaTypography.headingSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isToday
                      ? 'Get ready to join your training session'
                      : daysUntil == 0
                          ? 'Starting in $hoursUntil hours'
                          : 'Starting in $daysUntil ${daysUntil == 1 ? 'day' : 'days'}',
                  style: PharmaTypography.body.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          if (isToday)
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: PharmaColors.emerald600,
              ),
              child: const Text('Join Now'),
            ),
        ],
      ),
    );
  }

  Widget _buildSessionInfoCard(DateFormat dateFormat, DateFormat timeFormat) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session Details',
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          _buildInfoRow(
            icon: Icons.calendar_today_rounded,
            label: 'Date',
            value: dateFormat.format(batch.startDate),
          ),
          const SizedBox(height: PharmaSpacing.md),
          _buildInfoRow(
            icon: Icons.access_time_rounded,
            label: 'Time',
            value: '${timeFormat.format(batch.startDate)} - ${timeFormat.format(batch.endDate)}',
          ),
          const SizedBox(height: PharmaSpacing.md),
          _buildInfoRow(
            icon: Icons.timelapse_rounded,
            label: 'Duration',
            value: _calculateDuration(),
          ),
          const SizedBox(height: PharmaSpacing.md),
          _buildInfoRow(
            icon: Icons.location_on_rounded,
            label: 'Location',
            value: batch.location ?? 'Virtual Session',
            isLink: batch.location?.toLowerCase().contains('virtual') ?? true,
          ),
          const SizedBox(height: PharmaSpacing.md),
          _buildInfoRow(
            icon: Icons.people_rounded,
            label: 'Class Size',
            value: '${batch.enrolledCount} / ${batch.capacity} enrolled',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: PharmaColors.gray100,
            borderRadius: BorderRadius.circular(PharmaRadius.sm),
          ),
          child: Icon(icon, size: 18, color: PharmaColors.textSecondary),
        ),
        const SizedBox(width: PharmaSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: PharmaTypography.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isLink ? PharmaColors.emerald600 : PharmaColors.textPrimary,
                  decoration: isLink ? TextDecoration.underline : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructorCard() {
    final instructor = batch.instructor;
    
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Instructor',
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: PharmaColors.emerald100,
                child: Text(
                  instructor != null
                      ? '${instructor.firstName.substring(0, 1)}${instructor.lastName.substring(0, 1)}'
                      : 'TB',
                  style: TextStyle(
                    color: PharmaColors.emerald700,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instructor != null
                          ? '${instructor.firstName} ${instructor.lastName}'
                          : 'Instructor TBD',
                      style: PharmaTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (instructor?.email != null)
                      Text(
                        instructor!.email,
                        style: PharmaTypography.caption.copyWith(
                          color: PharmaColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.email_outlined),
                tooltip: 'Contact Instructor',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    bool isUpcoming,
    bool isActive,
    bool isCompleted,
    bool isToday,
  ) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: isActive || isToday ? PharmaColors.emerald50 : PharmaColors.cardBg,
        border: Border.all(
          color: isActive || isToday ? PharmaColors.emerald200 : PharmaColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quick Actions',
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          if (isActive || isToday) ...[
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.login_rounded, size: 18),
              label: const Text('Join Session'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                minimumSize: const Size.fromHeight(44),
              ),
            ),
            const SizedBox(height: PharmaSpacing.sm),
          ],
          if (isUpcoming) ...[
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month_rounded, size: 18),
              label: const Text('Add to Calendar'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
            ),
            const SizedBox(height: PharmaSpacing.sm),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined, size: 18),
              label: const Text('Set Reminder'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
            ),
          ],
          if (isCompleted) ...[
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text('Download Materials'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
            ),
            const SizedBox(height: PharmaSpacing.sm),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.workspace_premium_rounded, size: 18),
              label: const Text('View Certificate'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEnrollmentStatusCard() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Status',
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          Row(
            children: [
              Icon(Icons.check_circle_rounded, color: PharmaColors.success, size: 20),
              const SizedBox(width: PharmaSpacing.sm),
              Text(
                'Enrolled',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.sm),
          Text(
            'You are confirmed for this training session.',
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
    final course = batch.courseVersion?.course;
    
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This Training',
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          Text(
            course?.description ?? batch.notes ?? 'No description available for this training session.',
            style: PharmaTypography.body.copyWith(
              color: PharmaColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparationCard() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.infoBg,
        border: Border.all(color: PharmaColors.info.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, color: PharmaColors.info, size: 20),
              const SizedBox(width: PharmaSpacing.sm),
              Text(
                'How to Prepare',
                style: PharmaTypography.headingSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PharmaColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.md),
          _buildPrepItem('Review any pre-reading materials shared by your instructor'),
          _buildPrepItem('Ensure your computer/device is charged and connected to internet'),
          _buildPrepItem('Find a quiet space free from distractions'),
          _buildPrepItem('Have a notebook ready for taking notes'),
          _buildPrepItem('Join the session 5 minutes early to test your connection'),
        ],
      ),
    );
  }

  Widget _buildPrepItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: PharmaColors.info),
          const SizedBox(width: PharmaSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, bool isToday) {
    final color = isToday ? PharmaColors.emerald600 : _getStatusColor(status);
    final label = isToday ? 'Today' : _getStatusLabel(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(status), size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: PharmaTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return PharmaColors.info;
      case 'in_progress':
      case 'active':
        return PharmaColors.emerald600;
      case 'completed':
        return PharmaColors.success;
      case 'cancelled':
        return PharmaColors.danger;
      default:
        return PharmaColors.gray600;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'scheduled':
        return Icons.schedule_rounded;
      case 'in_progress':
      case 'active':
        return Icons.play_circle_rounded;
      case 'completed':
        return Icons.check_circle_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'scheduled':
        return 'Upcoming';
      case 'in_progress':
      case 'active':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  String _calculateDuration() {
    final diff = batch.endDate.difference(batch.startDate);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    
    if (hours > 0 && minutes > 0) {
      return '$hours hr $minutes min';
    } else if (hours > 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'}';
    } else {
      return '$minutes minutes';
    }
  }
}
