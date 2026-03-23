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
import '../infrastructure/scheduled_job_log.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Result of audit trail integrity check (SYS-WF-08).
abstract class AuditIntegrityResult
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AuditIntegrityResult._({
    this.id,
    DateTime? checkedAt,
    required this.recordsChecked,
    required this.hashMismatches,
    required this.sequenceGaps,
    required this.result,
    this.failureDetailsJson,
    this.scheduledJobLogId,
    this.scheduledJobLog,
  }) : checkedAt = checkedAt ?? DateTime.now();

  factory AuditIntegrityResult({
    int? id,
    DateTime? checkedAt,
    required int recordsChecked,
    required int hashMismatches,
    required int sequenceGaps,
    required String result,
    String? failureDetailsJson,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) = _AuditIntegrityResultImpl;

  factory AuditIntegrityResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AuditIntegrityResult(
      id: jsonSerialization['id'] as int?,
      checkedAt: jsonSerialization['checkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkedAt']),
      recordsChecked: jsonSerialization['recordsChecked'] as int,
      hashMismatches: jsonSerialization['hashMismatches'] as int,
      sequenceGaps: jsonSerialization['sequenceGaps'] as int,
      result: jsonSerialization['result'] as String,
      failureDetailsJson: jsonSerialization['failureDetailsJson'] as String?,
      scheduledJobLogId: jsonSerialization['scheduledJobLogId'] as int?,
      scheduledJobLog: jsonSerialization['scheduledJobLog'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.ScheduledJobLog>(
              jsonSerialization['scheduledJobLog'],
            ),
    );
  }

  static final t = AuditIntegrityResultTable();

  static const db = AuditIntegrityResultRepository._();

  @override
  int? id;

  /// When the check was performed.
  DateTime checkedAt;

  /// Number of records checked.
  int recordsChecked;

  /// Number of hash mismatches found.
  int hashMismatches;

  /// Number of sequence gaps found.
  int sequenceGaps;

  /// Overall result: passed, failed.
  String result;

  /// Details of any failures as JSON array.
  String? failureDetailsJson;

  int? scheduledJobLogId;

  /// Job log reference.
  _i2.ScheduledJobLog? scheduledJobLog;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditIntegrityResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditIntegrityResult copyWith({
    int? id,
    DateTime? checkedAt,
    int? recordsChecked,
    int? hashMismatches,
    int? sequenceGaps,
    String? result,
    String? failureDetailsJson,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditIntegrityResult',
      if (id != null) 'id': id,
      'checkedAt': checkedAt.toJson(),
      'recordsChecked': recordsChecked,
      'hashMismatches': hashMismatches,
      'sequenceGaps': sequenceGaps,
      'result': result,
      if (failureDetailsJson != null) 'failureDetailsJson': failureDetailsJson,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null) 'scheduledJobLog': scheduledJobLog?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditIntegrityResult',
      if (id != null) 'id': id,
      'checkedAt': checkedAt.toJson(),
      'recordsChecked': recordsChecked,
      'hashMismatches': hashMismatches,
      'sequenceGaps': sequenceGaps,
      'result': result,
      if (failureDetailsJson != null) 'failureDetailsJson': failureDetailsJson,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null)
        'scheduledJobLog': scheduledJobLog?.toJsonForProtocol(),
    };
  }

  static AuditIntegrityResultInclude include({
    _i2.ScheduledJobLogInclude? scheduledJobLog,
  }) {
    return AuditIntegrityResultInclude._(scheduledJobLog: scheduledJobLog);
  }

  static AuditIntegrityResultIncludeList includeList({
    _i1.WhereExpressionBuilder<AuditIntegrityResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditIntegrityResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditIntegrityResultTable>? orderByList,
    AuditIntegrityResultInclude? include,
  }) {
    return AuditIntegrityResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditIntegrityResult.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AuditIntegrityResult.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditIntegrityResultImpl extends AuditIntegrityResult {
  _AuditIntegrityResultImpl({
    int? id,
    DateTime? checkedAt,
    required int recordsChecked,
    required int hashMismatches,
    required int sequenceGaps,
    required String result,
    String? failureDetailsJson,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) : super._(
         id: id,
         checkedAt: checkedAt,
         recordsChecked: recordsChecked,
         hashMismatches: hashMismatches,
         sequenceGaps: sequenceGaps,
         result: result,
         failureDetailsJson: failureDetailsJson,
         scheduledJobLogId: scheduledJobLogId,
         scheduledJobLog: scheduledJobLog,
       );

  /// Returns a shallow copy of this [AuditIntegrityResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditIntegrityResult copyWith({
    Object? id = _Undefined,
    DateTime? checkedAt,
    int? recordsChecked,
    int? hashMismatches,
    int? sequenceGaps,
    String? result,
    Object? failureDetailsJson = _Undefined,
    Object? scheduledJobLogId = _Undefined,
    Object? scheduledJobLog = _Undefined,
  }) {
    return AuditIntegrityResult(
      id: id is int? ? id : this.id,
      checkedAt: checkedAt ?? this.checkedAt,
      recordsChecked: recordsChecked ?? this.recordsChecked,
      hashMismatches: hashMismatches ?? this.hashMismatches,
      sequenceGaps: sequenceGaps ?? this.sequenceGaps,
      result: result ?? this.result,
      failureDetailsJson: failureDetailsJson is String?
          ? failureDetailsJson
          : this.failureDetailsJson,
      scheduledJobLogId: scheduledJobLogId is int?
          ? scheduledJobLogId
          : this.scheduledJobLogId,
      scheduledJobLog: scheduledJobLog is _i2.ScheduledJobLog?
          ? scheduledJobLog
          : this.scheduledJobLog?.copyWith(),
    );
  }
}

class AuditIntegrityResultUpdateTable
    extends _i1.UpdateTable<AuditIntegrityResultTable> {
  AuditIntegrityResultUpdateTable(super.table);

  _i1.ColumnValue<DateTime, DateTime> checkedAt(DateTime value) =>
      _i1.ColumnValue(
        table.checkedAt,
        value,
      );

  _i1.ColumnValue<int, int> recordsChecked(int value) => _i1.ColumnValue(
    table.recordsChecked,
    value,
  );

  _i1.ColumnValue<int, int> hashMismatches(int value) => _i1.ColumnValue(
    table.hashMismatches,
    value,
  );

  _i1.ColumnValue<int, int> sequenceGaps(int value) => _i1.ColumnValue(
    table.sequenceGaps,
    value,
  );

  _i1.ColumnValue<String, String> result(String value) => _i1.ColumnValue(
    table.result,
    value,
  );

  _i1.ColumnValue<String, String> failureDetailsJson(String? value) =>
      _i1.ColumnValue(
        table.failureDetailsJson,
        value,
      );

  _i1.ColumnValue<int, int> scheduledJobLogId(int? value) => _i1.ColumnValue(
    table.scheduledJobLogId,
    value,
  );
}

class AuditIntegrityResultTable extends _i1.Table<int?> {
  AuditIntegrityResultTable({super.tableRelation})
    : super(tableName: 'audit_integrity_result') {
    updateTable = AuditIntegrityResultUpdateTable(this);
    checkedAt = _i1.ColumnDateTime(
      'checkedAt',
      this,
      hasDefault: true,
    );
    recordsChecked = _i1.ColumnInt(
      'recordsChecked',
      this,
    );
    hashMismatches = _i1.ColumnInt(
      'hashMismatches',
      this,
    );
    sequenceGaps = _i1.ColumnInt(
      'sequenceGaps',
      this,
    );
    result = _i1.ColumnString(
      'result',
      this,
    );
    failureDetailsJson = _i1.ColumnString(
      'failureDetailsJson',
      this,
    );
    scheduledJobLogId = _i1.ColumnInt(
      'scheduledJobLogId',
      this,
    );
  }

  late final AuditIntegrityResultUpdateTable updateTable;

  /// When the check was performed.
  late final _i1.ColumnDateTime checkedAt;

  /// Number of records checked.
  late final _i1.ColumnInt recordsChecked;

  /// Number of hash mismatches found.
  late final _i1.ColumnInt hashMismatches;

  /// Number of sequence gaps found.
  late final _i1.ColumnInt sequenceGaps;

  /// Overall result: passed, failed.
  late final _i1.ColumnString result;

  /// Details of any failures as JSON array.
  late final _i1.ColumnString failureDetailsJson;

  late final _i1.ColumnInt scheduledJobLogId;

  /// Job log reference.
  _i2.ScheduledJobLogTable? _scheduledJobLog;

  _i2.ScheduledJobLogTable get scheduledJobLog {
    if (_scheduledJobLog != null) return _scheduledJobLog!;
    _scheduledJobLog = _i1.createRelationTable(
      relationFieldName: 'scheduledJobLog',
      field: AuditIntegrityResult.t.scheduledJobLogId,
      foreignField: _i2.ScheduledJobLog.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledJobLogTable(tableRelation: foreignTableRelation),
    );
    return _scheduledJobLog!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    checkedAt,
    recordsChecked,
    hashMismatches,
    sequenceGaps,
    result,
    failureDetailsJson,
    scheduledJobLogId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'scheduledJobLog') {
      return scheduledJobLog;
    }
    return null;
  }
}

class AuditIntegrityResultInclude extends _i1.IncludeObject {
  AuditIntegrityResultInclude._({_i2.ScheduledJobLogInclude? scheduledJobLog}) {
    _scheduledJobLog = scheduledJobLog;
  }

  _i2.ScheduledJobLogInclude? _scheduledJobLog;

  @override
  Map<String, _i1.Include?> get includes => {
    'scheduledJobLog': _scheduledJobLog,
  };

  @override
  _i1.Table<int?> get table => AuditIntegrityResult.t;
}

class AuditIntegrityResultIncludeList extends _i1.IncludeList {
  AuditIntegrityResultIncludeList._({
    _i1.WhereExpressionBuilder<AuditIntegrityResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditIntegrityResult.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AuditIntegrityResult.t;
}

class AuditIntegrityResultRepository {
  const AuditIntegrityResultRepository._();

  final attachRow = const AuditIntegrityResultAttachRowRepository._();

  final detachRow = const AuditIntegrityResultDetachRowRepository._();

  /// Returns a list of [AuditIntegrityResult]s matching the given query parameters.
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
  Future<List<AuditIntegrityResult>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditIntegrityResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditIntegrityResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditIntegrityResultTable>? orderByList,
    _i1.Transaction? transaction,
    AuditIntegrityResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditIntegrityResult>(
      where: where?.call(AuditIntegrityResult.t),
      orderBy: orderBy?.call(AuditIntegrityResult.t),
      orderByList: orderByList?.call(AuditIntegrityResult.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditIntegrityResult] matching the given query parameters.
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
  Future<AuditIntegrityResult?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditIntegrityResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<AuditIntegrityResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditIntegrityResultTable>? orderByList,
    _i1.Transaction? transaction,
    AuditIntegrityResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditIntegrityResult>(
      where: where?.call(AuditIntegrityResult.t),
      orderBy: orderBy?.call(AuditIntegrityResult.t),
      orderByList: orderByList?.call(AuditIntegrityResult.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditIntegrityResult] by its [id] or null if no such row exists.
  Future<AuditIntegrityResult?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AuditIntegrityResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditIntegrityResult>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditIntegrityResult]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditIntegrityResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AuditIntegrityResult>> insert(
    _i1.DatabaseSession session,
    List<AuditIntegrityResult> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AuditIntegrityResult>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AuditIntegrityResult] and returns the inserted row.
  ///
  /// The returned [AuditIntegrityResult] will have its `id` field set.
  Future<AuditIntegrityResult> insertRow(
    _i1.DatabaseSession session,
    AuditIntegrityResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditIntegrityResult>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AuditIntegrityResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AuditIntegrityResult>> update(
    _i1.DatabaseSession session,
    List<AuditIntegrityResult> rows, {
    _i1.ColumnSelections<AuditIntegrityResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AuditIntegrityResult>(
      rows,
      columns: columns?.call(AuditIntegrityResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditIntegrityResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditIntegrityResult> updateRow(
    _i1.DatabaseSession session,
    AuditIntegrityResult row, {
    _i1.ColumnSelections<AuditIntegrityResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditIntegrityResult>(
      row,
      columns: columns?.call(AuditIntegrityResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditIntegrityResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditIntegrityResult?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AuditIntegrityResultUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditIntegrityResult>(
      id,
      columnValues: columnValues(AuditIntegrityResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditIntegrityResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AuditIntegrityResult>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AuditIntegrityResultUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AuditIntegrityResultTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditIntegrityResultTable>? orderBy,
    _i1.OrderByListBuilder<AuditIntegrityResultTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AuditIntegrityResult>(
      columnValues: columnValues(AuditIntegrityResult.t.updateTable),
      where: where(AuditIntegrityResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditIntegrityResult.t),
      orderByList: orderByList?.call(AuditIntegrityResult.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AuditIntegrityResult]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AuditIntegrityResult>> delete(
    _i1.DatabaseSession session,
    List<AuditIntegrityResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AuditIntegrityResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AuditIntegrityResult].
  Future<AuditIntegrityResult> deleteRow(
    _i1.DatabaseSession session,
    AuditIntegrityResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditIntegrityResult>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AuditIntegrityResult>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditIntegrityResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AuditIntegrityResult>(
      where: where(AuditIntegrityResult.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditIntegrityResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AuditIntegrityResult>(
      where: where?.call(AuditIntegrityResult.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditIntegrityResult] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditIntegrityResultTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditIntegrityResult>(
      where: where(AuditIntegrityResult.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AuditIntegrityResultAttachRowRepository {
  const AuditIntegrityResultAttachRowRepository._();

  /// Creates a relation between the given [AuditIntegrityResult] and [ScheduledJobLog]
  /// by setting the [AuditIntegrityResult]'s foreign key `scheduledJobLogId` to refer to the [ScheduledJobLog].
  Future<void> scheduledJobLog(
    _i1.DatabaseSession session,
    AuditIntegrityResult auditIntegrityResult,
    _i2.ScheduledJobLog scheduledJobLog, {
    _i1.Transaction? transaction,
  }) async {
    if (auditIntegrityResult.id == null) {
      throw ArgumentError.notNull('auditIntegrityResult.id');
    }
    if (scheduledJobLog.id == null) {
      throw ArgumentError.notNull('scheduledJobLog.id');
    }

    var $auditIntegrityResult = auditIntegrityResult.copyWith(
      scheduledJobLogId: scheduledJobLog.id,
    );
    await session.db.updateRow<AuditIntegrityResult>(
      $auditIntegrityResult,
      columns: [AuditIntegrityResult.t.scheduledJobLogId],
      transaction: transaction,
    );
  }
}

class AuditIntegrityResultDetachRowRepository {
  const AuditIntegrityResultDetachRowRepository._();

  /// Detaches the relation between this [AuditIntegrityResult] and the [ScheduledJobLog] set in `scheduledJobLog`
  /// by setting the [AuditIntegrityResult]'s foreign key `scheduledJobLogId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledJobLog(
    _i1.DatabaseSession session,
    AuditIntegrityResult auditIntegrityResult, {
    _i1.Transaction? transaction,
  }) async {
    if (auditIntegrityResult.id == null) {
      throw ArgumentError.notNull('auditIntegrityResult.id');
    }

    var $auditIntegrityResult = auditIntegrityResult.copyWith(
      scheduledJobLogId: null,
    );
    await session.db.updateRow<AuditIntegrityResult>(
      $auditIntegrityResult,
      columns: [AuditIntegrityResult.t.scheduledJobLogId],
      transaction: transaction,
    );
  }
}
