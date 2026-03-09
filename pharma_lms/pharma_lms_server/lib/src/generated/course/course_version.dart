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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Versioned course - immutable history for compliance.
abstract class CourseVersion
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CourseVersion._({
    this.id,
    required this.courseId,
    this.course,
    required this.version,
    this.effectiveDate,
    this.obsoleteDate,
    String? status,
    this.supersededByVersionId,
    this.changeSummary,
  }) : status = status ?? 'draft';

  factory CourseVersion({
    int? id,
    required int courseId,
    _i2.Course? course,
    required String version,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    String? status,
    int? supersededByVersionId,
    String? changeSummary,
  }) = _CourseVersionImpl;

  factory CourseVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseVersion(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      version: jsonSerialization['version'] as String,
      effectiveDate: jsonSerialization['effectiveDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectiveDate'],
            ),
      obsoleteDate: jsonSerialization['obsoleteDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['obsoleteDate'],
            ),
      status: jsonSerialization['status'] as String?,
      supersededByVersionId: jsonSerialization['supersededByVersionId'] as int?,
      changeSummary: jsonSerialization['changeSummary'] as String?,
    );
  }

  static final t = CourseVersionTable();

  static const db = CourseVersionRepository._();

  @override
  int? id;

  int courseId;

  /// The course.
  _i2.Course? course;

  /// Version string (e.g., 1.0, 2.0).
  String version;

  /// When this version becomes effective.
  DateTime? effectiveDate;

  /// When this version is obsolete.
  DateTime? obsoleteDate;

  /// Status: draft, approved, effective, obsolete.
  String status;

  /// Version that supersedes this one (when obsolete).
  int? supersededByVersionId;

  /// Change summary when creating new version from existing (TRN-05).
  String? changeSummary;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseVersion copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    String? version,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    String? status,
    int? supersededByVersionId,
    String? changeSummary,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseVersion',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'version': version,
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
      if (obsoleteDate != null) 'obsoleteDate': obsoleteDate?.toJson(),
      'status': status,
      if (supersededByVersionId != null)
        'supersededByVersionId': supersededByVersionId,
      if (changeSummary != null) 'changeSummary': changeSummary,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseVersion',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      'version': version,
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
      if (obsoleteDate != null) 'obsoleteDate': obsoleteDate?.toJson(),
      'status': status,
      if (supersededByVersionId != null)
        'supersededByVersionId': supersededByVersionId,
      if (changeSummary != null) 'changeSummary': changeSummary,
    };
  }

  static CourseVersionInclude include({_i2.CourseInclude? course}) {
    return CourseVersionInclude._(course: course);
  }

  static CourseVersionIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseVersionTable>? orderByList,
    CourseVersionInclude? include,
  }) {
    return CourseVersionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseVersion.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CourseVersion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseVersionImpl extends CourseVersion {
  _CourseVersionImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    required String version,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    String? status,
    int? supersededByVersionId,
    String? changeSummary,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         version: version,
         effectiveDate: effectiveDate,
         obsoleteDate: obsoleteDate,
         status: status,
         supersededByVersionId: supersededByVersionId,
         changeSummary: changeSummary,
       );

  /// Returns a shallow copy of this [CourseVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseVersion copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    String? version,
    Object? effectiveDate = _Undefined,
    Object? obsoleteDate = _Undefined,
    String? status,
    Object? supersededByVersionId = _Undefined,
    Object? changeSummary = _Undefined,
  }) {
    return CourseVersion(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      version: version ?? this.version,
      effectiveDate: effectiveDate is DateTime?
          ? effectiveDate
          : this.effectiveDate,
      obsoleteDate: obsoleteDate is DateTime?
          ? obsoleteDate
          : this.obsoleteDate,
      status: status ?? this.status,
      supersededByVersionId: supersededByVersionId is int?
          ? supersededByVersionId
          : this.supersededByVersionId,
      changeSummary: changeSummary is String?
          ? changeSummary
          : this.changeSummary,
    );
  }
}

class CourseVersionUpdateTable extends _i1.UpdateTable<CourseVersionTable> {
  CourseVersionUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> effectiveDate(DateTime? value) =>
      _i1.ColumnValue(
        table.effectiveDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> obsoleteDate(DateTime? value) =>
      _i1.ColumnValue(
        table.obsoleteDate,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> supersededByVersionId(int? value) =>
      _i1.ColumnValue(
        table.supersededByVersionId,
        value,
      );

  _i1.ColumnValue<String, String> changeSummary(String? value) =>
      _i1.ColumnValue(
        table.changeSummary,
        value,
      );
}

class CourseVersionTable extends _i1.Table<int?> {
  CourseVersionTable({super.tableRelation})
    : super(tableName: 'course_version') {
    updateTable = CourseVersionUpdateTable(this);
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    version = _i1.ColumnString(
      'version',
      this,
    );
    effectiveDate = _i1.ColumnDateTime(
      'effectiveDate',
      this,
    );
    obsoleteDate = _i1.ColumnDateTime(
      'obsoleteDate',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    supersededByVersionId = _i1.ColumnInt(
      'supersededByVersionId',
      this,
    );
    changeSummary = _i1.ColumnString(
      'changeSummary',
      this,
    );
  }

  late final CourseVersionUpdateTable updateTable;

  late final _i1.ColumnInt courseId;

  /// The course.
  _i2.CourseTable? _course;

  /// Version string (e.g., 1.0, 2.0).
  late final _i1.ColumnString version;

  /// When this version becomes effective.
  late final _i1.ColumnDateTime effectiveDate;

  /// When this version is obsolete.
  late final _i1.ColumnDateTime obsoleteDate;

  /// Status: draft, approved, effective, obsolete.
  late final _i1.ColumnString status;

  /// Version that supersedes this one (when obsolete).
  late final _i1.ColumnInt supersededByVersionId;

  /// Change summary when creating new version from existing (TRN-05).
  late final _i1.ColumnString changeSummary;

  _i2.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: CourseVersion.t.courseId,
      foreignField: _i2.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseId,
    version,
    effectiveDate,
    obsoleteDate,
    status,
    supersededByVersionId,
    changeSummary,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'course') {
      return course;
    }
    return null;
  }
}

class CourseVersionInclude extends _i1.IncludeObject {
  CourseVersionInclude._({_i2.CourseInclude? course}) {
    _course = course;
  }

  _i2.CourseInclude? _course;

  @override
  Map<String, _i1.Include?> get includes => {'course': _course};

  @override
  _i1.Table<int?> get table => CourseVersion.t;
}

class CourseVersionIncludeList extends _i1.IncludeList {
  CourseVersionIncludeList._({
    _i1.WhereExpressionBuilder<CourseVersionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseVersion.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CourseVersion.t;
}

class CourseVersionRepository {
  const CourseVersionRepository._();

  final attachRow = const CourseVersionAttachRowRepository._();

  /// Returns a list of [CourseVersion]s matching the given query parameters.
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
  Future<List<CourseVersion>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourseVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseVersionTable>? orderByList,
    _i1.Transaction? transaction,
    CourseVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseVersion>(
      where: where?.call(CourseVersion.t),
      orderBy: orderBy?.call(CourseVersion.t),
      orderByList: orderByList?.call(CourseVersion.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseVersion] matching the given query parameters.
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
  Future<CourseVersion?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourseVersionTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseVersionTable>? orderByList,
    _i1.Transaction? transaction,
    CourseVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseVersion>(
      where: where?.call(CourseVersion.t),
      orderBy: orderBy?.call(CourseVersion.t),
      orderByList: orderByList?.call(CourseVersion.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseVersion] by its [id] or null if no such row exists.
  Future<CourseVersion?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CourseVersionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseVersion>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseVersion]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseVersion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CourseVersion>> insert(
    _i1.Session session,
    List<CourseVersion> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CourseVersion>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CourseVersion] and returns the inserted row.
  ///
  /// The returned [CourseVersion] will have its `id` field set.
  Future<CourseVersion> insertRow(
    _i1.Session session,
    CourseVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CourseVersion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CourseVersion>> update(
    _i1.Session session,
    List<CourseVersion> rows, {
    _i1.ColumnSelections<CourseVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CourseVersion>(
      rows,
      columns: columns?.call(CourseVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseVersion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseVersion> updateRow(
    _i1.Session session,
    CourseVersion row, {
    _i1.ColumnSelections<CourseVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseVersion>(
      row,
      columns: columns?.call(CourseVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseVersion] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseVersion?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseVersionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseVersion>(
      id,
      columnValues: columnValues(CourseVersion.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseVersion]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CourseVersion>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CourseVersionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourseVersionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseVersionTable>? orderBy,
    _i1.OrderByListBuilder<CourseVersionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CourseVersion>(
      columnValues: columnValues(CourseVersion.t.updateTable),
      where: where(CourseVersion.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseVersion.t),
      orderByList: orderByList?.call(CourseVersion.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CourseVersion]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CourseVersion>> delete(
    _i1.Session session,
    List<CourseVersion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CourseVersion>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CourseVersion].
  Future<CourseVersion> deleteRow(
    _i1.Session session,
    CourseVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CourseVersion>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CourseVersionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CourseVersion>(
      where: where(CourseVersion.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourseVersionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CourseVersion>(
      where: where?.call(CourseVersion.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseVersion] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CourseVersionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseVersion>(
      where: where(CourseVersion.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CourseVersionAttachRowRepository {
  const CourseVersionAttachRowRepository._();

  /// Creates a relation between the given [CourseVersion] and [Course]
  /// by setting the [CourseVersion]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.Session session,
    CourseVersion courseVersion,
    _i2.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $courseVersion = courseVersion.copyWith(courseId: course.id);
    await session.db.updateRow<CourseVersion>(
      $courseVersion,
      columns: [CourseVersion.t.courseId],
      transaction: transaction,
    );
  }
}
