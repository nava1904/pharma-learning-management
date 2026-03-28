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
import '../course/course_version.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../training/learner_trainer_message.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Message between a learner and the course trainer for a given course version.
abstract class LearnerTrainerMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LearnerTrainerMessage._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.fromUserId,
    this.fromUser,
    required this.toUserId,
    this.toUser,
    required this.body,
    this.parentMessageId,
    this.parentMessage,
    this.readAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory LearnerTrainerMessage({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int fromUserId,
    _i3.PharmaUser? fromUser,
    required int toUserId,
    _i3.PharmaUser? toUser,
    required String body,
    int? parentMessageId,
    _i4.LearnerTrainerMessage? parentMessage,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _LearnerTrainerMessageImpl;

  factory LearnerTrainerMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LearnerTrainerMessage(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      fromUserId: jsonSerialization['fromUserId'] as int,
      fromUser: jsonSerialization['fromUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['fromUser'],
            ),
      toUserId: jsonSerialization['toUserId'] as int,
      toUser: jsonSerialization['toUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['toUser'],
            ),
      body: jsonSerialization['body'] as String,
      parentMessageId: jsonSerialization['parentMessageId'] as int?,
      parentMessage: jsonSerialization['parentMessage'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.LearnerTrainerMessage>(
              jsonSerialization['parentMessage'],
            ),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = LearnerTrainerMessageTable();

  static const db = LearnerTrainerMessageRepository._();

  @override
  int? id;

  int courseVersionId;

  _i2.CourseVersion? courseVersion;

  int fromUserId;

  _i3.PharmaUser? fromUser;

  int toUserId;

  _i3.PharmaUser? toUser;

  String body;

  int? parentMessageId;

  _i4.LearnerTrainerMessage? parentMessage;

  DateTime? readAt;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LearnerTrainerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LearnerTrainerMessage copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? fromUserId,
    _i3.PharmaUser? fromUser,
    int? toUserId,
    _i3.PharmaUser? toUser,
    String? body,
    int? parentMessageId,
    _i4.LearnerTrainerMessage? parentMessage,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LearnerTrainerMessage',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'fromUserId': fromUserId,
      if (fromUser != null) 'fromUser': fromUser?.toJson(),
      'toUserId': toUserId,
      if (toUser != null) 'toUser': toUser?.toJson(),
      'body': body,
      if (parentMessageId != null) 'parentMessageId': parentMessageId,
      if (parentMessage != null) 'parentMessage': parentMessage?.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LearnerTrainerMessage',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'fromUserId': fromUserId,
      if (fromUser != null) 'fromUser': fromUser?.toJsonForProtocol(),
      'toUserId': toUserId,
      if (toUser != null) 'toUser': toUser?.toJsonForProtocol(),
      'body': body,
      if (parentMessageId != null) 'parentMessageId': parentMessageId,
      if (parentMessage != null)
        'parentMessage': parentMessage?.toJsonForProtocol(),
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static LearnerTrainerMessageInclude include({
    _i2.CourseVersionInclude? courseVersion,
    _i3.PharmaUserInclude? fromUser,
    _i3.PharmaUserInclude? toUser,
    _i4.LearnerTrainerMessageInclude? parentMessage,
  }) {
    return LearnerTrainerMessageInclude._(
      courseVersion: courseVersion,
      fromUser: fromUser,
      toUser: toUser,
      parentMessage: parentMessage,
    );
  }

  static LearnerTrainerMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<LearnerTrainerMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LearnerTrainerMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LearnerTrainerMessageTable>? orderByList,
    LearnerTrainerMessageInclude? include,
  }) {
    return LearnerTrainerMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LearnerTrainerMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LearnerTrainerMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LearnerTrainerMessageImpl extends LearnerTrainerMessage {
  _LearnerTrainerMessageImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int fromUserId,
    _i3.PharmaUser? fromUser,
    required int toUserId,
    _i3.PharmaUser? toUser,
    required String body,
    int? parentMessageId,
    _i4.LearnerTrainerMessage? parentMessage,
    DateTime? readAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         fromUserId: fromUserId,
         fromUser: fromUser,
         toUserId: toUserId,
         toUser: toUser,
         body: body,
         parentMessageId: parentMessageId,
         parentMessage: parentMessage,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LearnerTrainerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LearnerTrainerMessage copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? fromUserId,
    Object? fromUser = _Undefined,
    int? toUserId,
    Object? toUser = _Undefined,
    String? body,
    Object? parentMessageId = _Undefined,
    Object? parentMessage = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return LearnerTrainerMessage(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      fromUserId: fromUserId ?? this.fromUserId,
      fromUser: fromUser is _i3.PharmaUser?
          ? fromUser
          : this.fromUser?.copyWith(),
      toUserId: toUserId ?? this.toUserId,
      toUser: toUser is _i3.PharmaUser? ? toUser : this.toUser?.copyWith(),
      body: body ?? this.body,
      parentMessageId: parentMessageId is int?
          ? parentMessageId
          : this.parentMessageId,
      parentMessage: parentMessage is _i4.LearnerTrainerMessage?
          ? parentMessage
          : this.parentMessage?.copyWith(),
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LearnerTrainerMessageUpdateTable
    extends _i1.UpdateTable<LearnerTrainerMessageTable> {
  LearnerTrainerMessageUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> fromUserId(int value) => _i1.ColumnValue(
    table.fromUserId,
    value,
  );

  _i1.ColumnValue<int, int> toUserId(int value) => _i1.ColumnValue(
    table.toUserId,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<int, int> parentMessageId(int? value) => _i1.ColumnValue(
    table.parentMessageId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> readAt(DateTime? value) =>
      _i1.ColumnValue(
        table.readAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class LearnerTrainerMessageTable extends _i1.Table<int?> {
  LearnerTrainerMessageTable({super.tableRelation})
    : super(tableName: 'learner_trainer_message') {
    updateTable = LearnerTrainerMessageUpdateTable(this);
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    fromUserId = _i1.ColumnInt(
      'fromUserId',
      this,
    );
    toUserId = _i1.ColumnInt(
      'toUserId',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    parentMessageId = _i1.ColumnInt(
      'parentMessageId',
      this,
    );
    readAt = _i1.ColumnDateTime(
      'readAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final LearnerTrainerMessageUpdateTable updateTable;

  late final _i1.ColumnInt courseVersionId;

  _i2.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt fromUserId;

  _i3.PharmaUserTable? _fromUser;

  late final _i1.ColumnInt toUserId;

  _i3.PharmaUserTable? _toUser;

  late final _i1.ColumnString body;

  late final _i1.ColumnInt parentMessageId;

  _i4.LearnerTrainerMessageTable? _parentMessage;

  late final _i1.ColumnDateTime readAt;

  late final _i1.ColumnDateTime createdAt;

  _i2.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: LearnerTrainerMessage.t.courseVersionId,
      foreignField: _i2.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i3.PharmaUserTable get fromUser {
    if (_fromUser != null) return _fromUser!;
    _fromUser = _i1.createRelationTable(
      relationFieldName: 'fromUser',
      field: LearnerTrainerMessage.t.fromUserId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _fromUser!;
  }

  _i3.PharmaUserTable get toUser {
    if (_toUser != null) return _toUser!;
    _toUser = _i1.createRelationTable(
      relationFieldName: 'toUser',
      field: LearnerTrainerMessage.t.toUserId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _toUser!;
  }

  _i4.LearnerTrainerMessageTable get parentMessage {
    if (_parentMessage != null) return _parentMessage!;
    _parentMessage = _i1.createRelationTable(
      relationFieldName: 'parentMessage',
      field: LearnerTrainerMessage.t.parentMessageId,
      foreignField: _i4.LearnerTrainerMessage.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.LearnerTrainerMessageTable(tableRelation: foreignTableRelation),
    );
    return _parentMessage!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseVersionId,
    fromUserId,
    toUserId,
    body,
    parentMessageId,
    readAt,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'fromUser') {
      return fromUser;
    }
    if (relationField == 'toUser') {
      return toUser;
    }
    if (relationField == 'parentMessage') {
      return parentMessage;
    }
    return null;
  }
}

class LearnerTrainerMessageInclude extends _i1.IncludeObject {
  LearnerTrainerMessageInclude._({
    _i2.CourseVersionInclude? courseVersion,
    _i3.PharmaUserInclude? fromUser,
    _i3.PharmaUserInclude? toUser,
    _i4.LearnerTrainerMessageInclude? parentMessage,
  }) {
    _courseVersion = courseVersion;
    _fromUser = fromUser;
    _toUser = toUser;
    _parentMessage = parentMessage;
  }

  _i2.CourseVersionInclude? _courseVersion;

  _i3.PharmaUserInclude? _fromUser;

  _i3.PharmaUserInclude? _toUser;

  _i4.LearnerTrainerMessageInclude? _parentMessage;

  @override
  Map<String, _i1.Include?> get includes => {
    'courseVersion': _courseVersion,
    'fromUser': _fromUser,
    'toUser': _toUser,
    'parentMessage': _parentMessage,
  };

  @override
  _i1.Table<int?> get table => LearnerTrainerMessage.t;
}

class LearnerTrainerMessageIncludeList extends _i1.IncludeList {
  LearnerTrainerMessageIncludeList._({
    _i1.WhereExpressionBuilder<LearnerTrainerMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LearnerTrainerMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LearnerTrainerMessage.t;
}

class LearnerTrainerMessageRepository {
  const LearnerTrainerMessageRepository._();

  final attachRow = const LearnerTrainerMessageAttachRowRepository._();

  final detachRow = const LearnerTrainerMessageDetachRowRepository._();

  /// Returns a list of [LearnerTrainerMessage]s matching the given query parameters.
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
  Future<List<LearnerTrainerMessage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LearnerTrainerMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LearnerTrainerMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LearnerTrainerMessageTable>? orderByList,
    _i1.Transaction? transaction,
    LearnerTrainerMessageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LearnerTrainerMessage>(
      where: where?.call(LearnerTrainerMessage.t),
      orderBy: orderBy?.call(LearnerTrainerMessage.t),
      orderByList: orderByList?.call(LearnerTrainerMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LearnerTrainerMessage] matching the given query parameters.
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
  Future<LearnerTrainerMessage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LearnerTrainerMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<LearnerTrainerMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LearnerTrainerMessageTable>? orderByList,
    _i1.Transaction? transaction,
    LearnerTrainerMessageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LearnerTrainerMessage>(
      where: where?.call(LearnerTrainerMessage.t),
      orderBy: orderBy?.call(LearnerTrainerMessage.t),
      orderByList: orderByList?.call(LearnerTrainerMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LearnerTrainerMessage] by its [id] or null if no such row exists.
  Future<LearnerTrainerMessage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    LearnerTrainerMessageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LearnerTrainerMessage>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LearnerTrainerMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [LearnerTrainerMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LearnerTrainerMessage>> insert(
    _i1.DatabaseSession session,
    List<LearnerTrainerMessage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LearnerTrainerMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LearnerTrainerMessage] and returns the inserted row.
  ///
  /// The returned [LearnerTrainerMessage] will have its `id` field set.
  Future<LearnerTrainerMessage> insertRow(
    _i1.DatabaseSession session,
    LearnerTrainerMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LearnerTrainerMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LearnerTrainerMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LearnerTrainerMessage>> update(
    _i1.DatabaseSession session,
    List<LearnerTrainerMessage> rows, {
    _i1.ColumnSelections<LearnerTrainerMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LearnerTrainerMessage>(
      rows,
      columns: columns?.call(LearnerTrainerMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LearnerTrainerMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LearnerTrainerMessage> updateRow(
    _i1.DatabaseSession session,
    LearnerTrainerMessage row, {
    _i1.ColumnSelections<LearnerTrainerMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LearnerTrainerMessage>(
      row,
      columns: columns?.call(LearnerTrainerMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LearnerTrainerMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LearnerTrainerMessage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LearnerTrainerMessageUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LearnerTrainerMessage>(
      id,
      columnValues: columnValues(LearnerTrainerMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LearnerTrainerMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LearnerTrainerMessage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LearnerTrainerMessageUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<LearnerTrainerMessageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LearnerTrainerMessageTable>? orderBy,
    _i1.OrderByListBuilder<LearnerTrainerMessageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LearnerTrainerMessage>(
      columnValues: columnValues(LearnerTrainerMessage.t.updateTable),
      where: where(LearnerTrainerMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LearnerTrainerMessage.t),
      orderByList: orderByList?.call(LearnerTrainerMessage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LearnerTrainerMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LearnerTrainerMessage>> delete(
    _i1.DatabaseSession session,
    List<LearnerTrainerMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LearnerTrainerMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LearnerTrainerMessage].
  Future<LearnerTrainerMessage> deleteRow(
    _i1.DatabaseSession session,
    LearnerTrainerMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LearnerTrainerMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LearnerTrainerMessage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LearnerTrainerMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LearnerTrainerMessage>(
      where: where(LearnerTrainerMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LearnerTrainerMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LearnerTrainerMessage>(
      where: where?.call(LearnerTrainerMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LearnerTrainerMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LearnerTrainerMessageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LearnerTrainerMessage>(
      where: where(LearnerTrainerMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LearnerTrainerMessageAttachRowRepository {
  const LearnerTrainerMessageAttachRowRepository._();

  /// Creates a relation between the given [LearnerTrainerMessage] and [CourseVersion]
  /// by setting the [LearnerTrainerMessage]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    LearnerTrainerMessage learnerTrainerMessage,
    _i2.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (learnerTrainerMessage.id == null) {
      throw ArgumentError.notNull('learnerTrainerMessage.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $learnerTrainerMessage = learnerTrainerMessage.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<LearnerTrainerMessage>(
      $learnerTrainerMessage,
      columns: [LearnerTrainerMessage.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LearnerTrainerMessage] and [PharmaUser]
  /// by setting the [LearnerTrainerMessage]'s foreign key `fromUserId` to refer to the [PharmaUser].
  Future<void> fromUser(
    _i1.DatabaseSession session,
    LearnerTrainerMessage learnerTrainerMessage,
    _i3.PharmaUser fromUser, {
    _i1.Transaction? transaction,
  }) async {
    if (learnerTrainerMessage.id == null) {
      throw ArgumentError.notNull('learnerTrainerMessage.id');
    }
    if (fromUser.id == null) {
      throw ArgumentError.notNull('fromUser.id');
    }

    var $learnerTrainerMessage = learnerTrainerMessage.copyWith(
      fromUserId: fromUser.id,
    );
    await session.db.updateRow<LearnerTrainerMessage>(
      $learnerTrainerMessage,
      columns: [LearnerTrainerMessage.t.fromUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LearnerTrainerMessage] and [PharmaUser]
  /// by setting the [LearnerTrainerMessage]'s foreign key `toUserId` to refer to the [PharmaUser].
  Future<void> toUser(
    _i1.DatabaseSession session,
    LearnerTrainerMessage learnerTrainerMessage,
    _i3.PharmaUser toUser, {
    _i1.Transaction? transaction,
  }) async {
    if (learnerTrainerMessage.id == null) {
      throw ArgumentError.notNull('learnerTrainerMessage.id');
    }
    if (toUser.id == null) {
      throw ArgumentError.notNull('toUser.id');
    }

    var $learnerTrainerMessage = learnerTrainerMessage.copyWith(
      toUserId: toUser.id,
    );
    await session.db.updateRow<LearnerTrainerMessage>(
      $learnerTrainerMessage,
      columns: [LearnerTrainerMessage.t.toUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [LearnerTrainerMessage] and [LearnerTrainerMessage]
  /// by setting the [LearnerTrainerMessage]'s foreign key `parentMessageId` to refer to the [LearnerTrainerMessage].
  Future<void> parentMessage(
    _i1.DatabaseSession session,
    LearnerTrainerMessage learnerTrainerMessage,
    _i4.LearnerTrainerMessage parentMessage, {
    _i1.Transaction? transaction,
  }) async {
    if (learnerTrainerMessage.id == null) {
      throw ArgumentError.notNull('learnerTrainerMessage.id');
    }
    if (parentMessage.id == null) {
      throw ArgumentError.notNull('parentMessage.id');
    }

    var $learnerTrainerMessage = learnerTrainerMessage.copyWith(
      parentMessageId: parentMessage.id,
    );
    await session.db.updateRow<LearnerTrainerMessage>(
      $learnerTrainerMessage,
      columns: [LearnerTrainerMessage.t.parentMessageId],
      transaction: transaction,
    );
  }
}

class LearnerTrainerMessageDetachRowRepository {
  const LearnerTrainerMessageDetachRowRepository._();

  /// Detaches the relation between this [LearnerTrainerMessage] and the [LearnerTrainerMessage] set in `parentMessage`
  /// by setting the [LearnerTrainerMessage]'s foreign key `parentMessageId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> parentMessage(
    _i1.DatabaseSession session,
    LearnerTrainerMessage learnerTrainerMessage, {
    _i1.Transaction? transaction,
  }) async {
    if (learnerTrainerMessage.id == null) {
      throw ArgumentError.notNull('learnerTrainerMessage.id');
    }

    var $learnerTrainerMessage = learnerTrainerMessage.copyWith(
      parentMessageId: null,
    );
    await session.db.updateRow<LearnerTrainerMessage>(
      $learnerTrainerMessage,
      columns: [LearnerTrainerMessage.t.parentMessageId],
      transaction: transaction,
    );
  }
}
