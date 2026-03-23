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
import '../audit/inspection_record.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Auditor session for time-limited read-only access. FDA 21 CFR Part 11.
abstract class AuditorSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AuditorSession._({
    this.id,
    required this.inspectionRecordId,
    this.inspectionRecord,
    this.auditorUserId,
    this.auditorUser,
    required this.accessType,
    this.accessToken,
    this.tokenIssuedAt,
    this.tokenExpiresAt,
    this.scopeStartDate,
    this.scopeEndDate,
    this.scopeSitesJson,
    this.scopeDepartmentsJson,
    bool? isActive,
    this.endedAt,
    this.endedReason,
    int? pagesViewedCount,
    this.lastActivityAt,
  }) : isActive = isActive ?? true,
       pagesViewedCount = pagesViewedCount ?? 0;

  factory AuditorSession({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? auditorUserId,
    _i3.PharmaUser? auditorUser,
    required String accessType,
    String? accessToken,
    DateTime? tokenIssuedAt,
    DateTime? tokenExpiresAt,
    DateTime? scopeStartDate,
    DateTime? scopeEndDate,
    String? scopeSitesJson,
    String? scopeDepartmentsJson,
    bool? isActive,
    DateTime? endedAt,
    String? endedReason,
    int? pagesViewedCount,
    DateTime? lastActivityAt,
  }) = _AuditorSessionImpl;

  factory AuditorSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditorSession(
      id: jsonSerialization['id'] as int?,
      inspectionRecordId: jsonSerialization['inspectionRecordId'] as int,
      inspectionRecord: jsonSerialization['inspectionRecord'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.InspectionRecord>(
              jsonSerialization['inspectionRecord'],
            ),
      auditorUserId: jsonSerialization['auditorUserId'] as int?,
      auditorUser: jsonSerialization['auditorUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['auditorUser'],
            ),
      accessType: jsonSerialization['accessType'] as String,
      accessToken: jsonSerialization['accessToken'] as String?,
      tokenIssuedAt: jsonSerialization['tokenIssuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['tokenIssuedAt'],
            ),
      tokenExpiresAt: jsonSerialization['tokenExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['tokenExpiresAt'],
            ),
      scopeStartDate: jsonSerialization['scopeStartDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scopeStartDate'],
            ),
      scopeEndDate: jsonSerialization['scopeEndDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scopeEndDate'],
            ),
      scopeSitesJson: jsonSerialization['scopeSitesJson'] as String?,
      scopeDepartmentsJson:
          jsonSerialization['scopeDepartmentsJson'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      endedReason: jsonSerialization['endedReason'] as String?,
      pagesViewedCount: jsonSerialization['pagesViewedCount'] as int?,
      lastActivityAt: jsonSerialization['lastActivityAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActivityAt'],
            ),
    );
  }

  static final t = AuditorSessionTable();

  static const db = AuditorSessionRepository._();

  @override
  int? id;

  int inspectionRecordId;

  /// The inspection record.
  _i2.InspectionRecord? inspectionRecord;

  int? auditorUserId;

  /// Auditor user.
  _i3.PharmaUser? auditorUser;

  /// Access type: internal, external_fda, external_ema, customer.
  String accessType;

  /// Hashed access token.
  String? accessToken;

  /// When token was issued.
  DateTime? tokenIssuedAt;

  /// When token expires.
  DateTime? tokenExpiresAt;

  /// Scope start date.
  DateTime? scopeStartDate;

  /// Scope end date.
  DateTime? scopeEndDate;

  /// Scope sites as JSON array.
  String? scopeSitesJson;

  /// Scope departments as JSON array.
  String? scopeDepartmentsJson;

  /// Whether session is active.
  bool isActive;

  /// When session ended.
  DateTime? endedAt;

  /// End reason: expired, manual_revoke, completed.
  String? endedReason;

  /// Pages viewed count.
  int pagesViewedCount;

  /// Last activity timestamp.
  DateTime? lastActivityAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditorSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditorSession copyWith({
    int? id,
    int? inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? auditorUserId,
    _i3.PharmaUser? auditorUser,
    String? accessType,
    String? accessToken,
    DateTime? tokenIssuedAt,
    DateTime? tokenExpiresAt,
    DateTime? scopeStartDate,
    DateTime? scopeEndDate,
    String? scopeSitesJson,
    String? scopeDepartmentsJson,
    bool? isActive,
    DateTime? endedAt,
    String? endedReason,
    int? pagesViewedCount,
    DateTime? lastActivityAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditorSession',
      if (id != null) 'id': id,
      'inspectionRecordId': inspectionRecordId,
      if (inspectionRecord != null)
        'inspectionRecord': inspectionRecord?.toJson(),
      if (auditorUserId != null) 'auditorUserId': auditorUserId,
      if (auditorUser != null) 'auditorUser': auditorUser?.toJson(),
      'accessType': accessType,
      if (accessToken != null) 'accessToken': accessToken,
      if (tokenIssuedAt != null) 'tokenIssuedAt': tokenIssuedAt?.toJson(),
      if (tokenExpiresAt != null) 'tokenExpiresAt': tokenExpiresAt?.toJson(),
      if (scopeStartDate != null) 'scopeStartDate': scopeStartDate?.toJson(),
      if (scopeEndDate != null) 'scopeEndDate': scopeEndDate?.toJson(),
      if (scopeSitesJson != null) 'scopeSitesJson': scopeSitesJson,
      if (scopeDepartmentsJson != null)
        'scopeDepartmentsJson': scopeDepartmentsJson,
      'isActive': isActive,
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (endedReason != null) 'endedReason': endedReason,
      'pagesViewedCount': pagesViewedCount,
      if (lastActivityAt != null) 'lastActivityAt': lastActivityAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditorSession',
      if (id != null) 'id': id,
      'inspectionRecordId': inspectionRecordId,
      if (inspectionRecord != null)
        'inspectionRecord': inspectionRecord?.toJsonForProtocol(),
      if (auditorUserId != null) 'auditorUserId': auditorUserId,
      if (auditorUser != null) 'auditorUser': auditorUser?.toJsonForProtocol(),
      'accessType': accessType,
      if (accessToken != null) 'accessToken': accessToken,
      if (tokenIssuedAt != null) 'tokenIssuedAt': tokenIssuedAt?.toJson(),
      if (tokenExpiresAt != null) 'tokenExpiresAt': tokenExpiresAt?.toJson(),
      if (scopeStartDate != null) 'scopeStartDate': scopeStartDate?.toJson(),
      if (scopeEndDate != null) 'scopeEndDate': scopeEndDate?.toJson(),
      if (scopeSitesJson != null) 'scopeSitesJson': scopeSitesJson,
      if (scopeDepartmentsJson != null)
        'scopeDepartmentsJson': scopeDepartmentsJson,
      'isActive': isActive,
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (endedReason != null) 'endedReason': endedReason,
      'pagesViewedCount': pagesViewedCount,
      if (lastActivityAt != null) 'lastActivityAt': lastActivityAt?.toJson(),
    };
  }

  static AuditorSessionInclude include({
    _i2.InspectionRecordInclude? inspectionRecord,
    _i3.PharmaUserInclude? auditorUser,
  }) {
    return AuditorSessionInclude._(
      inspectionRecord: inspectionRecord,
      auditorUser: auditorUser,
    );
  }

  static AuditorSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<AuditorSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditorSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditorSessionTable>? orderByList,
    AuditorSessionInclude? include,
  }) {
    return AuditorSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditorSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AuditorSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditorSessionImpl extends AuditorSession {
  _AuditorSessionImpl({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? auditorUserId,
    _i3.PharmaUser? auditorUser,
    required String accessType,
    String? accessToken,
    DateTime? tokenIssuedAt,
    DateTime? tokenExpiresAt,
    DateTime? scopeStartDate,
    DateTime? scopeEndDate,
    String? scopeSitesJson,
    String? scopeDepartmentsJson,
    bool? isActive,
    DateTime? endedAt,
    String? endedReason,
    int? pagesViewedCount,
    DateTime? lastActivityAt,
  }) : super._(
         id: id,
         inspectionRecordId: inspectionRecordId,
         inspectionRecord: inspectionRecord,
         auditorUserId: auditorUserId,
         auditorUser: auditorUser,
         accessType: accessType,
         accessToken: accessToken,
         tokenIssuedAt: tokenIssuedAt,
         tokenExpiresAt: tokenExpiresAt,
         scopeStartDate: scopeStartDate,
         scopeEndDate: scopeEndDate,
         scopeSitesJson: scopeSitesJson,
         scopeDepartmentsJson: scopeDepartmentsJson,
         isActive: isActive,
         endedAt: endedAt,
         endedReason: endedReason,
         pagesViewedCount: pagesViewedCount,
         lastActivityAt: lastActivityAt,
       );

  /// Returns a shallow copy of this [AuditorSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditorSession copyWith({
    Object? id = _Undefined,
    int? inspectionRecordId,
    Object? inspectionRecord = _Undefined,
    Object? auditorUserId = _Undefined,
    Object? auditorUser = _Undefined,
    String? accessType,
    Object? accessToken = _Undefined,
    Object? tokenIssuedAt = _Undefined,
    Object? tokenExpiresAt = _Undefined,
    Object? scopeStartDate = _Undefined,
    Object? scopeEndDate = _Undefined,
    Object? scopeSitesJson = _Undefined,
    Object? scopeDepartmentsJson = _Undefined,
    bool? isActive,
    Object? endedAt = _Undefined,
    Object? endedReason = _Undefined,
    int? pagesViewedCount,
    Object? lastActivityAt = _Undefined,
  }) {
    return AuditorSession(
      id: id is int? ? id : this.id,
      inspectionRecordId: inspectionRecordId ?? this.inspectionRecordId,
      inspectionRecord: inspectionRecord is _i2.InspectionRecord?
          ? inspectionRecord
          : this.inspectionRecord?.copyWith(),
      auditorUserId: auditorUserId is int? ? auditorUserId : this.auditorUserId,
      auditorUser: auditorUser is _i3.PharmaUser?
          ? auditorUser
          : this.auditorUser?.copyWith(),
      accessType: accessType ?? this.accessType,
      accessToken: accessToken is String? ? accessToken : this.accessToken,
      tokenIssuedAt: tokenIssuedAt is DateTime?
          ? tokenIssuedAt
          : this.tokenIssuedAt,
      tokenExpiresAt: tokenExpiresAt is DateTime?
          ? tokenExpiresAt
          : this.tokenExpiresAt,
      scopeStartDate: scopeStartDate is DateTime?
          ? scopeStartDate
          : this.scopeStartDate,
      scopeEndDate: scopeEndDate is DateTime?
          ? scopeEndDate
          : this.scopeEndDate,
      scopeSitesJson: scopeSitesJson is String?
          ? scopeSitesJson
          : this.scopeSitesJson,
      scopeDepartmentsJson: scopeDepartmentsJson is String?
          ? scopeDepartmentsJson
          : this.scopeDepartmentsJson,
      isActive: isActive ?? this.isActive,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      endedReason: endedReason is String? ? endedReason : this.endedReason,
      pagesViewedCount: pagesViewedCount ?? this.pagesViewedCount,
      lastActivityAt: lastActivityAt is DateTime?
          ? lastActivityAt
          : this.lastActivityAt,
    );
  }
}

class AuditorSessionUpdateTable extends _i1.UpdateTable<AuditorSessionTable> {
  AuditorSessionUpdateTable(super.table);

  _i1.ColumnValue<int, int> inspectionRecordId(int value) => _i1.ColumnValue(
    table.inspectionRecordId,
    value,
  );

  _i1.ColumnValue<int, int> auditorUserId(int? value) => _i1.ColumnValue(
    table.auditorUserId,
    value,
  );

  _i1.ColumnValue<String, String> accessType(String value) => _i1.ColumnValue(
    table.accessType,
    value,
  );

  _i1.ColumnValue<String, String> accessToken(String? value) => _i1.ColumnValue(
    table.accessToken,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> tokenIssuedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.tokenIssuedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> tokenExpiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.tokenExpiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> scopeStartDate(DateTime? value) =>
      _i1.ColumnValue(
        table.scopeStartDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> scopeEndDate(DateTime? value) =>
      _i1.ColumnValue(
        table.scopeEndDate,
        value,
      );

  _i1.ColumnValue<String, String> scopeSitesJson(String? value) =>
      _i1.ColumnValue(
        table.scopeSitesJson,
        value,
      );

  _i1.ColumnValue<String, String> scopeDepartmentsJson(String? value) =>
      _i1.ColumnValue(
        table.scopeDepartmentsJson,
        value,
      );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.endedAt,
        value,
      );

  _i1.ColumnValue<String, String> endedReason(String? value) => _i1.ColumnValue(
    table.endedReason,
    value,
  );

  _i1.ColumnValue<int, int> pagesViewedCount(int value) => _i1.ColumnValue(
    table.pagesViewedCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastActivityAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastActivityAt,
        value,
      );
}

class AuditorSessionTable extends _i1.Table<int?> {
  AuditorSessionTable({super.tableRelation})
    : super(tableName: 'auditor_session') {
    updateTable = AuditorSessionUpdateTable(this);
    inspectionRecordId = _i1.ColumnInt(
      'inspectionRecordId',
      this,
    );
    auditorUserId = _i1.ColumnInt(
      'auditorUserId',
      this,
    );
    accessType = _i1.ColumnString(
      'accessType',
      this,
    );
    accessToken = _i1.ColumnString(
      'accessToken',
      this,
    );
    tokenIssuedAt = _i1.ColumnDateTime(
      'tokenIssuedAt',
      this,
    );
    tokenExpiresAt = _i1.ColumnDateTime(
      'tokenExpiresAt',
      this,
    );
    scopeStartDate = _i1.ColumnDateTime(
      'scopeStartDate',
      this,
    );
    scopeEndDate = _i1.ColumnDateTime(
      'scopeEndDate',
      this,
    );
    scopeSitesJson = _i1.ColumnString(
      'scopeSitesJson',
      this,
    );
    scopeDepartmentsJson = _i1.ColumnString(
      'scopeDepartmentsJson',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    endedAt = _i1.ColumnDateTime(
      'endedAt',
      this,
    );
    endedReason = _i1.ColumnString(
      'endedReason',
      this,
    );
    pagesViewedCount = _i1.ColumnInt(
      'pagesViewedCount',
      this,
      hasDefault: true,
    );
    lastActivityAt = _i1.ColumnDateTime(
      'lastActivityAt',
      this,
    );
  }

  late final AuditorSessionUpdateTable updateTable;

  late final _i1.ColumnInt inspectionRecordId;

  /// The inspection record.
  _i2.InspectionRecordTable? _inspectionRecord;

  late final _i1.ColumnInt auditorUserId;

  /// Auditor user.
  _i3.PharmaUserTable? _auditorUser;

  /// Access type: internal, external_fda, external_ema, customer.
  late final _i1.ColumnString accessType;

  /// Hashed access token.
  late final _i1.ColumnString accessToken;

  /// When token was issued.
  late final _i1.ColumnDateTime tokenIssuedAt;

  /// When token expires.
  late final _i1.ColumnDateTime tokenExpiresAt;

  /// Scope start date.
  late final _i1.ColumnDateTime scopeStartDate;

  /// Scope end date.
  late final _i1.ColumnDateTime scopeEndDate;

  /// Scope sites as JSON array.
  late final _i1.ColumnString scopeSitesJson;

  /// Scope departments as JSON array.
  late final _i1.ColumnString scopeDepartmentsJson;

  /// Whether session is active.
  late final _i1.ColumnBool isActive;

  /// When session ended.
  late final _i1.ColumnDateTime endedAt;

  /// End reason: expired, manual_revoke, completed.
  late final _i1.ColumnString endedReason;

  /// Pages viewed count.
  late final _i1.ColumnInt pagesViewedCount;

  /// Last activity timestamp.
  late final _i1.ColumnDateTime lastActivityAt;

  _i2.InspectionRecordTable get inspectionRecord {
    if (_inspectionRecord != null) return _inspectionRecord!;
    _inspectionRecord = _i1.createRelationTable(
      relationFieldName: 'inspectionRecord',
      field: AuditorSession.t.inspectionRecordId,
      foreignField: _i2.InspectionRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.InspectionRecordTable(tableRelation: foreignTableRelation),
    );
    return _inspectionRecord!;
  }

  _i3.PharmaUserTable get auditorUser {
    if (_auditorUser != null) return _auditorUser!;
    _auditorUser = _i1.createRelationTable(
      relationFieldName: 'auditorUser',
      field: AuditorSession.t.auditorUserId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _auditorUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    inspectionRecordId,
    auditorUserId,
    accessType,
    accessToken,
    tokenIssuedAt,
    tokenExpiresAt,
    scopeStartDate,
    scopeEndDate,
    scopeSitesJson,
    scopeDepartmentsJson,
    isActive,
    endedAt,
    endedReason,
    pagesViewedCount,
    lastActivityAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'inspectionRecord') {
      return inspectionRecord;
    }
    if (relationField == 'auditorUser') {
      return auditorUser;
    }
    return null;
  }
}

class AuditorSessionInclude extends _i1.IncludeObject {
  AuditorSessionInclude._({
    _i2.InspectionRecordInclude? inspectionRecord,
    _i3.PharmaUserInclude? auditorUser,
  }) {
    _inspectionRecord = inspectionRecord;
    _auditorUser = auditorUser;
  }

  _i2.InspectionRecordInclude? _inspectionRecord;

  _i3.PharmaUserInclude? _auditorUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'inspectionRecord': _inspectionRecord,
    'auditorUser': _auditorUser,
  };

  @override
  _i1.Table<int?> get table => AuditorSession.t;
}

class AuditorSessionIncludeList extends _i1.IncludeList {
  AuditorSessionIncludeList._({
    _i1.WhereExpressionBuilder<AuditorSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditorSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AuditorSession.t;
}

class AuditorSessionRepository {
  const AuditorSessionRepository._();

  final attachRow = const AuditorSessionAttachRowRepository._();

  final detachRow = const AuditorSessionDetachRowRepository._();

  /// Returns a list of [AuditorSession]s matching the given query parameters.
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
  Future<List<AuditorSession>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditorSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditorSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditorSessionTable>? orderByList,
    _i1.Transaction? transaction,
    AuditorSessionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditorSession>(
      where: where?.call(AuditorSession.t),
      orderBy: orderBy?.call(AuditorSession.t),
      orderByList: orderByList?.call(AuditorSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditorSession] matching the given query parameters.
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
  Future<AuditorSession?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditorSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AuditorSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditorSessionTable>? orderByList,
    _i1.Transaction? transaction,
    AuditorSessionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditorSession>(
      where: where?.call(AuditorSession.t),
      orderBy: orderBy?.call(AuditorSession.t),
      orderByList: orderByList?.call(AuditorSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditorSession] by its [id] or null if no such row exists.
  Future<AuditorSession?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AuditorSessionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditorSession>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditorSession]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditorSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AuditorSession>> insert(
    _i1.DatabaseSession session,
    List<AuditorSession> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AuditorSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AuditorSession] and returns the inserted row.
  ///
  /// The returned [AuditorSession] will have its `id` field set.
  Future<AuditorSession> insertRow(
    _i1.DatabaseSession session,
    AuditorSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditorSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AuditorSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AuditorSession>> update(
    _i1.DatabaseSession session,
    List<AuditorSession> rows, {
    _i1.ColumnSelections<AuditorSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AuditorSession>(
      rows,
      columns: columns?.call(AuditorSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditorSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditorSession> updateRow(
    _i1.DatabaseSession session,
    AuditorSession row, {
    _i1.ColumnSelections<AuditorSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditorSession>(
      row,
      columns: columns?.call(AuditorSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditorSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditorSession?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AuditorSessionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditorSession>(
      id,
      columnValues: columnValues(AuditorSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditorSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AuditorSession>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AuditorSessionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AuditorSessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditorSessionTable>? orderBy,
    _i1.OrderByListBuilder<AuditorSessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AuditorSession>(
      columnValues: columnValues(AuditorSession.t.updateTable),
      where: where(AuditorSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditorSession.t),
      orderByList: orderByList?.call(AuditorSession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AuditorSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AuditorSession>> delete(
    _i1.DatabaseSession session,
    List<AuditorSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AuditorSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AuditorSession].
  Future<AuditorSession> deleteRow(
    _i1.DatabaseSession session,
    AuditorSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditorSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AuditorSession>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditorSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AuditorSession>(
      where: where(AuditorSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditorSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AuditorSession>(
      where: where?.call(AuditorSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditorSession] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditorSessionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditorSession>(
      where: where(AuditorSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AuditorSessionAttachRowRepository {
  const AuditorSessionAttachRowRepository._();

  /// Creates a relation between the given [AuditorSession] and [InspectionRecord]
  /// by setting the [AuditorSession]'s foreign key `inspectionRecordId` to refer to the [InspectionRecord].
  Future<void> inspectionRecord(
    _i1.DatabaseSession session,
    AuditorSession auditorSession,
    _i2.InspectionRecord inspectionRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (auditorSession.id == null) {
      throw ArgumentError.notNull('auditorSession.id');
    }
    if (inspectionRecord.id == null) {
      throw ArgumentError.notNull('inspectionRecord.id');
    }

    var $auditorSession = auditorSession.copyWith(
      inspectionRecordId: inspectionRecord.id,
    );
    await session.db.updateRow<AuditorSession>(
      $auditorSession,
      columns: [AuditorSession.t.inspectionRecordId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AuditorSession] and [PharmaUser]
  /// by setting the [AuditorSession]'s foreign key `auditorUserId` to refer to the [PharmaUser].
  Future<void> auditorUser(
    _i1.DatabaseSession session,
    AuditorSession auditorSession,
    _i3.PharmaUser auditorUser, {
    _i1.Transaction? transaction,
  }) async {
    if (auditorSession.id == null) {
      throw ArgumentError.notNull('auditorSession.id');
    }
    if (auditorUser.id == null) {
      throw ArgumentError.notNull('auditorUser.id');
    }

    var $auditorSession = auditorSession.copyWith(
      auditorUserId: auditorUser.id,
    );
    await session.db.updateRow<AuditorSession>(
      $auditorSession,
      columns: [AuditorSession.t.auditorUserId],
      transaction: transaction,
    );
  }
}

class AuditorSessionDetachRowRepository {
  const AuditorSessionDetachRowRepository._();

  /// Detaches the relation between this [AuditorSession] and the [PharmaUser] set in `auditorUser`
  /// by setting the [AuditorSession]'s foreign key `auditorUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> auditorUser(
    _i1.DatabaseSession session,
    AuditorSession auditorSession, {
    _i1.Transaction? transaction,
  }) async {
    if (auditorSession.id == null) {
      throw ArgumentError.notNull('auditorSession.id');
    }

    var $auditorSession = auditorSession.copyWith(auditorUserId: null);
    await session.db.updateRow<AuditorSession>(
      $auditorSession,
      columns: [AuditorSession.t.auditorUserId],
      transaction: transaction,
    );
  }
}
