import 'package:flutter/material.dart';
import '../widgets/admin_page_frame.dart';

class AdminEnrollmentListScreen extends StatelessWidget {
  const AdminEnrollmentListScreen({super.key});
  @override
  Widget build(BuildContext context) => const _EnrollmentTemplate(
        title: 'All Enrollments',
        subtitle: 'Track assignment, due dates, and progress outcomes.',
      );
}

class AdminEnrollmentCreateScreen extends StatelessWidget {
  const AdminEnrollmentCreateScreen({super.key});
  @override
  Widget build(BuildContext context) => const _EnrollmentTemplate(
        title: 'New Enrollment',
        subtitle: 'Assign one learner or a department cohort.',
      );
}

class AdminEnrollmentBulkScreen extends StatelessWidget {
  const AdminEnrollmentBulkScreen({super.key});
  @override
  Widget build(BuildContext context) => const _EnrollmentTemplate(
        title: 'Bulk Enrollment Upload',
        subtitle: 'Upload assignment sheet and validate mapping.',
      );
}

class AdminEnrollmentRulesScreen extends StatelessWidget {
  const AdminEnrollmentRulesScreen({super.key});
  @override
  Widget build(BuildContext context) => const _EnrollmentTemplate(
        title: 'Auto-Enrol Rules',
        subtitle: 'Configure role/site based automatic assignments.',
      );
}

class AdminTranscriptViewerScreen extends StatelessWidget {
  const AdminTranscriptViewerScreen({super.key});
  @override
  Widget build(BuildContext context) => const _EnrollmentTemplate(
        title: 'Transcript Viewer',
        subtitle: 'Review user-level completion and certificate history.',
      );
}

class _EnrollmentTemplate extends StatelessWidget {
  const _EnrollmentTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Enrollment Records',
            child: AdminPlaceholderTable(
              columns: ['Learner', 'Course', 'Due Date', 'Status', 'Progress'],
              rows: [
                ['Arjun Kumar', 'GMP Fundamentals', '2026-03-25', 'Active', '68%'],
                ['Priya Singh', 'Data Integrity 101', '2026-03-28', 'Active', '45%'],
              ],
            ),
          ),
        ],
      );
}
