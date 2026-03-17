import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';

/// EMP-08: Digital Credentials Wallet (Odoo eLearning / LinkedIn Certifications style).
/// Uses enrollmentsProvider, certificatesProvider, trainingRecordsProvider; PDF export logs via client.audit.logReportExport.
class TrainingHistoryScreen extends ConsumerStatefulWidget {
  const TrainingHistoryScreen({super.key});

  @override
  ConsumerState<TrainingHistoryScreen> createState() =>
      _TrainingHistoryScreenState();
}

class _TrainingHistoryScreenState extends ConsumerState<TrainingHistoryScreen> {
  DateTime? _filterFrom;
  DateTime? _filterTo;
  String? _filterStatus;
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);
    final trainingRecordsAsync = ref.watch(trainingRecordsProvider);

    return AppShell(
      title: 'Digital Credentials Wallet',
      icon: Icons.workspace_premium_rounded,
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
            child: _WalletContent(
              userId: user.id!,
              enrollmentsAsync: enrollmentsAsync,
              certificatesAsync: certificatesAsync,
              trainingRecordsAsync: trainingRecordsAsync,
              filterFrom: _filterFrom,
              filterTo: _filterTo,
              filterStatus: _filterStatus,
              isExporting: _exporting,
              onFilterChanged: (from, to, status) {
                setState(() {
                  _filterFrom = from;
                  _filterTo = to;
                  _filterStatus = status;
                });
              },
              onExportPdf: _exporting
                  ? null
                  : () => _exportOfficialPdf(
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

  /// Builds official PDF with SHA-256 hash and logs export to backend (GxP).
  Future<void> _exportOfficialPdf(
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
              'Official Training Record & Credentials',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Generated: ${DateTime.now().toUtc().toIso8601String().split('T').first}',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.SizedBox(height: 16),
            pw.Text(
              'Total valid records: ${filtered.where((e) => e.certificate?.status != 'obsolete').length}',
              style: const pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 12),
            pw.Divider(),
            ...filtered.map((e) {
              final cert = _certificateForEnrollment(certificates, userId, e.enrollment);
              final rec = trainingRecords.cast<TrainingRecord?>().firstWhere(
                    (r) => r != null && r.enrollmentId == e.enrollment.id,
                    orElse: () => null,
                  );
              final courseTitle =
                  e.enrollment.courseVersion?.course?.title ?? 'Course';
              final version = e.enrollment.courseVersion?.version ?? '?';
              final sopNum =
                  e.enrollment.courseVersion?.course?.sopNumber ?? '';
              final isObsolete = cert?.status == 'obsolete';

              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 8),
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: isObsolete
                      ? const PdfColor(0.95, 0.95, 0.95)
                      : const PdfColor(1, 1, 1),
                  border: pw.Border.all(color: const PdfColor(0.8, 0.8, 0.8)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '$courseTitle v$version${sopNum.isNotEmpty ? ' ($sopNum)' : ''}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        pw.Text(
                          'Completed: ${e.enrollment.completedAt?.toIso8601String().split('T').first ?? '-'} | Score: ${rec?.score ?? '-'}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.Text(
                      isObsolete
                          ? 'OBSOLETE'
                          : (cert != null
                              ? 'VALID CERTIFICATE'
                              : e.enrollment.status.toUpperCase()),
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: isObsolete
                            ? const PdfColor(0.8, 0.2, 0.2)
                            : const PdfColor(0.1, 0.5, 0.1),
                      ),
                    ),
                  ],
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
              'End of Report.\nCryptographic Hash (SHA-256): $hash',
              textAlign: pw.TextAlign.center,
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
            'training-credentials-${DateTime.now().toIso8601String().split('T')[0]}.pdf',
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result != null ? 'Credentials saved securely' : 'Export cancelled',
          ),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Export failed: $e'),
          backgroundColor: AppColors.destructive,
        ),
      );
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Certificate? _certificateForEnrollment(
    List<Certificate> certificates,
    int userId,
    Enrollment enrollment,
  ) {
    return certificates
        .where((c) => c.courseVersionId == enrollment.courseVersionId && c.userId == userId)
        .firstOrNull;
  }

  List<_EnrollmentWithCert> _applyFilters(
    List<Enrollment> enrollments,
    List<Certificate> certificates,
  ) {
    var list = enrollments
        .map((e) => _EnrollmentWithCert(
              enrollment: e,
              certificate: _certificateForEnrollment(certificates, e.userId, e),
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
        list =
            list.where((e) => e.enrollment.status == _filterStatus).toList();
      }
    }
    list.sort((a, b) {
      final da = a.enrollment.completedAt ?? a.enrollment.startedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final db = b.enrollment.completedAt ?? b.enrollment.startedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return db.compareTo(da);
    });
    return list;
  }
}

Certificate? _certificateForEnrollment(
  List<Certificate> certificates,
  int userId,
  Enrollment enrollment,
) {
  return certificates
      .where((c) => c.courseVersionId == enrollment.courseVersionId && c.userId == userId)
      .firstOrNull;
}

class _EnrollmentWithCert {
  _EnrollmentWithCert({required this.enrollment, this.certificate});
  final Enrollment enrollment;
  final Certificate? certificate;
}

class _WalletContent extends ConsumerWidget {
  const _WalletContent({
    required this.userId,
    required this.enrollmentsAsync,
    required this.certificatesAsync,
    required this.trainingRecordsAsync,
    required this.filterFrom,
    required this.filterTo,
    required this.filterStatus,
    required this.isExporting,
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
  final bool isExporting;
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
                          certificate: _certificateForEnrollment(
                              certificates, userId, e),
                        ))
                    .toList();
                if (filterFrom != null) {
                  items = items.where((e) {
                    final d =
                        e.enrollment.completedAt ?? e.enrollment.startedAt;
                    return d != null && !d.isBefore(filterFrom!);
                  }).toList();
                }
                if (filterTo != null) {
                  items = items.where((e) {
                    final d =
                        e.enrollment.completedAt ?? e.enrollment.startedAt;
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
                        .where((e) =>
                            e.enrollment.status == filterStatus)
                        .toList();
                  }
                }
                items.sort((a, b) {
                  final da = a.enrollment.completedAt ??
                      a.enrollment.startedAt ??
                      DateTime.fromMillisecondsSinceEpoch(0);
                  final db = b.enrollment.completedAt ??
                      b.enrollment.startedAt ??
                      DateTime.fromMillisecondsSinceEpoch(0);
                  return db.compareTo(da);
                });

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Digital Credentials Wallet',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: AppColors.slate900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Your official, verified compliance records.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: AppColors.slate600,
                                          ),
                                    ),
                                  ],
                                ),
                                FilledButton.icon(
                                  onPressed: onExportPdf,
                                  icon: isExporting
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.picture_as_pdf_rounded,
                                        ),
                                  label: Text(isExporting
                                      ? 'Generating...'
                                      : 'Export Official PDF'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.indigo600,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            _WalletFilterBar(
                              filterFrom: filterFrom,
                              filterTo: filterTo,
                              filterStatus: filterStatus,
                              onFilterChanged: onFilterChanged,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (items.isEmpty)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyState(
                          message: 'No credentials match your filters.',
                          icon: Icons.filter_list_off_rounded,
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 400,
                            mainAxisExtent: 220,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final e = items[index];
                              return _CertificateWalletCard(
                                enrollment: e.enrollment,
                                certificate: e.certificate,
                                trainingRecords: trainingRecords,
                                userId: userId,
                              );
                            },
                            childCount: items.length,
                          ),
                        ),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

/// Inline wrap: From Date, To Date, Status dropdown.
class _WalletFilterBar extends StatelessWidget {
  const _WalletFilterBar({
    required this.filterFrom,
    required this.filterTo,
    required this.filterStatus,
    required this.onFilterChanged,
  });

  final DateTime? filterFrom;
  final DateTime? filterTo;
  final String? filterStatus;
  final void Function(DateTime?, DateTime?, String?) onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.filter_list, color: AppColors.slate500, size: 20),
          const SizedBox(width: 4),
          SizedBox(
            width: 140,
            height: 40,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.calendar_today, size: 16),
              label: Text(
                filterFrom != null
                    ? filterFrom!.toIso8601String().split('T').first
                    : 'From Date',
                style: const TextStyle(fontSize: 13),
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
            height: 40,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.calendar_today, size: 16),
              label: Text(
                filterTo != null
                    ? filterTo!.toIso8601String().split('T').first
                    : 'To Date',
                style: const TextStyle(fontSize: 13),
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
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.slate300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: filterStatus,
                hint: const Text('Status',
                    style: TextStyle(fontSize: 13)),
                icon: const Icon(Icons.arrow_drop_down, size: 20),
                style: TextStyle(
                    color: AppColors.slate700,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                items: const [
                  DropdownMenuItem(value: null, child: Text('All Statuses')),
                  DropdownMenuItem(
                      value: 'completed', child: Text('Valid Certificates')),
                  DropdownMenuItem(
                      value: 'obsolete', child: Text('Obsolete / Superseded')),
                  DropdownMenuItem(
                      value: 'in_progress', child: Text('In Progress')),
                  DropdownMenuItem(
                      value: 'not_started', child: Text('Not Started')),
                ],
                onChanged: (v) => onFilterChanged(filterFrom, filterTo, v),
              ),
            ),
          ),
          if (filterFrom != null ||
              filterTo != null ||
              filterStatus != null)
            TextButton(
              onPressed: () => onFilterChanged(null, null, null),
              child: const Text('Clear Filters'),
            ),
        ],
      ),
    );
  }
}

/// Convert enrollment status to human-readable label
String _formatStatusLabel(String status) {
  switch (status) {
    case 'in_progress':
      return 'In Progress';
    case 'not_started':
      return 'Not Started';
    case 'completed':
      return 'Completed';
    case 'assigned':
      return 'Assigned';
    case 'cancelled':
      return 'Cancelled';
    case 'overdue':
      return 'Overdue';
    default:
      return status.replaceAll('_', ' ');
  }
}

/// Premium credential card. Obsolete: grayscale + diagonal SUPERSEDED watermark (GxP).
class _CertificateWalletCard extends StatelessWidget {
  const _CertificateWalletCard({
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
        enrollment.courseVersion?.course?.title ?? 'Unknown Course';
    final version = enrollment.courseVersion?.version ?? '?';
    final sopNum = enrollment.courseVersion?.course?.sopNumber ?? '';
    final bool hasCert = certificate != null;
    final bool isObsolete = certificate?.status == 'obsolete';
    final bool isInProgress = enrollment.status == 'in_progress' ||
        enrollment.status == 'not_started';

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isObsolete ? AppColors.slate100 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isObsolete
                    ? AppColors.slate300
                    : (hasCert ? AppColors.indigo200 : AppColors.slate200),
                width: hasCert && !isObsolete ? 2 : 1,
              ),
              boxShadow: isObsolete
                  ? []
                  : [
                      BoxShadow(
                        color: AppColors.indigo900.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isObsolete
                        ? AppColors.slate200
                        : (hasCert
                            ? AppColors.indigo50
                            : AppColors.slate50),
                    border: Border(
                        bottom: BorderSide(color: AppColors.slate200)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        hasCert ? Icons.workspace_premium : Icons.menu_book,
                        color: isObsolete
                            ? AppColors.slate400
                            : (hasCert
                                ? Colors.amber[700]
                                : AppColors.slate500),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          sopNum.isNotEmpty
                              ? '$sopNum v$version'
                              : 'Course v$version',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isObsolete
                                ? AppColors.slate500
                                : AppColors.slate700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (hasCert && !isObsolete)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'VERIFIED',
                            style: TextStyle(
                                color: AppColors.success,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isObsolete
                                      ? AppColors.slate500
                                      : AppColors.slate900,
                                ),
                      ),
                      const SizedBox(height: 12),
                      if (enrollment.completedAt != null)
                        Text(
                          'Completed ${enrollment.completedAt!.toIso8601String().split('T').first}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isObsolete
                                ? AppColors.slate500
                                : AppColors.slate700,
                          ),
                        )
                      else
                        Text(
                          _formatStatusLabel(enrollment.status),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (rec?.score != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Score: ${rec!.score}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isObsolete
                                ? AppColors.slate500
                                : AppColors.slate800,
                          ),
                        ),
                      ],
                      const Spacer(),
                      if (hasCert)
                        OutlinedButton(
                          onPressed: () => context.push(
                              '/certificate/${certificate!.id}'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: isObsolete
                                ? AppColors.slate600
                                : AppColors.indigo600,
                            side: BorderSide(
                                color: isObsolete
                                    ? AppColors.slate300
                                    : AppColors.indigo200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text('View Certificate'),
                        )
                      else if (isInProgress)
                        FilledButton.tonal(
                          onPressed: () => context.push('/employee'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text('Continue'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isObsolete)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.white.withOpacity(0.25),
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.5,
                      child: Text(
                        'SUPERSEDED',
                        style: TextStyle(
                          color: AppColors.destructive.withOpacity(0.7),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (isObsolete) {
      return ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0,      0,      0,      1, 0,
        ]),
        child: card,
      );
    }
    return card;
  }
}
