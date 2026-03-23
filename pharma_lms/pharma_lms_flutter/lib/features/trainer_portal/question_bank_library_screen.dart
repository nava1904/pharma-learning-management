// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — QUESTION BANK LIBRARY (TRN-12)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/question-bank
// Global question bank: lists QuestionBanks from backend, expandable to show
// individual Questions. Filters by difficulty, type, regulatory tag.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

final _questionBanksProvider = FutureProvider<List<QuestionBank>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  return client.assessment.listQuestionBanks(organizationId: user?.organizationId);
});

final _questionsProvider = FutureProvider.family<List<Question>, int>((ref, bankId) async {
  return client.assessment.getQuestions(bankId);
});

class QuestionBankLibraryScreen extends ConsumerStatefulWidget {
  const QuestionBankLibraryScreen({super.key});

  @override
  ConsumerState<QuestionBankLibraryScreen> createState() => _QuestionBankLibraryScreenState();
}

class _QuestionBankLibraryScreenState extends ConsumerState<QuestionBankLibraryScreen> {
  String _searchQuery = '';
  String _filterDifficulty = 'All';
  String _filterType = 'All';
  final Set<int> _expandedBanks = {};

  @override
  Widget build(BuildContext context) {
    final banksAsync = ref.watch(_questionBanksProvider);

    return banksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading question banks: $e')),
      data: (banks) => ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(banks),
          const SizedBox(height: 20),
          _buildFilters(),
          const SizedBox(height: 16),
          if (banks.isEmpty)
            _buildEmptyState()
          else
            ...banks.map((bank) => _buildBankCard(bank)),
        ],
      ),
    );
  }

  Widget _buildHeader(List<QuestionBank> banks) {
    return Row(children: [
      Icon(Icons.quiz_outlined, color: PharmaColors.emerald600, size: 24),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global Question Bank',
                style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
            Text('${banks.length} question bank${banks.length == 1 ? '' : 's'}',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
          ],
        ),
      ),
      IconButton(
        onPressed: () => ref.invalidate(_questionBanksProvider),
        icon: const Icon(Icons.refresh, size: 20),
        tooltip: 'Refresh',
      ),
      const SizedBox(width: 8),
      FilledButton.icon(
        onPressed: () => _showCreateBankDialog(),
        icon: const Icon(Icons.add, size: 16),
        label: const Text('Create Bank'),
        style: FilledButton.styleFrom(
          backgroundColor: PharmaColors.emerald600,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    ]);
  }

  Widget _buildFilters() {
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
              hintText: 'Search questions…',
              prefixIcon: const Icon(Icons.search, size: 18),
              filled: true,
              fillColor: PharmaColors.pageBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _dropdown('Difficulty', _filterDifficulty, ['All', 'easy', 'medium', 'hard'],
            (v) => setState(() => _filterDifficulty = v)),
        const SizedBox(width: 8),
        _dropdown('Type', _filterType, ['All', 'multiple_choice', 'true_false'],
            (v) => setState(() => _filterType = v)),
      ]),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.quiz_outlined, size: 48, color: PharmaColors.gray300),
          const SizedBox(height: 8),
          Text('No question banks found', style: PharmaTypography.bodyMedium),
          const SizedBox(height: 4),
          Text('Question banks will appear here once created.',
              style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
        ],
      ),
    );
  }

  Widget _buildBankCard(QuestionBank bank) {
    final isExpanded = _expandedBanks.contains(bank.id);
    List<String>? tags;
    if (bank.tagsJson != null && bank.tagsJson!.isNotEmpty) {
      try {
        tags = (jsonDecode(bank.tagsJson!) as List).cast<String>();
      } catch (_) {
        tags = null;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: isExpanded ? PharmaColors.emerald600.withOpacity(0.4) : PharmaColors.borderLight),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedBanks.remove(bank.id);
                } else {
                  _expandedBanks.add(bank.id!);
                }
              });
            },
            borderRadius: PharmaRadius.cardRadius,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.folder_outlined, size: 22, color: PharmaColors.emerald600),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bank.name, style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
                        const SizedBox(height: 4),
                        if (tags != null && tags.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: tags.map((tag) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: PharmaColors.gray100,
                                borderRadius: PharmaRadius.pillRadius,
                              ),
                              child: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                            )).toList(),
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
          if (isExpanded) _buildQuestionsSection(bank.id!),
        ],
      ),
    );
  }

  Widget _buildQuestionsSection(int bankId) {
    final questionsAsync = ref.watch(_questionsProvider(bankId));

    return questionsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Error loading questions: $e',
            style: PharmaTypography.body.copyWith(color: PharmaColors.danger)),
      ),
      data: (questions) {
        final filtered = _applyQuestionFilters(questions);

        if (questions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text('No questions in this bank.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: PharmaColors.pageBg,
                border: Border(
                  top: BorderSide(color: PharmaColors.borderLight),
                ),
              ),
              child: Row(children: [
                Text('${filtered.length} of ${questions.length} question${questions.length == 1 ? '' : 's'}',
                    style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontWeight: FontWeight.w600)),
                const Spacer(),
                _buildDifficultyBreakdown(questions),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: () => _showAddQuestionDialog(bankId),
                  icon: const Icon(Icons.add, size: 14),
                  label: const Text('Add Question'),
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ),
              ]),
            ),
            if (filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text('No questions match your current filters.',
                      style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
                ),
              )
            else
              ...filtered.map((q) => _buildQuestionRow(q)),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  List<Question> _applyQuestionFilters(List<Question> questions) {
    return questions.where((q) {
      if (_searchQuery.isNotEmpty && !q.text.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      if (_filterDifficulty != 'All' && q.difficulty != _filterDifficulty) return false;
      if (_filterType != 'All' && q.questionType != _filterType) return false;
      return true;
    }).toList();
  }

  Widget _buildDifficultyBreakdown(List<Question> questions) {
    final easy = questions.where((q) => q.difficulty == 'easy').length;
    final medium = questions.where((q) => q.difficulty == 'medium').length;
    final hard = questions.where((q) => q.difficulty == 'hard').length;

    return Row(mainAxisSize: MainAxisSize.min, children: [
      _miniDiffBadge('E', easy, PharmaColors.successBg, PharmaColors.successText),
      const SizedBox(width: 4),
      _miniDiffBadge('M', medium, PharmaColors.warningBg, PharmaColors.warningText),
      const SizedBox(width: 4),
      _miniDiffBadge('H', hard, PharmaColors.dangerBg, PharmaColors.danger),
    ]);
  }

  Widget _miniDiffBadge(String letter, int count, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text('$letter:$count', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: fg)),
    );
  }

  Widget _buildQuestionRow(Question q) {
    List<String>? options;
    try {
      options = (jsonDecode(q.optionsJson) as List).cast<String>();
    } catch (_) {
      options = null;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight.withOpacity(0.5))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      _DiffChip(difficulty: q.difficulty ?? 'unknown'),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: PharmaColors.gray100, borderRadius: PharmaRadius.pillRadius),
                        child: Text(_formatQuestionType(q.questionType),
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                      ),
                      if (q.regulatoryTag != null && q.regulatoryTag!.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: PharmaColors.warningBg, borderRadius: PharmaRadius.pillRadius),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.gavel, size: 10, color: PharmaColors.warningText),
                            const SizedBox(width: 3),
                            Text(q.regulatoryTag!,
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: PharmaColors.warningText)),
                          ]),
                        ),
                      ],
                    ]),
                    const SizedBox(height: 8),
                    Text(q.text, style: PharmaTypography.bodyMedium),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showQuestionDetail(q, options),
                icon: Icon(Icons.visibility_outlined, size: 18, color: PharmaColors.textTertiary),
                tooltip: 'View Details',
              ),
              IconButton(
                onPressed: () => _showEditQuestionDialog(q),
                icon: Icon(Icons.edit_outlined, size: 18, color: PharmaColors.info),
                tooltip: 'Edit Question',
              ),
              IconButton(
                onPressed: () => _confirmDeleteQuestion(q),
                icon: Icon(Icons.delete_outline, size: 18, color: PharmaColors.danger),
                tooltip: 'Delete Question',
              ),
            ],
          ),
          if (options != null && options.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: options.asMap().entries.map((entry) {
                final isCorrect = q.correctAnswer == entry.key.toString() ||
                    q.correctAnswer == entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isCorrect ? PharmaColors.successBg : PharmaColors.pageBg,
                    borderRadius: PharmaRadius.pillRadius,
                    border: Border.all(
                      color: isCorrect ? PharmaColors.successText.withOpacity(0.4) : PharmaColors.borderLight,
                    ),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    if (isCorrect)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(Icons.check_circle, size: 12, color: PharmaColors.successText),
                      ),
                    Text(entry.value,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isCorrect ? FontWeight.w600 : FontWeight.w400,
                          color: isCorrect ? PharmaColors.successText : PharmaColors.textSecondary,
                        )),
                  ]),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showCreateBankDialog() async {
    final nameController = TextEditingController();
    final tagsController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Create Question Bank'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Bank Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: tagsController,
                decoration: const InputDecoration(labelText: 'Tags (comma-separated)', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Create')),
        ],
      ),
    );

    if (confirmed == true && nameController.text.isNotEmpty) {
      try {
        final user = await ref.read(currentUserProvider.future);
        final tags = tagsController.text.trim().isNotEmpty
            ? jsonEncode(tagsController.text.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList())
            : null;
        await client.assessmentBuilder.createQuestionBank(
          name: nameController.text.trim(),
          organizationId: user!.organizationId,
          tagsJson: tags,
        );
        ref.invalidate(_questionBanksProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Question bank created')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
        }
      }
    }
    nameController.dispose();
    tagsController.dispose();
  }

  Future<void> _showAddQuestionDialog(int bankId) async {
    final textController = TextEditingController();
    final correctAnswerController = TextEditingController();
    final optionsController = TextEditingController();
    String selectedType = 'multiple_choice';
    String selectedDifficulty = 'medium';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
          title: const Text('Add Question'),
          content: SizedBox(
            width: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'Question Text', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                      items: ['multiple_choice', 'true_false']
                          .map((t) => DropdownMenuItem(value: t, child: Text(t == 'multiple_choice' ? 'Multiple Choice' : 'True/False')))
                          .toList(),
                      onChanged: (v) => setDialogState(() => selectedType = v!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedDifficulty,
                      decoration: const InputDecoration(labelText: 'Difficulty', border: OutlineInputBorder()),
                      items: ['easy', 'medium', 'hard']
                          .map((d) => DropdownMenuItem(value: d, child: Text(d[0].toUpperCase() + d.substring(1))))
                          .toList(),
                      onChanged: (v) => setDialogState(() => selectedDifficulty = v!),
                    ),
                  ),
                ]),
                const SizedBox(height: 12),
                TextField(
                  controller: optionsController,
                  decoration: const InputDecoration(
                    labelText: 'Options (comma-separated)',
                    hintText: 'e.g. Option A, Option B, Option C, Option D',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: correctAnswerController,
                  decoration: const InputDecoration(labelText: 'Correct Answer', border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Add')),
          ],
        ),
      ),
    );

    if (confirmed == true && textController.text.isNotEmpty) {
      try {
        final options = optionsController.text.split(',').map((o) => o.trim()).where((o) => o.isNotEmpty).toList();
        await client.assessmentBuilder.createQuestion(
          questionBankId: bankId,
          text: textController.text.trim(),
          questionType: selectedType,
          optionsJson: jsonEncode(options),
          correctAnswer: correctAnswerController.text.trim(),
          difficulty: selectedDifficulty,
        );
        ref.invalidate(_questionsProvider(bankId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Question added')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
        }
      }
    }
    textController.dispose();
    correctAnswerController.dispose();
    optionsController.dispose();
  }

  Future<void> _showEditQuestionDialog(Question q) async {
    List<String> currentOptions;
    try {
      currentOptions = (jsonDecode(q.optionsJson) as List).cast<String>();
    } catch (_) {
      currentOptions = [];
    }

    final textController = TextEditingController(text: q.text);
    final correctAnswerController = TextEditingController(text: q.correctAnswer);
    final optionsController = TextEditingController(text: currentOptions.join(', '));
    String selectedType = q.questionType;
    String selectedDifficulty = q.difficulty ?? 'medium';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
          title: const Text('Edit Question'),
          content: SizedBox(
            width: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'Question Text', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                      items: ['multiple_choice', 'true_false']
                          .map((t) => DropdownMenuItem(value: t, child: Text(t == 'multiple_choice' ? 'Multiple Choice' : 'True/False')))
                          .toList(),
                      onChanged: (v) => setDialogState(() => selectedType = v!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedDifficulty,
                      decoration: const InputDecoration(labelText: 'Difficulty', border: OutlineInputBorder()),
                      items: ['easy', 'medium', 'hard']
                          .map((d) => DropdownMenuItem(value: d, child: Text(d[0].toUpperCase() + d.substring(1))))
                          .toList(),
                      onChanged: (v) => setDialogState(() => selectedDifficulty = v!),
                    ),
                  ),
                ]),
                const SizedBox(height: 12),
                TextField(
                  controller: optionsController,
                  decoration: const InputDecoration(
                    labelText: 'Options (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: correctAnswerController,
                  decoration: const InputDecoration(labelText: 'Correct Answer', border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );

    if (confirmed == true) {
      try {
        final options = optionsController.text.split(',').map((o) => o.trim()).where((o) => o.isNotEmpty).toList();
        await client.assessmentBuilder.updateQuestion(
          questionId: q.id!,
          text: textController.text.trim(),
          questionType: selectedType,
          optionsJson: jsonEncode(options),
          correctAnswer: correctAnswerController.text.trim(),
          difficulty: selectedDifficulty,
        );
        ref.invalidate(_questionsProvider(q.questionBankId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Question updated')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
        }
      }
    }
    textController.dispose();
    correctAnswerController.dispose();
    optionsController.dispose();
  }

  Future<void> _confirmDeleteQuestion(Question q) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Question?'),
        content: Text('Are you sure you want to delete this question?\n\n"${q.text}"'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await client.assessmentBuilder.deleteQuestion(questionId: q.id!);
        ref.invalidate(_questionsProvider(q.questionBankId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Question deleted')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
        }
      }
    }
  }

  void _showQuestionDetail(Question q, List<String>? options) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Question Details'),
        content: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(q.text, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              _dialogRow('Type', _formatQuestionType(q.questionType)),
              _dialogRow('Difficulty', q.difficulty ?? 'Not set'),
              _dialogRow('Correct Answer', q.correctAnswer),
              if (q.regulatoryTag != null)
                _dialogRow('Regulatory Tag', q.regulatoryTag!),
              _dialogRow('Bank ID', '${q.questionBankId}'),
              if (options != null && options.isNotEmpty) ...[
                const Divider(height: 24),
                Text('Options', style: PharmaTypography.headingSmall.copyWith(fontSize: 13)),
                const SizedBox(height: 8),
                ...options.asMap().entries.map((entry) {
                  final isCorrect = q.correctAnswer == entry.key.toString() ||
                      q.correctAnswer == entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isCorrect ? PharmaColors.successBg : PharmaColors.gray100,
                          shape: BoxShape.circle,
                        ),
                        child: Text('${entry.key + 1}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                                color: isCorrect ? PharmaColors.successText : PharmaColors.textSecondary)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(entry.value, style: PharmaTypography.bodyMedium)),
                      if (isCorrect)
                        Icon(Icons.check_circle, size: 16, color: PharmaColors.successText),
                    ]),
                  );
                }),
              ],
            ],
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

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: PharmaColors.borderLight), borderRadius: PharmaRadius.inputRadius),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox.shrink(),
        isDense: true,
        style: PharmaTypography.caption.copyWith(color: PharmaColors.textPrimary),
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(_formatDropdownLabel(i)))).toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  String _formatQuestionType(String type) {
    switch (type) {
      case 'multiple_choice':
        return 'Multiple Choice';
      case 'true_false':
        return 'True / False';
      default:
        return type;
    }
  }

  String _formatDropdownLabel(String value) {
    if (value == 'All') return value;
    switch (value) {
      case 'multiple_choice':
        return 'Multiple Choice';
      case 'true_false':
        return 'True / False';
      default:
        return value[0].toUpperCase() + value.substring(1);
    }
  }
}

class _DiffChip extends StatelessWidget {
  const _DiffChip({required this.difficulty});
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (difficulty) {
      case 'easy':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        break;
      case 'medium':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        break;
      case 'hard':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.danger;
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(difficulty.toUpperCase(),
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
