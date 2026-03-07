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

/// Error log for system failures and exceptions.
abstract class ErrorLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ErrorLog._({
    this.id,
    required this.message,
    this.stackTrace,
    this.contextJson,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ErrorLog({
    int? id,
    required String message,
    String? stackTrace,
    String? contextJson,
    DateTime? timestamp,
  }) = _ErrorLogImpl;

  factory ErrorLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ErrorLog(
      id: jsonSerialization['id'] as int?,
      message: jsonSerialization['message'] as String,
      stackTrace: jsonSerialization['stackTrace'] as String?,
      contextJson: jsonSerialization['contextJson'] as String?,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  static final t = ErrorLogTable();

  static const db = ErrorLogRepository._();

  @override
  int? id;

  /// Error message.
  String message;

  /// Stack trace.
  String? stackTrace;

  /// Additional context as JSON.
  String? contextJson;

  /// Timestamp.
  DateTime timestamp;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ErrorLog copyWith({
    int? id,
    String? message,
    String? stackTrace,
    String? contextJson,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ErrorLog',
      if (id != null) 'id': id,
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (contextJson != null) 'contextJson': contextJson,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ErrorLog',
      if (id != null) 'id': id,
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (contextJson != null) 'contextJson': contextJson,
      'timestamp': timestamp.toJson(),
    };
  }

  static ErrorLogInclude include() {
    return ErrorLogInclude._();
  }

  static ErrorLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ErrorLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ErrorLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ErrorLogTable>? orderByList,
    ErrorLogInclude? include,
  }) {
    return ErrorLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ErrorLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ErrorLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ErrorLogImpl extends ErrorLog {
  _ErrorLogImpl({
    int? id,
    required String message,
    String? stackTrace,
    String? contextJson,
    DateTime? timestamp,
  }) : super._(
         id: id,
         message: message,
         stackTrace: stackTrace,
         contextJson: contextJson,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [ErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ErrorLog copyWith({
    Object? id = _Undefined,
    String? message,
    Object? stackTrace = _Undefined,
    Object? contextJson = _Undefined,
    DateTime? timestamp,
  }) {
    return ErrorLog(
      id: id is int? ? id : this.id,
      message: message ?? this.message,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
      contextJson: contextJson is String? ? contextJson : this.contextJson,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class ErrorLogUpdateTable extends _i1.UpdateTable<ErrorLogTable> {
  ErrorLogUpdateTable(super.table);

  _i1.ColumnValue<String, String> message(String value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<String, String> stackTrace(String? value) => _i1.ColumnValue(
    table.stackTrace,
    value,
  );

  _i1.ColumnValue<String, String> contextJson(String? value) => _i1.ColumnValue(
    table.contextJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );
}

class ErrorLogTable extends _i1.Table<int?> {
  ErrorLogTable({super.tableRelation}) : super(tableName: 'error_log') {
    updateTable = ErrorLogUpdateTable(this);
    message = _i1.ColumnString(
      'message',
      this,
    );
    stackTrace = _i1.ColumnString(
      'stackTrace',
      this,
    );
    contextJson = _i1.ColumnString(
      'contextJson',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
  }

  late final ErrorLogUpdateTable updateTable;

  /// Error message.
  late final _i1.ColumnString message;

  /// Stack trace.
  late final _i1.ColumnString stackTrace;

  /// Additional context as JSON.
  late final _i1.ColumnString contextJson;

  /// Timestamp.
  late final _i1.ColumnDateTime timestamp;

  @override
  List<_i1.Column> get columns => [
    id,
    message,
    stackTrace,
    contextJson,
    timestamp,
  ];
}

class ErrorLogInclude extends _i1.IncludeObject {
  ErrorLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ErrorLog.t;
}

class ErrorLogIncludeList extends _i1.IncludeList {
  ErrorLogIncludeList._({
    _i1.WhereExpressionBuilder<ErrorLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ErrorLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ErrorLog.t;
}

class ErrorLogRepository {
  const ErrorLogRepository._();

  /// Returns a list of [ErrorLog]s matching the given query parameters.
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
  Future<List<ErrorLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ErrorLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ErrorLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ErrorLogTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ErrorLog>(
      where: where?.call(ErrorLog.t),
      orderBy: orderBy?.call(ErrorLog.t),
      orderByList: orderByList?.call(ErrorLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ErrorLog] matching the given query parameters.
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
  Future<ErrorLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ErrorLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ErrorLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ErrorLogTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ErrorLog>(
      where: where?.call(ErrorLog.t),
      orderBy: orderBy?.call(ErrorLog.t),
      orderByList: orderByList?.call(ErrorLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ErrorLog] by its [id] or null if no such row exists.
  Future<ErrorLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ErrorLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ErrorLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ErrorLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ErrorLog>> insert(
    _i1.Session session,
    List<ErrorLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ErrorLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ErrorLog] and returns the inserted row.
  ///
  /// The returned [ErrorLog] will have its `id` field set.
  Future<ErrorLog> insertRow(
    _i1.Session session,
    ErrorLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ErrorLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ErrorLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ErrorLog>> update(
    _i1.Session session,
    List<ErrorLog> rows, {
    _i1.ColumnSelections<ErrorLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ErrorLog>(
      rows,
      columns: columns?.call(ErrorLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ErrorLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ErrorLog> updateRow(
    _i1.Session session,
    ErrorLog row, {
    _i1.ColumnSelections<ErrorLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ErrorLog>(
      row,
      columns: columns?.call(ErrorLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ErrorLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ErrorLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ErrorLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ErrorLog>(
      id,
      columnValues: columnValues(ErrorLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ErrorLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ErrorLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ErrorLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ErrorLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ErrorLogTable>? orderBy,
    _i1.OrderByListBuilder<ErrorLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ErrorLog>(
      columnValues: columnValues(ErrorLog.t.updateTable),
      where: where(ErrorLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ErrorLog.t),
      orderByList: orderByList?.call(ErrorLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ErrorLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ErrorLog>> delete(
    _i1.Session session,
    List<ErrorLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ErrorLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ErrorLog].
  Future<ErrorLog> deleteRow(
    _i1.Session session,
    ErrorLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ErrorLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ErrorLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ErrorLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ErrorLog>(
      where: where(ErrorLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ErrorLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ErrorLog>(
      where: where?.call(ErrorLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ErrorLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ErrorLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ErrorLog>(
      where: where(ErrorLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
