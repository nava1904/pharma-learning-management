// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — DESIGN SYSTEM COMPONENTS V2
// ═══════════════════════════════════════════════════════════════════════════════
//
// Shared UI components matching the React reference design system.
// Built on top of pharma_design_system.dart tokens.
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'pharma_design_system.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA CARD
// Standard card component with border and subtle shadow
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaCard extends StatelessWidget {
  const PharmaCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.showHoverEffect = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool showHoverEffect;

  @override
  Widget build(BuildContext context) {
    return _HoverableCard(
      onTap: onTap,
      showHoverEffect: showHoverEffect,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(PharmaSpacing.cardPadding),
        child: child,
      ),
    );
  }
}

class _HoverableCard extends StatefulWidget {
  const _HoverableCard({
    required this.child,
    this.onTap,
    this.showHoverEffect = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool showHoverEffect;

  @override
  State<_HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<_HoverableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.showHoverEffect ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.showHoverEffect ? (_) => setState(() => _isHovered = false) : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
            boxShadow: _isHovered && widget.showHoverEffect
                ? PharmaShadows.cardHoverShadow
                : PharmaShadows.cardShadow,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA BUTTON
// Primary and secondary button variants
// ═══════════════════════════════════════════════════════════════════════════════

enum PharmaButtonVariant { primary, secondary, outline, danger }

class PharmaButton extends StatefulWidget {
  const PharmaButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = PharmaButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final PharmaButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  @override
  State<PharmaButton> createState() => _PharmaButtonState();
}

class _PharmaButtonState extends State<PharmaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, borderColor) = _getColors();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(
            horizontal: PharmaSpacing.lg,
            vertical: PharmaSpacing.md,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? bgColor.withValues(alpha: 0.9) : bgColor,
            borderRadius: PharmaRadius.buttonRadius,
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading) ...[
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                ),
                const SizedBox(width: 8),
              ] else if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: textColor),
                const SizedBox(width: 8),
              ],
              DefaultTextStyle(
                style: PharmaTypography.button.copyWith(color: textColor),
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  (Color, Color, Color) _getColors() {
    switch (widget.variant) {
      case PharmaButtonVariant.primary:
        return (PharmaColors.emerald600, Colors.white, PharmaColors.emerald600);
      case PharmaButtonVariant.secondary:
        return (PharmaColors.gray100, PharmaColors.textPrimary, PharmaColors.borderMedium);
      case PharmaButtonVariant.outline:
        return (Colors.transparent, PharmaColors.textPrimary, PharmaColors.borderMedium);
      case PharmaButtonVariant.danger:
        return (PharmaColors.danger, Colors.white, PharmaColors.danger);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA BADGE / PILL
// Status indicators matching React design
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaBadge extends StatelessWidget {
  const PharmaBadge({
    super.key,
    required this.label,
    this.status,
    this.backgroundColor,
    this.textColor,
  });

  final String label;
  final PharmaStatus? status;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? status?.backgroundColor ?? PharmaColors.gray100;
    final txtColor = textColor ?? status?.textColor ?? PharmaColors.gray700;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PharmaSpacing.md,
        vertical: PharmaSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        status?.label ?? label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: txtColor,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA INPUT
// Text field matching React design
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaInput extends StatefulWidget {
  const PharmaInput({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  State<PharmaInput> createState() => _PharmaInputState();
}

class _PharmaInputState extends State<PharmaInput> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.pageBg,
        borderRadius: PharmaRadius.inputRadius,
        border: Border.all(
          color: _isFocused ? PharmaColors.borderFocus : PharmaColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          if (widget.prefixIcon != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: PharmaSpacing.md),
              child: Icon(
                widget.prefixIcon,
                size: 20,
                color: PharmaColors.textQuaternary,
              ),
            ),
          ],
          Expanded(
            child: Focus(
              onFocusChange: (focused) => setState(() => _isFocused = focused),
              child: TextField(
                controller: widget.controller,
                autofocus: widget.autofocus,
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: PharmaTypography.body.copyWith(
                    color: PharmaColors.textQuaternary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: PharmaSpacing.md,
                    vertical: PharmaSpacing.md,
                  ),
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA PROGRESS BAR
// Linear progress indicator matching React design
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaProgressBar extends StatelessWidget {
  const PharmaProgressBar({
    super.key,
    required this.value,
    this.height = 6,
    this.backgroundColor,
    this.valueColor,
    this.showLabel = false,
  });

  final double value;
  final double height;
  final Color? backgroundColor;
  final Color? valueColor;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 100.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textSecondary,
                ),
              ),
              Text(
                '${clampedValue.toInt()}%',
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.emerald600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: PharmaRadius.pillRadius,
          child: LinearProgressIndicator(
            value: clampedValue / 100,
            backgroundColor: backgroundColor ?? PharmaColors.gray200,
            valueColor: AlwaysStoppedAnimation<Color>(
              valueColor ?? PharmaColors.emerald600,
            ),
            minHeight: height,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA SKELETON LOADER
// Shimmer effect for loading states
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaSkeletonLoader extends StatefulWidget {
  const PharmaSkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final double? borderRadius;

  @override
  State<PharmaSkeletonLoader> createState() => _PharmaSkeletonLoaderState();
}

class _PharmaSkeletonLoaderState extends State<PharmaSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
            gradient: LinearGradient(
              colors: [
                PharmaColors.gray100,
                PharmaColors.gray200,
                PharmaColors.gray100,
              ],
              stops: [
                0.0,
                _controller.value,
                1.0,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA EMPTY STATE
// Placeholder for empty lists/grids
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaEmptyState extends StatelessWidget {
  const PharmaEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: PharmaColors.textTertiary,
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Text(
              title,
              style: PharmaTypography.headingSmall,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: PharmaSpacing.xxl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA WORKFLOW STEPPER
// Horizontal stepper showing workflow states (Draft -> Under Review -> Approved)
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaWorkflowStepper extends StatelessWidget {
  final String currentStatus;
  final List<String> steps;

  const PharmaWorkflowStepper({
    super.key,
    required this.currentStatus,
    this.steps = const ['draft', 'pending_approval', 'effective'],
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = steps.indexOf(currentStatus);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          if (i > 0)
            Icon(Icons.chevron_right, size: 16, color: PharmaColors.gray400),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: i < currentIndex
                  ? PharmaColors.gray100
                  : i == currentIndex
                      ? _statusColor(steps[i])
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(PharmaRadius.full),
              border: i > currentIndex
                  ? Border.all(color: PharmaColors.borderLight)
                  : null,
            ),
            child: Text(
              _stepLabel(steps[i]),
              style: PharmaTypography.caption.copyWith(
                color: i < currentIndex
                    ? PharmaColors.gray500
                    : i == currentIndex
                        ? Colors.white
                        : PharmaColors.gray400,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'draft': return PharmaColors.gray500;
      case 'pending_approval': return PharmaColors.info;
      case 'under_review': return PharmaColors.info;
      case 'needs_revision': return PharmaColors.warning;
      case 'effective': return PharmaColors.emerald600;
      case 'approved': return PharmaColors.emerald600;
      case 'rejected': return PharmaColors.danger;
      case 'obsolete': return PharmaColors.gray400;
      default: return PharmaColors.gray500;
    }
  }

  String _stepLabel(String status) {
    switch (status) {
      case 'draft': return 'Draft';
      case 'pending_approval': return 'Under Review';
      case 'needs_revision': return 'Needs Revision';
      case 'effective': return 'Approved';
      case 'approved': return 'Approved';
      case 'rejected': return 'Rejected';
      case 'obsolete': return 'Obsolete';
      default: return status;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA COMPLIANCE BANNER
// Regulation tag banner with effective date and version hash
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaComplianceBanner extends StatelessWidget {
  final String regulationTag;
  final String? effectiveDate;
  final String? versionHash;

  const PharmaComplianceBanner({
    super.key,
    required this.regulationTag,
    this.effectiveDate,
    this.versionHash,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.infoBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user, size: 16, color: PharmaColors.info),
          const SizedBox(width: PharmaSpacing.sm),
          Text(regulationTag, style: PharmaTypography.caption.copyWith(
            color: PharmaColors.infoText, fontWeight: FontWeight.w600)),
          if (effectiveDate != null) ...[
            const SizedBox(width: PharmaSpacing.lg),
            Text('Effective: $effectiveDate', style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textSecondary)),
          ],
          const Spacer(),
          if (versionHash != null)
            PharmaHashDisplay(hash: versionHash!, compact: true),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA HASH DISPLAY
// Truncated hash with copy-to-clipboard support
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaHashDisplay extends StatelessWidget {
  final String hash;
  final bool compact;
  final VoidCallback? onCopy;

  const PharmaHashDisplay({
    super.key,
    required this.hash,
    this.compact = false,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final displayHash = compact && hash.length > 16
        ? '${hash.substring(0, 8)}...${hash.substring(hash.length - 8)}'
        : hash;

    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hash));
        if (onCopy != null) {
          onCopy!();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Hash copied to clipboard')),
          );
        }
      },
      borderRadius: BorderRadius.circular(PharmaRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: PharmaColors.gray100,
          borderRadius: BorderRadius.circular(PharmaRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayHash,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: PharmaColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.copy, size: 12, color: PharmaColors.gray400),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA AUTOSAVE INDICATOR
// Shows saving state or time since last save
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaAutosaveIndicator extends StatelessWidget {
  final bool isSaving;
  final DateTime? lastSaved;

  const PharmaAutosaveIndicator({
    super.key,
    this.isSaving = false,
    this.lastSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSaving) ...[
          SizedBox(width: 12, height: 12, child: CircularProgressIndicator(
            strokeWidth: 2, color: PharmaColors.emerald600)),
          const SizedBox(width: 6),
          Text('Saving...', style: PharmaTypography.caption.copyWith(
            color: PharmaColors.emerald600)),
        ] else if (lastSaved != null) ...[
          Icon(Icons.check_circle, size: 14, color: PharmaColors.emerald600),
          const SizedBox(width: 4),
          Text(_formatTimeSince(lastSaved!), style: PharmaTypography.caption.copyWith(
            color: PharmaColors.emerald600)),
        ],
      ],
    );
  }

  String _formatTimeSince(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inSeconds < 5) return 'Just saved';
    if (diff.inSeconds < 60) return 'Saved ${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return 'Saved ${diff.inMinutes}m ago';
    return 'Saved ${diff.inHours}h ago';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA VALIDATION CHECKLIST
// Displays pass/fail validation results
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaValidationChecklist extends StatelessWidget {
  final List<QaValidationRuleResult> results;

  const PharmaValidationChecklist({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: results.map((r) {
        final passed = r.passed;
        return Padding(
          padding: const EdgeInsets.only(bottom: PharmaSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 18,
                color: passed ? PharmaColors.emerald600 : PharmaColors.danger,
              ),
              const SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.rule, style: PharmaTypography.bodyMedium),
                    Text(r.detail, style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA NOTIFICATION CARD
// Notification item with type-based icon and read state
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaNotificationCard extends StatelessWidget {
  final String type;
  final String title;
  final String message;
  final String? timestamp;
  final bool isRead;
  final VoidCallback? onTap;

  const PharmaNotificationCard({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.timestamp,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(PharmaSpacing.md),
        decoration: BoxDecoration(
          color: isRead ? PharmaColors.cardBg : PharmaColors.infoBg,
          border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _iconBgColor,
                borderRadius: BorderRadius.circular(PharmaRadius.lg),
              ),
              child: Icon(_icon, size: 16, color: _iconColor),
            ),
            const SizedBox(width: PharmaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: PharmaTypography.bodyMedium.copyWith(
                    fontWeight: isRead ? FontWeight.w400 : FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(message, style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textSecondary)),
                  if (timestamp != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(timestamp!, style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.textTertiary, fontSize: 11)),
                    ),
                ],
              ),
            ),
            if (!isRead)
              Container(
                width: 8, height: 8,
                decoration: BoxDecoration(
                  color: PharmaColors.emerald600,
                  borderRadius: BorderRadius.circular(PharmaRadius.full),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    switch (type) {
      case 'qa_approved': return Icons.check_circle;
      case 'qa_returned': return Icons.replay;
      case 'qa_rejected': return Icons.cancel;
      case 'assignment': return Icons.assignment;
      case 'overdue': return Icons.warning;
      case 'sop_update': return Icons.description;
      default: return Icons.notifications;
    }
  }

  Color get _iconColor {
    switch (type) {
      case 'qa_approved': return PharmaColors.emerald600;
      case 'qa_returned': return PharmaColors.warning;
      case 'qa_rejected': return PharmaColors.danger;
      case 'overdue': return PharmaColors.danger;
      default: return PharmaColors.info;
    }
  }

  Color get _iconBgColor {
    switch (type) {
      case 'qa_approved': return PharmaColors.successBg;
      case 'qa_returned': return PharmaColors.warningBg;
      case 'qa_rejected': return PharmaColors.dangerBg;
      case 'overdue': return PharmaColors.dangerBg;
      default: return PharmaColors.infoBg;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA STATUS TIMELINE
// Vertical timeline for audit/status events
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaStatusTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const PharmaStatusTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < events.length; i++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                child: Column(
                  children: [
                    Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                        color: i == 0 ? PharmaColors.emerald600 : PharmaColors.gray300,
                        borderRadius: BorderRadius.circular(PharmaRadius.full),
                      ),
                    ),
                    if (i < events.length - 1)
                      Container(width: 2, height: 40, color: PharmaColors.borderLight),
                  ],
                ),
              ),
              const SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(events[i]['title'] as String? ?? '',
                          style: PharmaTypography.bodyMedium),
                      if (events[i]['subtitle'] != null)
                        Text(events[i]['subtitle'] as String,
                            style: PharmaTypography.caption.copyWith(
                              color: PharmaColors.textSecondary)),
                      if (events[i]['timestamp'] != null)
                        Text(events[i]['timestamp'] as String,
                            style: PharmaTypography.caption.copyWith(
                              color: PharmaColors.textTertiary, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA SEARCH BAR
// Reusable search field with clear button
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hint;

  const PharmaSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hint = 'Search courses, questions, SOPs...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: PharmaTypography.body,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
          prefixIcon: Icon(Icons.search, size: 18, color: PharmaColors.gray400),
          suffixIcon: controller != null && (controller!.text.isNotEmpty)
              ? IconButton(
                  icon: Icon(Icons.close, size: 16, color: PharmaColors.gray400),
                  onPressed: () { controller!.clear(); onClear?.call(); },
                )
              : null,
          filled: true,
          fillColor: PharmaColors.gray50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
            borderSide: BorderSide(color: PharmaColors.borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
            borderSide: BorderSide(color: PharmaColors.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
            borderSide: BorderSide(color: PharmaColors.emerald600),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          isDense: true,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA EXPORT BUTTON
// Dropdown button for CSV export and print actions
// ═══════════════════════════════════════════════════════════════════════════════

class PharmaExportButton extends StatelessWidget {
  final VoidCallback? onExportCsv;
  final VoidCallback? onPrint;
  final bool isLoading;

  const PharmaExportButton({
    super.key,
    this.onExportCsv,
    this.onPrint,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'csv') onExportCsv?.call();
        if (value == 'print') onPrint?.call();
      },
      itemBuilder: (context) => [
        if (onExportCsv != null)
          const PopupMenuItem(value: 'csv', child: Row(
            children: [
              Icon(Icons.download, size: 16),
              SizedBox(width: 8),
              Text('Export CSV'),
            ],
          )),
        if (onPrint != null)
          const PopupMenuItem(value: 'print', child: Row(
            children: [
              Icon(Icons.print, size: 16),
              SizedBox(width: 8),
              Text('Print'),
            ],
          )),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.lg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
            else
              Icon(Icons.download, size: 16, color: PharmaColors.textSecondary),
            const SizedBox(width: 6),
            Text('Export', style: PharmaTypography.button.copyWith(
              color: PharmaColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
