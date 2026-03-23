// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER BATCH DETAIL SCREEN (TRN-BATCH-02)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Detailed view for a training batch with participant management.
// Allows trainers to:
//  - View batch information
//  - See participant list with progress
//  - Mark attendance
//  - Start/complete training sessions
//  - View completion statistics
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/trainer_batch_providers.dart';

class TrainerBatchDetailScreen extends ConsumerWidget {
  const TrainerBatchDetailScreen({super.key, required this.batchId});

  final int batchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchAsync = ref.watch(trainerBatchDetailProvider(batchId));

    return batchAsync.when(
      data: (batch) {
        if (batch == null) {
          return _buildNotFoundState(context);
        }
        return _BatchDetailContent(batch: batch);
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
            'Batch Not Found',
            style: PharmaTypography.headingMedium,
          ),
          const SizedBox(height: PharmaSpacing.sm),
          Text(
            'The requested training batch could not be found.',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => context.go('/trainer/batches'),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Back to Batches'),
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
          Text('Failed to load batch', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.sm),
          Text(error, style: PharmaTypography.caption),
          const SizedBox(height: PharmaSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => ref.invalidate(trainerBatchDetailProvider(batchId)),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _BatchDetailContent extends ConsumerStatefulWidget {
  const _BatchDetailContent({required this.batch});

  final TrainingBatch batch;

  @override
  ConsumerState<_BatchDetailContent> createState() => _BatchDetailContentState();
}

class _BatchDetailContentState extends ConsumerState<_BatchDetailContent>
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

  @override
  Widget build(BuildContext context) {
    final batch = widget.batch;
    final dateFormat = DateFormat('MMM d, yyyy');
    final isActive = batch.status == 'in_progress' || batch.status == 'active';
    final isCompleted = batch.status == 'completed';
    final isScheduled = batch.status == 'scheduled';

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        // ── BACK BUTTON + PAGE HEADER ──
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/trainer/batches'),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Back to Batches',
            ),
            const SizedBox(width: PharmaSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    batch.name,
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    batch.courseVersion?.course?.title ?? 'Course TBD',
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            _buildStatusBadge(batch.status),
          ],
        ),
        const SizedBox(height: PharmaSpacing.sectionGap),

        // ── BATCH INFO CARD ──
        Container(
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
                'Session Information',
                style: PharmaTypography.headingSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: PharmaSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.calendar_today_rounded,
                      label: 'Start Date',
                      value: dateFormat.format(batch.startDate),
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.event_rounded,
                      label: 'End Date',
                      value: dateFormat.format(batch.endDate),
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.location_on_rounded,
                      label: 'Location',
                      value: batch.location ?? 'Virtual',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.people_rounded,
                      label: 'Capacity',
                      value: '${batch.enrolledCount} / ${batch.capacity}',
                    ),
                  ),
                ],
              ),
              if (batch.notes != null && batch.notes!.isNotEmpty) ...[
                const SizedBox(height: PharmaSpacing.md),
                Divider(color: PharmaColors.borderLight),
                const SizedBox(height: PharmaSpacing.md),
                Text(
                  'Notes',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: PharmaSpacing.xs),
                Text(
                  batch.notes!,
                  style: PharmaTypography.body,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: PharmaSpacing.md),

        // ── PROGRESS CARD (for active/completed) ──
        if (isActive || isCompleted)
          _buildProgressCard(batch),
        const SizedBox(height: PharmaSpacing.md),

        // ── ACTION BUTTONS ──
        _buildActionButtons(batch, isScheduled, isActive, isCompleted),
        const SizedBox(height: PharmaSpacing.sectionGap),

        // ── TABS: Participants, Attendance, Reports ──
        Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            border: Border.all(color: PharmaColors.borderLight),
            borderRadius: BorderRadius.circular(PharmaRadius.md),
          ),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: PharmaColors.emerald600,
                unselectedLabelColor: PharmaColors.textSecondary,
                indicatorColor: PharmaColors.emerald600,
                tabs: const [
                  Tab(text: 'Participants'),
                  Tab(text: 'Attendance'),
                  Tab(text: 'Reports'),
                ],
              ),
              SizedBox(
                height: 400,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildParticipantsTab(),
                    _buildAttendanceTab(),
                    _buildReportsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: PharmaColors.textTertiary),
        const SizedBox(width: PharmaSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textTertiary,
              ),
            ),
            Text(
              value,
              style: PharmaTypography.body.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = _getStatusColor(status);
    final label = _getStatusLabel(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(status), size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: PharmaTypography.body.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(TrainingBatch batch) {
    final progressPercent = batch.enrolledCount > 0
        ? (batch.completedCount / batch.enrolledCount * 100)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.emerald50,
        border: Border.all(color: PharmaColors.emerald200),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completion Progress',
                style: PharmaTypography.headingSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PharmaColors.emerald700,
                ),
              ),
              Text(
                '${progressPercent.toStringAsFixed(0)}%',
                style: PharmaTypography.headingLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: PharmaColors.emerald600,
                ),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progressPercent / 100,
              backgroundColor: PharmaColors.emerald200,
              valueColor: const AlwaysStoppedAnimation(PharmaColors.emerald600),
              minHeight: 12,
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressStat('Enrolled', '${batch.enrolledCount}', PharmaColors.info),
              _buildProgressStat('Completed', '${batch.completedCount}', PharmaColors.success),
              _buildProgressStat('Pending', '${batch.enrolledCount - batch.completedCount}', PharmaColors.warning),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: PharmaTypography.headingMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: PharmaTypography.caption.copyWith(
            color: PharmaColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    TrainingBatch batch,
    bool isScheduled,
    bool isActive,
    bool isCompleted,
  ) {
    return Row(
      children: [
        if (isScheduled) ...[
          FilledButton.icon(
            onPressed: () => _showStartSessionDialog(),
            icon: const Icon(Icons.play_circle_outline, size: 18),
            label: const Text('Start Session'),
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
        ],
        if (isActive) ...[
          FilledButton.icon(
            onPressed: () => _showMarkAttendanceDialog(),
            icon: const Icon(Icons.how_to_reg_rounded, size: 18),
            label: const Text('Mark Attendance'),
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.info,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
          FilledButton.icon(
            onPressed: () => _showCompleteSessionDialog(),
            icon: const Icon(Icons.check_circle_outline, size: 18),
            label: const Text('Complete Session'),
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.success,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
        ],
        if (isCompleted) ...[
          OutlinedButton.icon(
            onPressed: () => _exportReport(),
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const Text('Export Report'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
          OutlinedButton.icon(
            onPressed: () => _issueCertificates(),
            icon: const Icon(Icons.workspace_premium_rounded, size: 18),
            label: const Text('Issue Certificates'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
        ],
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () => _showEditBatchDialog(),
          icon: const Icon(Icons.edit_outlined, size: 18),
          label: const Text('Edit Batch'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantsTab() {
    // In production, this would use batchParticipantsProvider
    // For now, show placeholder with mock data structure
    return Padding(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Enrolled Participants',
                style: PharmaTypography.headingSmall,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_rounded, size: 18),
                label: const Text('Add Participant'),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.md),
          Expanded(
            child: widget.batch.enrolledCount == 0
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.people_outline, size: 48, color: PharmaColors.gray400),
                        const SizedBox(height: PharmaSpacing.sm),
                        Text(
                          'No participants enrolled yet',
                          style: PharmaTypography.body.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.batch.enrolledCount,
                    itemBuilder: (context, index) => _buildParticipantRow(index),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantRow(int index) {
    // Mock participant data
    final names = ['Alice Johnson', 'Bob Smith', 'Carol Davis', 'David Wilson', 'Eva Martinez'];
    final depts = ['Quality Assurance', 'Manufacturing', 'R&D', 'Packaging', 'Quality Control'];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: PharmaColors.borderLight),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: PharmaColors.emerald100,
            child: Text(
              names[index % names.length].substring(0, 1),
              style: const TextStyle(
                color: PharmaColors.emerald700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  names[index % names.length],
                  style: PharmaTypography.body.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  depts[index % depts.length],
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildParticipantStatusBadge(index % 3 == 0 ? 'completed' : 'in_progress'),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantStatusBadge(String status) {
    final isCompleted = status == 'completed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCompleted ? PharmaColors.successBg : PharmaColors.warningBg,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(
        isCompleted ? 'Completed' : 'In Progress',
        style: PharmaTypography.caption.copyWith(
          color: isCompleted ? PharmaColors.success : PharmaColors.warning,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAttendanceTab() {
    return Padding(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.how_to_reg_rounded, size: 48, color: PharmaColors.gray400),
            const SizedBox(height: PharmaSpacing.md),
            Text(
              'Attendance Tracking',
              style: PharmaTypography.headingSmall,
            ),
            const SizedBox(height: PharmaSpacing.sm),
            Text(
              'Mark attendance during active training sessions.',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (widget.batch.status == 'in_progress' || widget.batch.status == 'active') ...[
              const SizedBox(height: PharmaSpacing.lg),
              FilledButton.icon(
                onPressed: () => _showMarkAttendanceDialog(),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Mark Attendance Now'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReportsTab() {
    return Padding(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assessment_rounded, size: 48, color: PharmaColors.gray400),
            const SizedBox(height: PharmaSpacing.md),
            Text(
              'Batch Reports',
              style: PharmaTypography.headingSmall,
            ),
            const SizedBox(height: PharmaSpacing.sm),
            Text(
              'Generate and export training reports for compliance documentation.',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf_rounded, size: 18),
                  label: const Text('Export PDF'),
                ),
                const SizedBox(width: PharmaSpacing.md),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.table_chart_rounded, size: 18),
                  label: const Text('Export Excel'),
                ),
              ],
            ),
          ],
        ),
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
        return 'Scheduled';
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

  void _showStartSessionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Start Training Session'),
        content: const Text(
          'Are you ready to start this training session? This will mark the batch as "In Progress".',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Training session started!')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
            child: const Text('Start Session'),
          ),
        ],
      ),
    );
  }

  void _showMarkAttendanceDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mark Attendance'),
        content: const Text(
          'This feature allows you to record participant attendance for the current session.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attendance recorded!')),
              );
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showCompleteSessionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Complete Training Session'),
        content: const Text(
          'Are you sure you want to complete this training session? This will mark the batch as "Completed".',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Training session completed!')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.success),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _showEditBatchDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit batch dialog would open here')),
    );
  }

  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting batch report...')),
    );
  }

  void _issueCertificates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Certificate issuance dialog would open here')),
    );
  }
}
