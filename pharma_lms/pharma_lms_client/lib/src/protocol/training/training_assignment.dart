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
import '../organization/user.dart' as _i2;
import '../course/course_version.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Training assignment to user for a course version.
abstract class TrainingAssignment implements _i1.SerializableModel {
  TrainingAssignment._({
    this.id,
    required this.userId,
    this.user,
    required this.courseVersionId,
    this.courseVersion,
    required this.assignedById,
    this.assignedBy,
    DateTime? assignedAt,
    required this.dueDate,
    String? priority,
    this.reason,
    String? source,
    String? assignmentType,
    this.targetRoleId,
    this.targetDepartmentId,
    this.targetUserId,
    String? status,
    this.cancelledAt,
    this.cancelledById,
    this.cancellationReason,
  }) : assignedAt = assignedAt ?? DateTime.now(),
       priority = priority ?? 'medium',
       source = source ?? 'manual',
       assignmentType = assignmentType ?? 'individual',
       status = status ?? 'active';

  factory TrainingAssignment({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int assignedById,
    _i2.PharmaUser? assignedBy,
    DateTime? assignedAt,
    required DateTime dueDate,
    String? priority,
    String? reason,
    String? source,
    String? assignmentType,
    int? targetRoleId,
    int? targetDepartmentId,
    int? targetUserId,
    String? status,
    DateTime? cancelledAt,
    int? cancelledById,
    String? cancellationReason,
  }) = _TrainingAssignmentImpl;

  factory TrainingAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingAssignment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      assignedById: jsonSerialization['assignedById'] as int,
      assignedBy: jsonSerialization['assignedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['assignedBy'],
            ),
      assignedAt: jsonSerialization['assignedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['assignedAt']),
      dueDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      priority: jsonSerialization['priority'] as String?,
      reason: jsonSerialization['reason'] as String?,
      source: jsonSerialization['source'] as String?,
      assignmentType: jsonSerialization['assignmentType'] as String?,
      targetRoleId: jsonSerialization['targetRoleId'] as int?,
      targetDepartmentId: jsonSerialization['targetDepartmentId'] as int?,
      targetUserId: jsonSerialization['targetUserId'] as int?,
      status: jsonSerialization['status'] as String?,
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancelledById: jsonSerialization['cancelledById'] as int?,
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user assigned.
  _i2.PharmaUser? user;

  int courseVersionId;

  /// The course version to complete.
  _i3.CourseVersion? courseVersion;

  int assignedById;

  /// Who assigned (user ID).
  _i2.PharmaUser? assignedBy;

  /// When assigned.
  DateTime assignedAt;

  /// Due date.
  DateTime dueDate;

  /// Priority: low, medium, high.
  String priority;

  /// Reason for assignment.
  String? reason;

  /// Source: manual, sop_update, capa, onboarding.
  String source;

  /// Assignment type: role, department, individual, capa.
  String assignmentType;

  /// Target role ID when assigning by role.
  int? targetRoleId;

  /// Target department ID when assigning by department.
  int? targetDepartmentId;

  /// Target user ID when assigning to individual.
  int? targetUserId;

  /// Status: active, cancelled.
  String status;

  /// When cancelled.
  DateTime? cancelledAt;

  /// Who cancelled.
  int? cancelledById;

  /// Cancellation reason.
  String? cancellationReason;

  /// Returns a shallow copy of this [TrainingAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingAssignment copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    int? assignedById,
    _i2.PharmaUser? assignedBy,
    DateTime? assignedAt,
    DateTime? dueDate,
    String? priority,
    String? reason,
    String? source,
    String? assignmentType,
    int? targetRoleId,
    int? targetDepartmentId,
    int? targetUserId,
    String? status,
    DateTime? cancelledAt,
    int? cancelledById,
    String? cancellationReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'assignedById': assignedById,
      if (assignedBy != null) 'assignedBy': assignedBy?.toJson(),
      'assignedAt': assignedAt.toJson(),
      'dueDate': dueDate.toJson(),
      'priority': priority,
      if (reason != null) 'reason': reason,
      'source': source,
      'assignmentType': assignmentType,
      if (targetRoleId != null) 'targetRoleId': targetRoleId,
      if (targetDepartmentId != null) 'targetDepartmentId': targetDepartmentId,
      if (targetUserId != null) 'targetUserId': targetUserId,
      'status': status,
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById,
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingAssignmentImpl extends TrainingAssignment {
  _TrainingAssignmentImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required int assignedById,
    _i2.PharmaUser? assignedBy,
    DateTime? assignedAt,
    required DateTime dueDate,
    String? priority,
    String? reason,
    String? source,
    String? assignmentType,
    int? targetRoleId,
    int? targetDepartmentId,
    int? targetUserId,
    String? status,
    DateTime? cancelledAt,
    int? cancelledById,
    String? cancellationReason,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         assignedById: assignedById,
         assignedBy: assignedBy,
         assignedAt: assignedAt,
         dueDate: dueDate,
         priority: priority,
         reason: reason,
         source: source,
         assignmentType: assignmentType,
         targetRoleId: targetRoleId,
         targetDepartmentId: targetDepartmentId,
         targetUserId: targetUserId,
         status: status,
         cancelledAt: cancelledAt,
         cancelledById: cancelledById,
         cancellationReason: cancellationReason,
       );

  /// Returns a shallow copy of this [TrainingAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingAssignment copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    int? assignedById,
    Object? assignedBy = _Undefined,
    DateTime? assignedAt,
    DateTime? dueDate,
    String? priority,
    Object? reason = _Undefined,
    String? source,
    String? assignmentType,
    Object? targetRoleId = _Undefined,
    Object? targetDepartmentId = _Undefined,
    Object? targetUserId = _Undefined,
    String? status,
    Object? cancelledAt = _Undefined,
    Object? cancelledById = _Undefined,
    Object? cancellationReason = _Undefined,
  }) {
    return TrainingAssignment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      assignedById: assignedById ?? this.assignedById,
      assignedBy: assignedBy is _i2.PharmaUser?
          ? assignedBy
          : this.assignedBy?.copyWith(),
      assignedAt: assignedAt ?? this.assignedAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      reason: reason is String? ? reason : this.reason,
      source: source ?? this.source,
      assignmentType: assignmentType ?? this.assignmentType,
      targetRoleId: targetRoleId is int? ? targetRoleId : this.targetRoleId,
      targetDepartmentId: targetDepartmentId is int?
          ? targetDepartmentId
          : this.targetDepartmentId,
      targetUserId: targetUserId is int? ? targetUserId : this.targetUserId,
      status: status ?? this.status,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancelledById: cancelledById is int? ? cancelledById : this.cancelledById,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
    );
  }
}
