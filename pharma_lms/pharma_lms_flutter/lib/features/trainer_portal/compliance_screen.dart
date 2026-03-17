// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COMPLIANCE SCREEN (TRN-COMP)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/compliance
// Shows compliance metrics, audit readiness score, course archive,
// and e-signature verification information.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';

class TrainerComplianceScreen extends ConsumerStatefulWidget {
  const TrainerComplianceScreen({super.key});

  @override
  ConsumerState<TrainerComplianceScreen> createState() =>
      _TrainerComplianceScreenState();
}

class _TrainerComplianceScreenState
    extends ConsumerState<TrainerComplianceScreen> {
  bool _loading = true;
  String? _error;
  AuditReadinessScore? _readinessScore;
  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);

      final results = await Future.wait([
        client.analytics.getAuditReadinessScore(
          organizationId: user?.organizationId,
        ),
        client.course.listCourses(
          organizationId: user?.organizationId,
        ),
      ]);

      if (mounted) {
        setState(() {
          _readinessScore = results[0] as AuditReadinessScore;
          _courses = results[1] as List<Course>;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text('Failed to load compliance data',
                style: PharmaTypography.bodyMedium),
            const SizedBox(height: 4),
            Text(_error!,
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: _loadData, child: const Text('Retry')),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        _buildReadinessScoreCard(),
        const SizedBox(height: 20),
        _buildComplianceMetrics(),
        const SizedBox(height: 24),
        _buildESignatureSection(),
        const SizedBox(height: 24),
        _buildCourseArchive(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.shield, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compliance',
                style: PharmaTypography.headingLarge
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text(
                'Regulatory compliance status, audit readiness, and CFR Part 11 controls',
                style: PharmaTypography.body
                    .copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: _loadData,
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Refresh'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.emerald600,
            side: BorderSide(color: PharmaColors.emerald200),
          ),
        ),
      ],
    );
  }

  /// Converts API score to display percentage (0-100).
  /// API may return 0-1 (fraction) or 0-100 (already percentage).
  int _toDisplayPercent(double score) {
    final pct = score > 1 ? score : score * 100;
    return pct.clamp(0, 100).round();
  }

  /// Converts API score to CircularProgressIndicator value (0.0-1.0).
  double _toProgressValue(double score) {
    return (score > 1 ? score / 100 : score).clamp(0.0, 1.0);
  }

  Widget _buildReadinessScoreCard() {
    if (_readinessScore == null) return const SizedBox.shrink();

    final score = _readinessScore!;
    final overallPct = _toDisplayPercent(score.overallScore);
    final compliancePct = _toDisplayPercent(score.complianceScore);
    final scoreColor = overallPct >= 80
        ? PharmaColors.emerald600
        : overallPct >= 60
            ? PharmaColors.warning
            : PharmaColors.danger;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        children: [
          // Score circle
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: _toProgressValue(score.overallScore),
                    strokeWidth: 8,
                    backgroundColor: PharmaColors.gray200,
                    valueColor: AlwaysStoppedAnimation(scoreColor),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$overallPct%',
                      style: PharmaTypography.headingLarge.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: scoreColor,
                      ),
                    ),
                    Text(
                      'Overall',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Audit Readiness Score',
                    style: PharmaTypography.headingSmall),
                const SizedBox(height: 12),
                _metricRow(
                  'Compliance Score',
                  '$compliancePct%',
                  compliancePct >= 80
                      ? PharmaColors.emerald600
                      : PharmaColors.warning,
                ),
                const SizedBox(height: 8),
                _metricRow(
                  'Audit Trail',
                  score.auditTrailActive ? 'Active' : 'Inactive',
                  score.auditTrailActive
                      ? PharmaColors.emerald600
                      : PharmaColors.danger,
                ),
                const SizedBox(height: 8),
                _metricRow(
                  'Departments Covered',
                  '${score.departmentCount}',
                  PharmaColors.info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricRow(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: PharmaTypography.body),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: PharmaRadius.pillRadius,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceMetrics() {
    final approvedCount =
        _courses.where((c) => c.status == 'approved' || c.status == 'effective' || c.status == 'published').length;
    final totalCourses = _courses.length;
    final complianceRate =
        totalCourses > 0 ? (approvedCount / totalCourses * 100).round() : 0;

    return Row(
      children: [
        Expanded(
          child: _ComplianceMetricCard(
            icon: Icons.verified,
            label: '21 CFR Part 11',
            value: _readinessScore?.auditTrailActive == true
                ? 'Compliant'
                : 'Review Needed',
            color: _readinessScore?.auditTrailActive == true
                ? PharmaColors.emerald600
                : PharmaColors.warning,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ComplianceMetricCard(
            icon: Icons.menu_book,
            label: 'Course Approval Rate',
            value: '$complianceRate%',
            color: complianceRate >= 80
                ? PharmaColors.emerald600
                : PharmaColors.warning,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ComplianceMetricCard(
            icon: Icons.draw,
            label: 'E-Signatures',
            value: 'Enabled',
            color: PharmaColors.emerald600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ComplianceMetricCard(
            icon: Icons.history,
            label: 'Audit Trail',
            value: _readinessScore?.auditTrailActive == true
                ? 'Recording'
                : 'Inactive',
            color: _readinessScore?.auditTrailActive == true
                ? PharmaColors.emerald600
                : PharmaColors.danger,
          ),
        ),
      ],
    );
  }

  Widget _buildESignatureSection() {
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
          Row(
            children: [
              Icon(Icons.draw, color: PharmaColors.emerald600, size: 20),
              const SizedBox(width: 8),
              Text('E-Signature Verification',
                  style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: PharmaColors.successBg,
                  borderRadius: PharmaRadius.pillRadius,
                ),
                child: Text(
                  'CFR Part 11 Compliant',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: PharmaColors.successText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _esigRow(
            Icons.check_circle,
            'Electronic Signature Capture',
            'Active — all QA approvals require e-signature',
          ),
          _esigRow(
            Icons.check_circle,
            'Signature Meaning Declarations',
            'Enabled — signers declare intent before signing',
          ),
          _esigRow(
            Icons.check_circle,
            'Tamper-Evident Audit Trail',
            'SHA-256 hashing applied to all signature records',
          ),
          _esigRow(
            Icons.check_circle,
            'Non-Repudiation',
            'Signatures are bound to user identity and timestamp',
          ),
        ],
      ),
    );
  }

  Widget _esigRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: PharmaColors.emerald600),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PharmaTypography.bodyMedium),
                Text(subtitle,
                    style: PharmaTypography.caption
                        .copyWith(color: PharmaColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseArchive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Course Archive',
                style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
            const Spacer(),
            Text(
              '${_courses.length} courses',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_courses.isEmpty)
          PharmaCard(
            child: PharmaEmptyState(
              icon: Icons.archive_outlined,
              title: 'No Courses',
              subtitle: 'Course compliance data will appear here.',
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(color: PharmaColors.borderLight),
            ),
            child: Column(
              children: [
                // Table header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: PharmaColors.pageBg,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text('COURSE',
                            style: PharmaTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 10)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('SOP',
                            style: PharmaTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 10)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('STATUS',
                            style: PharmaTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: PharmaColors.borderLight),
                ..._courses.map((course) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: PharmaColors.borderLight),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            course.title,
                            style: PharmaTypography.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            course.sopNumber ?? '—',
                            style: PharmaTypography.caption.copyWith(
                              fontFamily: 'monospace',
                              color: PharmaColors.textTertiary,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: _StatusChip(status: course.status),
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
  }
}

class _ComplianceMetricCard extends StatelessWidget {
  const _ComplianceMetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 10),
          Text(label,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          const SizedBox(height: 4),
          Text(
            value,
            style: PharmaTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    String label;
    switch (status) {
      case 'approved':
      case 'effective':
      case 'published':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'Approved';
        break;
      case 'pending_qa':
      case 'under_review':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        label = 'Under Review';
        break;
      case 'rejected':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.dangerText;
        label = 'Rejected';
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = 'Draft';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: PharmaRadius.pillRadius,
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600, color: fg),
        ),
      ),
    );
  }
}
