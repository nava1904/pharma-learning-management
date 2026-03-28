import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show QuestionBank, Question, Assessment, AssessmentAttempt;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// QUESTION BANK SCREEN - Real data from backend
// ═══════════════════════════════════════════════════════════════════════════════

class AdminQuestionBankScreen extends ConsumerStatefulWidget {
  const AdminQuestionBankScreen({super.key});

  @override
  ConsumerState<AdminQuestionBankScreen> createState() => _AdminQuestionBankScreenState();
}

class _AdminQuestionBankScreenState extends ConsumerState<AdminQuestionBankScreen> {
  int? _expandedBankId;

  @override
  Widget build(BuildContext context) {
    final questionBanksAsync = ref.watch(adminQuestionBanksProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(context),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Question Banks Grid
          questionBanksAsync.when(
            data: (banks) => _buildQuestionBanksGrid(banks),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question Bank', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Manage centralized assessment questions and tags',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => _showCreateBankDialog(context),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Bank'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionBanksGrid(List<QuestionBank> banks) {
    if (banks.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.quiz_outlined, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No question banks found',
                style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textTertiary),
              ),
              SizedBox(height: PharmaSpacing.md),
              ElevatedButton.icon(
                onPressed: () => _showCreateBankDialog(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create First Bank'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: banks.map((bank) => _buildQuestionBankCard(bank)).toList(),
    );
  }

  Widget _buildQuestionBankCard(QuestionBank bank) {
    final isExpanded = _expandedBankId == bank.id;
    
    return Container(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: isExpanded ? PharmaColors.emerald500 : PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        children: [
          // Bank Header
          InkWell(
            onTap: () => setState(() {
              _expandedBankId = isExpanded ? null : bank.id;
            }),
            borderRadius: BorderRadius.circular(PharmaRadius.md),
            child: Padding(
              padding: EdgeInsets.all(PharmaSpacing.cardPadding),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald50,
                      borderRadius: BorderRadius.circular(PharmaRadius.sm),
                    ),
                    child: Icon(Icons.quiz_outlined, color: PharmaColors.emerald600, size: 24),
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bank.name, style: PharmaTypography.headingSmall),
                        SizedBox(height: PharmaSpacing.xs),
                        Row(
                          children: [
                            _buildTagChip('Organization #${bank.organizationId}'),
                            if (bank.tagsJson != null) ...[
                              SizedBox(width: PharmaSpacing.sm),
                              _buildTagChip(bank.tagsJson!),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: PharmaColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
          
          // Expanded Questions List
          if (isExpanded && bank.id != null)
            _buildQuestionsSection(bank.id!),
        ],
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: PharmaColors.gray100,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(tag, style: PharmaTypography.caption),
    );
  }

  Widget _buildQuestionsSection(int bankId) {
    final questionsAsync = ref.watch(adminQuestionsProvider(bankId));
    
    return questionsAsync.when(
      data: (questions) => _buildQuestionsList(questions, bankId),
      loading: () => Padding(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => Padding(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Text('Error loading questions: $e'),
      ),
    );
  }

  Widget _buildQuestionsList(List<Question> questions, int bankId) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.gray50,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(PharmaRadius.md)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${questions.length} Questions',
                style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showImportQuestionsDialog(bankId),
                    icon: const Icon(Icons.upload_file, size: 16),
                    label: const Text('Import'),
                  ),
                  SizedBox(width: PharmaSpacing.sm),
                  ElevatedButton.icon(
                    onPressed: () => _showAddQuestionDialog(bankId),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PharmaColors.emerald600,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          if (questions.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(PharmaSpacing.lg),
                child: Text(
                  'No questions in this bank yet',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                ),
              ),
            )
          else
            ...questions.take(10).map((q) => _buildQuestionRow(q)),
          if (questions.length > 10)
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to full questions view
                },
                child: Text('View all ${questions.length} questions'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(Question question) {
    final qType = question.questionType;
    
    return Container(
      margin: EdgeInsets.only(bottom: PharmaSpacing.sm),
      padding: EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _getQuestionTypeColor(qType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(
              _getQuestionTypeIcon(qType),
              size: 16,
              color: _getQuestionTypeColor(qType),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.text,
                  style: PharmaTypography.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: PharmaSpacing.xs),
                Row(
                  children: [
                    _buildTagChip(qType.toUpperCase()),
                    if (question.difficulty != null) ...[
                      SizedBox(width: PharmaSpacing.sm),
                      _buildTagChip(question.difficulty!),
                    ],
                    if (question.regulatoryTag != null) ...[
                      SizedBox(width: PharmaSpacing.sm),
                      _buildTagChip(question.regulatoryTag!),
                    ],
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18),
            onPressed: () {},
            tooltip: 'Edit Question',
          ),
        ],
      ),
    );
  }

  IconData _getQuestionTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'mcq':
      case 'multiple_choice':
        return Icons.radio_button_checked;
      case 'true_false':
        return Icons.check_box;
      case 'fill_blank':
        return Icons.text_fields;
      case 'essay':
        return Icons.notes;
      default:
        return Icons.help_outline;
    }
  }

  Color _getQuestionTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'mcq':
      case 'multiple_choice':
        return PharmaColors.info;
      case 'true_false':
        return PharmaColors.success;
      case 'fill_blank':
        return PharmaColors.warning;
      case 'essay':
        return PharmaColors.purple;
      default:
        return PharmaColors.textTertiary;
    }
  }

  void _showCreateBankDialog(BuildContext context) {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Question Bank'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Bank Name',
            hintText: 'e.g., GMP Fundamentals Questions',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final me = await ref.read(currentUserProvider.future);
                if (me?.id == null) throw Exception('Not authenticated');
                await client.assessment.createQuestionBank(
                  name: nameController.text.trim(),
                  organizationId: me!.organizationId,
                );
                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Question bank created')),
                );
                ref.invalidate(adminQuestionBanksProvider);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create failed: $e')),
                );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showImportQuestionsDialog(int bankId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Questions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Import questions from CSV or JSON file'),
            SizedBox(height: PharmaSpacing.md),
            OutlinedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                final res = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: const ['json', 'csv'],
                  withData: true,
                );
                if (res == null || res.files.isEmpty) return;
                final file = res.files.first;
                final bytes = file.bytes;
                if (bytes == null) return;

                try {
                  final questions = _parseImportFile(file.name, bytes);
                  await client.assessment.importQuestionsToBank(
                    targetBankId: bankId,
                    questions: questions,
                  );
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Imported ${questions.length} questions')),
                  );
                  ref.invalidate(adminQuestionsProvider(bankId));
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Import failed: $e')),
                  );
                }
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Select File'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAddQuestionDialog(int bankId) {
    final text = TextEditingController();
    final type = TextEditingController(text: 'multiple_choice');
    final optionsJson = TextEditingController(text: '["A","B","C","D"]');
    final correct = TextEditingController(text: 'A');
    final difficulty = TextEditingController(text: 'easy');
    final regulatoryTag = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Question'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: text,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Question text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: type,
                decoration: const InputDecoration(
                  labelText: 'Question type (e.g. multiple_choice, true_false)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: optionsJson,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Options JSON (for MCQ)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: correct,
                decoration: const InputDecoration(
                  labelText: 'Correct answer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: difficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficulty (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: regulatoryTag,
                decoration: const InputDecoration(
                  labelText: 'Regulatory tag (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await client.assessmentBuilder.createQuestion(
                  questionBankId: bankId,
                  text: text.text,
                  questionType: type.text,
                  optionsJson: optionsJson.text,
                  correctAnswer: correct.text,
                  difficulty: difficulty.text.trim().isEmpty ? null : difficulty.text.trim(),
                  regulatoryTag: regulatoryTag.text.trim().isEmpty ? null : regulatoryTag.text.trim(),
                );
                if (!mounted) return;
                Navigator.pop(context);
                ref.invalidate(adminQuestionsProvider(bankId));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Question added')),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add failed: $e')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _parseImportFile(String name, Uint8List bytes) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.json')) {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! List) throw Exception('JSON must be an array of question objects');
      return decoded.cast<Map>().map((m) => Map<String, dynamic>.from(m)).toList();
    }

    // CSV: text,questionType,optionsJson,correctAnswer,difficulty,regulatoryTag
    final csv = utf8.decode(bytes);
    final lines = csv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isEmpty) return [];
    final headers = lines.first.split(',').map((s) => s.trim()).toList();
    final idx = <String, int>{};
    for (var i = 0; i < headers.length; i++) {
      idx[headers[i]] = i;
    }
    int col(String k) => idx[k] ?? -1;

    final out = <Map<String, dynamic>>[];
    for (var i = 1; i < lines.length; i++) {
      final cols = lines[i].split(',').map((s) => s.trim().replaceAll('"', '')).toList();
      String v(String k) {
        final c = col(k);
        if (c < 0 || c >= cols.length) return '';
        return cols[c];
      }

      out.add({
        'text': v('text'),
        'questionType': v('questionType'),
        'optionsJson': v('optionsJson'),
        'correctAnswer': v('correctAnswer'),
        'difficulty': v('difficulty'),
        'regulatoryTag': v('regulatoryTag'),
      });
    }
    return out;
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Failed to load question banks', style: PharmaTypography.bodyMedium),
            Text(error, style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton(
              onPressed: () => ref.invalidate(adminQuestionBanksProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ASSESSMENT LIST SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAssessmentListScreen extends StatelessWidget {
  const AdminAssessmentListScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AdminAssessmentListBody();
}

class _AdminAssessmentListBody extends ConsumerWidget {
  const _AdminAssessmentListBody();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meAsync = ref.watch(currentUserProvider);
    return meAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (me) {
        if (me == null) return const Center(child: Text('Not authenticated'));
        final assessmentsAsync = ref.watch(adminAssessmentsProvider(me.organizationId));
        return AdminPageFrame(
          title: 'Assessments',
          subtitle: 'Track assessment configurations.',
          children: [
            AdminSectionCard(
              title: 'Assessments',
              child: assessmentsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Failed to load assessments: $e'),
                data: (assessments) {
                  if (assessments.isEmpty) return const Text('No assessments found.');
                  return Column(
                    children: assessments.map((a) {
                      return ListTile(
                        title: Text('Assessment #${a.id ?? '-'}'),
                        subtitle: Text('courseVersionId=${a.courseVersionId} • bankId=${a.questionBankId} • passing=${a.passingScore}%'),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE ASSESSMENT SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAssessmentCreateScreen extends StatelessWidget {
  const AdminAssessmentCreateScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AdminAssessmentCreateBody();
}

class _AdminAssessmentCreateBody extends ConsumerStatefulWidget {
  const _AdminAssessmentCreateBody();

  @override
  ConsumerState<_AdminAssessmentCreateBody> createState() => _AdminAssessmentCreateBodyState();
}

class _AdminAssessmentCreateBodyState extends ConsumerState<_AdminAssessmentCreateBody> {
  final _courseVersionId = TextEditingController();
  final _passingScore = TextEditingController(text: '80');
  int? _questionBankId;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final meAsync = ref.watch(currentUserProvider);
    final banksAsync = ref.watch(adminQuestionBanksProvider);

    return meAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (me) {
        if (me == null) return const Center(child: Text('Not authenticated'));
        return AdminPageFrame(
          title: 'Create Assessment',
          subtitle: 'Create an assessment for a course version.',
          children: [
            AdminSectionCard(
              title: 'Assessment',
              child: Column(
                children: [
                  TextField(
                    controller: _courseVersionId,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Course Version ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  banksAsync.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (e, _) => Text('Failed to load banks: $e'),
                    data: (banks) {
                      return DropdownButtonFormField<int>(
                        initialValue: _questionBankId,
                        decoration: const InputDecoration(
                          labelText: 'Question Bank',
                          border: OutlineInputBorder(),
                        ),
                        items: banks
                            .where((b) => b.id != null)
                            .map((b) => DropdownMenuItem(value: b.id!, child: Text(b.name)))
                            .toList(),
                        onChanged: _saving ? null : (v) => setState(() => _questionBankId = v),
                      );
                    },
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  TextField(
                    controller: _passingScore,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Passing Score (%)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _saving
                          ? null
                          : () async {
                              setState(() => _saving = true);
                              try {
                                final cvId = int.tryParse(_courseVersionId.text.trim());
                                final pass = int.tryParse(_passingScore.text.trim());
                                final bankId = _questionBankId;
                                if (cvId == null || cvId <= 0) throw Exception('Invalid courseVersionId');
                                if (bankId == null) throw Exception('Select a question bank');
                                if (pass == null || pass < 10 || pass > 100) throw Exception('Invalid passing score');

                                await client.assessmentBuilder.createAssessment(
                                  courseVersionId: cvId,
                                  questionBankId: bankId,
                                  passingScore: pass,
                                  randomize: true,
                                  showAnswers: false,
                                  showSubmissionHistory: false,
                                );
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Assessment created')),
                                );
                                ref.invalidate(adminAssessmentsProvider(me.organizationId));
                              } catch (e) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Create failed: $e')),
                                );
                              } finally {
                                if (mounted) setState(() => _saving = false);
                              }
                            },
                      child: Text(_saving ? 'Creating...' : 'Create'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ATTEMPT REVIEW SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAttemptReviewScreen extends StatelessWidget {
  const AdminAttemptReviewScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AdminAttemptReviewBody();
}

class _AdminAttemptReviewBody extends ConsumerStatefulWidget {
  const _AdminAttemptReviewBody();

  @override
  ConsumerState<_AdminAttemptReviewBody> createState() => _AdminAttemptReviewBodyState();
}

class _AdminAttemptReviewBodyState extends ConsumerState<_AdminAttemptReviewBody> {
  final _assessmentId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final assessmentId = int.tryParse(_assessmentId.text.trim());
    final attemptsAsync = assessmentId == null ? null : ref.watch(adminAssessmentAttemptsProvider(assessmentId));

    return AdminPageFrame(
      title: 'Attempt Review',
      subtitle: 'Review learner attempts.',
      children: [
        AdminSectionCard(
          title: 'Filter',
          child: TextField(
            controller: _assessmentId,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Assessment ID',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        if (attemptsAsync != null)
          AdminSectionCard(
            title: 'Attempts',
            child: attemptsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Failed to load attempts: $e'),
              data: (attempts) {
                if (attempts.isEmpty) return const Text('No attempts found.');
                return Column(
                  children: attempts.map((a) {
                    return ListTile(
                      title: Text('Attempt #${a.id ?? '-'}'),
                      subtitle: Text(
                        'userId=${a.userId} • completed=${a.completedAt != null} • score=${a.score ?? '—'}',
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
      ],
    );
  }
}
