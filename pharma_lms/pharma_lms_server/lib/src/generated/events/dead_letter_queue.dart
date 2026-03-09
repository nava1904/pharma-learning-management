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

/// Dead letter queue for failed event publishing. Enterprise.
abstract class DeadLetterQueue
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeadLetterQueue._({
    this.id,
    this.outboxMessageId,
    DateTime? failedAt,
    this.failureReason,
    int? retryCount,
    bool? manuallyResolved,
    this.resolvedById,
    this.resolvedAt,
    this.resolutionNotes,
  }) : failedAt = failedAt ?? DateTime.now(),
       retryCount = retryCount ?? 0,
       manuallyResolved = manuallyResolved ?? false;

  factory DeadLetterQueue({
    int? id,
    int? outboxMessageId,
    DateTime? failedAt,
    String? failureReason,
    int? retryCount,
    bool? manuallyResolved,
    int? resolvedById,
    DateTime? resolvedAt,
    String? resolutionNotes,
  }) = _DeadLetterQueueImpl;

  factory DeadLetterQueue.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeadLetterQueue(
      id: jsonSerialization['id'] as int?,
      outboxMessageId: jsonSerialization['outboxMessageId'] as int?,
      failedAt: jsonSerialization['failedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['failedAt']),
      failureReason: jsonSerialization['failureReason'] as String?,
      retryCount: jsonSerialization['retryCount'] as int?,
      manuallyResolved: jsonSerialization['manuallyResolved'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['manuallyResolved'],
            ),
      resolvedById: jsonSerialization['resolvedById'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      resolutionNotes: jsonSerialization['resolutionNotes'] as String?,
    );
  }

  static final t = DeadLetterQueueTable();

  static const db = DeadLetterQueueRepository._();

  @override
  int? id;

  /// The outbox message that failed.
  int? outboxMessageId;

  /// When it failed.
  DateTime failedAt;

  /// Failure reason.
  String? failureReason;

  /// Retry count before moving to DLQ.
  int retryCount;

  /// Whether manually resolved.
  bool manuallyResolved;

  /// Who resolved (if manual).
  int? resolvedById;

  /// When resolved.
  DateTime? resolvedAt;

  /// Resolution notes.
  String? resolutionNotes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeadLetterQueue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeadLetterQueue copyWith({
    int? id,
    int? outboxMessageId,
    DateTime? failedAt,
    String? failureReason,
    int? retryCount,
    bool? manuallyResolved,
    int? resolvedById,
    DateTime? resolvedAt,
    String? resolutionNotes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeadLetterQueue',
      if (id != null) 'id': id,
      if (outboxMessageId != null) 'outboxMessageId': outboxMessageId,
      'failedAt': failedAt.toJson(),
      if (failureReason != null) 'failureReason': failureReason,
      'retryCount': retryCount,
      'manuallyResolved': manuallyResolved,
      if (resolvedById != null) 'resolvedById': resolvedById,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolutionNotes != null) 'resolutionNotes': resolutionNotes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeadLetterQueue',
      if (id != null) 'id': id,
      if (outboxMessageId != null) 'outboxMessageId': outboxMessageId,
      'failedAt': failedAt.toJson(),
      if (failureReason != null) 'failureReason': failureReason,
      'retryCount': retryCount,
      'manuallyResolved': manuallyResolved,
      if (resolvedById != null) 'resolvedById': resolvedById,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolutionNotes != null) 'resolutionNotes': resolutionNotes,
    };
  }

  static DeadLetterQueueInclude include() {
    return DeadLetterQueueInclude._();
  }

  static DeadLetterQueueIncludeList includeList({
    _i1.WhereExpressionBuilder<DeadLetterQueueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeadLetterQueueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeadLetterQueueTable>? orderByList,
    DeadLetterQueueInclude? include,
  }) {
    return DeadLetterQueueIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeadLetterQueue.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeadLetterQueue.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeadLetterQueueImpl extends DeadLetterQueue {
  _DeadLetterQueueImpl({
    int? id,
    int? outboxMessageId,
    DateTime? failedAt,
    String? failureReason,
    int? retryCount,
    bool? manuallyResolved,
    int? resolvedById,
    DateTime? resolvedAt,
    String? resolutionNotes,
  }) : super._(
         id: id,
         outboxMessageId: outboxMessageId,
         failedAt: failedAt,
         failureReason: failureReason,
         retryCount: retryCount,
         manuallyResolved: manuallyResolved,
         resolvedById: resolvedById,
         resolvedAt: resolvedAt,
         resolutionNotes: resolutionNotes,
       );

  /// Returns a shallow copy of this [DeadLetterQueue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeadLetterQueue copyWith({
    Object? id = _Undefined,
    Object? outboxMessageId = _Undefined,
    DateTime? failedAt,
    Object? failureReason = _Undefined,
    int? retryCount,
    bool? manuallyResolved,
    Object? resolvedById = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? resolutionNotes = _Undefined,
  }) {
    return DeadLetterQueue(
      id: id is int? ? id : this.id,
      outboxMessageId: outboxMessageId is int?
          ? outboxMessageId
          : this.outboxMessageId,
      failedAt: failedAt ?? this.failedAt,
      failureReason: failureReason is String?
          ? failureReason
          : this.failureReason,
      retryCount: retryCount ?? this.retryCount,
      manuallyResolved: manuallyResolved ?? this.manuallyResolved,
      resolvedById: resolvedById is int? ? resolvedById : this.resolvedById,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      resolutionNotes: resolutionNotes is String?
          ? resolutionNotes
          : this.resolutionNotes,
    );
  }
}

class DeadLetterQueueUpdateTable extends _i1.UpdateTable<DeadLetterQueueTable> {
  DeadLetterQueueUpdateTable(super.table);

  _i1.ColumnValue<int, int> outboxMessageId(int? value) => _i1.ColumnValue(
    table.outboxMessageId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> failedAt(DateTime value) =>
      _i1.ColumnValue(
        table.failedAt,
        value,
      );

  _i1.ColumnValue<String, String> failureReason(String? value) =>
      _i1.ColumnValue(
        table.failureReason,
        value,
      );

  _i1.ColumnValue<int, int> retryCount(int value) => _i1.ColumnValue(
    table.retryCount,
    value,
  );

  _i1.ColumnValue<bool, bool> manuallyResolved(bool value) => _i1.ColumnValue(
    table.manuallyResolved,
    value,
  );

  _i1.ColumnValue<int, int> resolvedById(int? value) => _i1.ColumnValue(
    table.resolvedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );

  _i1.ColumnValue<String, String> resolutionNotes(String? value) =>
      _i1.ColumnValue(
        table.resolutionNotes,
        value,
      );
}

class DeadLetterQueueTable extends _i1.Table<int?> {
  DeadLetterQueueTable({super.tableRelation})
    : super(tableName: 'dead_letter_queue') {
    updateTable = DeadLetterQueueUpdateTable(this);
    outboxMessageId = _i1.ColumnInt(
      'outboxMessageId',
      this,
    );
    failedAt = _i1.ColumnDateTime(
      'failedAt',
      this,
      hasDefault: true,
    );
    failureReason = _i1.ColumnString(
      'failureReason',
      this,
    );
    retryCount = _i1.ColumnInt(
      'retryCount',
      this,
      hasDefault: true,
    );
    manuallyResolved = _i1.ColumnBool(
      'manuallyResolved',
      this,
      hasDefault: true,
    );
    resolvedById = _i1.ColumnInt(
      'resolvedById',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
    resolutionNotes = _i1.ColumnString(
      'resolutionNotes',
      this,
    );
  }

  late final DeadLetterQueueUpdateTable updateTable;

  /// The outbox message that failed.
  late final _i1.ColumnInt outboxMessageId;

  /// When it failed.
  late final _i1.ColumnDateTime failedAt;

  /// Failure reason.
  late final _i1.ColumnString failureReason;

  /// Retry count before moving to DLQ.
  late final _i1.ColumnInt retryCount;

  /// Whether manually resolved.
  late final _i1.ColumnBool manuallyResolved;

  /// Who resolved (if manual).
  late final _i1.ColumnInt resolvedById;

  /// When resolved.
  late final _i1.ColumnDateTime resolvedAt;

  /// Resolution notes.
  late final _i1.ColumnString resolutionNotes;

  @override
  List<_i1.Column> get columns => [
    id,
    outboxMessageId,
    failedAt,
    failureReason,
    retryCount,
    manuallyResolved,
    resolvedById,
    resolvedAt,
    resolutionNotes,
  ];
}

class DeadLetterQueueInclude extends _i1.IncludeObject {
  DeadLetterQueueInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeadLetterQueue.t;
}

class DeadLetterQueueIncludeList extends _i1.IncludeList {
  DeadLetterQueueIncludeList._({
    _i1.WhereExpressionBuilder<DeadLetterQueueTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeadLetterQueue.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeadLetterQueue.t;
}

class DeadLetterQueueRepository {
  const DeadLetterQueueRepository._();

  /// Returns a list of [DeadLetterQueue]s matching the given query parameters.
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
  Future<List<DeadLetterQueue>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeadLetterQueueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeadLetterQueueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeadLetterQueueTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeadLetterQueue>(
      where: where?.call(DeadLetterQueue.t),
      orderBy: orderBy?.call(DeadLetterQueue.t),
      orderByList: orderByList?.call(DeadLetterQueue.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeadLetterQueue] matching the given query parameters.
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
  Future<DeadLetterQueue?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeadLetterQueueTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeadLetterQueueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeadLetterQueueTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeadLetterQueue>(
      where: where?.call(DeadLetterQueue.t),
      orderBy: orderBy?.call(DeadLetterQueue.t),
      orderByList: orderByList?.call(DeadLetterQueue.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeadLetterQueue] by its [id] or null if no such row exists.
  Future<DeadLetterQueue?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeadLetterQueue>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeadLetterQueue]s in the list and returns the inserted rows.
  ///
  /// The returned [DeadLetterQueue]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeadLetterQueue>> insert(
    _i1.Session session,
    List<DeadLetterQueue> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeadLetterQueue>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeadLetterQueue] and returns the inserted row.
  ///
  /// The returned [DeadLetterQueue] will have its `id` field set.
  Future<DeadLetterQueue> insertRow(
    _i1.Session session,
    DeadLetterQueue row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeadLetterQueue>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeadLetterQueue]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeadLetterQueue>> update(
    _i1.Session session,
    List<DeadLetterQueue> rows, {
    _i1.ColumnSelections<DeadLetterQueueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeadLetterQueue>(
      rows,
      columns: columns?.call(DeadLetterQueue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeadLetterQueue]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeadLetterQueue> updateRow(
    _i1.Session session,
    DeadLetterQueue row, {
    _i1.ColumnSelections<DeadLetterQueueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeadLetterQueue>(
      row,
      columns: columns?.call(DeadLetterQueue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeadLetterQueue] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeadLetterQueue?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DeadLetterQueueUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeadLetterQueue>(
      id,
      columnValues: columnValues(DeadLetterQueue.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeadLetterQueue]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeadLetterQueue>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DeadLetterQueueUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DeadLetterQueueTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeadLetterQueueTable>? orderBy,
    _i1.OrderByListBuilder<DeadLetterQueueTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeadLetterQueue>(
      columnValues: columnValues(DeadLetterQueue.t.updateTable),
      where: where(DeadLetterQueue.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeadLetterQueue.t),
      orderByList: orderByList?.call(DeadLetterQueue.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeadLetterQueue]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeadLetterQueue>> delete(
    _i1.Session session,
    List<DeadLetterQueue> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeadLetterQueue>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeadLetterQueue].
  Future<DeadLetterQueue> deleteRow(
    _i1.Session session,
    DeadLetterQueue row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeadLetterQueue>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeadLetterQueue>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DeadLetterQueueTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeadLetterQueue>(
      where: where(DeadLetterQueue.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeadLetterQueueTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeadLetterQueue>(
      where: where?.call(DeadLetterQueue.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeadLetterQueue] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DeadLetterQueueTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeadLetterQueue>(
      where: where(DeadLetterQueue.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
