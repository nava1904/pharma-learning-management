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

/// Immutable audit trail - append-only, no updates/deletes. FDA 21 CFR Part 11.
abstract class AuditTrail
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AuditTrail._({
    this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    this.oldValueJson,
    this.newValueJson,
    DateTime? timestamp,
    this.userId,
    this.user,
    this.reason,
    this.ipAddress,
    this.rowHash,
  }) : timestamp = timestamp ?? DateTime.now();

  factory AuditTrail({
    int? id,
    required String entityType,
    required String entityId,
    required String action,
    String? oldValueJson,
    String? newValueJson,
    DateTime? timestamp,
    int? userId,
    _i2.PharmaUser? user,
    String? reason,
    String? ipAddress,
    String? rowHash,
  }) = _AuditTrailImpl;

  factory AuditTrail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditTrail(
      id: jsonSerialization['id'] as int?,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String,
      action: jsonSerialization['action'] as String,
      oldValueJson: jsonSerialization['oldValueJson'] as String?,
      newValueJson: jsonSerialization['newValueJson'] as String?,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      userId: jsonSerialization['userId'] as int?,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      reason: jsonSerialization['reason'] as String?,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      rowHash: jsonSerialization['rowHash'] as String?,
    );
  }

  static final t = AuditTrailTable();

  static const db = AuditTrailRepository._();

  @override
  int? id;

  /// Entity type (e.g., course, training_record, document).
  String entityType;

  /// Entity ID.
  String entityId;

  /// Action performed (create, update, delete, approve).
  String action;

  /// Old value as JSON before change.
  String? oldValueJson;

  /// New value as JSON after change.
  String? newValueJson;

  /// Timestamp of the action.
  DateTime timestamp;

  int? userId;

  /// User who performed the action.
  _i2.PharmaUser? user;

  /// Reason for change (required for certain actions).
  String? reason;

  /// IP address.
  String? ipAddress;

  /// SHA-256 hash of critical fields for integrity verification (21 CFR Part 11).
  String? rowHash;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditTrail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditTrail copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? action,
    String? oldValueJson,
    String? newValueJson,
    DateTime? timestamp,
    int? userId,
    _i2.PharmaUser? user,
    String? reason,
    String? ipAddress,
    String? rowHash,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditTrail',
      if (id != null) 'id': id,
      'entityType': entityType,
      'entityId': entityId,
      'action': action,
      if (oldValueJson != null) 'oldValueJson': oldValueJson,
      if (newValueJson != null) 'newValueJson': newValueJson,
      'timestamp': timestamp.toJson(),
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (reason != null) 'reason': reason,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (rowHash != null) 'rowHash': rowHash,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditTrail',
      if (id != null) 'id': id,
      'entityType': entityType,
      'entityId': entityId,
      'action': action,
      if (oldValueJson != null) 'oldValueJson': oldValueJson,
      if (newValueJson != null) 'newValueJson': newValueJson,
      'timestamp': timestamp.toJson(),
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      if (reason != null) 'reason': reason,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (rowHash != null) 'rowHash': rowHash,
    };
  }

  static AuditTrailInclude include({_i2.PharmaUserInclude? user}) {
    return AuditTrailInclude._(user: user);
  }

  static AuditTrailIncludeList includeList({
    _i1.WhereExpressionBuilder<AuditTrailTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditTrailTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditTrailTable>? orderByList,
    AuditTrailInclude? include,
  }) {
    return AuditTrailIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditTrail.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AuditTrail.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditTrailImpl extends AuditTrail {
  _AuditTrailImpl({
    int? id,
    required String entityType,
    required String entityId,
    required String action,
    String? oldValueJson,
    String? newValueJson,
    DateTime? timestamp,
    int? userId,
    _i2.PharmaUser? user,
    String? reason,
    String? ipAddress,
    String? rowHash,
  }) : super._(
         id: id,
         entityType: entityType,
         entityId: entityId,
         action: action,
         oldValueJson: oldValueJson,
         newValueJson: newValueJson,
         timestamp: timestamp,
         userId: userId,
         user: user,
         reason: reason,
         ipAddress: ipAddress,
         rowHash: rowHash,
       );

  /// Returns a shallow copy of this [AuditTrail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditTrail copyWith({
    Object? id = _Undefined,
    String? entityType,
    String? entityId,
    String? action,
    Object? oldValueJson = _Undefined,
    Object? newValueJson = _Undefined,
    DateTime? timestamp,
    Object? userId = _Undefined,
    Object? user = _Undefined,
    Object? reason = _Undefined,
    Object? ipAddress = _Undefined,
    Object? rowHash = _Undefined,
  }) {
    return AuditTrail(
      id: id is int? ? id : this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      oldValueJson: oldValueJson is String? ? oldValueJson : this.oldValueJson,
      newValueJson: newValueJson is String? ? newValueJson : this.newValueJson,
      timestamp: timestamp ?? this.timestamp,
      userId: userId is int? ? userId : this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      reason: reason is String? ? reason : this.reason,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      rowHash: rowHash is String? ? rowHash : this.rowHash,
    );
  }
}

class AuditTrailUpdateTable extends _i1.UpdateTable<AuditTrailTable> {
  AuditTrailUpdateTable(super.table);

  _i1.ColumnValue<String, String> entityType(String value) => _i1.ColumnValue(
    table.entityType,
    value,
  );

  _i1.ColumnValue<String, String> entityId(String value) => _i1.ColumnValue(
    table.entityId,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> oldValueJson(String? value) =>
      _i1.ColumnValue(
        table.oldValueJson,
        value,
      );

  _i1.ColumnValue<String, String> newValueJson(String? value) =>
      _i1.ColumnValue(
        table.newValueJson,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String? value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<String, String> ipAddress(String? value) => _i1.ColumnValue(
    table.ipAddress,
    value,
  );

  _i1.ColumnValue<String, String> rowHash(String? value) => _i1.ColumnValue(
    table.rowHash,
    value,
  );
}

class AuditTrailTable extends _i1.Table<int?> {
  AuditTrailTable({super.tableRelation}) : super(tableName: 'audit_trail') {
    updateTable = AuditTrailUpdateTable(this);
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    entityId = _i1.ColumnString(
      'entityId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    oldValueJson = _i1.ColumnString(
      'oldValueJson',
      this,
    );
    newValueJson = _i1.ColumnString(
      'newValueJson',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
      this,
    );
    rowHash = _i1.ColumnString(
      'rowHash',
      this,
    );
  }

  late final AuditTrailUpdateTable updateTable;

  /// Entity type (e.g., course, training_record, document).
  late final _i1.ColumnString entityType;

  /// Entity ID.
  late final _i1.ColumnString entityId;

  /// Action performed (create, update, delete, approve).
  late final _i1.ColumnString action;

  /// Old value as JSON before change.
  late final _i1.ColumnString oldValueJson;

  /// New value as JSON after change.
  late final _i1.ColumnString newValueJson;

  /// Timestamp of the action.
  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnInt userId;

  /// User who performed the action.
  _i2.PharmaUserTable? _user;

  /// Reason for change (required for certain actions).
  late final _i1.ColumnString reason;

  /// IP address.
  late final _i1.ColumnString ipAddress;

  /// SHA-256 hash of critical fields for integrity verification (21 CFR Part 11).
  late final _i1.ColumnString rowHash;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AuditTrail.t.userId,
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
    entityType,
    entityId,
    action,
    oldValueJson,
    newValueJson,
    timestamp,
    userId,
    reason,
    ipAddress,
    rowHash,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class AuditTrailInclude extends _i1.IncludeObject {
  AuditTrailInclude._({_i2.PharmaUserInclude? user}) {
    _user = user;
  }

  _i2.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => AuditTrail.t;
}

class AuditTrailIncludeList extends _i1.IncludeList {
  AuditTrailIncludeList._({
    _i1.WhereExpressionBuilder<AuditTrailTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditTrail.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AuditTrail.t;
}

class AuditTrailRepository {
  const AuditTrailRepository._();

  final attachRow = const AuditTrailAttachRowRepository._();

  final detachRow = const AuditTrailDetachRowRepository._();

  /// Returns a list of [AuditTrail]s matching the given query parameters.
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
  Future<List<AuditTrail>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditTrailTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditTrailTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditTrailTable>? orderByList,
    _i1.Transaction? transaction,
    AuditTrailInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditTrail>(
      where: where?.call(AuditTrail.t),
      orderBy: orderBy?.call(AuditTrail.t),
      orderByList: orderByList?.call(AuditTrail.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditTrail] matching the given query parameters.
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
  Future<AuditTrail?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditTrailTable>? where,
    int? offset,
    _i1.OrderByBuilder<AuditTrailTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditTrailTable>? orderByList,
    _i1.Transaction? transaction,
    AuditTrailInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditTrail>(
      where: where?.call(AuditTrail.t),
      orderBy: orderBy?.call(AuditTrail.t),
      orderByList: orderByList?.call(AuditTrail.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditTrail] by its [id] or null if no such row exists.
  Future<AuditTrail?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AuditTrailInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditTrail>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditTrail]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditTrail]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AuditTrail>> insert(
    _i1.DatabaseSession session,
    List<AuditTrail> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AuditTrail>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AuditTrail] and returns the inserted row.
  ///
  /// The returned [AuditTrail] will have its `id` field set.
  Future<AuditTrail> insertRow(
    _i1.DatabaseSession session,
    AuditTrail row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditTrail>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AuditTrail]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AuditTrail>> update(
    _i1.DatabaseSession session,
    List<AuditTrail> rows, {
    _i1.ColumnSelections<AuditTrailTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AuditTrail>(
      rows,
      columns: columns?.call(AuditTrail.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditTrail]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditTrail> updateRow(
    _i1.DatabaseSession session,
    AuditTrail row, {
    _i1.ColumnSelections<AuditTrailTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditTrail>(
      row,
      columns: columns?.call(AuditTrail.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditTrail] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditTrail?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AuditTrailUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditTrail>(
      id,
      columnValues: columnValues(AuditTrail.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditTrail]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AuditTrail>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AuditTrailUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AuditTrailTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditTrailTable>? orderBy,
    _i1.OrderByListBuilder<AuditTrailTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AuditTrail>(
      columnValues: columnValues(AuditTrail.t.updateTable),
      where: where(AuditTrail.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditTrail.t),
      orderByList: orderByList?.call(AuditTrail.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AuditTrail]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AuditTrail>> delete(
    _i1.DatabaseSession session,
    List<AuditTrail> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AuditTrail>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AuditTrail].
  Future<AuditTrail> deleteRow(
    _i1.DatabaseSession session,
    AuditTrail row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditTrail>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AuditTrail>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditTrailTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AuditTrail>(
      where: where(AuditTrail.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditTrailTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AuditTrail>(
      where: where?.call(AuditTrail.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditTrail] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditTrailTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditTrail>(
      where: where(AuditTrail.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AuditTrailAttachRowRepository {
  const AuditTrailAttachRowRepository._();

  /// Creates a relation between the given [AuditTrail] and [PharmaUser]
  /// by setting the [AuditTrail]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    AuditTrail auditTrail,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (auditTrail.id == null) {
      throw ArgumentError.notNull('auditTrail.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $auditTrail = auditTrail.copyWith(userId: user.id);
    await session.db.updateRow<AuditTrail>(
      $auditTrail,
      columns: [AuditTrail.t.userId],
      transaction: transaction,
    );
  }
}

class AuditTrailDetachRowRepository {
  const AuditTrailDetachRowRepository._();

  /// Detaches the relation between this [AuditTrail] and the [PharmaUser] set in `user`
  /// by setting the [AuditTrail]'s foreign key `userId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> user(
    _i1.DatabaseSession session,
    AuditTrail auditTrail, {
    _i1.Transaction? transaction,
  }) async {
    if (auditTrail.id == null) {
      throw ArgumentError.notNull('auditTrail.id');
    }

    var $auditTrail = auditTrail.copyWith(userId: null);
    await session.db.updateRow<AuditTrail>(
      $auditTrail,
      columns: [AuditTrail.t.userId],
      transaction: transaction,
    );
  }
}
