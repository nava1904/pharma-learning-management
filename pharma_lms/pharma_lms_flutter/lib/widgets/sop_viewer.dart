import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/webview_safe.dart';
import '../design_system/colors.dart';
import '../design_system/spacing.dart';

/// SOP document viewer with PDF display, version info, and acknowledge action.
class SOPViewer extends StatefulWidget {
  const SOPViewer({
    super.key,
    required this.title,
    this.version,
    this.pdfUrl,
    this.onAcknowledge,
    this.acknowledgedAt,
    this.isAcknowledging = false,
  });

  final String title;
  final String? version;
  final String? pdfUrl;
  final VoidCallback? onAcknowledge;
  final DateTime? acknowledgedAt;
  final bool isAcknowledging;

  @override
  State<SOPViewer> createState() => _SOPViewerState();
}

class _SOPViewerState extends State<SOPViewer> {
  WebViewController? _controller;

  @override
  void didUpdateWidget(covariant SOPViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pdfUrl != oldWidget.pdfUrl && widget.pdfUrl != null) {
      _controller = webViewControllerWithDefaults()
        ..loadRequest(Uri.parse(widget.pdfUrl!));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.pdfUrl != null && widget.pdfUrl!.isNotEmpty) {
      _controller = webViewControllerWithDefaults()
        ..loadRequest(Uri.parse(widget.pdfUrl!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header with version
        Container(
          padding: const EdgeInsets.all(DesignSpacing.md),
          decoration: BoxDecoration(
            color: DesignColors.neutral50,
            border: Border(
              bottom: BorderSide(color: DesignColors.neutral200),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (widget.version != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Version: ${widget.version}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: DesignColors.neutral600,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.acknowledgedAt != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSpacing.sm,
                    vertical: DesignSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: DesignColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: DesignColors.success),
                      const SizedBox(width: 4),
                      Text(
                        'Acknowledged',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: DesignColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                )
              else if (widget.onAcknowledge != null)
                FilledButton.icon(
                  onPressed: widget.isAcknowledging ? null : widget.onAcknowledge,
                  icon: widget.isAcknowledging
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.draw, size: 18),
                  label: Text(widget.isAcknowledging ? 'Signing...' : 'Acknowledge'),
                ),
            ],
          ),
        ),
        // PDF content area
        Expanded(
          child: _controller != null
              ? WebViewWidget(controller: _controller!)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.picture_as_pdf_outlined,
                        size: 64,
                        color: DesignColors.neutral400,
                      ),
                      const SizedBox(height: DesignSpacing.md),
                      Text(
                        'No document available',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: DesignColors.neutral500,
                            ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
