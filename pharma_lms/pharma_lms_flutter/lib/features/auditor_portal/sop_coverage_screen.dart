import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// AUD-03: SOP training coverage - qualified vs non-qualified users.
class SopCoverageScreen extends StatefulWidget {
  const SopCoverageScreen({super.key});

  @override
  State<SopCoverageScreen> createState() => _SopCoverageScreenState();
}

class _SopCoverageScreenState extends State<SopCoverageScreen> {
  List<Document> _documents = [];
  final Map<int, List<CourseVersion>> _versionsByCourse = {};
  Document? _selectedDoc;
  CourseVersion? _selectedVersion;
  Map<String, dynamic>? _coverage;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final docs = await client.document.listDocuments(
        documentType: 'sop',
      );
      if (mounted) {
        setState(() {
          _documents = docs;
          _loading = false;
        });
        if (docs.isNotEmpty && _selectedDoc == null) {
          _onDocumentSelected(docs.first);
        }
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

  Future<void> _onDocumentSelected(Document doc) async {
    setState(() {
      _selectedDoc = doc;
      _selectedVersion = null;
      _coverage = null;
    });
    if (doc.id == null) return;
    try {
      final courses = await client.course.listCourses();
      final matching =
          courses.where((c) => c.sopNumber == doc.documentNumber).toList();
      if (matching.isEmpty) {
        setState(() => _error = 'No course linked to this SOP');
        return;
      }
      final versions = <CourseVersion>[];
      for (final c in matching) {
        if (c.id != null) {
          final v = await client.course.getCourseVersions(c.id!);
          versions.addAll(v);
        }
      }
      if (mounted) {
        setState(() {
          _versionsByCourse[doc.id!] = versions;
          if (versions.isNotEmpty && _selectedVersion == null) {
            _selectedVersion = versions.first;
            _loadCoverage();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = e.toString());
      }
    }
  }

  Future<void> _loadCoverage() async {
    if (_selectedDoc?.id == null || _selectedVersion?.id == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await client.inspection.getSopTrainingCoverage(
        sopDocumentId: _selectedDoc!.id!,
        versionId: _selectedVersion!.id!,
      );
      if (mounted) {
        setState(() {
          _coverage = result;
          _loading = false;
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/auditor'),
        ),
        title: const Text('SOP Coverage'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SOP Document',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<Document>(
                  initialValue: _selectedDoc,
                  items: _documents
                      .map((d) => DropdownMenuItem(
                            value: d,
                            child: Text(
                                '${d.documentNumber ?? d.id} - ${d.title}'),
                          ))
                      .toList(),
                  onChanged: _loading
                      ? null
                      : (d) {
                          if (d != null) _onDocumentSelected(d);
                        },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Course Version',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<CourseVersion>(
                  initialValue: _selectedVersion,
                  items: (_selectedDoc != null
                          ? _versionsByCourse[_selectedDoc!.id] ?? []
                          : <CourseVersion>[])
                      .map((v) => DropdownMenuItem(
                            value: v,
                            child: Text('${v.version} - ${v.status}'),
                          ))
                      .toList(),
                  onChanged: _loading
                      ? null
                      : (v) {
                          setState(() {
                            _selectedVersion = v;
                            _coverage = null;
                          });
                          if (v != null) _loadCoverage();
                        },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (_selectedVersion != null)
                  FilledButton(
                    onPressed: _loading ? null : _loadCoverage,
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Load Coverage'),
                  ),
              ],
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _error!,
                style: TextStyle(color: AppColors.destructive),
              ),
            ),
          Expanded(
            child: _coverage == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_turned_in, size: 64, color: AppColors.slate300),
                        const SizedBox(height: 16),
                        Text(
                          'Select SOP and version, then Load',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.slate600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'View qualified vs non-qualified users per SOP version',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.slate500,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : _buildCoverageContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageContent() {
    final qualified =
        (_coverage!['qualified'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
    final nonQualified =
        (_coverage!['nonQualified'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>() ??
            [];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.success, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Qualified (${qualified.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: qualified.length,
                    itemBuilder: (context, i) {
                      final q = qualified[i];
                      return ListTile(
                        leading: Icon(Icons.check_circle,
                            color: Colors.green.shade700),
                        title: Text(q['userName'] as String? ?? 'Unknown'),
                        subtitle: Text(
                          'Completed: ${q['completedAt'] ?? ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber, color: AppColors.warning, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Non-Qualified (${nonQualified.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: nonQualified.length,
                    itemBuilder: (context, i) {
                      final n = nonQualified[i];
                      return ListTile(
                        leading: Icon(Icons.warning_amber,
                            color: Colors.orange.shade700),
                        title: Text(n['userName'] as String? ?? 'Unknown'),
                        subtitle: Text(
                          'User ID: ${n['userId'] ?? ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
