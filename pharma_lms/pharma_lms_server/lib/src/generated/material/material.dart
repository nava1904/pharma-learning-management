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
import '../organization/organization.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Learning material (PDF, video, SCORM).
abstract class Material
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Material._({
    this.id,
    required this.title,
    required this.materialType,
    this.storageKey,
    required this.organizationId,
    this.organization,
  });

  factory Material({
    int? id,
    required String title,
    required String materialType,
    String? storageKey,
    required int organizationId,
    _i2.Organization? organization,
  }) = _MaterialImpl;

  factory Material.fromJson(Map<String, dynamic> jsonSerialization) {
    return Material(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      materialType: jsonSerialization['materialType'] as String,
      storageKey: jsonSerialization['storageKey'] as String?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
    );
  }

  static final t = MaterialTable();

  static const db = MaterialRepository._();

  @override
  int? id;

  /// Material title.
  String title;

  /// Type: pdf, video, scorm.
  String materialType;

  /// S3/MinIO storage key.
  String? storageKey;

  int organizationId;

  /// Organization for multi-tenant.
  _i2.Organization? organization;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Material]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Material copyWith({
    int? id,
    String? title,
    String? materialType,
    String? storageKey,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Material',
      if (id != null) 'id': id,
      'title': title,
      'materialType': materialType,
      if (storageKey != null) 'storageKey': storageKey,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Material',
      if (id != null) 'id': id,
      'title': title,
      'materialType': materialType,
      if (storageKey != null) 'storageKey': storageKey,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
    };
  }

  static MaterialInclude include({_i2.OrganizationInclude? organization}) {
    return MaterialInclude._(organization: organization);
  }

  static MaterialIncludeList includeList({
    _i1.WhereExpressionBuilder<MaterialTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialTable>? orderByList,
    MaterialInclude? include,
  }) {
    return MaterialIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Material.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Material.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialImpl extends Material {
  _MaterialImpl({
    int? id,
    required String title,
    required String materialType,
    String? storageKey,
    required int organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         title: title,
         materialType: materialType,
         storageKey: storageKey,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [Material]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Material copyWith({
    Object? id = _Undefined,
    String? title,
    String? materialType,
    Object? storageKey = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
  }) {
    return Material(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      materialType: materialType ?? this.materialType,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}

class MaterialUpdateTable extends _i1.UpdateTable<MaterialTable> {
  MaterialUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> materialType(String value) => _i1.ColumnValue(
    table.materialType,
    value,
  );

  _i1.ColumnValue<String, String> storageKey(String? value) => _i1.ColumnValue(
    table.storageKey,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );
}

class MaterialTable extends _i1.Table<int?> {
  MaterialTable({super.tableRelation}) : super(tableName: 'material') {
    updateTable = MaterialUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    materialType = _i1.ColumnString(
      'materialType',
      this,
    );
    storageKey = _i1.ColumnString(
      'storageKey',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
  }

  late final MaterialUpdateTable updateTable;

  /// Material title.
  late final _i1.ColumnString title;

  /// Type: pdf, video, scorm.
  late final _i1.ColumnString materialType;

  /// S3/MinIO storage key.
  late final _i1.ColumnString storageKey;

  late final _i1.ColumnInt organizationId;

  /// Organization for multi-tenant.
  _i2.OrganizationTable? _organization;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Material.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    materialType,
    storageKey,
    organizationId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class MaterialInclude extends _i1.IncludeObject {
  MaterialInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Material.t;
}

class MaterialIncludeList extends _i1.IncludeList {
  MaterialIncludeList._({
    _i1.WhereExpressionBuilder<MaterialTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Material.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Material.t;
}

class MaterialRepository {
  const MaterialRepository._();

  final attachRow = const MaterialAttachRowRepository._();

  /// Returns a list of [Material]s matching the given query parameters.
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
  Future<List<Material>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialTable>? orderByList,
    _i1.Transaction? transaction,
    MaterialInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Material>(
      where: where?.call(Material.t),
      orderBy: orderBy?.call(Material.t),
      orderByList: orderByList?.call(Material.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Material] matching the given query parameters.
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
  Future<Material?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialTable>? where,
    int? offset,
    _i1.OrderByBuilder<MaterialTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialTable>? orderByList,
    _i1.Transaction? transaction,
    MaterialInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Material>(
      where: where?.call(Material.t),
      orderBy: orderBy?.call(Material.t),
      orderByList: orderByList?.call(Material.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Material] by its [id] or null if no such row exists.
  Future<Material?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    MaterialInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Material>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Material]s in the list and returns the inserted rows.
  ///
  /// The returned [Material]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Material>> insert(
    _i1.Session session,
    List<Material> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Material>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Material] and returns the inserted row.
  ///
  /// The returned [Material] will have its `id` field set.
  Future<Material> insertRow(
    _i1.Session session,
    Material row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Material>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Material]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Material>> update(
    _i1.Session session,
    List<Material> rows, {
    _i1.ColumnSelections<MaterialTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Material>(
      rows,
      columns: columns?.call(Material.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Material]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Material> updateRow(
    _i1.Session session,
    Material row, {
    _i1.ColumnSelections<MaterialTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Material>(
      row,
      columns: columns?.call(Material.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Material] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Material?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MaterialUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Material>(
      id,
      columnValues: columnValues(Material.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Material]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Material>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MaterialUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MaterialTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialTable>? orderBy,
    _i1.OrderByListBuilder<MaterialTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Material>(
      columnValues: columnValues(Material.t.updateTable),
      where: where(Material.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Material.t),
      orderByList: orderByList?.call(Material.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Material]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Material>> delete(
    _i1.Session session,
    List<Material> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Material>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Material].
  Future<Material> deleteRow(
    _i1.Session session,
    Material row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Material>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Material>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MaterialTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Material>(
      where: where(Material.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MaterialTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Material>(
      where: where?.call(Material.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Material] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MaterialTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Material>(
      where: where(Material.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MaterialAttachRowRepository {
  const MaterialAttachRowRepository._();

  /// Creates a relation between the given [Material] and [Organization]
  /// by setting the [Material]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.Session session,
    Material material,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (material.id == null) {
      throw ArgumentError.notNull('material.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $material = material.copyWith(organizationId: organization.id);
    await session.db.updateRow<Material>(
      $material,
      columns: [Material.t.organizationId],
      transaction: transaction,
    );
  }
}
