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
import '../organization/job_role.dart' as _i2;
import '../course/course.dart' as _i3;
import '../organization/site.dart' as _i4;
import '../organization/user.dart' as _i5;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i6;

/// Training matrix - role to course mapping. GMP.
abstract class TrainingMatrix implements _i1.SerializableModel {
  TrainingMatrix._({
    this.id,
    required this.jobRoleId,
    this.jobRole,
    required this.courseId,
    this.course,
    this.siteId,
    this.site,
    bool? isMandatory,
    int? dueDaysFromHire,
    this.retrainingIntervalDays,
    this.createdById,
    this.createdBy,
    this.approvedById,
    this.approvedBy,
    this.effectiveDate,
  }) : isMandatory = isMandatory ?? true,
       dueDaysFromHire = dueDaysFromHire ?? 60;

  factory TrainingMatrix({
    int? id,
    required int jobRoleId,
    _i2.JobRole? jobRole,
    required int courseId,
    _i3.Course? course,
    int? siteId,
    _i4.Site? site,
    bool? isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? createdById,
    _i5.PharmaUser? createdBy,
    int? approvedById,
    _i5.PharmaUser? approvedBy,
    DateTime? effectiveDate,
  }) = _TrainingMatrixImpl;

  factory TrainingMatrix.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingMatrix(
      id: jsonSerialization['id'] as int?,
      jobRoleId: jsonSerialization['jobRoleId'] as int,
      jobRole: jsonSerialization['jobRole'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.JobRole>(
              jsonSerialization['jobRole'],
            ),
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Course>(jsonSerialization['course']),
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Site>(jsonSerialization['site']),
      isMandatory: jsonSerialization['isMandatory'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMandatory']),
      dueDaysFromHire: jsonSerialization['dueDaysFromHire'] as int?,
      retrainingIntervalDays:
          jsonSerialization['retrainingIntervalDays'] as int?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      approvedById: jsonSerialization['approvedById'] as int?,
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.PharmaUser>(
              jsonSerialization['approvedBy'],
            ),
      effectiveDate: jsonSerialization['effectiveDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectiveDate'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobRoleId;

  /// The job role.
  _i2.JobRole? jobRole;

  int courseId;

  /// The course.
  _i3.Course? course;

  int? siteId;

  /// Site (nullable for org-wide).
  _i4.Site? site;

  /// Whether mandatory for this role.
  bool isMandatory;

  /// Days from hire to complete (default 60 for onboarding).
  int dueDaysFromHire;

  /// Retraining interval in days (for recurring certs).
  int? retrainingIntervalDays;

  int? createdById;

  /// Who created.
  _i5.PharmaUser? createdBy;

  int? approvedById;

  /// QA approval for matrix changes.
  _i5.PharmaUser? approvedBy;

  /// When effective.
  DateTime? effectiveDate;

  /// Returns a shallow copy of this [TrainingMatrix]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingMatrix copyWith({
    int? id,
    int? jobRoleId,
    _i2.JobRole? jobRole,
    int? courseId,
    _i3.Course? course,
    int? siteId,
    _i4.Site? site,
    bool? isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? createdById,
    _i5.PharmaUser? createdBy,
    int? approvedById,
    _i5.PharmaUser? approvedBy,
    DateTime? effectiveDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingMatrix',
      if (id != null) 'id': id,
      'jobRoleId': jobRoleId,
      if (jobRole != null) 'jobRole': jobRole?.toJson(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'isMandatory': isMandatory,
      'dueDaysFromHire': dueDaysFromHire,
      if (retrainingIntervalDays != null)
        'retrainingIntervalDays': retrainingIntervalDays,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      if (approvedById != null) 'approvedById': approvedById,
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingMatrixImpl extends TrainingMatrix {
  _TrainingMatrixImpl({
    int? id,
    required int jobRoleId,
    _i2.JobRole? jobRole,
    required int courseId,
    _i3.Course? course,
    int? siteId,
    _i4.Site? site,
    bool? isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? createdById,
    _i5.PharmaUser? createdBy,
    int? approvedById,
    _i5.PharmaUser? approvedBy,
    DateTime? effectiveDate,
  }) : super._(
         id: id,
         jobRoleId: jobRoleId,
         jobRole: jobRole,
         courseId: courseId,
         course: course,
         siteId: siteId,
         site: site,
         isMandatory: isMandatory,
         dueDaysFromHire: dueDaysFromHire,
         retrainingIntervalDays: retrainingIntervalDays,
         createdById: createdById,
         createdBy: createdBy,
         approvedById: approvedById,
         approvedBy: approvedBy,
         effectiveDate: effectiveDate,
       );

  /// Returns a shallow copy of this [TrainingMatrix]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingMatrix copyWith({
    Object? id = _Undefined,
    int? jobRoleId,
    Object? jobRole = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    bool? isMandatory,
    int? dueDaysFromHire,
    Object? retrainingIntervalDays = _Undefined,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    Object? approvedById = _Undefined,
    Object? approvedBy = _Undefined,
    Object? effectiveDate = _Undefined,
  }) {
    return TrainingMatrix(
      id: id is int? ? id : this.id,
      jobRoleId: jobRoleId ?? this.jobRoleId,
      jobRole: jobRole is _i2.JobRole? ? jobRole : this.jobRole?.copyWith(),
      courseId: courseId ?? this.courseId,
      course: course is _i3.Course? ? course : this.course?.copyWith(),
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i4.Site? ? site : this.site?.copyWith(),
      isMandatory: isMandatory ?? this.isMandatory,
      dueDaysFromHire: dueDaysFromHire ?? this.dueDaysFromHire,
      retrainingIntervalDays: retrainingIntervalDays is int?
          ? retrainingIntervalDays
          : this.retrainingIntervalDays,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i5.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      approvedById: approvedById is int? ? approvedById : this.approvedById,
      approvedBy: approvedBy is _i5.PharmaUser?
          ? approvedBy
          : this.approvedBy?.copyWith(),
      effectiveDate: effectiveDate is DateTime?
          ? effectiveDate
          : this.effectiveDate,
    );
  }
}
