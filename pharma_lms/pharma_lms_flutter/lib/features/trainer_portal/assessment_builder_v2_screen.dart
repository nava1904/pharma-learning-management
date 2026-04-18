import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/file_download.dart';
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

  // Persistent controllers — never created inside build()
  late final TextEditingController _timeLimitCtl;
  late final TextEditingController _passingScoreCtl;
  late final TextEditingController _displayCountCtl;

  int? _expandedQuestionId;

  @override
  void initState() {
    super.initState();
    _timeLimitCtl = TextEditingController(text: '$_timeLimitMinutes');
    _passingScoreCtl = TextEditingController(text: '$_passingScore');
    _displayCountCtl = TextEditingController(text: '$_displayCount');
    _loadData();
  }

  @override
  void dispose() {
    _timeLimitCtl.dispose();
    _passingScoreCtl.dispose();
    _displayCountCtl.dispose();
    super.dispose();
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
      // Sync persistent controllers with loaded values
      _timeLimitCtl.text = '$_timeLimitMinutes';
      _passingScoreCtl.text = '$_passingScore';
      _displayCountCtl.text = '$_displayCount';
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
  bool get _poolValid => _totalInPool == 0 || _displayCount < _totalInPool;

  // ═══════════════════════════════════════════════════════════════════════════
  // SAVE / CRUD (unchanged logic, _showFeedback removed — consolidated into showAnswers)
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _saveAssessment() async {
    if (_effectiveCourseVersionId == null && widget.courseId > 0) { _snack('No course version available', err: true); return; }
    if (_selectedQuestionBankId == null) { _snack('Please select a question bank first', err: true); return; }
    if (!_poolValid) { _snack('Display count must be less than pool size ($_totalInPool questions)', err: true); return; }

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

  // ═══════════════════════════════════════════════════════════════════════════
  // PREVIEW — Shows the assessment as the learner would see it
  // ═══════════════════════════════════════════════════════════════════════════

  void _showPreviewDialog() {
    // Pick random subset just like the real assessment engine
    final pool = List<Question>.from(_questions);
    if (_shuffleQuestions) pool.shuffle();
    final preview = pool.take(_displayCount.clamp(0, pool.length)).toList();

    showDialog(
      context: context,
      builder: (ctx) => Dialog.fullscreen(
        child: Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
            title: Row(children: [
              const Icon(Icons.visibility, size: 18),
              const SizedBox(width: 8),
              const Text('Assessment Preview'),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(12)),
                child: const Text('PREVIEW MODE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
              ),
            ]),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(children: [
                  Icon(Icons.timer_outlined, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text('$_timeLimitMinutes min', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(width: 16),
                  Text('${preview.length} of ${_questions.length} questions', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(width: 16),
                  Text('Pass: $_passingScore%', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ]),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.close, color: Colors.white),
                label: const Text('Close Preview', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: preview.length,
            itemBuilder: (context, i) {
              final q = preview[i];
              return _buildPreviewQuestionCard(i, q);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewQuestionCard(int index, Question q) {
    final typeInfo = _questionTypeInfo(q.questionType);
    List<String> options = [];
    try {
      final decoded = jsonDecode(q.optionsJson);
      if (decoded is List) options = decoded.map((e) => e.toString()).toList();
    } catch (_) {}

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text('${index + 1}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: PharmaColors.emerald700))),
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
          if (q.difficulty != null) ...[
            const SizedBox(width: 8),
            _DifficultyChip(difficulty: _cap(q.difficulty!)),
          ],
        ]),
        const SizedBox(height: 14),
        Text(q.text, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500, fontSize: 15)),
        const SizedBox(height: 16),
        // Show answer options based on type
        if (q.questionType == 'multiple_choice' && options.isNotEmpty)
          ...options.asMap().entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: PharmaColors.pageBg,
                borderRadius: PharmaRadius.inputRadius,
                border: Border.all(color: PharmaColors.borderLight),
              ),
              child: Row(children: [
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: PharmaColors.gray300, width: 2)),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text(String.fromCharCode(65 + entry.key), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: PharmaColors.emerald700))),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(entry.value, style: PharmaTypography.body)),
              ]),
            ),
          ))
        else if (q.questionType == 'true_false')
          Row(children: [
            _previewTfChip('True'),
            const SizedBox(width: 12),
            _previewTfChip('False'),
          ])
        else if (q.questionType == 'short_answer')
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PharmaColors.pageBg,
              borderRadius: PharmaRadius.inputRadius,
              border: Border.all(color: PharmaColors.borderLight),
            ),
            child: Text('Learner types answer here…', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
          )
        else if (q.questionType == 'open_ended')
          Container(
            height: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PharmaColors.pageBg,
              borderRadius: PharmaRadius.inputRadius,
              border: Border.all(color: PharmaColors.borderLight),
            ),
            child: Text('Learner writes a detailed response here…', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
          ),
      ]),
    );
  }

  Widget _previewTfChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: PharmaColors.pageBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: PharmaColors.gray300, width: 2)),
        ),
        const SizedBox(width: 8),
        Text(label, style: PharmaTypography.bodyMedium),
      ]),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PDF — Generate a real PDF question paper and trigger download
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _generatePdfPreview() async {
    if (_questions.isEmpty) {
      _snack('No questions to export', err: true);
      return;
    }

    _snack('Generating PDF…');

    try {
      final pdf = pw.Document();
      final bankName = _questionBank?.name ?? 'Assessment';

      // ── Styles ──
      final titleStyle = pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
      final headerStyle = pw.TextStyle(fontSize: 10, color: PdfColors.grey700);
      final questionStyle = pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);
      final optionStyle = const pw.TextStyle(fontSize: 11);
      final metaStyle = pw.TextStyle(fontSize: 9, color: PdfColors.grey600);
      final answerKeyTitle = pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold);
      final answerStyle = const pw.TextStyle(fontSize: 10);

      // ── Build question widgets ──
      final questionWidgets = <pw.Widget>[];
      for (var i = 0; i < _questions.length; i++) {
        final q = _questions[i];
        List<String> options = [];
        try {
          final decoded = jsonDecode(q.optionsJson);
          if (decoded is List) options = decoded.map((e) => e.toString()).toList();
        } catch (_) {}

        final typeLabel = q.questionType.replaceAll('_', ' ').toUpperCase();
        final diffLabel = (q.difficulty ?? 'medium').toUpperCase();

        questionWidgets.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 14),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(children: [
                  pw.Text('Q${i + 1}.', style: questionStyle),
                  pw.SizedBox(width: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(3),
                    ),
                    child: pw.Text(typeLabel, style: metaStyle),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(3),
                    ),
                    child: pw.Text(diffLabel, style: metaStyle),
                  ),
                ]),
                pw.SizedBox(height: 4),
                pw.Text(q.text, style: const pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 6),
                // Options
                if (q.questionType == 'multiple_choice' && options.isNotEmpty)
                  ...options.asMap().entries.map((entry) {
                    final letter = String.fromCharCode(65 + entry.key);
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 16, bottom: 2),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 16, height: 16,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: PdfColors.grey400, width: 1),
                            ),
                          ),
                          pw.SizedBox(width: 6),
                          pw.Text('$letter)  ', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                          pw.Expanded(child: pw.Text(entry.value, style: optionStyle)),
                        ],
                      ),
                    );
                  })
                else if (q.questionType == 'true_false')
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 16),
                    child: pw.Row(children: [
                      pw.Container(width: 14, height: 14, decoration: pw.BoxDecoration(shape: pw.BoxShape.circle, border: pw.Border.all(color: PdfColors.grey400))),
                      pw.SizedBox(width: 4),
                      pw.Text('A) True', style: optionStyle),
                      pw.SizedBox(width: 24),
                      pw.Container(width: 14, height: 14, decoration: pw.BoxDecoration(shape: pw.BoxShape.circle, border: pw.Border.all(color: PdfColors.grey400))),
                      pw.SizedBox(width: 4),
                      pw.Text('B) False', style: optionStyle),
                    ]),
                  )
                else if (q.questionType == 'short_answer')
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 16, top: 4),
                    child: pw.Container(
                      height: 24,
                      decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey400))),
                    ),
                  )
                else
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 16, top: 4),
                    child: pw.Container(
                      height: 60,
                      decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey300), borderRadius: pw.BorderRadius.circular(4)),
                    ),
                  ),
                pw.SizedBox(height: 6),
                pw.Divider(color: PdfColors.grey300, thickness: 0.5),
              ],
            ),
          ),
        );
      }

      // ── Answer key widgets ──
      final answerKeyWidgets = <pw.Widget>[];
      for (var i = 0; i < _questions.length; i++) {
        final q = _questions[i];
        String answer;
        if (q.questionType == 'multiple_choice') {
          final idx = int.tryParse(q.correctAnswer ?? '') ?? 0;
          List<String> opts = [];
          try { final d = jsonDecode(q.optionsJson); if (d is List) opts = d.map((e) => e.toString()).toList(); } catch (_) {}
          answer = idx < opts.length ? '${String.fromCharCode(65 + idx)}) ${opts[idx]}' : q.correctAnswer ?? '';
        } else if (q.questionType == 'true_false') {
          answer = (int.tryParse(q.correctAnswer ?? '') ?? 0) == 0 ? 'True' : 'False';
        } else {
          answer = q.correctAnswer?.isNotEmpty == true ? q.correctAnswer! : '(Manual grading)';
        }
        answerKeyWidgets.add(
          pw.Text('Q${i + 1}: $answer', style: answerStyle),
        );
      }

      // ── Compose pages ──
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          header: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('ASSESSMENT — QUESTION PAPER', style: titleStyle),
                  pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: metaStyle),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Row(children: [
                  pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.Text('Question Bank: $bankName', style: headerStyle),
                    pw.Text('Total in Pool: ${_questions.length} · Displayed: $_displayCount', style: headerStyle),
                  ])),
                  pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.Text('Time Limit: $_timeLimitMinutes min · Pass: $_passingScore%', style: headerStyle),
                    pw.Text('Max Attempts: ${_maxAttempts == 0 ? "Unlimited" : "$_maxAttempts"} · Shuffle: ${_shuffleQuestions ? "Yes" : "No"}', style: headerStyle),
                  ])),
                ]),
              ),
              pw.SizedBox(height: 12),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 8),
            ],
          ),
          footer: (context) => pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 10),
            child: pw.Text(
              'Generated ${DateTime.now().toString().substring(0, 16)} · Pharma LMS',
              style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
            ),
          ),
          build: (context) => [
            ...questionWidgets,
            // Answer key on the last page
            pw.SizedBox(height: 20),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.grey400),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('ANSWER KEY', style: answerKeyTitle),
                  pw.SizedBox(height: 8),
                  pw.Divider(thickness: 0.5),
                  pw.SizedBox(height: 6),
                  ...answerKeyWidgets,
                ],
              ),
            ),
          ],
        ),
      );

      final bytes = await pdf.save();
      final fileName = 'Assessment_${bankName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await saveBytesToFile(bytes, fileName);
      _snack('PDF downloaded: $fileName');
    } catch (e) {
      _snack('Failed to generate PDF: $e', err: true);
    }
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
          // ── Preview button ──
          if (_assessment != null) ...[
            OutlinedButton.icon(
              onPressed: () => _showPreviewDialog(),
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('Preview'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.emerald700,
                side: BorderSide(color: PharmaColors.emerald200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(width: 8),
            // ── PDF Download button ──
            OutlinedButton.icon(
              onPressed: () => _generatePdfPreview(),
              icon: const Icon(Icons.picture_as_pdf, size: 16),
              label: const Text('PDF'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.danger,
                side: BorderSide(color: PharmaColors.danger.withValues(alpha: 0.3)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(width: 8),
          ],
          // ── Save / Update button ──
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
            // ── Grade button ──
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
              controller: _timeLimitCtl,
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => _timeLimitMinutes = int.tryParse(v) ?? _timeLimitMinutes),
              decoration: _fieldDecor(suffix: 'min'),
            ),
          )),
          const SizedBox(width: 16),
          Expanded(child: _settingsField(
            label: 'Passing Percentage',
            child: TextField(
              controller: _passingScoreCtl,
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
                controller: _displayCountCtl,
                keyboardType: TextInputType.number,
                onChanged: (v) => setState(() => _displayCount = int.tryParse(v) ?? _displayCount),
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
                Text('Display count must be less than pool size ($_totalInPool questions)', style: TextStyle(fontSize: 12, color: PharmaColors.danger)),
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
  // One persistent controller per option — never created inside build()
  final List<TextEditingController> _optionCtls = [];

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
    _rebuildOptionCtls();
  }

  List<String> _parseOptions(String json) {
    try {
      final list = jsonDecode(json) as List<dynamic>?;
      if (list != null && list.isNotEmpty) return list.map((e) => e.toString()).toList();
    } catch (_) {}
    return ['Option A', 'Option B', 'Option C', 'Option D'];
  }

  /// Rebuild the option controllers list to match _options length.
  void _rebuildOptionCtls() {
    for (final c in _optionCtls) c.dispose();
    _optionCtls.clear();
    for (final opt in _options) {
      _optionCtls.add(TextEditingController(text: opt));
    }
  }

  @override
  void dispose() {
    _textCtl.dispose();
    _shortAnswerCtl.dispose();
    for (final c in _optionCtls) c.dispose();
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
    // Keep _optionCtls in sync with _options (size may differ after add/remove)
    while (_optionCtls.length < _options.length) {
      _optionCtls.add(TextEditingController(text: _options[_optionCtls.length]));
    }
    while (_optionCtls.length > _options.length) {
      _optionCtls.removeLast().dispose();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Options (select the correct answer)', style: PharmaTypography.labelLarge.copyWith(fontSize: 12, color: PharmaColors.textSecondary)),
      const SizedBox(height: 8),
      RadioGroup<int>(
        groupValue: _correctIndex,
        onChanged: (v) => setState(() => _correctIndex = v ?? 0),
        child: Column(children: List.generate(_options.length, (i) {
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
                controller: _optionCtls[i],
                onChanged: (v) => _options[i] = v,
                decoration: _decor('Option ${String.fromCharCode(65 + i)}'),
              )),
              if (_options.length > 2)
                IconButton(icon: Icon(Icons.close, size: 16, color: PharmaColors.textTertiary), onPressed: () {
                  setState(() {
                    _options.removeAt(i);
                    _optionCtls.removeAt(i).dispose();
                    if (_correctIndex >= _options.length) _correctIndex = 0;
                  });
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
        Expanded(child: Text('Open-ended questions require manual grading by the instructor. Learners can enter detailed text responses.', style: PharmaTypography.body.copyWith(color: PharmaColors.info, fontSize: 13))),
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
