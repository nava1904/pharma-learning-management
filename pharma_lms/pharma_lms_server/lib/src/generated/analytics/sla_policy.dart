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
import '../organization/role.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// SLA policy for compliance monitoring.
abstract class SlaPolicy
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SlaPolicy._({
    this.id,
    required this.metric,
    required this.threshold,
    required this.alertRoleId,
    this.alertRole,
  });

  factory SlaPolicy({
    int? id,
    required String metric,
    required double threshold,
    required int alertRoleId,
    _i2.Role? alertRole,
  }) = _SlaPolicyImpl;

  factory SlaPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return SlaPolicy(
      id: jsonSerialization['id'] as int?,
      metric: jsonSerialization['metric'] as String,
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      alertRoleId: jsonSerialization['alertRoleId'] as int,
      alertRole: jsonSerialization['alertRole'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Role>(
              jsonSerialization['alertRole'],
            ),
    );
  }

  static final t = SlaPolicyTable();

  static const db = SlaPolicyRepository._();

  @override
  int? id;

  /// Metric (e.g., compliance_rate).
  String metric;

  /// Threshold (e.g., 90 for 90%).
  double threshold;

  int alertRoleId;

  /// Role to alert.
  _i2.Role? alertRole;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SlaPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SlaPolicy copyWith({
    int? id,
    String? metric,
    double? threshold,
    int? alertRoleId,
    _i2.Role? alertRole,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SlaPolicy',
      if (id != null) 'id': id,
      'metric': metric,
      'threshold': threshold,
      'alertRoleId': alertRoleId,
      if (alertRole != null) 'alertRole': alertRole?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SlaPolicy',
      if (id != null) 'id': id,
      'metric': metric,
      'threshold': threshold,
      'alertRoleId': alertRoleId,
      if (alertRole != null) 'alertRole': alertRole?.toJsonForProtocol(),
    };
  }

  static SlaPolicyInclude include({_i2.RoleInclude? alertRole}) {
    return SlaPolicyInclude._(alertRole: alertRole);
  }

  static SlaPolicyIncludeList includeList({
    _i1.WhereExpressionBuilder<SlaPolicyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlaPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlaPolicyTable>? orderByList,
    SlaPolicyInclude? include,
  }) {
    return SlaPolicyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SlaPolicy.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SlaPolicy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SlaPolicyImpl extends SlaPolicy {
  _SlaPolicyImpl({
    int? id,
    required String metric,
    required double threshold,
    required int alertRoleId,
    _i2.Role? alertRole,
  }) : super._(
         id: id,
         metric: metric,
         threshold: threshold,
         alertRoleId: alertRoleId,
         alertRole: alertRole,
       );

  /// Returns a shallow copy of this [SlaPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SlaPolicy copyWith({
    Object? id = _Undefined,
    String? metric,
    double? threshold,
    int? alertRoleId,
    Object? alertRole = _Undefined,
  }) {
    return SlaPolicy(
      id: id is int? ? id : this.id,
      metric: metric ?? this.metric,
      threshold: threshold ?? this.threshold,
      alertRoleId: alertRoleId ?? this.alertRoleId,
      alertRole: alertRole is _i2.Role?
          ? alertRole
          : this.alertRole?.copyWith(),
    );
  }
}

class SlaPolicyUpdateTable extends _i1.UpdateTable<SlaPolicyTable> {
  SlaPolicyUpdateTable(super.table);

  _i1.ColumnValue<String, String> metric(String value) => _i1.ColumnValue(
    table.metric,
    value,
  );

  _i1.ColumnValue<double, double> threshold(double value) => _i1.ColumnValue(
    table.threshold,
    value,
  );

  _i1.ColumnValue<int, int> alertRoleId(int value) => _i1.ColumnValue(
    table.alertRoleId,
    value,
  );
}

class SlaPolicyTable extends _i1.Table<int?> {
  SlaPolicyTable({super.tableRelation}) : super(tableName: 'sla_policy') {
    updateTable = SlaPolicyUpdateTable(this);
    metric = _i1.ColumnString(
      'metric',
      this,
    );
    threshold = _i1.ColumnDouble(
      'threshold',
      this,
    );
    alertRoleId = _i1.ColumnInt(
      'alertRoleId',
      this,
    );
  }

  late final SlaPolicyUpdateTable updateTable;

  /// Metric (e.g., compliance_rate).
  late final _i1.ColumnString metric;

  /// Threshold (e.g., 90 for 90%).
  late final _i1.ColumnDouble threshold;

  late final _i1.ColumnInt alertRoleId;

  /// Role to alert.
  _i2.RoleTable? _alertRole;

  _i2.RoleTable get alertRole {
    if (_alertRole != null) return _alertRole!;
    _alertRole = _i1.createRelationTable(
      relationFieldName: 'alertRole',
      field: SlaPolicy.t.alertRoleId,
      foreignField: _i2.Role.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoleTable(tableRelation: foreignTableRelation),
    );
    return _alertRole!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    metric,
    threshold,
    alertRoleId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'alertRole') {
      return alertRole;
    }
    return null;
  }
}

class SlaPolicyInclude extends _i1.IncludeObject {
  SlaPolicyInclude._({_i2.RoleInclude? alertRole}) {
    _alertRole = alertRole;
  }

  _i2.RoleInclude? _alertRole;

  @override
  Map<String, _i1.Include?> get includes => {'alertRole': _alertRole};

  @override
  _i1.Table<int?> get table => SlaPolicy.t;
}

class SlaPolicyIncludeList extends _i1.IncludeList {
  SlaPolicyIncludeList._({
    _i1.WhereExpressionBuilder<SlaPolicyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SlaPolicy.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SlaPolicy.t;
}

class SlaPolicyRepository {
  const SlaPolicyRepository._();

  final attachRow = const SlaPolicyAttachRowRepository._();

  /// Returns a list of [SlaPolicy]s matching the given query parameters.
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
  Future<List<SlaPolicy>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SlaPolicyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlaPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlaPolicyTable>? orderByList,
    _i1.Transaction? transaction,
    SlaPolicyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SlaPolicy>(
      where: where?.call(SlaPolicy.t),
      orderBy: orderBy?.call(SlaPolicy.t),
      orderByList: orderByList?.call(SlaPolicy.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SlaPolicy] matching the given query parameters.
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
  Future<SlaPolicy?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SlaPolicyTable>? where,
    int? offset,
    _i1.OrderByBuilder<SlaPolicyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlaPolicyTable>? orderByList,
    _i1.Transaction? transaction,
    SlaPolicyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SlaPolicy>(
      where: where?.call(SlaPolicy.t),
      orderBy: orderBy?.call(SlaPolicy.t),
      orderByList: orderByList?.call(SlaPolicy.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SlaPolicy] by its [id] or null if no such row exists.
  Future<SlaPolicy?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SlaPolicyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SlaPolicy>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SlaPolicy]s in the list and returns the inserted rows.
  ///
  /// The returned [SlaPolicy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SlaPolicy>> insert(
    _i1.DatabaseSession session,
    List<SlaPolicy> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SlaPolicy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SlaPolicy] and returns the inserted row.
  ///
  /// The returned [SlaPolicy] will have its `id` field set.
  Future<SlaPolicy> insertRow(
    _i1.DatabaseSession session,
    SlaPolicy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SlaPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SlaPolicy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SlaPolicy>> update(
    _i1.DatabaseSession session,
    List<SlaPolicy> rows, {
    _i1.ColumnSelections<SlaPolicyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SlaPolicy>(
      rows,
      columns: columns?.call(SlaPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SlaPolicy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SlaPolicy> updateRow(
    _i1.DatabaseSession session,
    SlaPolicy row, {
    _i1.ColumnSelections<SlaPolicyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SlaPolicy>(
      row,
      columns: columns?.call(SlaPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SlaPolicy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SlaPolicy?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SlaPolicyUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SlaPolicy>(
      id,
      columnValues: columnValues(SlaPolicy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SlaPolicy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SlaPolicy>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SlaPolicyUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SlaPolicyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlaPolicyTable>? orderBy,
    _i1.OrderByListBuilder<SlaPolicyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SlaPolicy>(
      columnValues: columnValues(SlaPolicy.t.updateTable),
      where: where(SlaPolicy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SlaPolicy.t),
      orderByList: orderByList?.call(SlaPolicy.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SlaPolicy]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SlaPolicy>> delete(
    _i1.DatabaseSession session,
    List<SlaPolicy> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SlaPolicy>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SlaPolicy].
  Future<SlaPolicy> deleteRow(
    _i1.DatabaseSession session,
    SlaPolicy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SlaPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SlaPolicy>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SlaPolicyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SlaPolicy>(
      where: where(SlaPolicy.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SlaPolicyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SlaPolicy>(
      where: where?.call(SlaPolicy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SlaPolicy] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SlaPolicyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SlaPolicy>(
      where: where(SlaPolicy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SlaPolicyAttachRowRepository {
  const SlaPolicyAttachRowRepository._();

  /// Creates a relation between the given [SlaPolicy] and [Role]
  /// by setting the [SlaPolicy]'s foreign key `alertRoleId` to refer to the [Role].
  Future<void> alertRole(
    _i1.DatabaseSession session,
    SlaPolicy slaPolicy,
    _i2.Role alertRole, {
    _i1.Transaction? transaction,
  }) async {
    if (slaPolicy.id == null) {
      throw ArgumentError.notNull('slaPolicy.id');
    }
    if (alertRole.id == null) {
      throw ArgumentError.notNull('alertRole.id');
    }

    var $slaPolicy = slaPolicy.copyWith(alertRoleId: alertRole.id);
    await session.db.updateRow<SlaPolicy>(
      $slaPolicy,
      columns: [SlaPolicy.t.alertRoleId],
      transaction: transaction,
    );
  }
}
