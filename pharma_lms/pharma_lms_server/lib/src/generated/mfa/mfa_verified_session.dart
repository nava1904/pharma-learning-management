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

/// Tracks MFA verification for a session. Used to allow access after TOTP verification.
abstract class MfaVerifiedSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MfaVerifiedSession._({
    this.id,
    required this.authUserId,
    required this.sessionId,
    DateTime? verifiedAt,
  }) : verifiedAt = verifiedAt ?? DateTime.now();

  factory MfaVerifiedSession({
    int? id,
    required String authUserId,
    required String sessionId,
    DateTime? verifiedAt,
  }) = _MfaVerifiedSessionImpl;

  factory MfaVerifiedSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return MfaVerifiedSession(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      sessionId: jsonSerialization['sessionId'] as String,
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
    );
  }

  static final t = MfaVerifiedSessionTable();

  static const db = MfaVerifiedSessionRepository._();

  @override
  int? id;

  /// Serverpod auth user ID (UUID).
  String authUserId;

  /// Session identifier (e.g. JWT jti or device fingerprint).
  String sessionId;

  /// When TOTP was verified.
  DateTime verifiedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MfaVerifiedSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MfaVerifiedSession copyWith({
    int? id,
    String? authUserId,
    String? sessionId,
    DateTime? verifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MfaVerifiedSession',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'sessionId': sessionId,
      'verifiedAt': verifiedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MfaVerifiedSession',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'sessionId': sessionId,
      'verifiedAt': verifiedAt.toJson(),
    };
  }

  static MfaVerifiedSessionInclude include() {
    return MfaVerifiedSessionInclude._();
  }

  static MfaVerifiedSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<MfaVerifiedSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MfaVerifiedSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MfaVerifiedSessionTable>? orderByList,
    MfaVerifiedSessionInclude? include,
  }) {
    return MfaVerifiedSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MfaVerifiedSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MfaVerifiedSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MfaVerifiedSessionImpl extends MfaVerifiedSession {
  _MfaVerifiedSessionImpl({
    int? id,
    required String authUserId,
    required String sessionId,
    DateTime? verifiedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         sessionId: sessionId,
         verifiedAt: verifiedAt,
       );

  /// Returns a shallow copy of this [MfaVerifiedSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MfaVerifiedSession copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? sessionId,
    DateTime? verifiedAt,
  }) {
    return MfaVerifiedSession(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      sessionId: sessionId ?? this.sessionId,
      verifiedAt: verifiedAt ?? this.verifiedAt,
    );
  }
}

class MfaVerifiedSessionUpdateTable
    extends _i1.UpdateTable<MfaVerifiedSessionTable> {
  MfaVerifiedSessionUpdateTable(super.table);

  _i1.ColumnValue<String, String> authUserId(String value) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> verifiedAt(DateTime value) =>
      _i1.ColumnValue(
        table.verifiedAt,
        value,
      );
}

class MfaVerifiedSessionTable extends _i1.Table<int?> {
  MfaVerifiedSessionTable({super.tableRelation})
    : super(tableName: 'mfa_verified_session') {
    updateTable = MfaVerifiedSessionUpdateTable(this);
    authUserId = _i1.ColumnString(
      'authUserId',
      this,
    );
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    verifiedAt = _i1.ColumnDateTime(
      'verifiedAt',
      this,
      hasDefault: true,
    );
  }

  late final MfaVerifiedSessionUpdateTable updateTable;

  /// Serverpod auth user ID (UUID).
  late final _i1.ColumnString authUserId;

  /// Session identifier (e.g. JWT jti or device fingerprint).
  late final _i1.ColumnString sessionId;

  /// When TOTP was verified.
  late final _i1.ColumnDateTime verifiedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    sessionId,
    verifiedAt,
  ];
}

class MfaVerifiedSessionInclude extends _i1.IncludeObject {
  MfaVerifiedSessionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MfaVerifiedSession.t;
}

class MfaVerifiedSessionIncludeList extends _i1.IncludeList {
  MfaVerifiedSessionIncludeList._({
    _i1.WhereExpressionBuilder<MfaVerifiedSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MfaVerifiedSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MfaVerifiedSession.t;
}

class MfaVerifiedSessionRepository {
  const MfaVerifiedSessionRepository._();

  /// Returns a list of [MfaVerifiedSession]s matching the given query parameters.
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
  Future<List<MfaVerifiedSession>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MfaVerifiedSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MfaVerifiedSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MfaVerifiedSessionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MfaVerifiedSession>(
      where: where?.call(MfaVerifiedSession.t),
      orderBy: orderBy?.call(MfaVerifiedSession.t),
      orderByList: orderByList?.call(MfaVerifiedSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MfaVerifiedSession] matching the given query parameters.
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
  Future<MfaVerifiedSession?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MfaVerifiedSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<MfaVerifiedSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MfaVerifiedSessionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MfaVerifiedSession>(
      where: where?.call(MfaVerifiedSession.t),
      orderBy: orderBy?.call(MfaVerifiedSession.t),
      orderByList: orderByList?.call(MfaVerifiedSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MfaVerifiedSession] by its [id] or null if no such row exists.
  Future<MfaVerifiedSession?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MfaVerifiedSession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MfaVerifiedSession]s in the list and returns the inserted rows.
  ///
  /// The returned [MfaVerifiedSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MfaVerifiedSession>> insert(
    _i1.DatabaseSession session,
    List<MfaVerifiedSession> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MfaVerifiedSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MfaVerifiedSession] and returns the inserted row.
  ///
  /// The returned [MfaVerifiedSession] will have its `id` field set.
  Future<MfaVerifiedSession> insertRow(
    _i1.DatabaseSession session,
    MfaVerifiedSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MfaVerifiedSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MfaVerifiedSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MfaVerifiedSession>> update(
    _i1.DatabaseSession session,
    List<MfaVerifiedSession> rows, {
    _i1.ColumnSelections<MfaVerifiedSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MfaVerifiedSession>(
      rows,
      columns: columns?.call(MfaVerifiedSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MfaVerifiedSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MfaVerifiedSession> updateRow(
    _i1.DatabaseSession session,
    MfaVerifiedSession row, {
    _i1.ColumnSelections<MfaVerifiedSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MfaVerifiedSession>(
      row,
      columns: columns?.call(MfaVerifiedSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MfaVerifiedSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MfaVerifiedSession?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MfaVerifiedSessionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MfaVerifiedSession>(
      id,
      columnValues: columnValues(MfaVerifiedSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MfaVerifiedSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MfaVerifiedSession>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MfaVerifiedSessionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<MfaVerifiedSessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MfaVerifiedSessionTable>? orderBy,
    _i1.OrderByListBuilder<MfaVerifiedSessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MfaVerifiedSession>(
      columnValues: columnValues(MfaVerifiedSession.t.updateTable),
      where: where(MfaVerifiedSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MfaVerifiedSession.t),
      orderByList: orderByList?.call(MfaVerifiedSession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MfaVerifiedSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MfaVerifiedSession>> delete(
    _i1.DatabaseSession session,
    List<MfaVerifiedSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MfaVerifiedSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MfaVerifiedSession].
  Future<MfaVerifiedSession> deleteRow(
    _i1.DatabaseSession session,
    MfaVerifiedSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MfaVerifiedSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MfaVerifiedSession>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MfaVerifiedSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MfaVerifiedSession>(
      where: where(MfaVerifiedSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MfaVerifiedSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MfaVerifiedSession>(
      where: where?.call(MfaVerifiedSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MfaVerifiedSession] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MfaVerifiedSessionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MfaVerifiedSession>(
      where: where(MfaVerifiedSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
