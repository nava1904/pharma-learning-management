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

/// Configurable e-signature meaning for 21 CFR Part 11 compliance.
abstract class SignatureMeaning implements _i1.SerializableModel {
  SignatureMeaning._({
    this.id,
    required this.meaning,
    bool? isActive,
    int? orderIndex,
    this.applicableTo,
  }) : isActive = isActive ?? true,
       orderIndex = orderIndex ?? 0;

  factory SignatureMeaning({
    int? id,
    required String meaning,
    bool? isActive,
    int? orderIndex,
    String? applicableTo,
  }) = _SignatureMeaningImpl;

  factory SignatureMeaning.fromJson(Map<String, dynamic> jsonSerialization) {
    return SignatureMeaning(
      id: jsonSerialization['id'] as int?,
      meaning: jsonSerialization['meaning'] as String,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      applicableTo: jsonSerialization['applicableTo'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The meaning text (e.g., "I have read, understood, and agree to comply").
  String meaning;

  /// Whether this meaning is available for selection.
  bool isActive;

  /// Display order (lower = first).
  int orderIndex;

  /// Applicable to: training_completion, course_approval, capa_closure, document_acknowledgement.
  String? applicableTo;

  /// Returns a shallow copy of this [SignatureMeaning]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SignatureMeaning copyWith({
    int? id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
    String? applicableTo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SignatureMeaning',
      if (id != null) 'id': id,
      'meaning': meaning,
      'isActive': isActive,
      'orderIndex': orderIndex,
      if (applicableTo != null) 'applicableTo': applicableTo,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SignatureMeaningImpl extends SignatureMeaning {
  _SignatureMeaningImpl({
    int? id,
    required String meaning,
    bool? isActive,
    int? orderIndex,
    String? applicableTo,
  }) : super._(
         id: id,
         meaning: meaning,
         isActive: isActive,
         orderIndex: orderIndex,
         applicableTo: applicableTo,
       );

  /// Returns a shallow copy of this [SignatureMeaning]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SignatureMeaning copyWith({
    Object? id = _Undefined,
    String? meaning,
    bool? isActive,
    int? orderIndex,
    Object? applicableTo = _Undefined,
  }) {
    return SignatureMeaning(
      id: id is int? ? id : this.id,
      meaning: meaning ?? this.meaning,
      isActive: isActive ?? this.isActive,
      orderIndex: orderIndex ?? this.orderIndex,
      applicableTo: applicableTo is String? ? applicableTo : this.applicableTo,
    );
  }
}
