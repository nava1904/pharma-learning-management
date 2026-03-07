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
import '../organization/user.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Delegated authority (e.g., supervisor delegates to delegatee).
abstract class DelegatedAuthority implements _i1.SerializableModel {
  DelegatedAuthority._({
    this.id,
    required this.delegatorId,
    this.delegator,
    required this.delegateeId,
    this.delegatee,
    required this.scope,
    required this.expiresAt,
  });

  factory DelegatedAuthority({
    int? id,
    required int delegatorId,
    _i2.PharmaUser? delegator,
    required int delegateeId,
    _i2.PharmaUser? delegatee,
    required String scope,
    required DateTime expiresAt,
  }) = _DelegatedAuthorityImpl;

  factory DelegatedAuthority.fromJson(Map<String, dynamic> jsonSerialization) {
    return DelegatedAuthority(
      id: jsonSerialization['id'] as int?,
      delegatorId: jsonSerialization['delegatorId'] as int,
      delegator: jsonSerialization['delegator'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['delegator'],
            ),
      delegateeId: jsonSerialization['delegateeId'] as int,
      delegatee: jsonSerialization['delegatee'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['delegatee'],
            ),
      scope: jsonSerialization['scope'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int delegatorId;

  /// Delegator user.
  _i2.PharmaUser? delegator;

  int delegateeId;

  /// Delegatee user.
  _i2.PharmaUser? delegatee;

  /// Scope of delegation.
  String scope;

  /// When it expires.
  DateTime expiresAt;

  /// Returns a shallow copy of this [DelegatedAuthority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DelegatedAuthority copyWith({
    int? id,
    int? delegatorId,
    _i2.PharmaUser? delegator,
    int? delegateeId,
    _i2.PharmaUser? delegatee,
    String? scope,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DelegatedAuthority',
      if (id != null) 'id': id,
      'delegatorId': delegatorId,
      if (delegator != null) 'delegator': delegator?.toJson(),
      'delegateeId': delegateeId,
      if (delegatee != null) 'delegatee': delegatee?.toJson(),
      'scope': scope,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DelegatedAuthorityImpl extends DelegatedAuthority {
  _DelegatedAuthorityImpl({
    int? id,
    required int delegatorId,
    _i2.PharmaUser? delegator,
    required int delegateeId,
    _i2.PharmaUser? delegatee,
    required String scope,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         delegatorId: delegatorId,
         delegator: delegator,
         delegateeId: delegateeId,
         delegatee: delegatee,
         scope: scope,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [DelegatedAuthority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DelegatedAuthority copyWith({
    Object? id = _Undefined,
    int? delegatorId,
    Object? delegator = _Undefined,
    int? delegateeId,
    Object? delegatee = _Undefined,
    String? scope,
    DateTime? expiresAt,
  }) {
    return DelegatedAuthority(
      id: id is int? ? id : this.id,
      delegatorId: delegatorId ?? this.delegatorId,
      delegator: delegator is _i2.PharmaUser?
          ? delegator
          : this.delegator?.copyWith(),
      delegateeId: delegateeId ?? this.delegateeId,
      delegatee: delegatee is _i2.PharmaUser?
          ? delegatee
          : this.delegatee?.copyWith(),
      scope: scope ?? this.scope,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
