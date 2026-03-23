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
import '../course/course_version.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Training assignment to user for a course version.
abstract class TrainingAssignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingAssignment._({
    this.id,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    required this.assignedById,
    this.assignedBy,
    DateTime? assignedAt,
    required this.dueDate,
    String? priority,
    this.reason,
    String? source,
    String? assignmentType,
    this.targetRoleId,
    this.targetDepartmentId,
    this.targetUserId,
    String? status,
    this.cancelledAt,
    this.cancelledById,
    this.cancellationReason,
  }) : assignedAt = assignedAt ?? DateTime.now(),
       priority = priority ?? 'medium',
       source = source ?? 'manual',
       assignmentType = assignmentType ?? 'individual',
       status = status ?? 'active';

  factory TrainingAssignment({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int assignedById,
    _i2.PharmaUser? assignedBy,
    DateTime? assignedAt,
    required DateTime dueDate,
    String? priority,
    String? reason,
    String? source,
    String? assignmentType,
    int? targetRoleId,
    int? targetDepartmentId,
    int? targetUserId,
    String? status,
    DateTime? cancelledAt,
    int? cancelledById,
    String? cancellationReason,
  }) = _TrainingAssignmentImpl;

  factory TrainingAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingAssignment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      assignedById: jsonSerialization['assignedById'] as int,
      assignedBy: jsonSerialization['assignedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['assignedBy'],
            ),
      assignedAt: jsonSerialization['assignedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['assignedAt']),
      dueDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      priority: jsonSerialization['priority'] as String?,
      reason: jsonSerialization['reason'] as String?,
      source: jsonSerialization['source'] as String?,
      assignmentType: jsonSerialization['assignmentType'] as String?,
      targetRoleId: jsonSerialization['targetRoleId'] as int?,
      targetDepartmentId: jsonSerialization['targetDepartmentId'] as int?,
      targetUserId: jsonSerialization['targetUserId'] as int?,
      status: jsonSerialization['status'] as String?,
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancelledById: jsonSerialization['cancelledById'] as int?,
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
    );
  }

  static final t = TrainingAssignmentTable();

  static const db = TrainingAssignmentRepository._();

  @override
  int? id;

  int userId;

  /// The user assigned.
  _i2.PharmaUser? user;

  int courseVersionId;

  /// The course version to complete.
  _i3.CourseVersion? courseVersion;

  int assignedById;

  /// Who assigned (user ID).
  _i2.PharmaUser? assignedBy;

  /// When assigned.
  DateTime assignedAt;

  /// Due date.
  DateTime dueDate;

  /// Priority: low, medium, high.
  String priority;

  /// Reason for assignment.
  String? reason;

  /// Source: manual, sop_update, capa, onboarding.
  String source;

  /// Assignment type: role, department, individual, capa.
  String assignmentType;

  /// Target role ID when assigning by role.
  int? targetRoleId;

  /// Target department ID when assigning by department.
  int? targetDepartmentId;

  /// Target user ID when assigning to individual.
  int? targetUserId;

  /// Status: active, cancelled.
  String status;

  /// When cancelled.
  DateTime? cancelledAt;

  /// Who cancelled.
  int? cancelledById;

  /// Cancellation reason.
  String? cancellationReason;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingAssignment copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignedById,
    _i2.PharmaUser? assignedBy,
    DateTime? assignedAt,
    DateTime? dueDate,
    String? priority,
    String? reason,
    String? source,
    String? assignmentType,
    int? targetRoleId,
    int? targetDepartmentId,
    int? targetUserId,
    String? status,
    DateTime? cancelledAt,
    int? cancelledById,
    String? cancellationReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'assignedById': assignedById,
      if (assignedBy != null) 'assignedBy': assignedBy?.toJson(),
      'assignedAt': assignedAt.toJson(),
      'dueDate': dueDate.toJson(),
      'priority': priority,
      if (reason != null) 'reason': reason,
      'source': source,
      'assignmentType': assignmentType,
      if (targetRoleId != null) 'targetRoleId': targetRoleId,
      if (targetDepartmentId != null) 'targetDepartmentId': targetDepartmentId,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'status': status,
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'assignedById': assignedById,
      if (assignedBy != null) 'assignedBy': assignedBy?.toJsonForProtocol(),
      'assignedAt': assignedAt.toJson(),
      'dueDate': dueDate.toJson(),
      'priority': priority,
      if (reason != null) 'reason': reason,
      'source': source,
      'assignmentType': assignmentType,
      if (targetRoleId != null) 'targetRoleId': targetRoleId,
      if (targetDepartmentId != null) 'targetDepartmentId': targetDepartmentId,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'status': status,
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
    };
  }

  static TrainingAssignmentInclude include({
    _i2.PharmaUserInclude? user,
    _i3.CourseVersionInclude? courseVersion,
    _i2.PharmaUserInclude? assignedBy,
  }) {
    return TrainingAssignmentInclude._(
      user: user,
      courseVersion: courseVersion,
      assignedBy: assignedBy,
    );
  }

  static TrainingAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingAssignmentTable>? orderByList,
    TrainingAssignmentInclude? include,
  }) {
    return TrainingAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingAssignmentImpl extends TrainingAssignment {
  _TrainingAssignmentImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int assignedById,
    _i2.PharmaUser? assignedBy,
    DateTime? assignedAt,
    required DateTime dueDate,
    String? priority,
    String? reason,
    String? source,
    String? assignmentType,
    int? targetRoleId,
    int? targetDepartmentId,
    int? targetUserId,
    String? status,
    DateTime? cancelledAt,
    int? cancelledById,
    String? cancellationReason,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         assignedById: assignedById,
         assignedBy: assignedBy,
         assignedAt: assignedAt,
         dueDate: dueDate,
         priority: priority,
         reason: reason,
         source: source,
         assignmentType: assignmentType,
         targetRoleId: targetRoleId,
         targetDepartmentId: targetDepartmentId,
         targetUserId: targetUserId,
         status: status,
         cancelledAt: cancelledAt,
         cancelledById: cancelledById,
         cancellationReason: cancellationReason,
       );

  /// Returns a shallow copy of this [TrainingAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingAssignment copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? assignedById,
    Object? assignedBy = _Undefined,
    DateTime? assignedAt,
    DateTime? dueDate,
    String? priority,
    Object? reason = _Undefined,
    String? source,
    String? assignmentType,
    Object? targetRoleId = _Undefined,
    Object? targetDepartmentId = _Undefined,
    Object? targetUserId = _Undefined,
    String? status,
    Object? cancelledAt = _Undefined,
    Object? cancelledById = _Undefined,
    Object? cancellationReason = _Undefined,
  }) {
    return TrainingAssignment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      assignedById: assignedById ?? this.assignedById,
      assignedBy: assignedBy is _i2.PharmaUser?
          ? assignedBy
          : this.assignedBy?.copyWith(),
      assignedAt: assignedAt ?? this.assignedAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      reason: reason is String? ? reason : this.reason,
      source: source ?? this.source,
      assignmentType: assignmentType ?? this.assignmentType,
      targetRoleId: targetRoleId is int? ? targetRoleId : this.targetRoleId,
      targetDepartmentId: targetDepartmentId is int?
          ? targetDepartmentId
          : this.targetDepartmentId,
      targetUserId: targetUserId is int? ? targetUserId : this.targetUserId,
      status: status ?? this.status,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancelledById: cancelledById is int? ? cancelledById : this.cancelledById,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
    );
  }
}

class TrainingAssignmentUpdateTable
    extends _i1.UpdateTable<TrainingAssignmentTable> {
  TrainingAssignmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> assignedById(int value) => _i1.ColumnValue(
    table.assignedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> assignedAt(DateTime value) =>
      _i1.ColumnValue(
        table.assignedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> dueDate(DateTime value) =>
      _i1.ColumnValue(
        table.dueDate,
        value,
      );

  _i1.ColumnValue<String, String> priority(String value) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<String, String> reason(String? value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<String, String> source(String value) => _i1.ColumnValue(
    table.source,
    value,
  );

  _i1.ColumnValue<String, String> assignmentType(String value) =>
      _i1.ColumnValue(
        table.assignmentType,
        value,
      );

  _i1.ColumnValue<int, int> targetRoleId(int? value) => _i1.ColumnValue(
    table.targetRoleId,
    value,
  );

  _i1.ColumnValue<int, int> targetDepartmentId(int? value) => _i1.ColumnValue(
    table.targetDepartmentId,
    value,
  );

  _i1.ColumnValue<int, int> targetUserId(int? value) => _i1.ColumnValue(
    table.targetUserId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.cancelledAt,
        value,
      );

  _i1.ColumnValue<int, int> cancelledById(int? value) => _i1.ColumnValue(
    table.cancelledById,
    value,
  );

  _i1.ColumnValue<String, String> cancellationReason(String? value) =>
      _i1.ColumnValue(
        table.cancellationReason,
        value,
      );
}

class TrainingAssignmentTable extends _i1.Table<int?> {
  TrainingAssignmentTable({super.tableRelation})
    : super(tableName: 'training_assignment') {
    updateTable = TrainingAssignmentUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    assignedById = _i1.ColumnInt(
      'assignedById',
      this,
    );
    assignedAt = _i1.ColumnDateTime(
      'assignedAt',
      this,
      hasDefault: true,
    );
    dueDate = _i1.ColumnDateTime(
      'dueDate',
      this,
    );
    priority = _i1.ColumnString(
      'priority',
      this,
      hasDefault: true,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
      hasDefault: true,
    );
    assignmentType = _i1.ColumnString(
      'assignmentType',
      this,
      hasDefault: true,
    );
    targetRoleId = _i1.ColumnInt(
      'targetRoleId',
      this,
    );
    targetDepartmentId = _i1.ColumnInt(
      'targetDepartmentId',
      this,
    );
    targetUserId = _i1.ColumnInt(
      'targetUserId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    cancelledAt = _i1.ColumnDateTime(
      'cancelledAt',
      this,
    );
    cancelledById = _i1.ColumnInt(
      'cancelledById',
      this,
    );
    cancellationReason = _i1.ColumnString(
      'cancellationReason',
      this,
    );
  }

  late final TrainingAssignmentUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user assigned.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt courseVersionId;

  /// The course version to complete.
  _i3.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt assignedById;

  /// Who assigned (user ID).
  _i2.PharmaUserTable? _assignedBy;

  /// When assigned.
  late final _i1.ColumnDateTime assignedAt;

  /// Due date.
  late final _i1.ColumnDateTime dueDate;

  /// Priority: low, medium, high.
  late final _i1.ColumnString priority;

  /// Reason for assignment.
  late final _i1.ColumnString reason;

  /// Source: manual, sop_update, capa, onboarding.
  late final _i1.ColumnString source;

  /// Assignment type: role, department, individual, capa.
  late final _i1.ColumnString assignmentType;

  /// Target role ID when assigning by role.
  late final _i1.ColumnInt targetRoleId;

  /// Target department ID when assigning by department.
  late final _i1.ColumnInt targetDepartmentId;

  /// Target user ID when assigning to individual.
  late final _i1.ColumnInt targetUserId;

  /// Status: active, cancelled.
  late final _i1.ColumnString status;

  /// When cancelled.
  late final _i1.ColumnDateTime cancelledAt;

  /// Who cancelled.
  late final _i1.ColumnInt cancelledById;

  /// Cancellation reason.
  late final _i1.ColumnString cancellationReason;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: TrainingAssignment.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: TrainingAssignment.t.courseVersionId,
      foreignField: _i3.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i2.PharmaUserTable get assignedBy {
    if (_assignedBy != null) return _assignedBy!;
    _assignedBy = _i1.createRelationTable(
      relationFieldName: 'assignedBy',
      field: TrainingAssignment.t.assignedById,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _assignedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    courseVersionId,
    assignedById,
    assignedAt,
    dueDate,
    priority,
    reason,
    source,
    assignmentType,
    targetRoleId,
    targetDepartmentId,
    targetUserId,
    status,
    cancelledAt,
    cancelledById,
    cancellationReason,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'assignedBy') {
      return assignedBy;
    }
    return null;
  }
}

class TrainingAssignmentInclude extends _i1.IncludeObject {
  TrainingAssignmentInclude._({
    _i2.PharmaUserInclude? user,
    _i3.CourseVersionInclude? courseVersion,
    _i2.PharmaUserInclude? assignedBy,
  }) {
    _user = user;
    _courseVersion = courseVersion;
    _assignedBy = assignedBy;
  }

  _i2.PharmaUserInclude? _user;

  _i3.CourseVersionInclude? _courseVersion;

  _i2.PharmaUserInclude? _assignedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'courseVersion': _courseVersion,
    'assignedBy': _assignedBy,
  };

  @override
  _i1.Table<int?> get table => TrainingAssignment.t;
}

class TrainingAssignmentIncludeList extends _i1.IncludeList {
  TrainingAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<TrainingAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingAssignment.t;
}

class TrainingAssignmentRepository {
  const TrainingAssignmentRepository._();

  final attachRow = const TrainingAssignmentAttachRowRepository._();

  /// Returns a list of [TrainingAssignment]s matching the given query parameters.
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
  Future<List<TrainingAssignment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingAssignment>(
      where: where?.call(TrainingAssignment.t),
      orderBy: orderBy?.call(TrainingAssignment.t),
      orderByList: orderByList?.call(TrainingAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingAssignment] matching the given query parameters.
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
  Future<TrainingAssignment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingAssignment>(
      where: where?.call(TrainingAssignment.t),
      orderBy: orderBy?.call(TrainingAssignment.t),
      orderByList: orderByList?.call(TrainingAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingAssignment] by its [id] or null if no such row exists.
  Future<TrainingAssignment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingAssignment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingAssignment>> insert(
    _i1.DatabaseSession session,
    List<TrainingAssignment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingAssignment] and returns the inserted row.
  ///
  /// The returned [TrainingAssignment] will have its `id` field set.
  Future<TrainingAssignment> insertRow(
    _i1.DatabaseSession session,
    TrainingAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingAssignment>> update(
    _i1.DatabaseSession session,
    List<TrainingAssignment> rows, {
    _i1.ColumnSelections<TrainingAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingAssignment>(
      rows,
      columns: columns?.call(TrainingAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingAssignment> updateRow(
    _i1.DatabaseSession session,
    TrainingAssignment row, {
    _i1.ColumnSelections<TrainingAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingAssignment>(
      row,
      columns: columns?.call(TrainingAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingAssignment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingAssignmentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingAssignment>(
      id,
      columnValues: columnValues(TrainingAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingAssignment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingAssignmentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingAssignmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingAssignmentTable>? orderBy,
    _i1.OrderByListBuilder<TrainingAssignmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingAssignment>(
      columnValues: columnValues(TrainingAssignment.t.updateTable),
      where: where(TrainingAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingAssignment.t),
      orderByList: orderByList?.call(TrainingAssignment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingAssignment>> delete(
    _i1.DatabaseSession session,
    List<TrainingAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingAssignment].
  Future<TrainingAssignment> deleteRow(
    _i1.DatabaseSession session,
    TrainingAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingAssignment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingAssignment>(
      where: where(TrainingAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingAssignment>(
      where: where?.call(TrainingAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingAssignmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingAssignment>(
      where: where(TrainingAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingAssignmentAttachRowRepository {
  const TrainingAssignmentAttachRowRepository._();

  /// Creates a relation between the given [TrainingAssignment] and [PharmaUser]
  /// by setting the [TrainingAssignment]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    TrainingAssignment trainingAssignment,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingAssignment.id == null) {
      throw ArgumentError.notNull('trainingAssignment.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $trainingAssignment = trainingAssignment.copyWith(userId: user.id);
    await session.db.updateRow<TrainingAssignment>(
      $trainingAssignment,
      columns: [TrainingAssignment.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingAssignment] and [CourseVersion]
  /// by setting the [TrainingAssignment]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    TrainingAssignment trainingAssignment,
    _i3.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingAssignment.id == null) {
      throw ArgumentError.notNull('trainingAssignment.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $trainingAssignment = trainingAssignment.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<TrainingAssignment>(
      $trainingAssignment,
      columns: [TrainingAssignment.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingAssignment] and [PharmaUser]
  /// by setting the [TrainingAssignment]'s foreign key `assignedById` to refer to the [PharmaUser].
  Future<void> assignedBy(
    _i1.DatabaseSession session,
    TrainingAssignment trainingAssignment,
    _i2.PharmaUser assignedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingAssignment.id == null) {
      throw ArgumentError.notNull('trainingAssignment.id');
    }
    if (assignedBy.id == null) {
      throw ArgumentError.notNull('assignedBy.id');
    }

    var $trainingAssignment = trainingAssignment.copyWith(
      assignedById: assignedBy.id,
    );
    await session.db.updateRow<TrainingAssignment>(
      $trainingAssignment,
      columns: [TrainingAssignment.t.assignedById],
      transaction: transaction,
    );
  }
}
