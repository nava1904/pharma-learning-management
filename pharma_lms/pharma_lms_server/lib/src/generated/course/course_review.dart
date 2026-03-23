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
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Course review record - QA approval workflow. FDA 21 CFR Part 11.
abstract class CourseReview
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CourseReview._({
    this.id,
    required this.courseVersionId,
    this.courseVersion,
    required this.reviewerId,
    this.reviewer,
    String? reviewType,
    required this.decision,
    this.comments,
    this.reviewChecklistJson,
    DateTime? reviewedAt,
    this.esignatureId,
    this.esignature,
  }) : reviewType = reviewType ?? 'initial',
       reviewedAt = reviewedAt ?? DateTime.now();

  factory CourseReview({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int reviewerId,
    _i3.PharmaUser? reviewer,
    String? reviewType,
    required String decision,
    String? comments,
    String? reviewChecklistJson,
    DateTime? reviewedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) = _CourseReviewImpl;

  factory CourseReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseReview(
      id: jsonSerialization['id'] as int?,
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      reviewerId: jsonSerialization['reviewerId'] as int,
      reviewer: jsonSerialization['reviewer'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['reviewer'],
            ),
      reviewType: jsonSerialization['reviewType'] as String?,
      decision: jsonSerialization['decision'] as String,
      comments: jsonSerialization['comments'] as String?,
      reviewChecklistJson: jsonSerialization['reviewChecklistJson'] as String?,
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      esignatureId: jsonSerialization['esignatureId'] as int?,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  static final t = CourseReviewTable();

  static const db = CourseReviewRepository._();

  @override
  int? id;

  int courseVersionId;

  /// The course version reviewed.
  _i2.CourseVersion? courseVersion;

  int reviewerId;

  /// QA reviewer.
  _i3.PharmaUser? reviewer;

  /// Review type: initial, re_review_after_changes.
  String reviewType;

  /// Decision: approved, rejected, returned_for_changes.
  String decision;

  /// Review comments.
  String? comments;

  /// Review checklist as JSON.
  String? reviewChecklistJson;

  /// When reviewed.
  DateTime reviewedAt;

  int? esignatureId;

  /// E-signature for approval.
  _i4.ElectronicSignature? esignature;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseReview copyWith({
    int? id,
    int? courseVersionId,
    _i2.CourseVersion? courseVersion,
    int? reviewerId,
    _i3.PharmaUser? reviewer,
    String? reviewType,
    String? decision,
    String? comments,
    String? reviewChecklistJson,
    DateTime? reviewedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseReview',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'reviewerId': reviewerId,
      if (reviewer != null) 'reviewer': reviewer?.toJson(),
      'reviewType': reviewType,
      'decision': decision,
      if (comments != null) 'comments': comments,
      if (reviewChecklistJson != null)
        'reviewChecklistJson': reviewChecklistJson,
      'reviewedAt': reviewedAt.toJson(),
      if (esignatureId != null) 'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseReview',
      if (id != null) 'id': id,
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'reviewerId': reviewerId,
      if (reviewer != null) 'reviewer': reviewer?.toJsonForProtocol(),
      'reviewType': reviewType,
      'decision': decision,
      if (comments != null) 'comments': comments,
      if (reviewChecklistJson != null)
        'reviewChecklistJson': reviewChecklistJson,
      'reviewedAt': reviewedAt.toJson(),
      if (esignatureId != null) 'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJsonForProtocol(),
    };
  }

  static CourseReviewInclude include({
    _i2.CourseVersionInclude? courseVersion,
    _i3.PharmaUserInclude? reviewer,
    _i4.ElectronicSignatureInclude? esignature,
  }) {
    return CourseReviewInclude._(
      courseVersion: courseVersion,
      reviewer: reviewer,
      esignature: esignature,
    );
  }

  static CourseReviewIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseReviewTable>? orderByList,
    CourseReviewInclude? include,
  }) {
    return CourseReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseReview.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CourseReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseReviewImpl extends CourseReview {
  _CourseReviewImpl({
    int? id,
    required int courseVersionId,
    _i2.CourseVersion? courseVersion,
    required int reviewerId,
    _i3.PharmaUser? reviewer,
    String? reviewType,
    required String decision,
    String? comments,
    String? reviewChecklistJson,
    DateTime? reviewedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         reviewerId: reviewerId,
         reviewer: reviewer,
         reviewType: reviewType,
         decision: decision,
         comments: comments,
         reviewChecklistJson: reviewChecklistJson,
         reviewedAt: reviewedAt,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [CourseReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseReview copyWith({
    Object? id = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? reviewerId,
    Object? reviewer = _Undefined,
    String? reviewType,
    String? decision,
    Object? comments = _Undefined,
    Object? reviewChecklistJson = _Undefined,
    DateTime? reviewedAt,
    Object? esignatureId = _Undefined,
    Object? esignature = _Undefined,
  }) {
    return CourseReview(
      id: id is int? ? id : this.id,
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i2.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      reviewerId: reviewerId ?? this.reviewerId,
      reviewer: reviewer is _i3.PharmaUser?
          ? reviewer
          : this.reviewer?.copyWith(),
      reviewType: reviewType ?? this.reviewType,
      decision: decision ?? this.decision,
      comments: comments is String? ? comments : this.comments,
      reviewChecklistJson: reviewChecklistJson is String?
          ? reviewChecklistJson
          : this.reviewChecklistJson,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      esignatureId: esignatureId is int? ? esignatureId : this.esignatureId,
      esignature: esignature is _i4.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}

class CourseReviewUpdateTable extends _i1.UpdateTable<CourseReviewTable> {
  CourseReviewUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> reviewerId(int value) => _i1.ColumnValue(
    table.reviewerId,
    value,
  );

  _i1.ColumnValue<String, String> reviewType(String value) => _i1.ColumnValue(
    table.reviewType,
    value,
  );

  _i1.ColumnValue<String, String> decision(String value) => _i1.ColumnValue(
    table.decision,
    value,
  );

  _i1.ColumnValue<String, String> comments(String? value) => _i1.ColumnValue(
    table.comments,
    value,
  );

  _i1.ColumnValue<String, String> reviewChecklistJson(String? value) =>
      _i1.ColumnValue(
        table.reviewChecklistJson,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> reviewedAt(DateTime value) =>
      _i1.ColumnValue(
        table.reviewedAt,
        value,
      );

  _i1.ColumnValue<int, int> esignatureId(int? value) => _i1.ColumnValue(
    table.esignatureId,
    value,
  );
}

class CourseReviewTable extends _i1.Table<int?> {
  CourseReviewTable({super.tableRelation}) : super(tableName: 'course_review') {
    updateTable = CourseReviewUpdateTable(this);
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    reviewerId = _i1.ColumnInt(
      'reviewerId',
      this,
    );
    reviewType = _i1.ColumnString(
      'reviewType',
      this,
      hasDefault: true,
    );
    decision = _i1.ColumnString(
      'decision',
      this,
    );
    comments = _i1.ColumnString(
      'comments',
      this,
    );
    reviewChecklistJson = _i1.ColumnString(
      'reviewChecklistJson',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
      this,
      hasDefault: true,
    );
    esignatureId = _i1.ColumnInt(
      'esignatureId',
      this,
    );
  }

  late final CourseReviewUpdateTable updateTable;

  late final _i1.ColumnInt courseVersionId;

  /// The course version reviewed.
  _i2.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt reviewerId;

  /// QA reviewer.
  _i3.PharmaUserTable? _reviewer;

  /// Review type: initial, re_review_after_changes.
  late final _i1.ColumnString reviewType;

  /// Decision: approved, rejected, returned_for_changes.
  late final _i1.ColumnString decision;

  /// Review comments.
  late final _i1.ColumnString comments;

  /// Review checklist as JSON.
  late final _i1.ColumnString reviewChecklistJson;

  /// When reviewed.
  late final _i1.ColumnDateTime reviewedAt;

  late final _i1.ColumnInt esignatureId;

  /// E-signature for approval.
  _i4.ElectronicSignatureTable? _esignature;

  _i2.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: CourseReview.t.courseVersionId,
      foreignField: _i2.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i3.PharmaUserTable get reviewer {
    if (_reviewer != null) return _reviewer!;
    _reviewer = _i1.createRelationTable(
      relationFieldName: 'reviewer',
      field: CourseReview.t.reviewerId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _reviewer!;
  }

  _i4.ElectronicSignatureTable get esignature {
    if (_esignature != null) return _esignature!;
    _esignature = _i1.createRelationTable(
      relationFieldName: 'esignature',
      field: CourseReview.t.esignatureId,
      foreignField: _i4.ElectronicSignature.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ElectronicSignatureTable(tableRelation: foreignTableRelation),
    );
    return _esignature!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    courseVersionId,
    reviewerId,
    reviewType,
    decision,
    comments,
    reviewChecklistJson,
    reviewedAt,
    esignatureId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'reviewer') {
      return reviewer;
    }
    if (relationField == 'esignature') {
      return esignature;
    }
    return null;
  }
}

class CourseReviewInclude extends _i1.IncludeObject {
  CourseReviewInclude._({
    _i2.CourseVersionInclude? courseVersion,
    _i3.PharmaUserInclude? reviewer,
    _i4.ElectronicSignatureInclude? esignature,
  }) {
    _courseVersion = courseVersion;
    _reviewer = reviewer;
    _esignature = esignature;
  }

  _i2.CourseVersionInclude? _courseVersion;

  _i3.PharmaUserInclude? _reviewer;

  _i4.ElectronicSignatureInclude? _esignature;

  @override
  Map<String, _i1.Include?> get includes => {
    'courseVersion': _courseVersion,
    'reviewer': _reviewer,
    'esignature': _esignature,
  };

  @override
  _i1.Table<int?> get table => CourseReview.t;
}

class CourseReviewIncludeList extends _i1.IncludeList {
  CourseReviewIncludeList._({
    _i1.WhereExpressionBuilder<CourseReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseReview.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CourseReview.t;
}

class CourseReviewRepository {
  const CourseReviewRepository._();

  final attachRow = const CourseReviewAttachRowRepository._();

  final detachRow = const CourseReviewDetachRowRepository._();

  /// Returns a list of [CourseReview]s matching the given query parameters.
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
  Future<List<CourseReview>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseReviewTable>? orderByList,
    _i1.Transaction? transaction,
    CourseReviewInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseReview>(
      where: where?.call(CourseReview.t),
      orderBy: orderBy?.call(CourseReview.t),
      orderByList: orderByList?.call(CourseReview.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseReview] matching the given query parameters.
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
  Future<CourseReview?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseReviewTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseReviewTable>? orderByList,
    _i1.Transaction? transaction,
    CourseReviewInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseReview>(
      where: where?.call(CourseReview.t),
      orderBy: orderBy?.call(CourseReview.t),
      orderByList: orderByList?.call(CourseReview.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseReview] by its [id] or null if no such row exists.
  Future<CourseReview?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CourseReviewInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseReview>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseReview]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CourseReview>> insert(
    _i1.DatabaseSession session,
    List<CourseReview> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CourseReview>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CourseReview] and returns the inserted row.
  ///
  /// The returned [CourseReview] will have its `id` field set.
  Future<CourseReview> insertRow(
    _i1.DatabaseSession session,
    CourseReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseReview>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CourseReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CourseReview>> update(
    _i1.DatabaseSession session,
    List<CourseReview> rows, {
    _i1.ColumnSelections<CourseReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CourseReview>(
      rows,
      columns: columns?.call(CourseReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseReview> updateRow(
    _i1.DatabaseSession session,
    CourseReview row, {
    _i1.ColumnSelections<CourseReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseReview>(
      row,
      columns: columns?.call(CourseReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseReview?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseReviewUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseReview>(
      id,
      columnValues: columnValues(CourseReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CourseReview>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CourseReviewUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourseReviewTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseReviewTable>? orderBy,
    _i1.OrderByListBuilder<CourseReviewTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CourseReview>(
      columnValues: columnValues(CourseReview.t.updateTable),
      where: where(CourseReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseReview.t),
      orderByList: orderByList?.call(CourseReview.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CourseReview]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CourseReview>> delete(
    _i1.DatabaseSession session,
    List<CourseReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CourseReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CourseReview].
  Future<CourseReview> deleteRow(
    _i1.DatabaseSession session,
    CourseReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseReview>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CourseReview>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseReviewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CourseReview>(
      where: where(CourseReview.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseReviewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CourseReview>(
      where: where?.call(CourseReview.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseReview] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseReviewTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseReview>(
      where: where(CourseReview.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CourseReviewAttachRowRepository {
  const CourseReviewAttachRowRepository._();

  /// Creates a relation between the given [CourseReview] and [CourseVersion]
  /// by setting the [CourseReview]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    CourseReview courseReview,
    _i2.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (courseReview.id == null) {
      throw ArgumentError.notNull('courseReview.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $courseReview = courseReview.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<CourseReview>(
      $courseReview,
      columns: [CourseReview.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CourseReview] and [PharmaUser]
  /// by setting the [CourseReview]'s foreign key `reviewerId` to refer to the [PharmaUser].
  Future<void> reviewer(
    _i1.DatabaseSession session,
    CourseReview courseReview,
    _i3.PharmaUser reviewer, {
    _i1.Transaction? transaction,
  }) async {
    if (courseReview.id == null) {
      throw ArgumentError.notNull('courseReview.id');
    }
    if (reviewer.id == null) {
      throw ArgumentError.notNull('reviewer.id');
    }

    var $courseReview = courseReview.copyWith(reviewerId: reviewer.id);
    await session.db.updateRow<CourseReview>(
      $courseReview,
      columns: [CourseReview.t.reviewerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CourseReview] and [ElectronicSignature]
  /// by setting the [CourseReview]'s foreign key `esignatureId` to refer to the [ElectronicSignature].
  Future<void> esignature(
    _i1.DatabaseSession session,
    CourseReview courseReview,
    _i4.ElectronicSignature esignature, {
    _i1.Transaction? transaction,
  }) async {
    if (courseReview.id == null) {
      throw ArgumentError.notNull('courseReview.id');
    }
    if (esignature.id == null) {
      throw ArgumentError.notNull('esignature.id');
    }

    var $courseReview = courseReview.copyWith(esignatureId: esignature.id);
    await session.db.updateRow<CourseReview>(
      $courseReview,
      columns: [CourseReview.t.esignatureId],
      transaction: transaction,
    );
  }
}

class CourseReviewDetachRowRepository {
  const CourseReviewDetachRowRepository._();

  /// Detaches the relation between this [CourseReview] and the [ElectronicSignature] set in `esignature`
  /// by setting the [CourseReview]'s foreign key `esignatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> esignature(
    _i1.DatabaseSession session,
    CourseReview courseReview, {
    _i1.Transaction? transaction,
  }) async {
    if (courseReview.id == null) {
      throw ArgumentError.notNull('courseReview.id');
    }

    var $courseReview = courseReview.copyWith(esignatureId: null);
    await session.db.updateRow<CourseReview>(
      $courseReview,
      columns: [CourseReview.t.esignatureId],
      transaction: transaction,
    );
  }
}
