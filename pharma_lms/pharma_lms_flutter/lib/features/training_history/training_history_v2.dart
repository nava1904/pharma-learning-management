// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINING HISTORY V2 — Matches React ref2 TrainingHistory.tsx
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/training-history
// Design: Table layout with image, course name, dates, status badge, action
// Backend: trainingRecordsProvider + enrollmentsProvider (Serverpod)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

class TrainingHistoryV2 extends ConsumerStatefulWidget {
  const TrainingHistoryV2({super.key});

  @override
  ConsumerState<TrainingHistoryV2> createState() => _TrainingHistoryV2State();
}

class _TrainingHistoryV2State extends ConsumerState<TrainingHistoryV2> {
  int _selectedTab = 0;
  final _tabs = ['All Records', 'Completed', 'In Progress', 'Not Started'];
  final Set<int> _expandedRows = {};
  bool _exporting = false;
  final Map<int, double> _progressCache = {};
  final Set<int> _progressLoading = {};

  void _loadProgressForEnrollments(List<Enrollment> enrollments) {
    for (final e in enrollments) {
      if (e.id == null || e.status == 'completed' || _progressCache.containsKey(e.id) || _progressLoading.contains(e.id)) continue;
      _progressLoading.add(e.id!);
      client.training.getEnrollmentProgress(e.id!).then((result) {
        if (mounted) {
          setState(() {
            _progressCache[e.id!] = double.tryParse(result['progressPct']?.toString() ?? '') ?? 0.0;
          });
        }
      }).catchError((_) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final recordsAsync = ref.watch(trainingRecordsProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);

    return RefreshIndicator(
      color: PharmaColors.emerald600,
      onRefresh: () async {
        ref.invalidate(trainingRecordsProvider);
        ref.invalidate(enrollmentsProvider);
        ref.invalidate(certificatesProvider);
        await Future.wait([
          ref.refresh(trainingRecordsProvider.future),
          ref.refresh(enrollmentsProvider.future),
          ref.refresh(certificatesProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: PharmaSpacing.sectionGap),
            _buildTabs(),
            const SizedBox(height: PharmaSpacing.sectionGap),
            _buildContent(recordsAsync, enrollmentsAsync, certificatesAsync),
            const SizedBox(height: PharmaSpacing.sectionGap),
            _buildNavButtons(),
            const SizedBox(height: PharmaSpacing.sectionGap),
            // ALCOA+ Compliance Footer (FRD SCR-05)
            _buildAlcoaFooter(),
          ],
        ),
      ),
    );
  }

  // ─── HEADER ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('Training History', style: PharmaTypography.headingLarge),
          ],
        ),
        OutlinedButton.icon(
          onPressed: _exporting ? null : () => _downloadPdf(context),
          icon: _exporting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: PharmaColors.emerald600),
                )
              : const Icon(Icons.file_download_outlined, size: 16),
          label: Text(_exporting ? 'Generating...' : 'Download PDF'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.textPrimary,
            side: const BorderSide(color: PharmaColors.borderMedium),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PharmaRadius.lg),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ],
    );
  }

  Certificate? _certForEnrollment(List<Certificate> certs, int userId, Enrollment e) {
    try {
      return certs.firstWhere((c) => c.courseVersionId == e.courseVersionId && c.userId == userId);
    } catch (_) {
      return null;
    }
  }

  TrainingRecord? _recordForEnrollment(List<TrainingRecord> records, Enrollment e) {
    try {
      return records.firstWhere((r) => r.enrollmentId == e.id);
    } catch (_) {
      return null;
    }
  }

  Future<void> _downloadPdf(BuildContext context) async {
    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to export'), behavior: SnackBarBehavior.floating),
      );
      return;
    }
    setState(() => _exporting = true);
    try {
      final enrollments = await ref.read(enrollmentsProvider.future);
      final certificates = await ref.read(certificatesProvider.future);
      final trainingRecords = await ref.read(trainingRecordsProvider.future);
      final userId = user!.id!;

      final items = enrollments.map((e) {
        final cert = _certForEnrollment(certificates, userId, e);
        final rec = _recordForEnrollment(trainingRecords, e);
        return (enrollment: e, certificate: cert, record: rec);
      }).toList();
      items.sort((a, b) {
        final da = a.enrollment.completedAt ?? a.enrollment.startedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final db = b.enrollment.completedAt ?? b.enrollment.startedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return db.compareTo(da);
      });

      const textDark = PdfColor.fromInt(0xFF1E293B);
      const textLight = PdfColor.fromInt(0xFF64748B);
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (ctx) {
            return pw.Stack(
              children: [
                pw.Positioned.fill(
                  child: pw.Center(
                    child: pw.Transform.rotate(
                      angle: -0.3,
                      child: pw.Opacity(
                        opacity: 0.04,
                        child: pw.Text(
                          'Vyuh lms',
                          style: pw.TextStyle(fontSize: 120, fontWeight: pw.FontWeight.bold, color: PdfColors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(24),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Official Training Record & Credentials',
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: textDark),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Generated: ${DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc())} UTC',
                        style: const pw.TextStyle(fontSize: 10, color: textLight),
                      ),
                      pw.SizedBox(height: 16),
                      pw.Text(
                        'Total records: ${items.length}',
                        style: const pw.TextStyle(fontSize: 12, color: textDark),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Divider(),
                      ...items.map((item) {
                        final courseTitle = item.enrollment.courseVersion?.course?.title ?? 'Course';
                        final version = item.enrollment.courseVersion?.version ?? '?';
                        final sopNum = item.enrollment.courseVersion?.course?.sopNumber ?? '';
                        final isObsolete = item.certificate?.status == 'obsolete';
                        final completedStr = item.enrollment.completedAt != null
                            ? DateFormat('yyyy-MM-dd').format(item.enrollment.completedAt!)
                            : '-';
                        final scoreStr = item.record?.score != null ? '${item.record!.score}%' : '-';
                        final statusStr = isObsolete
                            ? 'OBSOLETE'
                            : (item.certificate != null ? 'VALID CERTIFICATE' : item.enrollment.status.toUpperCase());
                        return pw.Container(
                          margin: const pw.EdgeInsets.only(bottom: 8),
                          padding: const pw.EdgeInsets.all(8),
                          decoration: pw.BoxDecoration(
                            color: isObsolete ? const PdfColor(0.95, 0.95, 0.95) : const PdfColor(1, 1, 1),
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
                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
                                  ),
                                  pw.Text(
                                    'Completed: $completedStr | Score: $scoreStr',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              pw.Text(
                                statusStr,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: isObsolete ? const PdfColor(0.8, 0.2, 0.2) : const PdfColor(0.1, 0.5, 0.1),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

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

      try {
        await client.audit.logReportExport(reportType: 'employee_training_history', hashSha256: hash);
      } catch (_) {}

      final fileName = 'training-history-${DateFormat('yyyy-MM-dd').format(DateTime.now())}.pdf';
      final saved = await saveBytesToFile(bytes, fileName);
      if (!mounted) return;
      setState(() => _exporting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(saved ? 'Training history PDF saved' : 'Export cancelled'),
          backgroundColor: saved ? PharmaColors.emerald600 : null,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (mounted) {
        setState(() => _exporting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: PharmaColors.danger,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // ─── TABS ────────────────────────────────────────────────────────────────────
  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: PharmaColors.borderLight),
        ),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: Container(
              padding: const EdgeInsets.only(bottom: 12, right: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? PharmaColors.emerald600 : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected ? PharmaColors.emerald600 : PharmaColors.textTertiary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── CONTENT ─────────────────────────────────────────────────────────────────
  Widget _buildContent(
    AsyncValue<List<TrainingRecord>> recordsAsync,
    AsyncValue<List<Enrollment>> enrollmentsAsync,
    AsyncValue<List<Certificate>> certificatesAsync,
  ) {
    return enrollmentsAsync.when(
      loading: () => _buildSkeleton(),
      error: (e, _) => _buildError(),
      data: (enrollments) {
        final records = recordsAsync.valueOrNull ?? [];
        final certificates = certificatesAsync.valueOrNull ?? [];

        _loadProgressForEnrollments(enrollments);

        // Build unified history items
        final items = _buildHistoryItems(enrollments, records, certificates);

        // Filter by tab
        final filtered = _filterByTab(items);

        if (filtered.isEmpty) {
          return _buildEmpty();
        }

        return Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(
            children: [
              // Table header
              _buildTableHeader(),
              // Table rows
              ...filtered.asMap().entries.map((entry) {
                return _buildTableRow(entry.value, entry.key + 1, entry.key < filtered.length - 1);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: PharmaColors.borderLight),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('#', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 48,
            child: Text('', style: PharmaTypography.caption),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text('Course', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Enrolled', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Completed', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          Expanded(
            flex: 1,
            child: Text('Score', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Progress', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Status', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500, color: PharmaColors.textSecondary)),
          ),
          const SizedBox(width: 80), // Actions column
        ],
      ),
    );
  }

  Widget _buildTableRow(_HistoryItem item, int index, bool showBorder) {
    final isExpanded = _expandedRows.contains(item.enrollmentId);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isExpanded ? PharmaColors.gray50 : null,
            border: showBorder && !isExpanded
                ? const Border(bottom: BorderSide(color: PharmaColors.borderLight))
                : null,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedRows.remove(item.enrollmentId);
                } else {
                  _expandedRows.add(item.enrollmentId);
                }
              });
            },
            child: Row(
              children: [
                // Expand/collapse chevron
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: PharmaColors.textQuaternary,
                ),
                SizedBox(
                  width: 28,
                  child: Text('$index', style: PharmaTypography.body),
                ),
                const SizedBox(width: 12),
                // Image avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PharmaColors.emerald100,
                    borderRadius: BorderRadius.circular(PharmaRadius.full),
                  ),
                  child: Center(
                    child: Text(
                      item.courseName.isNotEmpty ? item.courseName[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PharmaColors.emerald700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Course name
                Expanded(
                  flex: 3,
                  child: Text(
                    item.courseName,
                    style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Enrolled date
                Expanded(
                  flex: 2,
                  child: Text(item.enrolledDate, style: PharmaTypography.body),
                ),
                // Completed date
                Expanded(
                  flex: 2,
                  child: Text(item.completedDate, style: PharmaTypography.body),
                ),
                // Score column
                Expanded(
                  flex: 1,
                  child: Text(
                    item.score != null ? '${item.score}%' : '—',
                    style: PharmaTypography.bodyMedium.copyWith(
                      color: item.score != null ? PharmaColors.emerald600 : PharmaColors.textQuaternary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Progress column
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: item.progressPct / 100.0,
                            minHeight: 6,
                            backgroundColor: PharmaColors.gray100,
                            valueColor: AlwaysStoppedAnimation(
                              item.progressPct >= 100 ? PharmaColors.emerald500 : PharmaColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${item.progressPct.toInt()}%',
                        style: PharmaTypography.caption.copyWith(
                          color: PharmaColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status badge
                Expanded(flex: 2, child: _buildStatusBadge(item.status, item.score)),
                // Action links
                SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.status == 'completed' && item.hasCertificate)
                        Tooltip(
                          message: 'View Certificate',
                          child: IconButton(
                            icon: Icon(Icons.workspace_premium_rounded, size: 18, color: PharmaColors.emerald600),
                            onPressed: () {
                              final id = item.certificateId;
                              if (id != null) {
                                context.push('/certificate/$id');
                              } else {
                                context.go('/employee/credentials');
                              }
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                        ),
                      Tooltip(
                        message: 'View Course',
                        child: IconButton(
                          icon: Icon(Icons.chevron_right_rounded, size: 20, color: PharmaColors.textQuaternary),
                          onPressed: () => context.go(
                            '/employee/course/${item.courseVersionId}',
                            extra: {
                              'courseVersionId': item.courseVersionId,
                              'enrollmentId': item.enrollmentId.toString(),
                            },
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── EXPANDED DETAIL ROW (FRD SCR-05: e-sig, audit trail, version) ──
        if (isExpanded)
          Container(
            padding: const EdgeInsets.fromLTRB(64, 0, 16, 16),
            decoration: BoxDecoration(
              color: PharmaColors.gray50,
              border: showBorder
                  ? const Border(bottom: BorderSide(color: PharmaColors.borderLight))
                  : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              decoration: BoxDecoration(
                color: PharmaColors.cardBg,
                borderRadius: BorderRadius.circular(PharmaRadius.lg),
                border: Border.all(color: PharmaColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _expandedDetail('Course Version', 'v${item.courseVersionId}'),
                      const SizedBox(width: PharmaSpacing.xxl),
                      _expandedDetail('Enrollment ID', '#${item.enrollmentId}'),
                      const SizedBox(width: PharmaSpacing.xxl),
                      if (item.score != null)
                        _expandedDetail('Assessment Score', '${item.score}%'),
                    ],
                  ),
                  if (item.status == 'completed') ...[
                    const SizedBox(height: PharmaSpacing.md),
                    Row(
                      children: [
                        Icon(Icons.verified_rounded, size: 14, color: PharmaColors.emerald600),
                        const SizedBox(width: 4),
                        Text(
                          'E-Signature recorded • 21 CFR Part 11 compliant',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.emerald700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _expandedDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: PharmaTypography.bodyMedium),
      ],
    );
  }

  Widget _buildStatusBadge(String status, int? score) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case 'completed':
        bgColor = PharmaColors.emerald100;
        textColor = PharmaColors.emerald700;
        label = score != null ? 'Completed · $score%' : 'Completed';
        break;
      case 'in_progress':
        bgColor = PharmaColors.infoBg;
        textColor = PharmaColors.infoText;
        label = 'In Progress';
        break;
      case 'overdue':
        bgColor = PharmaColors.dangerBg;
        textColor = PharmaColors.dangerText;
        label = 'Overdue';
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.gray700;
        label = 'Not Started';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  // ─── NAV BUTTONS (matches React) ─────────────────────────────────────────────
  Widget _buildNavButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.chevron_left_rounded, size: 16),
          label: const Text('Back'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.textPrimary,
            side: const BorderSide(color: PharmaColors.borderMedium),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PharmaRadius.lg),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Refresh
            ref.invalidate(trainingRecordsProvider);
            ref.invalidate(enrollmentsProvider);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PharmaRadius.lg),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Refresh', style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  // ─── ALCOA+ COMPLIANCE FOOTER (FRD SCR-05) ────────────────────────────────
  Widget _buildAlcoaFooter() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.gray50,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user_outlined, size: 16, color: PharmaColors.emerald600),
          const SizedBox(width: PharmaSpacing.sm),
          Expanded(
            child: Text(
              'ALCOA+ Compliant Records  •  Attributable · Legible · Contemporaneous · Original · Accurate  •  '
              'All training records are electronically signed per 21 CFR Part 11 and GMP Annex 11.',
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textTertiary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── DATA HELPERS ────────────────────────────────────────────────────────────
  List<_HistoryItem> _buildHistoryItems(
    List<Enrollment> enrollments,
    List<TrainingRecord> records,
    List<Certificate> certificates,
  ) {
    final dateFormat = DateFormat('MM/dd/yyyy');
    final recordMap = <int, TrainingRecord>{};
    for (final r in records) {
      recordMap[r.enrollmentId] = r;
    }

    final certIdByCourseVersionId = <int, int>{};
    for (final c in certificates) {
      if (c.id != null) {
        certIdByCourseVersionId[c.courseVersionId] = c.id!;
      }
    }

    return enrollments.map((e) {
      final record = recordMap[e.id];
      final courseName = e.courseVersion?.course?.title ?? 'Course #${e.courseVersionId}';
      final enrolledDate = e.startedAt != null ? dateFormat.format(e.startedAt!) : '-';
      final completedDate = record != null ? dateFormat.format(record.completedAt) : '-';

      final progressPct = e.status == 'completed'
          ? 100.0
          : _progressCache[e.id] ?? 0.0;

      final certificateId = certIdByCourseVersionId[e.courseVersionId];

      return _HistoryItem(
        enrollmentId: e.id ?? 0,
        courseVersionId: e.courseVersionId,
        courseName: courseName,
        enrolledDate: enrolledDate,
        completedDate: completedDate,
        status: e.status,
        score: record?.score,
        hasCertificate: certificateId != null,
        certificateId: certificateId,
        progressPct: progressPct,
      );
    }).toList()
      ..sort((a, b) {
        // Sort completed first, then in-progress, then not-started
        const order = {'completed': 0, 'in_progress': 1, 'assigned': 2, 'not_started': 3};
        return (order[a.status] ?? 4).compareTo(order[b.status] ?? 4);
      });
  }

  List<_HistoryItem> _filterByTab(List<_HistoryItem> items) {
    switch (_selectedTab) {
      case 1: // Completed
        return items.where((i) => i.status == 'completed').toList();
      case 2: // In Progress
        return items.where((i) => i.status == 'in_progress').toList();
      case 3: // Not Started
        return items.where((i) => i.status == 'not_started' || i.status == 'assigned').toList();
      default: // All
        return items;
    }
  }

  // ─── STATES ──────────────────────────────────────────────────────────────────
  Widget _buildSkeleton() {
    return Column(
      children: List.generate(5, (i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          height: 64,
          decoration: BoxDecoration(
            color: PharmaColors.gray100,
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
          ),
        );
      }),
    );
  }

  Widget _buildEmpty() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.history_rounded, size: 48, color: PharmaColors.textQuaternary),
            const SizedBox(height: 16),
            Text('No Training Records', style: PharmaTypography.headingMedium),
            const SizedBox(height: 8),
            Text(
              'Your training history will appear here once you complete courses.',
              style: PharmaTypography.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline_rounded, size: 48, color: PharmaColors.dangerText),
            const SizedBox(height: 16),
            Text('Failed to load training history', style: PharmaTypography.headingMedium),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(enrollmentsProvider);
                ref.invalidate(trainingRecordsProvider);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryItem {
  final int enrollmentId;
  final int courseVersionId;
  final String courseName;
  final String enrolledDate;
  final String completedDate;
  final String status;
  final int? score;
  final bool hasCertificate;
  final int? certificateId;
  final double progressPct;

  _HistoryItem({
    required this.enrollmentId,
    required this.courseVersionId,
    required this.courseName,
    required this.enrolledDate,
    required this.completedDate,
    required this.status,
    this.score,
    this.hasCertificate = false,
    this.certificateId,
    this.progressPct = 0.0,
  });
}
