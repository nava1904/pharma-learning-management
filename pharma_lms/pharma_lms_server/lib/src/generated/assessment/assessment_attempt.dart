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
import '../organization/user.dart' as _i2;
import '../assessment/assessment.dart' as _i3;
import '../training/enrollment.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// User attempt at an assessment.
abstract class AssessmentAttempt
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AssessmentAttempt._({
    this.id,
    required this.userId,
    this.user,
    required this.assessmentId,
    this.assessment,
    this.enrollmentId,
    this.enrollment,
    DateTime? startedAt,
    this.completedAt,
    this.score,
  }) : startedAt = startedAt ?? DateTime.now();

  factory AssessmentAttempt({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int assessmentId,
    _i3.Assessment? assessment,
    int? enrollmentId,
    _i4.Enrollment? enrollment,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
  }) = _AssessmentAttemptImpl;

  factory AssessmentAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssessmentAttempt(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      assessmentId: jsonSerialization['assessmentId'] as int,
      assessment: jsonSerialization['assessment'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Assessment>(
              jsonSerialization['assessment'],
            ),
      enrollmentId: jsonSerialization['enrollmentId'] as int?,
      enrollment: jsonSerialization['enrollment'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Enrollment>(
              jsonSerialization['enrollment'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      score: jsonSerialization['score'] as int?,
    );
  }

  static final t = AssessmentAttemptTable();

  static const db = AssessmentAttemptRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int assessmentId;

  /// The assessment.
  _i3.Assessment? assessment;

  int? enrollmentId;

  /// Enrollment this attempt is for.
  _i4.Enrollment? enrollment;

  /// When started.
  DateTime startedAt;

  /// When completed (null if in progress).
  DateTime? completedAt;

  /// Score achieved.
  int? score;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AssessmentAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssessmentAttempt copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? assessmentId,
    _i3.Assessment? assessment,
    int? enrollmentId,
    _i4.Enrollment? enrollment,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssessmentAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'assessmentId': assessmentId,
      if (assessment != null) 'assessment': assessment?.toJson(),
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJson(),
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (score != null) 'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssessmentAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'assessmentId': assessmentId,
      if (assessment != null) 'assessment': assessment?.toJsonForProtocol(),
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJsonForProtocol(),
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (score != null) 'score': score,
    };
  }

  static AssessmentAttemptInclude include({
    _i2.PharmaUserInclude? user,
    _i3.AssessmentInclude? assessment,
    _i4.EnrollmentInclude? enrollment,
  }) {
    return AssessmentAttemptInclude._(
      user: user,
      assessment: assessment,
      enrollment: enrollment,
    );
  }

  static AssessmentAttemptIncludeList includeList({
    _i1.WhereExpressionBuilder<AssessmentAttemptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentAttemptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentAttemptTable>? orderByList,
    AssessmentAttemptInclude? include,
  }) {
    return AssessmentAttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentAttempt.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssessmentAttempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssessmentAttemptImpl extends AssessmentAttempt {
  _AssessmentAttemptImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int assessmentId,
    _i3.Assessment? assessment,
    int? enrollmentId,
    _i4.Enrollment? enrollment,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         assessmentId: assessmentId,
         assessment: assessment,
         enrollmentId: enrollmentId,
         enrollment: enrollment,
         startedAt: startedAt,
         completedAt: completedAt,
         score: score,
       );

  /// Returns a shallow copy of this [AssessmentAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssessmentAttempt copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? assessmentId,
    Object? assessment = _Undefined,
    Object? enrollmentId = _Undefined,
    Object? enrollment = _Undefined,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
    Object? score = _Undefined,
  }) {
    return AssessmentAttempt(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      assessmentId: assessmentId ?? this.assessmentId,
      assessment: assessment is _i3.Assessment?
          ? assessment
          : this.assessment?.copyWith(),
      enrollmentId: enrollmentId is int? ? enrollmentId : this.enrollmentId,
      enrollment: enrollment is _i4.Enrollment?
          ? enrollment
          : this.enrollment?.copyWith(),
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      score: score is int? ? score : this.score,
    );
  }
}

class AssessmentAttemptUpdateTable
    extends _i1.UpdateTable<AssessmentAttemptTable> {
  AssessmentAttemptUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> assessmentId(int value) => _i1.ColumnValue(
    table.assessmentId,
    value,
  );

  _i1.ColumnValue<int, int> enrollmentId(int? value) => _i1.ColumnValue(
    table.enrollmentId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<int, int> score(int? value) => _i1.ColumnValue(
    table.score,
    value,
  );
}

class AssessmentAttemptTable extends _i1.Table<int?> {
  AssessmentAttemptTable({super.tableRelation})
    : super(tableName: 'assessment_attempt') {
    updateTable = AssessmentAttemptUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    assessmentId = _i1.ColumnInt(
      'assessmentId',
      this,
    );
    enrollmentId = _i1.ColumnInt(
      'enrollmentId',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
      hasDefault: true,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
  }

  late final AssessmentAttemptUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt assessmentId;

  /// The assessment.
  _i3.AssessmentTable? _assessment;

  late final _i1.ColumnInt enrollmentId;

  /// Enrollment this attempt is for.
  _i4.EnrollmentTable? _enrollment;

  /// When started.
  late final _i1.ColumnDateTime startedAt;

  /// When completed (null if in progress).
  late final _i1.ColumnDateTime completedAt;

  /// Score achieved.
  late final _i1.ColumnInt score;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AssessmentAttempt.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.AssessmentTable get assessment {
    if (_assessment != null) return _assessment!;
    _assessment = _i1.createRelationTable(
      relationFieldName: 'assessment',
      field: AssessmentAttempt.t.assessmentId,
      foreignField: _i3.Assessment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AssessmentTable(tableRelation: foreignTableRelation),
    );
    return _assessment!;
  }

  _i4.EnrollmentTable get enrollment {
    if (_enrollment != null) return _enrollment!;
    _enrollment = _i1.createRelationTable(
      relationFieldName: 'enrollment',
      field: AssessmentAttempt.t.enrollmentId,
      foreignField: _i4.Enrollment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.EnrollmentTable(tableRelation: foreignTableRelation),
    );
    return _enrollment!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    assessmentId,
    enrollmentId,
    startedAt,
    completedAt,
    score,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'assessment') {
      return assessment;
    }
    if (relationField == 'enrollment') {
      return enrollment;
    }
    return null;
  }
}

class AssessmentAttemptInclude extends _i1.IncludeObject {
  AssessmentAttemptInclude._({
    _i2.PharmaUserInclude? user,
    _i3.AssessmentInclude? assessment,
    _i4.EnrollmentInclude? enrollment,
  }) {
    _user = user;
    _assessment = assessment;
    _enrollment = enrollment;
  }

  _i2.PharmaUserInclude? _user;

  _i3.AssessmentInclude? _assessment;

  _i4.EnrollmentInclude? _enrollment;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'assessment': _assessment,
    'enrollment': _enrollment,
  };

  @override
  _i1.Table<int?> get table => AssessmentAttempt.t;
}

class AssessmentAttemptIncludeList extends _i1.IncludeList {
  AssessmentAttemptIncludeList._({
    _i1.WhereExpressionBuilder<AssessmentAttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssessmentAttempt.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssessmentAttempt.t;
}

class AssessmentAttemptRepository {
  const AssessmentAttemptRepository._();

  final attachRow = const AssessmentAttemptAttachRowRepository._();

  final detachRow = const AssessmentAttemptDetachRowRepository._();

  /// Returns a list of [AssessmentAttempt]s matching the given query parameters.
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
  Future<List<AssessmentAttempt>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentAttemptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentAttemptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentAttemptTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentAttemptInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssessmentAttempt>(
      where: where?.call(AssessmentAttempt.t),
      orderBy: orderBy?.call(AssessmentAttempt.t),
      orderByList: orderByList?.call(AssessmentAttempt.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssessmentAttempt] matching the given query parameters.
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
  Future<AssessmentAttempt?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentAttemptTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssessmentAttemptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentAttemptTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentAttemptInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssessmentAttempt>(
      where: where?.call(AssessmentAttempt.t),
      orderBy: orderBy?.call(AssessmentAttempt.t),
      orderByList: orderByList?.call(AssessmentAttempt.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssessmentAttempt] by its [id] or null if no such row exists.
  Future<AssessmentAttempt?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssessmentAttemptInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssessmentAttempt>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssessmentAttempt]s in the list and returns the inserted rows.
  ///
  /// The returned [AssessmentAttempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssessmentAttempt>> insert(
    _i1.DatabaseSession session,
    List<AssessmentAttempt> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssessmentAttempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssessmentAttempt] and returns the inserted row.
  ///
  /// The returned [AssessmentAttempt] will have its `id` field set.
  Future<AssessmentAttempt> insertRow(
    _i1.DatabaseSession session,
    AssessmentAttempt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssessmentAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentAttempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssessmentAttempt>> update(
    _i1.DatabaseSession session,
    List<AssessmentAttempt> rows, {
    _i1.ColumnSelections<AssessmentAttemptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssessmentAttempt>(
      rows,
      columns: columns?.call(AssessmentAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentAttempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssessmentAttempt> updateRow(
    _i1.DatabaseSession session,
    AssessmentAttempt row, {
    _i1.ColumnSelections<AssessmentAttemptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssessmentAttempt>(
      row,
      columns: columns?.call(AssessmentAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentAttempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssessmentAttempt?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssessmentAttemptUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssessmentAttempt>(
      id,
      columnValues: columnValues(AssessmentAttempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentAttempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssessmentAttempt>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssessmentAttemptUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AssessmentAttemptTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentAttemptTable>? orderBy,
    _i1.OrderByListBuilder<AssessmentAttemptTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssessmentAttempt>(
      columnValues: columnValues(AssessmentAttempt.t.updateTable),
      where: where(AssessmentAttempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentAttempt.t),
      orderByList: orderByList?.call(AssessmentAttempt.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssessmentAttempt]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssessmentAttempt>> delete(
    _i1.DatabaseSession session,
    List<AssessmentAttempt> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssessmentAttempt>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssessmentAttempt].
  Future<AssessmentAttempt> deleteRow(
    _i1.DatabaseSession session,
    AssessmentAttempt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssessmentAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssessmentAttempt>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentAttemptTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssessmentAttempt>(
      where: where(AssessmentAttempt.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentAttemptTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssessmentAttempt>(
      where: where?.call(AssessmentAttempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssessmentAttempt] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentAttemptTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssessmentAttempt>(
      where: where(AssessmentAttempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssessmentAttemptAttachRowRepository {
  const AssessmentAttemptAttachRowRepository._();

  /// Creates a relation between the given [AssessmentAttempt] and [PharmaUser]
  /// by setting the [AssessmentAttempt]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    AssessmentAttempt assessmentAttempt,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentAttempt.id == null) {
      throw ArgumentError.notNull('assessmentAttempt.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $assessmentAttempt = assessmentAttempt.copyWith(userId: user.id);
    await session.db.updateRow<AssessmentAttempt>(
      $assessmentAttempt,
      columns: [AssessmentAttempt.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AssessmentAttempt] and [Assessment]
  /// by setting the [AssessmentAttempt]'s foreign key `assessmentId` to refer to the [Assessment].
  Future<void> assessment(
    _i1.DatabaseSession session,
    AssessmentAttempt assessmentAttempt,
    _i3.Assessment assessment, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentAttempt.id == null) {
      throw ArgumentError.notNull('assessmentAttempt.id');
    }
    if (assessment.id == null) {
      throw ArgumentError.notNull('assessment.id');
    }

    var $assessmentAttempt = assessmentAttempt.copyWith(
      assessmentId: assessment.id,
    );
    await session.db.updateRow<AssessmentAttempt>(
      $assessmentAttempt,
      columns: [AssessmentAttempt.t.assessmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AssessmentAttempt] and [Enrollment]
  /// by setting the [AssessmentAttempt]'s foreign key `enrollmentId` to refer to the [Enrollment].
  Future<void> enrollment(
    _i1.DatabaseSession session,
    AssessmentAttempt assessmentAttempt,
    _i4.Enrollment enrollment, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentAttempt.id == null) {
      throw ArgumentError.notNull('assessmentAttempt.id');
    }
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }

    var $assessmentAttempt = assessmentAttempt.copyWith(
      enrollmentId: enrollment.id,
    );
    await session.db.updateRow<AssessmentAttempt>(
      $assessmentAttempt,
      columns: [AssessmentAttempt.t.enrollmentId],
      transaction: transaction,
    );
  }
}

class AssessmentAttemptDetachRowRepository {
  const AssessmentAttemptDetachRowRepository._();

  /// Detaches the relation between this [AssessmentAttempt] and the [Enrollment] set in `enrollment`
  /// by setting the [AssessmentAttempt]'s foreign key `enrollmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> enrollment(
    _i1.DatabaseSession session,
    AssessmentAttempt assessmentAttempt, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentAttempt.id == null) {
      throw ArgumentError.notNull('assessmentAttempt.id');
    }

    var $assessmentAttempt = assessmentAttempt.copyWith(enrollmentId: null);
    await session.db.updateRow<AssessmentAttempt>(
      $assessmentAttempt,
      columns: [AssessmentAttempt.t.enrollmentId],
      transaction: transaction,
    );
  }
}
