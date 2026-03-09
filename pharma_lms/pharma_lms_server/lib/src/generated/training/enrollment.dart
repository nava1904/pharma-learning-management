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
import '../organization/user.dart' as _i2;
import '../course/course_version.dart' as _i3;
import '../training/training_assignment.dart' as _i4;
import '../shared/electronic_signature.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Enrollment - user's progress in a course version.
abstract class Enrollment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Enrollment._({
    this.id,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    this.assignmentId,
    this.assignment,
    String? status,
    this.startedAt,
    this.completedAt,
    this.retrainingChangeSummary,
    this.acknowledgedAt,
    this.acknowledgementEsignatureId,
    this.acknowledgementEsignature,
  }) : status = status ?? 'not_started';

  factory Enrollment({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignmentId,
    _i4.TrainingAssignment? assignment,
    String? status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? retrainingChangeSummary,
    DateTime? acknowledgedAt,
    int? acknowledgementEsignatureId,
    _i5.ElectronicSignature? acknowledgementEsignature,
  }) = _EnrollmentImpl;

  factory Enrollment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Enrollment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      assignmentId: jsonSerialization['assignmentId'] as int?,
      assignment: jsonSerialization['assignment'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.TrainingAssignment>(
              jsonSerialization['assignment'],
            ),
      status: jsonSerialization['status'] as String?,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      retrainingChangeSummary:
          jsonSerialization['retrainingChangeSummary'] as String?,
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      acknowledgementEsignatureId:
          jsonSerialization['acknowledgementEsignatureId'] as int?,
      acknowledgementEsignature:
          jsonSerialization['acknowledgementEsignature'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ElectronicSignature>(
              jsonSerialization['acknowledgementEsignature'],
            ),
    );
  }

  static final t = EnrollmentTable();

  static const db = EnrollmentRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int courseVersionId;

  /// The course version.
  _i3.CourseVersion? courseVersion;

  int? assignmentId;

  /// The assignment that created this enrollment.
  _i4.TrainingAssignment? assignment;

  /// Status: not_started, in_progress, completed, overdue.
  String status;

  /// When started.
  DateTime? startedAt;

  /// When completed.
  DateTime? completedAt;

  /// For retraining: change summary from document/course version (EMP-10).
  String? retrainingChangeSummary;

  /// When user acknowledged retraining change summary.
  DateTime? acknowledgedAt;

  int? acknowledgementEsignatureId;

  /// E-signature for retraining acknowledgement.
  _i5.ElectronicSignature? acknowledgementEsignature;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Enrollment copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignmentId,
    _i4.TrainingAssignment? assignment,
    String? status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? retrainingChangeSummary,
    DateTime? acknowledgedAt,
    int? acknowledgementEsignatureId,
    _i5.ElectronicSignature? acknowledgementEsignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Enrollment',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      if (assignmentId != null) 'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJson(),
      'status': status,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (retrainingChangeSummary != null)
        'retrainingChangeSummary': retrainingChangeSummary,
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (acknowledgementEsignatureId != null)
        'acknowledgementEsignatureId': acknowledgementEsignatureId,
      if (acknowledgementEsignature != null)
        'acknowledgementEsignature': acknowledgementEsignature?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Enrollment',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      if (assignmentId != null) 'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJsonForProtocol(),
      'status': status,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (retrainingChangeSummary != null)
        'retrainingChangeSummary': retrainingChangeSummary,
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (acknowledgementEsignatureId != null)
        'acknowledgementEsignatureId': acknowledgementEsignatureId,
      if (acknowledgementEsignature != null)
        'acknowledgementEsignature': acknowledgementEsignature
            ?.toJsonForProtocol(),
    };
  }

  static EnrollmentInclude include({
    _i2.PharmaUserInclude? user,
    _i3.CourseVersionInclude? courseVersion,
    _i4.TrainingAssignmentInclude? assignment,
    _i5.ElectronicSignatureInclude? acknowledgementEsignature,
  }) {
    return EnrollmentInclude._(
      user: user,
      courseVersion: courseVersion,
      assignment: assignment,
      acknowledgementEsignature: acknowledgementEsignature,
    );
  }

  static EnrollmentIncludeList includeList({
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    EnrollmentInclude? include,
  }) {
    return EnrollmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Enrollment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Enrollment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EnrollmentImpl extends Enrollment {
  _EnrollmentImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignmentId,
    _i4.TrainingAssignment? assignment,
    String? status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? retrainingChangeSummary,
    DateTime? acknowledgedAt,
    int? acknowledgementEsignatureId,
    _i5.ElectronicSignature? acknowledgementEsignature,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         assignmentId: assignmentId,
         assignment: assignment,
         status: status,
         startedAt: startedAt,
         completedAt: completedAt,
         retrainingChangeSummary: retrainingChangeSummary,
         acknowledgedAt: acknowledgedAt,
         acknowledgementEsignatureId: acknowledgementEsignatureId,
         acknowledgementEsignature: acknowledgementEsignature,
       );

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Enrollment copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    Object? assignmentId = _Undefined,
    Object? assignment = _Undefined,
    String? status,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? retrainingChangeSummary = _Undefined,
    Object? acknowledgedAt = _Undefined,
    Object? acknowledgementEsignatureId = _Undefined,
    Object? acknowledgementEsignature = _Undefined,
  }) {
    return Enrollment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      assignmentId: assignmentId is int? ? assignmentId : this.assignmentId,
      assignment: assignment is _i4.TrainingAssignment?
          ? assignment
          : this.assignment?.copyWith(),
      status: status ?? this.status,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      retrainingChangeSummary: retrainingChangeSummary is String?
          ? retrainingChangeSummary
          : this.retrainingChangeSummary,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      acknowledgementEsignatureId: acknowledgementEsignatureId is int?
          ? acknowledgementEsignatureId
          : this.acknowledgementEsignatureId,
      acknowledgementEsignature:
          acknowledgementEsignature is _i5.ElectronicSignature?
          ? acknowledgementEsignature
          : this.acknowledgementEsignature?.copyWith(),
    );
  }
}

class EnrollmentUpdateTable extends _i1.UpdateTable<EnrollmentTable> {
  EnrollmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> assignmentId(int? value) => _i1.ColumnValue(
    table.assignmentId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<String, String> retrainingChangeSummary(String? value) =>
      _i1.ColumnValue(
        table.retrainingChangeSummary,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acknowledgedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acknowledgedAt,
        value,
      );

  _i1.ColumnValue<int, int> acknowledgementEsignatureId(int? value) =>
      _i1.ColumnValue(
        table.acknowledgementEsignatureId,
        value,
      );
}

class EnrollmentTable extends _i1.Table<int?> {
  EnrollmentTable({super.tableRelation}) : super(tableName: 'enrollment') {
    updateTable = EnrollmentUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    assignmentId = _i1.ColumnInt(
      'assignmentId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    retrainingChangeSummary = _i1.ColumnString(
      'retrainingChangeSummary',
      this,
    );
    acknowledgedAt = _i1.ColumnDateTime(
      'acknowledgedAt',
      this,
    );
    acknowledgementEsignatureId = _i1.ColumnInt(
      'acknowledgementEsignatureId',
      this,
    );
  }

  late final EnrollmentUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt courseVersionId;

  /// The course version.
  _i3.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt assignmentId;

  /// The assignment that created this enrollment.
  _i4.TrainingAssignmentTable? _assignment;

  /// Status: not_started, in_progress, completed, overdue.
  late final _i1.ColumnString status;

  /// When started.
  late final _i1.ColumnDateTime startedAt;

  /// When completed.
  late final _i1.ColumnDateTime completedAt;

  /// For retraining: change summary from document/course version (EMP-10).
  late final _i1.ColumnString retrainingChangeSummary;

  /// When user acknowledged retraining change summary.
  late final _i1.ColumnDateTime acknowledgedAt;

  late final _i1.ColumnInt acknowledgementEsignatureId;

  /// E-signature for retraining acknowledgement.
  _i5.ElectronicSignatureTable? _acknowledgementEsignature;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Enrollment.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: Enrollment.t.courseVersionId,
      foreignField: _i3.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i4.TrainingAssignmentTable get assignment {
    if (_assignment != null) return _assignment!;
    _assignment = _i1.createRelationTable(
      relationFieldName: 'assignment',
      field: Enrollment.t.assignmentId,
      foreignField: _i4.TrainingAssignment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TrainingAssignmentTable(tableRelation: foreignTableRelation),
    );
    return _assignment!;
  }

  _i5.ElectronicSignatureTable get acknowledgementEsignature {
    if (_acknowledgementEsignature != null) return _acknowledgementEsignature!;
    _acknowledgementEsignature = _i1.createRelationTable(
      relationFieldName: 'acknowledgementEsignature',
      field: Enrollment.t.acknowledgementEsignatureId,
      foreignField: _i5.ElectronicSignature.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.ElectronicSignatureTable(tableRelation: foreignTableRelation),
    );
    return _acknowledgementEsignature!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    courseVersionId,
    assignmentId,
    status,
    startedAt,
    completedAt,
    retrainingChangeSummary,
    acknowledgedAt,
    acknowledgementEsignatureId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'assignment') {
      return assignment;
    }
    if (relationField == 'acknowledgementEsignature') {
      return acknowledgementEsignature;
    }
    return null;
  }
}

class EnrollmentInclude extends _i1.IncludeObject {
  EnrollmentInclude._({
    _i2.PharmaUserInclude? user,
    _i3.CourseVersionInclude? courseVersion,
    _i4.TrainingAssignmentInclude? assignment,
    _i5.ElectronicSignatureInclude? acknowledgementEsignature,
  }) {
    _user = user;
    _courseVersion = courseVersion;
    _assignment = assignment;
    _acknowledgementEsignature = acknowledgementEsignature;
  }

  _i2.PharmaUserInclude? _user;

  _i3.CourseVersionInclude? _courseVersion;

  _i4.TrainingAssignmentInclude? _assignment;

  _i5.ElectronicSignatureInclude? _acknowledgementEsignature;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'courseVersion': _courseVersion,
    'assignment': _assignment,
    'acknowledgementEsignature': _acknowledgementEsignature,
  };

  @override
  _i1.Table<int?> get table => Enrollment.t;
}

class EnrollmentIncludeList extends _i1.IncludeList {
  EnrollmentIncludeList._({
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Enrollment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Enrollment.t;
}

class EnrollmentRepository {
  const EnrollmentRepository._();

  final attachRow = const EnrollmentAttachRowRepository._();

  final detachRow = const EnrollmentDetachRowRepository._();

  /// Returns a list of [Enrollment]s matching the given query parameters.
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
  Future<List<Enrollment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    _i1.Transaction? transaction,
    EnrollmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Enrollment>(
      where: where?.call(Enrollment.t),
      orderBy: orderBy?.call(Enrollment.t),
      orderByList: orderByList?.call(Enrollment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Enrollment] matching the given query parameters.
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
  Future<Enrollment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    _i1.Transaction? transaction,
    EnrollmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Enrollment>(
      where: where?.call(Enrollment.t),
      orderBy: orderBy?.call(Enrollment.t),
      orderByList: orderByList?.call(Enrollment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Enrollment] by its [id] or null if no such row exists.
  Future<Enrollment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    EnrollmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Enrollment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Enrollment]s in the list and returns the inserted rows.
  ///
  /// The returned [Enrollment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Enrollment>> insert(
    _i1.Session session,
    List<Enrollment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Enrollment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Enrollment] and returns the inserted row.
  ///
  /// The returned [Enrollment] will have its `id` field set.
  Future<Enrollment> insertRow(
    _i1.Session session,
    Enrollment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Enrollment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Enrollment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Enrollment>> update(
    _i1.Session session,
    List<Enrollment> rows, {
    _i1.ColumnSelections<EnrollmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Enrollment>(
      rows,
      columns: columns?.call(Enrollment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Enrollment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Enrollment> updateRow(
    _i1.Session session,
    Enrollment row, {
    _i1.ColumnSelections<EnrollmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Enrollment>(
      row,
      columns: columns?.call(Enrollment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Enrollment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Enrollment?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<EnrollmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Enrollment>(
      id,
      columnValues: columnValues(Enrollment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Enrollment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Enrollment>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<EnrollmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EnrollmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Enrollment>(
      columnValues: columnValues(Enrollment.t.updateTable),
      where: where(Enrollment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Enrollment.t),
      orderByList: orderByList?.call(Enrollment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Enrollment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Enrollment>> delete(
    _i1.Session session,
    List<Enrollment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Enrollment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Enrollment].
  Future<Enrollment> deleteRow(
    _i1.Session session,
    Enrollment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Enrollment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Enrollment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EnrollmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Enrollment>(
      where: where(Enrollment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Enrollment>(
      where: where?.call(Enrollment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Enrollment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EnrollmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Enrollment>(
      where: where(Enrollment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EnrollmentAttachRowRepository {
  const EnrollmentAttachRowRepository._();

  /// Creates a relation between the given [Enrollment] and [PharmaUser]
  /// by setting the [Enrollment]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    Enrollment enrollment,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $enrollment = enrollment.copyWith(userId: user.id);
    await session.db.updateRow<Enrollment>(
      $enrollment,
      columns: [Enrollment.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Enrollment] and [CourseVersion]
  /// by setting the [Enrollment]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.Session session,
    Enrollment enrollment,
    _i3.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $enrollment = enrollment.copyWith(courseVersionId: courseVersion.id);
    await session.db.updateRow<Enrollment>(
      $enrollment,
      columns: [Enrollment.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Enrollment] and [TrainingAssignment]
  /// by setting the [Enrollment]'s foreign key `assignmentId` to refer to the [TrainingAssignment].
  Future<void> assignment(
    _i1.Session session,
    Enrollment enrollment,
    _i4.TrainingAssignment assignment, {
    _i1.Transaction? transaction,
  }) async {
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }
    if (assignment.id == null) {
      throw ArgumentError.notNull('assignment.id');
    }

    var $enrollment = enrollment.copyWith(assignmentId: assignment.id);
    await session.db.updateRow<Enrollment>(
      $enrollment,
      columns: [Enrollment.t.assignmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Enrollment] and [ElectronicSignature]
  /// by setting the [Enrollment]'s foreign key `acknowledgementEsignatureId` to refer to the [ElectronicSignature].
  Future<void> acknowledgementEsignature(
    _i1.Session session,
    Enrollment enrollment,
    _i5.ElectronicSignature acknowledgementEsignature, {
    _i1.Transaction? transaction,
  }) async {
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }
    if (acknowledgementEsignature.id == null) {
      throw ArgumentError.notNull('acknowledgementEsignature.id');
    }

    var $enrollment = enrollment.copyWith(
      acknowledgementEsignatureId: acknowledgementEsignature.id,
    );
    await session.db.updateRow<Enrollment>(
      $enrollment,
      columns: [Enrollment.t.acknowledgementEsignatureId],
      transaction: transaction,
    );
  }
}

class EnrollmentDetachRowRepository {
  const EnrollmentDetachRowRepository._();

  /// Detaches the relation between this [Enrollment] and the [TrainingAssignment] set in `assignment`
  /// by setting the [Enrollment]'s foreign key `assignmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> assignment(
    _i1.Session session,
    Enrollment enrollment, {
    _i1.Transaction? transaction,
  }) async {
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }

    var $enrollment = enrollment.copyWith(assignmentId: null);
    await session.db.updateRow<Enrollment>(
      $enrollment,
      columns: [Enrollment.t.assignmentId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Enrollment] and the [ElectronicSignature] set in `acknowledgementEsignature`
  /// by setting the [Enrollment]'s foreign key `acknowledgementEsignatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> acknowledgementEsignature(
    _i1.Session session,
    Enrollment enrollment, {
    _i1.Transaction? transaction,
  }) async {
    if (enrollment.id == null) {
      throw ArgumentError.notNull('enrollment.id');
    }

    var $enrollment = enrollment.copyWith(acknowledgementEsignatureId: null);
    await session.db.updateRow<Enrollment>(
      $enrollment,
      columns: [Enrollment.t.acknowledgementEsignatureId],
      transaction: transaction,
    );
  }
}
