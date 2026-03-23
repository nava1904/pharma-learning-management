import 'package:flutter/material.dart';
import '../widgets/admin_page_frame.dart';

class AdminComplianceReportDashboardScreen extends StatelessWidget {
  const AdminComplianceReportDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => const _ReportTemplate(
        title: 'Compliance Overview',
        subtitle: 'Global compliance KPI and trend tracking.',
      );
}

class AdminGapReportScreen extends StatelessWidget {
  const AdminGapReportScreen({super.key});
  @override
  Widget build(BuildContext context) => const _ReportTemplate(
        title: 'Gap Report',
        subtitle: 'Role, site, and department compliance gap export.',
      );
}

class AdminRegulatoryReportScreen extends StatelessWidget {
  const AdminRegulatoryReportScreen({super.key});
  @override
  Widget build(BuildContext context) => const _ReportTemplate(
        title: 'Regulatory Reports',
        subtitle: 'Inspection-ready report packages and evidence.',
      );
}

class AdminScheduledReportScreen extends StatelessWidget {
  const AdminScheduledReportScreen({super.key});
  @override
  Widget build(BuildContext context) => const _ReportTemplate(
        title: 'Scheduled Reports',
        subtitle: 'Automated report generation and email delivery.',
      );
}

class _ReportTemplate extends StatelessWidget {
  const _ReportTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Report Jobs',
            child: AdminPlaceholderTable(
              columns: ['Report', 'Frequency', 'Recipients', 'Last Run', 'Status'],
              rows: [
                ['Weekly Compliance', 'Weekly', 'QA, Site Heads', '2026-03-18', 'Success'],
                ['Expiry Watchlist', 'Daily', 'LMS Admin', '2026-03-20', 'Success'],
              ],
            ),
          ),
        ],
      );
}
