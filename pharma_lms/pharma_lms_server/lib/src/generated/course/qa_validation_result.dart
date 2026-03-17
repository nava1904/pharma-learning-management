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
import '../course/qa_validation_rule_result.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Result of TRN-WF-04 validateForQaSubmission.
abstract class QaValidationResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  QaValidationResult._({
    required this.courseVersionId,
    required this.courseTitle,
    required this.version,
    required this.allPassed,
    required this.passedCount,
    required this.totalRules,
    required this.validationResults,
  });

  factory QaValidationResult({
    required int courseVersionId,
    required String courseTitle,
    required String version,
    required bool allPassed,
    required int passedCount,
    required int totalRules,
    required List<_i2.QaValidationRuleResult> validationResults,
  }) = _QaValidationResultImpl;

  factory QaValidationResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return QaValidationResult(
      courseVersionId: jsonSerialization['courseVersionId'] as int,
      courseTitle: jsonSerialization['courseTitle'] as String,
      version: jsonSerialization['version'] as String,
      allPassed: _i1.BoolJsonExtension.fromJson(jsonSerialization['allPassed']),
      passedCount: jsonSerialization['passedCount'] as int,
      totalRules: jsonSerialization['totalRules'] as int,
      validationResults: _i3.Protocol()
          .deserialize<List<_i2.QaValidationRuleResult>>(
            jsonSerialization['validationResults'],
          ),
    );
  }

  /// Course version ID validated.
  int courseVersionId;

  /// Course title.
  String courseTitle;

  /// Version string (e.g., "1.0").
  String version;

  /// Whether all validation rules passed.
  bool allPassed;

  /// Number of rules that passed.
  int passedCount;

  /// Total number of rules checked.
  int totalRules;

  /// Per-rule validation results.
  List<_i2.QaValidationRuleResult> validationResults;

  /// Returns a shallow copy of this [QaValidationResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QaValidationResult copyWith({
    int? courseVersionId,
    String? courseTitle,
    String? version,
    bool? allPassed,
    int? passedCount,
    int? totalRules,
    List<_i2.QaValidationRuleResult>? validationResults,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QaValidationResult',
      'courseVersionId': courseVersionId,
      'courseTitle': courseTitle,
      'version': version,
      'allPassed': allPassed,
      'passedCount': passedCount,
      'totalRules': totalRules,
      'validationResults': validationResults.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QaValidationResult',
      'courseVersionId': courseVersionId,
      'courseTitle': courseTitle,
      'version': version,
      'allPassed': allPassed,
      'passedCount': passedCount,
      'totalRules': totalRules,
      'validationResults': validationResults.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QaValidationResultImpl extends QaValidationResult {
  _QaValidationResultImpl({
    required int courseVersionId,
    required String courseTitle,
    required String version,
    required bool allPassed,
    required int passedCount,
    required int totalRules,
    required List<_i2.QaValidationRuleResult> validationResults,
  }) : super._(
         courseVersionId: courseVersionId,
         courseTitle: courseTitle,
         version: version,
         allPassed: allPassed,
         passedCount: passedCount,
         totalRules: totalRules,
         validationResults: validationResults,
       );

  /// Returns a shallow copy of this [QaValidationResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QaValidationResult copyWith({
    int? courseVersionId,
    String? courseTitle,
    String? version,
    bool? allPassed,
    int? passedCount,
    int? totalRules,
    List<_i2.QaValidationRuleResult>? validationResults,
  }) {
    return QaValidationResult(
      courseVersionId: courseVersionId ?? this.courseVersionId,
      courseTitle: courseTitle ?? this.courseTitle,
      version: version ?? this.version,
      allPassed: allPassed ?? this.allPassed,
      passedCount: passedCount ?? this.passedCount,
      totalRules: totalRules ?? this.totalRules,
      validationResults:
          validationResults ??
          this.validationResults.map((e0) => e0.copyWith()).toList(),
    );
  }
}
