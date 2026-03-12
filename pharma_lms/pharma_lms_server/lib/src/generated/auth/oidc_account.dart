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

/// OIDC provider account. Links to serverpod auth user by UUID.
/// Supports Auth0, Okta, Azure AD via OIDC discovery.
abstract class OidcAccount
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OidcAccount._({
    this.id,
    required this.authUserId,
    required this.providerId,
    this.email,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OidcAccount({
    int? id,
    required String authUserId,
    required String providerId,
    String? email,
    DateTime? createdAt,
  }) = _OidcAccountImpl;

  factory OidcAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return OidcAccount(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      providerId: jsonSerialization['providerId'] as String,
      email: jsonSerialization['email'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OidcAccountTable();

  static const db = OidcAccountRepository._();

  @override
  int? id;

  /// Serverpod auth user ID (UUID).
  String authUserId;

  /// OIDC provider subject (sub claim).
  String providerId;

  /// User email from OIDC userinfo.
  String? email;

  /// Creation timestamp.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OidcAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OidcAccount copyWith({
    int? id,
    String? authUserId,
    String? providerId,
    String? email,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OidcAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'providerId': providerId,
      if (email != null) 'email': email,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OidcAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'providerId': providerId,
      if (email != null) 'email': email,
      'createdAt': createdAt.toJson(),
    };
  }

  static OidcAccountInclude include() {
    return OidcAccountInclude._();
  }

  static OidcAccountIncludeList includeList({
    _i1.WhereExpressionBuilder<OidcAccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OidcAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OidcAccountTable>? orderByList,
    OidcAccountInclude? include,
  }) {
    return OidcAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OidcAccount.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OidcAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OidcAccountImpl extends OidcAccount {
  _OidcAccountImpl({
    int? id,
    required String authUserId,
    required String providerId,
    String? email,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         providerId: providerId,
         email: email,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OidcAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OidcAccount copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? providerId,
    Object? email = _Undefined,
    DateTime? createdAt,
  }) {
    return OidcAccount(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      providerId: providerId ?? this.providerId,
      email: email is String? ? email : this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OidcAccountUpdateTable extends _i1.UpdateTable<OidcAccountTable> {
  OidcAccountUpdateTable(super.table);

  _i1.ColumnValue<String, String> authUserId(String value) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> providerId(String value) => _i1.ColumnValue(
    table.providerId,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class OidcAccountTable extends _i1.Table<int?> {
  OidcAccountTable({super.tableRelation}) : super(tableName: 'oidc_account') {
    updateTable = OidcAccountUpdateTable(this);
    authUserId = _i1.ColumnString(
      'authUserId',
      this,
    );
    providerId = _i1.ColumnString(
      'providerId',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final OidcAccountUpdateTable updateTable;

  /// Serverpod auth user ID (UUID).
  late final _i1.ColumnString authUserId;

  /// OIDC provider subject (sub claim).
  late final _i1.ColumnString providerId;

  /// User email from OIDC userinfo.
  late final _i1.ColumnString email;

  /// Creation timestamp.
  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    providerId,
    email,
    createdAt,
  ];
}

class OidcAccountInclude extends _i1.IncludeObject {
  OidcAccountInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OidcAccount.t;
}

class OidcAccountIncludeList extends _i1.IncludeList {
  OidcAccountIncludeList._({
    _i1.WhereExpressionBuilder<OidcAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OidcAccount.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OidcAccount.t;
}

class OidcAccountRepository {
  const OidcAccountRepository._();

  /// Returns a list of [OidcAccount]s matching the given query parameters.
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
  Future<List<OidcAccount>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OidcAccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OidcAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OidcAccountTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OidcAccount>(
      where: where?.call(OidcAccount.t),
      orderBy: orderBy?.call(OidcAccount.t),
      orderByList: orderByList?.call(OidcAccount.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OidcAccount] matching the given query parameters.
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
  Future<OidcAccount?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OidcAccountTable>? where,
    int? offset,
    _i1.OrderByBuilder<OidcAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OidcAccountTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OidcAccount>(
      where: where?.call(OidcAccount.t),
      orderBy: orderBy?.call(OidcAccount.t),
      orderByList: orderByList?.call(OidcAccount.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OidcAccount] by its [id] or null if no such row exists.
  Future<OidcAccount?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OidcAccount>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OidcAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [OidcAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OidcAccount>> insert(
    _i1.Session session,
    List<OidcAccount> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OidcAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OidcAccount] and returns the inserted row.
  ///
  /// The returned [OidcAccount] will have its `id` field set.
  Future<OidcAccount> insertRow(
    _i1.Session session,
    OidcAccount row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OidcAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OidcAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OidcAccount>> update(
    _i1.Session session,
    List<OidcAccount> rows, {
    _i1.ColumnSelections<OidcAccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OidcAccount>(
      rows,
      columns: columns?.call(OidcAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OidcAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OidcAccount> updateRow(
    _i1.Session session,
    OidcAccount row, {
    _i1.ColumnSelections<OidcAccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OidcAccount>(
      row,
      columns: columns?.call(OidcAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OidcAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OidcAccount?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OidcAccountUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OidcAccount>(
      id,
      columnValues: columnValues(OidcAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OidcAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OidcAccount>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OidcAccountUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OidcAccountTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OidcAccountTable>? orderBy,
    _i1.OrderByListBuilder<OidcAccountTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OidcAccount>(
      columnValues: columnValues(OidcAccount.t.updateTable),
      where: where(OidcAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OidcAccount.t),
      orderByList: orderByList?.call(OidcAccount.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OidcAccount]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OidcAccount>> delete(
    _i1.Session session,
    List<OidcAccount> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OidcAccount>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OidcAccount].
  Future<OidcAccount> deleteRow(
    _i1.Session session,
    OidcAccount row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OidcAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OidcAccount>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OidcAccountTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OidcAccount>(
      where: where(OidcAccount.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OidcAccountTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OidcAccount>(
      where: where?.call(OidcAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OidcAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OidcAccountTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OidcAccount>(
      where: where(OidcAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
