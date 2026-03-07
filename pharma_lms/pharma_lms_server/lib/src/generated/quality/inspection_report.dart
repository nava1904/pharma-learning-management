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
import '../organization/site.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Inspection report (FDA, etc.).
abstract class InspectionReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InspectionReport._({
    this.id,
    required this.organizationId,
    this.organization,
    this.siteId,
    this.site,
    this.inspector,
    this.inspectionDate,
    this.findingsJson,
    required this.status,
  });

  factory InspectionReport({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    int? siteId,
    _i3.Site? site,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
    required String status,
  }) = _InspectionReportImpl;

  factory InspectionReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return InspectionReport(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Site>(jsonSerialization['site']),
      inspector: jsonSerialization['inspector'] as String?,
      inspectionDate: jsonSerialization['inspectionDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['inspectionDate'],
            ),
      findingsJson: jsonSerialization['findingsJson'] as String?,
      status: jsonSerialization['status'] as String,
    );
  }

  static final t = InspectionReportTable();

  static const db = InspectionReportRepository._();

  @override
  int? id;

  int organizationId;

  /// Organization.
  _i2.Organization? organization;

  int? siteId;

  /// Site inspected.
  _i3.Site? site;

  /// Inspector name/agency.
  String? inspector;

  /// Inspection date.
  DateTime? inspectionDate;

  /// Findings as JSON.
  String? findingsJson;

  /// Status.
  String status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InspectionReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InspectionReport copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? siteId,
    _i3.Site? site,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InspectionReport',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      if (inspector != null) 'inspector': inspector,
      if (inspectionDate != null) 'inspectionDate': inspectionDate?.toJson(),
      if (findingsJson != null) 'findingsJson': findingsJson,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InspectionReport',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJsonForProtocol(),
      if (inspector != null) 'inspector': inspector,
      if (inspectionDate != null) 'inspectionDate': inspectionDate?.toJson(),
      if (findingsJson != null) 'findingsJson': findingsJson,
      'status': status,
    };
  }

  static InspectionReportInclude include({
    _i2.OrganizationInclude? organization,
    _i3.SiteInclude? site,
  }) {
    return InspectionReportInclude._(
      organization: organization,
      site: site,
    );
  }

  static InspectionReportIncludeList includeList({
    _i1.WhereExpressionBuilder<InspectionReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionReportTable>? orderByList,
    InspectionReportInclude? include,
  }) {
    return InspectionReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InspectionReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InspectionReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InspectionReportImpl extends InspectionReport {
  _InspectionReportImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    int? siteId,
    _i3.Site? site,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
    required String status,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         siteId: siteId,
         site: site,
         inspector: inspector,
         inspectionDate: inspectionDate,
         findingsJson: findingsJson,
         status: status,
       );

  /// Returns a shallow copy of this [InspectionReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InspectionReport copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    Object? inspector = _Undefined,
    Object? inspectionDate = _Undefined,
    Object? findingsJson = _Undefined,
    String? status,
  }) {
    return InspectionReport(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i3.Site? ? site : this.site?.copyWith(),
      inspector: inspector is String? ? inspector : this.inspector,
      inspectionDate: inspectionDate is DateTime?
          ? inspectionDate
          : this.inspectionDate,
      findingsJson: findingsJson is String? ? findingsJson : this.findingsJson,
      status: status ?? this.status,
    );
  }
}

class InspectionReportUpdateTable
    extends _i1.UpdateTable<InspectionReportTable> {
  InspectionReportUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int? value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<String, String> inspector(String? value) => _i1.ColumnValue(
    table.inspector,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> inspectionDate(DateTime? value) =>
      _i1.ColumnValue(
        table.inspectionDate,
        value,
      );

  _i1.ColumnValue<String, String> findingsJson(String? value) =>
      _i1.ColumnValue(
        table.findingsJson,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class InspectionReportTable extends _i1.Table<int?> {
  InspectionReportTable({super.tableRelation})
    : super(tableName: 'inspection_report') {
    updateTable = InspectionReportUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    inspector = _i1.ColumnString(
      'inspector',
      this,
    );
    inspectionDate = _i1.ColumnDateTime(
      'inspectionDate',
      this,
    );
    findingsJson = _i1.ColumnString(
      'findingsJson',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
  }

  late final InspectionReportUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  /// Organization.
  _i2.OrganizationTable? _organization;

  late final _i1.ColumnInt siteId;

  /// Site inspected.
  _i3.SiteTable? _site;

  /// Inspector name/agency.
  late final _i1.ColumnString inspector;

  /// Inspection date.
  late final _i1.ColumnDateTime inspectionDate;

  /// Findings as JSON.
  late final _i1.ColumnString findingsJson;

  /// Status.
  late final _i1.ColumnString status;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: InspectionReport.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.SiteTable get site {
    if (_site != null) return _site!;
    _site = _i1.createRelationTable(
      relationFieldName: 'site',
      field: InspectionReport.t.siteId,
      foreignField: _i3.Site.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SiteTable(tableRelation: foreignTableRelation),
    );
    return _site!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    siteId,
    inspector,
    inspectionDate,
    findingsJson,
    status,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'site') {
      return site;
    }
    return null;
  }
}

class InspectionReportInclude extends _i1.IncludeObject {
  InspectionReportInclude._({
    _i2.OrganizationInclude? organization,
    _i3.SiteInclude? site,
  }) {
    _organization = organization;
    _site = site;
  }

  _i2.OrganizationInclude? _organization;

  _i3.SiteInclude? _site;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'site': _site,
  };

  @override
  _i1.Table<int?> get table => InspectionReport.t;
}

class InspectionReportIncludeList extends _i1.IncludeList {
  InspectionReportIncludeList._({
    _i1.WhereExpressionBuilder<InspectionReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InspectionReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InspectionReport.t;
}

class InspectionReportRepository {
  const InspectionReportRepository._();

  final attachRow = const InspectionReportAttachRowRepository._();

  final detachRow = const InspectionReportDetachRowRepository._();

  /// Returns a list of [InspectionReport]s matching the given query parameters.
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
  Future<List<InspectionReport>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InspectionReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionReportTable>? orderByList,
    _i1.Transaction? transaction,
    InspectionReportInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InspectionReport>(
      where: where?.call(InspectionReport.t),
      orderBy: orderBy?.call(InspectionReport.t),
      orderByList: orderByList?.call(InspectionReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InspectionReport] matching the given query parameters.
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
  Future<InspectionReport?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InspectionReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<InspectionReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionReportTable>? orderByList,
    _i1.Transaction? transaction,
    InspectionReportInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InspectionReport>(
      where: where?.call(InspectionReport.t),
      orderBy: orderBy?.call(InspectionReport.t),
      orderByList: orderByList?.call(InspectionReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InspectionReport] by its [id] or null if no such row exists.
  Future<InspectionReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    InspectionReportInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InspectionReport>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InspectionReport]s in the list and returns the inserted rows.
  ///
  /// The returned [InspectionReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<InspectionReport>> insert(
    _i1.Session session,
    List<InspectionReport> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<InspectionReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [InspectionReport] and returns the inserted row.
  ///
  /// The returned [InspectionReport] will have its `id` field set.
  Future<InspectionReport> insertRow(
    _i1.Session session,
    InspectionReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InspectionReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InspectionReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InspectionReport>> update(
    _i1.Session session,
    List<InspectionReport> rows, {
    _i1.ColumnSelections<InspectionReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InspectionReport>(
      rows,
      columns: columns?.call(InspectionReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InspectionReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InspectionReport> updateRow(
    _i1.Session session,
    InspectionReport row, {
    _i1.ColumnSelections<InspectionReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InspectionReport>(
      row,
      columns: columns?.call(InspectionReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InspectionReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InspectionReport?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<InspectionReportUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<InspectionReport>(
      id,
      columnValues: columnValues(InspectionReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InspectionReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<InspectionReport>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<InspectionReportUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<InspectionReportTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionReportTable>? orderBy,
    _i1.OrderByListBuilder<InspectionReportTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<InspectionReport>(
      columnValues: columnValues(InspectionReport.t.updateTable),
      where: where(InspectionReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InspectionReport.t),
      orderByList: orderByList?.call(InspectionReport.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [InspectionReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InspectionReport>> delete(
    _i1.Session session,
    List<InspectionReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InspectionReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InspectionReport].
  Future<InspectionReport> deleteRow(
    _i1.Session session,
    InspectionReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InspectionReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InspectionReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InspectionReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InspectionReport>(
      where: where(InspectionReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InspectionReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InspectionReport>(
      where: where?.call(InspectionReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InspectionReport] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InspectionReportTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InspectionReport>(
      where: where(InspectionReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class InspectionReportAttachRowRepository {
  const InspectionReportAttachRowRepository._();

  /// Creates a relation between the given [InspectionReport] and [Organization]
  /// by setting the [InspectionReport]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.Session session,
    InspectionReport inspectionReport,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionReport.id == null) {
      throw ArgumentError.notNull('inspectionReport.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $inspectionReport = inspectionReport.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<InspectionReport>(
      $inspectionReport,
      columns: [InspectionReport.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [InspectionReport] and [Site]
  /// by setting the [InspectionReport]'s foreign key `siteId` to refer to the [Site].
  Future<void> site(
    _i1.Session session,
    InspectionReport inspectionReport,
    _i3.Site site, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionReport.id == null) {
      throw ArgumentError.notNull('inspectionReport.id');
    }
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }

    var $inspectionReport = inspectionReport.copyWith(siteId: site.id);
    await session.db.updateRow<InspectionReport>(
      $inspectionReport,
      columns: [InspectionReport.t.siteId],
      transaction: transaction,
    );
  }
}

class InspectionReportDetachRowRepository {
  const InspectionReportDetachRowRepository._();

  /// Detaches the relation between this [InspectionReport] and the [Site] set in `site`
  /// by setting the [InspectionReport]'s foreign key `siteId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> site(
    _i1.Session session,
    InspectionReport inspectionReport, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionReport.id == null) {
      throw ArgumentError.notNull('inspectionReport.id');
    }

    var $inspectionReport = inspectionReport.copyWith(siteId: null);
    await session.db.updateRow<InspectionReport>(
      $inspectionReport,
      columns: [InspectionReport.t.siteId],
      transaction: transaction,
    );
  }
}
