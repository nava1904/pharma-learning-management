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
import '../organization/user.dart' as _i2;
import '../organization/role.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Links users to RBAC roles (many-to-many).
abstract class UserRole
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserRole._({
    this.id,
    required this.userId,
    this.user,
    required this.roleId,
    this.role,
  });

  factory UserRole({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
  }) = _UserRoleImpl;

  factory UserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRole(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Role>(jsonSerialization['role']),
    );
  }

  static final t = UserRoleTable();

  static const db = UserRoleRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int roleId;

  /// The role assigned.
  _i3.Role? role;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRole copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? roleId,
    _i3.Role? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJsonForProtocol(),
    };
  }

  static UserRoleInclude include({
    _i2.PharmaUserInclude? user,
    _i3.RoleInclude? role,
  }) {
    return UserRoleInclude._(
      user: user,
      role: role,
    );
  }

  static UserRoleIncludeList includeList({
    _i1.WhereExpressionBuilder<UserRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoleTable>? orderByList,
    UserRoleInclude? include,
  }) {
    return UserRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRole.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoleImpl extends UserRole {
  _UserRoleImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         roleId: roleId,
         role: role,
       );

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRole copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? roleId,
    Object? role = _Undefined,
  }) {
    return UserRole(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      roleId: roleId ?? this.roleId,
      role: role is _i3.Role? ? role : this.role?.copyWith(),
    );
  }
}

class UserRoleUpdateTable extends _i1.UpdateTable<UserRoleTable> {
  UserRoleUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> roleId(int value) => _i1.ColumnValue(
    table.roleId,
    value,
  );
}

class UserRoleTable extends _i1.Table<int?> {
  UserRoleTable({super.tableRelation}) : super(tableName: 'user_role') {
    updateTable = UserRoleUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
  }

  late final UserRoleUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt roleId;

  /// The role assigned.
  _i3.RoleTable? _role;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: UserRole.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.RoleTable get role {
    if (_role != null) return _role!;
    _role = _i1.createRelationTable(
      relationFieldName: 'role',
      field: UserRole.t.roleId,
      foreignField: _i3.Role.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RoleTable(tableRelation: foreignTableRelation),
    );
    return _role!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    roleId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'role') {
      return role;
    }
    return null;
  }
}

class UserRoleInclude extends _i1.IncludeObject {
  UserRoleInclude._({
    _i2.PharmaUserInclude? user,
    _i3.RoleInclude? role,
  }) {
    _user = user;
    _role = role;
  }

  _i2.PharmaUserInclude? _user;

  _i3.RoleInclude? _role;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'role': _role,
  };

  @override
  _i1.Table<int?> get table => UserRole.t;
}

class UserRoleIncludeList extends _i1.IncludeList {
  UserRoleIncludeList._({
    _i1.WhereExpressionBuilder<UserRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRole.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserRole.t;
}

class UserRoleRepository {
  const UserRoleRepository._();

  final attachRow = const UserRoleAttachRowRepository._();

  /// Returns a list of [UserRole]s matching the given query parameters.
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
  Future<List<UserRole>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoleTable>? orderByList,
    _i1.Transaction? transaction,
    UserRoleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserRole>(
      where: where?.call(UserRole.t),
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserRole] matching the given query parameters.
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
  Future<UserRole?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserRoleTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoleTable>? orderByList,
    _i1.Transaction? transaction,
    UserRoleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserRole>(
      where: where?.call(UserRole.t),
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserRole] by its [id] or null if no such row exists.
  Future<UserRole?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserRoleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserRole>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserRole]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserRole>> insert(
    _i1.Session session,
    List<UserRole> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserRole] and returns the inserted row.
  ///
  /// The returned [UserRole] will have its `id` field set.
  Future<UserRole> insertRow(
    _i1.Session session,
    UserRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRole>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserRole>> update(
    _i1.Session session,
    List<UserRole> rows, {
    _i1.ColumnSelections<UserRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserRole>(
      rows,
      columns: columns?.call(UserRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRole> updateRow(
    _i1.Session session,
    UserRole row, {
    _i1.ColumnSelections<UserRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRole>(
      row,
      columns: columns?.call(UserRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRole?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserRoleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRole>(
      id,
      columnValues: columnValues(UserRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserRole>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserRoleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserRoleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoleTable>? orderBy,
    _i1.OrderByListBuilder<UserRoleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserRole>(
      columnValues: columnValues(UserRole.t.updateTable),
      where: where(UserRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserRole]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserRole>> delete(
    _i1.Session session,
    List<UserRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserRole].
  Future<UserRole> deleteRow(
    _i1.Session session,
    UserRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRole>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserRole>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserRoleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserRole>(
      where: where(UserRole.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserRoleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserRole>(
      where: where?.call(UserRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserRole] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserRoleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserRole>(
      where: where(UserRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserRoleAttachRowRepository {
  const UserRoleAttachRowRepository._();

  /// Creates a relation between the given [UserRole] and [PharmaUser]
  /// by setting the [UserRole]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    UserRole userRole,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (userRole.id == null) {
      throw ArgumentError.notNull('userRole.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userRole = userRole.copyWith(userId: user.id);
    await session.db.updateRow<UserRole>(
      $userRole,
      columns: [UserRole.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [UserRole] and [Role]
  /// by setting the [UserRole]'s foreign key `roleId` to refer to the [Role].
  Future<void> role(
    _i1.Session session,
    UserRole userRole,
    _i3.Role role, {
    _i1.Transaction? transaction,
  }) async {
    if (userRole.id == null) {
      throw ArgumentError.notNull('userRole.id');
    }
    if (role.id == null) {
      throw ArgumentError.notNull('role.id');
    }

    var $userRole = userRole.copyWith(roleId: role.id);
    await session.db.updateRow<UserRole>(
      $userRole,
      columns: [UserRole.t.roleId],
      transaction: transaction,
    );
  }
}
