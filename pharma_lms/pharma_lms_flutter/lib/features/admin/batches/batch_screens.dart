import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/features/admin_portal/widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// BATCH LIST SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBatchListScreen extends ConsumerStatefulWidget {
  const AdminBatchListScreen({super.key});

  @override
  ConsumerState<AdminBatchListScreen> createState() => _AdminBatchListScreenState();
}

class _AdminBatchListScreenState extends ConsumerState<AdminBatchListScreen> {
  String _statusFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(adminBatchesProvider);
    final statsAsync = ref.watch(adminBatchStatsProvider);

    return batchesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Error loading batches', style: PharmaTypography.body),
            SizedBox(height: PharmaSpacing.xs),
            Text(err.toString(), style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(adminBatchesProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (batches) {
        final filteredBatches = _statusFilter == 'all'
            ? batches
            : batches.where((b) => b.status == _statusFilter).toList();

        return SingleChildScrollView(
          padding: EdgeInsets.all(PharmaSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header
              _buildPageHeader(context),
              SizedBox(height: PharmaSpacing.sectionGap),

              // Stats Row
              statsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (stats) => _buildStatsRow(stats, batches),
              ),
              SizedBox(height: PharmaSpacing.md),

              // Filters
              _buildFiltersRow(),
              SizedBox(height: PharmaSpacing.md),

              // Batches Grid
              _buildBatchesGrid(filteredBatches),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Training Batches', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Manage scheduled cohorts and instructor allocations',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Batch'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BatchStats stats, List<TrainingBatch> batches) {
    final totalEnrolled = batches.fold<int>(0, (sum, b) => sum + b.enrolledCount);

    return Row(
      children: [
        _buildStatCard('Total Batches', stats.total.toString(), Icons.groups_outlined, PharmaColors.info),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('In Progress', stats.inProgress.toString(), Icons.play_circle_outline, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Scheduled', stats.scheduled.toString(), Icons.schedule_outlined, PharmaColors.warning),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Completed', stats.completed.toString(), Icons.check_circle_outline, PharmaColors.textTertiary),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Total Enrolled', totalEnrolled.toString(), Icons.people_outline, PharmaColors.emerald600),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
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
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: PharmaSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: PharmaTypography.headingSmall),
                Text(label, style: PharmaTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          Text('Status:', style: PharmaTypography.bodyMedium),
          SizedBox(width: PharmaSpacing.md),
          ...['all', 'in_progress', 'scheduled', 'completed'].map((status) => Padding(
            padding: EdgeInsets.only(right: PharmaSpacing.sm),
            child: ChoiceChip(
              label: Text(_statusLabel(status)),
              selected: _statusFilter == status,
              onSelected: (s) => setState(() => _statusFilter = status),
              selectedColor: PharmaColors.emerald100,
            ),
          )),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'all': return 'All';
      case 'in_progress': return 'In Progress';
      case 'scheduled': return 'Scheduled';
      case 'completed': return 'Completed';
      case 'cancelled': return 'Cancelled';
      default: return status;
    }
  }

  Widget _buildBatchesGrid(List<TrainingBatch> batches) {
    if (batches.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No batches found',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              SizedBox(height: PharmaSpacing.xs),
              Text(
                'Create a new training batch to get started',
                style: PharmaTypography.caption,
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: batches.length,
      itemBuilder: (context, index) => _buildBatchCard(batches[index]),
    );
  }

  Widget _buildBatchCard(TrainingBatch batch) {
    final progress = batch.status == 'completed' 
        ? 1.0 
        : batch.enrolledCount > 0 ? (batch.completedCount / batch.enrolledCount) : 0.0;
    
    final courseTitle = batch.courseVersion?.course?.title ?? 'Course';
    final instructorName = batch.instructor != null 
        ? '${batch.instructor!.firstName} ${batch.instructor!.lastName}'
        : 'Not Assigned';

    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  batch.name,
                  style: PharmaTypography.headingSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildStatusBadge(batch.status),
            ],
          ),
          SizedBox(height: PharmaSpacing.xs),
          Text(courseTitle, style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary)),
          SizedBox(height: PharmaSpacing.md),
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: PharmaColors.textTertiary),
              SizedBox(width: PharmaSpacing.xs),
              Expanded(
                child: Text(instructorName, style: PharmaTypography.caption, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.xs),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16, color: PharmaColors.textTertiary),
              SizedBox(width: PharmaSpacing.xs),
              Text(
                '${_formatDate(batch.startDate)} - ${_formatDate(batch.endDate)}',
                style: PharmaTypography.caption,
              ),
            ],
          ),
          if (batch.location != null && batch.location!.isNotEmpty) ...[
            SizedBox(height: PharmaSpacing.xs),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 16, color: PharmaColors.textTertiary),
                SizedBox(width: PharmaSpacing.xs),
                Expanded(
                  child: Text(batch.location!, style: PharmaTypography.caption, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
          const Spacer(),
          // Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${batch.enrolledCount}/${batch.capacity} enrolled',
                style: PharmaTypography.caption,
              ),
              Text(
                '${(progress * 100).toInt()}% complete',
                style: PharmaTypography.caption.copyWith(
                  color: progress >= 0.8 ? PharmaColors.success : PharmaColors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: PharmaColors.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 0.8 ? PharmaColors.success : PharmaColors.emerald500,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'in_progress':
        bgColor = PharmaColors.successBg;
        textColor = PharmaColors.success;
        break;
      case 'scheduled':
        bgColor = PharmaColors.warningBg;
        textColor = PharmaColors.warning;
        break;
      case 'completed':
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
        break;
      case 'cancelled':
        bgColor = PharmaColors.dangerBg;
        textColor = PharmaColors.danger;
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: PharmaTypography.caption.copyWith(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE BATCH SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBatchCreateScreen extends StatelessWidget {
  const AdminBatchCreateScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BatchTemplate(
        title: 'Create Batch',
        subtitle: 'Create a new cohort with schedule and attendees.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// BATCH DETAIL SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBatchDetailScreen extends StatelessWidget {
  const AdminBatchDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BatchTemplate(
        title: 'Batch Detail',
        subtitle: 'Monitor attendance, completion, and batch lifecycle.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// PLACEHOLDER TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════════

class _BatchTemplate extends StatelessWidget {
  const _BatchTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Coming Soon',
            child: AdminPlaceholderTable(
              columns: ['Feature', 'Status', 'ETA'],
              rows: [
                ['Full implementation', 'In Progress', 'Q2 2026'],
              ],
            ),
          ),
        ],
      );
}
