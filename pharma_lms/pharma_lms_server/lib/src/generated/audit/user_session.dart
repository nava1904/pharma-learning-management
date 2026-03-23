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

/// User session for login tracking. FDA 21 CFR Part 11.
abstract class UserSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserSession._({
    this.id,
    required this.userId,
    this.user,
    DateTime? startedAt,
    this.endedAt,
    this.ipAddress,
    this.userAgent,
    this.deviceFingerprint,
    this.endReason,
    bool? isMfaVerified,
  }) : startedAt = startedAt ?? DateTime.now(),
       isMfaVerified = isMfaVerified ?? false;

  factory UserSession({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? ipAddress,
    String? userAgent,
    String? deviceFingerprint,
    String? endReason,
    bool? isMfaVerified,
  }) = _UserSessionImpl;

  factory UserSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      deviceFingerprint: jsonSerialization['deviceFingerprint'] as String?,
      endReason: jsonSerialization['endReason'] as String?,
      isMfaVerified: jsonSerialization['isMfaVerified'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMfaVerified']),
    );
  }

  static final t = UserSessionTable();

  static const db = UserSessionRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  /// When session started.
  DateTime startedAt;

  /// When session ended.
  DateTime? endedAt;

  /// IP address at login.
  String? ipAddress;

  /// User agent string.
  String? userAgent;

  /// Device fingerprint.
  String? deviceFingerprint;

  /// How session ended: manual_logout, timeout, admin_revoke.
  String? endReason;

  /// Whether MFA was verified.
  bool isMfaVerified;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSession copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? ipAddress,
    String? userAgent,
    String? deviceFingerprint,
    String? endReason,
    bool? isMfaVerified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSession',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (deviceFingerprint != null) 'deviceFingerprint': deviceFingerprint,
      if (endReason != null) 'endReason': endReason,
      'isMfaVerified': isMfaVerified,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserSession',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (deviceFingerprint != null) 'deviceFingerprint': deviceFingerprint,
      if (endReason != null) 'endReason': endReason,
      'isMfaVerified': isMfaVerified,
    };
  }

  static UserSessionInclude include({_i2.PharmaUserInclude? user}) {
    return UserSessionInclude._(user: user);
  }

  static UserSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<UserSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSessionTable>? orderByList,
    UserSessionInclude? include,
  }) {
    return UserSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSessionImpl extends UserSession {
  _UserSessionImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? ipAddress,
    String? userAgent,
    String? deviceFingerprint,
    String? endReason,
    bool? isMfaVerified,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         startedAt: startedAt,
         endedAt: endedAt,
         ipAddress: ipAddress,
         userAgent: userAgent,
         deviceFingerprint: deviceFingerprint,
         endReason: endReason,
         isMfaVerified: isMfaVerified,
       );

  /// Returns a shallow copy of this [UserSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSession copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    Object? deviceFingerprint = _Undefined,
    Object? endReason = _Undefined,
    bool? isMfaVerified,
  }) {
    return UserSession(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      deviceFingerprint: deviceFingerprint is String?
          ? deviceFingerprint
          : this.deviceFingerprint,
      endReason: endReason is String? ? endReason : this.endReason,
      isMfaVerified: isMfaVerified ?? this.isMfaVerified,
    );
  }
}

class UserSessionUpdateTable extends _i1.UpdateTable<UserSessionTable> {
  UserSessionUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.endedAt,
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

  _i1.ColumnValue<String, String> deviceFingerprint(String? value) =>
      _i1.ColumnValue(
        table.deviceFingerprint,
        value,
      );

  _i1.ColumnValue<String, String> endReason(String? value) => _i1.ColumnValue(
    table.endReason,
    value,
  );

  _i1.ColumnValue<bool, bool> isMfaVerified(bool value) => _i1.ColumnValue(
    table.isMfaVerified,
    value,
  );
}

class UserSessionTable extends _i1.Table<int?> {
  UserSessionTable({super.tableRelation}) : super(tableName: 'user_session') {
    updateTable = UserSessionUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
      hasDefault: true,
    );
    endedAt = _i1.ColumnDateTime(
      'endedAt',
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
    deviceFingerprint = _i1.ColumnString(
      'deviceFingerprint',
      this,
    );
    endReason = _i1.ColumnString(
      'endReason',
      this,
    );
    isMfaVerified = _i1.ColumnBool(
      'isMfaVerified',
      this,
      hasDefault: true,
    );
  }

  late final UserSessionUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  /// When session started.
  late final _i1.ColumnDateTime startedAt;

  /// When session ended.
  late final _i1.ColumnDateTime endedAt;

  /// IP address at login.
  late final _i1.ColumnString ipAddress;

  /// User agent string.
  late final _i1.ColumnString userAgent;

  /// Device fingerprint.
  late final _i1.ColumnString deviceFingerprint;

  /// How session ended: manual_logout, timeout, admin_revoke.
  late final _i1.ColumnString endReason;

  /// Whether MFA was verified.
  late final _i1.ColumnBool isMfaVerified;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: UserSession.t.userId,
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
    startedAt,
    endedAt,
    ipAddress,
    userAgent,
    deviceFingerprint,
    endReason,
    isMfaVerified,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class UserSessionInclude extends _i1.IncludeObject {
  UserSessionInclude._({_i2.PharmaUserInclude? user}) {
    _user = user;
  }

  _i2.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => UserSession.t;
}

class UserSessionIncludeList extends _i1.IncludeList {
  UserSessionIncludeList._({
    _i1.WhereExpressionBuilder<UserSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserSession.t;
}

class UserSessionRepository {
  const UserSessionRepository._();

  final attachRow = const UserSessionAttachRowRepository._();

  /// Returns a list of [UserSession]s matching the given query parameters.
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
  Future<List<UserSession>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSessionTable>? orderByList,
    _i1.Transaction? transaction,
    UserSessionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserSession>(
      where: where?.call(UserSession.t),
      orderBy: orderBy?.call(UserSession.t),
      orderByList: orderByList?.call(UserSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserSession] matching the given query parameters.
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
  Future<UserSession?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSessionTable>? orderByList,
    _i1.Transaction? transaction,
    UserSessionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserSession>(
      where: where?.call(UserSession.t),
      orderBy: orderBy?.call(UserSession.t),
      orderByList: orderByList?.call(UserSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserSession] by its [id] or null if no such row exists.
  Future<UserSession?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    UserSessionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserSession>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserSession]s in the list and returns the inserted rows.
  ///
  /// The returned [UserSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserSession>> insert(
    _i1.DatabaseSession session,
    List<UserSession> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserSession] and returns the inserted row.
  ///
  /// The returned [UserSession] will have its `id` field set.
  Future<UserSession> insertRow(
    _i1.DatabaseSession session,
    UserSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserSession>> update(
    _i1.DatabaseSession session,
    List<UserSession> rows, {
    _i1.ColumnSelections<UserSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserSession>(
      rows,
      columns: columns?.call(UserSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserSession> updateRow(
    _i1.DatabaseSession session,
    UserSession row, {
    _i1.ColumnSelections<UserSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserSession>(
      row,
      columns: columns?.call(UserSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserSession?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserSessionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserSession>(
      id,
      columnValues: columnValues(UserSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserSession>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserSessionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserSessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSessionTable>? orderBy,
    _i1.OrderByListBuilder<UserSessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserSession>(
      columnValues: columnValues(UserSession.t.updateTable),
      where: where(UserSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSession.t),
      orderByList: orderByList?.call(UserSession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserSession>> delete(
    _i1.DatabaseSession session,
    List<UserSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserSession].
  Future<UserSession> deleteRow(
    _i1.DatabaseSession session,
    UserSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserSession>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserSession>(
      where: where(UserSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserSession>(
      where: where?.call(UserSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserSession] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserSessionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserSession>(
      where: where(UserSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserSessionAttachRowRepository {
  const UserSessionAttachRowRepository._();

  /// Creates a relation between the given [UserSession] and [PharmaUser]
  /// by setting the [UserSession]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    UserSession userSession,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (userSession.id == null) {
      throw ArgumentError.notNull('userSession.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userSession = userSession.copyWith(userId: user.id);
    await session.db.updateRow<UserSession>(
      $userSession,
      columns: [UserSession.t.userId],
      transaction: transaction,
    );
  }
}
