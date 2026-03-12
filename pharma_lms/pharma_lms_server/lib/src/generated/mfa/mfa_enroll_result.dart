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

/// Result of enrollMfa - secret and otpauth URL for QR.
abstract class MfaEnrollResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MfaEnrollResult._({
    required this.secretBase32,
    required this.otpauthUrl,
  });

  factory MfaEnrollResult({
    required String secretBase32,
    required String otpauthUrl,
  }) = _MfaEnrollResultImpl;

  factory MfaEnrollResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return MfaEnrollResult(
      secretBase32: jsonSerialization['secretBase32'] as String,
      otpauthUrl: jsonSerialization['otpauthUrl'] as String,
    );
  }

  String secretBase32;

  String otpauthUrl;

  /// Returns a shallow copy of this [MfaEnrollResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MfaEnrollResult copyWith({
    String? secretBase32,
    String? otpauthUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MfaEnrollResult',
      'secretBase32': secretBase32,
      'otpauthUrl': otpauthUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MfaEnrollResult',
      'secretBase32': secretBase32,
      'otpauthUrl': otpauthUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MfaEnrollResultImpl extends MfaEnrollResult {
  _MfaEnrollResultImpl({
    required String secretBase32,
    required String otpauthUrl,
  }) : super._(
         secretBase32: secretBase32,
         otpauthUrl: otpauthUrl,
       );

  /// Returns a shallow copy of this [MfaEnrollResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MfaEnrollResult copyWith({
    String? secretBase32,
    String? otpauthUrl,
  }) {
    return MfaEnrollResult(
      secretBase32: secretBase32 ?? this.secretBase32,
      otpauthUrl: otpauthUrl ?? this.otpauthUrl,
    );
  }
}
