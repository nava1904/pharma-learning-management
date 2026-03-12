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

/// MFA settings for a user. Links to serverpod auth user by UUID.
abstract class UserMfa
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserMfa._({
    this.id,
    required this.authUserId,
    required this.mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  }) : mfaEnabled = mfaEnabled ?? false,
       enrolledAt = enrolledAt ?? DateTime.now();

  factory UserMfa({
    int? id,
    required String authUserId,
    required String mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  }) = _UserMfaImpl;

  factory UserMfa.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserMfa(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] as String,
      mfaSecretBase32: jsonSerialization['mfaSecretBase32'] as String,
      mfaEnabled: jsonSerialization['mfaEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['mfaEnabled']),
      enrolledAt: jsonSerialization['enrolledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['enrolledAt']),
    );
  }

  static final t = UserMfaTable();

  static const db = UserMfaRepository._();

  @override
  int? id;

  /// Serverpod auth user ID (UUID).
  String authUserId;

  /// Base32-encoded TOTP secret.
  String mfaSecretBase32;

  /// Whether MFA is enabled for this user.
  bool mfaEnabled;

  /// When MFA was enrolled.
  DateTime? enrolledAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserMfa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserMfa copyWith({
    int? id,
    String? authUserId,
    String? mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserMfa',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'mfaSecretBase32': mfaSecretBase32,
      'mfaEnabled': mfaEnabled,
      if (enrolledAt != null) 'enrolledAt': enrolledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserMfa',
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'mfaSecretBase32': mfaSecretBase32,
      'mfaEnabled': mfaEnabled,
      if (enrolledAt != null) 'enrolledAt': enrolledAt?.toJson(),
    };
  }

  static UserMfaInclude include() {
    return UserMfaInclude._();
  }

  static UserMfaIncludeList includeList({
    _i1.WhereExpressionBuilder<UserMfaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserMfaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserMfaTable>? orderByList,
    UserMfaInclude? include,
  }) {
    return UserMfaIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserMfa.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserMfa.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserMfaImpl extends UserMfa {
  _UserMfaImpl({
    int? id,
    required String authUserId,
    required String mfaSecretBase32,
    bool? mfaEnabled,
    DateTime? enrolledAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         mfaSecretBase32: mfaSecretBase32,
         mfaEnabled: mfaEnabled,
         enrolledAt: enrolledAt,
       );

  /// Returns a shallow copy of this [UserMfa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserMfa copyWith({
    Object? id = _Undefined,
    String? authUserId,
    String? mfaSecretBase32,
    bool? mfaEnabled,
    Object? enrolledAt = _Undefined,
  }) {
    return UserMfa(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      mfaSecretBase32: mfaSecretBase32 ?? this.mfaSecretBase32,
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      enrolledAt: enrolledAt is DateTime? ? enrolledAt : this.enrolledAt,
    );
  }
}

class UserMfaUpdateTable extends _i1.UpdateTable<UserMfaTable> {
  UserMfaUpdateTable(super.table);

  _i1.ColumnValue<String, String> authUserId(String value) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> mfaSecretBase32(String value) =>
      _i1.ColumnValue(
        table.mfaSecretBase32,
        value,
      );

  _i1.ColumnValue<bool, bool> mfaEnabled(bool value) => _i1.ColumnValue(
    table.mfaEnabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> enrolledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.enrolledAt,
        value,
      );
}

class UserMfaTable extends _i1.Table<int?> {
  UserMfaTable({super.tableRelation}) : super(tableName: 'user_mfa') {
    updateTable = UserMfaUpdateTable(this);
    authUserId = _i1.ColumnString(
      'authUserId',
      this,
    );
    mfaSecretBase32 = _i1.ColumnString(
      'mfaSecretBase32',
      this,
    );
    mfaEnabled = _i1.ColumnBool(
      'mfaEnabled',
      this,
      hasDefault: true,
    );
    enrolledAt = _i1.ColumnDateTime(
      'enrolledAt',
      this,
      hasDefault: true,
    );
  }

  late final UserMfaUpdateTable updateTable;

  /// Serverpod auth user ID (UUID).
  late final _i1.ColumnString authUserId;

  /// Base32-encoded TOTP secret.
  late final _i1.ColumnString mfaSecretBase32;

  /// Whether MFA is enabled for this user.
  late final _i1.ColumnBool mfaEnabled;

  /// When MFA was enrolled.
  late final _i1.ColumnDateTime enrolledAt;

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    mfaSecretBase32,
    mfaEnabled,
    enrolledAt,
  ];
}

class UserMfaInclude extends _i1.IncludeObject {
  UserMfaInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserMfa.t;
}

class UserMfaIncludeList extends _i1.IncludeList {
  UserMfaIncludeList._({
    _i1.WhereExpressionBuilder<UserMfaTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserMfa.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserMfa.t;
}

class UserMfaRepository {
  const UserMfaRepository._();

  /// Returns a list of [UserMfa]s matching the given query parameters.
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
  Future<List<UserMfa>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserMfaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserMfaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserMfaTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserMfa>(
      where: where?.call(UserMfa.t),
      orderBy: orderBy?.call(UserMfa.t),
      orderByList: orderByList?.call(UserMfa.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserMfa] matching the given query parameters.
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
  Future<UserMfa?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserMfaTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserMfaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserMfaTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserMfa>(
      where: where?.call(UserMfa.t),
      orderBy: orderBy?.call(UserMfa.t),
      orderByList: orderByList?.call(UserMfa.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserMfa] by its [id] or null if no such row exists.
  Future<UserMfa?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserMfa>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserMfa]s in the list and returns the inserted rows.
  ///
  /// The returned [UserMfa]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserMfa>> insert(
    _i1.Session session,
    List<UserMfa> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserMfa>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserMfa] and returns the inserted row.
  ///
  /// The returned [UserMfa] will have its `id` field set.
  Future<UserMfa> insertRow(
    _i1.Session session,
    UserMfa row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserMfa>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserMfa]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserMfa>> update(
    _i1.Session session,
    List<UserMfa> rows, {
    _i1.ColumnSelections<UserMfaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserMfa>(
      rows,
      columns: columns?.call(UserMfa.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserMfa]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserMfa> updateRow(
    _i1.Session session,
    UserMfa row, {
    _i1.ColumnSelections<UserMfaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserMfa>(
      row,
      columns: columns?.call(UserMfa.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserMfa] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserMfa?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserMfaUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserMfa>(
      id,
      columnValues: columnValues(UserMfa.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserMfa]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserMfa>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserMfaUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserMfaTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserMfaTable>? orderBy,
    _i1.OrderByListBuilder<UserMfaTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserMfa>(
      columnValues: columnValues(UserMfa.t.updateTable),
      where: where(UserMfa.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserMfa.t),
      orderByList: orderByList?.call(UserMfa.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserMfa]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserMfa>> delete(
    _i1.Session session,
    List<UserMfa> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserMfa>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserMfa].
  Future<UserMfa> deleteRow(
    _i1.Session session,
    UserMfa row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserMfa>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserMfa>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserMfaTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserMfa>(
      where: where(UserMfa.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserMfaTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserMfa>(
      where: where?.call(UserMfa.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserMfa] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserMfaTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserMfa>(
      where: where(UserMfa.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
