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
import '../training/training_record.dart' as _i4;
import '../shared/electronic_signature.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Certificate issued after successful training.
abstract class Certificate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Certificate._({
    this.id,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    required this.trainingRecordId,
    this.trainingRecord,
    DateTime? issuedAt,
    this.expiresAt,
    this.qrCode,
    required this.esignatureId,
    this.esignature,
    String? status,
  }) : issuedAt = issuedAt ?? DateTime.now(),
       status = status ?? 'active';

  factory Certificate({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int trainingRecordId,
    _i4.TrainingRecord? trainingRecord,
    DateTime? issuedAt,
    DateTime? expiresAt,
    String? qrCode,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
    String? status,
  }) = _CertificateImpl;

  factory Certificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Certificate(
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
      trainingRecordId: jsonSerialization['trainingRecordId'] as int,
      trainingRecord: jsonSerialization['trainingRecord'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.TrainingRecord>(
              jsonSerialization['trainingRecord'],
            ),
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      qrCode: jsonSerialization['qrCode'] as String?,
      esignatureId: jsonSerialization['esignatureId'] as int,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
      status: jsonSerialization['status'] as String?,
    );
  }

  static final t = CertificateTable();

  static const db = CertificateRepository._();

  @override
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int courseVersionId;

  /// The course version.
  _i3.CourseVersion? courseVersion;

  int trainingRecordId;

  /// The training record.
  _i4.TrainingRecord? trainingRecord;

  /// When issued.
  DateTime issuedAt;

  /// When it expires.
  DateTime? expiresAt;

  /// QR code for verification.
  String? qrCode;

  int esignatureId;

  /// Electronic signature.
  _i5.ElectronicSignature? esignature;

  /// Status: active, obsolete, expired. Obsolete when course version superseded; expired when past expiresAt.
  String status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Certificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Certificate copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? trainingRecordId,
    _i4.TrainingRecord? trainingRecord,
    DateTime? issuedAt,
    DateTime? expiresAt,
    String? qrCode,
    int? esignatureId,
    _i5.ElectronicSignature? esignature,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Certificate',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'trainingRecordId': trainingRecordId,
      if (trainingRecord != null) 'trainingRecord': trainingRecord?.toJson(),
      'issuedAt': issuedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (qrCode != null) 'qrCode': qrCode,
      'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Certificate',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'trainingRecordId': trainingRecordId,
      if (trainingRecord != null)
        'trainingRecord': trainingRecord?.toJsonForProtocol(),
      'issuedAt': issuedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (qrCode != null) 'qrCode': qrCode,
      'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJsonForProtocol(),
      'status': status,
    };
  }

  static CertificateInclude include({
    _i2.PharmaUserInclude? user,
    _i3.CourseVersionInclude? courseVersion,
    _i4.TrainingRecordInclude? trainingRecord,
    _i5.ElectronicSignatureInclude? esignature,
  }) {
    return CertificateInclude._(
      user: user,
      courseVersion: courseVersion,
      trainingRecord: trainingRecord,
      esignature: esignature,
    );
  }

  static CertificateIncludeList includeList({
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    CertificateInclude? include,
  }) {
    return CertificateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Certificate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Certificate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CertificateImpl extends Certificate {
  _CertificateImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int trainingRecordId,
    _i4.TrainingRecord? trainingRecord,
    DateTime? issuedAt,
    DateTime? expiresAt,
    String? qrCode,
    required int esignatureId,
    _i5.ElectronicSignature? esignature,
    String? status,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         trainingRecordId: trainingRecordId,
         trainingRecord: trainingRecord,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         qrCode: qrCode,
         esignatureId: esignatureId,
         esignature: esignature,
         status: status,
       );

  /// Returns a shallow copy of this [Certificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Certificate copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? trainingRecordId,
    Object? trainingRecord = _Undefined,
    DateTime? issuedAt,
    Object? expiresAt = _Undefined,
    Object? qrCode = _Undefined,
    int? esignatureId,
    Object? esignature = _Undefined,
    String? status,
  }) {
    return Certificate(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      trainingRecordId: trainingRecordId ?? this.trainingRecordId,
      trainingRecord: trainingRecord is _i4.TrainingRecord?
          ? trainingRecord
          : this.trainingRecord?.copyWith(),
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      qrCode: qrCode is String? ? qrCode : this.qrCode,
      esignatureId: esignatureId ?? this.esignatureId,
      esignature: esignature is _i5.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
      status: status ?? this.status,
    );
  }
}

class CertificateUpdateTable extends _i1.UpdateTable<CertificateTable> {
  CertificateUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<int, int> trainingRecordId(int value) => _i1.ColumnValue(
    table.trainingRecordId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _i1.ColumnValue(
        table.issuedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<String, String> qrCode(String? value) => _i1.ColumnValue(
    table.qrCode,
    value,
  );

  _i1.ColumnValue<int, int> esignatureId(int value) => _i1.ColumnValue(
    table.esignatureId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class CertificateTable extends _i1.Table<int?> {
  CertificateTable({super.tableRelation}) : super(tableName: 'certificate') {
    updateTable = CertificateUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    trainingRecordId = _i1.ColumnInt(
      'trainingRecordId',
      this,
    );
    issuedAt = _i1.ColumnDateTime(
      'issuedAt',
      this,
      hasDefault: true,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    qrCode = _i1.ColumnString(
      'qrCode',
      this,
    );
    esignatureId = _i1.ColumnInt(
      'esignatureId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
  }

  late final CertificateUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// The user.
  _i2.PharmaUserTable? _user;

  late final _i1.ColumnInt courseVersionId;

  /// The course version.
  _i3.CourseVersionTable? _courseVersion;

  late final _i1.ColumnInt trainingRecordId;

  /// The training record.
  _i4.TrainingRecordTable? _trainingRecord;

  /// When issued.
  late final _i1.ColumnDateTime issuedAt;

  /// When it expires.
  late final _i1.ColumnDateTime expiresAt;

  /// QR code for verification.
  late final _i1.ColumnString qrCode;

  late final _i1.ColumnInt esignatureId;

  /// Electronic signature.
  _i5.ElectronicSignatureTable? _esignature;

  /// Status: active, obsolete, expired. Obsolete when course version superseded; expired when past expiresAt.
  late final _i1.ColumnString status;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Certificate.t.userId,
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
      field: Certificate.t.courseVersionId,
      foreignField: _i3.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  _i4.TrainingRecordTable get trainingRecord {
    if (_trainingRecord != null) return _trainingRecord!;
    _trainingRecord = _i1.createRelationTable(
      relationFieldName: 'trainingRecord',
      field: Certificate.t.trainingRecordId,
      foreignField: _i4.TrainingRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TrainingRecordTable(tableRelation: foreignTableRelation),
    );
    return _trainingRecord!;
  }

  _i5.ElectronicSignatureTable get esignature {
    if (_esignature != null) return _esignature!;
    _esignature = _i1.createRelationTable(
      relationFieldName: 'esignature',
      field: Certificate.t.esignatureId,
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
    userId,
    courseVersionId,
    trainingRecordId,
    issuedAt,
    expiresAt,
    qrCode,
    esignatureId,
    status,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    if (relationField == 'trainingRecord') {
      return trainingRecord;
    }
    if (relationField == 'esignature') {
      return esignature;
    }
    return null;
  }
}

class CertificateInclude extends _i1.IncludeObject {
  CertificateInclude._({
    _i2.PharmaUserInclude? user,
    _i3.CourseVersionInclude? courseVersion,
    _i4.TrainingRecordInclude? trainingRecord,
    _i5.ElectronicSignatureInclude? esignature,
  }) {
    _user = user;
    _courseVersion = courseVersion;
    _trainingRecord = trainingRecord;
    _esignature = esignature;
  }

  _i2.PharmaUserInclude? _user;

  _i3.CourseVersionInclude? _courseVersion;

  _i4.TrainingRecordInclude? _trainingRecord;

  _i5.ElectronicSignatureInclude? _esignature;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'courseVersion': _courseVersion,
    'trainingRecord': _trainingRecord,
    'esignature': _esignature,
  };

  @override
  _i1.Table<int?> get table => Certificate.t;
}

class CertificateIncludeList extends _i1.IncludeList {
  CertificateIncludeList._({
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Certificate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Certificate.t;
}

class CertificateRepository {
  const CertificateRepository._();

  final attachRow = const CertificateAttachRowRepository._();

  /// Returns a list of [Certificate]s matching the given query parameters.
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
  Future<List<Certificate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    _i1.Transaction? transaction,
    CertificateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Certificate>(
      where: where?.call(Certificate.t),
      orderBy: orderBy?.call(Certificate.t),
      orderByList: orderByList?.call(Certificate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Certificate] matching the given query parameters.
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
  Future<Certificate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    _i1.Transaction? transaction,
    CertificateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Certificate>(
      where: where?.call(Certificate.t),
      orderBy: orderBy?.call(Certificate.t),
      orderByList: orderByList?.call(Certificate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Certificate] by its [id] or null if no such row exists.
  Future<Certificate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CertificateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Certificate>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Certificate]s in the list and returns the inserted rows.
  ///
  /// The returned [Certificate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Certificate>> insert(
    _i1.Session session,
    List<Certificate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Certificate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Certificate] and returns the inserted row.
  ///
  /// The returned [Certificate] will have its `id` field set.
  Future<Certificate> insertRow(
    _i1.Session session,
    Certificate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Certificate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Certificate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Certificate>> update(
    _i1.Session session,
    List<Certificate> rows, {
    _i1.ColumnSelections<CertificateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Certificate>(
      rows,
      columns: columns?.call(Certificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Certificate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Certificate> updateRow(
    _i1.Session session,
    Certificate row, {
    _i1.ColumnSelections<CertificateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Certificate>(
      row,
      columns: columns?.call(Certificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Certificate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Certificate?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CertificateUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Certificate>(
      id,
      columnValues: columnValues(Certificate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Certificate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Certificate>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CertificateUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CertificateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CertificateTable>? orderBy,
    _i1.OrderByListBuilder<CertificateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Certificate>(
      columnValues: columnValues(Certificate.t.updateTable),
      where: where(Certificate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Certificate.t),
      orderByList: orderByList?.call(Certificate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Certificate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Certificate>> delete(
    _i1.Session session,
    List<Certificate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Certificate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Certificate].
  Future<Certificate> deleteRow(
    _i1.Session session,
    Certificate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Certificate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Certificate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CertificateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Certificate>(
      where: where(Certificate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CertificateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Certificate>(
      where: where?.call(Certificate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Certificate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CertificateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Certificate>(
      where: where(Certificate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CertificateAttachRowRepository {
  const CertificateAttachRowRepository._();

  /// Creates a relation between the given [Certificate] and [PharmaUser]
  /// by setting the [Certificate]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    Certificate certificate,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (certificate.id == null) {
      throw ArgumentError.notNull('certificate.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $certificate = certificate.copyWith(userId: user.id);
    await session.db.updateRow<Certificate>(
      $certificate,
      columns: [Certificate.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Certificate] and [CourseVersion]
  /// by setting the [Certificate]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.Session session,
    Certificate certificate,
    _i3.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (certificate.id == null) {
      throw ArgumentError.notNull('certificate.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $certificate = certificate.copyWith(courseVersionId: courseVersion.id);
    await session.db.updateRow<Certificate>(
      $certificate,
      columns: [Certificate.t.courseVersionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Certificate] and [TrainingRecord]
  /// by setting the [Certificate]'s foreign key `trainingRecordId` to refer to the [TrainingRecord].
  Future<void> trainingRecord(
    _i1.Session session,
    Certificate certificate,
    _i4.TrainingRecord trainingRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (certificate.id == null) {
      throw ArgumentError.notNull('certificate.id');
    }
    if (trainingRecord.id == null) {
      throw ArgumentError.notNull('trainingRecord.id');
    }

    var $certificate = certificate.copyWith(
      trainingRecordId: trainingRecord.id,
    );
    await session.db.updateRow<Certificate>(
      $certificate,
      columns: [Certificate.t.trainingRecordId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Certificate] and [ElectronicSignature]
  /// by setting the [Certificate]'s foreign key `esignatureId` to refer to the [ElectronicSignature].
  Future<void> esignature(
    _i1.Session session,
    Certificate certificate,
    _i5.ElectronicSignature esignature, {
    _i1.Transaction? transaction,
  }) async {
    if (certificate.id == null) {
      throw ArgumentError.notNull('certificate.id');
    }
    if (esignature.id == null) {
      throw ArgumentError.notNull('esignature.id');
    }

    var $certificate = certificate.copyWith(esignatureId: esignature.id);
    await session.db.updateRow<Certificate>(
      $certificate,
      columns: [Certificate.t.esignatureId],
      transaction: transaction,
    );
  }
}
