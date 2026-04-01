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
import '../course/competency.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Practical checklist item for OQ/OJT observation.
abstract class PracticalChecklistItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PracticalChecklistItem._({
    this.id,
    required this.competencyId,
    this.competency,
    required this.title,
    this.description,
    int? orderIndex,
    bool? isCritical,
    required this.organizationId,
  }) : orderIndex = orderIndex ?? 0,
       isCritical = isCritical ?? false;

  factory PracticalChecklistItem({
    int? id,
    required int competencyId,
    _i2.Competency? competency,
    required String title,
    String? description,
    int? orderIndex,
    bool? isCritical,
    required int organizationId,
  }) = _PracticalChecklistItemImpl;

  factory PracticalChecklistItem.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PracticalChecklistItem(
      id: jsonSerialization['id'] as int?,
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Competency>(
              jsonSerialization['competency'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      isCritical: jsonSerialization['isCritical'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isCritical']),
      organizationId: jsonSerialization['organizationId'] as int,
    );
  }

  static final t = PracticalChecklistItemTable();

  static const db = PracticalChecklistItemRepository._();

  @override
  int? id;

  int competencyId;

  /// The competency this checklist item belongs to.
  _i2.Competency? competency;

  /// Step/task title.
  String title;

  /// Detailed description of expected performance.
  String? description;

  /// Order within the checklist.
  int orderIndex;

  /// Whether this step is critical (must-pass).
  bool isCritical;

  /// The organization that owns this checklist item.
  int organizationId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PracticalChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PracticalChecklistItem copyWith({
    int? id,
    int? competencyId,
    _i2.Competency? competency,
    String? title,
    String? description,
    int? orderIndex,
    bool? isCritical,
    int? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PracticalChecklistItem',
      if (id != null) 'id': id,
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'orderIndex': orderIndex,
      'isCritical': isCritical,
      'organizationId': organizationId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PracticalChecklistItem',
      if (id != null) 'id': id,
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJsonForProtocol(),
      'title': title,
      if (description != null) 'description': description,
      'orderIndex': orderIndex,
      'isCritical': isCritical,
      'organizationId': organizationId,
    };
  }

  static PracticalChecklistItemInclude include({
    _i2.CompetencyInclude? competency,
  }) {
    return PracticalChecklistItemInclude._(competency: competency);
  }

  static PracticalChecklistItemIncludeList includeList({
    _i1.WhereExpressionBuilder<PracticalChecklistItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PracticalChecklistItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PracticalChecklistItemTable>? orderByList,
    PracticalChecklistItemInclude? include,
  }) {
    return PracticalChecklistItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PracticalChecklistItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PracticalChecklistItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PracticalChecklistItemImpl extends PracticalChecklistItem {
  _PracticalChecklistItemImpl({
    int? id,
    required int competencyId,
    _i2.Competency? competency,
    required String title,
    String? description,
    int? orderIndex,
    bool? isCritical,
    required int organizationId,
  }) : super._(
         id: id,
         competencyId: competencyId,
         competency: competency,
         title: title,
         description: description,
         orderIndex: orderIndex,
         isCritical: isCritical,
         organizationId: organizationId,
       );

  /// Returns a shallow copy of this [PracticalChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PracticalChecklistItem copyWith({
    Object? id = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
    String? title,
    Object? description = _Undefined,
    int? orderIndex,
    bool? isCritical,
    int? organizationId,
  }) {
    return PracticalChecklistItem(
      id: id is int? ? id : this.id,
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i2.Competency?
          ? competency
          : this.competency?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      isCritical: isCritical ?? this.isCritical,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}

class PracticalChecklistItemUpdateTable
    extends _i1.UpdateTable<PracticalChecklistItemTable> {
  PracticalChecklistItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> competencyId(int value) => _i1.ColumnValue(
    table.competencyId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> orderIndex(int value) => _i1.ColumnValue(
    table.orderIndex,
    value,
  );

  _i1.ColumnValue<bool, bool> isCritical(bool value) => _i1.ColumnValue(
    table.isCritical,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );
}

class PracticalChecklistItemTable extends _i1.Table<int?> {
  PracticalChecklistItemTable({super.tableRelation})
    : super(tableName: 'practical_checklist_item') {
    updateTable = PracticalChecklistItemUpdateTable(this);
    competencyId = _i1.ColumnInt(
      'competencyId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
      hasDefault: true,
    );
    isCritical = _i1.ColumnBool(
      'isCritical',
      this,
      hasDefault: true,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
  }

  late final PracticalChecklistItemUpdateTable updateTable;

  late final _i1.ColumnInt competencyId;

  /// The competency this checklist item belongs to.
  _i2.CompetencyTable? _competency;

  /// Step/task title.
  late final _i1.ColumnString title;

  /// Detailed description of expected performance.
  late final _i1.ColumnString description;

  /// Order within the checklist.
  late final _i1.ColumnInt orderIndex;

  /// Whether this step is critical (must-pass).
  late final _i1.ColumnBool isCritical;

  /// The organization that owns this checklist item.
  late final _i1.ColumnInt organizationId;

  _i2.CompetencyTable get competency {
    if (_competency != null) return _competency!;
    _competency = _i1.createRelationTable(
      relationFieldName: 'competency',
      field: PracticalChecklistItem.t.competencyId,
      foreignField: _i2.Competency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CompetencyTable(tableRelation: foreignTableRelation),
    );
    return _competency!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    competencyId,
    title,
    description,
    orderIndex,
    isCritical,
    organizationId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'competency') {
      return competency;
    }
    return null;
  }
}

class PracticalChecklistItemInclude extends _i1.IncludeObject {
  PracticalChecklistItemInclude._({_i2.CompetencyInclude? competency}) {
    _competency = competency;
  }

  _i2.CompetencyInclude? _competency;

  @override
  Map<String, _i1.Include?> get includes => {'competency': _competency};

  @override
  _i1.Table<int?> get table => PracticalChecklistItem.t;
}

class PracticalChecklistItemIncludeList extends _i1.IncludeList {
  PracticalChecklistItemIncludeList._({
    _i1.WhereExpressionBuilder<PracticalChecklistItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PracticalChecklistItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PracticalChecklistItem.t;
}

class PracticalChecklistItemRepository {
  const PracticalChecklistItemRepository._();

  final attachRow = const PracticalChecklistItemAttachRowRepository._();

  /// Returns a list of [PracticalChecklistItem]s matching the given query parameters.
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
  Future<List<PracticalChecklistItem>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PracticalChecklistItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PracticalChecklistItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PracticalChecklistItemTable>? orderByList,
    _i1.Transaction? transaction,
    PracticalChecklistItemInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PracticalChecklistItem>(
      where: where?.call(PracticalChecklistItem.t),
      orderBy: orderBy?.call(PracticalChecklistItem.t),
      orderByList: orderByList?.call(PracticalChecklistItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PracticalChecklistItem] matching the given query parameters.
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
  Future<PracticalChecklistItem?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PracticalChecklistItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<PracticalChecklistItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PracticalChecklistItemTable>? orderByList,
    _i1.Transaction? transaction,
    PracticalChecklistItemInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PracticalChecklistItem>(
      where: where?.call(PracticalChecklistItem.t),
      orderBy: orderBy?.call(PracticalChecklistItem.t),
      orderByList: orderByList?.call(PracticalChecklistItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PracticalChecklistItem] by its [id] or null if no such row exists.
  Future<PracticalChecklistItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    PracticalChecklistItemInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PracticalChecklistItem>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PracticalChecklistItem]s in the list and returns the inserted rows.
  ///
  /// The returned [PracticalChecklistItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PracticalChecklistItem>> insert(
    _i1.DatabaseSession session,
    List<PracticalChecklistItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PracticalChecklistItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PracticalChecklistItem] and returns the inserted row.
  ///
  /// The returned [PracticalChecklistItem] will have its `id` field set.
  Future<PracticalChecklistItem> insertRow(
    _i1.DatabaseSession session,
    PracticalChecklistItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PracticalChecklistItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PracticalChecklistItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PracticalChecklistItem>> update(
    _i1.DatabaseSession session,
    List<PracticalChecklistItem> rows, {
    _i1.ColumnSelections<PracticalChecklistItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PracticalChecklistItem>(
      rows,
      columns: columns?.call(PracticalChecklistItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PracticalChecklistItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PracticalChecklistItem> updateRow(
    _i1.DatabaseSession session,
    PracticalChecklistItem row, {
    _i1.ColumnSelections<PracticalChecklistItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PracticalChecklistItem>(
      row,
      columns: columns?.call(PracticalChecklistItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PracticalChecklistItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PracticalChecklistItem?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PracticalChecklistItemUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PracticalChecklistItem>(
      id,
      columnValues: columnValues(PracticalChecklistItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PracticalChecklistItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PracticalChecklistItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PracticalChecklistItemUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PracticalChecklistItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PracticalChecklistItemTable>? orderBy,
    _i1.OrderByListBuilder<PracticalChecklistItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PracticalChecklistItem>(
      columnValues: columnValues(PracticalChecklistItem.t.updateTable),
      where: where(PracticalChecklistItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PracticalChecklistItem.t),
      orderByList: orderByList?.call(PracticalChecklistItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PracticalChecklistItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PracticalChecklistItem>> delete(
    _i1.DatabaseSession session,
    List<PracticalChecklistItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PracticalChecklistItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PracticalChecklistItem].
  Future<PracticalChecklistItem> deleteRow(
    _i1.DatabaseSession session,
    PracticalChecklistItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PracticalChecklistItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PracticalChecklistItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PracticalChecklistItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PracticalChecklistItem>(
      where: where(PracticalChecklistItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PracticalChecklistItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PracticalChecklistItem>(
      where: where?.call(PracticalChecklistItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PracticalChecklistItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PracticalChecklistItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PracticalChecklistItem>(
      where: where(PracticalChecklistItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PracticalChecklistItemAttachRowRepository {
  const PracticalChecklistItemAttachRowRepository._();

  /// Creates a relation between the given [PracticalChecklistItem] and [Competency]
  /// by setting the [PracticalChecklistItem]'s foreign key `competencyId` to refer to the [Competency].
  Future<void> competency(
    _i1.DatabaseSession session,
    PracticalChecklistItem practicalChecklistItem,
    _i2.Competency competency, {
    _i1.Transaction? transaction,
  }) async {
    if (practicalChecklistItem.id == null) {
      throw ArgumentError.notNull('practicalChecklistItem.id');
    }
    if (competency.id == null) {
      throw ArgumentError.notNull('competency.id');
    }

    var $practicalChecklistItem = practicalChecklistItem.copyWith(
      competencyId: competency.id,
    );
    await session.db.updateRow<PracticalChecklistItem>(
      $practicalChecklistItem,
      columns: [PracticalChecklistItem.t.competencyId],
      transaction: transaction,
    );
  }
}
