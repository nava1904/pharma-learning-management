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
import '../course/course_version.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../sme/sme_review_comment.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Threaded SME review comment on a course version.
abstract class SmeReviewComment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SmeReviewComment._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.authorId,
    this.author,
    required this.sectionRef,
    String? severity,
    required this.body,
    bool? resolved,
    this.trainerResponse,
    this.resolvedAt,
    DateTime? createdAt,
    this.parentCommentId,
    this.parentComment,
  }) : severity = severity ?? 'note',
       resolved = resolved ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory SmeReviewComment({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int authorId,
    _i3.PharmaUser? author,
    required String sectionRef,
    String? severity,
    required String body,
    bool? resolved,
    String? trainerResponse,
    DateTime? resolvedAt,
    DateTime? createdAt,
    int? parentCommentId,
    _i4.SmeReviewComment? parentComment,
  }) = _SmeReviewCommentImpl;

  factory SmeReviewComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SmeReviewComment(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      authorId: jsonSerialization['authorId'] as int,
      author: jsonSerialization['author'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['author'],
            ),
      sectionRef: jsonSerialization['sectionRef'] as String,
      severity: jsonSerialization['severity'] as String?,
      body: jsonSerialization['body'] as String,
      resolved: jsonSerialization['resolved'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['resolved']),
      trainerResponse: jsonSerialization['trainerResponse'] as String?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      parentCommentId: jsonSerialization['parentCommentId'] as int?,
      parentComment: jsonSerialization['parentComment'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.SmeReviewComment>(
              jsonSerialization['parentComment'],
            ),
    );
  }

  static final t = SmeReviewCommentTable();

  static const db = SmeReviewCommentRepository._();

  @override
  int? id;

  int courseVersionId;

  /// Course version being reviewed.
  _i2.CourseVersion? courseVersion;

  int authorId;

  /// Author (usually the SME).
  _i3.PharmaUser? author;

  /// Section reference (e.g. module label or lesson id).
  String sectionRef;

  /// note, major, critical
  String severity;

  /// Comment body.
  String body;

  /// Trainer marked resolved.
  bool resolved;

  /// Trainer response when resolving.
  String? trainerResponse;

  /// When resolved.
  DateTime? resolvedAt;

  /// Created timestamp.
  DateTime createdAt;

  int? parentCommentId;

  /// Optional parent comment for threaded QA / trainer replies.
  _i4.SmeReviewComment? parentComment;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SmeReviewComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SmeReviewComment copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? authorId,
    _i3.PharmaUser? author,
    String? sectionRef,
    String? severity,
    String? body,
    bool? resolved,
    String? trainerResponse,
    DateTime? resolvedAt,
    DateTime? createdAt,
    int? parentCommentId,
    _i4.SmeReviewComment? parentComment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SmeReviewComment',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'authorId': authorId,
      if (author != null) 'author': author?.toJson(),
      'sectionRef': sectionRef,
      'severity': severity,
      'body': body,
      'resolved': resolved,
      if (trainerResponse != null) 'trainerResponse': trainerResponse,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
      if (parentComment != null) 'parentComment': parentComment?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SmeReviewComment',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'authorId': authorId,
      if (author != null) 'author': author?.toJsonForProtocol(),
      'sectionRef': sectionRef,
      'severity': severity,
      'body': body,
      'resolved': resolved,
      if (trainerResponse != null) 'trainerResponse': trainerResponse,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
      if (parentComment != null)
        'parentComment': parentComment?.toJsonForProtocol(),
    };
  }

  static SmeReviewCommentInclude include({
    _i2.CourseVersionInclude? courseVersion,
    _i3.PharmaUserInclude? author,
    _i4.SmeReviewCommentInclude? parentComment,
  }) {
    return SmeReviewCommentInclude._(
      courseVersion: courseVersion,
      author: author,
      parentComment: parentComment,
    );
  }

  static SmeReviewCommentIncludeList includeList({
    _i1.WhereExpressionBuilder<SmeReviewCommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SmeReviewCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SmeReviewCommentTable>? orderByList,
    SmeReviewCommentInclude? include,
  }) {
    return SmeReviewCommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SmeReviewComment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SmeReviewComment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SmeReviewCommentImpl extends SmeReviewComment {
  _SmeReviewCommentImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int authorId,
    _i3.PharmaUser? author,
    required String sectionRef,
    String? severity,
    required String body,
    bool? resolved,
    String? trainerResponse,
    DateTime? resolvedAt,
    DateTime? createdAt,
    int? parentCommentId,
    _i4.SmeReviewComment? parentComment,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         authorId: authorId,
         author: author,
         sectionRef: sectionRef,
         severity: severity,
         body: body,
         resolved: resolved,
         trainerResponse: trainerResponse,
         resolvedAt: resolvedAt,
         createdAt: createdAt,
         parentCommentId: parentCommentId,
         parentComment: parentComment,
       );

  /// Returns a shallow copy of this [SmeReviewComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SmeReviewComment copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? authorId,
    Object? author = _Undefined,
    String? sectionRef,
    String? severity,
    String? body,
    bool? resolved,
    Object? trainerResponse = _Undefined,
    Object? resolvedAt = _Undefined,
    DateTime? createdAt,
    Object? parentCommentId = _Undefined,
    Object? parentComment = _Undefined,
  }) {
    return SmeReviewComment(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      authorId: authorId ?? this.authorId,
      author: author is _i3.PharmaUser? ? author : this.author?.copyWith(),
      sectionRef: sectionRef ?? this.sectionRef,
      severity: severity ?? this.severity,
      body: body ?? this.body,
      resolved: resolved ?? this.resolved,
      trainerResponse: trainerResponse is String?
          ? trainerResponse
          : this.trainerResponse,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      createdAt: createdAt ?? this.createdAt,
      parentCommentId: parentCommentId is int?
          ? parentCommentId
          : this.parentCommentId,
      parentComment: parentComment is _i4.SmeReviewComment?
          ? parentComment
          : this.parentComment?.copyWith(),
    );
  }
}

class SmeReviewCommentUpdateTable
    extends _i1.UpdateTable<SmeReviewCommentTable> {
  SmeReviewCommentUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> authorId(int value) => _i1.ColumnValue(
    table.authorId,
    value,
  );

  _i1.ColumnValue<String, String> sectionRef(String value) => _i1.ColumnValue(
    table.sectionRef,
    value,
  );

  _i1.ColumnValue<String, String> severity(String value) => _i1.ColumnValue(
    table.severity,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<bool, bool> resolved(bool value) => _i1.ColumnValue(
    table.resolved,
    value,
  );

  _i1.ColumnValue<String, String> trainerResponse(String? value) =>
      _i1.ColumnValue(
        table.trainerResponse,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<int, int> parentCommentId(int? value) => _i1.ColumnValue(
    table.parentCommentId,
    value,
  );
}

class SmeReviewCommentTable extends _i1.Table<int?> {
  SmeReviewCommentTable({super.tableRelation})
    : super(tableName: 'sme_review_comment') {
    updateTable = SmeReviewCommentUpdateTable(this);
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    authorId = _i1.ColumnInt(
      'authorId',
      this,
    );
    sectionRef = _i1.ColumnString(
      'sectionRef',
      this,
    );
    severity = _i1.ColumnString(
      'severity',
      this,
      hasDefault: true,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    resolved = _i1.ColumnBool(
      'resolved',
      this,
      hasDefault: true,
    );
    trainerResponse = _i1.ColumnString(
      'trainerResponse',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    parentCommentId = _i1.ColumnInt(
      'parentCommentId',
      this,
    );
  }

  late final SmeReviewCommentUpdateTable updateTable;

  late final _i1.ColumnInt courseVersionId;

  /// Course version being reviewed.
  _i2.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt authorId;

  /// Author (usually the SME).
  _i3.PharmaUserTable? _author;

  /// Section reference (e.g. module label or lesson id).
  late final _i1.ColumnString sectionRef;

  /// note, major, critical
  late final _i1.ColumnString severity;

  /// Comment body.
  late final _i1.ColumnString body;

  /// Trainer marked resolved.
  late final _i1.ColumnBool resolved;

  /// Trainer response when resolving.
  late final _i1.ColumnString trainerResponse;

  /// When resolved.
  late final _i1.ColumnDateTime resolvedAt;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt parentCommentId;

  /// Optional parent comment for threaded QA / trainer replies.
  _i4.SmeReviewCommentTable? _parentComment;

  _i2.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: SmeReviewComment.t.courseVersionId,
      foreignField: _i2.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i3.PharmaUserTable get author {
    if (_author != null) return _author!;
    _author = _i1.createRelationTable(
      relationFieldName: 'author',
      field: SmeReviewComment.t.authorId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _author!;
  }

  _i4.SmeReviewCommentTable get parentComment {
    if (_parentComment != null) return _parentComment!;
    _parentComment = _i1.createRelationTable(
      relationFieldName: 'parentComment',
      field: SmeReviewComment.t.parentCommentId,
      foreignField: _i4.SmeReviewComment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SmeReviewCommentTable(tableRelation: foreignTableRelation),
    );
    return _parentComment!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseVersionId,
    authorId,
    sectionRef,
    severity,
    body,
    resolved,
    trainerResponse,
    resolvedAt,
    createdAt,
    parentCommentId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'author') {
      return author;
    }
    if (relationField == 'parentComment') {
      return parentComment;
    }
    return null;
  }
}

class SmeReviewCommentInclude extends _i1.IncludeObject {
  SmeReviewCommentInclude._({
    _i2.CourseVersionInclude? courseVersion,
    _i3.PharmaUserInclude? author,
    _i4.SmeReviewCommentInclude? parentComment,
  }) {
    _courseVersion = courseVersion;
    _author = author;
    _parentComment = parentComment;
  }

  _i2.CourseVersionInclude? _courseVersion;

  _i3.PharmaUserInclude? _author;

  _i4.SmeReviewCommentInclude? _parentComment;

  @override
  Map<String, _i1.Include?> get includes => {
    'courseVersion': _courseVersion,
    'author': _author,
    'parentComment': _parentComment,
  };

  @override
  _i1.Table<int?> get table => SmeReviewComment.t;
}

class SmeReviewCommentIncludeList extends _i1.IncludeList {
  SmeReviewCommentIncludeList._({
    _i1.WhereExpressionBuilder<SmeReviewCommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SmeReviewComment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SmeReviewComment.t;
}

class SmeReviewCommentRepository {
  const SmeReviewCommentRepository._();

  final attachRow = const SmeReviewCommentAttachRowRepository._();

  final detachRow = const SmeReviewCommentDetachRowRepository._();

  /// Returns a list of [SmeReviewComment]s matching the given query parameters.
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
  Future<List<SmeReviewComment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SmeReviewCommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SmeReviewCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SmeReviewCommentTable>? orderByList,
    _i1.Transaction? transaction,
    SmeReviewCommentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SmeReviewComment>(
      where: where?.call(SmeReviewComment.t),
      orderBy: orderBy?.call(SmeReviewComment.t),
      orderByList: orderByList?.call(SmeReviewComment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SmeReviewComment] matching the given query parameters.
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
  Future<SmeReviewComment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SmeReviewCommentTable>? where,
    int? offset,
    _i1.OrderByBuilder<SmeReviewCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SmeReviewCommentTable>? orderByList,
    _i1.Transaction? transaction,
    SmeReviewCommentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SmeReviewComment>(
      where: where?.call(SmeReviewComment.t),
      orderBy: orderBy?.call(SmeReviewComment.t),
      orderByList: orderByList?.call(SmeReviewComment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SmeReviewComment] by its [id] or null if no such row exists.
  Future<SmeReviewComment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    SmeReviewCommentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SmeReviewComment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SmeReviewComment]s in the list and returns the inserted rows.
  ///
  /// The returned [SmeReviewComment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SmeReviewComment>> insert(
    _i1.DatabaseSession session,
    List<SmeReviewComment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SmeReviewComment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SmeReviewComment] and returns the inserted row.
  ///
  /// The returned [SmeReviewComment] will have its `id` field set.
  Future<SmeReviewComment> insertRow(
    _i1.DatabaseSession session,
    SmeReviewComment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SmeReviewComment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SmeReviewComment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SmeReviewComment>> update(
    _i1.DatabaseSession session,
    List<SmeReviewComment> rows, {
    _i1.ColumnSelections<SmeReviewCommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SmeReviewComment>(
      rows,
      columns: columns?.call(SmeReviewComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SmeReviewComment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SmeReviewComment> updateRow(
    _i1.DatabaseSession session,
    SmeReviewComment row, {
    _i1.ColumnSelections<SmeReviewCommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SmeReviewComment>(
      row,
      columns: columns?.call(SmeReviewComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SmeReviewComment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SmeReviewComment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SmeReviewCommentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SmeReviewComment>(
      id,
      columnValues: columnValues(SmeReviewComment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SmeReviewComment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SmeReviewComment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SmeReviewCommentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SmeReviewCommentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SmeReviewCommentTable>? orderBy,
    _i1.OrderByListBuilder<SmeReviewCommentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SmeReviewComment>(
      columnValues: columnValues(SmeReviewComment.t.updateTable),
      where: where(SmeReviewComment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SmeReviewComment.t),
      orderByList: orderByList?.call(SmeReviewComment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SmeReviewComment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SmeReviewComment>> delete(
    _i1.DatabaseSession session,
    List<SmeReviewComment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SmeReviewComment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SmeReviewComment].
  Future<SmeReviewComment> deleteRow(
    _i1.DatabaseSession session,
    SmeReviewComment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SmeReviewComment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SmeReviewComment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SmeReviewCommentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SmeReviewComment>(
      where: where(SmeReviewComment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SmeReviewCommentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SmeReviewComment>(
      where: where?.call(SmeReviewComment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SmeReviewComment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SmeReviewCommentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SmeReviewComment>(
      where: where(SmeReviewComment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SmeReviewCommentAttachRowRepository {
  const SmeReviewCommentAttachRowRepository._();

  /// Creates a relation between the given [SmeReviewComment] and [CourseVersion]
  /// by setting the [SmeReviewComment]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    SmeReviewComment smeReviewComment,
    _i2.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (smeReviewComment.id == null) {
      throw ArgumentError.notNull('smeReviewComment.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $smeReviewComment = smeReviewComment.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<SmeReviewComment>(
      $smeReviewComment,
      columns: [SmeReviewComment.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SmeReviewComment] and [PharmaUser]
  /// by setting the [SmeReviewComment]'s foreign key `authorId` to refer to the [PharmaUser].
  Future<void> author(
    _i1.DatabaseSession session,
    SmeReviewComment smeReviewComment,
    _i3.PharmaUser author, {
    _i1.Transaction? transaction,
  }) async {
    if (smeReviewComment.id == null) {
      throw ArgumentError.notNull('smeReviewComment.id');
    }
    if (author.id == null) {
      throw ArgumentError.notNull('author.id');
    }

    var $smeReviewComment = smeReviewComment.copyWith(authorId: author.id);
    await session.db.updateRow<SmeReviewComment>(
      $smeReviewComment,
      columns: [SmeReviewComment.t.authorId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SmeReviewComment] and [SmeReviewComment]
  /// by setting the [SmeReviewComment]'s foreign key `parentCommentId` to refer to the [SmeReviewComment].
  Future<void> parentComment(
    _i1.DatabaseSession session,
    SmeReviewComment smeReviewComment,
    _i4.SmeReviewComment parentComment, {
    _i1.Transaction? transaction,
  }) async {
    if (smeReviewComment.id == null) {
      throw ArgumentError.notNull('smeReviewComment.id');
    }
    if (parentComment.id == null) {
      throw ArgumentError.notNull('parentComment.id');
    }

    var $smeReviewComment = smeReviewComment.copyWith(
      parentCommentId: parentComment.id,
    );
    await session.db.updateRow<SmeReviewComment>(
      $smeReviewComment,
      columns: [SmeReviewComment.t.parentCommentId],
      transaction: transaction,
    );
  }
}

class SmeReviewCommentDetachRowRepository {
  const SmeReviewCommentDetachRowRepository._();

  /// Detaches the relation between this [SmeReviewComment] and the [SmeReviewComment] set in `parentComment`
  /// by setting the [SmeReviewComment]'s foreign key `parentCommentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> parentComment(
    _i1.DatabaseSession session,
    SmeReviewComment smeReviewComment, {
    _i1.Transaction? transaction,
  }) async {
    if (smeReviewComment.id == null) {
      throw ArgumentError.notNull('smeReviewComment.id');
    }

    var $smeReviewComment = smeReviewComment.copyWith(parentCommentId: null);
    await session.db.updateRow<SmeReviewComment>(
      $smeReviewComment,
      columns: [SmeReviewComment.t.parentCommentId],
      transaction: transaction,
    );
  }
}
