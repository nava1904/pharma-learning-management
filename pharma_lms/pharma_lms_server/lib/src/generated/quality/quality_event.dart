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
import '../organization/site.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Quality event (deviation, CAPA, change control).
abstract class QualityEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QualityEvent._({
    this.id,
    required this.eventType,
    this.referenceId,
    required this.title,
    required this.status,
    this.siteId,
    this.site,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory QualityEvent({
    int? id,
    required String eventType,
    String? referenceId,
    required String title,
    required String status,
    int? siteId,
    _i2.Site? site,
    DateTime? createdAt,
  }) = _QualityEventImpl;

  factory QualityEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return QualityEvent(
      id: jsonSerialization['id'] as int?,
      eventType: jsonSerialization['eventType'] as String,
      referenceId: jsonSerialization['referenceId'] as String?,
      title: jsonSerialization['title'] as String,
      status: jsonSerialization['status'] as String,
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Site>(jsonSerialization['site']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = QualityEventTable();

  static const db = QualityEventRepository._();

  @override
  int? id;

  /// Type: deviation, capa, change_control.
  String eventType;

  /// External reference ID.
  String? referenceId;

  /// Title.
  String title;

  /// Status.
  String status;

  int? siteId;

  /// The site.
  _i2.Site? site;

  /// When created.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QualityEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QualityEvent copyWith({
    int? id,
    String? eventType,
    String? referenceId,
    String? title,
    String? status,
    int? siteId,
    _i2.Site? site,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QualityEvent',
      if (id != null) 'id': id,
      'eventType': eventType,
      if (referenceId != null) 'referenceId': referenceId,
      'title': title,
      'status': status,
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QualityEvent',
      if (id != null) 'id': id,
      'eventType': eventType,
      if (referenceId != null) 'referenceId': referenceId,
      'title': title,
      'status': status,
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static QualityEventInclude include({_i2.SiteInclude? site}) {
    return QualityEventInclude._(site: site);
  }

  static QualityEventIncludeList includeList({
    _i1.WhereExpressionBuilder<QualityEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QualityEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QualityEventTable>? orderByList,
    QualityEventInclude? include,
  }) {
    return QualityEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QualityEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QualityEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QualityEventImpl extends QualityEvent {
  _QualityEventImpl({
    int? id,
    required String eventType,
    String? referenceId,
    required String title,
    required String status,
    int? siteId,
    _i2.Site? site,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventType: eventType,
         referenceId: referenceId,
         title: title,
         status: status,
         siteId: siteId,
         site: site,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [QualityEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QualityEvent copyWith({
    Object? id = _Undefined,
    String? eventType,
    Object? referenceId = _Undefined,
    String? title,
    String? status,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    DateTime? createdAt,
  }) {
    return QualityEvent(
      id: id is int? ? id : this.id,
      eventType: eventType ?? this.eventType,
      referenceId: referenceId is String? ? referenceId : this.referenceId,
      title: title ?? this.title,
      status: status ?? this.status,
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i2.Site? ? site : this.site?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class QualityEventUpdateTable extends _i1.UpdateTable<QualityEventTable> {
  QualityEventUpdateTable(super.table);

  _i1.ColumnValue<String, String> eventType(String value) => _i1.ColumnValue(
    table.eventType,
    value,
  );

  _i1.ColumnValue<String, String> referenceId(String? value) => _i1.ColumnValue(
    table.referenceId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int? value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class QualityEventTable extends _i1.Table<int?> {
  QualityEventTable({super.tableRelation}) : super(tableName: 'quality_event') {
    updateTable = QualityEventUpdateTable(this);
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    referenceId = _i1.ColumnString(
      'referenceId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final QualityEventUpdateTable updateTable;

  /// Type: deviation, capa, change_control.
  late final _i1.ColumnString eventType;

  /// External reference ID.
  late final _i1.ColumnString referenceId;

  /// Title.
  late final _i1.ColumnString title;

  /// Status.
  late final _i1.ColumnString status;

  late final _i1.ColumnInt siteId;

  /// The site.
  _i2.SiteTable? _site;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  _i2.SiteTable get site {
    if (_site != null) return _site!;
    _site = _i1.createRelationTable(
      relationFieldName: 'site',
      field: QualityEvent.t.siteId,
      foreignField: _i2.Site.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SiteTable(tableRelation: foreignTableRelation),
    );
    return _site!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    eventType,
    referenceId,
    title,
    status,
    siteId,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'site') {
      return site;
    }
    return null;
  }
}

class QualityEventInclude extends _i1.IncludeObject {
  QualityEventInclude._({_i2.SiteInclude? site}) {
    _site = site;
  }

  _i2.SiteInclude? _site;

  @override
  Map<String, _i1.Include?> get includes => {'site': _site};

  @override
  _i1.Table<int?> get table => QualityEvent.t;
}

class QualityEventIncludeList extends _i1.IncludeList {
  QualityEventIncludeList._({
    _i1.WhereExpressionBuilder<QualityEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QualityEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QualityEvent.t;
}

class QualityEventRepository {
  const QualityEventRepository._();

  final attachRow = const QualityEventAttachRowRepository._();

  final detachRow = const QualityEventDetachRowRepository._();

  /// Returns a list of [QualityEvent]s matching the given query parameters.
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
  Future<List<QualityEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QualityEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QualityEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QualityEventTable>? orderByList,
    _i1.Transaction? transaction,
    QualityEventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QualityEvent>(
      where: where?.call(QualityEvent.t),
      orderBy: orderBy?.call(QualityEvent.t),
      orderByList: orderByList?.call(QualityEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QualityEvent] matching the given query parameters.
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
  Future<QualityEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QualityEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<QualityEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QualityEventTable>? orderByList,
    _i1.Transaction? transaction,
    QualityEventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QualityEvent>(
      where: where?.call(QualityEvent.t),
      orderBy: orderBy?.call(QualityEvent.t),
      orderByList: orderByList?.call(QualityEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QualityEvent] by its [id] or null if no such row exists.
  Future<QualityEvent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    QualityEventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QualityEvent>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QualityEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [QualityEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<QualityEvent>> insert(
    _i1.Session session,
    List<QualityEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<QualityEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [QualityEvent] and returns the inserted row.
  ///
  /// The returned [QualityEvent] will have its `id` field set.
  Future<QualityEvent> insertRow(
    _i1.Session session,
    QualityEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QualityEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QualityEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QualityEvent>> update(
    _i1.Session session,
    List<QualityEvent> rows, {
    _i1.ColumnSelections<QualityEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QualityEvent>(
      rows,
      columns: columns?.call(QualityEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QualityEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QualityEvent> updateRow(
    _i1.Session session,
    QualityEvent row, {
    _i1.ColumnSelections<QualityEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QualityEvent>(
      row,
      columns: columns?.call(QualityEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QualityEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QualityEvent?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<QualityEventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<QualityEvent>(
      id,
      columnValues: columnValues(QualityEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QualityEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<QualityEvent>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<QualityEventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<QualityEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QualityEventTable>? orderBy,
    _i1.OrderByListBuilder<QualityEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<QualityEvent>(
      columnValues: columnValues(QualityEvent.t.updateTable),
      where: where(QualityEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QualityEvent.t),
      orderByList: orderByList?.call(QualityEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [QualityEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QualityEvent>> delete(
    _i1.Session session,
    List<QualityEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QualityEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QualityEvent].
  Future<QualityEvent> deleteRow(
    _i1.Session session,
    QualityEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QualityEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QualityEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QualityEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QualityEvent>(
      where: where(QualityEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QualityEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QualityEvent>(
      where: where?.call(QualityEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QualityEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QualityEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QualityEvent>(
      where: where(QualityEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class QualityEventAttachRowRepository {
  const QualityEventAttachRowRepository._();

  /// Creates a relation between the given [QualityEvent] and [Site]
  /// by setting the [QualityEvent]'s foreign key `siteId` to refer to the [Site].
  Future<void> site(
    _i1.Session session,
    QualityEvent qualityEvent,
    _i2.Site site, {
    _i1.Transaction? transaction,
  }) async {
    if (qualityEvent.id == null) {
      throw ArgumentError.notNull('qualityEvent.id');
    }
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }

    var $qualityEvent = qualityEvent.copyWith(siteId: site.id);
    await session.db.updateRow<QualityEvent>(
      $qualityEvent,
      columns: [QualityEvent.t.siteId],
      transaction: transaction,
    );
  }
}

class QualityEventDetachRowRepository {
  const QualityEventDetachRowRepository._();

  /// Detaches the relation between this [QualityEvent] and the [Site] set in `site`
  /// by setting the [QualityEvent]'s foreign key `siteId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> site(
    _i1.Session session,
    QualityEvent qualityEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (qualityEvent.id == null) {
      throw ArgumentError.notNull('qualityEvent.id');
    }

    var $qualityEvent = qualityEvent.copyWith(siteId: null);
    await session.db.updateRow<QualityEvent>(
      $qualityEvent,
      columns: [QualityEvent.t.siteId],
      transaction: transaction,
    );
  }
}
