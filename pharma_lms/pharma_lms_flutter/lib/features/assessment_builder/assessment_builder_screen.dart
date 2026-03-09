import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// Assessment builder: question banks, questions, assessments.
class AssessmentBuilderScreen extends StatefulWidget {
  const AssessmentBuilderScreen({super.key});

  @override
  State<AssessmentBuilderScreen> createState() => _AssessmentBuilderScreenState();
}

class _AssessmentBuilderScreenState extends State<AssessmentBuilderScreen> {
  List<QuestionBank> _banks = [];
  List<Course> _courses = [];
  QuestionBank? _selectedBank;
  List<Question> _questions = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final banks = await client.assessment.listQuestionBanks();
      final courses = await client.course.listCourses();
      setState(() {
        _banks = banks;
        _courses = courses;
        _loading = false;
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

  void _showGenerateQuestionsPlaceholder() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Generate Questions'),
        content: const Text(
          'AI-assisted question generation coming soon. '
          'Integrate with OpenAI/LLM API for question generation from course content.',
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

  Future<void> _addQuestion() async {
    if (_selectedBank == null) return;
    final textController = TextEditingController();
    final optionsController = TextEditingController(text: '["A","B","C","D"]');
    final answerController = TextEditingController(text: '0');
    final typeController = TextEditingController(text: 'multiple_choice');

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Question'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(labelText: 'Question text', border: OutlineInputBorder()),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type (multiple_choice, true_false)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: optionsController,
                decoration: const InputDecoration(labelText: 'Options JSON', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(labelText: 'Correct answer index', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Add')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await client.assessmentBuilder.createQuestion(
        questionBankId: _selectedBank!.id!,
        text: textController.text.trim().isEmpty ? 'New question' : textController.text.trim(),
        questionType: typeController.text.trim().isEmpty ? 'multiple_choice' : typeController.text.trim(),
        optionsJson: optionsController.text.trim().isEmpty ? '[]' : optionsController.text.trim(),
        correctAnswer: answerController.text.trim().isEmpty ? '0' : answerController.text.trim(),
      );
      if (mounted) _selectBank(_selectedBank!);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _createAssessment() async {
    if (_selectedBank == null) return;
    CourseVersion? version;
    final passingController = TextEditingController(text: '80');
    List<CourseVersion> dialogVersions = [];
    for (final c in _courses) {
      if (c.id != null) {
        final v = await client.course.getCourseVersions(c.id!);
        dialogVersions.addAll(v);
      }
    }
    if (dialogVersions.isNotEmpty) version = dialogVersions.first;

    if (!mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setDialogState) {
          return AlertDialog(
            title: const Text('Create Assessment'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<CourseVersion>(
                    initialValue: version,
                    decoration: const InputDecoration(labelText: 'Course Version', border: OutlineInputBorder()),
                    items: dialogVersions.map((v) => DropdownMenuItem(value: v, child: Text('v${v.version}'))).toList(),
                    onChanged: (v) {
                      version = v;
                      setDialogState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passingController,
                    decoration: const InputDecoration(labelText: 'Passing score %', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, version != null),
                child: const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
    if (ok != true || !mounted || version == null) return;
    try {
      await client.assessmentBuilder.createAssessment(
        courseVersionId: version!.id!,
        questionBankId: _selectedBank!.id!,
        passingScore: int.tryParse(passingController.text) ?? 80,
        randomize: true,
        timeLimitMinutes: 15,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Assessment created')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assessment Builder')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assessment Builder')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Builder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 260,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Question Banks', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._banks.map((b) => ListTile(
                      title: Text(b.name),
                      selected: _selectedBank?.id == b.id,
                      onTap: () => _selectBank(b),
                    )),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _createAssessment,
                  icon: const Icon(Icons.quiz),
                  label: const Text('Create Assessment'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedBank == null
                ? const Center(child: Text('Select a question bank'))
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                        Row(
                        children: [
                          Text('Questions (${_selectedBank!.name})', style: Theme.of(context).textTheme.titleMedium),
                          const Spacer(),
                          OutlinedButton.icon(
                            onPressed: _showGenerateQuestionsPlaceholder,
                            icon: const Icon(Icons.auto_awesome),
                            label: const Text('Generate questions'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _addQuestion,
                            icon: const Icon(Icons.add),
                            label: const Text('Add Question'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ..._questions.map((q) => Card(
                            child: ListTile(
                              title: Text(q.text),
                              subtitle: Text('${q.questionType} -> ${q.correctAnswer}'),
                            ),
                          )),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
