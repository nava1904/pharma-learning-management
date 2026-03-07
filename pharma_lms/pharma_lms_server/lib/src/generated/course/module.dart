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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Module within a course version.
abstract class Module implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Module._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.title,
    int? orderIndex,
  }) : orderIndex = orderIndex ?? 0;

  factory Module({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required String title,
    int? orderIndex,
  }) = _ModuleImpl;

  factory Module.fromJson(Map<String, dynamic> jsonSerialization) {
    return Module(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      title: jsonSerialization['title'] as String,
      orderIndex: jsonSerialization['orderIndex'] as int?,
    );
  }

  static final t = ModuleTable();

  static const db = ModuleRepository._();

  @override
  int? id;

  int courseVersionId;

  /// The course version.
  _i2.CourseVersion? courseVersion;

  /// Module title.
  String title;

  /// Order index for display.
  int orderIndex;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Module]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Module copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    String? title,
    int? orderIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Module',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'title': title,
      'orderIndex': orderIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Module',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'title': title,
      'orderIndex': orderIndex,
    };
  }

  static ModuleInclude include({_i2.CourseVersionInclude? courseVersion}) {
    return ModuleInclude._(courseVersion: courseVersion);
  }

  static ModuleIncludeList includeList({
    _i1.WhereExpressionBuilder<ModuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModuleTable>? orderByList,
    ModuleInclude? include,
  }) {
    return ModuleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Module.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Module.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModuleImpl extends Module {
  _ModuleImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required String title,
    int? orderIndex,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         title: title,
         orderIndex: orderIndex,
       );

  /// Returns a shallow copy of this [Module]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Module copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    String? title,
    int? orderIndex,
  }) {
    return Module(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}

class ModuleUpdateTable extends _i1.UpdateTable<ModuleTable> {
  ModuleUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<int, int> orderIndex(int value) => _i1.ColumnValue(
    table.orderIndex,
    value,
  );
}

class ModuleTable extends _i1.Table<int?> {
  ModuleTable({super.tableRelation}) : super(tableName: 'module') {
    updateTable = ModuleUpdateTable(this);
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
      hasDefault: true,
    );
  }

  late final ModuleUpdateTable updateTable;

  late final _i1.ColumnInt courseVersionId;

  /// The course version.
  _i2.CourseVersionTable? _courseVersion;

  /// Module title.
  late final _i1.ColumnString title;

  /// Order index for display.
  late final _i1.ColumnInt orderIndex;

  _i2.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: Module.t.courseVersionId,
      foreignField: _i2.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseVersionId,
    title,
    orderIndex,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    return null;
  }
}

class ModuleInclude extends _i1.IncludeObject {
  ModuleInclude._({_i2.CourseVersionInclude? courseVersion}) {
    _courseVersion = courseVersion;
  }

  _i2.CourseVersionInclude? _courseVersion;

  @override
  Map<String, _i1.Include?> get includes => {'courseVersion': _courseVersion};

  @override
  _i1.Table<int?> get table => Module.t;
}

class ModuleIncludeList extends _i1.IncludeList {
  ModuleIncludeList._({
    _i1.WhereExpressionBuilder<ModuleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Module.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Module.t;
}

class ModuleRepository {
  const ModuleRepository._();

  final attachRow = const ModuleAttachRowRepository._();

  /// Returns a list of [Module]s matching the given query parameters.
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
  Future<List<Module>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ModuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModuleTable>? orderByList,
    _i1.Transaction? transaction,
    ModuleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Module>(
      where: where?.call(Module.t),
      orderBy: orderBy?.call(Module.t),
      orderByList: orderByList?.call(Module.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Module] matching the given query parameters.
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
  Future<Module?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ModuleTable>? where,
    int? offset,
    _i1.OrderByBuilder<ModuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModuleTable>? orderByList,
    _i1.Transaction? transaction,
    ModuleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Module>(
      where: where?.call(Module.t),
      orderBy: orderBy?.call(Module.t),
      orderByList: orderByList?.call(Module.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Module] by its [id] or null if no such row exists.
  Future<Module?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ModuleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Module>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Module]s in the list and returns the inserted rows.
  ///
  /// The returned [Module]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Module>> insert(
    _i1.Session session,
    List<Module> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Module>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Module] and returns the inserted row.
  ///
  /// The returned [Module] will have its `id` field set.
  Future<Module> insertRow(
    _i1.Session session,
    Module row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Module>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Module]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Module>> update(
    _i1.Session session,
    List<Module> rows, {
    _i1.ColumnSelections<ModuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Module>(
      rows,
      columns: columns?.call(Module.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Module]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Module> updateRow(
    _i1.Session session,
    Module row, {
    _i1.ColumnSelections<ModuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Module>(
      row,
      columns: columns?.call(Module.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Module] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Module?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ModuleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Module>(
      id,
      columnValues: columnValues(Module.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Module]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Module>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ModuleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ModuleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModuleTable>? orderBy,
    _i1.OrderByListBuilder<ModuleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Module>(
      columnValues: columnValues(Module.t.updateTable),
      where: where(Module.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Module.t),
      orderByList: orderByList?.call(Module.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Module]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Module>> delete(
    _i1.Session session,
    List<Module> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Module>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Module].
  Future<Module> deleteRow(
    _i1.Session session,
    Module row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Module>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Module>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ModuleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Module>(
      where: where(Module.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ModuleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Module>(
      where: where?.call(Module.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Module] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ModuleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Module>(
      where: where(Module.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ModuleAttachRowRepository {
  const ModuleAttachRowRepository._();

  /// Creates a relation between the given [Module] and [CourseVersion]
  /// by setting the [Module]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.Session session,
    Module module,
    _i2.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (module.id == null) {
      throw ArgumentError.notNull('module.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $module = module.copyWith(courseVersionId: courseVersion.id);
    await session.db.updateRow<Module>(
      $module,
      columns: [Module.t.courseVersionId],
      transaction: transaction,
    );
  }
}
