// ═══════════════════════════════════════════════════════════════════════════════
// TRAINER BATCH LIST SCREEN (TRN-BATCH-01)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Lists all training batches/cohorts assigned to the current trainer.
// Allows viewing, managing participants, and tracking progress.
//
// Features:
//  - View assigned batches with status badges
//  - Filter by status (scheduled, active, completed)
//  - Quick stats (total, active, upcoming, completed)
//  - Navigate to batch details
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/trainer_batch_providers.dart';

class TrainerBatchListScreen extends ConsumerStatefulWidget {
  const TrainerBatchListScreen({super.key});

  @override
  ConsumerState<TrainerBatchListScreen> createState() => _TrainerBatchListScreenState();
}

class _TrainerBatchListScreenState extends ConsumerState<TrainerBatchListScreen> {
  String _selectedStatus = 'all';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(trainerBatchesProvider);
    final statsAsync = ref.watch(trainerBatchStatsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(trainerBatchesProvider);
        ref.invalidate(trainerBatchStatsProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          // ── PAGE HEADER ──
          _buildPageHeader(context),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── STATS CARDS ──
          statsAsync.when(
            data: (stats) => _buildStatsRow(stats),
            loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── FILTERS ──
          _buildFiltersRow(),
          const SizedBox(height: PharmaSpacing.md),

          // ── BATCH LIST ──
          batchesAsync.when(
            data: (batches) => _buildBatchList(batches),
            loading: () => _buildLoadingState(),
            error: (e, _) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Training Batches',
              style: PharmaTypography.headingLarge.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage your assigned instructor-led training sessions',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow(TrainerBatchStats stats) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.2,
          children: [
            _StatCard(
              label: 'Total Batches',
              value: '${stats.totalBatches}',
              icon: Icons.groups_rounded,
              color: PharmaColors.emerald600,
              bgColor: PharmaColors.emerald50,
            ),
            _StatCard(
              label: 'Active Now',
              value: '${stats.activeBatches}',
              icon: Icons.play_circle_rounded,
              color: PharmaColors.info,
              bgColor: PharmaColors.infoBg,
            ),
            _StatCard(
              label: 'Upcoming',
              value: '${stats.upcomingBatches}',
              icon: Icons.schedule_rounded,
              color: PharmaColors.warning,
              bgColor: PharmaColors.warningBg,
            ),
            _StatCard(
              label: 'Completed',
              value: '${stats.completedBatches}',
              icon: Icons.check_circle_rounded,
              color: PharmaColors.success,
              bgColor: PharmaColors.successBg,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search batches...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
          // Status Filter
          Expanded(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Statuses')),
                DropdownMenuItem(value: 'scheduled', child: Text('Scheduled')),
                DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
                DropdownMenuItem(value: 'completed', child: Text('Completed')),
                DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
              ],
              onChanged: (v) => setState(() => _selectedStatus = v ?? 'all'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchList(List<TrainingBatch> batches) {
    var filtered = batches;

    // Apply status filter
    if (_selectedStatus != 'all') {
      filtered = filtered.where((b) => b.status == _selectedStatus).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((b) =>
        b.name.toLowerCase().contains(_searchQuery) ||
        (b.courseVersion?.course?.title.toLowerCase().contains(_searchQuery) ?? false) ||
        (b.location?.toLowerCase().contains(_searchQuery) ?? false)
      ).toList();
    }

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: filtered.map((batch) => _buildBatchCard(batch)).toList(),
    );
  }

  Widget _buildBatchCard(TrainingBatch batch) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final now = DateTime.now();
    
    final isUpcoming = batch.startDate.isAfter(now);
    final isActive = batch.status == 'in_progress' || batch.status == 'active';
    final isCompleted = batch.status == 'completed';
    
    final progressPercent = batch.enrolledCount > 0 
      ? (batch.completedCount / batch.enrolledCount * 100) 
      : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(
          color: isActive ? PharmaColors.emerald600 : PharmaColors.borderLight,
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: InkWell(
        onTap: () => context.go('/trainer/batches/${batch.id}'),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Batch Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(batch.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(PharmaRadius.sm),
                    ),
                    child: Icon(
                      _getStatusIcon(batch.status),
                      color: _getStatusColor(batch.status),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: PharmaSpacing.md),
                  // Batch Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          batch.name,
                          style: PharmaTypography.headingSmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          batch.courseVersion?.course?.title ?? 'Course TBD',
                          style: PharmaTypography.body.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status Badge
                  _buildStatusBadge(batch.status),
                ],
              ),
              
              const SizedBox(height: PharmaSpacing.md),
              Divider(color: PharmaColors.borderLight, height: 1),
              const SizedBox(height: PharmaSpacing.md),
              
              // Details Row
              Row(
                children: [
                  // Date/Time
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.calendar_today_rounded,
                      label: 'Schedule',
                      value: '${dateFormat.format(batch.startDate)} - ${dateFormat.format(batch.endDate)}',
                    ),
                  ),
                  // Location
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: batch.location ?? 'Virtual',
                    ),
                  ),
                  // Participants
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.people_outline,
                      label: 'Participants',
                      value: '${batch.enrolledCount} / ${batch.capacity}',
                    ),
                  ),
                ],
              ),
              
              // Progress Bar (for active/completed batches)
              if (isActive || isCompleted) ...[
                const SizedBox(height: PharmaSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Completion Progress',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${batch.completedCount}/${batch.enrolledCount} (${progressPercent.toStringAsFixed(0)}%)',
                          style: PharmaTypography.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: PharmaColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progressPercent / 100,
                        backgroundColor: PharmaColors.gray200,
                        valueColor: AlwaysStoppedAnimation(
                          isCompleted ? PharmaColors.success : PharmaColors.emerald600,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ],
              
              // Action Buttons
              const SizedBox(height: PharmaSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isUpcoming)
                    OutlinedButton.icon(
                      onPressed: () => context.go('/trainer/batches/${batch.id}'),
                      icon: const Icon(Icons.visibility_outlined, size: 18),
                      label: const Text('View Details'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PharmaColors.textSecondary,
                      ),
                    ),
                  if (isActive) ...[
                    OutlinedButton.icon(
                      onPressed: () => context.go('/trainer/batches/${batch.id}'),
                      icon: const Icon(Icons.people_outline, size: 18),
                      label: const Text('Manage Participants'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PharmaColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: PharmaSpacing.sm),
                    FilledButton.icon(
                      onPressed: () => context.go('/trainer/batches/${batch.id}'),
                      icon: const Icon(Icons.play_circle_outline, size: 18),
                      label: const Text('Conduct Session'),
                      style: FilledButton.styleFrom(
                        backgroundColor: PharmaColors.emerald600,
                      ),
                    ),
                  ],
                  if (isCompleted)
                    OutlinedButton.icon(
                      onPressed: () => context.go('/trainer/batches/${batch.id}'),
                      icon: const Icon(Icons.assessment_outlined, size: 18),
                      label: const Text('View Report'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PharmaColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: PharmaColors.textTertiary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textTertiary,
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: PharmaTypography.caption.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = _getStatusColor(status);
    final label = _getStatusLabel(status);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: PharmaTypography.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
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

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.xl * 2),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.groups_outlined,
              size: 64,
              color: PharmaColors.gray400,
            ),
            const SizedBox(height: PharmaSpacing.md),
            Text(
              'No Training Batches Assigned',
              style: PharmaTypography.headingSmall.copyWith(
                color: PharmaColors.textSecondary,
              ),
            ),
            const SizedBox(height: PharmaSpacing.sm),
            Text(
              'You have not been assigned to conduct any training batches yet.',
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.xl * 2),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: PharmaSpacing.md),
            Text(
              'Failed to load batches',
              style: PharmaTypography.headingSmall.copyWith(
                color: PharmaColors.danger,
              ),
            ),
            const SizedBox(height: PharmaSpacing.sm),
            Text(
              error,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PharmaSpacing.md),
            OutlinedButton.icon(
              onPressed: () {
                ref.invalidate(trainerBatchesProvider);
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STAT CARD WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: PharmaTypography.headingLarge.copyWith(
                    fontSize: 24,
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
            ),
          ),
        ],
      ),
    );
  }
}
