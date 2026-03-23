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
import '../course/course_version.dart' as _i3;
import '../organization/user.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Training batch for scheduled cohort training. GMP compliant.
abstract class TrainingBatch implements _i1.SerializableModel {
  TrainingBatch._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.courseVersionId,
    this.courseVersion,
    required this.name,
    required this.instructorId,
    this.instructor,
    required this.startDate,
    required this.endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    this.location,
    this.notes,
    DateTime? createdAt,
  }) : capacity = capacity ?? 30,
       enrolledCount = enrolledCount ?? 0,
       completedCount = completedCount ?? 0,
       status = status ?? 'scheduled',
       createdAt = createdAt ?? DateTime.now();

  factory TrainingBatch({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required String name,
    required int instructorId,
    _i4.PharmaUser? instructor,
    required DateTime startDate,
    required DateTime endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    String? location,
    String? notes,
    DateTime? createdAt,
  }) = _TrainingBatchImpl;

  factory TrainingBatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingBatch(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseVersion: jsonSerialization['courseVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.CourseVersion>(
              jsonSerialization['courseVersion'],
            ),
      name: jsonSerialization['name'] as String,
      instructorId: jsonSerialization['instructorId'] as int,
      instructor: jsonSerialization['instructor'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PharmaUser>(
              jsonSerialization['instructor'],
            ),
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      capacity: jsonSerialization['capacity'] as int?,
      enrolledCount: jsonSerialization['enrolledCount'] as int?,
      completedCount: jsonSerialization['completedCount'] as int?,
      status: jsonSerialization['status'] as String?,
      location: jsonSerialization['location'] as String?,
      notes: jsonSerialization['notes'] as String?,
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

  /// Organization this batch belongs to.
  _i2.Organization? organization;

  int courseVersionId;

  /// The course version for this batch.
  _i3.CourseVersion? courseVersion;

  /// Batch name.
  String name;

  int instructorId;

  /// Instructor/trainer assigned.
  _i4.PharmaUser? instructor;

  /// When batch starts.
  DateTime startDate;

  /// When batch ends.
  DateTime endDate;

  /// Max capacity of learners.
  int capacity;

  /// Number of learners enrolled.
  int enrolledCount;

  /// Number of learners completed.
  int completedCount;

  /// Status: scheduled, active, completed, cancelled.
  String status;

  /// Location (room, building, etc).
  String? location;

  /// Notes or description.
  String? notes;

  /// Created timestamp.
  DateTime createdAt;

  /// Returns a shallow copy of this [TrainingBatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingBatch copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? courseVersionId,
    _i3.CourseVersion? courseVersion,
    String? name,
    int? instructorId,
    _i4.PharmaUser? instructor,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    String? location,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingBatch',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'courseVersionId': courseVersionId,
      if (courseVersion != null) 'courseVersion': courseVersion?.toJson(),
      'name': name,
      'instructorId': instructorId,
      if (instructor != null) 'instructor': instructor?.toJson(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'capacity': capacity,
      'enrolledCount': enrolledCount,
      'completedCount': completedCount,
      'status': status,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingBatchImpl extends TrainingBatch {
  _TrainingBatchImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int courseVersionId,
    _i3.CourseVersion? courseVersion,
    required String name,
    required int instructorId,
    _i4.PharmaUser? instructor,
    required DateTime startDate,
    required DateTime endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    String? location,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         courseVersionId: courseVersionId,
         courseVersion: courseVersion,
         name: name,
         instructorId: instructorId,
         instructor: instructor,
         startDate: startDate,
         endDate: endDate,
         capacity: capacity,
         enrolledCount: enrolledCount,
         completedCount: completedCount,
         status: status,
         location: location,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [TrainingBatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingBatch copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    int? courseVersionId,
    Object? courseVersion = _Undefined,
    String? name,
    int? instructorId,
    Object? instructor = _Undefined,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    int? enrolledCount,
    int? completedCount,
    String? status,
    Object? location = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return TrainingBatch(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseVersion: courseVersion is _i3.CourseVersion?
          ? courseVersion
          : this.courseVersion?.copyWith(),
      name: name ?? this.name,
      instructorId: instructorId ?? this.instructorId,
      instructor: instructor is _i4.PharmaUser?
          ? instructor
          : this.instructor?.copyWith(),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      capacity: capacity ?? this.capacity,
      enrolledCount: enrolledCount ?? this.enrolledCount,
      completedCount: completedCount ?? this.completedCount,
      status: status ?? this.status,
      location: location is String? ? location : this.location,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
