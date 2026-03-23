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
import '../audit/inspection_record.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i5;

/// Inspection package - compliance evidence bundle. FDA.
abstract class InspectionPackage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InspectionPackage._({
    this.id,
    required this.inspectionRecordId,
    this.inspectionRecord,
    required this.generatedById,
    this.generatedBy,
    DateTime? generatedAt,
    this.scopeDescription,
    this.includedRecordsCount,
    this.fileHash,
    this.storageUrl,
    this.watermarkText,
    bool? isOfficial,
    this.officialEsignatureId,
    this.officialEsignature,
  }) : generatedAt = generatedAt ?? DateTime.now(),
       isOfficial = isOfficial ?? false;

  factory InspectionPackage({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    required int generatedById,
    _i3.PharmaUser? generatedBy,
    DateTime? generatedAt,
    String? scopeDescription,
    int? includedRecordsCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    bool? isOfficial,
    int? officialEsignatureId,
    _i4.ElectronicSignature? officialEsignature,
  }) = _InspectionPackageImpl;

  factory InspectionPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return InspectionPackage(
      id: jsonSerialization['id'] as int?,
      inspectionRecordId: jsonSerialization['inspectionRecordId'] as int,
      inspectionRecord: jsonSerialization['inspectionRecord'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.InspectionRecord>(
              jsonSerialization['inspectionRecord'],
            ),
      generatedById: jsonSerialization['generatedById'] as int,
      generatedBy: jsonSerialization['generatedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['generatedBy'],
            ),
      generatedAt: jsonSerialization['generatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['generatedAt'],
            ),
      scopeDescription: jsonSerialization['scopeDescription'] as String?,
      includedRecordsCount: jsonSerialization['includedRecordsCount'] as int?,
      fileHash: jsonSerialization['fileHash'] as String?,
      storageUrl: jsonSerialization['storageUrl'] as String?,
      watermarkText: jsonSerialization['watermarkText'] as String?,
      isOfficial: jsonSerialization['isOfficial'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isOfficial']),
      officialEsignatureId: jsonSerialization['officialEsignatureId'] as int?,
      officialEsignature: jsonSerialization['officialEsignature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['officialEsignature'],
            ),
    );
  }

  static final t = InspectionPackageTable();

  static const db = InspectionPackageRepository._();

  @override
  int? id;

  int inspectionRecordId;

  /// The inspection record.
  _i2.InspectionRecord? inspectionRecord;

  int generatedById;

  /// Who generated the package.
  _i3.PharmaUser? generatedBy;

  /// When generated.
  DateTime generatedAt;

  /// Scope description.
  String? scopeDescription;

  /// Included records count.
  int? includedRecordsCount;

  /// SHA-256 file hash.
  String? fileHash;

  /// Storage URL.
  String? storageUrl;

  /// Watermark text.
  String? watermarkText;

  /// Whether officially signed by QA Director.
  bool isOfficial;

  int? officialEsignatureId;

  /// Official e-signature.
  _i4.ElectronicSignature? officialEsignature;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InspectionPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InspectionPackage copyWith({
    int? id,
    int? inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? generatedById,
    _i3.PharmaUser? generatedBy,
    DateTime? generatedAt,
    String? scopeDescription,
    int? includedRecordsCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    bool? isOfficial,
    int? officialEsignatureId,
    _i4.ElectronicSignature? officialEsignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InspectionPackage',
      if (id != null) 'id': id,
      'inspectionRecordId': inspectionRecordId,
      if (inspectionRecord != null)
        'inspectionRecord': inspectionRecord?.toJson(),
      'generatedById': generatedById,
      if (generatedBy != null) 'generatedBy': generatedBy?.toJson(),
      'generatedAt': generatedAt.toJson(),
      if (scopeDescription != null) 'scopeDescription': scopeDescription,
      if (includedRecordsCount != null)
        'includedRecordsCount': includedRecordsCount,
      if (fileHash != null) 'fileHash': fileHash,
      if (storageUrl != null) 'storageUrl': storageUrl,
      if (watermarkText != null) 'watermarkText': watermarkText,
      'isOfficial': isOfficial,
      if (officialEsignatureId != null)
        'officialEsignatureId': officialEsignatureId,
      if (officialEsignature != null)
        'officialEsignature': officialEsignature?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InspectionPackage',
      if (id != null) 'id': id,
      'inspectionRecordId': inspectionRecordId,
      if (inspectionRecord != null)
        'inspectionRecord': inspectionRecord?.toJsonForProtocol(),
      'generatedById': generatedById,
      if (generatedBy != null) 'generatedBy': generatedBy?.toJsonForProtocol(),
      'generatedAt': generatedAt.toJson(),
      if (scopeDescription != null) 'scopeDescription': scopeDescription,
      if (includedRecordsCount != null)
        'includedRecordsCount': includedRecordsCount,
      if (fileHash != null) 'fileHash': fileHash,
      if (storageUrl != null) 'storageUrl': storageUrl,
      if (watermarkText != null) 'watermarkText': watermarkText,
      'isOfficial': isOfficial,
      if (officialEsignatureId != null)
        'officialEsignatureId': officialEsignatureId,
      if (officialEsignature != null)
        'officialEsignature': officialEsignature?.toJsonForProtocol(),
    };
  }

  static InspectionPackageInclude include({
    _i2.InspectionRecordInclude? inspectionRecord,
    _i3.PharmaUserInclude? generatedBy,
    _i4.ElectronicSignatureInclude? officialEsignature,
  }) {
    return InspectionPackageInclude._(
      inspectionRecord: inspectionRecord,
      generatedBy: generatedBy,
      officialEsignature: officialEsignature,
    );
  }

  static InspectionPackageIncludeList includeList({
    _i1.WhereExpressionBuilder<InspectionPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionPackageTable>? orderByList,
    InspectionPackageInclude? include,
  }) {
    return InspectionPackageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InspectionPackage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InspectionPackage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InspectionPackageImpl extends InspectionPackage {
  _InspectionPackageImpl({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    required int generatedById,
    _i3.PharmaUser? generatedBy,
    DateTime? generatedAt,
    String? scopeDescription,
    int? includedRecordsCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    bool? isOfficial,
    int? officialEsignatureId,
    _i4.ElectronicSignature? officialEsignature,
  }) : super._(
         id: id,
         inspectionRecordId: inspectionRecordId,
         inspectionRecord: inspectionRecord,
         generatedById: generatedById,
         generatedBy: generatedBy,
         generatedAt: generatedAt,
         scopeDescription: scopeDescription,
         includedRecordsCount: includedRecordsCount,
         fileHash: fileHash,
         storageUrl: storageUrl,
         watermarkText: watermarkText,
         isOfficial: isOfficial,
         officialEsignatureId: officialEsignatureId,
         officialEsignature: officialEsignature,
       );

  /// Returns a shallow copy of this [InspectionPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InspectionPackage copyWith({
    Object? id = _Undefined,
    int? inspectionRecordId,
    Object? inspectionRecord = _Undefined,
    int? generatedById,
    Object? generatedBy = _Undefined,
    DateTime? generatedAt,
    Object? scopeDescription = _Undefined,
    Object? includedRecordsCount = _Undefined,
    Object? fileHash = _Undefined,
    Object? storageUrl = _Undefined,
    Object? watermarkText = _Undefined,
    bool? isOfficial,
    Object? officialEsignatureId = _Undefined,
    Object? officialEsignature = _Undefined,
  }) {
    return InspectionPackage(
      id: id is int? ? id : this.id,
      inspectionRecordId: inspectionRecordId ?? this.inspectionRecordId,
      inspectionRecord: inspectionRecord is _i2.InspectionRecord?
          ? inspectionRecord
          : this.inspectionRecord?.copyWith(),
      generatedById: generatedById ?? this.generatedById,
      generatedBy: generatedBy is _i3.PharmaUser?
          ? generatedBy
          : this.generatedBy?.copyWith(),
      generatedAt: generatedAt ?? this.generatedAt,
      scopeDescription: scopeDescription is String?
          ? scopeDescription
          : this.scopeDescription,
      includedRecordsCount: includedRecordsCount is int?
          ? includedRecordsCount
          : this.includedRecordsCount,
      fileHash: fileHash is String? ? fileHash : this.fileHash,
      storageUrl: storageUrl is String? ? storageUrl : this.storageUrl,
      watermarkText: watermarkText is String?
          ? watermarkText
          : this.watermarkText,
      isOfficial: isOfficial ?? this.isOfficial,
      officialEsignatureId: officialEsignatureId is int?
          ? officialEsignatureId
          : this.officialEsignatureId,
      officialEsignature: officialEsignature is _i4.ElectronicSignature?
          ? officialEsignature
          : this.officialEsignature?.copyWith(),
    );
  }
}

class InspectionPackageUpdateTable
    extends _i1.UpdateTable<InspectionPackageTable> {
  InspectionPackageUpdateTable(super.table);

  _i1.ColumnValue<int, int> inspectionRecordId(int value) => _i1.ColumnValue(
    table.inspectionRecordId,
    value,
  );

  _i1.ColumnValue<int, int> generatedById(int value) => _i1.ColumnValue(
    table.generatedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> generatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.generatedAt,
        value,
      );

  _i1.ColumnValue<String, String> scopeDescription(String? value) =>
      _i1.ColumnValue(
        table.scopeDescription,
        value,
      );

  _i1.ColumnValue<int, int> includedRecordsCount(int? value) => _i1.ColumnValue(
    table.includedRecordsCount,
    value,
  );

  _i1.ColumnValue<String, String> fileHash(String? value) => _i1.ColumnValue(
    table.fileHash,
    value,
  );

  _i1.ColumnValue<String, String> storageUrl(String? value) => _i1.ColumnValue(
    table.storageUrl,
    value,
  );

  _i1.ColumnValue<String, String> watermarkText(String? value) =>
      _i1.ColumnValue(
        table.watermarkText,
        value,
      );

  _i1.ColumnValue<bool, bool> isOfficial(bool value) => _i1.ColumnValue(
    table.isOfficial,
    value,
  );

  _i1.ColumnValue<int, int> officialEsignatureId(int? value) => _i1.ColumnValue(
    table.officialEsignatureId,
    value,
  );
}

class InspectionPackageTable extends _i1.Table<int?> {
  InspectionPackageTable({super.tableRelation})
    : super(tableName: 'inspection_package') {
    updateTable = InspectionPackageUpdateTable(this);
    inspectionRecordId = _i1.ColumnInt(
      'inspectionRecordId',
      this,
    );
    generatedById = _i1.ColumnInt(
      'generatedById',
      this,
    );
    generatedAt = _i1.ColumnDateTime(
      'generatedAt',
      this,
      hasDefault: true,
    );
    scopeDescription = _i1.ColumnString(
      'scopeDescription',
      this,
    );
    includedRecordsCount = _i1.ColumnInt(
      'includedRecordsCount',
      this,
    );
    fileHash = _i1.ColumnString(
      'fileHash',
      this,
    );
    storageUrl = _i1.ColumnString(
      'storageUrl',
      this,
    );
    watermarkText = _i1.ColumnString(
      'watermarkText',
      this,
    );
    isOfficial = _i1.ColumnBool(
      'isOfficial',
      this,
      hasDefault: true,
    );
    officialEsignatureId = _i1.ColumnInt(
      'officialEsignatureId',
      this,
    );
  }

  late final InspectionPackageUpdateTable updateTable;

  late final _i1.ColumnInt inspectionRecordId;

  /// The inspection record.
  _i2.InspectionRecordTable? _inspectionRecord;

  late final _i1.ColumnInt generatedById;

  /// Who generated the package.
  _i3.PharmaUserTable? _generatedBy;

  /// When generated.
  late final _i1.ColumnDateTime generatedAt;

  /// Scope description.
  late final _i1.ColumnString scopeDescription;

  /// Included records count.
  late final _i1.ColumnInt includedRecordsCount;

  /// SHA-256 file hash.
  late final _i1.ColumnString fileHash;

  /// Storage URL.
  late final _i1.ColumnString storageUrl;

  /// Watermark text.
  late final _i1.ColumnString watermarkText;

  /// Whether officially signed by QA Director.
  late final _i1.ColumnBool isOfficial;

  late final _i1.ColumnInt officialEsignatureId;

  /// Official e-signature.
  _i4.ElectronicSignatureTable? _officialEsignature;

  _i2.InspectionRecordTable get inspectionRecord {
    if (_inspectionRecord != null) return _inspectionRecord!;
    _inspectionRecord = _i1.createRelationTable(
      relationFieldName: 'inspectionRecord',
      field: InspectionPackage.t.inspectionRecordId,
      foreignField: _i2.InspectionRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.InspectionRecordTable(tableRelation: foreignTableRelation),
    );
    return _inspectionRecord!;
  }

  _i3.PharmaUserTable get generatedBy {
    if (_generatedBy != null) return _generatedBy!;
    _generatedBy = _i1.createRelationTable(
      relationFieldName: 'generatedBy',
      field: InspectionPackage.t.generatedById,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _generatedBy!;
  }

  _i4.ElectronicSignatureTable get officialEsignature {
    if (_officialEsignature != null) return _officialEsignature!;
    _officialEsignature = _i1.createRelationTable(
      relationFieldName: 'officialEsignature',
      field: InspectionPackage.t.officialEsignatureId,
      foreignField: _i4.ElectronicSignature.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ElectronicSignatureTable(tableRelation: foreignTableRelation),
    );
    return _officialEsignature!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    inspectionRecordId,
    generatedById,
    generatedAt,
    scopeDescription,
    includedRecordsCount,
    fileHash,
    storageUrl,
    watermarkText,
    isOfficial,
    officialEsignatureId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'inspectionRecord') {
      return inspectionRecord;
    }
    if (relationField == 'generatedBy') {
      return generatedBy;
    }
    if (relationField == 'officialEsignature') {
      return officialEsignature;
    }
    return null;
  }
}

class InspectionPackageInclude extends _i1.IncludeObject {
  InspectionPackageInclude._({
    _i2.InspectionRecordInclude? inspectionRecord,
    _i3.PharmaUserInclude? generatedBy,
    _i4.ElectronicSignatureInclude? officialEsignature,
  }) {
    _inspectionRecord = inspectionRecord;
    _generatedBy = generatedBy;
    _officialEsignature = officialEsignature;
  }

  _i2.InspectionRecordInclude? _inspectionRecord;

  _i3.PharmaUserInclude? _generatedBy;

  _i4.ElectronicSignatureInclude? _officialEsignature;

  @override
  Map<String, _i1.Include?> get includes => {
    'inspectionRecord': _inspectionRecord,
    'generatedBy': _generatedBy,
    'officialEsignature': _officialEsignature,
  };

  @override
  _i1.Table<int?> get table => InspectionPackage.t;
}

class InspectionPackageIncludeList extends _i1.IncludeList {
  InspectionPackageIncludeList._({
    _i1.WhereExpressionBuilder<InspectionPackageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InspectionPackage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InspectionPackage.t;
}

class InspectionPackageRepository {
  const InspectionPackageRepository._();

  final attachRow = const InspectionPackageAttachRowRepository._();

  final detachRow = const InspectionPackageDetachRowRepository._();

  /// Returns a list of [InspectionPackage]s matching the given query parameters.
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
  Future<List<InspectionPackage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InspectionPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionPackageTable>? orderByList,
    _i1.Transaction? transaction,
    InspectionPackageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InspectionPackage>(
      where: where?.call(InspectionPackage.t),
      orderBy: orderBy?.call(InspectionPackage.t),
      orderByList: orderByList?.call(InspectionPackage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InspectionPackage] matching the given query parameters.
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
  Future<InspectionPackage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InspectionPackageTable>? where,
    int? offset,
    _i1.OrderByBuilder<InspectionPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InspectionPackageTable>? orderByList,
    _i1.Transaction? transaction,
    InspectionPackageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InspectionPackage>(
      where: where?.call(InspectionPackage.t),
      orderBy: orderBy?.call(InspectionPackage.t),
      orderByList: orderByList?.call(InspectionPackage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InspectionPackage] by its [id] or null if no such row exists.
  Future<InspectionPackage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    InspectionPackageInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InspectionPackage>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InspectionPackage]s in the list and returns the inserted rows.
  ///
  /// The returned [InspectionPackage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<InspectionPackage>> insert(
    _i1.DatabaseSession session,
    List<InspectionPackage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<InspectionPackage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [InspectionPackage] and returns the inserted row.
  ///
  /// The returned [InspectionPackage] will have its `id` field set.
  Future<InspectionPackage> insertRow(
    _i1.DatabaseSession session,
    InspectionPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InspectionPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InspectionPackage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InspectionPackage>> update(
    _i1.DatabaseSession session,
    List<InspectionPackage> rows, {
    _i1.ColumnSelections<InspectionPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InspectionPackage>(
      rows,
      columns: columns?.call(InspectionPackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InspectionPackage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InspectionPackage> updateRow(
    _i1.DatabaseSession session,
    InspectionPackage row, {
    _i1.ColumnSelections<InspectionPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InspectionPackage>(
      row,
      columns: columns?.call(InspectionPackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InspectionPackage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InspectionPackage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<InspectionPackageUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<InspectionPackage>(
      id,
      columnValues: columnValues(InspectionPackage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InspectionPackage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<InspectionPackage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<InspectionPackageUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<InspectionPackageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InspectionPackageTable>? orderBy,
    _i1.OrderByListBuilder<InspectionPackageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<InspectionPackage>(
      columnValues: columnValues(InspectionPackage.t.updateTable),
      where: where(InspectionPackage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InspectionPackage.t),
      orderByList: orderByList?.call(InspectionPackage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [InspectionPackage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InspectionPackage>> delete(
    _i1.DatabaseSession session,
    List<InspectionPackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InspectionPackage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InspectionPackage].
  Future<InspectionPackage> deleteRow(
    _i1.DatabaseSession session,
    InspectionPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InspectionPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InspectionPackage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InspectionPackageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InspectionPackage>(
      where: where(InspectionPackage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InspectionPackageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InspectionPackage>(
      where: where?.call(InspectionPackage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InspectionPackage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InspectionPackageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InspectionPackage>(
      where: where(InspectionPackage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class InspectionPackageAttachRowRepository {
  const InspectionPackageAttachRowRepository._();

  /// Creates a relation between the given [InspectionPackage] and [InspectionRecord]
  /// by setting the [InspectionPackage]'s foreign key `inspectionRecordId` to refer to the [InspectionRecord].
  Future<void> inspectionRecord(
    _i1.DatabaseSession session,
    InspectionPackage inspectionPackage,
    _i2.InspectionRecord inspectionRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionPackage.id == null) {
      throw ArgumentError.notNull('inspectionPackage.id');
    }
    if (inspectionRecord.id == null) {
      throw ArgumentError.notNull('inspectionRecord.id');
    }

    var $inspectionPackage = inspectionPackage.copyWith(
      inspectionRecordId: inspectionRecord.id,
    );
    await session.db.updateRow<InspectionPackage>(
      $inspectionPackage,
      columns: [InspectionPackage.t.inspectionRecordId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [InspectionPackage] and [PharmaUser]
  /// by setting the [InspectionPackage]'s foreign key `generatedById` to refer to the [PharmaUser].
  Future<void> generatedBy(
    _i1.DatabaseSession session,
    InspectionPackage inspectionPackage,
    _i3.PharmaUser generatedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionPackage.id == null) {
      throw ArgumentError.notNull('inspectionPackage.id');
    }
    if (generatedBy.id == null) {
      throw ArgumentError.notNull('generatedBy.id');
    }

    var $inspectionPackage = inspectionPackage.copyWith(
      generatedById: generatedBy.id,
    );
    await session.db.updateRow<InspectionPackage>(
      $inspectionPackage,
      columns: [InspectionPackage.t.generatedById],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [InspectionPackage] and [ElectronicSignature]
  /// by setting the [InspectionPackage]'s foreign key `officialEsignatureId` to refer to the [ElectronicSignature].
  Future<void> officialEsignature(
    _i1.DatabaseSession session,
    InspectionPackage inspectionPackage,
    _i4.ElectronicSignature officialEsignature, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionPackage.id == null) {
      throw ArgumentError.notNull('inspectionPackage.id');
    }
    if (officialEsignature.id == null) {
      throw ArgumentError.notNull('officialEsignature.id');
    }

    var $inspectionPackage = inspectionPackage.copyWith(
      officialEsignatureId: officialEsignature.id,
    );
    await session.db.updateRow<InspectionPackage>(
      $inspectionPackage,
      columns: [InspectionPackage.t.officialEsignatureId],
      transaction: transaction,
    );
  }
}

class InspectionPackageDetachRowRepository {
  const InspectionPackageDetachRowRepository._();

  /// Detaches the relation between this [InspectionPackage] and the [ElectronicSignature] set in `officialEsignature`
  /// by setting the [InspectionPackage]'s foreign key `officialEsignatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> officialEsignature(
    _i1.DatabaseSession session,
    InspectionPackage inspectionPackage, {
    _i1.Transaction? transaction,
  }) async {
    if (inspectionPackage.id == null) {
      throw ArgumentError.notNull('inspectionPackage.id');
    }

    var $inspectionPackage = inspectionPackage.copyWith(
      officialEsignatureId: null,
    );
    await session.db.updateRow<InspectionPackage>(
      $inspectionPackage,
      columns: [InspectionPackage.t.officialEsignatureId],
      transaction: transaction,
    );
  }
}
