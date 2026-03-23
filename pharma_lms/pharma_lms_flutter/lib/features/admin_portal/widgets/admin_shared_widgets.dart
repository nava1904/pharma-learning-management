import 'package:flutter/material.dart';
import '../../../design_system/pharma_components.dart';
import '../../../design_system/pharma_design_system.dart';

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
    return PharmaCard(
      child: Wrap(
        spacing: PharmaSpacing.md,
        runSpacing: PharmaSpacing.md,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(width: 260, child: PharmaSearchBar(hint: searchHint)),
          ...children,
        ],
      ),
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
    return PharmaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: PharmaTypography.headingSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Status: '),
              PharmaBadge(label: status),
            ],
          ),
          const SizedBox(height: PharmaSpacing.md),
          Row(
            children: [
              PharmaButton(
                onPressed: onApprove,
                variant: PharmaButtonVariant.primary,
                child: const Text('Approve'),
              ),
              const SizedBox(width: 8),
              PharmaButton(
                onPressed: onReject,
                variant: PharmaButtonVariant.danger,
                child: const Text('Reject'),
              ),
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
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: PharmaTypography.headingSmall)),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
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
    return PharmaCard(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
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
    );
  }
}
