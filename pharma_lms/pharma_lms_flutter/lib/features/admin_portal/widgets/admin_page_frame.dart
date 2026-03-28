import 'package:flutter/material.dart';
import '../../../design_system/pharma_components.dart';
import '../../../design_system/pharma_design_system.dart';

class AdminPageFrame extends StatelessWidget {
  const AdminPageFrame({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions = const [],
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.of(context).size.width < 980;
    return ListView(
      padding: const EdgeInsets.all(PortalLayout.contentPadding),
      children: [
        Wrap(
          spacing: PharmaSpacing.md,
          runSpacing: PharmaSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            SizedBox(
              width: compact ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width - 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: PharmaTypography.headingLarge),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (actions.isNotEmpty) Wrap(spacing: PharmaSpacing.sm, runSpacing: PharmaSpacing.sm, children: actions),
          ],
        ),
        const SizedBox(height: PharmaSpacing.lg),
        ...children,
      ],
    );
  }
}

class AdminSectionCard extends StatelessWidget {
  const AdminSectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.lg),
      child: PharmaCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: PharmaTypography.headingSmall),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: PharmaSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

class AdminKpiRow extends StatelessWidget {
  const AdminKpiRow({super.key, required this.items});

  final List<({String label, String value, IconData icon})> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: PharmaSpacing.md,
      runSpacing: PharmaSpacing.md,
      children: items
          .map(
            (i) => SizedBox(
              width: 220,
              child: PharmaCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: PharmaColors.gray100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(i.icon, size: 20, color: PharmaColors.emerald600),
                    ),
                    const SizedBox(width: PharmaSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i.label,
                            style: PharmaTypography.caption.copyWith(
                              color: PharmaColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(i.value, style: PharmaTypography.headingSmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

/// Simple read-only data table for admin lists (CSV-style rows).
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
            headingTextStyle: PharmaTypography.bodyMedium.copyWith(
              color: PharmaColors.textSecondary,
            ),
            columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
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
