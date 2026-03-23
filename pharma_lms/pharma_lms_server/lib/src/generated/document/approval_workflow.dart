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
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Approval workflow step for document version.
abstract class ApprovalWorkflow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ApprovalWorkflow._({
    this.id,
    required this.documentVersionId,
    this.documentVersion,
    required this.step,
    required this.approverId,
    this.approver,
    String? status,
    this.signedAt,
    this.esignatureId,
    this.esignature,
  }) : status = status ?? 'pending';

  factory ApprovalWorkflow({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required int step,
    required int approverId,
    _i3.PharmaUser? approver,
    String? status,
    DateTime? signedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) = _ApprovalWorkflowImpl;

  factory ApprovalWorkflow.fromJson(Map<String, dynamic> jsonSerialization) {
    return ApprovalWorkflow(
      id: jsonSerialization['id'] as int?,
      documentVersionId: jsonSerialization['documentVersionId'] as int,
      documentVersion: jsonSerialization['documentVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.DocumentVersion>(
              jsonSerialization['documentVersion'],
            ),
      step: jsonSerialization['step'] as int,
      approverId: jsonSerialization['approverId'] as int,
      approver: jsonSerialization['approver'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['approver'],
            ),
      status: jsonSerialization['status'] as String?,
      signedAt: jsonSerialization['signedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['signedAt']),
      esignatureId: jsonSerialization['esignatureId'] as int?,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  static final t = ApprovalWorkflowTable();

  static const db = ApprovalWorkflowRepository._();

  @override
  int? id;

  int documentVersionId;

  /// The document version.
  _i2.DocumentVersion? documentVersion;

  /// Step number.
  int step;

  int approverId;

  /// Approver user.
  _i3.PharmaUser? approver;

  /// Status: pending, approved, rejected.
  String status;

  /// When signed.
  DateTime? signedAt;

  int? esignatureId;

  /// Electronic signature.
  _i4.ElectronicSignature? esignature;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ApprovalWorkflow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ApprovalWorkflow copyWith({
    int? id,
    int? documentVersionId,
    _i2.DocumentVersion? documentVersion,
    int? step,
    int? approverId,
    _i3.PharmaUser? approver,
    String? status,
    DateTime? signedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ApprovalWorkflow',
      if (id != null) 'id': id,
      'documentVersionId': documentVersionId,
      if (documentVersion != null) 'documentVersion': documentVersion?.toJson(),
      'step': step,
      'approverId': approverId,
      if (approver != null) 'approver': approver?.toJson(),
      'status': status,
      if (signedAt != null) 'signedAt': signedAt?.toJson(),
      if (esignatureId != null) 'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ApprovalWorkflow',
      if (id != null) 'id': id,
      'documentVersionId': documentVersionId,
      if (documentVersion != null)
        'documentVersion': documentVersion?.toJsonForProtocol(),
      'step': step,
      'approverId': approverId,
      if (approver != null) 'approver': approver?.toJsonForProtocol(),
      'status': status,
      if (signedAt != null) 'signedAt': signedAt?.toJson(),
      if (esignatureId != null) 'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJsonForProtocol(),
    };
  }

  static ApprovalWorkflowInclude include({
    _i2.DocumentVersionInclude? documentVersion,
    _i3.PharmaUserInclude? approver,
    _i4.ElectronicSignatureInclude? esignature,
  }) {
    return ApprovalWorkflowInclude._(
      documentVersion: documentVersion,
      approver: approver,
      esignature: esignature,
    );
  }

  static ApprovalWorkflowIncludeList includeList({
    _i1.WhereExpressionBuilder<ApprovalWorkflowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApprovalWorkflowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApprovalWorkflowTable>? orderByList,
    ApprovalWorkflowInclude? include,
  }) {
    return ApprovalWorkflowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ApprovalWorkflow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ApprovalWorkflow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ApprovalWorkflowImpl extends ApprovalWorkflow {
  _ApprovalWorkflowImpl({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required int step,
    required int approverId,
    _i3.PharmaUser? approver,
    String? status,
    DateTime? signedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         documentVersionId: documentVersionId,
         documentVersion: documentVersion,
         step: step,
         approverId: approverId,
         approver: approver,
         status: status,
         signedAt: signedAt,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [ApprovalWorkflow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ApprovalWorkflow copyWith({
    Object? id = _Undefined,
    int? documentVersionId,
    Object? documentVersion = _Undefined,
    int? step,
    int? approverId,
    Object? approver = _Undefined,
    String? status,
    Object? signedAt = _Undefined,
    Object? esignatureId = _Undefined,
    Object? esignature = _Undefined,
  }) {
    return ApprovalWorkflow(
      id: id is int? ? id : this.id,
      documentVersionId: documentVersionId ?? this.documentVersionId,
      documentVersion: documentVersion is _i2.DocumentVersion?
          ? documentVersion
          : this.documentVersion?.copyWith(),
      step: step ?? this.step,
      approverId: approverId ?? this.approverId,
      approver: approver is _i3.PharmaUser?
          ? approver
          : this.approver?.copyWith(),
      status: status ?? this.status,
      signedAt: signedAt is DateTime? ? signedAt : this.signedAt,
      esignatureId: esignatureId is int? ? esignatureId : this.esignatureId,
      esignature: esignature is _i4.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}

class ApprovalWorkflowUpdateTable
    extends _i1.UpdateTable<ApprovalWorkflowTable> {
  ApprovalWorkflowUpdateTable(super.table);

  _i1.ColumnValue<int, int> documentVersionId(int value) => _i1.ColumnValue(
    table.documentVersionId,
    value,
  );

  _i1.ColumnValue<int, int> step(int value) => _i1.ColumnValue(
    table.step,
    value,
  );

  _i1.ColumnValue<int, int> approverId(int value) => _i1.ColumnValue(
    table.approverId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> signedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.signedAt,
        value,
      );

  _i1.ColumnValue<int, int> esignatureId(int? value) => _i1.ColumnValue(
    table.esignatureId,
    value,
  );
}

class ApprovalWorkflowTable extends _i1.Table<int?> {
  ApprovalWorkflowTable({super.tableRelation})
    : super(tableName: 'approval_workflow') {
    updateTable = ApprovalWorkflowUpdateTable(this);
    documentVersionId = _i1.ColumnInt(
      'documentVersionId',
      this,
    );
    step = _i1.ColumnInt(
      'step',
      this,
    );
    approverId = _i1.ColumnInt(
      'approverId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    signedAt = _i1.ColumnDateTime(
      'signedAt',
      this,
    );
    esignatureId = _i1.ColumnInt(
      'esignatureId',
      this,
    );
  }

  late final ApprovalWorkflowUpdateTable updateTable;

  late final _i1.ColumnInt documentVersionId;

  /// The document version.
  _i2.DocumentVersionTable? _documentVersion;

  /// Step number.
  late final _i1.ColumnInt step;

  late final _i1.ColumnInt approverId;

  /// Approver user.
  _i3.PharmaUserTable? _approver;

  /// Status: pending, approved, rejected.
  late final _i1.ColumnString status;

  /// When signed.
  late final _i1.ColumnDateTime signedAt;

  late final _i1.ColumnInt esignatureId;

  /// Electronic signature.
  _i4.ElectronicSignatureTable? _esignature;

  _i2.DocumentVersionTable get documentVersion {
    if (_documentVersion != null) return _documentVersion!;
    _documentVersion = _i1.createRelationTable(
      relationFieldName: 'documentVersion',
      field: ApprovalWorkflow.t.documentVersionId,
      foreignField: _i2.DocumentVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DocumentVersionTable(tableRelation: foreignTableRelation),
    );
    return _documentVersion!;
  }

  _i3.PharmaUserTable get approver {
    if (_approver != null) return _approver!;
    _approver = _i1.createRelationTable(
      relationFieldName: 'approver',
      field: ApprovalWorkflow.t.approverId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _approver!;
  }

  _i4.ElectronicSignatureTable get esignature {
    if (_esignature != null) return _esignature!;
    _esignature = _i1.createRelationTable(
      relationFieldName: 'esignature',
      field: ApprovalWorkflow.t.esignatureId,
      foreignField: _i4.ElectronicSignature.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ElectronicSignatureTable(tableRelation: foreignTableRelation),
    );
    return _esignature!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    documentVersionId,
    step,
    approverId,
    status,
    signedAt,
    esignatureId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'documentVersion') {
      return documentVersion;
    }
    if (relationField == 'approver') {
      return approver;
    }
    if (relationField == 'esignature') {
      return esignature;
    }
    return null;
  }
}

class ApprovalWorkflowInclude extends _i1.IncludeObject {
  ApprovalWorkflowInclude._({
    _i2.DocumentVersionInclude? documentVersion,
    _i3.PharmaUserInclude? approver,
    _i4.ElectronicSignatureInclude? esignature,
  }) {
    _documentVersion = documentVersion;
    _approver = approver;
    _esignature = esignature;
  }

  _i2.DocumentVersionInclude? _documentVersion;

  _i3.PharmaUserInclude? _approver;

  _i4.ElectronicSignatureInclude? _esignature;

  @override
  Map<String, _i1.Include?> get includes => {
    'documentVersion': _documentVersion,
    'approver': _approver,
    'esignature': _esignature,
  };

  @override
  _i1.Table<int?> get table => ApprovalWorkflow.t;
}

class ApprovalWorkflowIncludeList extends _i1.IncludeList {
  ApprovalWorkflowIncludeList._({
    _i1.WhereExpressionBuilder<ApprovalWorkflowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ApprovalWorkflow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ApprovalWorkflow.t;
}

class ApprovalWorkflowRepository {
  const ApprovalWorkflowRepository._();

  final attachRow = const ApprovalWorkflowAttachRowRepository._();

  final detachRow = const ApprovalWorkflowDetachRowRepository._();

  /// Returns a list of [ApprovalWorkflow]s matching the given query parameters.
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
  Future<List<ApprovalWorkflow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ApprovalWorkflowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApprovalWorkflowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApprovalWorkflowTable>? orderByList,
    _i1.Transaction? transaction,
    ApprovalWorkflowInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ApprovalWorkflow>(
      where: where?.call(ApprovalWorkflow.t),
      orderBy: orderBy?.call(ApprovalWorkflow.t),
      orderByList: orderByList?.call(ApprovalWorkflow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ApprovalWorkflow] matching the given query parameters.
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
  Future<ApprovalWorkflow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ApprovalWorkflowTable>? where,
    int? offset,
    _i1.OrderByBuilder<ApprovalWorkflowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApprovalWorkflowTable>? orderByList,
    _i1.Transaction? transaction,
    ApprovalWorkflowInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ApprovalWorkflow>(
      where: where?.call(ApprovalWorkflow.t),
      orderBy: orderBy?.call(ApprovalWorkflow.t),
      orderByList: orderByList?.call(ApprovalWorkflow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ApprovalWorkflow] by its [id] or null if no such row exists.
  Future<ApprovalWorkflow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ApprovalWorkflowInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ApprovalWorkflow>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ApprovalWorkflow]s in the list and returns the inserted rows.
  ///
  /// The returned [ApprovalWorkflow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ApprovalWorkflow>> insert(
    _i1.DatabaseSession session,
    List<ApprovalWorkflow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ApprovalWorkflow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ApprovalWorkflow] and returns the inserted row.
  ///
  /// The returned [ApprovalWorkflow] will have its `id` field set.
  Future<ApprovalWorkflow> insertRow(
    _i1.DatabaseSession session,
    ApprovalWorkflow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ApprovalWorkflow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ApprovalWorkflow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ApprovalWorkflow>> update(
    _i1.DatabaseSession session,
    List<ApprovalWorkflow> rows, {
    _i1.ColumnSelections<ApprovalWorkflowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ApprovalWorkflow>(
      rows,
      columns: columns?.call(ApprovalWorkflow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ApprovalWorkflow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ApprovalWorkflow> updateRow(
    _i1.DatabaseSession session,
    ApprovalWorkflow row, {
    _i1.ColumnSelections<ApprovalWorkflowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ApprovalWorkflow>(
      row,
      columns: columns?.call(ApprovalWorkflow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ApprovalWorkflow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ApprovalWorkflow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ApprovalWorkflowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ApprovalWorkflow>(
      id,
      columnValues: columnValues(ApprovalWorkflow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ApprovalWorkflow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ApprovalWorkflow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ApprovalWorkflowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ApprovalWorkflowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApprovalWorkflowTable>? orderBy,
    _i1.OrderByListBuilder<ApprovalWorkflowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ApprovalWorkflow>(
      columnValues: columnValues(ApprovalWorkflow.t.updateTable),
      where: where(ApprovalWorkflow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ApprovalWorkflow.t),
      orderByList: orderByList?.call(ApprovalWorkflow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ApprovalWorkflow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ApprovalWorkflow>> delete(
    _i1.DatabaseSession session,
    List<ApprovalWorkflow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ApprovalWorkflow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ApprovalWorkflow].
  Future<ApprovalWorkflow> deleteRow(
    _i1.DatabaseSession session,
    ApprovalWorkflow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ApprovalWorkflow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ApprovalWorkflow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ApprovalWorkflowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ApprovalWorkflow>(
      where: where(ApprovalWorkflow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ApprovalWorkflowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ApprovalWorkflow>(
      where: where?.call(ApprovalWorkflow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ApprovalWorkflow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ApprovalWorkflowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ApprovalWorkflow>(
      where: where(ApprovalWorkflow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ApprovalWorkflowAttachRowRepository {
  const ApprovalWorkflowAttachRowRepository._();

  /// Creates a relation between the given [ApprovalWorkflow] and [DocumentVersion]
  /// by setting the [ApprovalWorkflow]'s foreign key `documentVersionId` to refer to the [DocumentVersion].
  Future<void> documentVersion(
    _i1.DatabaseSession session,
    ApprovalWorkflow approvalWorkflow,
    _i2.DocumentVersion documentVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (approvalWorkflow.id == null) {
      throw ArgumentError.notNull('approvalWorkflow.id');
    }
    if (documentVersion.id == null) {
      throw ArgumentError.notNull('documentVersion.id');
    }

    var $approvalWorkflow = approvalWorkflow.copyWith(
      documentVersionId: documentVersion.id,
    );
    await session.db.updateRow<ApprovalWorkflow>(
      $approvalWorkflow,
      columns: [ApprovalWorkflow.t.documentVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ApprovalWorkflow] and [PharmaUser]
  /// by setting the [ApprovalWorkflow]'s foreign key `approverId` to refer to the [PharmaUser].
  Future<void> approver(
    _i1.DatabaseSession session,
    ApprovalWorkflow approvalWorkflow,
    _i3.PharmaUser approver, {
    _i1.Transaction? transaction,
  }) async {
    if (approvalWorkflow.id == null) {
      throw ArgumentError.notNull('approvalWorkflow.id');
    }
    if (approver.id == null) {
      throw ArgumentError.notNull('approver.id');
    }

    var $approvalWorkflow = approvalWorkflow.copyWith(approverId: approver.id);
    await session.db.updateRow<ApprovalWorkflow>(
      $approvalWorkflow,
      columns: [ApprovalWorkflow.t.approverId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ApprovalWorkflow] and [ElectronicSignature]
  /// by setting the [ApprovalWorkflow]'s foreign key `esignatureId` to refer to the [ElectronicSignature].
  Future<void> esignature(
    _i1.DatabaseSession session,
    ApprovalWorkflow approvalWorkflow,
    _i4.ElectronicSignature esignature, {
    _i1.Transaction? transaction,
  }) async {
    if (approvalWorkflow.id == null) {
      throw ArgumentError.notNull('approvalWorkflow.id');
    }
    if (esignature.id == null) {
      throw ArgumentError.notNull('esignature.id');
    }

    var $approvalWorkflow = approvalWorkflow.copyWith(
      esignatureId: esignature.id,
    );
    await session.db.updateRow<ApprovalWorkflow>(
      $approvalWorkflow,
      columns: [ApprovalWorkflow.t.esignatureId],
      transaction: transaction,
    );
  }
}

class ApprovalWorkflowDetachRowRepository {
  const ApprovalWorkflowDetachRowRepository._();

  /// Detaches the relation between this [ApprovalWorkflow] and the [ElectronicSignature] set in `esignature`
  /// by setting the [ApprovalWorkflow]'s foreign key `esignatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> esignature(
    _i1.DatabaseSession session,
    ApprovalWorkflow approvalWorkflow, {
    _i1.Transaction? transaction,
  }) async {
    if (approvalWorkflow.id == null) {
      throw ArgumentError.notNull('approvalWorkflow.id');
    }

    var $approvalWorkflow = approvalWorkflow.copyWith(esignatureId: null);
    await session.db.updateRow<ApprovalWorkflow>(
      $approvalWorkflow,
      columns: [ApprovalWorkflow.t.esignatureId],
      transaction: transaction,
    );
  }
}
