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
import '../course/assignment.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Student submission for an assignment.
abstract class AssignmentSubmission implements _i1.SerializableModel {
  AssignmentSubmission._({
    this.id,
    required this.assignmentId,
    this.assignment,
    this.userId,
    this.user,
    this.submissionUrl,
    this.storageKey,
    this.fileName,
    String? status,
    this.grade,
    this.feedback,
    DateTime? submittedAt,
    this.gradedAt,
  }) : status = status ?? 'submitted',
       submittedAt = submittedAt ?? DateTime.now();

  factory AssignmentSubmission({
    int? id,
    required int assignmentId,
    _i2.Assignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
    String? status,
    int? grade,
    String? feedback,
    DateTime? submittedAt,
    DateTime? gradedAt,
  }) = _AssignmentSubmissionImpl;

  factory AssignmentSubmission.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AssignmentSubmission(
      id: jsonSerialization['id'] as int?,
      assignmentId: jsonSerialization['assignmentId'] as int,
      assignment: jsonSerialization['assignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Assignment>(
              jsonSerialization['assignment'],
            ),
      userId: jsonSerialization['userId'] as int?,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['user'],
            ),
      submissionUrl: jsonSerialization['submissionUrl'] as String?,
      storageKey: jsonSerialization['storageKey'] as String?,
      fileName: jsonSerialization['fileName'] as String?,
      status: jsonSerialization['status'] as String?,
      grade: jsonSerialization['grade'] as int?,
      feedback: jsonSerialization['feedback'] as String?,
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int assignmentId;

  /// The assignment being submitted to.
  _i2.Assignment? assignment;

  int? userId;

  /// The user who submitted.
  _i3.PharmaUser? user;

  /// URL submission.
  String? submissionUrl;

  /// File upload storage key.
  String? storageKey;

  /// Original file name.
  String? fileName;

  /// Status: submitted, graded, returned.
  String status;

  /// Grade (0-100).
  int? grade;

  /// Instructor feedback.
  String? feedback;

  /// Submitted timestamp.
  DateTime submittedAt;

  /// Graded timestamp.
  DateTime? gradedAt;

  /// Returns a shallow copy of this [AssignmentSubmission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssignmentSubmission copyWith({
    int? id,
    int? assignmentId,
    _i2.Assignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
    String? status,
    int? grade,
    String? feedback,
    DateTime? submittedAt,
    DateTime? gradedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssignmentSubmission',
      if (id != null) 'id': id,
      'assignmentId': assignmentId,
      if (assignment != null) 'assignment': assignment?.toJson(),
      if (userId != null) 'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (submissionUrl != null) 'submissionUrl': submissionUrl,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'status': status,
      if (grade != null) 'grade': grade,
      if (feedback != null) 'feedback': feedback,
      'submittedAt': submittedAt.toJson(),
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssignmentSubmissionImpl extends AssignmentSubmission {
  _AssignmentSubmissionImpl({
    int? id,
    required int assignmentId,
    _i2.Assignment? assignment,
    int? userId,
    _i3.PharmaUser? user,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
    String? status,
    int? grade,
    String? feedback,
    DateTime? submittedAt,
    DateTime? gradedAt,
  }) : super._(
         id: id,
         assignmentId: assignmentId,
         assignment: assignment,
         userId: userId,
         user: user,
         submissionUrl: submissionUrl,
         storageKey: storageKey,
         fileName: fileName,
         status: status,
         grade: grade,
         feedback: feedback,
         submittedAt: submittedAt,
         gradedAt: gradedAt,
       );

  /// Returns a shallow copy of this [AssignmentSubmission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssignmentSubmission copyWith({
    Object? id = _Undefined,
    int? assignmentId,
    Object? assignment = _Undefined,
    Object? userId = _Undefined,
    Object? user = _Undefined,
    Object? submissionUrl = _Undefined,
    Object? storageKey = _Undefined,
    Object? fileName = _Undefined,
    String? status,
    Object? grade = _Undefined,
    Object? feedback = _Undefined,
    DateTime? submittedAt,
    Object? gradedAt = _Undefined,
  }) {
    return AssignmentSubmission(
      id: id is int? ? id : this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      assignment: assignment is _i2.Assignment?
          ? assignment
          : this.assignment?.copyWith(),
      userId: userId is int? ? userId : this.userId,
      user: user is _i3.PharmaUser? ? user : this.user?.copyWith(),
      submissionUrl: submissionUrl is String?
          ? submissionUrl
          : this.submissionUrl,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      fileName: fileName is String? ? fileName : this.fileName,
      status: status ?? this.status,
      grade: grade is int? ? grade : this.grade,
      feedback: feedback is String? ? feedback : this.feedback,
      submittedAt: submittedAt ?? this.submittedAt,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
    );
  }
}
