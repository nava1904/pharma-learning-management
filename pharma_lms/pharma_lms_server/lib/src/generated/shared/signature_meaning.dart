/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Configurable e-signature meaning for 21 CFR Part 11 compliance.
abstract class SignatureMeaning
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SignatureMeaning._({
    this.id,
    required this.meaning,
    bool? isActive,
    int? orderIndex,
    this.applicableTo,
  }) : isActive = isActive ?? true,
       orderIndex = orderIndex ?? 0;

  factory SignatureMeaning({
    int? id,
    required String meaning,
    bool? isActive,
    int? orderIndex,
    String? applicableTo,
  }) = _SignatureMeaningImpl;

  factory SignatureMeaning.fromJson(Map<String, dynamic> jsonSerialization) {
    return SignatureMeaning(
      id: jsonSerialization['id'] as int?,
      meaning: jsonSerialization['meaning'] as String,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      applicableTo: jsonSerialization['applicableTo'] as String?,
    );
  }

  static final t = SignatureMeaningTable();

  static const db = SignatureMeaningRepository._();

  @override
  int? id;

  /// The meaning text (e.g., "I have read, understood, and agree to comply").
  String meaning;

  /// Whether this meaning is available for selection.
  bool isActive;

  /// Display order (lower = first).
  int orderIndex;

  /// Applicable to: training_completion, course_approval, capa_closure, document_acknowledgement.
  String? applicableTo;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SignatureMeaning]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SignatureMeaning copyWith({
    int? id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
    String? applicableTo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SignatureMeaning',
      if (id != null) 'id': id,
      'meaning': meaning,
      'isActive': isActive,
      'orderIndex': orderIndex,
      if (applicableTo != null) 'applicableTo': applicableTo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SignatureMeaning',
      if (id != null) 'id': id,
      'meaning': meaning,
      'isActive': isActive,
      'orderIndex': orderIndex,
      if (applicableTo != null) 'applicableTo': applicableTo,
    };
  }

  static SignatureMeaningInclude include() {
    return SignatureMeaningInclude._();
  }

  static SignatureMeaningIncludeList includeList({
    _i1.WhereExpressionBuilder<SignatureMeaningTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SignatureMeaningTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SignatureMeaningTable>? orderByList,
    SignatureMeaningInclude? include,
  }) {
    return SignatureMeaningIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SignatureMeaning.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SignatureMeaning.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SignatureMeaningImpl extends SignatureMeaning {
  _SignatureMeaningImpl({
    int? id,
    required String meaning,
    bool? isActive,
    int? orderIndex,
    String? applicableTo,
  }) : super._(
         id: id,
         meaning: meaning,
         isActive: isActive,
         orderIndex: orderIndex,
         applicableTo: applicableTo,
       );

  /// Returns a shallow copy of this [SignatureMeaning]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SignatureMeaning copyWith({
    Object? id = _Undefined,
    String? meaning,
    bool? isActive,
    int? orderIndex,
    Object? applicableTo = _Undefined,
  }) {
    return SignatureMeaning(
      id: id is int? ? id : this.id,
      meaning: meaning ?? this.meaning,
      isActive: isActive ?? this.isActive,
      orderIndex: orderIndex ?? this.orderIndex,
      applicableTo: applicableTo is String? ? applicableTo : this.applicableTo,
    );
  }
}

class SignatureMeaningUpdateTable
    extends _i1.UpdateTable<SignatureMeaningTable> {
  SignatureMeaningUpdateTable(super.table);

  _i1.ColumnValue<String, String> meaning(String value) => _i1.ColumnValue(
    table.meaning,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<int, int> orderIndex(int value) => _i1.ColumnValue(
    table.orderIndex,
    value,
  );

  _i1.ColumnValue<String, String> applicableTo(String? value) =>
      _i1.ColumnValue(
        table.applicableTo,
        value,
      );
}

class SignatureMeaningTable extends _i1.Table<int?> {
  SignatureMeaningTable({super.tableRelation})
    : super(tableName: 'signature_meaning') {
    updateTable = SignatureMeaningUpdateTable(this);
    meaning = _i1.ColumnString(
      'meaning',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
      hasDefault: true,
    );
    applicableTo = _i1.ColumnString(
      'applicableTo',
      this,
    );
  }

  late final SignatureMeaningUpdateTable updateTable;

  /// The meaning text (e.g., "I have read, understood, and agree to comply").
  late final _i1.ColumnString meaning;

  /// Whether this meaning is available for selection.
  late final _i1.ColumnBool isActive;

  /// Display order (lower = first).
  late final _i1.ColumnInt orderIndex;

  /// Applicable to: training_completion, course_approval, capa_closure, document_acknowledgement.
  late final _i1.ColumnString applicableTo;

  @override
  List<_i1.Column> get columns => [
    id,
    meaning,
    isActive,
    orderIndex,
    applicableTo,
  ];
}

class SignatureMeaningInclude extends _i1.IncludeObject {
  SignatureMeaningInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SignatureMeaning.t;
}

class SignatureMeaningIncludeList extends _i1.IncludeList {
  SignatureMeaningIncludeList._({
    _i1.WhereExpressionBuilder<SignatureMeaningTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SignatureMeaning.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SignatureMeaning.t;
}

class SignatureMeaningRepository {
  const SignatureMeaningRepository._();

  /// Returns a list of [SignatureMeaning]s matching the given query parameters.
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
  Future<List<SignatureMeaning>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SignatureMeaningTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SignatureMeaningTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SignatureMeaningTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SignatureMeaning>(
      where: where?.call(SignatureMeaning.t),
      orderBy: orderBy?.call(SignatureMeaning.t),
      orderByList: orderByList?.call(SignatureMeaning.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SignatureMeaning] matching the given query parameters.
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
  Future<SignatureMeaning?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SignatureMeaningTable>? where,
    int? offset,
    _i1.OrderByBuilder<SignatureMeaningTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SignatureMeaningTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SignatureMeaning>(
      where: where?.call(SignatureMeaning.t),
      orderBy: orderBy?.call(SignatureMeaning.t),
      orderByList: orderByList?.call(SignatureMeaning.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SignatureMeaning] by its [id] or null if no such row exists.
  Future<SignatureMeaning?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SignatureMeaning>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SignatureMeaning]s in the list and returns the inserted rows.
  ///
  /// The returned [SignatureMeaning]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SignatureMeaning>> insert(
    _i1.DatabaseSession session,
    List<SignatureMeaning> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SignatureMeaning>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SignatureMeaning] and returns the inserted row.
  ///
  /// The returned [SignatureMeaning] will have its `id` field set.
  Future<SignatureMeaning> insertRow(
    _i1.DatabaseSession session,
    SignatureMeaning row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SignatureMeaning>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SignatureMeaning]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SignatureMeaning>> update(
    _i1.DatabaseSession session,
    List<SignatureMeaning> rows, {
    _i1.ColumnSelections<SignatureMeaningTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SignatureMeaning>(
      rows,
      columns: columns?.call(SignatureMeaning.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SignatureMeaning]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SignatureMeaning> updateRow(
    _i1.DatabaseSession session,
    SignatureMeaning row, {
    _i1.ColumnSelections<SignatureMeaningTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SignatureMeaning>(
      row,
      columns: columns?.call(SignatureMeaning.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SignatureMeaning] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SignatureMeaning?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SignatureMeaningUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SignatureMeaning>(
      id,
      columnValues: columnValues(SignatureMeaning.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SignatureMeaning]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SignatureMeaning>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SignatureMeaningUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SignatureMeaningTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SignatureMeaningTable>? orderBy,
    _i1.OrderByListBuilder<SignatureMeaningTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SignatureMeaning>(
      columnValues: columnValues(SignatureMeaning.t.updateTable),
      where: where(SignatureMeaning.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SignatureMeaning.t),
      orderByList: orderByList?.call(SignatureMeaning.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SignatureMeaning]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SignatureMeaning>> delete(
    _i1.DatabaseSession session,
    List<SignatureMeaning> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SignatureMeaning>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SignatureMeaning].
  Future<SignatureMeaning> deleteRow(
    _i1.DatabaseSession session,
    SignatureMeaning row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SignatureMeaning>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SignatureMeaning>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SignatureMeaningTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SignatureMeaning>(
      where: where(SignatureMeaning.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SignatureMeaningTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SignatureMeaning>(
      where: where?.call(SignatureMeaning.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SignatureMeaning] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SignatureMeaningTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SignatureMeaning>(
      where: where(SignatureMeaning.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
