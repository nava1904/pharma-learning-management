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
import '../shared/electronic_signature.dart' as _i2;
import 'package:pharma_lms_server/src/generated/protocol.dart' as _i3;

/// Result of e-signature integrity verification.
abstract class SignatureVerificationResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SignatureVerificationResult._({
    this.signature,
    bool? integrityViolation,
  }) : integrityViolation = integrityViolation ?? false;

  factory SignatureVerificationResult({
    _i2.ElectronicSignature? signature,
    bool? integrityViolation,
  }) = _SignatureVerificationResultImpl;

  factory SignatureVerificationResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SignatureVerificationResult(
      signature: jsonSerialization['signature'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.ElectronicSignature>(
              jsonSerialization['signature'],
            ),
      integrityViolation: jsonSerialization['integrityViolation'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['integrityViolation'],
            ),
    );
  }

  /// The signature (null if not found).
  _i2.ElectronicSignature? signature;

  /// True when HMAC mismatch - tampering detected.
  bool integrityViolation;

  /// Returns a shallow copy of this [SignatureVerificationResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SignatureVerificationResult copyWith({
    _i2.ElectronicSignature? signature,
    bool? integrityViolation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SignatureVerificationResult',
      if (signature != null) 'signature': signature?.toJson(),
      'integrityViolation': integrityViolation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SignatureVerificationResult',
      if (signature != null) 'signature': signature?.toJsonForProtocol(),
      'integrityViolation': integrityViolation,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SignatureVerificationResultImpl extends SignatureVerificationResult {
  _SignatureVerificationResultImpl({
    _i2.ElectronicSignature? signature,
    bool? integrityViolation,
  }) : super._(
         signature: signature,
         integrityViolation: integrityViolation,
       );

  /// Returns a shallow copy of this [SignatureVerificationResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SignatureVerificationResult copyWith({
    Object? signature = _Undefined,
    bool? integrityViolation,
  }) {
    return SignatureVerificationResult(
      signature: signature is _i2.ElectronicSignature?
          ? signature
          : this.signature?.copyWith(),
      integrityViolation: integrityViolation ?? this.integrityViolation,
    );
  }
}
