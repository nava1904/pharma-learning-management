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
import '../organization/department.dart' as _i2;
import '../infrastructure/scheduled_job_log.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Historical snapshot of department compliance metrics for trending.
abstract class DepartmentComplianceSnapshot
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DepartmentComplianceSnapshot._({
    this.id,
    required this.departmentId,
    this.department,
    DateTime? snapshotDate,
    required this.totalEmployees,
    required this.compliantCount,
    required this.overdueCount,
    required this.upcomingCount,
    required this.complianceRate,
    this.scheduledJobLogId,
    this.scheduledJobLog,
  }) : snapshotDate = snapshotDate ?? DateTime.now();

  factory DepartmentComplianceSnapshot({
    int? id,
    required int departmentId,
    _i2.Department? department,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required int upcomingCount,
    required double complianceRate,
    int? scheduledJobLogId,
    _i3.ScheduledJobLog? scheduledJobLog,
  }) = _DepartmentComplianceSnapshotImpl;

  factory DepartmentComplianceSnapshot.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DepartmentComplianceSnapshot(
      id: jsonSerialization['id'] as int?,
      departmentId: jsonSerialization['departmentId'] as int,
      department: jsonSerialization['department'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Department>(
              jsonSerialization['department'],
            ),
      snapshotDate: jsonSerialization['snapshotDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['snapshotDate'],
            ),
      totalEmployees: jsonSerialization['totalEmployees'] as int,
      compliantCount: jsonSerialization['compliantCount'] as int,
      overdueCount: jsonSerialization['overdueCount'] as int,
      upcomingCount: jsonSerialization['upcomingCount'] as int,
      complianceRate: (jsonSerialization['complianceRate'] as num).toDouble(),
      scheduledJobLogId: jsonSerialization['scheduledJobLogId'] as int?,
      scheduledJobLog: jsonSerialization['scheduledJobLog'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.ScheduledJobLog>(
              jsonSerialization['scheduledJobLog'],
            ),
    );
  }

  static final t = DepartmentComplianceSnapshotTable();

  static const db = DepartmentComplianceSnapshotRepository._();

  @override
  int? id;

  int departmentId;

  /// The department.
  _i2.Department? department;

  /// When the snapshot was taken.
  DateTime snapshotDate;

  /// Total employees in department at snapshot time.
  int totalEmployees;

  /// Compliant employee count.
  int compliantCount;

  /// Overdue employee count.
  int overdueCount;

  /// Upcoming expiry count.
  int upcomingCount;

  /// Compliance percentage (0-100).
  double complianceRate;

  int? scheduledJobLogId;

  /// Job log reference.
  _i3.ScheduledJobLog? scheduledJobLog;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DepartmentComplianceSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DepartmentComplianceSnapshot copyWith({
    int? id,
    int? departmentId,
    _i2.Department? department,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    int? upcomingCount,
    double? complianceRate,
    int? scheduledJobLogId,
    _i3.ScheduledJobLog? scheduledJobLog,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DepartmentComplianceSnapshot',
      if (id != null) 'id': id,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJson(),
      'snapshotDate': snapshotDate.toJson(),
      'totalEmployees': totalEmployees,
      'compliantCount': compliantCount,
      'overdueCount': overdueCount,
      'upcomingCount': upcomingCount,
      'complianceRate': complianceRate,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null) 'scheduledJobLog': scheduledJobLog?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DepartmentComplianceSnapshot',
      if (id != null) 'id': id,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJsonForProtocol(),
      'snapshotDate': snapshotDate.toJson(),
      'totalEmployees': totalEmployees,
      'compliantCount': compliantCount,
      'overdueCount': overdueCount,
      'upcomingCount': upcomingCount,
      'complianceRate': complianceRate,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null)
        'scheduledJobLog': scheduledJobLog?.toJsonForProtocol(),
    };
  }

  static DepartmentComplianceSnapshotInclude include({
    _i2.DepartmentInclude? department,
    _i3.ScheduledJobLogInclude? scheduledJobLog,
  }) {
    return DepartmentComplianceSnapshotInclude._(
      department: department,
      scheduledJobLog: scheduledJobLog,
    );
  }

  static DepartmentComplianceSnapshotIncludeList includeList({
    _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DepartmentComplianceSnapshotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DepartmentComplianceSnapshotTable>? orderByList,
    DepartmentComplianceSnapshotInclude? include,
  }) {
    return DepartmentComplianceSnapshotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DepartmentComplianceSnapshot.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DepartmentComplianceSnapshot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DepartmentComplianceSnapshotImpl extends DepartmentComplianceSnapshot {
  _DepartmentComplianceSnapshotImpl({
    int? id,
    required int departmentId,
    _i2.Department? department,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required int upcomingCount,
    required double complianceRate,
    int? scheduledJobLogId,
    _i3.ScheduledJobLog? scheduledJobLog,
  }) : super._(
         id: id,
         departmentId: departmentId,
         department: department,
         snapshotDate: snapshotDate,
         totalEmployees: totalEmployees,
         compliantCount: compliantCount,
         overdueCount: overdueCount,
         upcomingCount: upcomingCount,
         complianceRate: complianceRate,
         scheduledJobLogId: scheduledJobLogId,
         scheduledJobLog: scheduledJobLog,
       );

  /// Returns a shallow copy of this [DepartmentComplianceSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DepartmentComplianceSnapshot copyWith({
    Object? id = _Undefined,
    int? departmentId,
    Object? department = _Undefined,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    int? upcomingCount,
    double? complianceRate,
    Object? scheduledJobLogId = _Undefined,
    Object? scheduledJobLog = _Undefined,
  }) {
    return DepartmentComplianceSnapshot(
      id: id is int? ? id : this.id,
      departmentId: departmentId ?? this.departmentId,
      department: department is _i2.Department?
          ? department
          : this.department?.copyWith(),
      snapshotDate: snapshotDate ?? this.snapshotDate,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      compliantCount: compliantCount ?? this.compliantCount,
      overdueCount: overdueCount ?? this.overdueCount,
      upcomingCount: upcomingCount ?? this.upcomingCount,
      complianceRate: complianceRate ?? this.complianceRate,
      scheduledJobLogId: scheduledJobLogId is int?
          ? scheduledJobLogId
          : this.scheduledJobLogId,
      scheduledJobLog: scheduledJobLog is _i3.ScheduledJobLog?
          ? scheduledJobLog
          : this.scheduledJobLog?.copyWith(),
    );
  }
}

class DepartmentComplianceSnapshotUpdateTable
    extends _i1.UpdateTable<DepartmentComplianceSnapshotTable> {
  DepartmentComplianceSnapshotUpdateTable(super.table);

  _i1.ColumnValue<int, int> departmentId(int value) => _i1.ColumnValue(
    table.departmentId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> snapshotDate(DateTime value) =>
      _i1.ColumnValue(
        table.snapshotDate,
        value,
      );

  _i1.ColumnValue<int, int> totalEmployees(int value) => _i1.ColumnValue(
    table.totalEmployees,
    value,
  );

  _i1.ColumnValue<int, int> compliantCount(int value) => _i1.ColumnValue(
    table.compliantCount,
    value,
  );

  _i1.ColumnValue<int, int> overdueCount(int value) => _i1.ColumnValue(
    table.overdueCount,
    value,
  );

  _i1.ColumnValue<int, int> upcomingCount(int value) => _i1.ColumnValue(
    table.upcomingCount,
    value,
  );

  _i1.ColumnValue<double, double> complianceRate(double value) =>
      _i1.ColumnValue(
        table.complianceRate,
        value,
      );

  _i1.ColumnValue<int, int> scheduledJobLogId(int? value) => _i1.ColumnValue(
    table.scheduledJobLogId,
    value,
  );
}

class DepartmentComplianceSnapshotTable extends _i1.Table<int?> {
  DepartmentComplianceSnapshotTable({super.tableRelation})
    : super(tableName: 'department_compliance_snapshot') {
    updateTable = DepartmentComplianceSnapshotUpdateTable(this);
    departmentId = _i1.ColumnInt(
      'departmentId',
      this,
    );
    snapshotDate = _i1.ColumnDateTime(
      'snapshotDate',
      this,
      hasDefault: true,
    );
    totalEmployees = _i1.ColumnInt(
      'totalEmployees',
      this,
    );
    compliantCount = _i1.ColumnInt(
      'compliantCount',
      this,
    );
    overdueCount = _i1.ColumnInt(
      'overdueCount',
      this,
    );
    upcomingCount = _i1.ColumnInt(
      'upcomingCount',
      this,
    );
    complianceRate = _i1.ColumnDouble(
      'complianceRate',
      this,
    );
    scheduledJobLogId = _i1.ColumnInt(
      'scheduledJobLogId',
      this,
    );
  }

  late final DepartmentComplianceSnapshotUpdateTable updateTable;

  late final _i1.ColumnInt departmentId;

  /// The department.
  _i2.DepartmentTable? _department;

  /// When the snapshot was taken.
  late final _i1.ColumnDateTime snapshotDate;

  /// Total employees in department at snapshot time.
  late final _i1.ColumnInt totalEmployees;

  /// Compliant employee count.
  late final _i1.ColumnInt compliantCount;

  /// Overdue employee count.
  late final _i1.ColumnInt overdueCount;

  /// Upcoming expiry count.
  late final _i1.ColumnInt upcomingCount;

  /// Compliance percentage (0-100).
  late final _i1.ColumnDouble complianceRate;

  late final _i1.ColumnInt scheduledJobLogId;

  /// Job log reference.
  _i3.ScheduledJobLogTable? _scheduledJobLog;

  _i2.DepartmentTable get department {
    if (_department != null) return _department!;
    _department = _i1.createRelationTable(
      relationFieldName: 'department',
      field: DepartmentComplianceSnapshot.t.departmentId,
      foreignField: _i2.Department.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DepartmentTable(tableRelation: foreignTableRelation),
    );
    return _department!;
  }

  _i3.ScheduledJobLogTable get scheduledJobLog {
    if (_scheduledJobLog != null) return _scheduledJobLog!;
    _scheduledJobLog = _i1.createRelationTable(
      relationFieldName: 'scheduledJobLog',
      field: DepartmentComplianceSnapshot.t.scheduledJobLogId,
      foreignField: _i3.ScheduledJobLog.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledJobLogTable(tableRelation: foreignTableRelation),
    );
    return _scheduledJobLog!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    departmentId,
    snapshotDate,
    totalEmployees,
    compliantCount,
    overdueCount,
    upcomingCount,
    complianceRate,
    scheduledJobLogId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'department') {
      return department;
    }
    if (relationField == 'scheduledJobLog') {
      return scheduledJobLog;
    }
    return null;
  }
}

class DepartmentComplianceSnapshotInclude extends _i1.IncludeObject {
  DepartmentComplianceSnapshotInclude._({
    _i2.DepartmentInclude? department,
    _i3.ScheduledJobLogInclude? scheduledJobLog,
  }) {
    _department = department;
    _scheduledJobLog = scheduledJobLog;
  }

  _i2.DepartmentInclude? _department;

  _i3.ScheduledJobLogInclude? _scheduledJobLog;

  @override
  Map<String, _i1.Include?> get includes => {
    'department': _department,
    'scheduledJobLog': _scheduledJobLog,
  };

  @override
  _i1.Table<int?> get table => DepartmentComplianceSnapshot.t;
}

class DepartmentComplianceSnapshotIncludeList extends _i1.IncludeList {
  DepartmentComplianceSnapshotIncludeList._({
    _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DepartmentComplianceSnapshot.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DepartmentComplianceSnapshot.t;
}

class DepartmentComplianceSnapshotRepository {
  const DepartmentComplianceSnapshotRepository._();

  final attachRow = const DepartmentComplianceSnapshotAttachRowRepository._();

  final detachRow = const DepartmentComplianceSnapshotDetachRowRepository._();

  /// Returns a list of [DepartmentComplianceSnapshot]s matching the given query parameters.
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
  Future<List<DepartmentComplianceSnapshot>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DepartmentComplianceSnapshotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DepartmentComplianceSnapshotTable>? orderByList,
    _i1.Transaction? transaction,
    DepartmentComplianceSnapshotInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DepartmentComplianceSnapshot>(
      where: where?.call(DepartmentComplianceSnapshot.t),
      orderBy: orderBy?.call(DepartmentComplianceSnapshot.t),
      orderByList: orderByList?.call(DepartmentComplianceSnapshot.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DepartmentComplianceSnapshot] matching the given query parameters.
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
  Future<DepartmentComplianceSnapshot?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>? where,
    int? offset,
    _i1.OrderByBuilder<DepartmentComplianceSnapshotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DepartmentComplianceSnapshotTable>? orderByList,
    _i1.Transaction? transaction,
    DepartmentComplianceSnapshotInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DepartmentComplianceSnapshot>(
      where: where?.call(DepartmentComplianceSnapshot.t),
      orderBy: orderBy?.call(DepartmentComplianceSnapshot.t),
      orderByList: orderByList?.call(DepartmentComplianceSnapshot.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DepartmentComplianceSnapshot] by its [id] or null if no such row exists.
  Future<DepartmentComplianceSnapshot?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DepartmentComplianceSnapshotInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DepartmentComplianceSnapshot>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DepartmentComplianceSnapshot]s in the list and returns the inserted rows.
  ///
  /// The returned [DepartmentComplianceSnapshot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DepartmentComplianceSnapshot>> insert(
    _i1.DatabaseSession session,
    List<DepartmentComplianceSnapshot> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DepartmentComplianceSnapshot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DepartmentComplianceSnapshot] and returns the inserted row.
  ///
  /// The returned [DepartmentComplianceSnapshot] will have its `id` field set.
  Future<DepartmentComplianceSnapshot> insertRow(
    _i1.DatabaseSession session,
    DepartmentComplianceSnapshot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DepartmentComplianceSnapshot>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DepartmentComplianceSnapshot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DepartmentComplianceSnapshot>> update(
    _i1.DatabaseSession session,
    List<DepartmentComplianceSnapshot> rows, {
    _i1.ColumnSelections<DepartmentComplianceSnapshotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DepartmentComplianceSnapshot>(
      rows,
      columns: columns?.call(DepartmentComplianceSnapshot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DepartmentComplianceSnapshot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DepartmentComplianceSnapshot> updateRow(
    _i1.DatabaseSession session,
    DepartmentComplianceSnapshot row, {
    _i1.ColumnSelections<DepartmentComplianceSnapshotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DepartmentComplianceSnapshot>(
      row,
      columns: columns?.call(DepartmentComplianceSnapshot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DepartmentComplianceSnapshot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DepartmentComplianceSnapshot?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DepartmentComplianceSnapshotUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DepartmentComplianceSnapshot>(
      id,
      columnValues: columnValues(DepartmentComplianceSnapshot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DepartmentComplianceSnapshot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DepartmentComplianceSnapshot>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DepartmentComplianceSnapshotUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>
    where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DepartmentComplianceSnapshotTable>? orderBy,
    _i1.OrderByListBuilder<DepartmentComplianceSnapshotTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DepartmentComplianceSnapshot>(
      columnValues: columnValues(DepartmentComplianceSnapshot.t.updateTable),
      where: where(DepartmentComplianceSnapshot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DepartmentComplianceSnapshot.t),
      orderByList: orderByList?.call(DepartmentComplianceSnapshot.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DepartmentComplianceSnapshot]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DepartmentComplianceSnapshot>> delete(
    _i1.DatabaseSession session,
    List<DepartmentComplianceSnapshot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DepartmentComplianceSnapshot>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DepartmentComplianceSnapshot].
  Future<DepartmentComplianceSnapshot> deleteRow(
    _i1.DatabaseSession session,
    DepartmentComplianceSnapshot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DepartmentComplianceSnapshot>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DepartmentComplianceSnapshot>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>
    where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DepartmentComplianceSnapshot>(
      where: where(DepartmentComplianceSnapshot.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DepartmentComplianceSnapshot>(
      where: where?.call(DepartmentComplianceSnapshot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DepartmentComplianceSnapshot] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DepartmentComplianceSnapshotTable>
    where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DepartmentComplianceSnapshot>(
      where: where(DepartmentComplianceSnapshot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DepartmentComplianceSnapshotAttachRowRepository {
  const DepartmentComplianceSnapshotAttachRowRepository._();

  /// Creates a relation between the given [DepartmentComplianceSnapshot] and [Department]
  /// by setting the [DepartmentComplianceSnapshot]'s foreign key `departmentId` to refer to the [Department].
  Future<void> department(
    _i1.DatabaseSession session,
    DepartmentComplianceSnapshot departmentComplianceSnapshot,
    _i2.Department department, {
    _i1.Transaction? transaction,
  }) async {
    if (departmentComplianceSnapshot.id == null) {
      throw ArgumentError.notNull('departmentComplianceSnapshot.id');
    }
    if (department.id == null) {
      throw ArgumentError.notNull('department.id');
    }

    var $departmentComplianceSnapshot = departmentComplianceSnapshot.copyWith(
      departmentId: department.id,
    );
    await session.db.updateRow<DepartmentComplianceSnapshot>(
      $departmentComplianceSnapshot,
      columns: [DepartmentComplianceSnapshot.t.departmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [DepartmentComplianceSnapshot] and [ScheduledJobLog]
  /// by setting the [DepartmentComplianceSnapshot]'s foreign key `scheduledJobLogId` to refer to the [ScheduledJobLog].
  Future<void> scheduledJobLog(
    _i1.DatabaseSession session,
    DepartmentComplianceSnapshot departmentComplianceSnapshot,
    _i3.ScheduledJobLog scheduledJobLog, {
    _i1.Transaction? transaction,
  }) async {
    if (departmentComplianceSnapshot.id == null) {
      throw ArgumentError.notNull('departmentComplianceSnapshot.id');
    }
    if (scheduledJobLog.id == null) {
      throw ArgumentError.notNull('scheduledJobLog.id');
    }

    var $departmentComplianceSnapshot = departmentComplianceSnapshot.copyWith(
      scheduledJobLogId: scheduledJobLog.id,
    );
    await session.db.updateRow<DepartmentComplianceSnapshot>(
      $departmentComplianceSnapshot,
      columns: [DepartmentComplianceSnapshot.t.scheduledJobLogId],
      transaction: transaction,
    );
  }
}

class DepartmentComplianceSnapshotDetachRowRepository {
  const DepartmentComplianceSnapshotDetachRowRepository._();

  /// Detaches the relation between this [DepartmentComplianceSnapshot] and the [ScheduledJobLog] set in `scheduledJobLog`
  /// by setting the [DepartmentComplianceSnapshot]'s foreign key `scheduledJobLogId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledJobLog(
    _i1.DatabaseSession session,
    DepartmentComplianceSnapshot departmentComplianceSnapshot, {
    _i1.Transaction? transaction,
  }) async {
    if (departmentComplianceSnapshot.id == null) {
      throw ArgumentError.notNull('departmentComplianceSnapshot.id');
    }

    var $departmentComplianceSnapshot = departmentComplianceSnapshot.copyWith(
      scheduledJobLogId: null,
    );
    await session.db.updateRow<DepartmentComplianceSnapshot>(
      $departmentComplianceSnapshot,
      columns: [DepartmentComplianceSnapshot.t.scheduledJobLogId],
      transaction: transaction,
    );
  }
}
