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

/// Archived records moved from hot tables per retention policy.
/// Stores snapshot of record at archival time for compliance.
abstract class RetentionArchive
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RetentionArchive._({
    this.id,
    required this.entityType,
    required this.entityId,
    required this.rowJson,
    DateTime? archivedAt,
  }) : archivedAt = archivedAt ?? DateTime.now();

  factory RetentionArchive({
    int? id,
    required String entityType,
    required String entityId,
    required String rowJson,
    DateTime? archivedAt,
  }) = _RetentionArchiveImpl;

  factory RetentionArchive.fromJson(Map<String, dynamic> jsonSerialization) {
    return RetentionArchive(
      id: jsonSerialization['id'] as int?,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String,
      rowJson: jsonSerialization['rowJson'] as String,
      archivedAt: jsonSerialization['archivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['archivedAt']),
    );
  }

  static final t = RetentionArchiveTable();

  static const db = RetentionArchiveRepository._();

  @override
  int? id;

  /// Source entity type (e.g., audit_trail).
  String entityType;

  /// Original entity ID.
  String entityId;

  /// Full row data as JSON snapshot.
  String rowJson;

  /// When archived.
  DateTime archivedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RetentionArchive]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RetentionArchive copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? rowJson,
    DateTime? archivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RetentionArchive',
      if (id != null) 'id': id,
      'entityType': entityType,
      'entityId': entityId,
      'rowJson': rowJson,
      'archivedAt': archivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RetentionArchive',
      if (id != null) 'id': id,
      'entityType': entityType,
      'entityId': entityId,
      'rowJson': rowJson,
      'archivedAt': archivedAt.toJson(),
    };
  }

  static RetentionArchiveInclude include() {
    return RetentionArchiveInclude._();
  }

  static RetentionArchiveIncludeList includeList({
    _i1.WhereExpressionBuilder<RetentionArchiveTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RetentionArchiveTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RetentionArchiveTable>? orderByList,
    RetentionArchiveInclude? include,
  }) {
    return RetentionArchiveIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RetentionArchive.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RetentionArchive.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RetentionArchiveImpl extends RetentionArchive {
  _RetentionArchiveImpl({
    int? id,
    required String entityType,
    required String entityId,
    required String rowJson,
    DateTime? archivedAt,
  }) : super._(
         id: id,
         entityType: entityType,
         entityId: entityId,
         rowJson: rowJson,
         archivedAt: archivedAt,
       );

  /// Returns a shallow copy of this [RetentionArchive]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RetentionArchive copyWith({
    Object? id = _Undefined,
    String? entityType,
    String? entityId,
    String? rowJson,
    DateTime? archivedAt,
  }) {
    return RetentionArchive(
      id: id is int? ? id : this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      rowJson: rowJson ?? this.rowJson,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }
}

class RetentionArchiveUpdateTable
    extends _i1.UpdateTable<RetentionArchiveTable> {
  RetentionArchiveUpdateTable(super.table);

  _i1.ColumnValue<String, String> entityType(String value) => _i1.ColumnValue(
    table.entityType,
    value,
  );

  _i1.ColumnValue<String, String> entityId(String value) => _i1.ColumnValue(
    table.entityId,
    value,
  );

  _i1.ColumnValue<String, String> rowJson(String value) => _i1.ColumnValue(
    table.rowJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> archivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.archivedAt,
        value,
      );
}

class RetentionArchiveTable extends _i1.Table<int?> {
  RetentionArchiveTable({super.tableRelation})
    : super(tableName: 'retention_archive') {
    updateTable = RetentionArchiveUpdateTable(this);
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    entityId = _i1.ColumnString(
      'entityId',
      this,
    );
    rowJson = _i1.ColumnString(
      'rowJson',
      this,
    );
    archivedAt = _i1.ColumnDateTime(
      'archivedAt',
      this,
      hasDefault: true,
    );
  }

  late final RetentionArchiveUpdateTable updateTable;

  /// Source entity type (e.g., audit_trail).
  late final _i1.ColumnString entityType;

  /// Original entity ID.
  late final _i1.ColumnString entityId;

  /// Full row data as JSON snapshot.
  late final _i1.ColumnString rowJson;

  /// When archived.
  late final _i1.ColumnDateTime archivedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    entityType,
    entityId,
    rowJson,
    archivedAt,
  ];
}

class RetentionArchiveInclude extends _i1.IncludeObject {
  RetentionArchiveInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RetentionArchive.t;
}

class RetentionArchiveIncludeList extends _i1.IncludeList {
  RetentionArchiveIncludeList._({
    _i1.WhereExpressionBuilder<RetentionArchiveTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RetentionArchive.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RetentionArchive.t;
}

class RetentionArchiveRepository {
  const RetentionArchiveRepository._();

  /// Returns a list of [RetentionArchive]s matching the given query parameters.
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
  Future<List<RetentionArchive>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RetentionArchiveTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RetentionArchiveTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RetentionArchiveTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RetentionArchive>(
      where: where?.call(RetentionArchive.t),
      orderBy: orderBy?.call(RetentionArchive.t),
      orderByList: orderByList?.call(RetentionArchive.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RetentionArchive] matching the given query parameters.
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
  Future<RetentionArchive?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RetentionArchiveTable>? where,
    int? offset,
    _i1.OrderByBuilder<RetentionArchiveTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RetentionArchiveTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RetentionArchive>(
      where: where?.call(RetentionArchive.t),
      orderBy: orderBy?.call(RetentionArchive.t),
      orderByList: orderByList?.call(RetentionArchive.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RetentionArchive] by its [id] or null if no such row exists.
  Future<RetentionArchive?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RetentionArchive>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RetentionArchive]s in the list and returns the inserted rows.
  ///
  /// The returned [RetentionArchive]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RetentionArchive>> insert(
    _i1.DatabaseSession session,
    List<RetentionArchive> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RetentionArchive>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RetentionArchive] and returns the inserted row.
  ///
  /// The returned [RetentionArchive] will have its `id` field set.
  Future<RetentionArchive> insertRow(
    _i1.DatabaseSession session,
    RetentionArchive row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RetentionArchive>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RetentionArchive]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RetentionArchive>> update(
    _i1.DatabaseSession session,
    List<RetentionArchive> rows, {
    _i1.ColumnSelections<RetentionArchiveTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RetentionArchive>(
      rows,
      columns: columns?.call(RetentionArchive.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RetentionArchive]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RetentionArchive> updateRow(
    _i1.DatabaseSession session,
    RetentionArchive row, {
    _i1.ColumnSelections<RetentionArchiveTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RetentionArchive>(
      row,
      columns: columns?.call(RetentionArchive.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RetentionArchive] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RetentionArchive?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RetentionArchiveUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RetentionArchive>(
      id,
      columnValues: columnValues(RetentionArchive.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RetentionArchive]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RetentionArchive>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RetentionArchiveUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RetentionArchiveTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RetentionArchiveTable>? orderBy,
    _i1.OrderByListBuilder<RetentionArchiveTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RetentionArchive>(
      columnValues: columnValues(RetentionArchive.t.updateTable),
      where: where(RetentionArchive.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RetentionArchive.t),
      orderByList: orderByList?.call(RetentionArchive.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RetentionArchive]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RetentionArchive>> delete(
    _i1.DatabaseSession session,
    List<RetentionArchive> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RetentionArchive>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RetentionArchive].
  Future<RetentionArchive> deleteRow(
    _i1.DatabaseSession session,
    RetentionArchive row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RetentionArchive>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RetentionArchive>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RetentionArchiveTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RetentionArchive>(
      where: where(RetentionArchive.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RetentionArchiveTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RetentionArchive>(
      where: where?.call(RetentionArchive.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RetentionArchive] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RetentionArchiveTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RetentionArchive>(
      where: where(RetentionArchive.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
