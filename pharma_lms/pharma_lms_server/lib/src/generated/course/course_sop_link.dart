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
import '../document/document.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Explicit many-to-many SOP-Course linkage. Replaces implicit sopNumber matching.
abstract class CourseSopLink
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CourseSopLink._({
    this.id,
    required this.courseId,
    this.course,
    required this.documentId,
    this.document,
    required this.linkedById,
    this.linkedBy,
    DateTime? linkedAt,
    this.unlinkedAt,
  }) : linkedAt = linkedAt ?? DateTime.now();

  factory CourseSopLink({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int documentId,
    _i3.Document? document,
    required int linkedById,
    _i4.PharmaUser? linkedBy,
    DateTime? linkedAt,
    DateTime? unlinkedAt,
  }) = _CourseSopLinkImpl;

  factory CourseSopLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSopLink(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Course>(jsonSerialization['course']),
      documentId: jsonSerialization['documentId'] as int,
      document: jsonSerialization['document'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Document>(
              jsonSerialization['document'],
            ),
      linkedById: jsonSerialization['linkedById'] as int,
      linkedBy: jsonSerialization['linkedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['linkedBy'],
            ),
      linkedAt: jsonSerialization['linkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['linkedAt']),
      unlinkedAt: jsonSerialization['unlinkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['unlinkedAt']),
    );
  }

  static final t = CourseSopLinkTable();

  static const db = CourseSopLinkRepository._();

  @override
  int? id;

  int courseId;

  /// The course linked to the SOP.
  _i2.Course? course;

  int documentId;

  /// The SOP document linked.
  _i3.Document? document;

  int linkedById;

  /// Who created the link.
  _i4.PharmaUser? linkedBy;

  /// When the link was created.
  DateTime linkedAt;

  /// When the link was removed (soft-delete).
  DateTime? unlinkedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseSopLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseSopLink copyWith({
    int? id,
    int? courseId,
    _i2.Course? course,
    int? documentId,
    _i3.Document? document,
    int? linkedById,
    _i4.PharmaUser? linkedBy,
    DateTime? linkedAt,
    DateTime? unlinkedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSopLink',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'documentId': documentId,
      if (document != null) 'document': document?.toJson(),
      'linkedById': linkedById,
      if (linkedBy != null) 'linkedBy': linkedBy?.toJson(),
      'linkedAt': linkedAt.toJson(),
      if (unlinkedAt != null) 'unlinkedAt': unlinkedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseSopLink',
      if (id != null) 'id': id,
      'courseId': courseId,
      if (course != null) 'course': course?.toJsonForProtocol(),
      'documentId': documentId,
      if (document != null) 'document': document?.toJsonForProtocol(),
      'linkedById': linkedById,
      if (linkedBy != null) 'linkedBy': linkedBy?.toJsonForProtocol(),
      'linkedAt': linkedAt.toJson(),
      if (unlinkedAt != null) 'unlinkedAt': unlinkedAt?.toJson(),
    };
  }

  static CourseSopLinkInclude include({
    _i2.CourseInclude? course,
    _i3.DocumentInclude? document,
    _i4.PharmaUserInclude? linkedBy,
  }) {
    return CourseSopLinkInclude._(
      course: course,
      document: document,
      linkedBy: linkedBy,
    );
  }

  static CourseSopLinkIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseSopLinkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseSopLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseSopLinkTable>? orderByList,
    CourseSopLinkInclude? include,
  }) {
    return CourseSopLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseSopLink.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CourseSopLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseSopLinkImpl extends CourseSopLink {
  _CourseSopLinkImpl({
    int? id,
    required int courseId,
    _i2.Course? course,
    required int documentId,
    _i3.Document? document,
    required int linkedById,
    _i4.PharmaUser? linkedBy,
    DateTime? linkedAt,
    DateTime? unlinkedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         course: course,
         documentId: documentId,
         document: document,
         linkedById: linkedById,
         linkedBy: linkedBy,
         linkedAt: linkedAt,
         unlinkedAt: unlinkedAt,
       );

  /// Returns a shallow copy of this [CourseSopLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseSopLink copyWith({
    Object? id = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? documentId,
    Object? document = _Undefined,
    int? linkedById,
    Object? linkedBy = _Undefined,
    DateTime? linkedAt,
    Object? unlinkedAt = _Undefined,
  }) {
    return CourseSopLink(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      course: course is _i2.Course? ? course : this.course?.copyWith(),
      documentId: documentId ?? this.documentId,
      document: document is _i3.Document?
          ? document
          : this.document?.copyWith(),
      linkedById: linkedById ?? this.linkedById,
      linkedBy: linkedBy is _i4.PharmaUser?
          ? linkedBy
          : this.linkedBy?.copyWith(),
      linkedAt: linkedAt ?? this.linkedAt,
      unlinkedAt: unlinkedAt is DateTime? ? unlinkedAt : this.unlinkedAt,
    );
  }
}

class CourseSopLinkUpdateTable extends _i1.UpdateTable<CourseSopLinkTable> {
  CourseSopLinkUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> documentId(int value) => _i1.ColumnValue(
    table.documentId,
    value,
  );

  _i1.ColumnValue<int, int> linkedById(int value) => _i1.ColumnValue(
    table.linkedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> linkedAt(DateTime value) =>
      _i1.ColumnValue(
        table.linkedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> unlinkedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.unlinkedAt,
        value,
      );
}

class CourseSopLinkTable extends _i1.Table<int?> {
  CourseSopLinkTable({super.tableRelation})
    : super(tableName: 'course_sop_link') {
    updateTable = CourseSopLinkUpdateTable(this);
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    documentId = _i1.ColumnInt(
      'documentId',
      this,
    );
    linkedById = _i1.ColumnInt(
      'linkedById',
      this,
    );
    linkedAt = _i1.ColumnDateTime(
      'linkedAt',
      this,
      hasDefault: true,
    );
    unlinkedAt = _i1.ColumnDateTime(
      'unlinkedAt',
      this,
    );
  }

  late final CourseSopLinkUpdateTable updateTable;

  late final _i1.ColumnInt courseId;

  /// The course linked to the SOP.
  _i2.CourseTable? _course;

  late final _i1.ColumnInt documentId;

  /// The SOP document linked.
  _i3.DocumentTable? _document;

  late final _i1.ColumnInt linkedById;

  /// Who created the link.
  _i4.PharmaUserTable? _linkedBy;

  /// When the link was created.
  late final _i1.ColumnDateTime linkedAt;

  /// When the link was removed (soft-delete).
  late final _i1.ColumnDateTime unlinkedAt;

  _i2.CourseTable get course {
    if (_course != null) return _course!;
    _course = _i1.createRelationTable(
      relationFieldName: 'course',
      field: CourseSopLink.t.courseId,
      foreignField: _i2.Course.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseTable(tableRelation: foreignTableRelation),
    );
    return _course!;
  }

  _i3.DocumentTable get document {
    if (_document != null) return _document!;
    _document = _i1.createRelationTable(
      relationFieldName: 'document',
      field: CourseSopLink.t.documentId,
      foreignField: _i3.Document.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.DocumentTable(tableRelation: foreignTableRelation),
    );
    return _document!;
  }

  _i4.PharmaUserTable get linkedBy {
    if (_linkedBy != null) return _linkedBy!;
    _linkedBy = _i1.createRelationTable(
      relationFieldName: 'linkedBy',
      field: CourseSopLink.t.linkedById,
      foreignField: _i4.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _linkedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseId,
    documentId,
    linkedById,
    linkedAt,
    unlinkedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'course') {
      return course;
    }
    if (relationField == 'document') {
      return document;
    }
    if (relationField == 'linkedBy') {
      return linkedBy;
    }
    return null;
  }
}

class CourseSopLinkInclude extends _i1.IncludeObject {
  CourseSopLinkInclude._({
    _i2.CourseInclude? course,
    _i3.DocumentInclude? document,
    _i4.PharmaUserInclude? linkedBy,
  }) {
    _course = course;
    _document = document;
    _linkedBy = linkedBy;
  }

  _i2.CourseInclude? _course;

  _i3.DocumentInclude? _document;

  _i4.PharmaUserInclude? _linkedBy;

  @override
  Map<String, _i1.Include?> get includes => {
    'course': _course,
    'document': _document,
    'linkedBy': _linkedBy,
  };

  @override
  _i1.Table<int?> get table => CourseSopLink.t;
}

class CourseSopLinkIncludeList extends _i1.IncludeList {
  CourseSopLinkIncludeList._({
    _i1.WhereExpressionBuilder<CourseSopLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseSopLink.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CourseSopLink.t;
}

class CourseSopLinkRepository {
  const CourseSopLinkRepository._();

  final attachRow = const CourseSopLinkAttachRowRepository._();

  /// Returns a list of [CourseSopLink]s matching the given query parameters.
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
  Future<List<CourseSopLink>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseSopLinkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseSopLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseSopLinkTable>? orderByList,
    _i1.Transaction? transaction,
    CourseSopLinkInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseSopLink>(
      where: where?.call(CourseSopLink.t),
      orderBy: orderBy?.call(CourseSopLink.t),
      orderByList: orderByList?.call(CourseSopLink.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseSopLink] matching the given query parameters.
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
  Future<CourseSopLink?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseSopLinkTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseSopLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseSopLinkTable>? orderByList,
    _i1.Transaction? transaction,
    CourseSopLinkInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseSopLink>(
      where: where?.call(CourseSopLink.t),
      orderBy: orderBy?.call(CourseSopLink.t),
      orderByList: orderByList?.call(CourseSopLink.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseSopLink] by its [id] or null if no such row exists.
  Future<CourseSopLink?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CourseSopLinkInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseSopLink>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseSopLink]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseSopLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CourseSopLink>> insert(
    _i1.DatabaseSession session,
    List<CourseSopLink> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CourseSopLink>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CourseSopLink] and returns the inserted row.
  ///
  /// The returned [CourseSopLink] will have its `id` field set.
  Future<CourseSopLink> insertRow(
    _i1.DatabaseSession session,
    CourseSopLink row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseSopLink>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CourseSopLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CourseSopLink>> update(
    _i1.DatabaseSession session,
    List<CourseSopLink> rows, {
    _i1.ColumnSelections<CourseSopLinkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CourseSopLink>(
      rows,
      columns: columns?.call(CourseSopLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseSopLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseSopLink> updateRow(
    _i1.DatabaseSession session,
    CourseSopLink row, {
    _i1.ColumnSelections<CourseSopLinkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseSopLink>(
      row,
      columns: columns?.call(CourseSopLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseSopLink] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseSopLink?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseSopLinkUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseSopLink>(
      id,
      columnValues: columnValues(CourseSopLink.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseSopLink]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CourseSopLink>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CourseSopLinkUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourseSopLinkTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseSopLinkTable>? orderBy,
    _i1.OrderByListBuilder<CourseSopLinkTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CourseSopLink>(
      columnValues: columnValues(CourseSopLink.t.updateTable),
      where: where(CourseSopLink.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseSopLink.t),
      orderByList: orderByList?.call(CourseSopLink.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CourseSopLink]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CourseSopLink>> delete(
    _i1.DatabaseSession session,
    List<CourseSopLink> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CourseSopLink>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CourseSopLink].
  Future<CourseSopLink> deleteRow(
    _i1.DatabaseSession session,
    CourseSopLink row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseSopLink>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CourseSopLink>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseSopLinkTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CourseSopLink>(
      where: where(CourseSopLink.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseSopLinkTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CourseSopLink>(
      where: where?.call(CourseSopLink.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseSopLink] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseSopLinkTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseSopLink>(
      where: where(CourseSopLink.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CourseSopLinkAttachRowRepository {
  const CourseSopLinkAttachRowRepository._();

  /// Creates a relation between the given [CourseSopLink] and [Course]
  /// by setting the [CourseSopLink]'s foreign key `courseId` to refer to the [Course].
  Future<void> course(
    _i1.DatabaseSession session,
    CourseSopLink courseSopLink,
    _i2.Course course, {
    _i1.Transaction? transaction,
  }) async {
    if (courseSopLink.id == null) {
      throw ArgumentError.notNull('courseSopLink.id');
    }
    if (course.id == null) {
      throw ArgumentError.notNull('course.id');
    }

    var $courseSopLink = courseSopLink.copyWith(courseId: course.id);
    await session.db.updateRow<CourseSopLink>(
      $courseSopLink,
      columns: [CourseSopLink.t.courseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CourseSopLink] and [Document]
  /// by setting the [CourseSopLink]'s foreign key `documentId` to refer to the [Document].
  Future<void> document(
    _i1.DatabaseSession session,
    CourseSopLink courseSopLink,
    _i3.Document document, {
    _i1.Transaction? transaction,
  }) async {
    if (courseSopLink.id == null) {
      throw ArgumentError.notNull('courseSopLink.id');
    }
    if (document.id == null) {
      throw ArgumentError.notNull('document.id');
    }

    var $courseSopLink = courseSopLink.copyWith(documentId: document.id);
    await session.db.updateRow<CourseSopLink>(
      $courseSopLink,
      columns: [CourseSopLink.t.documentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CourseSopLink] and [PharmaUser]
  /// by setting the [CourseSopLink]'s foreign key `linkedById` to refer to the [PharmaUser].
  Future<void> linkedBy(
    _i1.DatabaseSession session,
    CourseSopLink courseSopLink,
    _i4.PharmaUser linkedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (courseSopLink.id == null) {
      throw ArgumentError.notNull('courseSopLink.id');
    }
    if (linkedBy.id == null) {
      throw ArgumentError.notNull('linkedBy.id');
    }

    var $courseSopLink = courseSopLink.copyWith(linkedById: linkedBy.id);
    await session.db.updateRow<CourseSopLink>(
      $courseSopLink,
      columns: [CourseSopLink.t.linkedById],
      transaction: transaction,
    );
  }
}
