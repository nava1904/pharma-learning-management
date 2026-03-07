import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Assessment builder endpoint for SME/trainers.
class AssessmentBuilderEndpoint extends Endpoint {
  Future<Question> createQuestion(
    Session session, {
    required int questionBankId,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
  }) async {
    return await Question.db.insertRow(
      session,
      Question(
        questionBankId: questionBankId,
        text: text,
        questionType: questionType,
        optionsJson: optionsJson,
        correctAnswer: correctAnswer,
        difficulty: difficulty,
      ),
    );
  }

  Future<Question> updateQuestion(
    Session session, {
    required int questionId,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    String? difficulty,
  }) async {
    final question = await Question.db.findById(session, questionId);
    if (question == null) throw Exception('Question not found');
    final updated = question.copyWith(
      text: text ?? question.text,
      questionType: questionType ?? question.questionType,
      optionsJson: optionsJson ?? question.optionsJson,
      correctAnswer: correctAnswer ?? question.correctAnswer,
      difficulty: difficulty ?? question.difficulty,
    );
    return await Question.db.updateRow(session, updated);
  }

  Future<Assessment> createAssessment(
    Session session, {
    required int courseVersionId,
    required int questionBankId,
    required int passingScore,
    bool randomize = true,
    int? timeLimitMinutes,
  }) async {
    return await Assessment.db.insertRow(
      session,
      Assessment(
        courseVersionId: courseVersionId,
        questionBankId: questionBankId,
        passingScore: passingScore,
        randomize: randomize,
        timeLimitMinutes: timeLimitMinutes,
      ),
    );
  }

  Future<Assessment> updateAssessment(
    Session session, {
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
  }) async {
    final assessment = await Assessment.db.findById(session, assessmentId);
    if (assessment == null) throw Exception('Assessment not found');
    final updated = assessment.copyWith(
      passingScore: passingScore ?? assessment.passingScore,
      randomize: randomize ?? assessment.randomize,
      timeLimitMinutes: timeLimitMinutes ?? assessment.timeLimitMinutes,
    );
    return await Assessment.db.updateRow(session, updated);
  }
}
