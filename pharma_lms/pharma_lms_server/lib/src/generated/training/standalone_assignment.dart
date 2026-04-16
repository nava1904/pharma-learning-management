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
import '../organization/organization.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../assessment/question_bank.dart' as _i4;
import '../course/course_version.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Trainer-authored assignment (open-ended / MCQ) not tied to a course lesson.
abstract class StandaloneAssignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StandaloneAssignment._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.createdById,
    this.createdBy,
    required this.title,
    this.instructions,
    required this.dueAt,
    String? contentKind,
    this.questionBankId,
    this.questionBank,
    this.courseVersionId,
    this.courseVersion,
    String? targetType,
    this.targetDepartmentId,
    this.targetBatchId,
    String? status,
    this.publishedAt,
    DateTime? createdAt,
    this.assignedByType,
  }) : contentKind = contentKind ?? 'open_ended',
       targetType = targetType ?? 'individual',
       status = status ?? 'draft',
       createdAt = createdAt ?? DateTime.now();

  factory StandaloneAssignment({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int createdById,
    _i3.PharmaUser? createdBy,
    required String title,
    String? instructions,
    required DateTime dueAt,
    String? contentKind,
    int? questionBankId,
    _i4.QuestionBank? questionBank,
    int? courseVersionId,
    _i5.CourseVersion? courseVersion,
    String? targetType,
    int? targetDepartmentId,
    int? targetBatchId,
    String? status,
    DateTime? publishedAt,
    DateTime? createdAt,
    String? assignedByType,
  }) = _StandaloneAssignmentImpl;

  factory StandaloneAssignment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StandaloneAssignment(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      createdById: jsonSerialization['createdById'] as int,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      title: jsonSerialization['title'] as String,
      instructions: jsonSerialization['instructions'] as String?,
      dueAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      contentKind: jsonSerialization['contentKind'] as String?,
      questionBankId: jsonSerialization['questionBankId'] as int?,
      questionBank: jsonSerialization['questionBank'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.QuestionBank>(
              jsonSerialization['questionBank'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int?,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      targetType: jsonSerialization['targetType'] as String?,
      targetDepartmentId: jsonSerialization['targetDepartmentId'] as int?,
      targetBatchId: jsonSerialization['targetBatchId'] as int?,
      status: jsonSerialization['status'] as String?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      assignedByType: jsonSerialization['assignedByType'] as String?,
    );
  }

  static final t = StandaloneAssignmentTable();

  static const db = StandaloneAssignmentRepository._();

  @override
  int? id;

  int organizationId;

  _i2.Organization? organization;

  int createdById;

  _i3.PharmaUser? createdBy;

  String title;

  String? instructions;

  DateTime dueAt;

  /// open_ended | mcq | mixed
  String contentKind;

  int? questionBankId;

  _i4.QuestionBank? questionBank;

  int? courseVersionId;

  _i5.CourseVersion? courseVersion;

  /// individual | department | batch
  String targetType;

  int? targetDepartmentId;

  int? targetBatchId;

  /// draft | published | closed
  String status;

  DateTime? publishedAt;

  DateTime createdAt;

  /// Source of assignment: trainer, batch, admin
  String? assignedByType;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StandaloneAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StandaloneAssignment copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? createdById,
    _i3.PharmaUser? createdBy,
    String? title,
    String? instructions,
    DateTime? dueAt,
    String? contentKind,
    int? questionBankId,
    _i4.QuestionBank? questionBank,
    int? courseVersionId,
    _i5.CourseVersion? courseVersion,
    String? targetType,
    int? targetDepartmentId,
    int? targetBatchId,
    String? status,
    DateTime? publishedAt,
    DateTime? createdAt,
    String? assignedByType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StandaloneAssignment',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'title': title,
      if (instructions != null) 'instructions': instructions,
      'dueAt': dueAt.toJson(),
      'contentKind': contentKind,
      if (questionBankId != null) 'questionBankId': questionBankId,
      if (questionBank != null) 'questionBank': questionBank?.toJson(),
      if (courseVersionId != null) 'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'targetType': targetType,
      if (targetDepartmentId != null) 'targetDepartmentId': targetDepartmentId,
      if (targetBatchId != null) 'targetBatchId': targetBatchId,
      'status': status,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (assignedByType != null) 'assignedByType': assignedByType,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StandaloneAssignment',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJsonForProtocol(),
      'title': title,
      if (instructions != null) 'instructions': instructions,
      'dueAt': dueAt.toJson(),
      'contentKind': contentKind,
      if (questionBankId != null) 'questionBankId': questionBankId,
      if (questionBank != null)
        'questionBank': questionBank?.toJsonForProtocol(),
      if (courseVersionId != null) 'courseVersionId': courseVersionId,
      if (courseVersion != null)
        'courseVersion': courseVersion?.toJsonForProtocol(),
      'targetType': targetType,
      if (targetDepartmentId != null) 'targetDepartmentId': targetDepartmentId,
      if (targetBatchId != null) 'targetBatchId': targetBatchId,
      'status': status,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (assignedByType != null) 'assignedByType': assignedByType,
    };
  }

  static StandaloneAssignmentInclude include({
    _i2.OrganizationInclude? organization,
    _i3.PharmaUserInclude? createdBy,
    _i4.QuestionBankInclude? questionBank,
    _i5.CourseVersionInclude? courseVersion,
  }) {
    return StandaloneAssignmentInclude._(
      organization: organization,
      createdBy: createdBy,
      questionBank: questionBank,
      courseVersion: courseVersion,
    );
  }

  static StandaloneAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<StandaloneAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandaloneAssignmentTable>? orderByList,
    StandaloneAssignmentInclude? include,
  }) {
    return StandaloneAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StandaloneAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StandaloneAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StandaloneAssignmentImpl extends StandaloneAssignment {
  _StandaloneAssignmentImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int createdById,
    _i3.PharmaUser? createdBy,
    required String title,
    String? instructions,
    required DateTime dueAt,
    String? contentKind,
    int? questionBankId,
    _i4.QuestionBank? questionBank,
    int? courseVersionId,
    _i5.CourseVersion? courseVersion,
    String? targetType,
    int? targetDepartmentId,
    int? targetBatchId,
    String? status,
    DateTime? publishedAt,
    DateTime? createdAt,
    String? assignedByType,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         createdById: createdById,
         createdBy: createdBy,
         title: title,
         instructions: instructions,
         dueAt: dueAt,
         contentKind: contentKind,
         questionBankId: questionBankId,
         questionBank: questionBank,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         targetType: targetType,
         targetDepartmentId: targetDepartmentId,
         targetBatchId: targetBatchId,
         status: status,
         publishedAt: publishedAt,
         createdAt: createdAt,
         assignedByType: assignedByType,
       );

  /// Returns a shallow copy of this [StandaloneAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StandaloneAssignment copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    int? createdById,
    Object? createdBy = _Undefined,
    String? title,
    Object? instructions = _Undefined,
    DateTime? dueAt,
    String? contentKind,
    Object? questionBankId = _Undefined,
    Object? questionBank = _Undefined,
    Object? courseVersionId = _Undefined,
    Object? courseVersion = _Undefined,
    String? targetType,
    Object? targetDepartmentId = _Undefined,
    Object? targetBatchId = _Undefined,
    String? status,
    Object? publishedAt = _Undefined,
    DateTime? createdAt,
    Object? assignedByType = _Undefined,
  }) {
    return StandaloneAssignment(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      createdById: createdById ?? this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      title: title ?? this.title,
      instructions: instructions is String? ? instructions : this.instructions,
      dueAt: dueAt ?? this.dueAt,
      contentKind: contentKind ?? this.contentKind,
      questionBankId: questionBankId is int?
          ? questionBankId
          : this.questionBankId,
      questionBank: questionBank is _i4.QuestionBank?
          ? questionBank
          : this.questionBank?.copyWith(),
      courseVersionId: courseVersionId is int?
          ? courseVersionId
          : this.courseVersionId,
      courseVersion: courseVersion is _i5.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      targetType: targetType ?? this.targetType,
      targetDepartmentId: targetDepartmentId is int?
          ? targetDepartmentId
          : this.targetDepartmentId,
      targetBatchId: targetBatchId is int? ? targetBatchId : this.targetBatchId,
      status: status ?? this.status,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      assignedByType: assignedByType is String?
          ? assignedByType
          : this.assignedByType,
    );
  }
}

class StandaloneAssignmentUpdateTable
    extends _i1.UpdateTable<StandaloneAssignmentTable> {
  StandaloneAssignmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<int, int> createdById(int value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> instructions(String? value) =>
      _i1.ColumnValue(
        table.instructions,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> dueAt(DateTime value) => _i1.ColumnValue(
    table.dueAt,
    value,
  );

  _i1.ColumnValue<String, String> contentKind(String value) => _i1.ColumnValue(
    table.contentKind,
    value,
  );

  _i1.ColumnValue<int, int> questionBankId(int? value) => _i1.ColumnValue(
    table.questionBankId,
    value,
  );

  _i1.ColumnValue<int, int> courseVersionId(int? value) => _i1.ColumnValue(
    table.courseVersionId,
    value,
  );

  _i1.ColumnValue<String, String> targetType(String value) => _i1.ColumnValue(
    table.targetType,
    value,
  );

  _i1.ColumnValue<int, int> targetDepartmentId(int? value) => _i1.ColumnValue(
    table.targetDepartmentId,
    value,
  );

  _i1.ColumnValue<int, int> targetBatchId(int? value) => _i1.ColumnValue(
    table.targetBatchId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.publishedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> assignedByType(String? value) =>
      _i1.ColumnValue(
        table.assignedByType,
        value,
      );
}

class StandaloneAssignmentTable extends _i1.Table<int?> {
  StandaloneAssignmentTable({super.tableRelation})
    : super(tableName: 'standalone_assignment') {
    updateTable = StandaloneAssignmentUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    instructions = _i1.ColumnString(
      'instructions',
      this,
    );
    dueAt = _i1.ColumnDateTime(
      'dueAt',
      this,
    );
    contentKind = _i1.ColumnString(
      'contentKind',
      this,
      hasDefault: true,
    );
    questionBankId = _i1.ColumnInt(
      'questionBankId',
      this,
    );
    courseVersionId = _i1.ColumnInt(
      'courseVersionId',
      this,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
      hasDefault: true,
    );
    targetDepartmentId = _i1.ColumnInt(
      'targetDepartmentId',
      this,
    );
    targetBatchId = _i1.ColumnInt(
      'targetBatchId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    assignedByType = _i1.ColumnString(
      'assignedByType',
      this,
    );
  }

  late final StandaloneAssignmentUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnInt createdById;

  _i3.PharmaUserTable? _createdBy;

  late final _i1.ColumnString title;

  late final _i1.ColumnString instructions;

  late final _i1.ColumnDateTime dueAt;

  /// open_ended | mcq | mixed
  late final _i1.ColumnString contentKind;

  late final _i1.ColumnInt questionBankId;

  _i4.QuestionBankTable? _questionBank;

  late final _i1.ColumnInt courseVersionId;

  _i5.CourseVersionTable? _courseVersion;

  /// individual | department | batch
  late final _i1.ColumnString targetType;

  late final _i1.ColumnInt targetDepartmentId;

  late final _i1.ColumnInt targetBatchId;

  /// draft | published | closed
  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime publishedAt;

  late final _i1.ColumnDateTime createdAt;

  /// Source of assignment: trainer, batch, admin
  late final _i1.ColumnString assignedByType;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: StandaloneAssignment.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.PharmaUserTable get createdBy {
    if (_createdBy != null) return _createdBy!;
    _createdBy = _i1.createRelationTable(
      relationFieldName: 'createdBy',
      field: StandaloneAssignment.t.createdById,
      foreignField: _i3.PharmaUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PharmaUserTable(tableRelation: foreignTableRelation),
    );
    return _createdBy!;
  }

  _i4.QuestionBankTable get questionBank {
    if (_questionBank != null) return _questionBank!;
    _questionBank = _i1.createRelationTable(
      relationFieldName: 'questionBank',
      field: StandaloneAssignment.t.questionBankId,
      foreignField: _i4.QuestionBank.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.QuestionBankTable(tableRelation: foreignTableRelation),
    );
    return _questionBank!;
  }

  _i5.CourseVersionTable get courseVersion {
    if (_courseVersion != null) return _courseVersion!;
    _courseVersion = _i1.createRelationTable(
      relationFieldName: 'courseVersion',
      field: StandaloneAssignment.t.courseVersionId,
      foreignField: _i5.CourseVersion.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.CourseVersionTable(tableRelation: foreignTableRelation),
    );
    return _courseVersion!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    createdById,
    title,
    instructions,
    dueAt,
    contentKind,
    questionBankId,
    courseVersionId,
    targetType,
    targetDepartmentId,
    targetBatchId,
    status,
    publishedAt,
    createdAt,
    assignedByType,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'createdBy') {
      return createdBy;
    }
    if (relationField == 'questionBank') {
      return questionBank;
    }
    if (relationField == 'courseVersion') {
      return courseVersion;
    }
    return null;
  }
}

class StandaloneAssignmentInclude extends _i1.IncludeObject {
  StandaloneAssignmentInclude._({
    _i2.OrganizationInclude? organization,
    _i3.PharmaUserInclude? createdBy,
    _i4.QuestionBankInclude? questionBank,
    _i5.CourseVersionInclude? courseVersion,
  }) {
    _organization = organization;
    _createdBy = createdBy;
    _questionBank = questionBank;
    _courseVersion = courseVersion;
  }

  _i2.OrganizationInclude? _organization;

  _i3.PharmaUserInclude? _createdBy;

  _i4.QuestionBankInclude? _questionBank;

  _i5.CourseVersionInclude? _courseVersion;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'createdBy': _createdBy,
    'questionBank': _questionBank,
    'courseVersion': _courseVersion,
  };

  @override
  _i1.Table<int?> get table => StandaloneAssignment.t;
}

class StandaloneAssignmentIncludeList extends _i1.IncludeList {
  StandaloneAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<StandaloneAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StandaloneAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StandaloneAssignment.t;
}

class StandaloneAssignmentRepository {
  const StandaloneAssignmentRepository._();

  final attachRow = const StandaloneAssignmentAttachRowRepository._();

  final detachRow = const StandaloneAssignmentDetachRowRepository._();

  /// Returns a list of [StandaloneAssignment]s matching the given query parameters.
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
  Future<List<StandaloneAssignment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandaloneAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandaloneAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    StandaloneAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StandaloneAssignment>(
      where: where?.call(StandaloneAssignment.t),
      orderBy: orderBy?.call(StandaloneAssignment.t),
      orderByList: orderByList?.call(StandaloneAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StandaloneAssignment] matching the given query parameters.
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
  Future<StandaloneAssignment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandaloneAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandaloneAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    StandaloneAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StandaloneAssignment>(
      where: where?.call(StandaloneAssignment.t),
      orderBy: orderBy?.call(StandaloneAssignment.t),
      orderByList: orderByList?.call(StandaloneAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StandaloneAssignment] by its [id] or null if no such row exists.
  Future<StandaloneAssignment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    StandaloneAssignmentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StandaloneAssignment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StandaloneAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [StandaloneAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StandaloneAssignment>> insert(
    _i1.DatabaseSession session,
    List<StandaloneAssignment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StandaloneAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StandaloneAssignment] and returns the inserted row.
  ///
  /// The returned [StandaloneAssignment] will have its `id` field set.
  Future<StandaloneAssignment> insertRow(
    _i1.DatabaseSession session,
    StandaloneAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StandaloneAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StandaloneAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StandaloneAssignment>> update(
    _i1.DatabaseSession session,
    List<StandaloneAssignment> rows, {
    _i1.ColumnSelections<StandaloneAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StandaloneAssignment>(
      rows,
      columns: columns?.call(StandaloneAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StandaloneAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StandaloneAssignment> updateRow(
    _i1.DatabaseSession session,
    StandaloneAssignment row, {
    _i1.ColumnSelections<StandaloneAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StandaloneAssignment>(
      row,
      columns: columns?.call(StandaloneAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StandaloneAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StandaloneAssignment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StandaloneAssignmentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StandaloneAssignment>(
      id,
      columnValues: columnValues(StandaloneAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StandaloneAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StandaloneAssignment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StandaloneAssignmentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<StandaloneAssignmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandaloneAssignmentTable>? orderBy,
    _i1.OrderByListBuilder<StandaloneAssignmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StandaloneAssignment>(
      columnValues: columnValues(StandaloneAssignment.t.updateTable),
      where: where(StandaloneAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StandaloneAssignment.t),
      orderByList: orderByList?.call(StandaloneAssignment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StandaloneAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StandaloneAssignment>> delete(
    _i1.DatabaseSession session,
    List<StandaloneAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StandaloneAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StandaloneAssignment].
  Future<StandaloneAssignment> deleteRow(
    _i1.DatabaseSession session,
    StandaloneAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StandaloneAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StandaloneAssignment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StandaloneAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StandaloneAssignment>(
      where: where(StandaloneAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandaloneAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StandaloneAssignment>(
      where: where?.call(StandaloneAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StandaloneAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StandaloneAssignmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StandaloneAssignment>(
      where: where(StandaloneAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class StandaloneAssignmentAttachRowRepository {
  const StandaloneAssignmentAttachRowRepository._();

  /// Creates a relation between the given [StandaloneAssignment] and [Organization]
  /// by setting the [StandaloneAssignment]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    StandaloneAssignment standaloneAssignment,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignment.id == null) {
      throw ArgumentError.notNull('standaloneAssignment.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $standaloneAssignment = standaloneAssignment.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<StandaloneAssignment>(
      $standaloneAssignment,
      columns: [StandaloneAssignment.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StandaloneAssignment] and [PharmaUser]
  /// by setting the [StandaloneAssignment]'s foreign key `createdById` to refer to the [PharmaUser].
  Future<void> createdBy(
    _i1.DatabaseSession session,
    StandaloneAssignment standaloneAssignment,
    _i3.PharmaUser createdBy, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignment.id == null) {
      throw ArgumentError.notNull('standaloneAssignment.id');
    }
    if (createdBy.id == null) {
      throw ArgumentError.notNull('createdBy.id');
    }

    var $standaloneAssignment = standaloneAssignment.copyWith(
      createdById: createdBy.id,
    );
    await session.db.updateRow<StandaloneAssignment>(
      $standaloneAssignment,
      columns: [StandaloneAssignment.t.createdById],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StandaloneAssignment] and [QuestionBank]
  /// by setting the [StandaloneAssignment]'s foreign key `questionBankId` to refer to the [QuestionBank].
  Future<void> questionBank(
    _i1.DatabaseSession session,
    StandaloneAssignment standaloneAssignment,
    _i4.QuestionBank questionBank, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignment.id == null) {
      throw ArgumentError.notNull('standaloneAssignment.id');
    }
    if (questionBank.id == null) {
      throw ArgumentError.notNull('questionBank.id');
    }

    var $standaloneAssignment = standaloneAssignment.copyWith(
      questionBankId: questionBank.id,
    );
    await session.db.updateRow<StandaloneAssignment>(
      $standaloneAssignment,
      columns: [StandaloneAssignment.t.questionBankId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StandaloneAssignment] and [CourseVersion]
  /// by setting the [StandaloneAssignment]'s foreign key `courseVersionId` to refer to the [CourseVersion].
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    StandaloneAssignment standaloneAssignment,
    _i5.CourseVersion courseVersion, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignment.id == null) {
      throw ArgumentError.notNull('standaloneAssignment.id');
    }
    if (courseVersion.id == null) {
      throw ArgumentError.notNull('courseVersion.id');
    }

    var $standaloneAssignment = standaloneAssignment.copyWith(
      courseVersionId: courseVersion.id,
    );
    await session.db.updateRow<StandaloneAssignment>(
      $standaloneAssignment,
      columns: [StandaloneAssignment.t.courseVersionId],
      transaction: transaction,
    );
  }
}

class StandaloneAssignmentDetachRowRepository {
  const StandaloneAssignmentDetachRowRepository._();

  /// Detaches the relation between this [StandaloneAssignment] and the [QuestionBank] set in `questionBank`
  /// by setting the [StandaloneAssignment]'s foreign key `questionBankId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> questionBank(
    _i1.DatabaseSession session,
    StandaloneAssignment standaloneAssignment, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignment.id == null) {
      throw ArgumentError.notNull('standaloneAssignment.id');
    }

    var $standaloneAssignment = standaloneAssignment.copyWith(
      questionBankId: null,
    );
    await session.db.updateRow<StandaloneAssignment>(
      $standaloneAssignment,
      columns: [StandaloneAssignment.t.questionBankId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [StandaloneAssignment] and the [CourseVersion] set in `courseVersion`
  /// by setting the [StandaloneAssignment]'s foreign key `courseVersionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> courseVersion(
    _i1.DatabaseSession session,
    StandaloneAssignment standaloneAssignment, {
    _i1.Transaction? transaction,
  }) async {
    if (standaloneAssignment.id == null) {
      throw ArgumentError.notNull('standaloneAssignment.id');
    }

    var $standaloneAssignment = standaloneAssignment.copyWith(
      courseVersionId: null,
    );
    await session.db.updateRow<StandaloneAssignment>(
      $standaloneAssignment,
      columns: [StandaloneAssignment.t.courseVersionId],
      transaction: transaction,
    );
  }
}
