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

/// Append-only role history for revocations and grants
abstract class RoleHistory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RoleHistory._({
    this.id,
    required this.userId,
    this.user,
    required this.roleId,
    this.role,
    required this.action,
    DateTime? timestamp,
    this.performedById,
    this.performedBy,
    this.reason,
    this.grantRecordId,
    this.ipAddress,
    this.hmacHash,
    this.migrationMarker,
  }) : timestamp = timestamp ?? DateTime.now();

  factory RoleHistory({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    required String action,
    DateTime? timestamp,
    int? performedById,
    _i2.PharmaUser? performedBy,
    String? reason,
    int? grantRecordId,
    String? ipAddress,
    String? hmacHash,
    String? migrationMarker,
  }) = _RoleHistoryImpl;

  factory RoleHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoleHistory(
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
      action: jsonSerialization['action'] as String,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      performedById: jsonSerialization['performedById'] as int?,
      performedBy: jsonSerialization['performedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['performedBy'],
            ),
      reason: jsonSerialization['reason'] as String?,
      grantRecordId: jsonSerialization['grantRecordId'] as int?,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      hmacHash: jsonSerialization['hmacHash'] as String?,
      migrationMarker: jsonSerialization['migrationMarker'] as String?,
    );
  }

  static final t = RoleHistoryTable();

  static const db = RoleHistoryRepository._();

  @override
  int? id;

  int userId;

  /// The user affected
  _i2.PharmaUser? user;

  int roleId;

  /// The role affected
  _i3.Role? role;

  /// Action (GRANTED, REVOKED)
  String action;

  /// Timestamp of the action
  DateTime timestamp;

  int? performedById;

  /// Who performed the action (admin or SYSTEM)
  _i2.PharmaUser? performedBy;

  /// Reason for the action
  String? reason;

  /// Original grant record ID (for revocations)
  int? grantRecordId;

  /// IP address
  String? ipAddress;

  /// HMAC hash for audit chain
  String? hmacHash;

  /// Temporary migration marker - remove after migration applied
  String? migrationMarker;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoleHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoleHistory copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? roleId,
    _i3.Role? role,
    String? action,
    DateTime? timestamp,
    int? performedById,
    _i2.PharmaUser? performedBy,
    String? reason,
    int? grantRecordId,
    String? ipAddress,
    String? hmacHash,
    String? migrationMarker,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoleHistory',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
      'action': action,
      'timestamp': timestamp.toJson(),
      if (performedById != null) 'performedById': performedById,
      if (performedBy != null) 'performedBy': performedBy?.toJson(),
      if (reason != null) 'reason': reason,
      if (grantRecordId != null) 'grantRecordId': grantRecordId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (hmacHash != null) 'hmacHash': hmacHash,
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoleHistory',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJsonForProtocol(),
      'action': action,
      'timestamp': timestamp.toJson(),
      if (performedById != null) 'performedById': performedById,
      if (performedBy != null) 'performedBy': performedBy?.toJsonForProtocol(),
      if (reason != null) 'reason': reason,
      if (grantRecordId != null) 'grantRecordId': grantRecordId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (hmacHash != null) 'hmacHash': hmacHash,
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  static RoleHistoryInclude include({
    _i2.PharmaUserInclude? user,
    _i3.RoleInclude? role,
    _i2.PharmaUserInclude? performedBy,
  }) {
    return RoleHistoryInclude._(
      user: user,
      role: role,
      performedBy: performedBy,
    );
  }

  static RoleHistoryIncludeList includeList({
    _i1.WhereExpressionBuilder<RoleHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoleHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoleHistoryTable>? orderByList,
    RoleHistoryInclude? include,
  }) {
    return RoleHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoleHistory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoleHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoleHistoryImpl extends RoleHistory {
  _RoleHistoryImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    required String action,
    DateTime? timestamp,
    int? performedById,
    _i2.PharmaUser? performedBy,
    String? reason,
    int? grantRecordId,
    String? ipAddress,
    String? hmacHash,
    String? migrationMarker,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         roleId: roleId,
         role: role,
         action: action,
         timestamp: timestamp,
         performedById: performedById,
         performedBy: performedBy,
         reason: reason,
         grantRecordId: grantRecordId,
         ipAddress: ipAddress,
         hmacHash: hmacHash,
         migrationMarker: migrationMarker,
       );

  /// Returns a shallow copy of this [RoleHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoleHistory copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? roleId,
    Object? role = _Undefined,
    String? action,
    DateTime? timestamp,
    Object? performedById = _Undefined,
    Object? performedBy = _Undefined,
    Object? reason = _Undefined,
    Object? grantRecordId = _Undefined,
    Object? ipAddress = _Undefined,
    Object? hmacHash = _Undefined,
    Object? migrationMarker = _Undefined,
  }) {
    return RoleHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      roleId: roleId ?? this.roleId,
      role: role is _i3.Role? ? role : this.role?.copyWith(),
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      performedById: performedById is int? ? performedById : this.performedById,
      performedBy: performedBy is _i2.PharmaUser?
          ? performedBy
          : this.performedBy?.copyWith(),
      reason: reason is String? ? reason : this.reason,
      grantRecordId: grantRecordId is int? ? grantRecordId : this.grantRecordId,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      hmacHash: hmacHash is String? ? hmacHash : this.hmacHash,
      migrationMarker: migrationMarker is String?
          ? migrationMarker
          : this.migrationMarker,
    );
  }
}

class RoleHistoryUpdateTable extends _i1.UpdateTable<RoleHistoryTable> {
  RoleHistoryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> roleId(int value) => _i1.ColumnValue(
    table.roleId,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<int, int> performedById(int? value) => _i1.ColumnValue(
    table.performedById,
    value,
  );

  _i1.ColumnValue<String, String> reason(String? value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<int, int> grantRecordId(int? value) => _i1.ColumnValue(
    table.grantRecordId,
    value,
  );

  _i1.ColumnValue<String, String> ipAddress(String? value) => _i1.ColumnValue(
    table.ipAddress,
    value,
  );

  _i1.ColumnValue<String, String> hmacHash(String? value) => _i1.ColumnValue(
    table.hmacHash,
    value,
  );

  _i1.ColumnValue<String, String> migrationMarker(String? value) =>
      _i1.ColumnValue(
        table.migrationMarker,
        value,
      );
}

class RoleHistoryTable extends _i1.Table<int?> {
  RoleHistoryTable({super.tableRelation}) : super(tableName: 'role_history') {
    updateTable = RoleHistoryUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
    performedById = _i1.ColumnInt(
      'performedById',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    grantRecordId = _i1.ColumnInt(
      'grantRecordId',
      this,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
      this,
    );
    hmacHash = _i1.ColumnString(
      'hmacHash',
      this,
    );
    migrationMarker = _i1.ColumnString(
      'migrationMarker',
      this,
    );
  }

  late final RoleHistoryUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user affected
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt roleId;

  /// The role affected
  _i3.RoleTable? _role;

  /// Action (GRANTED, REVOKED)
  late final _i1.ColumnString action;

  /// Timestamp of the action
  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnInt performedById;

  /// Who performed the action (admin or SYSTEM)
  _i2.PharmaUserTable? _performedBy;

  /// Reason for the action
  late final _i1.ColumnString reason;

  /// Original grant record ID (for revocations)
  late final _i1.ColumnInt grantRecordId;

  /// IP address
  late final _i1.ColumnString ipAddress;

  /// HMAC hash for audit chain
  late final _i1.ColumnString hmacHash;

  /// Temporary migration marker - remove after migration applied
  late final _i1.ColumnString migrationMarker;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: RoleHistory.t.userId,
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
      field: RoleHistory.t.roleId,
      foreignField: _i3.Role.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RoleTable(tableRelation: foreignTableRelation),
    );
    return _role!;
  }

  _i2.PharmaUserTable get performedBy {
    if (_performedBy != null) return _performedBy!;
    _performedBy = _i1.createRelationTable(
      relationFieldName: 'performedBy',
      field: RoleHistory.t.performedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _performedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    roleId,
    action,
    timestamp,
    performedById,
    reason,
    grantRecordId,
    ipAddress,
    hmacHash,
    migrationMarker,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'role') {
      return role;
    }
    if (relationField == 'performedBy') {
      return performedBy;
    }
    return null;
  }
}

class RoleHistoryInclude extends _i1.IncludeObject {
  RoleHistoryInclude._({
    _i2.PharmaUserInclude? user,
    _i3.RoleInclude? role,
    _i2.PharmaUserInclude? performedBy,
  }) {
    _user = user;
    _role = role;
    _performedBy = performedBy;
  }

  _i2.PharmaUserInclude? _user;

  _i3.RoleInclude? _role;

  _i2.PharmaUserInclude? _performedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'role': _role,
    'performedBy': _performedBy,
  };

  @override
  _i1.Table<int?> get table => RoleHistory.t;
}

class RoleHistoryIncludeList extends _i1.IncludeList {
  RoleHistoryIncludeList._({
    _i1.WhereExpressionBuilder<RoleHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoleHistory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RoleHistory.t;
}

class RoleHistoryRepository {
  const RoleHistoryRepository._();

  final attachRow = const RoleHistoryAttachRowRepository._();

  final detachRow = const RoleHistoryDetachRowRepository._();

  /// Returns a list of [RoleHistory]s matching the given query parameters.
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
  Future<List<RoleHistory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoleHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoleHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoleHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    RoleHistoryInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoleHistory>(
      where: where?.call(RoleHistory.t),
      orderBy: orderBy?.call(RoleHistory.t),
      orderByList: orderByList?.call(RoleHistory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoleHistory] matching the given query parameters.
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
  Future<RoleHistory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoleHistoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoleHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoleHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    RoleHistoryInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoleHistory>(
      where: where?.call(RoleHistory.t),
      orderBy: orderBy?.call(RoleHistory.t),
      orderByList: orderByList?.call(RoleHistory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoleHistory] by its [id] or null if no such row exists.
  Future<RoleHistory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    RoleHistoryInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoleHistory>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoleHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [RoleHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RoleHistory>> insert(
    _i1.DatabaseSession session,
    List<RoleHistory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RoleHistory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RoleHistory] and returns the inserted row.
  ///
  /// The returned [RoleHistory] will have its `id` field set.
  Future<RoleHistory> insertRow(
    _i1.DatabaseSession session,
    RoleHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoleHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RoleHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RoleHistory>> update(
    _i1.DatabaseSession session,
    List<RoleHistory> rows, {
    _i1.ColumnSelections<RoleHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoleHistory>(
      rows,
      columns: columns?.call(RoleHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoleHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoleHistory> updateRow(
    _i1.DatabaseSession session,
    RoleHistory row, {
    _i1.ColumnSelections<RoleHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoleHistory>(
      row,
      columns: columns?.call(RoleHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoleHistory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoleHistory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RoleHistoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RoleHistory>(
      id,
      columnValues: columnValues(RoleHistory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoleHistory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RoleHistory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RoleHistoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RoleHistoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoleHistoryTable>? orderBy,
    _i1.OrderByListBuilder<RoleHistoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RoleHistory>(
      columnValues: columnValues(RoleHistory.t.updateTable),
      where: where(RoleHistory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoleHistory.t),
      orderByList: orderByList?.call(RoleHistory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RoleHistory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RoleHistory>> delete(
    _i1.DatabaseSession session,
    List<RoleHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoleHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RoleHistory].
  Future<RoleHistory> deleteRow(
    _i1.DatabaseSession session,
    RoleHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoleHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RoleHistory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoleHistoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoleHistory>(
      where: where(RoleHistory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoleHistoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoleHistory>(
      where: where?.call(RoleHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoleHistory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoleHistoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoleHistory>(
      where: where(RoleHistory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RoleHistoryAttachRowRepository {
  const RoleHistoryAttachRowRepository._();

  /// Creates a relation between the given [RoleHistory] and [PharmaUser]
  /// by setting the [RoleHistory]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    RoleHistory roleHistory,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (roleHistory.id == null) {
      throw ArgumentError.notNull('roleHistory.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $roleHistory = roleHistory.copyWith(userId: user.id);
    await session.db.updateRow<RoleHistory>(
      $roleHistory,
      columns: [RoleHistory.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RoleHistory] and [Role]
  /// by setting the [RoleHistory]'s foreign key `roleId` to refer to the [Role].
  Future<void> role(
    _i1.DatabaseSession session,
    RoleHistory roleHistory,
    _i3.Role role, {
    _i1.Transaction? transaction,
  }) async {
    if (roleHistory.id == null) {
      throw ArgumentError.notNull('roleHistory.id');
    }
    if (role.id == null) {
      throw ArgumentError.notNull('role.id');
    }

    var $roleHistory = roleHistory.copyWith(roleId: role.id);
    await session.db.updateRow<RoleHistory>(
      $roleHistory,
      columns: [RoleHistory.t.roleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RoleHistory] and [PharmaUser]
  /// by setting the [RoleHistory]'s foreign key `performedById` to refer to the [PharmaUser].
  Future<void> performedBy(
    _i1.DatabaseSession session,
    RoleHistory roleHistory,
    _i2.PharmaUser performedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (roleHistory.id == null) {
      throw ArgumentError.notNull('roleHistory.id');
    }
    if (performedBy.id == null) {
      throw ArgumentError.notNull('performedBy.id');
    }

    var $roleHistory = roleHistory.copyWith(performedById: performedBy.id);
    await session.db.updateRow<RoleHistory>(
      $roleHistory,
      columns: [RoleHistory.t.performedById],
      transaction: transaction,
    );
  }
}

class RoleHistoryDetachRowRepository {
  const RoleHistoryDetachRowRepository._();

  /// Detaches the relation between this [RoleHistory] and the [PharmaUser] set in `performedBy`
  /// by setting the [RoleHistory]'s foreign key `performedById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> performedBy(
    _i1.DatabaseSession session,
    RoleHistory roleHistory, {
    _i1.Transaction? transaction,
  }) async {
    if (roleHistory.id == null) {
      throw ArgumentError.notNull('roleHistory.id');
    }

    var $roleHistory = roleHistory.copyWith(performedById: null);
    await session.db.updateRow<RoleHistory>(
      $roleHistory,
      columns: [RoleHistory.t.performedById],
      transaction: transaction,
    );
  }
}
