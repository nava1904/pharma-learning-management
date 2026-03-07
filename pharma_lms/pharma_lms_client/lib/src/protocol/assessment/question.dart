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
import '../assessment/question_bank.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Question in a question bank.
abstract class Question implements _i1.SerializableModel {
  Question._({
    this.id,
    required this.questionBankId,
    this.questionBank,
    required this.text,
    required this.questionType,
    required this.optionsJson,
    required this.correctAnswer,
    this.difficulty,
  });

  factory Question({
    int? id,
    required int questionBankId,
    _i2.QuestionBank? questionBank,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      questionBankId: jsonSerialization['questionBankId'] as int,
      questionBank: jsonSerialization['questionBank'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.QuestionBank>(
              jsonSerialization['questionBank'],
            ),
      text: jsonSerialization['text'] as String,
      questionType: jsonSerialization['questionType'] as String,
      optionsJson: jsonSerialization['optionsJson'] as String,
      correctAnswer: jsonSerialization['correctAnswer'] as String,
      difficulty: jsonSerialization['difficulty'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int questionBankId;

  /// The question bank.
  _i2.QuestionBank? questionBank;

  /// Question text.
  String text;

  /// Type: multiple_choice, true_false.
  String questionType;

  /// Options as JSON array.
  String optionsJson;

  /// Correct answer index or value.
  String correctAnswer;

  /// Difficulty: easy, medium, hard.
  String? difficulty;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    int? id,
    int? questionBankId,
    _i2.QuestionBank? questionBank,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    String? difficulty,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'questionBankId': questionBankId,
      if (questionBank != null) 'questionBank': questionBank?.toJson(),
      'text': text,
      'questionType': questionType,
      'optionsJson': optionsJson,
      'correctAnswer': correctAnswer,
      if (difficulty != null) 'difficulty': difficulty,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int questionBankId,
    _i2.QuestionBank? questionBank,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
  }) : super._(
         id: id,
         questionBankId: questionBankId,
         questionBank: questionBank,
         text: text,
         questionType: questionType,
         optionsJson: optionsJson,
         correctAnswer: correctAnswer,
         difficulty: difficulty,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? questionBankId,
    Object? questionBank = _Undefined,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    Object? difficulty = _Undefined,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      questionBankId: questionBankId ?? this.questionBankId,
      questionBank: questionBank is _i2.QuestionBank?
          ? questionBank
          : this.questionBank?.copyWith(),
      text: text ?? this.text,
      questionType: questionType ?? this.questionType,
      optionsJson: optionsJson ?? this.optionsJson,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      difficulty: difficulty is String? ? difficulty : this.difficulty,
    );
  }
}
