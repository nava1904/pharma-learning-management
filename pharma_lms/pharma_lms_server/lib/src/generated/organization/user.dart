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
import '../organization/department.dart' as _i2;
import '../organization/job_role.dart' as _i3;
import '../organization/site.dart' as _i4;
import '../organization/organization.dart' as _i5;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i6;

/// Pharma LMS user - links identity to organization hierarchy.
abstract class PharmaUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PharmaUser._({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    this.department,
    required this.jobRoleId,
    this.jobRole,
    required this.siteId,
    this.site,
    required this.organizationId,
    this.organization,
    String? status,
    DateTime? createdAt,
    this.authUserId,
    this.employeeId,
    this.hireDate,
    this.managerId,
    this.preferredLanguage,
    String? timezone,
  }) : status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now(),
       timezone = timezone ?? 'UTC';

  factory PharmaUser({
    int? id,
    required String email,
    required String firstName,
    required String lastName,
    required int departmentId,
    _i2.Department? department,
    required int jobRoleId,
    _i3.JobRole? jobRole,
    required int siteId,
    _i4.Site? site,
    required int organizationId,
    _i5.Organization? organization,
    String? status,
    DateTime? createdAt,
    int? authUserId,
    String? employeeId,
    DateTime? hireDate,
    int? managerId,
    String? preferredLanguage,
    String? timezone,
  }) = _PharmaUserImpl;

  factory PharmaUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return PharmaUser(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      departmentId: jsonSerialization['departmentId'] as int,
      department: jsonSerialization['department'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Department>(
              jsonSerialization['department'],
            ),
      jobRoleId: jsonSerialization['jobRoleId'] as int,
      jobRole: jsonSerialization['jobRole'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.JobRole>(
              jsonSerialization['jobRole'],
            ),
      siteId: jsonSerialization['siteId'] as int,
      site: jsonSerialization['site'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Site>(jsonSerialization['site']),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.Organization>(
              jsonSerialization['organization'],
            ),
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      authUserId: jsonSerialization['authUserId'] as int?,
      employeeId: jsonSerialization['employeeId'] as String?,
      hireDate: jsonSerialization['hireDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['hireDate']),
      managerId: jsonSerialization['managerId'] as int?,
      preferredLanguage: jsonSerialization['preferredLanguage'] as String?,
      timezone: jsonSerialization['timezone'] as String?,
    );
  }

  static final t = PharmaUserTable();

  static const db = PharmaUserRepository._();

  @override
  int? id;

  /// Primary identifier for login and notifications.
  String email;

  /// First name.
  String firstName;

  /// Last name.
  String lastName;

  int departmentId;

  /// The department this user belongs to.
  _i2.Department? department;

  int jobRoleId;

  /// The job role for training matrix.
  _i3.JobRole? jobRole;

  int siteId;

  /// The site this user is assigned to.
  _i4.Site? site;

  int organizationId;

  /// The organization this user belongs to.
  _i5.Organization? organization;

  /// User status (active, inactive, suspended).
  String status;

  /// When the user was created.
  DateTime createdAt;

  /// Optional link to serverpod auth user ID.
  int? authUserId;

  /// HR system employee ID.
  String? employeeId;

  /// Hire date.
  DateTime? hireDate;

  /// Manager user ID.
  int? managerId;

  /// Preferred language code.
  String? preferredLanguage;

  /// User timezone (e.g., America/New_York).
  String? timezone;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PharmaUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PharmaUser copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    int? departmentId,
    _i2.Department? department,
    int? jobRoleId,
    _i3.JobRole? jobRole,
    int? siteId,
    _i4.Site? site,
    int? organizationId,
    _i5.Organization? organization,
    String? status,
    DateTime? createdAt,
    int? authUserId,
    String? employeeId,
    DateTime? hireDate,
    int? managerId,
    String? preferredLanguage,
    String? timezone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PharmaUser',
      if (id != null) 'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJson(),
      'jobRoleId': jobRoleId,
      if (jobRole != null) 'jobRole': jobRole?.toJson(),
      'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
      if (authUserId != null) 'authUserId': authUserId,
      if (employeeId != null) 'employeeId': employeeId,
      if (hireDate != null) 'hireDate': hireDate?.toJson(),
      if (managerId != null) 'managerId': managerId,
      if (preferredLanguage != null) 'preferredLanguage': preferredLanguage,
      if (timezone != null) 'timezone': timezone,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PharmaUser',
      if (id != null) 'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      if (department != null) 'department': department?.toJsonForProtocol(),
      'jobRoleId': jobRoleId,
      if (jobRole != null) 'jobRole': jobRole?.toJsonForProtocol(),
      'siteId': siteId,
      if (site != null) 'site': site?.toJsonForProtocol(),
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'status': status,
      'createdAt': createdAt.toJson(),
      if (authUserId != null) 'authUserId': authUserId,
      if (employeeId != null) 'employeeId': employeeId,
      if (hireDate != null) 'hireDate': hireDate?.toJson(),
      if (managerId != null) 'managerId': managerId,
      if (preferredLanguage != null) 'preferredLanguage': preferredLanguage,
      if (timezone != null) 'timezone': timezone,
    };
  }

  static PharmaUserInclude include({
    _i2.DepartmentInclude? department,
    _i3.JobRoleInclude? jobRole,
    _i4.SiteInclude? site,
    _i5.OrganizationInclude? organization,
  }) {
    return PharmaUserInclude._(
      department: department,
      jobRole: jobRole,
      site: site,
      organization: organization,
    );
  }

  static PharmaUserIncludeList includeList({
    _i1.WhereExpressionBuilder<PharmaUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PharmaUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PharmaUserTable>? orderByList,
    PharmaUserInclude? include,
  }) {
    return PharmaUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PharmaUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PharmaUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PharmaUserImpl extends PharmaUser {
  _PharmaUserImpl({
    int? id,
    required String email,
    required String firstName,
    required String lastName,
    required int departmentId,
    _i2.Department? department,
    required int jobRoleId,
    _i3.JobRole? jobRole,
    required int siteId,
    _i4.Site? site,
    required int organizationId,
    _i5.Organization? organization,
    String? status,
    DateTime? createdAt,
    int? authUserId,
    String? employeeId,
    DateTime? hireDate,
    int? managerId,
    String? preferredLanguage,
    String? timezone,
  }) : super._(
         id: id,
         email: email,
         firstName: firstName,
         lastName: lastName,
         departmentId: departmentId,
         department: department,
         jobRoleId: jobRoleId,
         jobRole: jobRole,
         siteId: siteId,
         site: site,
         organizationId: organizationId,
         organization: organization,
         status: status,
         createdAt: createdAt,
         authUserId: authUserId,
         employeeId: employeeId,
         hireDate: hireDate,
         managerId: managerId,
         preferredLanguage: preferredLanguage,
         timezone: timezone,
       );

  /// Returns a shallow copy of this [PharmaUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PharmaUser copyWith({
    Object? id = _Undefined,
    String? email,
    String? firstName,
    String? lastName,
    int? departmentId,
    Object? department = _Undefined,
    int? jobRoleId,
    Object? jobRole = _Undefined,
    int? siteId,
    Object? site = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? authUserId = _Undefined,
    Object? employeeId = _Undefined,
    Object? hireDate = _Undefined,
    Object? managerId = _Undefined,
    Object? preferredLanguage = _Undefined,
    Object? timezone = _Undefined,
  }) {
    return PharmaUser(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      departmentId: departmentId ?? this.departmentId,
      department: department is _i2.Department?
          ? department
          : this.department?.copyWith(),
      jobRoleId: jobRoleId ?? this.jobRoleId,
      jobRole: jobRole is _i3.JobRole? ? jobRole : this.jobRole?.copyWith(),
      siteId: siteId ?? this.siteId,
      site: site is _i4.Site? ? site : this.site?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i5.Organization?
          ? organization
          : this.organization?.copyWith(),
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      authUserId: authUserId is int? ? authUserId : this.authUserId,
      employeeId: employeeId is String? ? employeeId : this.employeeId,
      hireDate: hireDate is DateTime? ? hireDate : this.hireDate,
      managerId: managerId is int? ? managerId : this.managerId,
      preferredLanguage: preferredLanguage is String?
          ? preferredLanguage
          : this.preferredLanguage,
      timezone: timezone is String? ? timezone : this.timezone,
    );
  }
}

class PharmaUserUpdateTable extends _i1.UpdateTable<PharmaUserTable> {
  PharmaUserUpdateTable(super.table);

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> firstName(String value) => _i1.ColumnValue(
    table.firstName,
    value,
  );

  _i1.ColumnValue<String, String> lastName(String value) => _i1.ColumnValue(
    table.lastName,
    value,
  );

  _i1.ColumnValue<int, int> departmentId(int value) => _i1.ColumnValue(
    table.departmentId,
    value,
  );

  _i1.ColumnValue<int, int> jobRoleId(int value) => _i1.ColumnValue(
    table.jobRoleId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<int, int> authUserId(int? value) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> employeeId(String? value) => _i1.ColumnValue(
    table.employeeId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> hireDate(DateTime? value) =>
      _i1.ColumnValue(
        table.hireDate,
        value,
      );

  _i1.ColumnValue<int, int> managerId(int? value) => _i1.ColumnValue(
    table.managerId,
    value,
  );

  _i1.ColumnValue<String, String> preferredLanguage(String? value) =>
      _i1.ColumnValue(
        table.preferredLanguage,
        value,
      );

  _i1.ColumnValue<String, String> timezone(String? value) => _i1.ColumnValue(
    table.timezone,
    value,
  );
}

class PharmaUserTable extends _i1.Table<int?> {
  PharmaUserTable({super.tableRelation}) : super(tableName: 'pharma_user') {
    updateTable = PharmaUserUpdateTable(this);
    email = _i1.ColumnString(
      'email',
      this,
    );
    firstName = _i1.ColumnString(
      'firstName',
      this,
    );
    lastName = _i1.ColumnString(
      'lastName',
      this,
    );
    departmentId = _i1.ColumnInt(
      'departmentId',
      this,
    );
    jobRoleId = _i1.ColumnInt(
      'jobRoleId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    authUserId = _i1.ColumnInt(
      'authUserId',
      this,
    );
    employeeId = _i1.ColumnString(
      'employeeId',
      this,
    );
    hireDate = _i1.ColumnDateTime(
      'hireDate',
      this,
    );
    managerId = _i1.ColumnInt(
      'managerId',
      this,
    );
    preferredLanguage = _i1.ColumnString(
      'preferredLanguage',
      this,
    );
    timezone = _i1.ColumnString(
      'timezone',
      this,
      hasDefault: true,
    );
  }

  late final PharmaUserUpdateTable updateTable;

  /// Primary identifier for login and notifications.
  late final _i1.ColumnString email;

  /// First name.
  late final _i1.ColumnString firstName;

  /// Last name.
  late final _i1.ColumnString lastName;

  late final _i1.ColumnInt departmentId;

  /// The department this user belongs to.
  _i2.DepartmentTable? _department;

  late final _i1.ColumnInt jobRoleId;

  /// The job role for training matrix.
  _i3.JobRoleTable? _jobRole;

  late final _i1.ColumnInt siteId;

  /// The site this user is assigned to.
  _i4.SiteTable? _site;

  late final _i1.ColumnInt organizationId;

  /// The organization this user belongs to.
  _i5.OrganizationTable? _organization;

  /// User status (active, inactive, suspended).
  late final _i1.ColumnString status;

  /// When the user was created.
  late final _i1.ColumnDateTime createdAt;

  /// Optional link to serverpod auth user ID.
  late final _i1.ColumnInt authUserId;

  /// HR system employee ID.
  late final _i1.ColumnString employeeId;

  /// Hire date.
  late final _i1.ColumnDateTime hireDate;

  /// Manager user ID.
  late final _i1.ColumnInt managerId;

  /// Preferred language code.
  late final _i1.ColumnString preferredLanguage;

  /// User timezone (e.g., America/New_York).
  late final _i1.ColumnString timezone;

  _i2.DepartmentTable get department {
    if (_department != null) return _department!;
    _department = _i1.createRelationTable(
      relationFieldName: 'department',
      field: PharmaUser.t.departmentId,
      foreignField: _i2.Department.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DepartmentTable(tableRelation: foreignTableRelation),
    );
    return _department!;
  }

  _i3.JobRoleTable get jobRole {
    if (_jobRole != null) return _jobRole!;
    _jobRole = _i1.createRelationTable(
      relationFieldName: 'jobRole',
      field: PharmaUser.t.jobRoleId,
      foreignField: _i3.JobRole.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.JobRoleTable(tableRelation: foreignTableRelation),
    );
    return _jobRole!;
  }

  _i4.SiteTable get site {
    if (_site != null) return _site!;
    _site = _i1.createRelationTable(
      relationFieldName: 'site',
      field: PharmaUser.t.siteId,
      foreignField: _i4.Site.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SiteTable(tableRelation: foreignTableRelation),
    );
    return _site!;
  }

  _i5.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: PharmaUser.t.organizationId,
      foreignField: _i5.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    email,
    firstName,
    lastName,
    departmentId,
    jobRoleId,
    siteId,
    organizationId,
    status,
    createdAt,
    authUserId,
    employeeId,
    hireDate,
    managerId,
    preferredLanguage,
    timezone,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'department') {
      return department;
    }
    if (relationField == 'jobRole') {
      return jobRole;
    }
    if (relationField == 'site') {
      return site;
    }
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class PharmaUserInclude extends _i1.IncludeObject {
  PharmaUserInclude._({
    _i2.DepartmentInclude? department,
    _i3.JobRoleInclude? jobRole,
    _i4.SiteInclude? site,
    _i5.OrganizationInclude? organization,
  }) {
    _department = department;
    _jobRole = jobRole;
    _site = site;
    _organization = organization;
  }

  _i2.DepartmentInclude? _department;

  _i3.JobRoleInclude? _jobRole;

  _i4.SiteInclude? _site;

  _i5.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {
    'department': _department,
    'jobRole': _jobRole,
    'site': _site,
    'organization': _organization,
  };

  @override
  _i1.Table<int?> get table => PharmaUser.t;
}

class PharmaUserIncludeList extends _i1.IncludeList {
  PharmaUserIncludeList._({
    _i1.WhereExpressionBuilder<PharmaUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PharmaUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PharmaUser.t;
}

class PharmaUserRepository {
  const PharmaUserRepository._();

  final attachRow = const PharmaUserAttachRowRepository._();

  /// Returns a list of [PharmaUser]s matching the given query parameters.
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
  Future<List<PharmaUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PharmaUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PharmaUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PharmaUserTable>? orderByList,
    _i1.Transaction? transaction,
    PharmaUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PharmaUser>(
      where: where?.call(PharmaUser.t),
      orderBy: orderBy?.call(PharmaUser.t),
      orderByList: orderByList?.call(PharmaUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PharmaUser] matching the given query parameters.
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
  Future<PharmaUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PharmaUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<PharmaUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PharmaUserTable>? orderByList,
    _i1.Transaction? transaction,
    PharmaUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PharmaUser>(
      where: where?.call(PharmaUser.t),
      orderBy: orderBy?.call(PharmaUser.t),
      orderByList: orderByList?.call(PharmaUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PharmaUser] by its [id] or null if no such row exists.
  Future<PharmaUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PharmaUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PharmaUser>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PharmaUser]s in the list and returns the inserted rows.
  ///
  /// The returned [PharmaUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PharmaUser>> insert(
    _i1.Session session,
    List<PharmaUser> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PharmaUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PharmaUser] and returns the inserted row.
  ///
  /// The returned [PharmaUser] will have its `id` field set.
  Future<PharmaUser> insertRow(
    _i1.Session session,
    PharmaUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PharmaUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PharmaUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PharmaUser>> update(
    _i1.Session session,
    List<PharmaUser> rows, {
    _i1.ColumnSelections<PharmaUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PharmaUser>(
      rows,
      columns: columns?.call(PharmaUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PharmaUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PharmaUser> updateRow(
    _i1.Session session,
    PharmaUser row, {
    _i1.ColumnSelections<PharmaUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PharmaUser>(
      row,
      columns: columns?.call(PharmaUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PharmaUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PharmaUser?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PharmaUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PharmaUser>(
      id,
      columnValues: columnValues(PharmaUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PharmaUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PharmaUser>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PharmaUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PharmaUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PharmaUserTable>? orderBy,
    _i1.OrderByListBuilder<PharmaUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PharmaUser>(
      columnValues: columnValues(PharmaUser.t.updateTable),
      where: where(PharmaUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PharmaUser.t),
      orderByList: orderByList?.call(PharmaUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PharmaUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PharmaUser>> delete(
    _i1.Session session,
    List<PharmaUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PharmaUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PharmaUser].
  Future<PharmaUser> deleteRow(
    _i1.Session session,
    PharmaUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PharmaUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PharmaUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PharmaUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PharmaUser>(
      where: where(PharmaUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PharmaUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PharmaUser>(
      where: where?.call(PharmaUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PharmaUser] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PharmaUserTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PharmaUser>(
      where: where(PharmaUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PharmaUserAttachRowRepository {
  const PharmaUserAttachRowRepository._();

  /// Creates a relation between the given [PharmaUser] and [Department]
  /// by setting the [PharmaUser]'s foreign key `departmentId` to refer to the [Department].
  Future<void> department(
    _i1.Session session,
    PharmaUser pharmaUser,
    _i2.Department department, {
    _i1.Transaction? transaction,
  }) async {
    if (pharmaUser.id == null) {
      throw ArgumentError.notNull('pharmaUser.id');
    }
    if (department.id == null) {
      throw ArgumentError.notNull('department.id');
    }

    var $pharmaUser = pharmaUser.copyWith(departmentId: department.id);
    await session.db.updateRow<PharmaUser>(
      $pharmaUser,
      columns: [PharmaUser.t.departmentId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PharmaUser] and [JobRole]
  /// by setting the [PharmaUser]'s foreign key `jobRoleId` to refer to the [JobRole].
  Future<void> jobRole(
    _i1.Session session,
    PharmaUser pharmaUser,
    _i3.JobRole jobRole, {
    _i1.Transaction? transaction,
  }) async {
    if (pharmaUser.id == null) {
      throw ArgumentError.notNull('pharmaUser.id');
    }
    if (jobRole.id == null) {
      throw ArgumentError.notNull('jobRole.id');
    }

    var $pharmaUser = pharmaUser.copyWith(jobRoleId: jobRole.id);
    await session.db.updateRow<PharmaUser>(
      $pharmaUser,
      columns: [PharmaUser.t.jobRoleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PharmaUser] and [Site]
  /// by setting the [PharmaUser]'s foreign key `siteId` to refer to the [Site].
  Future<void> site(
    _i1.Session session,
    PharmaUser pharmaUser,
    _i4.Site site, {
    _i1.Transaction? transaction,
  }) async {
    if (pharmaUser.id == null) {
      throw ArgumentError.notNull('pharmaUser.id');
    }
    if (site.id == null) {
      throw ArgumentError.notNull('site.id');
    }

    var $pharmaUser = pharmaUser.copyWith(siteId: site.id);
    await session.db.updateRow<PharmaUser>(
      $pharmaUser,
      columns: [PharmaUser.t.siteId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PharmaUser] and [Organization]
  /// by setting the [PharmaUser]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.Session session,
    PharmaUser pharmaUser,
    _i5.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (pharmaUser.id == null) {
      throw ArgumentError.notNull('pharmaUser.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $pharmaUser = pharmaUser.copyWith(organizationId: organization.id);
    await session.db.updateRow<PharmaUser>(
      $pharmaUser,
      columns: [PharmaUser.t.organizationId],
      transaction: transaction,
    );
  }
}
