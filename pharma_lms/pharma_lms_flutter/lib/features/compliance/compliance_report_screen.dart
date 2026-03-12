import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/client.dart';

/// Compliance report screen - department compliance summary.
/// When [departmentId] is provided (from analytics drill-down), shows non-compliant employees.
class ComplianceReportScreen extends StatefulWidget {
  const ComplianceReportScreen({super.key, this.departmentId});

  final int? departmentId;

  @override
  State<ComplianceReportScreen> createState() => _ComplianceReportScreenState();
}

class _ComplianceReportScreenState extends State<ComplianceReportScreen> {
  List<DepartmentComplianceSummary> _summary = [];
  List<PharmaUser> _nonCompliantUsers = [];
  AuditReadinessScore? _auditReadiness;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final summary = await client.analytics.getDepartmentComplianceSummary();
      final readiness = await client.analytics.getAuditReadinessScore();
      List<PharmaUser> nonCompliant = [];
      if (widget.departmentId != null) {
        nonCompliant = await client.analytics.getNonCompliantEmployees(
          departmentId: widget.departmentId,
        );
      }
      setState(() {
        _summary = summary;
        _auditReadiness = readiness;
        _nonCompliantUsers = nonCompliant;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _exportPdf() async {
    try {
    final pdf = pw.Document();
    final nowUtc = DateTime.now().toUtc();
    pdf.addPage(
      pw.Page(
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Compliance Report',
              style: pw.TextStyle(fontSize: 24),
            ),
            pw.SizedBox(height: 16),
            if (_auditReadiness != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 12),
              child: pw.Text(
                'Audit Readiness: ${(_auditReadiness!.overallScore * 100).toStringAsFixed(1)}%',
                style: pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.Text(
              'Department Compliance',
              style: pw.TextStyle(fontSize: 16),
            ),
            pw.SizedBox(height: 8),
            ..._summary.map((m) => pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    '${m.departmentName}: ${(m.complianceRate * 100).toStringAsFixed(1)}% (Overdue: ${m.overdue})',
                  ),
                )),
          ],
        ),
      ),
    );
    var bytes = await pdf.save();
    final hash = sha256.convert(bytes).toString();
    pdf.addPage(
      pw.Page(
        build: (ctx) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Spacer(),
            pw.Center(
              child: pw.Text(
                'Generated on ${nowUtc.toIso8601String().split('.').first}Z — Hash: $hash',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
    bytes = await pdf.save();
      try {
        await client.audit.logReportExport(
          reportType: 'compliance_report',
          hashSha256: hash,
          recordCount: _summary.length,
        );
      } catch (_) {}
      final result = await FilePicker.platform.saveFile(
        fileName:
            'compliance-report-${DateTime.now().toIso8601String().split('T')[0]}.pdf',
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result != null ? 'Report saved' : 'Export cancelled',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Compliance Report')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Compliance Report')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compliance Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportPdf,
            tooltip: 'Export PDF',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_auditReadiness != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Audit Readiness Score',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_auditReadiness!.overallScore.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Compliance: ${_auditReadiness!.complianceScore.toStringAsFixed(1)}% | '
                        'Audit trail: ${_auditReadiness!.auditTrailActive ? 'Active' : 'Inactive'}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            if (widget.departmentId != null && _nonCompliantUsers.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Non-Compliant Employees (Department Drill-Down)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _nonCompliantUsers.length,
                  itemBuilder: (context, i) {
                    final u = _nonCompliantUsers[i];
                    return ListTile(
                      title: Text('${u.firstName} ${u.lastName}'.trim().isEmpty ? u.email : '${u.firstName} ${u.lastName}'.trim()),
                      subtitle: Text(u.email ?? ''),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'By Department',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: _summary.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No data'),
                    )
                  : Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        const TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Department',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Rate %',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Overdue',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ..._summary.map((m) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    m.departmentName ?? '',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    m.complianceRate.toStringAsFixed(1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text('${m.overdue}'),
                                ),
                              ],
                            )),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
