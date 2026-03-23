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

/// System configuration key-value.
abstract class SystemConfiguration
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SystemConfiguration._({
    this.id,
    required this.key,
    required this.value,
    this.organizationId,
    this.organization,
  });

  factory SystemConfiguration({
    int? id,
    required String key,
    required String value,
    int? organizationId,
    _i2.Organization? organization,
  }) = _SystemConfigurationImpl;

  factory SystemConfiguration.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemConfiguration(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
    );
  }

  static final t = SystemConfigurationTable();

  static const db = SystemConfigurationRepository._();

  @override
  int? id;

  /// Configuration key.
  String key;

  /// Configuration value.
  String value;

  int? organizationId;

  /// Organization (null for global).
  _i2.Organization? organization;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SystemConfiguration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemConfiguration copyWith({
    int? id,
    String? key,
    String? value,
    int? organizationId,
    _i2.Organization? organization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemConfiguration',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SystemConfiguration',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
    };
  }

  static SystemConfigurationInclude include({
    _i2.OrganizationInclude? organization,
  }) {
    return SystemConfigurationInclude._(organization: organization);
  }

  static SystemConfigurationIncludeList includeList({
    _i1.WhereExpressionBuilder<SystemConfigurationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemConfigurationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemConfigurationTable>? orderByList,
    SystemConfigurationInclude? include,
  }) {
    return SystemConfigurationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemConfiguration.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SystemConfiguration.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemConfigurationImpl extends SystemConfiguration {
  _SystemConfigurationImpl({
    int? id,
    required String key,
    required String value,
    int? organizationId,
    _i2.Organization? organization,
  }) : super._(
         id: id,
         key: key,
         value: value,
         organizationId: organizationId,
         organization: organization,
       );

  /// Returns a shallow copy of this [SystemConfiguration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemConfiguration copyWith({
    Object? id = _Undefined,
    String? key,
    String? value,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
  }) {
    return SystemConfiguration(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
    );
  }
}

class SystemConfigurationUpdateTable
    extends _i1.UpdateTable<SystemConfigurationTable> {
  SystemConfigurationUpdateTable(super.table);

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<String, String> value(String value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );
}

class SystemConfigurationTable extends _i1.Table<int?> {
  SystemConfigurationTable({super.tableRelation})
    : super(tableName: 'system_configuration') {
    updateTable = SystemConfigurationUpdateTable(this);
    key = _i1.ColumnString(
      'key',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
  }

  late final SystemConfigurationUpdateTable updateTable;

  /// Configuration key.
  late final _i1.ColumnString key;

  /// Configuration value.
  late final _i1.ColumnString value;

  late final _i1.ColumnInt organizationId;

  /// Organization (null for global).
  _i2.OrganizationTable? _organization;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: SystemConfiguration.t.organizationId,
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
    value,
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

class SystemConfigurationInclude extends _i1.IncludeObject {
  SystemConfigurationInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => SystemConfiguration.t;
}

class SystemConfigurationIncludeList extends _i1.IncludeList {
  SystemConfigurationIncludeList._({
    _i1.WhereExpressionBuilder<SystemConfigurationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SystemConfiguration.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SystemConfiguration.t;
}

class SystemConfigurationRepository {
  const SystemConfigurationRepository._();

  final attachRow = const SystemConfigurationAttachRowRepository._();

  final detachRow = const SystemConfigurationDetachRowRepository._();

  /// Returns a list of [SystemConfiguration]s matching the given query parameters.
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
  Future<List<SystemConfiguration>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SystemConfigurationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemConfigurationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemConfigurationTable>? orderByList,
    _i1.Transaction? transaction,
    SystemConfigurationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SystemConfiguration>(
      where: where?.call(SystemConfiguration.t),
      orderBy: orderBy?.call(SystemConfiguration.t),
      orderByList: orderByList?.call(SystemConfiguration.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SystemConfiguration] matching the given query parameters.
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
  Future<SystemConfiguration?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SystemConfigurationTable>? where,
    int? offset,
    _i1.OrderByBuilder<SystemConfigurationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemConfigurationTable>? orderByList,
    _i1.Transaction? transaction,
    SystemConfigurationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SystemConfiguration>(
      where: where?.call(SystemConfiguration.t),
      orderBy: orderBy?.call(SystemConfiguration.t),
      orderByList: orderByList?.call(SystemConfiguration.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SystemConfiguration] by its [id] or null if no such row exists.
  Future<SystemConfiguration?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SystemConfigurationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SystemConfiguration>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SystemConfiguration]s in the list and returns the inserted rows.
  ///
  /// The returned [SystemConfiguration]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SystemConfiguration>> insert(
    _i1.DatabaseSession session,
    List<SystemConfiguration> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SystemConfiguration>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SystemConfiguration] and returns the inserted row.
  ///
  /// The returned [SystemConfiguration] will have its `id` field set.
  Future<SystemConfiguration> insertRow(
    _i1.DatabaseSession session,
    SystemConfiguration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SystemConfiguration>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SystemConfiguration]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SystemConfiguration>> update(
    _i1.DatabaseSession session,
    List<SystemConfiguration> rows, {
    _i1.ColumnSelections<SystemConfigurationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SystemConfiguration>(
      rows,
      columns: columns?.call(SystemConfiguration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemConfiguration]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SystemConfiguration> updateRow(
    _i1.DatabaseSession session,
    SystemConfiguration row, {
    _i1.ColumnSelections<SystemConfigurationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SystemConfiguration>(
      row,
      columns: columns?.call(SystemConfiguration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemConfiguration] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SystemConfiguration?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SystemConfigurationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SystemConfiguration>(
      id,
      columnValues: columnValues(SystemConfiguration.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SystemConfiguration]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SystemConfiguration>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SystemConfigurationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SystemConfigurationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemConfigurationTable>? orderBy,
    _i1.OrderByListBuilder<SystemConfigurationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SystemConfiguration>(
      columnValues: columnValues(SystemConfiguration.t.updateTable),
      where: where(SystemConfiguration.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemConfiguration.t),
      orderByList: orderByList?.call(SystemConfiguration.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SystemConfiguration]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SystemConfiguration>> delete(
    _i1.DatabaseSession session,
    List<SystemConfiguration> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SystemConfiguration>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SystemConfiguration].
  Future<SystemConfiguration> deleteRow(
    _i1.DatabaseSession session,
    SystemConfiguration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SystemConfiguration>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SystemConfiguration>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SystemConfigurationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SystemConfiguration>(
      where: where(SystemConfiguration.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SystemConfigurationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SystemConfiguration>(
      where: where?.call(SystemConfiguration.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SystemConfiguration] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SystemConfigurationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SystemConfiguration>(
      where: where(SystemConfiguration.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SystemConfigurationAttachRowRepository {
  const SystemConfigurationAttachRowRepository._();

  /// Creates a relation between the given [SystemConfiguration] and [Organization]
  /// by setting the [SystemConfiguration]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    SystemConfiguration systemConfiguration,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (systemConfiguration.id == null) {
      throw ArgumentError.notNull('systemConfiguration.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $systemConfiguration = systemConfiguration.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<SystemConfiguration>(
      $systemConfiguration,
      columns: [SystemConfiguration.t.organizationId],
      transaction: transaction,
    );
  }
}

class SystemConfigurationDetachRowRepository {
  const SystemConfigurationDetachRowRepository._();

  /// Detaches the relation between this [SystemConfiguration] and the [Organization] set in `organization`
  /// by setting the [SystemConfiguration]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    SystemConfiguration systemConfiguration, {
    _i1.Transaction? transaction,
  }) async {
    if (systemConfiguration.id == null) {
      throw ArgumentError.notNull('systemConfiguration.id');
    }

    var $systemConfiguration = systemConfiguration.copyWith(
      organizationId: null,
    );
    await session.db.updateRow<SystemConfiguration>(
      $systemConfiguration,
      columns: [SystemConfiguration.t.organizationId],
      transaction: transaction,
    );
  }
}
