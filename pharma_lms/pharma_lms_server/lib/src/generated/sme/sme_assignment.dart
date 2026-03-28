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
import '../course/course.dart' as _i2;
import '../course/course_version.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// SME invited to review a course (subject-matter expert collaboration).
abstract class SmeAssignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SmeAssignment._({
    this.id,
    required this.courseId,
    this.course,
    this.courseVersionId,
    this.courseVersion,
    required this.smeUserId,
    this.smeUser,
    required this.invitedById,
    this.invitedBy,
    String? status,
    DateTime? invitedAt,
  }) : status = status ?? 'invited',
       invitedAt = invitedAt ?? DateTime.now();

  factory SmeAssignment({
    int? id,
    required int courseId,
    _i2.Course? course,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int smeUserId,
    _i4.PharmaUser? smeUser,
    required int invitedById,
    _i4.PharmaUser? invitedBy,
    String? status,
    DateTime? invitedAt,
  }) = _SmeAssignmentImpl;

  factory SmeAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SmeAssignment(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      courseVersionId: jsonSerialization['courseVersionId'] as int?,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      smeUserId: jsonSerialization['smeUserId'] as int,
      smeUser: jsonSerialization['smeUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['smeUser'],
            ),
      invitedById: jsonSerialization['invitedById'] as int,
      invitedBy: jsonSerialization['invitedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['invitedBy'],
            ),
      status: jsonSerialization['status'] as String?,
      invitedAt: jsonSerialization['invitedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['invitedAt']),
    );
  }

  static final t = SmeAssignmentTable();

  static const db = SmeAssignmentRepository._();

  @override
  int? id;

  int courseId;

  /// Course under review.
  _i2.Course? course;

  int? courseVersionId;

  /// Optional: scoped to a specific version.
  _i3.CourseVersion? courseVersion;

  int smeUserId;

  /// SME (reviewer) user.
  _i4.PharmaUser? smeUser;

  int invitedById;

  /// Trainer who sent the invite.
  _i4.PharmaUser? invitedBy;

  /// invited, active, completed
  String status;

  /// When invited.
  DateTime invitedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SmeAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SmeAssignment copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? smeUserId,
    _i4.PharmaUser? smeUser,
    int? invitedById,
    _i4.PharmaUser? invitedBy,
    String? status,
    DateTime? invitedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SmeAssignment',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      if (courseVersionId != null) 'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'smeUserId': smeUserId,
      if (smeUser != null) 'smeUser': smeUser?.toJson(),
      'invitedById': invitedById,
      if (invitedBy != null) 'invitedBy': invitedBy?.toJson(),
      'status': status,
      'invitedAt': invitedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SmeAssignment',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      if (courseVersionId != null) 'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'smeUserId': smeUserId,
      if (smeUser != null) 'smeUser': smeUser?.toJsonForProtocol(),
      'invitedById': invitedById,
      if (invitedBy != null) 'invitedBy': invitedBy?.toJsonForProtocol(),
      'status': status,
      'invitedAt': invitedAt.toJson(),
    };
  }

  static SmeAssignmentInclude include({
    _i2.CourseInclude? course,
    _i3.CourseVersionInclude? courseVersion,
    _i4.PharmaUserInclude? smeUser,
    _i4.PharmaUserInclude? invitedBy,
  }) {
    return SmeAssignmentInclude._(
      course: course,
      courseVersion: courseVersion,
      smeUser: smeUser,
      invitedBy: invitedBy,
    );
  }

  static SmeAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<SmeAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SmeAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SmeAssignmentTable>? orderByList,
    SmeAssignmentInclude? include,
  }) {
    return SmeAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SmeAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SmeAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SmeAssignmentImpl extends SmeAssignment {
  _SmeAssignmentImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int smeUserId,
    _i4.PharmaUser? smeUser,
    required int invitedById,
    _i4.PharmaUser? invitedBy,
    String? status,
    DateTime? invitedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         smeUserId: smeUserId,
         smeUser: smeUser,
         invitedById: invitedById,
         invitedBy: invitedBy,
         status: status,
         invitedAt: invitedAt,
       );

  /// Returns a shallow copy of this [SmeAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SmeAssignment copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    Object? courseVersionId = _Undefined,
    Object? courseVersion = _Undefined,
    int? smeUserId,
    Object? smeUser = _Undefined,
    int? invitedById,
    Object? invitedBy = _Undefined,
    String? status,
    DateTime? invitedAt,
  }) {
    return SmeAssignment(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      courseVersionId: courseVersionId is int?
          ? courseVersionId
          : this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      smeUserId: smeUserId ?? this.smeUserId,
      smeUser: smeUser is _i4.PharmaUser? ? smeUser : this.smeUser?.copyWith(),
      invitedById: invitedById ?? this.invitedById,
      invitedBy: invitedBy is _i4.PharmaUser?
          ? invitedBy
          : this.invitedBy?.copyWith(),
      status: status ?? this.status,
      invitedAt: invitedAt ?? this.invitedAt,
    );
  }
}

class SmeAssignmentUpdateTable extends _i1.UpdateTable<SmeAssignmentTable> {
  SmeAssignmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int? value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> smeUserId(int value) => _i1.ColumnValue(
    table.smeUserId,
    value,
  );

  _i1.ColumnValue<int, int> invitedById(int value) => _i1.ColumnValue(
    table.invitedById,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> invitedAt(DateTime value) =>
      _i1.ColumnValue(
        table.invitedAt,
        value,
      );
}

class SmeAssignmentTable extends _i1.Table<int?> {
  SmeAssignmentTable({super.tableRelation})
    : super(tableName: 'sme_assignment') {
    updateTable = SmeAssignmentUpdateTable(this);
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    smeUserId = _i1.ColumnInt(
      'smeUserId',
      this,
    );
    invitedById = _i1.ColumnInt(
      'invitedById',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    invitedAt = _i1.ColumnDateTime(
      'invitedAt',
      this,
      hasDefault: true,
    );
  }

  late final SmeAssignmentUpdateTable updateTable;

  late final _i1.ColumnInt courseId;

  /// Course under review.
  _i2.CourseTable? _course;

  late final _i1.ColumnInt courseVersionId;

  /// Optional: scoped to a specific version.
  _i3.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt smeUserId;

  /// SME (reviewer) user.
  _i4.PharmaUserTable? _smeUser;

  late final _i1.ColumnInt invitedById;

  /// Trainer who sent the invite.
  _i4.PharmaUserTable? _invitedBy;

  /// invited, active, completed
  late final _i1.ColumnString status;

  /// When invited.
  late final _i1.ColumnDateTime invitedAt;

  _i2.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: SmeAssignment.t.courseId,
      foreignField: _i2.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  _i3.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: SmeAssignment.t.courseVersionId,
      foreignField: _i3.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i4.PharmaUserTable get smeUser {
    if (_smeUser != null) return _smeUser!;
    _smeUser = _i1.createRelationTable(
      relationFieldName: 'smeUser',
      field: SmeAssignment.t.smeUserId,
      foreignField: _i4.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _smeUser!;
  }

  _i4.PharmaUserTable get invitedBy {
    if (_invitedBy != null) return _invitedBy!;
    _invitedBy = _i1.createRelationTable(
      relationFieldName: 'invitedBy',
      field: SmeAssignment.t.invitedById,
      foreignField: _i4.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _invitedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseId,
    courseVersionId,
    smeUserId,
    invitedById,
    status,
    invitedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'course') {
      return course;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'smeUser') {
      return smeUser;
    }
    if (relationField == 'invitedBy') {
      return invitedBy;
    }
    return null;
  }
}

class SmeAssignmentInclude extends _i1.IncludeObject {
  SmeAssignmentInclude._({
    _i2.CourseInclude? course,
    _i3.CourseVersionInclude? courseVersion,
    _i4.PharmaUserInclude? smeUser,
    _i4.PharmaUserInclude? invitedBy,
  }) {
    _course = course;
    _courseVersion = courseVersion;
    _smeUser = smeUser;
    _invitedBy = invitedBy;
  }

  _i2.CourseInclude? _course;

  _i3.CourseVersionInclude? _courseVersion;

  _i4.PharmaUserInclude? _smeUser;

  _i4.PharmaUserInclude? _invitedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'course': _course,
    'courseVersion': _courseVersion,
    'smeUser': _smeUser,
    'invitedBy': _invitedBy,
  };

  @override
  _i1.Table<int?> get table => SmeAssignment.t;
}

class SmeAssignmentIncludeList extends _i1.IncludeList {
  SmeAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<SmeAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SmeAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SmeAssignment.t;
}

class SmeAssignmentRepository {
  const SmeAssignmentRepository._();

  final attachRow = const SmeAssignmentAttachRowRepository._();

  final detachRow = const SmeAssignmentDetachRowRepository._();

  /// Returns a list of [SmeAssignment]s matching the given query parameters.
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
  Future<List<SmeAssignment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SmeAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SmeAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SmeAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    SmeAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SmeAssignment>(
      where: where?.call(SmeAssignment.t),
      orderBy: orderBy?.call(SmeAssignment.t),
      orderByList: orderByList?.call(SmeAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SmeAssignment] matching the given query parameters.
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
  Future<SmeAssignment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SmeAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<SmeAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SmeAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    SmeAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SmeAssignment>(
      where: where?.call(SmeAssignment.t),
      orderBy: orderBy?.call(SmeAssignment.t),
      orderByList: orderByList?.call(SmeAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SmeAssignment] by its [id] or null if no such row exists.
  Future<SmeAssignment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SmeAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SmeAssignment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SmeAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [SmeAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SmeAssignment>> insert(
    _i1.DatabaseSession session,
    List<SmeAssignment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SmeAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SmeAssignment] and returns the inserted row.
  ///
  /// The returned [SmeAssignment] will have its `id` field set.
  Future<SmeAssignment> insertRow(
    _i1.DatabaseSession session,
    SmeAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SmeAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SmeAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SmeAssignment>> update(
    _i1.DatabaseSession session,
    List<SmeAssignment> rows, {
    _i1.ColumnSelections<SmeAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SmeAssignment>(
      rows,
      columns: columns?.call(SmeAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SmeAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SmeAssignment> updateRow(
    _i1.DatabaseSession session,
    SmeAssignment row, {
    _i1.ColumnSelections<SmeAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SmeAssignment>(
      row,
      columns: columns?.call(SmeAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SmeAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SmeAssignment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SmeAssignmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SmeAssignment>(
      id,
      columnValues: columnValues(SmeAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SmeAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SmeAssignment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SmeAssignmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SmeAssignmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SmeAssignmentTable>? orderBy,
    _i1.OrderByListBuilder<SmeAssignmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SmeAssignment>(
      columnValues: columnValues(SmeAssignment.t.updateTable),
      where: where(SmeAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SmeAssignment.t),
      orderByList: orderByList?.call(SmeAssignment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SmeAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SmeAssignment>> delete(
    _i1.DatabaseSession session,
    List<SmeAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SmeAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SmeAssignment].
  Future<SmeAssignment> deleteRow(
    _i1.DatabaseSession session,
    SmeAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SmeAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SmeAssignment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SmeAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SmeAssignment>(
      where: where(SmeAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SmeAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SmeAssignment>(
      where: where?.call(SmeAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SmeAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SmeAssignmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SmeAssignment>(
      where: where(SmeAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SmeAssignmentAttachRowRepository {
  const SmeAssignmentAttachRowRepository._();

  /// Creates a relation between the given [SmeAssignment] and [Course]
  /// by setting the [SmeAssignment]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.DatabaseSession session,
    SmeAssignment smeAssignment,
    _i2.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (smeAssignment.id == null) {
      throw ArgumentError.notNull('smeAssignment.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $smeAssignment = smeAssignment.copyWith(courseId: course.id);
    await session.db.updateRow<SmeAssignment>(
      $smeAssignment,
      columns: [SmeAssignment.t.courseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SmeAssignment] and [CourseVersion]
  /// by setting the [SmeAssignment]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    SmeAssignment smeAssignment,
    _i3.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (smeAssignment.id == null) {
      throw ArgumentError.notNull('smeAssignment.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $smeAssignment = smeAssignment.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<SmeAssignment>(
      $smeAssignment,
      columns: [SmeAssignment.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SmeAssignment] and [PharmaUser]
  /// by setting the [SmeAssignment]'s foreign key `smeUserId` to refer to the [PharmaUser].
  Future<void> smeUser(
    _i1.DatabaseSession session,
    SmeAssignment smeAssignment,
    _i4.PharmaUser smeUser, {
    _i1.Transaction? transaction,
  }) async {
    if (smeAssignment.id == null) {
      throw ArgumentError.notNull('smeAssignment.id');
    }
    if (smeUser.id == null) {
      throw ArgumentError.notNull('smeUser.id');
    }

    var $smeAssignment = smeAssignment.copyWith(smeUserId: smeUser.id);
    await session.db.updateRow<SmeAssignment>(
      $smeAssignment,
      columns: [SmeAssignment.t.smeUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SmeAssignment] and [PharmaUser]
  /// by setting the [SmeAssignment]'s foreign key `invitedById` to refer to the [PharmaUser].
  Future<void> invitedBy(
    _i1.DatabaseSession session,
    SmeAssignment smeAssignment,
    _i4.PharmaUser invitedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (smeAssignment.id == null) {
      throw ArgumentError.notNull('smeAssignment.id');
    }
    if (invitedBy.id == null) {
      throw ArgumentError.notNull('invitedBy.id');
    }

    var $smeAssignment = smeAssignment.copyWith(invitedById: invitedBy.id);
    await session.db.updateRow<SmeAssignment>(
      $smeAssignment,
      columns: [SmeAssignment.t.invitedById],
      transaction: transaction,
    );
  }
}

class SmeAssignmentDetachRowRepository {
  const SmeAssignmentDetachRowRepository._();

  /// Detaches the relation between this [SmeAssignment] and the [CourseVersion] set in `courseVersion`
  /// by setting the [SmeAssignment]'s foreign key `courseVersionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    SmeAssignment smeAssignment, {
    _i1.Transaction? transaction,
  }) async {
    if (smeAssignment.id == null) {
      throw ArgumentError.notNull('smeAssignment.id');
    }

    var $smeAssignment = smeAssignment.copyWith(courseVersionId: null);
    await session.db.updateRow<SmeAssignment>(
      $smeAssignment,
      columns: [SmeAssignment.t.courseVersionId],
      transaction: transaction,
    );
  }
}
