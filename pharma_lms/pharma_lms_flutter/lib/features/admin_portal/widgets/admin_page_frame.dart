import 'package:flutter/material.dart';
import '../../../design_system/pharma_design_system.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// STITCH "CLINICAL ARCHIVE" — ADMIN PAGE FRAME
// ═══════════════════════════════════════════════════════════════════════════════
// Tonal background (surface-container-low), no-border cards
// ═══════════════════════════════════════════════════════════════════════════════

class AdminPageFrame extends StatelessWidget {
  const AdminPageFrame({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions = const [],
    required this.children,
    this.versionBadge,
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;
  final List<Widget> children;
  final String? versionBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PharmaColors.clinicalSurfaceContainerLow,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Version badge (optional)
          if (versionBadge != null) ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: PharmaColors.clinicalSurfaceContainerHighest,
                    borderRadius: PharmaRadius.clinicalCardRadius,
                  ),
                  child: Text(
                    versionBadge!,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: PharmaColors.clinicalOnSurfaceVariant,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: PharmaTypography.clinicalHeadline),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: PharmaTypography.clinicalBody,
                    ),
                  ],
                ),
              ),
              if (actions.isNotEmpty)
                Wrap(spacing: 8, runSpacing: 8, children: actions),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }
}

/// Section card using tonal architecture (no borders)
class AdminSectionCard extends StatelessWidget {
  const AdminSectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.trailing,
    this.borderTop,
    this.borderLeft,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final Color? borderTop;
  final Color? borderLeft;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: PharmaColors.clinicalSurfaceContainerLowest,
          borderRadius: PharmaRadius.clinicalCardRadius,
          boxShadow: PharmaShadows.atmosphericLight,
          border: Border(
            top: borderTop != null
                ? BorderSide(color: borderTop!, width: 2)
                : BorderSide.none,
            left: borderLeft != null
                ? BorderSide(color: borderLeft!, width: 4)
                : BorderSide.none,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trailing != null)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: PharmaTypography.clinicalTitle),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(subtitle!, style: PharmaTypography.clinicalBody),
                        ],
                      ],
                    ),
                  ),
                  trailing!,
                ],
              )
            else ...[
              Text(title, style: PharmaTypography.clinicalTitle),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: PharmaTypography.clinicalBody),
              ],
            ],
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

/// KPI row with stitch clinical cards
class AdminKpiRow extends StatelessWidget {
  const AdminKpiRow({super.key, required this.items});

  final List<({String label, String value, IconData icon})> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 900
            ? (constraints.maxWidth - (items.length - 1) * 16) / items.length
            : constraints.maxWidth > 600
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items
              .map(
                (i) => SizedBox(
                  width: cardWidth,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: PharmaColors.clinicalSurfaceContainerLowest,
                      borderRadius: PharmaRadius.clinicalCardRadius,
                      boxShadow: PharmaShadows.sm,
                      border: const Border(
                        bottom: BorderSide(
                          color: PharmaColors.clinicalPrimaryContainer,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              i.label.toUpperCase(),
                              style: PharmaTypography.clinicalLabel,
                            ),
                            Icon(i.icon, size: 20, color: PharmaColors.clinicalOnSurfaceVariant),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          i.value,
                          style: PharmaTypography.clinicalKpiValue,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

/// Simple read-only data table for admin lists (stitch style).
class AdminDataTable extends StatelessWidget {
  const AdminDataTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<String> columns;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(PharmaColors.clinicalSurfaceContainerLow),
            headingTextStyle: PharmaTypography.clinicalTableHeader,
            dataTextStyle: PharmaTypography.clinicalTableCell,
            dividerThickness: 0,
            dataRowMinHeight: 48,
            columns: columns.map((c) => DataColumn(label: Text(c.toUpperCase()))).toList(),
            rows: rows
                .map(
                  (r) => DataRow(
                    cells: r.map((v) => DataCell(Text(v))).toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
