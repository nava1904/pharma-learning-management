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

/// Question bank for assessments.
abstract class QuestionBank
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuestionBank._({
    this.id,
    required this.name,
    required this.organizationId,
    this.organization,
    this.tagsJson,
  });

  factory QuestionBank({
    int? id,
    required String name,
    required int organizationId,
    _i2.Organization? organization,
    String? tagsJson,
  }) = _QuestionBankImpl;

  factory QuestionBank.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionBank(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      tagsJson: jsonSerialization['tagsJson'] as String?,
    );
  }

  static final t = QuestionBankTable();

  static const db = QuestionBankRepository._();

  @override
  int? id;

  /// Bank name.
  String name;

  int organizationId;

  /// Organization for multi-tenant.
  _i2.Organization? organization;

  /// Tags as JSON (e.g., GMP, Sterility).
  String? tagsJson;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuestionBank]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuestionBank copyWith({
    int? id,
    String? name,
    int? organizationId,
    _i2.Organization? organization,
    String? tagsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionBank',
      if (id != null) 'id': id,
      'name': name,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      if (tagsJson != null) 'tagsJson': tagsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuestionBank',
      if (id != null) 'id': id,
      'name': name,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (tagsJson != null) 'tagsJson': tagsJson,
    };
  }

  static QuestionBankInclude include({_i2.OrganizationInclude? organization}) {
    return QuestionBankInclude._(organization: organization);
  }

  static QuestionBankIncludeList includeList({
    _i1.WhereExpressionBuilder<QuestionBankTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionBankTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionBankTable>? orderByList,
    QuestionBankInclude? include,
  }) {
    return QuestionBankIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuestionBank.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuestionBank.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionBankImpl extends QuestionBank {
  _QuestionBankImpl({
    int? id,
    required String name,
    required int organizationId,
    _i2.Organization? organization,
    String? tagsJson,
  }) : super._(
         id: id,
         name: name,
         organizationId: organizationId,
         organization: organization,
         tagsJson: tagsJson,
       );

  /// Returns a shallow copy of this [QuestionBank]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuestionBank copyWith({
    Object? id = _Undefined,
    String? name,
    int? organizationId,
    Object? organization = _Undefined,
    Object? tagsJson = _Undefined,
  }) {
    return QuestionBank(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      tagsJson: tagsJson is String? ? tagsJson : this.tagsJson,
    );
  }
}

class QuestionBankUpdateTable extends _i1.UpdateTable<QuestionBankTable> {
  QuestionBankUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> tagsJson(String? value) => _i1.ColumnValue(
    table.tagsJson,
    value,
  );
}

class QuestionBankTable extends _i1.Table<int?> {
  QuestionBankTable({super.tableRelation}) : super(tableName: 'question_bank') {
    updateTable = QuestionBankUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    tagsJson = _i1.ColumnString(
      'tagsJson',
      this,
    );
  }

  late final QuestionBankUpdateTable updateTable;

  /// Bank name.
  late final _i1.ColumnString name;

  late final _i1.ColumnInt organizationId;

  /// Organization for multi-tenant.
  _i2.OrganizationTable? _organization;

  /// Tags as JSON (e.g., GMP, Sterility).
  late final _i1.ColumnString tagsJson;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: QuestionBank.t.organizationId,
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
    name,
    organizationId,
    tagsJson,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class QuestionBankInclude extends _i1.IncludeObject {
  QuestionBankInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => QuestionBank.t;
}

class QuestionBankIncludeList extends _i1.IncludeList {
  QuestionBankIncludeList._({
    _i1.WhereExpressionBuilder<QuestionBankTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuestionBank.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuestionBank.t;
}

class QuestionBankRepository {
  const QuestionBankRepository._();

  final attachRow = const QuestionBankAttachRowRepository._();

  /// Returns a list of [QuestionBank]s matching the given query parameters.
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
  Future<List<QuestionBank>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuestionBankTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionBankTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionBankTable>? orderByList,
    _i1.Transaction? transaction,
    QuestionBankInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuestionBank>(
      where: where?.call(QuestionBank.t),
      orderBy: orderBy?.call(QuestionBank.t),
      orderByList: orderByList?.call(QuestionBank.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuestionBank] matching the given query parameters.
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
  Future<QuestionBank?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuestionBankTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuestionBankTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionBankTable>? orderByList,
    _i1.Transaction? transaction,
    QuestionBankInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuestionBank>(
      where: where?.call(QuestionBank.t),
      orderBy: orderBy?.call(QuestionBank.t),
      orderByList: orderByList?.call(QuestionBank.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuestionBank] by its [id] or null if no such row exists.
  Future<QuestionBank?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    QuestionBankInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuestionBank>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuestionBank]s in the list and returns the inserted rows.
  ///
  /// The returned [QuestionBank]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<QuestionBank>> insert(
    _i1.Session session,
    List<QuestionBank> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<QuestionBank>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [QuestionBank] and returns the inserted row.
  ///
  /// The returned [QuestionBank] will have its `id` field set.
  Future<QuestionBank> insertRow(
    _i1.Session session,
    QuestionBank row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuestionBank>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuestionBank]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuestionBank>> update(
    _i1.Session session,
    List<QuestionBank> rows, {
    _i1.ColumnSelections<QuestionBankTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuestionBank>(
      rows,
      columns: columns?.call(QuestionBank.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuestionBank]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuestionBank> updateRow(
    _i1.Session session,
    QuestionBank row, {
    _i1.ColumnSelections<QuestionBankTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuestionBank>(
      row,
      columns: columns?.call(QuestionBank.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuestionBank] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuestionBank?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<QuestionBankUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<QuestionBank>(
      id,
      columnValues: columnValues(QuestionBank.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuestionBank]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<QuestionBank>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<QuestionBankUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<QuestionBankTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionBankTable>? orderBy,
    _i1.OrderByListBuilder<QuestionBankTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<QuestionBank>(
      columnValues: columnValues(QuestionBank.t.updateTable),
      where: where(QuestionBank.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuestionBank.t),
      orderByList: orderByList?.call(QuestionBank.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [QuestionBank]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuestionBank>> delete(
    _i1.Session session,
    List<QuestionBank> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuestionBank>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuestionBank].
  Future<QuestionBank> deleteRow(
    _i1.Session session,
    QuestionBank row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuestionBank>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuestionBank>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuestionBankTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuestionBank>(
      where: where(QuestionBank.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuestionBankTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuestionBank>(
      where: where?.call(QuestionBank.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuestionBank] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuestionBankTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuestionBank>(
      where: where(QuestionBank.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class QuestionBankAttachRowRepository {
  const QuestionBankAttachRowRepository._();

  /// Creates a relation between the given [QuestionBank] and [Organization]
  /// by setting the [QuestionBank]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.Session session,
    QuestionBank questionBank,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (questionBank.id == null) {
      throw ArgumentError.notNull('questionBank.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $questionBank = questionBank.copyWith(organizationId: organization.id);
    await session.db.updateRow<QuestionBank>(
      $questionBank,
      columns: [QuestionBank.t.organizationId],
      transaction: transaction,
    );
  }
}
