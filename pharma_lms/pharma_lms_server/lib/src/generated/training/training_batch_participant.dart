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
import '../training/training_batch.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// User membership in an ILT training batch (roster).
abstract class TrainingBatchParticipant
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingBatchParticipant._({
    this.id,
    required this.batchId,
    this.batch,
    required this.userId,
    this.user,
    DateTime? enrolledAt,
    this.role,
  }) : enrolledAt = enrolledAt ?? DateTime.now();

  factory TrainingBatchParticipant({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required int userId,
    _i3.PharmaUser? user,
    DateTime? enrolledAt,
    String? role,
  }) = _TrainingBatchParticipantImpl;

  factory TrainingBatchParticipant.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingBatchParticipant(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      enrolledAt: jsonSerialization['enrolledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['enrolledAt']),
      role: jsonSerialization['role'] as String?,
    );
  }

  static final t = TrainingBatchParticipantTable();

  static const db = TrainingBatchParticipantRepository._();

  @override
  int? id;

  int batchId;

  /// Batch cohort.
  _i2.TrainingBatch? batch;

  int userId;

  /// Learner or mentor.
  _i3.PharmaUser? user;

  /// When added to roster.
  DateTime enrolledAt;

  /// Optional: learner, mentor.
  String? role;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingBatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingBatchParticipant copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    int? userId,
    _i3.PharmaUser? user,
    DateTime? enrolledAt,
    String? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingBatchParticipant',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'enrolledAt': enrolledAt.toJson(),
      if (role != null) 'role': role,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingBatchParticipant',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJsonForProtocol(),
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'enrolledAt': enrolledAt.toJson(),
      if (role != null) 'role': role,
    };
  }

  static TrainingBatchParticipantInclude include({
    _i2.TrainingBatchInclude? batch,
    _i3.PharmaUserInclude? user,
  }) {
    return TrainingBatchParticipantInclude._(
      batch: batch,
      user: user,
    );
  }

  static TrainingBatchParticipantIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingBatchParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingBatchParticipantTable>? orderByList,
    TrainingBatchParticipantInclude? include,
  }) {
    return TrainingBatchParticipantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingBatchParticipant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingBatchParticipant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingBatchParticipantImpl extends TrainingBatchParticipant {
  _TrainingBatchParticipantImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required int userId,
    _i3.PharmaUser? user,
    DateTime? enrolledAt,
    String? role,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         userId: userId,
         user: user,
         enrolledAt: enrolledAt,
         role: role,
       );

  /// Returns a shallow copy of this [TrainingBatchParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingBatchParticipant copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    int? userId,
    Object? user = _Undefined,
    DateTime? enrolledAt,
    Object? role = _Undefined,
  }) {
    return TrainingBatchParticipant(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      enrolledAt: enrolledAt ?? this.enrolledAt,
      role: role is String? ? role : this.role,
    );
  }
}

class TrainingBatchParticipantUpdateTable
    extends _i1.UpdateTable<TrainingBatchParticipantTable> {
  TrainingBatchParticipantUpdateTable(super.table);

  _i1.ColumnValue<int, int> batchId(int value) => _i1.ColumnValue(
    table.batchId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> enrolledAt(DateTime value) =>
      _i1.ColumnValue(
        table.enrolledAt,
        value,
      );

  _i1.ColumnValue<String, String> role(String? value) => _i1.ColumnValue(
    table.role,
    value,
  );
}

class TrainingBatchParticipantTable extends _i1.Table<int?> {
  TrainingBatchParticipantTable({super.tableRelation})
    : super(tableName: 'training_batch_participant') {
    updateTable = TrainingBatchParticipantUpdateTable(this);
    batchId = _i1.ColumnInt(
      'batchId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    enrolledAt = _i1.ColumnDateTime(
      'enrolledAt',
      this,
      hasDefault: true,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
  }

  late final TrainingBatchParticipantUpdateTable updateTable;

  late final _i1.ColumnInt batchId;

  /// Batch cohort.
  _i2.TrainingBatchTable? _batch;

  late final _i1.ColumnInt userId;

  /// Learner or mentor.
  _i3.PharmaUserTable? _user;

  /// When added to roster.
  late final _i1.ColumnDateTime enrolledAt;

  /// Optional: learner, mentor.
  late final _i1.ColumnString role;

  _i2.TrainingBatchTable get batch {
    if (_batch != null) return _batch!;
    _batch = _i1.createRelationTable(
      relationFieldName: 'batch',
      field: TrainingBatchParticipant.t.batchId,
      foreignField: _i2.TrainingBatch.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingBatchTable(tableRelation: foreignTableRelation),
    );
    return _batch!;
  }

  _i3.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: TrainingBatchParticipant.t.userId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    batchId,
    userId,
    enrolledAt,
    role,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'batch') {
      return batch;
    }
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class TrainingBatchParticipantInclude extends _i1.IncludeObject {
  TrainingBatchParticipantInclude._({
    _i2.TrainingBatchInclude? batch,
    _i3.PharmaUserInclude? user,
  }) {
    _batch = batch;
    _user = user;
  }

  _i2.TrainingBatchInclude? _batch;

  _i3.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {
    'batch': _batch,
    'user': _user,
  };

  @override
  _i1.Table<int?> get table => TrainingBatchParticipant.t;
}

class TrainingBatchParticipantIncludeList extends _i1.IncludeList {
  TrainingBatchParticipantIncludeList._({
    _i1.WhereExpressionBuilder<TrainingBatchParticipantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingBatchParticipant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingBatchParticipant.t;
}

class TrainingBatchParticipantRepository {
  const TrainingBatchParticipantRepository._();

  final attachRow = const TrainingBatchParticipantAttachRowRepository._();

  /// Returns a list of [TrainingBatchParticipant]s matching the given query parameters.
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
  Future<List<TrainingBatchParticipant>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingBatchParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingBatchParticipantTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingBatchParticipantInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingBatchParticipant>(
      where: where?.call(TrainingBatchParticipant.t),
      orderBy: orderBy?.call(TrainingBatchParticipant.t),
      orderByList: orderByList?.call(TrainingBatchParticipant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingBatchParticipant] matching the given query parameters.
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
  Future<TrainingBatchParticipant?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingBatchParticipantTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingBatchParticipantTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingBatchParticipantInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingBatchParticipant>(
      where: where?.call(TrainingBatchParticipant.t),
      orderBy: orderBy?.call(TrainingBatchParticipant.t),
      orderByList: orderByList?.call(TrainingBatchParticipant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingBatchParticipant] by its [id] or null if no such row exists.
  Future<TrainingBatchParticipant?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingBatchParticipantInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingBatchParticipant>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingBatchParticipant]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingBatchParticipant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingBatchParticipant>> insert(
    _i1.DatabaseSession session,
    List<TrainingBatchParticipant> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingBatchParticipant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingBatchParticipant] and returns the inserted row.
  ///
  /// The returned [TrainingBatchParticipant] will have its `id` field set.
  Future<TrainingBatchParticipant> insertRow(
    _i1.DatabaseSession session,
    TrainingBatchParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingBatchParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingBatchParticipant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingBatchParticipant>> update(
    _i1.DatabaseSession session,
    List<TrainingBatchParticipant> rows, {
    _i1.ColumnSelections<TrainingBatchParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingBatchParticipant>(
      rows,
      columns: columns?.call(TrainingBatchParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingBatchParticipant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingBatchParticipant> updateRow(
    _i1.DatabaseSession session,
    TrainingBatchParticipant row, {
    _i1.ColumnSelections<TrainingBatchParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingBatchParticipant>(
      row,
      columns: columns?.call(TrainingBatchParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingBatchParticipant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingBatchParticipant?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingBatchParticipantUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingBatchParticipant>(
      id,
      columnValues: columnValues(TrainingBatchParticipant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingBatchParticipant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingBatchParticipant>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingBatchParticipantUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingBatchParticipantTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingBatchParticipantTable>? orderBy,
    _i1.OrderByListBuilder<TrainingBatchParticipantTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingBatchParticipant>(
      columnValues: columnValues(TrainingBatchParticipant.t.updateTable),
      where: where(TrainingBatchParticipant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingBatchParticipant.t),
      orderByList: orderByList?.call(TrainingBatchParticipant.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingBatchParticipant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingBatchParticipant>> delete(
    _i1.DatabaseSession session,
    List<TrainingBatchParticipant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingBatchParticipant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingBatchParticipant].
  Future<TrainingBatchParticipant> deleteRow(
    _i1.DatabaseSession session,
    TrainingBatchParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingBatchParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingBatchParticipant>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingBatchParticipantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingBatchParticipant>(
      where: where(TrainingBatchParticipant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingBatchParticipantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingBatchParticipant>(
      where: where?.call(TrainingBatchParticipant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingBatchParticipant] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingBatchParticipantTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingBatchParticipant>(
      where: where(TrainingBatchParticipant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingBatchParticipantAttachRowRepository {
  const TrainingBatchParticipantAttachRowRepository._();

  /// Creates a relation between the given [TrainingBatchParticipant] and [TrainingBatch]
  /// by setting the [TrainingBatchParticipant]'s foreign key `batchId` to refer to the [TrainingBatch].
  Future<void> batch(
    _i1.DatabaseSession session,
    TrainingBatchParticipant trainingBatchParticipant,
    _i2.TrainingBatch batch, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatchParticipant.id == null) {
      throw ArgumentError.notNull('trainingBatchParticipant.id');
    }
    if (batch.id == null) {
      throw ArgumentError.notNull('batch.id');
    }

    var $trainingBatchParticipant = trainingBatchParticipant.copyWith(
      batchId: batch.id,
    );
    await session.db.updateRow<TrainingBatchParticipant>(
      $trainingBatchParticipant,
      columns: [TrainingBatchParticipant.t.batchId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingBatchParticipant] and [PharmaUser]
  /// by setting the [TrainingBatchParticipant]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    TrainingBatchParticipant trainingBatchParticipant,
    _i3.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingBatchParticipant.id == null) {
      throw ArgumentError.notNull('trainingBatchParticipant.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $trainingBatchParticipant = trainingBatchParticipant.copyWith(
      userId: user.id,
    );
    await session.db.updateRow<TrainingBatchParticipant>(
      $trainingBatchParticipant,
      columns: [TrainingBatchParticipant.t.userId],
      transaction: transaction,
    );
  }
}
