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
import '../training/certificate.dart' as _i2;
import '../training/training_assignment.dart' as _i3;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i4;

/// Tracks certification expiry and renewal.
abstract class TrainingExpiration
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingExpiration._({
    this.id,
    required this.certificateId,
    this.certificate,
    required this.expiresAt,
    this.reminderSentAt,
    this.renewalAssignmentId,
    this.renewalAssignment,
    this.expiryStage,
  });

  factory TrainingExpiration({
    int? id,
    required int certificateId,
    _i2.Certificate? certificate,
    required DateTime expiresAt,
    DateTime? reminderSentAt,
    int? renewalAssignmentId,
    _i3.TrainingAssignment? renewalAssignment,
    String? expiryStage,
  }) = _TrainingExpirationImpl;

  factory TrainingExpiration.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingExpiration(
      id: jsonSerialization['id'] as int?,
      certificateId: jsonSerialization['certificateId'] as int,
      certificate: jsonSerialization['certificate'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Certificate>(
              jsonSerialization['certificate'],
            ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      reminderSentAt: jsonSerialization['reminderSentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['reminderSentAt'],
            ),
      renewalAssignmentId: jsonSerialization['renewalAssignmentId'] as int?,
      renewalAssignment: jsonSerialization['renewalAssignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.TrainingAssignment>(
              jsonSerialization['renewalAssignment'],
            ),
      expiryStage: jsonSerialization['expiryStage'] as String?,
    );
  }

  static final t = TrainingExpirationTable();

  static const db = TrainingExpirationRepository._();

  @override
  int? id;

  int certificateId;

  /// The certificate.
  _i2.Certificate? certificate;

  /// When it expires.
  DateTime expiresAt;

  /// When reminder was sent.
  DateTime? reminderSentAt;

  int? renewalAssignmentId;

  /// Renewal assignment if created.
  _i3.TrainingAssignment? renewalAssignment;

  /// Expiry ladder stage: 90d, 60d, 30d, 7d, expired (ADM-06).
  String? expiryStage;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingExpiration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingExpiration copyWith({
    int? id,
    int? certificateId,
    _i2.Certificate? certificate,
    DateTime? expiresAt,
    DateTime? reminderSentAt,
    int? renewalAssignmentId,
    _i3.TrainingAssignment? renewalAssignment,
    String? expiryStage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingExpiration',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      if (certificate != null) 'certificate': certificate?.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      if (renewalAssignmentId != null)
        'renewalAssignmentId': renewalAssignmentId,
      if (renewalAssignment != null)
        'renewalAssignment': renewalAssignment?.toJson(),
      if (expiryStage != null) 'expiryStage': expiryStage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingExpiration',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      if (certificate != null) 'certificate': certificate?.toJsonForProtocol(),
      'expiresAt': expiresAt.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      if (renewalAssignmentId != null)
        'renewalAssignmentId': renewalAssignmentId,
      if (renewalAssignment != null)
        'renewalAssignment': renewalAssignment?.toJsonForProtocol(),
      if (expiryStage != null) 'expiryStage': expiryStage,
    };
  }

  static TrainingExpirationInclude include({
    _i2.CertificateInclude? certificate,
    _i3.TrainingAssignmentInclude? renewalAssignment,
  }) {
    return TrainingExpirationInclude._(
      certificate: certificate,
      renewalAssignment: renewalAssignment,
    );
  }

  static TrainingExpirationIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingExpirationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingExpirationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingExpirationTable>? orderByList,
    TrainingExpirationInclude? include,
  }) {
    return TrainingExpirationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingExpiration.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingExpiration.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingExpirationImpl extends TrainingExpiration {
  _TrainingExpirationImpl({
    int? id,
    required int certificateId,
    _i2.Certificate? certificate,
    required DateTime expiresAt,
    DateTime? reminderSentAt,
    int? renewalAssignmentId,
    _i3.TrainingAssignment? renewalAssignment,
    String? expiryStage,
  }) : super._(
         id: id,
         certificateId: certificateId,
         certificate: certificate,
         expiresAt: expiresAt,
         reminderSentAt: reminderSentAt,
         renewalAssignmentId: renewalAssignmentId,
         renewalAssignment: renewalAssignment,
         expiryStage: expiryStage,
       );

  /// Returns a shallow copy of this [TrainingExpiration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingExpiration copyWith({
    Object? id = _Undefined,
    int? certificateId,
    Object? certificate = _Undefined,
    DateTime? expiresAt,
    Object? reminderSentAt = _Undefined,
    Object? renewalAssignmentId = _Undefined,
    Object? renewalAssignment = _Undefined,
    Object? expiryStage = _Undefined,
  }) {
    return TrainingExpiration(
      id: id is int? ? id : this.id,
      certificateId: certificateId ?? this.certificateId,
      certificate: certificate is _i2.Certificate?
          ? certificate
          : this.certificate?.copyWith(),
      expiresAt: expiresAt ?? this.expiresAt,
      reminderSentAt: reminderSentAt is DateTime?
          ? reminderSentAt
          : this.reminderSentAt,
      renewalAssignmentId: renewalAssignmentId is int?
          ? renewalAssignmentId
          : this.renewalAssignmentId,
      renewalAssignment: renewalAssignment is _i3.TrainingAssignment?
          ? renewalAssignment
          : this.renewalAssignment?.copyWith(),
      expiryStage: expiryStage is String? ? expiryStage : this.expiryStage,
    );
  }
}

class TrainingExpirationUpdateTable
    extends _i1.UpdateTable<TrainingExpirationTable> {
  TrainingExpirationUpdateTable(super.table);

  _i1.ColumnValue<int, int> certificateId(int value) => _i1.ColumnValue(
    table.certificateId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> reminderSentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.reminderSentAt,
        value,
      );

  _i1.ColumnValue<int, int> renewalAssignmentId(int? value) => _i1.ColumnValue(
    table.renewalAssignmentId,
    value,
  );

  _i1.ColumnValue<String, String> expiryStage(String? value) => _i1.ColumnValue(
    table.expiryStage,
    value,
  );
}

class TrainingExpirationTable extends _i1.Table<int?> {
  TrainingExpirationTable({super.tableRelation})
    : super(tableName: 'training_expiration') {
    updateTable = TrainingExpirationUpdateTable(this);
    certificateId = _i1.ColumnInt(
      'certificateId',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    reminderSentAt = _i1.ColumnDateTime(
      'reminderSentAt',
      this,
    );
    renewalAssignmentId = _i1.ColumnInt(
      'renewalAssignmentId',
      this,
    );
    expiryStage = _i1.ColumnString(
      'expiryStage',
      this,
    );
  }

  late final TrainingExpirationUpdateTable updateTable;

  late final _i1.ColumnInt certificateId;

  /// The certificate.
  _i2.CertificateTable? _certificate;

  /// When it expires.
  late final _i1.ColumnDateTime expiresAt;

  /// When reminder was sent.
  late final _i1.ColumnDateTime reminderSentAt;

  late final _i1.ColumnInt renewalAssignmentId;

  /// Renewal assignment if created.
  _i3.TrainingAssignmentTable? _renewalAssignment;

  /// Expiry ladder stage: 90d, 60d, 30d, 7d, expired (ADM-06).
  late final _i1.ColumnString expiryStage;

  _i2.CertificateTable get certificate {
    if (_certificate != null) return _certificate!;
    _certificate = _i1.createRelationTable(
      relationFieldName: 'certificate',
      field: TrainingExpiration.t.certificateId,
      foreignField: _i2.Certificate.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CertificateTable(tableRelation: foreignTableRelation),
    );
    return _certificate!;
  }

  _i3.TrainingAssignmentTable get renewalAssignment {
    if (_renewalAssignment != null) return _renewalAssignment!;
    _renewalAssignment = _i1.createRelationTable(
      relationFieldName: 'renewalAssignment',
      field: TrainingExpiration.t.renewalAssignmentId,
      foreignField: _i3.TrainingAssignment.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TrainingAssignmentTable(tableRelation: foreignTableRelation),
    );
    return _renewalAssignment!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    certificateId,
    expiresAt,
    reminderSentAt,
    renewalAssignmentId,
    expiryStage,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'certificate') {
      return certificate;
    }
    if (relationField == 'renewalAssignment') {
      return renewalAssignment;
    }
    return null;
  }
}

class TrainingExpirationInclude extends _i1.IncludeObject {
  TrainingExpirationInclude._({
    _i2.CertificateInclude? certificate,
    _i3.TrainingAssignmentInclude? renewalAssignment,
  }) {
    _certificate = certificate;
    _renewalAssignment = renewalAssignment;
  }

  _i2.CertificateInclude? _certificate;

  _i3.TrainingAssignmentInclude? _renewalAssignment;

  @override
  Map<String, _i1.Include?> get includes => {
    'certificate': _certificate,
    'renewalAssignment': _renewalAssignment,
  };

  @override
  _i1.Table<int?> get table => TrainingExpiration.t;
}

class TrainingExpirationIncludeList extends _i1.IncludeList {
  TrainingExpirationIncludeList._({
    _i1.WhereExpressionBuilder<TrainingExpirationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingExpiration.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingExpiration.t;
}

class TrainingExpirationRepository {
  const TrainingExpirationRepository._();

  final attachRow = const TrainingExpirationAttachRowRepository._();

  final detachRow = const TrainingExpirationDetachRowRepository._();

  /// Returns a list of [TrainingExpiration]s matching the given query parameters.
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
  Future<List<TrainingExpiration>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingExpirationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingExpirationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingExpirationTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingExpirationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingExpiration>(
      where: where?.call(TrainingExpiration.t),
      orderBy: orderBy?.call(TrainingExpiration.t),
      orderByList: orderByList?.call(TrainingExpiration.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingExpiration] matching the given query parameters.
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
  Future<TrainingExpiration?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingExpirationTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingExpirationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingExpirationTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingExpirationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingExpiration>(
      where: where?.call(TrainingExpiration.t),
      orderBy: orderBy?.call(TrainingExpiration.t),
      orderByList: orderByList?.call(TrainingExpiration.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingExpiration] by its [id] or null if no such row exists.
  Future<TrainingExpiration?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingExpirationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingExpiration>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingExpiration]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingExpiration]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingExpiration>> insert(
    _i1.DatabaseSession session,
    List<TrainingExpiration> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingExpiration>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingExpiration] and returns the inserted row.
  ///
  /// The returned [TrainingExpiration] will have its `id` field set.
  Future<TrainingExpiration> insertRow(
    _i1.DatabaseSession session,
    TrainingExpiration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingExpiration>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingExpiration]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingExpiration>> update(
    _i1.DatabaseSession session,
    List<TrainingExpiration> rows, {
    _i1.ColumnSelections<TrainingExpirationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingExpiration>(
      rows,
      columns: columns?.call(TrainingExpiration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingExpiration]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingExpiration> updateRow(
    _i1.DatabaseSession session,
    TrainingExpiration row, {
    _i1.ColumnSelections<TrainingExpirationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingExpiration>(
      row,
      columns: columns?.call(TrainingExpiration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingExpiration] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingExpiration?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingExpirationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingExpiration>(
      id,
      columnValues: columnValues(TrainingExpiration.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingExpiration]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingExpiration>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingExpirationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingExpirationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingExpirationTable>? orderBy,
    _i1.OrderByListBuilder<TrainingExpirationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingExpiration>(
      columnValues: columnValues(TrainingExpiration.t.updateTable),
      where: where(TrainingExpiration.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingExpiration.t),
      orderByList: orderByList?.call(TrainingExpiration.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingExpiration]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingExpiration>> delete(
    _i1.DatabaseSession session,
    List<TrainingExpiration> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingExpiration>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingExpiration].
  Future<TrainingExpiration> deleteRow(
    _i1.DatabaseSession session,
    TrainingExpiration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingExpiration>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingExpiration>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingExpirationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingExpiration>(
      where: where(TrainingExpiration.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingExpirationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingExpiration>(
      where: where?.call(TrainingExpiration.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingExpiration] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingExpirationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingExpiration>(
      where: where(TrainingExpiration.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingExpirationAttachRowRepository {
  const TrainingExpirationAttachRowRepository._();

  /// Creates a relation between the given [TrainingExpiration] and [Certificate]
  /// by setting the [TrainingExpiration]'s foreign key `certificateId` to refer to the [Certificate].
  Future<void> certificate(
    _i1.DatabaseSession session,
    TrainingExpiration trainingExpiration,
    _i2.Certificate certificate, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingExpiration.id == null) {
      throw ArgumentError.notNull('trainingExpiration.id');
    }
    if (certificate.id == null) {
      throw ArgumentError.notNull('certificate.id');
    }

    var $trainingExpiration = trainingExpiration.copyWith(
      certificateId: certificate.id,
    );
    await session.db.updateRow<TrainingExpiration>(
      $trainingExpiration,
      columns: [TrainingExpiration.t.certificateId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingExpiration] and [TrainingAssignment]
  /// by setting the [TrainingExpiration]'s foreign key `renewalAssignmentId` to refer to the [TrainingAssignment].
  Future<void> renewalAssignment(
    _i1.DatabaseSession session,
    TrainingExpiration trainingExpiration,
    _i3.TrainingAssignment renewalAssignment, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingExpiration.id == null) {
      throw ArgumentError.notNull('trainingExpiration.id');
    }
    if (renewalAssignment.id == null) {
      throw ArgumentError.notNull('renewalAssignment.id');
    }

    var $trainingExpiration = trainingExpiration.copyWith(
      renewalAssignmentId: renewalAssignment.id,
    );
    await session.db.updateRow<TrainingExpiration>(
      $trainingExpiration,
      columns: [TrainingExpiration.t.renewalAssignmentId],
      transaction: transaction,
    );
  }
}

class TrainingExpirationDetachRowRepository {
  const TrainingExpirationDetachRowRepository._();

  /// Detaches the relation between this [TrainingExpiration] and the [TrainingAssignment] set in `renewalAssignment`
  /// by setting the [TrainingExpiration]'s foreign key `renewalAssignmentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> renewalAssignment(
    _i1.DatabaseSession session,
    TrainingExpiration trainingExpiration, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingExpiration.id == null) {
      throw ArgumentError.notNull('trainingExpiration.id');
    }

    var $trainingExpiration = trainingExpiration.copyWith(
      renewalAssignmentId: null,
    );
    await session.db.updateRow<TrainingExpiration>(
      $trainingExpiration,
      columns: [TrainingExpiration.t.renewalAssignmentId],
      transaction: transaction,
    );
  }
}
