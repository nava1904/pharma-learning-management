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

/// Validated space / cleanroom / training room for ILT capacity control.
abstract class Facility
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Facility._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.code,
    int? maxCapacity,
    bool? isValidatedSpace,
  }) : maxCapacity = maxCapacity ?? 10,
       isValidatedSpace = isValidatedSpace ?? false;

  factory Facility({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    int? maxCapacity,
    bool? isValidatedSpace,
  }) = _FacilityImpl;

  factory Facility.fromJson(Map<String, dynamic> jsonSerialization) {
    return Facility(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      maxCapacity: jsonSerialization['maxCapacity'] as int?,
      isValidatedSpace: jsonSerialization['isValidatedSpace'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['isValidatedSpace'],
            ),
    );
  }

  static final t = FacilityTable();

  static const db = FacilityRepository._();

  @override
  int? id;

  int organizationId;

  _i2.Organization? organization;

  String name;

  String code;

  int maxCapacity;

  bool? isValidatedSpace;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Facility copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? code,
    int? maxCapacity,
    bool? isValidatedSpace,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'code': code,
      'maxCapacity': maxCapacity,
      if (isValidatedSpace != null) 'isValidatedSpace': isValidatedSpace,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'code': code,
      'maxCapacity': maxCapacity,
      if (isValidatedSpace != null) 'isValidatedSpace': isValidatedSpace,
    };
  }

  static FacilityInclude include({_i2.OrganizationInclude? organization}) {
    return FacilityInclude._(organization: organization);
  }

  static FacilityIncludeList includeList({
    _i1.WhereExpressionBuilder<FacilityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FacilityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FacilityTable>? orderByList,
    FacilityInclude? include,
  }) {
    return FacilityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Facility.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Facility.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityImpl extends Facility {
  _FacilityImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String code,
    int? maxCapacity,
    bool? isValidatedSpace,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         code: code,
         maxCapacity: maxCapacity,
         isValidatedSpace: isValidatedSpace,
       );

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Facility copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? code,
    int? maxCapacity,
    Object? isValidatedSpace = _Undefined,
  }) {
    return Facility(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      code: code ?? this.code,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      isValidatedSpace: isValidatedSpace is bool?
          ? isValidatedSpace
          : this.isValidatedSpace,
    );
  }
}

class FacilityUpdateTable extends _i1.UpdateTable<FacilityTable> {
  FacilityUpdateTable(super.table);

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

  _i1.ColumnValue<int, int> maxCapacity(int value) => _i1.ColumnValue(
    table.maxCapacity,
    value,
  );

  _i1.ColumnValue<bool, bool> isValidatedSpace(bool? value) => _i1.ColumnValue(
    table.isValidatedSpace,
    value,
  );
}

class FacilityTable extends _i1.Table<int?> {
  FacilityTable({super.tableRelation}) : super(tableName: 'facility') {
    updateTable = FacilityUpdateTable(this);
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
    maxCapacity = _i1.ColumnInt(
      'maxCapacity',
      this,
      hasDefault: true,
    );
    isValidatedSpace = _i1.ColumnBool(
      'isValidatedSpace',
      this,
      hasDefault: true,
    );
  }

  late final FacilityUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString name;

  late final _i1.ColumnString code;

  late final _i1.ColumnInt maxCapacity;

  late final _i1.ColumnBool isValidatedSpace;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Facility.t.organizationId,
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
    maxCapacity,
    isValidatedSpace,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class FacilityInclude extends _i1.IncludeObject {
  FacilityInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Facility.t;
}

class FacilityIncludeList extends _i1.IncludeList {
  FacilityIncludeList._({
    _i1.WhereExpressionBuilder<FacilityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Facility.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Facility.t;
}

class FacilityRepository {
  const FacilityRepository._();

  final attachRow = const FacilityAttachRowRepository._();

  /// Returns a list of [Facility]s matching the given query parameters.
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
  Future<List<Facility>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FacilityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FacilityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FacilityTable>? orderByList,
    _i1.Transaction? transaction,
    FacilityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Facility>(
      where: where?.call(Facility.t),
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Facility] matching the given query parameters.
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
  Future<Facility?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FacilityTable>? where,
    int? offset,
    _i1.OrderByBuilder<FacilityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FacilityTable>? orderByList,
    _i1.Transaction? transaction,
    FacilityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Facility>(
      where: where?.call(Facility.t),
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Facility] by its [id] or null if no such row exists.
  Future<Facility?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    FacilityInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Facility>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Facility]s in the list and returns the inserted rows.
  ///
  /// The returned [Facility]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Facility>> insert(
    _i1.DatabaseSession session,
    List<Facility> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Facility>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Facility] and returns the inserted row.
  ///
  /// The returned [Facility] will have its `id` field set.
  Future<Facility> insertRow(
    _i1.DatabaseSession session,
    Facility row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Facility>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Facility]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Facility>> update(
    _i1.DatabaseSession session,
    List<Facility> rows, {
    _i1.ColumnSelections<FacilityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Facility>(
      rows,
      columns: columns?.call(Facility.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Facility]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Facility> updateRow(
    _i1.DatabaseSession session,
    Facility row, {
    _i1.ColumnSelections<FacilityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Facility>(
      row,
      columns: columns?.call(Facility.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Facility] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Facility?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FacilityUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Facility>(
      id,
      columnValues: columnValues(Facility.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Facility]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Facility>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FacilityUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FacilityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FacilityTable>? orderBy,
    _i1.OrderByListBuilder<FacilityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Facility>(
      columnValues: columnValues(Facility.t.updateTable),
      where: where(Facility.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Facility.t),
      orderByList: orderByList?.call(Facility.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Facility]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Facility>> delete(
    _i1.DatabaseSession session,
    List<Facility> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Facility>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Facility].
  Future<Facility> deleteRow(
    _i1.DatabaseSession session,
    Facility row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Facility>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Facility>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FacilityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Facility>(
      where: where(Facility.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FacilityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Facility>(
      where: where?.call(Facility.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Facility] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FacilityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Facility>(
      where: where(Facility.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FacilityAttachRowRepository {
  const FacilityAttachRowRepository._();

  /// Creates a relation between the given [Facility] and [Organization]
  /// by setting the [Facility]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Facility facility,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (facility.id == null) {
      throw ArgumentError.notNull('facility.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $facility = facility.copyWith(organizationId: organization.id);
    await session.db.updateRow<Facility>(
      $facility,
      columns: [Facility.t.organizationId],
      transaction: transaction,
    );
  }
}
