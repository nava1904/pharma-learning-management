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
import '../course/competency.dart' as _i3;
import '../training/practical_checklist_item.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Observation log entry for OQ/OJT practical evaluation.
abstract class ObservationLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ObservationLog._({
    this.id,
    required this.userId,
    this.user,
    required this.evaluatorId,
    this.evaluator,
    required this.competencyId,
    this.competency,
    required this.checklistItemId,
    this.checklistItem,
    String? result,
    this.notes,
    DateTime? observedAt,
    this.evaluatorEsignatureId,
    this.traineeEsignatureId,
    required this.organizationId,
  }) : result = result ?? 'pending',
       observedAt = observedAt ?? DateTime.now();

  factory ObservationLog({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int evaluatorId,
    _i2.PharmaUser? evaluator,
    required int competencyId,
    _i3.Competency? competency,
    required int checklistItemId,
    _i4.PracticalChecklistItem? checklistItem,
    String? result,
    String? notes,
    DateTime? observedAt,
    int? evaluatorEsignatureId,
    int? traineeEsignatureId,
    required int organizationId,
  }) = _ObservationLogImpl;

  factory ObservationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ObservationLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      evaluatorId: jsonSerialization['evaluatorId'] as int,
      evaluator: jsonSerialization['evaluator'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['evaluator'],
            ),
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Competency>(
              jsonSerialization['competency'],
            ),
      checklistItemId: jsonSerialization['checklistItemId'] as int,
      checklistItem: jsonSerialization['checklistItem'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PracticalChecklistItem>(
              jsonSerialization['checklistItem'],
            ),
      result: jsonSerialization['result'] as String?,
      notes: jsonSerialization['notes'] as String?,
      observedAt: jsonSerialization['observedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['observedAt']),
      evaluatorEsignatureId: jsonSerialization['evaluatorEsignatureId'] as int?,
      traineeEsignatureId: jsonSerialization['traineeEsignatureId'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
    );
  }

  static final t = ObservationLogTable();

  static const db = ObservationLogRepository._();

  @override
  int? id;

  int userId;

  /// The user being evaluated.
  _i2.PharmaUser? user;

  int evaluatorId;

  /// The evaluator (trainer/SME).
  _i2.PharmaUser? evaluator;

  int competencyId;

  /// The competency being observed.
  _i3.Competency? competency;

  int checklistItemId;

  /// The checklist item being observed.
  _i4.PracticalChecklistItem? checklistItem;

  /// Observation result: pass, fail, needs_improvement.
  String result;

  /// Evaluator notes/comments.
  String? notes;

  /// When the observation occurred.
  DateTime observedAt;

  /// E-signature of the evaluator (21 CFR Part 11).
  int? evaluatorEsignatureId;

  /// E-signature of the trainee (21 CFR Part 11).
  int? traineeEsignatureId;

  /// The organization.
  int organizationId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ObservationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ObservationLog copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? evaluatorId,
    _i2.PharmaUser? evaluator,
    int? competencyId,
    _i3.Competency? competency,
    int? checklistItemId,
    _i4.PracticalChecklistItem? checklistItem,
    String? result,
    String? notes,
    DateTime? observedAt,
    int? evaluatorEsignatureId,
    int? traineeEsignatureId,
    int? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ObservationLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'evaluatorId': evaluatorId,
      if (evaluator != null) 'evaluator': evaluator?.toJson(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
      'checklistItemId': checklistItemId,
      if (checklistItem != null) 'checklistItem': checklistItem?.toJson(),
      'result': result,
      if (notes != null) 'notes': notes,
      'observedAt': observedAt.toJson(),
      if (evaluatorEsignatureId != null)
        'evaluatorEsignatureId': evaluatorEsignatureId,
      if (traineeEsignatureId != null)
        'traineeEsignatureId': traineeEsignatureId,
      'organizationId': organizationId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ObservationLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'evaluatorId': evaluatorId,
      if (evaluator != null) 'evaluator': evaluator?.toJsonForProtocol(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJsonForProtocol(),
      'checklistItemId': checklistItemId,
      if (checklistItem != null)
        'checklistItem': checklistItem?.toJsonForProtocol(),
      'result': result,
      if (notes != null) 'notes': notes,
      'observedAt': observedAt.toJson(),
      if (evaluatorEsignatureId != null)
        'evaluatorEsignatureId': evaluatorEsignatureId,
      if (traineeEsignatureId != null)
        'traineeEsignatureId': traineeEsignatureId,
      'organizationId': organizationId,
    };
  }

  static ObservationLogInclude include({
    _i2.PharmaUserInclude? user,
    _i2.PharmaUserInclude? evaluator,
    _i3.CompetencyInclude? competency,
    _i4.PracticalChecklistItemInclude? checklistItem,
  }) {
    return ObservationLogInclude._(
      user: user,
      evaluator: evaluator,
      competency: competency,
      checklistItem: checklistItem,
    );
  }

  static ObservationLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ObservationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ObservationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ObservationLogTable>? orderByList,
    ObservationLogInclude? include,
  }) {
    return ObservationLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ObservationLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ObservationLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ObservationLogImpl extends ObservationLog {
  _ObservationLogImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int evaluatorId,
    _i2.PharmaUser? evaluator,
    required int competencyId,
    _i3.Competency? competency,
    required int checklistItemId,
    _i4.PracticalChecklistItem? checklistItem,
    String? result,
    String? notes,
    DateTime? observedAt,
    int? evaluatorEsignatureId,
    int? traineeEsignatureId,
    required int organizationId,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         evaluatorId: evaluatorId,
         evaluator: evaluator,
         competencyId: competencyId,
         competency: competency,
         checklistItemId: checklistItemId,
         checklistItem: checklistItem,
         result: result,
         notes: notes,
         observedAt: observedAt,
         evaluatorEsignatureId: evaluatorEsignatureId,
         traineeEsignatureId: traineeEsignatureId,
         organizationId: organizationId,
       );

  /// Returns a shallow copy of this [ObservationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ObservationLog copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? evaluatorId,
    Object? evaluator = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
    int? checklistItemId,
    Object? checklistItem = _Undefined,
    String? result,
    Object? notes = _Undefined,
    DateTime? observedAt,
    Object? evaluatorEsignatureId = _Undefined,
    Object? traineeEsignatureId = _Undefined,
    int? organizationId,
  }) {
    return ObservationLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      evaluatorId: evaluatorId ?? this.evaluatorId,
      evaluator: evaluator is _i2.PharmaUser?
          ? evaluator
          : this.evaluator?.copyWith(),
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i3.Competency?
          ? competency
          : this.competency?.copyWith(),
      checklistItemId: checklistItemId ?? this.checklistItemId,
      checklistItem: checklistItem is _i4.PracticalChecklistItem?
          ? checklistItem
          : this.checklistItem?.copyWith(),
      result: result ?? this.result,
      notes: notes is String? ? notes : this.notes,
      observedAt: observedAt ?? this.observedAt,
      evaluatorEsignatureId: evaluatorEsignatureId is int?
          ? evaluatorEsignatureId
          : this.evaluatorEsignatureId,
      traineeEsignatureId: traineeEsignatureId is int?
          ? traineeEsignatureId
          : this.traineeEsignatureId,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}

class ObservationLogUpdateTable extends _i1.UpdateTable<ObservationLogTable> {
  ObservationLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> evaluatorId(int value) => _i1.ColumnValue(
    table.evaluatorId,
    value,
  );

  _i1.ColumnValue<int, int> competencyId(int value) => _i1.ColumnValue(
    table.competencyId,
    value,
  );

  _i1.ColumnValue<int, int> checklistItemId(int value) => _i1.ColumnValue(
    table.checklistItemId,
    value,
  );

  _i1.ColumnValue<String, String> result(String value) => _i1.ColumnValue(
    table.result,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> observedAt(DateTime value) =>
      _i1.ColumnValue(
        table.observedAt,
        value,
      );

  _i1.ColumnValue<int, int> evaluatorEsignatureId(int? value) =>
      _i1.ColumnValue(
        table.evaluatorEsignatureId,
        value,
      );

  _i1.ColumnValue<int, int> traineeEsignatureId(int? value) => _i1.ColumnValue(
    table.traineeEsignatureId,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );
}

class ObservationLogTable extends _i1.Table<int?> {
  ObservationLogTable({super.tableRelation})
    : super(tableName: 'observation_log') {
    updateTable = ObservationLogUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    evaluatorId = _i1.ColumnInt(
      'evaluatorId',
      this,
    );
    competencyId = _i1.ColumnInt(
      'competencyId',
      this,
    );
    checklistItemId = _i1.ColumnInt(
      'checklistItemId',
      this,
    );
    result = _i1.ColumnString(
      'result',
      this,
      hasDefault: true,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    observedAt = _i1.ColumnDateTime(
      'observedAt',
      this,
      hasDefault: true,
    );
    evaluatorEsignatureId = _i1.ColumnInt(
      'evaluatorEsignatureId',
      this,
    );
    traineeEsignatureId = _i1.ColumnInt(
      'traineeEsignatureId',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
  }

  late final ObservationLogUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user being evaluated.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt evaluatorId;

  /// The evaluator (trainer/SME).
  _i2.PharmaUserTable? _evaluator;

  late final _i1.ColumnInt competencyId;

  /// The competency being observed.
  _i3.CompetencyTable? _competency;

  late final _i1.ColumnInt checklistItemId;

  /// The checklist item being observed.
  _i4.PracticalChecklistItemTable? _checklistItem;

  /// Observation result: pass, fail, needs_improvement.
  late final _i1.ColumnString result;

  /// Evaluator notes/comments.
  late final _i1.ColumnString notes;

  /// When the observation occurred.
  late final _i1.ColumnDateTime observedAt;

  /// E-signature of the evaluator (21 CFR Part 11).
  late final _i1.ColumnInt evaluatorEsignatureId;

  /// E-signature of the trainee (21 CFR Part 11).
  late final _i1.ColumnInt traineeEsignatureId;

  /// The organization.
  late final _i1.ColumnInt organizationId;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: ObservationLog.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i2.PharmaUserTable get evaluator {
    if (_evaluator != null) return _evaluator!;
    _evaluator = _i1.createRelationTable(
      relationFieldName: 'evaluator',
      field: ObservationLog.t.evaluatorId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _evaluator!;
  }

  _i3.CompetencyTable get competency {
    if (_competency != null) return _competency!;
    _competency = _i1.createRelationTable(
      relationFieldName: 'competency',
      field: ObservationLog.t.competencyId,
      foreignField: _i3.Competency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetencyTable(tableRelation: foreignTableRelation),
    );
    return _competency!;
  }

  _i4.PracticalChecklistItemTable get checklistItem {
    if (_checklistItem != null) return _checklistItem!;
    _checklistItem = _i1.createRelationTable(
      relationFieldName: 'checklistItem',
      field: ObservationLog.t.checklistItemId,
      foreignField: _i4.PracticalChecklistItem.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PracticalChecklistItemTable(tableRelation: foreignTableRelation),
    );
    return _checklistItem!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    evaluatorId,
    competencyId,
    checklistItemId,
    result,
    notes,
    observedAt,
    evaluatorEsignatureId,
    traineeEsignatureId,
    organizationId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'evaluator') {
      return evaluator;
    }
    if (relationField == 'competency') {
      return competency;
    }
    if (relationField == 'checklistItem') {
      return checklistItem;
    }
    return null;
  }
}

class ObservationLogInclude extends _i1.IncludeObject {
  ObservationLogInclude._({
    _i2.PharmaUserInclude? user,
    _i2.PharmaUserInclude? evaluator,
    _i3.CompetencyInclude? competency,
    _i4.PracticalChecklistItemInclude? checklistItem,
  }) {
    _user = user;
    _evaluator = evaluator;
    _competency = competency;
    _checklistItem = checklistItem;
  }

  _i2.PharmaUserInclude? _user;

  _i2.PharmaUserInclude? _evaluator;

  _i3.CompetencyInclude? _competency;

  _i4.PracticalChecklistItemInclude? _checklistItem;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'evaluator': _evaluator,
    'competency': _competency,
    'checklistItem': _checklistItem,
  };

  @override
  _i1.Table<int?> get table => ObservationLog.t;
}

class ObservationLogIncludeList extends _i1.IncludeList {
  ObservationLogIncludeList._({
    _i1.WhereExpressionBuilder<ObservationLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ObservationLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ObservationLog.t;
}

class ObservationLogRepository {
  const ObservationLogRepository._();

  final attachRow = const ObservationLogAttachRowRepository._();

  /// Returns a list of [ObservationLog]s matching the given query parameters.
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
  Future<List<ObservationLog>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ObservationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ObservationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ObservationLogTable>? orderByList,
    _i1.Transaction? transaction,
    ObservationLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ObservationLog>(
      where: where?.call(ObservationLog.t),
      orderBy: orderBy?.call(ObservationLog.t),
      orderByList: orderByList?.call(ObservationLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ObservationLog] matching the given query parameters.
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
  Future<ObservationLog?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ObservationLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ObservationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ObservationLogTable>? orderByList,
    _i1.Transaction? transaction,
    ObservationLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ObservationLog>(
      where: where?.call(ObservationLog.t),
      orderBy: orderBy?.call(ObservationLog.t),
      orderByList: orderByList?.call(ObservationLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ObservationLog] by its [id] or null if no such row exists.
  Future<ObservationLog?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ObservationLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ObservationLog>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ObservationLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ObservationLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ObservationLog>> insert(
    _i1.DatabaseSession session,
    List<ObservationLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ObservationLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ObservationLog] and returns the inserted row.
  ///
  /// The returned [ObservationLog] will have its `id` field set.
  Future<ObservationLog> insertRow(
    _i1.DatabaseSession session,
    ObservationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ObservationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ObservationLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ObservationLog>> update(
    _i1.DatabaseSession session,
    List<ObservationLog> rows, {
    _i1.ColumnSelections<ObservationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ObservationLog>(
      rows,
      columns: columns?.call(ObservationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ObservationLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ObservationLog> updateRow(
    _i1.DatabaseSession session,
    ObservationLog row, {
    _i1.ColumnSelections<ObservationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ObservationLog>(
      row,
      columns: columns?.call(ObservationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ObservationLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ObservationLog?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ObservationLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ObservationLog>(
      id,
      columnValues: columnValues(ObservationLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ObservationLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ObservationLog>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ObservationLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ObservationLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ObservationLogTable>? orderBy,
    _i1.OrderByListBuilder<ObservationLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ObservationLog>(
      columnValues: columnValues(ObservationLog.t.updateTable),
      where: where(ObservationLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ObservationLog.t),
      orderByList: orderByList?.call(ObservationLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ObservationLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ObservationLog>> delete(
    _i1.DatabaseSession session,
    List<ObservationLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ObservationLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ObservationLog].
  Future<ObservationLog> deleteRow(
    _i1.DatabaseSession session,
    ObservationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ObservationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ObservationLog>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ObservationLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ObservationLog>(
      where: where(ObservationLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ObservationLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ObservationLog>(
      where: where?.call(ObservationLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ObservationLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ObservationLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ObservationLog>(
      where: where(ObservationLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ObservationLogAttachRowRepository {
  const ObservationLogAttachRowRepository._();

  /// Creates a relation between the given [ObservationLog] and [PharmaUser]
  /// by setting the [ObservationLog]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    ObservationLog observationLog,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (observationLog.id == null) {
      throw ArgumentError.notNull('observationLog.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $observationLog = observationLog.copyWith(userId: user.id);
    await session.db.updateRow<ObservationLog>(
      $observationLog,
      columns: [ObservationLog.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ObservationLog] and [PharmaUser]
  /// by setting the [ObservationLog]'s foreign key `evaluatorId` to refer to the [PharmaUser].
  Future<void> evaluator(
    _i1.DatabaseSession session,
    ObservationLog observationLog,
    _i2.PharmaUser evaluator, {
    _i1.Transaction? transaction,
  }) async {
    if (observationLog.id == null) {
      throw ArgumentError.notNull('observationLog.id');
    }
    if (evaluator.id == null) {
      throw ArgumentError.notNull('evaluator.id');
    }

    var $observationLog = observationLog.copyWith(evaluatorId: evaluator.id);
    await session.db.updateRow<ObservationLog>(
      $observationLog,
      columns: [ObservationLog.t.evaluatorId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ObservationLog] and [Competency]
  /// by setting the [ObservationLog]'s foreign key `competencyId` to refer to the [Competency].
  Future<void> competency(
    _i1.DatabaseSession session,
    ObservationLog observationLog,
    _i3.Competency competency, {
    _i1.Transaction? transaction,
  }) async {
    if (observationLog.id == null) {
      throw ArgumentError.notNull('observationLog.id');
    }
    if (competency.id == null) {
      throw ArgumentError.notNull('competency.id');
    }

    var $observationLog = observationLog.copyWith(competencyId: competency.id);
    await session.db.updateRow<ObservationLog>(
      $observationLog,
      columns: [ObservationLog.t.competencyId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ObservationLog] and [PracticalChecklistItem]
  /// by setting the [ObservationLog]'s foreign key `checklistItemId` to refer to the [PracticalChecklistItem].
  Future<void> checklistItem(
    _i1.DatabaseSession session,
    ObservationLog observationLog,
    _i4.PracticalChecklistItem checklistItem, {
    _i1.Transaction? transaction,
  }) async {
    if (observationLog.id == null) {
      throw ArgumentError.notNull('observationLog.id');
    }
    if (checklistItem.id == null) {
      throw ArgumentError.notNull('checklistItem.id');
    }

    var $observationLog = observationLog.copyWith(
      checklistItemId: checklistItem.id,
    );
    await session.db.updateRow<ObservationLog>(
      $observationLog,
      columns: [ObservationLog.t.checklistItemId],
      transaction: transaction,
    );
  }
}
