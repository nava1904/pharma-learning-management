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

/// Retention policy configuration for data archival.
/// Defines how long to retain data before archiving to cold storage.
abstract class RetentionPolicy
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RetentionPolicy._({
    this.id,
    required this.entityType,
    int? retentionYears,
    bool? archiveEnabled,
    this.lastArchivedAt,
  }) : retentionYears = retentionYears ?? 7,
       archiveEnabled = archiveEnabled ?? true;

  factory RetentionPolicy({
    int? id,
    required String entityType,
    int? retentionYears,
    bool? archiveEnabled,
    DateTime? lastArchivedAt,
  }) = _RetentionPolicyImpl;

  factory RetentionPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return RetentionPolicy(
      id: jsonSerialization['id'] as int?,
      entityType: jsonSerialization['entityType'] as String,
      retentionYears: jsonSerialization['retentionYears'] as int?,
      archiveEnabled: jsonSerialization['archiveEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['archiveEnabled']),
      lastArchivedAt: jsonSerialization['lastArchivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastArchivedAt'],
            ),
    );
  }

  static final t = RetentionPolicyTable();

  static const db = RetentionPolicyRepository._();

  @override
  int? id;

  /// Entity type (e.g., audit_trail, access_log, notification).
  String entityType;

  /// Retention period in years before archival.
  int retentionYears;

  /// Whether to archive (move to cold storage) or only enforce retention.
  bool archiveEnabled;

  /// Last run timestamp.
  DateTime? lastArchivedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RetentionPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RetentionPolicy copyWith({
    int? id,
    String? entityType,
    int? retentionYears,
    bool? archiveEnabled,
    DateTime? lastArchivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RetentionPolicy',
      if (id != null) 'id': id,
      'entityType': entityType,
      'retentionYears': retentionYears,
      'archiveEnabled': archiveEnabled,
      if (lastArchivedAt != null) 'lastArchivedAt': lastArchivedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RetentionPolicy',
      if (id != null) 'id': id,
      'entityType': entityType,
      'retentionYears': retentionYears,
      'archiveEnabled': archiveEnabled,
      if (lastArchivedAt != null) 'lastArchivedAt': lastArchivedAt?.toJson(),
    };
  }

  static RetentionPolicyInclude include() {
    return RetentionPolicyInclude._();
  }

  static RetentionPolicyIncludeList includeList({
    _i1.WhereExpressionBuilder<RetentionPolicyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RetentionPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RetentionPolicyTable>? orderByList,
    RetentionPolicyInclude? include,
  }) {
    return RetentionPolicyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RetentionPolicy.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RetentionPolicy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RetentionPolicyImpl extends RetentionPolicy {
  _RetentionPolicyImpl({
    int? id,
    required String entityType,
    int? retentionYears,
    bool? archiveEnabled,
    DateTime? lastArchivedAt,
  }) : super._(
         id: id,
         entityType: entityType,
         retentionYears: retentionYears,
         archiveEnabled: archiveEnabled,
         lastArchivedAt: lastArchivedAt,
       );

  /// Returns a shallow copy of this [RetentionPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RetentionPolicy copyWith({
    Object? id = _Undefined,
    String? entityType,
    int? retentionYears,
    bool? archiveEnabled,
    Object? lastArchivedAt = _Undefined,
  }) {
    return RetentionPolicy(
      id: id is int? ? id : this.id,
      entityType: entityType ?? this.entityType,
      retentionYears: retentionYears ?? this.retentionYears,
      archiveEnabled: archiveEnabled ?? this.archiveEnabled,
      lastArchivedAt: lastArchivedAt is DateTime?
          ? lastArchivedAt
          : this.lastArchivedAt,
    );
  }
}

class RetentionPolicyUpdateTable extends _i1.UpdateTable<RetentionPolicyTable> {
  RetentionPolicyUpdateTable(super.table);

  _i1.ColumnValue<String, String> entityType(String value) => _i1.ColumnValue(
    table.entityType,
    value,
  );

  _i1.ColumnValue<int, int> retentionYears(int value) => _i1.ColumnValue(
    table.retentionYears,
    value,
  );

  _i1.ColumnValue<bool, bool> archiveEnabled(bool value) => _i1.ColumnValue(
    table.archiveEnabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastArchivedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastArchivedAt,
        value,
      );
}

class RetentionPolicyTable extends _i1.Table<int?> {
  RetentionPolicyTable({super.tableRelation})
    : super(tableName: 'retention_policy') {
    updateTable = RetentionPolicyUpdateTable(this);
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    retentionYears = _i1.ColumnInt(
      'retentionYears',
      this,
      hasDefault: true,
    );
    archiveEnabled = _i1.ColumnBool(
      'archiveEnabled',
      this,
      hasDefault: true,
    );
    lastArchivedAt = _i1.ColumnDateTime(
      'lastArchivedAt',
      this,
    );
  }

  late final RetentionPolicyUpdateTable updateTable;

  /// Entity type (e.g., audit_trail, access_log, notification).
  late final _i1.ColumnString entityType;

  /// Retention period in years before archival.
  late final _i1.ColumnInt retentionYears;

  /// Whether to archive (move to cold storage) or only enforce retention.
  late final _i1.ColumnBool archiveEnabled;

  /// Last run timestamp.
  late final _i1.ColumnDateTime lastArchivedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    entityType,
    retentionYears,
    archiveEnabled,
    lastArchivedAt,
  ];
}

class RetentionPolicyInclude extends _i1.IncludeObject {
  RetentionPolicyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RetentionPolicy.t;
}

class RetentionPolicyIncludeList extends _i1.IncludeList {
  RetentionPolicyIncludeList._({
    _i1.WhereExpressionBuilder<RetentionPolicyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RetentionPolicy.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RetentionPolicy.t;
}

class RetentionPolicyRepository {
  const RetentionPolicyRepository._();

  /// Returns a list of [RetentionPolicy]s matching the given query parameters.
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
  Future<List<RetentionPolicy>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RetentionPolicyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RetentionPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RetentionPolicyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RetentionPolicy>(
      where: where?.call(RetentionPolicy.t),
      orderBy: orderBy?.call(RetentionPolicy.t),
      orderByList: orderByList?.call(RetentionPolicy.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RetentionPolicy] matching the given query parameters.
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
  Future<RetentionPolicy?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RetentionPolicyTable>? where,
    int? offset,
    _i1.OrderByBuilder<RetentionPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RetentionPolicyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RetentionPolicy>(
      where: where?.call(RetentionPolicy.t),
      orderBy: orderBy?.call(RetentionPolicy.t),
      orderByList: orderByList?.call(RetentionPolicy.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RetentionPolicy] by its [id] or null if no such row exists.
  Future<RetentionPolicy?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RetentionPolicy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RetentionPolicy]s in the list and returns the inserted rows.
  ///
  /// The returned [RetentionPolicy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RetentionPolicy>> insert(
    _i1.DatabaseSession session,
    List<RetentionPolicy> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RetentionPolicy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RetentionPolicy] and returns the inserted row.
  ///
  /// The returned [RetentionPolicy] will have its `id` field set.
  Future<RetentionPolicy> insertRow(
    _i1.DatabaseSession session,
    RetentionPolicy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RetentionPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RetentionPolicy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RetentionPolicy>> update(
    _i1.DatabaseSession session,
    List<RetentionPolicy> rows, {
    _i1.ColumnSelections<RetentionPolicyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RetentionPolicy>(
      rows,
      columns: columns?.call(RetentionPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RetentionPolicy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RetentionPolicy> updateRow(
    _i1.DatabaseSession session,
    RetentionPolicy row, {
    _i1.ColumnSelections<RetentionPolicyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RetentionPolicy>(
      row,
      columns: columns?.call(RetentionPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RetentionPolicy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RetentionPolicy?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RetentionPolicyUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RetentionPolicy>(
      id,
      columnValues: columnValues(RetentionPolicy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RetentionPolicy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RetentionPolicy>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RetentionPolicyUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RetentionPolicyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RetentionPolicyTable>? orderBy,
    _i1.OrderByListBuilder<RetentionPolicyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RetentionPolicy>(
      columnValues: columnValues(RetentionPolicy.t.updateTable),
      where: where(RetentionPolicy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RetentionPolicy.t),
      orderByList: orderByList?.call(RetentionPolicy.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RetentionPolicy]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RetentionPolicy>> delete(
    _i1.DatabaseSession session,
    List<RetentionPolicy> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RetentionPolicy>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RetentionPolicy].
  Future<RetentionPolicy> deleteRow(
    _i1.DatabaseSession session,
    RetentionPolicy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RetentionPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RetentionPolicy>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RetentionPolicyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RetentionPolicy>(
      where: where(RetentionPolicy.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RetentionPolicyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RetentionPolicy>(
      where: where?.call(RetentionPolicy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RetentionPolicy] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RetentionPolicyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RetentionPolicy>(
      where: where(RetentionPolicy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
