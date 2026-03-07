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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Access log for login, session, and access tracking.
abstract class AccessLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AccessLog._({
    this.id,
    this.userId,
    this.user,
    required this.action,
    this.ipAddress,
    this.userAgent,
    DateTime? timestamp,
    bool? success,
  }) : timestamp = timestamp ?? DateTime.now(),
       success = success ?? true;

  factory AccessLog({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    required String action,
    String? ipAddress,
    String? userAgent,
    DateTime? timestamp,
    bool? success,
  }) = _AccessLogImpl;

  factory AccessLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      action: jsonSerialization['action'] as String,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      success: jsonSerialization['success'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
    );
  }

  static final t = AccessLogTable();

  static const db = AccessLogRepository._();

  @override
  int? id;

  int? userId;

  /// User who accessed (nullable for failed login).
  _i2.PharmaUser? user;

  /// Action (login, logout, session_timeout).
  String action;

  /// IP address.
  String? ipAddress;

  /// User agent string.
  String? userAgent;

  /// Timestamp.
  DateTime timestamp;

  /// Whether the action succeeded.
  bool success;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessLog copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? action,
    String? ipAddress,
    String? userAgent,
    DateTime? timestamp,
    bool? success,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'action': action,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'timestamp': timestamp.toJson(),
      'success': success,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccessLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'action': action,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'timestamp': timestamp.toJson(),
      'success': success,
    };
  }

  static AccessLogInclude include({_i2.PharmaUserInclude? user}) {
    return AccessLogInclude._(user: user);
  }

  static AccessLogIncludeList includeList({
    _i1.WhereExpressionBuilder<AccessLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessLogTable>? orderByList,
    AccessLogInclude? include,
  }) {
    return AccessLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AccessLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessLogImpl extends AccessLog {
  _AccessLogImpl({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    required String action,
    String? ipAddress,
    String? userAgent,
    DateTime? timestamp,
    bool? success,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         action: action,
         ipAddress: ipAddress,
         userAgent: userAgent,
         timestamp: timestamp,
         success: success,
       );

  /// Returns a shallow copy of this [AccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    Object? user = _Undefined,
    String? action,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    DateTime? timestamp,
    bool? success,
  }) {
    return AccessLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      action: action ?? this.action,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      timestamp: timestamp ?? this.timestamp,
      success: success ?? this.success,
    );
  }
}

class AccessLogUpdateTable extends _i1.UpdateTable<AccessLogTable> {
  AccessLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> ipAddress(String? value) => _i1.ColumnValue(
    table.ipAddress,
    value,
  );

  _i1.ColumnValue<String, String> userAgent(String? value) => _i1.ColumnValue(
    table.userAgent,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<bool, bool> success(bool value) => _i1.ColumnValue(
    table.success,
    value,
  );
}

class AccessLogTable extends _i1.Table<int?> {
  AccessLogTable({super.tableRelation}) : super(tableName: 'access_log') {
    updateTable = AccessLogUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
      this,
    );
    userAgent = _i1.ColumnString(
      'userAgent',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
    success = _i1.ColumnBool(
      'success',
      this,
      hasDefault: true,
    );
  }

  late final AccessLogUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// User who accessed (nullable for failed login).
  _i2.PharmaUserTable? _user;

  /// Action (login, logout, session_timeout).
  late final _i1.ColumnString action;

  /// IP address.
  late final _i1.ColumnString ipAddress;

  /// User agent string.
  late final _i1.ColumnString userAgent;

  /// Timestamp.
  late final _i1.ColumnDateTime timestamp;

  /// Whether the action succeeded.
  late final _i1.ColumnBool success;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AccessLog.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    action,
    ipAddress,
    userAgent,
    timestamp,
    success,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class AccessLogInclude extends _i1.IncludeObject {
  AccessLogInclude._({_i2.PharmaUserInclude? user}) {
    _user = user;
  }

  _i2.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => AccessLog.t;
}

class AccessLogIncludeList extends _i1.IncludeList {
  AccessLogIncludeList._({
    _i1.WhereExpressionBuilder<AccessLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccessLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AccessLog.t;
}

class AccessLogRepository {
  const AccessLogRepository._();

  final attachRow = const AccessLogAttachRowRepository._();

  final detachRow = const AccessLogDetachRowRepository._();

  /// Returns a list of [AccessLog]s matching the given query parameters.
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
  Future<List<AccessLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccessLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessLogTable>? orderByList,
    _i1.Transaction? transaction,
    AccessLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AccessLog>(
      where: where?.call(AccessLog.t),
      orderBy: orderBy?.call(AccessLog.t),
      orderByList: orderByList?.call(AccessLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AccessLog] matching the given query parameters.
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
  Future<AccessLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccessLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccessLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessLogTable>? orderByList,
    _i1.Transaction? transaction,
    AccessLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AccessLog>(
      where: where?.call(AccessLog.t),
      orderBy: orderBy?.call(AccessLog.t),
      orderByList: orderByList?.call(AccessLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AccessLog] by its [id] or null if no such row exists.
  Future<AccessLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AccessLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AccessLog>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AccessLog]s in the list and returns the inserted rows.
  ///
  /// The returned [AccessLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AccessLog>> insert(
    _i1.Session session,
    List<AccessLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AccessLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AccessLog] and returns the inserted row.
  ///
  /// The returned [AccessLog] will have its `id` field set.
  Future<AccessLog> insertRow(
    _i1.Session session,
    AccessLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccessLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AccessLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AccessLog>> update(
    _i1.Session session,
    List<AccessLog> rows, {
    _i1.ColumnSelections<AccessLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AccessLog>(
      rows,
      columns: columns?.call(AccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccessLog> updateRow(
    _i1.Session session,
    AccessLog row, {
    _i1.ColumnSelections<AccessLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccessLog>(
      row,
      columns: columns?.call(AccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccessLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AccessLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AccessLog>(
      id,
      columnValues: columnValues(AccessLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccessLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AccessLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AccessLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AccessLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessLogTable>? orderBy,
    _i1.OrderByListBuilder<AccessLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AccessLog>(
      columnValues: columnValues(AccessLog.t.updateTable),
      where: where(AccessLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessLog.t),
      orderByList: orderByList?.call(AccessLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AccessLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AccessLog>> delete(
    _i1.Session session,
    List<AccessLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AccessLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AccessLog].
  Future<AccessLog> deleteRow(
    _i1.Session session,
    AccessLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccessLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AccessLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AccessLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AccessLog>(
      where: where(AccessLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccessLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AccessLog>(
      where: where?.call(AccessLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AccessLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AccessLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AccessLog>(
      where: where(AccessLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AccessLogAttachRowRepository {
  const AccessLogAttachRowRepository._();

  /// Creates a relation between the given [AccessLog] and [PharmaUser]
  /// by setting the [AccessLog]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    AccessLog accessLog,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (accessLog.id == null) {
      throw ArgumentError.notNull('accessLog.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $accessLog = accessLog.copyWith(userId: user.id);
    await session.db.updateRow<AccessLog>(
      $accessLog,
      columns: [AccessLog.t.userId],
      transaction: transaction,
    );
  }
}

class AccessLogDetachRowRepository {
  const AccessLogDetachRowRepository._();

  /// Detaches the relation between this [AccessLog] and the [PharmaUser] set in `user`
  /// by setting the [AccessLog]'s foreign key `userId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> user(
    _i1.Session session,
    AccessLog accessLog, {
    _i1.Transaction? transaction,
  }) async {
    if (accessLog.id == null) {
      throw ArgumentError.notNull('accessLog.id');
    }

    var $accessLog = accessLog.copyWith(userId: null);
    await session.db.updateRow<AccessLog>(
      $accessLog,
      columns: [AccessLog.t.userId],
      transaction: transaction,
    );
  }
}
