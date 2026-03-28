import 'package:flutter/material.dart';

class AccessReviewTable extends StatelessWidget {
  final List<AccessReviewRowData> rows;
  final void Function(AccessReviewRowData) onRecertify;
  final void Function(AccessReviewRowData) onRevoke;

  const AccessReviewTable({
    super.key,
    required this.rows,
    required this.onRecertify,
    required this.onRevoke,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Dept / Role')),
              DataColumn(label: Text('Site')),
              DataColumn(label: Text('Hire Date')),
              DataColumn(label: Text('Compliance')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('MFA')),
              DataColumn(label: Text('Last Login')),
              DataColumn(label: Text('Login Risk')),
              DataColumn(label: Text('Actions')),
            ],
            rows: rows.map((row) => DataRow(cells: [
              DataCell(_EmployeeCell(row)),
              DataCell(Text(row.deptRole)),
              DataCell(Text(row.site)),
              DataCell(Text(row.hireDate)),
              DataCell(_ComplianceCell(row.compliancePercent)),
              DataCell(_StatusCell(row.status)),
              DataCell(_MfaCell(row.mfaType)),
              DataCell(Text(row.lastLogin)),
              DataCell(_LoginRiskCell(row.loginRisk)),
              DataCell(Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () => onRecertify(row),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Recertify'),
                  ),
                  ElevatedButton(
                    onPressed: () => onRevoke(row),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Revoke'),
                  ),
                ],
              )),
            ])).toList(),
          ),
        ),
      ),
    );
  }
}

class AccessReviewRowData {
  final int reviewId;
  final String employeeName;
  final String employeeId;
  final String deptRole;
  final String site;
  final String hireDate;
  final int compliancePercent;
  final String status;
  final String mfaType;
  final String lastLogin;
  final String loginRisk;
  final String avatarUrl;
  final String decision;

  AccessReviewRowData({
    required this.reviewId,
    required this.employeeName,
    required this.employeeId,
    required this.deptRole,
    required this.site,
    required this.hireDate,
    required this.compliancePercent,
    required this.status,
    required this.mfaType,
    required this.lastLogin,
    required this.loginRisk,
    required this.avatarUrl,
    required this.decision,
  });
}

class _EmployeeCell extends StatelessWidget {
  final AccessReviewRowData row;
  const _EmployeeCell(this.row);
  @override
  Widget build(BuildContext context) {
    final initials = row.employeeName.trim().isEmpty
        ? '?'
        : row.employeeName
            .trim()
            .split(RegExp(r'\s+'))
            .where((p) => p.isNotEmpty)
            .take(2)
            .map((p) => p[0])
            .join()
            .toUpperCase();
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.blueGrey.shade100,
          backgroundImage: row.avatarUrl.trim().isEmpty ? null : NetworkImage(row.avatarUrl),
          child: row.avatarUrl.trim().isEmpty
              ? Text(initials, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
              : null,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.employeeName, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Access review', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class _ComplianceCell extends StatelessWidget {
  final int compliancePercent;
  const _ComplianceCell(this.compliancePercent);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$compliancePercent%'),
        const SizedBox(width: 4),
        Icon(Icons.check_circle, color: compliancePercent >= 80 ? Colors.green : Colors.orange, size: 16),
      ],
    );
  }
}

class _StatusCell extends StatelessWidget {
  final String status;
  const _StatusCell(this.status);
  @override
  Widget build(BuildContext context) {
    final normalized = status.trim().toLowerCase();
    final isActive = normalized == 'active';
    Color color = isActive ? Colors.green : Colors.red;
    return Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold));
  }
}

class _MfaCell extends StatelessWidget {
  final String mfaType;
  const _MfaCell(this.mfaType);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.verified_user, color: Colors.blue, size: 16),
        const SizedBox(width: 4),
        Text(mfaType),
      ],
    );
  }
}

class _LoginRiskCell extends StatelessWidget {
  final String loginRisk;
  const _LoginRiskCell(this.loginRisk);
  @override
  Widget build(BuildContext context) {
    if (loginRisk.isEmpty) return const SizedBox();
    Color color = loginRisk.contains('Amber') ? Colors.amber : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(loginRisk, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
