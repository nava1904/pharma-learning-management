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
  }) : assignedAt = assignedAt ?? DateTime.now(),
       priority = priority ?? 'medium',
       source = source ?? 'manual';

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
    );
  }
}
