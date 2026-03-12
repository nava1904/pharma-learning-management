import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';

/// EMP-08: Training history page - lists all enrollments with filters and self-export PDF.
class TrainingHistoryScreen extends ConsumerStatefulWidget {
  const TrainingHistoryScreen({super.key});

  @override
  ConsumerState<TrainingHistoryScreen> createState() =>
      _TrainingHistoryScreenState();
}

class _TrainingHistoryScreenState extends ConsumerState<TrainingHistoryScreen> {
  DateTime? _filterFrom;
  DateTime? _filterTo;
  String? _filterStatus; // completed, in_progress, not_started, overdue, obsolete
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);
    final trainingRecordsAsync = ref.watch(trainingRecordsProvider);

    return AppShell(
      title: 'My Training History',
      icon: Icons.history_rounded,
      child: userAsync.when(
        data: (user) {
          if (user == null || user.id == null) {
            return const EmptyState(
              message: 'User not found. Please log in.',
              icon: Icons.person_off_rounded,
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(enrollmentsProvider);
              ref.invalidate(certificatesProvider);
              ref.invalidate(trainingRecordsProvider);
            },
            child: _TrainingHistoryContent(
              userId: user.id!,
              enrollmentsAsync: enrollmentsAsync,
              certificatesAsync: certificatesAsync,
              trainingRecordsAsync: trainingRecordsAsync,
              filterFrom: _filterFrom,
              filterTo: _filterTo,
              filterStatus: _filterStatus,
              onFilterChanged: (from, to, status) {
                setState(() {
                  _filterFrom = from;
                  _filterTo = to;
                  _filterStatus = status;
                });
              },
              onExportPdf: _exporting
                  ? null
                  : () => _exportPdf(
                        context,
                        user.id!,
                        enrollmentsAsync.valueOrNull ?? [],
                        certificatesAsync.valueOrNull ?? [],
                        trainingRecordsAsync.valueOrNull ?? [],
                      ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $e', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(currentUserProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportPdf(
    BuildContext context,
    int userId,
    List<Enrollment> enrollments,
    List<Certificate> certificates,
    List<TrainingRecord> trainingRecords,
  ) async {
    setState(() => _exporting = true);
    final filtered = _applyFilters(enrollments, certificates);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'My Training History',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Generated: ${DateTime.now().toUtc().toIso8601String().split('T').first}',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.SizedBox(height: 16),
            pw.Text(
              'Total records: ${filtered.length}',
              style: const pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 12),
            ...filtered.map((e) {
              final cert = certificates.cast<Certificate?>().firstWhere(
                    (c) =>
                        c != null &&
                        c.courseVersionId == e.enrollment.courseVersionId &&
                        c.userId == userId,
                    orElse: () => null,
                  );
              final rec = trainingRecords.cast<TrainingRecord?>().firstWhere(
                    (r) =>
                        r != null && r.enrollmentId == e.enrollment.id,
                    orElse: () => null,
                  );
              final courseTitle =
                  e.enrollment.courseVersion?.course?.title ?? 'Course';
              final version = e.enrollment.courseVersion?.version ?? '?';
              final sopNum =
                  e.enrollment.courseVersion?.course?.sopNumber ?? '';
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Text(
                  '$courseTitle v$version${sopNum.isNotEmpty ? ' ($sopNum)' : ''} | '
                  '${e.enrollment.startedAt?.toIso8601String().split('T').first ?? '-'} | '
                  '${e.enrollment.completedAt?.toIso8601String().split('T').first ?? '-'} | '
                  'Score: ${rec?.score ?? '-'} | '
                  '${cert != null ? (cert.status == 'obsolete' ? 'Obsolete' : 'Certificate') : e.enrollment.status}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
              );
            }),
          ],
        ),
      ),
    );
    try {
      var bytes = await pdf.save();
      final hash = sha256.convert(bytes).toString();
      pdf.addPage(
        pw.Page(
          build: (ctx) => pw.Center(
            child: pw.Text(
              'Report Hash: $hash',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
      bytes = await pdf.save();
      await client.audit.logReportExport(
        reportType: 'employee_training_history',
        hashSha256: hash,
      );
      final result = await FilePicker.platform.saveFile(
        fileName:
            'training-history-${DateTime.now().toIso8601String().split('T')[0]}.pdf',
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result != null ? 'Report saved' : 'Export cancelled',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  List<_EnrollmentWithCert> _applyFilters(
    List<Enrollment> enrollments,
    List<Certificate> certificates,
  ) {
    var list = enrollments
        .map((e) => _EnrollmentWithCert(
              enrollment: e,
              certificate: certificates.cast<Certificate?>().firstWhere(
                    (c) =>
                        c != null &&
                        c.courseVersionId == e.courseVersionId &&
                        c.userId == e.userId,
                    orElse: () => null,
                  ),
            ))
        .toList();
    if (_filterFrom != null) {
      list = list.where((e) {
        final d = e.enrollment.completedAt ?? e.enrollment.startedAt;
        return d != null && !d.isBefore(_filterFrom!);
      }).toList();
    }
    if (_filterTo != null) {
      list = list.where((e) {
        final d = e.enrollment.completedAt ?? e.enrollment.startedAt;
        return d != null && !d.isAfter(_filterTo!);
      }).toList();
    }
    if (_filterStatus != null && _filterStatus!.isNotEmpty) {
      if (_filterStatus == 'obsolete') {
        list = list.where((e) => e.certificate?.status == 'obsolete').toList();
      } else {
        list = list
            .where((e) => e.enrollment.status == _filterStatus)
            .toList();
      }
    }
    list.sort((a, b) {
      final da = a.enrollment.completedAt ?? a.enrollment.startedAt ?? DateTime(1970);
      final db = b.enrollment.completedAt ?? b.enrollment.startedAt ?? DateTime(1970);
      return db.compareTo(da);
    });
    return list;
  }
}

class _EnrollmentWithCert {
  _EnrollmentWithCert({required this.enrollment, this.certificate});
  final Enrollment enrollment;
  final Certificate? certificate;
}

class _TrainingHistoryContent extends ConsumerWidget {
  const _TrainingHistoryContent({
    required this.userId,
    required this.enrollmentsAsync,
    required this.certificatesAsync,
    required this.trainingRecordsAsync,
    required this.filterFrom,
    required this.filterTo,
    required this.filterStatus,
    required this.onFilterChanged,
    required this.onExportPdf,
  });

  final int userId;
  final AsyncValue<List<Enrollment>> enrollmentsAsync;
  final AsyncValue<List<Certificate>> certificatesAsync;
  final AsyncValue<List<TrainingRecord>> trainingRecordsAsync;
  final DateTime? filterFrom;
  final DateTime? filterTo;
  final String? filterStatus;
  final void Function(DateTime?, DateTime?, String?) onFilterChanged;
  final VoidCallback? onExportPdf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return enrollmentsAsync.when(
      data: (enrollments) {
        return certificatesAsync.when(
          data: (certificates) {
            return trainingRecordsAsync.when(
              data: (trainingRecords) {
                var items = enrollments
                    .map((e) => _EnrollmentWithCert(
                          enrollment: e,
                          certificate: certificates.cast<Certificate?>().firstWhere(
                                (c) =>
                                    c != null &&
                                    c.courseVersionId == e.courseVersionId &&
                                    c.userId == userId,
                                orElse: () => null,
                              ),
                        ))
                    .toList();
                if (filterFrom != null) {
                  items = items.where((e) {
                    final d = e.enrollment.completedAt ?? e.enrollment.startedAt;
                    return d != null && !d.isBefore(filterFrom!);
                  }).toList();
                }
                if (filterTo != null) {
                  items = items.where((e) {
                    final d = e.enrollment.completedAt ?? e.enrollment.startedAt;
                    return d != null && !d.isAfter(filterTo!);
                  }).toList();
                }
                if (filterStatus != null && filterStatus!.isNotEmpty) {
                  if (filterStatus == 'obsolete') {
                    items = items
                        .where((e) => e.certificate?.status == 'obsolete')
                        .toList();
                  } else {
                    items = items
                        .where((e) => e.enrollment.status == filterStatus)
                        .toList();
                  }
                }
                items.sort((a, b) {
                  final da = a.enrollment.completedAt ??
                      a.enrollment.startedAt ??
                      DateTime(1970);
                  final db = b.enrollment.completedAt ??
                      b.enrollment.startedAt ??
                      DateTime(1970);
                  return db.compareTo(da);
                });

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FilterBar(
                        filterFrom: filterFrom,
                        filterTo: filterTo,
                        filterStatus: filterStatus,
                        onFilterChanged: onFilterChanged,
                        onExportPdf: onExportPdf,
                      ),
                      const SizedBox(height: 24),
                      if (items.isEmpty)
                        const EmptyState(
                          message: 'No training records match your filters',
                          icon: Icons.filter_list_off_rounded,
                        )
                      else
                        ...items.map((e) => _HistoryTile(
                              enrollment: e.enrollment,
                              certificate: e.certificate,
                              trainingRecords: trainingRecordsAsync.valueOrNull ?? [],
                              userId: userId,
                            )),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.filterFrom,
    required this.filterTo,
    required this.filterStatus,
    required this.onFilterChanged,
    required this.onExportPdf,
  });

  final DateTime? filterFrom;
  final DateTime? filterTo;
  final String? filterStatus;
  final void Function(DateTime?, DateTime?, String?) onFilterChanged;
  final VoidCallback? onExportPdf;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate900,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 140,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(
                    filterFrom != null
                        ? filterFrom!.toIso8601String().split('T').first
                        : 'From date',
                  ),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: filterFrom ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (d != null) onFilterChanged(d, filterTo, filterStatus);
                  },
                ),
              ),
              SizedBox(
                width: 140,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(
                    filterTo != null
                        ? filterTo!.toIso8601String().split('T').first
                        : 'To date',
                  ),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: filterTo ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (d != null) onFilterChanged(filterFrom, d, filterStatus);
                  },
                ),
              ),
              DropdownButton<String>(
                value: filterStatus,
                hint: const Text('Status'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('All')),
                  DropdownMenuItem(value: 'completed', child: Text('Completed')),
                  DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
                  DropdownMenuItem(value: 'not_started', child: Text('Not Started')),
                  DropdownMenuItem(value: 'overdue', child: Text('Overdue')),
                  DropdownMenuItem(value: 'obsolete', child: Text('Obsolete')),
                ],
                onChanged: (v) => onFilterChanged(filterFrom, filterTo, v),
              ),
              TextButton(
                onPressed: () => onFilterChanged(null, null, null),
                child: const Text('Clear'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: onExportPdf,
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Export my training history'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.enrollment,
    required this.certificate,
    required this.trainingRecords,
    required this.userId,
  });

  final Enrollment enrollment;
  final Certificate? certificate;
  final List<TrainingRecord> trainingRecords;
  final int userId;

  @override
  Widget build(BuildContext context) {
    final rec = trainingRecords.cast<TrainingRecord?>().firstWhere(
          (r) => r != null && r.enrollmentId == enrollment.id,
          orElse: () => null,
        );
    final courseTitle =
        enrollment.courseVersion?.course?.title ?? 'Course';
    final version = enrollment.courseVersion?.version ?? '?';
    final sopNum = enrollment.courseVersion?.course?.sopNumber ?? '';
    final certStatus = certificate?.status ?? 'active';
    final isObsolete = certStatus == 'obsolete';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isObsolete ? AppColors.slate100 : AppColors.slate50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isObsolete ? AppColors.slate300 : AppColors.slate200,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      courseTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    if (sopNum.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        '$sopNum v$version',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.slate500,
                            ),
                      ),
                    ],
                    const SizedBox(width: 8),
                    StatusBadge(
                      status: isObsolete ? 'obsolete' : enrollment.status,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Started: ${enrollment.startedAt?.toIso8601String().split('T').first ?? '-'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate600,
                          ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Completed: ${enrollment.completedAt?.toIso8601String().split('T').first ?? '-'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate600,
                          ),
                    ),
                    if (rec?.score != null) ...[
                      const SizedBox(width: 16),
                      Text(
                        'Score: ${rec!.score}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.slate600,
                            ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (certificate != null && certificate!.id != null)
            TextButton(
              onPressed: () =>
                  context.push('/certificate/${certificate!.id}'),
              child: const Text('View Certificate'),
            ),
        ],
      ),
    );
  }
}
