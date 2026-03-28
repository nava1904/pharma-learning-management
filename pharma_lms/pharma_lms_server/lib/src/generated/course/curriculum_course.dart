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
import '../course/curriculum.dart' as _i2;
import '../course/course.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Membership of a course in a curriculum.
abstract class CurriculumCourse
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CurriculumCourse._({
    this.id,
    required this.curriculumId,
    this.curriculum,
    required this.courseId,
    this.course,
    int? sortOrder,
  }) : sortOrder = sortOrder ?? 0;

  factory CurriculumCourse({
    int? id,
    required int curriculumId,
    _i2.Curriculum? curriculum,
    required int courseId,
    _i3.Course? course,
    int? sortOrder,
  }) = _CurriculumCourseImpl;

  factory CurriculumCourse.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurriculumCourse(
      id: jsonSerialization['id'] as int?,
      curriculumId: jsonSerialization['curriculumId'] as int,
      curriculum: jsonSerialization['curriculum'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Curriculum>(
              jsonSerialization['curriculum'],
            ),
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Course>(jsonSerialization['course']),
      sortOrder: jsonSerialization['sortOrder'] as int?,
    );
  }

  static final t = CurriculumCourseTable();

  static const db = CurriculumCourseRepository._();

  @override
  int? id;

  int curriculumId;

  _i2.Curriculum? curriculum;

  int courseId;

  _i3.Course? course;

  int sortOrder;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CurriculumCourse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurriculumCourse copyWith({
    int? id,
    int? curriculumId,
    _i2.Curriculum? curriculum,
    int? courseId,
    _i3.Course? course,
    int? sortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumCourse',
      if (id != null) 'id': id,
      'curriculumId': curriculumId,
      if (curriculum != null) 'curriculum': curriculum?.toJson(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'sortOrder': sortOrder,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurriculumCourse',
      if (id != null) 'id': id,
      'curriculumId': curriculumId,
      if (curriculum != null) 'curriculum': curriculum?.toJsonForProtocol(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      'sortOrder': sortOrder,
    };
  }

  static CurriculumCourseInclude include({
    _i2.CurriculumInclude? curriculum,
    _i3.CourseInclude? course,
  }) {
    return CurriculumCourseInclude._(
      curriculum: curriculum,
      course: course,
    );
  }

  static CurriculumCourseIncludeList includeList({
    _i1.WhereExpressionBuilder<CurriculumCourseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurriculumCourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurriculumCourseTable>? orderByList,
    CurriculumCourseInclude? include,
  }) {
    return CurriculumCourseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CurriculumCourse.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CurriculumCourse.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurriculumCourseImpl extends CurriculumCourse {
  _CurriculumCourseImpl({
    int? id,
    required int curriculumId,
    _i2.Curriculum? curriculum,
    required int courseId,
    _i3.Course? course,
    int? sortOrder,
  }) : super._(
         id: id,
         curriculumId: curriculumId,
         curriculum: curriculum,
         courseId: courseId,
         course: course,
         sortOrder: sortOrder,
       );

  /// Returns a shallow copy of this [CurriculumCourse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurriculumCourse copyWith({
    Object? id = _Undefined,
    int? curriculumId,
    Object? curriculum = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? sortOrder,
  }) {
    return CurriculumCourse(
      id: id is int? ? id : this.id,
      curriculumId: curriculumId ?? this.curriculumId,
      curriculum: curriculum is _i2.Curriculum?
          ? curriculum
          : this.curriculum?.copyWith(),
      courseId: courseId ?? this.courseId,
      course: course is _i3.Course? ? course : this.course?.copyWith(),
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

class CurriculumCourseUpdateTable
    extends _i1.UpdateTable<CurriculumCourseTable> {
  CurriculumCourseUpdateTable(super.table);

  _i1.ColumnValue<int, int> curriculumId(int value) => _i1.ColumnValue(
    table.curriculumId,
    value,
  );

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> sortOrder(int value) => _i1.ColumnValue(
    table.sortOrder,
    value,
  );
}

class CurriculumCourseTable extends _i1.Table<int?> {
  CurriculumCourseTable({super.tableRelation})
    : super(tableName: 'curriculum_course') {
    updateTable = CurriculumCourseUpdateTable(this);
    curriculumId = _i1.ColumnInt(
      'curriculumId',
      this,
    );
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
  }

  late final CurriculumCourseUpdateTable updateTable;

  late final _i1.ColumnInt curriculumId;

  _i2.CurriculumTable? _curriculum;

  late final _i1.ColumnInt courseId;

  _i3.CourseTable? _course;

  late final _i1.ColumnInt sortOrder;

  _i2.CurriculumTable get curriculum {
    if (_curriculum != null) return _curriculum!;
    _curriculum = _i1.createRelationTable(
      relationFieldName: 'curriculum',
      field: CurriculumCourse.t.curriculumId,
      foreignField: _i2.Curriculum.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CurriculumTable(tableRelation: foreignTableRelation),
    );
    return _curriculum!;
  }

  _i3.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: CurriculumCourse.t.courseId,
      foreignField: _i3.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    curriculumId,
    courseId,
    sortOrder,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'curriculum') {
      return curriculum;
    }
    if (relationField == 'course') {
      return course;
    }
    return null;
  }
}

class CurriculumCourseInclude extends _i1.IncludeObject {
  CurriculumCourseInclude._({
    _i2.CurriculumInclude? curriculum,
    _i3.CourseInclude? course,
  }) {
    _curriculum = curriculum;
    _course = course;
  }

  _i2.CurriculumInclude? _curriculum;

  _i3.CourseInclude? _course;

  @override
  Map<String, _i1.Include?> get includes => {
    'curriculum': _curriculum,
    'course': _course,
  };

  @override
  _i1.Table<int?> get table => CurriculumCourse.t;
}

class CurriculumCourseIncludeList extends _i1.IncludeList {
  CurriculumCourseIncludeList._({
    _i1.WhereExpressionBuilder<CurriculumCourseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CurriculumCourse.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CurriculumCourse.t;
}

class CurriculumCourseRepository {
  const CurriculumCourseRepository._();

  final attachRow = const CurriculumCourseAttachRowRepository._();

  /// Returns a list of [CurriculumCourse]s matching the given query parameters.
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
  Future<List<CurriculumCourse>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CurriculumCourseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurriculumCourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurriculumCourseTable>? orderByList,
    _i1.Transaction? transaction,
    CurriculumCourseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CurriculumCourse>(
      where: where?.call(CurriculumCourse.t),
      orderBy: orderBy?.call(CurriculumCourse.t),
      orderByList: orderByList?.call(CurriculumCourse.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CurriculumCourse] matching the given query parameters.
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
  Future<CurriculumCourse?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CurriculumCourseTable>? where,
    int? offset,
    _i1.OrderByBuilder<CurriculumCourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CurriculumCourseTable>? orderByList,
    _i1.Transaction? transaction,
    CurriculumCourseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CurriculumCourse>(
      where: where?.call(CurriculumCourse.t),
      orderBy: orderBy?.call(CurriculumCourse.t),
      orderByList: orderByList?.call(CurriculumCourse.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CurriculumCourse] by its [id] or null if no such row exists.
  Future<CurriculumCourse?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CurriculumCourseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CurriculumCourse>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CurriculumCourse]s in the list and returns the inserted rows.
  ///
  /// The returned [CurriculumCourse]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CurriculumCourse>> insert(
    _i1.DatabaseSession session,
    List<CurriculumCourse> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CurriculumCourse>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CurriculumCourse] and returns the inserted row.
  ///
  /// The returned [CurriculumCourse] will have its `id` field set.
  Future<CurriculumCourse> insertRow(
    _i1.DatabaseSession session,
    CurriculumCourse row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CurriculumCourse>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CurriculumCourse]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CurriculumCourse>> update(
    _i1.DatabaseSession session,
    List<CurriculumCourse> rows, {
    _i1.ColumnSelections<CurriculumCourseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CurriculumCourse>(
      rows,
      columns: columns?.call(CurriculumCourse.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CurriculumCourse]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CurriculumCourse> updateRow(
    _i1.DatabaseSession session,
    CurriculumCourse row, {
    _i1.ColumnSelections<CurriculumCourseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CurriculumCourse>(
      row,
      columns: columns?.call(CurriculumCourse.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CurriculumCourse] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CurriculumCourse?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CurriculumCourseUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CurriculumCourse>(
      id,
      columnValues: columnValues(CurriculumCourse.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CurriculumCourse]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CurriculumCourse>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CurriculumCourseUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CurriculumCourseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CurriculumCourseTable>? orderBy,
    _i1.OrderByListBuilder<CurriculumCourseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CurriculumCourse>(
      columnValues: columnValues(CurriculumCourse.t.updateTable),
      where: where(CurriculumCourse.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CurriculumCourse.t),
      orderByList: orderByList?.call(CurriculumCourse.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CurriculumCourse]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CurriculumCourse>> delete(
    _i1.DatabaseSession session,
    List<CurriculumCourse> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CurriculumCourse>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CurriculumCourse].
  Future<CurriculumCourse> deleteRow(
    _i1.DatabaseSession session,
    CurriculumCourse row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CurriculumCourse>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CurriculumCourse>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CurriculumCourseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CurriculumCourse>(
      where: where(CurriculumCourse.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CurriculumCourseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CurriculumCourse>(
      where: where?.call(CurriculumCourse.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CurriculumCourse] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CurriculumCourseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CurriculumCourse>(
      where: where(CurriculumCourse.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CurriculumCourseAttachRowRepository {
  const CurriculumCourseAttachRowRepository._();

  /// Creates a relation between the given [CurriculumCourse] and [Curriculum]
  /// by setting the [CurriculumCourse]'s foreign key `curriculumId` to refer to the [Curriculum].
  Future<void> curriculum(
    _i1.DatabaseSession session,
    CurriculumCourse curriculumCourse,
    _i2.Curriculum curriculum, {
    _i1.Transaction? transaction,
  }) async {
    if (curriculumCourse.id == null) {
      throw ArgumentError.notNull('curriculumCourse.id');
    }
    if (curriculum.id == null) {
      throw ArgumentError.notNull('curriculum.id');
    }

    var $curriculumCourse = curriculumCourse.copyWith(
      curriculumId: curriculum.id,
    );
    await session.db.updateRow<CurriculumCourse>(
      $curriculumCourse,
      columns: [CurriculumCourse.t.curriculumId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CurriculumCourse] and [Course]
  /// by setting the [CurriculumCourse]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.DatabaseSession session,
    CurriculumCourse curriculumCourse,
    _i3.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (curriculumCourse.id == null) {
      throw ArgumentError.notNull('curriculumCourse.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $curriculumCourse = curriculumCourse.copyWith(courseId: course.id);
    await session.db.updateRow<CurriculumCourse>(
      $curriculumCourse,
      columns: [CurriculumCourse.t.courseId],
      transaction: transaction,
    );
  }
}
