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
import '../training/enrollment.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../course/course_version.dart' as _i4;
import '../shared/electronic_signature.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Training record - completion with e-signature. FDA 21 CFR Part 11.
abstract class TrainingRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingRecord._({
    this.id,
    required this.enrollmentId,
    this.enrollment,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    DateTime? completedAt,
    this.score,
    required this.esignatureId,
    this.esignature,
  }) : completedAt = completedAt ?? DateTime.now();

  factory TrainingRecord({
    int? id,
    required int enrollmentId,
    _i2.Enrollment? enrollment,
    required int userId,
    _i3.PharmaUser? user,
    required int courseVersionId,
    _i4.CourseVersion? courseVersion,
    DateTime? completedAt,
    int? score,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
  }) = _TrainingRecordImpl;

  factory TrainingRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingRecord(
      id: jsonSerialization['id'] as int?,
      enrollmentId: jsonSerialization['enrollmentId'] as int,
      enrollment: jsonSerialization['enrollment'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Enrollment>(
              jsonSerialization['enrollment'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      score: jsonSerialization['score'] as int?,
      esignatureId: jsonSerialization['esignatureId'] as int,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  static final t = TrainingRecordTable();

  static const db = TrainingRecordRepository._();

  @override
  int? id;

  int enrollmentId;

  /// The enrollment this completes.
  _i2.Enrollment? enrollment;

  int userId;

  /// The user.
  _i3.PharmaUser? user;

  int courseVersionId;

  /// The course version completed.
  _i4.CourseVersion? courseVersion;

  /// When completed.
  DateTime completedAt;

  /// Assessment score.
  int? score;

  int esignatureId;

  /// Electronic signature for compliance.
  _i5.ElectronicSignature? esignature;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingRecord copyWith({
    int? id,
    int? enrollmentId,
    _i2.Enrollment? enrollment,
    int? userId,
    _i3.PharmaUser? user,
    int? courseVersionId,
    _i4.CourseVersion? courseVersion,
    DateTime? completedAt,
    int? score,
    int? esignatureId,
    _i5.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingRecord',
      if (id != null) 'id': id,
      'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'completedAt': completedAt.toJson(),
      if (score != null) 'score': score,
      'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingRecord',
      if (id != null) 'id': id,
      'enrollmentId': enrollmentId,
      if (enrollment != null) 'enrollment': enrollment?.toJsonForProtocol(),
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'completedAt': completedAt.toJson(),
      if (score != null) 'score': score,
      'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJsonForProtocol(),
    };
  }

  static TrainingRecordInclude include({
    _i2.EnrollmentInclude? enrollment,
    _i3.PharmaUserInclude? user,
    _i4.CourseVersionInclude? courseVersion,
    _i5.ElectronicSignatureInclude? esignature,
  }) {
    return TrainingRecordInclude._(
      enrollment: enrollment,
      user: user,
      courseVersion: courseVersion,
      esignature: esignature,
    );
  }

  static TrainingRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingRecordTable>? orderByList,
    TrainingRecordInclude? include,
  }) {
    return TrainingRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingRecordImpl extends TrainingRecord {
  _TrainingRecordImpl({
    int? id,
    required int enrollmentId,
    _i2.Enrollment? enrollment,
    required int userId,
    _i3.PharmaUser? user,
    required int courseVersionId,
    _i4.CourseVersion? courseVersion,
    DateTime? completedAt,
    int? score,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         enrollmentId: enrollmentId,
         enrollment: enrollment,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         completedAt: completedAt,
         score: score,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [TrainingRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingRecord copyWith({
    Object? id = _Undefined,
    int? enrollmentId,
    Object? enrollment = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    DateTime? completedAt,
    Object? score = _Undefined,
    int? esignatureId,
    Object? esignature = _Undefined,
  }) {
    return TrainingRecord(
      id: id is int? ? id : this.id,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      enrollment: enrollment is _i2.Enrollment?
          ? enrollment
          : this.enrollment?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i4.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      completedAt: completedAt ?? this.completedAt,
      score: score is int? ? score : this.score,
      esignatureId: esignatureId ?? this.esignatureId,
      esignature: esignature is _i5.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}

class TrainingRecordUpdateTable extends _i1.UpdateTable<TrainingRecordTable> {
  TrainingRecordUpdateTable(super.table);

  _i1.ColumnValue<int, int> enrollmentId(int value) => _i1.ColumnValue(
    table.enrollmentId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<int, int> score(int? value) => _i1.ColumnValue(
    table.score,
    value,
  );

  _i1.ColumnValue<int, int> esignatureId(int value) => _i1.ColumnValue(
    table.esignatureId,
    value,
  );
}

class TrainingRecordTable extends _i1.Table<int?> {
  TrainingRecordTable({super.tableRelation})
    : super(tableName: 'training_record') {
    updateTable = TrainingRecordUpdateTable(this);
    enrollmentId = _i1.ColumnInt(
      'enrollmentId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
      hasDefault: true,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
    esignatureId = _i1.ColumnInt(
      'esignatureId',
      this,
    );
  }

  late final TrainingRecordUpdateTable updateTable;

  late final _i1.ColumnInt enrollmentId;

  /// The enrollment this completes.
  _i2.EnrollmentTable? _enrollment;

  late final _i1.ColumnInt userId;

  /// The user.
  _i3.PharmaUserTable? _user;

  late final _i1.ColumnInt courseVersionId;

  /// The course version completed.
  _i4.CourseVersionTable? _courseVersion;

  /// When completed.
  late final _i1.ColumnDateTime completedAt;

  /// Assessment score.
  late final _i1.ColumnInt score;

  late final _i1.ColumnInt esignatureId;

  /// Electronic signature for compliance.
  _i5.ElectronicSignatureTable? _esignature;

  _i2.EnrollmentTable get enrollment {
    if (_enrollment != null) return _enrollment!;
    _enrollment = _i1.createRelationTable(
      relationFieldName: 'enrollment',
      field: TrainingRecord.t.enrollmentId,
      foreignField: _i2.Enrollment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EnrollmentTable(tableRelation: foreignTableRelation),
    );
    return _enrollment!;
  }

  _i3.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: TrainingRecord.t.userId,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i4.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: TrainingRecord.t.courseVersionId,
      foreignField: _i4.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i5.ElectronicSignatureTable get esignature {
    if (_esignature != null) return _esignature!;
    _esignature = _i1.createRelationTable(
      relationFieldName: 'esignature',
      field: TrainingRecord.t.esignatureId,
      foreignField: _i5.ElectronicSignature.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.ElectronicSignatureTable(tableRelation: foreignTableRelation),
    );
    return _esignature!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    enrollmentId,
    userId,
    courseVersionId,
    completedAt,
    score,
    esignatureId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'enrollment') {
      return enrollment;
    }
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'esignature') {
      return esignature;
    }
    return null;
  }
}

class TrainingRecordInclude extends _i1.IncludeObject {
  TrainingRecordInclude._({
    _i2.EnrollmentInclude? enrollment,
    _i3.PharmaUserInclude? user,
    _i4.CourseVersionInclude? courseVersion,
    _i5.ElectronicSignatureInclude? esignature,
  }) {
    _enrollment = enrollment;
    _user = user;
    _courseVersion = courseVersion;
    _esignature = esignature;
  }

  _i2.EnrollmentInclude? _enrollment;

  _i3.PharmaUserInclude? _user;

  _i4.CourseVersionInclude? _courseVersion;

  _i5.ElectronicSignatureInclude? _esignature;

  @override
  Map<String, _i1.Include?> get includes => {
    'enrollment': _enrollment,
    'user': _user,
    'courseVersion': _courseVersion,
    'esignature': _esignature,
  };

  @override
  _i1.Table<int?> get table => TrainingRecord.t;
}

class TrainingRecordIncludeList extends _i1.IncludeList {
  TrainingRecordIncludeList._({
    _i1.WhereExpressionBuilder<TrainingRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingRecord.t;
}

class TrainingRecordRepository {
  const TrainingRecordRepository._();

  final attachRow = const TrainingRecordAttachRowRepository._();

  /// Returns a list of [TrainingRecord]s matching the given query parameters.
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
  Future<List<TrainingRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingRecordTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingRecord>(
      where: where?.call(TrainingRecord.t),
      orderBy: orderBy?.call(TrainingRecord.t),
      orderByList: orderByList?.call(TrainingRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingRecord] matching the given query parameters.
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
  Future<TrainingRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingRecordTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingRecord>(
      where: where?.call(TrainingRecord.t),
      orderBy: orderBy?.call(TrainingRecord.t),
      orderByList: orderByList?.call(TrainingRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingRecord] by its [id] or null if no such row exists.
  Future<TrainingRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingRecord>> insert(
    _i1.DatabaseSession session,
    List<TrainingRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingRecord] and returns the inserted row.
  ///
  /// The returned [TrainingRecord] will have its `id` field set.
  Future<TrainingRecord> insertRow(
    _i1.DatabaseSession session,
    TrainingRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingRecord>> update(
    _i1.DatabaseSession session,
    List<TrainingRecord> rows, {
    _i1.ColumnSelections<TrainingRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingRecord>(
      rows,
      columns: columns?.call(TrainingRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingRecord> updateRow(
    _i1.DatabaseSession session,
    TrainingRecord row, {
    _i1.ColumnSelections<TrainingRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingRecord>(
      row,
      columns: columns?.call(TrainingRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingRecord>(
      id,
      columnValues: columnValues(TrainingRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TrainingRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingRecordTable>? orderBy,
    _i1.OrderByListBuilder<TrainingRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingRecord>(
      columnValues: columnValues(TrainingRecord.t.updateTable),
      where: where(TrainingRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingRecord.t),
      orderByList: orderByList?.call(TrainingRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingRecord>> delete(
    _i1.DatabaseSession session,
    List<TrainingRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingRecord].
  Future<TrainingRecord> deleteRow(
    _i1.DatabaseSession session,
    TrainingRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingRecord>(
      where: where(TrainingRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingRecord>(
      where: where?.call(TrainingRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingRecord>(
      where: where(TrainingRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingRecordAttachRowRepository {
  const TrainingRecordAttachRowRepository._();

  /// Creates a relation between the given [TrainingRecord] and [Enrollment]
  /// by setting the [TrainingRecord]'s foreign key `enrollmentId` to refer to the [Enrollment].
  Future<void> enrollment(
    _i1.DatabaseSession session,
    TrainingRecord trainingRecord,
    _i2.Enrollment enrollment, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingRecord.id == null) {
      throw ArgumentError.notNull('trainingRecord.id');
    }
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }

    var $trainingRecord = trainingRecord.copyWith(enrollmentId: enrollment.id);
    await session.db.updateRow<TrainingRecord>(
      $trainingRecord,
      columns: [TrainingRecord.t.enrollmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingRecord] and [PharmaUser]
  /// by setting the [TrainingRecord]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.DatabaseSession session,
    TrainingRecord trainingRecord,
    _i3.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingRecord.id == null) {
      throw ArgumentError.notNull('trainingRecord.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $trainingRecord = trainingRecord.copyWith(userId: user.id);
    await session.db.updateRow<TrainingRecord>(
      $trainingRecord,
      columns: [TrainingRecord.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingRecord] and [CourseVersion]
  /// by setting the [TrainingRecord]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    TrainingRecord trainingRecord,
    _i4.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingRecord.id == null) {
      throw ArgumentError.notNull('trainingRecord.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $trainingRecord = trainingRecord.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<TrainingRecord>(
      $trainingRecord,
      columns: [TrainingRecord.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingRecord] and [ElectronicSignature]
  /// by setting the [TrainingRecord]'s foreign key `esignatureId` to refer to the [ElectronicSignature].
  Future<void> esignature(
    _i1.DatabaseSession session,
    TrainingRecord trainingRecord,
    _i5.ElectronicSignature esignature, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingRecord.id == null) {
      throw ArgumentError.notNull('trainingRecord.id');
    }
    if (esignature.id == null) {
      throw ArgumentError.notNull('esignature.id');
    }

    var $trainingRecord = trainingRecord.copyWith(esignatureId: esignature.id);
    await session.db.updateRow<TrainingRecord>(
      $trainingRecord,
      columns: [TrainingRecord.t.esignatureId],
      transaction: transaction,
    );
  }
}
