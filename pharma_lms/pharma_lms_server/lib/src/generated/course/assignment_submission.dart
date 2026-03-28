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
import '../course/assignment.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Student submission for an assignment.
abstract class AssignmentSubmission
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AssignmentSubmission._({
    this.id,
    required this.assignmentId,
    this.assignment,
    this.userId,
    this.user,
    this.submissionUrl,
    this.storageKey,
    this.fileName,
    String? status,
    this.grade,
    this.feedback,
    DateTime? submittedAt,
    this.gradedAt,
  }) : status = status ?? 'submitted',
       submittedAt = submittedAt ?? DateTime.now();

  factory AssignmentSubmission({
    int? id,
    required int assignmentId,
    _i2.Assignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
    String? status,
    int? grade,
    String? feedback,
    DateTime? submittedAt,
    DateTime? gradedAt,
  }) = _AssignmentSubmissionImpl;

  factory AssignmentSubmission.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AssignmentSubmission(
      id: jsonSerialization['id'] as int?,
      assignmentId: jsonSerialization['assignmentId'] as int,
      assignment: jsonSerialization['assignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Assignment>(
              jsonSerialization['assignment'],
            ),
      userId: jsonSerialization['userId'] as int?,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      submissionUrl: jsonSerialization['submissionUrl'] as String?,
      storageKey: jsonSerialization['storageKey'] as String?,
      fileName: jsonSerialization['fileName'] as String?,
      status: jsonSerialization['status'] as String?,
      grade: jsonSerialization['grade'] as int?,
      feedback: jsonSerialization['feedback'] as String?,
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
    );
  }

  static final t = AssignmentSubmissionTable();

  static const db = AssignmentSubmissionRepository._();

  @override
  int? id;

  int assignmentId;

  /// The assignment being submitted to.
  _i2.Assignment? assignment;

  int? userId;

  /// The user who submitted.
  _i3.PharmaUser? user;

  /// URL submission.
  String? submissionUrl;

  /// File upload storage key.
  String? storageKey;

  /// Original file name.
  String? fileName;

  /// Status: submitted, graded, returned.
  String status;

  /// Grade (0-100).
  int? grade;

  /// Instructor feedback.
  String? feedback;

  /// Submitted timestamp.
  DateTime submittedAt;

  /// Graded timestamp.
  DateTime? gradedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AssignmentSubmission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssignmentSubmission copyWith({
    int? id,
    int? assignmentId,
    _i2.Assignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
    String? status,
    int? grade,
    String? feedback,
    DateTime? submittedAt,
    DateTime? gradedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssignmentSubmission',
      if (id != null) 'id': id,
      'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJson(),
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (submissionUrl != null) 'submissionUrl': submissionUrl,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'status': status,
      if (grade != null) 'grade': grade,
      if (feedback != null) 'feedback': feedback,
      'submittedAt': submittedAt.toJson(),
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssignmentSubmission',
      if (id != null) 'id': id,
      'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJsonForProtocol(),
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      if (submissionUrl != null) 'submissionUrl': submissionUrl,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'status': status,
      if (grade != null) 'grade': grade,
      if (feedback != null) 'feedback': feedback,
      'submittedAt': submittedAt.toJson(),
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  static AssignmentSubmissionInclude include({
    _i2.AssignmentInclude? assignment,
    _i3.PharmaUserInclude? user,
  }) {
    return AssignmentSubmissionInclude._(
      assignment: assignment,
      user: user,
    );
  }

  static AssignmentSubmissionIncludeList includeList({
    _i1.WhereExpressionBuilder<AssignmentSubmissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssignmentSubmissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssignmentSubmissionTable>? orderByList,
    AssignmentSubmissionInclude? include,
  }) {
    return AssignmentSubmissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssignmentSubmission.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssignmentSubmission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssignmentSubmissionImpl extends AssignmentSubmission {
  _AssignmentSubmissionImpl({
    int? id,
    required int assignmentId,
    _i2.Assignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
    String? status,
    int? grade,
    String? feedback,
    DateTime? submittedAt,
    DateTime? gradedAt,
  }) : super._(
         id: id,
         assignmentId: assignmentId,
         assignment: assignment,
         userId: userId,
         user: user,
         submissionUrl: submissionUrl,
         storageKey: storageKey,
         fileName: fileName,
         status: status,
         grade: grade,
         feedback: feedback,
         submittedAt: submittedAt,
         gradedAt: gradedAt,
       );

  /// Returns a shallow copy of this [AssignmentSubmission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssignmentSubmission copyWith({
    Object? id = _Undefined,
    int? assignmentId,
    Object? assignment = _Undefined,
    Object? userId = _Undefined,
    Object? user = _Undefined,
    Object? submissionUrl = _Undefined,
    Object? storageKey = _Undefined,
    Object? fileName = _Undefined,
    String? status,
    Object? grade = _Undefined,
    Object? feedback = _Undefined,
    DateTime? submittedAt,
    Object? gradedAt = _Undefined,
  }) {
    return AssignmentSubmission(
      id: id is int? ? id : this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      assignment: assignment is _i2.Assignment?
          ? assignment
          : this.assignment?.copyWith(),
      userId: userId is int? ? userId : this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      submissionUrl: submissionUrl is String?
          ? submissionUrl
          : this.submissionUrl,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      fileName: fileName is String? ? fileName : this.fileName,
      status: status ?? this.status,
      grade: grade is int? ? grade : this.grade,
      feedback: feedback is String? ? feedback : this.feedback,
      submittedAt: submittedAt ?? this.submittedAt,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
    );
  }
}

class AssignmentSubmissionUpdateTable
    extends _i1.UpdateTable<AssignmentSubmissionTable> {
  AssignmentSubmissionUpdateTable(super.table);

  _i1.ColumnValue<int, int> assignmentId(int value) => _i1.ColumnValue(
    table.assignmentId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> submissionUrl(String? value) =>
      _i1.ColumnValue(
        table.submissionUrl,
        value,
      );

  _i1.ColumnValue<String, String> storageKey(String? value) => _i1.ColumnValue(
    table.storageKey,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String? value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> grade(int? value) => _i1.ColumnValue(
    table.grade,
    value,
  );

  _i1.ColumnValue<String, String> feedback(String? value) => _i1.ColumnValue(
    table.feedback,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> submittedAt(DateTime value) =>
      _i1.ColumnValue(
        table.submittedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> gradedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.gradedAt,
        value,
      );
}

class AssignmentSubmissionTable extends _i1.Table<int?> {
  AssignmentSubmissionTable({super.tableRelation})
    : super(tableName: 'assignment_submission') {
    updateTable = AssignmentSubmissionUpdateTable(this);
    assignmentId = _i1.ColumnInt(
      'assignmentId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    submissionUrl = _i1.ColumnString(
      'submissionUrl',
      this,
    );
    storageKey = _i1.ColumnString(
      'storageKey',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    grade = _i1.ColumnInt(
      'grade',
      this,
    );
    feedback = _i1.ColumnString(
      'feedback',
      this,
    );
    submittedAt = _i1.ColumnDateTime(
      'submittedAt',
      this,
      hasDefault: true,
    );
    gradedAt = _i1.ColumnDateTime(
      'gradedAt',
      this,
    );
  }

  late final AssignmentSubmissionUpdateTable updateTable;

  late final _i1.ColumnInt assignmentId;

  /// The assignment being submitted to.
  _i2.AssignmentTable? _assignment;

  late final _i1.ColumnInt userId;

  /// The user who submitted.
  _i3.PharmaUserTable? _user;

  /// URL submission.
  late final _i1.ColumnString submissionUrl;

  /// File upload storage key.
  late final _i1.ColumnString storageKey;

  /// Original file name.
  late final _i1.ColumnString fileName;

  /// Status: submitted, graded, returned.
  late final _i1.ColumnString status;

  /// Grade (0-100).
  late final _i1.ColumnInt grade;

  /// Instructor feedback.
  late final _i1.ColumnString feedback;

  /// Submitted timestamp.
  late final _i1.ColumnDateTime submittedAt;

  /// Graded timestamp.
  late final _i1.ColumnDateTime gradedAt;

  _i2.AssignmentTable get assignment {
    if (_assignment != null) return _assignment!;
    _assignment = _i1.createRelationTable(
      relationFieldName: 'assignment',
      field: AssignmentSubmission.t.assignmentId,
      foreignField: _i2.Assignment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AssignmentTable(tableRelation: foreignTableRelation),
    );
    return _assignment!;
  }

  _i3.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AssignmentSubmission.t.userId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    assignmentId,
    userId,
    submissionUrl,
    storageKey,
    fileName,
    status,
    grade,
    feedback,
    submittedAt,
    gradedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'assignment') {
      return assignment;
    }
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class AssignmentSubmissionInclude extends _i1.IncludeObject {
  AssignmentSubmissionInclude._({
    _i2.AssignmentInclude? assignment,
    _i3.PharmaUserInclude? user,
  }) {
    _assignment = assignment;
    _user = user;
  }

  _i2.AssignmentInclude? _assignment;

  _i3.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {
    'assignment': _assignment,
    'user': _user,
  };

  @override
  _i1.Table<int?> get table => AssignmentSubmission.t;
}

class AssignmentSubmissionIncludeList extends _i1.IncludeList {
  AssignmentSubmissionIncludeList._({
    _i1.WhereExpressionBuilder<AssignmentSubmissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssignmentSubmission.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssignmentSubmission.t;
}

class AssignmentSubmissionRepository {
  const AssignmentSubmissionRepository._();

  final attachRow = const AssignmentSubmissionAttachRowRepository._();

  final detachRow = const AssignmentSubmissionDetachRowRepository._();

  /// Returns a list of [AssignmentSubmission]s matching the given query parameters.
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
  Future<List<AssignmentSubmission>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssignmentSubmissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssignmentSubmissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssignmentSubmissionTable>? orderByList,
    _i1.Transaction? transaction,
    AssignmentSubmissionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssignmentSubmission>(
      where: where?.call(AssignmentSubmission.t),
      orderBy: orderBy?.call(AssignmentSubmission.t),
      orderByList: orderByList?.call(AssignmentSubmission.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssignmentSubmission] matching the given query parameters.
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
  Future<AssignmentSubmission?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssignmentSubmissionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssignmentSubmissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssignmentSubmissionTable>? orderByList,
    _i1.Transaction? transaction,
    AssignmentSubmissionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssignmentSubmission>(
      where: where?.call(AssignmentSubmission.t),
      orderBy: orderBy?.call(AssignmentSubmission.t),
      orderByList: orderByList?.call(AssignmentSubmission.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssignmentSubmission] by its [id] or null if no such row exists.
  Future<AssignmentSubmission?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssignmentSubmissionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssignmentSubmission>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssignmentSubmission]s in the list and returns the inserted rows.
  ///
  /// The returned [AssignmentSubmission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssignmentSubmission>> insert(
    _i1.DatabaseSession session,
    List<AssignmentSubmission> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssignmentSubmission>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssignmentSubmission] and returns the inserted row.
  ///
  /// The returned [AssignmentSubmission] will have its `id` field set.
  Future<AssignmentSubmission> insertRow(
    _i1.DatabaseSession session,
    AssignmentSubmission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssignmentSubmission>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssignmentSubmission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssignmentSubmission>> update(
    _i1.DatabaseSession session,
    List<AssignmentSubmission> rows, {
    _i1.ColumnSelections<AssignmentSubmissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssignmentSubmission>(
      rows,
      columns: columns?.call(AssignmentSubmission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssignmentSubmission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssignmentSubmission> updateRow(
    _i1.DatabaseSession session,
    AssignmentSubmission row, {
    _i1.ColumnSelections<AssignmentSubmissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssignmentSubmission>(
      row,
      columns: columns?.call(AssignmentSubmission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssignmentSubmission] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssignmentSubmission?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssignmentSubmissionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssignmentSubmission>(
      id,
      columnValues: columnValues(AssignmentSubmission.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssignmentSubmission]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssignmentSubmission>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssignmentSubmissionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AssignmentSubmissionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssignmentSubmissionTable>? orderBy,
    _i1.OrderByListBuilder<AssignmentSubmissionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssignmentSubmission>(
      columnValues: columnValues(AssignmentSubmission.t.updateTable),
      where: where(AssignmentSubmission.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssignmentSubmission.t),
      orderByList: orderByList?.call(AssignmentSubmission.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssignmentSubmission]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssignmentSubmission>> delete(
    _i1.DatabaseSession session,
    List<AssignmentSubmission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssignmentSubmission>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssignmentSubmission].
  Future<AssignmentSubmission> deleteRow(
    _i1.DatabaseSession session,
    AssignmentSubmission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssignmentSubmission>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssignmentSubmission>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssignmentSubmissionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssignmentSubmission>(
      where: where(AssignmentSubmission.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssignmentSubmissionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssignmentSubmission>(
      where: where?.call(AssignmentSubmission.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssignmentSubmission] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssignmentSubmissionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssignmentSubmission>(
      where: where(AssignmentSubmission.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssignmentSubmissionAttachRowRepository {
  const AssignmentSubmissionAttachRowRepository._();

  /// Creates a relation between the given [AssignmentSubmission] and [Assignment]
  /// by setting the [AssignmentSubmission]'s foreign key `assignmentId` to refer to the [Assignment].
  Future<void> assignment(
    _i1.DatabaseSession session,
    AssignmentSubmission assignmentSubmission,
    _i2.Assignment assignment, {
    _i1.Transaction? transaction,
  }) async {
    if (assignmentSubmission.id == null) {
      throw ArgumentError.notNull('assignmentSubmission.id');
    }
    if (assignment.id == null) {
      throw ArgumentError.notNull('assignment.id');
    }

    var $assignmentSubmission = assignmentSubmission.copyWith(
      assignmentId: assignment.id,
    );
    await session.db.updateRow<AssignmentSubmission>(
      $assignmentSubmission,
      columns: [AssignmentSubmission.t.assignmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AssignmentSubmission] and [PharmaUser]
  /// by setting the [AssignmentSubmission]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    AssignmentSubmission assignmentSubmission,
    _i3.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (assignmentSubmission.id == null) {
      throw ArgumentError.notNull('assignmentSubmission.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $assignmentSubmission = assignmentSubmission.copyWith(userId: user.id);
    await session.db.updateRow<AssignmentSubmission>(
      $assignmentSubmission,
      columns: [AssignmentSubmission.t.userId],
      transaction: transaction,
    );
  }
}

class AssignmentSubmissionDetachRowRepository {
  const AssignmentSubmissionDetachRowRepository._();

  /// Detaches the relation between this [AssignmentSubmission] and the [PharmaUser] set in `user`
  /// by setting the [AssignmentSubmission]'s foreign key `userId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> user(
    _i1.DatabaseSession session,
    AssignmentSubmission assignmentSubmission, {
    _i1.Transaction? transaction,
  }) async {
    if (assignmentSubmission.id == null) {
      throw ArgumentError.notNull('assignmentSubmission.id');
    }

    var $assignmentSubmission = assignmentSubmission.copyWith(userId: null);
    await session.db.updateRow<AssignmentSubmission>(
      $assignmentSubmission,
      columns: [AssignmentSubmission.t.userId],
      transaction: transaction,
    );
  }
}
