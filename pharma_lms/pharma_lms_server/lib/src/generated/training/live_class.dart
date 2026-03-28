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

/// Live class session within a training batch.
abstract class LiveClass
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LiveClass._({
    this.id,
    required this.batchId,
    this.batch,
    required this.title,
    this.description,
    required this.scheduledAt,
    int? durationMinutes,
    this.meetingUrl,
    bool? autoRecording,
    this.createdById,
    this.createdBy,
    DateTime? createdAt,
  }) : durationMinutes = durationMinutes ?? 60,
       autoRecording = autoRecording ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory LiveClass({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    String? description,
    required DateTime scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) = _LiveClassImpl;

  factory LiveClass.fromJson(Map<String, dynamic> jsonSerialization) {
    return LiveClass(
      id: jsonSerialization['id'] as int?,
      batchId: jsonSerialization['batchId'] as int,
      batch: jsonSerialization['batch'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingBatch>(
              jsonSerialization['batch'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      scheduledAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledAt'],
      ),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      meetingUrl: jsonSerialization['meetingUrl'] as String?,
      autoRecording: jsonSerialization['autoRecording'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['autoRecording']),
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

  static final t = LiveClassTable();

  static const db = LiveClassRepository._();

  @override
  int? id;

  int batchId;

  /// The training batch.
  _i2.TrainingBatch? batch;

  /// Session title.
  String title;

  /// Session description.
  String? description;

  /// When the session is scheduled.
  DateTime scheduledAt;

  /// Duration in minutes.
  int durationMinutes;

  /// Meeting/conference URL.
  String? meetingUrl;

  /// Whether auto-recording is enabled.
  bool autoRecording;

  int? createdById;

  /// User who created this session.
  _i3.PharmaUser? createdBy;

  /// Created timestamp.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LiveClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LiveClass copyWith({
    int? id,
    int? batchId,
    _i2.TrainingBatch? batch,
    String? title,
    String? description,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LiveClass',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'scheduledAt': scheduledAt.toJson(),
      'durationMinutes': durationMinutes,
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      'autoRecording': autoRecording,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LiveClass',
      if (id != null) 'id': id,
      'batchId': batchId,
      if (batch != null) 'batch': batch?.toJsonForProtocol(),
      'title': title,
      if (description != null) 'description': description,
      'scheduledAt': scheduledAt.toJson(),
      'durationMinutes': durationMinutes,
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      'autoRecording': autoRecording,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static LiveClassInclude include({
    _i2.TrainingBatchInclude? batch,
    _i3.PharmaUserInclude? createdBy,
  }) {
    return LiveClassInclude._(
      batch: batch,
      createdBy: createdBy,
    );
  }

  static LiveClassIncludeList includeList({
    _i1.WhereExpressionBuilder<LiveClassTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LiveClassTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LiveClassTable>? orderByList,
    LiveClassInclude? include,
  }) {
    return LiveClassIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LiveClass.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LiveClass.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LiveClassImpl extends LiveClass {
  _LiveClassImpl({
    int? id,
    required int batchId,
    _i2.TrainingBatch? batch,
    required String title,
    String? description,
    required DateTime scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         batchId: batchId,
         batch: batch,
         title: title,
         description: description,
         scheduledAt: scheduledAt,
         durationMinutes: durationMinutes,
         meetingUrl: meetingUrl,
         autoRecording: autoRecording,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LiveClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LiveClass copyWith({
    Object? id = _Undefined,
    int? batchId,
    Object? batch = _Undefined,
    String? title,
    Object? description = _Undefined,
    DateTime? scheduledAt,
    int? durationMinutes,
    Object? meetingUrl = _Undefined,
    bool? autoRecording,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
  }) {
    return LiveClass(
      id: id is int? ? id : this.id,
      batchId: batchId ?? this.batchId,
      batch: batch is _i2.TrainingBatch? ? batch : this.batch?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      meetingUrl: meetingUrl is String? ? meetingUrl : this.meetingUrl,
      autoRecording: autoRecording ?? this.autoRecording,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LiveClassUpdateTable extends _i1.UpdateTable<LiveClassTable> {
  LiveClassUpdateTable(super.table);

  _i1.ColumnValue<int, int> batchId(int value) => _i1.ColumnValue(
    table.batchId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> scheduledAt(DateTime value) =>
      _i1.ColumnValue(
        table.scheduledAt,
        value,
      );

  _i1.ColumnValue<int, int> durationMinutes(int value) => _i1.ColumnValue(
    table.durationMinutes,
    value,
  );

  _i1.ColumnValue<String, String> meetingUrl(String? value) => _i1.ColumnValue(
    table.meetingUrl,
    value,
  );

  _i1.ColumnValue<bool, bool> autoRecording(bool value) => _i1.ColumnValue(
    table.autoRecording,
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

class LiveClassTable extends _i1.Table<int?> {
  LiveClassTable({super.tableRelation}) : super(tableName: 'live_class') {
    updateTable = LiveClassUpdateTable(this);
    batchId = _i1.ColumnInt(
      'batchId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    scheduledAt = _i1.ColumnDateTime(
      'scheduledAt',
      this,
    );
    durationMinutes = _i1.ColumnInt(
      'durationMinutes',
      this,
      hasDefault: true,
    );
    meetingUrl = _i1.ColumnString(
      'meetingUrl',
      this,
    );
    autoRecording = _i1.ColumnBool(
      'autoRecording',
      this,
      hasDefault: true,
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

  late final LiveClassUpdateTable updateTable;

  late final _i1.ColumnInt batchId;

  /// The training batch.
  _i2.TrainingBatchTable? _batch;

  /// Session title.
  late final _i1.ColumnString title;

  /// Session description.
  late final _i1.ColumnString description;

  /// When the session is scheduled.
  late final _i1.ColumnDateTime scheduledAt;

  /// Duration in minutes.
  late final _i1.ColumnInt durationMinutes;

  /// Meeting/conference URL.
  late final _i1.ColumnString meetingUrl;

  /// Whether auto-recording is enabled.
  late final _i1.ColumnBool autoRecording;

  late final _i1.ColumnInt createdById;

  /// User who created this session.
  _i3.PharmaUserTable? _createdBy;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  _i2.TrainingBatchTable get batch {
    if (_batch != null) return _batch!;
    _batch = _i1.createRelationTable(
      relationFieldName: 'batch',
      field: LiveClass.t.batchId,
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
      field: LiveClass.t.createdById,
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
    description,
    scheduledAt,
    durationMinutes,
    meetingUrl,
    autoRecording,
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

class LiveClassInclude extends _i1.IncludeObject {
  LiveClassInclude._({
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
  _i1.Table<int?> get table => LiveClass.t;
}

class LiveClassIncludeList extends _i1.IncludeList {
  LiveClassIncludeList._({
    _i1.WhereExpressionBuilder<LiveClassTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LiveClass.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LiveClass.t;
}

class LiveClassRepository {
  const LiveClassRepository._();

  final attachRow = const LiveClassAttachRowRepository._();

  final detachRow = const LiveClassDetachRowRepository._();

  /// Returns a list of [LiveClass]s matching the given query parameters.
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
  Future<List<LiveClass>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LiveClassTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LiveClassTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LiveClassTable>? orderByList,
    _i1.Transaction? transaction,
    LiveClassInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LiveClass>(
      where: where?.call(LiveClass.t),
      orderBy: orderBy?.call(LiveClass.t),
      orderByList: orderByList?.call(LiveClass.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LiveClass] matching the given query parameters.
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
  Future<LiveClass?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LiveClassTable>? where,
    int? offset,
    _i1.OrderByBuilder<LiveClassTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LiveClassTable>? orderByList,
    _i1.Transaction? transaction,
    LiveClassInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LiveClass>(
      where: where?.call(LiveClass.t),
      orderBy: orderBy?.call(LiveClass.t),
      orderByList: orderByList?.call(LiveClass.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LiveClass] by its [id] or null if no such row exists.
  Future<LiveClass?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    LiveClassInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LiveClass>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LiveClass]s in the list and returns the inserted rows.
  ///
  /// The returned [LiveClass]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LiveClass>> insert(
    _i1.DatabaseSession session,
    List<LiveClass> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LiveClass>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LiveClass] and returns the inserted row.
  ///
  /// The returned [LiveClass] will have its `id` field set.
  Future<LiveClass> insertRow(
    _i1.DatabaseSession session,
    LiveClass row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LiveClass>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LiveClass]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LiveClass>> update(
    _i1.DatabaseSession session,
    List<LiveClass> rows, {
    _i1.ColumnSelections<LiveClassTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LiveClass>(
      rows,
      columns: columns?.call(LiveClass.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LiveClass]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LiveClass> updateRow(
    _i1.DatabaseSession session,
    LiveClass row, {
    _i1.ColumnSelections<LiveClassTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LiveClass>(
      row,
      columns: columns?.call(LiveClass.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LiveClass] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LiveClass?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LiveClassUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LiveClass>(
      id,
      columnValues: columnValues(LiveClass.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LiveClass]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LiveClass>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LiveClassUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LiveClassTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LiveClassTable>? orderBy,
    _i1.OrderByListBuilder<LiveClassTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LiveClass>(
      columnValues: columnValues(LiveClass.t.updateTable),
      where: where(LiveClass.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LiveClass.t),
      orderByList: orderByList?.call(LiveClass.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LiveClass]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LiveClass>> delete(
    _i1.DatabaseSession session,
    List<LiveClass> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LiveClass>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LiveClass].
  Future<LiveClass> deleteRow(
    _i1.DatabaseSession session,
    LiveClass row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LiveClass>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LiveClass>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LiveClassTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LiveClass>(
      where: where(LiveClass.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LiveClassTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LiveClass>(
      where: where?.call(LiveClass.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LiveClass] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LiveClassTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LiveClass>(
      where: where(LiveClass.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LiveClassAttachRowRepository {
  const LiveClassAttachRowRepository._();

  /// Creates a relation between the given [LiveClass] and [TrainingBatch]
  /// by setting the [LiveClass]'s foreign key `batchId` to refer to the [TrainingBatch].
  Future<void> batch(
    _i1.DatabaseSession session,
    LiveClass liveClass,
    _i2.TrainingBatch batch, {
    _i1.Transaction? transaction,
  }) async {
    if (liveClass.id == null) {
      throw ArgumentError.notNull('liveClass.id');
    }
    if (batch.id == null) {
      throw ArgumentError.notNull('batch.id');
    }

    var $liveClass = liveClass.copyWith(batchId: batch.id);
    await session.db.updateRow<LiveClass>(
      $liveClass,
      columns: [LiveClass.t.batchId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LiveClass] and [PharmaUser]
  /// by setting the [LiveClass]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.DatabaseSession session,
    LiveClass liveClass,
    _i3.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (liveClass.id == null) {
      throw ArgumentError.notNull('liveClass.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $liveClass = liveClass.copyWith(createdById: createdBy.id);
    await session.db.updateRow<LiveClass>(
      $liveClass,
      columns: [LiveClass.t.createdById],
      transaction: transaction,
    );
  }
}

class LiveClassDetachRowRepository {
  const LiveClassDetachRowRepository._();

  /// Detaches the relation between this [LiveClass] and the [PharmaUser] set in `createdBy`
  /// by setting the [LiveClass]'s foreign key `createdById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> createdBy(
    _i1.DatabaseSession session,
    LiveClass liveClass, {
    _i1.Transaction? transaction,
  }) async {
    if (liveClass.id == null) {
      throw ArgumentError.notNull('liveClass.id');
    }

    var $liveClass = liveClass.copyWith(createdById: null);
    await session.db.updateRow<LiveClass>(
      $liveClass,
      columns: [LiveClass.t.createdById],
      transaction: transaction,
    );
  }
}
