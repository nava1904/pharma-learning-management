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

/// Competency/skill definition.
abstract class Competency
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Competency._({
    this.id,
    required this.name,
    required this.code,
    this.level,
  });

  factory Competency({
    int? id,
    required String name,
    required String code,
    int? level,
  }) = _CompetencyImpl;

  factory Competency.fromJson(Map<String, dynamic> jsonSerialization) {
    return Competency(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      level: jsonSerialization['level'] as int?,
    );
  }

  static final t = CompetencyTable();

  static const db = CompetencyRepository._();

  @override
  int? id;

  /// Competency name.
  String name;

  /// Unique code.
  String code;

  /// Level (1, 2, 3, etc.).
  int? level;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Competency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Competency copyWith({
    int? id,
    String? name,
    String? code,
    int? level,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Competency',
      if (id != null) 'id': id,
      'name': name,
      'code': code,
      if (level != null) 'level': level,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Competency',
      if (id != null) 'id': id,
      'name': name,
      'code': code,
      if (level != null) 'level': level,
    };
  }

  static CompetencyInclude include() {
    return CompetencyInclude._();
  }

  static CompetencyIncludeList includeList({
    _i1.WhereExpressionBuilder<CompetencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetencyTable>? orderByList,
    CompetencyInclude? include,
  }) {
    return CompetencyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Competency.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Competency.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetencyImpl extends Competency {
  _CompetencyImpl({
    int? id,
    required String name,
    required String code,
    int? level,
  }) : super._(
         id: id,
         name: name,
         code: code,
         level: level,
       );

  /// Returns a shallow copy of this [Competency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Competency copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    Object? level = _Undefined,
  }) {
    return Competency(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      level: level is int? ? level : this.level,
    );
  }
}

class CompetencyUpdateTable extends _i1.UpdateTable<CompetencyTable> {
  CompetencyUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<int, int> level(int? value) => _i1.ColumnValue(
    table.level,
    value,
  );
}

class CompetencyTable extends _i1.Table<int?> {
  CompetencyTable({super.tableRelation}) : super(tableName: 'competency') {
    updateTable = CompetencyUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
  }

  late final CompetencyUpdateTable updateTable;

  /// Competency name.
  late final _i1.ColumnString name;

  /// Unique code.
  late final _i1.ColumnString code;

  /// Level (1, 2, 3, etc.).
  late final _i1.ColumnInt level;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    code,
    level,
  ];
}

class CompetencyInclude extends _i1.IncludeObject {
  CompetencyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Competency.t;
}

class CompetencyIncludeList extends _i1.IncludeList {
  CompetencyIncludeList._({
    _i1.WhereExpressionBuilder<CompetencyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Competency.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Competency.t;
}

class CompetencyRepository {
  const CompetencyRepository._();

  /// Returns a list of [Competency]s matching the given query parameters.
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
  Future<List<Competency>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CompetencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetencyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Competency>(
      where: where?.call(Competency.t),
      orderBy: orderBy?.call(Competency.t),
      orderByList: orderByList?.call(Competency.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Competency] matching the given query parameters.
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
  Future<Competency?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CompetencyTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompetencyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Competency>(
      where: where?.call(Competency.t),
      orderBy: orderBy?.call(Competency.t),
      orderByList: orderByList?.call(Competency.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Competency] by its [id] or null if no such row exists.
  Future<Competency?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Competency>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Competency]s in the list and returns the inserted rows.
  ///
  /// The returned [Competency]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Competency>> insert(
    _i1.DatabaseSession session,
    List<Competency> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Competency>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Competency] and returns the inserted row.
  ///
  /// The returned [Competency] will have its `id` field set.
  Future<Competency> insertRow(
    _i1.DatabaseSession session,
    Competency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Competency>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Competency]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Competency>> update(
    _i1.DatabaseSession session,
    List<Competency> rows, {
    _i1.ColumnSelections<CompetencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Competency>(
      rows,
      columns: columns?.call(Competency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Competency]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Competency> updateRow(
    _i1.DatabaseSession session,
    Competency row, {
    _i1.ColumnSelections<CompetencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Competency>(
      row,
      columns: columns?.call(Competency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Competency] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Competency?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CompetencyUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Competency>(
      id,
      columnValues: columnValues(Competency.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Competency]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Competency>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CompetencyUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CompetencyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompetencyTable>? orderBy,
    _i1.OrderByListBuilder<CompetencyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Competency>(
      columnValues: columnValues(Competency.t.updateTable),
      where: where(Competency.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Competency.t),
      orderByList: orderByList?.call(Competency.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Competency]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Competency>> delete(
    _i1.DatabaseSession session,
    List<Competency> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Competency>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Competency].
  Future<Competency> deleteRow(
    _i1.DatabaseSession session,
    Competency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Competency>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Competency>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CompetencyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Competency>(
      where: where(Competency.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CompetencyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Competency>(
      where: where?.call(Competency.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Competency] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CompetencyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Competency>(
      where: where(Competency.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
