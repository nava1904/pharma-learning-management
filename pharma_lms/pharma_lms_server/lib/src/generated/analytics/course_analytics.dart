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
  });

  factory CourseAnalytics({
    required int courseVersionId,
    required double passRate,
    required int totalAttempts,
    required int passedCount,
    String? scoreDistributionJson,
  }) = _CourseAnalyticsImpl;

  factory CourseAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseAnalytics(
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      passRate: (jsonSerialization['passRate'] as num).toDouble(),
      totalAttempts: jsonSerialization['totalAttempts'] as int,
      passedCount: jsonSerialization['passedCount'] as int,
      scoreDistributionJson:
          jsonSerialization['scoreDistributionJson'] as String?,
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

  /// Returns a shallow copy of this [CourseAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseAnalytics copyWith({
    int? courseVersionId,
    double? passRate,
    int? totalAttempts,
    int? passedCount,
    String? scoreDistributionJson,
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
  }) : super._(
         courseVersionId: courseVersionId,
         passRate: passRate,
         totalAttempts: totalAttempts,
         passedCount: passedCount,
         scoreDistributionJson: scoreDistributionJson,
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
  }) {
    return CourseAnalytics(
      courseVersionId: courseVersionId ?? this.courseVersionId,
      passRate: passRate ?? this.passRate,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      passedCount: passedCount ?? this.passedCount,
      scoreDistributionJson: scoreDistributionJson is String?
          ? scoreDistributionJson
          : this.scoreDistributionJson,
    );
  }
}
