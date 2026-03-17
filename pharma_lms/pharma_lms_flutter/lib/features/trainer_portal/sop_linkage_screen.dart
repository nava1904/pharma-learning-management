// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — SOP LINKAGE (TRN-06)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/sop-links
// Link courses to SOPs. Linkage is via Course.sopNumber matching
// Document.documentNumber — displayed as read-only linkage info.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

final _courseProvider = FutureProvider.family<Course?, int>((ref, courseId) async {
  return client.course.getCourse(courseId);
});

final _courseVersionsProvider = FutureProvider.family<List<CourseVersion>, int>((ref, courseId) async {
  return client.course.getCourseVersions(courseId);
});

final _allDocumentsProvider = FutureProvider<List<Document>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  return client.document.listDocuments(organizationId: user?.organizationId);
});

final _linkedSopsProvider = FutureProvider.family<List<CourseSopLink>, int>((ref, courseId) async {
  return client.sopLinkage.getLinkedSops(courseId: courseId);
});

class SopLinkageScreen extends ConsumerStatefulWidget {
  const SopLinkageScreen({super.key, required this.courseId});

  final int courseId;

  @override
  ConsumerState<SopLinkageScreen> createState() => _SopLinkageScreenState();
}

class _SopLinkageScreenState extends ConsumerState<SopLinkageScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final courseAsync = ref.watch(_courseProvider(widget.courseId));
    final versionsAsync = ref.watch(_courseVersionsProvider(widget.courseId));
    final docsAsync = ref.watch(_allDocumentsProvider);
    final linkedSopsAsync = ref.watch(_linkedSopsProvider(widget.courseId));

    return courseAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading course: $e')),
      data: (course) {
        if (course == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
                const SizedBox(height: 12),
                Text('Course not found', style: PharmaTypography.headingSmall),
              ],
            ),
          );
        }

        return docsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading documents: $e')),
          data: (allDocs) {
            final links = linkedSopsAsync.valueOrNull ?? [];
            final linkedDocIds = links.map((l) => l.documentId).toSet();
            final linkedDocs = allDocs.where((d) => linkedDocIds.contains(d.id)).toList();

            final availableDocs = allDocs.where((d) {
              if (linkedDocIds.contains(d.id)) return false;
              if (_searchQuery.isEmpty) return true;
              final q = _searchQuery.toLowerCase();
              return d.title.toLowerCase().contains(q) ||
                  d.documentNumber.toLowerCase().contains(q);
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
              children: [
                _buildHeader(course),
                const SizedBox(height: PharmaSpacing.sectionGap),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(children: [
                        _buildCourseInfoCard(course),
                        const SizedBox(height: 20),
                        _buildLinkedSopsCard(linkedDocs, links),
                        const SizedBox(height: 20),
                        _buildAvailableSopsCard(availableDocs),
                      ]),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 300,
                      child: Column(children: [
                        _buildVersionsPanel(versionsAsync),
                        const SizedBox(height: 20),
                        _buildRetrainingRulesPanel(linkedDocs),
                      ]),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(Course course) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go('/trainer/courses/${widget.courseId}/builder'),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Icon(Icons.link, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SOP Linkage', style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Viewing SOP linkage for "${course.title}"',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        if (course.sopNumber != null && course.sopNumber!.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PharmaColors.emerald50,
              borderRadius: PharmaRadius.pillRadius,
              border: Border.all(color: PharmaColors.emerald600.withOpacity(0.3)),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.link, size: 14, color: PharmaColors.emerald600),
              const SizedBox(width: 6),
              Text(course.sopNumber!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: PharmaColors.emerald600, fontFamily: 'monospace')),
            ]),
          ),
      ],
    );
  }

  Widget _buildCourseInfoCard(Course course) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Course Details', style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
                const SizedBox(height: 12),
                _infoRow('Title', course.title),
                _infoRow('SOP Number', course.sopNumber ?? 'Not linked'),
                _infoRow('Status', course.status.toUpperCase()),
                if (course.description != null && course.description!.isNotEmpty)
                  _infoRow('Description', course.description!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value, style: PharmaTypography.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildLinkedSopsCard(List<Document> linkedDocs, List<CourseSopLink> links) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              Text('Linked SOPs', style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: PharmaRadius.pillRadius),
                child: Text('${linkedDocs.length}',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: PharmaColors.emerald600)),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => _showLinkSopDialog(),
                icon: const Icon(Icons.add_link, size: 16),
                label: const Text('Link SOP'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ]),
          ),
          if (linkedDocs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.link_off, size: 36, color: PharmaColors.gray300),
                    const SizedBox(height: 8),
                    Text(
                      'No SOPs linked to this course yet. Click "Link SOP" to add one.',
                      style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ...linkedDocs.map((doc) {
              final link = links.where((l) => l.documentId == doc.id).firstOrNull;
              return _buildLinkedSopRow(doc, link);
            }),
        ],
      ),
    );
  }

  Widget _buildLinkedSopRow(Document doc, CourseSopLink? link) {
    final isTrainingRequired = doc.trainingRequiredByQa == 'training_required';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined, size: 20, color: PharmaColors.emerald600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(doc.documentNumber,
                      style: PharmaTypography.bodyMedium.copyWith(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  if (isTrainingRequired)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: PharmaColors.dangerBg, borderRadius: PharmaRadius.pillRadius),
                      child: Text('TRAINING REQUIRED',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: PharmaColors.danger, letterSpacing: 0.5)),
                    ),
                ]),
                const SizedBox(height: 2),
                Text(doc.title, style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: PharmaRadius.pillRadius),
            child: Text(doc.documentType.toUpperCase(),
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _showDocumentDetail(doc),
            icon: Icon(Icons.visibility_outlined, size: 18, color: PharmaColors.textTertiary),
            tooltip: 'View Document',
          ),
          if (link != null)
            IconButton(
              onPressed: () => _confirmUnlink(link),
              icon: Icon(Icons.link_off, size: 18, color: PharmaColors.danger),
              tooltip: 'Unlink SOP',
            ),
        ],
      ),
    );
  }

  Widget _buildAvailableSopsCard(List<Document> availableDocs) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('All SOP Documents', style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: PharmaRadius.pillRadius),
                    child: Text('${availableDocs.length}',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: PharmaColors.textSecondary)),
                  ),
                ]),
                const SizedBox(height: 12),
                TextField(
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
              ],
            ),
          ),
          if (availableDocs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text('No documents match your search.',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
              ),
            )
          else
            ...availableDocs.map((doc) => _buildAvailableSopRow(doc)),
        ],
      ),
    );
  }

  Widget _buildAvailableSopRow(Document doc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined, size: 20, color: PharmaColors.gray400),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc.documentNumber, style: PharmaTypography.bodyMedium.copyWith(fontFamily: 'monospace')),
                Text(doc.title, style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: PharmaRadius.pillRadius),
            child: Text(doc.documentType, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
          if (doc.trainingRequiredByQa == 'training_required')
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: PharmaColors.warningBg, borderRadius: PharmaRadius.pillRadius),
                child: Text('QA: Training Req.',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: PharmaColors.warningText)),
              ),
            ),
          IconButton(
            onPressed: () => _showDocumentDetail(doc),
            icon: Icon(Icons.visibility_outlined, size: 18, color: PharmaColors.textTertiary),
            tooltip: 'View Details',
          ),
        ],
      ),
    );
  }

  Widget _buildVersionsPanel(AsyncValue<List<CourseVersion>> versionsAsync) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Versions', style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 12),
          versionsAsync.when(
            loading: () => const Center(child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(strokeWidth: 2),
            )),
            error: (e, _) => Text('Error: $e', style: PharmaTypography.caption.copyWith(color: PharmaColors.danger)),
            data: (versions) {
              if (versions.isEmpty) {
                return Text('No versions found.', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary));
              }
              return Column(
                children: versions.map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: v.status == 'effective' ? PharmaColors.emerald50 : PharmaColors.gray100,
                          borderRadius: PharmaRadius.pillRadius,
                        ),
                        child: Text('v${v.version}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                              color: v.status == 'effective' ? PharmaColors.emerald600 : PharmaColors.textSecondary,
                            )),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(v.status.toUpperCase(),
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: PharmaColors.textTertiary)),
                      ),
                      if (v.effectiveDate != null)
                        Text(_formatDate(v.effectiveDate!),
                            style: TextStyle(fontSize: 10, color: PharmaColors.textTertiary)),
                    ],
                  ),
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRetrainingRulesPanel(List<Document> linkedDocs) {
    final trainingRequired = linkedDocs.where((d) => d.trainingRequiredByQa == 'training_required').length;
    final noTraining = linkedDocs.where((d) => d.trainingRequiredByQa != 'training_required').length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Retraining Rules', style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 16),
          _ruleItem(Icons.warning_amber, PharmaColors.danger, 'Training Required',
              'Retraining triggered when linked SOP is revised (QA gate: training_required).'),
          _ruleItem(Icons.info_outline, PharmaColors.warningText, 'SOP Linkage',
              'Course.sopNumber must match Document.documentNumber to establish linkage.'),
          _ruleItem(Icons.notifications_active, PharmaColors.emerald600, 'Auto-notification',
              'Employees are notified automatically when linked SOP is revised.'),
          _ruleItem(Icons.history, PharmaColors.textTertiary, 'Audit Trail',
              'All linkage changes are recorded in the permanent audit trail.'),
          const SizedBox(height: 20),
          Text('Linkage Summary', style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 12),
          _certRow('Training Required', trainingRequired, PharmaColors.danger),
          _certRow('No Training Required', noTraining, PharmaColors.emerald600),
        ],
      ),
    );
  }

  Widget _ruleItem(IconData icon, Color color, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(desc, style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, height: 1.4)),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _certRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: PharmaTypography.bodyMedium),
        const Spacer(),
        Text('$count', style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
      ]),
    );
  }

  Future<void> _showLinkSopDialog() async {
    final allDocs = ref.read(_allDocumentsProvider).valueOrNull ?? [];
    final links = ref.read(_linkedSopsProvider(widget.courseId)).valueOrNull ?? [];
    final linkedDocIds = links.map((l) => l.documentId).toSet();
    final unlinkedDocs = allDocs.where((d) => !linkedDocIds.contains(d.id)).toList();

    if (!mounted) return;
    final selectedDoc = await showDialog<Document>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select SOP to Link'),
        children: unlinkedDocs.isEmpty
            ? [const Padding(padding: EdgeInsets.all(16), child: Text('No unlinked documents available.'))]
            : unlinkedDocs.map((d) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, d),
                child: Text('${d.documentNumber} — ${d.title}'),
              )).toList(),
      ),
    );

    if (selectedDoc != null && mounted) {
      try {
        final user = await ref.read(currentUserProvider.future);
        await client.sopLinkage.linkSopToCourse(
          courseId: widget.courseId,
          documentId: selectedDoc.id!,
          linkedById: user?.id,
        );
        ref.invalidate(_linkedSopsProvider(widget.courseId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Linked "${selectedDoc.documentNumber}" to this course')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to link: $e')),
          );
        }
      }
    }
  }

  Future<void> _confirmUnlink(CourseSopLink link) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Unlink SOP?'),
        content: Text('Remove the link between this course and document #${link.documentId}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Unlink'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await client.sopLinkage.unlinkSopFromCourse(linkId: link.id!);
        ref.invalidate(_linkedSopsProvider(widget.courseId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SOP unlinked successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to unlink: $e')),
          );
        }
      }
    }
  }

  void _showDocumentDetail(Document doc) async {
    List<DocumentVersion>? versions;
    try {
      versions = await client.document.getDocumentVersions(doc.id!);
    } catch (_) {
      versions = [];
    }

    if (!mounted) return;

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
              Text(doc.title, style: PharmaTypography.bodyMedium),
              const SizedBox(height: 12),
              _dialogInfoRow('Type', doc.documentType),
              _dialogInfoRow('Document #', doc.documentNumber),
              _dialogInfoRow('QA Training', doc.trainingRequiredByQa ?? 'Not classified'),
              const Divider(height: 24),
              Text('Versions (${versions?.length ?? 0})',
                  style: PharmaTypography.headingSmall.copyWith(fontSize: 13)),
              const SizedBox(height: 8),
              if (versions != null && versions.isNotEmpty)
                ...versions.map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: PharmaRadius.pillRadius),
                      child: Text('v${v.version}',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                    ),
                    const SizedBox(width: 8),
                    if (v.isMajorVersion == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: PharmaColors.warningBg, borderRadius: PharmaRadius.pillRadius),
                        child: Text('MAJOR', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: PharmaColors.warningText)),
                      ),
                    const Spacer(),
                    if (v.effectiveDate != null)
                      Text('Effective: ${_formatDate(v.effectiveDate!)}',
                          style: TextStyle(fontSize: 10, color: PharmaColors.textTertiary)),
                  ]),
                ))
              else
                Text('No versions recorded.', style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _dialogInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        SizedBox(width: 110, child: Text(label,
            style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontWeight: FontWeight.w600))),
        Expanded(child: Text(value, style: PharmaTypography.bodyMedium)),
      ]),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
