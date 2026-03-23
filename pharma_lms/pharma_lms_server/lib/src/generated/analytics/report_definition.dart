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

/// Report definition for analytics.
abstract class ReportDefinition
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReportDefinition._({
    this.id,
    required this.name,
    required this.reportType,
    this.querySql,
    this.paramsJson,
  });

  factory ReportDefinition({
    int? id,
    required String name,
    required String reportType,
    String? querySql,
    String? paramsJson,
  }) = _ReportDefinitionImpl;

  factory ReportDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportDefinition(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      reportType: jsonSerialization['reportType'] as String,
      querySql: jsonSerialization['querySql'] as String?,
      paramsJson: jsonSerialization['paramsJson'] as String?,
    );
  }

  static final t = ReportDefinitionTable();

  static const db = ReportDefinitionRepository._();

  @override
  int? id;

  /// Report name.
  String name;

  /// Report type.
  String reportType;

  /// Query SQL or template.
  String? querySql;

  /// Parameters as JSON.
  String? paramsJson;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReportDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportDefinition copyWith({
    int? id,
    String? name,
    String? reportType,
    String? querySql,
    String? paramsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportDefinition',
      if (id != null) 'id': id,
      'name': name,
      'reportType': reportType,
      if (querySql != null) 'querySql': querySql,
      if (paramsJson != null) 'paramsJson': paramsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReportDefinition',
      if (id != null) 'id': id,
      'name': name,
      'reportType': reportType,
      if (querySql != null) 'querySql': querySql,
      if (paramsJson != null) 'paramsJson': paramsJson,
    };
  }

  static ReportDefinitionInclude include() {
    return ReportDefinitionInclude._();
  }

  static ReportDefinitionIncludeList includeList({
    _i1.WhereExpressionBuilder<ReportDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportDefinitionTable>? orderByList,
    ReportDefinitionInclude? include,
  }) {
    return ReportDefinitionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReportDefinition.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReportDefinition.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportDefinitionImpl extends ReportDefinition {
  _ReportDefinitionImpl({
    int? id,
    required String name,
    required String reportType,
    String? querySql,
    String? paramsJson,
  }) : super._(
         id: id,
         name: name,
         reportType: reportType,
         querySql: querySql,
         paramsJson: paramsJson,
       );

  /// Returns a shallow copy of this [ReportDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportDefinition copyWith({
    Object? id = _Undefined,
    String? name,
    String? reportType,
    Object? querySql = _Undefined,
    Object? paramsJson = _Undefined,
  }) {
    return ReportDefinition(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      reportType: reportType ?? this.reportType,
      querySql: querySql is String? ? querySql : this.querySql,
      paramsJson: paramsJson is String? ? paramsJson : this.paramsJson,
    );
  }
}

class ReportDefinitionUpdateTable
    extends _i1.UpdateTable<ReportDefinitionTable> {
  ReportDefinitionUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> reportType(String value) => _i1.ColumnValue(
    table.reportType,
    value,
  );

  _i1.ColumnValue<String, String> querySql(String? value) => _i1.ColumnValue(
    table.querySql,
    value,
  );

  _i1.ColumnValue<String, String> paramsJson(String? value) => _i1.ColumnValue(
    table.paramsJson,
    value,
  );
}

class ReportDefinitionTable extends _i1.Table<int?> {
  ReportDefinitionTable({super.tableRelation})
    : super(tableName: 'report_definition') {
    updateTable = ReportDefinitionUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    reportType = _i1.ColumnString(
      'reportType',
      this,
    );
    querySql = _i1.ColumnString(
      'querySql',
      this,
    );
    paramsJson = _i1.ColumnString(
      'paramsJson',
      this,
    );
  }

  late final ReportDefinitionUpdateTable updateTable;

  /// Report name.
  late final _i1.ColumnString name;

  /// Report type.
  late final _i1.ColumnString reportType;

  /// Query SQL or template.
  late final _i1.ColumnString querySql;

  /// Parameters as JSON.
  late final _i1.ColumnString paramsJson;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    reportType,
    querySql,
    paramsJson,
  ];
}

class ReportDefinitionInclude extends _i1.IncludeObject {
  ReportDefinitionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReportDefinition.t;
}

class ReportDefinitionIncludeList extends _i1.IncludeList {
  ReportDefinitionIncludeList._({
    _i1.WhereExpressionBuilder<ReportDefinitionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReportDefinition.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReportDefinition.t;
}

class ReportDefinitionRepository {
  const ReportDefinitionRepository._();

  /// Returns a list of [ReportDefinition]s matching the given query parameters.
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
  Future<List<ReportDefinition>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReportDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReportDefinition>(
      where: where?.call(ReportDefinition.t),
      orderBy: orderBy?.call(ReportDefinition.t),
      orderByList: orderByList?.call(ReportDefinition.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReportDefinition] matching the given query parameters.
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
  Future<ReportDefinition?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReportDefinitionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReportDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReportDefinition>(
      where: where?.call(ReportDefinition.t),
      orderBy: orderBy?.call(ReportDefinition.t),
      orderByList: orderByList?.call(ReportDefinition.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReportDefinition] by its [id] or null if no such row exists.
  Future<ReportDefinition?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReportDefinition>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReportDefinition]s in the list and returns the inserted rows.
  ///
  /// The returned [ReportDefinition]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ReportDefinition>> insert(
    _i1.DatabaseSession session,
    List<ReportDefinition> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ReportDefinition>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ReportDefinition] and returns the inserted row.
  ///
  /// The returned [ReportDefinition] will have its `id` field set.
  Future<ReportDefinition> insertRow(
    _i1.DatabaseSession session,
    ReportDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReportDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReportDefinition]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReportDefinition>> update(
    _i1.DatabaseSession session,
    List<ReportDefinition> rows, {
    _i1.ColumnSelections<ReportDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReportDefinition>(
      rows,
      columns: columns?.call(ReportDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReportDefinition]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReportDefinition> updateRow(
    _i1.DatabaseSession session,
    ReportDefinition row, {
    _i1.ColumnSelections<ReportDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReportDefinition>(
      row,
      columns: columns?.call(ReportDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReportDefinition] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReportDefinition?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ReportDefinitionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ReportDefinition>(
      id,
      columnValues: columnValues(ReportDefinition.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReportDefinition]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ReportDefinition>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ReportDefinitionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ReportDefinitionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportDefinitionTable>? orderBy,
    _i1.OrderByListBuilder<ReportDefinitionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ReportDefinition>(
      columnValues: columnValues(ReportDefinition.t.updateTable),
      where: where(ReportDefinition.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReportDefinition.t),
      orderByList: orderByList?.call(ReportDefinition.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ReportDefinition]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReportDefinition>> delete(
    _i1.DatabaseSession session,
    List<ReportDefinition> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReportDefinition>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReportDefinition].
  Future<ReportDefinition> deleteRow(
    _i1.DatabaseSession session,
    ReportDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReportDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReportDefinition>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReportDefinitionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReportDefinition>(
      where: where(ReportDefinition.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReportDefinitionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReportDefinition>(
      where: where?.call(ReportDefinition.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReportDefinition] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReportDefinitionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReportDefinition>(
      where: where(ReportDefinition.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
