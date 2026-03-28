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
  final bool _showQuestionPalette = true;
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

      var questions = await client.assessment.getQuestions(assessment.questionBankId);
      if (assessment.randomize) {
        questions = List.of(questions)..shuffle();
      }

      final attempt = await client.assessment.startAttempt(
        userId: _effectiveUserId,
        assessmentId: assessment.id!,
        enrollmentId: _effectiveEnrollmentId > 0 ? _effectiveEnrollmentId : null,
        skipInterAttemptCooldown: false,
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

    final futures = <Future>[];
    for (final q in _questions) {
      if (q.id != null && _answers[q.id] != null) {
        futures.add(
          client.assessment.recordAnswer(
            attemptId: _attempt!.id!,
            questionId: q.id!,
            answer: _answers[q.id]!,
          ),
        );
      }
    }
    await Future.wait(futures);

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
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600) _buildQuestionGrid(),
          Expanded(child: _buildQuestionContent()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            _previousQuestion();
          } else if (index == 1) {
            _nextQuestion();
          } else if (index == 2) {
            _showSubmitConfirmation();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Previous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'Next',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Submit',
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionGrid() {
    return Container(
      width: 200,
      color: AppColors.slate100,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final q = _questions[index];
          final isAnswered = _answers.containsKey(q.id);
          final isCurrent = _currentIndex == index;
          final isFlagged = _markedForReview.contains(q.id);

          return GestureDetector(
            onTap: () => setState(() => _currentIndex = index),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isAnswered
                    ? AppColors.indigo600
                    : Colors.transparent,
                border: Border.all(
                  color: isCurrent
                      ? AppColors.indigo600
                      : AppColors.slate300,
                  width: isCurrent ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isAnswered ? Colors.white : AppColors.slate600,
                      ),
                    ),
                  ),
                  if (isFlagged)
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Icon(
                        Icons.flag,
                        size: 12,
                        color: Colors.yellow,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestionContent() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    if (_submitted) {
      return Center(
        child: Text(
          'Assessment Submitted! Your score: $_finalScore',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    final q = _questions[_currentIndex];
    final options = _parseOptions(q.optionsJson);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  q.text,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(
                  _markedForReview.contains(q.id)
                      ? Icons.flag
                      : Icons.outlined_flag,
                  color: _markedForReview.contains(q.id) ? Colors.yellow : null,
                ),
                onPressed: _toggleMarkForReview,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return RadioListTile<String>(
                value: option,
                groupValue: _answers[q.id],
                onChanged: (value) => _selectAnswer(value!),
                title: Text(option),
              );
            },
          ),
        ),
      ],
    );
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    }
  }
}

class _PassSuccessLottieDialog extends StatelessWidget {
  const _PassSuccessLottieDialog({
    required this.onComplete,
  });

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: 300,
        height: 300,
        child: Lottie.asset(
          'assets/lottie/success.json',
          onLoaded: (composition) {
            // Configure Lottie to loop the animation
            composition.duration;
          },
          repeat: true,
        ),
      ),
    );
  }
}
