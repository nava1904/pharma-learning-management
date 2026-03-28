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
import '../organization/organization.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../assessment/question_bank.dart' as _i4;
import '../course/course_version.dart' as _i5;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i6;

/// Trainer-authored assignment (open-ended / MCQ) not tied to a course lesson.
abstract class StandaloneAssignment implements _i1.SerializableModel {
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
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
    };
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
    );
  }
}
