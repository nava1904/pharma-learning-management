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

/// Outbox pattern for reliable event publishing.
abstract class OutboxMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OutboxMessage._({
    this.id,
    required this.topic,
    required this.payloadJson,
    DateTime? createdAt,
    this.sentAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OutboxMessage({
    int? id,
    required String topic,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? sentAt,
  }) = _OutboxMessageImpl;

  factory OutboxMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return OutboxMessage(
      id: jsonSerialization['id'] as int?,
      topic: jsonSerialization['topic'] as String,
      payloadJson: jsonSerialization['payloadJson'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  static final t = OutboxMessageTable();

  static const db = OutboxMessageRepository._();

  @override
  int? id;

  /// Kafka topic.
  String topic;

  /// Payload as JSON.
  String payloadJson;

  /// When created.
  DateTime createdAt;

  /// When sent (null if pending).
  DateTime? sentAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OutboxMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OutboxMessage copyWith({
    int? id,
    String? topic,
    String? payloadJson,
    DateTime? createdAt,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OutboxMessage',
      if (id != null) 'id': id,
      'topic': topic,
      'payloadJson': payloadJson,
      'createdAt': createdAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OutboxMessage',
      if (id != null) 'id': id,
      'topic': topic,
      'payloadJson': payloadJson,
      'createdAt': createdAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
    };
  }

  static OutboxMessageInclude include() {
    return OutboxMessageInclude._();
  }

  static OutboxMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<OutboxMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OutboxMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OutboxMessageTable>? orderByList,
    OutboxMessageInclude? include,
  }) {
    return OutboxMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OutboxMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OutboxMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OutboxMessageImpl extends OutboxMessage {
  _OutboxMessageImpl({
    int? id,
    required String topic,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? sentAt,
  }) : super._(
         id: id,
         topic: topic,
         payloadJson: payloadJson,
         createdAt: createdAt,
         sentAt: sentAt,
       );

  /// Returns a shallow copy of this [OutboxMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OutboxMessage copyWith({
    Object? id = _Undefined,
    String? topic,
    String? payloadJson,
    DateTime? createdAt,
    Object? sentAt = _Undefined,
  }) {
    return OutboxMessage(
      id: id is int? ? id : this.id,
      topic: topic ?? this.topic,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
    );
  }
}

class OutboxMessageUpdateTable extends _i1.UpdateTable<OutboxMessageTable> {
  OutboxMessageUpdateTable(super.table);

  _i1.ColumnValue<String, String> topic(String value) => _i1.ColumnValue(
    table.topic,
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

  _i1.ColumnValue<DateTime, DateTime> sentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.sentAt,
        value,
      );
}

class OutboxMessageTable extends _i1.Table<int?> {
  OutboxMessageTable({super.tableRelation})
    : super(tableName: 'outbox_message') {
    updateTable = OutboxMessageUpdateTable(this);
    topic = _i1.ColumnString(
      'topic',
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
    sentAt = _i1.ColumnDateTime(
      'sentAt',
      this,
    );
  }

  late final OutboxMessageUpdateTable updateTable;

  /// Kafka topic.
  late final _i1.ColumnString topic;

  /// Payload as JSON.
  late final _i1.ColumnString payloadJson;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  /// When sent (null if pending).
  late final _i1.ColumnDateTime sentAt;

  @override
  List<_i1.Column> get columns => [
    id,
    topic,
    payloadJson,
    createdAt,
    sentAt,
  ];
}

class OutboxMessageInclude extends _i1.IncludeObject {
  OutboxMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OutboxMessage.t;
}

class OutboxMessageIncludeList extends _i1.IncludeList {
  OutboxMessageIncludeList._({
    _i1.WhereExpressionBuilder<OutboxMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OutboxMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OutboxMessage.t;
}

class OutboxMessageRepository {
  const OutboxMessageRepository._();

  /// Returns a list of [OutboxMessage]s matching the given query parameters.
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
  Future<List<OutboxMessage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OutboxMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OutboxMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OutboxMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OutboxMessage>(
      where: where?.call(OutboxMessage.t),
      orderBy: orderBy?.call(OutboxMessage.t),
      orderByList: orderByList?.call(OutboxMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OutboxMessage] matching the given query parameters.
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
  Future<OutboxMessage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OutboxMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<OutboxMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OutboxMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OutboxMessage>(
      where: where?.call(OutboxMessage.t),
      orderBy: orderBy?.call(OutboxMessage.t),
      orderByList: orderByList?.call(OutboxMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OutboxMessage] by its [id] or null if no such row exists.
  Future<OutboxMessage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OutboxMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OutboxMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [OutboxMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OutboxMessage>> insert(
    _i1.Session session,
    List<OutboxMessage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OutboxMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OutboxMessage] and returns the inserted row.
  ///
  /// The returned [OutboxMessage] will have its `id` field set.
  Future<OutboxMessage> insertRow(
    _i1.Session session,
    OutboxMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OutboxMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OutboxMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OutboxMessage>> update(
    _i1.Session session,
    List<OutboxMessage> rows, {
    _i1.ColumnSelections<OutboxMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OutboxMessage>(
      rows,
      columns: columns?.call(OutboxMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OutboxMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OutboxMessage> updateRow(
    _i1.Session session,
    OutboxMessage row, {
    _i1.ColumnSelections<OutboxMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OutboxMessage>(
      row,
      columns: columns?.call(OutboxMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OutboxMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OutboxMessage?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OutboxMessageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OutboxMessage>(
      id,
      columnValues: columnValues(OutboxMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OutboxMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OutboxMessage>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OutboxMessageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OutboxMessageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OutboxMessageTable>? orderBy,
    _i1.OrderByListBuilder<OutboxMessageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OutboxMessage>(
      columnValues: columnValues(OutboxMessage.t.updateTable),
      where: where(OutboxMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OutboxMessage.t),
      orderByList: orderByList?.call(OutboxMessage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OutboxMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OutboxMessage>> delete(
    _i1.Session session,
    List<OutboxMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OutboxMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OutboxMessage].
  Future<OutboxMessage> deleteRow(
    _i1.Session session,
    OutboxMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OutboxMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OutboxMessage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OutboxMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OutboxMessage>(
      where: where(OutboxMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OutboxMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OutboxMessage>(
      where: where?.call(OutboxMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OutboxMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OutboxMessageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OutboxMessage>(
      where: where(OutboxMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
