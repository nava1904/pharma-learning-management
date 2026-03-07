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
import '../document/document_version.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Document lifecycle state tracking.
abstract class DocumentLifecycle
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DocumentLifecycle._({
    this.id,
    required this.documentVersionId,
    this.documentVersion,
    required this.state,
    DateTime? changedAt,
    required this.changedById,
    this.changedBy,
  }) : changedAt = changedAt ?? DateTime.now();

  factory DocumentLifecycle({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required String state,
    DateTime? changedAt,
    required int changedById,
    _i3.PharmaUser? changedBy,
  }) = _DocumentLifecycleImpl;

  factory DocumentLifecycle.fromJson(Map<String, dynamic> jsonSerialization) {
    return DocumentLifecycle(
      id: jsonSerialization['id'] as int?,
      documentVersionId: jsonSerialization['documentVersionId'] as int,
      documentVersion: jsonSerialization['documentVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.DocumentVersion>(
              jsonSerialization['documentVersion'],
            ),
      state: jsonSerialization['state'] as String,
      changedAt: jsonSerialization['changedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changedAt']),
      changedById: jsonSerialization['changedById'] as int,
      changedBy: jsonSerialization['changedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['changedBy'],
            ),
    );
  }

  static final t = DocumentLifecycleTable();

  static const db = DocumentLifecycleRepository._();

  @override
  int? id;

  int documentVersionId;

  /// The document version.
  _i2.DocumentVersion? documentVersion;

  /// State: draft, review, approved, effective, obsolete.
  String state;

  /// When changed.
  DateTime changedAt;

  int changedById;

  /// Who changed (user ID).
  _i3.PharmaUser? changedBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DocumentLifecycle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DocumentLifecycle copyWith({
    int? id,
    int? documentVersionId,
    _i2.DocumentVersion? documentVersion,
    String? state,
    DateTime? changedAt,
    int? changedById,
    _i3.PharmaUser? changedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DocumentLifecycle',
      if (id != null) 'id': id,
      'documentVersionId': documentVersionId,
      if (documentVersion != null) 'documentVersion': documentVersion?.toJson(),
      'state': state,
      'changedAt': changedAt.toJson(),
      'changedById': changedById,
      if (changedBy != null) 'changedBy': changedBy?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DocumentLifecycle',
      if (id != null) 'id': id,
      'documentVersionId': documentVersionId,
      if (documentVersion != null)
        'documentVersion': documentVersion?.toJsonForProtocol(),
      'state': state,
      'changedAt': changedAt.toJson(),
      'changedById': changedById,
      if (changedBy != null) 'changedBy': changedBy?.toJsonForProtocol(),
    };
  }

  static DocumentLifecycleInclude include({
    _i2.DocumentVersionInclude? documentVersion,
    _i3.PharmaUserInclude? changedBy,
  }) {
    return DocumentLifecycleInclude._(
      documentVersion: documentVersion,
      changedBy: changedBy,
    );
  }

  static DocumentLifecycleIncludeList includeList({
    _i1.WhereExpressionBuilder<DocumentLifecycleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentLifecycleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentLifecycleTable>? orderByList,
    DocumentLifecycleInclude? include,
  }) {
    return DocumentLifecycleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DocumentLifecycle.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DocumentLifecycle.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentLifecycleImpl extends DocumentLifecycle {
  _DocumentLifecycleImpl({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required String state,
    DateTime? changedAt,
    required int changedById,
    _i3.PharmaUser? changedBy,
  }) : super._(
         id: id,
         documentVersionId: documentVersionId,
         documentVersion: documentVersion,
         state: state,
         changedAt: changedAt,
         changedById: changedById,
         changedBy: changedBy,
       );

  /// Returns a shallow copy of this [DocumentLifecycle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DocumentLifecycle copyWith({
    Object? id = _Undefined,
    int? documentVersionId,
    Object? documentVersion = _Undefined,
    String? state,
    DateTime? changedAt,
    int? changedById,
    Object? changedBy = _Undefined,
  }) {
    return DocumentLifecycle(
      id: id is int? ? id : this.id,
      documentVersionId: documentVersionId ?? this.documentVersionId,
      documentVersion: documentVersion is _i2.DocumentVersion?
          ? documentVersion
          : this.documentVersion?.copyWith(),
      state: state ?? this.state,
      changedAt: changedAt ?? this.changedAt,
      changedById: changedById ?? this.changedById,
      changedBy: changedBy is _i3.PharmaUser?
          ? changedBy
          : this.changedBy?.copyWith(),
    );
  }
}

class DocumentLifecycleUpdateTable
    extends _i1.UpdateTable<DocumentLifecycleTable> {
  DocumentLifecycleUpdateTable(super.table);

  _i1.ColumnValue<int, int> documentVersionId(int value) => _i1.ColumnValue(
    table.documentVersionId,
    value,
  );

  _i1.ColumnValue<String, String> state(String value) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> changedAt(DateTime value) =>
      _i1.ColumnValue(
        table.changedAt,
        value,
      );

  _i1.ColumnValue<int, int> changedById(int value) => _i1.ColumnValue(
    table.changedById,
    value,
  );
}

class DocumentLifecycleTable extends _i1.Table<int?> {
  DocumentLifecycleTable({super.tableRelation})
    : super(tableName: 'document_lifecycle') {
    updateTable = DocumentLifecycleUpdateTable(this);
    documentVersionId = _i1.ColumnInt(
      'documentVersionId',
      this,
    );
    state = _i1.ColumnString(
      'state',
      this,
    );
    changedAt = _i1.ColumnDateTime(
      'changedAt',
      this,
      hasDefault: true,
    );
    changedById = _i1.ColumnInt(
      'changedById',
      this,
    );
  }

  late final DocumentLifecycleUpdateTable updateTable;

  late final _i1.ColumnInt documentVersionId;

  /// The document version.
  _i2.DocumentVersionTable? _documentVersion;

  /// State: draft, review, approved, effective, obsolete.
  late final _i1.ColumnString state;

  /// When changed.
  late final _i1.ColumnDateTime changedAt;

  late final _i1.ColumnInt changedById;

  /// Who changed (user ID).
  _i3.PharmaUserTable? _changedBy;

  _i2.DocumentVersionTable get documentVersion {
    if (_documentVersion != null) return _documentVersion!;
    _documentVersion = _i1.createRelationTable(
      relationFieldName: 'documentVersion',
      field: DocumentLifecycle.t.documentVersionId,
      foreignField: _i2.DocumentVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DocumentVersionTable(tableRelation: foreignTableRelation),
    );
    return _documentVersion!;
  }

  _i3.PharmaUserTable get changedBy {
    if (_changedBy != null) return _changedBy!;
    _changedBy = _i1.createRelationTable(
      relationFieldName: 'changedBy',
      field: DocumentLifecycle.t.changedById,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _changedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    documentVersionId,
    state,
    changedAt,
    changedById,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'documentVersion') {
      return documentVersion;
    }
    if (relationField == 'changedBy') {
      return changedBy;
    }
    return null;
  }
}

class DocumentLifecycleInclude extends _i1.IncludeObject {
  DocumentLifecycleInclude._({
    _i2.DocumentVersionInclude? documentVersion,
    _i3.PharmaUserInclude? changedBy,
  }) {
    _documentVersion = documentVersion;
    _changedBy = changedBy;
  }

  _i2.DocumentVersionInclude? _documentVersion;

  _i3.PharmaUserInclude? _changedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'documentVersion': _documentVersion,
    'changedBy': _changedBy,
  };

  @override
  _i1.Table<int?> get table => DocumentLifecycle.t;
}

class DocumentLifecycleIncludeList extends _i1.IncludeList {
  DocumentLifecycleIncludeList._({
    _i1.WhereExpressionBuilder<DocumentLifecycleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DocumentLifecycle.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DocumentLifecycle.t;
}

class DocumentLifecycleRepository {
  const DocumentLifecycleRepository._();

  final attachRow = const DocumentLifecycleAttachRowRepository._();

  /// Returns a list of [DocumentLifecycle]s matching the given query parameters.
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
  Future<List<DocumentLifecycle>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentLifecycleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentLifecycleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentLifecycleTable>? orderByList,
    _i1.Transaction? transaction,
    DocumentLifecycleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DocumentLifecycle>(
      where: where?.call(DocumentLifecycle.t),
      orderBy: orderBy?.call(DocumentLifecycle.t),
      orderByList: orderByList?.call(DocumentLifecycle.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DocumentLifecycle] matching the given query parameters.
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
  Future<DocumentLifecycle?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentLifecycleTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocumentLifecycleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentLifecycleTable>? orderByList,
    _i1.Transaction? transaction,
    DocumentLifecycleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DocumentLifecycle>(
      where: where?.call(DocumentLifecycle.t),
      orderBy: orderBy?.call(DocumentLifecycle.t),
      orderByList: orderByList?.call(DocumentLifecycle.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DocumentLifecycle] by its [id] or null if no such row exists.
  Future<DocumentLifecycle?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    DocumentLifecycleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DocumentLifecycle>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DocumentLifecycle]s in the list and returns the inserted rows.
  ///
  /// The returned [DocumentLifecycle]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DocumentLifecycle>> insert(
    _i1.Session session,
    List<DocumentLifecycle> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DocumentLifecycle>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DocumentLifecycle] and returns the inserted row.
  ///
  /// The returned [DocumentLifecycle] will have its `id` field set.
  Future<DocumentLifecycle> insertRow(
    _i1.Session session,
    DocumentLifecycle row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DocumentLifecycle>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DocumentLifecycle]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DocumentLifecycle>> update(
    _i1.Session session,
    List<DocumentLifecycle> rows, {
    _i1.ColumnSelections<DocumentLifecycleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DocumentLifecycle>(
      rows,
      columns: columns?.call(DocumentLifecycle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DocumentLifecycle]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DocumentLifecycle> updateRow(
    _i1.Session session,
    DocumentLifecycle row, {
    _i1.ColumnSelections<DocumentLifecycleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DocumentLifecycle>(
      row,
      columns: columns?.call(DocumentLifecycle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DocumentLifecycle] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DocumentLifecycle?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DocumentLifecycleUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DocumentLifecycle>(
      id,
      columnValues: columnValues(DocumentLifecycle.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DocumentLifecycle]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DocumentLifecycle>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DocumentLifecycleUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DocumentLifecycleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentLifecycleTable>? orderBy,
    _i1.OrderByListBuilder<DocumentLifecycleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DocumentLifecycle>(
      columnValues: columnValues(DocumentLifecycle.t.updateTable),
      where: where(DocumentLifecycle.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DocumentLifecycle.t),
      orderByList: orderByList?.call(DocumentLifecycle.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DocumentLifecycle]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DocumentLifecycle>> delete(
    _i1.Session session,
    List<DocumentLifecycle> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DocumentLifecycle>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DocumentLifecycle].
  Future<DocumentLifecycle> deleteRow(
    _i1.Session session,
    DocumentLifecycle row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DocumentLifecycle>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DocumentLifecycle>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocumentLifecycleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DocumentLifecycle>(
      where: where(DocumentLifecycle.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentLifecycleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DocumentLifecycle>(
      where: where?.call(DocumentLifecycle.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DocumentLifecycle] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocumentLifecycleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DocumentLifecycle>(
      where: where(DocumentLifecycle.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DocumentLifecycleAttachRowRepository {
  const DocumentLifecycleAttachRowRepository._();

  /// Creates a relation between the given [DocumentLifecycle] and [DocumentVersion]
  /// by setting the [DocumentLifecycle]'s foreign key `documentVersionId` to refer to the [DocumentVersion].
  Future<void> documentVersion(
    _i1.Session session,
    DocumentLifecycle documentLifecycle,
    _i2.DocumentVersion documentVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (documentLifecycle.id == null) {
      throw ArgumentError.notNull('documentLifecycle.id');
    }
    if (documentVersion.id == null) {
      throw ArgumentError.notNull('documentVersion.id');
    }

    var $documentLifecycle = documentLifecycle.copyWith(
      documentVersionId: documentVersion.id,
    );
    await session.db.updateRow<DocumentLifecycle>(
      $documentLifecycle,
      columns: [DocumentLifecycle.t.documentVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [DocumentLifecycle] and [PharmaUser]
  /// by setting the [DocumentLifecycle]'s foreign key `changedById` to refer to the [PharmaUser].
  Future<void> changedBy(
    _i1.Session session,
    DocumentLifecycle documentLifecycle,
    _i3.PharmaUser changedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (documentLifecycle.id == null) {
      throw ArgumentError.notNull('documentLifecycle.id');
    }
    if (changedBy.id == null) {
      throw ArgumentError.notNull('changedBy.id');
    }

    var $documentLifecycle = documentLifecycle.copyWith(
      changedById: changedBy.id,
    );
    await session.db.updateRow<DocumentLifecycle>(
      $documentLifecycle,
      columns: [DocumentLifecycle.t.changedById],
      transaction: transaction,
    );
  }
}
