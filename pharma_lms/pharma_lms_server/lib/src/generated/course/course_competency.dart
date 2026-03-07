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
import '../course/competency.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Links courses to competencies.
abstract class CourseCompetency
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CourseCompetency._({
    this.id,
    required this.courseId,
    this.course,
    required this.competencyId,
    this.competency,
  });

  factory CourseCompetency({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int competencyId,
    _i3.Competency? competency,
  }) = _CourseCompetencyImpl;

  factory CourseCompetency.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseCompetency(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Competency>(
              jsonSerialization['competency'],
            ),
    );
  }

  static final t = CourseCompetencyTable();

  static const db = CourseCompetencyRepository._();

  @override
  int? id;

  int courseId;

  /// The course.
  _i2.Course? course;

  int competencyId;

  /// The competency.
  _i3.Competency? competency;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseCompetency copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    int? competencyId,
    _i3.Competency? competency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseCompetency',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseCompetency',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJsonForProtocol(),
    };
  }

  static CourseCompetencyInclude include({
    _i2.CourseInclude? course,
    _i3.CompetencyInclude? competency,
  }) {
    return CourseCompetencyInclude._(
      course: course,
      competency: competency,
    );
  }

  static CourseCompetencyIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseCompetencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseCompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseCompetencyTable>? orderByList,
    CourseCompetencyInclude? include,
  }) {
    return CourseCompetencyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseCompetency.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CourseCompetency.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseCompetencyImpl extends CourseCompetency {
  _CourseCompetencyImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int competencyId,
    _i3.Competency? competency,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         competencyId: competencyId,
         competency: competency,
       );

  /// Returns a shallow copy of this [CourseCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseCompetency copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
  }) {
    return CourseCompetency(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i3.Competency?
          ? competency
          : this.competency?.copyWith(),
    );
  }
}

class CourseCompetencyUpdateTable
    extends _i1.UpdateTable<CourseCompetencyTable> {
  CourseCompetencyUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> competencyId(int value) => _i1.ColumnValue(
    table.competencyId,
    value,
  );
}

class CourseCompetencyTable extends _i1.Table<int?> {
  CourseCompetencyTable({super.tableRelation})
    : super(tableName: 'course_competency') {
    updateTable = CourseCompetencyUpdateTable(this);
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    competencyId = _i1.ColumnInt(
      'competencyId',
      this,
    );
  }

  late final CourseCompetencyUpdateTable updateTable;

  late final _i1.ColumnInt courseId;

  /// The course.
  _i2.CourseTable? _course;

  late final _i1.ColumnInt competencyId;

  /// The competency.
  _i3.CompetencyTable? _competency;

  _i2.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: CourseCompetency.t.courseId,
      foreignField: _i2.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  _i3.CompetencyTable get competency {
    if (_competency != null) return _competency!;
    _competency = _i1.createRelationTable(
      relationFieldName: 'competency',
      field: CourseCompetency.t.competencyId,
      foreignField: _i3.Competency.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CompetencyTable(tableRelation: foreignTableRelation),
    );
    return _competency!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseId,
    competencyId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'course') {
      return course;
    }
    if (relationField == 'competency') {
      return competency;
    }
    return null;
  }
}

class CourseCompetencyInclude extends _i1.IncludeObject {
  CourseCompetencyInclude._({
    _i2.CourseInclude? course,
    _i3.CompetencyInclude? competency,
  }) {
    _course = course;
    _competency = competency;
  }

  _i2.CourseInclude? _course;

  _i3.CompetencyInclude? _competency;

  @override
  Map<String, _i1.Include?> get includes => {
    'course': _course,
    'competency': _competency,
  };

  @override
  _i1.Table<int?> get table => CourseCompetency.t;
}

class CourseCompetencyIncludeList extends _i1.IncludeList {
  CourseCompetencyIncludeList._({
    _i1.WhereExpressionBuilder<CourseCompetencyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseCompetency.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CourseCompetency.t;
}

class CourseCompetencyRepository {
  const CourseCompetencyRepository._();

  final attachRow = const CourseCompetencyAttachRowRepository._();

  /// Returns a list of [CourseCompetency]s matching the given query parameters.
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
  Future<List<CourseCompetency>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourseCompetencyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseCompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseCompetencyTable>? orderByList,
    _i1.Transaction? transaction,
    CourseCompetencyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseCompetency>(
      where: where?.call(CourseCompetency.t),
      orderBy: orderBy?.call(CourseCompetency.t),
      orderByList: orderByList?.call(CourseCompetency.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseCompetency] matching the given query parameters.
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
  Future<CourseCompetency?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourseCompetencyTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseCompetencyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseCompetencyTable>? orderByList,
    _i1.Transaction? transaction,
    CourseCompetencyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseCompetency>(
      where: where?.call(CourseCompetency.t),
      orderBy: orderBy?.call(CourseCompetency.t),
      orderByList: orderByList?.call(CourseCompetency.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseCompetency] by its [id] or null if no such row exists.
  Future<CourseCompetency?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CourseCompetencyInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseCompetency>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseCompetency]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseCompetency]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CourseCompetency>> insert(
    _i1.Session session,
    List<CourseCompetency> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CourseCompetency>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CourseCompetency] and returns the inserted row.
  ///
  /// The returned [CourseCompetency] will have its `id` field set.
  Future<CourseCompetency> insertRow(
    _i1.Session session,
    CourseCompetency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseCompetency>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CourseCompetency]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CourseCompetency>> update(
    _i1.Session session,
    List<CourseCompetency> rows, {
    _i1.ColumnSelections<CourseCompetencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CourseCompetency>(
      rows,
      columns: columns?.call(CourseCompetency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseCompetency]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseCompetency> updateRow(
    _i1.Session session,
    CourseCompetency row, {
    _i1.ColumnSelections<CourseCompetencyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseCompetency>(
      row,
      columns: columns?.call(CourseCompetency.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseCompetency] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseCompetency?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseCompetencyUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseCompetency>(
      id,
      columnValues: columnValues(CourseCompetency.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseCompetency]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CourseCompetency>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CourseCompetencyUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CourseCompetencyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseCompetencyTable>? orderBy,
    _i1.OrderByListBuilder<CourseCompetencyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CourseCompetency>(
      columnValues: columnValues(CourseCompetency.t.updateTable),
      where: where(CourseCompetency.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseCompetency.t),
      orderByList: orderByList?.call(CourseCompetency.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CourseCompetency]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CourseCompetency>> delete(
    _i1.Session session,
    List<CourseCompetency> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CourseCompetency>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CourseCompetency].
  Future<CourseCompetency> deleteRow(
    _i1.Session session,
    CourseCompetency row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseCompetency>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CourseCompetency>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CourseCompetencyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CourseCompetency>(
      where: where(CourseCompetency.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CourseCompetencyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CourseCompetency>(
      where: where?.call(CourseCompetency.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseCompetency] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CourseCompetencyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseCompetency>(
      where: where(CourseCompetency.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CourseCompetencyAttachRowRepository {
  const CourseCompetencyAttachRowRepository._();

  /// Creates a relation between the given [CourseCompetency] and [Course]
  /// by setting the [CourseCompetency]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.Session session,
    CourseCompetency courseCompetency,
    _i2.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (courseCompetency.id == null) {
      throw ArgumentError.notNull('courseCompetency.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $courseCompetency = courseCompetency.copyWith(courseId: course.id);
    await session.db.updateRow<CourseCompetency>(
      $courseCompetency,
      columns: [CourseCompetency.t.courseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CourseCompetency] and [Competency]
  /// by setting the [CourseCompetency]'s foreign key `competencyId` to refer to the [Competency].
  Future<void> competency(
    _i1.Session session,
    CourseCompetency courseCompetency,
    _i3.Competency competency, {
    _i1.Transaction? transaction,
  }) async {
    if (courseCompetency.id == null) {
      throw ArgumentError.notNull('courseCompetency.id');
    }
    if (competency.id == null) {
      throw ArgumentError.notNull('competency.id');
    }

    var $courseCompetency = courseCompetency.copyWith(
      competencyId: competency.id,
    );
    await session.db.updateRow<CourseCompetency>(
      $courseCompetency,
      columns: [CourseCompetency.t.competencyId],
      transaction: transaction,
    );
  }
}
