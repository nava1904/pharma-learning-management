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

/// Instructor or admin post visible to batch roster (assignments, live session notes, general).
abstract class BatchAnnouncement
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BatchAnnouncement._({
    this.id,
    required this.batchId,
    this.batch,
    required this.title,
    required this.body,
    String? kind,
    this.relatedLiveClassId,
    this.createdById,
    this.createdBy,
    DateTime? createdAt,
  }) : kind = kind ?? 'general',
       createdAt = createdAt ?? DateTime.now();

  factory BatchAnnouncement({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    required String body,
    String? kind,
    int? relatedLiveClassId,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) = _BatchAnnouncementImpl;

  factory BatchAnnouncement.fromJson(Map<String, dynamic> jsonSerialization) {
    return BatchAnnouncement(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      kind: jsonSerialization['kind'] as String?,
      relatedLiveClassId: jsonSerialization['relatedLiveClassId'] as int?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = BatchAnnouncementTable();

  static const db = BatchAnnouncementRepository._();

  @override
  int? id;

  int batchId;

  _i2.TrainingBatch? batch;

  String title;

  String body;

  /// general | assignment | live_session
  String kind;

  int? relatedLiveClassId;

  int? createdById;

  _i3.PharmaUser? createdBy;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BatchAnnouncement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchAnnouncement copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    String? title,
    String? body,
    String? kind,
    int? relatedLiveClassId,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BatchAnnouncement',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      'title': title,
      'body': body,
      'kind': kind,
      if (relatedLiveClassId != null) 'relatedLiveClassId': relatedLiveClassId,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BatchAnnouncement',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJsonForProtocol(),
      'title': title,
      'body': body,
      'kind': kind,
      if (relatedLiveClassId != null) 'relatedLiveClassId': relatedLiveClassId,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static BatchAnnouncementInclude include({
    _i2.TrainingBatchInclude? batch,
    _i3.PharmaUserInclude? createdBy,
  }) {
    return BatchAnnouncementInclude._(
      batch: batch,
      createdBy: createdBy,
    );
  }

  static BatchAnnouncementIncludeList includeList({
    _i1.WhereExpressionBuilder<BatchAnnouncementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BatchAnnouncementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BatchAnnouncementTable>? orderByList,
    BatchAnnouncementInclude? include,
  }) {
    return BatchAnnouncementIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BatchAnnouncement.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BatchAnnouncement.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchAnnouncementImpl extends BatchAnnouncement {
  _BatchAnnouncementImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    required String body,
    String? kind,
    int? relatedLiveClassId,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         title: title,
         body: body,
         kind: kind,
         relatedLiveClassId: relatedLiveClassId,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BatchAnnouncement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchAnnouncement copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    String? title,
    String? body,
    String? kind,
    Object? relatedLiveClassId = _Undefined,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
  }) {
    return BatchAnnouncement(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      title: title ?? this.title,
      body: body ?? this.body,
      kind: kind ?? this.kind,
      relatedLiveClassId: relatedLiveClassId is int?
          ? relatedLiveClassId
          : this.relatedLiveClassId,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BatchAnnouncementUpdateTable
    extends _i1.UpdateTable<BatchAnnouncementTable> {
  BatchAnnouncementUpdateTable(super.table);

  _i1.ColumnValue<int, int> batchId(int value) => _i1.ColumnValue(
    table.batchId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<String, String> kind(String value) => _i1.ColumnValue(
    table.kind,
    value,
  );

  _i1.ColumnValue<int, int> relatedLiveClassId(int? value) => _i1.ColumnValue(
    table.relatedLiveClassId,
    value,
  );

  _i1.ColumnValue<int, int> createdById(int? value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class BatchAnnouncementTable extends _i1.Table<int?> {
  BatchAnnouncementTable({super.tableRelation})
    : super(tableName: 'batch_announcement') {
    updateTable = BatchAnnouncementUpdateTable(this);
    batchId = _i1.ColumnInt(
      'batchId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    kind = _i1.ColumnString(
      'kind',
      this,
      hasDefault: true,
    );
    relatedLiveClassId = _i1.ColumnInt(
      'relatedLiveClassId',
      this,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final BatchAnnouncementUpdateTable updateTable;

  late final _i1.ColumnInt batchId;

  _i2.TrainingBatchTable? _batch;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  /// general | assignment | live_session
  late final _i1.ColumnString kind;

  late final _i1.ColumnInt relatedLiveClassId;

  late final _i1.ColumnInt createdById;

  _i3.PharmaUserTable? _createdBy;

  late final _i1.ColumnDateTime createdAt;

  _i2.TrainingBatchTable get batch {
    if (_batch != null) return _batch!;
    _batch = _i1.createRelationTable(
      relationFieldName: 'batch',
      field: BatchAnnouncement.t.batchId,
      foreignField: _i2.TrainingBatch.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingBatchTable(tableRelation: foreignTableRelation),
    );
    return _batch!;
  }

  _i3.PharmaUserTable get createdBy {
    if (_createdBy != null) return _createdBy!;
    _createdBy = _i1.createRelationTable(
      relationFieldName: 'createdBy',
      field: BatchAnnouncement.t.createdById,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _createdBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    batchId,
    title,
    body,
    kind,
    relatedLiveClassId,
    createdById,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'batch') {
      return batch;
    }
    if (relationField == 'createdBy') {
      return createdBy;
    }
    return null;
  }
}

class BatchAnnouncementInclude extends _i1.IncludeObject {
  BatchAnnouncementInclude._({
    _i2.TrainingBatchInclude? batch,
    _i3.PharmaUserInclude? createdBy,
  }) {
    _batch = batch;
    _createdBy = createdBy;
  }

  _i2.TrainingBatchInclude? _batch;

  _i3.PharmaUserInclude? _createdBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'batch': _batch,
    'createdBy': _createdBy,
  };

  @override
  _i1.Table<int?> get table => BatchAnnouncement.t;
}

class BatchAnnouncementIncludeList extends _i1.IncludeList {
  BatchAnnouncementIncludeList._({
    _i1.WhereExpressionBuilder<BatchAnnouncementTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BatchAnnouncement.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BatchAnnouncement.t;
}

class BatchAnnouncementRepository {
  const BatchAnnouncementRepository._();

  final attachRow = const BatchAnnouncementAttachRowRepository._();

  final detachRow = const BatchAnnouncementDetachRowRepository._();

  /// Returns a list of [BatchAnnouncement]s matching the given query parameters.
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
  Future<List<BatchAnnouncement>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BatchAnnouncementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BatchAnnouncementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BatchAnnouncementTable>? orderByList,
    _i1.Transaction? transaction,
    BatchAnnouncementInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BatchAnnouncement>(
      where: where?.call(BatchAnnouncement.t),
      orderBy: orderBy?.call(BatchAnnouncement.t),
      orderByList: orderByList?.call(BatchAnnouncement.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BatchAnnouncement] matching the given query parameters.
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
  Future<BatchAnnouncement?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BatchAnnouncementTable>? where,
    int? offset,
    _i1.OrderByBuilder<BatchAnnouncementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BatchAnnouncementTable>? orderByList,
    _i1.Transaction? transaction,
    BatchAnnouncementInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BatchAnnouncement>(
      where: where?.call(BatchAnnouncement.t),
      orderBy: orderBy?.call(BatchAnnouncement.t),
      orderByList: orderByList?.call(BatchAnnouncement.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BatchAnnouncement] by its [id] or null if no such row exists.
  Future<BatchAnnouncement?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    BatchAnnouncementInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BatchAnnouncement>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BatchAnnouncement]s in the list and returns the inserted rows.
  ///
  /// The returned [BatchAnnouncement]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BatchAnnouncement>> insert(
    _i1.DatabaseSession session,
    List<BatchAnnouncement> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BatchAnnouncement>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BatchAnnouncement] and returns the inserted row.
  ///
  /// The returned [BatchAnnouncement] will have its `id` field set.
  Future<BatchAnnouncement> insertRow(
    _i1.DatabaseSession session,
    BatchAnnouncement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BatchAnnouncement>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BatchAnnouncement]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BatchAnnouncement>> update(
    _i1.DatabaseSession session,
    List<BatchAnnouncement> rows, {
    _i1.ColumnSelections<BatchAnnouncementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BatchAnnouncement>(
      rows,
      columns: columns?.call(BatchAnnouncement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BatchAnnouncement]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BatchAnnouncement> updateRow(
    _i1.DatabaseSession session,
    BatchAnnouncement row, {
    _i1.ColumnSelections<BatchAnnouncementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BatchAnnouncement>(
      row,
      columns: columns?.call(BatchAnnouncement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BatchAnnouncement] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BatchAnnouncement?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BatchAnnouncementUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BatchAnnouncement>(
      id,
      columnValues: columnValues(BatchAnnouncement.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BatchAnnouncement]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BatchAnnouncement>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BatchAnnouncementUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BatchAnnouncementTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BatchAnnouncementTable>? orderBy,
    _i1.OrderByListBuilder<BatchAnnouncementTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BatchAnnouncement>(
      columnValues: columnValues(BatchAnnouncement.t.updateTable),
      where: where(BatchAnnouncement.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BatchAnnouncement.t),
      orderByList: orderByList?.call(BatchAnnouncement.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BatchAnnouncement]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BatchAnnouncement>> delete(
    _i1.DatabaseSession session,
    List<BatchAnnouncement> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BatchAnnouncement>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BatchAnnouncement].
  Future<BatchAnnouncement> deleteRow(
    _i1.DatabaseSession session,
    BatchAnnouncement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BatchAnnouncement>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BatchAnnouncement>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BatchAnnouncementTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BatchAnnouncement>(
      where: where(BatchAnnouncement.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BatchAnnouncementTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BatchAnnouncement>(
      where: where?.call(BatchAnnouncement.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BatchAnnouncement] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BatchAnnouncementTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BatchAnnouncement>(
      where: where(BatchAnnouncement.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BatchAnnouncementAttachRowRepository {
  const BatchAnnouncementAttachRowRepository._();

  /// Creates a relation between the given [BatchAnnouncement] and [TrainingBatch]
  /// by setting the [BatchAnnouncement]'s foreign key `batchId` to refer to the [TrainingBatch].
  Future<void> batch(
    _i1.DatabaseSession session,
    BatchAnnouncement batchAnnouncement,
    _i2.TrainingBatch batch, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAnnouncement.id == null) {
      throw ArgumentError.notNull('batchAnnouncement.id');
    }
    if (batch.id == null) {
      throw ArgumentError.notNull('batch.id');
    }

    var $batchAnnouncement = batchAnnouncement.copyWith(batchId: batch.id);
    await session.db.updateRow<BatchAnnouncement>(
      $batchAnnouncement,
      columns: [BatchAnnouncement.t.batchId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BatchAnnouncement] and [PharmaUser]
  /// by setting the [BatchAnnouncement]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.DatabaseSession session,
    BatchAnnouncement batchAnnouncement,
    _i3.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAnnouncement.id == null) {
      throw ArgumentError.notNull('batchAnnouncement.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $batchAnnouncement = batchAnnouncement.copyWith(
      createdById: createdBy.id,
    );
    await session.db.updateRow<BatchAnnouncement>(
      $batchAnnouncement,
      columns: [BatchAnnouncement.t.createdById],
      transaction: transaction,
    );
  }
}

class BatchAnnouncementDetachRowRepository {
  const BatchAnnouncementDetachRowRepository._();

  /// Detaches the relation between this [BatchAnnouncement] and the [PharmaUser] set in `createdBy`
  /// by setting the [BatchAnnouncement]'s foreign key `createdById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> createdBy(
    _i1.DatabaseSession session,
    BatchAnnouncement batchAnnouncement, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAnnouncement.id == null) {
      throw ArgumentError.notNull('batchAnnouncement.id');
    }

    var $batchAnnouncement = batchAnnouncement.copyWith(createdById: null);
    await session.db.updateRow<BatchAnnouncement>(
      $batchAnnouncement,
      columns: [BatchAnnouncement.t.createdById],
      transaction: transaction,
    );
  }
}
