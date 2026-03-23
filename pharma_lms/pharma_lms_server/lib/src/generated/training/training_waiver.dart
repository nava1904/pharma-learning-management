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
import '../course/course.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Training waiver - exempt user from course requirement. ADM-07.
/// Request flow: employee/admin requests -> QA approves with evidence.
abstract class TrainingWaiver
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingWaiver._({
    this.id,
    required this.userId,
    this.user,
    required this.courseId,
    this.course,
    required this.requestedById,
    this.requestedBy,
    DateTime? requestedAt,
    required this.requestReason,
    this.evidenceStoragePath,
    String? status,
    this.approvedById,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    this.expiresAt,
  }) : requestedAt = requestedAt ?? DateTime.now(),
       status = status ?? 'pending';

  factory TrainingWaiver({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseId,
    _i3.Course? course,
    required int requestedById,
    _i2.PharmaUser? requestedBy,
    DateTime? requestedAt,
    required String requestReason,
    String? evidenceStoragePath,
    String? status,
    int? approvedById,
    _i2.PharmaUser? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    DateTime? expiresAt,
  }) = _TrainingWaiverImpl;

  factory TrainingWaiver.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingWaiver(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Course>(jsonSerialization['course']),
      requestedById: jsonSerialization['requestedById'] as int,
      requestedBy: jsonSerialization['requestedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['requestedBy'],
            ),
      requestedAt: jsonSerialization['requestedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['requestedAt'],
            ),
      requestReason: jsonSerialization['requestReason'] as String,
      evidenceStoragePath: jsonSerialization['evidenceStoragePath'] as String?,
      status: jsonSerialization['status'] as String?,
      approvedById: jsonSerialization['approvedById'] as int?,
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['approvedBy'],
            ),
      approvedAt: jsonSerialization['approvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['approvedAt']),
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  static final t = TrainingWaiverTable();

  static const db = TrainingWaiverRepository._();

  @override
  int? id;

  int userId;

  /// The user being waived.
  _i2.PharmaUser? user;

  int courseId;

  /// The course requirement being waived.
  _i3.Course? course;

  int requestedById;

  /// Who requested (admin or employee).
  _i2.PharmaUser? requestedBy;

  /// When requested.
  DateTime requestedAt;

  /// Justification for waiver request.
  String requestReason;

  /// Cloud storage path for evidence attachment (e.g. prior cert, justification doc).
  String? evidenceStoragePath;

  /// Status: pending, approved, rejected.
  String status;

  int? approvedById;

  /// QA user who approved/rejected.
  _i2.PharmaUser? approvedBy;

  /// When approved/rejected.
  DateTime? approvedAt;

  /// Rejection reason when status is rejected.
  String? rejectionReason;

  /// Optional expiry - waiver valid until this date.
  DateTime? expiresAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingWaiver]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingWaiver copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseId,
    _i3.Course? course,
    int? requestedById,
    _i2.PharmaUser? requestedBy,
    DateTime? requestedAt,
    String? requestReason,
    String? evidenceStoragePath,
    String? status,
    int? approvedById,
    _i2.PharmaUser? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingWaiver',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'requestedById': requestedById,
      if (requestedBy != null) 'requestedBy': requestedBy?.toJson(),
      'requestedAt': requestedAt.toJson(),
      'requestReason': requestReason,
      if (evidenceStoragePath != null)
        'evidenceStoragePath': evidenceStoragePath,
      'status': status,
      if (approvedById != null) 'approvedById': approvedById,
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingWaiver',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      'requestedById': requestedById,
      if (requestedBy != null) 'requestedBy': requestedBy?.toJsonForProtocol(),
      'requestedAt': requestedAt.toJson(),
      'requestReason': requestReason,
      if (evidenceStoragePath != null)
        'evidenceStoragePath': evidenceStoragePath,
      'status': status,
      if (approvedById != null) 'approvedById': approvedById,
      if (approvedBy != null) 'approvedBy': approvedBy?.toJsonForProtocol(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  static TrainingWaiverInclude include({
    _i2.PharmaUserInclude? user,
    _i3.CourseInclude? course,
    _i2.PharmaUserInclude? requestedBy,
    _i2.PharmaUserInclude? approvedBy,
  }) {
    return TrainingWaiverInclude._(
      user: user,
      course: course,
      requestedBy: requestedBy,
      approvedBy: approvedBy,
    );
  }

  static TrainingWaiverIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingWaiverTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingWaiverTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingWaiverTable>? orderByList,
    TrainingWaiverInclude? include,
  }) {
    return TrainingWaiverIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingWaiver.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingWaiver.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingWaiverImpl extends TrainingWaiver {
  _TrainingWaiverImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseId,
    _i3.Course? course,
    required int requestedById,
    _i2.PharmaUser? requestedBy,
    DateTime? requestedAt,
    required String requestReason,
    String? evidenceStoragePath,
    String? status,
    int? approvedById,
    _i2.PharmaUser? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseId: courseId,
         course: course,
         requestedById: requestedById,
         requestedBy: requestedBy,
         requestedAt: requestedAt,
         requestReason: requestReason,
         evidenceStoragePath: evidenceStoragePath,
         status: status,
         approvedById: approvedById,
         approvedBy: approvedBy,
         approvedAt: approvedAt,
         rejectionReason: rejectionReason,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [TrainingWaiver]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingWaiver copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? requestedById,
    Object? requestedBy = _Undefined,
    DateTime? requestedAt,
    String? requestReason,
    Object? evidenceStoragePath = _Undefined,
    String? status,
    Object? approvedById = _Undefined,
    Object? approvedBy = _Undefined,
    Object? approvedAt = _Undefined,
    Object? rejectionReason = _Undefined,
    Object? expiresAt = _Undefined,
  }) {
    return TrainingWaiver(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseId: courseId ?? this.courseId,
      course: course is _i3.Course? ? course : this.course?.copyWith(),
      requestedById: requestedById ?? this.requestedById,
      requestedBy: requestedBy is _i2.PharmaUser?
          ? requestedBy
          : this.requestedBy?.copyWith(),
      requestedAt: requestedAt ?? this.requestedAt,
      requestReason: requestReason ?? this.requestReason,
      evidenceStoragePath: evidenceStoragePath is String?
          ? evidenceStoragePath
          : this.evidenceStoragePath,
      status: status ?? this.status,
      approvedById: approvedById is int? ? approvedById : this.approvedById,
      approvedBy: approvedBy is _i2.PharmaUser?
          ? approvedBy
          : this.approvedBy?.copyWith(),
      approvedAt: approvedAt is DateTime? ? approvedAt : this.approvedAt,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}

class TrainingWaiverUpdateTable extends _i1.UpdateTable<TrainingWaiverTable> {
  TrainingWaiverUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> requestedById(int value) => _i1.ColumnValue(
    table.requestedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> requestedAt(DateTime value) =>
      _i1.ColumnValue(
        table.requestedAt,
        value,
      );

  _i1.ColumnValue<String, String> requestReason(String value) =>
      _i1.ColumnValue(
        table.requestReason,
        value,
      );

  _i1.ColumnValue<String, String> evidenceStoragePath(String? value) =>
      _i1.ColumnValue(
        table.evidenceStoragePath,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> approvedById(int? value) => _i1.ColumnValue(
    table.approvedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> approvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.approvedAt,
        value,
      );

  _i1.ColumnValue<String, String> rejectionReason(String? value) =>
      _i1.ColumnValue(
        table.rejectionReason,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class TrainingWaiverTable extends _i1.Table<int?> {
  TrainingWaiverTable({super.tableRelation})
    : super(tableName: 'training_waiver') {
    updateTable = TrainingWaiverUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    requestedById = _i1.ColumnInt(
      'requestedById',
      this,
    );
    requestedAt = _i1.ColumnDateTime(
      'requestedAt',
      this,
      hasDefault: true,
    );
    requestReason = _i1.ColumnString(
      'requestReason',
      this,
    );
    evidenceStoragePath = _i1.ColumnString(
      'evidenceStoragePath',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    approvedById = _i1.ColumnInt(
      'approvedById',
      this,
    );
    approvedAt = _i1.ColumnDateTime(
      'approvedAt',
      this,
    );
    rejectionReason = _i1.ColumnString(
      'rejectionReason',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final TrainingWaiverUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user being waived.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt courseId;

  /// The course requirement being waived.
  _i3.CourseTable? _course;

  late final _i1.ColumnInt requestedById;

  /// Who requested (admin or employee).
  _i2.PharmaUserTable? _requestedBy;

  /// When requested.
  late final _i1.ColumnDateTime requestedAt;

  /// Justification for waiver request.
  late final _i1.ColumnString requestReason;

  /// Cloud storage path for evidence attachment (e.g. prior cert, justification doc).
  late final _i1.ColumnString evidenceStoragePath;

  /// Status: pending, approved, rejected.
  late final _i1.ColumnString status;

  late final _i1.ColumnInt approvedById;

  /// QA user who approved/rejected.
  _i2.PharmaUserTable? _approvedBy;

  /// When approved/rejected.
  late final _i1.ColumnDateTime approvedAt;

  /// Rejection reason when status is rejected.
  late final _i1.ColumnString rejectionReason;

  /// Optional expiry - waiver valid until this date.
  late final _i1.ColumnDateTime expiresAt;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: TrainingWaiver.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: TrainingWaiver.t.courseId,
      foreignField: _i3.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  _i2.PharmaUserTable get requestedBy {
    if (_requestedBy != null) return _requestedBy!;
    _requestedBy = _i1.createRelationTable(
      relationFieldName: 'requestedBy',
      field: TrainingWaiver.t.requestedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _requestedBy!;
  }

  _i2.PharmaUserTable get approvedBy {
    if (_approvedBy != null) return _approvedBy!;
    _approvedBy = _i1.createRelationTable(
      relationFieldName: 'approvedBy',
      field: TrainingWaiver.t.approvedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _approvedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    courseId,
    requestedById,
    requestedAt,
    requestReason,
    evidenceStoragePath,
    status,
    approvedById,
    approvedAt,
    rejectionReason,
    expiresAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'course') {
      return course;
    }
    if (relationField == 'requestedBy') {
      return requestedBy;
    }
    if (relationField == 'approvedBy') {
      return approvedBy;
    }
    return null;
  }
}

class TrainingWaiverInclude extends _i1.IncludeObject {
  TrainingWaiverInclude._({
    _i2.PharmaUserInclude? user,
    _i3.CourseInclude? course,
    _i2.PharmaUserInclude? requestedBy,
    _i2.PharmaUserInclude? approvedBy,
  }) {
    _user = user;
    _course = course;
    _requestedBy = requestedBy;
    _approvedBy = approvedBy;
  }

  _i2.PharmaUserInclude? _user;

  _i3.CourseInclude? _course;

  _i2.PharmaUserInclude? _requestedBy;

  _i2.PharmaUserInclude? _approvedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'course': _course,
    'requestedBy': _requestedBy,
    'approvedBy': _approvedBy,
  };

  @override
  _i1.Table<int?> get table => TrainingWaiver.t;
}

class TrainingWaiverIncludeList extends _i1.IncludeList {
  TrainingWaiverIncludeList._({
    _i1.WhereExpressionBuilder<TrainingWaiverTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingWaiver.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingWaiver.t;
}

class TrainingWaiverRepository {
  const TrainingWaiverRepository._();

  final attachRow = const TrainingWaiverAttachRowRepository._();

  final detachRow = const TrainingWaiverDetachRowRepository._();

  /// Returns a list of [TrainingWaiver]s matching the given query parameters.
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
  Future<List<TrainingWaiver>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingWaiverTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingWaiverTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingWaiverTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingWaiverInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingWaiver>(
      where: where?.call(TrainingWaiver.t),
      orderBy: orderBy?.call(TrainingWaiver.t),
      orderByList: orderByList?.call(TrainingWaiver.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingWaiver] matching the given query parameters.
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
  Future<TrainingWaiver?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingWaiverTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingWaiverTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingWaiverTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingWaiverInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingWaiver>(
      where: where?.call(TrainingWaiver.t),
      orderBy: orderBy?.call(TrainingWaiver.t),
      orderByList: orderByList?.call(TrainingWaiver.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingWaiver] by its [id] or null if no such row exists.
  Future<TrainingWaiver?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingWaiverInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingWaiver>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingWaiver]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingWaiver]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingWaiver>> insert(
    _i1.DatabaseSession session,
    List<TrainingWaiver> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingWaiver>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingWaiver] and returns the inserted row.
  ///
  /// The returned [TrainingWaiver] will have its `id` field set.
  Future<TrainingWaiver> insertRow(
    _i1.DatabaseSession session,
    TrainingWaiver row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingWaiver>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingWaiver]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingWaiver>> update(
    _i1.DatabaseSession session,
    List<TrainingWaiver> rows, {
    _i1.ColumnSelections<TrainingWaiverTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingWaiver>(
      rows,
      columns: columns?.call(TrainingWaiver.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingWaiver]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingWaiver> updateRow(
    _i1.DatabaseSession session,
    TrainingWaiver row, {
    _i1.ColumnSelections<TrainingWaiverTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingWaiver>(
      row,
      columns: columns?.call(TrainingWaiver.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingWaiver] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingWaiver?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingWaiverUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingWaiver>(
      id,
      columnValues: columnValues(TrainingWaiver.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingWaiver]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingWaiver>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingWaiverUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TrainingWaiverTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingWaiverTable>? orderBy,
    _i1.OrderByListBuilder<TrainingWaiverTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingWaiver>(
      columnValues: columnValues(TrainingWaiver.t.updateTable),
      where: where(TrainingWaiver.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingWaiver.t),
      orderByList: orderByList?.call(TrainingWaiver.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingWaiver]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingWaiver>> delete(
    _i1.DatabaseSession session,
    List<TrainingWaiver> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingWaiver>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingWaiver].
  Future<TrainingWaiver> deleteRow(
    _i1.DatabaseSession session,
    TrainingWaiver row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingWaiver>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingWaiver>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingWaiverTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingWaiver>(
      where: where(TrainingWaiver.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingWaiverTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingWaiver>(
      where: where?.call(TrainingWaiver.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingWaiver] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingWaiverTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingWaiver>(
      where: where(TrainingWaiver.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingWaiverAttachRowRepository {
  const TrainingWaiverAttachRowRepository._();

  /// Creates a relation between the given [TrainingWaiver] and [PharmaUser]
  /// by setting the [TrainingWaiver]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    TrainingWaiver trainingWaiver,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingWaiver.id == null) {
      throw ArgumentError.notNull('trainingWaiver.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $trainingWaiver = trainingWaiver.copyWith(userId: user.id);
    await session.db.updateRow<TrainingWaiver>(
      $trainingWaiver,
      columns: [TrainingWaiver.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingWaiver] and [Course]
  /// by setting the [TrainingWaiver]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.DatabaseSession session,
    TrainingWaiver trainingWaiver,
    _i3.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingWaiver.id == null) {
      throw ArgumentError.notNull('trainingWaiver.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $trainingWaiver = trainingWaiver.copyWith(courseId: course.id);
    await session.db.updateRow<TrainingWaiver>(
      $trainingWaiver,
      columns: [TrainingWaiver.t.courseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingWaiver] and [PharmaUser]
  /// by setting the [TrainingWaiver]'s foreign key `requestedById` to refer to the [PharmaUser].
  Future<void> requestedBy(
    _i1.DatabaseSession session,
    TrainingWaiver trainingWaiver,
    _i2.PharmaUser requestedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingWaiver.id == null) {
      throw ArgumentError.notNull('trainingWaiver.id');
    }
    if (requestedBy.id == null) {
      throw ArgumentError.notNull('requestedBy.id');
    }

    var $trainingWaiver = trainingWaiver.copyWith(
      requestedById: requestedBy.id,
    );
    await session.db.updateRow<TrainingWaiver>(
      $trainingWaiver,
      columns: [TrainingWaiver.t.requestedById],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingWaiver] and [PharmaUser]
  /// by setting the [TrainingWaiver]'s foreign key `approvedById` to refer to the [PharmaUser].
  Future<void> approvedBy(
    _i1.DatabaseSession session,
    TrainingWaiver trainingWaiver,
    _i2.PharmaUser approvedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingWaiver.id == null) {
      throw ArgumentError.notNull('trainingWaiver.id');
    }
    if (approvedBy.id == null) {
      throw ArgumentError.notNull('approvedBy.id');
    }

    var $trainingWaiver = trainingWaiver.copyWith(approvedById: approvedBy.id);
    await session.db.updateRow<TrainingWaiver>(
      $trainingWaiver,
      columns: [TrainingWaiver.t.approvedById],
      transaction: transaction,
    );
  }
}

class TrainingWaiverDetachRowRepository {
  const TrainingWaiverDetachRowRepository._();

  /// Detaches the relation between this [TrainingWaiver] and the [PharmaUser] set in `approvedBy`
  /// by setting the [TrainingWaiver]'s foreign key `approvedById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> approvedBy(
    _i1.DatabaseSession session,
    TrainingWaiver trainingWaiver, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingWaiver.id == null) {
      throw ArgumentError.notNull('trainingWaiver.id');
    }

    var $trainingWaiver = trainingWaiver.copyWith(approvedById: null);
    await session.db.updateRow<TrainingWaiver>(
      $trainingWaiver,
      columns: [TrainingWaiver.t.approvedById],
      transaction: transaction,
    );
  }
}
