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

/// Feature flag for gradual rollout.
abstract class FeatureFlag
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureFlag._({
    this.id,
    required this.key,
    bool? enabled,
    this.organizationId,
    this.organization,
  }) : enabled = enabled ?? false;

  factory FeatureFlag({
    int? id,
    required String key,
    bool? enabled,
    int? organizationId,
    _i2.Organization? organization,
  }) = _FeatureFlagImpl;

  factory FeatureFlag.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureFlag(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
    );
  }

  static final t = FeatureFlagTable();

  static const db = FeatureFlagRepository._();

  @override
  int? id;

  /// Flag key.
  String key;

  /// Whether enabled.
  bool enabled;

  int? organizationId;

  /// Organization (null for global).
  _i2.Organization? organization;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureFlag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureFlag copyWith({
    int? id,
    String? key,
    bool? enabled,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureFlag',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureFlag',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
    };
  }

  static FeatureFlagInclude include({_i2.OrganizationInclude? organization}) {
    return FeatureFlagInclude._(organization: organization);
  }

  static FeatureFlagIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    FeatureFlagInclude? include,
  }) {
    return FeatureFlagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureFlag.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureFlagImpl extends FeatureFlag {
  _FeatureFlagImpl({
    int? id,
    required String key,
    bool? enabled,
    int? organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         key: key,
         enabled: enabled,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [FeatureFlag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureFlag copyWith({
    Object? id = _Undefined,
    String? key,
    bool? enabled,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
  }) {
    return FeatureFlag(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      enabled: enabled ?? this.enabled,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}

class FeatureFlagUpdateTable extends _i1.UpdateTable<FeatureFlagTable> {
  FeatureFlagUpdateTable(super.table);

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );
}

class FeatureFlagTable extends _i1.Table<int?> {
  FeatureFlagTable({super.tableRelation}) : super(tableName: 'feature_flag') {
    updateTable = FeatureFlagUpdateTable(this);
    key = _i1.ColumnString(
      'key',
      this,
    );
    enabled = _i1.ColumnBool(
      'enabled',
      this,
      hasDefault: true,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
  }

  late final FeatureFlagUpdateTable updateTable;

  /// Flag key.
  late final _i1.ColumnString key;

  /// Whether enabled.
  late final _i1.ColumnBool enabled;

  late final _i1.ColumnInt organizationId;

  /// Organization (null for global).
  _i2.OrganizationTable? _organization;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: FeatureFlag.t.organizationId,
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
    key,
    enabled,
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

class FeatureFlagInclude extends _i1.IncludeObject {
  FeatureFlagInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => FeatureFlag.t;
}

class FeatureFlagIncludeList extends _i1.IncludeList {
  FeatureFlagIncludeList._({
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureFlag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureFlag.t;
}

class FeatureFlagRepository {
  const FeatureFlagRepository._();

  final attachRow = const FeatureFlagAttachRowRepository._();

  final detachRow = const FeatureFlagDetachRowRepository._();

  /// Returns a list of [FeatureFlag]s matching the given query parameters.
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
  Future<List<FeatureFlag>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureFlagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureFlag>(
      where: where?.call(FeatureFlag.t),
      orderBy: orderBy?.call(FeatureFlag.t),
      orderByList: orderByList?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureFlag] matching the given query parameters.
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
  Future<FeatureFlag?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureFlagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureFlag>(
      where: where?.call(FeatureFlag.t),
      orderBy: orderBy?.call(FeatureFlag.t),
      orderByList: orderByList?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureFlag] by its [id] or null if no such row exists.
  Future<FeatureFlag?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    FeatureFlagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureFlag>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureFlag]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureFlag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FeatureFlag>> insert(
    _i1.DatabaseSession session,
    List<FeatureFlag> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FeatureFlag>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FeatureFlag] and returns the inserted row.
  ///
  /// The returned [FeatureFlag] will have its `id` field set.
  Future<FeatureFlag> insertRow(
    _i1.DatabaseSession session,
    FeatureFlag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureFlag>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureFlag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureFlag>> update(
    _i1.DatabaseSession session,
    List<FeatureFlag> rows, {
    _i1.ColumnSelections<FeatureFlagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureFlag>(
      rows,
      columns: columns?.call(FeatureFlag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureFlag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureFlag> updateRow(
    _i1.DatabaseSession session,
    FeatureFlag row, {
    _i1.ColumnSelections<FeatureFlagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureFlag>(
      row,
      columns: columns?.call(FeatureFlag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureFlag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureFlag?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FeatureFlagUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureFlag>(
      id,
      columnValues: columnValues(FeatureFlag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureFlag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FeatureFlag>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FeatureFlagUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FeatureFlagTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FeatureFlag>(
      columnValues: columnValues(FeatureFlag.t.updateTable),
      where: where(FeatureFlag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureFlag.t),
      orderByList: orderByList?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureFlag]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureFlag>> delete(
    _i1.DatabaseSession session,
    List<FeatureFlag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureFlag>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureFlag].
  Future<FeatureFlag> deleteRow(
    _i1.DatabaseSession session,
    FeatureFlag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureFlag>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureFlag>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FeatureFlagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureFlag>(
      where: where(FeatureFlag.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureFlag>(
      where: where?.call(FeatureFlag.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureFlag] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FeatureFlagTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureFlag>(
      where: where(FeatureFlag.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureFlagAttachRowRepository {
  const FeatureFlagAttachRowRepository._();

  /// Creates a relation between the given [FeatureFlag] and [Organization]
  /// by setting the [FeatureFlag]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    FeatureFlag featureFlag,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (featureFlag.id == null) {
      throw ArgumentError.notNull('featureFlag.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $featureFlag = featureFlag.copyWith(organizationId: organization.id);
    await session.db.updateRow<FeatureFlag>(
      $featureFlag,
      columns: [FeatureFlag.t.organizationId],
      transaction: transaction,
    );
  }
}

class FeatureFlagDetachRowRepository {
  const FeatureFlagDetachRowRepository._();

  /// Detaches the relation between this [FeatureFlag] and the [Organization] set in `organization`
  /// by setting the [FeatureFlag]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    FeatureFlag featureFlag, {
    _i1.Transaction? transaction,
  }) async {
    if (featureFlag.id == null) {
      throw ArgumentError.notNull('featureFlag.id');
    }

    var $featureFlag = featureFlag.copyWith(organizationId: null);
    await session.db.updateRow<FeatureFlag>(
      $featureFlag,
      columns: [FeatureFlag.t.organizationId],
      transaction: transaction,
    );
  }
}
