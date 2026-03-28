import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../widgets/admin_page_frame.dart';

class AdminDocumentLibraryScreen extends ConsumerWidget {
  const AdminDocumentLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docs = ref.watch(adminDocumentsProvider);

    return AdminPageFrame(
      title: 'Document Library',
      subtitle: 'Controlled document repository and metadata.',
      children: [
        AdminSectionCard(
          title: 'Documents',
          child: docs.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('$e'),
            data: (list) {
              if (list.isEmpty) {
                return Text(
                  'No documents in this organization.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                );
              }
              return AdminDataTable(
                columns: const ['Title', 'Number', 'Type', 'QA training flag'],
                rows: list
                    .map(
                      (d) => [
                        d.title,
                        d.documentNumber,
                        d.documentType,
                        d.trainingRequiredByQa ?? '—',
                      ],
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AdminDocumentUploadScreen extends ConsumerStatefulWidget {
  const AdminDocumentUploadScreen({super.key});

  @override
  ConsumerState<AdminDocumentUploadScreen> createState() => _AdminDocumentUploadScreenState();
}

class _AdminDocumentUploadScreenState extends ConsumerState<AdminDocumentUploadScreen> {
  final _title = TextEditingController();
  final _number = TextEditingController();
  String _type = 'sop';
  final _version = TextEditingController(text: '1.0');
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    _number.dispose();
    _version.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final user = await ref.read(currentUserProvider.future);
    if (user == null) return;
    setState(() => _busy = true);
    try {
      final doc = await client.document.createDocument(
        title: _title.text.trim(),
        documentNumber: _number.text.trim(),
        documentType: _type,
        organizationId: user.organizationId,
      );
      if (doc.id == null) throw Exception('Document create failed');
      final key = 'admin-upload/${doc.id}/${DateTime.now().millisecondsSinceEpoch}.pdf';
      await client.document.createDocumentVersion(
        documentId: doc.id!,
        version: _version.text.trim().isEmpty ? '1.0' : _version.text.trim(),
        storageKey: key,
        effectiveDate: DateTime.now(),
      );
      ref.invalidate(adminDocumentsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document created')));
      _title.clear();
      _number.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Upload Document',
      subtitle: 'Register metadata and an initial version; storage keys are assigned server-side when the file is uploaded.',
      children: [
        AdminSectionCard(
          title: 'New document',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              ),
              SizedBox(height: PharmaSpacing.md),
              TextField(
                controller: _number,
                decoration: const InputDecoration(labelText: 'Document number', border: OutlineInputBorder()),
              ),
              SizedBox(height: PharmaSpacing.md),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                initialValue: _type,
                items: const [
                  DropdownMenuItem(value: 'sop', child: Text('sop')),
                  DropdownMenuItem(value: 'policy', child: Text('policy')),
                  DropdownMenuItem(value: 'guideline', child: Text('guideline')),
                ],
                onChanged: (v) => setState(() => _type = v ?? 'sop'),
              ),
              SizedBox(height: PharmaSpacing.md),
              TextField(
                controller: _version,
                decoration: const InputDecoration(labelText: 'Initial version', border: OutlineInputBorder()),
              ),
              SizedBox(height: PharmaSpacing.md),
              FilledButton(onPressed: _busy ? null : _submit, child: Text(_busy ? 'Saving…' : 'Create')),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminDocumentAcknowledgementScreen extends ConsumerWidget {
  const AdminDocumentAcknowledgementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docs = ref.watch(adminDocumentsProvider);

    return AdminPageFrame(
      title: 'Acknowledgements',
      subtitle: 'Documents with QA training classification (retraining workflow alignment).',
      children: [
        AdminSectionCard(
          title: 'Training-linked documents',
          child: docs.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('$e'),
            data: (list) {
              final gated = list.where((d) => (d.trainingRequiredByQa ?? '').isNotEmpty).toList();
              if (gated.isEmpty) {
                return Text(
                  'No QA training flags set on documents.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                );
              }
              return AdminDataTable(
                columns: const ['Title', 'Number', 'QA training', 'Affected dept IDs (json)'],
                rows: gated
                    .map(
                      (d) => [
                        d.title,
                        d.documentNumber,
                        d.trainingRequiredByQa ?? '—',
                        d.affectedDepartmentIdsJson ?? '—',
                      ],
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
