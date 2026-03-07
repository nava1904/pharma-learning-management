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
import '../organization/role.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Dashboard configuration.
abstract class Dashboard
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Dashboard._({
    this.id,
    required this.name,
    required this.widgetsJson,
    this.roleId,
    this.role,
  });

  factory Dashboard({
    int? id,
    required String name,
    required String widgetsJson,
    int? roleId,
    _i2.Role? role,
  }) = _DashboardImpl;

  factory Dashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dashboard(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      widgetsJson: jsonSerialization['widgetsJson'] as String,
      roleId: jsonSerialization['roleId'] as int?,
      role: jsonSerialization['role'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Role>(jsonSerialization['role']),
    );
  }

  static final t = DashboardTable();

  static const db = DashboardRepository._();

  @override
  int? id;

  /// Dashboard name.
  String name;

  /// Widgets configuration as JSON.
  String widgetsJson;

  int? roleId;

  /// Role this dashboard is for.
  _i2.Role? role;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Dashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dashboard copyWith({
    int? id,
    String? name,
    String? widgetsJson,
    int? roleId,
    _i2.Role? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dashboard',
      if (id != null) 'id': id,
      'name': name,
      'widgetsJson': widgetsJson,
      if (roleId != null) 'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Dashboard',
      if (id != null) 'id': id,
      'name': name,
      'widgetsJson': widgetsJson,
      if (roleId != null) 'roleId': roleId,
      if (role != null) 'role': role?.toJsonForProtocol(),
    };
  }

  static DashboardInclude include({_i2.RoleInclude? role}) {
    return DashboardInclude._(role: role);
  }

  static DashboardIncludeList includeList({
    _i1.WhereExpressionBuilder<DashboardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DashboardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DashboardTable>? orderByList,
    DashboardInclude? include,
  }) {
    return DashboardIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dashboard.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Dashboard.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardImpl extends Dashboard {
  _DashboardImpl({
    int? id,
    required String name,
    required String widgetsJson,
    int? roleId,
    _i2.Role? role,
  }) : super._(
         id: id,
         name: name,
         widgetsJson: widgetsJson,
         roleId: roleId,
         role: role,
       );

  /// Returns a shallow copy of this [Dashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dashboard copyWith({
    Object? id = _Undefined,
    String? name,
    String? widgetsJson,
    Object? roleId = _Undefined,
    Object? role = _Undefined,
  }) {
    return Dashboard(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      widgetsJson: widgetsJson ?? this.widgetsJson,
      roleId: roleId is int? ? roleId : this.roleId,
      role: role is _i2.Role? ? role : this.role?.copyWith(),
    );
  }
}

class DashboardUpdateTable extends _i1.UpdateTable<DashboardTable> {
  DashboardUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> widgetsJson(String value) => _i1.ColumnValue(
    table.widgetsJson,
    value,
  );

  _i1.ColumnValue<int, int> roleId(int? value) => _i1.ColumnValue(
    table.roleId,
    value,
  );
}

class DashboardTable extends _i1.Table<int?> {
  DashboardTable({super.tableRelation}) : super(tableName: 'dashboard') {
    updateTable = DashboardUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    widgetsJson = _i1.ColumnString(
      'widgetsJson',
      this,
    );
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
  }

  late final DashboardUpdateTable updateTable;

  /// Dashboard name.
  late final _i1.ColumnString name;

  /// Widgets configuration as JSON.
  late final _i1.ColumnString widgetsJson;

  late final _i1.ColumnInt roleId;

  /// Role this dashboard is for.
  _i2.RoleTable? _role;

  _i2.RoleTable get role {
    if (_role != null) return _role!;
    _role = _i1.createRelationTable(
      relationFieldName: 'role',
      field: Dashboard.t.roleId,
      foreignField: _i2.Role.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoleTable(tableRelation: foreignTableRelation),
    );
    return _role!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    widgetsJson,
    roleId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'role') {
      return role;
    }
    return null;
  }
}

class DashboardInclude extends _i1.IncludeObject {
  DashboardInclude._({_i2.RoleInclude? role}) {
    _role = role;
  }

  _i2.RoleInclude? _role;

  @override
  Map<String, _i1.Include?> get includes => {'role': _role};

  @override
  _i1.Table<int?> get table => Dashboard.t;
}

class DashboardIncludeList extends _i1.IncludeList {
  DashboardIncludeList._({
    _i1.WhereExpressionBuilder<DashboardTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Dashboard.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Dashboard.t;
}

class DashboardRepository {
  const DashboardRepository._();

  final attachRow = const DashboardAttachRowRepository._();

  final detachRow = const DashboardDetachRowRepository._();

  /// Returns a list of [Dashboard]s matching the given query parameters.
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
  Future<List<Dashboard>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DashboardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DashboardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DashboardTable>? orderByList,
    _i1.Transaction? transaction,
    DashboardInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Dashboard>(
      where: where?.call(Dashboard.t),
      orderBy: orderBy?.call(Dashboard.t),
      orderByList: orderByList?.call(Dashboard.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Dashboard] matching the given query parameters.
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
  Future<Dashboard?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DashboardTable>? where,
    int? offset,
    _i1.OrderByBuilder<DashboardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DashboardTable>? orderByList,
    _i1.Transaction? transaction,
    DashboardInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Dashboard>(
      where: where?.call(Dashboard.t),
      orderBy: orderBy?.call(Dashboard.t),
      orderByList: orderByList?.call(Dashboard.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Dashboard] by its [id] or null if no such row exists.
  Future<Dashboard?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    DashboardInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Dashboard>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Dashboard]s in the list and returns the inserted rows.
  ///
  /// The returned [Dashboard]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Dashboard>> insert(
    _i1.Session session,
    List<Dashboard> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Dashboard>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Dashboard] and returns the inserted row.
  ///
  /// The returned [Dashboard] will have its `id` field set.
  Future<Dashboard> insertRow(
    _i1.Session session,
    Dashboard row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Dashboard>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Dashboard]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Dashboard>> update(
    _i1.Session session,
    List<Dashboard> rows, {
    _i1.ColumnSelections<DashboardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Dashboard>(
      rows,
      columns: columns?.call(Dashboard.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dashboard]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Dashboard> updateRow(
    _i1.Session session,
    Dashboard row, {
    _i1.ColumnSelections<DashboardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Dashboard>(
      row,
      columns: columns?.call(Dashboard.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dashboard] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Dashboard?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DashboardUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Dashboard>(
      id,
      columnValues: columnValues(Dashboard.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Dashboard]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Dashboard>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DashboardUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DashboardTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DashboardTable>? orderBy,
    _i1.OrderByListBuilder<DashboardTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Dashboard>(
      columnValues: columnValues(Dashboard.t.updateTable),
      where: where(Dashboard.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dashboard.t),
      orderByList: orderByList?.call(Dashboard.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Dashboard]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Dashboard>> delete(
    _i1.Session session,
    List<Dashboard> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Dashboard>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Dashboard].
  Future<Dashboard> deleteRow(
    _i1.Session session,
    Dashboard row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Dashboard>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Dashboard>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DashboardTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Dashboard>(
      where: where(Dashboard.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DashboardTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Dashboard>(
      where: where?.call(Dashboard.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Dashboard] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DashboardTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Dashboard>(
      where: where(Dashboard.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DashboardAttachRowRepository {
  const DashboardAttachRowRepository._();

  /// Creates a relation between the given [Dashboard] and [Role]
  /// by setting the [Dashboard]'s foreign key `roleId` to refer to the [Role].
  Future<void> role(
    _i1.Session session,
    Dashboard dashboard,
    _i2.Role role, {
    _i1.Transaction? transaction,
  }) async {
    if (dashboard.id == null) {
      throw ArgumentError.notNull('dashboard.id');
    }
    if (role.id == null) {
      throw ArgumentError.notNull('role.id');
    }

    var $dashboard = dashboard.copyWith(roleId: role.id);
    await session.db.updateRow<Dashboard>(
      $dashboard,
      columns: [Dashboard.t.roleId],
      transaction: transaction,
    );
  }
}

class DashboardDetachRowRepository {
  const DashboardDetachRowRepository._();

  /// Detaches the relation between this [Dashboard] and the [Role] set in `role`
  /// by setting the [Dashboard]'s foreign key `roleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> role(
    _i1.Session session,
    Dashboard dashboard, {
    _i1.Transaction? transaction,
  }) async {
    if (dashboard.id == null) {
      throw ArgumentError.notNull('dashboard.id');
    }

    var $dashboard = dashboard.copyWith(roleId: null);
    await session.db.updateRow<Dashboard>(
      $dashboard,
      columns: [Dashboard.t.roleId],
      transaction: transaction,
    );
  }
}
