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
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Electronic signature for 21 CFR Part 11 compliance.
abstract class ElectronicSignature
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ElectronicSignature._({
    this.id,
    required this.userId,
    this.user,
    DateTime? timestamp,
    required this.signatureMeaning,
    this.passwordReauthHash,
    required this.entityType,
    required this.entityId,
    this.ipAddress,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ElectronicSignature({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? timestamp,
    required String signatureMeaning,
    String? passwordReauthHash,
    required String entityType,
    required String entityId,
    String? ipAddress,
  }) = _ElectronicSignatureImpl;

  factory ElectronicSignature.fromJson(Map<String, dynamic> jsonSerialization) {
    return ElectronicSignature(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      signatureMeaning: jsonSerialization['signatureMeaning'] as String,
      passwordReauthHash: jsonSerialization['passwordReauthHash'] as String?,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String,
      ipAddress: jsonSerialization['ipAddress'] as String?,
    );
  }

  static final t = ElectronicSignatureTable();

  static const db = ElectronicSignatureRepository._();

  @override
  int? id;

  int userId;

  /// User who signed.
  _i2.PharmaUser? user;

  /// Timestamp of signature (NTP-synced).
  DateTime timestamp;

  /// Signature meaning: "I have read and understood", "Verification", "Approval".
  String signatureMeaning;

  /// Hash of password re-authentication (for verification).
  String? passwordReauthHash;

  /// Entity type signed (e.g., training_record, certificate).
  String entityType;

  /// Entity ID signed.
  String entityId;

  /// IP address at time of signature.
  String? ipAddress;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ElectronicSignature]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ElectronicSignature copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    DateTime? timestamp,
    String? signatureMeaning,
    String? passwordReauthHash,
    String? entityType,
    String? entityId,
    String? ipAddress,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ElectronicSignature',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'timestamp': timestamp.toJson(),
      'signatureMeaning': signatureMeaning,
      if (passwordReauthHash != null) 'passwordReauthHash': passwordReauthHash,
      'entityType': entityType,
      'entityId': entityId,
      if (ipAddress != null) 'ipAddress': ipAddress,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ElectronicSignature',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
      'timestamp': timestamp.toJson(),
      'signatureMeaning': signatureMeaning,
      if (passwordReauthHash != null) 'passwordReauthHash': passwordReauthHash,
      'entityType': entityType,
      'entityId': entityId,
      if (ipAddress != null) 'ipAddress': ipAddress,
    };
  }

  static ElectronicSignatureInclude include({_i2.PharmaUserInclude? user}) {
    return ElectronicSignatureInclude._(user: user);
  }

  static ElectronicSignatureIncludeList includeList({
    _i1.WhereExpressionBuilder<ElectronicSignatureTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ElectronicSignatureTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ElectronicSignatureTable>? orderByList,
    ElectronicSignatureInclude? include,
  }) {
    return ElectronicSignatureIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ElectronicSignature.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ElectronicSignature.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ElectronicSignatureImpl extends ElectronicSignature {
  _ElectronicSignatureImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    DateTime? timestamp,
    required String signatureMeaning,
    String? passwordReauthHash,
    required String entityType,
    required String entityId,
    String? ipAddress,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         timestamp: timestamp,
         signatureMeaning: signatureMeaning,
         passwordReauthHash: passwordReauthHash,
         entityType: entityType,
         entityId: entityId,
         ipAddress: ipAddress,
       );

  /// Returns a shallow copy of this [ElectronicSignature]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ElectronicSignature copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    DateTime? timestamp,
    String? signatureMeaning,
    Object? passwordReauthHash = _Undefined,
    String? entityType,
    String? entityId,
    Object? ipAddress = _Undefined,
  }) {
    return ElectronicSignature(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      timestamp: timestamp ?? this.timestamp,
      signatureMeaning: signatureMeaning ?? this.signatureMeaning,
      passwordReauthHash: passwordReauthHash is String?
          ? passwordReauthHash
          : this.passwordReauthHash,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
    );
  }
}

class ElectronicSignatureUpdateTable
    extends _i1.UpdateTable<ElectronicSignatureTable> {
  ElectronicSignatureUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<String, String> signatureMeaning(String value) =>
      _i1.ColumnValue(
        table.signatureMeaning,
        value,
      );

  _i1.ColumnValue<String, String> passwordReauthHash(String? value) =>
      _i1.ColumnValue(
        table.passwordReauthHash,
        value,
      );

  _i1.ColumnValue<String, String> entityType(String value) => _i1.ColumnValue(
    table.entityType,
    value,
  );

  _i1.ColumnValue<String, String> entityId(String value) => _i1.ColumnValue(
    table.entityId,
    value,
  );

  _i1.ColumnValue<String, String> ipAddress(String? value) => _i1.ColumnValue(
    table.ipAddress,
    value,
  );
}

class ElectronicSignatureTable extends _i1.Table<int?> {
  ElectronicSignatureTable({super.tableRelation})
    : super(tableName: 'electronic_signature') {
    updateTable = ElectronicSignatureUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
    signatureMeaning = _i1.ColumnString(
      'signatureMeaning',
      this,
    );
    passwordReauthHash = _i1.ColumnString(
      'passwordReauthHash',
      this,
    );
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    entityId = _i1.ColumnString(
      'entityId',
      this,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
      this,
    );
  }

  late final ElectronicSignatureUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  /// User who signed.
  _i2.PharmaUserTable? _user;

  /// Timestamp of signature (NTP-synced).
  late final _i1.ColumnDateTime timestamp;

  /// Signature meaning: "I have read and understood", "Verification", "Approval".
  late final _i1.ColumnString signatureMeaning;

  /// Hash of password re-authentication (for verification).
  late final _i1.ColumnString passwordReauthHash;

  /// Entity type signed (e.g., training_record, certificate).
  late final _i1.ColumnString entityType;

  /// Entity ID signed.
  late final _i1.ColumnString entityId;

  /// IP address at time of signature.
  late final _i1.ColumnString ipAddress;

  _i2.PharmaUserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: ElectronicSignature.t.userId,
      foreignField: _i2.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    timestamp,
    signatureMeaning,
    passwordReauthHash,
    entityType,
    entityId,
    ipAddress,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class ElectronicSignatureInclude extends _i1.IncludeObject {
  ElectronicSignatureInclude._({_i2.PharmaUserInclude? user}) {
    _user = user;
  }

  _i2.PharmaUserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => ElectronicSignature.t;
}

class ElectronicSignatureIncludeList extends _i1.IncludeList {
  ElectronicSignatureIncludeList._({
    _i1.WhereExpressionBuilder<ElectronicSignatureTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ElectronicSignature.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ElectronicSignature.t;
}

class ElectronicSignatureRepository {
  const ElectronicSignatureRepository._();

  final attachRow = const ElectronicSignatureAttachRowRepository._();

  /// Returns a list of [ElectronicSignature]s matching the given query parameters.
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
  Future<List<ElectronicSignature>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ElectronicSignatureTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ElectronicSignatureTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ElectronicSignatureTable>? orderByList,
    _i1.Transaction? transaction,
    ElectronicSignatureInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ElectronicSignature>(
      where: where?.call(ElectronicSignature.t),
      orderBy: orderBy?.call(ElectronicSignature.t),
      orderByList: orderByList?.call(ElectronicSignature.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ElectronicSignature] matching the given query parameters.
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
  Future<ElectronicSignature?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ElectronicSignatureTable>? where,
    int? offset,
    _i1.OrderByBuilder<ElectronicSignatureTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ElectronicSignatureTable>? orderByList,
    _i1.Transaction? transaction,
    ElectronicSignatureInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ElectronicSignature>(
      where: where?.call(ElectronicSignature.t),
      orderBy: orderBy?.call(ElectronicSignature.t),
      orderByList: orderByList?.call(ElectronicSignature.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ElectronicSignature] by its [id] or null if no such row exists.
  Future<ElectronicSignature?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ElectronicSignatureInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ElectronicSignature>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ElectronicSignature]s in the list and returns the inserted rows.
  ///
  /// The returned [ElectronicSignature]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ElectronicSignature>> insert(
    _i1.Session session,
    List<ElectronicSignature> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ElectronicSignature>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ElectronicSignature] and returns the inserted row.
  ///
  /// The returned [ElectronicSignature] will have its `id` field set.
  Future<ElectronicSignature> insertRow(
    _i1.Session session,
    ElectronicSignature row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ElectronicSignature>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ElectronicSignature]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ElectronicSignature>> update(
    _i1.Session session,
    List<ElectronicSignature> rows, {
    _i1.ColumnSelections<ElectronicSignatureTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ElectronicSignature>(
      rows,
      columns: columns?.call(ElectronicSignature.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ElectronicSignature]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ElectronicSignature> updateRow(
    _i1.Session session,
    ElectronicSignature row, {
    _i1.ColumnSelections<ElectronicSignatureTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ElectronicSignature>(
      row,
      columns: columns?.call(ElectronicSignature.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ElectronicSignature] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ElectronicSignature?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ElectronicSignatureUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ElectronicSignature>(
      id,
      columnValues: columnValues(ElectronicSignature.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ElectronicSignature]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ElectronicSignature>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ElectronicSignatureUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ElectronicSignatureTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ElectronicSignatureTable>? orderBy,
    _i1.OrderByListBuilder<ElectronicSignatureTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ElectronicSignature>(
      columnValues: columnValues(ElectronicSignature.t.updateTable),
      where: where(ElectronicSignature.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ElectronicSignature.t),
      orderByList: orderByList?.call(ElectronicSignature.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ElectronicSignature]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ElectronicSignature>> delete(
    _i1.Session session,
    List<ElectronicSignature> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ElectronicSignature>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ElectronicSignature].
  Future<ElectronicSignature> deleteRow(
    _i1.Session session,
    ElectronicSignature row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ElectronicSignature>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ElectronicSignature>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ElectronicSignatureTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ElectronicSignature>(
      where: where(ElectronicSignature.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ElectronicSignatureTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ElectronicSignature>(
      where: where?.call(ElectronicSignature.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ElectronicSignature] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ElectronicSignatureTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ElectronicSignature>(
      where: where(ElectronicSignature.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ElectronicSignatureAttachRowRepository {
  const ElectronicSignatureAttachRowRepository._();

  /// Creates a relation between the given [ElectronicSignature] and [PharmaUser]
  /// by setting the [ElectronicSignature]'s foreign key `userId` to refer to the [PharmaUser].
  Future<void> user(
    _i1.Session session,
    ElectronicSignature electronicSignature,
    _i2.PharmaUser user, {
    _i1.Transaction? transaction,
  }) async {
    if (electronicSignature.id == null) {
      throw ArgumentError.notNull('electronicSignature.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $electronicSignature = electronicSignature.copyWith(userId: user.id);
    await session.db.updateRow<ElectronicSignature>(
      $electronicSignature,
      columns: [ElectronicSignature.t.userId],
      transaction: transaction,
    );
  }
}
