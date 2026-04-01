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
import '../training/standalone_assignment.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// One row per learner assigned a [StandaloneAssignment].
abstract class StandaloneAssignmentRecipient implements _i1.SerializableModel {
  StandaloneAssignmentRecipient._({
    this.id,
    required this.assignmentId,
    this.assignment,
    required this.userId,
    this.user,
    String? status,
    this.submittedAt,
    this.responseJson,
    this.grade,
    this.feedback,
    this.gradedAt,
    this.gradedById,
    DateTime? createdAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now();

  factory StandaloneAssignmentRecipient({
    int? id,
    required int assignmentId,
    _i2.StandaloneAssignment? assignment,
    required int userId,
    _i3.PharmaUser? user,
    String? status,
    DateTime? submittedAt,
    String? responseJson,
    int? grade,
    String? feedback,
    DateTime? gradedAt,
    int? gradedById,
    DateTime? createdAt,
  }) = _StandaloneAssignmentRecipientImpl;

  factory StandaloneAssignmentRecipient.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StandaloneAssignmentRecipient(
      id: jsonSerialization['id'] as int?,
      assignmentId: jsonSerialization['assignmentId'] as int,
      assignment: jsonSerialization['assignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.StandaloneAssignment>(
              jsonSerialization['assignment'],
            ),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      status: jsonSerialization['status'] as String?,
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      responseJson: jsonSerialization['responseJson'] as String?,
      grade: jsonSerialization['grade'] as int?,
      feedback: jsonSerialization['feedback'] as String?,
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
      gradedById: jsonSerialization['gradedById'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int assignmentId;

  _i2.StandaloneAssignment? assignment;

  int userId;

  _i3.PharmaUser? user;

  /// pending | submitted | graded
  String status;

  DateTime? submittedAt;

  /// JSON: answers or open-ended text
  String? responseJson;

  /// Grade (0-100).
  int? grade;

  /// Trainer feedback.
  String? feedback;

  /// When graded.
  DateTime? gradedAt;

  /// Who graded.
  int? gradedById;

  DateTime createdAt;

  /// Returns a shallow copy of this [StandaloneAssignmentRecipient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StandaloneAssignmentRecipient copyWith({
    int? id,
    int? assignmentId,
    _i2.StandaloneAssignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? status,
    DateTime? submittedAt,
    String? responseJson,
    int? grade,
    String? feedback,
    DateTime? gradedAt,
    int? gradedById,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StandaloneAssignmentRecipient',
      if (id != null) 'id': id,
      'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'status': status,
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (responseJson != null) 'responseJson': responseJson,
      if (grade != null) 'grade': grade,
      if (feedback != null) 'feedback': feedback,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
      if (gradedById != null) 'gradedById': gradedById,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StandaloneAssignmentRecipientImpl extends StandaloneAssignmentRecipient {
  _StandaloneAssignmentRecipientImpl({
    int? id,
    required int assignmentId,
    _i2.StandaloneAssignment? assignment,
    required int userId,
    _i3.PharmaUser? user,
    String? status,
    DateTime? submittedAt,
    String? responseJson,
    int? grade,
    String? feedback,
    DateTime? gradedAt,
    int? gradedById,
    DateTime? createdAt,
  }) : super._(
         id: id,
         assignmentId: assignmentId,
         assignment: assignment,
         userId: userId,
         user: user,
         status: status,
         submittedAt: submittedAt,
         responseJson: responseJson,
         grade: grade,
         feedback: feedback,
         gradedAt: gradedAt,
         gradedById: gradedById,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StandaloneAssignmentRecipient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StandaloneAssignmentRecipient copyWith({
    Object? id = _Undefined,
    int? assignmentId,
    Object? assignment = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? status,
    Object? submittedAt = _Undefined,
    Object? responseJson = _Undefined,
    Object? grade = _Undefined,
    Object? feedback = _Undefined,
    Object? gradedAt = _Undefined,
    Object? gradedById = _Undefined,
    DateTime? createdAt,
  }) {
    return StandaloneAssignmentRecipient(
      id: id is int? ? id : this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      assignment: assignment is _i2.StandaloneAssignment?
          ? assignment
          : this.assignment?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      status: status ?? this.status,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      responseJson: responseJson is String? ? responseJson : this.responseJson,
      grade: grade is int? ? grade : this.grade,
      feedback: feedback is String? ? feedback : this.feedback,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
      gradedById: gradedById is int? ? gradedById : this.gradedById,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
