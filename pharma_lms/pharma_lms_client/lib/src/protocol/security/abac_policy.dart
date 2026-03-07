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

/// ABAC policy for attribute-based access control.
abstract class AbacPolicy implements _i1.SerializableModel {
  AbacPolicy._({
    this.id,
    required this.name,
    required this.ruleJson,
    required this.effect,
  });

  factory AbacPolicy({
    int? id,
    required String name,
    required String ruleJson,
    required String effect,
  }) = _AbacPolicyImpl;

  factory AbacPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return AbacPolicy(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      ruleJson: jsonSerialization['ruleJson'] as String,
      effect: jsonSerialization['effect'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Policy name.
  String name;

  /// Rule as JSON.
  String ruleJson;

  /// Effect: allow, deny.
  String effect;

  /// Returns a shallow copy of this [AbacPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AbacPolicy copyWith({
    int? id,
    String? name,
    String? ruleJson,
    String? effect,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AbacPolicy',
      if (id != null) 'id': id,
      'name': name,
      'ruleJson': ruleJson,
      'effect': effect,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AbacPolicyImpl extends AbacPolicy {
  _AbacPolicyImpl({
    int? id,
    required String name,
    required String ruleJson,
    required String effect,
  }) : super._(
         id: id,
         name: name,
         ruleJson: ruleJson,
         effect: effect,
       );

  /// Returns a shallow copy of this [AbacPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AbacPolicy copyWith({
    Object? id = _Undefined,
    String? name,
    String? ruleJson,
    String? effect,
  }) {
    return AbacPolicy(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      ruleJson: ruleJson ?? this.ruleJson,
      effect: effect ?? this.effect,
    );
  }
}
