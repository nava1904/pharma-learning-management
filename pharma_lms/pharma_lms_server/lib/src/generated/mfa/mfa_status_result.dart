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

/// Result of getMfaStatus.
abstract class MfaStatusResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MfaStatusResult._({
    required this.mfaEnabled,
    this.enrolledAt,
  });

  factory MfaStatusResult({
    required bool mfaEnabled,
    DateTime? enrolledAt,
  }) = _MfaStatusResultImpl;

  factory MfaStatusResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return MfaStatusResult(
      mfaEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['mfaEnabled'],
      ),
      enrolledAt: jsonSerialization['enrolledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['enrolledAt']),
    );
  }

  bool mfaEnabled;

  DateTime? enrolledAt;

  /// Returns a shallow copy of this [MfaStatusResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MfaStatusResult copyWith({
    bool? mfaEnabled,
    DateTime? enrolledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MfaStatusResult',
      'mfaEnabled': mfaEnabled,
      if (enrolledAt != null) 'enrolledAt': enrolledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MfaStatusResult',
      'mfaEnabled': mfaEnabled,
      if (enrolledAt != null) 'enrolledAt': enrolledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MfaStatusResultImpl extends MfaStatusResult {
  _MfaStatusResultImpl({
    required bool mfaEnabled,
    DateTime? enrolledAt,
  }) : super._(
         mfaEnabled: mfaEnabled,
         enrolledAt: enrolledAt,
       );

  /// Returns a shallow copy of this [MfaStatusResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MfaStatusResult copyWith({
    bool? mfaEnabled,
    Object? enrolledAt = _Undefined,
  }) {
    return MfaStatusResult(
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      enrolledAt: enrolledAt is DateTime? ? enrolledAt : this.enrolledAt,
    );
  }
}
