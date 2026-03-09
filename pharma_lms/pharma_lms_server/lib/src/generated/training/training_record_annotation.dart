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
import '../training/training_record.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// QA annotation on a training record.
abstract class TrainingRecordAnnotation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingRecordAnnotation._({
    this.id,
    required this.trainingRecordId,
    this.trainingRecord,
    required this.authorId,
    this.author,
    required this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory TrainingRecordAnnotation({
    int? id,
    required int trainingRecordId,
    _i2.TrainingRecord? trainingRecord,
    required int authorId,
    _i3.PharmaUser? author,
    required String note,
    DateTime? createdAt,
  }) = _TrainingRecordAnnotationImpl;

  factory TrainingRecordAnnotation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingRecordAnnotation(
      id: jsonSerialization['id'] as int?,
      trainingRecordId: jsonSerialization['trainingRecordId'] as int,
      trainingRecord: jsonSerialization['trainingRecord'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TrainingRecord>(
              jsonSerialization['trainingRecord'],
            ),
      authorId: jsonSerialization['authorId'] as int,
      author: jsonSerialization['author'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['author'],
            ),
      note: jsonSerialization['note'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = TrainingRecordAnnotationTable();

  static const db = TrainingRecordAnnotationRepository._();

  @override
  int? id;

  int trainingRecordId;

  /// The training record.
  _i2.TrainingRecord? trainingRecord;

  int authorId;

  /// Author (QA user who added the note).
  _i3.PharmaUser? author;

  /// Note text.
  String note;

  /// When created.
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingRecordAnnotation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingRecordAnnotation copyWith({
    int? id,
    int? trainingRecordId,
    _i2.TrainingRecord? trainingRecord,
    int? authorId,
    _i3.PharmaUser? author,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingRecordAnnotation',
      if (id != null) 'id': id,
      'trainingRecordId': trainingRecordId,
      if (trainingRecord != null) 'trainingRecord': trainingRecord?.toJson(),
      'authorId': authorId,
      if (author != null) 'author': author?.toJson(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingRecordAnnotation',
      if (id != null) 'id': id,
      'trainingRecordId': trainingRecordId,
      if (trainingRecord != null)
        'trainingRecord': trainingRecord?.toJsonForProtocol(),
      'authorId': authorId,
      if (author != null) 'author': author?.toJsonForProtocol(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  static TrainingRecordAnnotationInclude include({
    _i2.TrainingRecordInclude? trainingRecord,
    _i3.PharmaUserInclude? author,
  }) {
    return TrainingRecordAnnotationInclude._(
      trainingRecord: trainingRecord,
      author: author,
    );
  }

  static TrainingRecordAnnotationIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordAnnotationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingRecordAnnotationTable>? orderByList,
    TrainingRecordAnnotationInclude? include,
  }) {
    return TrainingRecordAnnotationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingRecordAnnotation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingRecordAnnotation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingRecordAnnotationImpl extends TrainingRecordAnnotation {
  _TrainingRecordAnnotationImpl({
    int? id,
    required int trainingRecordId,
    _i2.TrainingRecord? trainingRecord,
    required int authorId,
    _i3.PharmaUser? author,
    required String note,
    DateTime? createdAt,
  }) : super._(
         id: id,
         trainingRecordId: trainingRecordId,
         trainingRecord: trainingRecord,
         authorId: authorId,
         author: author,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [TrainingRecordAnnotation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingRecordAnnotation copyWith({
    Object? id = _Undefined,
    int? trainingRecordId,
    Object? trainingRecord = _Undefined,
    int? authorId,
    Object? author = _Undefined,
    String? note,
    DateTime? createdAt,
  }) {
    return TrainingRecordAnnotation(
      id: id is int? ? id : this.id,
      trainingRecordId: trainingRecordId ?? this.trainingRecordId,
      trainingRecord: trainingRecord is _i2.TrainingRecord?
          ? trainingRecord
          : this.trainingRecord?.copyWith(),
      authorId: authorId ?? this.authorId,
      author: author is _i3.PharmaUser? ? author : this.author?.copyWith(),
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TrainingRecordAnnotationUpdateTable
    extends _i1.UpdateTable<TrainingRecordAnnotationTable> {
  TrainingRecordAnnotationUpdateTable(super.table);

  _i1.ColumnValue<int, int> trainingRecordId(int value) => _i1.ColumnValue(
    table.trainingRecordId,
    value,
  );

  _i1.ColumnValue<int, int> authorId(int value) => _i1.ColumnValue(
    table.authorId,
    value,
  );

  _i1.ColumnValue<String, String> note(String value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class TrainingRecordAnnotationTable extends _i1.Table<int?> {
  TrainingRecordAnnotationTable({super.tableRelation})
    : super(tableName: 'training_record_annotation') {
    updateTable = TrainingRecordAnnotationUpdateTable(this);
    trainingRecordId = _i1.ColumnInt(
      'trainingRecordId',
      this,
    );
    authorId = _i1.ColumnInt(
      'authorId',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final TrainingRecordAnnotationUpdateTable updateTable;

  late final _i1.ColumnInt trainingRecordId;

  /// The training record.
  _i2.TrainingRecordTable? _trainingRecord;

  late final _i1.ColumnInt authorId;

  /// Author (QA user who added the note).
  _i3.PharmaUserTable? _author;

  /// Note text.
  late final _i1.ColumnString note;

  /// When created.
  late final _i1.ColumnDateTime createdAt;

  _i2.TrainingRecordTable get trainingRecord {
    if (_trainingRecord != null) return _trainingRecord!;
    _trainingRecord = _i1.createRelationTable(
      relationFieldName: 'trainingRecord',
      field: TrainingRecordAnnotation.t.trainingRecordId,
      foreignField: _i2.TrainingRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingRecordTable(tableRelation: foreignTableRelation),
    );
    return _trainingRecord!;
  }

  _i3.PharmaUserTable get author {
    if (_author != null) return _author!;
    _author = _i1.createRelationTable(
      relationFieldName: 'author',
      field: TrainingRecordAnnotation.t.authorId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _author!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    trainingRecordId,
    authorId,
    note,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'trainingRecord') {
      return trainingRecord;
    }
    if (relationField == 'author') {
      return author;
    }
    return null;
  }
}

class TrainingRecordAnnotationInclude extends _i1.IncludeObject {
  TrainingRecordAnnotationInclude._({
    _i2.TrainingRecordInclude? trainingRecord,
    _i3.PharmaUserInclude? author,
  }) {
    _trainingRecord = trainingRecord;
    _author = author;
  }

  _i2.TrainingRecordInclude? _trainingRecord;

  _i3.PharmaUserInclude? _author;

  @override
  Map<String, _i1.Include?> get includes => {
    'trainingRecord': _trainingRecord,
    'author': _author,
  };

  @override
  _i1.Table<int?> get table => TrainingRecordAnnotation.t;
}

class TrainingRecordAnnotationIncludeList extends _i1.IncludeList {
  TrainingRecordAnnotationIncludeList._({
    _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingRecordAnnotation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingRecordAnnotation.t;
}

class TrainingRecordAnnotationRepository {
  const TrainingRecordAnnotationRepository._();

  final attachRow = const TrainingRecordAnnotationAttachRowRepository._();

  /// Returns a list of [TrainingRecordAnnotation]s matching the given query parameters.
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
  Future<List<TrainingRecordAnnotation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordAnnotationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingRecordAnnotationTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingRecordAnnotationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingRecordAnnotation>(
      where: where?.call(TrainingRecordAnnotation.t),
      orderBy: orderBy?.call(TrainingRecordAnnotation.t),
      orderByList: orderByList?.call(TrainingRecordAnnotation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingRecordAnnotation] matching the given query parameters.
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
  Future<TrainingRecordAnnotation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordAnnotationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingRecordAnnotationTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingRecordAnnotationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingRecordAnnotation>(
      where: where?.call(TrainingRecordAnnotation.t),
      orderBy: orderBy?.call(TrainingRecordAnnotation.t),
      orderByList: orderByList?.call(TrainingRecordAnnotation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingRecordAnnotation] by its [id] or null if no such row exists.
  Future<TrainingRecordAnnotation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TrainingRecordAnnotationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingRecordAnnotation>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingRecordAnnotation]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingRecordAnnotation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingRecordAnnotation>> insert(
    _i1.Session session,
    List<TrainingRecordAnnotation> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingRecordAnnotation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingRecordAnnotation] and returns the inserted row.
  ///
  /// The returned [TrainingRecordAnnotation] will have its `id` field set.
  Future<TrainingRecordAnnotation> insertRow(
    _i1.Session session,
    TrainingRecordAnnotation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingRecordAnnotation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingRecordAnnotation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingRecordAnnotation>> update(
    _i1.Session session,
    List<TrainingRecordAnnotation> rows, {
    _i1.ColumnSelections<TrainingRecordAnnotationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingRecordAnnotation>(
      rows,
      columns: columns?.call(TrainingRecordAnnotation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingRecordAnnotation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingRecordAnnotation> updateRow(
    _i1.Session session,
    TrainingRecordAnnotation row, {
    _i1.ColumnSelections<TrainingRecordAnnotationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingRecordAnnotation>(
      row,
      columns: columns?.call(TrainingRecordAnnotation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingRecordAnnotation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingRecordAnnotation?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingRecordAnnotationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingRecordAnnotation>(
      id,
      columnValues: columnValues(TrainingRecordAnnotation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingRecordAnnotation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingRecordAnnotation>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TrainingRecordAnnotationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordAnnotationTable>? orderBy,
    _i1.OrderByListBuilder<TrainingRecordAnnotationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingRecordAnnotation>(
      columnValues: columnValues(TrainingRecordAnnotation.t.updateTable),
      where: where(TrainingRecordAnnotation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingRecordAnnotation.t),
      orderByList: orderByList?.call(TrainingRecordAnnotation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingRecordAnnotation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingRecordAnnotation>> delete(
    _i1.Session session,
    List<TrainingRecordAnnotation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingRecordAnnotation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingRecordAnnotation].
  Future<TrainingRecordAnnotation> deleteRow(
    _i1.Session session,
    TrainingRecordAnnotation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingRecordAnnotation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingRecordAnnotation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingRecordAnnotation>(
      where: where(TrainingRecordAnnotation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingRecordAnnotation>(
      where: where?.call(TrainingRecordAnnotation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingRecordAnnotation] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TrainingRecordAnnotationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingRecordAnnotation>(
      where: where(TrainingRecordAnnotation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingRecordAnnotationAttachRowRepository {
  const TrainingRecordAnnotationAttachRowRepository._();

  /// Creates a relation between the given [TrainingRecordAnnotation] and [TrainingRecord]
  /// by setting the [TrainingRecordAnnotation]'s foreign key `trainingRecordId` to refer to the [TrainingRecord].
  Future<void> trainingRecord(
    _i1.Session session,
    TrainingRecordAnnotation trainingRecordAnnotation,
    _i2.TrainingRecord trainingRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingRecordAnnotation.id == null) {
      throw ArgumentError.notNull('trainingRecordAnnotation.id');
    }
    if (trainingRecord.id == null) {
      throw ArgumentError.notNull('trainingRecord.id');
    }

    var $trainingRecordAnnotation = trainingRecordAnnotation.copyWith(
      trainingRecordId: trainingRecord.id,
    );
    await session.db.updateRow<TrainingRecordAnnotation>(
      $trainingRecordAnnotation,
      columns: [TrainingRecordAnnotation.t.trainingRecordId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingRecordAnnotation] and [PharmaUser]
  /// by setting the [TrainingRecordAnnotation]'s foreign key `authorId` to refer to the [PharmaUser].
  Future<void> author(
    _i1.Session session,
    TrainingRecordAnnotation trainingRecordAnnotation,
    _i3.PharmaUser author, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingRecordAnnotation.id == null) {
      throw ArgumentError.notNull('trainingRecordAnnotation.id');
    }
    if (author.id == null) {
      throw ArgumentError.notNull('author.id');
    }

    var $trainingRecordAnnotation = trainingRecordAnnotation.copyWith(
      authorId: author.id,
    );
    await session.db.updateRow<TrainingRecordAnnotation>(
      $trainingRecordAnnotation,
      columns: [TrainingRecordAnnotation.t.authorId],
      transaction: transaction,
    );
  }
}
