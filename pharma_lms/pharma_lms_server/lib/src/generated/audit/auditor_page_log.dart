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
import '../audit/auditor_session.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Auditor page view log. FDA 21 CFR Part 11.
abstract class AuditorPageLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AuditorPageLog._({
    this.id,
    required this.auditorSessionId,
    this.auditorSession,
    required this.pageUrl,
    this.pageTitle,
    this.entityType,
    this.entityId,
    DateTime? viewedAt,
    this.timeOnPageSeconds,
    bool? exported,
  }) : viewedAt = viewedAt ?? DateTime.now(),
       exported = exported ?? false;

  factory AuditorPageLog({
    int? id,
    required int auditorSessionId,
    _i2.AuditorSession? auditorSession,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    DateTime? viewedAt,
    int? timeOnPageSeconds,
    bool? exported,
  }) = _AuditorPageLogImpl;

  factory AuditorPageLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditorPageLog(
      id: jsonSerialization['id'] as int?,
      auditorSessionId: jsonSerialization['auditorSessionId'] as int,
      auditorSession: jsonSerialization['auditorSession'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuditorSession>(
              jsonSerialization['auditorSession'],
            ),
      pageUrl: jsonSerialization['pageUrl'] as String,
      pageTitle: jsonSerialization['pageTitle'] as String?,
      entityType: jsonSerialization['entityType'] as String?,
      entityId: jsonSerialization['entityId'] as String?,
      viewedAt: jsonSerialization['viewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['viewedAt']),
      timeOnPageSeconds: jsonSerialization['timeOnPageSeconds'] as int?,
      exported: jsonSerialization['exported'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['exported']),
    );
  }

  static final t = AuditorPageLogTable();

  static const db = AuditorPageLogRepository._();

  @override
  int? id;

  int auditorSessionId;

  /// The auditor session.
  _i2.AuditorSession? auditorSession;

  /// Page URL viewed.
  String pageUrl;

  /// Page title.
  String? pageTitle;

  /// Entity type: training_record, certificate, esignature, audit_trail, capa, report.
  String? entityType;

  /// Entity ID.
  String? entityId;

  /// When viewed.
  DateTime viewedAt;

  /// Time on page in seconds.
  int? timeOnPageSeconds;

  /// Whether page was exported.
  bool exported;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditorPageLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditorPageLog copyWith({
    int? id,
    int? auditorSessionId,
    _i2.AuditorSession? auditorSession,
    String? pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    DateTime? viewedAt,
    int? timeOnPageSeconds,
    bool? exported,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditorPageLog',
      if (id != null) 'id': id,
      'auditorSessionId': auditorSessionId,
      if (auditorSession != null) 'auditorSession': auditorSession?.toJson(),
      'pageUrl': pageUrl,
      if (pageTitle != null) 'pageTitle': pageTitle,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      'viewedAt': viewedAt.toJson(),
      if (timeOnPageSeconds != null) 'timeOnPageSeconds': timeOnPageSeconds,
      'exported': exported,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditorPageLog',
      if (id != null) 'id': id,
      'auditorSessionId': auditorSessionId,
      if (auditorSession != null)
        'auditorSession': auditorSession?.toJsonForProtocol(),
      'pageUrl': pageUrl,
      if (pageTitle != null) 'pageTitle': pageTitle,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      'viewedAt': viewedAt.toJson(),
      if (timeOnPageSeconds != null) 'timeOnPageSeconds': timeOnPageSeconds,
      'exported': exported,
    };
  }

  static AuditorPageLogInclude include({
    _i2.AuditorSessionInclude? auditorSession,
  }) {
    return AuditorPageLogInclude._(auditorSession: auditorSession);
  }

  static AuditorPageLogIncludeList includeList({
    _i1.WhereExpressionBuilder<AuditorPageLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditorPageLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditorPageLogTable>? orderByList,
    AuditorPageLogInclude? include,
  }) {
    return AuditorPageLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditorPageLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AuditorPageLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditorPageLogImpl extends AuditorPageLog {
  _AuditorPageLogImpl({
    int? id,
    required int auditorSessionId,
    _i2.AuditorSession? auditorSession,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    DateTime? viewedAt,
    int? timeOnPageSeconds,
    bool? exported,
  }) : super._(
         id: id,
         auditorSessionId: auditorSessionId,
         auditorSession: auditorSession,
         pageUrl: pageUrl,
         pageTitle: pageTitle,
         entityType: entityType,
         entityId: entityId,
         viewedAt: viewedAt,
         timeOnPageSeconds: timeOnPageSeconds,
         exported: exported,
       );

  /// Returns a shallow copy of this [AuditorPageLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditorPageLog copyWith({
    Object? id = _Undefined,
    int? auditorSessionId,
    Object? auditorSession = _Undefined,
    String? pageUrl,
    Object? pageTitle = _Undefined,
    Object? entityType = _Undefined,
    Object? entityId = _Undefined,
    DateTime? viewedAt,
    Object? timeOnPageSeconds = _Undefined,
    bool? exported,
  }) {
    return AuditorPageLog(
      id: id is int? ? id : this.id,
      auditorSessionId: auditorSessionId ?? this.auditorSessionId,
      auditorSession: auditorSession is _i2.AuditorSession?
          ? auditorSession
          : this.auditorSession?.copyWith(),
      pageUrl: pageUrl ?? this.pageUrl,
      pageTitle: pageTitle is String? ? pageTitle : this.pageTitle,
      entityType: entityType is String? ? entityType : this.entityType,
      entityId: entityId is String? ? entityId : this.entityId,
      viewedAt: viewedAt ?? this.viewedAt,
      timeOnPageSeconds: timeOnPageSeconds is int?
          ? timeOnPageSeconds
          : this.timeOnPageSeconds,
      exported: exported ?? this.exported,
    );
  }
}

class AuditorPageLogUpdateTable extends _i1.UpdateTable<AuditorPageLogTable> {
  AuditorPageLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> auditorSessionId(int value) => _i1.ColumnValue(
    table.auditorSessionId,
    value,
  );

  _i1.ColumnValue<String, String> pageUrl(String value) => _i1.ColumnValue(
    table.pageUrl,
    value,
  );

  _i1.ColumnValue<String, String> pageTitle(String? value) => _i1.ColumnValue(
    table.pageTitle,
    value,
  );

  _i1.ColumnValue<String, String> entityType(String? value) => _i1.ColumnValue(
    table.entityType,
    value,
  );

  _i1.ColumnValue<String, String> entityId(String? value) => _i1.ColumnValue(
    table.entityId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> viewedAt(DateTime value) =>
      _i1.ColumnValue(
        table.viewedAt,
        value,
      );

  _i1.ColumnValue<int, int> timeOnPageSeconds(int? value) => _i1.ColumnValue(
    table.timeOnPageSeconds,
    value,
  );

  _i1.ColumnValue<bool, bool> exported(bool value) => _i1.ColumnValue(
    table.exported,
    value,
  );
}

class AuditorPageLogTable extends _i1.Table<int?> {
  AuditorPageLogTable({super.tableRelation})
    : super(tableName: 'auditor_page_log') {
    updateTable = AuditorPageLogUpdateTable(this);
    auditorSessionId = _i1.ColumnInt(
      'auditorSessionId',
      this,
    );
    pageUrl = _i1.ColumnString(
      'pageUrl',
      this,
    );
    pageTitle = _i1.ColumnString(
      'pageTitle',
      this,
    );
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    entityId = _i1.ColumnString(
      'entityId',
      this,
    );
    viewedAt = _i1.ColumnDateTime(
      'viewedAt',
      this,
      hasDefault: true,
    );
    timeOnPageSeconds = _i1.ColumnInt(
      'timeOnPageSeconds',
      this,
    );
    exported = _i1.ColumnBool(
      'exported',
      this,
      hasDefault: true,
    );
  }

  late final AuditorPageLogUpdateTable updateTable;

  late final _i1.ColumnInt auditorSessionId;

  /// The auditor session.
  _i2.AuditorSessionTable? _auditorSession;

  /// Page URL viewed.
  late final _i1.ColumnString pageUrl;

  /// Page title.
  late final _i1.ColumnString pageTitle;

  /// Entity type: training_record, certificate, esignature, audit_trail, capa, report.
  late final _i1.ColumnString entityType;

  /// Entity ID.
  late final _i1.ColumnString entityId;

  /// When viewed.
  late final _i1.ColumnDateTime viewedAt;

  /// Time on page in seconds.
  late final _i1.ColumnInt timeOnPageSeconds;

  /// Whether page was exported.
  late final _i1.ColumnBool exported;

  _i2.AuditorSessionTable get auditorSession {
    if (_auditorSession != null) return _auditorSession!;
    _auditorSession = _i1.createRelationTable(
      relationFieldName: 'auditorSession',
      field: AuditorPageLog.t.auditorSessionId,
      foreignField: _i2.AuditorSession.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuditorSessionTable(tableRelation: foreignTableRelation),
    );
    return _auditorSession!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    auditorSessionId,
    pageUrl,
    pageTitle,
    entityType,
    entityId,
    viewedAt,
    timeOnPageSeconds,
    exported,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'auditorSession') {
      return auditorSession;
    }
    return null;
  }
}

class AuditorPageLogInclude extends _i1.IncludeObject {
  AuditorPageLogInclude._({_i2.AuditorSessionInclude? auditorSession}) {
    _auditorSession = auditorSession;
  }

  _i2.AuditorSessionInclude? _auditorSession;

  @override
  Map<String, _i1.Include?> get includes => {'auditorSession': _auditorSession};

  @override
  _i1.Table<int?> get table => AuditorPageLog.t;
}

class AuditorPageLogIncludeList extends _i1.IncludeList {
  AuditorPageLogIncludeList._({
    _i1.WhereExpressionBuilder<AuditorPageLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditorPageLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AuditorPageLog.t;
}

class AuditorPageLogRepository {
  const AuditorPageLogRepository._();

  final attachRow = const AuditorPageLogAttachRowRepository._();

  /// Returns a list of [AuditorPageLog]s matching the given query parameters.
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
  Future<List<AuditorPageLog>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditorPageLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditorPageLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditorPageLogTable>? orderByList,
    _i1.Transaction? transaction,
    AuditorPageLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditorPageLog>(
      where: where?.call(AuditorPageLog.t),
      orderBy: orderBy?.call(AuditorPageLog.t),
      orderByList: orderByList?.call(AuditorPageLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditorPageLog] matching the given query parameters.
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
  Future<AuditorPageLog?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditorPageLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<AuditorPageLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditorPageLogTable>? orderByList,
    _i1.Transaction? transaction,
    AuditorPageLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditorPageLog>(
      where: where?.call(AuditorPageLog.t),
      orderBy: orderBy?.call(AuditorPageLog.t),
      orderByList: orderByList?.call(AuditorPageLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditorPageLog] by its [id] or null if no such row exists.
  Future<AuditorPageLog?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AuditorPageLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditorPageLog>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditorPageLog]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditorPageLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AuditorPageLog>> insert(
    _i1.DatabaseSession session,
    List<AuditorPageLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AuditorPageLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AuditorPageLog] and returns the inserted row.
  ///
  /// The returned [AuditorPageLog] will have its `id` field set.
  Future<AuditorPageLog> insertRow(
    _i1.DatabaseSession session,
    AuditorPageLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditorPageLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AuditorPageLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AuditorPageLog>> update(
    _i1.DatabaseSession session,
    List<AuditorPageLog> rows, {
    _i1.ColumnSelections<AuditorPageLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AuditorPageLog>(
      rows,
      columns: columns?.call(AuditorPageLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditorPageLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditorPageLog> updateRow(
    _i1.DatabaseSession session,
    AuditorPageLog row, {
    _i1.ColumnSelections<AuditorPageLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditorPageLog>(
      row,
      columns: columns?.call(AuditorPageLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditorPageLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditorPageLog?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AuditorPageLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditorPageLog>(
      id,
      columnValues: columnValues(AuditorPageLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditorPageLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AuditorPageLog>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AuditorPageLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AuditorPageLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditorPageLogTable>? orderBy,
    _i1.OrderByListBuilder<AuditorPageLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AuditorPageLog>(
      columnValues: columnValues(AuditorPageLog.t.updateTable),
      where: where(AuditorPageLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditorPageLog.t),
      orderByList: orderByList?.call(AuditorPageLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AuditorPageLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AuditorPageLog>> delete(
    _i1.DatabaseSession session,
    List<AuditorPageLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AuditorPageLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AuditorPageLog].
  Future<AuditorPageLog> deleteRow(
    _i1.DatabaseSession session,
    AuditorPageLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditorPageLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AuditorPageLog>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditorPageLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AuditorPageLog>(
      where: where(AuditorPageLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditorPageLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AuditorPageLog>(
      where: where?.call(AuditorPageLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditorPageLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditorPageLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditorPageLog>(
      where: where(AuditorPageLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AuditorPageLogAttachRowRepository {
  const AuditorPageLogAttachRowRepository._();

  /// Creates a relation between the given [AuditorPageLog] and [AuditorSession]
  /// by setting the [AuditorPageLog]'s foreign key `auditorSessionId` to refer to the [AuditorSession].
  Future<void> auditorSession(
    _i1.DatabaseSession session,
    AuditorPageLog auditorPageLog,
    _i2.AuditorSession auditorSession, {
    _i1.Transaction? transaction,
  }) async {
    if (auditorPageLog.id == null) {
      throw ArgumentError.notNull('auditorPageLog.id');
    }
    if (auditorSession.id == null) {
      throw ArgumentError.notNull('auditorSession.id');
    }

    var $auditorPageLog = auditorPageLog.copyWith(
      auditorSessionId: auditorSession.id,
    );
    await session.db.updateRow<AuditorPageLog>(
      $auditorPageLog,
      columns: [AuditorPageLog.t.auditorSessionId],
      transaction: transaction,
    );
  }
}
