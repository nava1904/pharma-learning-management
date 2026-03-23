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

/// Permission linked to a role for RBAC.
abstract class Permission
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Permission._({
    this.id,
    required this.roleId,
    this.role,
    required this.resource,
    required this.action,
  });

  factory Permission({
    int? id,
    required int roleId,
    _i2.Role? role,
    required String resource,
    required String action,
  }) = _PermissionImpl;

  factory Permission.fromJson(Map<String, dynamic> jsonSerialization) {
    return Permission(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Role>(jsonSerialization['role']),
      resource: jsonSerialization['resource'] as String,
      action: jsonSerialization['action'] as String,
    );
  }

  static final t = PermissionTable();

  static const db = PermissionRepository._();

  @override
  int? id;

  int roleId;

  /// The role this permission belongs to.
  _i2.Role? role;

  /// Resource being protected (e.g., course, training, audit).
  String resource;

  /// Action allowed (e.g., read, write, approve).
  String action;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Permission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Permission copyWith({
    int? id,
    int? roleId,
    _i2.Role? role,
    String? resource,
    String? action,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Permission',
      if (id != null) 'id': id,
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
      'resource': resource,
      'action': action,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Permission',
      if (id != null) 'id': id,
      'roleId': roleId,
      if (role != null) 'role': role?.toJsonForProtocol(),
      'resource': resource,
      'action': action,
    };
  }

  static PermissionInclude include({_i2.RoleInclude? role}) {
    return PermissionInclude._(role: role);
  }

  static PermissionIncludeList includeList({
    _i1.WhereExpressionBuilder<PermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PermissionTable>? orderByList,
    PermissionInclude? include,
  }) {
    return PermissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Permission.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Permission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PermissionImpl extends Permission {
  _PermissionImpl({
    int? id,
    required int roleId,
    _i2.Role? role,
    required String resource,
    required String action,
  }) : super._(
         id: id,
         roleId: roleId,
         role: role,
         resource: resource,
         action: action,
       );

  /// Returns a shallow copy of this [Permission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Permission copyWith({
    Object? id = _Undefined,
    int? roleId,
    Object? role = _Undefined,
    String? resource,
    String? action,
  }) {
    return Permission(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      role: role is _i2.Role? ? role : this.role?.copyWith(),
      resource: resource ?? this.resource,
      action: action ?? this.action,
    );
  }
}

class PermissionUpdateTable extends _i1.UpdateTable<PermissionTable> {
  PermissionUpdateTable(super.table);

  _i1.ColumnValue<int, int> roleId(int value) => _i1.ColumnValue(
    table.roleId,
    value,
  );

  _i1.ColumnValue<String, String> resource(String value) => _i1.ColumnValue(
    table.resource,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );
}

class PermissionTable extends _i1.Table<int?> {
  PermissionTable({super.tableRelation}) : super(tableName: 'permission') {
    updateTable = PermissionUpdateTable(this);
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    resource = _i1.ColumnString(
      'resource',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
  }

  late final PermissionUpdateTable updateTable;

  late final _i1.ColumnInt roleId;

  /// The role this permission belongs to.
  _i2.RoleTable? _role;

  /// Resource being protected (e.g., course, training, audit).
  late final _i1.ColumnString resource;

  /// Action allowed (e.g., read, write, approve).
  late final _i1.ColumnString action;

  _i2.RoleTable get role {
    if (_role != null) return _role!;
    _role = _i1.createRelationTable(
      relationFieldName: 'role',
      field: Permission.t.roleId,
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
    roleId,
    resource,
    action,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'role') {
      return role;
    }
    return null;
  }
}

class PermissionInclude extends _i1.IncludeObject {
  PermissionInclude._({_i2.RoleInclude? role}) {
    _role = role;
  }

  _i2.RoleInclude? _role;

  @override
  Map<String, _i1.Include?> get includes => {'role': _role};

  @override
  _i1.Table<int?> get table => Permission.t;
}

class PermissionIncludeList extends _i1.IncludeList {
  PermissionIncludeList._({
    _i1.WhereExpressionBuilder<PermissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Permission.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Permission.t;
}

class PermissionRepository {
  const PermissionRepository._();

  final attachRow = const PermissionAttachRowRepository._();

  /// Returns a list of [Permission]s matching the given query parameters.
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
  Future<List<Permission>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PermissionTable>? orderByList,
    _i1.Transaction? transaction,
    PermissionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Permission>(
      where: where?.call(Permission.t),
      orderBy: orderBy?.call(Permission.t),
      orderByList: orderByList?.call(Permission.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Permission] matching the given query parameters.
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
  Future<Permission?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PermissionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PermissionTable>? orderByList,
    _i1.Transaction? transaction,
    PermissionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Permission>(
      where: where?.call(Permission.t),
      orderBy: orderBy?.call(Permission.t),
      orderByList: orderByList?.call(Permission.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Permission] by its [id] or null if no such row exists.
  Future<Permission?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    PermissionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Permission>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Permission]s in the list and returns the inserted rows.
  ///
  /// The returned [Permission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Permission>> insert(
    _i1.DatabaseSession session,
    List<Permission> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Permission>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Permission] and returns the inserted row.
  ///
  /// The returned [Permission] will have its `id` field set.
  Future<Permission> insertRow(
    _i1.DatabaseSession session,
    Permission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Permission>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Permission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Permission>> update(
    _i1.DatabaseSession session,
    List<Permission> rows, {
    _i1.ColumnSelections<PermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Permission>(
      rows,
      columns: columns?.call(Permission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Permission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Permission> updateRow(
    _i1.DatabaseSession session,
    Permission row, {
    _i1.ColumnSelections<PermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Permission>(
      row,
      columns: columns?.call(Permission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Permission] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Permission?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PermissionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Permission>(
      id,
      columnValues: columnValues(Permission.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Permission]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Permission>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PermissionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PermissionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PermissionTable>? orderBy,
    _i1.OrderByListBuilder<PermissionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Permission>(
      columnValues: columnValues(Permission.t.updateTable),
      where: where(Permission.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Permission.t),
      orderByList: orderByList?.call(Permission.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Permission]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Permission>> delete(
    _i1.DatabaseSession session,
    List<Permission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Permission>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Permission].
  Future<Permission> deleteRow(
    _i1.DatabaseSession session,
    Permission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Permission>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Permission>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PermissionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Permission>(
      where: where(Permission.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PermissionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Permission>(
      where: where?.call(Permission.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Permission] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PermissionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Permission>(
      where: where(Permission.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PermissionAttachRowRepository {
  const PermissionAttachRowRepository._();

  /// Creates a relation between the given [Permission] and [Role]
  /// by setting the [Permission]'s foreign key `roleId` to refer to the [Role].
  Future<void> role(
    _i1.DatabaseSession session,
    Permission permission,
    _i2.Role role, {
    _i1.Transaction? transaction,
  }) async {
    if (permission.id == null) {
      throw ArgumentError.notNull('permission.id');
    }
    if (role.id == null) {
      throw ArgumentError.notNull('role.id');
    }

    var $permission = permission.copyWith(roleId: role.id);
    await session.db.updateRow<Permission>(
      $permission,
      columns: [Permission.t.roleId],
      transaction: transaction,
    );
  }
}
