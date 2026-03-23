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

/// Access Review Window (quarterly/periodic review instance)
abstract class AccessReviewWindow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AccessReviewWindow._({
    this.id,
    required this.windowId,
    required this.openDate,
    required this.closeDate,
    required this.totalRecords,
    this.jobId,
    String? status,
    DateTime? createdAt,
    this.migrationMarker,
  }) : status = status ?? 'ACTIVE',
       createdAt = createdAt ?? DateTime.now();

  factory AccessReviewWindow({
    int? id,
    required int windowId,
    required DateTime openDate,
    required DateTime closeDate,
    required int totalRecords,
    String? jobId,
    String? status,
    DateTime? createdAt,
    String? migrationMarker,
  }) = _AccessReviewWindowImpl;

  factory AccessReviewWindow.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessReviewWindow(
      id: jsonSerialization['id'] as int?,
      windowId: jsonSerialization['windowId'] as int,
      openDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['openDate'],
      ),
      closeDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['closeDate'],
      ),
      totalRecords: jsonSerialization['totalRecords'] as int,
      jobId: jsonSerialization['jobId'] as String?,
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      migrationMarker: jsonSerialization['migrationMarker'] as String?,
    );
  }

  static final t = AccessReviewWindowTable();

  static const db = AccessReviewWindowRepository._();

  @override
  int? id;

  /// Unique window ID
  int windowId;

  /// Open date
  DateTime openDate;

  /// Close date
  DateTime closeDate;

  /// Total records in this window
  int totalRecords;

  /// Triggering job ID
  String? jobId;

  /// Status (ACTIVE, CLOSED)
  String status;

  /// Created at
  DateTime createdAt;

  /// Temporary migration marker - remove after migration applied
  String? migrationMarker;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccessReviewWindow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessReviewWindow copyWith({
    int? id,
    int? windowId,
    DateTime? openDate,
    DateTime? closeDate,
    int? totalRecords,
    String? jobId,
    String? status,
    DateTime? createdAt,
    String? migrationMarker,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessReviewWindow',
      if (id != null) 'id': id,
      'windowId': windowId,
      'openDate': openDate.toJson(),
      'closeDate': closeDate.toJson(),
      'totalRecords': totalRecords,
      if (jobId != null) 'jobId': jobId,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccessReviewWindow',
      if (id != null) 'id': id,
      'windowId': windowId,
      'openDate': openDate.toJson(),
      'closeDate': closeDate.toJson(),
      'totalRecords': totalRecords,
      if (jobId != null) 'jobId': jobId,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  static AccessReviewWindowInclude include() {
    return AccessReviewWindowInclude._();
  }

  static AccessReviewWindowIncludeList includeList({
    _i1.WhereExpressionBuilder<AccessReviewWindowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessReviewWindowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessReviewWindowTable>? orderByList,
    AccessReviewWindowInclude? include,
  }) {
    return AccessReviewWindowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessReviewWindow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AccessReviewWindow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessReviewWindowImpl extends AccessReviewWindow {
  _AccessReviewWindowImpl({
    int? id,
    required int windowId,
    required DateTime openDate,
    required DateTime closeDate,
    required int totalRecords,
    String? jobId,
    String? status,
    DateTime? createdAt,
    String? migrationMarker,
  }) : super._(
         id: id,
         windowId: windowId,
         openDate: openDate,
         closeDate: closeDate,
         totalRecords: totalRecords,
         jobId: jobId,
         status: status,
         createdAt: createdAt,
         migrationMarker: migrationMarker,
       );

  /// Returns a shallow copy of this [AccessReviewWindow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessReviewWindow copyWith({
    Object? id = _Undefined,
    int? windowId,
    DateTime? openDate,
    DateTime? closeDate,
    int? totalRecords,
    Object? jobId = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? migrationMarker = _Undefined,
  }) {
    return AccessReviewWindow(
      id: id is int? ? id : this.id,
      windowId: windowId ?? this.windowId,
      openDate: openDate ?? this.openDate,
      closeDate: closeDate ?? this.closeDate,
      totalRecords: totalRecords ?? this.totalRecords,
      jobId: jobId is String? ? jobId : this.jobId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      migrationMarker: migrationMarker is String?
          ? migrationMarker
          : this.migrationMarker,
    );
  }
}

class AccessReviewWindowUpdateTable
    extends _i1.UpdateTable<AccessReviewWindowTable> {
  AccessReviewWindowUpdateTable(super.table);

  _i1.ColumnValue<int, int> windowId(int value) => _i1.ColumnValue(
    table.windowId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> openDate(DateTime value) =>
      _i1.ColumnValue(
        table.openDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> closeDate(DateTime value) =>
      _i1.ColumnValue(
        table.closeDate,
        value,
      );

  _i1.ColumnValue<int, int> totalRecords(int value) => _i1.ColumnValue(
    table.totalRecords,
    value,
  );

  _i1.ColumnValue<String, String> jobId(String? value) => _i1.ColumnValue(
    table.jobId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> migrationMarker(String? value) =>
      _i1.ColumnValue(
        table.migrationMarker,
        value,
      );
}

class AccessReviewWindowTable extends _i1.Table<int?> {
  AccessReviewWindowTable({super.tableRelation})
    : super(tableName: 'access_review_window') {
    updateTable = AccessReviewWindowUpdateTable(this);
    windowId = _i1.ColumnInt(
      'windowId',
      this,
    );
    openDate = _i1.ColumnDateTime(
      'openDate',
      this,
    );
    closeDate = _i1.ColumnDateTime(
      'closeDate',
      this,
    );
    totalRecords = _i1.ColumnInt(
      'totalRecords',
      this,
    );
    jobId = _i1.ColumnString(
      'jobId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    migrationMarker = _i1.ColumnString(
      'migrationMarker',
      this,
    );
  }

  late final AccessReviewWindowUpdateTable updateTable;

  /// Unique window ID
  late final _i1.ColumnInt windowId;

  /// Open date
  late final _i1.ColumnDateTime openDate;

  /// Close date
  late final _i1.ColumnDateTime closeDate;

  /// Total records in this window
  late final _i1.ColumnInt totalRecords;

  /// Triggering job ID
  late final _i1.ColumnString jobId;

  /// Status (ACTIVE, CLOSED)
  late final _i1.ColumnString status;

  /// Created at
  late final _i1.ColumnDateTime createdAt;

  /// Temporary migration marker - remove after migration applied
  late final _i1.ColumnString migrationMarker;

  @override
  List<_i1.Column> get columns => [
    id,
    windowId,
    openDate,
    closeDate,
    totalRecords,
    jobId,
    status,
    createdAt,
    migrationMarker,
  ];
}

class AccessReviewWindowInclude extends _i1.IncludeObject {
  AccessReviewWindowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AccessReviewWindow.t;
}

class AccessReviewWindowIncludeList extends _i1.IncludeList {
  AccessReviewWindowIncludeList._({
    _i1.WhereExpressionBuilder<AccessReviewWindowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccessReviewWindow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AccessReviewWindow.t;
}

class AccessReviewWindowRepository {
  const AccessReviewWindowRepository._();

  /// Returns a list of [AccessReviewWindow]s matching the given query parameters.
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
  Future<List<AccessReviewWindow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessReviewWindowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessReviewWindowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessReviewWindowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AccessReviewWindow>(
      where: where?.call(AccessReviewWindow.t),
      orderBy: orderBy?.call(AccessReviewWindow.t),
      orderByList: orderByList?.call(AccessReviewWindow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AccessReviewWindow] matching the given query parameters.
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
  Future<AccessReviewWindow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessReviewWindowTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccessReviewWindowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessReviewWindowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AccessReviewWindow>(
      where: where?.call(AccessReviewWindow.t),
      orderBy: orderBy?.call(AccessReviewWindow.t),
      orderByList: orderByList?.call(AccessReviewWindow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AccessReviewWindow] by its [id] or null if no such row exists.
  Future<AccessReviewWindow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AccessReviewWindow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AccessReviewWindow]s in the list and returns the inserted rows.
  ///
  /// The returned [AccessReviewWindow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AccessReviewWindow>> insert(
    _i1.DatabaseSession session,
    List<AccessReviewWindow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AccessReviewWindow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AccessReviewWindow] and returns the inserted row.
  ///
  /// The returned [AccessReviewWindow] will have its `id` field set.
  Future<AccessReviewWindow> insertRow(
    _i1.DatabaseSession session,
    AccessReviewWindow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccessReviewWindow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AccessReviewWindow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AccessReviewWindow>> update(
    _i1.DatabaseSession session,
    List<AccessReviewWindow> rows, {
    _i1.ColumnSelections<AccessReviewWindowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AccessReviewWindow>(
      rows,
      columns: columns?.call(AccessReviewWindow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessReviewWindow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccessReviewWindow> updateRow(
    _i1.DatabaseSession session,
    AccessReviewWindow row, {
    _i1.ColumnSelections<AccessReviewWindowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccessReviewWindow>(
      row,
      columns: columns?.call(AccessReviewWindow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessReviewWindow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccessReviewWindow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AccessReviewWindowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AccessReviewWindow>(
      id,
      columnValues: columnValues(AccessReviewWindow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccessReviewWindow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AccessReviewWindow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AccessReviewWindowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AccessReviewWindowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessReviewWindowTable>? orderBy,
    _i1.OrderByListBuilder<AccessReviewWindowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AccessReviewWindow>(
      columnValues: columnValues(AccessReviewWindow.t.updateTable),
      where: where(AccessReviewWindow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessReviewWindow.t),
      orderByList: orderByList?.call(AccessReviewWindow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AccessReviewWindow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AccessReviewWindow>> delete(
    _i1.DatabaseSession session,
    List<AccessReviewWindow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AccessReviewWindow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AccessReviewWindow].
  Future<AccessReviewWindow> deleteRow(
    _i1.DatabaseSession session,
    AccessReviewWindow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccessReviewWindow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AccessReviewWindow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccessReviewWindowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AccessReviewWindow>(
      where: where(AccessReviewWindow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessReviewWindowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AccessReviewWindow>(
      where: where?.call(AccessReviewWindow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AccessReviewWindow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccessReviewWindowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AccessReviewWindow>(
      where: where(AccessReviewWindow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
