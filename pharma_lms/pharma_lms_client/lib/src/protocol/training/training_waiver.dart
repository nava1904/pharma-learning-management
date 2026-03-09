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
import '../course/course.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Training waiver - exempt user from course requirement. ADM-07.
/// Request flow: employee/admin requests -> QA approves with evidence.
abstract class TrainingWaiver implements _i1.SerializableModel {
  TrainingWaiver._({
    this.id,
    required this.userId,
    this.user,
    required this.courseId,
    this.course,
    required this.requestedById,
    this.requestedBy,
    DateTime? requestedAt,
    required this.requestReason,
    this.evidenceStoragePath,
    String? status,
    this.approvedById,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    this.expiresAt,
  }) : requestedAt = requestedAt ?? DateTime.now(),
       status = status ?? 'pending';

  factory TrainingWaiver({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseId,
    _i3.Course? course,
    required int requestedById,
    _i2.PharmaUser? requestedBy,
    DateTime? requestedAt,
    required String requestReason,
    String? evidenceStoragePath,
    String? status,
    int? approvedById,
    _i2.PharmaUser? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    DateTime? expiresAt,
  }) = _TrainingWaiverImpl;

  factory TrainingWaiver.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingWaiver(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      courseId: jsonSerialization['courseId'] as int,
      course: jsonSerialization['course'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Course>(jsonSerialization['course']),
      requestedById: jsonSerialization['requestedById'] as int,
      requestedBy: jsonSerialization['requestedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['requestedBy'],
            ),
      requestedAt: jsonSerialization['requestedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['requestedAt'],
            ),
      requestReason: jsonSerialization['requestReason'] as String,
      evidenceStoragePath: jsonSerialization['evidenceStoragePath'] as String?,
      status: jsonSerialization['status'] as String?,
      approvedById: jsonSerialization['approvedById'] as int?,
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['approvedBy'],
            ),
      approvedAt: jsonSerialization['approvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['approvedAt']),
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user being waived.
  _i2.PharmaUser? user;

  int courseId;

  /// The course requirement being waived.
  _i3.Course? course;

  int requestedById;

  /// Who requested (admin or employee).
  _i2.PharmaUser? requestedBy;

  /// When requested.
  DateTime requestedAt;

  /// Justification for waiver request.
  String requestReason;

  /// Cloud storage path for evidence attachment (e.g. prior cert, justification doc).
  String? evidenceStoragePath;

  /// Status: pending, approved, rejected.
  String status;

  int? approvedById;

  /// QA user who approved/rejected.
  _i2.PharmaUser? approvedBy;

  /// When approved/rejected.
  DateTime? approvedAt;

  /// Rejection reason when status is rejected.
  String? rejectionReason;

  /// Optional expiry - waiver valid until this date.
  DateTime? expiresAt;

  /// Returns a shallow copy of this [TrainingWaiver]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingWaiver copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? courseId,
    _i3.Course? course,
    int? requestedById,
    _i2.PharmaUser? requestedBy,
    DateTime? requestedAt,
    String? requestReason,
    String? evidenceStoragePath,
    String? status,
    int? approvedById,
    _i2.PharmaUser? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingWaiver',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'courseId': courseId,
      if (course != null) 'course': course?.toJson(),
      'requestedById': requestedById,
      if (requestedBy != null) 'requestedBy': requestedBy?.toJson(),
      'requestedAt': requestedAt.toJson(),
      'requestReason': requestReason,
      if (evidenceStoragePath != null)
        'evidenceStoragePath': evidenceStoragePath,
      'status': status,
      if (approvedById != null) 'approvedById': approvedById,
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingWaiverImpl extends TrainingWaiver {
  _TrainingWaiverImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int courseId,
    _i3.Course? course,
    required int requestedById,
    _i2.PharmaUser? requestedBy,
    DateTime? requestedAt,
    required String requestReason,
    String? evidenceStoragePath,
    String? status,
    int? approvedById,
    _i2.PharmaUser? approvedBy,
    DateTime? approvedAt,
    String? rejectionReason,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         courseId: courseId,
         course: course,
         requestedById: requestedById,
         requestedBy: requestedBy,
         requestedAt: requestedAt,
         requestReason: requestReason,
         evidenceStoragePath: evidenceStoragePath,
         status: status,
         approvedById: approvedById,
         approvedBy: approvedBy,
         approvedAt: approvedAt,
         rejectionReason: rejectionReason,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [TrainingWaiver]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingWaiver copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? courseId,
    Object? course = _Undefined,
    int? requestedById,
    Object? requestedBy = _Undefined,
    DateTime? requestedAt,
    String? requestReason,
    Object? evidenceStoragePath = _Undefined,
    String? status,
    Object? approvedById = _Undefined,
    Object? approvedBy = _Undefined,
    Object? approvedAt = _Undefined,
    Object? rejectionReason = _Undefined,
    Object? expiresAt = _Undefined,
  }) {
    return TrainingWaiver(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      courseId: courseId ?? this.courseId,
      course: course is _i3.Course? ? course : this.course?.copyWith(),
      requestedById: requestedById ?? this.requestedById,
      requestedBy: requestedBy is _i2.PharmaUser?
          ? requestedBy
          : this.requestedBy?.copyWith(),
      requestedAt: requestedAt ?? this.requestedAt,
      requestReason: requestReason ?? this.requestReason,
      evidenceStoragePath: evidenceStoragePath is String?
          ? evidenceStoragePath
          : this.evidenceStoragePath,
      status: status ?? this.status,
      approvedById: approvedById is int? ? approvedById : this.approvedById,
      approvedBy: approvedBy is _i2.PharmaUser?
          ? approvedBy
          : this.approvedBy?.copyWith(),
      approvedAt: approvedAt is DateTime? ? approvedAt : this.approvedAt,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
