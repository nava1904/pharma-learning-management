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

/// Controlled document (SOP, policy).
abstract class Document
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Document._({
    this.id,
    required this.title,
    required this.documentNumber,
    required this.documentType,
    required this.organizationId,
    this.organization,
    this.affectedDepartmentIdsJson,
    this.affectedRoleIdsJson,
    this.trainingRequiredByQa,
  });

  factory Document({
    int? id,
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
    _i2.Organization? organization,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
    String? trainingRequiredByQa,
  }) = _DocumentImpl;

  factory Document.fromJson(Map<String, dynamic> jsonSerialization) {
    return Document(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      documentNumber: jsonSerialization['documentNumber'] as String,
      documentType: jsonSerialization['documentType'] as String,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      affectedDepartmentIdsJson:
          jsonSerialization['affectedDepartmentIdsJson'] as String?,
      affectedRoleIdsJson: jsonSerialization['affectedRoleIdsJson'] as String?,
      trainingRequiredByQa:
          jsonSerialization['trainingRequiredByQa'] as String?,
    );
  }

  static final t = DocumentTable();

  static const db = DocumentRepository._();

  @override
  int? id;

  /// Document title.
  String title;

  /// Document number (e.g., SOP-105).
  String documentNumber;

  /// Type: sop, policy, guideline.
  String documentType;

  int organizationId;

  /// Organization for multi-tenant.
  _i2.Organization? organization;

  /// JSON array of department IDs affected by this document (for retraining scope).
  String? affectedDepartmentIdsJson;

  /// JSON array of role IDs affected by this document (for retraining scope).
  String? affectedRoleIdsJson;

  /// QA gate: training_required, no_training_required. Only trigger retraining when training_required.
  String? trainingRequiredByQa;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Document copyWith({
    int? id,
    String? title,
    String? documentNumber,
    String? documentType,
    int? organizationId,
    _i2.Organization? organization,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
    String? trainingRequiredByQa,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'title': title,
      'documentNumber': documentNumber,
      'documentType': documentType,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (affectedDepartmentIdsJson != null)
        'affectedDepartmentIdsJson': affectedDepartmentIdsJson,
      if (affectedRoleIdsJson != null)
        'affectedRoleIdsJson': affectedRoleIdsJson,
      if (trainingRequiredByQa != null)
        'trainingRequiredByQa': trainingRequiredByQa,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'title': title,
      'documentNumber': documentNumber,
      'documentType': documentType,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (affectedDepartmentIdsJson != null)
        'affectedDepartmentIdsJson': affectedDepartmentIdsJson,
      if (affectedRoleIdsJson != null)
        'affectedRoleIdsJson': affectedRoleIdsJson,
      if (trainingRequiredByQa != null)
        'trainingRequiredByQa': trainingRequiredByQa,
    };
  }

  static DocumentInclude include({_i2.OrganizationInclude? organization}) {
    return DocumentInclude._(organization: organization);
  }

  static DocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    DocumentInclude? include,
  }) {
    return DocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Document.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Document.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentImpl extends Document {
  _DocumentImpl({
    int? id,
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
    _i2.Organization? organization,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
    String? trainingRequiredByQa,
  }) : super._(
         id: id,
         title: title,
         documentNumber: documentNumber,
         documentType: documentType,
         organizationId: organizationId,
         organization: organization,
         affectedDepartmentIdsJson: affectedDepartmentIdsJson,
         affectedRoleIdsJson: affectedRoleIdsJson,
         trainingRequiredByQa: trainingRequiredByQa,
       );

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Document copyWith({
    Object? id = _Undefined,
    String? title,
    String? documentNumber,
    String? documentType,
    int? organizationId,
    Object? organization = _Undefined,
    Object? affectedDepartmentIdsJson = _Undefined,
    Object? affectedRoleIdsJson = _Undefined,
    Object? trainingRequiredByQa = _Undefined,
  }) {
    return Document(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      documentNumber: documentNumber ?? this.documentNumber,
      documentType: documentType ?? this.documentType,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      affectedDepartmentIdsJson: affectedDepartmentIdsJson is String?
          ? affectedDepartmentIdsJson
          : this.affectedDepartmentIdsJson,
      affectedRoleIdsJson: affectedRoleIdsJson is String?
          ? affectedRoleIdsJson
          : this.affectedRoleIdsJson,
      trainingRequiredByQa: trainingRequiredByQa is String?
          ? trainingRequiredByQa
          : this.trainingRequiredByQa,
    );
  }
}

class DocumentUpdateTable extends _i1.UpdateTable<DocumentTable> {
  DocumentUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> documentNumber(String value) =>
      _i1.ColumnValue(
        table.documentNumber,
        value,
      );

  _i1.ColumnValue<String, String> documentType(String value) => _i1.ColumnValue(
    table.documentType,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> affectedDepartmentIdsJson(String? value) =>
      _i1.ColumnValue(
        table.affectedDepartmentIdsJson,
        value,
      );

  _i1.ColumnValue<String, String> affectedRoleIdsJson(String? value) =>
      _i1.ColumnValue(
        table.affectedRoleIdsJson,
        value,
      );

  _i1.ColumnValue<String, String> trainingRequiredByQa(String? value) =>
      _i1.ColumnValue(
        table.trainingRequiredByQa,
        value,
      );
}

class DocumentTable extends _i1.Table<int?> {
  DocumentTable({super.tableRelation}) : super(tableName: 'document') {
    updateTable = DocumentUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    documentNumber = _i1.ColumnString(
      'documentNumber',
      this,
    );
    documentType = _i1.ColumnString(
      'documentType',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    affectedDepartmentIdsJson = _i1.ColumnString(
      'affectedDepartmentIdsJson',
      this,
    );
    affectedRoleIdsJson = _i1.ColumnString(
      'affectedRoleIdsJson',
      this,
    );
    trainingRequiredByQa = _i1.ColumnString(
      'trainingRequiredByQa',
      this,
    );
  }

  late final DocumentUpdateTable updateTable;

  /// Document title.
  late final _i1.ColumnString title;

  /// Document number (e.g., SOP-105).
  late final _i1.ColumnString documentNumber;

  /// Type: sop, policy, guideline.
  late final _i1.ColumnString documentType;

  late final _i1.ColumnInt organizationId;

  /// Organization for multi-tenant.
  _i2.OrganizationTable? _organization;

  /// JSON array of department IDs affected by this document (for retraining scope).
  late final _i1.ColumnString affectedDepartmentIdsJson;

  /// JSON array of role IDs affected by this document (for retraining scope).
  late final _i1.ColumnString affectedRoleIdsJson;

  /// QA gate: training_required, no_training_required. Only trigger retraining when training_required.
  late final _i1.ColumnString trainingRequiredByQa;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Document.t.organizationId,
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
    documentNumber,
    documentType,
    organizationId,
    affectedDepartmentIdsJson,
    affectedRoleIdsJson,
    trainingRequiredByQa,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class DocumentInclude extends _i1.IncludeObject {
  DocumentInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Document.t;
}

class DocumentIncludeList extends _i1.IncludeList {
  DocumentIncludeList._({
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Document.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Document.t;
}

class DocumentRepository {
  const DocumentRepository._();

  final attachRow = const DocumentAttachRowRepository._();

  /// Returns a list of [Document]s matching the given query parameters.
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
  Future<List<Document>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    _i1.Transaction? transaction,
    DocumentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Document>(
      where: where?.call(Document.t),
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Document] matching the given query parameters.
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
  Future<Document?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    _i1.Transaction? transaction,
    DocumentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Document>(
      where: where?.call(Document.t),
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Document] by its [id] or null if no such row exists.
  Future<Document?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DocumentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Document>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Document]s in the list and returns the inserted rows.
  ///
  /// The returned [Document]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Document>> insert(
    _i1.DatabaseSession session,
    List<Document> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Document>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Document] and returns the inserted row.
  ///
  /// The returned [Document] will have its `id` field set.
  Future<Document> insertRow(
    _i1.DatabaseSession session,
    Document row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Document>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Document]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Document>> update(
    _i1.DatabaseSession session,
    List<Document> rows, {
    _i1.ColumnSelections<DocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Document>(
      rows,
      columns: columns?.call(Document.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Document]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Document> updateRow(
    _i1.DatabaseSession session,
    Document row, {
    _i1.ColumnSelections<DocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Document>(
      row,
      columns: columns?.call(Document.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Document] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Document?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DocumentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Document>(
      id,
      columnValues: columnValues(Document.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Document]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Document>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DocumentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DocumentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Document>(
      columnValues: columnValues(Document.t.updateTable),
      where: where(Document.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Document]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Document>> delete(
    _i1.DatabaseSession session,
    List<Document> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Document>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Document].
  Future<Document> deleteRow(
    _i1.DatabaseSession session,
    Document row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Document>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Document>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Document>(
      where: where(Document.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Document>(
      where: where?.call(Document.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Document] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DocumentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Document>(
      where: where(Document.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DocumentAttachRowRepository {
  const DocumentAttachRowRepository._();

  /// Creates a relation between the given [Document] and [Organization]
  /// by setting the [Document]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Document document,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (document.id == null) {
      throw ArgumentError.notNull('document.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $document = document.copyWith(organizationId: organization.id);
    await session.db.updateRow<Document>(
      $document,
      columns: [Document.t.organizationId],
      transaction: transaction,
    );
  }
}
