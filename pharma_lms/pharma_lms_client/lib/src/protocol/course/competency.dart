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

/// Competency/skill definition.
abstract class Competency implements _i1.SerializableModel {
  Competency._({
    this.id,
    required this.name,
    required this.code,
    this.level,
  });

  factory Competency({
    int? id,
    required String name,
    required String code,
    int? level,
  }) = _CompetencyImpl;

  factory Competency.fromJson(Map<String, dynamic> jsonSerialization) {
    return Competency(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      level: jsonSerialization['level'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Competency name.
  String name;

  /// Unique code.
  String code;

  /// Level (1, 2, 3, etc.).
  int? level;

  /// Returns a shallow copy of this [Competency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Competency copyWith({
    int? id,
    String? name,
    String? code,
    int? level,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Competency',
      if (id != null) 'id': id,
      'name': name,
      'code': code,
      if (level != null) 'level': level,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompetencyImpl extends Competency {
  _CompetencyImpl({
    int? id,
    required String name,
    required String code,
    int? level,
  }) : super._(
         id: id,
         name: name,
         code: code,
         level: level,
       );

  /// Returns a shallow copy of this [Competency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Competency copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    Object? level = _Undefined,
  }) {
    return Competency(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      level: level is int? ? level : this.level,
    );
  }
}
