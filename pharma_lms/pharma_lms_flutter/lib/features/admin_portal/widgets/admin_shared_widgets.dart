import 'package:flutter/material.dart';
import '../../../design_system/pharma_components.dart';
import '../../../design_system/pharma_design_system.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// STITCH "CLINICAL ARCHIVE" — ADMIN SHARED WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════
// Tonal Architecture: no borders, surface layering, ghost borders
// All labels: 10px bold uppercase tracking-widest
// ═══════════════════════════════════════════════════════════════════════════════

// ─── CRITICAL BANNER ─────────────────────────────────────────────────────────
/// Red banner for overdue/non-compliance alerts (DC2626)
class ClinicalCriticalBanner extends StatelessWidget {
  const ClinicalCriticalBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.onAction,
    this.icon = Icons.warning_rounded,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: PharmaColors.clinicalCriticalBanner,
        boxShadow: [
          BoxShadow(
            color: Color(0x33DC2626),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Material(
            color: Colors.white,
            borderRadius: PharmaRadius.clinicalButtonRadius,
            child: InkWell(
              onTap: onAction,
              borderRadius: PharmaRadius.clinicalButtonRadius,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  actionLabel.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: PharmaColors.clinicalCriticalBanner,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── TONAL CARD (NO BORDER) ─────────────────────────────────────────────────
/// Surface-container-lowest card with atmospheric shadow (no borders)
class ClinicalTonalCard extends StatelessWidget {
  const ClinicalTonalCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderBottom,
    this.borderLeft,
    this.backgroundColor,
    this.shadow = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? borderBottom;
  final Color? borderLeft;
  final Color? backgroundColor;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? PharmaColors.clinicalSurfaceContainerLowest,
        borderRadius: PharmaRadius.clinicalCardRadius,
        boxShadow: shadow ? PharmaShadows.atmosphericLight : null,
        border: Border(
          bottom: borderBottom != null
              ? BorderSide(color: borderBottom!, width: 2)
              : BorderSide.none,
          left: borderLeft != null
              ? BorderSide(color: borderLeft!, width: 4)
              : BorderSide.none,
        ),
      ),
      child: child,
    );
  }
}

// ─── KPI CARD (STITCH STYLE) ────────────────────────────────────────────────
/// KPI card with bottom accent border, label, icon, large value, progress bar
class ClinicalKpiCard extends StatelessWidget {
  const ClinicalKpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.subtitle,
    this.progress,
    this.progressColor,
    this.valueColor,
    this.changeLabel,
    this.changeColor,
    this.flex = 1,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? subtitle;
  final double? progress;
  final Color? progressColor;
  final Color? valueColor;
  final String? changeLabel;
  final Color? changeColor;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return ClinicalTonalCard(
      borderBottom: PharmaColors.clinicalPrimaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: PharmaTypography.clinicalLabel,
              ),
              Icon(icon, size: 22, color: valueColor ?? PharmaColors.clinicalOnSurfaceVariant),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: PharmaTypography.clinicalKpiValue.copyWith(
                  color: valueColor ?? PharmaColors.clinicalOnSurface,
                ),
              ),
              if (changeLabel != null) ...[
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    changeLabel!,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: changeColor ?? PharmaColors.clinicalOnSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 12),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: PharmaColors.clinicalSurfaceContainer,
                borderRadius: BorderRadius.circular(1),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress!.clamp(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: progressColor ?? PharmaColors.clinicalSecondary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: PharmaColors.clinicalOnSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── SYSTEM HEALTH CELL ─────────────────────────────────────────────────────
/// Small health indicator (SCIM Sync, Kafka Lag, DB Status)
class ClinicalHealthCell extends StatelessWidget {
  const ClinicalHealthCell({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.statusColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    final color = statusColor ?? PharmaColors.clinicalSecondary;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PharmaColors.clinicalSurfaceContainerLow,
        borderRadius: PharmaRadius.clinicalCardRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: PharmaColors.clinicalOnSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── COMPLIANCE LABEL ────────────────────────────────────────────────────────
/// 10px bold uppercase tracking-widest label on clinical surfaces
class ClinicalComplianceLabel extends StatelessWidget {
  const ClinicalComplianceLabel({
    super.key,
    required this.text,
    this.color,
    this.icon,
  });

  final String text;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 12, color: color ?? PharmaColors.clinicalOnSurfaceVariant),
          const SizedBox(width: 4),
        ],
        Text(
          text.toUpperCase(),
          style: PharmaTypography.clinicalLabel.copyWith(
            color: color ?? PharmaColors.clinicalOnSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ─── HMAC BADGE ──────────────────────────────────────────────────────────────
/// Small monospace HMAC verification badge
class ClinicalHmacBadge extends StatelessWidget {
  const ClinicalHmacBadge({
    super.key,
    required this.status,
    this.hash,
    this.compact = false,
  });

  final String status; // 'PASS', 'FAIL', 'PENDING'
  final String? hash;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final isPassing = status.toUpperCase() == 'PASS';
    final color = isPassing ? PharmaColors.clinicalSecondary : PharmaColors.clinicalTertiary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPassing ? Icons.verified : Icons.error_outline,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          status.toUpperCase(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        if (hash != null && !compact) ...[
          const SizedBox(width: 8),
          Text(
            hash!,
            style: PharmaTypography.clinicalMono,
          ),
        ],
      ],
    );
  }
}

// ─── CLINICAL SECTION HEADER ─────────────────────────────────────────────────
/// Headline with optional badge/action
class ClinicalSectionHeader extends StatelessWidget {
  const ClinicalSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.badge,
    this.badgeColor,
  });

  final String title;
  final Widget? trailing;
  final String? badge;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: PharmaColors.clinicalOnSurface,
              letterSpacing: -0.3,
            ),
          ),
        ),
        if (badge != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (badgeColor ?? PharmaColors.clinicalTertiary).withValues(alpha: 0.1),
              borderRadius: PharmaRadius.clinicalCardRadius,
            ),
            child: Text(
              badge!.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: badgeColor ?? PharmaColors.clinicalTertiary,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
        ?trailing,
      ],
    );
  }
}

// ─── CLINICAL DATA TABLE ─────────────────────────────────────────────────────
/// High-density table: no lines, row spacing, hover bg shifts
class ClinicalDataTable extends StatelessWidget {
  const ClinicalDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.columnAlignments,
  });

  final List<String> columns;
  final List<List<Widget>> rows;
  final void Function(int index)? onRowTap;
  final List<TextAlign>? columnAlignments;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth = constraints.maxWidth;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth < 400 ? 600 : tableWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: List.generate(columns.length, (i) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            columns[i].toUpperCase(),
                            textAlign: columnAlignments != null && i < columnAlignments!.length
                                ? columnAlignments![i]
                                : TextAlign.left,
                            style: PharmaTypography.clinicalTableHeader,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // Ghost border separator
                Container(
                  height: 1,
                  color: PharmaColors.clinicalOutlineVariant.withValues(alpha: 0.15),
                ),
                // Data rows with spacing
                ...List.generate(rows.length, (rowIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Material(
                      color: PharmaColors.clinicalSurface,
                      borderRadius: PharmaRadius.clinicalCardRadius,
                      child: InkWell(
                        onTap: onRowTap != null ? () => onRowTap!(rowIndex) : null,
                        hoverColor: PharmaColors.clinicalSurfaceContainerLow,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: List.generate(columns.length, (colIndex) {
                              if (colIndex < rows[rowIndex].length) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: rows[rowIndex][colIndex],
                                  ),
                                );
                              }
                              return const Expanded(child: SizedBox.shrink());
                            }),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── AUDIT TIMELINE ──────────────────────────────────────────────────────────
/// Timeline with vertical line and colored dots
class ClinicalAuditTimeline extends StatelessWidget {
  const ClinicalAuditTimeline({super.key, required this.events});

  final List<ClinicalTimelineEvent> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(events.length, (i) {
        final event = events[i];
        final isLast = i == events.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline dot + line
              SizedBox(
                width: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: event.dotColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PharmaColors.clinicalSurfaceContainerLowest,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: event.dotColor.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(event.icon, size: 11, color: Colors.white),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          color: PharmaColors.clinicalOutlineVariant.withValues(alpha: 0.3),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: PharmaColors.clinicalOnSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        event.subtitle,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          color: PharmaColors.clinicalOnSurfaceVariant,
                        ),
                      ),
                      if (event.timestamp != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          event.timestamp!,
                          style: PharmaTypography.clinicalMono,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ClinicalTimelineEvent {
  final String title;
  final String subtitle;
  final String? timestamp;
  final IconData icon;
  final Color dotColor;

  const ClinicalTimelineEvent({
    required this.title,
    required this.subtitle,
    this.timestamp,
    required this.icon,
    required this.dotColor,
  });
}

// ─── E-SIGNATURE READINESS WIDGET ────────────────────────────────────────────
class ClinicalESignatureWidget extends StatelessWidget {
  const ClinicalESignatureWidget({
    super.key,
    required this.pendingCount,
    this.hmacStatus = 'SHA-256 Validation Active',
    this.onProcess,
  });

  final int pendingCount;
  final String hmacStatus;
  final VoidCallback? onProcess;

  @override
  Widget build(BuildContext context) {
    return ClinicalTonalCard(
      borderLeft: PharmaColors.clinicalSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-SIGNATURE READINESS',
            style: PharmaTypography.clinicalLabel,
          ),
          const SizedBox(height: 16),
          // HMAC status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PharmaColors.clinicalSecondaryContainer.withValues(alpha: 0.1),
              border: Border.all(
                color: PharmaColors.clinicalSecondaryContainer.withValues(alpha: 0.2),
              ),
              borderRadius: PharmaRadius.clinicalCardRadius,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HMAC-bound signature active',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: PharmaColors.clinicalOnSecondaryContainer,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        hmacStatus,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: PharmaColors.clinicalOnSecondaryContainer.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.lock_open_rounded, color: PharmaColors.clinicalSecondary, size: 22),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Pending count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PharmaColors.clinicalSurfaceContainerLow,
              borderRadius: PharmaRadius.clinicalCardRadius,
            ),
            child: Column(
              children: [
                Text(
                  pendingCount.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: PharmaColors.clinicalOnSurface,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PENDING ADMIN SIGN-OFFS',
                  style: PharmaTypography.clinicalLabel,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // CTA button with gradient
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [PharmaColors.clinicalSecondary, PharmaColors.clinicalSecondaryDim],
                ),
                borderRadius: PharmaRadius.clinicalButtonRadius,
                boxShadow: [
                  BoxShadow(
                    color: PharmaColors.clinicalSecondary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onProcess,
                  borderRadius: PharmaRadius.clinicalButtonRadius,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'PROCESS PENDING SIGNATURES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.5,
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
  }
}

// ─── FILTER BAR (STITCH STYLE) ──────────────────────────────────────────────
/// Advanced filter grid with uppercase labels and tonal inputs
class ClinicalFilterBar extends StatelessWidget {
  const ClinicalFilterBar({
    super.key,
    required this.children,
    this.trailing,
    this.onApply,
    this.onReset,
  });

  final List<Widget> children;
  final Widget? trailing;
  final VoidCallback? onApply;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    return ClinicalTonalCard(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          ...children,
          if (onApply != null || onReset != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onApply != null)
                  SizedBox(
                    height: 36,
                    child: Material(
                      color: PharmaColors.clinicalPrimary,
                      borderRadius: PharmaRadius.clinicalButtonRadius,
                      child: InkWell(
                        onTap: onApply,
                        borderRadius: PharmaRadius.clinicalButtonRadius,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              'APPLY',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: PharmaColors.clinicalOnPrimary,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (onReset != null) ...[
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Material(
                      color: PharmaColors.clinicalSurfaceContainerLow,
                      borderRadius: PharmaRadius.clinicalButtonRadius,
                      child: InkWell(
                        onTap: onReset,
                        borderRadius: PharmaRadius.clinicalButtonRadius,
                        child: const Icon(Icons.refresh, size: 16, color: PharmaColors.clinicalOnSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Filter field with stitch-style label
class ClinicalFilterField extends StatelessWidget {
  const ClinicalFilterField({
    super.key,
    required this.label,
    required this.child,
    this.width = 160,
  });

  final String label;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              label.toUpperCase(),
              style: PharmaTypography.clinicalLabel,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ─── DEPARTMENT COMPLIANCE CARD ──────────────────────────────────────────────
/// Icon + percentage badge + description
class ClinicalDepartmentCard extends StatelessWidget {
  const ClinicalDepartmentCard({
    super.key,
    required this.name,
    required this.percentage,
    required this.icon,
    this.description,
    this.isCritical = false,
    this.onTap,
  });

  final String name;
  final double percentage;
  final IconData icon;
  final String? description;
  final bool isCritical;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badgeColor = isCritical ? PharmaColors.clinicalTertiary : PharmaColors.clinicalSecondary;
    return Material(
      color: isCritical
          ? PharmaColors.clinicalTertiary.withValues(alpha: 0.05)
          : PharmaColors.clinicalSurfaceContainerLowest,
      child: InkWell(
        onTap: onTap,
        hoverColor: PharmaColors.clinicalSurfaceContainerLow,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isCritical
                          ? PharmaColors.clinicalTertiary.withValues(alpha: 0.1)
                          : PharmaColors.clinicalSurfaceContainer,
                      borderRadius: PharmaRadius.clinicalCardRadius,
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: isCritical ? PharmaColors.clinicalTertiary : PharmaColors.clinicalPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isCritical
                          ? PharmaColors.clinicalTertiary
                          : badgeColor.withValues(alpha: 0.1),
                      borderRadius: PharmaRadius.clinicalCardRadius,
                    ),
                    child: Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: isCritical ? Colors.white : badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                name.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: PharmaColors.clinicalOnBackground,
                  letterSpacing: 1.0,
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: 4),
                Text(
                  description!,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: PharmaColors.clinicalOnSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── COMPLIANCE FLAG CARD ────────────────────────────────────────────────────
/// Critical alert with border-l-4 tertiary
class ClinicalComplianceFlag extends StatelessWidget {
  const ClinicalComplianceFlag({
    super.key,
    required this.title,
    required this.role,
    required this.description,
    required this.icon,
    this.actions = const [],
  });

  final String title;
  final String role;
  final String description;
  final IconData icon;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PharmaColors.clinicalTertiary.withValues(alpha: 0.05),
        border: const Border(
          left: BorderSide(color: PharmaColors.clinicalTertiary, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: PharmaColors.clinicalTertiary.withValues(alpha: 0.1),
              borderRadius: PharmaRadius.clinicalCardRadius,
            ),
            child: Icon(icon, color: PharmaColors.clinicalTertiary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: PharmaColors.clinicalOnBackground,
                        ),
                      ),
                    ),
                    Text(
                      role.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: PharmaColors.clinicalTertiary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: PharmaColors.clinicalOnSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                if (actions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, children: actions),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CLINICAL ACTION BUTTON ──────────────────────────────────────────────────
/// Small stitch-style button (primary, secondary, tertiary, outline)
class ClinicalActionButton extends StatelessWidget {
  const ClinicalActionButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.variant = ClinicalButtonVariant.primary,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final ClinicalButtonVariant variant;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    Border? border;
    switch (variant) {
      case ClinicalButtonVariant.primary:
        bg = PharmaColors.clinicalPrimary;
        fg = PharmaColors.clinicalOnPrimary;
        break;
      case ClinicalButtonVariant.secondary:
        bg = PharmaColors.clinicalSecondary;
        fg = Colors.white;
        break;
      case ClinicalButtonVariant.tertiary:
        bg = PharmaColors.clinicalTertiary;
        fg = Colors.white;
        break;
      case ClinicalButtonVariant.outline:
        bg = Colors.transparent;
        fg = PharmaColors.clinicalOnSurfaceVariant;
        border = Border.all(color: PharmaColors.clinicalOutlineVariant, width: 1);
        break;
      case ClinicalButtonVariant.surface:
        bg = PharmaColors.clinicalSurfaceContainerLow;
        fg = PharmaColors.clinicalOnSurface;
        break;
    }

    return Material(
      color: bg,
      borderRadius: PharmaRadius.clinicalButtonRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: PharmaRadius.clinicalButtonRadius,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 8 : 16,
            vertical: compact ? 4 : 8,
          ),
          decoration: BoxDecoration(
            border: border,
            borderRadius: PharmaRadius.clinicalButtonRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: compact ? 12 : 14, color: fg),
                SizedBox(width: compact ? 4 : 8),
              ],
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: compact ? 8 : 10,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: compact ? 0.5 : 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ClinicalButtonVariant { primary, secondary, tertiary, outline, surface }

// ─── GHOST BORDER DIVIDER ────────────────────────────────────────────────────
/// outline-variant at 15% opacity — felt, not seen
class ClinicalGhostDivider extends StatelessWidget {
  const ClinicalGhostDivider({super.key, this.vertical = false});

  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return vertical
        ? Container(
            width: 1,
            color: PharmaColors.clinicalOutlineVariant.withValues(alpha: 0.15),
          )
        : Container(
            height: 1,
            color: PharmaColors.clinicalOutlineVariant.withValues(alpha: 0.15),
          );
  }
}

// ─── VERSION BADGE ───────────────────────────────────────────────────────────
/// v2.4.0-Validated style badge
class ClinicalVersionBadge extends StatelessWidget {
  const ClinicalVersionBadge({super.key, required this.version, this.hmacTimestamp});

  final String version;
  final String? hmacTimestamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: PharmaColors.clinicalSurfaceContainerHighest,
            borderRadius: PharmaRadius.clinicalCardRadius,
          ),
          child: Text(
            version,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: PharmaColors.clinicalOnSurfaceVariant,
              letterSpacing: 1.0,
            ),
          ),
        ),
        if (hmacTimestamp != null) ...[
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user, size: 12, color: PharmaColors.clinicalOnSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                'HMAC Verified: $hmacTimestamp',
                style: PharmaTypography.clinicalBody.copyWith(fontSize: 11),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ─── PROGRESS BAR (STITCH STYLE) ────────────────────────────────────────────
class ClinicalProgressBar extends StatelessWidget {
  const ClinicalProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 6,
    this.label,
  });

  final double value;
  final Color? color;
  final double height;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PharmaColors.clinicalSurfaceContainerLow,
            borderRadius: BorderRadius.circular(1),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0, 1),
            child: Container(
              decoration: BoxDecoration(
                color: color ?? PharmaColors.clinicalSecondary,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 4),
          Text(label!, style: PharmaTypography.clinicalMono),
        ],
      ],
    );
  }
}

// ─── LEGACY WRAPPERS (backward compatibility) ────────────────────────────────

class AdminFilterBar extends StatelessWidget {
  const AdminFilterBar({
    super.key,
    required this.children,
    this.searchHint = 'Search...',
  });

  final List<Widget> children;
  final String searchHint;

  @override
  Widget build(BuildContext context) {
    return ClinicalFilterBar(
      children: [
        SizedBox(width: 260, child: PharmaSearchBar(hint: searchHint)),
        ...children,
      ],
    );
  }
}

class AdminApprovalPanel extends StatelessWidget {
  const AdminApprovalPanel({
    super.key,
    required this.title,
    required this.status,
    this.onApprove,
    this.onReject,
  });

  final String title;
  final String status;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return ClinicalTonalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: PharmaTypography.clinicalTitle),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Status: '),
              PharmaBadge(label: status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClinicalActionButton(label: 'Approve', variant: ClinicalButtonVariant.secondary, onTap: onApprove),
              const SizedBox(width: 8),
              ClinicalActionButton(label: 'Reject', variant: ClinicalButtonVariant.tertiary, onTap: onReject),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminActionDrawer extends StatelessWidget {
  const AdminActionDrawer({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 420,
      backgroundColor: PharmaColors.clinicalSurfaceContainerLow,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: PharmaTypography.clinicalTitle)),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: PharmaColors.clinicalOnSurfaceVariant),
                  ),
                ],
              ),
            ),
            const ClinicalGhostDivider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminAdvancedTable extends StatelessWidget {
  const AdminAdvancedTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<String> columns;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return ClinicalTonalCard(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      child: ClinicalDataTable(
        columns: columns,
        rows: rows
            .map(
              (r) => r
                  .map<Widget>(
                    (v) => Text(v, style: PharmaTypography.clinicalTableCell),
                  )
                  .toList(),
            )
            .toList(),
      ),
    );
  }
}
