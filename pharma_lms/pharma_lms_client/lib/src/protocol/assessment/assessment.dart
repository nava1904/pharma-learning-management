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
import '../course/course_version.dart' as _i2;
import '../assessment/question_bank.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Assessment linked to course version.
abstract class Assessment implements _i1.SerializableModel {
  Assessment._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.questionBankId,
    this.questionBank,
    required this.passingScore,
    bool? randomize,
    this.timeLimitMinutes,
    this.maxAttempts,
    this.questionsToDisplay,
  }) : randomize = randomize ?? true;

  factory Assessment({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int questionBankId,
    _i3.QuestionBank? questionBank,
    required int passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
  }) = _AssessmentImpl;

  factory Assessment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Assessment(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      questionBankId: jsonSerialization['questionBankId'] as int,
      questionBank: jsonSerialization['questionBank'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.QuestionBank>(
              jsonSerialization['questionBank'],
            ),
      passingScore: jsonSerialization['passingScore'] as int,
      randomize: jsonSerialization['randomize'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['randomize']),
      timeLimitMinutes: jsonSerialization['timeLimitMinutes'] as int?,
      maxAttempts: jsonSerialization['maxAttempts'] as int?,
      questionsToDisplay: jsonSerialization['questionsToDisplay'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseVersionId;

  /// The course version.
  _i2.CourseVersion? courseVersion;

  int questionBankId;

  /// The question bank.
  _i3.QuestionBank? questionBank;

  /// Passing score percentage (e.g., 80).
  int passingScore;

  /// Whether to randomize questions.
  bool randomize;

  /// Time limit in minutes.
  int? timeLimitMinutes;

  /// Maximum attempts allowed (0 = unlimited).
  int? maxAttempts;

  /// Number of questions to display from the bank.
  /// TRN-WF-03: Must be <= totalQuestions / 2 for adequate randomization.
  int? questionsToDisplay;

  /// Returns a shallow copy of this [Assessment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Assessment copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? questionBankId,
    _i3.QuestionBank? questionBank,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Assessment',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'questionBankId': questionBankId,
      if (questionBank != null) 'questionBank': questionBank?.toJson(),
      'passingScore': passingScore,
      'randomize': randomize,
      if (timeLimitMinutes != null) 'timeLimitMinutes': timeLimitMinutes,
      if (maxAttempts != null) 'maxAttempts': maxAttempts,
      if (questionsToDisplay != null) 'questionsToDisplay': questionsToDisplay,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssessmentImpl extends Assessment {
  _AssessmentImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int questionBankId,
    _i3.QuestionBank? questionBank,
    required int passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         questionBankId: questionBankId,
         questionBank: questionBank,
         passingScore: passingScore,
         randomize: randomize,
         timeLimitMinutes: timeLimitMinutes,
         maxAttempts: maxAttempts,
         questionsToDisplay: questionsToDisplay,
       );

  /// Returns a shallow copy of this [Assessment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Assessment copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? questionBankId,
    Object? questionBank = _Undefined,
    int? passingScore,
    bool? randomize,
    Object? timeLimitMinutes = _Undefined,
    Object? maxAttempts = _Undefined,
    Object? questionsToDisplay = _Undefined,
  }) {
    return Assessment(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      questionBankId: questionBankId ?? this.questionBankId,
      questionBank: questionBank is _i3.QuestionBank?
          ? questionBank
          : this.questionBank?.copyWith(),
      passingScore: passingScore ?? this.passingScore,
      randomize: randomize ?? this.randomize,
      timeLimitMinutes: timeLimitMinutes is int?
          ? timeLimitMinutes
          : this.timeLimitMinutes,
      maxAttempts: maxAttempts is int? ? maxAttempts : this.maxAttempts,
      questionsToDisplay: questionsToDisplay is int?
          ? questionsToDisplay
          : this.questionsToDisplay,
    );
  }
}
