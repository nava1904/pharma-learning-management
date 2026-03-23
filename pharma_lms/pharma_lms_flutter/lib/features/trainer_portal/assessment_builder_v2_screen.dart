import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

class AssessmentBuilderV2Screen extends ConsumerStatefulWidget {
  const AssessmentBuilderV2Screen({super.key, required this.courseId});

  final int courseId;

  @override
  ConsumerState<AssessmentBuilderV2Screen> createState() =>
      _AssessmentBuilderV2ScreenState();
}

class _AssessmentBuilderV2ScreenState
    extends ConsumerState<AssessmentBuilderV2Screen> {
  bool _isLoading = true;
  String? _errorMessage;
  bool _isSaving = false;

  List<CourseVersion> _courseVersions = [];
  int? _effectiveCourseVersionId;

  Assessment? _assessment;

  QuestionBank? _questionBank;
  List<QuestionBank> _allQuestionBanks = [];
  int? _selectedQuestionBankId;

  List<Question> _questions = [];

  int _passingScore = 80;
  int _maxAttempts = 3;
  int _timeLimitMinutes = 60;
  bool _shuffleQuestions = true;
  bool _showFeedback = false;
  int _displayCount = 10;

  String _searchQuery = '';
  String _filterDifficulty = 'All';
  String _filterCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      if (widget.courseId > 0) {
        await _loadCourseAssessment();
      } else {
        await _loadStandaloneMode();
      }
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadCourseAssessment() async {
    final versions = await client.course.getCourseVersions(widget.courseId);
    _courseVersions = versions;

    if (versions.isEmpty) {
      _errorMessage = 'No versions found for this course.';
      return;
    }

    final effective =
        versions.where((v) => v.status == 'effective').toList();
    final target = effective.isNotEmpty ? effective.last : versions.last;
    _effectiveCourseVersionId = target.id;

    final existingAssessment =
        await client.assessment.getAssessmentForCourse(target.id!);

    if (existingAssessment != null) {
      _assessment = existingAssessment;
      _passingScore = existingAssessment.passingScore;
      _shuffleQuestions = existingAssessment.randomize;
      _timeLimitMinutes = existingAssessment.timeLimitMinutes ?? 60;
      _maxAttempts = existingAssessment.maxAttempts ?? 3;
      _displayCount = existingAssessment.questionsToDisplay ?? 10;
      _selectedQuestionBankId = existingAssessment.questionBankId;
      _questionBank = existingAssessment.questionBank;
      await _loadQuestionsForBank(existingAssessment.questionBankId);
    } else {
      final user = await ref.read(currentUserProvider.future);
      _allQuestionBanks = await client.assessment.listQuestionBanks(
        organizationId: user?.organizationId,
      );
    }
  }

  Future<void> _loadStandaloneMode() async {
    final user = await ref.read(currentUserProvider.future);
    _allQuestionBanks = await client.assessment.listQuestionBanks(
      organizationId: user?.organizationId,
    );
    if (_allQuestionBanks.isNotEmpty) {
      _selectedQuestionBankId = _allQuestionBanks.first.id;
      _questionBank = _allQuestionBanks.first;
      await _loadQuestionsForBank(_allQuestionBanks.first.id!);
    }
  }

  Future<void> _loadQuestionsForBank(int questionBankId) async {
    final questions = await client.assessment.getQuestions(questionBankId);
    _questions = questions;
    _selectedQuestionBankId = questionBankId;

    if (_questionBank == null || _questionBank!.id != questionBankId) {
      _questionBank =
          _allQuestionBanks.where((b) => b.id == questionBankId).firstOrNull;
    }
  }

  List<Question> get _filteredQuestions {
    return _questions.where((q) {
      if (_searchQuery.isNotEmpty &&
          !q.text.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      final diff = (q.difficulty ?? '').toLowerCase();
      if (_filterDifficulty != 'All' &&
          diff != _filterDifficulty.toLowerCase()) {
        return false;
      }
      final tag = q.regulatoryTag ?? '';
      if (_filterCategory != 'All' && tag != _filterCategory) return false;
      return true;
    }).toList();
  }

  int get _totalInPool => _questions.length;

  bool get _poolValid => _displayCount <= (_totalInPool / 2).floor();

  List<String> get _difficultyOptions {
    final diffs =
        _questions.map((q) => _capitalize(q.difficulty ?? 'Unknown')).toSet();
    return ['All', ...diffs];
  }

  List<String> get _categoryOptions {
    final cats =
        _questions.map((q) => q.regulatoryTag ?? 'Uncategorized').toSet();
    return ['All', ...cats];
  }

  Future<void> _saveAssessment() async {
    if (_effectiveCourseVersionId == null && widget.courseId > 0) {
      _showSnackBar('No course version available', isError: true);
      return;
    }
    if (_selectedQuestionBankId == null) {
      _showSnackBar('Please select a question bank first', isError: true);
      return;
    }
    if (!_poolValid) {
      _showSnackBar(
        'Display count must be ≤ ${(_totalInPool / 2).floor()} (pool / 2)',
        isError: true,
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      if (_assessment != null && _assessment!.id != null) {
        final updated = await client.assessmentBuilder.updateAssessment(
          assessmentId: _assessment!.id!,
          passingScore: _passingScore,
          randomize: _shuffleQuestions,
          timeLimitMinutes: _timeLimitMinutes,
          maxAttempts: _maxAttempts,
          questionsToDisplay: _displayCount,
        );
        setState(() => _assessment = updated);
        _showSnackBar('Assessment updated successfully');
      } else {
        final created = await client.assessmentBuilder.createAssessment(
          courseVersionId: _effectiveCourseVersionId!,
          questionBankId: _selectedQuestionBankId!,
          passingScore: _passingScore,
          randomize: _shuffleQuestions,
          timeLimitMinutes: _timeLimitMinutes,
          maxAttempts: _maxAttempts,
          questionsToDisplay: _displayCount,
        );
        setState(() => _assessment = created);
        _showSnackBar('Assessment created successfully');
      }
    } catch (e) {
      _showSnackBar('Failed to save: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _addQuestion(
    String text,
    String questionType,
    String optionsJson,
    String correctAnswer,
    String? difficulty,
    String? regulatoryTag,
  ) async {
    if (_selectedQuestionBankId == null) {
      _showSnackBar('No question bank selected', isError: true);
      return;
    }
    try {
      final question = await client.assessmentBuilder.createQuestion(
        questionBankId: _selectedQuestionBankId!,
        text: text,
        questionType: questionType,
        optionsJson: optionsJson,
        correctAnswer: correctAnswer,
        difficulty: difficulty,
        regulatoryTag: regulatoryTag,
      );
      setState(() => _questions.add(question));
      _showSnackBar('Question added');
    } catch (e) {
      _showSnackBar('Failed to add question: $e', isError: true);
    }
  }

  Future<void> _editQuestion(
    Question existing,
    String text,
    String questionType,
    String optionsJson,
    String correctAnswer,
    String? difficulty,
  ) async {
    try {
      final updated = await client.assessmentBuilder.updateQuestion(
        questionId: existing.id!,
        text: text,
        questionType: questionType,
        optionsJson: optionsJson,
        correctAnswer: correctAnswer,
        difficulty: difficulty,
      );
      setState(() {
        final idx = _questions.indexWhere((q) => q.id == existing.id);
        if (idx >= 0) _questions[idx] = updated;
      });
      _showSnackBar('Question updated');
    } catch (e) {
      _showSnackBar('Failed to update question: $e', isError: true);
    }
  }

  Future<void> _deleteQuestion(Question q) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PharmaRadius.xl),
        ),
        title: const Text('Delete Question?'),
        content: Text(
          'Are you sure you want to delete this question?\n\n"${q.text}"',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await client.assessmentBuilder.deleteQuestion(questionId: q.id!);
      setState(() => _questions.removeWhere((x) => x.id == q.id));
      _showSnackBar('Question deleted');
    } catch (e) {
      _showSnackBar('Failed to delete: $e', isError: true);
    }
  }

  Future<void> _createNewQuestionBank() async {
    final nameController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PharmaRadius.xl),
        ),
        title: const Text('Create Question Bank'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Enter bank name…',
            filled: true,
            fillColor: PharmaColors.pageBg,
            border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, nameController.text.trim()),
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (result == null || result.isEmpty) return;

    try {
      final user = await ref.read(currentUserProvider.future);
      if (user?.organizationId == null) {
        _showSnackBar('User has no organization assigned', isError: true);
        return;
      }
      final bank = await client.assessmentBuilder.createQuestionBank(
        name: result,
        organizationId: user!.organizationId,
      );
      setState(() {
        _allQuestionBanks.add(bank);
        _selectedQuestionBankId = bank.id;
        _questionBank = bank;
        _questions = [];
      });
      _showSnackBar('Question bank "${bank.name}" created');
    } catch (e) {
      _showSnackBar('Failed to create bank: $e', isError: true);
    }
  }

  Future<void> _selectQuestionBank(QuestionBank bank) async {
    setState(() => _isLoading = true);
    try {
      await _loadQuestionsForBank(bank.id!);
      setState(() => _questionBank = bank);
    } catch (e) {
      _showSnackBar('Failed to load questions: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? PharmaColors.danger : PharmaColors.emerald600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  String _optionsSummary(String optionsJson) {
    try {
      final decoded = jsonDecode(optionsJson);
      if (decoded is List) return '${decoded.length} options';
      return optionsJson.length > 30
          ? '${optionsJson.substring(0, 30)}…'
          : optionsJson;
    } catch (_) {
      return optionsJson.length > 30
          ? '${optionsJson.substring(0, 30)}…'
          : optionsJson;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: PharmaTypography.body.copyWith(color: PharmaColors.danger),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Retry'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: PharmaSpacing.sectionGap),
        if (_assessment == null && _selectedQuestionBankId == null)
          _buildBankSelector()
        else if (_selectedQuestionBankId != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _buildQuestionBank()),
              const SizedBox(width: 24),
              SizedBox(width: 320, child: _buildConfigPanel()),
            ],
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (widget.courseId > 0) {
              context.go('/trainer/courses/${widget.courseId}/builder');
            } else {
              context.go('/trainer');
            }
          },
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Icon(Icons.quiz_outlined, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assessment Builder',
                style: PharmaTypography.headingLarge
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text(
                _assessment != null
                    ? 'Editing assessment #${_assessment!.id}'
                    : 'Configure questions and assessment rules',
                style: PharmaTypography.body
                    .copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ),
        if (_selectedQuestionBankId != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _poolValid
                  ? PharmaColors.successBg
                  : PharmaColors.dangerBg,
              borderRadius: PharmaRadius.pillRadius,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _poolValid ? Icons.check_circle : Icons.warning,
                  size: 14,
                  color: _poolValid
                      ? PharmaColors.successText
                      : PharmaColors.danger,
                ),
                const SizedBox(width: 6),
                Text(
                  'Pool: $_totalInPool questions · Display: $_displayCount',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _poolValid
                        ? PharmaColors.successText
                        : PharmaColors.danger,
                  ),
                ),
              ],
            ),
          ),
          if (widget.courseId > 0) ...[
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: _isSaving ? null : _saveAssessment,
              icon: _isSaving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: PharmaColors.cardBg,
                      ),
                    )
                  : const Icon(Icons.save, size: 16),
              label: Text(
                _assessment != null ? 'Update Assessment' : 'Save Assessment',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildBankSelector() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Question Bank', style: PharmaTypography.headingSmall),
          const SizedBox(height: 8),
          Text(
            'Choose an existing question bank or create a new one to get started.',
            style:
                PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
          ),
          const SizedBox(height: 20),
          if (_allQuestionBanks.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.folder_open, size: 48, color: PharmaColors.gray300),
                  const SizedBox(height: 12),
                  Text('No question banks found',
                      style: PharmaTypography.body),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _createNewQuestionBank,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Create Question Bank'),
                    style: FilledButton.styleFrom(
                      backgroundColor: PharmaColors.emerald600,
                      foregroundColor: PharmaColors.cardBg,
                    ),
                  ),
                ],
              ),
            )
          else ...[
            ..._allQuestionBanks.map(_buildBankTile),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _createNewQuestionBank,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Create New Bank'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBankTile(QuestionBank bank) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => _selectQuestionBank(bank),
        leading: Icon(Icons.library_books, color: PharmaColors.emerald600),
        title: Text(bank.name, style: PharmaTypography.bodyMedium),
        subtitle: Text(
          'Bank #${bank.id}',
          style: PharmaTypography.caption,
        ),
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(
          borderRadius: PharmaRadius.cardRadius,
          side: BorderSide(color: PharmaColors.borderLight),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildQuestionBank() {
    final filtered = _filteredQuestions;

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _questionBank != null
                          ? 'Question Bank: ${_questionBank!.name}'
                          : 'Question Bank',
                      style: PharmaTypography.headingSmall
                          .copyWith(fontSize: 15),
                    ),
                    const Spacer(),
                    FilledButton.tonal(
                      onPressed: _showAddQuestionDialog,
                      child: const Text('+ Add Question'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () =>
                          context.go('/trainer/assessments/ai-generate'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome,
                              size: 16, color: PharmaColors.emerald600),
                          const SizedBox(width: 6),
                          const Text('AI Generate'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (v) =>
                            setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search questions…',
                          prefixIcon: const Icon(Icons.search, size: 18),
                          filled: true,
                          fillColor: PharmaColors.pageBg,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: PharmaRadius.inputRadius,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildDropdown(
                      'Difficulty',
                      _filterDifficulty,
                      _difficultyOptions,
                      (v) => setState(() => _filterDifficulty = v),
                    ),
                    const SizedBox(width: 8),
                    _buildDropdown(
                      'Category',
                      _filterCategory,
                      _categoryOptions,
                      (v) => setState(() => _filterCategory = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...filtered.map(_buildQuestionRow),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.quiz_outlined,
                        size: 40, color: PharmaColors.gray300),
                    const SizedBox(height: 12),
                    Text(
                      _questions.isEmpty
                          ? 'No questions yet. Add your first question.'
                          : 'No questions match filters',
                      style: PharmaTypography.body
                          .copyWith(color: PharmaColors.textTertiary),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(Question q) {
    final difficulty = _capitalize(q.difficulty ?? 'Unknown');
    final category = q.regulatoryTag ?? 'Uncategorized';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PharmaColors.borderLight.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q.text,
                  style: PharmaTypography.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${q.questionType} · ${_optionsSummary(q.optionsJson)}',
                  style: PharmaTypography.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _DifficultyChip(difficulty: difficulty),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: PharmaColors.gray100,
              borderRadius: PharmaRadius.pillRadius,
            ),
            child: Text(
              category,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _showEditQuestionDialog(q),
            icon: Icon(Icons.edit_outlined,
                size: 16, color: PharmaColors.textTertiary),
            tooltip: 'Edit question',
          ),
          IconButton(
            onPressed: () => _deleteQuestion(q),
            icon: Icon(Icons.delete_outline,
                size: 16, color: PharmaColors.danger),
            tooltip: 'Delete question',
          ),
        ],
      ),
    );
  }

  Widget _buildConfigPanel() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assessment Configuration',
                style:
                    PharmaTypography.headingSmall.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 20),
              _configLabel('Passing Score (%)'),
              Slider(
                value: _passingScore.toDouble(),
                min: 50,
                max: 100,
                divisions: 10,
                activeColor: PharmaColors.emerald600,
                label: '$_passingScore%',
                onChanged: (v) =>
                    setState(() => _passingScore = v.toInt()),
              ),
              Text(
                '$_passingScore%',
                textAlign: TextAlign.center,
                style: PharmaTypography.statNumber.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 16),
              _configLabel('Maximum Attempts'),
              DropdownButtonFormField<int>(
                initialValue: _maxAttempts,
                items: [1, 2, 3, 5, 10]
                    .map((a) => DropdownMenuItem(
                        value: a, child: Text('$a attempts')))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _maxAttempts = v ?? 3),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _configLabel('Time Limit (minutes)'),
              TextField(
                controller:
                    TextEditingController(text: '$_timeLimitMinutes'),
                keyboardType: TextInputType.number,
                onChanged: (v) => setState(
                    () => _timeLimitMinutes = int.tryParse(v) ?? 60),
                decoration: InputDecoration(
                  suffixText: 'min',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _configLabel('Display Questions'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          TextEditingController(text: '$_displayCount'),
                      keyboardType: TextInputType.number,
                      onChanged: (v) => setState(
                          () => _displayCount = int.tryParse(v) ?? 10),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PharmaColors.pageBg,
                        border: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('of $_totalInPool', style: PharmaTypography.body),
                ],
              ),
              if (!_poolValid)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber,
                          size: 14, color: PharmaColors.danger),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Display count must be ≤ ${(_totalInPool / 2).floor()} (total / 2)',
                          style: TextStyle(
                              fontSize: 11, color: PharmaColors.danger),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              SwitchListTile(
                value: _shuffleQuestions,
                onChanged: (v) =>
                    setState(() => _shuffleQuestions = v),
                title: Text('Shuffle Questions',
                    style: PharmaTypography.bodyMedium),
                contentPadding: EdgeInsets.zero,
                activeThumbColor: PharmaColors.emerald600,
              ),
              SwitchListTile(
                value: _showFeedback,
                onChanged: (v) =>
                    setState(() => _showFeedback = v),
                title: Text('Show Answer Feedback',
                    style: PharmaTypography.bodyMedium),
                contentPadding: EdgeInsets.zero,
                activeThumbColor: PharmaColors.emerald600,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _selectedQuestionBankId == null || _displayCount <= 0
                      ? null
                      : () async {
                          try {
                            final preview =
                                await client.assessment.generateRandomAssessment(
                              questionBankId: _selectedQuestionBankId!,
                              count: _displayCount,
                            );
                            if (!mounted) return;
                            _showRandomPreviewDialog(preview);
                          } catch (e) {
                            _showSnackBar('Preview failed: $e', isError: true);
                          }
                        },
                  icon: const Icon(Icons.shuffle, size: 16),
                  label: const Text('Random Preview'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.info,
                    side: BorderSide(color: PharmaColors.info),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Difficulty Distribution',
                style:
                    PharmaTypography.headingSmall.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 16),
              _diffBar(
                'Easy',
                _questions
                    .where((q) =>
                        (q.difficulty ?? '').toLowerCase() == 'easy')
                    .length,
                PharmaColors.emerald600,
              ),
              _diffBar(
                'Medium',
                _questions
                    .where((q) =>
                        (q.difficulty ?? '').toLowerCase() == 'medium')
                    .length,
                PharmaColors.warningText,
              ),
              _diffBar(
                'Hard',
                _questions
                    .where((q) =>
                        (q.difficulty ?? '').toLowerCase() == 'hard')
                    .length,
                PharmaColors.danger,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _diffBar(String label, int count, Color color) {
    final frac = _totalInPool > 0 ? count / _totalInPool : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(label,
                style: PharmaTypography.caption
                    .copyWith(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: frac,
                backgroundColor: PharmaColors.gray100,
                color: color,
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('$count',
              style: PharmaTypography.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _configLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: PharmaTypography.labelLarge
            .copyWith(fontSize: 12, color: PharmaColors.textSecondary),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    final safeValue = items.contains(value) ? value : items.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: PharmaRadius.inputRadius,
      ),
      child: DropdownButton<String>(
        value: safeValue,
        underline: const SizedBox.shrink(),
        isDense: true,
        style: PharmaTypography.caption
            .copyWith(color: PharmaColors.textPrimary),
        items: items
            .map((i) => DropdownMenuItem(value: i, child: Text(i)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  void _showRandomPreviewDialog(List<Question> preview) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PharmaRadius.xl),
        ),
        title: Text('Random Preview (${preview.length} questions)'),
        content: SizedBox(
          width: 520,
          height: 400,
          child: ListView.separated(
            itemCount: preview.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final q = preview[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Q${i + 1}. ${q.text}',
                      style: PharmaTypography.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_capitalize(q.difficulty ?? 'Unknown')} · ${q.questionType} · Answer: ${q.correctAnswer}',
                      style: PharmaTypography.caption,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddQuestionDialog() {
    final textCtl = TextEditingController();
    final optionsCtl = TextEditingController(
      text: '["Option A", "Option B", "Option C", "Option D"]',
    );
    final correctCtl = TextEditingController(text: '0');
    String questionType = 'multiple_choice';
    String difficulty = 'medium';
    String category = 'GMP';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl),
          ),
          title: const Text('Add Question'),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textCtl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter question text…',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: questionType,
                          items: ['multiple_choice', 'true_false']
                              .map((t) => DropdownMenuItem(
                                  value: t, child: Text(t)))
                              .toList(),
                          onChanged: (v) => setDialogState(
                              () => questionType = v ?? 'multiple_choice'),
                          decoration: InputDecoration(
                            labelText: 'Type',
                            filled: true,
                            fillColor: PharmaColors.pageBg,
                            border: OutlineInputBorder(
                              borderRadius: PharmaRadius.inputRadius,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: difficulty,
                          items: ['easy', 'medium', 'hard']
                              .map((d) => DropdownMenuItem(
                                  value: d, child: Text(_capitalize(d))))
                              .toList(),
                          onChanged: (v) => setDialogState(
                              () => difficulty = v ?? 'medium'),
                          decoration: InputDecoration(
                            labelText: 'Difficulty',
                            filled: true,
                            fillColor: PharmaColors.pageBg,
                            border: OutlineInputBorder(
                              borderRadius: PharmaRadius.inputRadius,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: category,
                    items: [
                      'GMP',
                      'Data Integrity',
                      'Quality',
                      'Process',
                      'Compliance',
                      'Validation',
                      '21 CFR 11',
                      'ICH Q10',
                    ]
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) =>
                        setDialogState(() => category = v ?? 'GMP'),
                    decoration: InputDecoration(
                      labelText: 'Regulatory Tag',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: optionsCtl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          'Options as JSON array, e.g. ["A","B","C","D"]',
                      labelText: 'Options (JSON)',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: correctCtl,
                    decoration: InputDecoration(
                      hintText: 'Index of correct answer (0-based)',
                      labelText: 'Correct Answer',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (textCtl.text.trim().isEmpty) return;
                Navigator.pop(ctx);
                _addQuestion(
                  textCtl.text.trim(),
                  questionType,
                  optionsCtl.text.trim(),
                  correctCtl.text.trim(),
                  difficulty,
                  category,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
              ),
              child: const Text('Add to Pool'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditQuestionDialog(Question q) {
    final textCtl = TextEditingController(text: q.text);
    final optionsCtl = TextEditingController(text: q.optionsJson);
    final correctCtl = TextEditingController(text: q.correctAnswer);
    String questionType = q.questionType;
    String difficulty = (q.difficulty ?? 'medium').toLowerCase();
    if (!['easy', 'medium', 'hard'].contains(difficulty)) {
      difficulty = 'medium';
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl),
          ),
          title: const Text('Edit Question'),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textCtl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter question text…',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: questionType,
                          items: ['multiple_choice', 'true_false']
                              .map((t) => DropdownMenuItem(
                                  value: t, child: Text(t)))
                              .toList(),
                          onChanged: (v) => setDialogState(
                              () => questionType = v ?? 'multiple_choice'),
                          decoration: InputDecoration(
                            labelText: 'Type',
                            filled: true,
                            fillColor: PharmaColors.pageBg,
                            border: OutlineInputBorder(
                              borderRadius: PharmaRadius.inputRadius,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: difficulty,
                          items: ['easy', 'medium', 'hard']
                              .map((d) => DropdownMenuItem(
                                  value: d, child: Text(_capitalize(d))))
                              .toList(),
                          onChanged: (v) => setDialogState(
                              () => difficulty = v ?? 'medium'),
                          decoration: InputDecoration(
                            labelText: 'Difficulty',
                            filled: true,
                            fillColor: PharmaColors.pageBg,
                            border: OutlineInputBorder(
                              borderRadius: PharmaRadius.inputRadius,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: optionsCtl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Options (JSON)',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: correctCtl,
                    decoration: InputDecoration(
                      labelText: 'Correct Answer',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                        borderRadius: PharmaRadius.inputRadius,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (textCtl.text.trim().isEmpty) return;
                Navigator.pop(ctx);
                _editQuestion(
                  q,
                  textCtl.text.trim(),
                  questionType,
                  optionsCtl.text.trim(),
                  correctCtl.text.trim(),
                  difficulty,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty});
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (difficulty.toLowerCase()) {
      case 'easy':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
      case 'medium':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
      case 'hard':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.danger;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration:
          BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(
        difficulty,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
