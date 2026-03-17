import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';

/// SCR-19 — Training Waiver View (Employee side).
/// Shows an approved/pending/rejected waiver for a specific training assignment.
class TrainingWaiverScreen extends StatefulWidget {
  const TrainingWaiverScreen({super.key, required this.waiverId});

  final String waiverId;

  @override
  State<TrainingWaiverScreen> createState() => _TrainingWaiverScreenState();
}

class _TrainingWaiverScreenState extends State<TrainingWaiverScreen> {
  bool _loading = true;
  String? _error;
  TrainingWaiver? _waiver;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = int.tryParse(widget.waiverId);
    if (id == null) {
      setState(() {
        _error = 'Invalid waiver ID.';
        _loading = false;
      });
      return;
    }
    try {
      final waiver = await client.training.getWaiverById(id);
      if (mounted) {
        setState(() {
          _waiver = waiver;
          _loading = false;
          if (waiver == null) _error = 'Waiver not found or you do not have access.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load waiver: $e';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Waiver'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/employee'),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null || _waiver == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text(_error ?? 'Waiver not found.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/employee'),
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      );
    }

    final w = _waiver!;
    final status = w.status ?? 'pending';
    final isApproved = status == 'approved';
    final isPending = status == 'pending';
    final courseTitle = w.course?.title ?? 'Course';

    Color statusBg;
    Color statusText;
    IconData statusIcon;
    String statusLabel;

    if (isApproved) {
      statusBg = PharmaColors.purpleBg;
      statusText = PharmaColors.purpleText;
      statusIcon = Icons.check_circle;
      statusLabel = 'Approved';
    } else if (isPending) {
      statusBg = PharmaColors.warningBg;
      statusText = PharmaColors.warningText;
      statusIcon = Icons.hourglass_top;
      statusLabel = 'Pending Review';
    } else {
      statusBg = PharmaColors.dangerBg;
      statusText = PharmaColors.dangerText;
      statusIcon = Icons.cancel;
      statusLabel = 'Rejected';
    }

    final approvedByStr = w.approvedBy != null
        ? '${w.approvedBy!.firstName ?? ''} ${w.approvedBy!.lastName ?? ''}'.trim()
        : null;
    final approvedAtStr = w.approvedAt != null ? DateFormat('yyyy-MM-dd').format(w.approvedAt!) : null;
    final expiresAtStr = w.expiresAt != null ? DateFormat('yyyy-MM-dd').format(w.expiresAt!) : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Status Header ──
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: statusText.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(statusIcon, size: 40, color: statusText),
                    const SizedBox(height: 10),
                    Text(
                      'Training Waiver — $statusLabel',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: statusText,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      courseTitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: statusText.withValues(alpha: 0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ── Waiver Details ──
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waiver Details',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Divider(height: 24),
                      _detailRow('Waiver ID', 'WVR-${w.id}'),
                      _detailRow('Course', courseTitle),
                      _detailRow(
                          'Status',
                          statusLabel,
                          valueColor: statusText),
                      if (approvedByStr != null && approvedByStr.isNotEmpty)
                        _detailRow('Approved By', approvedByStr),
                      if (approvedAtStr != null)
                        _detailRow('Approved Date', approvedAtStr),
                      if (expiresAtStr != null)
                        _detailRow('Expires', expiresAtStr),
                      if (w.rejectionReason != null && w.rejectionReason!.isNotEmpty)
                        _detailRow('Rejection Reason', w.rejectionReason!, valueColor: PharmaColors.danger),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ── Justification ──
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.description_outlined,
                              size: 18, color: PharmaColors.purple),
                          const SizedBox(width: 8),
                          Text(
                            'Justification',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: PharmaColors.pageBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          w.requestReason,
                          style: TextStyle(
                            fontSize: 13,
                            color: PharmaColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ── Compliance Notice ──
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PharmaColors.infoBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: PharmaColors.info.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user,
                        size: 16, color: PharmaColors.infoText),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Training waivers are tracked per ICH Q10 and require '
                        'QA approval with CAPA documentation.',
                        style: TextStyle(
                          fontSize: 11,
                          color: PharmaColors.infoText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // ── ALCOA+ Footer ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PharmaColors.pageBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: PharmaColors.borderLight),
                ),
                child: Column(
                  children: [
                    Text(
                      'Attributable · Legible · Contemporaneous · Original · Accurate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: PharmaColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Training waivers are electronically approved per '
                      '21 CFR Part 11 and GMP Annex 11',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: PharmaColors.textQuaternary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: PharmaColors.textTertiary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: valueColor ?? PharmaColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
