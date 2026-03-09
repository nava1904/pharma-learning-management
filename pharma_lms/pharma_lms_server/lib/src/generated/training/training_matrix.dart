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
import '../organization/job_role.dart' as _i2;
import '../course/course.dart' as _i3;
import '../organization/site.dart' as _i4;
import '../organization/user.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Training matrix - role to course mapping. GMP.
abstract class TrainingMatrix
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingMatrix._({
    this.id,
    required this.jobRoleId,
    this.jobRole,
    required this.courseId,
    this.course,
    this.siteId,
    this.site,
    bool? isMandatory,
    int? dueDaysFromHire,
    this.retrainingIntervalDays,
    this.createdById,
    this.createdBy,
    this.approvedById,
    this.approvedBy,
    this.effectiveDate,
  }) : isMandatory = isMandatory ?? true,
       dueDaysFromHire = dueDaysFromHire ?? 60;

  factory TrainingMatrix({
    int? id,
    required int jobRoleId,
    _i2.JobRole? jobRole,
    required int courseId,
    _i3.Course? course,
    int? siteId,
    _i4.Site? site,
    bool? isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? createdById,
    _i5.PharmaUser? createdBy,
    int? approvedById,
    _i5.PharmaUser? approvedBy,
    DateTime? effectiveDate,
  }) = _TrainingMatrixImpl;

  factory TrainingMatrix.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingMatrix(
      id: jsonSerialization['id'] as int?,
      jobRoleId: jsonSerialization['jobRoleId'] as int,
      jobRole: jsonSerialization['jobRole'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.JobRole>(
              jsonSerialization['jobRole'],
            ),
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Course>(jsonSerialization['course']),
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Site>(jsonSerialization['site']),
      isMandatory: jsonSerialization['isMandatory'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMandatory']),
      dueDaysFromHire: jsonSerialization['dueDaysFromHire'] as int?,
      retrainingIntervalDays:
          jsonSerialization['retrainingIntervalDays'] as int?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      approvedById: jsonSerialization['approvedById'] as int?,
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.PharmaUser>(
              jsonSerialization['approvedBy'],
            ),
      effectiveDate: jsonSerialization['effectiveDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectiveDate'],
            ),
    );
  }

  static final t = TrainingMatrixTable();

  static const db = TrainingMatrixRepository._();

  @override
  int? id;

  int jobRoleId;

  /// The job role.
  _i2.JobRole? jobRole;

  int courseId;

  /// The course.
  _i3.Course? course;

  int? siteId;

  /// Site (nullable for org-wide).
  _i4.Site? site;

  /// Whether mandatory for this role.
  bool isMandatory;

  /// Days from hire to complete (default 60 for onboarding).
  int dueDaysFromHire;

  /// Retraining interval in days (for recurring certs).
  int? retrainingIntervalDays;

  int? createdById;

  /// Who created.
  _i5.PharmaUser? createdBy;

  int? approvedById;

  /// QA approval for matrix changes.
  _i5.PharmaUser? approvedBy;

  /// When effective.
  DateTime? effectiveDate;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingMatrix]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingMatrix copyWith({
    int? id,
    int? jobRoleId,
    _i2.JobRole? jobRole,
    int? courseId,
    _i3.Course? course,
    int? siteId,
    _i4.Site? site,
    bool? isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? createdById,
    _i5.PharmaUser? createdBy,
    int? approvedById,
    _i5.PharmaUser? approvedBy,
    DateTime? effectiveDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingMatrix',
      if (id != null) 'id': id,
      'jobRoleId': jobRoleId,
      if (jobRole != null) 'jobRole': jobRole?.toJson(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'isMandatory': isMandatory,
      'dueDaysFromHire': dueDaysFromHire,
      if (retrainingIntervalDays != null)
        'retrainingIntervalDays': retrainingIntervalDays,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      if (approvedById != null) 'approvedById': approvedById,
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingMatrix',
      if (id != null) 'id': id,
      'jobRoleId': jobRoleId,
      if (jobRole != null) 'jobRole': jobRole?.toJsonForProtocol(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJsonForProtocol(),
      'isMandatory': isMandatory,
      'dueDaysFromHire': dueDaysFromHire,
      if (retrainingIntervalDays != null)
        'retrainingIntervalDays': retrainingIntervalDays,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      if (approvedById != null) 'approvedById': approvedById,
      if (approvedBy != null) 'approvedBy': approvedBy?.toJsonForProtocol(),
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
    };
  }

  static TrainingMatrixInclude include({
    _i2.JobRoleInclude? jobRole,
    _i3.CourseInclude? course,
    _i4.SiteInclude? site,
    _i5.PharmaUserInclude? createdBy,
    _i5.PharmaUserInclude? approvedBy,
  }) {
    return TrainingMatrixInclude._(
      jobRole: jobRole,
      course: course,
      site: site,
      createdBy: createdBy,
      approvedBy: approvedBy,
    );
  }

  static TrainingMatrixIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingMatrixTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingMatrixTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingMatrixTable>? orderByList,
    TrainingMatrixInclude? include,
  }) {
    return TrainingMatrixIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingMatrix.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingMatrix.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingMatrixImpl extends TrainingMatrix {
  _TrainingMatrixImpl({
    int? id,
    required int jobRoleId,
    _i2.JobRole? jobRole,
    required int courseId,
    _i3.Course? course,
    int? siteId,
    _i4.Site? site,
    bool? isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? createdById,
    _i5.PharmaUser? createdBy,
    int? approvedById,
    _i5.PharmaUser? approvedBy,
    DateTime? effectiveDate,
  }) : super._(
         id: id,
         jobRoleId: jobRoleId,
         jobRole: jobRole,
         courseId: courseId,
         course: course,
         siteId: siteId,
         site: site,
         isMandatory: isMandatory,
         dueDaysFromHire: dueDaysFromHire,
         retrainingIntervalDays: retrainingIntervalDays,
         createdById: createdById,
         createdBy: createdBy,
         approvedById: approvedById,
         approvedBy: approvedBy,
         effectiveDate: effectiveDate,
       );

  /// Returns a shallow copy of this [TrainingMatrix]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingMatrix copyWith({
    Object? id = _Undefined,
    int? jobRoleId,
    Object? jobRole = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    bool? isMandatory,
    int? dueDaysFromHire,
    Object? retrainingIntervalDays = _Undefined,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    Object? approvedById = _Undefined,
    Object? approvedBy = _Undefined,
    Object? effectiveDate = _Undefined,
  }) {
    return TrainingMatrix(
      id: id is int? ? id : this.id,
      jobRoleId: jobRoleId ?? this.jobRoleId,
      jobRole: jobRole is _i2.JobRole? ? jobRole : this.jobRole?.copyWith(),
      courseId: courseId ?? this.courseId,
      course: course is _i3.Course? ? course : this.course?.copyWith(),
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i4.Site? ? site : this.site?.copyWith(),
      isMandatory: isMandatory ?? this.isMandatory,
      dueDaysFromHire: dueDaysFromHire ?? this.dueDaysFromHire,
      retrainingIntervalDays: retrainingIntervalDays is int?
          ? retrainingIntervalDays
          : this.retrainingIntervalDays,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i5.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      approvedById: approvedById is int? ? approvedById : this.approvedById,
      approvedBy: approvedBy is _i5.PharmaUser?
          ? approvedBy
          : this.approvedBy?.copyWith(),
      effectiveDate: effectiveDate is DateTime?
          ? effectiveDate
          : this.effectiveDate,
    );
  }
}

class TrainingMatrixUpdateTable extends _i1.UpdateTable<TrainingMatrixTable> {
  TrainingMatrixUpdateTable(super.table);

  _i1.ColumnValue<int, int> jobRoleId(int value) => _i1.ColumnValue(
    table.jobRoleId,
    value,
  );

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int? value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<bool, bool> isMandatory(bool value) => _i1.ColumnValue(
    table.isMandatory,
    value,
  );

  _i1.ColumnValue<int, int> dueDaysFromHire(int value) => _i1.ColumnValue(
    table.dueDaysFromHire,
    value,
  );

  _i1.ColumnValue<int, int> retrainingIntervalDays(int? value) =>
      _i1.ColumnValue(
        table.retrainingIntervalDays,
        value,
      );

  _i1.ColumnValue<int, int> createdById(int? value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<int, int> approvedById(int? value) => _i1.ColumnValue(
    table.approvedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> effectiveDate(DateTime? value) =>
      _i1.ColumnValue(
        table.effectiveDate,
        value,
      );
}

class TrainingMatrixTable extends _i1.Table<int?> {
  TrainingMatrixTable({super.tableRelation})
    : super(tableName: 'training_matrix') {
    updateTable = TrainingMatrixUpdateTable(this);
    jobRoleId = _i1.ColumnInt(
      'jobRoleId',
      this,
    );
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    isMandatory = _i1.ColumnBool(
      'isMandatory',
      this,
      hasDefault: true,
    );
    dueDaysFromHire = _i1.ColumnInt(
      'dueDaysFromHire',
      this,
      hasDefault: true,
    );
    retrainingIntervalDays = _i1.ColumnInt(
      'retrainingIntervalDays',
      this,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    approvedById = _i1.ColumnInt(
      'approvedById',
      this,
    );
    effectiveDate = _i1.ColumnDateTime(
      'effectiveDate',
      this,
    );
  }

  late final TrainingMatrixUpdateTable updateTable;

  late final _i1.ColumnInt jobRoleId;

  /// The job role.
  _i2.JobRoleTable? _jobRole;

  late final _i1.ColumnInt courseId;

  /// The course.
  _i3.CourseTable? _course;

  late final _i1.ColumnInt siteId;

  /// Site (nullable for org-wide).
  _i4.SiteTable? _site;

  /// Whether mandatory for this role.
  late final _i1.ColumnBool isMandatory;

  /// Days from hire to complete (default 60 for onboarding).
  late final _i1.ColumnInt dueDaysFromHire;

  /// Retraining interval in days (for recurring certs).
  late final _i1.ColumnInt retrainingIntervalDays;

  late final _i1.ColumnInt createdById;

  /// Who created.
  _i5.PharmaUserTable? _createdBy;

  late final _i1.ColumnInt approvedById;

  /// QA approval for matrix changes.
  _i5.PharmaUserTable? _approvedBy;

  /// When effective.
  late final _i1.ColumnDateTime effectiveDate;

  _i2.JobRoleTable get jobRole {
    if (_jobRole != null) return _jobRole!;
    _jobRole = _i1.createRelationTable(
      relationFieldName: 'jobRole',
      field: TrainingMatrix.t.jobRoleId,
      foreignField: _i2.JobRole.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobRoleTable(tableRelation: foreignTableRelation),
    );
    return _jobRole!;
  }

  _i3.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: TrainingMatrix.t.courseId,
      foreignField: _i3.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  _i4.SiteTable get site {
    if (_site != null) return _site!;
    _site = _i1.createRelationTable(
      relationFieldName: 'site',
      field: TrainingMatrix.t.siteId,
      foreignField: _i4.Site.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SiteTable(tableRelation: foreignTableRelation),
    );
    return _site!;
  }

  _i5.PharmaUserTable get createdBy {
    if (_createdBy != null) return _createdBy!;
    _createdBy = _i1.createRelationTable(
      relationFieldName: 'createdBy',
      field: TrainingMatrix.t.createdById,
      foreignField: _i5.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _createdBy!;
  }

  _i5.PharmaUserTable get approvedBy {
    if (_approvedBy != null) return _approvedBy!;
    _approvedBy = _i1.createRelationTable(
      relationFieldName: 'approvedBy',
      field: TrainingMatrix.t.approvedById,
      foreignField: _i5.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _approvedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    jobRoleId,
    courseId,
    siteId,
    isMandatory,
    dueDaysFromHire,
    retrainingIntervalDays,
    createdById,
    approvedById,
    effectiveDate,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobRole') {
      return jobRole;
    }
    if (relationField == 'course') {
      return course;
    }
    if (relationField == 'site') {
      return site;
    }
    if (relationField == 'createdBy') {
      return createdBy;
    }
    if (relationField == 'approvedBy') {
      return approvedBy;
    }
    return null;
  }
}

class TrainingMatrixInclude extends _i1.IncludeObject {
  TrainingMatrixInclude._({
    _i2.JobRoleInclude? jobRole,
    _i3.CourseInclude? course,
    _i4.SiteInclude? site,
    _i5.PharmaUserInclude? createdBy,
    _i5.PharmaUserInclude? approvedBy,
  }) {
    _jobRole = jobRole;
    _course = course;
    _site = site;
    _createdBy = createdBy;
    _approvedBy = approvedBy;
  }

  _i2.JobRoleInclude? _jobRole;

  _i3.CourseInclude? _course;

  _i4.SiteInclude? _site;

  _i5.PharmaUserInclude? _createdBy;

  _i5.PharmaUserInclude? _approvedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'jobRole': _jobRole,
    'course': _course,
    'site': _site,
    'createdBy': _createdBy,
    'approvedBy': _approvedBy,
  };

  @override
  _i1.Table<int?> get table => TrainingMatrix.t;
}

class TrainingMatrixIncludeList extends _i1.IncludeList {
  TrainingMatrixIncludeList._({
    _i1.WhereExpressionBuilder<TrainingMatrixTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingMatrix.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingMatrix.t;
}

class TrainingMatrixRepository {
  const TrainingMatrixRepository._();

  final attachRow = const TrainingMatrixAttachRowRepository._();

  final detachRow = const TrainingMatrixDetachRowRepository._();

  /// Returns a list of [TrainingMatrix]s matching the given query parameters.
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
  Future<List<TrainingMatrix>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TrainingMatrixTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingMatrixTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingMatrixTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingMatrixInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingMatrix>(
      where: where?.call(TrainingMatrix.t),
      orderBy: orderBy?.call(TrainingMatrix.t),
      orderByList: orderByList?.call(TrainingMatrix.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingMatrix] matching the given query parameters.
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
  Future<TrainingMatrix?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TrainingMatrixTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingMatrixTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingMatrixTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingMatrixInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingMatrix>(
      where: where?.call(TrainingMatrix.t),
      orderBy: orderBy?.call(TrainingMatrix.t),
      orderByList: orderByList?.call(TrainingMatrix.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingMatrix] by its [id] or null if no such row exists.
  Future<TrainingMatrix?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TrainingMatrixInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingMatrix>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingMatrix]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingMatrix]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingMatrix>> insert(
    _i1.Session session,
    List<TrainingMatrix> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingMatrix>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingMatrix] and returns the inserted row.
  ///
  /// The returned [TrainingMatrix] will have its `id` field set.
  Future<TrainingMatrix> insertRow(
    _i1.Session session,
    TrainingMatrix row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingMatrix>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingMatrix]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingMatrix>> update(
    _i1.Session session,
    List<TrainingMatrix> rows, {
    _i1.ColumnSelections<TrainingMatrixTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingMatrix>(
      rows,
      columns: columns?.call(TrainingMatrix.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingMatrix]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingMatrix> updateRow(
    _i1.Session session,
    TrainingMatrix row, {
    _i1.ColumnSelections<TrainingMatrixTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingMatrix>(
      row,
      columns: columns?.call(TrainingMatrix.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingMatrix] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingMatrix?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingMatrixUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingMatrix>(
      id,
      columnValues: columnValues(TrainingMatrix.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingMatrix]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingMatrix>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TrainingMatrixUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TrainingMatrixTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingMatrixTable>? orderBy,
    _i1.OrderByListBuilder<TrainingMatrixTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingMatrix>(
      columnValues: columnValues(TrainingMatrix.t.updateTable),
      where: where(TrainingMatrix.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingMatrix.t),
      orderByList: orderByList?.call(TrainingMatrix.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingMatrix]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingMatrix>> delete(
    _i1.Session session,
    List<TrainingMatrix> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingMatrix>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingMatrix].
  Future<TrainingMatrix> deleteRow(
    _i1.Session session,
    TrainingMatrix row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingMatrix>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingMatrix>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TrainingMatrixTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingMatrix>(
      where: where(TrainingMatrix.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TrainingMatrixTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingMatrix>(
      where: where?.call(TrainingMatrix.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingMatrix] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TrainingMatrixTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingMatrix>(
      where: where(TrainingMatrix.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingMatrixAttachRowRepository {
  const TrainingMatrixAttachRowRepository._();

  /// Creates a relation between the given [TrainingMatrix] and [JobRole]
  /// by setting the [TrainingMatrix]'s foreign key `jobRoleId` to refer to the [JobRole].
  Future<void> jobRole(
    _i1.Session session,
    TrainingMatrix trainingMatrix,
    _i2.JobRole jobRole, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }
    if (jobRole.id == null) {
      throw ArgumentError.notNull('jobRole.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(jobRoleId: jobRole.id);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.jobRoleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingMatrix] and [Course]
  /// by setting the [TrainingMatrix]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.Session session,
    TrainingMatrix trainingMatrix,
    _i3.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(courseId: course.id);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.courseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingMatrix] and [Site]
  /// by setting the [TrainingMatrix]'s foreign key `siteId` to refer to the [Site].
  Future<void> site(
    _i1.Session session,
    TrainingMatrix trainingMatrix,
    _i4.Site site, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(siteId: site.id);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.siteId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingMatrix] and [PharmaUser]
  /// by setting the [TrainingMatrix]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.Session session,
    TrainingMatrix trainingMatrix,
    _i5.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(createdById: createdBy.id);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.createdById],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingMatrix] and [PharmaUser]
  /// by setting the [TrainingMatrix]'s foreign key `approvedById` to refer to the [PharmaUser].
  Future<void> approvedBy(
    _i1.Session session,
    TrainingMatrix trainingMatrix,
    _i5.PharmaUser approvedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }
    if (approvedBy.id == null) {
      throw ArgumentError.notNull('approvedBy.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(approvedById: approvedBy.id);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.approvedById],
      transaction: transaction,
    );
  }
}

class TrainingMatrixDetachRowRepository {
  const TrainingMatrixDetachRowRepository._();

  /// Detaches the relation between this [TrainingMatrix] and the [Site] set in `site`
  /// by setting the [TrainingMatrix]'s foreign key `siteId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> site(
    _i1.Session session,
    TrainingMatrix trainingMatrix, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(siteId: null);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.siteId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [TrainingMatrix] and the [PharmaUser] set in `createdBy`
  /// by setting the [TrainingMatrix]'s foreign key `createdById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> createdBy(
    _i1.Session session,
    TrainingMatrix trainingMatrix, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(createdById: null);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.createdById],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [TrainingMatrix] and the [PharmaUser] set in `approvedBy`
  /// by setting the [TrainingMatrix]'s foreign key `approvedById` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> approvedBy(
    _i1.Session session,
    TrainingMatrix trainingMatrix, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingMatrix.id == null) {
      throw ArgumentError.notNull('trainingMatrix.id');
    }

    var $trainingMatrix = trainingMatrix.copyWith(approvedById: null);
    await session.db.updateRow<TrainingMatrix>(
      $trainingMatrix,
      columns: [TrainingMatrix.t.approvedById],
      transaction: transaction,
    );
  }
}
