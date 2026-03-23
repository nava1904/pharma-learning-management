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
import '../notifications/notification.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Log of notification delivery attempts. GMP.
abstract class NotificationLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  NotificationLog._({
    this.id,
    required this.notificationId,
    this.notification,
    DateTime? attemptedAt,
    required this.channel,
    String? status,
    this.errorMessage,
    int? retryCount,
    this.externalMessageId,
  }) : attemptedAt = attemptedAt ?? DateTime.now(),
       status = status ?? 'sent',
       retryCount = retryCount ?? 0;

  factory NotificationLog({
    int? id,
    required int notificationId,
    _i2.Notification? notification,
    DateTime? attemptedAt,
    required String channel,
    String? status,
    String? errorMessage,
    int? retryCount,
    String? externalMessageId,
  }) = _NotificationLogImpl;

  factory NotificationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotificationLog(
      id: jsonSerialization['id'] as int?,
      notificationId: jsonSerialization['notificationId'] as int,
      notification: jsonSerialization['notification'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Notification>(
              jsonSerialization['notification'],
            ),
      attemptedAt: jsonSerialization['attemptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['attemptedAt'],
            ),
      channel: jsonSerialization['channel'] as String,
      status: jsonSerialization['status'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      retryCount: jsonSerialization['retryCount'] as int?,
      externalMessageId: jsonSerialization['externalMessageId'] as String?,
    );
  }

  static final t = NotificationLogTable();

  static const db = NotificationLogRepository._();

  @override
  int? id;

  int notificationId;

  /// The notification record.
  _i2.Notification? notification;

  /// When the delivery was attempted.
  DateTime attemptedAt;

  /// Delivery channel: email, sms, in_app.
  String channel;

  /// Status: sent, failed, bounced, delivered.
  String status;

  /// Error message if failed.
  String? errorMessage;

  /// Retry count.
  int retryCount;

  /// External message ID (e.g., SendGrid ID).
  String? externalMessageId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [NotificationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationLog copyWith({
    int? id,
    int? notificationId,
    _i2.Notification? notification,
    DateTime? attemptedAt,
    String? channel,
    String? status,
    String? errorMessage,
    int? retryCount,
    String? externalMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationLog',
      if (id != null) 'id': id,
      'notificationId': notificationId,
      if (notification != null) 'notification': notification?.toJson(),
      'attemptedAt': attemptedAt.toJson(),
      'channel': channel,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'retryCount': retryCount,
      if (externalMessageId != null) 'externalMessageId': externalMessageId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NotificationLog',
      if (id != null) 'id': id,
      'notificationId': notificationId,
      if (notification != null)
        'notification': notification?.toJsonForProtocol(),
      'attemptedAt': attemptedAt.toJson(),
      'channel': channel,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'retryCount': retryCount,
      if (externalMessageId != null) 'externalMessageId': externalMessageId,
    };
  }

  static NotificationLogInclude include({
    _i2.NotificationInclude? notification,
  }) {
    return NotificationLogInclude._(notification: notification);
  }

  static NotificationLogIncludeList includeList({
    _i1.WhereExpressionBuilder<NotificationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationLogTable>? orderByList,
    NotificationLogInclude? include,
  }) {
    return NotificationLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(NotificationLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationLogImpl extends NotificationLog {
  _NotificationLogImpl({
    int? id,
    required int notificationId,
    _i2.Notification? notification,
    DateTime? attemptedAt,
    required String channel,
    String? status,
    String? errorMessage,
    int? retryCount,
    String? externalMessageId,
  }) : super._(
         id: id,
         notificationId: notificationId,
         notification: notification,
         attemptedAt: attemptedAt,
         channel: channel,
         status: status,
         errorMessage: errorMessage,
         retryCount: retryCount,
         externalMessageId: externalMessageId,
       );

  /// Returns a shallow copy of this [NotificationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationLog copyWith({
    Object? id = _Undefined,
    int? notificationId,
    Object? notification = _Undefined,
    DateTime? attemptedAt,
    String? channel,
    String? status,
    Object? errorMessage = _Undefined,
    int? retryCount,
    Object? externalMessageId = _Undefined,
  }) {
    return NotificationLog(
      id: id is int? ? id : this.id,
      notificationId: notificationId ?? this.notificationId,
      notification: notification is _i2.Notification?
          ? notification
          : this.notification?.copyWith(),
      attemptedAt: attemptedAt ?? this.attemptedAt,
      channel: channel ?? this.channel,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      retryCount: retryCount ?? this.retryCount,
      externalMessageId: externalMessageId is String?
          ? externalMessageId
          : this.externalMessageId,
    );
  }
}

class NotificationLogUpdateTable extends _i1.UpdateTable<NotificationLogTable> {
  NotificationLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> notificationId(int value) => _i1.ColumnValue(
    table.notificationId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> attemptedAt(DateTime value) =>
      _i1.ColumnValue(
        table.attemptedAt,
        value,
      );

  _i1.ColumnValue<String, String> channel(String value) => _i1.ColumnValue(
    table.channel,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
        value,
      );

  _i1.ColumnValue<int, int> retryCount(int value) => _i1.ColumnValue(
    table.retryCount,
    value,
  );

  _i1.ColumnValue<String, String> externalMessageId(String? value) =>
      _i1.ColumnValue(
        table.externalMessageId,
        value,
      );
}

class NotificationLogTable extends _i1.Table<int?> {
  NotificationLogTable({super.tableRelation})
    : super(tableName: 'notification_log') {
    updateTable = NotificationLogUpdateTable(this);
    notificationId = _i1.ColumnInt(
      'notificationId',
      this,
    );
    attemptedAt = _i1.ColumnDateTime(
      'attemptedAt',
      this,
      hasDefault: true,
    );
    channel = _i1.ColumnString(
      'channel',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
      this,
    );
    retryCount = _i1.ColumnInt(
      'retryCount',
      this,
      hasDefault: true,
    );
    externalMessageId = _i1.ColumnString(
      'externalMessageId',
      this,
    );
  }

  late final NotificationLogUpdateTable updateTable;

  late final _i1.ColumnInt notificationId;

  /// The notification record.
  _i2.NotificationTable? _notification;

  /// When the delivery was attempted.
  late final _i1.ColumnDateTime attemptedAt;

  /// Delivery channel: email, sms, in_app.
  late final _i1.ColumnString channel;

  /// Status: sent, failed, bounced, delivered.
  late final _i1.ColumnString status;

  /// Error message if failed.
  late final _i1.ColumnString errorMessage;

  /// Retry count.
  late final _i1.ColumnInt retryCount;

  /// External message ID (e.g., SendGrid ID).
  late final _i1.ColumnString externalMessageId;

  _i2.NotificationTable get notification {
    if (_notification != null) return _notification!;
    _notification = _i1.createRelationTable(
      relationFieldName: 'notification',
      field: NotificationLog.t.notificationId,
      foreignField: _i2.Notification.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.NotificationTable(tableRelation: foreignTableRelation),
    );
    return _notification!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    notificationId,
    attemptedAt,
    channel,
    status,
    errorMessage,
    retryCount,
    externalMessageId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'notification') {
      return notification;
    }
    return null;
  }
}

class NotificationLogInclude extends _i1.IncludeObject {
  NotificationLogInclude._({_i2.NotificationInclude? notification}) {
    _notification = notification;
  }

  _i2.NotificationInclude? _notification;

  @override
  Map<String, _i1.Include?> get includes => {'notification': _notification};

  @override
  _i1.Table<int?> get table => NotificationLog.t;
}

class NotificationLogIncludeList extends _i1.IncludeList {
  NotificationLogIncludeList._({
    _i1.WhereExpressionBuilder<NotificationLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NotificationLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => NotificationLog.t;
}

class NotificationLogRepository {
  const NotificationLogRepository._();

  final attachRow = const NotificationLogAttachRowRepository._();

  /// Returns a list of [NotificationLog]s matching the given query parameters.
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
  Future<List<NotificationLog>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<NotificationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationLogTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NotificationLog>(
      where: where?.call(NotificationLog.t),
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NotificationLog] matching the given query parameters.
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
  Future<NotificationLog?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<NotificationLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<NotificationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationLogTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NotificationLog>(
      where: where?.call(NotificationLog.t),
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NotificationLog] by its [id] or null if no such row exists.
  Future<NotificationLog?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    NotificationLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NotificationLog>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NotificationLog]s in the list and returns the inserted rows.
  ///
  /// The returned [NotificationLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<NotificationLog>> insert(
    _i1.DatabaseSession session,
    List<NotificationLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<NotificationLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [NotificationLog] and returns the inserted row.
  ///
  /// The returned [NotificationLog] will have its `id` field set.
  Future<NotificationLog> insertRow(
    _i1.DatabaseSession session,
    NotificationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<NotificationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [NotificationLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<NotificationLog>> update(
    _i1.DatabaseSession session,
    List<NotificationLog> rows, {
    _i1.ColumnSelections<NotificationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<NotificationLog>(
      rows,
      columns: columns?.call(NotificationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NotificationLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NotificationLog> updateRow(
    _i1.DatabaseSession session,
    NotificationLog row, {
    _i1.ColumnSelections<NotificationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<NotificationLog>(
      row,
      columns: columns?.call(NotificationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NotificationLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NotificationLog?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<NotificationLogUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<NotificationLog>(
      id,
      columnValues: columnValues(NotificationLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NotificationLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<NotificationLog>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<NotificationLogUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<NotificationLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationLogTable>? orderBy,
    _i1.OrderByListBuilder<NotificationLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<NotificationLog>(
      columnValues: columnValues(NotificationLog.t.updateTable),
      where: where(NotificationLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NotificationLog.t),
      orderByList: orderByList?.call(NotificationLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [NotificationLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<NotificationLog>> delete(
    _i1.DatabaseSession session,
    List<NotificationLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<NotificationLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [NotificationLog].
  Future<NotificationLog> deleteRow(
    _i1.DatabaseSession session,
    NotificationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NotificationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<NotificationLog>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<NotificationLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<NotificationLog>(
      where: where(NotificationLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<NotificationLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<NotificationLog>(
      where: where?.call(NotificationLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NotificationLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<NotificationLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NotificationLog>(
      where: where(NotificationLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class NotificationLogAttachRowRepository {
  const NotificationLogAttachRowRepository._();

  /// Creates a relation between the given [NotificationLog] and [Notification]
  /// by setting the [NotificationLog]'s foreign key `notificationId` to refer to the [Notification].
  Future<void> notification(
    _i1.DatabaseSession session,
    NotificationLog notificationLog,
    _i2.Notification notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notificationLog.id == null) {
      throw ArgumentError.notNull('notificationLog.id');
    }
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }

    var $notificationLog = notificationLog.copyWith(
      notificationId: notification.id,
    );
    await session.db.updateRow<NotificationLog>(
      $notificationLog,
      columns: [NotificationLog.t.notificationId],
      transaction: transaction,
    );
  }
}
