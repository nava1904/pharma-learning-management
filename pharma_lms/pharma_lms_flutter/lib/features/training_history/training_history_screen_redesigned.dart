// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINING HISTORY SCREEN (S7) — SERVERPOD WIRED
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/training-history
// View completed training history with certificates
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../design_system/tokens.dart';
import '../../design_system/components.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

/// Training History screen showing completed courses
class TrainingHistoryScreenRedesigned extends ConsumerStatefulWidget {
  const TrainingHistoryScreenRedesigned({super.key});

  @override
  ConsumerState<TrainingHistoryScreenRedesigned> createState() =>
      _TrainingHistoryScreenRedesignedState();
}

class _TrainingHistoryScreenRedesignedState
    extends ConsumerState<TrainingHistoryScreenRedesigned> {
  String _searchQuery = '';
  String _sortBy = 'date';
  bool _sortAscending = false;
  DateTimeRange? _dateRange;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final trainingRecordsAsync = ref.watch(trainingRecordsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(trainingRecordsProvider);
        ref.invalidate(certificatesProvider);
        await Future.wait([
          ref.refresh(trainingRecordsProvider.future),
          ref.refresh(certificatesProvider.future),
        ]);
      },
      child: userAsync.when(
        data: (user) {
          if (user == null || user.id == null) {
            return _buildEmptyState();
          }

          final records = trainingRecordsAsync.valueOrNull ?? [];
          final certificates = certificatesAsync.valueOrNull ?? [];

          return _HistoryContent(
            userId: user.id!,
            trainingRecords: records,
            certificates: certificates,
            searchQuery: _searchQuery,
            sortBy: _sortBy,
            sortAscending: _sortAscending,
            dateRange: _dateRange,
            onSearchChanged: (v) => setState(() => _searchQuery = v),
            onSortChanged: (by, asc) => setState(() {
              _sortBy = by;
              _sortAscending = asc;
            }),
            onDateRangeChanged: (range) => setState(() => _dateRange = range),
          );
        },
        loading: () => _buildLoadingState(),
        error: (e, _) => _buildErrorState(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: AppEmptyState(
        icon: Icons.history_outlined,
        title: 'No Training History',
        description: 'Your completed training will appear here.',
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoader(height: 32, width: 200),
          const SizedBox(height: AppSpacing.s2),
          SkeletonLoader(height: 20, width: 300),
          const SizedBox(height: AppSpacing.s6),
          Row(
            children: [
              Expanded(child: SkeletonLoader(height: 80)),
              const SizedBox(width: AppSpacing.s4),
              Expanded(child: SkeletonLoader(height: 80)),
              const SizedBox(width: AppSpacing.s4),
              Expanded(child: SkeletonLoader(height: 80)),
            ],
          ),
          const SizedBox(height: AppSpacing.s6),
          ...List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s4),
              child: SkeletonLoader(height: 100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: AppErrorWidget(
        title: 'Unable to Load History',
        message: 'There was a problem loading your training history.',
        onRetry: () {
          ref.invalidate(trainingRecordsProvider);
          ref.invalidate(certificatesProvider);
        },
      ),
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({
    required this.userId,
    required this.trainingRecords,
    required this.certificates,
    required this.searchQuery,
    required this.sortBy,
    required this.sortAscending,
    required this.dateRange,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onDateRangeChanged,
  });

  final int userId;
  final List<TrainingRecord> trainingRecords;
  final List<Certificate> certificates;
  final String searchQuery;
  final String sortBy;
  final bool sortAscending;
  final DateTimeRange? dateRange;
  final ValueChanged<String> onSearchChanged;
  final void Function(String, bool) onSortChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  Certificate? _getCertificate(TrainingRecord record) {
    return certificates.where((c) => c.trainingRecordId == record.id).firstOrNull;
  }

  List<TrainingRecord> get _filteredRecords {
    var filtered = trainingRecords.toList();

    if (dateRange != null) {
      filtered = filtered.where((r) {
        return r.completedAt.isAfter(dateRange!.start.subtract(const Duration(days: 1))) &&
            r.completedAt.isBefore(dateRange!.end.add(const Duration(days: 1)));
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((r) {
        final title = r.courseVersion?.course?.title ?? '';
        return title.toLowerCase().contains(query);
      }).toList();
    }

    switch (sortBy) {
      case 'date':
        filtered.sort((a, b) => sortAscending
            ? a.completedAt.compareTo(b.completedAt)
            : b.completedAt.compareTo(a.completedAt));
        break;
      case 'name':
        filtered.sort((a, b) {
          final aTitle = a.courseVersion?.course?.title ?? '';
          final bTitle = b.courseVersion?.course?.title ?? '';
          return sortAscending ? aTitle.compareTo(bTitle) : bTitle.compareTo(aTitle);
        });
        break;
      case 'score':
        filtered.sort((a, b) {
          final aScore = a.score ?? 0;
          final bScore = b.score ?? 0;
          return sortAscending ? aScore.compareTo(bScore) : bScore.compareTo(aScore);
        });
        break;
    }

    return filtered;
  }

  int get _totalCertificates => certificates.length;

  double get _averageScore {
    if (trainingRecords.isEmpty) return 0;
    final scoresWithValue = trainingRecords.where((r) => r.score != null);
    if (scoresWithValue.isEmpty) return 0;
    final total = scoresWithValue.map((r) => r.score!).reduce((a, b) => a + b);
    return total / scoresWithValue.length;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSpacing.s6),
          _buildStatsRow(),
          const SizedBox(height: AppSpacing.s6),
          _buildFilterBar(context),
          const SizedBox(height: AppSpacing.s5),
          Row(
            children: [
              Text(
                '${filtered.length} completed course${filtered.length == 1 ? '' : 's'}',
                style: AppTypography.bodySmall.copyWith(color: AppColors.n500),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showExportDialog(context),
                icon: Icon(Icons.download, size: 18, color: AppColors.blue),
                label: Text('Export', style: TextStyle(color: AppColors.blue)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s4),
          if (filtered.isEmpty)
            AppEmptyState(
              icon: Icons.search_off_outlined,
              title: 'No Matching Records',
              description: 'Try adjusting your filters or search terms.',
              actionLabel: 'Clear Filters',
              onAction: () {
                onSearchChanged('');
                onDateRangeChanged(null);
              },
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s4),
              itemBuilder: (context, index) {
                final record = filtered[index];
                final certificate = _getCertificate(record);
                return _HistoryCard(
                  record: record,
                  certificate: certificate,
                  onViewCertificate: certificate != null
                      ? () => _viewCertificate(context, certificate)
                      : null,
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Training History',
          style: AppTypography.display.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.s2),
        Text(
          'View your completed training and download certificates',
          style: AppTypography.body.copyWith(color: AppColors.n500),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.workspace_premium_outlined,
            iconColor: AppColors.blue,
            value: '$_totalCertificates',
            label: 'Certificates',
          ),
        ),
        const SizedBox(width: AppSpacing.s4),
        Expanded(
          child: _StatCard(
            icon: Icons.star_outline,
            iconColor: AppColors.warning,
            value: '${_averageScore.toStringAsFixed(0)}%',
            label: 'Avg. Score',
          ),
        ),
        const SizedBox(width: AppSpacing.s4),
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.success,
            value: '${trainingRecords.length}',
            label: 'Completions',
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Wrap(
        spacing: AppSpacing.s4,
        runSpacing: AppSpacing.s3,
        children: [
          SizedBox(
            width: 280,
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by course name...',
                hintStyle: AppTypography.body.copyWith(color: AppColors.n400),
                prefixIcon: Icon(Icons.search, color: AppColors.n400, size: 20),
                filled: true,
                fillColor: AppColors.n50,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s4,
                  vertical: AppSpacing.s3,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.br2,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.br2,
                  borderSide: BorderSide(color: AppColors.n200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.br2,
                  borderSide: BorderSide(color: AppColors.blue, width: 2),
                ),
              ),
              style: AppTypography.body,
            ),
          ),
          _FilterDropdown(
            value: sortBy,
            items: const {
              'date': 'Completion Date',
              'name': 'Course Name',
              'score': 'Score',
            },
            onChanged: (v) => onSortChanged(v, sortAscending),
          ),
          IconButton(
            onPressed: () => onSortChanged(sortBy, !sortAscending),
            icon: Icon(
              sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 20,
              color: AppColors.n500,
            ),
            tooltip: sortAscending ? 'Sort Ascending' : 'Sort Descending',
          ),
          OutlinedButton.icon(
            onPressed: () => _selectDateRange(context),
            icon: Icon(Icons.date_range, size: 18),
            label: Text(
              dateRange != null
                  ? '${dateRange!.start.humanDate} - ${dateRange!.end.humanDate}'
                  : 'Date Range',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.n700,
              side: BorderSide(color: AppColors.n200),
            ),
          ),
          if (dateRange != null)
            IconButton(
              onPressed: () => onDateRangeChanged(null),
              icon: Icon(Icons.clear, size: 18, color: AppColors.n400),
              tooltip: 'Clear Date Filter',
            ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: AppColors.n0,
              surface: AppColors.n0,
              onSurface: AppColors.n900,
            ),
          ),
          child: child!,
        );
      },
    );
    if (range != null) {
      onDateRangeChanged(range);
    }
  }

  void _viewCertificate(BuildContext context, Certificate certificate) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Certificate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              certificate.courseVersion?.course?.title ?? 'Training Certificate',
              style: AppTypography.title,
            ),
            const SizedBox(height: AppSpacing.s4),
            _InfoRow(label: 'Issued', value: certificate.issuedAt.humanDate),
            if (certificate.expiresAt != null)
              _InfoRow(label: 'Expires', value: certificate.expiresAt!.humanDate),
            if (certificate.qrCode != null)
              _InfoRow(label: 'Verification', value: certificate.qrCode!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Certificate download started'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Export Training History'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ExportOption(
              icon: Icons.picture_as_pdf,
              label: 'Export as PDF',
              onTap: () {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('PDF export started'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.s3),
            _ExportOption(
              icon: Icons.table_chart,
              label: 'Export as CSV',
              onTap: () {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('CSV export started'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.s3),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: AppRadius.br2,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: AppSpacing.s3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTypography.headline.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                style: AppTypography.caption.copyWith(color: AppColors.n500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final Map<String, String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s1),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        border: Border.all(color: AppColors.n200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          style: AppTypography.body.copyWith(color: AppColors.n700),
          items: items.entries.map((e) {
            return DropdownMenuItem(value: e.key, child: Text(e.value));
          }).toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.record,
    this.certificate,
    this.onViewCertificate,
  });

  final TrainingRecord record;
  final Certificate? certificate;
  final VoidCallback? onViewCertificate;

  @override
  Widget build(BuildContext context) {
    final course = record.courseVersion?.course;
    final title = course?.title ?? 'Training Course';
    final score = record.score;

    return Material(
      color: AppColors.n0,
      borderRadius: AppRadius.br2,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s5),
        decoration: BoxDecoration(
          borderRadius: AppRadius.br2,
          border: Border.all(color: AppColors.n200),
          boxShadow: AppShadows.sh1,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.s3),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: AppRadius.br2,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.title.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.n400),
                      const SizedBox(width: 4),
                      Text(
                        'Completed ${record.completedAt.humanDate}',
                        style: AppTypography.caption.copyWith(color: AppColors.n500),
                      ),
                      if (score != null) ...[
                        const SizedBox(width: AppSpacing.s4),
                        Icon(Icons.star_outline, size: 14, color: AppColors.warning),
                        const SizedBox(width: 4),
                        Text(
                          'Score: $score%',
                          style: AppTypography.caption.copyWith(
                            color: score >= 80 ? AppColors.success : AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.s4),
            if (certificate != null)
              FilledButton.icon(
                onPressed: onViewCertificate,
                icon: Icon(Icons.workspace_premium, size: 18),
                label: Text('Certificate'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.n0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s4,
                    vertical: AppSpacing.s3,
                  ),
                ),
              )
            else
              OutlinedButton(
                onPressed: null,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.n400,
                  side: BorderSide(color: AppColors.n200),
                ),
                child: Text('No Certificate'),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s1),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTypography.caption.copyWith(color: AppColors.n500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.body,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExportOption extends StatelessWidget {
  const _ExportOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.n50,
      borderRadius: AppRadius.br2,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br2,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s4),
          child: Row(
            children: [
              Icon(icon, color: AppColors.blue, size: 24),
              const SizedBox(width: AppSpacing.s3),
              Text(label, style: AppTypography.body),
              const Spacer(),
              Icon(Icons.chevron_right, color: AppColors.n400),
            ],
          ),
        ),
      ),
    );
  }
}
