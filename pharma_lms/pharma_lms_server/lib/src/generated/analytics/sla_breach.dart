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
import '../analytics/sla_policy.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// SLA breach record.
abstract class SlaBreach
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SlaBreach._({
    this.id,
    required this.slaPolicyId,
    this.slaPolicy,
    DateTime? breachedAt,
    this.resolvedAt,
  }) : breachedAt = breachedAt ?? DateTime.now();

  factory SlaBreach({
    int? id,
    required int slaPolicyId,
    _i2.SlaPolicy? slaPolicy,
    DateTime? breachedAt,
    DateTime? resolvedAt,
  }) = _SlaBreachImpl;

  factory SlaBreach.fromJson(Map<String, dynamic> jsonSerialization) {
    return SlaBreach(
      id: jsonSerialization['id'] as int?,
      slaPolicyId: jsonSerialization['slaPolicyId'] as int,
      slaPolicy: jsonSerialization['slaPolicy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.SlaPolicy>(
              jsonSerialization['slaPolicy'],
            ),
      breachedAt: jsonSerialization['breachedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['breachedAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = SlaBreachTable();

  static const db = SlaBreachRepository._();

  @override
  int? id;

  int slaPolicyId;

  /// The SLA policy.
  _i2.SlaPolicy? slaPolicy;

  /// When breached.
  DateTime breachedAt;

  /// When resolved (null if open).
  DateTime? resolvedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SlaBreach]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SlaBreach copyWith({
    int? id,
    int? slaPolicyId,
    _i2.SlaPolicy? slaPolicy,
    DateTime? breachedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SlaBreach',
      if (id != null) 'id': id,
      'slaPolicyId': slaPolicyId,
      if (slaPolicy != null) 'slaPolicy': slaPolicy?.toJson(),
      'breachedAt': breachedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SlaBreach',
      if (id != null) 'id': id,
      'slaPolicyId': slaPolicyId,
      if (slaPolicy != null) 'slaPolicy': slaPolicy?.toJsonForProtocol(),
      'breachedAt': breachedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static SlaBreachInclude include({_i2.SlaPolicyInclude? slaPolicy}) {
    return SlaBreachInclude._(slaPolicy: slaPolicy);
  }

  static SlaBreachIncludeList includeList({
    _i1.WhereExpressionBuilder<SlaBreachTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlaBreachTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlaBreachTable>? orderByList,
    SlaBreachInclude? include,
  }) {
    return SlaBreachIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SlaBreach.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SlaBreach.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SlaBreachImpl extends SlaBreach {
  _SlaBreachImpl({
    int? id,
    required int slaPolicyId,
    _i2.SlaPolicy? slaPolicy,
    DateTime? breachedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         slaPolicyId: slaPolicyId,
         slaPolicy: slaPolicy,
         breachedAt: breachedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [SlaBreach]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SlaBreach copyWith({
    Object? id = _Undefined,
    int? slaPolicyId,
    Object? slaPolicy = _Undefined,
    DateTime? breachedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return SlaBreach(
      id: id is int? ? id : this.id,
      slaPolicyId: slaPolicyId ?? this.slaPolicyId,
      slaPolicy: slaPolicy is _i2.SlaPolicy?
          ? slaPolicy
          : this.slaPolicy?.copyWith(),
      breachedAt: breachedAt ?? this.breachedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class SlaBreachUpdateTable extends _i1.UpdateTable<SlaBreachTable> {
  SlaBreachUpdateTable(super.table);

  _i1.ColumnValue<int, int> slaPolicyId(int value) => _i1.ColumnValue(
    table.slaPolicyId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> breachedAt(DateTime value) =>
      _i1.ColumnValue(
        table.breachedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class SlaBreachTable extends _i1.Table<int?> {
  SlaBreachTable({super.tableRelation}) : super(tableName: 'sla_breach') {
    updateTable = SlaBreachUpdateTable(this);
    slaPolicyId = _i1.ColumnInt(
      'slaPolicyId',
      this,
    );
    breachedAt = _i1.ColumnDateTime(
      'breachedAt',
      this,
      hasDefault: true,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final SlaBreachUpdateTable updateTable;

  late final _i1.ColumnInt slaPolicyId;

  /// The SLA policy.
  _i2.SlaPolicyTable? _slaPolicy;

  /// When breached.
  late final _i1.ColumnDateTime breachedAt;

  /// When resolved (null if open).
  late final _i1.ColumnDateTime resolvedAt;

  _i2.SlaPolicyTable get slaPolicy {
    if (_slaPolicy != null) return _slaPolicy!;
    _slaPolicy = _i1.createRelationTable(
      relationFieldName: 'slaPolicy',
      field: SlaBreach.t.slaPolicyId,
      foreignField: _i2.SlaPolicy.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SlaPolicyTable(tableRelation: foreignTableRelation),
    );
    return _slaPolicy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    slaPolicyId,
    breachedAt,
    resolvedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'slaPolicy') {
      return slaPolicy;
    }
    return null;
  }
}

class SlaBreachInclude extends _i1.IncludeObject {
  SlaBreachInclude._({_i2.SlaPolicyInclude? slaPolicy}) {
    _slaPolicy = slaPolicy;
  }

  _i2.SlaPolicyInclude? _slaPolicy;

  @override
  Map<String, _i1.Include?> get includes => {'slaPolicy': _slaPolicy};

  @override
  _i1.Table<int?> get table => SlaBreach.t;
}

class SlaBreachIncludeList extends _i1.IncludeList {
  SlaBreachIncludeList._({
    _i1.WhereExpressionBuilder<SlaBreachTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SlaBreach.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SlaBreach.t;
}

class SlaBreachRepository {
  const SlaBreachRepository._();

  final attachRow = const SlaBreachAttachRowRepository._();

  /// Returns a list of [SlaBreach]s matching the given query parameters.
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
  Future<List<SlaBreach>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SlaBreachTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlaBreachTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlaBreachTable>? orderByList,
    _i1.Transaction? transaction,
    SlaBreachInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SlaBreach>(
      where: where?.call(SlaBreach.t),
      orderBy: orderBy?.call(SlaBreach.t),
      orderByList: orderByList?.call(SlaBreach.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SlaBreach] matching the given query parameters.
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
  Future<SlaBreach?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SlaBreachTable>? where,
    int? offset,
    _i1.OrderByBuilder<SlaBreachTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlaBreachTable>? orderByList,
    _i1.Transaction? transaction,
    SlaBreachInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SlaBreach>(
      where: where?.call(SlaBreach.t),
      orderBy: orderBy?.call(SlaBreach.t),
      orderByList: orderByList?.call(SlaBreach.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SlaBreach] by its [id] or null if no such row exists.
  Future<SlaBreach?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SlaBreachInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SlaBreach>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SlaBreach]s in the list and returns the inserted rows.
  ///
  /// The returned [SlaBreach]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SlaBreach>> insert(
    _i1.DatabaseSession session,
    List<SlaBreach> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SlaBreach>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SlaBreach] and returns the inserted row.
  ///
  /// The returned [SlaBreach] will have its `id` field set.
  Future<SlaBreach> insertRow(
    _i1.DatabaseSession session,
    SlaBreach row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SlaBreach>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SlaBreach]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SlaBreach>> update(
    _i1.DatabaseSession session,
    List<SlaBreach> rows, {
    _i1.ColumnSelections<SlaBreachTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SlaBreach>(
      rows,
      columns: columns?.call(SlaBreach.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SlaBreach]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SlaBreach> updateRow(
    _i1.DatabaseSession session,
    SlaBreach row, {
    _i1.ColumnSelections<SlaBreachTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SlaBreach>(
      row,
      columns: columns?.call(SlaBreach.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SlaBreach] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SlaBreach?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SlaBreachUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SlaBreach>(
      id,
      columnValues: columnValues(SlaBreach.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SlaBreach]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SlaBreach>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SlaBreachUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SlaBreachTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlaBreachTable>? orderBy,
    _i1.OrderByListBuilder<SlaBreachTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SlaBreach>(
      columnValues: columnValues(SlaBreach.t.updateTable),
      where: where(SlaBreach.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SlaBreach.t),
      orderByList: orderByList?.call(SlaBreach.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SlaBreach]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SlaBreach>> delete(
    _i1.DatabaseSession session,
    List<SlaBreach> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SlaBreach>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SlaBreach].
  Future<SlaBreach> deleteRow(
    _i1.DatabaseSession session,
    SlaBreach row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SlaBreach>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SlaBreach>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SlaBreachTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SlaBreach>(
      where: where(SlaBreach.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SlaBreachTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SlaBreach>(
      where: where?.call(SlaBreach.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SlaBreach] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SlaBreachTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SlaBreach>(
      where: where(SlaBreach.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SlaBreachAttachRowRepository {
  const SlaBreachAttachRowRepository._();

  /// Creates a relation between the given [SlaBreach] and [SlaPolicy]
  /// by setting the [SlaBreach]'s foreign key `slaPolicyId` to refer to the [SlaPolicy].
  Future<void> slaPolicy(
    _i1.DatabaseSession session,
    SlaBreach slaBreach,
    _i2.SlaPolicy slaPolicy, {
    _i1.Transaction? transaction,
  }) async {
    if (slaBreach.id == null) {
      throw ArgumentError.notNull('slaBreach.id');
    }
    if (slaPolicy.id == null) {
      throw ArgumentError.notNull('slaPolicy.id');
    }

    var $slaBreach = slaBreach.copyWith(slaPolicyId: slaPolicy.id);
    await session.db.updateRow<SlaBreach>(
      $slaBreach,
      columns: [SlaBreach.t.slaPolicyId],
      transaction: transaction,
    );
  }
}
