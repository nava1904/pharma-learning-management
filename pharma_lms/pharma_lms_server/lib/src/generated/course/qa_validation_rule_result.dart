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

/// Single rule result from QA validation.
abstract class QaValidationRuleResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  QaValidationRuleResult._({
    required this.rule,
    required this.description,
    required this.passed,
    required this.detail,
  });

  factory QaValidationRuleResult({
    required String rule,
    required String description,
    required bool passed,
    required String detail,
  }) = _QaValidationRuleResultImpl;

  factory QaValidationRuleResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return QaValidationRuleResult(
      rule: jsonSerialization['rule'] as String,
      description: jsonSerialization['description'] as String,
      passed: _i1.BoolJsonExtension.fromJson(jsonSerialization['passed']),
      detail: jsonSerialization['detail'] as String,
    );
  }

  /// Rule name/identifier.
  String rule;

  /// Human-readable description of the rule.
  String description;

  /// Whether the rule passed.
  bool passed;

  /// Detail message (e.g., "3 module(s) found" or error message).
  String detail;

  /// Returns a shallow copy of this [QaValidationRuleResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QaValidationRuleResult copyWith({
    String? rule,
    String? description,
    bool? passed,
    String? detail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QaValidationRuleResult',
      'rule': rule,
      'description': description,
      'passed': passed,
      'detail': detail,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QaValidationRuleResult',
      'rule': rule,
      'description': description,
      'passed': passed,
      'detail': detail,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QaValidationRuleResultImpl extends QaValidationRuleResult {
  _QaValidationRuleResultImpl({
    required String rule,
    required String description,
    required bool passed,
    required String detail,
  }) : super._(
         rule: rule,
         description: description,
         passed: passed,
         detail: detail,
       );

  /// Returns a shallow copy of this [QaValidationRuleResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QaValidationRuleResult copyWith({
    String? rule,
    String? description,
    bool? passed,
    String? detail,
  }) {
    return QaValidationRuleResult(
      rule: rule ?? this.rule,
      description: description ?? this.description,
      passed: passed ?? this.passed,
      detail: detail ?? this.detail,
    );
  }
}
