import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../features/esignature/esignature_screen.dart' show showEsignatureModal;

/// Assessment screen: NTA-style question palette, Save & Next, Clear, Mark for Review.
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
  int _attemptNumber = 1;
  int _maxAttempts = 999;
  static const bool _allowBackAfterAnswer = false;
  bool _showQuestionPalette = true;
  Timer? _timer;
  int _remainingSeconds = 0;
  final Set<int> _markedForReview = {};

  int get _effectiveUserId => widget.userId ?? 0;
  int get _effectiveCourseVersionId => widget.courseVersionId ?? 0;
  int get _effectiveEnrollmentId => widget.enrollmentId ?? 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _load();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _timer?.cancel();
    super.dispose();
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
      if (assessment.questionBankId == null) {
        setState(() {
          _error = 'Assessment has no question bank.';
          _loading = false;
        });
        return;
      }

      var questions = await client.assessment.getQuestions(assessment.questionBankId!);
      if (assessment.randomize) {
        questions = List.of(questions)..shuffle();
      }

      final attempt = await client.assessment.startAttempt(
        userId: _effectiveUserId,
        assessmentId: assessment.id!,
        enrollmentId: _effectiveEnrollmentId > 0 ? _effectiveEnrollmentId : null,
      );

      final attemptCount = await client.assessment.getAttemptCount(
        userId: _effectiveUserId,
        assessmentId: assessment.id!,
        enrollmentId: _effectiveEnrollmentId > 0 ? _effectiveEnrollmentId : null,
      );

      final timeLimit = assessment.timeLimitMinutes ?? 0;
      setState(() {
        _assessment = assessment;
        _questions = questions;
        _attempt = attempt;
        _attemptNumber = attemptCount;
        _maxAttempts = 999;
        _remainingSeconds = timeLimit > 0 ? timeLimit * 60 : 0;
        _loading = false;
      });
      if (timeLimit > 0) {
        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (!mounted) return;
          setState(() {
            if (_remainingSeconds > 0) _remainingSeconds--;
            if (_remainingSeconds <= 0) _timer?.cancel();
          });
          if (_remainingSeconds <= 0 && !_submitted) _submit();
        });
      }
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

  void _clearAnswer() {
    final q = _questions[_currentIndex];
    if (q.id != null) {
      setState(() => _answers.remove(q.id!));
    }
  }

  void _toggleMarkForReview() {
    final q = _questions[_currentIndex];
    if (q.id != null) {
      setState(() {
        if (_markedForReview.contains(q.id)) {
          _markedForReview.remove(q.id);
        } else {
          _markedForReview.add(q.id!);
        }
      });
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

  void _showSubmitConfirmation() {
    final attempted = _answers.length;
    final total = _questions.length;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Submit Assessment?'),
        content: Text(
          'You have attempted $attempted of $total questions.\n\n'
          'Once submitted, you cannot change your answers. Are you sure you want to submit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _submit();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
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
          );
        } catch (_) {}
      }
    }

    final updated = await client.assessment.submitAttempt(
      attemptId: _attempt!.id!,
    );
    final score = updated.score ?? _computeScore();

    setState(() {
      _submitted = true;
      _finalScore = score;
    });

    if (score >= _assessment!.passingScore &&
        _effectiveEnrollmentId > 0 &&
        _effectiveUserId > 0 &&
        _effectiveCourseVersionId > 0) {
      // Show short success Lottie before e-signature (plan 4B)
      if (context.mounted) {
        await _showPassSuccessLottie(context);
      }
      if (!context.mounted) return;
      // ignore: use_build_context_synchronously
      final esignatureId = await showEsignatureModal(
        context,
        userId: _effectiveUserId,
        entityType: 'training_record',
        entityId: 'enrollment-$_effectiveEnrollmentId',
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

  /// Shows a short success Lottie overlay (plan 4B), then closes after delay.
  Future<void> _showPassSuccessLottie(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (ctx) => _PassSuccessLottieDialog(
        onComplete: () => Navigator.of(ctx).pop(),
      ),
    );
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
      final correctCount = _questions.isEmpty
          ? 0
          : (_finalScore != null ? (_finalScore! * _questions.length / 100).round() : 0);
      return Scaffold(
        appBar: AppBar(title: const Text('Test Summary')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: passed ? AppColors.success : AppColors.destructive,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            passed ? Icons.check_circle : Icons.cancel,
                            size: 64,
                            color: passed ? AppColors.success : AppColors.destructive,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            passed ? 'Passed!' : 'Not Passed',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: passed ? AppColors.success : AppColors.destructive,
                                ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _ScoreItem(
                                label: 'Score',
                                value: '$_finalScore%',
                                color: AppColors.indigo600,
                              ),
                              _ScoreItem(
                                label: 'Correct',
                                value: '$correctCount / ${_questions.length}',
                                color: AppColors.slate700,
                              ),
                              _ScoreItem(
                                label: 'Pass Mark',
                                value: '${_assessment!.passingScore}%',
                                color: AppColors.slate600,
                              ),
                            ],
                          ),
                          if (!passed) ...[
                            const SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: _load,
                              icon: const Icon(Icons.refresh, size: 18),
                              label: const Text('Retry'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Access correct solutions after submission.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                          fontStyle: FontStyle.italic,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
    final isMarked = q.id != null && _markedForReview.contains(q.id);

    final showPrevious = _allowBackAfterAnswer || _currentIndex == 0 ||
        (q.id != null && _answers[q.id!] == null);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentIndex + 1} of ${_questions.length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (_maxAttempts < 999)
              Text(
                'Attempt $_attemptNumber of $_maxAttempts',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.slate600,
                    ),
              )
            else if (_attemptNumber > 1)
              Text(
                'Attempt $_attemptNumber',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.slate600,
                    ),
              ),
          ],
        ),
        actions: [
          if (_remainingSeconds > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _remainingSeconds <= 60
                        ? AppColors.destructive.withValues(alpha: 0.15)
                        : AppColors.slate200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_remainingSeconds ~/ 60}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _remainingSeconds <= 60
                          ? AppColors.destructive
                          : AppColors.slate700,
                    ),
                  ),
                ),
              ),
            ),
          IconButton(
            icon: Icon(_showQuestionPalette ? Icons.grid_view : Icons.list),
            onPressed: () => setState(() => _showQuestionPalette = !_showQuestionPalette),
            tooltip: _showQuestionPalette ? 'Hide question palette' : 'Show question palette',
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.slate200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.indigo100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Q${_currentIndex + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.indigo700,
                                  ),
                                ),
                              ),
                              if (isMarked) ...[
                                const SizedBox(width: 8),
                                Icon(Icons.flag, size: 18, color: Colors.purple[700]),
                                const SizedBox(width: 4),
                                Text(
                                  'Marked for Review',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.purple[700],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            q.text,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  height: 1.4,
                                  color: AppColors.slate900,
                                ),
                          ),
                          const SizedBox(height: 20),
                          ...options.map((opt) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _selectAnswer(opt),
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                      decoration: BoxDecoration(
                                        color: selected == opt
                                            ? AppColors.indigo50
                                            : AppColors.slate50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: selected == opt
                                              ? AppColors.indigo600
                                              : AppColors.slate200,
                                          width: selected == opt ? 2 : 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            selected == opt
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            size: 22,
                                            color: selected == opt
                                                ? AppColors.indigo600
                                                : AppColors.slate500,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              opt,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: AppColors.slate800,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (selected != null)
                        TextButton.icon(
                          onPressed: _clearAnswer,
                          icon: const Icon(Icons.clear, size: 18),
                          label: const Text('Clear'),
                        ),
                      TextButton.icon(
                        onPressed: _toggleMarkForReview,
                        icon: Icon(
                          isMarked ? Icons.flag : Icons.outlined_flag,
                          size: 18,
                          color: isMarked ? Colors.purple[700] : null,
                        ),
                        label: Text(isMarked ? 'Unmark Review' : 'Mark for Review'),
                      ),
                      const Spacer(),
                      if (_currentIndex > 0 && showPrevious)
                        OutlinedButton(
                          onPressed: () => setState(() => _currentIndex--),
                          child: const Text('Previous'),
                        ),
                      if (_currentIndex > 0 && showPrevious) const SizedBox(width: 12),
                      if (_currentIndex < _questions.length - 1)
                        FilledButton(
                          onPressed: () => setState(() => _currentIndex++),
                          child: const Text('Save & Next'),
                        )
                      else
                        FilledButton(
                          onPressed: selected != null ? _showSubmitConfirmation : null,
                          child: const Text('Submit'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_showQuestionPalette)
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: AppColors.slate50,
                border: Border(
                  left: BorderSide(color: AppColors.slate200),
                ),
              ),
              child: _QuestionPalette(
                questions: _questions,
                answers: _answers,
                markedForReview: _markedForReview,
                currentIndex: _currentIndex,
                onSelectQuestion: (i) => setState(() => _currentIndex = i),
              ),
            ),
        ],
      ),
    );
  }
}

/// NTA-style question palette: color-coded status, direct navigation.
class _QuestionPalette extends StatelessWidget {
  const _QuestionPalette({
    required this.questions,
    required this.answers,
    required this.markedForReview,
    required this.currentIndex,
    required this.onSelectQuestion,
  });

  final List<Question> questions;
  final Map<int, String> answers;
  final Set<int> markedForReview;
  final int currentIndex;
  final ValueChanged<int> onSelectQuestion;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Question Paper',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.slate700,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(questions.length, (i) {
            final q = questions[i];
            final attempted = q.id != null && answers.containsKey(q.id);
            final marked = q.id != null && markedForReview.contains(q.id);
            final isCurrent = i == currentIndex;
            Color bgColor;
            Color borderColor;
            if (isCurrent) {
              bgColor = AppColors.indigo100;
              borderColor = AppColors.indigo600;
            } else if (marked) {
              bgColor = Colors.purple.shade50;
              borderColor = Colors.purple.shade400;
            } else if (attempted) {
              bgColor = AppColors.teal50;
              borderColor = AppColors.teal500;
            } else {
              bgColor = AppColors.slate100;
              borderColor = AppColors.slate300;
            }
            return GestureDetector(
              onTap: () => onSelectQuestion(i),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: isCurrent ? 2 : 1),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                    color: isCurrent ? AppColors.indigo700 : AppColors.slate700,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _LegendDot(color: AppColors.teal500, label: 'Attempted'),
            const SizedBox(width: 12),
            _LegendDot(color: Colors.purple.shade400, label: 'Review'),
          ],
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.slate600,
              ),
        ),
      ],
    );
  }
}

class _ScoreItem extends StatelessWidget {
  const _ScoreItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.slate600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
        ),
      ],
    );
  }
}

/// Fullscreen success Lottie overlay; auto-dismisses after delay (plan 4B).
class _PassSuccessLottieDialog extends StatefulWidget {
  const _PassSuccessLottieDialog({required this.onComplete});

  final VoidCallback onComplete;

  @override
  State<_PassSuccessLottieDialog> createState() =>
      _PassSuccessLottieDialogState();
}

class _PassSuccessLottieDialogState extends State<_PassSuccessLottieDialog> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              'assets/lottie/success.json',
              fit: BoxFit.contain,
              repeat: false,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Passed!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
