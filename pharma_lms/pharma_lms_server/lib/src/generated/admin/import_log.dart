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

/// Import log for bulk operations. FDA 21 CFR Part 11.
abstract class ImportLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ImportLog._({
    this.id,
    required this.importedById,
    this.importedBy,
    required this.importType,
    this.filename,
    this.recordCount,
    this.successCount,
    this.failureCount,
    this.failureDetailsJson,
    DateTime? importedAt,
  }) : importedAt = importedAt ?? DateTime.now();

  factory ImportLog({
    int? id,
    required int importedById,
    _i2.PharmaUser? importedBy,
    required String importType,
    String? filename,
    int? recordCount,
    int? successCount,
    int? failureCount,
    String? failureDetailsJson,
    DateTime? importedAt,
  }) = _ImportLogImpl;

  factory ImportLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImportLog(
      id: jsonSerialization['id'] as int?,
      importedById: jsonSerialization['importedById'] as int,
      importedBy: jsonSerialization['importedBy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['importedBy'],
            ),
      importType: jsonSerialization['importType'] as String,
      filename: jsonSerialization['filename'] as String?,
      recordCount: jsonSerialization['recordCount'] as int?,
      successCount: jsonSerialization['successCount'] as int?,
      failureCount: jsonSerialization['failureCount'] as int?,
      failureDetailsJson: jsonSerialization['failureDetailsJson'] as String?,
      importedAt: jsonSerialization['importedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['importedAt']),
    );
  }

  static final t = ImportLogTable();

  static const db = ImportLogRepository._();

  @override
  int? id;

  int importedById;

  /// Who performed the import.
  _i2.PharmaUser? importedBy;

  /// Import type: employee, course, assignment.
  String importType;

  /// Original filename.
  String? filename;

  /// Total records in file.
  int? recordCount;

  /// Successfully imported count.
  int? successCount;

  /// Failed count.
  int? failureCount;

  /// Failure details as JSON.
  String? failureDetailsJson;

  /// When imported.
  DateTime importedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ImportLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ImportLog copyWith({
    int? id,
    int? importedById,
    _i2.PharmaUser? importedBy,
    String? importType,
    String? filename,
    int? recordCount,
    int? successCount,
    int? failureCount,
    String? failureDetailsJson,
    DateTime? importedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImportLog',
      if (id != null) 'id': id,
      'importedById': importedById,
      if (importedBy != null) 'importedBy': importedBy?.toJson(),
      'importType': importType,
      if (filename != null) 'filename': filename,
      if (recordCount != null) 'recordCount': recordCount,
      if (successCount != null) 'successCount': successCount,
      if (failureCount != null) 'failureCount': failureCount,
      if (failureDetailsJson != null) 'failureDetailsJson': failureDetailsJson,
      'importedAt': importedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ImportLog',
      if (id != null) 'id': id,
      'importedById': importedById,
      if (importedBy != null) 'importedBy': importedBy?.toJsonForProtocol(),
      'importType': importType,
      if (filename != null) 'filename': filename,
      if (recordCount != null) 'recordCount': recordCount,
      if (successCount != null) 'successCount': successCount,
      if (failureCount != null) 'failureCount': failureCount,
      if (failureDetailsJson != null) 'failureDetailsJson': failureDetailsJson,
      'importedAt': importedAt.toJson(),
    };
  }

  static ImportLogInclude include({_i2.PharmaUserInclude? importedBy}) {
    return ImportLogInclude._(importedBy: importedBy);
  }

  static ImportLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ImportLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ImportLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ImportLogTable>? orderByList,
    ImportLogInclude? include,
  }) {
    return ImportLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ImportLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ImportLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ImportLogImpl extends ImportLog {
  _ImportLogImpl({
    int? id,
    required int importedById,
    _i2.PharmaUser? importedBy,
    required String importType,
    String? filename,
    int? recordCount,
    int? successCount,
    int? failureCount,
    String? failureDetailsJson,
    DateTime? importedAt,
  }) : super._(
         id: id,
         importedById: importedById,
         importedBy: importedBy,
         importType: importType,
         filename: filename,
         recordCount: recordCount,
         successCount: successCount,
         failureCount: failureCount,
         failureDetailsJson: failureDetailsJson,
         importedAt: importedAt,
       );

  /// Returns a shallow copy of this [ImportLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ImportLog copyWith({
    Object? id = _Undefined,
    int? importedById,
    Object? importedBy = _Undefined,
    String? importType,
    Object? filename = _Undefined,
    Object? recordCount = _Undefined,
    Object? successCount = _Undefined,
    Object? failureCount = _Undefined,
    Object? failureDetailsJson = _Undefined,
    DateTime? importedAt,
  }) {
    return ImportLog(
      id: id is int? ? id : this.id,
      importedById: importedById ?? this.importedById,
      importedBy: importedBy is _i2.PharmaUser?
          ? importedBy
          : this.importedBy?.copyWith(),
      importType: importType ?? this.importType,
      filename: filename is String? ? filename : this.filename,
      recordCount: recordCount is int? ? recordCount : this.recordCount,
      successCount: successCount is int? ? successCount : this.successCount,
      failureCount: failureCount is int? ? failureCount : this.failureCount,
      failureDetailsJson: failureDetailsJson is String?
          ? failureDetailsJson
          : this.failureDetailsJson,
      importedAt: importedAt ?? this.importedAt,
    );
  }
}

class ImportLogUpdateTable extends _i1.UpdateTable<ImportLogTable> {
  ImportLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> importedById(int value) => _i1.ColumnValue(
    table.importedById,
    value,
  );

  _i1.ColumnValue<String, String> importType(String value) => _i1.ColumnValue(
    table.importType,
    value,
  );

  _i1.ColumnValue<String, String> filename(String? value) => _i1.ColumnValue(
    table.filename,
    value,
  );

  _i1.ColumnValue<int, int> recordCount(int? value) => _i1.ColumnValue(
    table.recordCount,
    value,
  );

  _i1.ColumnValue<int, int> successCount(int? value) => _i1.ColumnValue(
    table.successCount,
    value,
  );

  _i1.ColumnValue<int, int> failureCount(int? value) => _i1.ColumnValue(
    table.failureCount,
    value,
  );

  _i1.ColumnValue<String, String> failureDetailsJson(String? value) =>
      _i1.ColumnValue(
        table.failureDetailsJson,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> importedAt(DateTime value) =>
      _i1.ColumnValue(
        table.importedAt,
        value,
      );
}

class ImportLogTable extends _i1.Table<int?> {
  ImportLogTable({super.tableRelation}) : super(tableName: 'import_log') {
    updateTable = ImportLogUpdateTable(this);
    importedById = _i1.ColumnInt(
      'importedById',
      this,
    );
    importType = _i1.ColumnString(
      'importType',
      this,
    );
    filename = _i1.ColumnString(
      'filename',
      this,
    );
    recordCount = _i1.ColumnInt(
      'recordCount',
      this,
    );
    successCount = _i1.ColumnInt(
      'successCount',
      this,
    );
    failureCount = _i1.ColumnInt(
      'failureCount',
      this,
    );
    failureDetailsJson = _i1.ColumnString(
      'failureDetailsJson',
      this,
    );
    importedAt = _i1.ColumnDateTime(
      'importedAt',
      this,
      hasDefault: true,
    );
  }

  late final ImportLogUpdateTable updateTable;

  late final _i1.ColumnInt importedById;

  /// Who performed the import.
  _i2.PharmaUserTable? _importedBy;

  /// Import type: employee, course, assignment.
  late final _i1.ColumnString importType;

  /// Original filename.
  late final _i1.ColumnString filename;

  /// Total records in file.
  late final _i1.ColumnInt recordCount;

  /// Successfully imported count.
  late final _i1.ColumnInt successCount;

  /// Failed count.
  late final _i1.ColumnInt failureCount;

  /// Failure details as JSON.
  late final _i1.ColumnString failureDetailsJson;

  /// When imported.
  late final _i1.ColumnDateTime importedAt;

  _i2.PharmaUserTable get importedBy {
    if (_importedBy != null) return _importedBy!;
    _importedBy = _i1.createRelationTable(
      relationFieldName: 'importedBy',
      field: ImportLog.t.importedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _importedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    importedById,
    importType,
    filename,
    recordCount,
    successCount,
    failureCount,
    failureDetailsJson,
    importedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'importedBy') {
      return importedBy;
    }
    return null;
  }
}

class ImportLogInclude extends _i1.IncludeObject {
  ImportLogInclude._({_i2.PharmaUserInclude? importedBy}) {
    _importedBy = importedBy;
  }

  _i2.PharmaUserInclude? _importedBy;

  @override
  Map<String, _i1.Include?> get includes => {'importedBy': _importedBy};

  @override
  _i1.Table<int?> get table => ImportLog.t;
}

class ImportLogIncludeList extends _i1.IncludeList {
  ImportLogIncludeList._({
    _i1.WhereExpressionBuilder<ImportLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ImportLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ImportLog.t;
}

class ImportLogRepository {
  const ImportLogRepository._();

  final attachRow = const ImportLogAttachRowRepository._();

  /// Returns a list of [ImportLog]s matching the given query parameters.
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
  Future<List<ImportLog>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ImportLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ImportLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ImportLogTable>? orderByList,
    _i1.Transaction? transaction,
    ImportLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ImportLog>(
      where: where?.call(ImportLog.t),
      orderBy: orderBy?.call(ImportLog.t),
      orderByList: orderByList?.call(ImportLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ImportLog] matching the given query parameters.
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
  Future<ImportLog?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ImportLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ImportLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ImportLogTable>? orderByList,
    _i1.Transaction? transaction,
    ImportLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ImportLog>(
      where: where?.call(ImportLog.t),
      orderBy: orderBy?.call(ImportLog.t),
      orderByList: orderByList?.call(ImportLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ImportLog] by its [id] or null if no such row exists.
  Future<ImportLog?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ImportLogInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ImportLog>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ImportLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ImportLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ImportLog>> insert(
    _i1.DatabaseSession session,
    List<ImportLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ImportLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ImportLog] and returns the inserted row.
  ///
  /// The returned [ImportLog] will have its `id` field set.
  Future<ImportLog> insertRow(
    _i1.DatabaseSession session,
    ImportLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ImportLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ImportLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ImportLog>> update(
    _i1.DatabaseSession session,
    List<ImportLog> rows, {
    _i1.ColumnSelections<ImportLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ImportLog>(
      rows,
      columns: columns?.call(ImportLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ImportLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ImportLog> updateRow(
    _i1.DatabaseSession session,
    ImportLog row, {
    _i1.ColumnSelections<ImportLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ImportLog>(
      row,
      columns: columns?.call(ImportLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ImportLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ImportLog?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ImportLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ImportLog>(
      id,
      columnValues: columnValues(ImportLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ImportLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ImportLog>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ImportLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ImportLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ImportLogTable>? orderBy,
    _i1.OrderByListBuilder<ImportLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ImportLog>(
      columnValues: columnValues(ImportLog.t.updateTable),
      where: where(ImportLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ImportLog.t),
      orderByList: orderByList?.call(ImportLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ImportLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ImportLog>> delete(
    _i1.DatabaseSession session,
    List<ImportLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ImportLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ImportLog].
  Future<ImportLog> deleteRow(
    _i1.DatabaseSession session,
    ImportLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ImportLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ImportLog>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ImportLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ImportLog>(
      where: where(ImportLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ImportLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ImportLog>(
      where: where?.call(ImportLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ImportLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ImportLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ImportLog>(
      where: where(ImportLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ImportLogAttachRowRepository {
  const ImportLogAttachRowRepository._();

  /// Creates a relation between the given [ImportLog] and [PharmaUser]
  /// by setting the [ImportLog]'s foreign key `importedById` to refer to the [PharmaUser].
  Future<void> importedBy(
    _i1.DatabaseSession session,
    ImportLog importLog,
    _i2.PharmaUser importedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (importLog.id == null) {
      throw ArgumentError.notNull('importLog.id');
    }
    if (importedBy.id == null) {
      throw ArgumentError.notNull('importedBy.id');
    }

    var $importLog = importLog.copyWith(importedById: importedBy.id);
    await session.db.updateRow<ImportLog>(
      $importLog,
      columns: [ImportLog.t.importedById],
      transaction: transaction,
    );
  }
}
