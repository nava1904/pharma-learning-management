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

/// Domain event for event-driven workflows.
abstract class DomainEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DomainEvent._({
    this.id,
    required this.eventType,
    required this.aggregateId,
    required this.payloadJson,
    DateTime? createdAt,
    this.processedAt,
    this.kafkaOffset,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DomainEvent({
    int? id,
    required String eventType,
    required String aggregateId,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? processedAt,
    String? kafkaOffset,
  }) = _DomainEventImpl;

  factory DomainEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DomainEvent(
      id: jsonSerialization['id'] as int?,
      eventType: jsonSerialization['eventType'] as String,
      aggregateId: jsonSerialization['aggregateId'] as String,
      payloadJson: jsonSerialization['payloadJson'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processedAt'],
            ),
      kafkaOffset: jsonSerialization['kafkaOffset'] as String?,
    );
  }

  static final t = DomainEventTable();

  static const db = DomainEventRepository._();

  @override
  int? id;

  /// Event type.
  String eventType;

  /// Aggregate ID.
  String aggregateId;

  /// Payload as JSON.
  String payloadJson;

  /// When created.
  DateTime createdAt;

  /// When processed (null if pending).
  DateTime? processedAt;

  /// Kafka offset if published.
  String? kafkaOffset;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DomainEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DomainEvent copyWith({
    int? id,
    String? eventType,
    String? aggregateId,
    String? payloadJson,
    DateTime? createdAt,
    DateTime? processedAt,
    String? kafkaOffset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DomainEvent',
      if (id != null) 'id': id,
      'eventType': eventType,
      'aggregateId': aggregateId,
      'payloadJson': payloadJson,
      'createdAt': createdAt.toJson(),
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
      if (kafkaOffset != null) 'kafkaOffset': kafkaOffset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DomainEvent',
      if (id != null) 'id': id,
      'eventType': eventType,
      'aggregateId': aggregateId,
      'payloadJson': payloadJson,
      'createdAt': createdAt.toJson(),
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
      if (kafkaOffset != null) 'kafkaOffset': kafkaOffset,
    };
  }

  static DomainEventInclude include() {
    return DomainEventInclude._();
  }

  static DomainEventIncludeList includeList({
    _i1.WhereExpressionBuilder<DomainEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DomainEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DomainEventTable>? orderByList,
    DomainEventInclude? include,
  }) {
    return DomainEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DomainEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DomainEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DomainEventImpl extends DomainEvent {
  _DomainEventImpl({
    int? id,
    required String eventType,
    required String aggregateId,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? processedAt,
    String? kafkaOffset,
  }) : super._(
         id: id,
         eventType: eventType,
         aggregateId: aggregateId,
         payloadJson: payloadJson,
         createdAt: createdAt,
         processedAt: processedAt,
         kafkaOffset: kafkaOffset,
       );

  /// Returns a shallow copy of this [DomainEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DomainEvent copyWith({
    Object? id = _Undefined,
    String? eventType,
    String? aggregateId,
    String? payloadJson,
    DateTime? createdAt,
    Object? processedAt = _Undefined,
    Object? kafkaOffset = _Undefined,
  }) {
    return DomainEvent(
      id: id is int? ? id : this.id,
      eventType: eventType ?? this.eventType,
      aggregateId: aggregateId ?? this.aggregateId,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
      kafkaOffset: kafkaOffset is String? ? kafkaOffset : this.kafkaOffset,
    );
  }
}

class DomainEventUpdateTable extends _i1.UpdateTable<DomainEventTable> {
  DomainEventUpdateTable(super.table);

  _i1.ColumnValue<String, String> eventType(String value) => _i1.ColumnValue(
    table.eventType,
    value,
  );

  _i1.ColumnValue<String, String> aggregateId(String value) => _i1.ColumnValue(
    table.aggregateId,
    value,
  );

  _i1.ColumnValue<String, String> payloadJson(String value) => _i1.ColumnValue(
    table.payloadJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> processedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.processedAt,
        value,
      );

  _i1.ColumnValue<String, String> kafkaOffset(String? value) => _i1.ColumnValue(
    table.kafkaOffset,
    value,
  );
}

class DomainEventTable extends _i1.Table<int?> {
  DomainEventTable({super.tableRelation}) : super(tableName: 'domain_event') {
    updateTable = DomainEventUpdateTable(this);
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    aggregateId = _i1.ColumnString(
      'aggregateId',
      this,
    );
    payloadJson = _i1.ColumnString(
      'payloadJson',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    processedAt = _i1.ColumnDateTime(
      'processedAt',
      this,
    );
    kafkaOffset = _i1.ColumnString(
      'kafkaOffset',
      this,
    );
  }

  late final DomainEventUpdateTable updateTable;

  /// Event type.
  late final _i1.ColumnString eventType;

  /// Aggregate ID.
  late final _i1.ColumnString aggregateId;

  /// Payload as JSON.
  late final _i1.ColumnString payloadJson;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  /// When processed (null if pending).
  late final _i1.ColumnDateTime processedAt;

  /// Kafka offset if published.
  late final _i1.ColumnString kafkaOffset;

  @override
  List<_i1.Column> get columns => [
    id,
    eventType,
    aggregateId,
    payloadJson,
    createdAt,
    processedAt,
    kafkaOffset,
  ];
}

class DomainEventInclude extends _i1.IncludeObject {
  DomainEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DomainEvent.t;
}

class DomainEventIncludeList extends _i1.IncludeList {
  DomainEventIncludeList._({
    _i1.WhereExpressionBuilder<DomainEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DomainEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DomainEvent.t;
}

class DomainEventRepository {
  const DomainEventRepository._();

  /// Returns a list of [DomainEvent]s matching the given query parameters.
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
  Future<List<DomainEvent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DomainEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DomainEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DomainEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DomainEvent>(
      where: where?.call(DomainEvent.t),
      orderBy: orderBy?.call(DomainEvent.t),
      orderByList: orderByList?.call(DomainEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DomainEvent] matching the given query parameters.
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
  Future<DomainEvent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DomainEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<DomainEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DomainEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DomainEvent>(
      where: where?.call(DomainEvent.t),
      orderBy: orderBy?.call(DomainEvent.t),
      orderByList: orderByList?.call(DomainEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DomainEvent] by its [id] or null if no such row exists.
  Future<DomainEvent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DomainEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DomainEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [DomainEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DomainEvent>> insert(
    _i1.DatabaseSession session,
    List<DomainEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DomainEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DomainEvent] and returns the inserted row.
  ///
  /// The returned [DomainEvent] will have its `id` field set.
  Future<DomainEvent> insertRow(
    _i1.DatabaseSession session,
    DomainEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DomainEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DomainEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DomainEvent>> update(
    _i1.DatabaseSession session,
    List<DomainEvent> rows, {
    _i1.ColumnSelections<DomainEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DomainEvent>(
      rows,
      columns: columns?.call(DomainEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DomainEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DomainEvent> updateRow(
    _i1.DatabaseSession session,
    DomainEvent row, {
    _i1.ColumnSelections<DomainEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DomainEvent>(
      row,
      columns: columns?.call(DomainEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DomainEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DomainEvent?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DomainEventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DomainEvent>(
      id,
      columnValues: columnValues(DomainEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DomainEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DomainEvent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DomainEventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DomainEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DomainEventTable>? orderBy,
    _i1.OrderByListBuilder<DomainEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DomainEvent>(
      columnValues: columnValues(DomainEvent.t.updateTable),
      where: where(DomainEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DomainEvent.t),
      orderByList: orderByList?.call(DomainEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DomainEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DomainEvent>> delete(
    _i1.DatabaseSession session,
    List<DomainEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DomainEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DomainEvent].
  Future<DomainEvent> deleteRow(
    _i1.DatabaseSession session,
    DomainEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DomainEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DomainEvent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DomainEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DomainEvent>(
      where: where(DomainEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DomainEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DomainEvent>(
      where: where?.call(DomainEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DomainEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DomainEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DomainEvent>(
      where: where(DomainEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
