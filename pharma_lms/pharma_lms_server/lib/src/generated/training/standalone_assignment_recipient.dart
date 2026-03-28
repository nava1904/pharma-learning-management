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
import '../training/standalone_assignment.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// One row per learner assigned a [StandaloneAssignment].
abstract class StandaloneAssignmentRecipient
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StandaloneAssignmentRecipient._({
    this.id,
    required this.assignmentId,
    this.assignment,
    required this.userId,
    this.user,
    String? status,
    this.submittedAt,
    this.responseJson,
    DateTime? createdAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now();

  factory StandaloneAssignmentRecipient({
    int? id,
    required int assignmentId,
    _i2.StandaloneAssignment? assignment,
    required int userId,
    _i3.PharmaUser? user,
    String? status,
    DateTime? submittedAt,
    String? responseJson,
    DateTime? createdAt,
  }) = _StandaloneAssignmentRecipientImpl;

  factory StandaloneAssignmentRecipient.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StandaloneAssignmentRecipient(
      id: jsonSerialization['id'] as int?,
      assignmentId: jsonSerialization['assignmentId'] as int,
      assignment: jsonSerialization['assignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.StandaloneAssignment>(
              jsonSerialization['assignment'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      status: jsonSerialization['status'] as String?,
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      responseJson: jsonSerialization['responseJson'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = StandaloneAssignmentRecipientTable();

  static const db = StandaloneAssignmentRecipientRepository._();

  @override
  int? id;

  int assignmentId;

  _i2.StandaloneAssignment? assignment;

  int userId;

  _i3.PharmaUser? user;

  /// pending | submitted
  String status;

  DateTime? submittedAt;

  /// JSON: answers or open-ended text
  String? responseJson;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StandaloneAssignmentRecipient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StandaloneAssignmentRecipient copyWith({
    int? id,
    int? assignmentId,
    _i2.StandaloneAssignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? status,
    DateTime? submittedAt,
    String? responseJson,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StandaloneAssignmentRecipient',
      if (id != null) 'id': id,
      'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'status': status,
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (responseJson != null) 'responseJson': responseJson,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StandaloneAssignmentRecipient',
      if (id != null) 'id': id,
      'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJsonForProtocol(),
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'status': status,
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (responseJson != null) 'responseJson': responseJson,
      'createdAt': createdAt.toJson(),
    };
  }

  static StandaloneAssignmentRecipientInclude include({
    _i2.StandaloneAssignmentInclude? assignment,
    _i3.PharmaUserInclude? user,
  }) {
    return StandaloneAssignmentRecipientInclude._(
      assignment: assignment,
      user: user,
    );
  }

  static StandaloneAssignmentRecipientIncludeList includeList({
    _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentRecipientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandaloneAssignmentRecipientTable>? orderByList,
    StandaloneAssignmentRecipientInclude? include,
  }) {
    return StandaloneAssignmentRecipientIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StandaloneAssignmentRecipient.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StandaloneAssignmentRecipient.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StandaloneAssignmentRecipientImpl extends StandaloneAssignmentRecipient {
  _StandaloneAssignmentRecipientImpl({
    int? id,
    required int assignmentId,
    _i2.StandaloneAssignment? assignment,
    required int userId,
    _i3.PharmaUser? user,
    String? status,
    DateTime? submittedAt,
    String? responseJson,
    DateTime? createdAt,
  }) : super._(
         id: id,
         assignmentId: assignmentId,
         assignment: assignment,
         userId: userId,
         user: user,
         status: status,
         submittedAt: submittedAt,
         responseJson: responseJson,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StandaloneAssignmentRecipient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StandaloneAssignmentRecipient copyWith({
    Object? id = _Undefined,
    int? assignmentId,
    Object? assignment = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? status,
    Object? submittedAt = _Undefined,
    Object? responseJson = _Undefined,
    DateTime? createdAt,
  }) {
    return StandaloneAssignmentRecipient(
      id: id is int? ? id : this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      assignment: assignment is _i2.StandaloneAssignment?
          ? assignment
          : this.assignment?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      status: status ?? this.status,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      responseJson: responseJson is String? ? responseJson : this.responseJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StandaloneAssignmentRecipientUpdateTable
    extends _i1.UpdateTable<StandaloneAssignmentRecipientTable> {
  StandaloneAssignmentRecipientUpdateTable(super.table);

  _i1.ColumnValue<int, int> assignmentId(int value) => _i1.ColumnValue(
    table.assignmentId,
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

  _i1.ColumnValue<DateTime, DateTime> submittedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.submittedAt,
        value,
      );

  _i1.ColumnValue<String, String> responseJson(String? value) =>
      _i1.ColumnValue(
        table.responseJson,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class StandaloneAssignmentRecipientTable extends _i1.Table<int?> {
  StandaloneAssignmentRecipientTable({super.tableRelation})
    : super(tableName: 'standalone_assignment_recipient') {
    updateTable = StandaloneAssignmentRecipientUpdateTable(this);
    assignmentId = _i1.ColumnInt(
      'assignmentId',
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
    submittedAt = _i1.ColumnDateTime(
      'submittedAt',
      this,
    );
    responseJson = _i1.ColumnString(
      'responseJson',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final StandaloneAssignmentRecipientUpdateTable updateTable;

  late final _i1.ColumnInt assignmentId;

  _i2.StandaloneAssignmentTable? _assignment;

  late final _i1.ColumnInt userId;

  _i3.PharmaUserTable? _user;

  /// pending | submitted
  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime submittedAt;

  /// JSON: answers or open-ended text
  late final _i1.ColumnString responseJson;

  late final _i1.ColumnDateTime createdAt;

  _i2.StandaloneAssignmentTable get assignment {
    if (_assignment != null) return _assignment!;
    _assignment = _i1.createRelationTable(
      relationFieldName: 'assignment',
      field: StandaloneAssignmentRecipient.t.assignmentId,
      foreignField: _i2.StandaloneAssignment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.StandaloneAssignmentTable(tableRelation: foreignTableRelation),
    );
    return _assignment!;
  }

  _i3.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: StandaloneAssignmentRecipient.t.userId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    assignmentId,
    userId,
    status,
    submittedAt,
    responseJson,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'assignment') {
      return assignment;
    }
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class StandaloneAssignmentRecipientInclude extends _i1.IncludeObject {
  StandaloneAssignmentRecipientInclude._({
    _i2.StandaloneAssignmentInclude? assignment,
    _i3.PharmaUserInclude? user,
  }) {
    _assignment = assignment;
    _user = user;
  }

  _i2.StandaloneAssignmentInclude? _assignment;

  _i3.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {
    'assignment': _assignment,
    'user': _user,
  };

  @override
  _i1.Table<int?> get table => StandaloneAssignmentRecipient.t;
}

class StandaloneAssignmentRecipientIncludeList extends _i1.IncludeList {
  StandaloneAssignmentRecipientIncludeList._({
    _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StandaloneAssignmentRecipient.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StandaloneAssignmentRecipient.t;
}

class StandaloneAssignmentRecipientRepository {
  const StandaloneAssignmentRecipientRepository._();

  final attachRow = const StandaloneAssignmentRecipientAttachRowRepository._();

  /// Returns a list of [StandaloneAssignmentRecipient]s matching the given query parameters.
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
  Future<List<StandaloneAssignmentRecipient>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentRecipientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandaloneAssignmentRecipientTable>? orderByList,
    _i1.Transaction? transaction,
    StandaloneAssignmentRecipientInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StandaloneAssignmentRecipient>(
      where: where?.call(StandaloneAssignmentRecipient.t),
      orderBy: orderBy?.call(StandaloneAssignmentRecipient.t),
      orderByList: orderByList?.call(StandaloneAssignmentRecipient.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StandaloneAssignmentRecipient] matching the given query parameters.
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
  Future<StandaloneAssignmentRecipient?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>? where,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentRecipientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandaloneAssignmentRecipientTable>? orderByList,
    _i1.Transaction? transaction,
    StandaloneAssignmentRecipientInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StandaloneAssignmentRecipient>(
      where: where?.call(StandaloneAssignmentRecipient.t),
      orderBy: orderBy?.call(StandaloneAssignmentRecipient.t),
      orderByList: orderByList?.call(StandaloneAssignmentRecipient.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StandaloneAssignmentRecipient] by its [id] or null if no such row exists.
  Future<StandaloneAssignmentRecipient?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    StandaloneAssignmentRecipientInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StandaloneAssignmentRecipient>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StandaloneAssignmentRecipient]s in the list and returns the inserted rows.
  ///
  /// The returned [StandaloneAssignmentRecipient]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StandaloneAssignmentRecipient>> insert(
    _i1.DatabaseSession session,
    List<StandaloneAssignmentRecipient> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StandaloneAssignmentRecipient>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StandaloneAssignmentRecipient] and returns the inserted row.
  ///
  /// The returned [StandaloneAssignmentRecipient] will have its `id` field set.
  Future<StandaloneAssignmentRecipient> insertRow(
    _i1.DatabaseSession session,
    StandaloneAssignmentRecipient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StandaloneAssignmentRecipient>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StandaloneAssignmentRecipient]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StandaloneAssignmentRecipient>> update(
    _i1.DatabaseSession session,
    List<StandaloneAssignmentRecipient> rows, {
    _i1.ColumnSelections<StandaloneAssignmentRecipientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StandaloneAssignmentRecipient>(
      rows,
      columns: columns?.call(StandaloneAssignmentRecipient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StandaloneAssignmentRecipient]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StandaloneAssignmentRecipient> updateRow(
    _i1.DatabaseSession session,
    StandaloneAssignmentRecipient row, {
    _i1.ColumnSelections<StandaloneAssignmentRecipientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StandaloneAssignmentRecipient>(
      row,
      columns: columns?.call(StandaloneAssignmentRecipient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StandaloneAssignmentRecipient] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StandaloneAssignmentRecipient?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<
      StandaloneAssignmentRecipientUpdateTable
    >
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StandaloneAssignmentRecipient>(
      id,
      columnValues: columnValues(StandaloneAssignmentRecipient.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StandaloneAssignmentRecipient]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StandaloneAssignmentRecipient>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<
      StandaloneAssignmentRecipientUpdateTable
    >
    columnValues,
    required _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>
    where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentRecipientTable>? orderBy,
    _i1.OrderByListBuilder<StandaloneAssignmentRecipientTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StandaloneAssignmentRecipient>(
      columnValues: columnValues(StandaloneAssignmentRecipient.t.updateTable),
      where: where(StandaloneAssignmentRecipient.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StandaloneAssignmentRecipient.t),
      orderByList: orderByList?.call(StandaloneAssignmentRecipient.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StandaloneAssignmentRecipient]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StandaloneAssignmentRecipient>> delete(
    _i1.DatabaseSession session,
    List<StandaloneAssignmentRecipient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StandaloneAssignmentRecipient>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StandaloneAssignmentRecipient].
  Future<StandaloneAssignmentRecipient> deleteRow(
    _i1.DatabaseSession session,
    StandaloneAssignmentRecipient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StandaloneAssignmentRecipient>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StandaloneAssignmentRecipient>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>
    where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StandaloneAssignmentRecipient>(
      where: where(StandaloneAssignmentRecipient.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StandaloneAssignmentRecipient>(
      where: where?.call(StandaloneAssignmentRecipient.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StandaloneAssignmentRecipient] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StandaloneAssignmentRecipientTable>
    where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StandaloneAssignmentRecipient>(
      where: where(StandaloneAssignmentRecipient.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class StandaloneAssignmentRecipientAttachRowRepository {
  const StandaloneAssignmentRecipientAttachRowRepository._();

  /// Creates a relation between the given [StandaloneAssignmentRecipient] and [StandaloneAssignment]
  /// by setting the [StandaloneAssignmentRecipient]'s foreign key `assignmentId` to refer to the [StandaloneAssignment].
  Future<void> assignment(
    _i1.DatabaseSession session,
    StandaloneAssignmentRecipient standaloneAssignmentRecipient,
    _i2.StandaloneAssignment assignment, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignmentRecipient.id == null) {
      throw ArgumentError.notNull('standaloneAssignmentRecipient.id');
    }
    if (assignment.id == null) {
      throw ArgumentError.notNull('assignment.id');
    }

    var $standaloneAssignmentRecipient = standaloneAssignmentRecipient.copyWith(
      assignmentId: assignment.id,
    );
    await session.db.updateRow<StandaloneAssignmentRecipient>(
      $standaloneAssignmentRecipient,
      columns: [StandaloneAssignmentRecipient.t.assignmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StandaloneAssignmentRecipient] and [PharmaUser]
  /// by setting the [StandaloneAssignmentRecipient]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    StandaloneAssignmentRecipient standaloneAssignmentRecipient,
    _i3.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignmentRecipient.id == null) {
      throw ArgumentError.notNull('standaloneAssignmentRecipient.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $standaloneAssignmentRecipient = standaloneAssignmentRecipient.copyWith(
      userId: user.id,
    );
    await session.db.updateRow<StandaloneAssignmentRecipient>(
      $standaloneAssignmentRecipient,
      columns: [StandaloneAssignmentRecipient.t.userId],
      transaction: transaction,
    );
  }
}
