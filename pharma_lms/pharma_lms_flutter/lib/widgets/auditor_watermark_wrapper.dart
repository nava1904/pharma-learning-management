import 'dart:async';

import 'package:flutter/material.dart';

import '../core/client.dart';

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
          setState(() => _inspectionRecordId = id);
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

    return Stack(
      children: [
        widget.child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.black.withValues(alpha: 0.05),
              child: Center(
                child: Text(
                  'AUDIT COPY',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    letterSpacing: 4,
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
