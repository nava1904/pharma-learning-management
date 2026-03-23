import 'package:flutter/material.dart';
import '../widgets/admin_page_frame.dart';

class AdminDocumentLibraryScreen extends StatelessWidget {
  const AdminDocumentLibraryScreen({super.key});
  @override
  Widget build(BuildContext context) => const _DocumentTemplate(
        title: 'Document Library',
        subtitle: 'Controlled document repository and version records.',
      );
}

class AdminDocumentUploadScreen extends StatelessWidget {
  const AdminDocumentUploadScreen({super.key});
  @override
  Widget build(BuildContext context) => const _DocumentTemplate(
        title: 'Upload Document',
        subtitle: 'Upload and classify GxP documents.',
      );
}

class AdminDocumentAcknowledgementScreen extends StatelessWidget {
  const AdminDocumentAcknowledgementScreen({super.key});
  @override
  Widget build(BuildContext context) => const _DocumentTemplate(
        title: 'Acknowledgements',
        subtitle: 'Track read-and-ack completion by employees.',
      );
}

class _DocumentTemplate extends StatelessWidget {
  const _DocumentTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Documents',
            child: AdminPlaceholderTable(
              columns: ['Document', 'Version', 'Owner', 'Ack Pending', 'Status'],
              rows: [
                ['SOP-101', 'v5', 'QA', '12', 'Effective'],
                ['WI-224', 'v2', 'Ops', '6', 'Under Review'],
              ],
            ),
          ),
        ],
      );
}
