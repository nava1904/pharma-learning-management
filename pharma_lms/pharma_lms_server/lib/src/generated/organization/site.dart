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

/// Physical site within an organization.
abstract class Site implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Site._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.code,
    String? timezone,
  }) : timezone = timezone ?? 'UTC';

  factory Site({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? timezone,
  }) = _SiteImpl;

  factory Site.fromJson(Map<String, dynamic> jsonSerialization) {
    return Site(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      timezone: jsonSerialization['timezone'] as String?,
    );
  }

  static final t = SiteTable();

  static const db = SiteRepository._();

  @override
  int? id;

  int organizationId;

  /// The organization this site belongs to.
  _i2.Organization? organization;

  /// Site name.
  String name;

  /// Unique code for the site.
  String code;

  /// Timezone for the site (e.g., America/New_York).
  String timezone;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Site copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? code,
    String? timezone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'code': code,
      'timezone': timezone,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'code': code,
      'timezone': timezone,
    };
  }

  static SiteInclude include({_i2.OrganizationInclude? organization}) {
    return SiteInclude._(organization: organization);
  }

  static SiteIncludeList includeList({
    _i1.WhereExpressionBuilder<SiteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SiteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SiteTable>? orderByList,
    SiteInclude? include,
  }) {
    return SiteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Site.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Site.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteImpl extends Site {
  _SiteImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? timezone,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         code: code,
         timezone: timezone,
       );

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Site copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? code,
    String? timezone,
  }) {
    return Site(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      timezone: timezone ?? this.timezone,
    );
  }
}

class SiteUpdateTable extends _i1.UpdateTable<SiteTable> {
  SiteUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
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

  _i1.ColumnValue<String, String> timezone(String value) => _i1.ColumnValue(
    table.timezone,
    value,
  );
}

class SiteTable extends _i1.Table<int?> {
  SiteTable({super.tableRelation}) : super(tableName: 'site') {
    updateTable = SiteUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
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
    timezone = _i1.ColumnString(
      'timezone',
      this,
      hasDefault: true,
    );
  }

  late final SiteUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  /// The organization this site belongs to.
  _i2.OrganizationTable? _organization;

  /// Site name.
  late final _i1.ColumnString name;

  /// Unique code for the site.
  late final _i1.ColumnString code;

  /// Timezone for the site (e.g., America/New_York).
  late final _i1.ColumnString timezone;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Site.t.organizationId,
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
    organizationId,
    name,
    code,
    timezone,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class SiteInclude extends _i1.IncludeObject {
  SiteInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Site.t;
}

class SiteIncludeList extends _i1.IncludeList {
  SiteIncludeList._({
    _i1.WhereExpressionBuilder<SiteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Site.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Site.t;
}

class SiteRepository {
  const SiteRepository._();

  final attachRow = const SiteAttachRowRepository._();

  /// Returns a list of [Site]s matching the given query parameters.
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
  Future<List<Site>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SiteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SiteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SiteTable>? orderByList,
    _i1.Transaction? transaction,
    SiteInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Site>(
      where: where?.call(Site.t),
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Site] matching the given query parameters.
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
  Future<Site?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SiteTable>? where,
    int? offset,
    _i1.OrderByBuilder<SiteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SiteTable>? orderByList,
    _i1.Transaction? transaction,
    SiteInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Site>(
      where: where?.call(Site.t),
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Site] by its [id] or null if no such row exists.
  Future<Site?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SiteInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Site>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Site]s in the list and returns the inserted rows.
  ///
  /// The returned [Site]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Site>> insert(
    _i1.DatabaseSession session,
    List<Site> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Site>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Site] and returns the inserted row.
  ///
  /// The returned [Site] will have its `id` field set.
  Future<Site> insertRow(
    _i1.DatabaseSession session,
    Site row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Site>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Site]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Site>> update(
    _i1.DatabaseSession session,
    List<Site> rows, {
    _i1.ColumnSelections<SiteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Site>(
      rows,
      columns: columns?.call(Site.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Site]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Site> updateRow(
    _i1.DatabaseSession session,
    Site row, {
    _i1.ColumnSelections<SiteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Site>(
      row,
      columns: columns?.call(Site.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Site] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Site?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SiteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Site>(
      id,
      columnValues: columnValues(Site.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Site]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Site>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SiteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SiteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SiteTable>? orderBy,
    _i1.OrderByListBuilder<SiteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Site>(
      columnValues: columnValues(Site.t.updateTable),
      where: where(Site.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Site]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Site>> delete(
    _i1.DatabaseSession session,
    List<Site> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Site>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Site].
  Future<Site> deleteRow(
    _i1.DatabaseSession session,
    Site row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Site>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Site>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SiteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Site>(
      where: where(Site.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SiteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Site>(
      where: where?.call(Site.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Site] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SiteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Site>(
      where: where(Site.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SiteAttachRowRepository {
  const SiteAttachRowRepository._();

  /// Creates a relation between the given [Site] and [Organization]
  /// by setting the [Site]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Site site,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $site = site.copyWith(organizationId: organization.id);
    await session.db.updateRow<Site>(
      $site,
      columns: [Site.t.organizationId],
      transaction: transaction,
    );
  }
}
