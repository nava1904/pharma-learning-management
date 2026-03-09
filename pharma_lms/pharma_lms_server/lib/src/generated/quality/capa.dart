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
import '../quality/quality_event.dart' as _i2;
import '../training/training_assignment.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// CAPA - Corrective and Preventive Action.
abstract class Capa implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Capa._({
    this.id,
    required this.qualityEventId,
    this.qualityEvent,
    this.description,
    this.rootCause,
    bool? trainingRequired,
    this.trainingAssignmentId,
    this.trainingAssignment,
    String? status,
    this.rcaCompletedAt,
    this.effectivenessCheckDue,
    this.closedAt,
    this.closedById,
  }) : trainingRequired = trainingRequired ?? false,
       status = status ?? 'Initiation';

  factory Capa({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    String? description,
    String? rootCause,
    bool? trainingRequired,
    int? trainingAssignmentId,
    _i3.TrainingAssignment? trainingAssignment,
    String? status,
    DateTime? rcaCompletedAt,
    DateTime? effectivenessCheckDue,
    DateTime? closedAt,
    int? closedById,
  }) = _CapaImpl;

  factory Capa.fromJson(Map<String, dynamic> jsonSerialization) {
    return Capa(
      id: jsonSerialization['id'] as int?,
      qualityEventId: jsonSerialization['qualityEventId'] as int,
      qualityEvent: jsonSerialization['qualityEvent'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.QualityEvent>(
              jsonSerialization['qualityEvent'],
            ),
      description: jsonSerialization['description'] as String?,
      rootCause: jsonSerialization['rootCause'] as String?,
      trainingRequired: jsonSerialization['trainingRequired'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['trainingRequired'],
            ),
      trainingAssignmentId: jsonSerialization['trainingAssignmentId'] as int?,
      trainingAssignment: jsonSerialization['trainingAssignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.TrainingAssignment>(
              jsonSerialization['trainingAssignment'],
            ),
      status: jsonSerialization['status'] as String?,
      rcaCompletedAt: jsonSerialization['rcaCompletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['rcaCompletedAt'],
            ),
      effectivenessCheckDue: jsonSerialization['effectivenessCheckDue'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectivenessCheckDue'],
            ),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      closedById: jsonSerialization['closedById'] as int?,
    );
  }

  static final t = CapaTable();

  static const db = CapaRepository._();

  @override
  int? id;

  int qualityEventId;

  /// The quality event.
  _i2.QualityEvent? qualityEvent;

  /// Description.
  String? description;

  /// Root cause analysis.
  String? rootCause;

  /// Whether training is required.
  bool trainingRequired;

  int? trainingAssignmentId;

  /// Training assignment if created.
  _i3.TrainingAssignment? trainingAssignment;

  /// Lifecycle status: Initiation, Investigation, ActionPlanApproved, Implementation, Verification, Closed.
  String status;

  /// When RCA was completed.
  DateTime? rcaCompletedAt;

  /// When effectiveness check is due (30/60/90 days after training).
  DateTime? effectivenessCheckDue;

  /// When CAPA was closed.
  DateTime? closedAt;

  /// User who closed the CAPA.
  int? closedById;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Capa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Capa copyWith({
    int? id,
    int? qualityEventId,
    _i2.QualityEvent? qualityEvent,
    String? description,
    String? rootCause,
    bool? trainingRequired,
    int? trainingAssignmentId,
    _i3.TrainingAssignment? trainingAssignment,
    String? status,
    DateTime? rcaCompletedAt,
    DateTime? effectivenessCheckDue,
    DateTime? closedAt,
    int? closedById,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Capa',
      if (id != null) 'id': id,
      'qualityEventId': qualityEventId,
      if (qualityEvent != null) 'qualityEvent': qualityEvent?.toJson(),
      if (description != null) 'description': description,
      if (rootCause != null) 'rootCause': rootCause,
      'trainingRequired': trainingRequired,
      if (trainingAssignmentId != null)
        'trainingAssignmentId': trainingAssignmentId,
      if (trainingAssignment != null)
        'trainingAssignment': trainingAssignment?.toJson(),
      'status': status,
      if (rcaCompletedAt != null) 'rcaCompletedAt': rcaCompletedAt?.toJson(),
      if (effectivenessCheckDue != null)
        'effectivenessCheckDue': effectivenessCheckDue?.toJson(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (closedById != null) 'closedById': closedById,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Capa',
      if (id != null) 'id': id,
      'qualityEventId': qualityEventId,
      if (qualityEvent != null)
        'qualityEvent': qualityEvent?.toJsonForProtocol(),
      if (description != null) 'description': description,
      if (rootCause != null) 'rootCause': rootCause,
      'trainingRequired': trainingRequired,
      if (trainingAssignmentId != null)
        'trainingAssignmentId': trainingAssignmentId,
      if (trainingAssignment != null)
        'trainingAssignment': trainingAssignment?.toJsonForProtocol(),
      'status': status,
      if (rcaCompletedAt != null) 'rcaCompletedAt': rcaCompletedAt?.toJson(),
      if (effectivenessCheckDue != null)
        'effectivenessCheckDue': effectivenessCheckDue?.toJson(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (closedById != null) 'closedById': closedById,
    };
  }

  static CapaInclude include({
    _i2.QualityEventInclude? qualityEvent,
    _i3.TrainingAssignmentInclude? trainingAssignment,
  }) {
    return CapaInclude._(
      qualityEvent: qualityEvent,
      trainingAssignment: trainingAssignment,
    );
  }

  static CapaIncludeList includeList({
    _i1.WhereExpressionBuilder<CapaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CapaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CapaTable>? orderByList,
    CapaInclude? include,
  }) {
    return CapaIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Capa.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Capa.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CapaImpl extends Capa {
  _CapaImpl({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    String? description,
    String? rootCause,
    bool? trainingRequired,
    int? trainingAssignmentId,
    _i3.TrainingAssignment? trainingAssignment,
    String? status,
    DateTime? rcaCompletedAt,
    DateTime? effectivenessCheckDue,
    DateTime? closedAt,
    int? closedById,
  }) : super._(
         id: id,
         qualityEventId: qualityEventId,
         qualityEvent: qualityEvent,
         description: description,
         rootCause: rootCause,
         trainingRequired: trainingRequired,
         trainingAssignmentId: trainingAssignmentId,
         trainingAssignment: trainingAssignment,
         status: status,
         rcaCompletedAt: rcaCompletedAt,
         effectivenessCheckDue: effectivenessCheckDue,
         closedAt: closedAt,
         closedById: closedById,
       );

  /// Returns a shallow copy of this [Capa]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Capa copyWith({
    Object? id = _Undefined,
    int? qualityEventId,
    Object? qualityEvent = _Undefined,
    Object? description = _Undefined,
    Object? rootCause = _Undefined,
    bool? trainingRequired,
    Object? trainingAssignmentId = _Undefined,
    Object? trainingAssignment = _Undefined,
    String? status,
    Object? rcaCompletedAt = _Undefined,
    Object? effectivenessCheckDue = _Undefined,
    Object? closedAt = _Undefined,
    Object? closedById = _Undefined,
  }) {
    return Capa(
      id: id is int? ? id : this.id,
      qualityEventId: qualityEventId ?? this.qualityEventId,
      qualityEvent: qualityEvent is _i2.QualityEvent?
          ? qualityEvent
          : this.qualityEvent?.copyWith(),
      description: description is String? ? description : this.description,
      rootCause: rootCause is String? ? rootCause : this.rootCause,
      trainingRequired: trainingRequired ?? this.trainingRequired,
      trainingAssignmentId: trainingAssignmentId is int?
          ? trainingAssignmentId
          : this.trainingAssignmentId,
      trainingAssignment: trainingAssignment is _i3.TrainingAssignment?
          ? trainingAssignment
          : this.trainingAssignment?.copyWith(),
      status: status ?? this.status,
      rcaCompletedAt: rcaCompletedAt is DateTime?
          ? rcaCompletedAt
          : this.rcaCompletedAt,
      effectivenessCheckDue: effectivenessCheckDue is DateTime?
          ? effectivenessCheckDue
          : this.effectivenessCheckDue,
      closedAt: closedAt is DateTime? ? closedAt : this.closedAt,
      closedById: closedById is int? ? closedById : this.closedById,
    );
  }
}

class CapaUpdateTable extends _i1.UpdateTable<CapaTable> {
  CapaUpdateTable(super.table);

  _i1.ColumnValue<int, int> qualityEventId(int value) => _i1.ColumnValue(
    table.qualityEventId,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> rootCause(String? value) => _i1.ColumnValue(
    table.rootCause,
    value,
  );

  _i1.ColumnValue<bool, bool> trainingRequired(bool value) => _i1.ColumnValue(
    table.trainingRequired,
    value,
  );

  _i1.ColumnValue<int, int> trainingAssignmentId(int? value) => _i1.ColumnValue(
    table.trainingAssignmentId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> rcaCompletedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.rcaCompletedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> effectivenessCheckDue(DateTime? value) =>
      _i1.ColumnValue(
        table.effectivenessCheckDue,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> closedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.closedAt,
        value,
      );

  _i1.ColumnValue<int, int> closedById(int? value) => _i1.ColumnValue(
    table.closedById,
    value,
  );
}

class CapaTable extends _i1.Table<int?> {
  CapaTable({super.tableRelation}) : super(tableName: 'capa') {
    updateTable = CapaUpdateTable(this);
    qualityEventId = _i1.ColumnInt(
      'qualityEventId',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    rootCause = _i1.ColumnString(
      'rootCause',
      this,
    );
    trainingRequired = _i1.ColumnBool(
      'trainingRequired',
      this,
      hasDefault: true,
    );
    trainingAssignmentId = _i1.ColumnInt(
      'trainingAssignmentId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    rcaCompletedAt = _i1.ColumnDateTime(
      'rcaCompletedAt',
      this,
    );
    effectivenessCheckDue = _i1.ColumnDateTime(
      'effectivenessCheckDue',
      this,
    );
    closedAt = _i1.ColumnDateTime(
      'closedAt',
      this,
    );
    closedById = _i1.ColumnInt(
      'closedById',
      this,
    );
  }

  late final CapaUpdateTable updateTable;

  late final _i1.ColumnInt qualityEventId;

  /// The quality event.
  _i2.QualityEventTable? _qualityEvent;

  /// Description.
  late final _i1.ColumnString description;

  /// Root cause analysis.
  late final _i1.ColumnString rootCause;

  /// Whether training is required.
  late final _i1.ColumnBool trainingRequired;

  late final _i1.ColumnInt trainingAssignmentId;

  /// Training assignment if created.
  _i3.TrainingAssignmentTable? _trainingAssignment;

  /// Lifecycle status: Initiation, Investigation, ActionPlanApproved, Implementation, Verification, Closed.
  late final _i1.ColumnString status;

  /// When RCA was completed.
  late final _i1.ColumnDateTime rcaCompletedAt;

  /// When effectiveness check is due (30/60/90 days after training).
  late final _i1.ColumnDateTime effectivenessCheckDue;

  /// When CAPA was closed.
  late final _i1.ColumnDateTime closedAt;

  /// User who closed the CAPA.
  late final _i1.ColumnInt closedById;

  _i2.QualityEventTable get qualityEvent {
    if (_qualityEvent != null) return _qualityEvent!;
    _qualityEvent = _i1.createRelationTable(
      relationFieldName: 'qualityEvent',
      field: Capa.t.qualityEventId,
      foreignField: _i2.QualityEvent.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.QualityEventTable(tableRelation: foreignTableRelation),
    );
    return _qualityEvent!;
  }

  _i3.TrainingAssignmentTable get trainingAssignment {
    if (_trainingAssignment != null) return _trainingAssignment!;
    _trainingAssignment = _i1.createRelationTable(
      relationFieldName: 'trainingAssignment',
      field: Capa.t.trainingAssignmentId,
      foreignField: _i3.TrainingAssignment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TrainingAssignmentTable(tableRelation: foreignTableRelation),
    );
    return _trainingAssignment!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    qualityEventId,
    description,
    rootCause,
    trainingRequired,
    trainingAssignmentId,
    status,
    rcaCompletedAt,
    effectivenessCheckDue,
    closedAt,
    closedById,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'qualityEvent') {
      return qualityEvent;
    }
    if (relationField == 'trainingAssignment') {
      return trainingAssignment;
    }
    return null;
  }
}

class CapaInclude extends _i1.IncludeObject {
  CapaInclude._({
    _i2.QualityEventInclude? qualityEvent,
    _i3.TrainingAssignmentInclude? trainingAssignment,
  }) {
    _qualityEvent = qualityEvent;
    _trainingAssignment = trainingAssignment;
  }

  _i2.QualityEventInclude? _qualityEvent;

  _i3.TrainingAssignmentInclude? _trainingAssignment;

  @override
  Map<String, _i1.Include?> get includes => {
    'qualityEvent': _qualityEvent,
    'trainingAssignment': _trainingAssignment,
  };

  @override
  _i1.Table<int?> get table => Capa.t;
}

class CapaIncludeList extends _i1.IncludeList {
  CapaIncludeList._({
    _i1.WhereExpressionBuilder<CapaTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Capa.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Capa.t;
}

class CapaRepository {
  const CapaRepository._();

  final attachRow = const CapaAttachRowRepository._();

  final detachRow = const CapaDetachRowRepository._();

  /// Returns a list of [Capa]s matching the given query parameters.
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
  Future<List<Capa>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CapaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CapaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CapaTable>? orderByList,
    _i1.Transaction? transaction,
    CapaInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Capa>(
      where: where?.call(Capa.t),
      orderBy: orderBy?.call(Capa.t),
      orderByList: orderByList?.call(Capa.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Capa] matching the given query parameters.
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
  Future<Capa?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CapaTable>? where,
    int? offset,
    _i1.OrderByBuilder<CapaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CapaTable>? orderByList,
    _i1.Transaction? transaction,
    CapaInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Capa>(
      where: where?.call(Capa.t),
      orderBy: orderBy?.call(Capa.t),
      orderByList: orderByList?.call(Capa.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Capa] by its [id] or null if no such row exists.
  Future<Capa?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CapaInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Capa>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Capa]s in the list and returns the inserted rows.
  ///
  /// The returned [Capa]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Capa>> insert(
    _i1.Session session,
    List<Capa> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Capa>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Capa] and returns the inserted row.
  ///
  /// The returned [Capa] will have its `id` field set.
  Future<Capa> insertRow(
    _i1.Session session,
    Capa row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Capa>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Capa]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Capa>> update(
    _i1.Session session,
    List<Capa> rows, {
    _i1.ColumnSelections<CapaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Capa>(
      rows,
      columns: columns?.call(Capa.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Capa]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Capa> updateRow(
    _i1.Session session,
    Capa row, {
    _i1.ColumnSelections<CapaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Capa>(
      row,
      columns: columns?.call(Capa.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Capa] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Capa?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CapaUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Capa>(
      id,
      columnValues: columnValues(Capa.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Capa]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Capa>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CapaUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CapaTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CapaTable>? orderBy,
    _i1.OrderByListBuilder<CapaTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Capa>(
      columnValues: columnValues(Capa.t.updateTable),
      where: where(Capa.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Capa.t),
      orderByList: orderByList?.call(Capa.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Capa]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Capa>> delete(
    _i1.Session session,
    List<Capa> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Capa>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Capa].
  Future<Capa> deleteRow(
    _i1.Session session,
    Capa row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Capa>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Capa>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CapaTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Capa>(
      where: where(Capa.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CapaTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Capa>(
      where: where?.call(Capa.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Capa] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CapaTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Capa>(
      where: where(Capa.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CapaAttachRowRepository {
  const CapaAttachRowRepository._();

  /// Creates a relation between the given [Capa] and [QualityEvent]
  /// by setting the [Capa]'s foreign key `qualityEventId` to refer to the [QualityEvent].
  Future<void> qualityEvent(
    _i1.Session session,
    Capa capa,
    _i2.QualityEvent qualityEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (capa.id == null) {
      throw ArgumentError.notNull('capa.id');
    }
    if (qualityEvent.id == null) {
      throw ArgumentError.notNull('qualityEvent.id');
    }

    var $capa = capa.copyWith(qualityEventId: qualityEvent.id);
    await session.db.updateRow<Capa>(
      $capa,
      columns: [Capa.t.qualityEventId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Capa] and [TrainingAssignment]
  /// by setting the [Capa]'s foreign key `trainingAssignmentId` to refer to the [TrainingAssignment].
  Future<void> trainingAssignment(
    _i1.Session session,
    Capa capa,
    _i3.TrainingAssignment trainingAssignment, {
    _i1.Transaction? transaction,
  }) async {
    if (capa.id == null) {
      throw ArgumentError.notNull('capa.id');
    }
    if (trainingAssignment.id == null) {
      throw ArgumentError.notNull('trainingAssignment.id');
    }

    var $capa = capa.copyWith(trainingAssignmentId: trainingAssignment.id);
    await session.db.updateRow<Capa>(
      $capa,
      columns: [Capa.t.trainingAssignmentId],
      transaction: transaction,
    );
  }
}

class CapaDetachRowRepository {
  const CapaDetachRowRepository._();

  /// Detaches the relation between this [Capa] and the [TrainingAssignment] set in `trainingAssignment`
  /// by setting the [Capa]'s foreign key `trainingAssignmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> trainingAssignment(
    _i1.Session session,
    Capa capa, {
    _i1.Transaction? transaction,
  }) async {
    if (capa.id == null) {
      throw ArgumentError.notNull('capa.id');
    }

    var $capa = capa.copyWith(trainingAssignmentId: null);
    await session.db.updateRow<Capa>(
      $capa,
      columns: [Capa.t.trainingAssignmentId],
      transaction: transaction,
    );
  }
}
