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
import '../course/competency.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// User's achieved competency with expiry.
abstract class UserCompetency implements _i1.SerializableModel {
  UserCompetency._({
    this.id,
    required this.userId,
    this.user,
    required this.competencyId,
    this.competency,
    DateTime? achievedAt,
    this.expiresAt,
  }) : achievedAt = achievedAt ?? DateTime.now();

  factory UserCompetency({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int competencyId,
    _i3.Competency? competency,
    DateTime? achievedAt,
    DateTime? expiresAt,
  }) = _UserCompetencyImpl;

  factory UserCompetency.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserCompetency(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Competency>(
              jsonSerialization['competency'],
            ),
      achievedAt: jsonSerialization['achievedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user.
  _i2.PharmaUser? user;

  int competencyId;

  /// The competency.
  _i3.Competency? competency;

  /// When achieved.
  DateTime achievedAt;

  /// When it expires (if applicable).
  DateTime? expiresAt;

  /// Returns a shallow copy of this [UserCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserCompetency copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? competencyId,
    _i3.Competency? competency,
    DateTime? achievedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserCompetency',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
      'achievedAt': achievedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserCompetencyImpl extends UserCompetency {
  _UserCompetencyImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int competencyId,
    _i3.Competency? competency,
    DateTime? achievedAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         competencyId: competencyId,
         competency: competency,
         achievedAt: achievedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [UserCompetency]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserCompetency copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
    DateTime? achievedAt,
    Object? expiresAt = _Undefined,
  }) {
    return UserCompetency(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i3.Competency?
          ? competency
          : this.competency?.copyWith(),
      achievedAt: achievedAt ?? this.achievedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
