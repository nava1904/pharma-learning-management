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

/// Delegated authority (e.g., supervisor delegates to delegatee).
abstract class DelegatedAuthority
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DelegatedAuthority._({
    this.id,
    required this.delegatorId,
    this.delegator,
    required this.delegateeId,
    this.delegatee,
    required this.scope,
    required this.expiresAt,
  });

  factory DelegatedAuthority({
    int? id,
    required int delegatorId,
    _i2.PharmaUser? delegator,
    required int delegateeId,
    _i2.PharmaUser? delegatee,
    required String scope,
    required DateTime expiresAt,
  }) = _DelegatedAuthorityImpl;

  factory DelegatedAuthority.fromJson(Map<String, dynamic> jsonSerialization) {
    return DelegatedAuthority(
      id: jsonSerialization['id'] as int?,
      delegatorId: jsonSerialization['delegatorId'] as int,
      delegator: jsonSerialization['delegator'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['delegator'],
            ),
      delegateeId: jsonSerialization['delegateeId'] as int,
      delegatee: jsonSerialization['delegatee'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['delegatee'],
            ),
      scope: jsonSerialization['scope'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = DelegatedAuthorityTable();

  static const db = DelegatedAuthorityRepository._();

  @override
  int? id;

  int delegatorId;

  /// Delegator user.
  _i2.PharmaUser? delegator;

  int delegateeId;

  /// Delegatee user.
  _i2.PharmaUser? delegatee;

  /// Scope of delegation.
  String scope;

  /// When it expires.
  DateTime expiresAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DelegatedAuthority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DelegatedAuthority copyWith({
    int? id,
    int? delegatorId,
    _i2.PharmaUser? delegator,
    int? delegateeId,
    _i2.PharmaUser? delegatee,
    String? scope,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DelegatedAuthority',
      if (id != null) 'id': id,
      'delegatorId': delegatorId,
      if (delegator != null) 'delegator': delegator?.toJson(),
      'delegateeId': delegateeId,
      if (delegatee != null) 'delegatee': delegatee?.toJson(),
      'scope': scope,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DelegatedAuthority',
      if (id != null) 'id': id,
      'delegatorId': delegatorId,
      if (delegator != null) 'delegator': delegator?.toJsonForProtocol(),
      'delegateeId': delegateeId,
      if (delegatee != null) 'delegatee': delegatee?.toJsonForProtocol(),
      'scope': scope,
      'expiresAt': expiresAt.toJson(),
    };
  }

  static DelegatedAuthorityInclude include({
    _i2.PharmaUserInclude? delegator,
    _i2.PharmaUserInclude? delegatee,
  }) {
    return DelegatedAuthorityInclude._(
      delegator: delegator,
      delegatee: delegatee,
    );
  }

  static DelegatedAuthorityIncludeList includeList({
    _i1.WhereExpressionBuilder<DelegatedAuthorityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DelegatedAuthorityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DelegatedAuthorityTable>? orderByList,
    DelegatedAuthorityInclude? include,
  }) {
    return DelegatedAuthorityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DelegatedAuthority.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DelegatedAuthority.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DelegatedAuthorityImpl extends DelegatedAuthority {
  _DelegatedAuthorityImpl({
    int? id,
    required int delegatorId,
    _i2.PharmaUser? delegator,
    required int delegateeId,
    _i2.PharmaUser? delegatee,
    required String scope,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         delegatorId: delegatorId,
         delegator: delegator,
         delegateeId: delegateeId,
         delegatee: delegatee,
         scope: scope,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [DelegatedAuthority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DelegatedAuthority copyWith({
    Object? id = _Undefined,
    int? delegatorId,
    Object? delegator = _Undefined,
    int? delegateeId,
    Object? delegatee = _Undefined,
    String? scope,
    DateTime? expiresAt,
  }) {
    return DelegatedAuthority(
      id: id is int? ? id : this.id,
      delegatorId: delegatorId ?? this.delegatorId,
      delegator: delegator is _i2.PharmaUser?
          ? delegator
          : this.delegator?.copyWith(),
      delegateeId: delegateeId ?? this.delegateeId,
      delegatee: delegatee is _i2.PharmaUser?
          ? delegatee
          : this.delegatee?.copyWith(),
      scope: scope ?? this.scope,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class DelegatedAuthorityUpdateTable
    extends _i1.UpdateTable<DelegatedAuthorityTable> {
  DelegatedAuthorityUpdateTable(super.table);

  _i1.ColumnValue<int, int> delegatorId(int value) => _i1.ColumnValue(
    table.delegatorId,
    value,
  );

  _i1.ColumnValue<int, int> delegateeId(int value) => _i1.ColumnValue(
    table.delegateeId,
    value,
  );

  _i1.ColumnValue<String, String> scope(String value) => _i1.ColumnValue(
    table.scope,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class DelegatedAuthorityTable extends _i1.Table<int?> {
  DelegatedAuthorityTable({super.tableRelation})
    : super(tableName: 'delegated_authority') {
    updateTable = DelegatedAuthorityUpdateTable(this);
    delegatorId = _i1.ColumnInt(
      'delegatorId',
      this,
    );
    delegateeId = _i1.ColumnInt(
      'delegateeId',
      this,
    );
    scope = _i1.ColumnString(
      'scope',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final DelegatedAuthorityUpdateTable updateTable;

  late final _i1.ColumnInt delegatorId;

  /// Delegator user.
  _i2.PharmaUserTable? _delegator;

  late final _i1.ColumnInt delegateeId;

  /// Delegatee user.
  _i2.PharmaUserTable? _delegatee;

  /// Scope of delegation.
  late final _i1.ColumnString scope;

  /// When it expires.
  late final _i1.ColumnDateTime expiresAt;

  _i2.PharmaUserTable get delegator {
    if (_delegator != null) return _delegator!;
    _delegator = _i1.createRelationTable(
      relationFieldName: 'delegator',
      field: DelegatedAuthority.t.delegatorId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _delegator!;
  }

  _i2.PharmaUserTable get delegatee {
    if (_delegatee != null) return _delegatee!;
    _delegatee = _i1.createRelationTable(
      relationFieldName: 'delegatee',
      field: DelegatedAuthority.t.delegateeId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _delegatee!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    delegatorId,
    delegateeId,
    scope,
    expiresAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'delegator') {
      return delegator;
    }
    if (relationField == 'delegatee') {
      return delegatee;
    }
    return null;
  }
}

class DelegatedAuthorityInclude extends _i1.IncludeObject {
  DelegatedAuthorityInclude._({
    _i2.PharmaUserInclude? delegator,
    _i2.PharmaUserInclude? delegatee,
  }) {
    _delegator = delegator;
    _delegatee = delegatee;
  }

  _i2.PharmaUserInclude? _delegator;

  _i2.PharmaUserInclude? _delegatee;

  @override
  Map<String, _i1.Include?> get includes => {
    'delegator': _delegator,
    'delegatee': _delegatee,
  };

  @override
  _i1.Table<int?> get table => DelegatedAuthority.t;
}

class DelegatedAuthorityIncludeList extends _i1.IncludeList {
  DelegatedAuthorityIncludeList._({
    _i1.WhereExpressionBuilder<DelegatedAuthorityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DelegatedAuthority.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DelegatedAuthority.t;
}

class DelegatedAuthorityRepository {
  const DelegatedAuthorityRepository._();

  final attachRow = const DelegatedAuthorityAttachRowRepository._();

  /// Returns a list of [DelegatedAuthority]s matching the given query parameters.
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
  Future<List<DelegatedAuthority>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DelegatedAuthorityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DelegatedAuthorityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DelegatedAuthorityTable>? orderByList,
    _i1.Transaction? transaction,
    DelegatedAuthorityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DelegatedAuthority>(
      where: where?.call(DelegatedAuthority.t),
      orderBy: orderBy?.call(DelegatedAuthority.t),
      orderByList: orderByList?.call(DelegatedAuthority.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DelegatedAuthority] matching the given query parameters.
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
  Future<DelegatedAuthority?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DelegatedAuthorityTable>? where,
    int? offset,
    _i1.OrderByBuilder<DelegatedAuthorityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DelegatedAuthorityTable>? orderByList,
    _i1.Transaction? transaction,
    DelegatedAuthorityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DelegatedAuthority>(
      where: where?.call(DelegatedAuthority.t),
      orderBy: orderBy?.call(DelegatedAuthority.t),
      orderByList: orderByList?.call(DelegatedAuthority.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DelegatedAuthority] by its [id] or null if no such row exists.
  Future<DelegatedAuthority?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    DelegatedAuthorityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DelegatedAuthority>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DelegatedAuthority]s in the list and returns the inserted rows.
  ///
  /// The returned [DelegatedAuthority]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DelegatedAuthority>> insert(
    _i1.Session session,
    List<DelegatedAuthority> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DelegatedAuthority>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DelegatedAuthority] and returns the inserted row.
  ///
  /// The returned [DelegatedAuthority] will have its `id` field set.
  Future<DelegatedAuthority> insertRow(
    _i1.Session session,
    DelegatedAuthority row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DelegatedAuthority>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DelegatedAuthority]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DelegatedAuthority>> update(
    _i1.Session session,
    List<DelegatedAuthority> rows, {
    _i1.ColumnSelections<DelegatedAuthorityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DelegatedAuthority>(
      rows,
      columns: columns?.call(DelegatedAuthority.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DelegatedAuthority]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DelegatedAuthority> updateRow(
    _i1.Session session,
    DelegatedAuthority row, {
    _i1.ColumnSelections<DelegatedAuthorityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DelegatedAuthority>(
      row,
      columns: columns?.call(DelegatedAuthority.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DelegatedAuthority] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DelegatedAuthority?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DelegatedAuthorityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DelegatedAuthority>(
      id,
      columnValues: columnValues(DelegatedAuthority.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DelegatedAuthority]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DelegatedAuthority>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DelegatedAuthorityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DelegatedAuthorityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DelegatedAuthorityTable>? orderBy,
    _i1.OrderByListBuilder<DelegatedAuthorityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DelegatedAuthority>(
      columnValues: columnValues(DelegatedAuthority.t.updateTable),
      where: where(DelegatedAuthority.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DelegatedAuthority.t),
      orderByList: orderByList?.call(DelegatedAuthority.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DelegatedAuthority]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DelegatedAuthority>> delete(
    _i1.Session session,
    List<DelegatedAuthority> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DelegatedAuthority>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DelegatedAuthority].
  Future<DelegatedAuthority> deleteRow(
    _i1.Session session,
    DelegatedAuthority row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DelegatedAuthority>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DelegatedAuthority>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DelegatedAuthorityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DelegatedAuthority>(
      where: where(DelegatedAuthority.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DelegatedAuthorityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DelegatedAuthority>(
      where: where?.call(DelegatedAuthority.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DelegatedAuthority] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DelegatedAuthorityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DelegatedAuthority>(
      where: where(DelegatedAuthority.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DelegatedAuthorityAttachRowRepository {
  const DelegatedAuthorityAttachRowRepository._();

  /// Creates a relation between the given [DelegatedAuthority] and [PharmaUser]
  /// by setting the [DelegatedAuthority]'s foreign key `delegatorId` to refer to the [PharmaUser].
  Future<void> delegator(
    _i1.Session session,
    DelegatedAuthority delegatedAuthority,
    _i2.PharmaUser delegator, {
    _i1.Transaction? transaction,
  }) async {
    if (delegatedAuthority.id == null) {
      throw ArgumentError.notNull('delegatedAuthority.id');
    }
    if (delegator.id == null) {
      throw ArgumentError.notNull('delegator.id');
    }

    var $delegatedAuthority = delegatedAuthority.copyWith(
      delegatorId: delegator.id,
    );
    await session.db.updateRow<DelegatedAuthority>(
      $delegatedAuthority,
      columns: [DelegatedAuthority.t.delegatorId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [DelegatedAuthority] and [PharmaUser]
  /// by setting the [DelegatedAuthority]'s foreign key `delegateeId` to refer to the [PharmaUser].
  Future<void> delegatee(
    _i1.Session session,
    DelegatedAuthority delegatedAuthority,
    _i2.PharmaUser delegatee, {
    _i1.Transaction? transaction,
  }) async {
    if (delegatedAuthority.id == null) {
      throw ArgumentError.notNull('delegatedAuthority.id');
    }
    if (delegatee.id == null) {
      throw ArgumentError.notNull('delegatee.id');
    }

    var $delegatedAuthority = delegatedAuthority.copyWith(
      delegateeId: delegatee.id,
    );
    await session.db.updateRow<DelegatedAuthority>(
      $delegatedAuthority,
      columns: [DelegatedAuthority.t.delegateeId],
      transaction: transaction,
    );
  }
}
