import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/colors.dart';
import '../../design_system/spacing.dart';

/// Odoo-style Assessment Builder with TRN-WF-03 compliance.
/// 
/// TRN-WF-03 Rule: Questions to Display must be <= Total Questions / 2
/// to ensure adequate randomization for assessment integrity.
class AssessmentBuilderScreen extends StatefulWidget {
  const AssessmentBuilderScreen({super.key, this.assessmentId});

  final int? assessmentId;

  @override
  State<AssessmentBuilderScreen> createState() => _AssessmentBuilderScreenState();
}

class _AssessmentBuilderScreenState extends State<AssessmentBuilderScreen> {
  // Data
  List<QuestionBank> _banks = [];
  QuestionBank? _selectedBank;
  List<Question> _questions = [];
  bool _loading = true;
  String? _error;

  // Assessment Settings Controllers
  final _passingScoreController = TextEditingController(text: '80');
  final _timeLimitController = TextEditingController(text: '30');
  final _maxAttemptsController = TextEditingController(text: '3');
  final _questionsToDisplayController = TextEditingController(text: '10');
  bool _randomizeQuestions = true;

  // TRN-WF-03 Validation
  bool get _isTrnWf03Valid {
    final questionsToDisplay = int.tryParse(_questionsToDisplayController.text) ?? 0;
    final totalQuestions = _questions.length;
    if (totalQuestions == 0) return true; // No questions yet, skip validation
    return questionsToDisplay <= (totalQuestions / 2).floor();
  }

  int get _minimumQuestionsRequired {
    final questionsToDisplay = int.tryParse(_questionsToDisplayController.text) ?? 0;
    return questionsToDisplay * 2;
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _passingScoreController.dispose();
    _timeLimitController.dispose();
    _maxAttemptsController.dispose();
    _questionsToDisplayController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final banks = await client.assessment.listQuestionBanks();
      setState(() {
        _banks = banks;
        _loading = false;
        if (_banks.isNotEmpty) {
          _selectBank(_banks.first);
        }
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _selectBank(QuestionBank bank) async {
    setState(() => _selectedBank = bank);
    try {
      final questions = await client.assessment.getQuestions(bank.id!);
      setState(() => _questions = questions);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _addQuestion() async {
    if (_selectedBank == null) return;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => _AddQuestionDialog(),
    );

    if (result == null || !mounted) return;

    try {
      await client.assessmentBuilder.createQuestion(
        questionBankId: _selectedBank!.id!,
        text: result['text'] as String,
        questionType: result['questionType'] as String,
        optionsJson: result['optionsJson'] as String,
        correctAnswer: result['correctAnswer'] as String,
        // Note: difficulty and regulatoryTag will need endpoint update
      );
      if (mounted) {
        _selectBank(_selectedBank!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Question added successfully'),
            backgroundColor: DesignColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: DesignColors.danger),
        );
      }
    }
  }

  Future<void> _deleteQuestion(Question question) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Question'),
        content: Text('Are you sure you want to delete this question?\n\n"${question.text}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: DesignColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    try {
      // TRN-WF-03: Delete question using new endpoint
      await client.assessmentBuilder.deleteQuestion(questionId: question.id!);
      if (mounted) {
        _selectBank(_selectedBank!); // Refresh questions
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Question deleted successfully'),
            backgroundColor: DesignColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: DesignColors.danger),
        );
      }
    }
  }

  Future<void> _saveAssessment() async {
    if (_selectedBank == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a question bank'),
          backgroundColor: DesignColors.warning,
        ),
      );
      return;
    }

    if (!_isTrnWf03Valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'TRN-WF-03 Violation: Question bank must contain at least $_minimumQuestionsRequired questions '
            'for ${_questionsToDisplayController.text} questions to display.',
          ),
          backgroundColor: DesignColors.danger,
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }

    // For now show placeholder - need course version selection
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Assessment settings validated. Link to course version to complete.'),
        backgroundColor: DesignColors.success,
      ),
    );
  }
  
  /// TRN-WF-03: Create a new question bank
  Future<void> _showCreateQuestionBankDialog() async {
    final nameController = TextEditingController();
    final tagsController = TextEditingController();
    
    final result = await showDialog<QuestionBank>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: DesignColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.folder_open, color: DesignColors.primary),
            ),
            const SizedBox(width: 12),
            const Text('Create Question Bank'),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: DesignColors.neutral700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'e.g., GMP Fundamentals Quiz',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tags (optional, comma-separated)',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: DesignColors.neutral700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: tagsController,
                decoration: const InputDecoration(
                  hintText: 'e.g., GMP, 21CFR, Quality',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Please enter a name')),
                );
                return;
              }
              
              try {
                // Create using new endpoint
                final bank = await client.assessmentBuilder.createQuestionBank(
                  name: nameController.text.trim(),
                  organizationId: 1, // TODO: Get from user context
                  tagsJson: tagsController.text.isNotEmpty
                      ? jsonEncode(tagsController.text.split(',').map((t) => t.trim()).toList())
                      : null,
                );
                Navigator.pop(ctx, bank);
              } catch (e) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(content: Text('Failed to create: $e')),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Create'),
          ),
        ],
      ),
    );
    
    if (result != null && mounted) {
      // Reload banks and select the new one
      await _load();
      _selectBank(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Question bank "${result.name}" created'),
          backgroundColor: DesignColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: DesignColors.neutral50,
        appBar: _buildAppBar(),
        body: const Center(
          child: CircularProgressIndicator(color: DesignColors.primary),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: DesignColors.neutral50,
        appBar: _buildAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: DesignColors.danger),
              const SizedBox(height: DesignSpacing.md),
              Text(_error!, style: const TextStyle(color: DesignColors.neutral700)),
              const SizedBox(height: DesignSpacing.md),
              ElevatedButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: DesignColors.neutral50,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // TRN-WF-03 Validation Warning Panel
          _buildValidationPanel(),

          // Main Content
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Sidebar: Assessment Settings
                _buildSettingsSidebar(),

                // Divider
                Container(
                  width: 1,
                  color: DesignColors.neutral200,
                ),

                // Main Body: Question Bank
                Expanded(child: _buildQuestionBank()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DesignColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.quiz_outlined, color: DesignColors.primary),
          ),
          const SizedBox(width: DesignSpacing.sm),
          const Text('Assessment Builder'),
        ],
      ),
      backgroundColor: Colors.white,
      foregroundColor: DesignColors.neutral900,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      actions: [
        OutlinedButton.icon(
          onPressed: _load,
          icon: const Icon(Icons.refresh, size: 18),
          label: const Text('Refresh'),
          style: OutlinedButton.styleFrom(
            foregroundColor: DesignColors.neutral700,
            side: const BorderSide(color: DesignColors.neutral300),
          ),
        ),
        const SizedBox(width: DesignSpacing.sm),
        ElevatedButton.icon(
          onPressed: _saveAssessment,
          icon: const Icon(Icons.save, size: 18),
          label: const Text('Save Assessment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: DesignColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: DesignSpacing.md),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: DesignColors.neutral200, height: 1),
      ),
    );
  }

  Widget _buildValidationPanel() {
    final questionsToDisplay = int.tryParse(_questionsToDisplayController.text) ?? 0;
    final totalQuestions = _questions.length;

    if (questionsToDisplay == 0 || _isTrnWf03Valid) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignSpacing.md),
      decoration: BoxDecoration(
        color: DesignColors.danger.withAlpha(15),
        border: const Border(
          bottom: BorderSide(color: DesignColors.danger, width: 2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DesignColors.danger.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.warning_amber, color: DesignColors.danger, size: 24),
          ),
          const SizedBox(width: DesignSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TRN-WF-03 Validation Failed',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: DesignColors.danger,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'To display $questionsToDisplay questions, your question bank must contain at least $_minimumQuestionsRequired questions. '
                  'Currently: $totalQuestions questions. Add ${_minimumQuestionsRequired - totalQuestions} more questions.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: DesignColors.neutral700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: DesignColors.danger,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$totalQuestions / $_minimumQuestionsRequired',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSidebar() {
    return Container(
      width: 300,
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(DesignSpacing.md),
        children: [
          // Section Header
          Row(
            children: [
              const Icon(Icons.settings, color: DesignColors.primary, size: 20),
              const SizedBox(width: DesignSpacing.sm),
              const Text(
                'Assessment Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DesignColors.neutral900,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignSpacing.lg),

          // Question Bank Selector with Create button
          Row(
            children: [
              Expanded(child: _buildSidebarLabel('Question Bank')),
              IconButton(
                onPressed: _showCreateQuestionBankDialog,
                icon: const Icon(Icons.add, size: 18),
                tooltip: 'Create New Question Bank',
                style: IconButton.styleFrom(
                  backgroundColor: DesignColors.primary.withOpacity(0.1),
                  foregroundColor: DesignColors.primary,
                  minimumSize: const Size(28, 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignSpacing.xs),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: DesignColors.neutral300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<QuestionBank>(
                value: _selectedBank,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                items: _banks.map((b) {
                  return DropdownMenuItem(
                    value: b,
                    child: Text(b.name, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (bank) {
                  if (bank != null) _selectBank(bank);
                },
              ),
            ),
          ),
          const SizedBox(height: DesignSpacing.lg),

          const Divider(height: 1, color: DesignColors.neutral200),
          const SizedBox(height: DesignSpacing.lg),

          // Pass Mark
          _buildSidebarLabel('Pass Mark (%)'),
          const SizedBox(height: DesignSpacing.xs),
          _buildNumberField(_passingScoreController, suffix: '%'),
          const SizedBox(height: DesignSpacing.md),

          // Time Limit
          _buildSidebarLabel('Time Limit (minutes)'),
          const SizedBox(height: DesignSpacing.xs),
          _buildNumberField(_timeLimitController, suffix: 'min'),
          const SizedBox(height: DesignSpacing.md),

          // Max Attempts
          _buildSidebarLabel('Max Attempts'),
          const SizedBox(height: DesignSpacing.xs),
          _buildNumberField(_maxAttemptsController, hint: '0 = unlimited'),
          const SizedBox(height: DesignSpacing.md),

          // Questions to Display
          _buildSidebarLabel('Questions to Display'),
          const SizedBox(height: DesignSpacing.xs),
          _buildNumberField(
            _questionsToDisplayController,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 4),
          Text(
            'TRN-WF-03: Must be ≤ ${(_questions.length / 2).floor()} (half of bank)',
            style: TextStyle(
              fontSize: 11,
              color: _isTrnWf03Valid ? DesignColors.neutral500 : DesignColors.danger,
              fontWeight: _isTrnWf03Valid ? FontWeight.normal : FontWeight.w500,
            ),
          ),
          const SizedBox(height: DesignSpacing.lg),

          // Randomize Toggle
          Container(
            padding: const EdgeInsets.all(DesignSpacing.sm),
            decoration: BoxDecoration(
              color: DesignColors.neutral100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Randomize Questions',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: DesignColors.neutral800,
                        ),
                      ),
                      Text(
                        'Shuffle question order for each attempt',
                        style: TextStyle(fontSize: 11, color: DesignColors.neutral500),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _randomizeQuestions,
                  onChanged: (v) => setState(() => _randomizeQuestions = v),
                  activeTrackColor: DesignColors.primary.withAlpha(150),
                  thumbColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return DesignColors.primary;
                    }
                    return DesignColors.neutral400;
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: DesignSpacing.xl),

          // Stats Card
          _buildStatsCard(),
        ],
      ),
    );
  }

  Widget _buildSidebarLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: DesignColors.neutral600,
      ),
    );
  }

  Widget _buildNumberField(
    TextEditingController controller, {
    String? suffix,
    String? hint,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: DesignColors.neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: DesignColors.neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: DesignColors.primary, width: 2),
        ),
        suffixText: suffix,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: DesignColors.neutral400),
      ),
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildStatsCard() {
    final questionsToDisplay = int.tryParse(_questionsToDisplayController.text) ?? 0;

    return Container(
      padding: const EdgeInsets.all(DesignSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DesignColors.primary.withAlpha(15),
            DesignColors.primary.withAlpha(5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DesignColors.primary.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Question Bank Stats',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: DesignColors.primary,
            ),
          ),
          const SizedBox(height: DesignSpacing.sm),
          _buildStatRow('Total Questions', '${_questions.length}'),
          _buildStatRow('Easy', '${_questions.where((q) => q.difficulty == 'easy').length}'),
          _buildStatRow('Medium', '${_questions.where((q) => q.difficulty == 'medium').length}'),
          _buildStatRow('Hard', '${_questions.where((q) => q.difficulty == 'hard').length}'),
          const Divider(height: 16, color: DesignColors.neutral300),
          _buildStatRow(
            'Randomization Pool',
            questionsToDisplay > 0
                ? '${((_questions.length / questionsToDisplay) * 100).toStringAsFixed(0)}%'
                : 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: DesignColors.neutral600),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: DesignColors.neutral800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionBank() {
    return Container(
      color: DesignColors.neutral50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(DesignSpacing.md),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(Icons.quiz, color: DesignColors.neutral700, size: 20),
                const SizedBox(width: DesignSpacing.sm),
                Text(
                  'Question Bank',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DesignColors.neutral900,
                  ),
                ),
                if (_selectedBank != null) ...[
                  const SizedBox(width: DesignSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: DesignColors.primary.withAlpha(15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _selectedBank!.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: DesignColors.primary,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _showGenerateQuestionsDialog,
                  icon: const Icon(Icons.auto_awesome, size: 18),
                  label: const Text('AI Generate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: DesignColors.neutral700,
                    side: const BorderSide(color: DesignColors.neutral300),
                  ),
                ),
                const SizedBox(width: DesignSpacing.sm),
                ElevatedButton.icon(
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Question'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: DesignColors.neutral200),

          // Questions List
          Expanded(
            child: _questions.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(DesignSpacing.md),
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      return _QuestionCard(
                        question: _questions[index],
                        index: index + 1,
                        onDelete: () => _deleteQuestion(_questions[index]),
                        onEdit: () => _editQuestion(_questions[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(DesignSpacing.lg),
            decoration: BoxDecoration(
              color: DesignColors.neutral200,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.help_outline,
              size: 48,
              color: DesignColors.neutral500,
            ),
          ),
          const SizedBox(height: DesignSpacing.lg),
          const Text(
            'No questions yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: DesignColors.neutral700,
            ),
          ),
          const SizedBox(height: DesignSpacing.xs),
          const Text(
            'Add questions to build your assessment',
            style: TextStyle(
              fontSize: 14,
              color: DesignColors.neutral500,
            ),
          ),
          const SizedBox(height: DesignSpacing.lg),
          ElevatedButton.icon(
            onPressed: _addQuestion,
            icon: const Icon(Icons.add),
            label: const Text('Add First Question'),
            style: ElevatedButton.styleFrom(
              backgroundColor: DesignColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showGenerateQuestionsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.auto_awesome, color: DesignColors.primary),
            SizedBox(width: DesignSpacing.sm),
            Text('AI Question Generation'),
          ],
        ),
        content: const Text(
          'AI-assisted question generation coming soon.\n\n'
          'This feature will integrate with OpenAI/LLM to generate '
          'regulatory-compliant questions from your course content.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _editQuestion(Question question) {
    // Placeholder for edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit question functionality coming soon')),
    );
  }
}

/// Question Card Widget
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.question,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });

  final Question question;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  Color get _difficultyColor {
    switch (question.difficulty?.toLowerCase()) {
      case 'easy':
        return DesignColors.success;
      case 'medium':
        return DesignColors.warning;
      case 'hard':
        return DesignColors.danger;
      default:
        return DesignColors.neutral500;
    }
  }

  IconData get _typeIcon {
    switch (question.questionType.toLowerCase()) {
      case 'true_false':
        return Icons.toggle_on_outlined;
      case 'multiple_choice':
        return Icons.radio_button_checked;
      case 'fill_blank':
        return Icons.short_text;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> options = [];
    try {
      options = jsonDecode(question.optionsJson) as List<dynamic>;
    } catch (_) {}

    return Card(
      margin: const EdgeInsets.only(bottom: DesignSpacing.sm),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: DesignColors.neutral200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Question Number
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: DesignColors.primary.withAlpha(15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DesignColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: DesignSpacing.sm),

                // Question Type Icon
                Icon(_typeIcon, size: 18, color: DesignColors.neutral500),
                const SizedBox(width: 4),
                Text(
                  question.questionType.replaceAll('_', ' ').toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: DesignColors.neutral500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: DesignSpacing.sm),

                // Difficulty Badge
                if (question.difficulty != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _difficultyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      question.difficulty!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _difficultyColor,
                      ),
                    ),
                  ),
                ],

                // Regulatory Tag Badge (mock - will use actual field after generate)
                const SizedBox(width: DesignSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: DesignColors.neutral200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '21 CFR 11',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: DesignColors.neutral600,
                    ),
                  ),
                ),

                const Spacer(),

                // Actions
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  color: DesignColors.neutral500,
                  tooltip: 'Edit',
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18),
                  color: DesignColors.danger,
                  tooltip: 'Delete',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: DesignSpacing.sm),

            // Question Text
            Text(
              question.text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: DesignColors.neutral900,
              ),
            ),
            const SizedBox(height: DesignSpacing.sm),

            // Options
            if (options.isNotEmpty) ...[
              Wrap(
                spacing: DesignSpacing.sm,
                runSpacing: DesignSpacing.xs,
                children: options.asMap().entries.map((entry) {
                  final isCorrect = entry.key.toString() == question.correctAnswer;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? DesignColors.success.withAlpha(15)
                          : DesignColors.neutral100,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isCorrect ? DesignColors.success : DesignColors.neutral300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isCorrect)
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.check_circle, size: 14, color: DesignColors.success),
                          ),
                        Text(
                          '${String.fromCharCode(65 + entry.key)}. ${entry.value}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isCorrect ? DesignColors.success : DesignColors.neutral700,
                            fontWeight: isCorrect ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Add Question Dialog with TRN-WF-03 compliant fields
class _AddQuestionDialog extends StatefulWidget {
  @override
  State<_AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<_AddQuestionDialog> {
  final _textController = TextEditingController();
  final _optionsControllers = List.generate(4, (_) => TextEditingController());
  String _questionType = 'multiple_choice';
  String _difficulty = 'medium';
  String _regulatoryTag = '21 CFR 11';
  int _correctAnswerIndex = 0;

  final _questionTypes = [
    ('multiple_choice', 'Multiple Choice'),
    ('true_false', 'True/False'),
    ('fill_blank', 'Fill in the Blank'),
  ];

  final _difficulties = ['easy', 'medium', 'hard'];

  final _regulatoryTags = [
    '21 CFR 11',
    '21 CFR Part 820',
    'GMP',
    'GxP',
    'ICH Q10',
    'EU Annex 11',
    'Data Integrity',
    'ALCOA+',
  ];

  @override
  void dispose() {
    _textController.dispose();
    for (final c in _optionsControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 550,
        constraints: const BoxConstraints(maxHeight: 650),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(DesignSpacing.md),
              decoration: const BoxDecoration(
                color: DesignColors.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.add_circle_outline, color: Colors.white),
                  SizedBox(width: DesignSpacing.sm),
                  Text(
                    'Add Question',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Form Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DesignSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question Text
                    const Text(
                      'Question Text *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: DesignColors.neutral700,
                      ),
                    ),
                    const SizedBox(height: DesignSpacing.xs),
                    TextField(
                      controller: _textController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter your question here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: DesignSpacing.lg),

                    // Type, Difficulty, Regulatory Tag Row
                    Row(
                      children: [
                        // Question Type
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Question Type',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: DesignColors.neutral700,
                                ),
                              ),
                              const SizedBox(height: DesignSpacing.xs),
                              DropdownButtonFormField<String>(
                                initialValue: _questionType,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                items: _questionTypes.map((t) {
                                  return DropdownMenuItem(
                                    value: t.$1,
                                    child: Text(t.$2, style: const TextStyle(fontSize: 13)),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  if (v != null) setState(() => _questionType = v);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: DesignSpacing.md),

                        // Difficulty
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Difficulty',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: DesignColors.neutral700,
                                ),
                              ),
                              const SizedBox(height: DesignSpacing.xs),
                              DropdownButtonFormField<String>(
                                initialValue: _difficulty,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                items: _difficulties.map((d) {
                                  return DropdownMenuItem(
                                    value: d,
                                    child: Text(
                                      d.toUpperCase(),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  if (v != null) setState(() => _difficulty = v);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DesignSpacing.md),

                    // Regulatory Tag
                    const Text(
                      'Regulatory Tag',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: DesignColors.neutral700,
                      ),
                    ),
                    const SizedBox(height: DesignSpacing.xs),
                    DropdownButtonFormField<String>(
                      initialValue: _regulatoryTag,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: _regulatoryTags.map((tag) {
                        return DropdownMenuItem(
                          value: tag,
                          child: Text(tag, style: const TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _regulatoryTag = v);
                      },
                    ),
                    const SizedBox(height: DesignSpacing.lg),

                    // Answer Options (for multiple choice)
                    if (_questionType == 'multiple_choice') ...[
                      const Text(
                        'Answer Options',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: DesignColors.neutral700,
                        ),
                      ),
                      const SizedBox(height: DesignSpacing.xs),
                      ...List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: DesignSpacing.sm),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: _correctAnswerIndex,
                                onChanged: (v) {
                                  if (v != null) setState(() => _correctAnswerIndex = v);
                                },
                                activeColor: DesignColors.success,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _optionsControllers[index],
                                  decoration: InputDecoration(
                                    hintText: 'Option ${String.fromCharCode(65 + index)}',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    prefixIcon: Container(
                                      width: 32,
                                      alignment: Alignment.center,
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: DesignColors.neutral600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: DesignSpacing.xs),
                      Text(
                        '● Select the radio button next to the correct answer',
                        style: TextStyle(
                          fontSize: 11,
                          color: DesignColors.neutral500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],

                    // True/False Options
                    if (_questionType == 'true_false') ...[
                      const Text(
                        'Correct Answer',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: DesignColors.neutral700,
                        ),
                      ),
                      const SizedBox(height: DesignSpacing.xs),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              value: 0,
                              groupValue: _correctAnswerIndex,
                              onChanged: (v) {
                                if (v != null) setState(() => _correctAnswerIndex = v);
                              },
                              title: const Text('True'),
                              activeColor: DesignColors.success,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: _correctAnswerIndex == 0
                                      ? DesignColors.success
                                      : DesignColors.neutral300,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: DesignSpacing.sm),
                          Expanded(
                            child: RadioListTile<int>(
                              value: 1,
                              groupValue: _correctAnswerIndex,
                              onChanged: (v) {
                                if (v != null) setState(() => _correctAnswerIndex = v);
                              },
                              title: const Text('False'),
                              activeColor: DesignColors.success,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: _correctAnswerIndex == 1
                                      ? DesignColors.success
                                      : DesignColors.neutral300,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(DesignSpacing.md),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: DesignColors.neutral200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: DesignColors.neutral700,
                      side: const BorderSide(color: DesignColors.neutral300),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: DesignSpacing.sm),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DesignColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Add Question'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter question text'),
          backgroundColor: DesignColors.warning,
        ),
      );
      return;
    }

    String optionsJson;
    String correctAnswer;

    if (_questionType == 'multiple_choice') {
      final options = _optionsControllers
          .map((c) => c.text.trim())
          .where((t) => t.isNotEmpty)
          .toList();
      if (options.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide at least 2 options'),
            backgroundColor: DesignColors.warning,
          ),
        );
        return;
      }
      optionsJson = jsonEncode(options);
      correctAnswer = _correctAnswerIndex.toString();
    } else if (_questionType == 'true_false') {
      optionsJson = jsonEncode(['True', 'False']);
      correctAnswer = _correctAnswerIndex.toString();
    } else {
      optionsJson = '[]';
      correctAnswer = '';
    }

    Navigator.pop(context, {
      'text': _textController.text.trim(),
      'questionType': _questionType,
      'optionsJson': optionsJson,
      'correctAnswer': correctAnswer,
      'difficulty': _difficulty,
      'regulatoryTag': _regulatoryTag,
    });
  }
}
