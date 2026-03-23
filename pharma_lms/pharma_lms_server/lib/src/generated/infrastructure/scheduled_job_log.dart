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
import 'package:serverpod/serverpod.dart' as _i1;

/// Scheduled job execution log. GMP.
abstract class ScheduledJobLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScheduledJobLog._({
    this.id,
    required this.jobName,
    DateTime? startedAt,
    this.completedAt,
    String? status,
    this.recordsProcessed,
    this.recordsAffected,
    this.errorDetails,
  }) : startedAt = startedAt ?? DateTime.now(),
       status = status ?? 'running';

  factory ScheduledJobLog({
    int? id,
    required String jobName,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
    int? recordsProcessed,
    int? recordsAffected,
    String? errorDetails,
  }) = _ScheduledJobLogImpl;

  factory ScheduledJobLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduledJobLog(
      id: jsonSerialization['id'] as int?,
      jobName: jsonSerialization['jobName'] as String,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      status: jsonSerialization['status'] as String?,
      recordsProcessed: jsonSerialization['recordsProcessed'] as int?,
      recordsAffected: jsonSerialization['recordsAffected'] as int?,
      errorDetails: jsonSerialization['errorDetails'] as String?,
    );
  }

  static final t = ScheduledJobLogTable();

  static const db = ScheduledJobLogRepository._();

  @override
  int? id;

  /// Job name: CertExpiryCheck, ComplianceCalc, NotificationWorker, CapaEffectivenessCheck.
  String jobName;

  /// When started.
  DateTime startedAt;

  /// When completed.
  DateTime? completedAt;

  /// Status: running, completed, failed.
  String status;

  /// Records processed.
  int? recordsProcessed;

  /// Records affected.
  int? recordsAffected;

  /// Error details if failed.
  String? errorDetails;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScheduledJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledJobLog copyWith({
    int? id,
    String? jobName,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
    int? recordsProcessed,
    int? recordsAffected,
    String? errorDetails,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduledJobLog',
      if (id != null) 'id': id,
      'jobName': jobName,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'status': status,
      if (recordsProcessed != null) 'recordsProcessed': recordsProcessed,
      if (recordsAffected != null) 'recordsAffected': recordsAffected,
      if (errorDetails != null) 'errorDetails': errorDetails,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScheduledJobLog',
      if (id != null) 'id': id,
      'jobName': jobName,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'status': status,
      if (recordsProcessed != null) 'recordsProcessed': recordsProcessed,
      if (recordsAffected != null) 'recordsAffected': recordsAffected,
      if (errorDetails != null) 'errorDetails': errorDetails,
    };
  }

  static ScheduledJobLogInclude include() {
    return ScheduledJobLogInclude._();
  }

  static ScheduledJobLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduledJobLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledJobLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledJobLogTable>? orderByList,
    ScheduledJobLogInclude? include,
  }) {
    return ScheduledJobLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledJobLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduledJobLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledJobLogImpl extends ScheduledJobLog {
  _ScheduledJobLogImpl({
    int? id,
    required String jobName,
    DateTime? startedAt,
    DateTime? completedAt,
    String? status,
    int? recordsProcessed,
    int? recordsAffected,
    String? errorDetails,
  }) : super._(
         id: id,
         jobName: jobName,
         startedAt: startedAt,
         completedAt: completedAt,
         status: status,
         recordsProcessed: recordsProcessed,
         recordsAffected: recordsAffected,
         errorDetails: errorDetails,
       );

  /// Returns a shallow copy of this [ScheduledJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledJobLog copyWith({
    Object? id = _Undefined,
    String? jobName,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
    String? status,
    Object? recordsProcessed = _Undefined,
    Object? recordsAffected = _Undefined,
    Object? errorDetails = _Undefined,
  }) {
    return ScheduledJobLog(
      id: id is int? ? id : this.id,
      jobName: jobName ?? this.jobName,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      status: status ?? this.status,
      recordsProcessed: recordsProcessed is int?
          ? recordsProcessed
          : this.recordsProcessed,
      recordsAffected: recordsAffected is int?
          ? recordsAffected
          : this.recordsAffected,
      errorDetails: errorDetails is String? ? errorDetails : this.errorDetails,
    );
  }
}

class ScheduledJobLogUpdateTable extends _i1.UpdateTable<ScheduledJobLogTable> {
  ScheduledJobLogUpdateTable(super.table);

  _i1.ColumnValue<String, String> jobName(String value) => _i1.ColumnValue(
    table.jobName,
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

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> recordsProcessed(int? value) => _i1.ColumnValue(
    table.recordsProcessed,
    value,
  );

  _i1.ColumnValue<int, int> recordsAffected(int? value) => _i1.ColumnValue(
    table.recordsAffected,
    value,
  );

  _i1.ColumnValue<String, String> errorDetails(String? value) =>
      _i1.ColumnValue(
        table.errorDetails,
        value,
      );
}

class ScheduledJobLogTable extends _i1.Table<int?> {
  ScheduledJobLogTable({super.tableRelation})
    : super(tableName: 'scheduled_job_log') {
    updateTable = ScheduledJobLogUpdateTable(this);
    jobName = _i1.ColumnString(
      'jobName',
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
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    recordsProcessed = _i1.ColumnInt(
      'recordsProcessed',
      this,
    );
    recordsAffected = _i1.ColumnInt(
      'recordsAffected',
      this,
    );
    errorDetails = _i1.ColumnString(
      'errorDetails',
      this,
    );
  }

  late final ScheduledJobLogUpdateTable updateTable;

  /// Job name: CertExpiryCheck, ComplianceCalc, NotificationWorker, CapaEffectivenessCheck.
  late final _i1.ColumnString jobName;

  /// When started.
  late final _i1.ColumnDateTime startedAt;

  /// When completed.
  late final _i1.ColumnDateTime completedAt;

  /// Status: running, completed, failed.
  late final _i1.ColumnString status;

  /// Records processed.
  late final _i1.ColumnInt recordsProcessed;

  /// Records affected.
  late final _i1.ColumnInt recordsAffected;

  /// Error details if failed.
  late final _i1.ColumnString errorDetails;

  @override
  List<_i1.Column> get columns => [
    id,
    jobName,
    startedAt,
    completedAt,
    status,
    recordsProcessed,
    recordsAffected,
    errorDetails,
  ];
}

class ScheduledJobLogInclude extends _i1.IncludeObject {
  ScheduledJobLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ScheduledJobLog.t;
}

class ScheduledJobLogIncludeList extends _i1.IncludeList {
  ScheduledJobLogIncludeList._({
    _i1.WhereExpressionBuilder<ScheduledJobLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduledJobLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScheduledJobLog.t;
}

class ScheduledJobLogRepository {
  const ScheduledJobLogRepository._();

  /// Returns a list of [ScheduledJobLog]s matching the given query parameters.
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
  Future<List<ScheduledJobLog>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledJobLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledJobLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledJobLogTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScheduledJobLog>(
      where: where?.call(ScheduledJobLog.t),
      orderBy: orderBy?.call(ScheduledJobLog.t),
      orderByList: orderByList?.call(ScheduledJobLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScheduledJobLog] matching the given query parameters.
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
  Future<ScheduledJobLog?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledJobLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduledJobLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledJobLogTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScheduledJobLog>(
      where: where?.call(ScheduledJobLog.t),
      orderBy: orderBy?.call(ScheduledJobLog.t),
      orderByList: orderByList?.call(ScheduledJobLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScheduledJobLog] by its [id] or null if no such row exists.
  Future<ScheduledJobLog?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScheduledJobLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScheduledJobLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduledJobLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ScheduledJobLog>> insert(
    _i1.DatabaseSession session,
    List<ScheduledJobLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ScheduledJobLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ScheduledJobLog] and returns the inserted row.
  ///
  /// The returned [ScheduledJobLog] will have its `id` field set.
  Future<ScheduledJobLog> insertRow(
    _i1.DatabaseSession session,
    ScheduledJobLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduledJobLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledJobLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduledJobLog>> update(
    _i1.DatabaseSession session,
    List<ScheduledJobLog> rows, {
    _i1.ColumnSelections<ScheduledJobLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduledJobLog>(
      rows,
      columns: columns?.call(ScheduledJobLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledJobLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduledJobLog> updateRow(
    _i1.DatabaseSession session,
    ScheduledJobLog row, {
    _i1.ColumnSelections<ScheduledJobLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduledJobLog>(
      row,
      columns: columns?.call(ScheduledJobLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledJobLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScheduledJobLog?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ScheduledJobLogUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScheduledJobLog>(
      id,
      columnValues: columnValues(ScheduledJobLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledJobLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScheduledJobLog>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ScheduledJobLogUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ScheduledJobLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledJobLogTable>? orderBy,
    _i1.OrderByListBuilder<ScheduledJobLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScheduledJobLog>(
      columnValues: columnValues(ScheduledJobLog.t.updateTable),
      where: where(ScheduledJobLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledJobLog.t),
      orderByList: orderByList?.call(ScheduledJobLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduledJobLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduledJobLog>> delete(
    _i1.DatabaseSession session,
    List<ScheduledJobLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduledJobLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduledJobLog].
  Future<ScheduledJobLog> deleteRow(
    _i1.DatabaseSession session,
    ScheduledJobLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduledJobLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduledJobLog>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScheduledJobLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduledJobLog>(
      where: where(ScheduledJobLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledJobLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduledJobLog>(
      where: where?.call(ScheduledJobLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScheduledJobLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScheduledJobLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScheduledJobLog>(
      where: where(ScheduledJobLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
