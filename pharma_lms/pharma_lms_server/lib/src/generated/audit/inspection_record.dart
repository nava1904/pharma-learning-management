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
import '../organization/site.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Inspection record for auditor access. FDA 21 CFR Part 11.
abstract class InspectionRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InspectionRecord._({
    this.id,
    required this.inspectionType,
    this.scheduledDate,
    this.inspectorNames,
    this.scopeDescription,
    this.siteId,
    this.site,
    String? status,
    this.inspectionAccessToken,
    this.tokenExpiresAt,
    this.briefingPackHash,
    this.briefingPackGeneratedAt,
    this.outcome,
    this.findingsCount,
    this.createdById,
    this.createdBy,
    DateTime? createdAt,
  }) : status = status ?? 'scheduled',
       createdAt = createdAt ?? DateTime.now();

  factory InspectionRecord({
    int? id,
    required String inspectionType,
    DateTime? scheduledDate,
    String? inspectorNames,
    String? scopeDescription,
    int? siteId,
    _i2.Site? site,
    String? status,
    String? inspectionAccessToken,
    DateTime? tokenExpiresAt,
    String? briefingPackHash,
    DateTime? briefingPackGeneratedAt,
    String? outcome,
    int? findingsCount,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) = _InspectionRecordImpl;

  factory InspectionRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return InspectionRecord(
      id: jsonSerialization['id'] as int?,
      inspectionType: jsonSerialization['inspectionType'] as String,
      scheduledDate: jsonSerialization['scheduledDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledDate'],
            ),
      inspectorNames: jsonSerialization['inspectorNames'] as String?,
      scopeDescription: jsonSerialization['scopeDescription'] as String?,
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Site>(jsonSerialization['site']),
      status: jsonSerialization['status'] as String?,
      inspectionAccessToken:
          jsonSerialization['inspectionAccessToken'] as String?,
      tokenExpiresAt: jsonSerialization['tokenExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['tokenExpiresAt'],
            ),
      briefingPackHash: jsonSerialization['briefingPackHash'] as String?,
      briefingPackGeneratedAt:
          jsonSerialization['briefingPackGeneratedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['briefingPackGeneratedAt'],
            ),
      outcome: jsonSerialization['outcome'] as String?,
      findingsCount: jsonSerialization['findingsCount'] as int?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = InspectionRecordTable();

  static const db = InspectionRecordRepository._();

  @override
  int? id;

  /// Inspection type: fda, ema, internal, customer.
  String inspectionType;

  /// Scheduled date.
  DateTime? scheduledDate;

  /// Inspector names.
  String? inspectorNames;

  /// Scope description.
  String? scopeDescription;

  int? siteId;

  /// Site in scope.
  _i2.Site? site;

  /// Status: scheduled, in_progress, completed, follow_up.
  String status;

  /// Time-limited access token for auditor.
  String? inspectionAccessToken;

  /// When token expires.
  DateTime? tokenExpiresAt;

  /// Briefing pack hash.
  String? briefingPackHash;

  /// When briefing pack was generated.
  DateTime? briefingPackGeneratedAt;

  /// Outcome: no_findings, observations, warning_letter.
  String? outcome;

  /// Findings count.
  int? findingsCount;

  int? createdById;

  /// Who created this record.
  _i3.PharmaUser? createdBy;

  /// When created.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InspectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InspectionRecord copyWith({
    int? id,
    String? inspectionType,
    DateTime? scheduledDate,
    String? inspectorNames,
    String? scopeDescription,
    int? siteId,
    _i2.Site? site,
    String? status,
    String? inspectionAccessToken,
    DateTime? tokenExpiresAt,
    String? briefingPackHash,
    DateTime? briefingPackGeneratedAt,
    String? outcome,
    int? findingsCount,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InspectionRecord',
      if (id != null) 'id': id,
      'inspectionType': inspectionType,
      if (scheduledDate != null) 'scheduledDate': scheduledDate?.toJson(),
      if (inspectorNames != null) 'inspectorNames': inspectorNames,
      if (scopeDescription != null) 'scopeDescription': scopeDescription,
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'status': status,
      if (inspectionAccessToken != null)
        'inspectionAccessToken': inspectionAccessToken,
      if (tokenExpiresAt != null) 'tokenExpiresAt': tokenExpiresAt?.toJson(),
      if (briefingPackHash != null) 'briefingPackHash': briefingPackHash,
      if (briefingPackGeneratedAt != null)
        'briefingPackGeneratedAt': briefingPackGeneratedAt?.toJson(),
      if (outcome != null) 'outcome': outcome,
      if (findingsCount != null) 'findingsCount': findingsCount,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InspectionRecord',
      if (id != null) 'id': id,
      'inspectionType': inspectionType,
      if (scheduledDate != null) 'scheduledDate': scheduledDate?.toJson(),
      if (inspectorNames != null) 'inspectorNames': inspectorNames,
      if (scopeDescription != null) 'scopeDescription': scopeDescription,
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJsonForProtocol(),
      'status': status,
      if (inspectionAccessToken != null)
        'inspectionAccessToken': inspectionAccessToken,
      if (tokenExpiresAt != null) 'tokenExpiresAt': tokenExpiresAt?.toJson(),
      if (briefingPackHash != null) 'briefingPackHash': briefingPackHash,
      if (briefingPackGeneratedAt != null)
        'briefingPackGeneratedAt': briefingPackGeneratedAt?.toJson(),
      if (outcome != null) 'outcome': outcome,
      if (findingsCount != null) 'findingsCount': findingsCount,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static InspectionRecordInclude include({
    _i2.SiteInclude? site,
    _i3.PharmaUserInclude? createdBy,
  }) {
    return InspectionRecordInclude._(
      site: site,
      createdBy: createdBy,
    );
  }

  static InspectionRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<InspectionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionRecordTable>? orderByList,
    InspectionRecordInclude? include,
  }) {
    return InspectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InspectionRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InspectionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InspectionRecordImpl extends InspectionRecord {
  _InspectionRecordImpl({
    int? id,
    required String inspectionType,
    DateTime? scheduledDate,
    String? inspectorNames,
    String? scopeDescription,
    int? siteId,
    _i2.Site? site,
    String? status,
    String? inspectionAccessToken,
    DateTime? tokenExpiresAt,
    String? briefingPackHash,
    DateTime? briefingPackGeneratedAt,
    String? outcome,
    int? findingsCount,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         inspectionType: inspectionType,
         scheduledDate: scheduledDate,
         inspectorNames: inspectorNames,
         scopeDescription: scopeDescription,
         siteId: siteId,
         site: site,
         status: status,
         inspectionAccessToken: inspectionAccessToken,
         tokenExpiresAt: tokenExpiresAt,
         briefingPackHash: briefingPackHash,
         briefingPackGeneratedAt: briefingPackGeneratedAt,
         outcome: outcome,
         findingsCount: findingsCount,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [InspectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InspectionRecord copyWith({
    Object? id = _Undefined,
    String? inspectionType,
    Object? scheduledDate = _Undefined,
    Object? inspectorNames = _Undefined,
    Object? scopeDescription = _Undefined,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    String? status,
    Object? inspectionAccessToken = _Undefined,
    Object? tokenExpiresAt = _Undefined,
    Object? briefingPackHash = _Undefined,
    Object? briefingPackGeneratedAt = _Undefined,
    Object? outcome = _Undefined,
    Object? findingsCount = _Undefined,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
  }) {
    return InspectionRecord(
      id: id is int? ? id : this.id,
      inspectionType: inspectionType ?? this.inspectionType,
      scheduledDate: scheduledDate is DateTime?
          ? scheduledDate
          : this.scheduledDate,
      inspectorNames: inspectorNames is String?
          ? inspectorNames
          : this.inspectorNames,
      scopeDescription: scopeDescription is String?
          ? scopeDescription
          : this.scopeDescription,
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i2.Site? ? site : this.site?.copyWith(),
      status: status ?? this.status,
      inspectionAccessToken: inspectionAccessToken is String?
          ? inspectionAccessToken
          : this.inspectionAccessToken,
      tokenExpiresAt: tokenExpiresAt is DateTime?
          ? tokenExpiresAt
          : this.tokenExpiresAt,
      briefingPackHash: briefingPackHash is String?
          ? briefingPackHash
          : this.briefingPackHash,
      briefingPackGeneratedAt: briefingPackGeneratedAt is DateTime?
          ? briefingPackGeneratedAt
          : this.briefingPackGeneratedAt,
      outcome: outcome is String? ? outcome : this.outcome,
      findingsCount: findingsCount is int? ? findingsCount : this.findingsCount,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class InspectionRecordUpdateTable
    extends _i1.UpdateTable<InspectionRecordTable> {
  InspectionRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> inspectionType(String value) =>
      _i1.ColumnValue(
        table.inspectionType,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> scheduledDate(DateTime? value) =>
      _i1.ColumnValue(
        table.scheduledDate,
        value,
      );

  _i1.ColumnValue<String, String> inspectorNames(String? value) =>
      _i1.ColumnValue(
        table.inspectorNames,
        value,
      );

  _i1.ColumnValue<String, String> scopeDescription(String? value) =>
      _i1.ColumnValue(
        table.scopeDescription,
        value,
      );

  _i1.ColumnValue<int, int> siteId(int? value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> inspectionAccessToken(String? value) =>
      _i1.ColumnValue(
        table.inspectionAccessToken,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> tokenExpiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.tokenExpiresAt,
        value,
      );

  _i1.ColumnValue<String, String> briefingPackHash(String? value) =>
      _i1.ColumnValue(
        table.briefingPackHash,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> briefingPackGeneratedAt(
    DateTime? value,
  ) => _i1.ColumnValue(
    table.briefingPackGeneratedAt,
    value,
  );

  _i1.ColumnValue<String, String> outcome(String? value) => _i1.ColumnValue(
    table.outcome,
    value,
  );

  _i1.ColumnValue<int, int> findingsCount(int? value) => _i1.ColumnValue(
    table.findingsCount,
    value,
  );

  _i1.ColumnValue<int, int> createdById(int? value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class InspectionRecordTable extends _i1.Table<int?> {
  InspectionRecordTable({super.tableRelation})
    : super(tableName: 'inspection_record') {
    updateTable = InspectionRecordUpdateTable(this);
    inspectionType = _i1.ColumnString(
      'inspectionType',
      this,
    );
    scheduledDate = _i1.ColumnDateTime(
      'scheduledDate',
      this,
    );
    inspectorNames = _i1.ColumnString(
      'inspectorNames',
      this,
    );
    scopeDescription = _i1.ColumnString(
      'scopeDescription',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    inspectionAccessToken = _i1.ColumnString(
      'inspectionAccessToken',
      this,
    );
    tokenExpiresAt = _i1.ColumnDateTime(
      'tokenExpiresAt',
      this,
    );
    briefingPackHash = _i1.ColumnString(
      'briefingPackHash',
      this,
    );
    briefingPackGeneratedAt = _i1.ColumnDateTime(
      'briefingPackGeneratedAt',
      this,
    );
    outcome = _i1.ColumnString(
      'outcome',
      this,
    );
    findingsCount = _i1.ColumnInt(
      'findingsCount',
      this,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final InspectionRecordUpdateTable updateTable;

  /// Inspection type: fda, ema, internal, customer.
  late final _i1.ColumnString inspectionType;

  /// Scheduled date.
  late final _i1.ColumnDateTime scheduledDate;

  /// Inspector names.
  late final _i1.ColumnString inspectorNames;

  /// Scope description.
  late final _i1.ColumnString scopeDescription;

  late final _i1.ColumnInt siteId;

  /// Site in scope.
  _i2.SiteTable? _site;

  /// Status: scheduled, in_progress, completed, follow_up.
  late final _i1.ColumnString status;

  /// Time-limited access token for auditor.
  late final _i1.ColumnString inspectionAccessToken;

  /// When token expires.
  late final _i1.ColumnDateTime tokenExpiresAt;

  /// Briefing pack hash.
  late final _i1.ColumnString briefingPackHash;

  /// When briefing pack was generated.
  late final _i1.ColumnDateTime briefingPackGeneratedAt;

  /// Outcome: no_findings, observations, warning_letter.
  late final _i1.ColumnString outcome;

  /// Findings count.
  late final _i1.ColumnInt findingsCount;

  late final _i1.ColumnInt createdById;

  /// Who created this record.
  _i3.PharmaUserTable? _createdBy;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  _i2.SiteTable get site {
    if (_site != null) return _site!;
    _site = _i1.createRelationTable(
      relationFieldName: 'site',
      field: InspectionRecord.t.siteId,
      foreignField: _i2.Site.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SiteTable(tableRelation: foreignTableRelation),
    );
    return _site!;
  }

  _i3.PharmaUserTable get createdBy {
    if (_createdBy != null) return _createdBy!;
    _createdBy = _i1.createRelationTable(
      relationFieldName: 'createdBy',
      field: InspectionRecord.t.createdById,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _createdBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    inspectionType,
    scheduledDate,
    inspectorNames,
    scopeDescription,
    siteId,
    status,
    inspectionAccessToken,
    tokenExpiresAt,
    briefingPackHash,
    briefingPackGeneratedAt,
    outcome,
    findingsCount,
    createdById,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'site') {
      return site;
    }
    if (relationField == 'createdBy') {
      return createdBy;
    }
    return null;
  }
}

class InspectionRecordInclude extends _i1.IncludeObject {
  InspectionRecordInclude._({
    _i2.SiteInclude? site,
    _i3.PharmaUserInclude? createdBy,
  }) {
    _site = site;
    _createdBy = createdBy;
  }

  _i2.SiteInclude? _site;

  _i3.PharmaUserInclude? _createdBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'site': _site,
    'createdBy': _createdBy,
  };

  @override
  _i1.Table<int?> get table => InspectionRecord.t;
}

class InspectionRecordIncludeList extends _i1.IncludeList {
  InspectionRecordIncludeList._({
    _i1.WhereExpressionBuilder<InspectionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InspectionRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InspectionRecord.t;
}

class InspectionRecordRepository {
  const InspectionRecordRepository._();

  final attachRow = const InspectionRecordAttachRowRepository._();

  final detachRow = const InspectionRecordDetachRowRepository._();

  /// Returns a list of [InspectionRecord]s matching the given query parameters.
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
  Future<List<InspectionRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InspectionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    InspectionRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InspectionRecord>(
      where: where?.call(InspectionRecord.t),
      orderBy: orderBy?.call(InspectionRecord.t),
      orderByList: orderByList?.call(InspectionRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InspectionRecord] matching the given query parameters.
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
  Future<InspectionRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InspectionRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<InspectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    InspectionRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InspectionRecord>(
      where: where?.call(InspectionRecord.t),
      orderBy: orderBy?.call(InspectionRecord.t),
      orderByList: orderByList?.call(InspectionRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InspectionRecord] by its [id] or null if no such row exists.
  Future<InspectionRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    InspectionRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InspectionRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InspectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [InspectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<InspectionRecord>> insert(
    _i1.Session session,
    List<InspectionRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<InspectionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [InspectionRecord] and returns the inserted row.
  ///
  /// The returned [InspectionRecord] will have its `id` field set.
  Future<InspectionRecord> insertRow(
    _i1.Session session,
    InspectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InspectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InspectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InspectionRecord>> update(
    _i1.Session session,
    List<InspectionRecord> rows, {
    _i1.ColumnSelections<InspectionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InspectionRecord>(
      rows,
      columns: columns?.call(InspectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InspectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InspectionRecord> updateRow(
    _i1.Session session,
    InspectionRecord row, {
    _i1.ColumnSelections<InspectionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InspectionRecord>(
      row,
      columns: columns?.call(InspectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InspectionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InspectionRecord?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<InspectionRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<InspectionRecord>(
      id,
      columnValues: columnValues(InspectionRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InspectionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<InspectionRecord>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<InspectionRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<InspectionRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionRecordTable>? orderBy,
    _i1.OrderByListBuilder<InspectionRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<InspectionRecord>(
      columnValues: columnValues(InspectionRecord.t.updateTable),
      where: where(InspectionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InspectionRecord.t),
      orderByList: orderByList?.call(InspectionRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [InspectionRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InspectionRecord>> delete(
    _i1.Session session,
    List<InspectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InspectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InspectionRecord].
  Future<InspectionRecord> deleteRow(
    _i1.Session session,
    InspectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InspectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InspectionRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InspectionRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InspectionRecord>(
      where: where(InspectionRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InspectionRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InspectionRecord>(
      where: where?.call(InspectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InspectionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InspectionRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InspectionRecord>(
      where: where(InspectionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class InspectionRecordAttachRowRepository {
  const InspectionRecordAttachRowRepository._();

  /// Creates a relation between the given [InspectionRecord] and [Site]
  /// by setting the [InspectionRecord]'s foreign key `siteId` to refer to the [Site].
  Future<void> site(
    _i1.Session session,
    InspectionRecord inspectionRecord,
    _i2.Site site, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionRecord.id == null) {
      throw ArgumentError.notNull('inspectionRecord.id');
    }
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }

    var $inspectionRecord = inspectionRecord.copyWith(siteId: site.id);
    await session.db.updateRow<InspectionRecord>(
      $inspectionRecord,
      columns: [InspectionRecord.t.siteId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [InspectionRecord] and [PharmaUser]
  /// by setting the [InspectionRecord]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.Session session,
    InspectionRecord inspectionRecord,
    _i3.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionRecord.id == null) {
      throw ArgumentError.notNull('inspectionRecord.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $inspectionRecord = inspectionRecord.copyWith(
      createdById: createdBy.id,
    );
    await session.db.updateRow<InspectionRecord>(
      $inspectionRecord,
      columns: [InspectionRecord.t.createdById],
      transaction: transaction,
    );
  }
}

class InspectionRecordDetachRowRepository {
  const InspectionRecordDetachRowRepository._();

  /// Detaches the relation between this [InspectionRecord] and the [Site] set in `site`
  /// by setting the [InspectionRecord]'s foreign key `siteId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> site(
    _i1.Session session,
    InspectionRecord inspectionRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionRecord.id == null) {
      throw ArgumentError.notNull('inspectionRecord.id');
    }

    var $inspectionRecord = inspectionRecord.copyWith(siteId: null);
    await session.db.updateRow<InspectionRecord>(
      $inspectionRecord,
      columns: [InspectionRecord.t.siteId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [InspectionRecord] and the [PharmaUser] set in `createdBy`
  /// by setting the [InspectionRecord]'s foreign key `createdById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> createdBy(
    _i1.Session session,
    InspectionRecord inspectionRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionRecord.id == null) {
      throw ArgumentError.notNull('inspectionRecord.id');
    }

    var $inspectionRecord = inspectionRecord.copyWith(createdById: null);
    await session.db.updateRow<InspectionRecord>(
      $inspectionRecord,
      columns: [InspectionRecord.t.createdById],
      transaction: transaction,
    );
  }
}
