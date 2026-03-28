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

/// Certificate template with HTML layout and merge fields.
abstract class CertificateTemplate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CertificateTemplate._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory CertificateTemplate({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) = _CertificateTemplateImpl;

  factory CertificateTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return CertificateTemplate(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      htmlTemplate: jsonSerialization['htmlTemplate'] as String,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CertificateTemplateTable();

  static const db = CertificateTemplateRepository._();

  @override
  int? id;

  int organizationId;

  /// Organization this template belongs to.
  _i2.Organization? organization;

  /// Template name.
  String name;

  /// HTML template with merge fields like {{learnerName}}, {{courseName}}, etc.
  String htmlTemplate;

  /// Whether this is the default template for the organization.
  bool isDefault;

  /// Created timestamp.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CertificateTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CertificateTemplate copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CertificateTemplate',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'htmlTemplate': htmlTemplate,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CertificateTemplate',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'htmlTemplate': htmlTemplate,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
    };
  }

  static CertificateTemplateInclude include({
    _i2.OrganizationInclude? organization,
  }) {
    return CertificateTemplateInclude._(organization: organization);
  }

  static CertificateTemplateIncludeList includeList({
    _i1.WhereExpressionBuilder<CertificateTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTemplateTable>? orderByList,
    CertificateTemplateInclude? include,
  }) {
    return CertificateTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CertificateTemplate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CertificateTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CertificateTemplateImpl extends CertificateTemplate {
  _CertificateTemplateImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         htmlTemplate: htmlTemplate,
         isDefault: isDefault,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CertificateTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CertificateTemplate copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return CertificateTemplate(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      htmlTemplate: htmlTemplate ?? this.htmlTemplate,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CertificateTemplateUpdateTable
    extends _i1.UpdateTable<CertificateTemplateTable> {
  CertificateTemplateUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> htmlTemplate(String value) => _i1.ColumnValue(
    table.htmlTemplate,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CertificateTemplateTable extends _i1.Table<int?> {
  CertificateTemplateTable({super.tableRelation})
    : super(tableName: 'certificate_template') {
    updateTable = CertificateTemplateUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    htmlTemplate = _i1.ColumnString(
      'htmlTemplate',
      this,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CertificateTemplateUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  /// Organization this template belongs to.
  _i2.OrganizationTable? _organization;

  /// Template name.
  late final _i1.ColumnString name;

  /// HTML template with merge fields like {{learnerName}}, {{courseName}}, etc.
  late final _i1.ColumnString htmlTemplate;

  /// Whether this is the default template for the organization.
  late final _i1.ColumnBool isDefault;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: CertificateTemplate.t.organizationId,
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
    htmlTemplate,
    isDefault,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class CertificateTemplateInclude extends _i1.IncludeObject {
  CertificateTemplateInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => CertificateTemplate.t;
}

class CertificateTemplateIncludeList extends _i1.IncludeList {
  CertificateTemplateIncludeList._({
    _i1.WhereExpressionBuilder<CertificateTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CertificateTemplate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CertificateTemplate.t;
}

class CertificateTemplateRepository {
  const CertificateTemplateRepository._();

  final attachRow = const CertificateTemplateAttachRowRepository._();

  /// Returns a list of [CertificateTemplate]s matching the given query parameters.
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
  Future<List<CertificateTemplate>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CertificateTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTemplateTable>? orderByList,
    _i1.Transaction? transaction,
    CertificateTemplateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CertificateTemplate>(
      where: where?.call(CertificateTemplate.t),
      orderBy: orderBy?.call(CertificateTemplate.t),
      orderByList: orderByList?.call(CertificateTemplate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CertificateTemplate] matching the given query parameters.
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
  Future<CertificateTemplate?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CertificateTemplateTable>? where,
    int? offset,
    _i1.OrderByBuilder<CertificateTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTemplateTable>? orderByList,
    _i1.Transaction? transaction,
    CertificateTemplateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CertificateTemplate>(
      where: where?.call(CertificateTemplate.t),
      orderBy: orderBy?.call(CertificateTemplate.t),
      orderByList: orderByList?.call(CertificateTemplate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CertificateTemplate] by its [id] or null if no such row exists.
  Future<CertificateTemplate?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CertificateTemplateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CertificateTemplate>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CertificateTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [CertificateTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CertificateTemplate>> insert(
    _i1.DatabaseSession session,
    List<CertificateTemplate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CertificateTemplate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CertificateTemplate] and returns the inserted row.
  ///
  /// The returned [CertificateTemplate] will have its `id` field set.
  Future<CertificateTemplate> insertRow(
    _i1.DatabaseSession session,
    CertificateTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CertificateTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CertificateTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CertificateTemplate>> update(
    _i1.DatabaseSession session,
    List<CertificateTemplate> rows, {
    _i1.ColumnSelections<CertificateTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CertificateTemplate>(
      rows,
      columns: columns?.call(CertificateTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CertificateTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CertificateTemplate> updateRow(
    _i1.DatabaseSession session,
    CertificateTemplate row, {
    _i1.ColumnSelections<CertificateTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CertificateTemplate>(
      row,
      columns: columns?.call(CertificateTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CertificateTemplate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CertificateTemplate?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CertificateTemplateUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CertificateTemplate>(
      id,
      columnValues: columnValues(CertificateTemplate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CertificateTemplate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CertificateTemplate>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CertificateTemplateUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CertificateTemplateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTemplateTable>? orderBy,
    _i1.OrderByListBuilder<CertificateTemplateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CertificateTemplate>(
      columnValues: columnValues(CertificateTemplate.t.updateTable),
      where: where(CertificateTemplate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CertificateTemplate.t),
      orderByList: orderByList?.call(CertificateTemplate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CertificateTemplate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CertificateTemplate>> delete(
    _i1.DatabaseSession session,
    List<CertificateTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CertificateTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CertificateTemplate].
  Future<CertificateTemplate> deleteRow(
    _i1.DatabaseSession session,
    CertificateTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CertificateTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CertificateTemplate>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CertificateTemplateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CertificateTemplate>(
      where: where(CertificateTemplate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CertificateTemplateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CertificateTemplate>(
      where: where?.call(CertificateTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CertificateTemplate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CertificateTemplateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CertificateTemplate>(
      where: where(CertificateTemplate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CertificateTemplateAttachRowRepository {
  const CertificateTemplateAttachRowRepository._();

  /// Creates a relation between the given [CertificateTemplate] and [Organization]
  /// by setting the [CertificateTemplate]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    CertificateTemplate certificateTemplate,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (certificateTemplate.id == null) {
      throw ArgumentError.notNull('certificateTemplate.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $certificateTemplate = certificateTemplate.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<CertificateTemplate>(
      $certificateTemplate,
      columns: [CertificateTemplate.t.organizationId],
      transaction: transaction,
    );
  }
}
