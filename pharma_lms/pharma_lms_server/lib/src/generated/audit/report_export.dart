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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Report export record for audit. FDA 21 CFR Part 11.
abstract class ReportExport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReportExport._({
    this.id,
    required this.exportedById,
    this.exportedBy,
    required this.reportType,
    this.filterParamsJson,
    this.recordCount,
    this.fileHash,
    this.storageUrl,
    this.watermarkText,
    DateTime? exportedAt,
    this.expiresAt,
  }) : exportedAt = exportedAt ?? DateTime.now();

  factory ReportExport({
    int? id,
    required int exportedById,
    _i2.PharmaUser? exportedBy,
    required String reportType,
    String? filterParamsJson,
    int? recordCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    DateTime? exportedAt,
    DateTime? expiresAt,
  }) = _ReportExportImpl;

  factory ReportExport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportExport(
      id: jsonSerialization['id'] as int?,
      exportedById: jsonSerialization['exportedById'] as int,
      exportedBy: jsonSerialization['exportedBy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['exportedBy'],
            ),
      reportType: jsonSerialization['reportType'] as String,
      filterParamsJson: jsonSerialization['filterParamsJson'] as String?,
      recordCount: jsonSerialization['recordCount'] as int?,
      fileHash: jsonSerialization['fileHash'] as String?,
      storageUrl: jsonSerialization['storageUrl'] as String?,
      watermarkText: jsonSerialization['watermarkText'] as String?,
      exportedAt: jsonSerialization['exportedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['exportedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  static final t = ReportExportTable();

  static const db = ReportExportRepository._();

  @override
  int? id;

  int exportedById;

  /// Who exported.
  _i2.PharmaUser? exportedBy;

  /// Report type: compliance, training_matrix, audit_trail, certificate_list, inspection_package.
  String reportType;

  /// Filter params as JSON.
  String? filterParamsJson;

  /// Record count in export.
  int? recordCount;

  /// SHA-256 hash for tamper detection.
  String? fileHash;

  /// Storage URL.
  String? storageUrl;

  /// Watermark text.
  String? watermarkText;

  /// When exported.
  DateTime exportedAt;

  /// When export expires (if time-limited).
  DateTime? expiresAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReportExport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportExport copyWith({
    int? id,
    int? exportedById,
    _i2.PharmaUser? exportedBy,
    String? reportType,
    String? filterParamsJson,
    int? recordCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    DateTime? exportedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportExport',
      if (id != null) 'id': id,
      'exportedById': exportedById,
      if (exportedBy != null) 'exportedBy': exportedBy?.toJson(),
      'reportType': reportType,
      if (filterParamsJson != null) 'filterParamsJson': filterParamsJson,
      if (recordCount != null) 'recordCount': recordCount,
      if (fileHash != null) 'fileHash': fileHash,
      if (storageUrl != null) 'storageUrl': storageUrl,
      if (watermarkText != null) 'watermarkText': watermarkText,
      'exportedAt': exportedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReportExport',
      if (id != null) 'id': id,
      'exportedById': exportedById,
      if (exportedBy != null) 'exportedBy': exportedBy?.toJsonForProtocol(),
      'reportType': reportType,
      if (filterParamsJson != null) 'filterParamsJson': filterParamsJson,
      if (recordCount != null) 'recordCount': recordCount,
      if (fileHash != null) 'fileHash': fileHash,
      if (storageUrl != null) 'storageUrl': storageUrl,
      if (watermarkText != null) 'watermarkText': watermarkText,
      'exportedAt': exportedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  static ReportExportInclude include({_i2.PharmaUserInclude? exportedBy}) {
    return ReportExportInclude._(exportedBy: exportedBy);
  }

  static ReportExportIncludeList includeList({
    _i1.WhereExpressionBuilder<ReportExportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportExportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportExportTable>? orderByList,
    ReportExportInclude? include,
  }) {
    return ReportExportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReportExport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReportExport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportExportImpl extends ReportExport {
  _ReportExportImpl({
    int? id,
    required int exportedById,
    _i2.PharmaUser? exportedBy,
    required String reportType,
    String? filterParamsJson,
    int? recordCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    DateTime? exportedAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         exportedById: exportedById,
         exportedBy: exportedBy,
         reportType: reportType,
         filterParamsJson: filterParamsJson,
         recordCount: recordCount,
         fileHash: fileHash,
         storageUrl: storageUrl,
         watermarkText: watermarkText,
         exportedAt: exportedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [ReportExport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportExport copyWith({
    Object? id = _Undefined,
    int? exportedById,
    Object? exportedBy = _Undefined,
    String? reportType,
    Object? filterParamsJson = _Undefined,
    Object? recordCount = _Undefined,
    Object? fileHash = _Undefined,
    Object? storageUrl = _Undefined,
    Object? watermarkText = _Undefined,
    DateTime? exportedAt,
    Object? expiresAt = _Undefined,
  }) {
    return ReportExport(
      id: id is int? ? id : this.id,
      exportedById: exportedById ?? this.exportedById,
      exportedBy: exportedBy is _i2.PharmaUser?
          ? exportedBy
          : this.exportedBy?.copyWith(),
      reportType: reportType ?? this.reportType,
      filterParamsJson: filterParamsJson is String?
          ? filterParamsJson
          : this.filterParamsJson,
      recordCount: recordCount is int? ? recordCount : this.recordCount,
      fileHash: fileHash is String? ? fileHash : this.fileHash,
      storageUrl: storageUrl is String? ? storageUrl : this.storageUrl,
      watermarkText: watermarkText is String?
          ? watermarkText
          : this.watermarkText,
      exportedAt: exportedAt ?? this.exportedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}

class ReportExportUpdateTable extends _i1.UpdateTable<ReportExportTable> {
  ReportExportUpdateTable(super.table);

  _i1.ColumnValue<int, int> exportedById(int value) => _i1.ColumnValue(
    table.exportedById,
    value,
  );

  _i1.ColumnValue<String, String> reportType(String value) => _i1.ColumnValue(
    table.reportType,
    value,
  );

  _i1.ColumnValue<String, String> filterParamsJson(String? value) =>
      _i1.ColumnValue(
        table.filterParamsJson,
        value,
      );

  _i1.ColumnValue<int, int> recordCount(int? value) => _i1.ColumnValue(
    table.recordCount,
    value,
  );

  _i1.ColumnValue<String, String> fileHash(String? value) => _i1.ColumnValue(
    table.fileHash,
    value,
  );

  _i1.ColumnValue<String, String> storageUrl(String? value) => _i1.ColumnValue(
    table.storageUrl,
    value,
  );

  _i1.ColumnValue<String, String> watermarkText(String? value) =>
      _i1.ColumnValue(
        table.watermarkText,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> exportedAt(DateTime value) =>
      _i1.ColumnValue(
        table.exportedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class ReportExportTable extends _i1.Table<int?> {
  ReportExportTable({super.tableRelation}) : super(tableName: 'report_export') {
    updateTable = ReportExportUpdateTable(this);
    exportedById = _i1.ColumnInt(
      'exportedById',
      this,
    );
    reportType = _i1.ColumnString(
      'reportType',
      this,
    );
    filterParamsJson = _i1.ColumnString(
      'filterParamsJson',
      this,
    );
    recordCount = _i1.ColumnInt(
      'recordCount',
      this,
    );
    fileHash = _i1.ColumnString(
      'fileHash',
      this,
    );
    storageUrl = _i1.ColumnString(
      'storageUrl',
      this,
    );
    watermarkText = _i1.ColumnString(
      'watermarkText',
      this,
    );
    exportedAt = _i1.ColumnDateTime(
      'exportedAt',
      this,
      hasDefault: true,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final ReportExportUpdateTable updateTable;

  late final _i1.ColumnInt exportedById;

  /// Who exported.
  _i2.PharmaUserTable? _exportedBy;

  /// Report type: compliance, training_matrix, audit_trail, certificate_list, inspection_package.
  late final _i1.ColumnString reportType;

  /// Filter params as JSON.
  late final _i1.ColumnString filterParamsJson;

  /// Record count in export.
  late final _i1.ColumnInt recordCount;

  /// SHA-256 hash for tamper detection.
  late final _i1.ColumnString fileHash;

  /// Storage URL.
  late final _i1.ColumnString storageUrl;

  /// Watermark text.
  late final _i1.ColumnString watermarkText;

  /// When exported.
  late final _i1.ColumnDateTime exportedAt;

  /// When export expires (if time-limited).
  late final _i1.ColumnDateTime expiresAt;

  _i2.PharmaUserTable get exportedBy {
    if (_exportedBy != null) return _exportedBy!;
    _exportedBy = _i1.createRelationTable(
      relationFieldName: 'exportedBy',
      field: ReportExport.t.exportedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _exportedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    exportedById,
    reportType,
    filterParamsJson,
    recordCount,
    fileHash,
    storageUrl,
    watermarkText,
    exportedAt,
    expiresAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'exportedBy') {
      return exportedBy;
    }
    return null;
  }
}

class ReportExportInclude extends _i1.IncludeObject {
  ReportExportInclude._({_i2.PharmaUserInclude? exportedBy}) {
    _exportedBy = exportedBy;
  }

  _i2.PharmaUserInclude? _exportedBy;

  @override
  Map<String, _i1.Include?> get includes => {'exportedBy': _exportedBy};

  @override
  _i1.Table<int?> get table => ReportExport.t;
}

class ReportExportIncludeList extends _i1.IncludeList {
  ReportExportIncludeList._({
    _i1.WhereExpressionBuilder<ReportExportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReportExport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReportExport.t;
}

class ReportExportRepository {
  const ReportExportRepository._();

  final attachRow = const ReportExportAttachRowRepository._();

  /// Returns a list of [ReportExport]s matching the given query parameters.
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
  Future<List<ReportExport>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReportExportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportExportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportExportTable>? orderByList,
    _i1.Transaction? transaction,
    ReportExportInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReportExport>(
      where: where?.call(ReportExport.t),
      orderBy: orderBy?.call(ReportExport.t),
      orderByList: orderByList?.call(ReportExport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReportExport] matching the given query parameters.
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
  Future<ReportExport?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReportExportTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReportExportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportExportTable>? orderByList,
    _i1.Transaction? transaction,
    ReportExportInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReportExport>(
      where: where?.call(ReportExport.t),
      orderBy: orderBy?.call(ReportExport.t),
      orderByList: orderByList?.call(ReportExport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReportExport] by its [id] or null if no such row exists.
  Future<ReportExport?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ReportExportInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReportExport>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReportExport]s in the list and returns the inserted rows.
  ///
  /// The returned [ReportExport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ReportExport>> insert(
    _i1.DatabaseSession session,
    List<ReportExport> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ReportExport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ReportExport] and returns the inserted row.
  ///
  /// The returned [ReportExport] will have its `id` field set.
  Future<ReportExport> insertRow(
    _i1.DatabaseSession session,
    ReportExport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReportExport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReportExport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReportExport>> update(
    _i1.DatabaseSession session,
    List<ReportExport> rows, {
    _i1.ColumnSelections<ReportExportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReportExport>(
      rows,
      columns: columns?.call(ReportExport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReportExport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReportExport> updateRow(
    _i1.DatabaseSession session,
    ReportExport row, {
    _i1.ColumnSelections<ReportExportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReportExport>(
      row,
      columns: columns?.call(ReportExport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReportExport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReportExport?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ReportExportUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ReportExport>(
      id,
      columnValues: columnValues(ReportExport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReportExport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ReportExport>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ReportExportUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ReportExportTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportExportTable>? orderBy,
    _i1.OrderByListBuilder<ReportExportTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ReportExport>(
      columnValues: columnValues(ReportExport.t.updateTable),
      where: where(ReportExport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReportExport.t),
      orderByList: orderByList?.call(ReportExport.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ReportExport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReportExport>> delete(
    _i1.DatabaseSession session,
    List<ReportExport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReportExport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReportExport].
  Future<ReportExport> deleteRow(
    _i1.DatabaseSession session,
    ReportExport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReportExport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReportExport>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReportExportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReportExport>(
      where: where(ReportExport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReportExportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReportExport>(
      where: where?.call(ReportExport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReportExport] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReportExportTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReportExport>(
      where: where(ReportExport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ReportExportAttachRowRepository {
  const ReportExportAttachRowRepository._();

  /// Creates a relation between the given [ReportExport] and [PharmaUser]
  /// by setting the [ReportExport]'s foreign key `exportedById` to refer to the [PharmaUser].
  Future<void> exportedBy(
    _i1.DatabaseSession session,
    ReportExport reportExport,
    _i2.PharmaUser exportedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (reportExport.id == null) {
      throw ArgumentError.notNull('reportExport.id');
    }
    if (exportedBy.id == null) {
      throw ArgumentError.notNull('exportedBy.id');
    }

    var $reportExport = reportExport.copyWith(exportedById: exportedBy.id);
    await session.db.updateRow<ReportExport>(
      $reportExport,
      columns: [ReportExport.t.exportedById],
      transaction: transaction,
    );
  }
}
