import 'package:serverpod/serverpod.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

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
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
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
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
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
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final result = await Assessment.db.insertRow(
      session,
      Assessment(
        courseVersionId: courseVersionId,
        questionBankId: questionBankId,
        passingScore: passingScore,
        randomize: randomize,
        timeLimitMinutes: timeLimitMinutes,
      ),
    );
    await AuditService.log(
      session,
      entityType: 'assessment',
      entityId: result.id.toString(),
      action: AuditEventType.configChanged,
      newValueJson: '{"courseVersionId":$courseVersionId,"passingScore":$passingScore}',
    );
    return result;
  }

  Future<Assessment> updateAssessment(
    Session session, {
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final assessment = await Assessment.db.findById(session, assessmentId);
    if (assessment == null) throw Exception('Assessment not found');
    final updated = assessment.copyWith(
      passingScore: passingScore ?? assessment.passingScore,
      randomize: randomize ?? assessment.randomize,
      timeLimitMinutes: timeLimitMinutes ?? assessment.timeLimitMinutes,
    );
    final result = await Assessment.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'assessment',
      entityId: assessmentId.toString(),
      action: AuditEventType.configChanged,
      oldValueJson: '{"passingScore":${assessment.passingScore}}',
      newValueJson: '{"passingScore":${result.passingScore}}',
    );
    return result;
  }
}
