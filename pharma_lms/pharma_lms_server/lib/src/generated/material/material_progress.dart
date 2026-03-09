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
import '../material/material.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// User progress on material (video watch, scroll depth).
abstract class MaterialProgress
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MaterialProgress._({
    this.id,
    required this.userId,
    this.user,
    required this.materialId,
    this.material,
    int? progressPct,
    this.completedAt,
    this.interactionJson,
    this.materialVersionId,
    this.enrollmentId,
    this.timeSpentSeconds,
    this.readTimeMet,
  }) : progressPct = progressPct ?? 0;

  factory MaterialProgress({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int materialId,
    _i3.Material? material,
    int? progressPct,
    DateTime? completedAt,
    String? interactionJson,
    int? materialVersionId,
    int? enrollmentId,
    int? timeSpentSeconds,
    bool? readTimeMet,
  }) = _MaterialProgressImpl;

  factory MaterialProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialProgress(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Material>(
              jsonSerialization['material'],
            ),
      progressPct: jsonSerialization['progressPct'] as int?,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      interactionJson: jsonSerialization['interactionJson'] as String?,
      materialVersionId: jsonSerialization['materialVersionId'] as int?,
      enrollmentId: jsonSerialization['enrollmentId'] as int?,
      timeSpentSeconds: jsonSerialization['timeSpentSeconds'] as int?,
      readTimeMet: jsonSerialization['readTimeMet'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['readTimeMet']),
    );
  }

  static final t = MaterialProgressTable();

  static const db = MaterialProgressRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int materialId;

  /// The material.
  _i3.Material? material;

  /// Progress percentage 0-100.
  int progressPct;

  /// When completed (null if in progress).
  DateTime? completedAt;

  /// Interaction data as JSON (watch/pause, scroll depth).
  String? interactionJson;

  /// Material version for retraining tracking.
  int? materialVersionId;

  /// Enrollment this progress belongs to.
  int? enrollmentId;

  /// Active engagement time in seconds.
  int? timeSpentSeconds;

  /// Whether minimum read time was met.
  bool? readTimeMet;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MaterialProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialProgress copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? materialId,
    _i3.Material? material,
    int? progressPct,
    DateTime? completedAt,
    String? interactionJson,
    int? materialVersionId,
    int? enrollmentId,
    int? timeSpentSeconds,
    bool? readTimeMet,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialProgress',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      'progressPct': progressPct,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (interactionJson != null) 'interactionJson': interactionJson,
      if (materialVersionId != null) 'materialVersionId': materialVersionId,
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (timeSpentSeconds != null) 'timeSpentSeconds': timeSpentSeconds,
      if (readTimeMet != null) 'readTimeMet': readTimeMet,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaterialProgress',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'materialId': materialId,
      if (material != null) 'material': material?.toJsonForProtocol(),
      'progressPct': progressPct,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (interactionJson != null) 'interactionJson': interactionJson,
      if (materialVersionId != null) 'materialVersionId': materialVersionId,
      if (enrollmentId != null) 'enrollmentId': enrollmentId,
      if (timeSpentSeconds != null) 'timeSpentSeconds': timeSpentSeconds,
      if (readTimeMet != null) 'readTimeMet': readTimeMet,
    };
  }

  static MaterialProgressInclude include({
    _i2.PharmaUserInclude? user,
    _i3.MaterialInclude? material,
  }) {
    return MaterialProgressInclude._(
      user: user,
      material: material,
    );
  }

  static MaterialProgressIncludeList includeList({
    _i1.WhereExpressionBuilder<MaterialProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialProgressTable>? orderByList,
    MaterialProgressInclude? include,
  }) {
    return MaterialProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialProgress.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MaterialProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialProgressImpl extends MaterialProgress {
  _MaterialProgressImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int materialId,
    _i3.Material? material,
    int? progressPct,
    DateTime? completedAt,
    String? interactionJson,
    int? materialVersionId,
    int? enrollmentId,
    int? timeSpentSeconds,
    bool? readTimeMet,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         materialId: materialId,
         material: material,
         progressPct: progressPct,
         completedAt: completedAt,
         interactionJson: interactionJson,
         materialVersionId: materialVersionId,
         enrollmentId: enrollmentId,
         timeSpentSeconds: timeSpentSeconds,
         readTimeMet: readTimeMet,
       );

  /// Returns a shallow copy of this [MaterialProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialProgress copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? materialId,
    Object? material = _Undefined,
    int? progressPct,
    Object? completedAt = _Undefined,
    Object? interactionJson = _Undefined,
    Object? materialVersionId = _Undefined,
    Object? enrollmentId = _Undefined,
    Object? timeSpentSeconds = _Undefined,
    Object? readTimeMet = _Undefined,
  }) {
    return MaterialProgress(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      materialId: materialId ?? this.materialId,
      material: material is _i3.Material?
          ? material
          : this.material?.copyWith(),
      progressPct: progressPct ?? this.progressPct,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      interactionJson: interactionJson is String?
          ? interactionJson
          : this.interactionJson,
      materialVersionId: materialVersionId is int?
          ? materialVersionId
          : this.materialVersionId,
      enrollmentId: enrollmentId is int? ? enrollmentId : this.enrollmentId,
      timeSpentSeconds: timeSpentSeconds is int?
          ? timeSpentSeconds
          : this.timeSpentSeconds,
      readTimeMet: readTimeMet is bool? ? readTimeMet : this.readTimeMet,
    );
  }
}

class MaterialProgressUpdateTable
    extends _i1.UpdateTable<MaterialProgressTable> {
  MaterialProgressUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> materialId(int value) => _i1.ColumnValue(
    table.materialId,
    value,
  );

  _i1.ColumnValue<int, int> progressPct(int value) => _i1.ColumnValue(
    table.progressPct,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<String, String> interactionJson(String? value) =>
      _i1.ColumnValue(
        table.interactionJson,
        value,
      );

  _i1.ColumnValue<int, int> materialVersionId(int? value) => _i1.ColumnValue(
    table.materialVersionId,
    value,
  );

  _i1.ColumnValue<int, int> enrollmentId(int? value) => _i1.ColumnValue(
    table.enrollmentId,
    value,
  );

  _i1.ColumnValue<int, int> timeSpentSeconds(int? value) => _i1.ColumnValue(
    table.timeSpentSeconds,
    value,
  );

  _i1.ColumnValue<bool, bool> readTimeMet(bool? value) => _i1.ColumnValue(
    table.readTimeMet,
    value,
  );
}

class MaterialProgressTable extends _i1.Table<int?> {
  MaterialProgressTable({super.tableRelation})
    : super(tableName: 'material_progress') {
    updateTable = MaterialProgressUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    materialId = _i1.ColumnInt(
      'materialId',
      this,
    );
    progressPct = _i1.ColumnInt(
      'progressPct',
      this,
      hasDefault: true,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    interactionJson = _i1.ColumnString(
      'interactionJson',
      this,
    );
    materialVersionId = _i1.ColumnInt(
      'materialVersionId',
      this,
    );
    enrollmentId = _i1.ColumnInt(
      'enrollmentId',
      this,
    );
    timeSpentSeconds = _i1.ColumnInt(
      'timeSpentSeconds',
      this,
    );
    readTimeMet = _i1.ColumnBool(
      'readTimeMet',
      this,
    );
  }

  late final MaterialProgressUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt materialId;

  /// The material.
  _i3.MaterialTable? _material;

  /// Progress percentage 0-100.
  late final _i1.ColumnInt progressPct;

  /// When completed (null if in progress).
  late final _i1.ColumnDateTime completedAt;

  /// Interaction data as JSON (watch/pause, scroll depth).
  late final _i1.ColumnString interactionJson;

  /// Material version for retraining tracking.
  late final _i1.ColumnInt materialVersionId;

  /// Enrollment this progress belongs to.
  late final _i1.ColumnInt enrollmentId;

  /// Active engagement time in seconds.
  late final _i1.ColumnInt timeSpentSeconds;

  /// Whether minimum read time was met.
  late final _i1.ColumnBool readTimeMet;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: MaterialProgress.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.MaterialTable get material {
    if (_material != null) return _material!;
    _material = _i1.createRelationTable(
      relationFieldName: 'material',
      field: MaterialProgress.t.materialId,
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
    userId,
    materialId,
    progressPct,
    completedAt,
    interactionJson,
    materialVersionId,
    enrollmentId,
    timeSpentSeconds,
    readTimeMet,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'material') {
      return material;
    }
    return null;
  }
}

class MaterialProgressInclude extends _i1.IncludeObject {
  MaterialProgressInclude._({
    _i2.PharmaUserInclude? user,
    _i3.MaterialInclude? material,
  }) {
    _user = user;
    _material = material;
  }

  _i2.PharmaUserInclude? _user;

  _i3.MaterialInclude? _material;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'material': _material,
  };

  @override
  _i1.Table<int?> get table => MaterialProgress.t;
}

class MaterialProgressIncludeList extends _i1.IncludeList {
  MaterialProgressIncludeList._({
    _i1.WhereExpressionBuilder<MaterialProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MaterialProgress.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MaterialProgress.t;
}

class MaterialProgressRepository {
  const MaterialProgressRepository._();

  final attachRow = const MaterialProgressAttachRowRepository._();

  /// Returns a list of [MaterialProgress]s matching the given query parameters.
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
  Future<List<MaterialProgress>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialProgressTable>? orderByList,
    _i1.Transaction? transaction,
    MaterialProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MaterialProgress>(
      where: where?.call(MaterialProgress.t),
      orderBy: orderBy?.call(MaterialProgress.t),
      orderByList: orderByList?.call(MaterialProgress.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MaterialProgress] matching the given query parameters.
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
  Future<MaterialProgress?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialProgressTable>? where,
    int? offset,
    _i1.OrderByBuilder<MaterialProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialProgressTable>? orderByList,
    _i1.Transaction? transaction,
    MaterialProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MaterialProgress>(
      where: where?.call(MaterialProgress.t),
      orderBy: orderBy?.call(MaterialProgress.t),
      orderByList: orderByList?.call(MaterialProgress.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MaterialProgress] by its [id] or null if no such row exists.
  Future<MaterialProgress?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MaterialProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MaterialProgress>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MaterialProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [MaterialProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MaterialProgress>> insert(
    _i1.Session session,
    List<MaterialProgress> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MaterialProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MaterialProgress] and returns the inserted row.
  ///
  /// The returned [MaterialProgress] will have its `id` field set.
  Future<MaterialProgress> insertRow(
    _i1.Session session,
    MaterialProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MaterialProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MaterialProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MaterialProgress>> update(
    _i1.Session session,
    List<MaterialProgress> rows, {
    _i1.ColumnSelections<MaterialProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MaterialProgress>(
      rows,
      columns: columns?.call(MaterialProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MaterialProgress> updateRow(
    _i1.Session session,
    MaterialProgress row, {
    _i1.ColumnSelections<MaterialProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MaterialProgress>(
      row,
      columns: columns?.call(MaterialProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MaterialProgress?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MaterialProgressUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MaterialProgress>(
      id,
      columnValues: columnValues(MaterialProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MaterialProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MaterialProgress>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MaterialProgressUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<MaterialProgressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialProgressTable>? orderBy,
    _i1.OrderByListBuilder<MaterialProgressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MaterialProgress>(
      columnValues: columnValues(MaterialProgress.t.updateTable),
      where: where(MaterialProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialProgress.t),
      orderByList: orderByList?.call(MaterialProgress.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MaterialProgress]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MaterialProgress>> delete(
    _i1.Session session,
    List<MaterialProgress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MaterialProgress>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MaterialProgress].
  Future<MaterialProgress> deleteRow(
    _i1.Session session,
    MaterialProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MaterialProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MaterialProgress>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MaterialProgressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MaterialProgress>(
      where: where(MaterialProgress.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialProgressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MaterialProgress>(
      where: where?.call(MaterialProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MaterialProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MaterialProgressTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MaterialProgress>(
      where: where(MaterialProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MaterialProgressAttachRowRepository {
  const MaterialProgressAttachRowRepository._();

  /// Creates a relation between the given [MaterialProgress] and [PharmaUser]
  /// by setting the [MaterialProgress]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    MaterialProgress materialProgress,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (materialProgress.id == null) {
      throw ArgumentError.notNull('materialProgress.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $materialProgress = materialProgress.copyWith(userId: user.id);
    await session.db.updateRow<MaterialProgress>(
      $materialProgress,
      columns: [MaterialProgress.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MaterialProgress] and [Material]
  /// by setting the [MaterialProgress]'s foreign key `materialId` to refer to the [Material].
  Future<void> material(
    _i1.Session session,
    MaterialProgress materialProgress,
    _i3.Material material, {
    _i1.Transaction? transaction,
  }) async {
    if (materialProgress.id == null) {
      throw ArgumentError.notNull('materialProgress.id');
    }
    if (material.id == null) {
      throw ArgumentError.notNull('material.id');
    }

    var $materialProgress = materialProgress.copyWith(materialId: material.id);
    await session.db.updateRow<MaterialProgress>(
      $materialProgress,
      columns: [MaterialProgress.t.materialId],
      transaction: transaction,
    );
  }
}
