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
import '../organization/site.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Department within a site.
abstract class Department
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Department._({
    this.id,
    required this.siteId,
    this.site,
    required this.name,
    required this.code,
  });

  factory Department({
    int? id,
    required int siteId,
    _i2.Site? site,
    required String name,
    required String code,
  }) = _DepartmentImpl;

  factory Department.fromJson(Map<String, dynamic> jsonSerialization) {
    return Department(
      id: jsonSerialization['id'] as int?,
      siteId: jsonSerialization['siteId'] as int,
      site: jsonSerialization['site'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Site>(jsonSerialization['site']),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
    );
  }

  static final t = DepartmentTable();

  static const db = DepartmentRepository._();

  @override
  int? id;

  int siteId;

  /// The site this department belongs to.
  _i2.Site? site;

  /// Department name.
  String name;

  /// Unique code for the department.
  String code;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Department]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Department copyWith({
    int? id,
    int? siteId,
    _i2.Site? site,
    String? name,
    String? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Department',
      if (id != null) 'id': id,
      'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'name': name,
      'code': code,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Department',
      if (id != null) 'id': id,
      'siteId': siteId,
      if (site != null) 'site': site?.toJsonForProtocol(),
      'name': name,
      'code': code,
    };
  }

  static DepartmentInclude include({_i2.SiteInclude? site}) {
    return DepartmentInclude._(site: site);
  }

  static DepartmentIncludeList includeList({
    _i1.WhereExpressionBuilder<DepartmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DepartmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DepartmentTable>? orderByList,
    DepartmentInclude? include,
  }) {
    return DepartmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Department.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Department.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DepartmentImpl extends Department {
  _DepartmentImpl({
    int? id,
    required int siteId,
    _i2.Site? site,
    required String name,
    required String code,
  }) : super._(
         id: id,
         siteId: siteId,
         site: site,
         name: name,
         code: code,
       );

  /// Returns a shallow copy of this [Department]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Department copyWith({
    Object? id = _Undefined,
    int? siteId,
    Object? site = _Undefined,
    String? name,
    String? code,
  }) {
    return Department(
      id: id is int? ? id : this.id,
      siteId: siteId ?? this.siteId,
      site: site is _i2.Site? ? site : this.site?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}

class DepartmentUpdateTable extends _i1.UpdateTable<DepartmentTable> {
  DepartmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
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
}

class DepartmentTable extends _i1.Table<int?> {
  DepartmentTable({super.tableRelation}) : super(tableName: 'department') {
    updateTable = DepartmentUpdateTable(this);
    siteId = _i1.ColumnInt(
      'siteId',
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
  }

  late final DepartmentUpdateTable updateTable;

  late final _i1.ColumnInt siteId;

  /// The site this department belongs to.
  _i2.SiteTable? _site;

  /// Department name.
  late final _i1.ColumnString name;

  /// Unique code for the department.
  late final _i1.ColumnString code;

  _i2.SiteTable get site {
    if (_site != null) return _site!;
    _site = _i1.createRelationTable(
      relationFieldName: 'site',
      field: Department.t.siteId,
      foreignField: _i2.Site.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SiteTable(tableRelation: foreignTableRelation),
    );
    return _site!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    siteId,
    name,
    code,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'site') {
      return site;
    }
    return null;
  }
}

class DepartmentInclude extends _i1.IncludeObject {
  DepartmentInclude._({_i2.SiteInclude? site}) {
    _site = site;
  }

  _i2.SiteInclude? _site;

  @override
  Map<String, _i1.Include?> get includes => {'site': _site};

  @override
  _i1.Table<int?> get table => Department.t;
}

class DepartmentIncludeList extends _i1.IncludeList {
  DepartmentIncludeList._({
    _i1.WhereExpressionBuilder<DepartmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Department.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Department.t;
}

class DepartmentRepository {
  const DepartmentRepository._();

  final attachRow = const DepartmentAttachRowRepository._();

  /// Returns a list of [Department]s matching the given query parameters.
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
  Future<List<Department>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DepartmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DepartmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DepartmentTable>? orderByList,
    _i1.Transaction? transaction,
    DepartmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Department>(
      where: where?.call(Department.t),
      orderBy: orderBy?.call(Department.t),
      orderByList: orderByList?.call(Department.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Department] matching the given query parameters.
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
  Future<Department?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DepartmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<DepartmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DepartmentTable>? orderByList,
    _i1.Transaction? transaction,
    DepartmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Department>(
      where: where?.call(Department.t),
      orderBy: orderBy?.call(Department.t),
      orderByList: orderByList?.call(Department.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Department] by its [id] or null if no such row exists.
  Future<Department?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    DepartmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Department>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Department]s in the list and returns the inserted rows.
  ///
  /// The returned [Department]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Department>> insert(
    _i1.Session session,
    List<Department> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Department>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Department] and returns the inserted row.
  ///
  /// The returned [Department] will have its `id` field set.
  Future<Department> insertRow(
    _i1.Session session,
    Department row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Department>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Department]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Department>> update(
    _i1.Session session,
    List<Department> rows, {
    _i1.ColumnSelections<DepartmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Department>(
      rows,
      columns: columns?.call(Department.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Department]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Department> updateRow(
    _i1.Session session,
    Department row, {
    _i1.ColumnSelections<DepartmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Department>(
      row,
      columns: columns?.call(Department.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Department] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Department?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DepartmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Department>(
      id,
      columnValues: columnValues(Department.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Department]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Department>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DepartmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DepartmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DepartmentTable>? orderBy,
    _i1.OrderByListBuilder<DepartmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Department>(
      columnValues: columnValues(Department.t.updateTable),
      where: where(Department.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Department.t),
      orderByList: orderByList?.call(Department.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Department]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Department>> delete(
    _i1.Session session,
    List<Department> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Department>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Department].
  Future<Department> deleteRow(
    _i1.Session session,
    Department row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Department>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Department>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DepartmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Department>(
      where: where(Department.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DepartmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Department>(
      where: where?.call(Department.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Department] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DepartmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Department>(
      where: where(Department.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DepartmentAttachRowRepository {
  const DepartmentAttachRowRepository._();

  /// Creates a relation between the given [Department] and [Site]
  /// by setting the [Department]'s foreign key `siteId` to refer to the [Site].
  Future<void> site(
    _i1.Session session,
    Department department,
    _i2.Site site, {
    _i1.Transaction? transaction,
  }) async {
    if (department.id == null) {
      throw ArgumentError.notNull('department.id');
    }
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }

    var $department = department.copyWith(siteId: site.id);
    await session.db.updateRow<Department>(
      $department,
      columns: [Department.t.siteId],
      transaction: transaction,
    );
  }
}
