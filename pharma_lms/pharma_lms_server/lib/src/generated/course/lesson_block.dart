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

/// Ordered content block within a lesson (text, video, quiz, assignment, upload, etc.).
abstract class LessonBlock
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LessonBlock._({
    this.id,
    required this.lessonId,
    this.lesson,
    int? orderIndex,
    required this.blockType,
    required this.contentJson,
    DateTime? createdAt,
  }) : orderIndex = orderIndex ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory LessonBlock({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    int? orderIndex,
    required String blockType,
    required String contentJson,
    DateTime? createdAt,
  }) = _LessonBlockImpl;

  factory LessonBlock.fromJson(Map<String, dynamic> jsonSerialization) {
    return LessonBlock(
      id: jsonSerialization['id'] as int?,
      lessonId: jsonSerialization['lessonId'] as int,
      lesson: jsonSerialization['lesson'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Lesson>(jsonSerialization['lesson']),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      blockType: jsonSerialization['blockType'] as String,
      contentJson: jsonSerialization['contentJson'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = LessonBlockTable();

  static const db = LessonBlockRepository._();

  @override
  int? id;

  int lessonId;

  /// The lesson this block belongs to.
  _i2.Lesson? lesson;

  /// Display order within the lesson.
  int orderIndex;

  /// Block type: text, heading, video, upload, quiz, assignment, google_doc, google_sheet, google_slide, code_sandbox, audio.
  String blockType;

  /// JSON payload (schema varies by block type).
  String contentJson;

  /// Created timestamp.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LessonBlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LessonBlock copyWith({
    int? id,
    int? lessonId,
    _i2.Lesson? lesson,
    int? orderIndex,
    String? blockType,
    String? contentJson,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LessonBlock',
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJson(),
      'orderIndex': orderIndex,
      'blockType': blockType,
      'contentJson': contentJson,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LessonBlock',
      if (id != null) 'id': id,
      'lessonId': lessonId,
      if (lesson != null) 'lesson': lesson?.toJsonForProtocol(),
      'orderIndex': orderIndex,
      'blockType': blockType,
      'contentJson': contentJson,
      'createdAt': createdAt.toJson(),
    };
  }

  static LessonBlockInclude include({_i2.LessonInclude? lesson}) {
    return LessonBlockInclude._(lesson: lesson);
  }

  static LessonBlockIncludeList includeList({
    _i1.WhereExpressionBuilder<LessonBlockTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonBlockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonBlockTable>? orderByList,
    LessonBlockInclude? include,
  }) {
    return LessonBlockIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LessonBlock.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LessonBlock.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LessonBlockImpl extends LessonBlock {
  _LessonBlockImpl({
    int? id,
    required int lessonId,
    _i2.Lesson? lesson,
    int? orderIndex,
    required String blockType,
    required String contentJson,
    DateTime? createdAt,
  }) : super._(
         id: id,
         lessonId: lessonId,
         lesson: lesson,
         orderIndex: orderIndex,
         blockType: blockType,
         contentJson: contentJson,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LessonBlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LessonBlock copyWith({
    Object? id = _Undefined,
    int? lessonId,
    Object? lesson = _Undefined,
    int? orderIndex,
    String? blockType,
    String? contentJson,
    DateTime? createdAt,
  }) {
    return LessonBlock(
      id: id is int? ? id : this.id,
      lessonId: lessonId ?? this.lessonId,
      lesson: lesson is _i2.Lesson? ? lesson : this.lesson?.copyWith(),
      orderIndex: orderIndex ?? this.orderIndex,
      blockType: blockType ?? this.blockType,
      contentJson: contentJson ?? this.contentJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LessonBlockUpdateTable extends _i1.UpdateTable<LessonBlockTable> {
  LessonBlockUpdateTable(super.table);

  _i1.ColumnValue<int, int> lessonId(int value) => _i1.ColumnValue(
    table.lessonId,
    value,
  );

  _i1.ColumnValue<int, int> orderIndex(int value) => _i1.ColumnValue(
    table.orderIndex,
    value,
  );

  _i1.ColumnValue<String, String> blockType(String value) => _i1.ColumnValue(
    table.blockType,
    value,
  );

  _i1.ColumnValue<String, String> contentJson(String value) => _i1.ColumnValue(
    table.contentJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class LessonBlockTable extends _i1.Table<int?> {
  LessonBlockTable({super.tableRelation}) : super(tableName: 'lesson_block') {
    updateTable = LessonBlockUpdateTable(this);
    lessonId = _i1.ColumnInt(
      'lessonId',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
      hasDefault: true,
    );
    blockType = _i1.ColumnString(
      'blockType',
      this,
    );
    contentJson = _i1.ColumnString(
      'contentJson',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final LessonBlockUpdateTable updateTable;

  late final _i1.ColumnInt lessonId;

  /// The lesson this block belongs to.
  _i2.LessonTable? _lesson;

  /// Display order within the lesson.
  late final _i1.ColumnInt orderIndex;

  /// Block type: text, heading, video, upload, quiz, assignment, google_doc, google_sheet, google_slide, code_sandbox, audio.
  late final _i1.ColumnString blockType;

  /// JSON payload (schema varies by block type).
  late final _i1.ColumnString contentJson;

  /// Created timestamp.
  late final _i1.ColumnDateTime createdAt;

  _i2.LessonTable get lesson {
    if (_lesson != null) return _lesson!;
    _lesson = _i1.createRelationTable(
      relationFieldName: 'lesson',
      field: LessonBlock.t.lessonId,
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
    orderIndex,
    blockType,
    contentJson,
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

class LessonBlockInclude extends _i1.IncludeObject {
  LessonBlockInclude._({_i2.LessonInclude? lesson}) {
    _lesson = lesson;
  }

  _i2.LessonInclude? _lesson;

  @override
  Map<String, _i1.Include?> get includes => {'lesson': _lesson};

  @override
  _i1.Table<int?> get table => LessonBlock.t;
}

class LessonBlockIncludeList extends _i1.IncludeList {
  LessonBlockIncludeList._({
    _i1.WhereExpressionBuilder<LessonBlockTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LessonBlock.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LessonBlock.t;
}

class LessonBlockRepository {
  const LessonBlockRepository._();

  final attachRow = const LessonBlockAttachRowRepository._();

  /// Returns a list of [LessonBlock]s matching the given query parameters.
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
  Future<List<LessonBlock>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LessonBlockTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonBlockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonBlockTable>? orderByList,
    _i1.Transaction? transaction,
    LessonBlockInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LessonBlock>(
      where: where?.call(LessonBlock.t),
      orderBy: orderBy?.call(LessonBlock.t),
      orderByList: orderByList?.call(LessonBlock.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LessonBlock] matching the given query parameters.
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
  Future<LessonBlock?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LessonBlockTable>? where,
    int? offset,
    _i1.OrderByBuilder<LessonBlockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LessonBlockTable>? orderByList,
    _i1.Transaction? transaction,
    LessonBlockInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LessonBlock>(
      where: where?.call(LessonBlock.t),
      orderBy: orderBy?.call(LessonBlock.t),
      orderByList: orderByList?.call(LessonBlock.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LessonBlock] by its [id] or null if no such row exists.
  Future<LessonBlock?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    LessonBlockInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LessonBlock>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LessonBlock]s in the list and returns the inserted rows.
  ///
  /// The returned [LessonBlock]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LessonBlock>> insert(
    _i1.DatabaseSession session,
    List<LessonBlock> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LessonBlock>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LessonBlock] and returns the inserted row.
  ///
  /// The returned [LessonBlock] will have its `id` field set.
  Future<LessonBlock> insertRow(
    _i1.DatabaseSession session,
    LessonBlock row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LessonBlock>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LessonBlock]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LessonBlock>> update(
    _i1.DatabaseSession session,
    List<LessonBlock> rows, {
    _i1.ColumnSelections<LessonBlockTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LessonBlock>(
      rows,
      columns: columns?.call(LessonBlock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LessonBlock]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LessonBlock> updateRow(
    _i1.DatabaseSession session,
    LessonBlock row, {
    _i1.ColumnSelections<LessonBlockTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LessonBlock>(
      row,
      columns: columns?.call(LessonBlock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LessonBlock] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LessonBlock?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LessonBlockUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LessonBlock>(
      id,
      columnValues: columnValues(LessonBlock.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LessonBlock]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LessonBlock>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LessonBlockUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LessonBlockTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LessonBlockTable>? orderBy,
    _i1.OrderByListBuilder<LessonBlockTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LessonBlock>(
      columnValues: columnValues(LessonBlock.t.updateTable),
      where: where(LessonBlock.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LessonBlock.t),
      orderByList: orderByList?.call(LessonBlock.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LessonBlock]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LessonBlock>> delete(
    _i1.DatabaseSession session,
    List<LessonBlock> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LessonBlock>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LessonBlock].
  Future<LessonBlock> deleteRow(
    _i1.DatabaseSession session,
    LessonBlock row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LessonBlock>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LessonBlock>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LessonBlockTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LessonBlock>(
      where: where(LessonBlock.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LessonBlockTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LessonBlock>(
      where: where?.call(LessonBlock.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LessonBlock] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LessonBlockTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LessonBlock>(
      where: where(LessonBlock.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LessonBlockAttachRowRepository {
  const LessonBlockAttachRowRepository._();

  /// Creates a relation between the given [LessonBlock] and [Lesson]
  /// by setting the [LessonBlock]'s foreign key `lessonId` to refer to the [Lesson].
  Future<void> lesson(
    _i1.DatabaseSession session,
    LessonBlock lessonBlock,
    _i2.Lesson lesson, {
    _i1.Transaction? transaction,
  }) async {
    if (lessonBlock.id == null) {
      throw ArgumentError.notNull('lessonBlock.id');
    }
    if (lesson.id == null) {
      throw ArgumentError.notNull('lesson.id');
    }

    var $lessonBlock = lessonBlock.copyWith(lessonId: lesson.id);
    await session.db.updateRow<LessonBlock>(
      $lessonBlock,
      columns: [LessonBlock.t.lessonId],
      transaction: transaction,
    );
  }
}
