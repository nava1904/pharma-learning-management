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
import '../assessment/assessment_attempt.dart' as _i2;
import '../assessment/question.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Individual question result within an attempt.
abstract class AssessmentResult
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = AssessmentResultTable();

  static const db = AssessmentResultRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssessmentResult',
      if (id != null) 'id': id,
      'attemptId': attemptId,
      if (attempt != null) 'attempt': attempt?.toJsonForProtocol(),
      'questionId': questionId,
      if (question != null) 'question': question?.toJsonForProtocol(),
      'answer': answer,
      'correct': correct,
      if (points != null) 'points': points,
      'needsManualGrading': needsManualGrading,
      if (manualScore != null) 'manualScore': manualScore,
      if (gradedById != null) 'gradedById': gradedById,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  static AssessmentResultInclude include({
    _i2.AssessmentAttemptInclude? attempt,
    _i3.QuestionInclude? question,
  }) {
    return AssessmentResultInclude._(
      attempt: attempt,
      question: question,
    );
  }

  static AssessmentResultIncludeList includeList({
    _i1.WhereExpressionBuilder<AssessmentResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentResultTable>? orderByList,
    AssessmentResultInclude? include,
  }) {
    return AssessmentResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentResult.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssessmentResult.t),
      include: include,
    );
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

class AssessmentResultUpdateTable
    extends _i1.UpdateTable<AssessmentResultTable> {
  AssessmentResultUpdateTable(super.table);

  _i1.ColumnValue<int, int> attemptId(int value) => _i1.ColumnValue(
    table.attemptId,
    value,
  );

  _i1.ColumnValue<int, int> questionId(int value) => _i1.ColumnValue(
    table.questionId,
    value,
  );

  _i1.ColumnValue<String, String> answer(String value) => _i1.ColumnValue(
    table.answer,
    value,
  );

  _i1.ColumnValue<bool, bool> correct(bool value) => _i1.ColumnValue(
    table.correct,
    value,
  );

  _i1.ColumnValue<int, int> points(int? value) => _i1.ColumnValue(
    table.points,
    value,
  );

  _i1.ColumnValue<bool, bool> needsManualGrading(bool value) => _i1.ColumnValue(
    table.needsManualGrading,
    value,
  );

  _i1.ColumnValue<int, int> manualScore(int? value) => _i1.ColumnValue(
    table.manualScore,
    value,
  );

  _i1.ColumnValue<int, int> gradedById(int? value) => _i1.ColumnValue(
    table.gradedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> gradedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.gradedAt,
        value,
      );
}

class AssessmentResultTable extends _i1.Table<int?> {
  AssessmentResultTable({super.tableRelation})
    : super(tableName: 'assessment_result') {
    updateTable = AssessmentResultUpdateTable(this);
    attemptId = _i1.ColumnInt(
      'attemptId',
      this,
    );
    questionId = _i1.ColumnInt(
      'questionId',
      this,
    );
    answer = _i1.ColumnString(
      'answer',
      this,
    );
    correct = _i1.ColumnBool(
      'correct',
      this,
    );
    points = _i1.ColumnInt(
      'points',
      this,
    );
    needsManualGrading = _i1.ColumnBool(
      'needsManualGrading',
      this,
      hasDefault: true,
    );
    manualScore = _i1.ColumnInt(
      'manualScore',
      this,
    );
    gradedById = _i1.ColumnInt(
      'gradedById',
      this,
    );
    gradedAt = _i1.ColumnDateTime(
      'gradedAt',
      this,
    );
  }

  late final AssessmentResultUpdateTable updateTable;

  late final _i1.ColumnInt attemptId;

  /// The attempt.
  _i2.AssessmentAttemptTable? _attempt;

  late final _i1.ColumnInt questionId;

  /// The question.
  _i3.QuestionTable? _question;

  /// Answer given.
  late final _i1.ColumnString answer;

  /// Whether the answer was correct.
  late final _i1.ColumnBool correct;

  /// Points earned.
  late final _i1.ColumnInt points;

  /// Whether this result requires manual instructor grading (open_ended, unscored short_answer).
  late final _i1.ColumnBool needsManualGrading;

  /// Instructor-assigned score override (null until graded).
  late final _i1.ColumnInt manualScore;

  /// Instructor who graded this result.
  late final _i1.ColumnInt gradedById;

  /// Timestamp of instructor grading.
  late final _i1.ColumnDateTime gradedAt;

  _i2.AssessmentAttemptTable get attempt {
    if (_attempt != null) return _attempt!;
    _attempt = _i1.createRelationTable(
      relationFieldName: 'attempt',
      field: AssessmentResult.t.attemptId,
      foreignField: _i2.AssessmentAttempt.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AssessmentAttemptTable(tableRelation: foreignTableRelation),
    );
    return _attempt!;
  }

  _i3.QuestionTable get question {
    if (_question != null) return _question!;
    _question = _i1.createRelationTable(
      relationFieldName: 'question',
      field: AssessmentResult.t.questionId,
      foreignField: _i3.Question.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.QuestionTable(tableRelation: foreignTableRelation),
    );
    return _question!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    attemptId,
    questionId,
    answer,
    correct,
    points,
    needsManualGrading,
    manualScore,
    gradedById,
    gradedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'attempt') {
      return attempt;
    }
    if (relationField == 'question') {
      return question;
    }
    return null;
  }
}

class AssessmentResultInclude extends _i1.IncludeObject {
  AssessmentResultInclude._({
    _i2.AssessmentAttemptInclude? attempt,
    _i3.QuestionInclude? question,
  }) {
    _attempt = attempt;
    _question = question;
  }

  _i2.AssessmentAttemptInclude? _attempt;

  _i3.QuestionInclude? _question;

  @override
  Map<String, _i1.Include?> get includes => {
    'attempt': _attempt,
    'question': _question,
  };

  @override
  _i1.Table<int?> get table => AssessmentResult.t;
}

class AssessmentResultIncludeList extends _i1.IncludeList {
  AssessmentResultIncludeList._({
    _i1.WhereExpressionBuilder<AssessmentResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssessmentResult.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssessmentResult.t;
}

class AssessmentResultRepository {
  const AssessmentResultRepository._();

  final attachRow = const AssessmentResultAttachRowRepository._();

  /// Returns a list of [AssessmentResult]s matching the given query parameters.
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
  Future<List<AssessmentResult>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentResultTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssessmentResult>(
      where: where?.call(AssessmentResult.t),
      orderBy: orderBy?.call(AssessmentResult.t),
      orderByList: orderByList?.call(AssessmentResult.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssessmentResult] matching the given query parameters.
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
  Future<AssessmentResult?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssessmentResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentResultTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssessmentResult>(
      where: where?.call(AssessmentResult.t),
      orderBy: orderBy?.call(AssessmentResult.t),
      orderByList: orderByList?.call(AssessmentResult.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssessmentResult] by its [id] or null if no such row exists.
  Future<AssessmentResult?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssessmentResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssessmentResult>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssessmentResult]s in the list and returns the inserted rows.
  ///
  /// The returned [AssessmentResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssessmentResult>> insert(
    _i1.DatabaseSession session,
    List<AssessmentResult> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssessmentResult>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssessmentResult] and returns the inserted row.
  ///
  /// The returned [AssessmentResult] will have its `id` field set.
  Future<AssessmentResult> insertRow(
    _i1.DatabaseSession session,
    AssessmentResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssessmentResult>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssessmentResult>> update(
    _i1.DatabaseSession session,
    List<AssessmentResult> rows, {
    _i1.ColumnSelections<AssessmentResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssessmentResult>(
      rows,
      columns: columns?.call(AssessmentResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssessmentResult> updateRow(
    _i1.DatabaseSession session,
    AssessmentResult row, {
    _i1.ColumnSelections<AssessmentResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssessmentResult>(
      row,
      columns: columns?.call(AssessmentResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssessmentResult?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssessmentResultUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssessmentResult>(
      id,
      columnValues: columnValues(AssessmentResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssessmentResult>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssessmentResultUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AssessmentResultTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentResultTable>? orderBy,
    _i1.OrderByListBuilder<AssessmentResultTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssessmentResult>(
      columnValues: columnValues(AssessmentResult.t.updateTable),
      where: where(AssessmentResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentResult.t),
      orderByList: orderByList?.call(AssessmentResult.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssessmentResult]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssessmentResult>> delete(
    _i1.DatabaseSession session,
    List<AssessmentResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssessmentResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssessmentResult].
  Future<AssessmentResult> deleteRow(
    _i1.DatabaseSession session,
    AssessmentResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssessmentResult>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssessmentResult>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssessmentResult>(
      where: where(AssessmentResult.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssessmentResult>(
      where: where?.call(AssessmentResult.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssessmentResult] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentResultTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssessmentResult>(
      where: where(AssessmentResult.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssessmentResultAttachRowRepository {
  const AssessmentResultAttachRowRepository._();

  /// Creates a relation between the given [AssessmentResult] and [AssessmentAttempt]
  /// by setting the [AssessmentResult]'s foreign key `attemptId` to refer to the [AssessmentAttempt].
  Future<void> attempt(
    _i1.DatabaseSession session,
    AssessmentResult assessmentResult,
    _i2.AssessmentAttempt attempt, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentResult.id == null) {
      throw ArgumentError.notNull('assessmentResult.id');
    }
    if (attempt.id == null) {
      throw ArgumentError.notNull('attempt.id');
    }

    var $assessmentResult = assessmentResult.copyWith(attemptId: attempt.id);
    await session.db.updateRow<AssessmentResult>(
      $assessmentResult,
      columns: [AssessmentResult.t.attemptId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AssessmentResult] and [Question]
  /// by setting the [AssessmentResult]'s foreign key `questionId` to refer to the [Question].
  Future<void> question(
    _i1.DatabaseSession session,
    AssessmentResult assessmentResult,
    _i3.Question question, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentResult.id == null) {
      throw ArgumentError.notNull('assessmentResult.id');
    }
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $assessmentResult = assessmentResult.copyWith(questionId: question.id);
    await session.db.updateRow<AssessmentResult>(
      $assessmentResult,
      columns: [AssessmentResult.t.questionId],
      transaction: transaction,
    );
  }
}
