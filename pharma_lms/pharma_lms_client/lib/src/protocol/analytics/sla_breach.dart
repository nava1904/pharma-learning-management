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
import '../analytics/sla_policy.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// SLA breach record.
abstract class SlaBreach implements _i1.SerializableModel {
  SlaBreach._({
    this.id,
    required this.slaPolicyId,
    this.slaPolicy,
    DateTime? breachedAt,
    this.resolvedAt,
  }) : breachedAt = breachedAt ?? DateTime.now();

  factory SlaBreach({
    int? id,
    required int slaPolicyId,
    _i2.SlaPolicy? slaPolicy,
    DateTime? breachedAt,
    DateTime? resolvedAt,
  }) = _SlaBreachImpl;

  factory SlaBreach.fromJson(Map<String, dynamic> jsonSerialization) {
    return SlaBreach(
      id: jsonSerialization['id'] as int?,
      slaPolicyId: jsonSerialization['slaPolicyId'] as int,
      slaPolicy: jsonSerialization['slaPolicy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.SlaPolicy>(
              jsonSerialization['slaPolicy'],
            ),
      breachedAt: jsonSerialization['breachedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['breachedAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int slaPolicyId;

  /// The SLA policy.
  _i2.SlaPolicy? slaPolicy;

  /// When breached.
  DateTime breachedAt;

  /// When resolved (null if open).
  DateTime? resolvedAt;

  /// Returns a shallow copy of this [SlaBreach]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SlaBreach copyWith({
    int? id,
    int? slaPolicyId,
    _i2.SlaPolicy? slaPolicy,
    DateTime? breachedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SlaBreach',
      if (id != null) 'id': id,
      'slaPolicyId': slaPolicyId,
      if (slaPolicy != null) 'slaPolicy': slaPolicy?.toJson(),
      'breachedAt': breachedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SlaBreachImpl extends SlaBreach {
  _SlaBreachImpl({
    int? id,
    required int slaPolicyId,
    _i2.SlaPolicy? slaPolicy,
    DateTime? breachedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         slaPolicyId: slaPolicyId,
         slaPolicy: slaPolicy,
         breachedAt: breachedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [SlaBreach]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SlaBreach copyWith({
    Object? id = _Undefined,
    int? slaPolicyId,
    Object? slaPolicy = _Undefined,
    DateTime? breachedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return SlaBreach(
      id: id is int? ? id : this.id,
      slaPolicyId: slaPolicyId ?? this.slaPolicyId,
      slaPolicy: slaPolicy is _i2.SlaPolicy?
          ? slaPolicy
          : this.slaPolicy?.copyWith(),
      breachedAt: breachedAt ?? this.breachedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
