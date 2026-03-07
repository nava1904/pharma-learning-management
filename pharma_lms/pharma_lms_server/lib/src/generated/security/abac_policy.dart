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

/// ABAC policy for attribute-based access control.
abstract class AbacPolicy
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AbacPolicy._({
    this.id,
    required this.name,
    required this.ruleJson,
    required this.effect,
  });

  factory AbacPolicy({
    int? id,
    required String name,
    required String ruleJson,
    required String effect,
  }) = _AbacPolicyImpl;

  factory AbacPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return AbacPolicy(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      ruleJson: jsonSerialization['ruleJson'] as String,
      effect: jsonSerialization['effect'] as String,
    );
  }

  static final t = AbacPolicyTable();

  static const db = AbacPolicyRepository._();

  @override
  int? id;

  /// Policy name.
  String name;

  /// Rule as JSON.
  String ruleJson;

  /// Effect: allow, deny.
  String effect;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AbacPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AbacPolicy copyWith({
    int? id,
    String? name,
    String? ruleJson,
    String? effect,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AbacPolicy',
      if (id != null) 'id': id,
      'name': name,
      'ruleJson': ruleJson,
      'effect': effect,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AbacPolicy',
      if (id != null) 'id': id,
      'name': name,
      'ruleJson': ruleJson,
      'effect': effect,
    };
  }

  static AbacPolicyInclude include() {
    return AbacPolicyInclude._();
  }

  static AbacPolicyIncludeList includeList({
    _i1.WhereExpressionBuilder<AbacPolicyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AbacPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AbacPolicyTable>? orderByList,
    AbacPolicyInclude? include,
  }) {
    return AbacPolicyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AbacPolicy.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AbacPolicy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AbacPolicyImpl extends AbacPolicy {
  _AbacPolicyImpl({
    int? id,
    required String name,
    required String ruleJson,
    required String effect,
  }) : super._(
         id: id,
         name: name,
         ruleJson: ruleJson,
         effect: effect,
       );

  /// Returns a shallow copy of this [AbacPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AbacPolicy copyWith({
    Object? id = _Undefined,
    String? name,
    String? ruleJson,
    String? effect,
  }) {
    return AbacPolicy(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      ruleJson: ruleJson ?? this.ruleJson,
      effect: effect ?? this.effect,
    );
  }
}

class AbacPolicyUpdateTable extends _i1.UpdateTable<AbacPolicyTable> {
  AbacPolicyUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> ruleJson(String value) => _i1.ColumnValue(
    table.ruleJson,
    value,
  );

  _i1.ColumnValue<String, String> effect(String value) => _i1.ColumnValue(
    table.effect,
    value,
  );
}

class AbacPolicyTable extends _i1.Table<int?> {
  AbacPolicyTable({super.tableRelation}) : super(tableName: 'abac_policy') {
    updateTable = AbacPolicyUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    ruleJson = _i1.ColumnString(
      'ruleJson',
      this,
    );
    effect = _i1.ColumnString(
      'effect',
      this,
    );
  }

  late final AbacPolicyUpdateTable updateTable;

  /// Policy name.
  late final _i1.ColumnString name;

  /// Rule as JSON.
  late final _i1.ColumnString ruleJson;

  /// Effect: allow, deny.
  late final _i1.ColumnString effect;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    ruleJson,
    effect,
  ];
}

class AbacPolicyInclude extends _i1.IncludeObject {
  AbacPolicyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AbacPolicy.t;
}

class AbacPolicyIncludeList extends _i1.IncludeList {
  AbacPolicyIncludeList._({
    _i1.WhereExpressionBuilder<AbacPolicyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AbacPolicy.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AbacPolicy.t;
}

class AbacPolicyRepository {
  const AbacPolicyRepository._();

  /// Returns a list of [AbacPolicy]s matching the given query parameters.
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
  Future<List<AbacPolicy>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AbacPolicyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AbacPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AbacPolicyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AbacPolicy>(
      where: where?.call(AbacPolicy.t),
      orderBy: orderBy?.call(AbacPolicy.t),
      orderByList: orderByList?.call(AbacPolicy.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AbacPolicy] matching the given query parameters.
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
  Future<AbacPolicy?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AbacPolicyTable>? where,
    int? offset,
    _i1.OrderByBuilder<AbacPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AbacPolicyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AbacPolicy>(
      where: where?.call(AbacPolicy.t),
      orderBy: orderBy?.call(AbacPolicy.t),
      orderByList: orderByList?.call(AbacPolicy.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AbacPolicy] by its [id] or null if no such row exists.
  Future<AbacPolicy?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AbacPolicy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AbacPolicy]s in the list and returns the inserted rows.
  ///
  /// The returned [AbacPolicy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AbacPolicy>> insert(
    _i1.Session session,
    List<AbacPolicy> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AbacPolicy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AbacPolicy] and returns the inserted row.
  ///
  /// The returned [AbacPolicy] will have its `id` field set.
  Future<AbacPolicy> insertRow(
    _i1.Session session,
    AbacPolicy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AbacPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AbacPolicy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AbacPolicy>> update(
    _i1.Session session,
    List<AbacPolicy> rows, {
    _i1.ColumnSelections<AbacPolicyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AbacPolicy>(
      rows,
      columns: columns?.call(AbacPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AbacPolicy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AbacPolicy> updateRow(
    _i1.Session session,
    AbacPolicy row, {
    _i1.ColumnSelections<AbacPolicyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AbacPolicy>(
      row,
      columns: columns?.call(AbacPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AbacPolicy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AbacPolicy?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AbacPolicyUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AbacPolicy>(
      id,
      columnValues: columnValues(AbacPolicy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AbacPolicy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AbacPolicy>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AbacPolicyUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AbacPolicyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AbacPolicyTable>? orderBy,
    _i1.OrderByListBuilder<AbacPolicyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AbacPolicy>(
      columnValues: columnValues(AbacPolicy.t.updateTable),
      where: where(AbacPolicy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AbacPolicy.t),
      orderByList: orderByList?.call(AbacPolicy.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AbacPolicy]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AbacPolicy>> delete(
    _i1.Session session,
    List<AbacPolicy> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AbacPolicy>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AbacPolicy].
  Future<AbacPolicy> deleteRow(
    _i1.Session session,
    AbacPolicy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AbacPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AbacPolicy>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AbacPolicyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AbacPolicy>(
      where: where(AbacPolicy.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AbacPolicyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AbacPolicy>(
      where: where?.call(AbacPolicy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AbacPolicy] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AbacPolicyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AbacPolicy>(
      where: where(AbacPolicy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
