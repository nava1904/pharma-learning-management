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
import '../organization/user.dart' as _i2;
import '../organization/role.dart' as _i3;
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Access Review window and per-user review record
abstract class AccessReview
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AccessReview._({
    this.id,
    required this.windowId,
    required this.userId,
    this.user,
    required this.roleId,
    this.role,
    String? decision,
    this.justification,
    this.reviewedById,
    this.reviewedBy,
    this.reviewedAt,
    this.signedAt,
    this.signatureId,
    this.signature,
    required this.windowOpen,
    required this.windowClose,
    this.jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.migrationMarker,
  }) : decision = decision ?? 'PENDING',
       status = status ?? 'ACTIVE',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AccessReview({
    int? id,
    required int windowId,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    String? decision,
    String? justification,
    int? reviewedById,
    _i2.PharmaUser? reviewedBy,
    DateTime? reviewedAt,
    DateTime? signedAt,
    int? signatureId,
    _i4.ElectronicSignature? signature,
    required DateTime windowOpen,
    required DateTime windowClose,
    String? jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? migrationMarker,
  }) = _AccessReviewImpl;

  factory AccessReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessReview(
      id: jsonSerialization['id'] as int?,
      windowId: jsonSerialization['windowId'] as int,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Role>(jsonSerialization['role']),
      decision: jsonSerialization['decision'] as String?,
      justification: jsonSerialization['justification'] as String?,
      reviewedById: jsonSerialization['reviewedById'] as int?,
      reviewedBy: jsonSerialization['reviewedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['reviewedBy'],
            ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      signedAt: jsonSerialization['signedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['signedAt']),
      signatureId: jsonSerialization['signatureId'] as int?,
      signature: jsonSerialization['signature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['signature'],
            ),
      windowOpen: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowOpen'],
      ),
      windowClose: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowClose'],
      ),
      jobId: jsonSerialization['jobId'] as String?,
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      migrationMarker: jsonSerialization['migrationMarker'] as String?,
    );
  }

  static final t = AccessReviewTable();

  static const db = AccessReviewRepository._();

  @override
  int? id;

  /// The review window (foreign key to AccessReviewWindow)
  int windowId;

  int userId;

  /// The user under review
  _i2.PharmaUser? user;

  int roleId;

  /// The role being reviewed
  _i3.Role? role;

  /// Review decision (APPROVED, REVOKED, PENDING)
  String decision;

  /// Justification for the decision
  String? justification;

  int? reviewedById;

  /// Reviewer (admin) who made the decision
  _i2.PharmaUser? reviewedBy;

  /// Timestamp when reviewed
  DateTime? reviewedAt;

  /// Timestamp when signed (if e-signed)
  DateTime? signedAt;

  int? signatureId;

  /// E-signature record (if signed)
  _i4.ElectronicSignature? signature;

  /// Review window open date
  DateTime windowOpen;

  /// Review window close date
  DateTime windowClose;

  /// Triggering job ID (for audit)
  String? jobId;

  /// Status (ACTIVE, CLOSED)
  String status;

  /// Audit fields
  DateTime createdAt;

  DateTime updatedAt;

  /// Temporary migration marker - remove after migration applied
  String? migrationMarker;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccessReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessReview copyWith({
    int? id,
    int? windowId,
    int? userId,
    _i2.PharmaUser? user,
    int? roleId,
    _i3.Role? role,
    String? decision,
    String? justification,
    int? reviewedById,
    _i2.PharmaUser? reviewedBy,
    DateTime? reviewedAt,
    DateTime? signedAt,
    int? signatureId,
    _i4.ElectronicSignature? signature,
    DateTime? windowOpen,
    DateTime? windowClose,
    String? jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? migrationMarker,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessReview',
      if (id != null) 'id': id,
      'windowId': windowId,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
      'decision': decision,
      if (justification != null) 'justification': justification,
      if (reviewedById != null) 'reviewedById': reviewedById,
      if (reviewedBy != null) 'reviewedBy': reviewedBy?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (signedAt != null) 'signedAt': signedAt?.toJson(),
      if (signatureId != null) 'signatureId': signatureId,
      if (signature != null) 'signature': signature?.toJson(),
      'windowOpen': windowOpen.toJson(),
      'windowClose': windowClose.toJson(),
      if (jobId != null) 'jobId': jobId,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccessReview',
      if (id != null) 'id': id,
      'windowId': windowId,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJsonForProtocol(),
      'decision': decision,
      if (justification != null) 'justification': justification,
      if (reviewedById != null) 'reviewedById': reviewedById,
      if (reviewedBy != null) 'reviewedBy': reviewedBy?.toJsonForProtocol(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (signedAt != null) 'signedAt': signedAt?.toJson(),
      if (signatureId != null) 'signatureId': signatureId,
      if (signature != null) 'signature': signature?.toJsonForProtocol(),
      'windowOpen': windowOpen.toJson(),
      'windowClose': windowClose.toJson(),
      if (jobId != null) 'jobId': jobId,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  static AccessReviewInclude include({
    _i2.PharmaUserInclude? user,
    _i3.RoleInclude? role,
    _i2.PharmaUserInclude? reviewedBy,
    _i4.ElectronicSignatureInclude? signature,
  }) {
    return AccessReviewInclude._(
      user: user,
      role: role,
      reviewedBy: reviewedBy,
      signature: signature,
    );
  }

  static AccessReviewIncludeList includeList({
    _i1.WhereExpressionBuilder<AccessReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessReviewTable>? orderByList,
    AccessReviewInclude? include,
  }) {
    return AccessReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessReview.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AccessReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessReviewImpl extends AccessReview {
  _AccessReviewImpl({
    int? id,
    required int windowId,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    String? decision,
    String? justification,
    int? reviewedById,
    _i2.PharmaUser? reviewedBy,
    DateTime? reviewedAt,
    DateTime? signedAt,
    int? signatureId,
    _i4.ElectronicSignature? signature,
    required DateTime windowOpen,
    required DateTime windowClose,
    String? jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? migrationMarker,
  }) : super._(
         id: id,
         windowId: windowId,
         userId: userId,
         user: user,
         roleId: roleId,
         role: role,
         decision: decision,
         justification: justification,
         reviewedById: reviewedById,
         reviewedBy: reviewedBy,
         reviewedAt: reviewedAt,
         signedAt: signedAt,
         signatureId: signatureId,
         signature: signature,
         windowOpen: windowOpen,
         windowClose: windowClose,
         jobId: jobId,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
         migrationMarker: migrationMarker,
       );

  /// Returns a shallow copy of this [AccessReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessReview copyWith({
    Object? id = _Undefined,
    int? windowId,
    int? userId,
    Object? user = _Undefined,
    int? roleId,
    Object? role = _Undefined,
    String? decision,
    Object? justification = _Undefined,
    Object? reviewedById = _Undefined,
    Object? reviewedBy = _Undefined,
    Object? reviewedAt = _Undefined,
    Object? signedAt = _Undefined,
    Object? signatureId = _Undefined,
    Object? signature = _Undefined,
    DateTime? windowOpen,
    DateTime? windowClose,
    Object? jobId = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? migrationMarker = _Undefined,
  }) {
    return AccessReview(
      id: id is int? ? id : this.id,
      windowId: windowId ?? this.windowId,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      roleId: roleId ?? this.roleId,
      role: role is _i3.Role? ? role : this.role?.copyWith(),
      decision: decision ?? this.decision,
      justification: justification is String?
          ? justification
          : this.justification,
      reviewedById: reviewedById is int? ? reviewedById : this.reviewedById,
      reviewedBy: reviewedBy is _i2.PharmaUser?
          ? reviewedBy
          : this.reviewedBy?.copyWith(),
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      signedAt: signedAt is DateTime? ? signedAt : this.signedAt,
      signatureId: signatureId is int? ? signatureId : this.signatureId,
      signature: signature is _i4.ElectronicSignature?
          ? signature
          : this.signature?.copyWith(),
      windowOpen: windowOpen ?? this.windowOpen,
      windowClose: windowClose ?? this.windowClose,
      jobId: jobId is String? ? jobId : this.jobId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      migrationMarker: migrationMarker is String?
          ? migrationMarker
          : this.migrationMarker,
    );
  }
}

class AccessReviewUpdateTable extends _i1.UpdateTable<AccessReviewTable> {
  AccessReviewUpdateTable(super.table);

  _i1.ColumnValue<int, int> windowId(int value) => _i1.ColumnValue(
    table.windowId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> roleId(int value) => _i1.ColumnValue(
    table.roleId,
    value,
  );

  _i1.ColumnValue<String, String> decision(String value) => _i1.ColumnValue(
    table.decision,
    value,
  );

  _i1.ColumnValue<String, String> justification(String? value) =>
      _i1.ColumnValue(
        table.justification,
        value,
      );

  _i1.ColumnValue<int, int> reviewedById(int? value) => _i1.ColumnValue(
    table.reviewedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.reviewedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> signedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.signedAt,
        value,
      );

  _i1.ColumnValue<int, int> signatureId(int? value) => _i1.ColumnValue(
    table.signatureId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> windowOpen(DateTime value) =>
      _i1.ColumnValue(
        table.windowOpen,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> windowClose(DateTime value) =>
      _i1.ColumnValue(
        table.windowClose,
        value,
      );

  _i1.ColumnValue<String, String> jobId(String? value) => _i1.ColumnValue(
    table.jobId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<String, String> migrationMarker(String? value) =>
      _i1.ColumnValue(
        table.migrationMarker,
        value,
      );
}

class AccessReviewTable extends _i1.Table<int?> {
  AccessReviewTable({super.tableRelation}) : super(tableName: 'access_review') {
    updateTable = AccessReviewUpdateTable(this);
    windowId = _i1.ColumnInt(
      'windowId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    decision = _i1.ColumnString(
      'decision',
      this,
      hasDefault: true,
    );
    justification = _i1.ColumnString(
      'justification',
      this,
    );
    reviewedById = _i1.ColumnInt(
      'reviewedById',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
      this,
    );
    signedAt = _i1.ColumnDateTime(
      'signedAt',
      this,
    );
    signatureId = _i1.ColumnInt(
      'signatureId',
      this,
    );
    windowOpen = _i1.ColumnDateTime(
      'windowOpen',
      this,
    );
    windowClose = _i1.ColumnDateTime(
      'windowClose',
      this,
    );
    jobId = _i1.ColumnString(
      'jobId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
    migrationMarker = _i1.ColumnString(
      'migrationMarker',
      this,
    );
  }

  late final AccessReviewUpdateTable updateTable;

  /// The review window (foreign key to AccessReviewWindow)
  late final _i1.ColumnInt windowId;

  late final _i1.ColumnInt userId;

  /// The user under review
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt roleId;

  /// The role being reviewed
  _i3.RoleTable? _role;

  /// Review decision (APPROVED, REVOKED, PENDING)
  late final _i1.ColumnString decision;

  /// Justification for the decision
  late final _i1.ColumnString justification;

  late final _i1.ColumnInt reviewedById;

  /// Reviewer (admin) who made the decision
  _i2.PharmaUserTable? _reviewedBy;

  /// Timestamp when reviewed
  late final _i1.ColumnDateTime reviewedAt;

  /// Timestamp when signed (if e-signed)
  late final _i1.ColumnDateTime signedAt;

  late final _i1.ColumnInt signatureId;

  /// E-signature record (if signed)
  _i4.ElectronicSignatureTable? _signature;

  /// Review window open date
  late final _i1.ColumnDateTime windowOpen;

  /// Review window close date
  late final _i1.ColumnDateTime windowClose;

  /// Triggering job ID (for audit)
  late final _i1.ColumnString jobId;

  /// Status (ACTIVE, CLOSED)
  late final _i1.ColumnString status;

  /// Audit fields
  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  /// Temporary migration marker - remove after migration applied
  late final _i1.ColumnString migrationMarker;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AccessReview.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.RoleTable get role {
    if (_role != null) return _role!;
    _role = _i1.createRelationTable(
      relationFieldName: 'role',
      field: AccessReview.t.roleId,
      foreignField: _i3.Role.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RoleTable(tableRelation: foreignTableRelation),
    );
    return _role!;
  }

  _i2.PharmaUserTable get reviewedBy {
    if (_reviewedBy != null) return _reviewedBy!;
    _reviewedBy = _i1.createRelationTable(
      relationFieldName: 'reviewedBy',
      field: AccessReview.t.reviewedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _reviewedBy!;
  }

  _i4.ElectronicSignatureTable get signature {
    if (_signature != null) return _signature!;
    _signature = _i1.createRelationTable(
      relationFieldName: 'signature',
      field: AccessReview.t.signatureId,
      foreignField: _i4.ElectronicSignature.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ElectronicSignatureTable(tableRelation: foreignTableRelation),
    );
    return _signature!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    windowId,
    userId,
    roleId,
    decision,
    justification,
    reviewedById,
    reviewedAt,
    signedAt,
    signatureId,
    windowOpen,
    windowClose,
    jobId,
    status,
    createdAt,
    updatedAt,
    migrationMarker,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'role') {
      return role;
    }
    if (relationField == 'reviewedBy') {
      return reviewedBy;
    }
    if (relationField == 'signature') {
      return signature;
    }
    return null;
  }
}

class AccessReviewInclude extends _i1.IncludeObject {
  AccessReviewInclude._({
    _i2.PharmaUserInclude? user,
    _i3.RoleInclude? role,
    _i2.PharmaUserInclude? reviewedBy,
    _i4.ElectronicSignatureInclude? signature,
  }) {
    _user = user;
    _role = role;
    _reviewedBy = reviewedBy;
    _signature = signature;
  }

  _i2.PharmaUserInclude? _user;

  _i3.RoleInclude? _role;

  _i2.PharmaUserInclude? _reviewedBy;

  _i4.ElectronicSignatureInclude? _signature;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'role': _role,
    'reviewedBy': _reviewedBy,
    'signature': _signature,
  };

  @override
  _i1.Table<int?> get table => AccessReview.t;
}

class AccessReviewIncludeList extends _i1.IncludeList {
  AccessReviewIncludeList._({
    _i1.WhereExpressionBuilder<AccessReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccessReview.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AccessReview.t;
}

class AccessReviewRepository {
  const AccessReviewRepository._();

  final attachRow = const AccessReviewAttachRowRepository._();

  final detachRow = const AccessReviewDetachRowRepository._();

  /// Returns a list of [AccessReview]s matching the given query parameters.
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
  Future<List<AccessReview>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessReviewTable>? orderByList,
    _i1.Transaction? transaction,
    AccessReviewInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AccessReview>(
      where: where?.call(AccessReview.t),
      orderBy: orderBy?.call(AccessReview.t),
      orderByList: orderByList?.call(AccessReview.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AccessReview] matching the given query parameters.
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
  Future<AccessReview?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessReviewTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccessReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessReviewTable>? orderByList,
    _i1.Transaction? transaction,
    AccessReviewInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AccessReview>(
      where: where?.call(AccessReview.t),
      orderBy: orderBy?.call(AccessReview.t),
      orderByList: orderByList?.call(AccessReview.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AccessReview] by its [id] or null if no such row exists.
  Future<AccessReview?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AccessReviewInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AccessReview>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AccessReview]s in the list and returns the inserted rows.
  ///
  /// The returned [AccessReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AccessReview>> insert(
    _i1.DatabaseSession session,
    List<AccessReview> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AccessReview>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AccessReview] and returns the inserted row.
  ///
  /// The returned [AccessReview] will have its `id` field set.
  Future<AccessReview> insertRow(
    _i1.DatabaseSession session,
    AccessReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccessReview>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AccessReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AccessReview>> update(
    _i1.DatabaseSession session,
    List<AccessReview> rows, {
    _i1.ColumnSelections<AccessReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AccessReview>(
      rows,
      columns: columns?.call(AccessReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccessReview> updateRow(
    _i1.DatabaseSession session,
    AccessReview row, {
    _i1.ColumnSelections<AccessReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccessReview>(
      row,
      columns: columns?.call(AccessReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccessReview?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AccessReviewUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AccessReview>(
      id,
      columnValues: columnValues(AccessReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccessReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AccessReview>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AccessReviewUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AccessReviewTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessReviewTable>? orderBy,
    _i1.OrderByListBuilder<AccessReviewTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AccessReview>(
      columnValues: columnValues(AccessReview.t.updateTable),
      where: where(AccessReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessReview.t),
      orderByList: orderByList?.call(AccessReview.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AccessReview]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AccessReview>> delete(
    _i1.DatabaseSession session,
    List<AccessReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AccessReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AccessReview].
  Future<AccessReview> deleteRow(
    _i1.DatabaseSession session,
    AccessReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccessReview>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AccessReview>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccessReviewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AccessReview>(
      where: where(AccessReview.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccessReviewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AccessReview>(
      where: where?.call(AccessReview.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AccessReview] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccessReviewTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AccessReview>(
      where: where(AccessReview.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AccessReviewAttachRowRepository {
  const AccessReviewAttachRowRepository._();

  /// Creates a relation between the given [AccessReview] and [PharmaUser]
  /// by setting the [AccessReview]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    AccessReview accessReview,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (accessReview.id == null) {
      throw ArgumentError.notNull('accessReview.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $accessReview = accessReview.copyWith(userId: user.id);
    await session.db.updateRow<AccessReview>(
      $accessReview,
      columns: [AccessReview.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AccessReview] and [Role]
  /// by setting the [AccessReview]'s foreign key `roleId` to refer to the [Role].
  Future<void> role(
    _i1.DatabaseSession session,
    AccessReview accessReview,
    _i3.Role role, {
    _i1.Transaction? transaction,
  }) async {
    if (accessReview.id == null) {
      throw ArgumentError.notNull('accessReview.id');
    }
    if (role.id == null) {
      throw ArgumentError.notNull('role.id');
    }

    var $accessReview = accessReview.copyWith(roleId: role.id);
    await session.db.updateRow<AccessReview>(
      $accessReview,
      columns: [AccessReview.t.roleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AccessReview] and [PharmaUser]
  /// by setting the [AccessReview]'s foreign key `reviewedById` to refer to the [PharmaUser].
  Future<void> reviewedBy(
    _i1.DatabaseSession session,
    AccessReview accessReview,
    _i2.PharmaUser reviewedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (accessReview.id == null) {
      throw ArgumentError.notNull('accessReview.id');
    }
    if (reviewedBy.id == null) {
      throw ArgumentError.notNull('reviewedBy.id');
    }

    var $accessReview = accessReview.copyWith(reviewedById: reviewedBy.id);
    await session.db.updateRow<AccessReview>(
      $accessReview,
      columns: [AccessReview.t.reviewedById],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AccessReview] and [ElectronicSignature]
  /// by setting the [AccessReview]'s foreign key `signatureId` to refer to the [ElectronicSignature].
  Future<void> signature(
    _i1.DatabaseSession session,
    AccessReview accessReview,
    _i4.ElectronicSignature signature, {
    _i1.Transaction? transaction,
  }) async {
    if (accessReview.id == null) {
      throw ArgumentError.notNull('accessReview.id');
    }
    if (signature.id == null) {
      throw ArgumentError.notNull('signature.id');
    }

    var $accessReview = accessReview.copyWith(signatureId: signature.id);
    await session.db.updateRow<AccessReview>(
      $accessReview,
      columns: [AccessReview.t.signatureId],
      transaction: transaction,
    );
  }
}

class AccessReviewDetachRowRepository {
  const AccessReviewDetachRowRepository._();

  /// Detaches the relation between this [AccessReview] and the [PharmaUser] set in `reviewedBy`
  /// by setting the [AccessReview]'s foreign key `reviewedById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> reviewedBy(
    _i1.DatabaseSession session,
    AccessReview accessReview, {
    _i1.Transaction? transaction,
  }) async {
    if (accessReview.id == null) {
      throw ArgumentError.notNull('accessReview.id');
    }

    var $accessReview = accessReview.copyWith(reviewedById: null);
    await session.db.updateRow<AccessReview>(
      $accessReview,
      columns: [AccessReview.t.reviewedById],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [AccessReview] and the [ElectronicSignature] set in `signature`
  /// by setting the [AccessReview]'s foreign key `signatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> signature(
    _i1.DatabaseSession session,
    AccessReview accessReview, {
    _i1.Transaction? transaction,
  }) async {
    if (accessReview.id == null) {
      throw ArgumentError.notNull('accessReview.id');
    }

    var $accessReview = accessReview.copyWith(signatureId: null);
    await session.db.updateRow<AccessReview>(
      $accessReview,
      columns: [AccessReview.t.signatureId],
      transaction: transaction,
    );
  }
}
