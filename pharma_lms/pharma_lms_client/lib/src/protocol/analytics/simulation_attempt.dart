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

/// MSL / coaching simulation attempt (behavioral metrics as JSON).
abstract class SimulationAttempt implements _i1.SerializableModel {
  SimulationAttempt._({
    this.id,
    required this.userId,
    this.user,
    required this.scenarioTitle,
    this.scorePercent,
    this.metricsJson,
    DateTime? startedAt,
    this.completedAt,
  }) : startedAt = startedAt ?? DateTime.now();

  factory SimulationAttempt({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String scenarioTitle,
    double? scorePercent,
    String? metricsJson,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _SimulationAttemptImpl;

  factory SimulationAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SimulationAttempt(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      scenarioTitle: jsonSerialization['scenarioTitle'] as String,
      scorePercent: (jsonSerialization['scorePercent'] as num?)?.toDouble(),
      metricsJson: jsonSerialization['metricsJson'] as String?,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.PharmaUser? user;

  String scenarioTitle;

  double? scorePercent;

  String? metricsJson;

  DateTime startedAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [SimulationAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SimulationAttempt copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    String? scenarioTitle,
    double? scorePercent,
    String? metricsJson,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SimulationAttempt',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'scenarioTitle': scenarioTitle,
      if (scorePercent != null) 'scorePercent': scorePercent,
      if (metricsJson != null) 'metricsJson': metricsJson,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SimulationAttemptImpl extends SimulationAttempt {
  _SimulationAttemptImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required String scenarioTitle,
    double? scorePercent,
    String? metricsJson,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         scenarioTitle: scenarioTitle,
         scorePercent: scorePercent,
         metricsJson: metricsJson,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [SimulationAttempt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SimulationAttempt copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? scenarioTitle,
    Object? scorePercent = _Undefined,
    Object? metricsJson = _Undefined,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
  }) {
    return SimulationAttempt(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      scenarioTitle: scenarioTitle ?? this.scenarioTitle,
      scorePercent: scorePercent is double? ? scorePercent : this.scorePercent,
      metricsJson: metricsJson is String? ? metricsJson : this.metricsJson,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
