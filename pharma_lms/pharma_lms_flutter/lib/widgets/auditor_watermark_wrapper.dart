import 'dart:async';

import 'package:flutter/material.dart';

import '../core/client.dart';
import 'auditor_diagonal_watermark.dart';

/// Wraps a child with "AUDIT COPY" watermark and logs page view when token is valid.
class AuditorWatermarkWrapper extends StatefulWidget {
  const AuditorWatermarkWrapper({
    super.key,
    required this.child,
    this.auditorToken,
    required this.pageUrl,
    required this.pageTitle,
  });

  final Widget child;
  final String? auditorToken;
  final String pageUrl;
  final String pageTitle;

  @override
  State<AuditorWatermarkWrapper> createState() => _AuditorWatermarkWrapperState();
}

class _AuditorWatermarkWrapperState extends State<AuditorWatermarkWrapper> {
  int? _inspectionRecordId;
  String? _inspectorNames;

  @override
  void initState() {
    super.initState();
    if (widget.auditorToken != null && widget.auditorToken!.isNotEmpty) {
      _validateAndLog();
    }
  }

  Future<void> _validateAndLog() async {
    try {
      final result = await client.inspection.validateAuditorToken(
        token: widget.auditorToken!,
      );
      if (result != null && mounted) {
        final id = result['inspectionRecordId'] as int?;
        if (id != null) {
          setState(() {
            _inspectionRecordId = id;
            _inspectorNames = result['inspectorNames'] as String?;
          });
          unawaited(client.inspection.logAuditorPageView(
            inspectionRecordId: id,
            pageUrl: widget.pageUrl,
            pageTitle: widget.pageTitle,
          ));
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final showWatermark = _inspectionRecordId != null;

    if (!showWatermark) {
      return widget.child;
    }

    // Plan 6C: diagonal repeating "AUDIT COPY" across entire background
    return Stack(
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: LayoutBuilder(
              builder: (_, constraints) {
                return CustomPaint(
                  painter: AuditorDiagonalWatermarkPainter(
                    text: 'AUDIT COPY',
                    angle: -0.35,
                    spacing: 180,
                    fontSize: 14,
                    color: Colors.grey.withValues(alpha: 0.12),
                  ),
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                );
              },
            ),
          ),
        ),
        widget.child,
        // Keep a small bottom bar with context
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.black.withValues(alpha: 0.04),
              child: Center(
                child: Text(
                  '${_inspectorNames ?? 'Auditor'} — ${DateTime.now().toIso8601String().split('T').first}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
