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

/// Aggregated analytics for a training batch (roster + course version).
abstract class BatchTrainingAnalytics implements _i1.SerializableModel {
  BatchTrainingAnalytics._({
    required this.batchId,
    this.courseVersionId,
    required this.rosterCount,
    required this.enrollmentCount,
    required this.completedEnrollments,
    required this.inProgressEnrollments,
    required this.overdueEnrollments,
    required this.totalTimeSpentSeconds,
    required this.averageMaterialProgressPct,
    required this.activeTrainingAssignmentCount,
    required this.assessmentAttemptCount,
    required this.passedAssessmentAttemptCount,
  });

  factory BatchTrainingAnalytics({
    required int batchId,
    int? courseVersionId,
    required int rosterCount,
    required int enrollmentCount,
    required int completedEnrollments,
    required int inProgressEnrollments,
    required int overdueEnrollments,
    required int totalTimeSpentSeconds,
    required double averageMaterialProgressPct,
    required int activeTrainingAssignmentCount,
    required int assessmentAttemptCount,
    required int passedAssessmentAttemptCount,
  }) = _BatchTrainingAnalyticsImpl;

  factory BatchTrainingAnalytics.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BatchTrainingAnalytics(
      batchId: jsonSerialization['batchId'] as int,
      courseVersionId: jsonSerialization['courseVersionId'] as int?,
      rosterCount: jsonSerialization['rosterCount'] as int,
      enrollmentCount: jsonSerialization['enrollmentCount'] as int,
      completedEnrollments: jsonSerialization['completedEnrollments'] as int,
      inProgressEnrollments: jsonSerialization['inProgressEnrollments'] as int,
      overdueEnrollments: jsonSerialization['overdueEnrollments'] as int,
      totalTimeSpentSeconds: jsonSerialization['totalTimeSpentSeconds'] as int,
      averageMaterialProgressPct:
          (jsonSerialization['averageMaterialProgressPct'] as num).toDouble(),
      activeTrainingAssignmentCount:
          jsonSerialization['activeTrainingAssignmentCount'] as int,
      assessmentAttemptCount:
          jsonSerialization['assessmentAttemptCount'] as int,
      passedAssessmentAttemptCount:
          jsonSerialization['passedAssessmentAttemptCount'] as int,
    );
  }

  int batchId;

  int? courseVersionId;

  int rosterCount;

  int enrollmentCount;

  int completedEnrollments;

  int inProgressEnrollments;

  int overdueEnrollments;

  int totalTimeSpentSeconds;

  double averageMaterialProgressPct;

  int activeTrainingAssignmentCount;

  int assessmentAttemptCount;

  int passedAssessmentAttemptCount;

  /// Returns a shallow copy of this [BatchTrainingAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BatchTrainingAnalytics copyWith({
    int? batchId,
    int? courseVersionId,
    int? rosterCount,
    int? enrollmentCount,
    int? completedEnrollments,
    int? inProgressEnrollments,
    int? overdueEnrollments,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BatchTrainingAnalytics',
      'batchId': batchId,
      if (courseVersionId != null) 'courseVersionId': courseVersionId,
      'rosterCount': rosterCount,
      'enrollmentCount': enrollmentCount,
      'completedEnrollments': completedEnrollments,
      'inProgressEnrollments': inProgressEnrollments,
      'overdueEnrollments': overdueEnrollments,
      'totalTimeSpentSeconds': totalTimeSpentSeconds,
      'averageMaterialProgressPct': averageMaterialProgressPct,
      'activeTrainingAssignmentCount': activeTrainingAssignmentCount,
      'assessmentAttemptCount': assessmentAttemptCount,
      'passedAssessmentAttemptCount': passedAssessmentAttemptCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BatchTrainingAnalyticsImpl extends BatchTrainingAnalytics {
  _BatchTrainingAnalyticsImpl({
    required int batchId,
    int? courseVersionId,
    required int rosterCount,
    required int enrollmentCount,
    required int completedEnrollments,
    required int inProgressEnrollments,
    required int overdueEnrollments,
    required int totalTimeSpentSeconds,
    required double averageMaterialProgressPct,
    required int activeTrainingAssignmentCount,
    required int assessmentAttemptCount,
    required int passedAssessmentAttemptCount,
  }) : super._(
         batchId: batchId,
         courseVersionId: courseVersionId,
         rosterCount: rosterCount,
         enrollmentCount: enrollmentCount,
         completedEnrollments: completedEnrollments,
         inProgressEnrollments: inProgressEnrollments,
         overdueEnrollments: overdueEnrollments,
         totalTimeSpentSeconds: totalTimeSpentSeconds,
         averageMaterialProgressPct: averageMaterialProgressPct,
         activeTrainingAssignmentCount: activeTrainingAssignmentCount,
         assessmentAttemptCount: assessmentAttemptCount,
         passedAssessmentAttemptCount: passedAssessmentAttemptCount,
       );

  /// Returns a shallow copy of this [BatchTrainingAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BatchTrainingAnalytics copyWith({
    int? batchId,
    Object? courseVersionId = _Undefined,
    int? rosterCount,
    int? enrollmentCount,
    int? completedEnrollments,
    int? inProgressEnrollments,
    int? overdueEnrollments,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  }) {
    return BatchTrainingAnalytics(
      batchId: batchId ?? this.batchId,
      courseVersionId: courseVersionId is int?
          ? courseVersionId
          : this.courseVersionId,
      rosterCount: rosterCount ?? this.rosterCount,
      enrollmentCount: enrollmentCount ?? this.enrollmentCount,
      completedEnrollments: completedEnrollments ?? this.completedEnrollments,
      inProgressEnrollments:
          inProgressEnrollments ?? this.inProgressEnrollments,
      overdueEnrollments: overdueEnrollments ?? this.overdueEnrollments,
      totalTimeSpentSeconds:
          totalTimeSpentSeconds ?? this.totalTimeSpentSeconds,
      averageMaterialProgressPct:
          averageMaterialProgressPct ?? this.averageMaterialProgressPct,
      activeTrainingAssignmentCount:
          activeTrainingAssignmentCount ?? this.activeTrainingAssignmentCount,
      assessmentAttemptCount:
          assessmentAttemptCount ?? this.assessmentAttemptCount,
      passedAssessmentAttemptCount:
          passedAssessmentAttemptCount ?? this.passedAssessmentAttemptCount,
    );
  }
}
