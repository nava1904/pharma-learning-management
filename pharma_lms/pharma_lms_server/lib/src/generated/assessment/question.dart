/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../assessment/question_bank.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Question in a question bank.
abstract class Question
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Question._({
    this.id,
    required this.questionBankId,
    this.questionBank,
    required this.text,
    required this.questionType,
    required this.optionsJson,
    required this.correctAnswer,
    this.difficulty,
    this.regulatoryTag,
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
    String? regulatoryTag,
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
      regulatoryTag: jsonSerialization['regulatoryTag'] as String?,
    );
  }

  static final t = QuestionTable();

  static const db = QuestionRepository._();

  @override
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

  /// Regulatory tag (e.g., '21 CFR 11', 'GMP', 'ICH Q10').
  String? regulatoryTag;

  @override
  _i1.Table<int?> get table => t;

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
    String? regulatoryTag,
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
      if (regulatoryTag != null) 'regulatoryTag': regulatoryTag,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'questionBankId': questionBankId,
      if (questionBank != null)
        'questionBank': questionBank?.toJsonForProtocol(),
      'text': text,
      'questionType': questionType,
      'optionsJson': optionsJson,
      'correctAnswer': correctAnswer,
      if (difficulty != null) 'difficulty': difficulty,
      if (regulatoryTag != null) 'regulatoryTag': regulatoryTag,
    };
  }

  static QuestionInclude include({_i2.QuestionBankInclude? questionBank}) {
    return QuestionInclude._(questionBank: questionBank);
  }

  static QuestionIncludeList includeList({
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    QuestionInclude? include,
  }) {
    return QuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Question.t),
      include: include,
    );
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
    String? regulatoryTag,
  }) : super._(
         id: id,
         questionBankId: questionBankId,
         questionBank: questionBank,
         text: text,
         questionType: questionType,
         optionsJson: optionsJson,
         correctAnswer: correctAnswer,
         difficulty: difficulty,
         regulatoryTag: regulatoryTag,
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
    Object? regulatoryTag = _Undefined,
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
      regulatoryTag: regulatoryTag is String?
          ? regulatoryTag
          : this.regulatoryTag,
    );
  }
}

class QuestionUpdateTable extends _i1.UpdateTable<QuestionTable> {
  QuestionUpdateTable(super.table);

  _i1.ColumnValue<int, int> questionBankId(int value) => _i1.ColumnValue(
    table.questionBankId,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<String, String> questionType(String value) => _i1.ColumnValue(
    table.questionType,
    value,
  );

  _i1.ColumnValue<String, String> optionsJson(String value) => _i1.ColumnValue(
    table.optionsJson,
    value,
  );

  _i1.ColumnValue<String, String> correctAnswer(String value) =>
      _i1.ColumnValue(
        table.correctAnswer,
        value,
      );

  _i1.ColumnValue<String, String> difficulty(String? value) => _i1.ColumnValue(
    table.difficulty,
    value,
  );

  _i1.ColumnValue<String, String> regulatoryTag(String? value) =>
      _i1.ColumnValue(
        table.regulatoryTag,
        value,
      );
}

class QuestionTable extends _i1.Table<int?> {
  QuestionTable({super.tableRelation}) : super(tableName: 'question') {
    updateTable = QuestionUpdateTable(this);
    questionBankId = _i1.ColumnInt(
      'questionBankId',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    questionType = _i1.ColumnString(
      'questionType',
      this,
    );
    optionsJson = _i1.ColumnString(
      'optionsJson',
      this,
    );
    correctAnswer = _i1.ColumnString(
      'correctAnswer',
      this,
    );
    difficulty = _i1.ColumnString(
      'difficulty',
      this,
    );
    regulatoryTag = _i1.ColumnString(
      'regulatoryTag',
      this,
    );
  }

  late final QuestionUpdateTable updateTable;

  late final _i1.ColumnInt questionBankId;

  /// The question bank.
  _i2.QuestionBankTable? _questionBank;

  /// Question text.
  late final _i1.ColumnString text;

  /// Type: multiple_choice, true_false.
  late final _i1.ColumnString questionType;

  /// Options as JSON array.
  late final _i1.ColumnString optionsJson;

  /// Correct answer index or value.
  late final _i1.ColumnString correctAnswer;

  /// Difficulty: easy, medium, hard.
  late final _i1.ColumnString difficulty;

  /// Regulatory tag (e.g., '21 CFR 11', 'GMP', 'ICH Q10').
  late final _i1.ColumnString regulatoryTag;

  _i2.QuestionBankTable get questionBank {
    if (_questionBank != null) return _questionBank!;
    _questionBank = _i1.createRelationTable(
      relationFieldName: 'questionBank',
      field: Question.t.questionBankId,
      foreignField: _i2.QuestionBank.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.QuestionBankTable(tableRelation: foreignTableRelation),
    );
    return _questionBank!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    questionBankId,
    text,
    questionType,
    optionsJson,
    correctAnswer,
    difficulty,
    regulatoryTag,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'questionBank') {
      return questionBank;
    }
    return null;
  }
}

class QuestionInclude extends _i1.IncludeObject {
  QuestionInclude._({_i2.QuestionBankInclude? questionBank}) {
    _questionBank = questionBank;
  }

  _i2.QuestionBankInclude? _questionBank;

  @override
  Map<String, _i1.Include?> get includes => {'questionBank': _questionBank};

  @override
  _i1.Table<int?> get table => Question.t;
}

class QuestionIncludeList extends _i1.IncludeList {
  QuestionIncludeList._({
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Question.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Question.t;
}

class QuestionRepository {
  const QuestionRepository._();

  final attachRow = const QuestionAttachRowRepository._();

  /// Returns a list of [Question]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Question>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    _i1.Transaction? transaction,
    QuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Question] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Question?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    _i1.Transaction? transaction,
    QuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Question] by its [id] or null if no such row exists.
  Future<Question?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    QuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Question>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Question]s in the list and returns the inserted rows.
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Question>> insert(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Question>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Question] and returns the inserted row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question> insertRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Question]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Question>> update(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.ColumnSelections<QuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Question>(
      rows,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Question> updateRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.ColumnSelections<QuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Question>(
      row,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Question?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Question>(
      id,
      columnValues: columnValues(Question.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Question>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Question>(
      columnValues: columnValues(Question.t.updateTable),
      where: where(Question.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Question]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Question>> delete(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Question>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Question].
  Future<Question> deleteRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Question>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Question>(
      where: where(Question.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where?.call(Question.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Question] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Question>(
      where: where(Question.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class QuestionAttachRowRepository {
  const QuestionAttachRowRepository._();

  /// Creates a relation between the given [Question] and [QuestionBank]
  /// by setting the [Question]'s foreign key `questionBankId` to refer to the [QuestionBank].
  Future<void> questionBank(
    _i1.DatabaseSession session,
    Question question,
    _i2.QuestionBank questionBank, {
    _i1.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }
    if (questionBank.id == null) {
      throw ArgumentError.notNull('questionBank.id');
    }

    var $question = question.copyWith(questionBankId: questionBank.id);
    await session.db.updateRow<Question>(
      $question,
      columns: [Question.t.questionBankId],
      transaction: transaction,
    );
  }
}
