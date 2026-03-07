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

/// Media asset (video, image) linked to material.
abstract class MediaAsset
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MediaAsset._({
    this.id,
    required this.materialId,
    this.material,
    required this.assetType,
    required this.url,
    this.durationSeconds,
  });

  factory MediaAsset({
    int? id,
    required int materialId,
    _i2.Material? material,
    required String assetType,
    required String url,
    int? durationSeconds,
  }) = _MediaAssetImpl;

  factory MediaAsset.fromJson(Map<String, dynamic> jsonSerialization) {
    return MediaAsset(
      id: jsonSerialization['id'] as int?,
      materialId: jsonSerialization['materialId'] as int,
      material: jsonSerialization['material'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Material>(
              jsonSerialization['material'],
            ),
      assetType: jsonSerialization['assetType'] as String,
      url: jsonSerialization['url'] as String,
      durationSeconds: jsonSerialization['durationSeconds'] as int?,
    );
  }

  static final t = MediaAssetTable();

  static const db = MediaAssetRepository._();

  @override
  int? id;

  int materialId;

  /// The material.
  _i2.Material? material;

  /// Type (video, image).
  String assetType;

  /// URL or storage path.
  String url;

  /// Duration in seconds for video.
  int? durationSeconds;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MediaAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MediaAsset copyWith({
    int? id,
    int? materialId,
    _i2.Material? material,
    String? assetType,
    String? url,
    int? durationSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MediaAsset',
      if (id != null) 'id': id,
      'materialId': materialId,
      if (material != null) 'material': material?.toJson(),
      'assetType': assetType,
      'url': url,
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MediaAsset',
      if (id != null) 'id': id,
      'materialId': materialId,
      if (material != null) 'material': material?.toJsonForProtocol(),
      'assetType': assetType,
      'url': url,
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
    };
  }

  static MediaAssetInclude include({_i2.MaterialInclude? material}) {
    return MediaAssetInclude._(material: material);
  }

  static MediaAssetIncludeList includeList({
    _i1.WhereExpressionBuilder<MediaAssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaAssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaAssetTable>? orderByList,
    MediaAssetInclude? include,
  }) {
    return MediaAssetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MediaAsset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MediaAsset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MediaAssetImpl extends MediaAsset {
  _MediaAssetImpl({
    int? id,
    required int materialId,
    _i2.Material? material,
    required String assetType,
    required String url,
    int? durationSeconds,
  }) : super._(
         id: id,
         materialId: materialId,
         material: material,
         assetType: assetType,
         url: url,
         durationSeconds: durationSeconds,
       );

  /// Returns a shallow copy of this [MediaAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MediaAsset copyWith({
    Object? id = _Undefined,
    int? materialId,
    Object? material = _Undefined,
    String? assetType,
    String? url,
    Object? durationSeconds = _Undefined,
  }) {
    return MediaAsset(
      id: id is int? ? id : this.id,
      materialId: materialId ?? this.materialId,
      material: material is _i2.Material?
          ? material
          : this.material?.copyWith(),
      assetType: assetType ?? this.assetType,
      url: url ?? this.url,
      durationSeconds: durationSeconds is int?
          ? durationSeconds
          : this.durationSeconds,
    );
  }
}

class MediaAssetUpdateTable extends _i1.UpdateTable<MediaAssetTable> {
  MediaAssetUpdateTable(super.table);

  _i1.ColumnValue<int, int> materialId(int value) => _i1.ColumnValue(
    table.materialId,
    value,
  );

  _i1.ColumnValue<String, String> assetType(String value) => _i1.ColumnValue(
    table.assetType,
    value,
  );

  _i1.ColumnValue<String, String> url(String value) => _i1.ColumnValue(
    table.url,
    value,
  );

  _i1.ColumnValue<int, int> durationSeconds(int? value) => _i1.ColumnValue(
    table.durationSeconds,
    value,
  );
}

class MediaAssetTable extends _i1.Table<int?> {
  MediaAssetTable({super.tableRelation}) : super(tableName: 'media_asset') {
    updateTable = MediaAssetUpdateTable(this);
    materialId = _i1.ColumnInt(
      'materialId',
      this,
    );
    assetType = _i1.ColumnString(
      'assetType',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    durationSeconds = _i1.ColumnInt(
      'durationSeconds',
      this,
    );
  }

  late final MediaAssetUpdateTable updateTable;

  late final _i1.ColumnInt materialId;

  /// The material.
  _i2.MaterialTable? _material;

  /// Type (video, image).
  late final _i1.ColumnString assetType;

  /// URL or storage path.
  late final _i1.ColumnString url;

  /// Duration in seconds for video.
  late final _i1.ColumnInt durationSeconds;

  _i2.MaterialTable get material {
    if (_material != null) return _material!;
    _material = _i1.createRelationTable(
      relationFieldName: 'material',
      field: MediaAsset.t.materialId,
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
    assetType,
    url,
    durationSeconds,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'material') {
      return material;
    }
    return null;
  }
}

class MediaAssetInclude extends _i1.IncludeObject {
  MediaAssetInclude._({_i2.MaterialInclude? material}) {
    _material = material;
  }

  _i2.MaterialInclude? _material;

  @override
  Map<String, _i1.Include?> get includes => {'material': _material};

  @override
  _i1.Table<int?> get table => MediaAsset.t;
}

class MediaAssetIncludeList extends _i1.IncludeList {
  MediaAssetIncludeList._({
    _i1.WhereExpressionBuilder<MediaAssetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MediaAsset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MediaAsset.t;
}

class MediaAssetRepository {
  const MediaAssetRepository._();

  final attachRow = const MediaAssetAttachRowRepository._();

  /// Returns a list of [MediaAsset]s matching the given query parameters.
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
  Future<List<MediaAsset>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaAssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaAssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaAssetTable>? orderByList,
    _i1.Transaction? transaction,
    MediaAssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MediaAsset>(
      where: where?.call(MediaAsset.t),
      orderBy: orderBy?.call(MediaAsset.t),
      orderByList: orderByList?.call(MediaAsset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MediaAsset] matching the given query parameters.
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
  Future<MediaAsset?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaAssetTable>? where,
    int? offset,
    _i1.OrderByBuilder<MediaAssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaAssetTable>? orderByList,
    _i1.Transaction? transaction,
    MediaAssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MediaAsset>(
      where: where?.call(MediaAsset.t),
      orderBy: orderBy?.call(MediaAsset.t),
      orderByList: orderByList?.call(MediaAsset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MediaAsset] by its [id] or null if no such row exists.
  Future<MediaAsset?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MediaAssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MediaAsset>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MediaAsset]s in the list and returns the inserted rows.
  ///
  /// The returned [MediaAsset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MediaAsset>> insert(
    _i1.Session session,
    List<MediaAsset> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MediaAsset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MediaAsset] and returns the inserted row.
  ///
  /// The returned [MediaAsset] will have its `id` field set.
  Future<MediaAsset> insertRow(
    _i1.Session session,
    MediaAsset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MediaAsset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MediaAsset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MediaAsset>> update(
    _i1.Session session,
    List<MediaAsset> rows, {
    _i1.ColumnSelections<MediaAssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MediaAsset>(
      rows,
      columns: columns?.call(MediaAsset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MediaAsset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MediaAsset> updateRow(
    _i1.Session session,
    MediaAsset row, {
    _i1.ColumnSelections<MediaAssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MediaAsset>(
      row,
      columns: columns?.call(MediaAsset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MediaAsset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MediaAsset?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MediaAssetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MediaAsset>(
      id,
      columnValues: columnValues(MediaAsset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MediaAsset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MediaAsset>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MediaAssetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MediaAssetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaAssetTable>? orderBy,
    _i1.OrderByListBuilder<MediaAssetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MediaAsset>(
      columnValues: columnValues(MediaAsset.t.updateTable),
      where: where(MediaAsset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MediaAsset.t),
      orderByList: orderByList?.call(MediaAsset.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MediaAsset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MediaAsset>> delete(
    _i1.Session session,
    List<MediaAsset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MediaAsset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MediaAsset].
  Future<MediaAsset> deleteRow(
    _i1.Session session,
    MediaAsset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MediaAsset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MediaAsset>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MediaAssetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MediaAsset>(
      where: where(MediaAsset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaAssetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MediaAsset>(
      where: where?.call(MediaAsset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MediaAsset] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MediaAssetTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MediaAsset>(
      where: where(MediaAsset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MediaAssetAttachRowRepository {
  const MediaAssetAttachRowRepository._();

  /// Creates a relation between the given [MediaAsset] and [Material]
  /// by setting the [MediaAsset]'s foreign key `materialId` to refer to the [Material].
  Future<void> material(
    _i1.Session session,
    MediaAsset mediaAsset,
    _i2.Material material, {
    _i1.Transaction? transaction,
  }) async {
    if (mediaAsset.id == null) {
      throw ArgumentError.notNull('mediaAsset.id');
    }
    if (material.id == null) {
      throw ArgumentError.notNull('material.id');
    }

    var $mediaAsset = mediaAsset.copyWith(materialId: material.id);
    await session.db.updateRow<MediaAsset>(
      $mediaAsset,
      columns: [MediaAsset.t.materialId],
      transaction: transaction,
    );
  }
}
