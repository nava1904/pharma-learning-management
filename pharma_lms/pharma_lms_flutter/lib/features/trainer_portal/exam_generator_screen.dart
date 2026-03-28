// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EXAM GENERATOR (QUESTION PAPER + PDF)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/exam-generator
// Build an exam from question banks: add questions, organize by category, reorder,
// and generate a PDF question paper for verification and circulation.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/client.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

final _questionBanksProvider = FutureProvider<List<QuestionBank>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  return client.assessment.listQuestionBanks(organizationId: user?.organizationId);
});

final _questionsForBankProvider =
    FutureProvider.family<List<Question>, int>((ref, bankId) async {
  return client.assessment.getQuestions(bankId);
});

class ExamGeneratorScreen extends ConsumerStatefulWidget {
  const ExamGeneratorScreen({super.key});

  @override
  ConsumerState<ExamGeneratorScreen> createState() => _ExamGeneratorScreenState();
}

final _orgCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  return client.course.listCourses(organizationId: user?.organizationId);
});

class _ExamGeneratorScreenState extends ConsumerState<ExamGeneratorScreen> {
  final List<Question> _examQuestions = [];
  int? _selectedBankId;
  String _examTitle = 'Question Paper';
  String _instructions = 'Answer all questions.';
  int _passingScore = 80;

  // Save-to-server state
  Course? _selectedCourse;
  CourseVersion? _selectedCourseVersion;
  List<CourseVersion> _courseVersions = [];
  bool _loadingVersions = false;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final banksAsync = ref.watch(_questionBanksProvider);

    return banksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading question banks: $e')),
      data: (banks) => ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildQuestionBankPanel(banks),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: _buildExamPanel(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _loadCourseVersions(int courseId) async {
    setState(() => _loadingVersions = true);
    try {
      final versions = await client.course.getCourseVersions(courseId);
      if (mounted) {
        setState(() {
          _courseVersions = versions;
          _selectedCourseVersion = versions.isNotEmpty ? versions.first : null;
          _loadingVersions = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingVersions = false);
    }
  }

  Future<void> _saveExamToServer() async {
    if (_examQuestions.isEmpty) return;
    if (_selectedCourseVersion == null || _selectedBankId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a course version and question bank before saving')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await client.assessmentBuilder.createAssessment(
        courseVersionId: _selectedCourseVersion!.id!,
        questionBankId: _selectedBankId!,
        passingScore: _passingScore,
        randomize: true,
        questionsToDisplay: _examQuestions.length,
        showAnswers: false,
        showSubmissionHistory: false,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assessment saved to server. Submit for QA review to publish.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    }
    if (mounted) setState(() => _saving = false);
  }

  void _showPreviewDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Row(
          children: [
            const Icon(Icons.preview_rounded, size: 20),
            const SizedBox(width: 8),
            Text(_examTitle),
            const Spacer(),
            IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
          ],
        ),
        content: SizedBox(
          width: 600,
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${DateTime.now().toString().substring(0, 10)}', style: PharmaTypography.caption),
                const SizedBox(height: 8),
                Text(_instructions, style: PharmaTypography.body),
                const Divider(height: 24),
                ..._examQuestions.asMap().entries.map((entry) {
                  final i = entry.key + 1;
                  final q = entry.value;
                  List<String>? options;
                  try {
                    final list = jsonDecode(q.optionsJson) as List<dynamic>?;
                    options = list?.map((e) => e.toString()).toList();
                  } catch (_) {}
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$i. ${q.text}', style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                        if (options != null && options.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: options.asMap().entries.map((o) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text('${String.fromCharCode(65 + o.key)}. ${o.value}', style: PharmaTypography.body),
                              )).toList(),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton.icon(
            onPressed: () { Navigator.pop(ctx); _generatePdf(); },
            icon: const Icon(Icons.picture_as_pdf, size: 16),
            label: const Text('Save as PDF'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.quiz, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exam generator',
                style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text(
                'Build a question paper, preview, save to server, or export PDF',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: _examQuestions.isEmpty ? null : _showPreviewDialog,
          icon: const Icon(Icons.preview_rounded, size: 16),
          label: const Text('Preview'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _examQuestions.isEmpty ? null : _generatePdf,
          icon: const Icon(Icons.picture_as_pdf, size: 16),
          label: const Text('PDF'),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: (_examQuestions.isEmpty || _saving) ? null : _saveExamToServer,
          icon: _saving
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.cloud_upload_rounded, size: 16),
          label: const Text('Save Exam'),
          style: FilledButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: PharmaColors.cardBg,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionBankPanel(List<QuestionBank> banks) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question banks',
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: _selectedBankId,
            decoration: InputDecoration(
              hintText: 'Select a bank',
              border: OutlineInputBorder(
                borderRadius: PharmaRadius.inputRadius,
              ),
            ),
            items: banks
                .where((b) => b.id != null)
                .map((b) => DropdownMenuItem(
                      value: b.id,
                      child: Text(b.name ?? 'Bank #${b.id}'),
                    ))
                .toList(),
            onChanged: (id) => setState(() => _selectedBankId = id),
          ),
          const SizedBox(height: 16),
          if (_selectedBankId != null)
            _BankQuestionsLoader(
              bankId: _selectedBankId!,
              onAddAll: (questions) {
                setState(() {
                  for (final q in questions) {
                    if (!_examQuestions.any((e) => e.id == q.id)) {
                      _examQuestions.add(q);
                    }
                  }
                });
              },
              onAddSelected: (questions) {
                setState(() {
                  for (final q in questions) {
                    if (!_examQuestions.any((e) => e.id == q.id)) {
                      _examQuestions.add(q);
                    }
                  }
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildExamPanel() {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Exam questions (${_examQuestions.length})',
                style: PharmaTypography.headingSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (_examQuestions.isNotEmpty)
                TextButton.icon(
                  onPressed: () => setState(() => _examQuestions.clear()),
                  icon: const Icon(Icons.clear_all, size: 18),
                  label: const Text('Clear all'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (v) => setState(() => _examTitle = v.isNotEmpty ? v : 'Question Paper'),
            decoration: InputDecoration(
              labelText: 'Paper title',
              hintText: 'Question Paper',
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (v) => _instructions = v.isNotEmpty ? v : 'Answer all questions.',
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Instructions',
              hintText: 'Answer all questions.',
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
            ),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: Builder(builder: (context) {
                final coursesAsync = ref.watch(_orgCoursesProvider);
                final courses = coursesAsync.valueOrNull ?? [];
                return DropdownButtonFormField<Course>(
                  initialValue: _selectedCourse,
                  items: courses.map((c) => DropdownMenuItem(value: c, child: Text(c.title, overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (c) {
                    setState(() { _selectedCourse = c; _selectedCourseVersion = null; _courseVersions = []; });
                    if (c?.id != null) _loadCourseVersions(c!.id!);
                  },
                  decoration: InputDecoration(
                    labelText: 'Link to Course',
                    hintText: 'Select course',
                    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                  ),
                  isExpanded: true,
                );
              }),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 160,
              child: _loadingVersions
                  ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))
                  : DropdownButtonFormField<CourseVersion>(
                      initialValue: _selectedCourseVersion,
                      items: _courseVersions.map((v) => DropdownMenuItem(value: v, child: Text('v${v.version}'))).toList(),
                      onChanged: (v) => setState(() => _selectedCourseVersion = v),
                      decoration: InputDecoration(
                        labelText: 'Version',
                        border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextField(
                onChanged: (v) => _passingScore = int.tryParse(v) ?? 80,
                decoration: InputDecoration(
                  labelText: 'Pass %',
                  hintText: '80',
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ]),
          const SizedBox(height: 16),
          if (_examQuestions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.quiz_outlined, size: 48, color: PharmaColors.gray300),
                    const SizedBox(height: 8),
                    Text(
                      'No questions yet',
                      style: PharmaTypography.body
                          .copyWith(color: PharmaColors.textTertiary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select a question bank and add questions.',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary),
                    ),
                  ],
                ),
              ),
            )
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _examQuestions.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final q = _examQuestions.removeAt(oldIndex);
                  _examQuestions.insert(newIndex, q);
                });
              },
              itemBuilder: (context, index) {
                final q = _examQuestions[index];
                return Card(
                  key: ValueKey(q.id ?? index),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: Icon(Icons.drag_handle, color: PharmaColors.textTertiary),
                    ),
                    title: Text(
                      q.text,
                      style: PharmaTypography.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${q.questionType} · ${q.difficulty ?? "—"}',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline, color: PharmaColors.danger),
                      onPressed: () => setState(() => _examQuestions.removeAt(index)),
                      tooltip: 'Remove',
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _generatePdf() async {
    if (_examQuestions.isEmpty) return;
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (context) => [
            pw.Header(
              level: 0,
              child: pw.Text(
                _examTitle,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Date: ${DateTime.now().toString().substring(0, 10)}',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.SizedBox(height: 16),
            pw.Text(
              _instructions,
              style: const pw.TextStyle(fontSize: 11),
            ),
            pw.SizedBox(height: 24),
            ..._examQuestions.asMap().entries.map((entry) {
              final i = entry.key + 1;
              final q = entry.value;
              List<String>? options;
              try {
                final list = jsonDecode(q.optionsJson) as List<dynamic>?;
                options = list?.map((e) => e.toString()).toList();
              } catch (_) {}
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '$i. ${q.text}',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                    if (options != null && options.isNotEmpty)
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 16, top: 6),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: options
                              .asMap()
                              .entries
                              .map((o) => pw.Text(
                                    '  ${String.fromCharCode(65 + o.key)}. ${o.value}',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
      final bytes = await pdf.save();
      if (!context.mounted) return;
      final fileName =
          'question_paper_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final saved = await saveBytesToFile(bytes, fileName);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              saved
                  ? 'PDF saved as $fileName'
                  : 'PDF generated (${(bytes.length / 1024).toStringAsFixed(1)} KB). Use browser print to save.',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF generation failed: $e')),
        );
      }
    }
  }
}

class _BankQuestionsLoader extends ConsumerWidget {
  const _BankQuestionsLoader({
    required this.bankId,
    required this.onAddAll,
    required this.onAddSelected,
  });

  final int bankId;
  final void Function(List<Question>) onAddAll;
  final void Function(List<Question>) onAddSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsync = ref.watch(_questionsForBankProvider(bankId));

    return questionsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 8),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          'Failed to load: $e',
          style: PharmaTypography.caption.copyWith(color: PharmaColors.danger),
        ),
      ),
      data: (questions) {
        if (questions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'No questions in this bank',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${questions.length} questions',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => onAddAll(questions),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add all'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
              ),
            ),
          ],
        );
      },
    );
  }
}
