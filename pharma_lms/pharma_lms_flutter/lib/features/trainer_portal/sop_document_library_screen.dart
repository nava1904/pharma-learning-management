// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — SOP DOCUMENT LIBRARY (TRN-11)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/sop-documents
// Browse/search/filter all SOP documents from the backend.
// Track revisions, QA classification, document type.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

final _documentsProvider = FutureProvider<List<Document>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  return client.document.listDocuments(organizationId: user?.organizationId);
});

class SopDocumentLibraryScreen extends ConsumerStatefulWidget {
  const SopDocumentLibraryScreen({super.key});

  @override
  ConsumerState<SopDocumentLibraryScreen> createState() => _SopDocumentLibraryScreenState();
}

class _SopDocumentLibraryScreenState extends ConsumerState<SopDocumentLibraryScreen> {
  String _searchQuery = '';
  String _filterType = 'All';
  String _filterQaStatus = 'All';

  final Map<int, List<DocumentVersion>> _versionCache = {};
  final Map<int, List<CourseSopLink>> _linkedCoursesCache = {};

  List<Document> _applyFilters(List<Document> docs) {
    return docs.where((d) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!d.title.toLowerCase().contains(q) && !d.documentNumber.toLowerCase().contains(q)) return false;
      }
      if (_filterType != 'All' && d.documentType != _filterType) return false;
      if (_filterQaStatus != 'All') {
        final qa = d.trainingRequiredByQa ?? 'unclassified';
        if (_filterQaStatus == 'Training Required' && qa != 'training_required') return false;
        if (_filterQaStatus == 'No Training' && qa != 'no_training_required') return false;
        if (_filterQaStatus == 'Unclassified' && qa != 'unclassified' && d.trainingRequiredByQa != null) return false;
      }
      return true;
    }).toList();
  }

  List<String> _getDocumentTypes(List<Document> docs) {
    return docs.map((d) => d.documentType).toSet().toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    final docsAsync = ref.watch(_documentsProvider);

    return docsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading documents: $e')),
      data: (allDocs) {
        final filtered = _applyFilters(allDocs);
        final docTypes = _getDocumentTypes(allDocs);

        return ListView(
          padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
          children: [
            _buildHeader(allDocs),
            const SizedBox(height: 20),
            _buildStatsRow(allDocs),
            const SizedBox(height: 16),
            _buildFilters(docTypes),
            const SizedBox(height: 16),
            _buildTable(filtered),
          ],
        );
      },
    );
  }

  Widget _buildHeader(List<Document> allDocs) {
    return Row(children: [
      Icon(Icons.policy_outlined, color: PharmaColors.emerald600, size: 24),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SOP Document Library',
                style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
            Text('${allDocs.length} documents managed by your organization',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
          ],
        ),
      ),
      IconButton(
        onPressed: () => ref.invalidate(_documentsProvider),
        icon: const Icon(Icons.refresh, size: 20),
        tooltip: 'Refresh',
      ),
    ]);
  }

  Widget _buildStatsRow(List<Document> docs) {
    final sopCount = docs.where((d) => d.documentType == 'sop').length;
    final policyCount = docs.where((d) => d.documentType == 'policy').length;
    final guidelineCount = docs.where((d) => d.documentType == 'guideline').length;
    final trainingReqCount = docs.where((d) => d.trainingRequiredByQa == 'training_required').length;

    return Row(
      children: [
        _miniStat('Total', '${docs.length}', Icons.folder_outlined, PharmaColors.emerald600),
        _miniStat('SOPs', '$sopCount', Icons.description_outlined, PharmaColors.emerald600),
        _miniStat('Policies', '$policyCount', Icons.policy_outlined, PharmaColors.warningText),
        _miniStat('Guidelines', '$guidelineCount', Icons.menu_book_outlined, PharmaColors.textTertiary),
        _miniStat('Training Req.', '$trainingReqCount', Icons.school_outlined, PharmaColors.danger),
      ].map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: w))).toList(),
    );
  }

  Widget _miniStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
          Text(label, style: TextStyle(fontSize: 10, color: PharmaColors.textTertiary)),
        ]),
      ]),
    );
  }

  Widget _buildFilters(List<String> docTypes) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Search by document number or title…',
              prefixIcon: const Icon(Icons.search, size: 18),
              filled: true,
              fillColor: PharmaColors.pageBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _dropdown('Type', _filterType, ['All', ...docTypes], (v) => setState(() => _filterType = v)),
        const SizedBox(width: 8),
        _dropdown('QA Status', _filterQaStatus,
            ['All', 'Training Required', 'No Training', 'Unclassified'],
            (v) => setState(() => _filterQaStatus = v)),
      ]),
    );
  }

  Widget _buildTable(List<Document> filtered) {
    if (filtered.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
        ),
        child: Center(
          child: Column(children: [
            Icon(Icons.policy_outlined, size: 48, color: PharmaColors.gray300),
            const SizedBox(height: 8),
            Text('No documents match your filters', style: PharmaTypography.bodyMedium),
          ]),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: DataTable(
        headingRowHeight: 44,
        dataRowMinHeight: 52,
        dataRowMaxHeight: 60,
        columnSpacing: 20,
        headingTextStyle: PharmaTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: PharmaColors.textTertiary,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
        columns: const [
          DataColumn(label: Text('DOCUMENT #')),
          DataColumn(label: Text('TITLE')),
          DataColumn(label: Text('TYPE')),
          DataColumn(label: Text('QA STATUS')),
          DataColumn(label: Text('LINKED COURSES')),
          DataColumn(label: Text('ACTIONS')),
        ],
        rows: filtered.map((doc) => DataRow(cells: [
          DataCell(Text(doc.documentNumber,
              style: PharmaTypography.bodyMedium.copyWith(fontFamily: 'monospace', fontWeight: FontWeight.w600))),
          DataCell(
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(doc.title, style: PharmaTypography.body, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
          DataCell(Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: PharmaRadius.pillRadius),
            child: Text(doc.documentType.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
          )),
          DataCell(_QaStatusChip(qaStatus: doc.trainingRequiredByQa)),
          DataCell(
            _LinkedCoursesChips(
              documentId: doc.id!,
              cache: _linkedCoursesCache,
            ),
          ),
          DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              onPressed: () => _linkToCourse(context, doc.id!),
              icon: Icon(Icons.link, size: 18, color: PharmaColors.emerald600),
              tooltip: 'Link to Course',
            ),
            IconButton(
              onPressed: () => _showDocumentVersions(doc),
              icon: const Icon(Icons.history, size: 18),
              tooltip: 'View Versions',
            ),
            IconButton(
              onPressed: () => _showDocumentDetail(doc),
              icon: const Icon(Icons.visibility_outlined, size: 18),
              tooltip: 'View Details',
            ),
          ])),
        ])).toList(),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: PharmaColors.borderLight), borderRadius: PharmaRadius.inputRadius),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox.shrink(),
        isDense: true,
        style: PharmaTypography.caption.copyWith(color: PharmaColors.textPrimary),
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  void _showDocumentDetail(Document doc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Text(doc.documentNumber),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doc.title, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              _dialogRow('Document #', doc.documentNumber),
              _dialogRow('Type', doc.documentType),
              _dialogRow('QA Training', doc.trainingRequiredByQa ?? 'Unclassified'),
              _dialogRow('Organization ID', '${doc.organizationId}'),
              if (doc.affectedDepartmentIdsJson != null)
                _dialogRow('Affected Depts', doc.affectedDepartmentIdsJson!),
              if (doc.affectedRoleIdsJson != null)
                _dialogRow('Affected Roles', doc.affectedRoleIdsJson!),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showDocumentVersions(Document doc) async {
    List<DocumentVersion> versions;

    if (_versionCache.containsKey(doc.id)) {
      versions = _versionCache[doc.id]!;
    } else {
      try {
        versions = await client.document.getDocumentVersions(doc.id!);
        _versionCache[doc.id!] = versions;
      } catch (_) {
        versions = [];
      }
    }

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Row(children: [
          const Icon(Icons.history, size: 20),
          const SizedBox(width: 8),
          Text('Versions — ${doc.documentNumber}'),
        ]),
        content: SizedBox(
          width: 480,
          child: versions.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text('No versions recorded for this document.',
                        style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: versions.map((v) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PharmaColors.pageBg,
                      borderRadius: PharmaRadius.cardRadius,
                      border: Border.all(color: PharmaColors.borderLight),
                    ),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PharmaColors.emerald50,
                          borderRadius: PharmaRadius.pillRadius,
                        ),
                        child: Text('v${v.version}',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                                fontFamily: 'monospace', color: PharmaColors.emerald600)),
                      ),
                      const SizedBox(width: 10),
                      if (v.isMajorVersion == true)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(color: PharmaColors.dangerBg, borderRadius: PharmaRadius.pillRadius),
                          child: Text('MAJOR',
                              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: PharmaColors.danger)),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (v.effectiveDate != null)
                              Text('Effective: ${_formatDate(v.effectiveDate!)}',
                                  style: TextStyle(fontSize: 11, color: PharmaColors.textSecondary)),
                            if (v.obsoleteDate != null)
                              Text('Obsolete: ${_formatDate(v.obsoleteDate!)}',
                                  style: TextStyle(fontSize: 11, color: PharmaColors.danger)),
                          ],
                        ),
                      ),
                    ]),
                  )).toList(),
                ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _dialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label,
              style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontWeight: FontWeight.w600))),
          Expanded(child: Text(value, style: PharmaTypography.bodyMedium)),
        ],
      ),
    );
  }

  Future<void> _linkToCourse(BuildContext context, int documentId) async {
    final courses = await client.course.listCourses();
    if (!context.mounted) return;
    final selectedCourse = await showDialog<Course>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select Course to Link'),
        children: courses.map((c) => SimpleDialogOption(
          onPressed: () => Navigator.pop(ctx, c),
          child: Text(c.title),
        )).toList(),
      ),
    );
    if (selectedCourse != null) {
      try {
        final user = await ref.read(currentUserProvider.future);
        await client.sopLinkage.linkSopToCourse(
          courseId: selectedCourse.id!,
          documentId: documentId,
          linkedById: user?.id,
        );
        _linkedCoursesCache.remove(documentId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Linked to ${selectedCourse.title}')),
          );
          setState(() {});
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $e')),
          );
        }
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _LinkedCoursesChips extends StatefulWidget {
  const _LinkedCoursesChips({required this.documentId, required this.cache});
  final int documentId;
  final Map<int, List<CourseSopLink>> cache;

  @override
  State<_LinkedCoursesChips> createState() => _LinkedCoursesChipsState();
}

class _LinkedCoursesChipsState extends State<_LinkedCoursesChips> {
  late Future<List<CourseSopLink>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<CourseSopLink>> _load() async {
    if (widget.cache.containsKey(widget.documentId)) {
      return widget.cache[widget.documentId]!;
    }
    try {
      final links = await client.sopLinkage.getCoursesForSop(documentId: widget.documentId);
      widget.cache[widget.documentId] = links;
      return links;
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CourseSopLink>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 1.5));
        }
        final links = snapshot.data ?? [];
        if (links.isEmpty) {
          return Text('—', style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary));
        }
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: links.map((link) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: PharmaColors.emerald50,
                borderRadius: PharmaRadius.pillRadius,
              ),
              child: Text(
                link.course?.title ?? 'Course #${link.courseId}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: PharmaColors.emerald600),
              ),
            )).toList(),
          ),
        );
      },
    );
  }
}

class _QaStatusChip extends StatelessWidget {
  const _QaStatusChip({required this.qaStatus});
  final String? qaStatus;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    String label;
    switch (qaStatus) {
      case 'training_required':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.danger;
        label = 'TRAINING REQUIRED';
        break;
      case 'no_training_required':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'NO TRAINING';
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = 'UNCLASSIFIED';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg, letterSpacing: 0.3)),
    );
  }
}
