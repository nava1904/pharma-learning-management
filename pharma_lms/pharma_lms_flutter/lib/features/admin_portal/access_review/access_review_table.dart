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
    return DataTable(
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
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () => onRecertify(row),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Recertify Access'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => onRevoke(row),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Revoke Access'),
            ),
          ],
        )),
      ])).toList(),
    );
  }
}

class AccessReviewRowData {
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

  AccessReviewRowData({
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
  });
}

class _EmployeeCell extends StatelessWidget {
  final AccessReviewRowData row;
  const _EmployeeCell(this.row);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(row.avatarUrl), radius: 16),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.employeeName, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(row.employeeId, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
    Color color = status == 'ACTIVE' ? Colors.green : Colors.red;
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
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(loginRisk, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
