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
import '../training/enrollment.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Notification record for delivery tracking. GMP.
abstract class Notification
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Notification._({
    this.id,
    required this.userId,
    this.user,
    required this.type,
    this.enrollmentId,
    this.enrollment,
    this.sentAt,
    this.deliveryStatus,
    this.readAt,
    String? channel,
    DateTime? createdAt,
  }) : channel = channel ?? 'in_app',
       createdAt = createdAt ?? DateTime.now();

  factory Notification({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String type,
    int? enrollmentId,
    _i3.Enrollment? enrollment,
    DateTime? sentAt,
    String? deliveryStatus,
    DateTime? readAt,
    String? channel,
    DateTime? createdAt,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      type: jsonSerialization['type'] as String,
      enrollmentId: jsonSerialization['enrollmentId'] as int?,
      enrollment: jsonSerialization['enrollment'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Enrollment>(
              jsonSerialization['enrollment'],
            ),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      deliveryStatus: jsonSerialization['deliveryStatus'] as String?,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      channel: jsonSerialization['channel'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = NotificationTable();

  static const db = NotificationRepository._();

  @override
  int? id;

  int userId;

  /// The user to notify.
  _i2.PharmaUser? user;

  /// Type: assignment, reminder_30d, reminder_14d, reminder_7d, reminder_3d, overdue, cert_expiry, cert_expiry_90d, cert_expiry_60d, cert_expiry_30d, cert_expiry_7d, cert_expired, compliance_alert.
  String type;

  int? enrollmentId;

  /// Enrollment this notification relates to.
  _i3.Enrollment? enrollment;

  /// When sent.
  DateTime? sentAt;

  /// Delivery status: sent, failed, bounced.
  String? deliveryStatus;

  /// When read (in-app).
  DateTime? readAt;

  /// Channel: email, in_app, sms.
  String channel;

  /// When created.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? type,
    int? enrollmentId,
    _i3.Enrollment? enrollment,
    DateTime? sentAt,
    String? deliveryStatus,
    DateTime? readAt,
    String? channel,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'type': type,
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (deliveryStatus != null) 'deliveryStatus': deliveryStatus,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'channel': channel,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'type': type,
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJsonForProtocol(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (deliveryStatus != null) 'deliveryStatus': deliveryStatus,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'channel': channel,
      'createdAt': createdAt.toJson(),
    };
  }

  static NotificationInclude include({
    _i2.PharmaUserInclude? user,
    _i3.EnrollmentInclude? enrollment,
  }) {
    return NotificationInclude._(
      user: user,
      enrollment: enrollment,
    );
  }

  static NotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    NotificationInclude? include,
  }) {
    return NotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Notification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String type,
    int? enrollmentId,
    _i3.Enrollment? enrollment,
    DateTime? sentAt,
    String? deliveryStatus,
    DateTime? readAt,
    String? channel,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         type: type,
         enrollmentId: enrollmentId,
         enrollment: enrollment,
         sentAt: sentAt,
         deliveryStatus: deliveryStatus,
         readAt: readAt,
         channel: channel,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? type,
    Object? enrollmentId = _Undefined,
    Object? enrollment = _Undefined,
    Object? sentAt = _Undefined,
    Object? deliveryStatus = _Undefined,
    Object? readAt = _Undefined,
    String? channel,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      type: type ?? this.type,
      enrollmentId: enrollmentId is int? ? enrollmentId : this.enrollmentId,
      enrollment: enrollment is _i3.Enrollment?
          ? enrollment
          : this.enrollment?.copyWith(),
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      deliveryStatus: deliveryStatus is String?
          ? deliveryStatus
          : this.deliveryStatus,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      channel: channel ?? this.channel,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NotificationUpdateTable extends _i1.UpdateTable<NotificationTable> {
  NotificationUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> type(String value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<int, int> enrollmentId(int? value) => _i1.ColumnValue(
    table.enrollmentId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> sentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.sentAt,
        value,
      );

  _i1.ColumnValue<String, String> deliveryStatus(String? value) =>
      _i1.ColumnValue(
        table.deliveryStatus,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> readAt(DateTime? value) =>
      _i1.ColumnValue(
        table.readAt,
        value,
      );

  _i1.ColumnValue<String, String> channel(String value) => _i1.ColumnValue(
    table.channel,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class NotificationTable extends _i1.Table<int?> {
  NotificationTable({super.tableRelation}) : super(tableName: 'notification') {
    updateTable = NotificationUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    enrollmentId = _i1.ColumnInt(
      'enrollmentId',
      this,
    );
    sentAt = _i1.ColumnDateTime(
      'sentAt',
      this,
    );
    deliveryStatus = _i1.ColumnString(
      'deliveryStatus',
      this,
    );
    readAt = _i1.ColumnDateTime(
      'readAt',
      this,
    );
    channel = _i1.ColumnString(
      'channel',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final NotificationUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user to notify.
  _i2.PharmaUserTable? _user;

  /// Type: assignment, reminder_30d, reminder_14d, reminder_7d, reminder_3d, overdue, cert_expiry, cert_expiry_90d, cert_expiry_60d, cert_expiry_30d, cert_expiry_7d, cert_expired, compliance_alert.
  late final _i1.ColumnString type;

  late final _i1.ColumnInt enrollmentId;

  /// Enrollment this notification relates to.
  _i3.EnrollmentTable? _enrollment;

  /// When sent.
  late final _i1.ColumnDateTime sentAt;

  /// Delivery status: sent, failed, bounced.
  late final _i1.ColumnString deliveryStatus;

  /// When read (in-app).
  late final _i1.ColumnDateTime readAt;

  /// Channel: email, in_app, sms.
  late final _i1.ColumnString channel;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Notification.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.EnrollmentTable get enrollment {
    if (_enrollment != null) return _enrollment!;
    _enrollment = _i1.createRelationTable(
      relationFieldName: 'enrollment',
      field: Notification.t.enrollmentId,
      foreignField: _i3.Enrollment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EnrollmentTable(tableRelation: foreignTableRelation),
    );
    return _enrollment!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    type,
    enrollmentId,
    sentAt,
    deliveryStatus,
    readAt,
    channel,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'enrollment') {
      return enrollment;
    }
    return null;
  }
}

class NotificationInclude extends _i1.IncludeObject {
  NotificationInclude._({
    _i2.PharmaUserInclude? user,
    _i3.EnrollmentInclude? enrollment,
  }) {
    _user = user;
    _enrollment = enrollment;
  }

  _i2.PharmaUserInclude? _user;

  _i3.EnrollmentInclude? _enrollment;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'enrollment': _enrollment,
  };

  @override
  _i1.Table<int?> get table => Notification.t;
}

class NotificationIncludeList extends _i1.IncludeList {
  NotificationIncludeList._({
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Notification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Notification.t;
}

class NotificationRepository {
  const NotificationRepository._();

  final attachRow = const NotificationAttachRowRepository._();

  final detachRow = const NotificationDetachRowRepository._();

  /// Returns a list of [Notification]s matching the given query parameters.
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
  Future<List<Notification>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Notification>(
      where: where?.call(Notification.t),
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Notification] matching the given query parameters.
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
  Future<Notification?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Notification>(
      where: where?.call(Notification.t),
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Notification] by its [id] or null if no such row exists.
  Future<Notification?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    NotificationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Notification>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Notification]s in the list and returns the inserted rows.
  ///
  /// The returned [Notification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Notification>> insert(
    _i1.Session session,
    List<Notification> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Notification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Notification] and returns the inserted row.
  ///
  /// The returned [Notification] will have its `id` field set.
  Future<Notification> insertRow(
    _i1.Session session,
    Notification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Notification>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Notification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Notification>> update(
    _i1.Session session,
    List<Notification> rows, {
    _i1.ColumnSelections<NotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Notification>(
      rows,
      columns: columns?.call(Notification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Notification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Notification> updateRow(
    _i1.Session session,
    Notification row, {
    _i1.ColumnSelections<NotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Notification>(
      row,
      columns: columns?.call(Notification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Notification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Notification?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<NotificationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Notification>(
      id,
      columnValues: columnValues(Notification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Notification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Notification>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<NotificationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<NotificationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Notification>(
      columnValues: columnValues(Notification.t.updateTable),
      where: where(Notification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Notification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Notification>> delete(
    _i1.Session session,
    List<Notification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Notification>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Notification].
  Future<Notification> deleteRow(
    _i1.Session session,
    Notification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Notification>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Notification>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Notification>(
      where: where(Notification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Notification>(
      where: where?.call(Notification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Notification] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NotificationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Notification>(
      where: where(Notification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class NotificationAttachRowRepository {
  const NotificationAttachRowRepository._();

  /// Creates a relation between the given [Notification] and [PharmaUser]
  /// by setting the [Notification]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    Notification notification,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $notification = notification.copyWith(userId: user.id);
    await session.db.updateRow<Notification>(
      $notification,
      columns: [Notification.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Notification] and [Enrollment]
  /// by setting the [Notification]'s foreign key `enrollmentId` to refer to the [Enrollment].
  Future<void> enrollment(
    _i1.Session session,
    Notification notification,
    _i3.Enrollment enrollment, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }

    var $notification = notification.copyWith(enrollmentId: enrollment.id);
    await session.db.updateRow<Notification>(
      $notification,
      columns: [Notification.t.enrollmentId],
      transaction: transaction,
    );
  }
}

class NotificationDetachRowRepository {
  const NotificationDetachRowRepository._();

  /// Detaches the relation between this [Notification] and the [Enrollment] set in `enrollment`
  /// by setting the [Notification]'s foreign key `enrollmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> enrollment(
    _i1.Session session,
    Notification notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }

    var $notification = notification.copyWith(enrollmentId: null);
    await session.db.updateRow<Notification>(
      $notification,
      columns: [Notification.t.enrollmentId],
      transaction: transaction,
    );
  }
}
