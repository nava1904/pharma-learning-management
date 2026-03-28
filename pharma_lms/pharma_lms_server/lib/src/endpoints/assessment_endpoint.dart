import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/event_service.dart';
import '../services/rbac_helper.dart';

/// Assessment Engine domain endpoint.
class AssessmentEndpoint extends Endpoint {
  Future<Assessment?> getAssessmentForCourse(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    final results = await Assessment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Question>> getQuestions(
    Session session,
    int questionBankId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    return await Question.db.find(
      session,
      where: (t) => t.questionBankId.equals(questionBankId),
    );
  }

  static const int _cooldownMinutes = 1440; // 24 hours

  /// When [skipInterAttemptCooldown] is true, the 24h gap between completed
  /// attempts is not enforced (explicit learner retake from review / practice).
  Future<AssessmentAttempt> startAttempt(
    Session session, {
    required int userId,
    required int assessmentId,
    int? enrollmentId,
    bool skipInterAttemptCooldown = false,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      throw Exception('Authentication required');
    }
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    if (enrollmentId != null) {
      final enrollment = await Enrollment.db.findById(session, enrollmentId);
      if (enrollment != null &&
          enrollment.retrainingChangeSummary != null &&
          enrollment.retrainingChangeSummary!.isNotEmpty &&
          enrollment.acknowledgedAt == null) {
        throw Exception(
          'Retraining change summary must be acknowledged before taking the assessment.',
        );
      }
    }

    final assessment = await Assessment.db.findById(session, assessmentId);
    if (assessment == null) throw Exception('Assessment not found');

    // Enforce maxAttempts
    if (assessment.maxAttempts != null && assessment.maxAttempts! > 0) {
      final completedAttempts = await AssessmentAttempt.db.find(
        session,
        where: (t) =>
            t.userId.equals(userId) &
            t.assessmentId.equals(assessmentId) &
            t.completedAt.notEquals(null),
      );
      if (completedAttempts.length >= assessment.maxAttempts!) {
        throw Exception(
          'Maximum attempts reached (${assessment.maxAttempts}). No more retakes allowed.',
        );
      }
    }

    final lastAttempt = await AssessmentAttempt.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.assessmentId.equals(assessmentId) &
          t.completedAt.notEquals(null),
      orderBy: (t) => t.startedAt,
      orderDescending: true,
    );
    if (!skipInterAttemptCooldown && lastAttempt?.completedAt != null) {
      final elapsed = DateTime.now().difference(lastAttempt!.completedAt!);
      if (elapsed.inMinutes < _cooldownMinutes) {
        final remaining = _cooldownMinutes - elapsed.inMinutes;
        throw Exception(
          'Cooldown: retry in ${remaining ~/ 60}h ${remaining % 60}m',
        );
      }
    }

    final attempt = AssessmentAttempt(
      userId: userId,
      assessmentId: assessmentId,
      enrollmentId: enrollmentId,
    );
    final inserted = await AssessmentAttempt.db.insertRow(session, attempt);
    if (inserted.id != null) {
      await EventService.emitAssessmentStarted(
        session,
        userId: userId,
        attemptId: inserted.id!,
        assessmentId: assessmentId,
      );
    }
    return inserted;
  }

  /// Completed attempts for trainer-visible learner transcript (same org).
  Future<List<AssessmentAttempt>> listCompletedAttemptsForUser(
    Session session, {
    required int userId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me == null) return [];
    await RbacHelper.requirePermission(session, resource: 'training', action: 'read');
    final target = await PharmaUser.db.findById(session, userId);
    if (target == null || target.organizationId != me.organizationId) return [];
    return AssessmentAttempt.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.completedAt.notEquals(null),
      include: AssessmentAttempt.include(
        assessment: Assessment.include(
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      ),
      orderBy: (t) => t.completedAt,
      orderDescending: true,
    );
  }

  /// Get attempt count for user+assessment+enrollment (for "Attempt X of Y" display).
  Future<int> getAttemptCount(
    Session session, {
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return 0;
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    final attempts = await AssessmentAttempt.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.assessmentId.equals(assessmentId),
    );
    final filtered = enrollmentId != null
        ? attempts.where((a) => a.enrollmentId == enrollmentId).toList()
        : attempts.where((a) => a.enrollmentId == null).toList();
    return filtered.length;
  }

  Future<AssessmentAttempt> submitAttempt(
    Session session, {
    required int attemptId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      throw Exception('Authentication required');
    }
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    final attempt = await AssessmentAttempt.db.findById(session, attemptId);
    if (attempt == null) throw Exception('Attempt not found');
    if (attempt.completedAt != null) {
      throw Exception('Attempt already submitted');
    }

    final assessment = await Assessment.db.findById(
      session,
      attempt.assessmentId ?? 0,
    );

    // Enforce timeLimitMinutes — auto-submit still counts but flag overtime
    bool overtimeSubmission = false;
    if (assessment?.timeLimitMinutes != null &&
        assessment!.timeLimitMinutes! > 0) {
      final elapsed = DateTime.now().difference(attempt.startedAt);
      if (elapsed.inMinutes > assessment.timeLimitMinutes!) {
        overtimeSubmission = true;
      }
    }

    final results = await AssessmentResult.db.find(
      session,
      where: (t) => t.attemptId.equals(attemptId),
    );
    final total = results.length;
    final correct = results.where((r) => r.correct).length;
    final score = total > 0 ? (correct * 100 / total).round() : 0;

    final passMark = assessment?.passingScore ?? 80;
    // Overtime submissions automatically fail
    final passed = overtimeSubmission ? false : score >= passMark;

    final updated = attempt.copyWith(
      completedAt: DateTime.now(),
      score: score,
    );
    final result = await AssessmentAttempt.db.updateRow(session, updated);

    await EventService.emitAssessmentCompleted(
      session,
      userId: attempt.userId ?? 0,
      attemptId: attemptId,
      passed: passed,
      score: score,
    );

    return result;
  }

  Future<AssessmentResult> recordAnswer(
    Session session, {
    required int attemptId,
    required int questionId,
    required String answer,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      throw Exception('Authentication required');
    }
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    final question = await Question.db.findById(session, questionId);
    if (question == null) throw Exception('Question not found');

    bool correct;
    bool needsManualGrading = false;

    switch (question.questionType) {
      case 'short_answer':
        if (question.correctAnswer == null || question.correctAnswer!.isEmpty) {
          correct = false;
          needsManualGrading = true;
        } else {
          try {
            final acceptedAnswers = (jsonDecode(question.correctAnswer!) as List)
                .map((e) => e.toString().trim().toLowerCase())
                .toList();
            correct = acceptedAnswers.contains(answer.trim().toLowerCase());
          } catch (_) {
            correct = answer.trim().toLowerCase() ==
                (question.correctAnswer ?? '').trim().toLowerCase();
          }
        }
        break;
      case 'open_ended':
        correct = false;
        needsManualGrading = true;
        break;
      default:
        correct = answer == question.correctAnswer;
    }

    final result = AssessmentResult(
      attemptId: attemptId,
      questionId: questionId,
      answer: answer,
      correct: correct,
      needsManualGrading: needsManualGrading,
    );
    return await AssessmentResult.db.insertRow(session, result);
  }

  Future<List<QuestionBank>> listQuestionBanks(
    Session session, {
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    if (organizationId != null) {
      return await QuestionBank.db.find(
        session,
        where: (t) => t.organizationId.equals(organizationId),
      );
    }
    return await QuestionBank.db.find(session);
  }

  Future<QuestionBank> createQuestionBank(
    Session session, {
    required String name,
    required int organizationId,
    String? tagsJson,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final bank = QuestionBank(
      name: name,
      organizationId: organizationId,
      tagsJson: tagsJson,
    );
    return await QuestionBank.db.insertRow(session, bank);
  }

  /// Generate a random assessment selection from a question bank using Fisher-Yates shuffle.
  Future<List<Question>> generateRandomAssessment(
    Session session, {
    required int questionBankId,
    required int count,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    
    final questions = await Question.db.find(
      session,
      where: (t) => t.questionBankId.equals(questionBankId),
    );
    
    if (questions.isEmpty) return [];
    final effectiveCount = count > questions.length ? questions.length : count;
    
    // Fisher-Yates shuffle
    final shuffled = List<Question>.from(questions);
    final random = DateTime.now().millisecondsSinceEpoch;
    var seed = random;
    for (var i = shuffled.length - 1; i > 0; i--) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      final j = seed % (i + 1);
      final temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    
    return shuffled.take(effectiveCount).toList();
  }

  /// Bulk import questions into a question bank.
  Future<List<Question>> importQuestionsToBank(
    Session session, {
    required int targetBankId,
    required List<Map<String, dynamic>> questions,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    
    final imported = <Question>[];
    for (final q in questions) {
      final question = await Question.db.insertRow(
        session,
        Question(
          questionBankId: targetBankId,
          text: q['text'] as String? ?? '',
          questionType: q['questionType'] as String? ?? 'multiple_choice',
          optionsJson: q['optionsJson'] as String? ?? '[]',
          correctAnswer: q['correctAnswer'] as String? ?? '0',
          difficulty: q['difficulty'] as String?,
          regulatoryTag: q['regulatoryTag'] as String?,
        ),
      );
      imported.add(question);
    }
    return imported;
  }

  /// List assessment results that need manual grading for a given assessment.
  Future<List<AssessmentResult>> listUngradedResults(
    Session session, {
    required int assessmentId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final attempts = await AssessmentAttempt.db.find(
      session,
      where: (t) =>
          t.assessmentId.equals(assessmentId) &
          t.completedAt.notEquals(null),
    );
    if (attempts.isEmpty) return [];

    final attemptIds = attempts.map((a) => a.id!).toList();
    final allResults = <AssessmentResult>[];
    for (final attemptId in attemptIds) {
      final results = await AssessmentResult.db.find(
        session,
        where: (t) =>
            t.attemptId.equals(attemptId) &
            t.needsManualGrading.equals(true) &
            t.gradedAt.equals(null),
        include: AssessmentResult.include(
          question: Question.include(),
          attempt: AssessmentAttempt.include(),
        ),
      );
      allResults.addAll(results);
    }
    return allResults;
  }

  /// Grade an individual assessment result (open_ended / short_answer).
  /// Recalculates the attempt score after grading.
  Future<AssessmentResult> gradeResult(
    Session session, {
    required int resultId,
    required bool correct,
    int? manualScore,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me == null) throw Exception('Authentication required');

    final result = await AssessmentResult.db.findById(session, resultId);
    if (result == null) throw Exception('Result not found');

    final graded = result.copyWith(
      correct: correct,
      manualScore: manualScore,
      gradedById: me.id,
      gradedAt: DateTime.now(),
    );
    final saved = await AssessmentResult.db.updateRow(session, graded);

    // Recalculate attempt score
    await _recalculateAttemptScore(session, result.attemptId);

    return saved;
  }

  /// Recalculate the total score for an attempt after manual grading.
  Future<void> _recalculateAttemptScore(Session session, int attemptId) async {
    final results = await AssessmentResult.db.find(
      session,
      where: (t) => t.attemptId.equals(attemptId),
    );
    if (results.isEmpty) return;

    final total = results.length;
    final correct = results.where((r) => r.correct).length;
    final score = total > 0 ? (correct * 100 / total).round() : 0;

    final attempt = await AssessmentAttempt.db.findById(session, attemptId);
    if (attempt == null) return;

    final updated = attempt.copyWith(score: score);
    await AssessmentAttempt.db.updateRow(session, updated);
  }

  /// List all results for a specific attempt (for instructor review).
  Future<List<AssessmentResult>> listResultsForAttempt(
    Session session, {
    required int attemptId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    return AssessmentResult.db.find(
      session,
      where: (t) => t.attemptId.equals(attemptId),
      include: AssessmentResult.include(
        question: Question.include(),
      ),
    );
  }
}
