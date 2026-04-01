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
import '../training/live_class.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Batch attendance record for ILT sessions.
abstract class BatchAttendanceRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BatchAttendanceRecord._({
    this.id,
    required this.batchId,
    this.batch,
    this.liveClassId,
    this.liveClass,
    required this.userId,
    this.user,
    String? status,
    DateTime? markedAt,
    required this.markedById,
    this.markedBy,
    this.notes,
  }) : status = status ?? 'present',
       markedAt = markedAt ?? DateTime.now();

  factory BatchAttendanceRecord({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    int? liveClassId,
    _i3.LiveClass? liveClass,
    required int userId,
    _i4.PharmaUser? user,
    String? status,
    DateTime? markedAt,
    required int markedById,
    _i4.PharmaUser? markedBy,
    String? notes,
  }) = _BatchAttendanceRecordImpl;

  factory BatchAttendanceRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BatchAttendanceRecord(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      liveClassId: jsonSerialization['liveClassId'] as int?,
      liveClass: jsonSerialization['liveClass'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.LiveClass>(
              jsonSerialization['liveClass'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['user'],
            ),
      status: jsonSerialization['status'] as String?,
      markedAt: jsonSerialization['markedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['markedAt']),
      markedById: jsonSerialization['markedById'] as int,
      markedBy: jsonSerialization['markedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['markedBy'],
            ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = BatchAttendanceRecordTable();

  static const db = BatchAttendanceRecordRepository._();

  @override
  int? id;

  int batchId;

  /// The training batch.
  _i2.TrainingBatch? batch;

  int? liveClassId;

  /// The live class session (if applicable).
  _i3.LiveClass? liveClass;

  int userId;

  /// The user who attended.
  _i4.PharmaUser? user;

  /// Attendance status: present, absent, excused, late.
  String status;

  /// When attendance was marked.
  DateTime markedAt;

  int markedById;

  /// Who marked attendance (instructor/admin).
  _i4.PharmaUser? markedBy;

  /// Notes (reason for absence, etc.).
  String? notes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BatchAttendanceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchAttendanceRecord copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    int? liveClassId,
    _i3.LiveClass? liveClass,
    int? userId,
    _i4.PharmaUser? user,
    String? status,
    DateTime? markedAt,
    int? markedById,
    _i4.PharmaUser? markedBy,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BatchAttendanceRecord',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      if (liveClassId != null) 'liveClassId': liveClassId,
      if (liveClass != null) 'liveClass': liveClass?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'status': status,
      'markedAt': markedAt.toJson(),
      'markedById': markedById,
      if (markedBy != null) 'markedBy': markedBy?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BatchAttendanceRecord',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJsonForProtocol(),
      if (liveClassId != null) 'liveClassId': liveClassId,
      if (liveClass != null) 'liveClass': liveClass?.toJsonForProtocol(),
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'status': status,
      'markedAt': markedAt.toJson(),
      'markedById': markedById,
      if (markedBy != null) 'markedBy': markedBy?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
    };
  }

  static BatchAttendanceRecordInclude include({
    _i2.TrainingBatchInclude? batch,
    _i3.LiveClassInclude? liveClass,
    _i4.PharmaUserInclude? user,
    _i4.PharmaUserInclude? markedBy,
  }) {
    return BatchAttendanceRecordInclude._(
      batch: batch,
      liveClass: liveClass,
      user: user,
      markedBy: markedBy,
    );
  }

  static BatchAttendanceRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<BatchAttendanceRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BatchAttendanceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BatchAttendanceRecordTable>? orderByList,
    BatchAttendanceRecordInclude? include,
  }) {
    return BatchAttendanceRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BatchAttendanceRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BatchAttendanceRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchAttendanceRecordImpl extends BatchAttendanceRecord {
  _BatchAttendanceRecordImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    int? liveClassId,
    _i3.LiveClass? liveClass,
    required int userId,
    _i4.PharmaUser? user,
    String? status,
    DateTime? markedAt,
    required int markedById,
    _i4.PharmaUser? markedBy,
    String? notes,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         liveClassId: liveClassId,
         liveClass: liveClass,
         userId: userId,
         user: user,
         status: status,
         markedAt: markedAt,
         markedById: markedById,
         markedBy: markedBy,
         notes: notes,
       );

  /// Returns a shallow copy of this [BatchAttendanceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchAttendanceRecord copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    Object? liveClassId = _Undefined,
    Object? liveClass = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? status,
    DateTime? markedAt,
    int? markedById,
    Object? markedBy = _Undefined,
    Object? notes = _Undefined,
  }) {
    return BatchAttendanceRecord(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      liveClassId: liveClassId is int? ? liveClassId : this.liveClassId,
      liveClass: liveClass is _i3.LiveClass?
          ? liveClass
          : this.liveClass?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i4.PharmaUser? ? user : this.user?.copyWith(),
      status: status ?? this.status,
      markedAt: markedAt ?? this.markedAt,
      markedById: markedById ?? this.markedById,
      markedBy: markedBy is _i4.PharmaUser?
          ? markedBy
          : this.markedBy?.copyWith(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class BatchAttendanceRecordUpdateTable
    extends _i1.UpdateTable<BatchAttendanceRecordTable> {
  BatchAttendanceRecordUpdateTable(super.table);

  _i1.ColumnValue<int, int> batchId(int value) => _i1.ColumnValue(
    table.batchId,
    value,
  );

  _i1.ColumnValue<int, int> liveClassId(int? value) => _i1.ColumnValue(
    table.liveClassId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> markedAt(DateTime value) =>
      _i1.ColumnValue(
        table.markedAt,
        value,
      );

  _i1.ColumnValue<int, int> markedById(int value) => _i1.ColumnValue(
    table.markedById,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );
}

class BatchAttendanceRecordTable extends _i1.Table<int?> {
  BatchAttendanceRecordTable({super.tableRelation})
    : super(tableName: 'batch_attendance_record') {
    updateTable = BatchAttendanceRecordUpdateTable(this);
    batchId = _i1.ColumnInt(
      'batchId',
      this,
    );
    liveClassId = _i1.ColumnInt(
      'liveClassId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    markedAt = _i1.ColumnDateTime(
      'markedAt',
      this,
      hasDefault: true,
    );
    markedById = _i1.ColumnInt(
      'markedById',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final BatchAttendanceRecordUpdateTable updateTable;

  late final _i1.ColumnInt batchId;

  /// The training batch.
  _i2.TrainingBatchTable? _batch;

  late final _i1.ColumnInt liveClassId;

  /// The live class session (if applicable).
  _i3.LiveClassTable? _liveClass;

  late final _i1.ColumnInt userId;

  /// The user who attended.
  _i4.PharmaUserTable? _user;

  /// Attendance status: present, absent, excused, late.
  late final _i1.ColumnString status;

  /// When attendance was marked.
  late final _i1.ColumnDateTime markedAt;

  late final _i1.ColumnInt markedById;

  /// Who marked attendance (instructor/admin).
  _i4.PharmaUserTable? _markedBy;

  /// Notes (reason for absence, etc.).
  late final _i1.ColumnString notes;

  _i2.TrainingBatchTable get batch {
    if (_batch != null) return _batch!;
    _batch = _i1.createRelationTable(
      relationFieldName: 'batch',
      field: BatchAttendanceRecord.t.batchId,
      foreignField: _i2.TrainingBatch.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingBatchTable(tableRelation: foreignTableRelation),
    );
    return _batch!;
  }

  _i3.LiveClassTable get liveClass {
    if (_liveClass != null) return _liveClass!;
    _liveClass = _i1.createRelationTable(
      relationFieldName: 'liveClass',
      field: BatchAttendanceRecord.t.liveClassId,
      foreignField: _i3.LiveClass.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LiveClassTable(tableRelation: foreignTableRelation),
    );
    return _liveClass!;
  }

  _i4.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: BatchAttendanceRecord.t.userId,
      foreignField: _i4.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i4.PharmaUserTable get markedBy {
    if (_markedBy != null) return _markedBy!;
    _markedBy = _i1.createRelationTable(
      relationFieldName: 'markedBy',
      field: BatchAttendanceRecord.t.markedById,
      foreignField: _i4.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _markedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    batchId,
    liveClassId,
    userId,
    status,
    markedAt,
    markedById,
    notes,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'batch') {
      return batch;
    }
    if (relationField == 'liveClass') {
      return liveClass;
    }
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'markedBy') {
      return markedBy;
    }
    return null;
  }
}

class BatchAttendanceRecordInclude extends _i1.IncludeObject {
  BatchAttendanceRecordInclude._({
    _i2.TrainingBatchInclude? batch,
    _i3.LiveClassInclude? liveClass,
    _i4.PharmaUserInclude? user,
    _i4.PharmaUserInclude? markedBy,
  }) {
    _batch = batch;
    _liveClass = liveClass;
    _user = user;
    _markedBy = markedBy;
  }

  _i2.TrainingBatchInclude? _batch;

  _i3.LiveClassInclude? _liveClass;

  _i4.PharmaUserInclude? _user;

  _i4.PharmaUserInclude? _markedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'batch': _batch,
    'liveClass': _liveClass,
    'user': _user,
    'markedBy': _markedBy,
  };

  @override
  _i1.Table<int?> get table => BatchAttendanceRecord.t;
}

class BatchAttendanceRecordIncludeList extends _i1.IncludeList {
  BatchAttendanceRecordIncludeList._({
    _i1.WhereExpressionBuilder<BatchAttendanceRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BatchAttendanceRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BatchAttendanceRecord.t;
}

class BatchAttendanceRecordRepository {
  const BatchAttendanceRecordRepository._();

  final attachRow = const BatchAttendanceRecordAttachRowRepository._();

  final detachRow = const BatchAttendanceRecordDetachRowRepository._();

  /// Returns a list of [BatchAttendanceRecord]s matching the given query parameters.
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
  Future<List<BatchAttendanceRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BatchAttendanceRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BatchAttendanceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BatchAttendanceRecordTable>? orderByList,
    _i1.Transaction? transaction,
    BatchAttendanceRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BatchAttendanceRecord>(
      where: where?.call(BatchAttendanceRecord.t),
      orderBy: orderBy?.call(BatchAttendanceRecord.t),
      orderByList: orderByList?.call(BatchAttendanceRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BatchAttendanceRecord] matching the given query parameters.
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
  Future<BatchAttendanceRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BatchAttendanceRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<BatchAttendanceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BatchAttendanceRecordTable>? orderByList,
    _i1.Transaction? transaction,
    BatchAttendanceRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BatchAttendanceRecord>(
      where: where?.call(BatchAttendanceRecord.t),
      orderBy: orderBy?.call(BatchAttendanceRecord.t),
      orderByList: orderByList?.call(BatchAttendanceRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BatchAttendanceRecord] by its [id] or null if no such row exists.
  Future<BatchAttendanceRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    BatchAttendanceRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BatchAttendanceRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BatchAttendanceRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [BatchAttendanceRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BatchAttendanceRecord>> insert(
    _i1.DatabaseSession session,
    List<BatchAttendanceRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BatchAttendanceRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BatchAttendanceRecord] and returns the inserted row.
  ///
  /// The returned [BatchAttendanceRecord] will have its `id` field set.
  Future<BatchAttendanceRecord> insertRow(
    _i1.DatabaseSession session,
    BatchAttendanceRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BatchAttendanceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BatchAttendanceRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BatchAttendanceRecord>> update(
    _i1.DatabaseSession session,
    List<BatchAttendanceRecord> rows, {
    _i1.ColumnSelections<BatchAttendanceRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BatchAttendanceRecord>(
      rows,
      columns: columns?.call(BatchAttendanceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BatchAttendanceRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BatchAttendanceRecord> updateRow(
    _i1.DatabaseSession session,
    BatchAttendanceRecord row, {
    _i1.ColumnSelections<BatchAttendanceRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BatchAttendanceRecord>(
      row,
      columns: columns?.call(BatchAttendanceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BatchAttendanceRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BatchAttendanceRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BatchAttendanceRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BatchAttendanceRecord>(
      id,
      columnValues: columnValues(BatchAttendanceRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BatchAttendanceRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BatchAttendanceRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BatchAttendanceRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BatchAttendanceRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BatchAttendanceRecordTable>? orderBy,
    _i1.OrderByListBuilder<BatchAttendanceRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BatchAttendanceRecord>(
      columnValues: columnValues(BatchAttendanceRecord.t.updateTable),
      where: where(BatchAttendanceRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BatchAttendanceRecord.t),
      orderByList: orderByList?.call(BatchAttendanceRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BatchAttendanceRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BatchAttendanceRecord>> delete(
    _i1.DatabaseSession session,
    List<BatchAttendanceRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BatchAttendanceRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BatchAttendanceRecord].
  Future<BatchAttendanceRecord> deleteRow(
    _i1.DatabaseSession session,
    BatchAttendanceRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BatchAttendanceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BatchAttendanceRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BatchAttendanceRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BatchAttendanceRecord>(
      where: where(BatchAttendanceRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BatchAttendanceRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BatchAttendanceRecord>(
      where: where?.call(BatchAttendanceRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BatchAttendanceRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BatchAttendanceRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BatchAttendanceRecord>(
      where: where(BatchAttendanceRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BatchAttendanceRecordAttachRowRepository {
  const BatchAttendanceRecordAttachRowRepository._();

  /// Creates a relation between the given [BatchAttendanceRecord] and [TrainingBatch]
  /// by setting the [BatchAttendanceRecord]'s foreign key `batchId` to refer to the [TrainingBatch].
  Future<void> batch(
    _i1.DatabaseSession session,
    BatchAttendanceRecord batchAttendanceRecord,
    _i2.TrainingBatch batch, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAttendanceRecord.id == null) {
      throw ArgumentError.notNull('batchAttendanceRecord.id');
    }
    if (batch.id == null) {
      throw ArgumentError.notNull('batch.id');
    }

    var $batchAttendanceRecord = batchAttendanceRecord.copyWith(
      batchId: batch.id,
    );
    await session.db.updateRow<BatchAttendanceRecord>(
      $batchAttendanceRecord,
      columns: [BatchAttendanceRecord.t.batchId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BatchAttendanceRecord] and [LiveClass]
  /// by setting the [BatchAttendanceRecord]'s foreign key `liveClassId` to refer to the [LiveClass].
  Future<void> liveClass(
    _i1.DatabaseSession session,
    BatchAttendanceRecord batchAttendanceRecord,
    _i3.LiveClass liveClass, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAttendanceRecord.id == null) {
      throw ArgumentError.notNull('batchAttendanceRecord.id');
    }
    if (liveClass.id == null) {
      throw ArgumentError.notNull('liveClass.id');
    }

    var $batchAttendanceRecord = batchAttendanceRecord.copyWith(
      liveClassId: liveClass.id,
    );
    await session.db.updateRow<BatchAttendanceRecord>(
      $batchAttendanceRecord,
      columns: [BatchAttendanceRecord.t.liveClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BatchAttendanceRecord] and [PharmaUser]
  /// by setting the [BatchAttendanceRecord]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    BatchAttendanceRecord batchAttendanceRecord,
    _i4.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAttendanceRecord.id == null) {
      throw ArgumentError.notNull('batchAttendanceRecord.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $batchAttendanceRecord = batchAttendanceRecord.copyWith(
      userId: user.id,
    );
    await session.db.updateRow<BatchAttendanceRecord>(
      $batchAttendanceRecord,
      columns: [BatchAttendanceRecord.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BatchAttendanceRecord] and [PharmaUser]
  /// by setting the [BatchAttendanceRecord]'s foreign key `markedById` to refer to the [PharmaUser].
  Future<void> markedBy(
    _i1.DatabaseSession session,
    BatchAttendanceRecord batchAttendanceRecord,
    _i4.PharmaUser markedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAttendanceRecord.id == null) {
      throw ArgumentError.notNull('batchAttendanceRecord.id');
    }
    if (markedBy.id == null) {
      throw ArgumentError.notNull('markedBy.id');
    }

    var $batchAttendanceRecord = batchAttendanceRecord.copyWith(
      markedById: markedBy.id,
    );
    await session.db.updateRow<BatchAttendanceRecord>(
      $batchAttendanceRecord,
      columns: [BatchAttendanceRecord.t.markedById],
      transaction: transaction,
    );
  }
}

class BatchAttendanceRecordDetachRowRepository {
  const BatchAttendanceRecordDetachRowRepository._();

  /// Detaches the relation between this [BatchAttendanceRecord] and the [LiveClass] set in `liveClass`
  /// by setting the [BatchAttendanceRecord]'s foreign key `liveClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> liveClass(
    _i1.DatabaseSession session,
    BatchAttendanceRecord batchAttendanceRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (batchAttendanceRecord.id == null) {
      throw ArgumentError.notNull('batchAttendanceRecord.id');
    }

    var $batchAttendanceRecord = batchAttendanceRecord.copyWith(
      liveClassId: null,
    );
    await session.db.updateRow<BatchAttendanceRecord>(
      $batchAttendanceRecord,
      columns: [BatchAttendanceRecord.t.liveClassId],
      transaction: transaction,
    );
  }
}
