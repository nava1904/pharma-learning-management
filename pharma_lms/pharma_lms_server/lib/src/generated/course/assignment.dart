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
import '../course/lesson.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Assignment within a lesson for student submissions.
abstract class Assignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Assignment._({
    this.id,
    required this.lessonId,
    this.lesson,
    required this.title,
    this.instructions,
    this.allowedFileTypes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Assignment({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required String title,
    String? instructions,
    String? allowedFileTypes,
    DateTime? createdAt,
  }) = _AssignmentImpl;

  factory Assignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Assignment(
      id: jsonSerialization['id'] as int?,
      lessonId: jsonSerialization['lessonId'] as int,
      lesson: jsonSerialization['lesson'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Lesson>(jsonSerialization['lesson']),
      title: jsonSerialization['title'] as String,
      instructions: jsonSerialization['instructions'] as String?,
      allowedFileTypes: jsonSerialization['allowedFileTypes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AssignmentTable();

  static const db = AssignmentRepository._();

  @override
  int? id;

  int lessonId;

  /// The lesson this assignment belongs to.
  _i2.Lesson? lesson;

  /// Assignment title.
  String title;

  /// Instructions for the assignment.
  String? instructions;

  /// Allowed file types as JSON array (e.g. ["pdf","doc","png"]).
  String? allowedFileTypes;

  /// Created timestamp.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Assignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Assignment copyWith({
    int? id,
    int? lessonId,
    _i2.Lesson? lesson,
    String? title,
    String? instructions,
    String? allowedFileTypes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Assignment',
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJson(),
      'title': title,
      if (instructions != null) 'instructions': instructions,
      if (allowedFileTypes != null) 'allowedFileTypes': allowedFileTypes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Assignment',
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJsonForProtocol(),
      'title': title,
      if (instructions != null) 'instructions': instructions,
      if (allowedFileTypes != null) 'allowedFileTypes': allowedFileTypes,
      'createdAt': createdAt.toJson(),
    };
  }

  static AssignmentInclude include({_i2.LessonInclude? lesson}) {
    return AssignmentInclude._(lesson: lesson);
  }

  static AssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<AssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssignmentTable>? orderByList,
    AssignmentInclude? include,
  }) {
    return AssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Assignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Assignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssignmentImpl extends Assignment {
  _AssignmentImpl({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    required String title,
    String? instructions,
    String? allowedFileTypes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         lessonId: lessonId,
         lesson: lesson,
         title: title,
         instructions: instructions,
         allowedFileTypes: allowedFileTypes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Assignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Assignment copyWith({
    Object? id = _Undefined,
    int? lessonId,
    Object? lesson = _Undefined,
    String? title,
    Object? instructions = _Undefined,
    Object? allowedFileTypes = _Undefined,
    DateTime? createdAt,
  }) {
    return Assignment(
      id: id is int? ? id : this.id,
      lessonId: lessonId ?? this.lessonId,
      lesson: lesson is _i2.Lesson? ? lesson : this.lesson?.copyWith(),
      title: title ?? this.title,
      instructions: instructions is String? ? instructions : this.instructions,
      allowedFileTypes: allowedFileTypes is String?
          ? allowedFileTypes
          : this.allowedFileTypes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AssignmentUpdateTable extends _i1.UpdateTable<AssignmentTable> {
  AssignmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> lessonId(int value) => _i1.ColumnValue(
    table.lessonId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> instructions(String? value) =>
      _i1.ColumnValue(
        table.instructions,
        value,
      );

  _i1.ColumnValue<String, String> allowedFileTypes(String? value) =>
      _i1.ColumnValue(
        table.allowedFileTypes,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AssignmentTable extends _i1.Table<int?> {
  AssignmentTable({super.tableRelation}) : super(tableName: 'assignment') {
    updateTable = AssignmentUpdateTable(this);
    lessonId = _i1.ColumnInt(
      'lessonId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    instructions = _i1.ColumnString(
      'instructions',
      this,
    );
    allowedFileTypes = _i1.ColumnString(
      'allowedFileTypes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AssignmentUpdateTable updateTable;

  late final _i1.ColumnInt lessonId;

  /// The lesson this assignment belongs to.
  _i2.LessonTable? _lesson;

  /// Assignment title.
  late final _i1.ColumnString title;

  /// Instructions for the assignment.
  late final _i1.ColumnString instructions;

  /// Allowed file types as JSON array (e.g. ["pdf","doc","png"]).
  late final _i1.ColumnString allowedFileTypes;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  _i2.LessonTable get lesson {
    if (_lesson != null) return _lesson!;
    _lesson = _i1.createRelationTable(
      relationFieldName: 'lesson',
      field: Assignment.t.lessonId,
      foreignField: _i2.Lesson.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LessonTable(tableRelation: foreignTableRelation),
    );
    return _lesson!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    lessonId,
    title,
    instructions,
    allowedFileTypes,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'lesson') {
      return lesson;
    }
    return null;
  }
}

class AssignmentInclude extends _i1.IncludeObject {
  AssignmentInclude._({_i2.LessonInclude? lesson}) {
    _lesson = lesson;
  }

  _i2.LessonInclude? _lesson;

  @override
  Map<String, _i1.Include?> get includes => {'lesson': _lesson};

  @override
  _i1.Table<int?> get table => Assignment.t;
}

class AssignmentIncludeList extends _i1.IncludeList {
  AssignmentIncludeList._({
    _i1.WhereExpressionBuilder<AssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Assignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Assignment.t;
}

class AssignmentRepository {
  const AssignmentRepository._();

  final attachRow = const AssignmentAttachRowRepository._();

  /// Returns a list of [Assignment]s matching the given query parameters.
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
  Future<List<Assignment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    AssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Assignment>(
      where: where?.call(Assignment.t),
      orderBy: orderBy?.call(Assignment.t),
      orderByList: orderByList?.call(Assignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Assignment] matching the given query parameters.
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
  Future<Assignment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    AssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Assignment>(
      where: where?.call(Assignment.t),
      orderBy: orderBy?.call(Assignment.t),
      orderByList: orderByList?.call(Assignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Assignment] by its [id] or null if no such row exists.
  Future<Assignment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Assignment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Assignment]s in the list and returns the inserted rows.
  ///
  /// The returned [Assignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Assignment>> insert(
    _i1.DatabaseSession session,
    List<Assignment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Assignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Assignment] and returns the inserted row.
  ///
  /// The returned [Assignment] will have its `id` field set.
  Future<Assignment> insertRow(
    _i1.DatabaseSession session,
    Assignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Assignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Assignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Assignment>> update(
    _i1.DatabaseSession session,
    List<Assignment> rows, {
    _i1.ColumnSelections<AssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Assignment>(
      rows,
      columns: columns?.call(Assignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Assignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Assignment> updateRow(
    _i1.DatabaseSession session,
    Assignment row, {
    _i1.ColumnSelections<AssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Assignment>(
      row,
      columns: columns?.call(Assignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Assignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Assignment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssignmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Assignment>(
      id,
      columnValues: columnValues(Assignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Assignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Assignment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssignmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AssignmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssignmentTable>? orderBy,
    _i1.OrderByListBuilder<AssignmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Assignment>(
      columnValues: columnValues(Assignment.t.updateTable),
      where: where(Assignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Assignment.t),
      orderByList: orderByList?.call(Assignment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Assignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Assignment>> delete(
    _i1.DatabaseSession session,
    List<Assignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Assignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Assignment].
  Future<Assignment> deleteRow(
    _i1.DatabaseSession session,
    Assignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Assignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Assignment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Assignment>(
      where: where(Assignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Assignment>(
      where: where?.call(Assignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Assignment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssignmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Assignment>(
      where: where(Assignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssignmentAttachRowRepository {
  const AssignmentAttachRowRepository._();

  /// Creates a relation between the given [Assignment] and [Lesson]
  /// by setting the [Assignment]'s foreign key `lessonId` to refer to the [Lesson].
  Future<void> lesson(
    _i1.DatabaseSession session,
    Assignment assignment,
    _i2.Lesson lesson, {
    _i1.Transaction? transaction,
  }) async {
    if (assignment.id == null) {
      throw ArgumentError.notNull('assignment.id');
    }
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }

    var $assignment = assignment.copyWith(lessonId: lesson.id);
    await session.db.updateRow<Assignment>(
      $assignment,
      columns: [Assignment.t.lessonId],
      transaction: transaction,
    );
  }
}
