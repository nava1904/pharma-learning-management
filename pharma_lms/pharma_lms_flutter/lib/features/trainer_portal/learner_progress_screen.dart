// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — LEARNER PROGRESS REPORT (TRN-15)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/reports/learner-progress
// Per-learner training history, compliance status, certifications.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:intl/intl.dart';

import '../../core/certificate_pdf_service.dart';
import '../../core/client.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_components.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

// ─── DATA MODEL ──────────────────────────────────────────────────────────────

class _LearnerSummary {
  _LearnerSummary({
    required this.user,
    required this.enrollments,
    required this.certificates,
  });

  final PharmaUser user;
  final List<Enrollment> enrollments;
  final List<Certificate> certificates;

  String get fullName => '${user.firstName} ${user.lastName}'.trim();

  int get completed =>
      enrollments.where((e) => e.status == 'completed').length;
  int get inProgress =>
      enrollments.where((e) => e.status == 'in_progress').length;
  int get notStarted =>
      enrollments.where((e) => e.status == 'not_started').length;
  int get overdue => enrollments
      .where((e) =>
          e.status != 'completed' &&
          e.status != 'cancelled' &&
          e.assignment != null &&
          e.assignment!.dueDate.isBefore(DateTime.now()))
      .length;
  int get totalActive =>
      enrollments.where((e) => e.status != 'cancelled').length;

  String get compliance {
    if (totalActive == 0) return 'compliant';
    if (overdue >= 3 || (totalActive > 0 && overdue / totalActive > 0.3)) {
      return 'non_compliant';
    }
    if (overdue > 0) return 'at_risk';
    return 'compliant';
  }
}

// ─── PROVIDERS ───────────────────────────────────────────────────────────────

final _learnersProvider =
    FutureProvider.autoDispose<List<_LearnerSummary>>((ref) async {
  final users = await client.organization.listUsers();
  final activeUsers =
      users.where((u) => u.status == 'active' && u.id != null).toList();

  final summaries = <_LearnerSummary>[];
  for (final user in activeUsers) {
    try {
      final enrollments =
          await client.training.getEnrollmentsForUser(user.id!);
      final certificates =
          await client.training.getCertificatesForUser(user.id!);
      summaries.add(_LearnerSummary(
        user: user,
        enrollments: enrollments,
        certificates: certificates,
      ));
    } catch (_) {
      summaries.add(_LearnerSummary(
        user: user,
        enrollments: [],
        certificates: [],
      ));
    }
  }
  return summaries;
});

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class LearnerProgressScreen extends ConsumerStatefulWidget {
  const LearnerProgressScreen({super.key});

  @override
  ConsumerState<LearnerProgressScreen> createState() =>
      _LearnerProgressScreenState();
}

class _LearnerProgressScreenState
    extends ConsumerState<LearnerProgressScreen> {
  String _searchQuery = '';
  String _filterCompliance = 'All';
  _LearnerSummary? _selectedLearner;
  List<AssessmentAttempt> _attemptsForDetail = [];
  bool _loadingAttempts = false;

  Future<void> _loadAttemptsForLearner(int? userId) async {
    if (userId == null) {
      setState(() {
        _attemptsForDetail = [];
        _loadingAttempts = false;
      });
      return;
    }
    setState(() => _loadingAttempts = true);
    try {
      final list =
          await client.assessment.listCompletedAttemptsForUser(userId: userId);
      if (mounted) {
        setState(() {
          _attemptsForDetail = list;
          _loadingAttempts = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _attemptsForDetail = [];
          _loadingAttempts = false;
        });
      }
    }
  }

  List<_LearnerSummary> _applyFilters(List<_LearnerSummary> all) {
    return all.where((l) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!l.fullName.toLowerCase().contains(q) &&
            !l.user.email.toLowerCase().contains(q)) {
          return false;
        }
      }
      if (_filterCompliance != 'All' && l.compliance != _filterCompliance) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final learnersAsync = ref.watch(_learnersProvider);

    return learnersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text('Failed to load learner data',
                style: PharmaTypography.headingSmall),
            const SizedBox(height: 4),
            Text('$e', style: PharmaTypography.caption),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(_learnersProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (learners) => _buildContent(learners),
    );
  }

  Widget _buildContent(List<_LearnerSummary> learners) {
    final filtered = _applyFilters(learners);

    final compliant =
        learners.where((l) => l.compliance == 'compliant').length;
    final atRisk = learners.where((l) => l.compliance == 'at_risk').length;
    final nonCompliant =
        learners.where((l) => l.compliance == 'non_compliant').length;

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(_learnersProvider),
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildComplianceStats(
              compliant, atRisk, nonCompliant, learners.length),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(children: [
                  _buildSearchFilter(),
                  const SizedBox(height: 12),
                  _buildLearnersTable(filtered),
                ]),
              ),
              if (_selectedLearner != null) ...[
                const SizedBox(width: 24),
                SizedBox(
                    width: 360,
                    child: _buildLearnerDetail(_selectedLearner!)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.school_outlined,
            color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Learner Progress',
                  style: PharmaTypography.headingLarge
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Individual training progress and compliance status',
                  style: PharmaTypography.body
                      .copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _exportLearnerProgressReport(),
          icon: const Icon(Icons.download, size: 16),
          label: const Text('Export Report'),
        ),
      ],
    );
  }

  Future<void> _exportLearnerProgressReport() async {
    try {
      final user = await ref.read(currentUserProvider.future);
      final csv = await client.analytics.exportLearnerProgressCsv(
        organizationId: user?.organizationId,
      );
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => PharmaDialog(
          title: 'Learner Progress Report',
          titleIcon: Icons.download_done,
          maxWidth: 640,
          content: SizedBox(
            height: 400,
            child: SelectableText(
              csv,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: csv));
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
              },
              child: const Text('Copy to Clipboard'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Widget _buildComplianceStats(
      int compliant, int atRisk, int nonCompliant, int total) {
    return Row(
      children: [
        _statCard(
            'Compliant',
            '$compliant',
            PharmaColors.emerald600,
            total > 0
                ? '${(compliant / total * 100).toInt()}%'
                : ''),
        _statCard(
            'At Risk',
            '$atRisk',
            PharmaColors.warningText,
            total > 0
                ? '${(atRisk / total * 100).toInt()}%'
                : ''),
        _statCard(
            'Non-Compliant',
            '$nonCompliant',
            PharmaColors.danger,
            total > 0
                ? '${(nonCompliant / total * 100).toInt()}%'
                : ''),
        _statCard('Total Learners', '$total', PharmaColors.gray600, ''),
      ]
          .map((w) => Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 12), child: w)))
          .toList(),
    );
  }

  Widget _statCard(String label, String value, Color color, String pct) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value,
              style: PharmaTypography.statNumber.copyWith(fontSize: 22)),
          Text(label,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
        ]),
        if (pct.isNotEmpty) ...[
          const Spacer(),
          Text(pct,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ]),
    );
  }

  Widget _buildSearchFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Search by name or email…',
              prefixIcon: const Icon(Icons.search, size: 18),
              filled: true,
              fillColor: PharmaColors.pageBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ...['All', 'compliant', 'at_risk', 'non_compliant'].map((s) {
          final isActive = _filterCompliance == s;
          String label;
          switch (s) {
            case 'compliant':
              label = 'Compliant';
              break;
            case 'at_risk':
              label = 'At Risk';
              break;
            case 'non_compliant':
              label = 'Non-Compliant';
              break;
            default:
              label = 'All';
          }
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: FilterChip(
              label: Text(label),
              selected: isActive,
              onSelected: (_) => setState(() => _filterCompliance = s),
              selectedColor: PharmaColors.emerald50,
              checkmarkColor: PharmaColors.emerald600,
              labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? PharmaColors.emerald600
                      : PharmaColors.textSecondary),
              side: BorderSide(
                  color: isActive
                      ? PharmaColors.emerald600
                      : PharmaColors.borderLight),
            ),
          );
        }),
      ]),
    );
  }

  Widget _buildLearnersTable(List<_LearnerSummary> filtered) {
    if (filtered.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline,
                size: 48, color: PharmaColors.gray300),
            const SizedBox(height: 8),
            Text('No learners match filters',
                style: PharmaTypography.bodyMedium),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
        headingRowHeight: 44,
        dataRowMinHeight: 52,
        dataRowMaxHeight: 60,
        columnSpacing: 20,
        showCheckboxColumn: false,
        headingTextStyle: PharmaTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: PharmaColors.textTertiary,
            fontSize: 11,
            letterSpacing: 0.5),
        columns: const [
          DataColumn(label: Text('LEARNER')),
          DataColumn(label: Text('EMAIL')),
          DataColumn(label: Text('COMPLIANCE')),
          DataColumn(label: Text('COMPLETED'), numeric: true),
          DataColumn(label: Text('IN PROGRESS'), numeric: true),
          DataColumn(label: Text('OVERDUE'), numeric: true),
          DataColumn(label: Text('CERTS'), numeric: true),
        ],
        rows: filtered
                .map((l) => DataRow(
                  selected: _selectedLearner == l,
                  onSelectChanged: (_) async {
                    setState(() => _selectedLearner = l);
                    await _loadAttemptsForLearner(l.user.id);
                  },
                  cells: [
                    DataCell(Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 16,
                              backgroundColor: PharmaColors.emerald50,
                              child: Text(
                                  _initials(l.user),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: PharmaColors.emerald600))),
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(l.fullName,
                                    style: PharmaTypography.bodyMedium
                                        .copyWith(
                                            fontWeight:
                                                FontWeight.w500)),
                              ]),
                        ])),
                    DataCell(Text(l.user.email,
                        style: PharmaTypography.caption,
                        overflow: TextOverflow.ellipsis)),
                    DataCell(
                        _ComplianceChip(status: l.compliance)),
                    DataCell(Text('${l.completed}',
                        style: PharmaTypography.bodyMedium)),
                    DataCell(Text('${l.inProgress}',
                        style: PharmaTypography.bodyMedium)),
                    DataCell(Text('${l.overdue}',
                        style: PharmaTypography.bodyMedium.copyWith(
                            color: l.overdue > 0
                                ? PharmaColors.danger
                                : null,
                            fontWeight: l.overdue > 0
                                ? FontWeight.w600
                                : null))),
                    DataCell(Text('${l.certificates.length}',
                        style: PharmaTypography.bodyMedium)),
                  ],
                ))
            .toList(),
        ),
      ),
    );
  }

  String _initials(PharmaUser u) {
    final parts = <String>[];
    if (u.firstName.isNotEmpty) parts.add(u.firstName[0]);
    if (u.lastName.isNotEmpty) parts.add(u.lastName[0]);
    return parts.join().toUpperCase();
  }

  Widget _buildLearnerDetail(_LearnerSummary l) {
    final activeEnrollments = l.enrollments
        .where((e) => e.status != 'cancelled')
        .toList()
      ..sort((a, b) {
        final aStatus = _enrollmentSortOrder(a.status);
        final bStatus = _enrollmentSortOrder(b.status);
        return aStatus.compareTo(bStatus);
      });

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(
                  radius: 24,
                  backgroundColor: PharmaColors.emerald50,
                  child: Text(_initials(l.user),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: PharmaColors.emerald600))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.fullName,
                          style: PharmaTypography.headingSmall),
                      Text(l.user.email,
                          style: PharmaTypography.caption
                              .copyWith(color: PharmaColors.textTertiary)),
                    ]),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedLearner = null;
                      _attemptsForDetail = [];
                    });
                  },
                  icon: Icon(Icons.close,
                      size: 18, color: PharmaColors.textTertiary)),
            ]),
            const SizedBox(height: 16),
            _ComplianceChip(status: l.compliance),
            const SizedBox(height: 20),
            Text('Training Summary',
                style:
                    PharmaTypography.labelLarge.copyWith(fontSize: 13)),
            const SizedBox(height: 12),
            _detailRow(
                'Completed', '${l.completed}', PharmaColors.emerald600),
            _detailRow(
                'In Progress', '${l.inProgress}', PharmaColors.info),
            _detailRow('Not Started', '${l.notStarted}',
                PharmaColors.gray500),
            _detailRow('Overdue', '${l.overdue}', PharmaColors.danger),
            _detailRow('Certifications', '${l.certificates.length}',
                PharmaColors.warningText),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _loadingAttempts
                  ? null
                  : () async {
                      final bytes = await generateLearnerTranscriptPdf(
                        user: l.user,
                        enrollments: l.enrollments,
                        attempts: _attemptsForDetail,
                        certificates: l.certificates,
                      );
                      final safe = l.user.email
                          .replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
                      await saveBytesToFile(bytes, '${safe}_transcript.pdf');
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Transcript PDF saved'),
                        ),
                      );
                    },
              icon: const Icon(Icons.picture_as_pdf, size: 18),
              label: const Text('Download PDF transcript'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Assessment history (read-only)',
              style: PharmaTypography.labelLarge.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            if (_loadingAttempts)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else if (_attemptsForDetail.isEmpty)
              Text(
                'No completed attempts on record.',
                style: PharmaTypography.caption,
              )
            else
              ..._attemptsForDetail.take(8).map(_assessmentAttemptRow),
            if (_attemptsForDetail.length > 8)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '+ ${_attemptsForDetail.length - 8} more in PDF',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.emerald600,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Enrollment detail list
            Text('Enrollments',
                style:
                    PharmaTypography.labelLarge.copyWith(fontSize: 13)),
            const SizedBox(height: 12),
            if (activeEnrollments.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('No enrollments found',
                    style: PharmaTypography.caption),
              )
            else
              ...activeEnrollments.take(10).map((e) =>
                  _enrollmentRow(e)),
            if (activeEnrollments.length > 10)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                    '+ ${activeEnrollments.length - 10} more',
                    style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.emerald600,
                        fontWeight: FontWeight.w500)),
              ),

            // Certificates
            if (l.certificates.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text('Certificates',
                  style: PharmaTypography.labelLarge
                      .copyWith(fontSize: 13)),
              const SizedBox(height: 12),
              ...l.certificates.take(5).map((c) => _certificateRow(c)),
            ],
          ]),
    );
  }

  int _enrollmentSortOrder(String status) {
    switch (status) {
      case 'in_progress':
        return 0;
      case 'not_started':
        return 1;
      case 'completed':
        return 2;
      default:
        return 3;
    }
  }

  Widget _assessmentAttemptRow(AssessmentAttempt a) {
    final title = a.assessment?.courseVersion?.course?.title ??
        'Assessment attempt';
    final when = a.completedAt != null
        ? DateFormat('MMM d, yyyy').format(a.completedAt!)
        : '—';
    final score = a.score != null ? '${a.score}%' : '—';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.fact_check, size: 14, color: PharmaColors.info),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PharmaTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Score $score · $when',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textTertiary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _enrollmentRow(Enrollment e) {
    final courseName = e.courseVersion?.course?.title ??
        'Assigned course';
    final version = e.courseVersion?.version ?? '';

    Color statusColor;
    IconData statusIcon;
    switch (e.status) {
      case 'completed':
        statusColor = PharmaColors.emerald600;
        statusIcon = Icons.check_circle;
        break;
      case 'in_progress':
        statusColor = PharmaColors.info;
        statusIcon = Icons.play_circle;
        break;
      case 'not_started':
        statusColor = PharmaColors.gray500;
        statusIcon = Icons.circle_outlined;
        break;
      default:
        statusColor = PharmaColors.gray400;
        statusIcon = Icons.cancel;
        break;
    }

    final isOverdue = e.status != 'completed' &&
        e.status != 'cancelled' &&
        e.assignment != null &&
        e.assignment!.dueDate.isBefore(DateTime.now());

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(statusIcon,
            size: 14,
            color: isOverdue ? PharmaColors.danger : statusColor),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$courseName${version.isNotEmpty ? ' v$version' : ''}',
                    style: PharmaTypography.caption.copyWith(
                        fontWeight: FontWeight.w500,
                        color: PharmaColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Row(children: [
                  Text(
                      e.status.replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isOverdue
                              ? PharmaColors.danger
                              : statusColor,
                          letterSpacing: 0.5)),
                  if (isOverdue) ...[
                    const SizedBox(width: 4),
                    Text('OVERDUE',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: PharmaColors.danger,
                            letterSpacing: 0.5)),
                  ],
                  if (e.completedAt != null) ...[
                    const SizedBox(width: 6),
                    Text(
                        '· ${DateFormat('MMM d, yyyy').format(e.completedAt!)}',
                        style: TextStyle(
                            fontSize: 9,
                            color: PharmaColors.textTertiary)),
                  ],
                ]),
              ]),
        ),
      ]),
    );
  }

  Widget _certificateRow(Certificate c) {
    final isExpired =
        c.expiresAt != null && c.expiresAt!.isBefore(DateTime.now());
    final isRevoked = c.status == 'revoked';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(
            isRevoked
                ? Icons.cancel
                : isExpired
                    ? Icons.timer_off
                    : Icons.verified,
            size: 14,
            color: isRevoked || isExpired
                ? PharmaColors.danger
                : PharmaColors.emerald600),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    c.courseVersion?.course?.title ??
                        'Certificate #${c.id}',
                    style: PharmaTypography.caption.copyWith(
                        fontWeight: FontWeight.w500,
                        color: PharmaColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(
                    isRevoked
                        ? 'REVOKED'
                        : isExpired
                            ? 'EXPIRED ${c.expiresAt != null ? DateFormat('MMM d, yyyy').format(c.expiresAt!) : ''}'
                            : 'Issued ${DateFormat('MMM d, yyyy').format(c.issuedAt)}${c.expiresAt != null ? ' · Expires ${DateFormat('MMM d, yyyy').format(c.expiresAt!)}' : ''}',
                    style: TextStyle(
                        fontSize: 9,
                        color: isRevoked || isExpired
                            ? PharmaColors.danger
                            : PharmaColors.textTertiary)),
              ]),
        ),
      ]),
    );
  }

  Widget _detailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Container(
            width: 8,
            height: 8,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: PharmaTypography.body)),
        Text(value,
            style: PharmaTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COMPLIANCE CHIP
// ═══════════════════════════════════════════════════════════════════════════════

class _ComplianceChip extends StatelessWidget {
  const _ComplianceChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    String label;
    switch (status) {
      case 'compliant':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'COMPLIANT';
        break;
      case 'at_risk':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        label = 'AT RISK';
        break;
      case 'non_compliant':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.danger;
        label = 'NON-COMPLIANT';
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = status.toUpperCase();
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(label,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: fg,
              letterSpacing: 0.5)),
    );
  }
}
