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

/// Groups courses into a named curriculum (credit / requirements roadmap).
abstract class Curriculum
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Curriculum._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.code,
    this.description,
  });

  factory Curriculum({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? description,
  }) = _CurriculumImpl;

  factory Curriculum.fromJson(Map<String, dynamic> jsonSerialization) {
    return Curriculum(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      description: jsonSerialization['description'] as String?,
    );
  }

  static final t = CurriculumTable();

  static const db = CurriculumRepository._();

  @override
  int? id;

  int organizationId;

  _i2.Organization? organization;

  String name;

  String code;

  String? description;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Curriculum]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Curriculum copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? code,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Curriculum',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'code': code,
      if (description != null) 'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Curriculum',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'code': code,
      if (description != null) 'description': description,
    };
  }

  static CurriculumInclude include({_i2.OrganizationInclude? organization}) {
    return CurriculumInclude._(organization: organization);
  }

  static CurriculumIncludeList includeList({
    _i1.WhereExpressionBuilder<CurriculumTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurriculumTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurriculumTable>? orderByList,
    CurriculumInclude? include,
  }) {
    return CurriculumIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Curriculum.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Curriculum.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurriculumImpl extends Curriculum {
  _CurriculumImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    String? description,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         code: code,
         description: description,
       );

  /// Returns a shallow copy of this [Curriculum]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Curriculum copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? code,
    Object? description = _Undefined,
  }) {
    return Curriculum(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      description: description is String? ? description : this.description,
    );
  }
}

class CurriculumUpdateTable extends _i1.UpdateTable<CurriculumTable> {
  CurriculumUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );
}

class CurriculumTable extends _i1.Table<int?> {
  CurriculumTable({super.tableRelation}) : super(tableName: 'curriculum') {
    updateTable = CurriculumUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
  }

  late final CurriculumUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString name;

  late final _i1.ColumnString code;

  late final _i1.ColumnString description;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Curriculum.t.organizationId,
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
    organizationId,
    name,
    code,
    description,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class CurriculumInclude extends _i1.IncludeObject {
  CurriculumInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Curriculum.t;
}

class CurriculumIncludeList extends _i1.IncludeList {
  CurriculumIncludeList._({
    _i1.WhereExpressionBuilder<CurriculumTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Curriculum.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Curriculum.t;
}

class CurriculumRepository {
  const CurriculumRepository._();

  final attachRow = const CurriculumAttachRowRepository._();

  /// Returns a list of [Curriculum]s matching the given query parameters.
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
  Future<List<Curriculum>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CurriculumTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurriculumTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurriculumTable>? orderByList,
    _i1.Transaction? transaction,
    CurriculumInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Curriculum>(
      where: where?.call(Curriculum.t),
      orderBy: orderBy?.call(Curriculum.t),
      orderByList: orderByList?.call(Curriculum.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Curriculum] matching the given query parameters.
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
  Future<Curriculum?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CurriculumTable>? where,
    int? offset,
    _i1.OrderByBuilder<CurriculumTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurriculumTable>? orderByList,
    _i1.Transaction? transaction,
    CurriculumInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Curriculum>(
      where: where?.call(Curriculum.t),
      orderBy: orderBy?.call(Curriculum.t),
      orderByList: orderByList?.call(Curriculum.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Curriculum] by its [id] or null if no such row exists.
  Future<Curriculum?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CurriculumInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Curriculum>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Curriculum]s in the list and returns the inserted rows.
  ///
  /// The returned [Curriculum]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Curriculum>> insert(
    _i1.DatabaseSession session,
    List<Curriculum> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Curriculum>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Curriculum] and returns the inserted row.
  ///
  /// The returned [Curriculum] will have its `id` field set.
  Future<Curriculum> insertRow(
    _i1.DatabaseSession session,
    Curriculum row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Curriculum>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Curriculum]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Curriculum>> update(
    _i1.DatabaseSession session,
    List<Curriculum> rows, {
    _i1.ColumnSelections<CurriculumTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Curriculum>(
      rows,
      columns: columns?.call(Curriculum.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Curriculum]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Curriculum> updateRow(
    _i1.DatabaseSession session,
    Curriculum row, {
    _i1.ColumnSelections<CurriculumTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Curriculum>(
      row,
      columns: columns?.call(Curriculum.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Curriculum] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Curriculum?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CurriculumUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Curriculum>(
      id,
      columnValues: columnValues(Curriculum.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Curriculum]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Curriculum>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CurriculumUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CurriculumTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurriculumTable>? orderBy,
    _i1.OrderByListBuilder<CurriculumTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Curriculum>(
      columnValues: columnValues(Curriculum.t.updateTable),
      where: where(Curriculum.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Curriculum.t),
      orderByList: orderByList?.call(Curriculum.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Curriculum]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Curriculum>> delete(
    _i1.DatabaseSession session,
    List<Curriculum> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Curriculum>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Curriculum].
  Future<Curriculum> deleteRow(
    _i1.DatabaseSession session,
    Curriculum row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Curriculum>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Curriculum>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CurriculumTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Curriculum>(
      where: where(Curriculum.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CurriculumTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Curriculum>(
      where: where?.call(Curriculum.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Curriculum] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CurriculumTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Curriculum>(
      where: where(Curriculum.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CurriculumAttachRowRepository {
  const CurriculumAttachRowRepository._();

  /// Creates a relation between the given [Curriculum] and [Organization]
  /// by setting the [Curriculum]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Curriculum curriculum,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (curriculum.id == null) {
      throw ArgumentError.notNull('curriculum.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $curriculum = curriculum.copyWith(organizationId: organization.id);
    await session.db.updateRow<Curriculum>(
      $curriculum,
      columns: [Curriculum.t.organizationId],
      transaction: transaction,
    );
  }
}
