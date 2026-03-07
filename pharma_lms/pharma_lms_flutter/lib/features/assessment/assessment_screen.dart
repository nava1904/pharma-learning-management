import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// Assessment screen: load questions, record answers, compute score, e-sign, complete.
class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({
    super.key,
    required this.courseId,
    this.courseTitle,
    this.courseVersionId,
    this.enrollmentId,
    this.userId,
  });

  final String courseId;
  final String? courseTitle;
  final int? courseVersionId;
  final int? enrollmentId;
  final int? userId;

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  Assessment? _assessment;
  List<Question> _questions = [];
  AssessmentAttempt? _attempt;
  bool _loading = true;
  String? _error;
  int _currentIndex = 0;
  final Map<int, String> _answers = {};
  bool _submitted = false;
  int? _finalScore;

  int get _effectiveUserId => widget.userId ?? 0;
  int get _effectiveCourseVersionId => widget.courseVersionId ?? 0;
  int get _effectiveEnrollmentId => widget.enrollmentId ?? 0;

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
      final courseVersionId = _effectiveCourseVersionId;
      if (courseVersionId == 0) {
        setState(() {
          _error = 'Missing course version. Go back and open from course.';
          _loading = false;
        });
        return;
      }

      final assessment = await client.assessment.getAssessmentForCourse(courseVersionId);
      if (assessment == null) {
        setState(() {
          _error = 'No assessment for this course.';
          _loading = false;
        });
        return;
      }

      var questions = await client.assessment.getQuestions(assessment.questionBankId);
      if (assessment.randomize) {
        questions = List.of(questions)..shuffle();
      }

      final attempt = await client.assessment.startAttempt(
        userId: _effectiveUserId,
        assessmentId: assessment.id!,
        enrollmentId: _effectiveEnrollmentId > 0 ? _effectiveEnrollmentId : null,
      );

      setState(() {
        _assessment = assessment;
        _questions = questions;
        _attempt = attempt;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  List<String> _parseOptions(String optionsJson) {
    try {
      final decoded = jsonDecode(optionsJson);
      if (decoded is List) {
        return decoded.map((e) => e.toString()).toList();
      }
    } catch (_) {}
    return [];
  }

  void _selectAnswer(String answer) {
    final q = _questions[_currentIndex];
    if (q.id != null) {
      setState(() => _answers[q.id!] = answer);
    }
  }

  int _computeScore() {
    var correct = 0;
    for (final q in _questions) {
      final ans = q.id != null ? _answers[q.id!] : null;
      if (ans != null && ans == q.correctAnswer) correct++;
    }
    return _questions.isEmpty ? 0 : (correct * 100 / _questions.length).round();
  }

  Future<void> _submit() async {
    if (_assessment == null || _attempt == null) return;

    for (final q in _questions) {
      if (q.id != null && _answers[q.id] != null) {
        try {
          await client.assessment.recordAnswer(
            attemptId: _attempt!.id!,
            questionId: q.id!,
            answer: _answers[q.id]!,
            correct: _answers[q.id] == q.correctAnswer,
          );
        } catch (_) {}
      }
    }

    final score = _computeScore();
    await client.assessment.submitAttempt(
      attemptId: _attempt!.id!,
      score: score,
    );

    setState(() {
      _submitted = true;
      _finalScore = score;
    });

    if (score >= _assessment!.passingScore &&
        _effectiveEnrollmentId > 0 &&
        _effectiveUserId > 0 &&
        _effectiveCourseVersionId > 0) {
      // ignore: use_build_context_synchronously
      final esignatureId = await context.push<int>(
        '/esignature',
        extra: {
          'userId': _effectiveUserId,
          'entityType': 'training_record',
          'entityId': 'enrollment-$_effectiveEnrollmentId',
          'signatureMeaning': 'I have read and understood',
        },
      );
      if (!context.mounted) return;
      if (esignatureId != null) {
        try {
          final cert = await client.training.completeTraining(
            enrollmentId: _effectiveEnrollmentId,
            userId: _effectiveUserId,
            courseVersionId: _effectiveCourseVersionId,
            esignatureId: esignatureId,
            score: score,
          );
          if (!mounted) return;
          if (cert.id != null) {
            context.go('/certificate/${cert.id}', extra: cert);
          }
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Completion failed: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Assessment${widget.courseTitle != null ? ' - ${widget.courseTitle}' : ''}')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assessment')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    if (_submitted) {
      final passed = _finalScore != null &&
          _assessment != null &&
          _finalScore! >= _assessment!.passingScore;
      return Scaffold(
        appBar: AppBar(title: const Text('Assessment Complete')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        passed ? 'Passed!' : 'Not passed',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: passed ? Colors.green : Colors.red,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text('Score: $_finalScore%'),
                      Text('Passing: ${_assessment!.passingScore}%'),
                      if (!passed) ...[
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => _load(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assessment')),
        body: const Center(child: Text('No questions in this assessment.')),
      );
    }

    final q = _questions[_currentIndex];
    final options = _parseOptions(q.optionsJson);
    final selected = q.id != null ? _answers[q.id!] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1} of ${_questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.text,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ...options.map((opt) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: OutlinedButton(
                            onPressed: () => _selectAnswer(opt),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: selected == opt
                                  ? Theme.of(context).colorScheme.primaryContainer
                                  : null,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(opt),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _currentIndex--),
                    child: const Text('Previous'),
                  ),
                const Spacer(),
                if (_currentIndex < _questions.length - 1)
                  ElevatedButton(
                    onPressed: () => setState(() => _currentIndex++),
                    child: const Text('Next'),
                  )
                else
                  ElevatedButton(
                    onPressed: selected != null ? _submit : null,
                    child: const Text('Submit'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
