// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE BATCH LIST SCREEN (EMP-BATCH-01)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Lists all training sessions/batches the employee is enrolled in.
// Allows viewing upcoming sessions, joining active training, and tracking progress.
//
// Features:
//  - View enrolled training sessions with status badges
//  - Filter by status (upcoming, in progress, completed)
//  - Quick stats (total enrolled, upcoming, completed)
//  - Navigate to session details
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/employee_batch_providers.dart';

class EmployeeBatchListScreen extends ConsumerStatefulWidget {
  const EmployeeBatchListScreen({super.key});

  @override
  ConsumerState<EmployeeBatchListScreen> createState() => _EmployeeBatchListScreenState();
}

class _EmployeeBatchListScreenState extends ConsumerState<EmployeeBatchListScreen> {
  String _selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(employeeBatchesProvider);
    final statsAsync = ref.watch(employeeBatchStatsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(employeeBatchesProvider);
        ref.invalidate(employeeBatchStatsProvider);
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
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ── FILTER CHIPS ──
          _buildFilterChips(),
          const SizedBox(height: PharmaSpacing.md),

          // ── SESSION LIST ──
          batchesAsync.when(
            data: (batches) => _buildSessionList(batches),
            loading: () => _buildLoadingState(),
            error: (e, _) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Training Sessions',
          style: PharmaTypography.headingLarge.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'View your enrolled instructor-led training sessions and schedules',
          style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
        ),
      ],
    );
  }

  Widget _buildStatsRow(EmployeeBatchStats stats) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.0,
          children: [
            _StatCard(
              label: 'Total Enrolled',
              value: '${stats.totalEnrolled}',
              icon: Icons.school_rounded,
              color: PharmaColors.emerald600,
              bgColor: PharmaColors.emerald50,
            ),
            _StatCard(
              label: 'Upcoming',
              value: '${stats.upcomingSessions}',
              icon: Icons.schedule_rounded,
              color: PharmaColors.info,
              bgColor: PharmaColors.infoBg,
            ),
            _StatCard(
              label: 'In Progress',
              value: '${stats.inProgress}',
              icon: Icons.play_circle_rounded,
              color: PharmaColors.warning,
              bgColor: PharmaColors.warningBg,
            ),
            _StatCard(
              label: 'Completed',
              value: '${stats.completed}',
              icon: Icons.check_circle_rounded,
              color: PharmaColors.success,
              bgColor: PharmaColors.successBg,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: PharmaSpacing.sm,
      children: [
        _FilterChip(
          label: 'All',
          isSelected: _selectedStatus == 'all',
          onTap: () => setState(() => _selectedStatus = 'all'),
        ),
        _FilterChip(
          label: 'Upcoming',
          isSelected: _selectedStatus == 'scheduled',
          onTap: () => setState(() => _selectedStatus = 'scheduled'),
        ),
        _FilterChip(
          label: 'In Progress',
          isSelected: _selectedStatus == 'in_progress',
          onTap: () => setState(() => _selectedStatus = 'in_progress'),
        ),
        _FilterChip(
          label: 'Completed',
          isSelected: _selectedStatus == 'completed',
          onTap: () => setState(() => _selectedStatus = 'completed'),
        ),
      ],
    );
  }

  Widget _buildSessionList(List<TrainingBatch> batches) {
    var filtered = batches;

    // Apply status filter
    if (_selectedStatus != 'all') {
      if (_selectedStatus == 'in_progress') {
        filtered = filtered.where((b) => 
          b.status == 'in_progress' || b.status == 'active'
        ).toList();
      } else {
        filtered = filtered.where((b) => b.status == _selectedStatus).toList();
      }
    }

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: filtered.map((batch) => _buildSessionCard(batch)).toList(),
    );
  }

  Widget _buildSessionCard(TrainingBatch batch) {
    final dateFormat = DateFormat('EEE, MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');
    final now = DateTime.now();

    final isUpcoming = batch.startDate.isAfter(now) && batch.status == 'scheduled';
    final isActive = batch.status == 'in_progress' || batch.status == 'active';
    final isToday = batch.startDate.year == now.year &&
        batch.startDate.month == now.month &&
        batch.startDate.day == now.day;

    return Container(
      margin: const EdgeInsets.only(bottom: PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(
          color: isActive || isToday ? PharmaColors.emerald600 : PharmaColors.borderLight,
          width: isActive || isToday ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: InkWell(
        onTap: () => context.go('/employee/sessions/${batch.id}'),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(batch.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(PharmaRadius.sm),
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      color: _getStatusColor(batch.status),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: PharmaSpacing.md),
                  // Session Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                batch.courseVersion?.course?.title ?? 'Training Session',
                                style: PharmaTypography.headingSmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            _buildStatusBadge(batch.status, isToday),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          batch.name,
                          style: PharmaTypography.body.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: PharmaSpacing.md),
              Divider(color: PharmaColors.borderLight, height: 1),
              const SizedBox(height: PharmaSpacing.md),

              // Details Row
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.calendar_today_rounded,
                      label: 'Date',
                      value: dateFormat.format(batch.startDate),
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.access_time_rounded,
                      label: 'Time',
                      value: timeFormat.format(batch.startDate),
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.location_on_rounded,
                      label: 'Location',
                      value: batch.location ?? 'Virtual',
                    ),
                  ),
                ],
              ),

              // Instructor Row
              const SizedBox(height: PharmaSpacing.md),
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: PharmaColors.emerald100,
                    child: Icon(
                      Icons.person_rounded,
                      size: 16,
                      color: PharmaColors.emerald700,
                    ),
                  ),
                  const SizedBox(width: PharmaSpacing.sm),
                  Text(
                    'Instructor: ${batch.instructor?.firstName ?? 'TBD'} ${batch.instructor?.lastName ?? ''}',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.textSecondary,
                    ),
                  ),
                ],
              ),

              // Action Buttons
              const SizedBox(height: PharmaSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isUpcoming) ...[
                    OutlinedButton.icon(
                      onPressed: () => _addToCalendar(batch),
                      icon: const Icon(Icons.calendar_month_rounded, size: 18),
                      label: const Text('Add to Calendar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PharmaColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: PharmaSpacing.sm),
                  ],
                  if (isActive || isToday)
                    FilledButton.icon(
                      onPressed: () => _joinSession(batch),
                      icon: const Icon(Icons.login_rounded, size: 18),
                      label: const Text('Join Session'),
                      style: FilledButton.styleFrom(
                        backgroundColor: PharmaColors.emerald600,
                      ),
                    )
                  else
                    OutlinedButton.icon(
                      onPressed: () => context.go('/employee/sessions/${batch.id}'),
                      icon: const Icon(Icons.visibility_outlined, size: 18),
                      label: const Text('View Details'),
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

  Widget _buildStatusBadge(String status, bool isToday) {
    final color = isToday ? PharmaColors.emerald600 : _getStatusColor(status);
    final label = isToday ? 'Today' : _getStatusLabel(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          fontSize: 11,
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
              Icons.event_available_rounded,
              size: 64,
              color: PharmaColors.gray400,
            ),
            const SizedBox(height: PharmaSpacing.md),
            Text(
              'No Training Sessions',
              style: PharmaTypography.headingSmall.copyWith(
                color: PharmaColors.textSecondary,
              ),
            ),
            const SizedBox(height: PharmaSpacing.sm),
            Text(
              _selectedStatus == 'all'
                  ? 'You are not enrolled in any instructor-led training sessions.'
                  : 'No sessions found with the selected filter.',
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
              'Failed to load sessions',
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
                ref.invalidate(employeeBatchesProvider);
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCalendar(TrainingBatch batch) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to calendar!')),
    );
  }

  void _joinSession(TrainingBatch batch) {
    if (batch.location?.toLowerCase().contains('virtual') ?? true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening virtual session...')),
      );
    } else {
      context.go('/employee/sessions/${batch.id}');
    }
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
      padding: const EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: PharmaSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    fontSize: 11,
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

// ─────────────────────────────────────────────────────────────────────────────
// FILTER CHIP WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: PharmaDurations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? PharmaColors.emerald600 : PharmaColors.cardBg,
          border: Border.all(
            color: isSelected ? PharmaColors.emerald600 : PharmaColors.borderLight,
          ),
          borderRadius: BorderRadius.circular(PharmaRadius.lg),
        ),
        child: Text(
          label,
          style: PharmaTypography.caption.copyWith(
            color: isSelected ? Colors.white : PharmaColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
