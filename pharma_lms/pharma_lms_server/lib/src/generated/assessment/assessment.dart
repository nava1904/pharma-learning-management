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
import '../course/course_version.dart' as _i2;
import '../assessment/question_bank.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Assessment linked to course version.
abstract class Assessment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Assessment._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.questionBankId,
    this.questionBank,
    required this.passingScore,
    bool? randomize,
    this.timeLimitMinutes,
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
    );
  }

  static final t = AssessmentTable();

  static const db = AssessmentRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Assessment',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'questionBankId': questionBankId,
      if (questionBank != null)
        'questionBank': questionBank?.toJsonForProtocol(),
      'passingScore': passingScore,
      'randomize': randomize,
      if (timeLimitMinutes != null) 'timeLimitMinutes': timeLimitMinutes,
    };
  }

  static AssessmentInclude include({
    _i2.CourseVersionInclude? courseVersion,
    _i3.QuestionBankInclude? questionBank,
  }) {
    return AssessmentInclude._(
      courseVersion: courseVersion,
      questionBank: questionBank,
    );
  }

  static AssessmentIncludeList includeList({
    _i1.WhereExpressionBuilder<AssessmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentTable>? orderByList,
    AssessmentInclude? include,
  }) {
    return AssessmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Assessment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Assessment.t),
      include: include,
    );
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
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         questionBankId: questionBankId,
         questionBank: questionBank,
         passingScore: passingScore,
         randomize: randomize,
         timeLimitMinutes: timeLimitMinutes,
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
    );
  }
}

class AssessmentUpdateTable extends _i1.UpdateTable<AssessmentTable> {
  AssessmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> questionBankId(int value) => _i1.ColumnValue(
    table.questionBankId,
    value,
  );

  _i1.ColumnValue<int, int> passingScore(int value) => _i1.ColumnValue(
    table.passingScore,
    value,
  );

  _i1.ColumnValue<bool, bool> randomize(bool value) => _i1.ColumnValue(
    table.randomize,
    value,
  );

  _i1.ColumnValue<int, int> timeLimitMinutes(int? value) => _i1.ColumnValue(
    table.timeLimitMinutes,
    value,
  );
}

class AssessmentTable extends _i1.Table<int?> {
  AssessmentTable({super.tableRelation}) : super(tableName: 'assessment') {
    updateTable = AssessmentUpdateTable(this);
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    questionBankId = _i1.ColumnInt(
      'questionBankId',
      this,
    );
    passingScore = _i1.ColumnInt(
      'passingScore',
      this,
    );
    randomize = _i1.ColumnBool(
      'randomize',
      this,
      hasDefault: true,
    );
    timeLimitMinutes = _i1.ColumnInt(
      'timeLimitMinutes',
      this,
    );
  }

  late final AssessmentUpdateTable updateTable;

  late final _i1.ColumnInt courseVersionId;

  /// The course version.
  _i2.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt questionBankId;

  /// The question bank.
  _i3.QuestionBankTable? _questionBank;

  /// Passing score percentage (e.g., 80).
  late final _i1.ColumnInt passingScore;

  /// Whether to randomize questions.
  late final _i1.ColumnBool randomize;

  /// Time limit in minutes.
  late final _i1.ColumnInt timeLimitMinutes;

  _i2.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: Assessment.t.courseVersionId,
      foreignField: _i2.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i3.QuestionBankTable get questionBank {
    if (_questionBank != null) return _questionBank!;
    _questionBank = _i1.createRelationTable(
      relationFieldName: 'questionBank',
      field: Assessment.t.questionBankId,
      foreignField: _i3.QuestionBank.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.QuestionBankTable(tableRelation: foreignTableRelation),
    );
    return _questionBank!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseVersionId,
    questionBankId,
    passingScore,
    randomize,
    timeLimitMinutes,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'questionBank') {
      return questionBank;
    }
    return null;
  }
}

class AssessmentInclude extends _i1.IncludeObject {
  AssessmentInclude._({
    _i2.CourseVersionInclude? courseVersion,
    _i3.QuestionBankInclude? questionBank,
  }) {
    _courseVersion = courseVersion;
    _questionBank = questionBank;
  }

  _i2.CourseVersionInclude? _courseVersion;

  _i3.QuestionBankInclude? _questionBank;

  @override
  Map<String, _i1.Include?> get includes => {
    'courseVersion': _courseVersion,
    'questionBank': _questionBank,
  };

  @override
  _i1.Table<int?> get table => Assessment.t;
}

class AssessmentIncludeList extends _i1.IncludeList {
  AssessmentIncludeList._({
    _i1.WhereExpressionBuilder<AssessmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Assessment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Assessment.t;
}

class AssessmentRepository {
  const AssessmentRepository._();

  final attachRow = const AssessmentAttachRowRepository._();

  /// Returns a list of [Assessment]s matching the given query parameters.
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
  Future<List<Assessment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AssessmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Assessment>(
      where: where?.call(Assessment.t),
      orderBy: orderBy?.call(Assessment.t),
      orderByList: orderByList?.call(Assessment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Assessment] matching the given query parameters.
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
  Future<Assessment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AssessmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssessmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Assessment>(
      where: where?.call(Assessment.t),
      orderBy: orderBy?.call(Assessment.t),
      orderByList: orderByList?.call(Assessment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Assessment] by its [id] or null if no such row exists.
  Future<Assessment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AssessmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Assessment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Assessment]s in the list and returns the inserted rows.
  ///
  /// The returned [Assessment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Assessment>> insert(
    _i1.Session session,
    List<Assessment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Assessment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Assessment] and returns the inserted row.
  ///
  /// The returned [Assessment] will have its `id` field set.
  Future<Assessment> insertRow(
    _i1.Session session,
    Assessment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Assessment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Assessment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Assessment>> update(
    _i1.Session session,
    List<Assessment> rows, {
    _i1.ColumnSelections<AssessmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Assessment>(
      rows,
      columns: columns?.call(Assessment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Assessment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Assessment> updateRow(
    _i1.Session session,
    Assessment row, {
    _i1.ColumnSelections<AssessmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Assessment>(
      row,
      columns: columns?.call(Assessment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Assessment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Assessment?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AssessmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Assessment>(
      id,
      columnValues: columnValues(Assessment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Assessment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Assessment>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AssessmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AssessmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentTable>? orderBy,
    _i1.OrderByListBuilder<AssessmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Assessment>(
      columnValues: columnValues(Assessment.t.updateTable),
      where: where(Assessment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Assessment.t),
      orderByList: orderByList?.call(Assessment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Assessment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Assessment>> delete(
    _i1.Session session,
    List<Assessment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Assessment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Assessment].
  Future<Assessment> deleteRow(
    _i1.Session session,
    Assessment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Assessment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Assessment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AssessmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Assessment>(
      where: where(Assessment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AssessmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Assessment>(
      where: where?.call(Assessment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Assessment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AssessmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Assessment>(
      where: where(Assessment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssessmentAttachRowRepository {
  const AssessmentAttachRowRepository._();

  /// Creates a relation between the given [Assessment] and [CourseVersion]
  /// by setting the [Assessment]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.Session session,
    Assessment assessment,
    _i2.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (assessment.id == null) {
      throw ArgumentError.notNull('assessment.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $assessment = assessment.copyWith(courseVersionId: courseVersion.id);
    await session.db.updateRow<Assessment>(
      $assessment,
      columns: [Assessment.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Assessment] and [QuestionBank]
  /// by setting the [Assessment]'s foreign key `questionBankId` to refer to the [QuestionBank].
  Future<void> questionBank(
    _i1.Session session,
    Assessment assessment,
    _i3.QuestionBank questionBank, {
    _i1.Transaction? transaction,
  }) async {
    if (assessment.id == null) {
      throw ArgumentError.notNull('assessment.id');
    }
    if (questionBank.id == null) {
      throw ArgumentError.notNull('questionBank.id');
    }

    var $assessment = assessment.copyWith(questionBankId: questionBank.id);
    await session.db.updateRow<Assessment>(
      $assessment,
      columns: [Assessment.t.questionBankId],
      transaction: transaction,
    );
  }
}
