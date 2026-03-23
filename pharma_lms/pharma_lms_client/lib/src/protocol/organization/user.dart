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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../organization/department.dart' as _i2;
import '../organization/job_role.dart' as _i3;
import '../organization/site.dart' as _i4;
import '../organization/organization.dart' as _i5;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i6;

/// Pharma LMS user - links identity to organization hierarchy.
abstract class PharmaUser implements _i1.SerializableModel {
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
    this.lastLogin,
    this.authType,
    bool? mfaEnabled,
    double? compliancePercent,
    this.roles,
  }) : status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now(),
       timezone = timezone ?? 'UTC',
       mfaEnabled = mfaEnabled ?? false,
       compliancePercent = compliancePercent ?? 0.0;

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
    DateTime? lastLogin,
    String? authType,
    bool? mfaEnabled,
    double? compliancePercent,
    List<String>? roles,
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
      lastLogin: jsonSerialization['lastLogin'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastLogin']),
      authType: jsonSerialization['authType'] as String?,
      mfaEnabled: jsonSerialization['mfaEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['mfaEnabled']),
      compliancePercent: (jsonSerialization['compliancePercent'] as num?)
          ?.toDouble(),
      roles: jsonSerialization['roles'] == null
          ? null
          : _i6.Protocol().deserialize<List<String>>(
              jsonSerialization['roles'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Last login timestamp.
  DateTime? lastLogin;

  /// Authentication type (e.g., SSO, Local).
  String? authType;

  /// Whether MFA is enabled for this user.
  bool? mfaEnabled;

  /// Compliance percent (0-100).
  double? compliancePercent;

  /// List of roles assigned to the user.
  List<String>? roles;

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
    DateTime? lastLogin,
    String? authType,
    bool? mfaEnabled,
    double? compliancePercent,
    List<String>? roles,
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
      if (lastLogin != null) 'lastLogin': lastLogin?.toJson(),
      if (authType != null) 'authType': authType,
      if (mfaEnabled != null) 'mfaEnabled': mfaEnabled,
      if (compliancePercent != null) 'compliancePercent': compliancePercent,
      if (roles != null) 'roles': roles?.toJson(),
    };
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
    DateTime? lastLogin,
    String? authType,
    bool? mfaEnabled,
    double? compliancePercent,
    List<String>? roles,
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
         lastLogin: lastLogin,
         authType: authType,
         mfaEnabled: mfaEnabled,
         compliancePercent: compliancePercent,
         roles: roles,
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
    Object? lastLogin = _Undefined,
    Object? authType = _Undefined,
    Object? mfaEnabled = _Undefined,
    Object? compliancePercent = _Undefined,
    Object? roles = _Undefined,
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
      lastLogin: lastLogin is DateTime? ? lastLogin : this.lastLogin,
      authType: authType is String? ? authType : this.authType,
      mfaEnabled: mfaEnabled is bool? ? mfaEnabled : this.mfaEnabled,
      compliancePercent: compliancePercent is double?
          ? compliancePercent
          : this.compliancePercent,
      roles: roles is List<String>?
          ? roles
          : this.roles?.map((e0) => e0).toList(),
    );
  }
}
