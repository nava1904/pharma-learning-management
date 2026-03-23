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
import '../quality/quality_event.dart' as _i2;
import '../document/document_version.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Change control linking to document and training.
abstract class ChangeControl
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChangeControl._({
    this.id,
    required this.qualityEventId,
    this.qualityEvent,
    required this.documentVersionId,
    this.documentVersion,
    this.trainingTriggerId,
  });

  factory ChangeControl({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    required int documentVersionId,
    _i3.DocumentVersion? documentVersion,
    int? trainingTriggerId,
  }) = _ChangeControlImpl;

  factory ChangeControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChangeControl(
      id: jsonSerialization['id'] as int?,
      qualityEventId: jsonSerialization['qualityEventId'] as int,
      qualityEvent: jsonSerialization['qualityEvent'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.QualityEvent>(
              jsonSerialization['qualityEvent'],
            ),
      documentVersionId: jsonSerialization['documentVersionId'] as int,
      documentVersion: jsonSerialization['documentVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.DocumentVersion>(
              jsonSerialization['documentVersion'],
            ),
      trainingTriggerId: jsonSerialization['trainingTriggerId'] as int?,
    );
  }

  static final t = ChangeControlTable();

  static const db = ChangeControlRepository._();

  @override
  int? id;

  int qualityEventId;

  /// The quality event.
  _i2.QualityEvent? qualityEvent;

  int documentVersionId;

  /// The document version changed.
  _i3.DocumentVersion? documentVersion;

  /// Training trigger/assignment ID.
  int? trainingTriggerId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChangeControl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChangeControl copyWith({
    int? id,
    int? qualityEventId,
    _i2.QualityEvent? qualityEvent,
    int? documentVersionId,
    _i3.DocumentVersion? documentVersion,
    int? trainingTriggerId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChangeControl',
      if (id != null) 'id': id,
      'qualityEventId': qualityEventId,
      if (qualityEvent != null) 'qualityEvent': qualityEvent?.toJson(),
      'documentVersionId': documentVersionId,
      if (documentVersion != null) 'documentVersion': documentVersion?.toJson(),
      if (trainingTriggerId != null) 'trainingTriggerId': trainingTriggerId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChangeControl',
      if (id != null) 'id': id,
      'qualityEventId': qualityEventId,
      if (qualityEvent != null)
        'qualityEvent': qualityEvent?.toJsonForProtocol(),
      'documentVersionId': documentVersionId,
      if (documentVersion != null)
        'documentVersion': documentVersion?.toJsonForProtocol(),
      if (trainingTriggerId != null) 'trainingTriggerId': trainingTriggerId,
    };
  }

  static ChangeControlInclude include({
    _i2.QualityEventInclude? qualityEvent,
    _i3.DocumentVersionInclude? documentVersion,
  }) {
    return ChangeControlInclude._(
      qualityEvent: qualityEvent,
      documentVersion: documentVersion,
    );
  }

  static ChangeControlIncludeList includeList({
    _i1.WhereExpressionBuilder<ChangeControlTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChangeControlTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChangeControlTable>? orderByList,
    ChangeControlInclude? include,
  }) {
    return ChangeControlIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChangeControl.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChangeControl.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChangeControlImpl extends ChangeControl {
  _ChangeControlImpl({
    int? id,
    required int qualityEventId,
    _i2.QualityEvent? qualityEvent,
    required int documentVersionId,
    _i3.DocumentVersion? documentVersion,
    int? trainingTriggerId,
  }) : super._(
         id: id,
         qualityEventId: qualityEventId,
         qualityEvent: qualityEvent,
         documentVersionId: documentVersionId,
         documentVersion: documentVersion,
         trainingTriggerId: trainingTriggerId,
       );

  /// Returns a shallow copy of this [ChangeControl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChangeControl copyWith({
    Object? id = _Undefined,
    int? qualityEventId,
    Object? qualityEvent = _Undefined,
    int? documentVersionId,
    Object? documentVersion = _Undefined,
    Object? trainingTriggerId = _Undefined,
  }) {
    return ChangeControl(
      id: id is int? ? id : this.id,
      qualityEventId: qualityEventId ?? this.qualityEventId,
      qualityEvent: qualityEvent is _i2.QualityEvent?
          ? qualityEvent
          : this.qualityEvent?.copyWith(),
      documentVersionId: documentVersionId ?? this.documentVersionId,
      documentVersion: documentVersion is _i3.DocumentVersion?
          ? documentVersion
          : this.documentVersion?.copyWith(),
      trainingTriggerId: trainingTriggerId is int?
          ? trainingTriggerId
          : this.trainingTriggerId,
    );
  }
}

class ChangeControlUpdateTable extends _i1.UpdateTable<ChangeControlTable> {
  ChangeControlUpdateTable(super.table);

  _i1.ColumnValue<int, int> qualityEventId(int value) => _i1.ColumnValue(
    table.qualityEventId,
    value,
  );

  _i1.ColumnValue<int, int> documentVersionId(int value) => _i1.ColumnValue(
    table.documentVersionId,
    value,
  );

  _i1.ColumnValue<int, int> trainingTriggerId(int? value) => _i1.ColumnValue(
    table.trainingTriggerId,
    value,
  );
}

class ChangeControlTable extends _i1.Table<int?> {
  ChangeControlTable({super.tableRelation})
    : super(tableName: 'change_control') {
    updateTable = ChangeControlUpdateTable(this);
    qualityEventId = _i1.ColumnInt(
      'qualityEventId',
      this,
    );
    documentVersionId = _i1.ColumnInt(
      'documentVersionId',
      this,
    );
    trainingTriggerId = _i1.ColumnInt(
      'trainingTriggerId',
      this,
    );
  }

  late final ChangeControlUpdateTable updateTable;

  late final _i1.ColumnInt qualityEventId;

  /// The quality event.
  _i2.QualityEventTable? _qualityEvent;

  late final _i1.ColumnInt documentVersionId;

  /// The document version changed.
  _i3.DocumentVersionTable? _documentVersion;

  /// Training trigger/assignment ID.
  late final _i1.ColumnInt trainingTriggerId;

  _i2.QualityEventTable get qualityEvent {
    if (_qualityEvent != null) return _qualityEvent!;
    _qualityEvent = _i1.createRelationTable(
      relationFieldName: 'qualityEvent',
      field: ChangeControl.t.qualityEventId,
      foreignField: _i2.QualityEvent.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.QualityEventTable(tableRelation: foreignTableRelation),
    );
    return _qualityEvent!;
  }

  _i3.DocumentVersionTable get documentVersion {
    if (_documentVersion != null) return _documentVersion!;
    _documentVersion = _i1.createRelationTable(
      relationFieldName: 'documentVersion',
      field: ChangeControl.t.documentVersionId,
      foreignField: _i3.DocumentVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.DocumentVersionTable(tableRelation: foreignTableRelation),
    );
    return _documentVersion!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    qualityEventId,
    documentVersionId,
    trainingTriggerId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'qualityEvent') {
      return qualityEvent;
    }
    if (relationField == 'documentVersion') {
      return documentVersion;
    }
    return null;
  }
}

class ChangeControlInclude extends _i1.IncludeObject {
  ChangeControlInclude._({
    _i2.QualityEventInclude? qualityEvent,
    _i3.DocumentVersionInclude? documentVersion,
  }) {
    _qualityEvent = qualityEvent;
    _documentVersion = documentVersion;
  }

  _i2.QualityEventInclude? _qualityEvent;

  _i3.DocumentVersionInclude? _documentVersion;

  @override
  Map<String, _i1.Include?> get includes => {
    'qualityEvent': _qualityEvent,
    'documentVersion': _documentVersion,
  };

  @override
  _i1.Table<int?> get table => ChangeControl.t;
}

class ChangeControlIncludeList extends _i1.IncludeList {
  ChangeControlIncludeList._({
    _i1.WhereExpressionBuilder<ChangeControlTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChangeControl.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChangeControl.t;
}

class ChangeControlRepository {
  const ChangeControlRepository._();

  final attachRow = const ChangeControlAttachRowRepository._();

  /// Returns a list of [ChangeControl]s matching the given query parameters.
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
  Future<List<ChangeControl>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChangeControlTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChangeControlTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChangeControlTable>? orderByList,
    _i1.Transaction? transaction,
    ChangeControlInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChangeControl>(
      where: where?.call(ChangeControl.t),
      orderBy: orderBy?.call(ChangeControl.t),
      orderByList: orderByList?.call(ChangeControl.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChangeControl] matching the given query parameters.
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
  Future<ChangeControl?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChangeControlTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChangeControlTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChangeControlTable>? orderByList,
    _i1.Transaction? transaction,
    ChangeControlInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChangeControl>(
      where: where?.call(ChangeControl.t),
      orderBy: orderBy?.call(ChangeControl.t),
      orderByList: orderByList?.call(ChangeControl.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChangeControl] by its [id] or null if no such row exists.
  Future<ChangeControl?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ChangeControlInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChangeControl>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChangeControl]s in the list and returns the inserted rows.
  ///
  /// The returned [ChangeControl]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChangeControl>> insert(
    _i1.DatabaseSession session,
    List<ChangeControl> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChangeControl>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChangeControl] and returns the inserted row.
  ///
  /// The returned [ChangeControl] will have its `id` field set.
  Future<ChangeControl> insertRow(
    _i1.DatabaseSession session,
    ChangeControl row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChangeControl>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChangeControl]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChangeControl>> update(
    _i1.DatabaseSession session,
    List<ChangeControl> rows, {
    _i1.ColumnSelections<ChangeControlTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChangeControl>(
      rows,
      columns: columns?.call(ChangeControl.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChangeControl]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChangeControl> updateRow(
    _i1.DatabaseSession session,
    ChangeControl row, {
    _i1.ColumnSelections<ChangeControlTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChangeControl>(
      row,
      columns: columns?.call(ChangeControl.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChangeControl] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChangeControl?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChangeControlUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChangeControl>(
      id,
      columnValues: columnValues(ChangeControl.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChangeControl]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChangeControl>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChangeControlUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChangeControlTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChangeControlTable>? orderBy,
    _i1.OrderByListBuilder<ChangeControlTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChangeControl>(
      columnValues: columnValues(ChangeControl.t.updateTable),
      where: where(ChangeControl.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChangeControl.t),
      orderByList: orderByList?.call(ChangeControl.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChangeControl]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChangeControl>> delete(
    _i1.DatabaseSession session,
    List<ChangeControl> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChangeControl>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChangeControl].
  Future<ChangeControl> deleteRow(
    _i1.DatabaseSession session,
    ChangeControl row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChangeControl>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChangeControl>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChangeControlTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChangeControl>(
      where: where(ChangeControl.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChangeControlTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChangeControl>(
      where: where?.call(ChangeControl.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChangeControl] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChangeControlTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChangeControl>(
      where: where(ChangeControl.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ChangeControlAttachRowRepository {
  const ChangeControlAttachRowRepository._();

  /// Creates a relation between the given [ChangeControl] and [QualityEvent]
  /// by setting the [ChangeControl]'s foreign key `qualityEventId` to refer to the [QualityEvent].
  Future<void> qualityEvent(
    _i1.DatabaseSession session,
    ChangeControl changeControl,
    _i2.QualityEvent qualityEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (changeControl.id == null) {
      throw ArgumentError.notNull('changeControl.id');
    }
    if (qualityEvent.id == null) {
      throw ArgumentError.notNull('qualityEvent.id');
    }

    var $changeControl = changeControl.copyWith(
      qualityEventId: qualityEvent.id,
    );
    await session.db.updateRow<ChangeControl>(
      $changeControl,
      columns: [ChangeControl.t.qualityEventId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChangeControl] and [DocumentVersion]
  /// by setting the [ChangeControl]'s foreign key `documentVersionId` to refer to the [DocumentVersion].
  Future<void> documentVersion(
    _i1.DatabaseSession session,
    ChangeControl changeControl,
    _i3.DocumentVersion documentVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (changeControl.id == null) {
      throw ArgumentError.notNull('changeControl.id');
    }
    if (documentVersion.id == null) {
      throw ArgumentError.notNull('documentVersion.id');
    }

    var $changeControl = changeControl.copyWith(
      documentVersionId: documentVersion.id,
    );
    await session.db.updateRow<ChangeControl>(
      $changeControl,
      columns: [ChangeControl.t.documentVersionId],
      transaction: transaction,
    );
  }
}
