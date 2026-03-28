// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — MY TRAINING SCREEN (S2) — SERVERPOD WIRED
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/my-training
// Shows all training assigned to the employee with filtering and sorting.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/tokens.dart';
import '../../design_system/components.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

/// My Training screen - all assigned training with filtering
class MyTrainingScreen extends ConsumerStatefulWidget {
  const MyTrainingScreen({super.key});

  @override
  ConsumerState<MyTrainingScreen> createState() => _MyTrainingScreenState();
}

class _MyTrainingScreenState extends ConsumerState<MyTrainingScreen> {
  String _statusFilter = 'all';
  String _sortBy = 'dueDate';
  String _searchQuery = '';
  final Map<int, double> _progressCache = {};
  final Set<int> _progressLoading = {};

  void _loadProgressForEnrollments(List<Enrollment> enrollments) {
    for (final enrollment in enrollments) {
      final id = enrollment.id;
      if (id == null ||
          _progressCache.containsKey(id) ||
          _progressLoading.contains(id)) {
        continue;
      }
      if (enrollment.status == 'completed') {
        _progressCache[id] = 1.0;
        continue;
      }
      if (enrollment.status != 'in_progress') continue;
      _progressLoading.add(id);
      client.training.getEnrollmentProgress(id).then((result) {
        if (!mounted) return;
        final pct = (result['progressPct'] as num?)?.toDouble() ?? 0.0;
        setState(() {
          _progressCache[id] = pct / 100.0;
          _progressLoading.remove(id);
        });
      }).catchError((_) {
        _progressLoading.remove(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final assignmentsAsync = ref.watch(assignmentsProvider);
    final resumeLabelsAsync = ref.watch(enrollmentResumeLabelsProvider);
    final complianceAsync = ref.watch(userComplianceProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(enrollmentsProvider);
        ref.invalidate(assignmentsProvider);
        ref.invalidate(enrollmentResumeLabelsProvider);
        ref.invalidate(userComplianceProvider);
        ref.invalidate(certificatesProvider);
        await Future.wait([
          ref.refresh(enrollmentsProvider.future),
          ref.refresh(assignmentsProvider.future),
          ref.refresh(enrollmentResumeLabelsProvider.future),
          ref.refresh(userComplianceProvider.future),
          ref.refresh(certificatesProvider.future),
        ]);
      },
      child: userAsync.when(
        data: (user) {
          if (user == null || user.id == null) {
            return _buildEmptyState();
          }

          final enrollments = enrollmentsAsync.valueOrNull ?? [];
          final assignments = assignmentsAsync.valueOrNull ?? [];
          final resumeLabels = resumeLabelsAsync.valueOrNull ?? {};
          final compliance = complianceAsync.valueOrNull;
          final overdueCount = compliance?.overdueCount ?? 0;
          final certificates = ref.watch(certificatesProvider).valueOrNull ?? [];

          _loadProgressForEnrollments(enrollments);

          return _MyTrainingContent(
            userId: user.id!,
            enrollments: enrollments,
            assignments: assignments,
            certificates: certificates,
            resumeLabels: resumeLabels,
            overdueCount: overdueCount,
            progressCache: _progressCache,
            statusFilter: _statusFilter,
            sortBy: _sortBy,
            searchQuery: _searchQuery,
            onStatusFilterChanged: (v) => setState(() => _statusFilter = v),
            onSortByChanged: (v) => setState(() => _sortBy = v),
            onSearchChanged: (v) => setState(() => _searchQuery = v),
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
        icon: Icons.school_outlined,
        title: 'No Training Assigned',
        description: 'You have no training courses assigned at this time.',
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoader(height: 24, width: 180),
          const SizedBox(height: AppSpacing.s4),
          SkeletonLoader(height: 48),
          const SizedBox(height: AppSpacing.s6),
          ...List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s4),
              child: CourseCardSkeleton(),
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
        title: 'Unable to Load Training',
        message: 'There was a problem loading your training data.',
        onRetry: () {
          ref.invalidate(enrollmentsProvider);
          ref.invalidate(assignmentsProvider);
        },
      ),
    );
  }
}

class _MyTrainingContent extends StatelessWidget {
  const _MyTrainingContent({
    required this.userId,
    required this.enrollments,
    required this.assignments,
    required this.certificates,
    required this.resumeLabels,
    required this.overdueCount,
    required this.progressCache,
    required this.statusFilter,
    required this.sortBy,
    required this.searchQuery,
    required this.onStatusFilterChanged,
    required this.onSortByChanged,
    required this.onSearchChanged,
  });

  final int userId;
  final List<Enrollment> enrollments;
  final List<TrainingAssignment> assignments;
  final List<Certificate> certificates;
  final Map<int, String> resumeLabels;
  final int overdueCount;
  final Map<int, double> progressCache;
  final String statusFilter;
  final String sortBy;
  final String searchQuery;
  final ValueChanged<String> onStatusFilterChanged;
  final ValueChanged<String> onSortByChanged;
  final ValueChanged<String> onSearchChanged;

  TrainingAssignment? _getAssignment(Enrollment enrollment) {
    return assignments
        .where((a) =>
            a.courseVersionId == enrollment.courseVersionId && a.userId == userId)
        .firstOrNull;
  }

  int? _certificateIdForEnrollment(Enrollment enrollment) {
    final cvId = enrollment.courseVersionId;
    for (final c in certificates) {
      if (c.courseVersionId == cvId && c.id != null) return c.id;
    }
    return null;
  }

  DateTime _getDueDate(Enrollment enrollment) {
    final assignment = _getAssignment(enrollment);
    return assignment?.dueDate ?? DateTime.now().add(const Duration(days: 365));
  }

  bool _isOverdue(Enrollment enrollment) {
    if (enrollment.status == 'completed') return false;
    return _getDueDate(enrollment).isBefore(DateTime.now());
  }

  TrainingStatus _getStatus(Enrollment enrollment) {
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

  List<Enrollment> get _filteredEnrollments {
    var filtered = enrollments.where((e) {
      if (searchQuery.isNotEmpty) {
        final title = e.courseVersion?.course?.title ?? '';
        if (!title.toLowerCase().contains(searchQuery.toLowerCase())) {
          return false;
        }
      }
      if (statusFilter == 'all') return true;
      final status = _getStatus(e);
      switch (statusFilter) {
        case 'overdue':
          return status == TrainingStatus.overdue || status == TrainingStatus.sopUpdate;
        case 'inProgress':
          return status == TrainingStatus.inProgress;
        case 'notStarted':
          return status == TrainingStatus.notStarted;
        case 'completed':
          return status == TrainingStatus.completed;
        default:
          return true;
      }
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case 'dueDate':
          final aOverdue = _isOverdue(a);
          final bOverdue = _isOverdue(b);
          if (aOverdue != bOverdue) return aOverdue ? -1 : 1;
          return _getDueDate(a).compareTo(_getDueDate(b));
        case 'name':
          final aTitle = a.courseVersion?.course?.title ?? '';
          final bTitle = b.courseVersion?.course?.title ?? '';
          return aTitle.compareTo(bTitle);
        case 'progress':
          final aStatus = _getStatus(a);
          final bStatus = _getStatus(b);
          return aStatus.index.compareTo(bStatus.index);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredEnrollments;
    
    // Find enrollments with SOP retraining required
    final sopRetrainingRequired = enrollments.where((e) =>
        e.retrainingChangeSummary != null &&
        e.retrainingChangeSummary!.isNotEmpty &&
        e.acknowledgedAt == null).toList();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SOP Retraining Alert Card (soft warning #FAEEDA)
          if (sopRetrainingRequired.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _SopRetrainingAlertCard(
                count: sopRetrainingRequired.length,
                enrollments: sopRetrainingRequired,
                onView: () => onStatusFilterChanged('overdue'),
              ),
            ),
        
          if (overdueCount > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s6),
              child: ComplianceAlertBanner(
                overdueCount: overdueCount,
                onViewOverdue: () => onStatusFilterChanged('overdue'),
              ),
            ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Training',
                      style: AppTypography.display.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s1),
                    Text(
                      '${enrollments.length} courses assigned',
                      style: AppTypography.body.copyWith(color: AppColors.n500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s6),

          _buildFilterRow(context),
          const SizedBox(height: AppSpacing.s6),

          if (filtered.isEmpty)
            AppEmptyState(
              icon: Icons.filter_list_off_outlined,
              title: 'No Matching Courses',
              description: 'Try adjusting your filters to see more results.',
              actionLabel: 'Clear Filters',
              onAction: () {
                onStatusFilterChanged('all');
                onSearchChanged('');
              },
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s4),
              itemBuilder: (context, index) {
                final enrollment = filtered[index];
                return _TrainingCard(
                  enrollment: enrollment,
                  status: _getStatus(enrollment),
                  dueDate: _getDueDate(enrollment),
                  resumeLabel: resumeLabels[enrollment.id],
                  progress: progressCache[enrollment.id] ?? 0.0,
                  onTap: () {
                    if (enrollment.status == 'completed') {
                      final certId = _certificateIdForEnrollment(enrollment);
                      if (certId != null) {
                        context.push('/certificate/$certId');
                      } else {
                        context.go('/employee/credentials');
                      }
                    } else {
                      final course = enrollment.courseVersion?.course;
                      context.go(
                        '/employee/course/${course?.id ?? enrollment.courseVersionId}',
                        extra: {
                          'courseVersionId': enrollment.courseVersionId.toString(),
                          'enrollmentId': enrollment.id?.toString(),
                          'enrollmentStatus': enrollment.status,
                        },
                      );
                    }
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.s4,
      runSpacing: AppSpacing.s3,
      children: [
        _FilterDropdown(
          value: statusFilter,
          items: const {
            'all': 'All Statuses',
            'overdue': 'Overdue',
            'inProgress': 'In Progress',
            'notStarted': 'Not Started',
            'completed': 'Completed',
          },
          onChanged: onStatusFilterChanged,
        ),
        _FilterDropdown(
          value: sortBy,
          items: const {
            'dueDate': 'Due Date',
            'name': 'Course Name',
            'progress': 'Progress',
          },
          onChanged: onSortByChanged,
        ),
        SizedBox(
          width: 280,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search courses...',
              hintStyle: AppTypography.body.copyWith(color: AppColors.n400),
              prefixIcon: const Icon(Icons.search, color: AppColors.n400),
              filled: true,
              fillColor: AppColors.n0,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s4,
                vertical: AppSpacing.s3,
              ),
              border: OutlineInputBorder(
                borderRadius: AppRadius.br2,
                borderSide: const BorderSide(color: AppColors.n200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.br2,
                borderSide: const BorderSide(color: AppColors.n200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.br2,
                borderSide: const BorderSide(color: AppColors.blue, width: 2),
              ),
            ),
            onChanged: onSearchChanged,
          ),
        ),
      ],
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

class _TrainingCard extends StatelessWidget {
  const _TrainingCard({
    required this.enrollment,
    required this.status,
    required this.dueDate,
    required this.onTap,
    required this.progress,
    this.resumeLabel,
  });

  final Enrollment enrollment;
  final TrainingStatus status;
  final DateTime dueDate;
  final double progress;
  final String? resumeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final course = enrollment.courseVersion?.course;
    final title = course?.title ?? 'Training Course';
    final isUrgent = status == TrainingStatus.overdue || status == TrainingStatus.sopUpdate;

    return Material(
      color: AppColors.n0,
      borderRadius: AppRadius.br2,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br2,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s5),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br2,
            border: Border.all(
              color: isUrgent ? AppColors.danger.withValues(alpha: 0.3) : AppColors.n200,
              width: isUrgent ? 2 : 1,
            ),
            boxShadow: AppShadows.sh1,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.s3),
                decoration: BoxDecoration(
                  color: status.bgColor,
                  borderRadius: AppRadius.br2,
                ),
                child: Icon(status.icon, color: status.color, size: 24),
              ),
              const SizedBox(width: AppSpacing.s4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTypography.title.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        StatusPill(status: status),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s2),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 14,
                          color: isUrgent ? AppColors.danger : AppColors.n400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isUrgent ? dueDate.fullDueDateLabel : 'Due ${dueDate.humanDate}',
                          style: AppTypography.caption.copyWith(
                            color: isUrgent ? AppColors.danger : AppColors.n500,
                          ),
                        ),
                        if (resumeLabel != null) ...[
                          const SizedBox(width: AppSpacing.s4),
                          Icon(Icons.bookmark_outlined, size: 14, color: AppColors.n400),
                          const SizedBox(width: 4),
                          Text(
                            resumeLabel!,
                            style: AppTypography.caption.copyWith(color: AppColors.n500),
                          ),
                        ],
                      ],
                    ),
                    if (status == TrainingStatus.inProgress) ...[
                      const SizedBox(height: AppSpacing.s3),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: AppRadius.br5,
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: AppColors.n200,
                                valueColor: AlwaysStoppedAnimation<Color>(status.color),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s3),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.n500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s4),
              FilledButton(
                onPressed: onTap,
                style: FilledButton.styleFrom(
                  backgroundColor: isUrgent ? AppColors.danger : AppColors.blue,
                  foregroundColor: AppColors.n0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s5,
                    vertical: AppSpacing.s3,
                  ),
                ),
                child: Text(
                  status.ctaLabel,
                  style: AppTypography.button.copyWith(color: AppColors.n0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// SOP Retraining Alert Card - Soft warning style (#FAEEDA background)
class _SopRetrainingAlertCard extends StatelessWidget {
  const _SopRetrainingAlertCard({
    required this.count,
    required this.enrollments,
    required this.onView,
  });

  final int count;
  final List<Enrollment> enrollments;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAEEDA), // Soft warning cream
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF59E0B).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.article_outlined,
              color: Color(0xFFD97706),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'SOP Retraining Required',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF92400E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  count == 1
                      ? 'A Standard Operating Procedure has been updated. Please review and acknowledge the changes.'
                      : '$count Standard Operating Procedures have been updated. Please review and acknowledge the changes.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF78350F),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Course list preview
                ...enrollments.take(2).map((e) {
                  final title = e.courseVersion?.course?.title ?? 'Training Course';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD97706),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF92400E),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                
                if (count > 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '+ ${count - 2} more',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFB45309),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Action button
          TextButton(
            onPressed: onView,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFD97706),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: const Color(0xFFF59E0B).withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Review',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}