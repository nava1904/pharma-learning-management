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
import '../course/competency.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// User's achieved competency with expiry.
abstract class UserCompetency
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserCompetency._({
    this.id,
    required this.userId,
    this.user,
    required this.competencyId,
    this.competency,
    DateTime? achievedAt,
    this.expiresAt,
  }) : achievedAt = achievedAt ?? DateTime.now();

  factory UserCompetency({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int competencyId,
    _i3.Competency? competency,
    DateTime? achievedAt,
    DateTime? expiresAt,
  }) = _UserCompetencyImpl;

  factory UserCompetency.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserCompetency(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Competency>(
              jsonSerialization['competency'],
            ),
      achievedAt: jsonSerialization['achievedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  static final t = UserCompetencyTable();

  static const db = UserCompetencyRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int competencyId;

  /// The competency.
  _i3.Competency? competency;

  /// When achieved.
  DateTime achievedAt;

  /// When it expires (if applicable).
  DateTime? expiresAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserCompetency copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? competencyId,
    _i3.Competency? competency,
    DateTime? achievedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserCompetency',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
      'achievedAt': achievedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserCompetency',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJsonForProtocol(),
      'achievedAt': achievedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  static UserCompetencyInclude include({
    _i2.PharmaUserInclude? user,
    _i3.CompetencyInclude? competency,
  }) {
    return UserCompetencyInclude._(
      user: user,
      competency: competency,
    );
  }

  static UserCompetencyIncludeList includeList({
    _i1.WhereExpressionBuilder<UserCompetencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserCompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserCompetencyTable>? orderByList,
    UserCompetencyInclude? include,
  }) {
    return UserCompetencyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserCompetency.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserCompetency.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserCompetencyImpl extends UserCompetency {
  _UserCompetencyImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int competencyId,
    _i3.Competency? competency,
    DateTime? achievedAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         competencyId: competencyId,
         competency: competency,
         achievedAt: achievedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [UserCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserCompetency copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
    DateTime? achievedAt,
    Object? expiresAt = _Undefined,
  }) {
    return UserCompetency(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i3.Competency?
          ? competency
          : this.competency?.copyWith(),
      achievedAt: achievedAt ?? this.achievedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}

class UserCompetencyUpdateTable extends _i1.UpdateTable<UserCompetencyTable> {
  UserCompetencyUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> competencyId(int value) => _i1.ColumnValue(
    table.competencyId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> achievedAt(DateTime value) =>
      _i1.ColumnValue(
        table.achievedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class UserCompetencyTable extends _i1.Table<int?> {
  UserCompetencyTable({super.tableRelation})
    : super(tableName: 'user_competency') {
    updateTable = UserCompetencyUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    competencyId = _i1.ColumnInt(
      'competencyId',
      this,
    );
    achievedAt = _i1.ColumnDateTime(
      'achievedAt',
      this,
      hasDefault: true,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final UserCompetencyUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt competencyId;

  /// The competency.
  _i3.CompetencyTable? _competency;

  /// When achieved.
  late final _i1.ColumnDateTime achievedAt;

  /// When it expires (if applicable).
  late final _i1.ColumnDateTime expiresAt;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: UserCompetency.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.CompetencyTable get competency {
    if (_competency != null) return _competency!;
    _competency = _i1.createRelationTable(
      relationFieldName: 'competency',
      field: UserCompetency.t.competencyId,
      foreignField: _i3.Competency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetencyTable(tableRelation: foreignTableRelation),
    );
    return _competency!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    competencyId,
    achievedAt,
    expiresAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'competency') {
      return competency;
    }
    return null;
  }
}

class UserCompetencyInclude extends _i1.IncludeObject {
  UserCompetencyInclude._({
    _i2.PharmaUserInclude? user,
    _i3.CompetencyInclude? competency,
  }) {
    _user = user;
    _competency = competency;
  }

  _i2.PharmaUserInclude? _user;

  _i3.CompetencyInclude? _competency;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'competency': _competency,
  };

  @override
  _i1.Table<int?> get table => UserCompetency.t;
}

class UserCompetencyIncludeList extends _i1.IncludeList {
  UserCompetencyIncludeList._({
    _i1.WhereExpressionBuilder<UserCompetencyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserCompetency.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserCompetency.t;
}

class UserCompetencyRepository {
  const UserCompetencyRepository._();

  final attachRow = const UserCompetencyAttachRowRepository._();

  /// Returns a list of [UserCompetency]s matching the given query parameters.
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
  Future<List<UserCompetency>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserCompetencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserCompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserCompetencyTable>? orderByList,
    _i1.Transaction? transaction,
    UserCompetencyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserCompetency>(
      where: where?.call(UserCompetency.t),
      orderBy: orderBy?.call(UserCompetency.t),
      orderByList: orderByList?.call(UserCompetency.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserCompetency] matching the given query parameters.
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
  Future<UserCompetency?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserCompetencyTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserCompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserCompetencyTable>? orderByList,
    _i1.Transaction? transaction,
    UserCompetencyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserCompetency>(
      where: where?.call(UserCompetency.t),
      orderBy: orderBy?.call(UserCompetency.t),
      orderByList: orderByList?.call(UserCompetency.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserCompetency] by its [id] or null if no such row exists.
  Future<UserCompetency?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    UserCompetencyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserCompetency>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserCompetency]s in the list and returns the inserted rows.
  ///
  /// The returned [UserCompetency]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserCompetency>> insert(
    _i1.DatabaseSession session,
    List<UserCompetency> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserCompetency>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserCompetency] and returns the inserted row.
  ///
  /// The returned [UserCompetency] will have its `id` field set.
  Future<UserCompetency> insertRow(
    _i1.DatabaseSession session,
    UserCompetency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserCompetency>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserCompetency]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserCompetency>> update(
    _i1.DatabaseSession session,
    List<UserCompetency> rows, {
    _i1.ColumnSelections<UserCompetencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserCompetency>(
      rows,
      columns: columns?.call(UserCompetency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserCompetency]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserCompetency> updateRow(
    _i1.DatabaseSession session,
    UserCompetency row, {
    _i1.ColumnSelections<UserCompetencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserCompetency>(
      row,
      columns: columns?.call(UserCompetency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserCompetency] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserCompetency?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserCompetencyUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserCompetency>(
      id,
      columnValues: columnValues(UserCompetency.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserCompetency]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserCompetency>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserCompetencyUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserCompetencyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserCompetencyTable>? orderBy,
    _i1.OrderByListBuilder<UserCompetencyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserCompetency>(
      columnValues: columnValues(UserCompetency.t.updateTable),
      where: where(UserCompetency.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserCompetency.t),
      orderByList: orderByList?.call(UserCompetency.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserCompetency]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserCompetency>> delete(
    _i1.DatabaseSession session,
    List<UserCompetency> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserCompetency>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserCompetency].
  Future<UserCompetency> deleteRow(
    _i1.DatabaseSession session,
    UserCompetency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserCompetency>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserCompetency>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserCompetencyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserCompetency>(
      where: where(UserCompetency.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserCompetencyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserCompetency>(
      where: where?.call(UserCompetency.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserCompetency] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserCompetencyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserCompetency>(
      where: where(UserCompetency.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserCompetencyAttachRowRepository {
  const UserCompetencyAttachRowRepository._();

  /// Creates a relation between the given [UserCompetency] and [PharmaUser]
  /// by setting the [UserCompetency]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    UserCompetency userCompetency,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (userCompetency.id == null) {
      throw ArgumentError.notNull('userCompetency.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userCompetency = userCompetency.copyWith(userId: user.id);
    await session.db.updateRow<UserCompetency>(
      $userCompetency,
      columns: [UserCompetency.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [UserCompetency] and [Competency]
  /// by setting the [UserCompetency]'s foreign key `competencyId` to refer to the [Competency].
  Future<void> competency(
    _i1.DatabaseSession session,
    UserCompetency userCompetency,
    _i3.Competency competency, {
    _i1.Transaction? transaction,
  }) async {
    if (userCompetency.id == null) {
      throw ArgumentError.notNull('userCompetency.id');
    }
    if (competency.id == null) {
      throw ArgumentError.notNull('competency.id');
    }

    var $userCompetency = userCompetency.copyWith(competencyId: competency.id);
    await session.db.updateRow<UserCompetency>(
      $userCompetency,
      columns: [UserCompetency.t.competencyId],
      transaction: transaction,
    );
  }
}
