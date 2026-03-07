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

/// Outbox pattern for reliable event publishing.
abstract class OutboxMessage implements _i1.SerializableModel {
  OutboxMessage._({
    this.id,
    required this.topic,
    required this.payloadJson,
    DateTime? createdAt,
    this.sentAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OutboxMessage({
    int? id,
    required String topic,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? sentAt,
  }) = _OutboxMessageImpl;

  factory OutboxMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return OutboxMessage(
      id: jsonSerialization['id'] as int?,
      topic: jsonSerialization['topic'] as String,
      payloadJson: jsonSerialization['payloadJson'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Kafka topic.
  String topic;

  /// Payload as JSON.
  String payloadJson;

  /// When created.
  DateTime createdAt;

  /// When sent (null if pending).
  DateTime? sentAt;

  /// Returns a shallow copy of this [OutboxMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OutboxMessage copyWith({
    int? id,
    String? topic,
    String? payloadJson,
    DateTime? createdAt,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OutboxMessage',
      if (id != null) 'id': id,
      'topic': topic,
      'payloadJson': payloadJson,
      'createdAt': createdAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OutboxMessageImpl extends OutboxMessage {
  _OutboxMessageImpl({
    int? id,
    required String topic,
    required String payloadJson,
    DateTime? createdAt,
    DateTime? sentAt,
  }) : super._(
         id: id,
         topic: topic,
         payloadJson: payloadJson,
         createdAt: createdAt,
         sentAt: sentAt,
       );

  /// Returns a shallow copy of this [OutboxMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OutboxMessage copyWith({
    Object? id = _Undefined,
    String? topic,
    String? payloadJson,
    DateTime? createdAt,
    Object? sentAt = _Undefined,
  }) {
    return OutboxMessage(
      id: id is int? ? id : this.id,
      topic: topic ?? this.topic,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
    );
  }
}
