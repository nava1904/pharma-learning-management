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

/// Course analytics - pass rate and score distribution from TrainingRecord.
abstract class CourseAnalytics
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CourseAnalytics._({
    required this.courseVersionId,
    required this.passRate,
    required this.totalAttempts,
    required this.passedCount,
    this.scoreDistributionJson,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? courseworkSubmissionCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  }) : totalTimeSpentSeconds = totalTimeSpentSeconds ?? 0,
       averageMaterialProgressPct = averageMaterialProgressPct ?? 0.0,
       activeTrainingAssignmentCount = activeTrainingAssignmentCount ?? 0,
       courseworkSubmissionCount = courseworkSubmissionCount ?? 0,
       assessmentAttemptCount = assessmentAttemptCount ?? 0,
       passedAssessmentAttemptCount = passedAssessmentAttemptCount ?? 0;

  factory CourseAnalytics({
    required int courseVersionId,
    required double passRate,
    required int totalAttempts,
    required int passedCount,
    String? scoreDistributionJson,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? courseworkSubmissionCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  }) = _CourseAnalyticsImpl;

  factory CourseAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseAnalytics(
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      passRate: (jsonSerialization['passRate'] as num).toDouble(),
      totalAttempts: jsonSerialization['totalAttempts'] as int,
      passedCount: jsonSerialization['passedCount'] as int,
      scoreDistributionJson:
          jsonSerialization['scoreDistributionJson'] as String?,
      totalTimeSpentSeconds: jsonSerialization['totalTimeSpentSeconds'] as int?,
      averageMaterialProgressPct:
          (jsonSerialization['averageMaterialProgressPct'] as num?)?.toDouble(),
      activeTrainingAssignmentCount:
          jsonSerialization['activeTrainingAssignmentCount'] as int?,
      courseworkSubmissionCount:
          jsonSerialization['courseworkSubmissionCount'] as int?,
      assessmentAttemptCount:
          jsonSerialization['assessmentAttemptCount'] as int?,
      passedAssessmentAttemptCount:
          jsonSerialization['passedAssessmentAttemptCount'] as int?,
    );
  }

  /// Course version ID.
  int courseVersionId;

  /// Pass rate (passed/total) 0.0-1.0.
  double passRate;

  /// Total training records (completed).
  int totalAttempts;

  /// Count that passed (score >= passingScore).
  int passedCount;

  /// Histogram: bucket label -> count. E.g. "0-20": 2, "21-40": 1, "41-60": 3, "61-80": 5, "81-100": 10.
  String? scoreDistributionJson;

  /// Sum of material engagement time for enrollments in this version.
  int totalTimeSpentSeconds;

  /// Mean material progress % (0–100) across progress rows for those enrollments.
  double averageMaterialProgressPct;

  /// Active training assignments tied to this course version.
  int activeTrainingAssignmentCount;

  /// Coursework assignment submissions (lessons in this version) by enrolled learners.
  int courseworkSubmissionCount;

  /// Completed assessment attempts by enrolled learners.
  int assessmentAttemptCount;

  /// Attempts that met passing score.
  int passedAssessmentAttemptCount;

  /// Returns a shallow copy of this [CourseAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseAnalytics copyWith({
    int? courseVersionId,
    double? passRate,
    int? totalAttempts,
    int? passedCount,
    String? scoreDistributionJson,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? courseworkSubmissionCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseAnalytics',
      'courseVersionId': courseVersionId,
      'passRate': passRate,
      'totalAttempts': totalAttempts,
      'passedCount': passedCount,
      if (scoreDistributionJson != null)
        'scoreDistributionJson': scoreDistributionJson,
      'totalTimeSpentSeconds': totalTimeSpentSeconds,
      'averageMaterialProgressPct': averageMaterialProgressPct,
      'activeTrainingAssignmentCount': activeTrainingAssignmentCount,
      'courseworkSubmissionCount': courseworkSubmissionCount,
      'assessmentAttemptCount': assessmentAttemptCount,
      'passedAssessmentAttemptCount': passedAssessmentAttemptCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseAnalytics',
      'courseVersionId': courseVersionId,
      'passRate': passRate,
      'totalAttempts': totalAttempts,
      'passedCount': passedCount,
      if (scoreDistributionJson != null)
        'scoreDistributionJson': scoreDistributionJson,
      'totalTimeSpentSeconds': totalTimeSpentSeconds,
      'averageMaterialProgressPct': averageMaterialProgressPct,
      'activeTrainingAssignmentCount': activeTrainingAssignmentCount,
      'courseworkSubmissionCount': courseworkSubmissionCount,
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

class _CourseAnalyticsImpl extends CourseAnalytics {
  _CourseAnalyticsImpl({
    required int courseVersionId,
    required double passRate,
    required int totalAttempts,
    required int passedCount,
    String? scoreDistributionJson,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? courseworkSubmissionCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  }) : super._(
         courseVersionId: courseVersionId,
         passRate: passRate,
         totalAttempts: totalAttempts,
         passedCount: passedCount,
         scoreDistributionJson: scoreDistributionJson,
         totalTimeSpentSeconds: totalTimeSpentSeconds,
         averageMaterialProgressPct: averageMaterialProgressPct,
         activeTrainingAssignmentCount: activeTrainingAssignmentCount,
         courseworkSubmissionCount: courseworkSubmissionCount,
         assessmentAttemptCount: assessmentAttemptCount,
         passedAssessmentAttemptCount: passedAssessmentAttemptCount,
       );

  /// Returns a shallow copy of this [CourseAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseAnalytics copyWith({
    int? courseVersionId,
    double? passRate,
    int? totalAttempts,
    int? passedCount,
    Object? scoreDistributionJson = _Undefined,
    int? totalTimeSpentSeconds,
    double? averageMaterialProgressPct,
    int? activeTrainingAssignmentCount,
    int? courseworkSubmissionCount,
    int? assessmentAttemptCount,
    int? passedAssessmentAttemptCount,
  }) {
    return CourseAnalytics(
      courseVersionId: courseVersionId ?? this.courseVersionId,
      passRate: passRate ?? this.passRate,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      passedCount: passedCount ?? this.passedCount,
      scoreDistributionJson: scoreDistributionJson is String?
          ? scoreDistributionJson
          : this.scoreDistributionJson,
      totalTimeSpentSeconds:
          totalTimeSpentSeconds ?? this.totalTimeSpentSeconds,
      averageMaterialProgressPct:
          averageMaterialProgressPct ?? this.averageMaterialProgressPct,
      activeTrainingAssignmentCount:
          activeTrainingAssignmentCount ?? this.activeTrainingAssignmentCount,
      courseworkSubmissionCount:
          courseworkSubmissionCount ?? this.courseworkSubmissionCount,
      assessmentAttemptCount:
          assessmentAttemptCount ?? this.assessmentAttemptCount,
      passedAssessmentAttemptCount:
          passedAssessmentAttemptCount ?? this.passedAssessmentAttemptCount,
    );
  }
}
