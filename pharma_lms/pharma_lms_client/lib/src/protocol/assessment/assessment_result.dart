/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../assessment/assessment_attempt.dart' as _i2;
import '../assessment/question.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Individual question result within an attempt.
abstract class AssessmentResult implements _i1.SerializableModel {
  AssessmentResult._({
    this.id,
    required this.attemptId,
    this.attempt,
    required this.questionId,
    this.question,
    required this.answer,
    required this.correct,
    this.points,
    bool? needsManualGrading,
    this.manualScore,
    this.gradedById,
    this.gradedAt,
  }) : needsManualGrading = needsManualGrading ?? false;

  factory AssessmentResult({
    int? id,
    required int attemptId,
    _i2.AssessmentAttempt? attempt,
    required int questionId,
    _i3.Question? question,
    required String answer,
    required bool correct,
    int? points,
    bool? needsManualGrading,
    int? manualScore,
    int? gradedById,
    DateTime? gradedAt,
  }) = _AssessmentResultImpl;

  factory AssessmentResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssessmentResult(
      id: jsonSerialization['id'] as int?,
      attemptId: jsonSerialization['attemptId'] as int,
      attempt: jsonSerialization['attempt'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AssessmentAttempt>(
              jsonSerialization['attempt'],
            ),
      questionId: jsonSerialization['questionId'] as int,
      question: jsonSerialization['question'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Question>(
              jsonSerialization['question'],
            ),
      answer: jsonSerialization['answer'] as String,
      correct: _i1.BoolJsonExtension.fromJson(jsonSerialization['correct']),
      points: jsonSerialization['points'] as int?,
      needsManualGrading: jsonSerialization['needsManualGrading'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['needsManualGrading'],
            ),
      manualScore: jsonSerialization['manualScore'] as int?,
      gradedById: jsonSerialization['gradedById'] as int?,
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int attemptId;

  /// The attempt.
  _i2.AssessmentAttempt? attempt;

  int questionId;

  /// The question.
  _i3.Question? question;

  /// Answer given.
  String answer;

  /// Whether the answer was correct.
  bool correct;

  /// Points earned.
  int? points;

  /// Whether this result requires manual instructor grading (open_ended, unscored short_answer).
  bool needsManualGrading;

  /// Instructor-assigned score override (null until graded).
  int? manualScore;

  /// Instructor who graded this result.
  int? gradedById;

  /// Timestamp of instructor grading.
  DateTime? gradedAt;

  /// Returns a shallow copy of this [AssessmentResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssessmentResult copyWith({
    int? id,
    int? attemptId,
    _i2.AssessmentAttempt? attempt,
    int? questionId,
    _i3.Question? question,
    String? answer,
    bool? correct,
    int? points,
    bool? needsManualGrading,
    int? manualScore,
    int? gradedById,
    DateTime? gradedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssessmentResult',
      if (id != null) 'id': id,
      'attemptId': attemptId,
      if (attempt != null) 'attempt': attempt?.toJson(),
      'questionId': questionId,
      if (question != null) 'question': question?.toJson(),
      'answer': answer,
      'correct': correct,
      if (points != null) 'points': points,
      'needsManualGrading': needsManualGrading,
      if (manualScore != null) 'manualScore': manualScore,
      if (gradedById != null) 'gradedById': gradedById,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssessmentResultImpl extends AssessmentResult {
  _AssessmentResultImpl({
    int? id,
    required int attemptId,
    _i2.AssessmentAttempt? attempt,
    required int questionId,
    _i3.Question? question,
    required String answer,
    required bool correct,
    int? points,
    bool? needsManualGrading,
    int? manualScore,
    int? gradedById,
    DateTime? gradedAt,
  }) : super._(
         id: id,
         attemptId: attemptId,
         attempt: attempt,
         questionId: questionId,
         question: question,
         answer: answer,
         correct: correct,
         points: points,
         needsManualGrading: needsManualGrading,
         manualScore: manualScore,
         gradedById: gradedById,
         gradedAt: gradedAt,
       );

  /// Returns a shallow copy of this [AssessmentResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssessmentResult copyWith({
    Object? id = _Undefined,
    int? attemptId,
    Object? attempt = _Undefined,
    int? questionId,
    Object? question = _Undefined,
    String? answer,
    bool? correct,
    Object? points = _Undefined,
    bool? needsManualGrading,
    Object? manualScore = _Undefined,
    Object? gradedById = _Undefined,
    Object? gradedAt = _Undefined,
  }) {
    return AssessmentResult(
      id: id is int? ? id : this.id,
      attemptId: attemptId ?? this.attemptId,
      attempt: attempt is _i2.AssessmentAttempt?
          ? attempt
          : this.attempt?.copyWith(),
      questionId: questionId ?? this.questionId,
      question: question is _i3.Question?
          ? question
          : this.question?.copyWith(),
      answer: answer ?? this.answer,
      correct: correct ?? this.correct,
      points: points is int? ? points : this.points,
      needsManualGrading: needsManualGrading ?? this.needsManualGrading,
      manualScore: manualScore is int? ? manualScore : this.manualScore,
      gradedById: gradedById is int? ? gradedById : this.gradedById,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
    );
  }
}
