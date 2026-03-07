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
import '../course/module.dart' as _i2;
import '../material/material.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Lesson within a module.
abstract class Lesson implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Lesson._({
    this.id,
    required this.moduleId,
    this.module,
    required this.title,
    int? orderIndex,
    required this.materialId,
    this.material,
    this.durationMinutes,
  }) : orderIndex = orderIndex ?? 0;

  factory Lesson({
    int? id,
    required int moduleId,
    _i2.Module? module,
    required String title,
    int? orderIndex,
    required int materialId,
    _i3.Material? material,
    int? durationMinutes,
  }) = _LessonImpl;

  factory Lesson.fromJson(Map<String, dynamic> jsonSerialization) {
    return Lesson(
      id: jsonSerialization['id'] as int?,
      moduleId: jsonSerialization['moduleId'] as int,
      module: jsonSerialization['module'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Module>(jsonSerialization['module']),
      title: jsonSerialization['title'] as String,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Material>(
              jsonSerialization['material'],
            ),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
    );
  }

  static final t = LessonTable();

  static const db = LessonRepository._();

  @override
  int? id;

  int moduleId;

  /// The module.
  _i2.Module? module;

  /// Lesson title.
  String title;

  /// Order index for display.
  int orderIndex;

  int materialId;

  /// Linked material for content.
  _i3.Material? material;

  /// Duration in minutes.
  int? durationMinutes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Lesson copyWith({
    int? id,
    int? moduleId,
    _i2.Module? module,
    String? title,
    int? orderIndex,
    int? materialId,
    _i3.Material? material,
    int? durationMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Lesson',
      if (id != null) 'id': id,
      'moduleId': moduleId,
      if (module != null) 'module': module?.toJson(),
      'title': title,
      'orderIndex': orderIndex,
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Lesson',
      if (id != null) 'id': id,
      'moduleId': moduleId,
      if (module != null) 'module': module?.toJsonForProtocol(),
      'title': title,
      'orderIndex': orderIndex,
      'materialId': materialId,
      if (material != null) 'material': material?.toJsonForProtocol(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
    };
  }

  static LessonInclude include({
    _i2.ModuleInclude? module,
    _i3.MaterialInclude? material,
  }) {
    return LessonInclude._(
      module: module,
      material: material,
    );
  }

  static LessonIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    LessonInclude? include,
  }) {
    return LessonIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Lesson.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Lesson.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonImpl extends Lesson {
  _LessonImpl({
    int? id,
    required int moduleId,
    _i2.Module? module,
    required String title,
    int? orderIndex,
    required int materialId,
    _i3.Material? material,
    int? durationMinutes,
  }) : super._(
         id: id,
         moduleId: moduleId,
         module: module,
         title: title,
         orderIndex: orderIndex,
         materialId: materialId,
         material: material,
         durationMinutes: durationMinutes,
       );

  /// Returns a shallow copy of this [Lesson]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Lesson copyWith({
    Object? id = _Undefined,
    int? moduleId,
    Object? module = _Undefined,
    String? title,
    int? orderIndex,
    int? materialId,
    Object? material = _Undefined,
    Object? durationMinutes = _Undefined,
  }) {
    return Lesson(
      id: id is int? ? id : this.id,
      moduleId: moduleId ?? this.moduleId,
      module: module is _i2.Module? ? module : this.module?.copyWith(),
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      materialId: materialId ?? this.materialId,
      material: material is _i3.Material?
          ? material
          : this.material?.copyWith(),
      durationMinutes: durationMinutes is int?
          ? durationMinutes
          : this.durationMinutes,
    );
  }
}

class LessonUpdateTable extends _i1.UpdateTable<LessonTable> {
  LessonUpdateTable(super.table);

  _i1.ColumnValue<int, int> moduleId(int value) => _i1.ColumnValue(
    table.moduleId,
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

  _i1.ColumnValue<int, int> materialId(int value) => _i1.ColumnValue(
    table.materialId,
    value,
  );

  _i1.ColumnValue<int, int> durationMinutes(int? value) => _i1.ColumnValue(
    table.durationMinutes,
    value,
  );
}

class LessonTable extends _i1.Table<int?> {
  LessonTable({super.tableRelation}) : super(tableName: 'lesson') {
    updateTable = LessonUpdateTable(this);
    moduleId = _i1.ColumnInt(
      'moduleId',
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
    materialId = _i1.ColumnInt(
      'materialId',
      this,
    );
    durationMinutes = _i1.ColumnInt(
      'durationMinutes',
      this,
    );
  }

  late final LessonUpdateTable updateTable;

  late final _i1.ColumnInt moduleId;

  /// The module.
  _i2.ModuleTable? _module;

  /// Lesson title.
  late final _i1.ColumnString title;

  /// Order index for display.
  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnInt materialId;

  /// Linked material for content.
  _i3.MaterialTable? _material;

  /// Duration in minutes.
  late final _i1.ColumnInt durationMinutes;

  _i2.ModuleTable get module {
    if (_module != null) return _module!;
    _module = _i1.createRelationTable(
      relationFieldName: 'module',
      field: Lesson.t.moduleId,
      foreignField: _i2.Module.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ModuleTable(tableRelation: foreignTableRelation),
    );
    return _module!;
  }

  _i3.MaterialTable get material {
    if (_material != null) return _material!;
    _material = _i1.createRelationTable(
      relationFieldName: 'material',
      field: Lesson.t.materialId,
      foreignField: _i3.Material.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.MaterialTable(tableRelation: foreignTableRelation),
    );
    return _material!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    moduleId,
    title,
    orderIndex,
    materialId,
    durationMinutes,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'module') {
      return module;
    }
    if (relationField == 'material') {
      return material;
    }
    return null;
  }
}

class LessonInclude extends _i1.IncludeObject {
  LessonInclude._({
    _i2.ModuleInclude? module,
    _i3.MaterialInclude? material,
  }) {
    _module = module;
    _material = material;
  }

  _i2.ModuleInclude? _module;

  _i3.MaterialInclude? _material;

  @override
  Map<String, _i1.Include?> get includes => {
    'module': _module,
    'material': _material,
  };

  @override
  _i1.Table<int?> get table => Lesson.t;
}

class LessonIncludeList extends _i1.IncludeList {
  LessonIncludeList._({
    _i1.WhereExpressionBuilder<LessonTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Lesson.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Lesson.t;
}

class LessonRepository {
  const LessonRepository._();

  final attachRow = const LessonAttachRowRepository._();

  /// Returns a list of [Lesson]s matching the given query parameters.
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
  Future<List<Lesson>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    _i1.Transaction? transaction,
    LessonInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Lesson>(
      where: where?.call(Lesson.t),
      orderBy: orderBy?.call(Lesson.t),
      orderByList: orderByList?.call(Lesson.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Lesson] matching the given query parameters.
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
  Future<Lesson?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    _i1.Transaction? transaction,
    LessonInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Lesson>(
      where: where?.call(Lesson.t),
      orderBy: orderBy?.call(Lesson.t),
      orderByList: orderByList?.call(Lesson.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Lesson] by its [id] or null if no such row exists.
  Future<Lesson?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LessonInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Lesson>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Lesson]s in the list and returns the inserted rows.
  ///
  /// The returned [Lesson]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Lesson>> insert(
    _i1.Session session,
    List<Lesson> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Lesson>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Lesson] and returns the inserted row.
  ///
  /// The returned [Lesson] will have its `id` field set.
  Future<Lesson> insertRow(
    _i1.Session session,
    Lesson row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Lesson>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Lesson]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Lesson>> update(
    _i1.Session session,
    List<Lesson> rows, {
    _i1.ColumnSelections<LessonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Lesson>(
      rows,
      columns: columns?.call(Lesson.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Lesson]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Lesson> updateRow(
    _i1.Session session,
    Lesson row, {
    _i1.ColumnSelections<LessonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Lesson>(
      row,
      columns: columns?.call(Lesson.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Lesson] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Lesson?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<LessonUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Lesson>(
      id,
      columnValues: columnValues(Lesson.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Lesson]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Lesson>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<LessonUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LessonTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonTable>? orderBy,
    _i1.OrderByListBuilder<LessonTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Lesson>(
      columnValues: columnValues(Lesson.t.updateTable),
      where: where(Lesson.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Lesson.t),
      orderByList: orderByList?.call(Lesson.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Lesson]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Lesson>> delete(
    _i1.Session session,
    List<Lesson> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Lesson>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Lesson].
  Future<Lesson> deleteRow(
    _i1.Session session,
    Lesson row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Lesson>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Lesson>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Lesson>(
      where: where(Lesson.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LessonTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Lesson>(
      where: where?.call(Lesson.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Lesson] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LessonTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Lesson>(
      where: where(Lesson.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LessonAttachRowRepository {
  const LessonAttachRowRepository._();

  /// Creates a relation between the given [Lesson] and [Module]
  /// by setting the [Lesson]'s foreign key `moduleId` to refer to the [Module].
  Future<void> module(
    _i1.Session session,
    Lesson lesson,
    _i2.Module module, {
    _i1.Transaction? transaction,
  }) async {
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }
    if (module.id == null) {
      throw ArgumentError.notNull('module.id');
    }

    var $lesson = lesson.copyWith(moduleId: module.id);
    await session.db.updateRow<Lesson>(
      $lesson,
      columns: [Lesson.t.moduleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Lesson] and [Material]
  /// by setting the [Lesson]'s foreign key `materialId` to refer to the [Material].
  Future<void> material(
    _i1.Session session,
    Lesson lesson,
    _i3.Material material, {
    _i1.Transaction? transaction,
  }) async {
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }
    if (material.id == null) {
      throw ArgumentError.notNull('material.id');
    }

    var $lesson = lesson.copyWith(materialId: material.id);
    await session.db.updateRow<Lesson>(
      $lesson,
      columns: [Lesson.t.materialId],
      transaction: transaction,
    );
  }
}
