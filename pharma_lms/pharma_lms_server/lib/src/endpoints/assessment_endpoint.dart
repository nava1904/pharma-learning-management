import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Assessment Engine domain endpoint.
class AssessmentEndpoint extends Endpoint {
  Future<Assessment?> getAssessmentForCourse(
    Session session,
    int courseVersionId,
  ) async {
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
    return await Question.db.find(
      session,
      where: (t) => t.questionBankId.equals(questionBankId),
    );
  }

  Future<AssessmentAttempt> startAttempt(
    Session session, {
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) async {
    final attempt = AssessmentAttempt(
      userId: userId,
      assessmentId: assessmentId,
      enrollmentId: enrollmentId,
    );
    return await AssessmentAttempt.db.insertRow(session, attempt);
  }

  Future<AssessmentAttempt> submitAttempt(
    Session session, {
    required int attemptId,
    required int score,
  }) async {
    final attempt = await AssessmentAttempt.db.findById(session, attemptId);
    if (attempt == null) throw Exception('Attempt not found');
    final updated = attempt.copyWith(
      completedAt: DateTime.now(),
      score: score,
    );
    return await AssessmentAttempt.db.updateRow(session, updated);
  }

  Future<AssessmentResult> recordAnswer(
    Session session, {
    required int attemptId,
    required int questionId,
    required String answer,
    required bool correct,
    int? points,
  }) async {
    final result = AssessmentResult(
      attemptId: attemptId,
      questionId: questionId,
      answer: answer,
      correct: correct,
      points: points,
    );
    return await AssessmentResult.db.insertRow(session, result);
  }

  Future<List<QuestionBank>> listQuestionBanks(
    Session session, {
    int? organizationId,
  }) async {
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
    final bank = QuestionBank(
      name: name,
      organizationId: organizationId,
      tagsJson: tagsJson,
    );
    return await QuestionBank.db.insertRow(session, bank);
  }
}
