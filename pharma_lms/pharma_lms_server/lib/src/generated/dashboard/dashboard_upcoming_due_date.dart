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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i2;

abstract class DashboardUpcomingDueDate
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardUpcomingDueDate._({
    required this.courseTitle,
    required this.dueDate,
    this.sopNumber,
    this.progress,
    this.tags,
    this.status,
  });

  factory DashboardUpcomingDueDate({
    required String courseTitle,
    required DateTime dueDate,
    String? sopNumber,
    double? progress,
    List<String>? tags,
    String? status,
  }) = _DashboardUpcomingDueDateImpl;

  factory DashboardUpcomingDueDate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DashboardUpcomingDueDate(
      courseTitle: jsonSerialization['courseTitle'] as String,
      dueDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      sopNumber: jsonSerialization['sopNumber'] as String?,
      progress: (jsonSerialization['progress'] as num?)?.toDouble(),
      tags: jsonSerialization['tags'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      status: jsonSerialization['status'] as String?,
    );
  }

  String courseTitle;

  DateTime dueDate;

  String? sopNumber;

  double? progress;

  List<String>? tags;

  String? status;

  /// Returns a shallow copy of this [DashboardUpcomingDueDate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardUpcomingDueDate copyWith({
    String? courseTitle,
    DateTime? dueDate,
    String? sopNumber,
    double? progress,
    List<String>? tags,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardUpcomingDueDate',
      'courseTitle': courseTitle,
      'dueDate': dueDate.toJson(),
      if (sopNumber != null) 'sopNumber': sopNumber,
      if (progress != null) 'progress': progress,
      if (tags != null) 'tags': tags?.toJson(),
      if (status != null) 'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardUpcomingDueDate',
      'courseTitle': courseTitle,
      'dueDate': dueDate.toJson(),
      if (sopNumber != null) 'sopNumber': sopNumber,
      if (progress != null) 'progress': progress,
      if (tags != null) 'tags': tags?.toJson(),
      if (status != null) 'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardUpcomingDueDateImpl extends DashboardUpcomingDueDate {
  _DashboardUpcomingDueDateImpl({
    required String courseTitle,
    required DateTime dueDate,
    String? sopNumber,
    double? progress,
    List<String>? tags,
    String? status,
  }) : super._(
         courseTitle: courseTitle,
         dueDate: dueDate,
         sopNumber: sopNumber,
         progress: progress,
         tags: tags,
         status: status,
       );

  /// Returns a shallow copy of this [DashboardUpcomingDueDate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardUpcomingDueDate copyWith({
    String? courseTitle,
    DateTime? dueDate,
    Object? sopNumber = _Undefined,
    Object? progress = _Undefined,
    Object? tags = _Undefined,
    Object? status = _Undefined,
  }) {
    return DashboardUpcomingDueDate(
      courseTitle: courseTitle ?? this.courseTitle,
      dueDate: dueDate ?? this.dueDate,
      sopNumber: sopNumber is String? ? sopNumber : this.sopNumber,
      progress: progress is double? ? progress : this.progress,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      status: status is String? ? status : this.status,
    );
  }
}
