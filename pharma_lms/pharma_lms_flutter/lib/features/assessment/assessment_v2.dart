// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — ASSESSMENT SCREEN V2 (REACT REFERENCE MATCH)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Modern assessment/quiz interface matching the React reference design.
// Uses real data from Serverpod assessment endpoints.
//
// Features:
// - Clean question cards with progress indicator
// - Timer display (if time-limited)
// - Attempt tracking (Attempt X of Y)
// - Results screen with pass/fail status
// - 21 CFR Part 11 compliant (audit trail, no question pre-viewing)
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../design_system/pharma_design_system.dart';
import '../../core/client.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../esignature/esignature_screen.dart';
import '../../widgets/part11_step_up_dialog.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════

/// Assessment details for a course version
final assessmentForCourseProvider = FutureProvider.family<Assessment?, int>((ref, courseVersionId) async {
  return client.assessment.getAssessmentForCourse(courseVersionId);
});

/// Questions for a question bank
final questionsProvider = FutureProvider.family<List<Question>, int>((ref, questionBankId) async {
  return client.assessment.getQuestions(questionBankId);
});

// ═══════════════════════════════════════════════════════════════════════════════
// ASSESSMENT STATE NOTIFIER
// ═══════════════════════════════════════════════════════════════════════════════

class AssessmentState {
  final Assessment? assessment;
  final List<Question> questions;
  final int currentQuestionIndex;
  final Map<int, String> answers; // questionId -> answer
  final AssessmentAttempt? attempt;
  final bool isLoading;
  final bool isSubmitting;
  final bool isComplete;
  final int? score;
  final bool? passed;
  final String? errorMessage;
  final int remainingSeconds;
  final int currentAttemptNumber;
  final int maxAttempts;
  final bool needsEsignature; // True when passed and awaiting e-signature
  final int? esignatureId; // Set after e-signature completes
  final bool isReviewMode; // True when user came from completed enrollment
  /// Set when training completes and a certificate is issued (or resolved for review).
  final int? certificateId;

  const AssessmentState({
    this.assessment,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.answers = const {},
    this.attempt,
    this.isLoading = true,
    this.isSubmitting = false,
    this.isComplete = false,
    this.score,
    this.passed,
    this.errorMessage,
    this.remainingSeconds = 0,
    this.currentAttemptNumber = 1,
    this.maxAttempts = 0,
    this.needsEsignature = false,
    this.esignatureId,
    this.isReviewMode = false,
    this.certificateId,
  });

  AssessmentState copyWith({
    Assessment? assessment,
    List<Question>? questions,
    int? currentQuestionIndex,
    Map<int, String>? answers,
    AssessmentAttempt? attempt,
    bool? isLoading,
    bool? isSubmitting,
    bool? isComplete,
    int? score,
    bool? passed,
    String? errorMessage,
    int? remainingSeconds,
    int? currentAttemptNumber,
    int? maxAttempts,
    bool? needsEsignature,
    int? esignatureId,
    bool? isReviewMode,
    int? certificateId,
  }) {
    return AssessmentState(
      assessment: assessment ?? this.assessment,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answers: answers ?? this.answers,
      attempt: attempt ?? this.attempt,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isComplete: isComplete ?? this.isComplete,
      score: score ?? this.score,
      passed: passed ?? this.passed,
      errorMessage: errorMessage,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      currentAttemptNumber: currentAttemptNumber ?? this.currentAttemptNumber,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      needsEsignature: needsEsignature ?? this.needsEsignature,
      esignatureId: esignatureId ?? this.esignatureId,
      isReviewMode: isReviewMode ?? this.isReviewMode,
      certificateId: certificateId ?? this.certificateId,
    );
  }
}

class AssessmentNotifier extends ChangeNotifier {
  final int courseVersionId;
  final int? enrollmentId;
  final bool forceRetake;
  final int userId;
  final VoidCallback? onTrainingCompleted;
  Timer? _timer;
  
  AssessmentState _state = const AssessmentState();
  AssessmentState get state => _state;
  
  void _updateState(AssessmentState newState) {
    _state = newState;
    notifyListeners();
  }

  AssessmentNotifier({
    required this.courseVersionId,
    required this.userId,
    this.enrollmentId,
    this.forceRetake = false,
    this.onTrainingCompleted,
  });

  Future<void> initialize() async {
    try {
      // Get assessment for course
      final assessment = await client.assessment.getAssessmentForCourse(courseVersionId);
      if (assessment == null) {
        _updateState(_state.copyWith(
          isLoading: false,
          errorMessage: 'No assessment found for this course.',
        ));
        return;
      }

      // Get questions
      final questions = await client.assessment.getQuestions(assessment.questionBankId);
      if (questions.isEmpty) {
        _updateState(_state.copyWith(
          isLoading: false,
          errorMessage: 'No questions available for this assessment.',
        ));
        return;
      }

      // Get attempt count for attempt tracking (FR-08-03: "Attempt 2 of 3")
      int attemptCount = 0;
      if (assessment.id != null) {
        try {
          attemptCount = await client.assessment.getAttemptCount(
            userId: userId,
            assessmentId: assessment.id!,
            enrollmentId: enrollmentId,
          );
        } catch (_) {}
      }
      final maxAttempts = assessment.maxAttempts ?? 3;

      bool enrollmentIsCompleted = false;

      // Check if already completed - show review mode instead of starting new attempt
      if (enrollmentId != null) {
        try {
          final enrollment = await client.training.getEnrollmentById(enrollmentId!);
          enrollmentIsCompleted = enrollment?.status == 'completed';
          if (enrollmentIsCompleted && !forceRetake) {
            final records = await client.training.getTrainingRecordsForUser(userId);
            final record = records.where((r) => r.courseVersionId == courseVersionId).firstOrNull;

            int? certId;
            try {
              final certs = await client.training.getCertificatesForUser(userId);
              for (final c in certs) {
                if (c.courseVersionId == courseVersionId && c.id != null) {
                  certId = c.id;
                  break;
                }
              }
            } catch (_) {}

            // Only lock into review mode after a real training/assessment outcome exists.
            // If enrollment is "completed" but no record, attempts, or certificate yet, allow taking the assessment.
            final hasAssessmentHistory =
                record != null || attemptCount > 0 || certId != null;
            if (!hasAssessmentHistory) {
              // Fall through to startAttempt below.
            } else {
              List<Question> displayQuestions = List.from(questions);
              if (assessment.randomize) displayQuestions.shuffle();
              if (assessment.questionsToDisplay != null &&
                  assessment.questionsToDisplay! < displayQuestions.length) {
                displayQuestions = displayQuestions.take(assessment.questionsToDisplay!).toList();
              }

              _updateState(_state.copyWith(
                assessment: assessment,
                questions: displayQuestions,
                isLoading: false,
                isComplete: true,
                isReviewMode: true,
                currentAttemptNumber: attemptCount,
                maxAttempts: maxAttempts,
                score: record?.score,
                passed: true,
                certificateId: certId,
              ));
              return;
            }
          }
        } catch (_) {}
      }

      // Check if max attempts exceeded
      if (maxAttempts > 0 && attemptCount >= maxAttempts) {
        _updateState(_state.copyWith(
          isLoading: false,
          errorMessage: 'Maximum attempts reached ($attemptCount of $maxAttempts). Contact your supervisor for additional attempts.',
        ));
        return;
      }

      // Randomize if needed
      List<Question> displayQuestions = List.from(questions);
      if (assessment.randomize) {
        displayQuestions.shuffle();
      }
      
      // Limit to questionsToDisplay if set
      if (assessment.questionsToDisplay != null && 
          assessment.questionsToDisplay! < displayQuestions.length) {
        displayQuestions = displayQuestions.take(assessment.questionsToDisplay!).toList();
      }

      // Start attempt ([forceRetake] bypasses server 24h inter-attempt cooldown.)
      final attempt = await client.assessment.startAttempt(
        userId: userId,
        assessmentId: assessment.id!,
        enrollmentId: enrollmentId,
        skipInterAttemptCooldown: forceRetake,
      );

      // Set initial remaining time
      final remainingSeconds = (assessment.timeLimitMinutes ?? 0) * 60;

      _updateState(_state.copyWith(
        assessment: assessment,
        questions: displayQuestions,
        attempt: attempt,
        isLoading: false,
        remainingSeconds: remainingSeconds,
        currentAttemptNumber: attemptCount + 1,
        maxAttempts: maxAttempts,
        isReviewMode: false,
      ));

      // Start timer if time-limited
      if (assessment.timeLimitMinutes != null && assessment.timeLimitMinutes! > 0) {
        _startTimer();
      }
    } catch (e) {
      _updateState(_state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.remainingSeconds <= 0) {
        timer.cancel();
        submitAssessment(); // Auto-submit when time runs out
      } else {
        _updateState(_state.copyWith(remainingSeconds: _state.remainingSeconds - 1));
      }
    });
  }

  void selectAnswer(int questionId, String answer) {
    final newAnswers = Map<int, String>.from(_state.answers);
    newAnswers[questionId] = answer;
    _updateState(_state.copyWith(answers: newAnswers));
  }

  void nextQuestion() {
    if (_state.currentQuestionIndex < _state.questions.length - 1) {
      _updateState(_state.copyWith(currentQuestionIndex: _state.currentQuestionIndex + 1));
    }
  }

  void previousQuestion() {
    if (_state.currentQuestionIndex > 0) {
      _updateState(_state.copyWith(currentQuestionIndex: _state.currentQuestionIndex - 1));
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _state.questions.length) {
      _updateState(_state.copyWith(currentQuestionIndex: index));
    }
  }

  Future<void> submitAssessment() async {
    if (_state.isSubmitting || _state.attempt == null) return;
    
    _timer?.cancel();
    _updateState(_state.copyWith(isSubmitting: true));

    try {
      // Record all answers
      for (final entry in _state.answers.entries) {
        await client.assessment.recordAnswer(
          attemptId: _state.attempt!.id!,
          questionId: entry.key,
          answer: entry.value,
        );
      }

      // Submit attempt
      final result = await client.assessment.submitAttempt(attemptId: _state.attempt!.id!);
      
      final passed = (result.score ?? 0) >= (_state.assessment?.passingScore ?? 80);

      // EMP-WF-06: If passed, set needsEsignature flag — the UI will show the modal
      // The e-signature modal will be triggered from the UI layer (not auto-created here)
      // This ensures 21 CFR Part 11 compliance: fresh password re-auth within 60 seconds
      _updateState(_state.copyWith(
        isSubmitting: false,
        isComplete: true,
        score: result.score,
        passed: passed,
        attempt: result,
        needsEsignature: passed && enrollmentId != null,
      ));
    } catch (e) {
      _updateState(_state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to submit assessment: $e',
      ));
    }
  }

  /// Called after e-signature modal returns successfully
  Future<void> completeWithEsignature(int esignatureId) async {
    if (enrollmentId == null) return;

    try {
      final cert = await client.training.completeTraining(
        enrollmentId: enrollmentId!,
        userId: userId,
        courseVersionId: courseVersionId,
        esignatureId: esignatureId,
        score: _state.score,
      );
      onTrainingCompleted?.call();
      _updateState(_state.copyWith(
        needsEsignature: false,
        esignatureId: esignatureId,
        certificateId: cert.id,
      ));
    } catch (e) {

      _updateState(_state.copyWith(
        needsEsignature: false,
        esignatureId: esignatureId,
      ));
      await ensureCertificateIdResolved();
    }
  }

  /// Fills [certificateId] from the server when not yet in state (e.g. after error recovery).
  Future<void> ensureCertificateIdResolved() async {
    if (_state.certificateId != null) return;
    try {
      final certs = await client.training.getCertificatesForUser(userId);
      for (final c in certs) {
        if (c.courseVersionId == courseVersionId && c.id != null) {
          _updateState(_state.copyWith(certificateId: c.id));
          return;
        }
      }
    } catch (_) {}
  }

  /// Called if e-signature is skipped/cancelled
  void skipEsignature() {
    _updateState(_state.copyWith(needsEsignature: false));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN ASSESSMENT SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AssessmentScreenV2 extends ConsumerStatefulWidget {
  final int courseVersionId;
  final int? enrollmentId;
  /// When true, allows starting a new assessment attempt even if the enrollment is already `completed`.
  final bool forceRetake;

  const AssessmentScreenV2({
    super.key,
    required this.courseVersionId,
    this.enrollmentId,
    this.forceRetake = false,
  });

  @override
  ConsumerState<AssessmentScreenV2> createState() => _AssessmentScreenV2State();
}

class _AssessmentScreenV2State extends ConsumerState<AssessmentScreenV2> {
  late AssessmentNotifier _notifier;
  bool _initialized = false;
  bool _showInstructions = true;

  /// Prefer returning to the previous screen (e.g. course viewer). Avoid bogus paths like `/training`.
  void _popOrGoLearningHub() {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
      return;
    }
    final role = ref.read(selectedRoleProvider);
    if (role == AppRole.employee || role == AppRole.admin) {
      context.go('/employee/my-training');
      return;
    }
    if (role == null) {
      context.go('/employee/my-training');
      return;
    }
    context.go('/learning');
  }

  @override
  void initState() {
    super.initState();
    _initNotifier();
  }

  Future<void> _initNotifier() async {
    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to take the assessment')),
        );
        context.go('/');
      }
      return;
    }

    _notifier = AssessmentNotifier(
      courseVersionId: widget.courseVersionId,
      enrollmentId: widget.enrollmentId,
      forceRetake: widget.forceRetake,
      userId: user!.id!,
      onTrainingCompleted: () {
        ref.invalidate(certificatesProvider);
        ref.invalidate(enrollmentsProvider);
      },
    );
    
    await _notifier.initialize();
    if (mounted) {
      setState(() => _initialized = true);
    }
  }

  @override
  void dispose() {
    if (_initialized) {
      _notifier.dispose();
    }
    super.dispose();
  }

  bool _esignatureShown = false;

  Future<void> _showEsignatureFlow() async {
    if (_esignatureShown) return; // Prevent double-trigger
    _esignatureShown = true;

    final state = _notifier.state;
    if (!mounted || state.attempt?.id == null) return;

    // EMP-WF-06: Show the dedicated e-signature modal with 60-second countdown
    // and password re-authentication (21 CFR Part 11 compliant)
    final esignatureId = await showEsignatureModal(
      context,
      entityType: 'assessment_attempt',
      entityId: state.attempt!.id.toString(),
      signatureMeaning: 'I confirm that I have completed and understood this training material.',
      userId: _notifier.userId,
    );

    if (esignatureId != null && mounted) {
      await _notifier.completeWithEsignature(esignatureId);
    } else {
      _notifier.skipEsignature();
    }
    _esignatureShown = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Scaffold(
        backgroundColor: PharmaColors.background,
        body: const Center(
          child: CircularProgressIndicator(color: PharmaColors.emerald500),
        ),
      );
    }

    return ListenableBuilder(
      listenable: _notifier,
      builder: (context, _) {
        final state = _notifier.state;

        if (state.isLoading) {
          return Scaffold(
            backgroundColor: PharmaColors.background,
            body: const Center(
              child: CircularProgressIndicator(color: PharmaColors.emerald500),
            ),
          );
        }

        if (state.errorMessage != null) {
          return _ErrorScreen(
            message: state.errorMessage!,
            onRetry: () => _popOrGoLearningHub(),
          );
        }

        if (_showInstructions && !state.isComplete) {
          return _InstructionsScreen(
            assessment: state.assessment!,
            totalQuestions: state.questions.length,
            attemptNumber: state.currentAttemptNumber,
            maxAttempts: state.maxAttempts,
            onStart: () async {
              final user = await ref.read(currentUserProvider.future);
              if (!mounted || user?.id == null) return;
              final printed =
                  '${user!.firstName} ${user.lastName}'.trim();
              if (!context.mounted) return;
              final ok = await showPart11StepUpDialog(
                context: context,
                userId: user.id!,
                printedName: printed.isEmpty ? user.email : printed,
                title: 'Assessment — electronic acknowledgment',
                attestText:
                    'I will complete this assessment personally, without unauthorized assistance, and in accordance with company training policy.',
              );
              if (!context.mounted) return;
              if (ok) setState(() => _showInstructions = false);
            },
            onBack: () => _popOrGoLearningHub(),
          );
        }

        if (state.isComplete) {
          // EMP-WF-06: Show e-signature modal immediately after passing
          // 21 CFR Part 11: Fresh password re-auth within 60-second window
          if (state.needsEsignature && state.passed == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showEsignatureFlow();
            });
          }

          return _ResultsScreen(
            score: state.score ?? 0,
            passed: state.passed ?? false,
            passingScore: state.assessment?.passingScore ?? 80,
            totalQuestions: state.questions.length,
            answeredQuestions: state.answers.length,
            attemptNumber: state.currentAttemptNumber,
            maxAttempts: state.maxAttempts,
            esignatureCompleted: state.esignatureId != null,
            needsEsignature: state.needsEsignature,
            isReviewMode: state.isReviewMode,
            onContinue: () => _popOrGoLearningHub(),
            onViewCertificate:
                state.passed == true &&
                        (state.isReviewMode ||
                            state.certificateId != null ||
                            state.esignatureId != null)
                    ? () async {
                        await _notifier.ensureCertificateIdResolved();
                        if (!context.mounted) return;
                        final id = _notifier.state.certificateId;
                        if (id != null) {
                          context.push('/certificate/$id');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Certificate not found. It may still be processing—try again in a moment.',
                              ),
                            ),
                          );
                        }
                      }
                    : null,
            onSignNow: () => _showEsignatureFlow(),
            onRetake: state.isReviewMode
                ? () {
                    final q = DateTime.now().millisecondsSinceEpoch.toString();
                    context.go(
                      Uri(
                        path: '/assessment-v2/${widget.courseVersionId}',
                        queryParameters: {'r': q},
                      ).toString(),
                      extra: {
                        'enrollmentId': widget.enrollmentId,
                        'forceRetake': true,
                      },
                    );
                  }
                : null,
            onBack: () => _popOrGoLearningHub(),
          );
        }

        return _AssessmentContent(
          state: state,
          onSelectAnswer: _notifier.selectAnswer,
          onNext: _notifier.nextQuestion,
          onPrevious: _notifier.previousQuestion,
          onGoToQuestion: _notifier.goToQuestion,
          onSubmit: _notifier.submitAssessment,
          onAbandon: _popOrGoLearningHub,
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ASSESSMENT CONTENT
// ═══════════════════════════════════════════════════════════════════════════════

class _AssessmentContent extends StatelessWidget {
  final AssessmentState state;
  final void Function(int, String) onSelectAnswer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final void Function(int) onGoToQuestion;
  final VoidCallback onSubmit;
  final VoidCallback onAbandon;

  const _AssessmentContent({
    required this.state,
    required this.onSelectAnswer,
    required this.onNext,
    required this.onPrevious,
    required this.onGoToQuestion,
    required this.onSubmit,
    required this.onAbandon,
  });

  @override
  Widget build(BuildContext context) {
    final currentQuestion = state.questions[state.currentQuestionIndex];
    final isLastQuestion = state.currentQuestionIndex == state.questions.length - 1;
    final answeredCount = state.answers.length;
    final totalQuestions = state.questions.length;

    return Scaffold(
      backgroundColor: PharmaColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ─────────────────────────────────────────────────────────────────
            // HEADER
            // ─────────────────────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              decoration: BoxDecoration(
                color: PharmaColors.surface,
                border: Border(
                  bottom: BorderSide(color: PharmaColors.border, width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _showExitConfirmation(context, onAbandon),
                    color: PharmaColors.textSecondary,
                  ),
                  const SizedBox(width: PharmaSpacing.md),
                  
                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Assessment',
                              style: PharmaTypography.headingMedium,
                            ),
                            if (state.maxAttempts > 0) ...[
                              const SizedBox(width: PharmaSpacing.md),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: PharmaColors.infoBg,
                                  borderRadius: BorderRadius.circular(PharmaRadius.full),
                                ),
                                child: Text(
                                  'Attempt ${state.currentAttemptNumber} of ${state.maxAttempts}',
                                  style: PharmaTypography.labelSmall.copyWith(
                                    color: PharmaColors.infoText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          'Question ${state.currentQuestionIndex + 1} of $totalQuestions',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Timer (if applicable)
                  if (state.assessment?.timeLimitMinutes != null && 
                      state.assessment!.timeLimitMinutes! > 0)
                    _TimerDisplay(remainingSeconds: state.remainingSeconds),
                ],
              ),
            ),

            // ─────────────────────────────────────────────────────────────────
            // PROGRESS BAR
            // ─────────────────────────────────────────────────────────────────
            LinearProgressIndicator(
              value: (state.currentQuestionIndex + 1) / totalQuestions,
              backgroundColor: PharmaColors.gray100,
              valueColor: const AlwaysStoppedAnimation(PharmaColors.emerald500),
              minHeight: 4,
            ),

            // ─────────────────────────────────────────────────────────────────
            // QUESTION CONTENT
            // ─────────────────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: _QuestionCard(
                      question: currentQuestion,
                      questionNumber: state.currentQuestionIndex + 1,
                      selectedAnswer: state.answers[currentQuestion.id],
                      onSelectAnswer: (answer) => onSelectAnswer(currentQuestion.id!, answer),
                    ),
                  ),
                ),
              ),
            ),

            // ─────────────────────────────────────────────────────────────────
            // NAVIGATION FOOTER
            // ─────────────────────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              decoration: BoxDecoration(
                color: PharmaColors.surface,
                border: Border(
                  top: BorderSide(color: PharmaColors.border, width: 1),
                ),
                boxShadow: PharmaShadows.md,
              ),
              child: Row(
                children: [
                  // Question palette
                  _QuestionPalette(
                    totalQuestions: totalQuestions,
                    currentIndex: state.currentQuestionIndex,
                    answeredQuestions: state.answers.keys.toSet(),
                    questions: state.questions,
                    onTap: onGoToQuestion,
                  ),
                  
                  const Spacer(),
                  
                  // Answered count
                  Text(
                    '$answeredCount of $totalQuestions answered',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                  ),
                  
                  const SizedBox(width: PharmaSpacing.lg),
                  
                  // Previous button
                  if (state.currentQuestionIndex > 0)
                    OutlinedButton(
                      onPressed: onPrevious,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PharmaColors.textPrimary,
                        side: BorderSide(color: PharmaColors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: PharmaSpacing.lg,
                          vertical: PharmaSpacing.md,
                        ),
                      ),
                      child: const Text('Previous'),
                    ),
                  
                  const SizedBox(width: PharmaSpacing.md),
                  
                  // Next/Submit button
                  ElevatedButton(
                    onPressed: state.isSubmitting
                        ? null
                        : (isLastQuestion ? onSubmit : onNext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLastQuestion 
                          ? PharmaColors.emerald500 
                          : PharmaColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: PharmaSpacing.xl,
                        vertical: PharmaSpacing.md,
                      ),
                    ),
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(isLastQuestion ? 'Submit Assessment' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

void _showExitConfirmation(BuildContext context, VoidCallback onAbandon) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Exit Assessment?'),
      content: const Text(
        'Your progress will be lost if you exit now. Are you sure you want to leave?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Continue Assessment'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            onAbandon();
          },
          style: TextButton.styleFrom(foregroundColor: PharmaColors.danger),
          child: const Text('Exit'),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// QUESTION CARD
// ═══════════════════════════════════════════════════════════════════════════════

class _QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final String? selectedAnswer;
  final void Function(String) onSelectAnswer;

  const _QuestionCard({
    required this.question,
    required this.questionNumber,
    this.selectedAnswer,
    required this.onSelectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    // Parse options from JSON or comma-separated
    List<String> options = [];
    try {
      if (question.optionsJson.startsWith('[')) {
        options = List<String>.from(
          question.optionsJson.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '').split(',').map((e) => e.trim()),
        );
      } else {
        options = question.optionsJson.split(',').map((e) => e.trim()).toList();
      }
    } catch (_) {
      options = question.optionsJson.split(',').map((e) => e.trim()).toList();
    }

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.surface,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.border),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question number badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PharmaSpacing.md,
              vertical: PharmaSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: PharmaColors.emerald50,
              borderRadius: BorderRadius.circular(PharmaRadius.full),
            ),
            child: Text(
              'Question $questionNumber',
              style: PharmaTypography.labelSmall.copyWith(
                color: PharmaColors.emerald700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          const SizedBox(height: PharmaSpacing.lg),
          
          // Question text
          Text(
            question.text,
            style: PharmaTypography.headingSmall.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: PharmaSpacing.xl),
          
          // Options
          ...options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final optionLabel = String.fromCharCode(65 + index); // A, B, C, D...
            final isSelected = selectedAnswer == option;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
              child: InkWell(
                onTap: () => onSelectAnswer(option),
                borderRadius: BorderRadius.circular(PharmaRadius.md),
                child: Container(
                  padding: const EdgeInsets.all(PharmaSpacing.lg),
                  decoration: BoxDecoration(
                    color: isSelected ? PharmaColors.emerald50 : PharmaColors.surface,
                    borderRadius: BorderRadius.circular(PharmaRadius.md),
                    border: Border.all(
                      color: isSelected ? PharmaColors.emerald500 : PharmaColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Option label circle
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? PharmaColors.emerald500 : PharmaColors.gray100,
                        ),
                        child: Center(
                          child: Text(
                            optionLabel,
                            style: PharmaTypography.labelMedium.copyWith(
                              color: isSelected ? Colors.white : PharmaColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: PharmaSpacing.md),
                      
                      // Option text
                      Expanded(
                        child: Text(
                          option,
                          style: PharmaTypography.body.copyWith(
                            color: isSelected ? PharmaColors.emerald700 : PharmaColors.textPrimary,
                          ),
                        ),
                      ),
                      
                      // Check icon
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: PharmaColors.emerald500,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TIMER DISPLAY
// ═══════════════════════════════════════════════════════════════════════════════

class _TimerDisplay extends StatelessWidget {
  final int remainingSeconds;

  const _TimerDisplay({required this.remainingSeconds});

  @override
  Widget build(BuildContext context) {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    final isLow = remainingSeconds < 300; // Less than 5 minutes

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PharmaSpacing.lg,
        vertical: PharmaSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isLow ? PharmaColors.danger.withValues(alpha: 0.1) : PharmaColors.gray100,
        borderRadius: BorderRadius.circular(PharmaRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 18,
            color: isLow ? PharmaColors.danger : PharmaColors.textSecondary,
          ),
          const SizedBox(width: PharmaSpacing.xs),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: PharmaTypography.labelMedium.copyWith(
              color: isLow ? PharmaColors.danger : PharmaColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// QUESTION PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

class _QuestionPalette extends StatelessWidget {
  final int totalQuestions;
  final int currentIndex;
  final Set<int> answeredQuestions;
  final List<Question> questions;
  final void Function(int) onTap;

  const _QuestionPalette({
    required this.totalQuestions,
    required this.currentIndex,
    required this.answeredQuestions,
    required this.questions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: totalQuestions,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isCurrent = index == currentIndex;
          final isAnswered = questions[index].id != null && 
              answeredQuestions.contains(questions[index].id);
          
          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(PharmaRadius.sm),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCurrent 
                    ? PharmaColors.primary 
                    : isAnswered 
                        ? PharmaColors.emerald500 
                        : PharmaColors.gray100,
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
                border: isCurrent 
                    ? null 
                    : Border.all(color: PharmaColors.border),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: PharmaTypography.labelSmall.copyWith(
                    color: (isCurrent || isAnswered) 
                        ? Colors.white 
                        : PharmaColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// RESULTS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class _ResultsScreen extends StatelessWidget {
  final int score;
  final bool passed;
  final int passingScore;
  final int totalQuestions;
  final int answeredQuestions;
  final int attemptNumber;
  final int maxAttempts;
  final bool esignatureCompleted;
  final bool needsEsignature;
  final bool isReviewMode;
  final VoidCallback onContinue;
  final VoidCallback? onViewCertificate;
  final VoidCallback onSignNow;
  final VoidCallback? onRetake;
  final VoidCallback? onBack;

  const _ResultsScreen({
    required this.score,
    required this.passed,
    required this.passingScore,
    required this.totalQuestions,
    required this.answeredQuestions,
    required this.attemptNumber,
    required this.maxAttempts,
    required this.esignatureCompleted,
    required this.needsEsignature,
    this.isReviewMode = false,
    required this.onContinue,
    this.onViewCertificate,
    required this.onSignNow,
    this.onRetake,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PharmaColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Result icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: passed 
                        ? PharmaColors.emerald50 
                        : PharmaColors.danger.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    passed ? Icons.check_circle : Icons.cancel,
                    size: 64,
                    color: passed ? PharmaColors.emerald500 : PharmaColors.danger,
                  ),
                ),
                
                const SizedBox(height: PharmaSpacing.xl),
                
                // Result text
                Text(
                  passed ? 'Congratulations!' : 'Assessment Not Passed',
                  style: PharmaTypography.displayLarge.copyWith(
                    color: passed ? PharmaColors.emerald700 : PharmaColors.danger,
                  ),
                ),
                
                const SizedBox(height: PharmaSpacing.md),
                
                Text(
                  passed 
                      ? 'You have successfully completed the assessment. Your certificate has been generated.'
                      : 'You need to score at least $passingScore% to pass.',
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: PharmaSpacing.xxl),
                
                // Score card with analytics
                Container(
                  padding: const EdgeInsets.all(PharmaSpacing.xl),
                  decoration: BoxDecoration(
                    color: PharmaColors.surface,
                    borderRadius: BorderRadius.circular(PharmaRadius.lg),
                    border: Border.all(color: PharmaColors.border),
                  ),
                  child: Column(
                    children: [
                      // Assessment Report header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.analytics_outlined, size: 18, color: PharmaColors.textTertiary),
                          const SizedBox(width: 6),
                          Text(
                            'Assessment Report',
                            style: PharmaTypography.caption.copyWith(
                              color: PharmaColors.textTertiary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PharmaSpacing.md),
                      Text(
                        '$score%',
                        style: PharmaTypography.displayLarge.copyWith(
                          fontSize: 48,
                          color: passed ? PharmaColors.emerald500 : PharmaColors.danger,
                        ),
                      ),
                      const SizedBox(height: PharmaSpacing.md),
                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ScoreStat(
                            label: 'Passing Score',
                            value: '$passingScore%',
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            margin: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg),
                            color: PharmaColors.border,
                          ),
                          _ScoreStat(
                            label: 'Answered',
                            value: '$answeredQuestions/$totalQuestions',
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            margin: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg),
                            color: PharmaColors.border,
                          ),
                          _ScoreStat(
                            label: 'Attempt',
                            value: maxAttempts > 0 ? '$attemptNumber of $maxAttempts' : '$attemptNumber',
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            margin: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg),
                            color: PharmaColors.border,
                          ),
                          _ScoreStat(
                            label: 'Status',
                            value: passed ? 'PASS' : 'FAIL',
                          ),
                        ],
                      ),

                      if (passed) ...[
                        const SizedBox(height: PharmaSpacing.lg),
                        const Divider(color: PharmaColors.borderLight),
                        const SizedBox(height: PharmaSpacing.md),
                        // E-signature & certificate confirmation
                        if (esignatureCompleted) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.verified_rounded, size: 16, color: PharmaColors.emerald600),
                              const SizedBox(width: 6),
                              Text(
                                'E-Signature recorded • Certificate issued',
                                style: PharmaTypography.caption.copyWith(
                                  color: PharmaColors.emerald700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '21 CFR Part 11 compliant',
                            style: PharmaTypography.caption.copyWith(
                              color: PharmaColors.textTertiary,
                              fontSize: 11,
                            ),
                          ),
                        ] else if (needsEsignature) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.draw_rounded, size: 16, color: PharmaColors.warning),
                              const SizedBox(width: 6),
                              Text(
                                'E-Signature required to issue certificate',
                                style: PharmaTypography.caption.copyWith(
                                  color: PharmaColors.warning,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: PharmaSpacing.md),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: onSignNow,
                              icon: const Icon(Icons.draw_rounded, size: 18),
                              label: const Text('Sign Now'),
                              style: FilledButton.styleFrom(
                                backgroundColor: PharmaColors.emerald600,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.md),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: PharmaSpacing.xxl),
                
                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PharmaColors.emerald500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(PharmaRadius.md),
                      ),
                    ),
                    child: Text(passed ? 'Continue' : 'Return to Course'),
                  ),
                ),

                if (passed && onViewCertificate != null) ...[
                  const SizedBox(height: PharmaSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onViewCertificate,
                      icon: const Icon(Icons.workspace_premium_rounded, size: 18),
                      label: const Text('View Certificate'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PharmaColors.emerald600,
                        side: BorderSide(color: PharmaColors.emerald500.withValues(alpha: 0.4)),
                        padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.lg),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PharmaRadius.md),
                        ),
                      ),
                    ),
                  ),
                ],
                
                if (!passed) ...[
                  const SizedBox(height: PharmaSpacing.md),
                  Text(
                    maxAttempts > 0
                        ? 'Attempts remaining: ${maxAttempts - attemptNumber}. A 24-hour cooldown period applies before retaking.'
                        : 'A 24-hour cooldown period applies before retaking.',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],

                if (isReviewMode) ...[
                  if (onRetake != null && maxAttempts > 0 && attemptNumber < maxAttempts) ...[
                    const SizedBox(height: PharmaSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: onRetake,
                        icon: const Icon(Icons.replay_rounded, size: 18),
                        label: const Text('Retake Assessment'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PharmaColors.primary,
                          side: BorderSide(color: PharmaColors.primary.withValues(alpha: 0.4)),
                          padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.lg),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(PharmaRadius.md),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: PharmaSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back, size: 18),
                      label: const Text('Back to My Learning'),
                      style: TextButton.styleFrom(
                        foregroundColor: PharmaColors.textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.md),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreStat extends StatelessWidget {
  final String label;
  final String value;

  const _ScoreStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: PharmaTypography.headingMedium,
        ),
        Text(
          label,
          style: PharmaTypography.caption.copyWith(
            color: PharmaColors.textTertiary,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INSTRUCTIONS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class _InstructionsScreen extends StatelessWidget {
  final Assessment assessment;
  final int totalQuestions;
  final int attemptNumber;
  final int maxAttempts;
  final Future<void> Function() onStart;
  final VoidCallback onBack;

  const _InstructionsScreen({
    required this.assessment,
    required this.totalQuestions,
    required this.attemptNumber,
    required this.maxAttempts,
    required this.onStart,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final timeLimit = assessment.timeLimitMinutes;
    final passingScore = assessment.passingScore ?? 80;

    return Scaffold(
      backgroundColor: PharmaColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBack,
                    color: PharmaColors.textSecondary,
                  ),
                  const SizedBox(height: PharmaSpacing.lg),

                  // Header icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PharmaColors.emerald50,
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        size: 40,
                        color: PharmaColors.emerald600,
                      ),
                    ),
                  ),
                  const SizedBox(height: PharmaSpacing.xl),

                  Center(
                    child: Text(
                      'Assessment',
                      style: PharmaTypography.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: PharmaSpacing.xxl),

                  // Info cards
                  Container(
                    padding: const EdgeInsets.all(PharmaSpacing.xl),
                    decoration: BoxDecoration(
                      color: PharmaColors.surface,
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                      border: Border.all(color: PharmaColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assessment Details',
                          style: PharmaTypography.headingSmall,
                        ),
                        const SizedBox(height: PharmaSpacing.lg),
                        _InfoRow(icon: Icons.quiz_outlined, label: 'Questions', value: '$totalQuestions'),
                        if (timeLimit != null && timeLimit > 0)
                          _InfoRow(icon: Icons.timer_outlined, label: 'Time Limit', value: '$timeLimit minutes'),
                        _InfoRow(icon: Icons.check_circle_outline, label: 'Passing Score', value: '$passingScore%'),
                        _InfoRow(
                          icon: Icons.replay,
                          label: 'Attempts',
                          value: maxAttempts > 0
                              ? 'Attempt $attemptNumber of $maxAttempts'
                              : 'Attempt $attemptNumber (unlimited)',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: PharmaSpacing.lg),

                  // Rules
                  Container(
                    padding: const EdgeInsets.all(PharmaSpacing.xl),
                    decoration: BoxDecoration(
                      color: PharmaColors.infoBg,
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                      border: Border.all(color: PharmaColors.infoText.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 18, color: PharmaColors.infoText),
                            const SizedBox(width: PharmaSpacing.sm),
                            Text(
                              'Important Rules',
                              style: PharmaTypography.labelMedium.copyWith(
                                color: PharmaColors.infoText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: PharmaSpacing.md),
                        _RuleBullet('Questions may be randomized for each attempt'),
                        _RuleBullet('All attempts are tracked for compliance records'),
                        _RuleBullet('E-signature is required upon passing (21 CFR Part 11)'),
                        if (timeLimit != null && timeLimit > 0)
                          _RuleBullet('Assessment auto-submits when time expires'),
                        _RuleBullet('You cannot return to the assessment once submitted'),
                      ],
                    ),
                  ),
                  const SizedBox(height: PharmaSpacing.xxl),

                  // Start button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async => onStart(),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Start Assessment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PharmaColors.emerald500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.lg),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PharmaRadius.md),
                        ),
                        textStyle: PharmaTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
      child: Row(
        children: [
          Icon(icon, size: 20, color: PharmaColors.textTertiary),
          const SizedBox(width: PharmaSpacing.md),
          Text(label, style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary)),
          const Spacer(),
          Text(value, style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _RuleBullet extends StatelessWidget {
  final String text;
  const _RuleBullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PharmaColors.infoText,
              ),
            ),
          ),
          const SizedBox(width: PharmaSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: PharmaTypography.caption.copyWith(color: PharmaColors.infoText),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ERROR SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class _ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorScreen({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PharmaColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: PharmaColors.danger,
              ),
              const SizedBox(height: PharmaSpacing.lg),
              Text(
                'Unable to Start Assessment',
                style: PharmaTypography.headingMedium,
              ),
              const SizedBox(height: PharmaSpacing.md),
              Text(
                message,
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: PharmaSpacing.xl),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
