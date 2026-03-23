// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — AI QUESTION GENERATION (TRN-07)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/assessments/ai-generate
// 3-step flow: Select Source Bank → Configure Count → Review & Import
// Uses generateRandomAssessment to shuffle questions from a source bank,
// then importQuestionsToBank to persist selected questions into a target bank.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

class AiQuestionGenerationScreen extends ConsumerStatefulWidget {
  const AiQuestionGenerationScreen({super.key});

  @override
  ConsumerState<AiQuestionGenerationScreen> createState() =>
      _AiQuestionGenerationScreenState();
}

class _AiQuestionGenerationScreenState
    extends ConsumerState<AiQuestionGenerationScreen> {
  int _currentStep = 0; // 0 = Select Source, 1 = Configure, 2 = Review & Import

  // Step 0 state — source question bank
  List<QuestionBank>? _questionBanks;
  bool _loadingBanks = true;
  String? _banksError;
  QuestionBank? _selectedSourceBank;

  // Step 1 state
  int _questionCount = 10;
  bool _includeExplanations = true;

  // Step 2 state — generated questions + target bank
  bool _loadingQuestions = false;
  String? _questionsError;
  List<Question> _fetchedQuestions = [];
  final Set<int> _selectedForImport = {};
  QuestionBank? _selectedTargetBank;
  bool _importing = false;

  @override
  void initState() {
    super.initState();
    _loadQuestionBanks();
  }

  Future<void> _loadQuestionBanks() async {
    setState(() {
      _loadingBanks = true;
      _banksError = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) {
        setState(() {
          _banksError = 'Not authenticated';
          _loadingBanks = false;
        });
        return;
      }
      final banks = await client.assessment.listQuestionBanks(
        organizationId: user.organizationId,
      );
      if (mounted) {
        setState(() {
          _questionBanks = banks;
          _loadingBanks = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _banksError = e.toString();
          _loadingBanks = false;
        });
      }
    }
  }

  Future<void> _generateQuestions() async {
    if (_selectedSourceBank?.id == null) return;
    setState(() {
      _loadingQuestions = true;
      _questionsError = null;
      _currentStep = 2;
    });

    try {
      final questions = await client.assessment.generateRandomAssessment(
        questionBankId: _selectedSourceBank!.id!,
        count: _questionCount,
      );

      if (mounted) {
        setState(() {
          _fetchedQuestions = questions;
          _selectedForImport.clear();
          for (final q in questions) {
            if (q.id != null) _selectedForImport.add(q.id!);
          }
          _loadingQuestions = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _questionsError = e.toString();
          _loadingQuestions = false;
        });
      }
    }
  }

  Future<void> _importSelected() async {
    if (_selectedTargetBank?.id == null || _selectedForImport.isEmpty) return;

    setState(() => _importing = true);
    try {
      final selectedQuestions = _fetchedQuestions
          .where((q) => q.id != null && _selectedForImport.contains(q.id!))
          .toList();

      await client.assessment.importQuestionsToBank(
        targetBankId: _selectedTargetBank!.id!,
        questions: selectedQuestions
            .map((q) => {
                  'text': q.text,
                  'questionType': q.questionType,
                  'optionsJson': q.optionsJson,
                  'correctAnswer': q.correctAnswer,
                })
            .toList(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '${selectedQuestions.length} questions imported to "${_selectedTargetBank!.name}"',
          ),
          backgroundColor: PharmaColors.emerald600,
        ));
        context.go('/trainer/question-bank');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        _buildStepper(),
        const SizedBox(height: 24),
        if (_currentStep == 0) _buildSelectSourceStep(),
        if (_currentStep == 1) _buildConfigureStep(),
        if (_currentStep == 2) _buildReviewStep(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go('/trainer/assessments'),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Icon(Icons.shuffle, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question Generation',
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Generate randomized question sets from existing banks',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: PharmaColors.infoBg,
            borderRadius: PharmaRadius.pillRadius,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.shuffle, size: 14, color: PharmaColors.infoText),
            const SizedBox(width: 6),
            Text(
              'Random Shuffle',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: PharmaColors.infoText,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        _stepDot(0, 'Select Source'),
        Expanded(
          child: Container(
            height: 2,
            color: _currentStep >= 1
                ? PharmaColors.emerald600
                : PharmaColors.gray200,
          ),
        ),
        _stepDot(1, 'Configure'),
        Expanded(
          child: Container(
            height: 2,
            color: _currentStep >= 2
                ? PharmaColors.emerald600
                : PharmaColors.gray200,
          ),
        ),
        _stepDot(2, 'Review & Import'),
      ],
    );
  }

  Widget _stepDot(int step, String label) {
    final isComplete = step < _currentStep;
    final isActive = step == _currentStep;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isComplete
              ? PharmaColors.emerald600
              : isActive
                  ? PharmaColors.emerald600
                  : PharmaColors.gray200,
        ),
        child: Center(
          child: isComplete
              ? const Icon(Icons.check, color: PharmaColors.cardBg, size: 16)
              : Text(
                  '${step + 1}',
                  style: TextStyle(
                    color: isActive ? PharmaColors.cardBg : PharmaColors.gray500,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isActive ? PharmaColors.emerald600 : PharmaColors.textTertiary,
        ),
      ),
    ]);
  }

  Widget _buildSelectSourceStep() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(children: [
            Text('Step 1: Select Source Question Bank',
                style: PharmaTypography.headingSmall),
            const SizedBox(height: 8),
            Text(
              'Choose an existing question bank to generate randomized questions from.',
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (_loadingBanks)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else if (_banksError != null)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(children: [
                  Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
                  const SizedBox(height: 12),
                  Text(
                    'Failed to load question banks',
                    style: PharmaTypography.bodyMedium.copyWith(
                      color: PharmaColors.danger,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _banksError!,
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _loadQuestionBanks,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Retry'),
                  ),
                ]),
              )
            else if (_questionBanks == null || _questionBanks!.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(children: [
                  Icon(Icons.quiz_outlined,
                      size: 48, color: PharmaColors.gray400),
                  const SizedBox(height: 12),
                  Text('No question banks found',
                      style: PharmaTypography.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Create a question bank first via the Question Bank Library.',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                  ),
                ]),
              )
            else
              Container(
                constraints: const BoxConstraints(maxHeight: 320),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _questionBanks!.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final bank = _questionBanks![index];
                    final isSelected = _selectedSourceBank?.id == bank.id;
                    return InkWell(
                      onTap: () => setState(() => _selectedSourceBank = bank),
                      borderRadius:
                          BorderRadius.circular(PharmaRadius.md),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? PharmaColors.emerald50
                              : PharmaColors.pageBg,
                          borderRadius: PharmaRadius.cardRadius,
                          border: Border.all(
                            color: isSelected
                                ? PharmaColors.emerald600
                                : PharmaColors.borderLight,
                          ),
                        ),
                        child: Row(children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.quiz_outlined,
                            size: 20,
                            color: isSelected
                                ? PharmaColors.emerald600
                                : PharmaColors.gray400,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bank.name,
                                  style: PharmaTypography.bodyMedium.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                                if (bank.tagsJson != null)
                                  Text(
                                    bank.tagsJson!,
                                    style: PharmaTypography.caption.copyWith(
                                      color: PharmaColors.textTertiary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              FilledButton(
                onPressed: _selectedSourceBank != null
                    ? () => setState(() => _currentStep = 1)
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  foregroundColor: PharmaColors.cardBg,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: const Text('Next: Configure'),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _buildConfigureStep() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Step 2: Configure Generation',
                      style: PharmaTypography.headingSmall),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald50,
                      borderRadius: PharmaRadius.pillRadius,
                    ),
                    child: Text(
                      'Source: ${_selectedSourceBank?.name ?? '—'}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: PharmaColors.emerald600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _label('Number of Questions'),
                Slider(
                  value: _questionCount.toDouble(),
                  min: 5,
                  max: 50,
                  divisions: 9,
                  activeColor: PharmaColors.emerald600,
                  label: '$_questionCount',
                  onChanged: (v) =>
                      setState(() => _questionCount = v.toInt()),
                ),
                Center(
                  child: Text('$_questionCount questions',
                      style: PharmaTypography.bodyMedium),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  value: _includeExplanations,
                  onChanged: (v) => setState(() => _includeExplanations = v),
                  title: Text('Show Answer Explanations',
                      style: PharmaTypography.bodyMedium),
                  subtitle: Text(
                    'Display correct answer in the review step',
                    style: PharmaTypography.caption,
                  ),
                  activeThumbColor: PharmaColors.emerald600,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PharmaColors.infoBg,
                    borderRadius: PharmaRadius.cardRadius,
                    border: Border.all(color: PharmaColors.infoBg),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                          size: 16, color: PharmaColors.infoText),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Questions will be randomly shuffled from the selected source bank using a Fisher-Yates algorithm. You can review and select which to import.',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.infoText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => setState(() => _currentStep = 0),
                        child: const Text('← Back'),
                      ),
                      FilledButton.icon(
                        onPressed: _generateQuestions,
                        icon: const Icon(Icons.shuffle, size: 16),
                        label: const Text('Generate Questions'),
                        style: FilledButton.styleFrom(
                          backgroundColor: PharmaColors.emerald600,
                          foregroundColor: PharmaColors.cardBg,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                        ),
                      ),
                    ]),
              ]),
        ),
      ),
    );
  }

  Widget _buildReviewStep() {
    if (_loadingQuestions) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(48),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Generating random question set…',
                style: PharmaTypography.bodyMedium),
            const SizedBox(height: 8),
            Text(
              'Shuffling $_questionCount questions from "${_selectedSourceBank?.name ?? 'bank'}"',
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textTertiary,
              ),
            ),
          ]),
        ),
      );
    }

    if (_questionsError != null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(48),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text('Failed to generate questions',
                style: PharmaTypography.bodyMedium
                    .copyWith(color: PharmaColors.danger)),
            const SizedBox(height: 4),
            Text(
              _questionsError!,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(mainAxisSize: MainAxisSize.min, children: [
              TextButton(
                onPressed: () => setState(() => _currentStep = 1),
                child: const Text('← Re-configure'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _generateQuestions,
                child: const Text('Retry'),
              ),
            ]),
          ]),
        ),
      );
    }

    if (_fetchedQuestions.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(48),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.quiz_outlined, size: 48, color: PharmaColors.gray400),
            const SizedBox(height: 12),
            Text('No questions found', style: PharmaTypography.headingSmall),
            const SizedBox(height: 4),
            Text(
              'The selected question bank has no questions. Try a different source bank.',
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(mainAxisSize: MainAxisSize.min, children: [
              TextButton(
                onPressed: () => setState(() => _currentStep = 0),
                child: const Text('← Select different bank'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => context.go('/trainer/question-bank'),
                child: const Text('Go to Question Bank'),
              ),
            ]),
          ]),
        ),
      );
    }

    final easyCount =
        _fetchedQuestions.where((q) => q.difficulty == 'easy').length;
    final mediumCount =
        _fetchedQuestions.where((q) => q.difficulty == 'medium').length;
    final hardCount =
        _fetchedQuestions.where((q) => q.difficulty == 'hard').length;

    final targetBanks = (_questionBanks ?? [])
        .where((b) => b.id != _selectedSourceBank?.id)
        .toList();

    return Column(
      children: [
        // Action bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Row(children: [
            Icon(Icons.quiz_outlined,
                color: PharmaColors.emerald600, size: 20),
            const SizedBox(width: 10),
            Text(
              '${_fetchedQuestions.length} questions generated',
              style: PharmaTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text('${_selectedForImport.length} selected',
                style: PharmaTypography.caption),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => setState(() => _currentStep = 1),
              child: const Text('← Re-configure'),
            ),
          ]),
        ),
        const SizedBox(height: 16),

        // Target bank selector + import button
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Row(
            children: [
              _diffStat('Easy', easyCount, PharmaColors.emerald600),
              const SizedBox(width: 24),
              _diffStat('Medium', mediumCount, PharmaColors.warningText),
              const SizedBox(width: 24),
              _diffStat('Hard', hardCount, PharmaColors.danger),
              const Spacer(),
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<int>(
                  initialValue: _selectedTargetBank?.id,
                  items: targetBanks
                      .map((b) => DropdownMenuItem(
                            value: b.id,
                            child: Text(b.name,
                                style: const TextStyle(fontSize: 13)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() {
                    _selectedTargetBank =
                        targetBanks.where((b) => b.id == v).firstOrNull;
                  }),
                  decoration: InputDecoration(
                    labelText: 'Import to Bank',
                    labelStyle: PharmaTypography.caption,
                    filled: true,
                    fillColor: PharmaColors.pageBg,
                    border: OutlineInputBorder(
                      borderRadius: PharmaRadius.inputRadius,
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: (_selectedForImport.isNotEmpty &&
                        _selectedTargetBank != null &&
                        !_importing)
                    ? _importSelected
                    : null,
                icon: _importing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: PharmaColors.cardBg),
                      )
                    : const Icon(Icons.download, size: 16),
                label: Text(_importing ? 'Importing...' : 'Import Selected'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  foregroundColor: PharmaColors.cardBg,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Question cards
        ..._fetchedQuestions.map((q) {
          final qId = q.id ?? 0;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(
                color: _selectedForImport.contains(qId)
                    ? PharmaColors.emerald600.withValues(alpha: 0.3)
                    : PharmaColors.borderLight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _selectedForImport.contains(qId),
                  activeColor: PharmaColors.emerald600,
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      _selectedForImport.add(qId);
                    } else {
                      _selectedForImport.remove(qId);
                    }
                  }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        _DiffChip(difficulty: q.difficulty ?? 'unknown'),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: PharmaColors.gray100,
                            borderRadius: PharmaRadius.pillRadius,
                          ),
                          child: Text(
                            q.questionType,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: PharmaColors.gray600,
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Text(q.text, style: PharmaTypography.bodyMedium),
                      if (_includeExplanations) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Answer: ${q.correctAnswer}',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.textTertiary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _diffStat(String label, int count, Color color) {
    return Row(children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text('$label: ', style: PharmaTypography.caption),
      Text('$count',
          style: PharmaTypography.bodyMedium
              .copyWith(fontWeight: FontWeight.w600)),
    ]);
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
    );
  }
}

class _DiffChip extends StatelessWidget {
  const _DiffChip({required this.difficulty});
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (difficulty.toLowerCase()) {
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
      child: Text(
        difficulty[0].toUpperCase() + difficulty.substring(1),
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
