import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

/// Converts a Map<String, dynamic> to Map<String, String> for Serverpod wire serialization.
Map<String, String> _stringifyMap(Map<String, dynamic> m) =>
    m.map((k, v) => MapEntry(k, v is Map || v is List ? jsonEncode(v) : (v?.toString() ?? '')));

/// Assessment builder endpoint for SME/trainers.
/// TRN-WF-03: Build Assessment and Question Bank
class AssessmentBuilderEndpoint extends Endpoint {
  Future<Question> createQuestion(
    Session session, {
    required int questionBankId,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
    String? regulatoryTag,
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
  
  /// TRN-WF-03: Delete a question from a question bank.
  /// Note: Cannot delete questions if they have been used in completed attempts.
  Future<bool> deleteQuestion(
    Session session, {
    required int questionId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final question = await Question.db.findById(session, questionId);
    if (question == null) throw Exception('Question not found');
    
    // Check if question has been answered in any completed attempts
    final answers = await AssessmentResult.db.find(
      session,
      where: (t) => t.questionId.equals(questionId),
      limit: 1,
    );
    
    if (answers.isNotEmpty) {
      throw Exception('Cannot delete question: it has been used in assessment attempts. Consider marking as archived instead.');
    }
    
    await Question.db.deleteRow(session, question);
    return true;
  }
  
  /// TRN-WF-03: Create a new question bank.
  Future<QuestionBank> createQuestionBank(
    Session session, {
    required String name,
    required int organizationId,
    String? tagsJson,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    
    final bank = await QuestionBank.db.insertRow(
      session,
      QuestionBank(
        name: name,
        organizationId: organizationId,
        tagsJson: tagsJson,
      ),
    );
    
    await AuditService.log(
      session,
      entityType: 'question_bank',
      entityId: bank.id.toString(),
      action: 'QuestionBankCreated',
      newValueJson: '{"name":"$name","organizationId":$organizationId}',
    );
    
    return bank;
  }
  
  /// TRN-WF-03: Update question bank metadata.
  Future<QuestionBank> updateQuestionBank(
    Session session, {
    required int questionBankId,
    String? name,
    String? tagsJson,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    
    final bank = await QuestionBank.db.findById(session, questionBankId);
    if (bank == null) throw Exception('Question bank not found');
    
    final updated = bank.copyWith(
      name: name ?? bank.name,
      tagsJson: tagsJson ?? bank.tagsJson,
    );
    
    return await QuestionBank.db.updateRow(session, updated);
  }
  
  /// TRN-WF-03: Get questions in a bank with count for validation.
  Future<Map<String, String>> getQuestionBankDetails(
    Session session, {
    required int questionBankId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    
    final bank = await QuestionBank.db.findById(session, questionBankId);
    if (bank == null) throw Exception('Question bank not found');
    
    final questions = await Question.db.find(
      session,
      where: (t) => t.questionBankId.equals(questionBankId),
    );
    
    // Count by difficulty
    final easyCount = questions.where((q) => q.difficulty == 'easy').length;
    final mediumCount = questions.where((q) => q.difficulty == 'medium').length;
    final hardCount = questions.where((q) => q.difficulty == 'hard').length;
    
    // Count by type
    final multipleChoiceCount = questions.where((q) => q.questionType == 'multiple_choice').length;
    final trueFalseCount = questions.where((q) => q.questionType == 'true_false').length;
    final maxAllowed = questions.length > 0 ? questions.length - 1 : 0;
    
    return _stringifyMap({
      'id': bank.id,
      'name': bank.name,
      'totalQuestions': questions.length,
      'byDifficulty': {
        'easy': easyCount,
        'medium': mediumCount,
        'hard': hardCount,
      },
      'byType': {
        'multiple_choice': multipleChoiceCount,
        'true_false': trueFalseCount,
      },
      // Maximum questions that can be displayed (must be less than pool size)
      'maxQuestionsToDisplay': questions.isEmpty ? 0 : questions.length - 1,
    });
  }

  /// Create assessment — questionsToDisplay must be less than pool size.
  Future<Assessment> createAssessment(
    Session session, {
    required int courseVersionId,
    required int questionBankId,
    required int passingScore,
    bool randomize = true,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
    bool showAnswers = false,
    bool showSubmissionHistory = false,
    int? limitQuestions,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');

    // Validate: display count must be less than pool size
    if (questionsToDisplay != null) {
      final questions = await Question.db.find(
        session,
        where: (t) => t.questionBankId.equals(questionBankId),
      );
      final totalQuestions = questions.length;
      if (totalQuestions > 0 && questionsToDisplay >= totalQuestions) {
        throw Exception(
          'Questions to display ($questionsToDisplay) must be less than pool size ($totalQuestions).',
        );
      }
    }
    
    final result = await Assessment.db.insertRow(
      session,
      Assessment(
        courseVersionId: courseVersionId,
        questionBankId: questionBankId,
        passingScore: passingScore,
        randomize: randomize,
        timeLimitMinutes: timeLimitMinutes,
        maxAttempts: maxAttempts,
        questionsToDisplay: questionsToDisplay,
        showAnswers: showAnswers,
        showSubmissionHistory: showSubmissionHistory,
        limitQuestions: limitQuestions,
      ),
    );
    
    await AuditService.log(
      session,
      entityType: 'assessment',
      entityId: result.id.toString(),
      action: AuditEventType.configChanged,
      newValueJson: '{"courseVersionId":$courseVersionId,"passingScore":$passingScore,"questionsToDisplay":$questionsToDisplay}',
    );
    return result;
  }

  /// Update assessment — questionsToDisplay must be less than pool size.
  Future<Assessment> updateAssessment(
    Session session, {
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
    bool? showAnswers,
    bool? showSubmissionHistory,
    int? limitQuestions,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'write');
    final assessment = await Assessment.db.findById(session, assessmentId);
    if (assessment == null) throw Exception('Assessment not found');

    // Validate: display count must be less than pool size
    if (questionsToDisplay != null) {
      final questions = await Question.db.find(
        session,
        where: (t) => t.questionBankId.equals(assessment.questionBankId),
      );
      final totalQuestions = questions.length;
      if (totalQuestions > 0 && questionsToDisplay >= totalQuestions) {
        throw Exception(
          'Questions to display ($questionsToDisplay) must be less than pool size ($totalQuestions).',
        );
      }
    }
    
    final updated = assessment.copyWith(
      passingScore: passingScore ?? assessment.passingScore,
      randomize: randomize ?? assessment.randomize,
      timeLimitMinutes: timeLimitMinutes ?? assessment.timeLimitMinutes,
      maxAttempts: maxAttempts ?? assessment.maxAttempts,
      questionsToDisplay: questionsToDisplay ?? assessment.questionsToDisplay,
      showAnswers: showAnswers ?? assessment.showAnswers,
      showSubmissionHistory: showSubmissionHistory ?? assessment.showSubmissionHistory,
      limitQuestions: limitQuestions ?? assessment.limitQuestions,
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
  
  /// TRN-WF-03: Validate assessment configuration for QA submission.
  /// Returns validation status and any issues found.
  Future<Map<String, String>> validateAssessmentForSubmission(
    Session session, {
    required int assessmentId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    
    final assessment = await Assessment.db.findById(session, assessmentId);
    if (assessment == null) throw Exception('Assessment not found');
    
    final questions = await Question.db.find(
      session,
      where: (t) => t.questionBankId.equals(assessment.questionBankId),
    );
    
    final issues = <String>[];
    
    // Check minimum questions
    if (questions.isEmpty) {
      issues.add('Question bank has no questions');
    }
    
    // Validate display count < pool size
    final questionsToDisplay = assessment.questionsToDisplay ?? questions.length;
    if (questions.isNotEmpty && questionsToDisplay >= questions.length) {
      issues.add('Questions to display ($questionsToDisplay) must be less than pool size (${questions.length})');
    }
    
    // Check passing score is reasonable (10-100)
    if (assessment.passingScore < 10 || assessment.passingScore > 100) {
      issues.add('Passing score must be between 10 and 100');
    }

    // Define maxAllowed as in getQuestionBankDetails
    final maxAllowed = questions.isEmpty ? 0 : questions.length - 1;
    
    return _stringifyMap({
      'valid': issues.isEmpty,
      'issues': issues,
      'assessment': {
        'id': assessment.id,
        'questionBankId': assessment.questionBankId,
        'totalQuestions': questions.length,
        'questionsToDisplay': questionsToDisplay,
        'maxAllowedToDisplay': maxAllowed,
        'passingScore': assessment.passingScore,
        'randomize': assessment.randomize,
      },
    });
  }

  /// Admin/Trainer: List assessments for an organization (basic admin visibility).
  Future<List<Assessment>> listAssessments(
    Session session, {
    int? organizationId,
    int limit = 200,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');

    final clamped = limit.clamp(1, 500);
    if (organizationId == null) {
      return Assessment.db.find(
        session,
        limit: clamped,
        orderBy: (t) => t.id,
        orderDescending: true,
      );
    }

    // Assessments are tied to CourseVersion; CourseVersion -> Course -> organizationId.
    // Serverpod ORM can't easily express this join here, so we fetch versions in-org then filter.
    final courseVersions = await CourseVersion.db.find(
      session,
      where: (t) => t.course.organizationId.equals(organizationId),
      include: CourseVersion.include(course: Course.include()),
      limit: 1000,
    );
    final versionIds = courseVersions.map((v) => v.id).whereType<int>().toSet();
    if (versionIds.isEmpty) return [];

    return Assessment.db.find(
      session,
      where: (t) => t.courseVersionId.inSet(versionIds),
      limit: clamped,
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  /// Admin/Trainer: List attempts for an assessment.
  Future<List<AssessmentAttempt>> listAssessmentAttempts(
    Session session, {
    required int assessmentId,
    int limit = 200,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'assessment', action: 'read');
    final clamped = limit.clamp(1, 500);
    return AssessmentAttempt.db.find(
      session,
      where: (t) => t.assessmentId.equals(assessmentId),
      limit: clamped,
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }
}
