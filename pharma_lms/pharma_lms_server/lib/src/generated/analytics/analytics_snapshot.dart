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
import '../infrastructure/scheduled_job_log.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Organization-wide analytics snapshot for historical trending.
abstract class AnalyticsSnapshot
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AnalyticsSnapshot._({
    this.id,
    DateTime? snapshotDate,
    required this.totalEmployees,
    required this.compliantCount,
    required this.overdueCount,
    required this.orgComplianceRate,
    required this.totalCertificates,
    required this.certsExpiring30d,
    required this.certsExpiring60d,
    required this.openAssignments,
    this.scheduledJobLogId,
    this.scheduledJobLog,
  }) : snapshotDate = snapshotDate ?? DateTime.now();

  factory AnalyticsSnapshot({
    int? id,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required double orgComplianceRate,
    required int totalCertificates,
    required int certsExpiring30d,
    required int certsExpiring60d,
    required int openAssignments,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) = _AnalyticsSnapshotImpl;

  factory AnalyticsSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsSnapshot(
      id: jsonSerialization['id'] as int?,
      snapshotDate: jsonSerialization['snapshotDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['snapshotDate'],
            ),
      totalEmployees: jsonSerialization['totalEmployees'] as int,
      compliantCount: jsonSerialization['compliantCount'] as int,
      overdueCount: jsonSerialization['overdueCount'] as int,
      orgComplianceRate: (jsonSerialization['orgComplianceRate'] as num)
          .toDouble(),
      totalCertificates: jsonSerialization['totalCertificates'] as int,
      certsExpiring30d: jsonSerialization['certsExpiring30d'] as int,
      certsExpiring60d: jsonSerialization['certsExpiring60d'] as int,
      openAssignments: jsonSerialization['openAssignments'] as int,
      scheduledJobLogId: jsonSerialization['scheduledJobLogId'] as int?,
      scheduledJobLog: jsonSerialization['scheduledJobLog'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.ScheduledJobLog>(
              jsonSerialization['scheduledJobLog'],
            ),
    );
  }

  static final t = AnalyticsSnapshotTable();

  static const db = AnalyticsSnapshotRepository._();

  @override
  int? id;

  /// When the snapshot was taken.
  DateTime snapshotDate;

  /// Total active employees.
  int totalEmployees;

  /// Total compliant employees.
  int compliantCount;

  /// Total overdue employees.
  int overdueCount;

  /// Organization-wide compliance rate (0-100).
  double orgComplianceRate;

  /// Total active certificates.
  int totalCertificates;

  /// Certificates expiring in 30 days.
  int certsExpiring30d;

  /// Certificates expiring in 60 days.
  int certsExpiring60d;

  /// Total open training assignments.
  int openAssignments;

  int? scheduledJobLogId;

  /// Job log reference.
  _i2.ScheduledJobLog? scheduledJobLog;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AnalyticsSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalyticsSnapshot copyWith({
    int? id,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    double? orgComplianceRate,
    int? totalCertificates,
    int? certsExpiring30d,
    int? certsExpiring60d,
    int? openAssignments,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsSnapshot',
      if (id != null) 'id': id,
      'snapshotDate': snapshotDate.toJson(),
      'totalEmployees': totalEmployees,
      'compliantCount': compliantCount,
      'overdueCount': overdueCount,
      'orgComplianceRate': orgComplianceRate,
      'totalCertificates': totalCertificates,
      'certsExpiring30d': certsExpiring30d,
      'certsExpiring60d': certsExpiring60d,
      'openAssignments': openAssignments,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null) 'scheduledJobLog': scheduledJobLog?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalyticsSnapshot',
      if (id != null) 'id': id,
      'snapshotDate': snapshotDate.toJson(),
      'totalEmployees': totalEmployees,
      'compliantCount': compliantCount,
      'overdueCount': overdueCount,
      'orgComplianceRate': orgComplianceRate,
      'totalCertificates': totalCertificates,
      'certsExpiring30d': certsExpiring30d,
      'certsExpiring60d': certsExpiring60d,
      'openAssignments': openAssignments,
      if (scheduledJobLogId != null) 'scheduledJobLogId': scheduledJobLogId,
      if (scheduledJobLog != null)
        'scheduledJobLog': scheduledJobLog?.toJsonForProtocol(),
    };
  }

  static AnalyticsSnapshotInclude include({
    _i2.ScheduledJobLogInclude? scheduledJobLog,
  }) {
    return AnalyticsSnapshotInclude._(scheduledJobLog: scheduledJobLog);
  }

  static AnalyticsSnapshotIncludeList includeList({
    _i1.WhereExpressionBuilder<AnalyticsSnapshotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnalyticsSnapshotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnalyticsSnapshotTable>? orderByList,
    AnalyticsSnapshotInclude? include,
  }) {
    return AnalyticsSnapshotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnalyticsSnapshot.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AnalyticsSnapshot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnalyticsSnapshotImpl extends AnalyticsSnapshot {
  _AnalyticsSnapshotImpl({
    int? id,
    DateTime? snapshotDate,
    required int totalEmployees,
    required int compliantCount,
    required int overdueCount,
    required double orgComplianceRate,
    required int totalCertificates,
    required int certsExpiring30d,
    required int certsExpiring60d,
    required int openAssignments,
    int? scheduledJobLogId,
    _i2.ScheduledJobLog? scheduledJobLog,
  }) : super._(
         id: id,
         snapshotDate: snapshotDate,
         totalEmployees: totalEmployees,
         compliantCount: compliantCount,
         overdueCount: overdueCount,
         orgComplianceRate: orgComplianceRate,
         totalCertificates: totalCertificates,
         certsExpiring30d: certsExpiring30d,
         certsExpiring60d: certsExpiring60d,
         openAssignments: openAssignments,
         scheduledJobLogId: scheduledJobLogId,
         scheduledJobLog: scheduledJobLog,
       );

  /// Returns a shallow copy of this [AnalyticsSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnalyticsSnapshot copyWith({
    Object? id = _Undefined,
    DateTime? snapshotDate,
    int? totalEmployees,
    int? compliantCount,
    int? overdueCount,
    double? orgComplianceRate,
    int? totalCertificates,
    int? certsExpiring30d,
    int? certsExpiring60d,
    int? openAssignments,
    Object? scheduledJobLogId = _Undefined,
    Object? scheduledJobLog = _Undefined,
  }) {
    return AnalyticsSnapshot(
      id: id is int? ? id : this.id,
      snapshotDate: snapshotDate ?? this.snapshotDate,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      compliantCount: compliantCount ?? this.compliantCount,
      overdueCount: overdueCount ?? this.overdueCount,
      orgComplianceRate: orgComplianceRate ?? this.orgComplianceRate,
      totalCertificates: totalCertificates ?? this.totalCertificates,
      certsExpiring30d: certsExpiring30d ?? this.certsExpiring30d,
      certsExpiring60d: certsExpiring60d ?? this.certsExpiring60d,
      openAssignments: openAssignments ?? this.openAssignments,
      scheduledJobLogId: scheduledJobLogId is int?
          ? scheduledJobLogId
          : this.scheduledJobLogId,
      scheduledJobLog: scheduledJobLog is _i2.ScheduledJobLog?
          ? scheduledJobLog
          : this.scheduledJobLog?.copyWith(),
    );
  }
}

class AnalyticsSnapshotUpdateTable
    extends _i1.UpdateTable<AnalyticsSnapshotTable> {
  AnalyticsSnapshotUpdateTable(super.table);

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

  _i1.ColumnValue<double, double> orgComplianceRate(double value) =>
      _i1.ColumnValue(
        table.orgComplianceRate,
        value,
      );

  _i1.ColumnValue<int, int> totalCertificates(int value) => _i1.ColumnValue(
    table.totalCertificates,
    value,
  );

  _i1.ColumnValue<int, int> certsExpiring30d(int value) => _i1.ColumnValue(
    table.certsExpiring30d,
    value,
  );

  _i1.ColumnValue<int, int> certsExpiring60d(int value) => _i1.ColumnValue(
    table.certsExpiring60d,
    value,
  );

  _i1.ColumnValue<int, int> openAssignments(int value) => _i1.ColumnValue(
    table.openAssignments,
    value,
  );

  _i1.ColumnValue<int, int> scheduledJobLogId(int? value) => _i1.ColumnValue(
    table.scheduledJobLogId,
    value,
  );
}

class AnalyticsSnapshotTable extends _i1.Table<int?> {
  AnalyticsSnapshotTable({super.tableRelation})
    : super(tableName: 'analytics_snapshot') {
    updateTable = AnalyticsSnapshotUpdateTable(this);
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
    orgComplianceRate = _i1.ColumnDouble(
      'orgComplianceRate',
      this,
    );
    totalCertificates = _i1.ColumnInt(
      'totalCertificates',
      this,
    );
    certsExpiring30d = _i1.ColumnInt(
      'certsExpiring30d',
      this,
    );
    certsExpiring60d = _i1.ColumnInt(
      'certsExpiring60d',
      this,
    );
    openAssignments = _i1.ColumnInt(
      'openAssignments',
      this,
    );
    scheduledJobLogId = _i1.ColumnInt(
      'scheduledJobLogId',
      this,
    );
  }

  late final AnalyticsSnapshotUpdateTable updateTable;

  /// When the snapshot was taken.
  late final _i1.ColumnDateTime snapshotDate;

  /// Total active employees.
  late final _i1.ColumnInt totalEmployees;

  /// Total compliant employees.
  late final _i1.ColumnInt compliantCount;

  /// Total overdue employees.
  late final _i1.ColumnInt overdueCount;

  /// Organization-wide compliance rate (0-100).
  late final _i1.ColumnDouble orgComplianceRate;

  /// Total active certificates.
  late final _i1.ColumnInt totalCertificates;

  /// Certificates expiring in 30 days.
  late final _i1.ColumnInt certsExpiring30d;

  /// Certificates expiring in 60 days.
  late final _i1.ColumnInt certsExpiring60d;

  /// Total open training assignments.
  late final _i1.ColumnInt openAssignments;

  late final _i1.ColumnInt scheduledJobLogId;

  /// Job log reference.
  _i2.ScheduledJobLogTable? _scheduledJobLog;

  _i2.ScheduledJobLogTable get scheduledJobLog {
    if (_scheduledJobLog != null) return _scheduledJobLog!;
    _scheduledJobLog = _i1.createRelationTable(
      relationFieldName: 'scheduledJobLog',
      field: AnalyticsSnapshot.t.scheduledJobLogId,
      foreignField: _i2.ScheduledJobLog.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledJobLogTable(tableRelation: foreignTableRelation),
    );
    return _scheduledJobLog!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    snapshotDate,
    totalEmployees,
    compliantCount,
    overdueCount,
    orgComplianceRate,
    totalCertificates,
    certsExpiring30d,
    certsExpiring60d,
    openAssignments,
    scheduledJobLogId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'scheduledJobLog') {
      return scheduledJobLog;
    }
    return null;
  }
}

class AnalyticsSnapshotInclude extends _i1.IncludeObject {
  AnalyticsSnapshotInclude._({_i2.ScheduledJobLogInclude? scheduledJobLog}) {
    _scheduledJobLog = scheduledJobLog;
  }

  _i2.ScheduledJobLogInclude? _scheduledJobLog;

  @override
  Map<String, _i1.Include?> get includes => {
    'scheduledJobLog': _scheduledJobLog,
  };

  @override
  _i1.Table<int?> get table => AnalyticsSnapshot.t;
}

class AnalyticsSnapshotIncludeList extends _i1.IncludeList {
  AnalyticsSnapshotIncludeList._({
    _i1.WhereExpressionBuilder<AnalyticsSnapshotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AnalyticsSnapshot.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AnalyticsSnapshot.t;
}

class AnalyticsSnapshotRepository {
  const AnalyticsSnapshotRepository._();

  final attachRow = const AnalyticsSnapshotAttachRowRepository._();

  final detachRow = const AnalyticsSnapshotDetachRowRepository._();

  /// Returns a list of [AnalyticsSnapshot]s matching the given query parameters.
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
  Future<List<AnalyticsSnapshot>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnalyticsSnapshotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnalyticsSnapshotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnalyticsSnapshotTable>? orderByList,
    _i1.Transaction? transaction,
    AnalyticsSnapshotInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AnalyticsSnapshot>(
      where: where?.call(AnalyticsSnapshot.t),
      orderBy: orderBy?.call(AnalyticsSnapshot.t),
      orderByList: orderByList?.call(AnalyticsSnapshot.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AnalyticsSnapshot] matching the given query parameters.
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
  Future<AnalyticsSnapshot?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnalyticsSnapshotTable>? where,
    int? offset,
    _i1.OrderByBuilder<AnalyticsSnapshotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnalyticsSnapshotTable>? orderByList,
    _i1.Transaction? transaction,
    AnalyticsSnapshotInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AnalyticsSnapshot>(
      where: where?.call(AnalyticsSnapshot.t),
      orderBy: orderBy?.call(AnalyticsSnapshot.t),
      orderByList: orderByList?.call(AnalyticsSnapshot.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AnalyticsSnapshot] by its [id] or null if no such row exists.
  Future<AnalyticsSnapshot?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AnalyticsSnapshotInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AnalyticsSnapshot>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AnalyticsSnapshot]s in the list and returns the inserted rows.
  ///
  /// The returned [AnalyticsSnapshot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AnalyticsSnapshot>> insert(
    _i1.Session session,
    List<AnalyticsSnapshot> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AnalyticsSnapshot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AnalyticsSnapshot] and returns the inserted row.
  ///
  /// The returned [AnalyticsSnapshot] will have its `id` field set.
  Future<AnalyticsSnapshot> insertRow(
    _i1.Session session,
    AnalyticsSnapshot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AnalyticsSnapshot>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AnalyticsSnapshot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AnalyticsSnapshot>> update(
    _i1.Session session,
    List<AnalyticsSnapshot> rows, {
    _i1.ColumnSelections<AnalyticsSnapshotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AnalyticsSnapshot>(
      rows,
      columns: columns?.call(AnalyticsSnapshot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnalyticsSnapshot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AnalyticsSnapshot> updateRow(
    _i1.Session session,
    AnalyticsSnapshot row, {
    _i1.ColumnSelections<AnalyticsSnapshotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AnalyticsSnapshot>(
      row,
      columns: columns?.call(AnalyticsSnapshot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnalyticsSnapshot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AnalyticsSnapshot?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AnalyticsSnapshotUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AnalyticsSnapshot>(
      id,
      columnValues: columnValues(AnalyticsSnapshot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AnalyticsSnapshot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AnalyticsSnapshot>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AnalyticsSnapshotUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AnalyticsSnapshotTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnalyticsSnapshotTable>? orderBy,
    _i1.OrderByListBuilder<AnalyticsSnapshotTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AnalyticsSnapshot>(
      columnValues: columnValues(AnalyticsSnapshot.t.updateTable),
      where: where(AnalyticsSnapshot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnalyticsSnapshot.t),
      orderByList: orderByList?.call(AnalyticsSnapshot.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AnalyticsSnapshot]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AnalyticsSnapshot>> delete(
    _i1.Session session,
    List<AnalyticsSnapshot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AnalyticsSnapshot>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AnalyticsSnapshot].
  Future<AnalyticsSnapshot> deleteRow(
    _i1.Session session,
    AnalyticsSnapshot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AnalyticsSnapshot>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AnalyticsSnapshot>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AnalyticsSnapshotTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AnalyticsSnapshot>(
      where: where(AnalyticsSnapshot.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnalyticsSnapshotTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AnalyticsSnapshot>(
      where: where?.call(AnalyticsSnapshot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AnalyticsSnapshot] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AnalyticsSnapshotTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AnalyticsSnapshot>(
      where: where(AnalyticsSnapshot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AnalyticsSnapshotAttachRowRepository {
  const AnalyticsSnapshotAttachRowRepository._();

  /// Creates a relation between the given [AnalyticsSnapshot] and [ScheduledJobLog]
  /// by setting the [AnalyticsSnapshot]'s foreign key `scheduledJobLogId` to refer to the [ScheduledJobLog].
  Future<void> scheduledJobLog(
    _i1.Session session,
    AnalyticsSnapshot analyticsSnapshot,
    _i2.ScheduledJobLog scheduledJobLog, {
    _i1.Transaction? transaction,
  }) async {
    if (analyticsSnapshot.id == null) {
      throw ArgumentError.notNull('analyticsSnapshot.id');
    }
    if (scheduledJobLog.id == null) {
      throw ArgumentError.notNull('scheduledJobLog.id');
    }

    var $analyticsSnapshot = analyticsSnapshot.copyWith(
      scheduledJobLogId: scheduledJobLog.id,
    );
    await session.db.updateRow<AnalyticsSnapshot>(
      $analyticsSnapshot,
      columns: [AnalyticsSnapshot.t.scheduledJobLogId],
      transaction: transaction,
    );
  }
}

class AnalyticsSnapshotDetachRowRepository {
  const AnalyticsSnapshotDetachRowRepository._();

  /// Detaches the relation between this [AnalyticsSnapshot] and the [ScheduledJobLog] set in `scheduledJobLog`
  /// by setting the [AnalyticsSnapshot]'s foreign key `scheduledJobLogId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> scheduledJobLog(
    _i1.Session session,
    AnalyticsSnapshot analyticsSnapshot, {
    _i1.Transaction? transaction,
  }) async {
    if (analyticsSnapshot.id == null) {
      throw ArgumentError.notNull('analyticsSnapshot.id');
    }

    var $analyticsSnapshot = analyticsSnapshot.copyWith(
      scheduledJobLogId: null,
    );
    await session.db.updateRow<AnalyticsSnapshot>(
      $analyticsSnapshot,
      columns: [AnalyticsSnapshot.t.scheduledJobLogId],
      transaction: transaction,
    );
  }
}
