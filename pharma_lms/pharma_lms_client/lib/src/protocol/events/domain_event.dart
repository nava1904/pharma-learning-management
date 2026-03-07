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

/// Domain event for event-driven workflows.
abstract class DomainEvent implements _i1.SerializableModel {
  DomainEvent._({
    this.id,
    required this.eventType,
    required this.aggregateId,
    required this.payloadJson,
    DateTime? createdAt,
    this.processedAt,
    this.kafkaOffset,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DomainEvent({
    int? id,
    required String eventType,
    required String aggregateId,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? processedAt,
    String? kafkaOffset,
  }) = _DomainEventImpl;

  factory DomainEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DomainEvent(
      id: jsonSerialization['id'] as int?,
      eventType: jsonSerialization['eventType'] as String,
      aggregateId: jsonSerialization['aggregateId'] as String,
      payloadJson: jsonSerialization['payloadJson'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processedAt'],
            ),
      kafkaOffset: jsonSerialization['kafkaOffset'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Event type.
  String eventType;

  /// Aggregate ID.
  String aggregateId;

  /// Payload as JSON.
  String payloadJson;

  /// When created.
  DateTime createdAt;

  /// When processed (null if pending).
  DateTime? processedAt;

  /// Kafka offset if published.
  String? kafkaOffset;

  /// Returns a shallow copy of this [DomainEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DomainEvent copyWith({
    int? id,
    String? eventType,
    String? aggregateId,
    String? payloadJson,
    DateTime? createdAt,
    DateTime? processedAt,
    String? kafkaOffset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DomainEvent',
      if (id != null) 'id': id,
      'eventType': eventType,
      'aggregateId': aggregateId,
      'payloadJson': payloadJson,
      'createdAt': createdAt.toJson(),
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
      if (kafkaOffset != null) 'kafkaOffset': kafkaOffset,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DomainEventImpl extends DomainEvent {
  _DomainEventImpl({
    int? id,
    required String eventType,
    required String aggregateId,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? processedAt,
    String? kafkaOffset,
  }) : super._(
         id: id,
         eventType: eventType,
         aggregateId: aggregateId,
         payloadJson: payloadJson,
         createdAt: createdAt,
         processedAt: processedAt,
         kafkaOffset: kafkaOffset,
       );

  /// Returns a shallow copy of this [DomainEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DomainEvent copyWith({
    Object? id = _Undefined,
    String? eventType,
    String? aggregateId,
    String? payloadJson,
    DateTime? createdAt,
    Object? processedAt = _Undefined,
    Object? kafkaOffset = _Undefined,
  }) {
    return DomainEvent(
      id: id is int? ? id : this.id,
      eventType: eventType ?? this.eventType,
      aggregateId: aggregateId ?? this.aggregateId,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
      kafkaOffset: kafkaOffset is String? ? kafkaOffset : this.kafkaOffset,
    );
  }
}
