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

  List<CourseVersion> _courseVersions = []; // ignore: unused_field
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
  int _displayCount = 10;
  bool _showAnswers = false;
  bool _showSubmissionHistory = false;

  int? _expandedQuestionId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DATA LOADING (unchanged logic)
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _loadData() async {
    setState(() { _isLoading = true; _errorMessage = null; });
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
    if (versions.isEmpty) { _errorMessage = 'No versions found for this course.'; return; }
    final effective = versions.where((v) => v.status == 'effective').toList();
    final target = effective.isNotEmpty ? effective.last : versions.last;
    _effectiveCourseVersionId = target.id;
    final existingAssessment = await client.assessment.getAssessmentForCourse(target.id!);
    if (existingAssessment != null) {
      _assessment = existingAssessment;
      _passingScore = existingAssessment.passingScore;
      _shuffleQuestions = existingAssessment.randomize;
      _timeLimitMinutes = existingAssessment.timeLimitMinutes ?? 60;
      _maxAttempts = existingAssessment.maxAttempts ?? 3;
      _displayCount = existingAssessment.questionsToDisplay ?? 10;
      _showAnswers = existingAssessment.showAnswers;
      _showSubmissionHistory = existingAssessment.showSubmissionHistory;
      _selectedQuestionBankId = existingAssessment.questionBankId;
      _questionBank = existingAssessment.questionBank;
      await _loadQuestionsForBank(existingAssessment.questionBankId);
    } else {
      final user = await ref.read(currentUserProvider.future);
      _allQuestionBanks = await client.assessment.listQuestionBanks(organizationId: user?.organizationId);
    }
  }

  Future<void> _loadStandaloneMode() async {
    final user = await ref.read(currentUserProvider.future);
    _allQuestionBanks = await client.assessment.listQuestionBanks(organizationId: user?.organizationId);
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
      _questionBank = _allQuestionBanks.where((b) => b.id == questionBankId).firstOrNull;
    }
  }

  int get _totalInPool => _questions.length;
  bool get _poolValid => _displayCount <= (_totalInPool / 2).floor();

  // ═══════════════════════════════════════════════════════════════════════════
  // SAVE / CRUD (unchanged logic, _showFeedback removed — consolidated into showAnswers)
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _saveAssessment() async {
    if (_effectiveCourseVersionId == null && widget.courseId > 0) { _snack('No course version available', err: true); return; }
    if (_selectedQuestionBankId == null) { _snack('Please select a question bank first', err: true); return; }
    if (!_poolValid) { _snack('Display count must be ≤ ${(_totalInPool / 2).floor()} (pool / 2)', err: true); return; }

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
          showAnswers: _showAnswers,
          showSubmissionHistory: _showSubmissionHistory,
        );
        setState(() => _assessment = updated);
        _snack('Assessment updated successfully');
      } else {
        final created = await client.assessmentBuilder.createAssessment(
          courseVersionId: _effectiveCourseVersionId!,
          questionBankId: _selectedQuestionBankId!,
          passingScore: _passingScore,
          randomize: _shuffleQuestions,
          timeLimitMinutes: _timeLimitMinutes,
          maxAttempts: _maxAttempts,
          questionsToDisplay: _displayCount,
          showAnswers: _showAnswers,
          showSubmissionHistory: _showSubmissionHistory,
        );
        setState(() => _assessment = created);
        _snack('Assessment created successfully');
      }
    } catch (e) {
      _snack('Failed to save: $e', err: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _addQuestion(String text, String questionType, String optionsJson, String correctAnswer, String? difficulty, String? regulatoryTag) async {
    if (_selectedQuestionBankId == null) { _snack('No question bank selected', err: true); return; }
    try {
      final question = await client.assessmentBuilder.createQuestion(
        questionBankId: _selectedQuestionBankId!,
        text: text, questionType: questionType, optionsJson: optionsJson,
        correctAnswer: correctAnswer, difficulty: difficulty, regulatoryTag: regulatoryTag,
      );
      setState(() => _questions.add(question));
      _snack('Question added');
    } catch (e) { _snack('Failed to add question: $e', err: true); }
  }

  Future<void> _editQuestion(Question existing, String text, String questionType, String optionsJson, String correctAnswer, String? difficulty) async {
    try {
      final updated = await client.assessmentBuilder.updateQuestion(
        questionId: existing.id!, text: text, questionType: questionType,
        optionsJson: optionsJson, correctAnswer: correctAnswer, difficulty: difficulty,
      );
      setState(() { final idx = _questions.indexWhere((q) => q.id == existing.id); if (idx >= 0) _questions[idx] = updated; });
      _snack('Question updated');
    } catch (e) { _snack('Failed to update question: $e', err: true); }
  }

  Future<void> _deleteQuestion(Question q) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Delete Question?'),
        content: Text('Are you sure you want to delete this question?\n\n"${q.text}"'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await client.assessmentBuilder.deleteQuestion(questionId: q.id!);
      setState(() => _questions.removeWhere((x) => x.id == q.id));
      _snack('Question deleted');
    } catch (e) { _snack('Failed to delete: $e', err: true); }
  }

  Future<void> _createNewQuestionBank() async {
    final nameController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Create Question Bank'),
        content: TextField(controller: nameController, decoration: InputDecoration(hintText: 'Enter bank name…', filled: true, fillColor: PharmaColors.pageBg, border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, nameController.text.trim()), style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600), child: const Text('Create')),
        ],
      ),
    );
    if (result == null || result.isEmpty) return;
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user?.organizationId == null) { _snack('User has no organization assigned', err: true); return; }
      final bank = await client.assessmentBuilder.createQuestionBank(name: result, organizationId: user!.organizationId);
      setState(() { _allQuestionBanks.add(bank); _selectedQuestionBankId = bank.id; _questionBank = bank; _questions = []; });
      _snack('Question bank "${bank.name}" created');
    } catch (e) { _snack('Failed to create bank: $e', err: true); }
  }

  Future<void> _selectQuestionBank(QuestionBank bank) async {
    setState(() => _isLoading = true);
    try {
      await _loadQuestionsForBank(bank.id!);
      setState(() => _questionBank = bank);
    } catch (e) { _snack('Failed to load questions: $e', err: true); }
    finally { if (mounted) setState(() => _isLoading = false); }
  }

  void _snack(String message, {bool err = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: err ? PharmaColors.danger : PharmaColors.emerald600,
      behavior: SnackBarBehavior.floating,
    ));
  }

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_errorMessage != null) {
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
        const SizedBox(height: 16),
        Text(_errorMessage!, style: PharmaTypography.body.copyWith(color: PharmaColors.danger), textAlign: TextAlign.center),
        const SizedBox(height: 16),
        FilledButton.icon(onPressed: _loadData, icon: const Icon(Icons.refresh, size: 16), label: const Text('Retry'), style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg)),
      ]));
    }

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        if (_assessment == null && _selectedQuestionBankId == null)
          _buildBankSelector()
        else if (_selectedQuestionBankId != null) ...[
          _buildSettingsCard(),
          const SizedBox(height: 20),
          _buildQuestionsSection(),
        ],
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HEADER
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (widget.courseId > 0) { context.go('/trainer/courses/${widget.courseId}/builder'); }
            else { context.go('/trainer'); }
          },
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Icon(Icons.quiz_outlined, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Assessment Builder', style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
          Text(_assessment != null ? 'Editing assessment · ${_questions.length} questions in pool' : 'Configure quiz settings and add questions', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
        ])),
        if (_selectedQuestionBankId != null && widget.courseId > 0) ...[
          FilledButton.icon(
            onPressed: _isSaving ? null : _saveAssessment,
            icon: _isSaving
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: PharmaColors.cardBg))
                : const Icon(Icons.save, size: 16),
            label: Text(_assessment != null ? 'Update' : 'Save'),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
          ),
          if (_assessment != null) ...[
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => context.go('/trainer/assessments/grading/${_assessment!.id}'),
              icon: const Icon(Icons.grading, size: 16),
              label: const Text('Grade'),
              style: OutlinedButton.styleFrom(foregroundColor: PharmaColors.info, side: BorderSide(color: PharmaColors.info), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
            ),
          ],
        ],
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BANK SELECTOR (unchanged)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildBankSelector() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius, border: Border.all(color: PharmaColors.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Select Question Bank', style: PharmaTypography.headingSmall),
        const SizedBox(height: 8),
        Text('Choose an existing question bank or create a new one to get started.', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
        const SizedBox(height: 20),
        if (_allQuestionBanks.isEmpty)
          Center(child: Column(children: [
            Icon(Icons.folder_open, size: 48, color: PharmaColors.gray300),
            const SizedBox(height: 12),
            Text('No question banks found', style: PharmaTypography.body),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: _createNewQuestionBank, icon: const Icon(Icons.add, size: 16), label: const Text('Create Question Bank'), style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg)),
          ]))
        else ...[
          ..._allQuestionBanks.map((bank) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              onTap: () => _selectQuestionBank(bank),
              leading: Icon(Icons.library_books, color: PharmaColors.emerald600),
              title: Text(bank.name, style: PharmaTypography.bodyMedium),
              subtitle: Text('Question bank', style: PharmaTypography.caption),
              trailing: const Icon(Icons.chevron_right),
              shape: RoundedRectangleBorder(borderRadius: PharmaRadius.cardRadius, side: BorderSide(color: PharmaColors.borderLight)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
          )),
          const SizedBox(height: 12),
          OutlinedButton.icon(onPressed: _createNewQuestionBank, icon: const Icon(Icons.add, size: 16), label: const Text('Create New Bank')),
        ],
      ]),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SETTINGS CARD (Frappe-style single-column form)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildSettingsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius, border: Border.all(color: PharmaColors.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.settings_outlined, size: 18, color: PharmaColors.emerald600),
          const SizedBox(width: 8),
          Text('Quiz Settings', style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          if (_questionBank != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: PharmaRadius.pillRadius),
              child: Text('Bank: ${_questionBank!.name}', style: PharmaTypography.caption.copyWith(color: PharmaColors.emerald700, fontWeight: FontWeight.w600)),
            ),
        ]),
        const SizedBox(height: 20),

        // Row 1: Max Attempts + Duration + Passing Score
        Row(children: [
          Expanded(child: _settingsField(
            label: 'Maximum Attempts',
            helper: '0 = unlimited',
            child: DropdownButtonFormField<int>(
              initialValue: _maxAttempts,
              items: [0, 1, 2, 3, 5, 10].map((a) => DropdownMenuItem(value: a, child: Text(a == 0 ? 'Unlimited' : '$a attempts'))).toList(),
              onChanged: (v) => setState(() => _maxAttempts = v ?? 3),
              decoration: _fieldDecor(),
            ),
          )),
          const SizedBox(width: 16),
          Expanded(child: _settingsField(
            label: 'Duration (minutes)',
            child: TextField(
              controller: TextEditingController(text: '$_timeLimitMinutes'),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => _timeLimitMinutes = int.tryParse(v) ?? 60),
              decoration: _fieldDecor(suffix: 'min'),
            ),
          )),
          const SizedBox(width: 16),
          Expanded(child: _settingsField(
            label: 'Passing Percentage',
            child: TextField(
              controller: TextEditingController(text: '$_passingScore'),
              keyboardType: TextInputType.number,
              onChanged: (v) { final val = int.tryParse(v); if (val != null && val >= 10 && val <= 100) setState(() => _passingScore = val); },
              decoration: _fieldDecor(suffix: '%'),
            ),
          )),
        ]),
        const SizedBox(height: 16),

        // Row 2: Display Questions
        Row(children: [
          Expanded(child: _settingsField(
            label: 'Questions to Display',
            helper: '${_questions.length} total in pool',
            child: Row(children: [
              Expanded(child: TextField(
                controller: TextEditingController(text: '$_displayCount'),
                keyboardType: TextInputType.number,
                onChanged: (v) => setState(() => _displayCount = int.tryParse(v) ?? 10),
                decoration: _fieldDecor(),
              )),
              const SizedBox(width: 8),
              Text('of $_totalInPool', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
            ]),
          )),
          const SizedBox(width: 16),
          Expanded(child: SizedBox()),
          const SizedBox(width: 16),
          Expanded(child: SizedBox()),
        ]),

        if (!_poolValid)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: PharmaColors.dangerBg, borderRadius: PharmaRadius.cardRadius),
              child: Row(children: [
                Icon(Icons.warning_amber, size: 14, color: PharmaColors.danger),
                const SizedBox(width: 8),
                Text('Display count must be ≤ ${(_totalInPool / 2).floor()} (total / 2)', style: TextStyle(fontSize: 12, color: PharmaColors.danger)),
              ]),
            ),
          ),

        const SizedBox(height: 20),
        Divider(color: PharmaColors.borderLight),
        const SizedBox(height: 16),

        // Toggles
        Wrap(spacing: 32, runSpacing: 8, children: [
          _settingsToggle('Shuffle Questions', 'Randomize question order for each attempt', _shuffleQuestions, (v) => setState(() => _shuffleQuestions = v)),
          _settingsToggle('Show Answers', 'Reveal correct answers after submission', _showAnswers, (v) => setState(() => _showAnswers = v)),
          _settingsToggle('Show Submission History', 'Let learners review previous attempts', _showSubmissionHistory, (v) => setState(() => _showSubmissionHistory = v)),
        ]),
      ]),
    );
  }

  Widget _settingsField({required String label, String? helper, required Widget child}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary, fontWeight: FontWeight.w600)),
      if (helper != null) Text(helper, style: PharmaTypography.caption.copyWith(fontSize: 10, color: PharmaColors.textTertiary)),
      const SizedBox(height: 6),
      child,
    ]);
  }

  Widget _settingsToggle(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SizedBox(
      width: 280,
      child: Row(children: [
        Switch(value: value, onChanged: onChanged, activeTrackColor: PharmaColors.emerald600),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
          Text(subtitle, style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontSize: 11)),
        ])),
      ]),
    );
  }

  InputDecoration _fieldDecor({String? suffix}) => InputDecoration(
    suffixText: suffix,
    filled: true, fillColor: PharmaColors.pageBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide(color: PharmaColors.borderLight)),
    enabledBorder: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide(color: PharmaColors.borderLight)),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // QUESTIONS SECTION (expandable cards)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildQuestionsSection() {
    return Container(
      decoration: BoxDecoration(color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius, border: Border.all(color: PharmaColors.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            Icon(Icons.help_outline, size: 18, color: PharmaColors.emerald600),
            const SizedBox(width: 8),
            Text('Questions', style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: PharmaRadius.pillRadius),
              child: Text('${_questions.length}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: PharmaColors.emerald700)),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => _showAddQuestionDialog(),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Question'),
              style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
            ),
          ]),
        ),
        Divider(height: 1, color: PharmaColors.borderLight),

        if (_questions.isEmpty)
          Padding(
            padding: const EdgeInsets.all(40),
            child: Center(child: Column(children: [
              Icon(Icons.quiz_outlined, size: 48, color: PharmaColors.gray300),
              const SizedBox(height: 12),
              Text('No questions yet', style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Click "Add Question" to create your first question.', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
            ])),
          )
        else
          ..._questions.asMap().entries.map((entry) => _buildQuestionCard(entry.key, entry.value)),
      ]),
    );
  }

  Widget _buildQuestionCard(int index, Question q) {
    final isExpanded = _expandedQuestionId == q.id;
    final typeInfo = _questionTypeInfo(q.questionType);

    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: PharmaColors.borderLight.withValues(alpha: 0.5)))),
      child: Column(children: [
        // Collapsed header
        InkWell(
          onTap: () => setState(() => _expandedQuestionId = isExpanded ? null : q.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(children: [
              Container(
                width: 28, height: 28,
                decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: BorderRadius.circular(6)),
                child: Center(child: Text('${index + 1}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: PharmaColors.emerald700))),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: typeInfo.color.withValues(alpha: 0.1), borderRadius: PharmaRadius.pillRadius),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(typeInfo.icon, size: 12, color: typeInfo.color),
                  const SizedBox(width: 4),
                  Text(typeInfo.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: typeInfo.color)),
                ]),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(q.text, style: PharmaTypography.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 8),
              _DifficultyChip(difficulty: _cap(q.difficulty ?? 'Unknown')),
              const SizedBox(width: 8),
              IconButton(icon: Icon(Icons.delete_outline, size: 16, color: PharmaColors.danger), onPressed: () => _deleteQuestion(q), tooltip: 'Delete'),
              Icon(isExpanded ? Icons.expand_less : Icons.expand_more, size: 20, color: PharmaColors.textTertiary),
            ]),
          ),
        ),

        // Expanded editor
        if (isExpanded)
          _QuestionInlineEditor(
            question: q,
            onSave: (text, type, optionsJson, correctAnswer, difficulty) {
              _editQuestion(q, text, type, optionsJson, correctAnswer, difficulty);
              setState(() => _expandedQuestionId = null);
            },
            onCancel: () => setState(() => _expandedQuestionId = null),
          ),
      ]),
    );
  }

  _QuestionTypeInfo _questionTypeInfo(String type) {
    switch (type) {
      case 'multiple_choice': return _QuestionTypeInfo('Multiple Choice', Icons.radio_button_checked, PharmaColors.info);
      case 'true_false': return _QuestionTypeInfo('True / False', Icons.toggle_on_outlined, PharmaColors.emerald600);
      case 'short_answer': return _QuestionTypeInfo('Short Answer', Icons.short_text, PharmaColors.warningText);
      case 'open_ended': return _QuestionTypeInfo('Open Ended', Icons.notes, PharmaColors.gray600);
      default: return _QuestionTypeInfo(type, Icons.help_outline, PharmaColors.gray600);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ADD QUESTION DIALOG (type-aware, visual, no raw JSON)
  // ═══════════════════════════════════════════════════════════════════════════

  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => _AddQuestionDialog(
        onAdd: (text, type, optionsJson, correctAnswer, difficulty, tag) {
          _addQuestion(text, type, optionsJson, correctAnswer, difficulty, tag);
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// QUESTION TYPE INFO
// ═══════════════════════════════════════════════════════════════════════════════

class _QuestionTypeInfo {
  final String label;
  final IconData icon;
  final Color color;
  _QuestionTypeInfo(this.label, this.icon, this.color);
}

// ═══════════════════════════════════════════════════════════════════════════════
// INLINE QUESTION EDITOR (expanded card)
// ═══════════════════════════════════════════════════════════════════════════════

class _QuestionInlineEditor extends StatefulWidget {
  const _QuestionInlineEditor({required this.question, required this.onSave, required this.onCancel});
  final Question question;
  final void Function(String text, String type, String optionsJson, String correctAnswer, String? difficulty) onSave;
  final VoidCallback onCancel;

  @override
  State<_QuestionInlineEditor> createState() => _QuestionInlineEditorState();
}

class _QuestionInlineEditorState extends State<_QuestionInlineEditor> {
  late TextEditingController _textCtl;
  late String _type;
  late String _difficulty;
  late List<String> _options;
  late int _correctIndex;
  late TextEditingController _shortAnswerCtl;

  @override
  void initState() {
    super.initState();
    _textCtl = TextEditingController(text: widget.question.text);
    _type = widget.question.questionType;
    _difficulty = (widget.question.difficulty ?? 'medium').toLowerCase();
    if (!['easy', 'medium', 'hard'].contains(_difficulty)) _difficulty = 'medium';

    _options = _parseOptions(widget.question.optionsJson);
    _correctIndex = int.tryParse(widget.question.correctAnswer ?? '') ?? 0;
    _shortAnswerCtl = TextEditingController(text: _type == 'short_answer' ? (widget.question.correctAnswer ?? '') : '');
  }

  List<String> _parseOptions(String json) {
    try {
      final list = jsonDecode(json) as List<dynamic>?;
      if (list != null && list.isNotEmpty) return list.map((e) => e.toString()).toList();
    } catch (_) {}
    return ['Option A', 'Option B', 'Option C', 'Option D'];
  }

  @override
  void dispose() {
    _textCtl.dispose();
    _shortAnswerCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      color: PharmaColors.pageBg,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12),
        TextField(controller: _textCtl, maxLines: 3, decoration: _decor('Question text')),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: DropdownButtonFormField<String>(
            initialValue: _difficulty,
            items: ['easy', 'medium', 'hard'].map((d) => DropdownMenuItem(value: d, child: Text(d[0].toUpperCase() + d.substring(1)))).toList(),
            onChanged: (v) => setState(() => _difficulty = v ?? 'medium'),
            decoration: _decor('Difficulty'),
          )),
          const SizedBox(width: 12),
          Expanded(child: DropdownButtonFormField<String>(
            initialValue: _type,
            items: const [
              DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
              DropdownMenuItem(value: 'true_false', child: Text('True / False')),
              DropdownMenuItem(value: 'short_answer', child: Text('Short Answer')),
              DropdownMenuItem(value: 'open_ended', child: Text('Open Ended')),
            ],
            onChanged: (v) => setState(() { _type = v ?? 'multiple_choice'; }),
            decoration: _decor('Type'),
          )),
        ]),
        const SizedBox(height: 16),
        _buildTypeEditor(),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(onPressed: widget.onCancel, child: const Text('Cancel')),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () {
              if (_textCtl.text.trim().isEmpty) return;
              String optionsJson;
              String correctAnswer;
              if (_type == 'multiple_choice') {
                optionsJson = jsonEncode(_options);
                correctAnswer = '$_correctIndex';
              } else if (_type == 'true_false') {
                optionsJson = jsonEncode(['True', 'False']);
                correctAnswer = '$_correctIndex';
              } else if (_type == 'short_answer') {
                optionsJson = '[]';
                correctAnswer = _shortAnswerCtl.text.trim();
              } else {
                optionsJson = '[]';
                correctAnswer = '';
              }
              widget.onSave(_textCtl.text.trim(), _type, optionsJson, correctAnswer, _difficulty);
            },
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
            child: const Text('Save Changes'),
          ),
        ]),
      ]),
    );
  }

  Widget _buildTypeEditor() {
    switch (_type) {
      case 'multiple_choice':
        return _buildMcqEditor();
      case 'true_false':
        return _buildTrueFalseEditor();
      case 'short_answer':
        return _buildShortAnswerEditor();
      case 'open_ended':
        return _buildOpenEndedEditor();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMcqEditor() {
    while (_options.length < 2) {
      _options.add('');
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Options (select the correct answer)', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
      const SizedBox(height: 8),
      RadioGroup<int>(
        groupValue: _correctIndex,
        onChanged: (v) => setState(() => _correctIndex = v ?? 0),
        child: Column(children: List.generate(_options.length, (i) {
          final ctl = TextEditingController(text: _options[i]);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              Radio<int>(value: i),
              const SizedBox(width: 4),
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: BorderRadius.circular(4)),
                child: Center(child: Text(String.fromCharCode(65 + i), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: PharmaColors.emerald700))),
              ),
              const SizedBox(width: 8),
              Expanded(child: TextField(
                controller: ctl,
                onChanged: (v) => _options[i] = v,
                decoration: _decor('Option ${String.fromCharCode(65 + i)}'),
              )),
              if (_options.length > 2)
                IconButton(icon: Icon(Icons.close, size: 16, color: PharmaColors.textTertiary), onPressed: () {
                  setState(() { _options.removeAt(i); if (_correctIndex >= _options.length) _correctIndex = 0; });
                }),
            ]),
          );
        })),
      ),
      if (_options.length < 6)
        TextButton.icon(
          onPressed: () => setState(() => _options.add('')),
          icon: const Icon(Icons.add, size: 14),
          label: const Text('Add Option'),
          style: TextButton.styleFrom(foregroundColor: PharmaColors.emerald600),
        ),
    ]);
  }

  Widget _buildTrueFalseEditor() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Select the correct answer', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
      const SizedBox(height: 8),
      Row(children: [
        _trueFalseOption('True', 0),
        const SizedBox(width: 16),
        _trueFalseOption('False', 1),
      ]),
    ]);
  }

  Widget _trueFalseOption(String label, int index) {
    final selected = _correctIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _correctIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? PharmaColors.emerald50 : PharmaColors.pageBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? PharmaColors.emerald600 : PharmaColors.borderLight, width: selected ? 2 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(selected ? Icons.check_circle : Icons.circle_outlined, size: 18, color: selected ? PharmaColors.emerald600 : PharmaColors.textTertiary),
          const SizedBox(width: 8),
          Text(label, style: PharmaTypography.bodyMedium.copyWith(fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: selected ? PharmaColors.emerald700 : PharmaColors.textPrimary)),
        ]),
      ),
    );
  }

  Widget _buildShortAnswerEditor() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Expected answer (auto-graded by exact match)', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
      const SizedBox(height: 8),
      TextField(controller: _shortAnswerCtl, decoration: _decor('Expected answer')),
    ]);
  }

  Widget _buildOpenEndedEditor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: PharmaColors.infoBg, borderRadius: PharmaRadius.cardRadius),
      child: Row(children: [
        Icon(Icons.info_outline, size: 18, color: PharmaColors.info),
        const SizedBox(width: 12),
        Expanded(child: Text('Open-ended questions require manual grading by the instructor. Students can enter detailed text responses.', style: PharmaTypography.body.copyWith(color: PharmaColors.info, fontSize: 13))),
      ]),
    );
  }

  InputDecoration _decor(String label) => InputDecoration(
    labelText: label, filled: true, fillColor: PharmaColors.cardBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide(color: PharmaColors.borderLight)),
    enabledBorder: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide(color: PharmaColors.borderLight)),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADD QUESTION DIALOG (type-aware, visual, no raw JSON)
// ═══════════════════════════════════════════════════════════════════════════════

class _AddQuestionDialog extends StatefulWidget {
  const _AddQuestionDialog({required this.onAdd});
  final void Function(String text, String type, String optionsJson, String correctAnswer, String? difficulty, String? tag) onAdd;

  @override
  State<_AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<_AddQuestionDialog> {
  final _textCtl = TextEditingController();
  String _type = 'multiple_choice';
  String _difficulty = 'medium';
  String _tag = 'GMP';
  final List<String> _options = ['', '', '', ''];
  int _correctIndex = 0;
  final _shortAnswerCtl = TextEditingController();

  @override
  void dispose() { _textCtl.dispose(); _shortAnswerCtl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
      title: const Text('Add Question'),
      content: SizedBox(
        width: 560,
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _textCtl, maxLines: 3, decoration: _decor('Enter your question…')),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: DropdownButtonFormField<String>(
              initialValue: _type,
              items: const [
                DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
                DropdownMenuItem(value: 'true_false', child: Text('True / False')),
                DropdownMenuItem(value: 'short_answer', child: Text('Short Answer')),
                DropdownMenuItem(value: 'open_ended', child: Text('Open Ended')),
              ],
              onChanged: (v) => setState(() => _type = v ?? 'multiple_choice'),
              decoration: _decor('Question Type'),
            )),
            const SizedBox(width: 12),
            Expanded(child: DropdownButtonFormField<String>(
              initialValue: _difficulty,
              items: ['easy', 'medium', 'hard'].map((d) => DropdownMenuItem(value: d, child: Text(d[0].toUpperCase() + d.substring(1)))).toList(),
              onChanged: (v) => setState(() => _difficulty = v ?? 'medium'),
              decoration: _decor('Difficulty'),
            )),
          ]),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _tag,
            items: ['GMP', 'Data Integrity', 'Quality', 'Process', 'Compliance', 'Validation', '21 CFR 11', 'ICH Q10']
                .map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _tag = v ?? 'GMP'),
            decoration: _decor('Regulatory Tag'),
          ),
          const SizedBox(height: 16),
          _buildTypeSection(),
        ])),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            if (_textCtl.text.trim().isEmpty) return;
            String optionsJson; String correctAnswer;
            if (_type == 'multiple_choice') {
              optionsJson = jsonEncode(_options.where((o) => o.isNotEmpty).toList());
              correctAnswer = '$_correctIndex';
            } else if (_type == 'true_false') {
              optionsJson = jsonEncode(['True', 'False']);
              correctAnswer = '$_correctIndex';
            } else if (_type == 'short_answer') {
              optionsJson = '[]';
              correctAnswer = _shortAnswerCtl.text.trim();
            } else {
              optionsJson = '[]';
              correctAnswer = '';
            }
            Navigator.pop(context);
            widget.onAdd(_textCtl.text.trim(), _type, optionsJson, correctAnswer, _difficulty, _tag);
          },
          style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          child: const Text('Add to Pool'),
        ),
      ],
    );
  }

  Widget _buildTypeSection() {
    switch (_type) {
      case 'multiple_choice':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Options', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
          const SizedBox(height: 8),
          RadioGroup<int>(
            groupValue: _correctIndex,
            onChanged: (v) => setState(() => _correctIndex = v ?? 0),
            child: Column(children: List.generate(_options.length, (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                Radio<int>(value: i),
                Container(width: 24, height: 24, decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text(String.fromCharCode(65 + i), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: PharmaColors.emerald700)))),
                const SizedBox(width: 8),
                Expanded(child: TextField(
                  onChanged: (v) => _options[i] = v,
                  decoration: _decor('Option ${String.fromCharCode(65 + i)}'),
                )),
                if (_options.length > 2) IconButton(icon: Icon(Icons.close, size: 16, color: PharmaColors.textTertiary), onPressed: () => setState(() { _options.removeAt(i); if (_correctIndex >= _options.length) _correctIndex = 0; })),
              ]),
            ))),
          ),
          if (_options.length < 6) TextButton.icon(onPressed: () => setState(() => _options.add('')), icon: const Icon(Icons.add, size: 14), label: const Text('Add Option'), style: TextButton.styleFrom(foregroundColor: PharmaColors.emerald600)),
        ]);
      case 'true_false':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Correct answer', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
          const SizedBox(height: 8),
          Row(children: [
            _tfOption('True', 0), const SizedBox(width: 12), _tfOption('False', 1),
          ]),
        ]);
      case 'short_answer':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Expected answer', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
          const SizedBox(height: 8),
          TextField(controller: _shortAnswerCtl, decoration: _decor('Expected answer')),
        ]);
      case 'open_ended':
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: PharmaColors.infoBg, borderRadius: PharmaRadius.cardRadius),
          child: Row(children: [
            Icon(Icons.info_outline, size: 16, color: PharmaColors.info),
            const SizedBox(width: 10),
            Expanded(child: Text('This question requires manual grading by the instructor.', style: PharmaTypography.body.copyWith(color: PharmaColors.info, fontSize: 13))),
          ]),
        );
      default: return const SizedBox.shrink();
    }
  }

  Widget _tfOption(String label, int index) {
    final sel = _correctIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _correctIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: sel ? PharmaColors.emerald50 : PharmaColors.pageBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: sel ? PharmaColors.emerald600 : PharmaColors.borderLight, width: sel ? 2 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(sel ? Icons.check_circle : Icons.circle_outlined, size: 16, color: sel ? PharmaColors.emerald600 : PharmaColors.textTertiary),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontWeight: sel ? FontWeight.w600 : FontWeight.w400, color: sel ? PharmaColors.emerald700 : PharmaColors.textPrimary)),
        ]),
      ),
    );
  }

  InputDecoration _decor(String label) => InputDecoration(
    labelText: label, filled: true, fillColor: PharmaColors.pageBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide(color: PharmaColors.borderLight)),
    enabledBorder: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide(color: PharmaColors.borderLight)),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// DIFFICULTY CHIP
// ═══════════════════════════════════════════════════════════════════════════════

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty});
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (difficulty.toLowerCase()) {
      case 'easy': bg = PharmaColors.successBg; fg = PharmaColors.successText;
      case 'medium': bg = PharmaColors.warningBg; fg = PharmaColors.warningText;
      case 'hard': bg = PharmaColors.dangerBg; fg = PharmaColors.danger;
      default: bg = PharmaColors.gray100; fg = PharmaColors.gray600;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(difficulty, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
