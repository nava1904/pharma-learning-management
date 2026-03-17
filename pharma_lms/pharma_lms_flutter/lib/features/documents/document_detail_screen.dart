
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/user_provider.dart';

/// Document detail, QA classification, and lifecycle (QA-02).
class DocumentDetailScreen extends ConsumerStatefulWidget {
  const DocumentDetailScreen({
    super.key,
    required this.documentId,
    this.document,
  });

  final String documentId;
  final Document? document;

  @override
  ConsumerState<DocumentDetailScreen> createState() =>
      _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends ConsumerState<DocumentDetailScreen> {
  Document? _document;
  List<DocumentVersion> _versions = [];
  Map<int, String> _versionStates = {}; // documentVersionId -> current state
  bool _loading = true;
  String? _error;
  String? _selectedQaClassification;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      _document = widget.document;
      _selectedQaClassification = widget.document!.trainingRequiredByQa ??
          'training_required';
      _loadVersions();
    } else {
      _load();
    }
  }

  Future<void> _load() async {
    final id = int.tryParse(widget.documentId);
    if (id == null) {
      setState(() {
        _error = 'Invalid document ID';
        _loading = false;
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final doc = await client.document.getDocument(id);
      if (mounted) {
        setState(() {
          _document = doc;
          _selectedQaClassification =
              doc?.trainingRequiredByQa ?? 'training_required';
          _loading = false;
        });
        _loadVersions();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _loadVersions() async {
    final docId = _document?.id;
    if (docId == null) return;
    try {
      final versions = await client.document.getDocumentVersions(docId);
      final states = <int, String>{};
      for (final v in versions) {
        if (v.id != null) {
          final lifecycles =
              await client.document.getDocumentLifecycle(v.id!);
          final sorted = List<DocumentLifecycle>.from(lifecycles)
            ..sort((a, b) => b.changedAt.compareTo(a.changedAt));
          states[v.id!] = sorted.isNotEmpty ? sorted.first.state : 'draft';
        }
      }
      if (mounted) {
        setState(() {
          _versions = versions;
          _versionStates = states;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _versions = [];
          _versionStates = {};
        });
      }
    }
  }

  Future<void> _saveQaClassification() async {
    if (_document?.id == null) return;
    if (_selectedQaClassification == null) return;
    setState(() => _saving = true);
    try {
      await client.document.updateDocumentQaClassification(
        documentId: _document!.id!,
        trainingRequiredByQa: _selectedQaClassification!,
      );
      if (mounted) {
        setState(() {
          _document = _document!.copyWith(
            trainingRequiredByQa: _selectedQaClassification,
          );
          _saving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QA classification updated')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  static const _validTransitions = <String, List<String>>{
    'draft': ['review'],
    'review': ['approved'],
    'approved': ['effective'],
    'effective': ['obsolete'],
    'obsolete': [],
  };

  Future<void> _transitionLifecycle(
    int documentVersionId,
    String newState, {
    String? obsoleteReason,
  }) async {
    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
      return;
    }

    final needsEsign = newState == 'approved' || newState == 'effective';
    String? passwordPlaintext;
    String signatureMeaning = 'Document lifecycle approval';

    if (needsEsign) {
      final result = await showDialog<Map<String, String>>(
        context: context,
        builder: (ctx) => _LifecycleSignDialog(newState: newState),
      );
      if (result == null || result['password']?.isEmpty == true) return;
      passwordPlaintext = result['password'];
      signatureMeaning = result['meaning'] ?? signatureMeaning;
    } else if (newState == 'obsolete' && (obsoleteReason == null || obsoleteReason.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Obsolete reason is required')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await client.document.transitionDocumentLifecycle(
        documentVersionId: documentVersionId,
        newState: newState,
        obsoleteReason: newState == 'obsolete' ? obsoleteReason : null,
        userId: user!.id!,
        signatureMeaning: signatureMeaning,
        passwordPlaintext: passwordPlaintext,
      );
      if (mounted) {
        setState(() {
          _versionStates[documentVersionId] = newState;
          _saving = false;
        });
        _loadVersions();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Moved to $newState')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _showObsoleteDialog(int documentVersionId) async {
    final reasonController = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mark as Obsolete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Obsolete reason is required for audit trail.',
              style: TextStyle(fontSize: 12, color: AppColors.slate600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Obsolete Reason',
                border: OutlineInputBorder(),
                hintText: 'e.g. Superseded by new version',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final r = reasonController.text.trim();
              if (r.isEmpty) return;
              Navigator.pop(ctx, r);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (reason != null && reason.isNotEmpty) {
      await _transitionLifecycle(
        documentVersionId,
        'obsolete',
        obsoleteReason: reason,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Document')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null || _document == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Document')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error ?? 'Document not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/documents'),
                child: const Text('Back to Documents'),
              ),
            ],
          ),
        ),
      );
    }

    final doc = _document!;

    return Scaffold(
      appBar: AppBar(
        title: Text(doc.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/documents'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document Metadata',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _MetaRow(label: 'Title', value: doc.title),
                  _MetaRow(label: 'Document Number', value: doc.documentNumber),
                  _MetaRow(label: 'Type', value: doc.documentType),
                  if (doc.organization != null)
                    _MetaRow(
                      label: 'Organization',
                      value: doc.organization!.name,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QA Classification',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Only documents marked "training_required" trigger retraining when updated.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedQaClassification ?? 'training_required',
                    decoration: const InputDecoration(
                      labelText: 'Training Required by QA',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'training_required',
                        child: Text('training_required'),
                      ),
                      DropdownMenuItem(
                        value: 'no_training_required',
                        child: Text('no_training_required'),
                      ),
                    ],
                    onChanged: _saving
                        ? null
                        : (v) => setState(() => _selectedQaClassification = v),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saving ? null : _saveQaClassification,
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save QA Classification'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _DocumentVersionsSection(
              documentTitle: doc.title,
              versions: _versions,
              versionStates: _versionStates,
              validTransitions: _validTransitions,
              onTransition: _transitionLifecycle,
              onObsolete: _showObsoleteDialog,
              saving: _saving,
            ),
          ],
        ),
      ),
    );
  }
}

/// Document versions and lifecycle state (QA-02).
class _DocumentVersionsSection extends StatelessWidget {
  const _DocumentVersionsSection({
    required this.documentTitle,
    required this.versions,
    required this.versionStates,
    required this.validTransitions,
    required this.onTransition,
    required this.onObsolete,
    required this.saving,
  });

  final String documentTitle;
  final List<DocumentVersion> versions;
  final Map<int, String> versionStates;
  final Map<String, List<String>> validTransitions;
  final Future<void> Function(int documentVersionId, String newState)
      onTransition;
  final Future<void> Function(int documentVersionId) onObsolete;
  final bool saving;

  Color _stateColor(String state) {
    switch (state) {
      case 'draft':
        return AppColors.slate500;
      case 'review':
        return AppColors.warning;
      case 'approved':
        return AppColors.info;
      case 'effective':
        return AppColors.success;
      case 'obsolete':
        return AppColors.destructive;
      default:
        return AppColors.slate600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: AppColors.indigo600, size: 20),
              const SizedBox(width: 8),
              Text(
                'Document Versions & Lifecycle',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate900,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Draft → Review → Approved → Effective → Obsolete. QA e-sign required for Approved and Effective.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.slate600,
                ),
          ),
          const SizedBox(height: 16),
          if (versions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No document versions yet.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate600,
                    ),
              ),
            )
          else
            ...versions.map((v) {
              final state = versionStates[v.id] ?? 'draft';
              final allowed = validTransitions[state] ?? [];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Version ${v.version}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.slate900,
                                  ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _stateColor(state).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              state.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _stateColor(state),
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (v.effectiveDate != null)
                            Text(
                              'Effective: ${v.effectiveDate!.toIso8601String().split('T')[0]}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.slate600,
                                  ),
                            ),
                          if (v.obsoleteDate != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              'Obsolete: ${v.obsoleteDate!.toIso8601String().split('T')[0]}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.destructive,
                                  ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final next in allowed)
                            if (next == 'obsolete')
                              OutlinedButton(
                                onPressed: saving
                                    ? null
                                    : () => onObsolete(v.id!),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.destructive,
                                  side: const BorderSide(
                                      color: AppColors.destructive),
                                ),
                                child: const Text('Mark Obsolete'),
                              )
                            else
                              FilledButton(
                                onPressed: saving
                                    ? null
                                    : () => onTransition(v.id!, next),
                                child: Text(
                                  next == 'review'
                                      ? 'Move to Review'
                                      : next == 'approved'
                                          ? 'Approve'
                                          : next == 'effective'
                                              ? 'Mark Effective'
                                              : next,
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

/// E-sign dialog for document lifecycle transitions (Approved, Effective).
class _LifecycleSignDialog extends StatefulWidget {
  const _LifecycleSignDialog({required this.newState});

  final String newState;

  @override
  State<_LifecycleSignDialog> createState() => _LifecycleSignDialogState();
}

class _LifecycleSignDialogState extends State<_LifecycleSignDialog> {
  final _passwordController = TextEditingController();
  final _meaningController = TextEditingController(
    text: 'Document lifecycle approval',
  );
  bool _signing = false;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    _meaningController.dispose();
    super.dispose();
  }

  Future<void> _sign() async {
    final password = _passwordController.text.trim();
    final meaning = _meaningController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Password required for re-authentication');
      return;
    }
    if (meaning.isEmpty) {
      setState(() => _error = 'Signature meaning required');
      return;
    }
    setState(() {
      _signing = true;
      _error = null;
    });
    if (mounted) {
      Navigator.pop(context, {'password': password, 'meaning': meaning});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sign: ${widget.newState == 'approved' ? 'Approve' : 'Mark Effective'}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'QA e-signature required. 21 CFR Part 11 compliant.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _meaningController,
              decoration: const InputDecoration(
                labelText: 'Signature Meaning',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password (re-authentication)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sign(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Colors.red[700])),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _signing ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _signing ? null : _sign,
          child: _signing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Sign'),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.slate600,
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
