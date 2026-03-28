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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// MSL / coaching simulation attempt (behavioral metrics as JSON).
abstract class SimulationAttempt
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SimulationAttempt._({
    this.id,
    required this.userId,
    this.user,
    required this.scenarioTitle,
    this.scorePercent,
    this.metricsJson,
    DateTime? startedAt,
    this.completedAt,
  }) : startedAt = startedAt ?? DateTime.now();

  factory SimulationAttempt({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String scenarioTitle,
    double? scorePercent,
    String? metricsJson,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _SimulationAttemptImpl;

  factory SimulationAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SimulationAttempt(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      scenarioTitle: jsonSerialization['scenarioTitle'] as String,
      scorePercent: (jsonSerialization['scorePercent'] as num?)?.toDouble(),
      metricsJson: jsonSerialization['metricsJson'] as String?,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = SimulationAttemptTable();

  static const db = SimulationAttemptRepository._();

  @override
  int? id;

  int userId;

  _i2.PharmaUser? user;

  String scenarioTitle;

  double? scorePercent;

  String? metricsJson;

  DateTime startedAt;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SimulationAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SimulationAttempt copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? scenarioTitle,
    double? scorePercent,
    String? metricsJson,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SimulationAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'scenarioTitle': scenarioTitle,
      if (scorePercent != null) 'scorePercent': scorePercent,
      if (metricsJson != null) 'metricsJson': metricsJson,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SimulationAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'scenarioTitle': scenarioTitle,
      if (scorePercent != null) 'scorePercent': scorePercent,
      if (metricsJson != null) 'metricsJson': metricsJson,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static SimulationAttemptInclude include({_i2.PharmaUserInclude? user}) {
    return SimulationAttemptInclude._(user: user);
  }

  static SimulationAttemptIncludeList includeList({
    _i1.WhereExpressionBuilder<SimulationAttemptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SimulationAttemptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SimulationAttemptTable>? orderByList,
    SimulationAttemptInclude? include,
  }) {
    return SimulationAttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SimulationAttempt.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SimulationAttempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SimulationAttemptImpl extends SimulationAttempt {
  _SimulationAttemptImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String scenarioTitle,
    double? scorePercent,
    String? metricsJson,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         scenarioTitle: scenarioTitle,
         scorePercent: scorePercent,
         metricsJson: metricsJson,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [SimulationAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SimulationAttempt copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? scenarioTitle,
    Object? scorePercent = _Undefined,
    Object? metricsJson = _Undefined,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
  }) {
    return SimulationAttempt(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      scenarioTitle: scenarioTitle ?? this.scenarioTitle,
      scorePercent: scorePercent is double? ? scorePercent : this.scorePercent,
      metricsJson: metricsJson is String? ? metricsJson : this.metricsJson,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class SimulationAttemptUpdateTable
    extends _i1.UpdateTable<SimulationAttemptTable> {
  SimulationAttemptUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> scenarioTitle(String value) =>
      _i1.ColumnValue(
        table.scenarioTitle,
        value,
      );

  _i1.ColumnValue<double, double> scorePercent(double? value) =>
      _i1.ColumnValue(
        table.scorePercent,
        value,
      );

  _i1.ColumnValue<String, String> metricsJson(String? value) => _i1.ColumnValue(
    table.metricsJson,
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
}

class SimulationAttemptTable extends _i1.Table<int?> {
  SimulationAttemptTable({super.tableRelation})
    : super(tableName: 'simulation_attempt') {
    updateTable = SimulationAttemptUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    scenarioTitle = _i1.ColumnString(
      'scenarioTitle',
      this,
    );
    scorePercent = _i1.ColumnDouble(
      'scorePercent',
      this,
    );
    metricsJson = _i1.ColumnString(
      'metricsJson',
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
  }

  late final SimulationAttemptUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i2.PharmaUserTable? _user;

  late final _i1.ColumnString scenarioTitle;

  late final _i1.ColumnDouble scorePercent;

  late final _i1.ColumnString metricsJson;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: SimulationAttempt.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    scenarioTitle,
    scorePercent,
    metricsJson,
    startedAt,
    completedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class SimulationAttemptInclude extends _i1.IncludeObject {
  SimulationAttemptInclude._({_i2.PharmaUserInclude? user}) {
    _user = user;
  }

  _i2.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => SimulationAttempt.t;
}

class SimulationAttemptIncludeList extends _i1.IncludeList {
  SimulationAttemptIncludeList._({
    _i1.WhereExpressionBuilder<SimulationAttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SimulationAttempt.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SimulationAttempt.t;
}

class SimulationAttemptRepository {
  const SimulationAttemptRepository._();

  final attachRow = const SimulationAttemptAttachRowRepository._();

  /// Returns a list of [SimulationAttempt]s matching the given query parameters.
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
  Future<List<SimulationAttempt>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SimulationAttemptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SimulationAttemptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SimulationAttemptTable>? orderByList,
    _i1.Transaction? transaction,
    SimulationAttemptInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SimulationAttempt>(
      where: where?.call(SimulationAttempt.t),
      orderBy: orderBy?.call(SimulationAttempt.t),
      orderByList: orderByList?.call(SimulationAttempt.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SimulationAttempt] matching the given query parameters.
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
  Future<SimulationAttempt?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SimulationAttemptTable>? where,
    int? offset,
    _i1.OrderByBuilder<SimulationAttemptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SimulationAttemptTable>? orderByList,
    _i1.Transaction? transaction,
    SimulationAttemptInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SimulationAttempt>(
      where: where?.call(SimulationAttempt.t),
      orderBy: orderBy?.call(SimulationAttempt.t),
      orderByList: orderByList?.call(SimulationAttempt.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SimulationAttempt] by its [id] or null if no such row exists.
  Future<SimulationAttempt?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SimulationAttemptInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SimulationAttempt>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SimulationAttempt]s in the list and returns the inserted rows.
  ///
  /// The returned [SimulationAttempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SimulationAttempt>> insert(
    _i1.DatabaseSession session,
    List<SimulationAttempt> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SimulationAttempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SimulationAttempt] and returns the inserted row.
  ///
  /// The returned [SimulationAttempt] will have its `id` field set.
  Future<SimulationAttempt> insertRow(
    _i1.DatabaseSession session,
    SimulationAttempt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SimulationAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SimulationAttempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SimulationAttempt>> update(
    _i1.DatabaseSession session,
    List<SimulationAttempt> rows, {
    _i1.ColumnSelections<SimulationAttemptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SimulationAttempt>(
      rows,
      columns: columns?.call(SimulationAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SimulationAttempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SimulationAttempt> updateRow(
    _i1.DatabaseSession session,
    SimulationAttempt row, {
    _i1.ColumnSelections<SimulationAttemptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SimulationAttempt>(
      row,
      columns: columns?.call(SimulationAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SimulationAttempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SimulationAttempt?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SimulationAttemptUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SimulationAttempt>(
      id,
      columnValues: columnValues(SimulationAttempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SimulationAttempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SimulationAttempt>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SimulationAttemptUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SimulationAttemptTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SimulationAttemptTable>? orderBy,
    _i1.OrderByListBuilder<SimulationAttemptTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SimulationAttempt>(
      columnValues: columnValues(SimulationAttempt.t.updateTable),
      where: where(SimulationAttempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SimulationAttempt.t),
      orderByList: orderByList?.call(SimulationAttempt.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SimulationAttempt]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SimulationAttempt>> delete(
    _i1.DatabaseSession session,
    List<SimulationAttempt> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SimulationAttempt>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SimulationAttempt].
  Future<SimulationAttempt> deleteRow(
    _i1.DatabaseSession session,
    SimulationAttempt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SimulationAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SimulationAttempt>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SimulationAttemptTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SimulationAttempt>(
      where: where(SimulationAttempt.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SimulationAttemptTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SimulationAttempt>(
      where: where?.call(SimulationAttempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SimulationAttempt] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SimulationAttemptTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SimulationAttempt>(
      where: where(SimulationAttempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SimulationAttemptAttachRowRepository {
  const SimulationAttemptAttachRowRepository._();

  /// Creates a relation between the given [SimulationAttempt] and [PharmaUser]
  /// by setting the [SimulationAttempt]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    SimulationAttempt simulationAttempt,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (simulationAttempt.id == null) {
      throw ArgumentError.notNull('simulationAttempt.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $simulationAttempt = simulationAttempt.copyWith(userId: user.id);
    await session.db.updateRow<SimulationAttempt>(
      $simulationAttempt,
      columns: [SimulationAttempt.t.userId],
      transaction: transaction,
    );
  }
}
