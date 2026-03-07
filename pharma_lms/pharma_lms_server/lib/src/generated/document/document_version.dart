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
import '../document/document.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Versioned document for lifecycle control.
abstract class DocumentVersion
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DocumentVersion._({
    this.id,
    required this.documentId,
    this.document,
    required this.version,
    required this.storageKey,
    this.effectiveDate,
    this.obsoleteDate,
  });

  factory DocumentVersion({
    int? id,
    required int documentId,
    _i2.Document? document,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  }) = _DocumentVersionImpl;

  factory DocumentVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return DocumentVersion(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as int,
      document: jsonSerialization['document'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Document>(
              jsonSerialization['document'],
            ),
      version: jsonSerialization['version'] as String,
      storageKey: jsonSerialization['storageKey'] as String,
      effectiveDate: jsonSerialization['effectiveDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectiveDate'],
            ),
      obsoleteDate: jsonSerialization['obsoleteDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['obsoleteDate'],
            ),
    );
  }

  static final t = DocumentVersionTable();

  static const db = DocumentVersionRepository._();

  @override
  int? id;

  int documentId;

  /// The document.
  _i2.Document? document;

  /// Version string.
  String version;

  /// S3/MinIO storage key.
  String storageKey;

  /// When effective.
  DateTime? effectiveDate;

  /// When obsolete.
  DateTime? obsoleteDate;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DocumentVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DocumentVersion copyWith({
    int? id,
    int? documentId,
    _i2.Document? document,
    String? version,
    String? storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DocumentVersion',
      if (id != null) 'id': id,
      'documentId': documentId,
      if (document != null) 'document': document?.toJson(),
      'version': version,
      'storageKey': storageKey,
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
      if (obsoleteDate != null) 'obsoleteDate': obsoleteDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DocumentVersion',
      if (id != null) 'id': id,
      'documentId': documentId,
      if (document != null) 'document': document?.toJsonForProtocol(),
      'version': version,
      'storageKey': storageKey,
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
      if (obsoleteDate != null) 'obsoleteDate': obsoleteDate?.toJson(),
    };
  }

  static DocumentVersionInclude include({_i2.DocumentInclude? document}) {
    return DocumentVersionInclude._(document: document);
  }

  static DocumentVersionIncludeList includeList({
    _i1.WhereExpressionBuilder<DocumentVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentVersionTable>? orderByList,
    DocumentVersionInclude? include,
  }) {
    return DocumentVersionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DocumentVersion.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DocumentVersion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentVersionImpl extends DocumentVersion {
  _DocumentVersionImpl({
    int? id,
    required int documentId,
    _i2.Document? document,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  }) : super._(
         id: id,
         documentId: documentId,
         document: document,
         version: version,
         storageKey: storageKey,
         effectiveDate: effectiveDate,
         obsoleteDate: obsoleteDate,
       );

  /// Returns a shallow copy of this [DocumentVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DocumentVersion copyWith({
    Object? id = _Undefined,
    int? documentId,
    Object? document = _Undefined,
    String? version,
    String? storageKey,
    Object? effectiveDate = _Undefined,
    Object? obsoleteDate = _Undefined,
  }) {
    return DocumentVersion(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      document: document is _i2.Document?
          ? document
          : this.document?.copyWith(),
      version: version ?? this.version,
      storageKey: storageKey ?? this.storageKey,
      effectiveDate: effectiveDate is DateTime?
          ? effectiveDate
          : this.effectiveDate,
      obsoleteDate: obsoleteDate is DateTime?
          ? obsoleteDate
          : this.obsoleteDate,
    );
  }
}

class DocumentVersionUpdateTable extends _i1.UpdateTable<DocumentVersionTable> {
  DocumentVersionUpdateTable(super.table);

  _i1.ColumnValue<int, int> documentId(int value) => _i1.ColumnValue(
    table.documentId,
    value,
  );

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<String, String> storageKey(String value) => _i1.ColumnValue(
    table.storageKey,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> effectiveDate(DateTime? value) =>
      _i1.ColumnValue(
        table.effectiveDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> obsoleteDate(DateTime? value) =>
      _i1.ColumnValue(
        table.obsoleteDate,
        value,
      );
}

class DocumentVersionTable extends _i1.Table<int?> {
  DocumentVersionTable({super.tableRelation})
    : super(tableName: 'document_version') {
    updateTable = DocumentVersionUpdateTable(this);
    documentId = _i1.ColumnInt(
      'documentId',
      this,
    );
    version = _i1.ColumnString(
      'version',
      this,
    );
    storageKey = _i1.ColumnString(
      'storageKey',
      this,
    );
    effectiveDate = _i1.ColumnDateTime(
      'effectiveDate',
      this,
    );
    obsoleteDate = _i1.ColumnDateTime(
      'obsoleteDate',
      this,
    );
  }

  late final DocumentVersionUpdateTable updateTable;

  late final _i1.ColumnInt documentId;

  /// The document.
  _i2.DocumentTable? _document;

  /// Version string.
  late final _i1.ColumnString version;

  /// S3/MinIO storage key.
  late final _i1.ColumnString storageKey;

  /// When effective.
  late final _i1.ColumnDateTime effectiveDate;

  /// When obsolete.
  late final _i1.ColumnDateTime obsoleteDate;

  _i2.DocumentTable get document {
    if (_document != null) return _document!;
    _document = _i1.createRelationTable(
      relationFieldName: 'document',
      field: DocumentVersion.t.documentId,
      foreignField: _i2.Document.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DocumentTable(tableRelation: foreignTableRelation),
    );
    return _document!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    documentId,
    version,
    storageKey,
    effectiveDate,
    obsoleteDate,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'document') {
      return document;
    }
    return null;
  }
}

class DocumentVersionInclude extends _i1.IncludeObject {
  DocumentVersionInclude._({_i2.DocumentInclude? document}) {
    _document = document;
  }

  _i2.DocumentInclude? _document;

  @override
  Map<String, _i1.Include?> get includes => {'document': _document};

  @override
  _i1.Table<int?> get table => DocumentVersion.t;
}

class DocumentVersionIncludeList extends _i1.IncludeList {
  DocumentVersionIncludeList._({
    _i1.WhereExpressionBuilder<DocumentVersionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DocumentVersion.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DocumentVersion.t;
}

class DocumentVersionRepository {
  const DocumentVersionRepository._();

  final attachRow = const DocumentVersionAttachRowRepository._();

  /// Returns a list of [DocumentVersion]s matching the given query parameters.
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
  Future<List<DocumentVersion>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentVersionTable>? orderByList,
    _i1.Transaction? transaction,
    DocumentVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DocumentVersion>(
      where: where?.call(DocumentVersion.t),
      orderBy: orderBy?.call(DocumentVersion.t),
      orderByList: orderByList?.call(DocumentVersion.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DocumentVersion] matching the given query parameters.
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
  Future<DocumentVersion?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentVersionTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocumentVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentVersionTable>? orderByList,
    _i1.Transaction? transaction,
    DocumentVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DocumentVersion>(
      where: where?.call(DocumentVersion.t),
      orderBy: orderBy?.call(DocumentVersion.t),
      orderByList: orderByList?.call(DocumentVersion.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DocumentVersion] by its [id] or null if no such row exists.
  Future<DocumentVersion?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    DocumentVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DocumentVersion>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DocumentVersion]s in the list and returns the inserted rows.
  ///
  /// The returned [DocumentVersion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DocumentVersion>> insert(
    _i1.Session session,
    List<DocumentVersion> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DocumentVersion>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DocumentVersion] and returns the inserted row.
  ///
  /// The returned [DocumentVersion] will have its `id` field set.
  Future<DocumentVersion> insertRow(
    _i1.Session session,
    DocumentVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DocumentVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DocumentVersion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DocumentVersion>> update(
    _i1.Session session,
    List<DocumentVersion> rows, {
    _i1.ColumnSelections<DocumentVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DocumentVersion>(
      rows,
      columns: columns?.call(DocumentVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DocumentVersion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DocumentVersion> updateRow(
    _i1.Session session,
    DocumentVersion row, {
    _i1.ColumnSelections<DocumentVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DocumentVersion>(
      row,
      columns: columns?.call(DocumentVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DocumentVersion] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DocumentVersion?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DocumentVersionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DocumentVersion>(
      id,
      columnValues: columnValues(DocumentVersion.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DocumentVersion]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DocumentVersion>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DocumentVersionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DocumentVersionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentVersionTable>? orderBy,
    _i1.OrderByListBuilder<DocumentVersionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DocumentVersion>(
      columnValues: columnValues(DocumentVersion.t.updateTable),
      where: where(DocumentVersion.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DocumentVersion.t),
      orderByList: orderByList?.call(DocumentVersion.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DocumentVersion]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DocumentVersion>> delete(
    _i1.Session session,
    List<DocumentVersion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DocumentVersion>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DocumentVersion].
  Future<DocumentVersion> deleteRow(
    _i1.Session session,
    DocumentVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DocumentVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DocumentVersion>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocumentVersionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DocumentVersion>(
      where: where(DocumentVersion.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentVersionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DocumentVersion>(
      where: where?.call(DocumentVersion.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DocumentVersion] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocumentVersionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DocumentVersion>(
      where: where(DocumentVersion.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DocumentVersionAttachRowRepository {
  const DocumentVersionAttachRowRepository._();

  /// Creates a relation between the given [DocumentVersion] and [Document]
  /// by setting the [DocumentVersion]'s foreign key `documentId` to refer to the [Document].
  Future<void> document(
    _i1.Session session,
    DocumentVersion documentVersion,
    _i2.Document document, {
    _i1.Transaction? transaction,
  }) async {
    if (documentVersion.id == null) {
      throw ArgumentError.notNull('documentVersion.id');
    }
    if (document.id == null) {
      throw ArgumentError.notNull('document.id');
    }

    var $documentVersion = documentVersion.copyWith(documentId: document.id);
    await session.db.updateRow<DocumentVersion>(
      $documentVersion,
      columns: [DocumentVersion.t.documentId],
      transaction: transaction,
    );
  }
}
