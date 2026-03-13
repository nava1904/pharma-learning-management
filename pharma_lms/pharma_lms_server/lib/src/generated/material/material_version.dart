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
import '../material/material.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Versioned material for document control.
abstract class MaterialVersion
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MaterialVersion._({
    this.id,
    required this.materialId,
    this.material,
    required this.version,
    required this.storageKey,
    DateTime? createdAt,
    this.fileHash,
    String? virusScanStatus,
    this.virusScanAt,
    this.fileSizeBytes,
  }) : createdAt = createdAt ?? DateTime.now(),
       virusScanStatus = virusScanStatus ?? 'pending';

  factory MaterialVersion({
    int? id,
    required int materialId,
    _i2.Material? material,
    required int version,
    required String storageKey,
    DateTime? createdAt,
    String? fileHash,
    String? virusScanStatus,
    DateTime? virusScanAt,
    int? fileSizeBytes,
  }) = _MaterialVersionImpl;

  factory MaterialVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialVersion(
      id: jsonSerialization['id'] as int?,
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Material>(
              jsonSerialization['material'],
            ),
      version: jsonSerialization['version'] as int,
      storageKey: jsonSerialization['storageKey'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      fileHash: jsonSerialization['fileHash'] as String?,
      virusScanStatus: jsonSerialization['virusScanStatus'] as String?,
      virusScanAt: jsonSerialization['virusScanAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['virusScanAt'],
            ),
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int?,
    );
  }

  static final t = MaterialVersionTable();

  static const db = MaterialVersionRepository._();

  @override
  int? id;

  int materialId;

  /// The material.
  _i2.Material? material;

  /// Version number.
  int version;

  /// Storage key for this version.
  String storageKey;

  /// When created.
  DateTime createdAt;

  /// SHA-256 file hash for integrity verification (TRN-WF-02).
  String? fileHash;

  /// Virus scan status: pending, clean, quarantined (TRN-WF-02).
  String? virusScanStatus;

  /// When virus scan completed.
  DateTime? virusScanAt;

  /// File size in bytes.
  int? fileSizeBytes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MaterialVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialVersion copyWith({
    int? id,
    int? materialId,
    _i2.Material? material,
    int? version,
    String? storageKey,
    DateTime? createdAt,
    String? fileHash,
    String? virusScanStatus,
    DateTime? virusScanAt,
    int? fileSizeBytes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialVersion',
      if (id != null) 'id': id,
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      'version': version,
      'storageKey': storageKey,
      'createdAt': createdAt.toJson(),
      if (fileHash != null) 'fileHash': fileHash,
      if (virusScanStatus != null) 'virusScanStatus': virusScanStatus,
      if (virusScanAt != null) 'virusScanAt': virusScanAt?.toJson(),
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaterialVersion',
      if (id != null) 'id': id,
      'materialId': materialId,
      if (material != null) 'material': material?.toJsonForProtocol(),
      'version': version,
      'storageKey': storageKey,
      'createdAt': createdAt.toJson(),
      if (fileHash != null) 'fileHash': fileHash,
      if (virusScanStatus != null) 'virusScanStatus': virusScanStatus,
      if (virusScanAt != null) 'virusScanAt': virusScanAt?.toJson(),
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
    };
  }

  static MaterialVersionInclude include({_i2.MaterialInclude? material}) {
    return MaterialVersionInclude._(material: material);
  }

  static MaterialVersionIncludeList includeList({
    _i1.WhereExpressionBuilder<MaterialVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialVersionTable>? orderByList,
    MaterialVersionInclude? include,
  }) {
    return MaterialVersionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialVersion.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MaterialVersion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialVersionImpl extends MaterialVersion {
  _MaterialVersionImpl({
    int? id,
    required int materialId,
    _i2.Material? material,
    required int version,
    required String storageKey,
    DateTime? createdAt,
    String? fileHash,
    String? virusScanStatus,
    DateTime? virusScanAt,
    int? fileSizeBytes,
  }) : super._(
         id: id,
         materialId: materialId,
         material: material,
         version: version,
         storageKey: storageKey,
         createdAt: createdAt,
         fileHash: fileHash,
         virusScanStatus: virusScanStatus,
         virusScanAt: virusScanAt,
         fileSizeBytes: fileSizeBytes,
       );

  /// Returns a shallow copy of this [MaterialVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialVersion copyWith({
    Object? id = _Undefined,
    int? materialId,
    Object? material = _Undefined,
    int? version,
    String? storageKey,
    DateTime? createdAt,
    Object? fileHash = _Undefined,
    Object? virusScanStatus = _Undefined,
    Object? virusScanAt = _Undefined,
    Object? fileSizeBytes = _Undefined,
  }) {
    return MaterialVersion(
      id: id is int? ? id : this.id,
      materialId: materialId ?? this.materialId,
      material: material is _i2.Material?
          ? material
          : this.material?.copyWith(),
      version: version ?? this.version,
      storageKey: storageKey ?? this.storageKey,
      createdAt: createdAt ?? this.createdAt,
      fileHash: fileHash is String? ? fileHash : this.fileHash,
      virusScanStatus: virusScanStatus is String?
          ? virusScanStatus
          : this.virusScanStatus,
      virusScanAt: virusScanAt is DateTime? ? virusScanAt : this.virusScanAt,
      fileSizeBytes: fileSizeBytes is int? ? fileSizeBytes : this.fileSizeBytes,
    );
  }
}

class MaterialVersionUpdateTable extends _i1.UpdateTable<MaterialVersionTable> {
  MaterialVersionUpdateTable(super.table);

  _i1.ColumnValue<int, int> materialId(int value) => _i1.ColumnValue(
    table.materialId,
    value,
  );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<String, String> storageKey(String value) => _i1.ColumnValue(
    table.storageKey,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> fileHash(String? value) => _i1.ColumnValue(
    table.fileHash,
    value,
  );

  _i1.ColumnValue<String, String> virusScanStatus(String? value) =>
      _i1.ColumnValue(
        table.virusScanStatus,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> virusScanAt(DateTime? value) =>
      _i1.ColumnValue(
        table.virusScanAt,
        value,
      );

  _i1.ColumnValue<int, int> fileSizeBytes(int? value) => _i1.ColumnValue(
    table.fileSizeBytes,
    value,
  );
}

class MaterialVersionTable extends _i1.Table<int?> {
  MaterialVersionTable({super.tableRelation})
    : super(tableName: 'material_version') {
    updateTable = MaterialVersionUpdateTable(this);
    materialId = _i1.ColumnInt(
      'materialId',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    storageKey = _i1.ColumnString(
      'storageKey',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    fileHash = _i1.ColumnString(
      'fileHash',
      this,
    );
    virusScanStatus = _i1.ColumnString(
      'virusScanStatus',
      this,
      hasDefault: true,
    );
    virusScanAt = _i1.ColumnDateTime(
      'virusScanAt',
      this,
    );
    fileSizeBytes = _i1.ColumnInt(
      'fileSizeBytes',
      this,
    );
  }

  late final MaterialVersionUpdateTable updateTable;

  late final _i1.ColumnInt materialId;

  /// The material.
  _i2.MaterialTable? _material;

  /// Version number.
  late final _i1.ColumnInt version;

  /// Storage key for this version.
  late final _i1.ColumnString storageKey;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  /// SHA-256 file hash for integrity verification (TRN-WF-02).
  late final _i1.ColumnString fileHash;

  /// Virus scan status: pending, clean, quarantined (TRN-WF-02).
  late final _i1.ColumnString virusScanStatus;

  /// When virus scan completed.
  late final _i1.ColumnDateTime virusScanAt;

  /// File size in bytes.
  late final _i1.ColumnInt fileSizeBytes;

  _i2.MaterialTable get material {
    if (_material != null) return _material!;
    _material = _i1.createRelationTable(
      relationFieldName: 'material',
      field: MaterialVersion.t.materialId,
      foreignField: _i2.Material.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.MaterialTable(tableRelation: foreignTableRelation),
    );
    return _material!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    materialId,
    version,
    storageKey,
    createdAt,
    fileHash,
    virusScanStatus,
    virusScanAt,
    fileSizeBytes,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'material') {
      return material;
    }
    return null;
  }
}

class MaterialVersionInclude extends _i1.IncludeObject {
  MaterialVersionInclude._({_i2.MaterialInclude? material}) {
    _material = material;
  }

  _i2.MaterialInclude? _material;

  @override
  Map<String, _i1.Include?> get includes => {'material': _material};

  @override
  _i1.Table<int?> get table => MaterialVersion.t;
}

class MaterialVersionIncludeList extends _i1.IncludeList {
  MaterialVersionIncludeList._({
    _i1.WhereExpressionBuilder<MaterialVersionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MaterialVersion.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MaterialVersion.t;
}

class MaterialVersionRepository {
  const MaterialVersionRepository._();

  final attachRow = const MaterialVersionAttachRowRepository._();

  /// Returns a list of [MaterialVersion]s matching the given query parameters.
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
  Future<List<MaterialVersion>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialVersionTable>? orderByList,
    _i1.Transaction? transaction,
    MaterialVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MaterialVersion>(
      where: where?.call(MaterialVersion.t),
      orderBy: orderBy?.call(MaterialVersion.t),
      orderByList: orderByList?.call(MaterialVersion.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MaterialVersion] matching the given query parameters.
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
  Future<MaterialVersion?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialVersionTable>? where,
    int? offset,
    _i1.OrderByBuilder<MaterialVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialVersionTable>? orderByList,
    _i1.Transaction? transaction,
    MaterialVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MaterialVersion>(
      where: where?.call(MaterialVersion.t),
      orderBy: orderBy?.call(MaterialVersion.t),
      orderByList: orderByList?.call(MaterialVersion.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MaterialVersion] by its [id] or null if no such row exists.
  Future<MaterialVersion?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MaterialVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MaterialVersion>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MaterialVersion]s in the list and returns the inserted rows.
  ///
  /// The returned [MaterialVersion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MaterialVersion>> insert(
    _i1.Session session,
    List<MaterialVersion> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MaterialVersion>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MaterialVersion] and returns the inserted row.
  ///
  /// The returned [MaterialVersion] will have its `id` field set.
  Future<MaterialVersion> insertRow(
    _i1.Session session,
    MaterialVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MaterialVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MaterialVersion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MaterialVersion>> update(
    _i1.Session session,
    List<MaterialVersion> rows, {
    _i1.ColumnSelections<MaterialVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MaterialVersion>(
      rows,
      columns: columns?.call(MaterialVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialVersion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MaterialVersion> updateRow(
    _i1.Session session,
    MaterialVersion row, {
    _i1.ColumnSelections<MaterialVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MaterialVersion>(
      row,
      columns: columns?.call(MaterialVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialVersion] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MaterialVersion?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MaterialVersionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MaterialVersion>(
      id,
      columnValues: columnValues(MaterialVersion.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MaterialVersion]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MaterialVersion>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MaterialVersionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<MaterialVersionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialVersionTable>? orderBy,
    _i1.OrderByListBuilder<MaterialVersionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MaterialVersion>(
      columnValues: columnValues(MaterialVersion.t.updateTable),
      where: where(MaterialVersion.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialVersion.t),
      orderByList: orderByList?.call(MaterialVersion.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MaterialVersion]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MaterialVersion>> delete(
    _i1.Session session,
    List<MaterialVersion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MaterialVersion>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MaterialVersion].
  Future<MaterialVersion> deleteRow(
    _i1.Session session,
    MaterialVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MaterialVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MaterialVersion>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MaterialVersionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MaterialVersion>(
      where: where(MaterialVersion.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialVersionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MaterialVersion>(
      where: where?.call(MaterialVersion.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MaterialVersion] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MaterialVersionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MaterialVersion>(
      where: where(MaterialVersion.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MaterialVersionAttachRowRepository {
  const MaterialVersionAttachRowRepository._();

  /// Creates a relation between the given [MaterialVersion] and [Material]
  /// by setting the [MaterialVersion]'s foreign key `materialId` to refer to the [Material].
  Future<void> material(
    _i1.Session session,
    MaterialVersion materialVersion,
    _i2.Material material, {
    _i1.Transaction? transaction,
  }) async {
    if (materialVersion.id == null) {
      throw ArgumentError.notNull('materialVersion.id');
    }
    if (material.id == null) {
      throw ArgumentError.notNull('material.id');
    }

    var $materialVersion = materialVersion.copyWith(materialId: material.id);
    await session.db.updateRow<MaterialVersion>(
      $materialVersion,
      columns: [MaterialVersion.t.materialId],
      transaction: transaction,
    );
  }
}
