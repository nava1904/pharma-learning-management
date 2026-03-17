import 'package:flutter/material.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../esignature/esignature_screen.dart';

/// SCR-18 — SOP Retraining Acknowledgement Modal.
/// Triggered when a course version is superseded and employee must re-certify.
///
/// Returns `true` if the user acknowledged and e-signed, `null`/`false` on dismiss.
Future<bool?> showSopRetrainingModal(
  BuildContext context, {
  required String courseTitle,
  required String previousVersion,
  required String newVersion,
  required int courseVersionId,
  required int userId,
  List<String> changes = const [],
}) {
  return showGeneralDialog<bool?>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) =>
        _SopRetrainingModal(
      courseTitle: courseTitle,
      previousVersion: previousVersion,
      newVersion: newVersion,
      courseVersionId: courseVersionId,
      userId: userId,
      changes: changes,
    ),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        ),
      );
    },
  );
}

class _SopRetrainingModal extends StatefulWidget {
  const _SopRetrainingModal({
    required this.courseTitle,
    required this.previousVersion,
    required this.newVersion,
    required this.courseVersionId,
    required this.userId,
    required this.changes,
  });

  final String courseTitle;
  final String previousVersion;
  final String newVersion;
  final int courseVersionId;
  final int userId;
  final List<String> changes;

  @override
  State<_SopRetrainingModal> createState() => _SopRetrainingModalState();
}

class _SopRetrainingModalState extends State<_SopRetrainingModal> {
  bool _acknowledged = false;
  bool _submitting = false;

  Future<void> _acknowledge() async {
    setState(() => _submitting = true);

    // E-signature required for SOP acknowledgement (21 CFR Part 11)
    final esigId = await showEsignatureModal(
      context,
      entityType: 'sop_retraining',
      entityId: '${widget.courseVersionId}',
      signatureMeaning: 'I acknowledge the SOP change and will complete retraining',
      userId: widget.userId,
    );

    if (!mounted) return;

    if (esigId != null) {
      // Enroll in new version
      try {
        await client.training.selfEnroll(
          userId: widget.userId,
          courseVersionId: widget.courseVersionId,
        );
      } catch (_) {
        // May already be enrolled
      }
      if (mounted) Navigator.of(context).pop(true);
    } else {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: PharmaColors.orangeBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.sync_problem,
                        color: PharmaColors.orange, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOP Retraining Required',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: PharmaColors.orangeText,
                              ),
                        ),
                        Text(
                          widget.courseTitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: PharmaColors.textTertiary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // ── Version Change Info ──
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: PharmaColors.orangeBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: PharmaColors.orange.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline,
                            size: 16, color: PharmaColors.orangeText),
                        const SizedBox(width: 8),
                        Text(
                          'Version Change',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: PharmaColors.orangeText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: PharmaColors.dangerBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'v${widget.previousVersion}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: PharmaColors.dangerText,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.arrow_forward,
                              size: 16, color: PharmaColors.textTertiary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: PharmaColors.successBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'v${widget.newVersion}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: PharmaColors.successText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ── Changes List ──
              if (widget.changes.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Key Changes',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: PharmaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                ...widget.changes.map((change) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(Icons.circle,
                                size: 6, color: PharmaColors.orangeText),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              change,
                              style: TextStyle(
                                fontSize: 13,
                                color: PharmaColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              const SizedBox(height: 16),
              // ── Acknowledgement Checkbox ──
              InkWell(
                onTap: () => setState(() => _acknowledged = !_acknowledged),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _acknowledged
                        ? PharmaColors.emerald50
                        : PharmaColors.pageBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _acknowledged
                          ? PharmaColors.emerald500
                          : PharmaColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _acknowledged
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 20,
                        color: _acknowledged
                            ? PharmaColors.emerald600
                            : PharmaColors.textTertiary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'I acknowledge that this SOP has changed and I will '
                          'complete the updated training within the required '
                          'compliance deadline.',
                          style: TextStyle(
                            fontSize: 12,
                            color: PharmaColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ── Actions ──
              Row(
                children: [
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => Navigator.of(context).pop(false),
                    child: const Text('Dismiss'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed:
                          (!_acknowledged || _submitting) ? null : _acknowledge,
                      icon: _submitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.draw_outlined, size: 18),
                      label: const Text('Acknowledge & Sign'),
                      style: FilledButton.styleFrom(
                        backgroundColor: PharmaColors.orange,
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // ── Compliance Notice ──
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PharmaColors.infoBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user,
                        size: 14, color: PharmaColors.infoText),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '21 CFR Part 11 · GMP Annex 11 · E-signature required',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: PharmaColors.infoText,
                        ),
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
}
