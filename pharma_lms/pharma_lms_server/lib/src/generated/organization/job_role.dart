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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Job role with training matrix for role-based training assignment.
abstract class JobRole
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobRole._({
    this.id,
    required this.departmentId,
    this.department,
    required this.name,
    required this.code,
    this.trainingMatrixJson,
  });

  factory JobRole({
    int? id,
    required int departmentId,
    _i2.Department? department,
    required String name,
    required String code,
    String? trainingMatrixJson,
  }) = _JobRoleImpl;

  factory JobRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobRole(
      id: jsonSerialization['id'] as int?,
      departmentId: jsonSerialization['departmentId'] as int,
      department: jsonSerialization['department'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Department>(
              jsonSerialization['department'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      trainingMatrixJson: jsonSerialization['trainingMatrixJson'] as String?,
    );
  }

  static final t = JobRoleTable();

  static const db = JobRoleRepository._();

  @override
  int? id;

  int departmentId;

  /// The department this job role belongs to.
  _i2.Department? department;

  /// Job role name.
  String name;

  /// Unique code for the job role.
  String code;

  /// JSON mapping of required course IDs for this role (training matrix).
  String? trainingMatrixJson;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobRole copyWith({
    int? id,
    int? departmentId,
    _i2.Department? department,
    String? name,
    String? code,
    String? trainingMatrixJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobRole',
      if (id != null) 'id': id,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJson(),
      'name': name,
      'code': code,
      if (trainingMatrixJson != null) 'trainingMatrixJson': trainingMatrixJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobRole',
      if (id != null) 'id': id,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJsonForProtocol(),
      'name': name,
      'code': code,
      if (trainingMatrixJson != null) 'trainingMatrixJson': trainingMatrixJson,
    };
  }

  static JobRoleInclude include({_i2.DepartmentInclude? department}) {
    return JobRoleInclude._(department: department);
  }

  static JobRoleIncludeList includeList({
    _i1.WhereExpressionBuilder<JobRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobRoleTable>? orderByList,
    JobRoleInclude? include,
  }) {
    return JobRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobRole.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobRoleImpl extends JobRole {
  _JobRoleImpl({
    int? id,
    required int departmentId,
    _i2.Department? department,
    required String name,
    required String code,
    String? trainingMatrixJson,
  }) : super._(
         id: id,
         departmentId: departmentId,
         department: department,
         name: name,
         code: code,
         trainingMatrixJson: trainingMatrixJson,
       );

  /// Returns a shallow copy of this [JobRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobRole copyWith({
    Object? id = _Undefined,
    int? departmentId,
    Object? department = _Undefined,
    String? name,
    String? code,
    Object? trainingMatrixJson = _Undefined,
  }) {
    return JobRole(
      id: id is int? ? id : this.id,
      departmentId: departmentId ?? this.departmentId,
      department: department is _i2.Department?
          ? department
          : this.department?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      trainingMatrixJson: trainingMatrixJson is String?
          ? trainingMatrixJson
          : this.trainingMatrixJson,
    );
  }
}

class JobRoleUpdateTable extends _i1.UpdateTable<JobRoleTable> {
  JobRoleUpdateTable(super.table);

  _i1.ColumnValue<int, int> departmentId(int value) => _i1.ColumnValue(
    table.departmentId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> trainingMatrixJson(String? value) =>
      _i1.ColumnValue(
        table.trainingMatrixJson,
        value,
      );
}

class JobRoleTable extends _i1.Table<int?> {
  JobRoleTable({super.tableRelation}) : super(tableName: 'job_role') {
    updateTable = JobRoleUpdateTable(this);
    departmentId = _i1.ColumnInt(
      'departmentId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    trainingMatrixJson = _i1.ColumnString(
      'trainingMatrixJson',
      this,
    );
  }

  late final JobRoleUpdateTable updateTable;

  late final _i1.ColumnInt departmentId;

  /// The department this job role belongs to.
  _i2.DepartmentTable? _department;

  /// Job role name.
  late final _i1.ColumnString name;

  /// Unique code for the job role.
  late final _i1.ColumnString code;

  /// JSON mapping of required course IDs for this role (training matrix).
  late final _i1.ColumnString trainingMatrixJson;

  _i2.DepartmentTable get department {
    if (_department != null) return _department!;
    _department = _i1.createRelationTable(
      relationFieldName: 'department',
      field: JobRole.t.departmentId,
      foreignField: _i2.Department.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DepartmentTable(tableRelation: foreignTableRelation),
    );
    return _department!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    departmentId,
    name,
    code,
    trainingMatrixJson,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'department') {
      return department;
    }
    return null;
  }
}

class JobRoleInclude extends _i1.IncludeObject {
  JobRoleInclude._({_i2.DepartmentInclude? department}) {
    _department = department;
  }

  _i2.DepartmentInclude? _department;

  @override
  Map<String, _i1.Include?> get includes => {'department': _department};

  @override
  _i1.Table<int?> get table => JobRole.t;
}

class JobRoleIncludeList extends _i1.IncludeList {
  JobRoleIncludeList._({
    _i1.WhereExpressionBuilder<JobRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobRole.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobRole.t;
}

class JobRoleRepository {
  const JobRoleRepository._();

  final attachRow = const JobRoleAttachRowRepository._();

  /// Returns a list of [JobRole]s matching the given query parameters.
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
  Future<List<JobRole>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobRoleTable>? orderByList,
    _i1.Transaction? transaction,
    JobRoleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobRole>(
      where: where?.call(JobRole.t),
      orderBy: orderBy?.call(JobRole.t),
      orderByList: orderByList?.call(JobRole.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobRole] matching the given query parameters.
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
  Future<JobRole?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobRoleTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobRoleTable>? orderByList,
    _i1.Transaction? transaction,
    JobRoleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobRole>(
      where: where?.call(JobRole.t),
      orderBy: orderBy?.call(JobRole.t),
      orderByList: orderByList?.call(JobRole.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobRole] by its [id] or null if no such row exists.
  Future<JobRole?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobRoleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobRole>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobRole]s in the list and returns the inserted rows.
  ///
  /// The returned [JobRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobRole>> insert(
    _i1.DatabaseSession session,
    List<JobRole> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobRole] and returns the inserted row.
  ///
  /// The returned [JobRole] will have its `id` field set.
  Future<JobRole> insertRow(
    _i1.DatabaseSession session,
    JobRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobRole>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobRole>> update(
    _i1.DatabaseSession session,
    List<JobRole> rows, {
    _i1.ColumnSelections<JobRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobRole>(
      rows,
      columns: columns?.call(JobRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobRole> updateRow(
    _i1.DatabaseSession session,
    JobRole row, {
    _i1.ColumnSelections<JobRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobRole>(
      row,
      columns: columns?.call(JobRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobRole?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobRoleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobRole>(
      id,
      columnValues: columnValues(JobRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobRole>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobRoleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<JobRoleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobRoleTable>? orderBy,
    _i1.OrderByListBuilder<JobRoleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobRole>(
      columnValues: columnValues(JobRole.t.updateTable),
      where: where(JobRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobRole.t),
      orderByList: orderByList?.call(JobRole.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobRole]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobRole>> delete(
    _i1.DatabaseSession session,
    List<JobRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobRole].
  Future<JobRole> deleteRow(
    _i1.DatabaseSession session,
    JobRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobRole>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobRole>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobRoleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobRole>(
      where: where(JobRole.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobRoleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobRole>(
      where: where?.call(JobRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobRole] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobRoleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobRole>(
      where: where(JobRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobRoleAttachRowRepository {
  const JobRoleAttachRowRepository._();

  /// Creates a relation between the given [JobRole] and [Department]
  /// by setting the [JobRole]'s foreign key `departmentId` to refer to the [Department].
  Future<void> department(
    _i1.DatabaseSession session,
    JobRole jobRole,
    _i2.Department department, {
    _i1.Transaction? transaction,
  }) async {
    if (jobRole.id == null) {
      throw ArgumentError.notNull('jobRole.id');
    }
    if (department.id == null) {
      throw ArgumentError.notNull('department.id');
    }

    var $jobRole = jobRole.copyWith(departmentId: department.id);
    await session.db.updateRow<JobRole>(
      $jobRole,
      columns: [JobRole.t.departmentId],
      transaction: transaction,
    );
  }
}
