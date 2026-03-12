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

/// Real-time analytics event for streaming to dashboards.
/// Not persisted - used for Serverpod Stream push.
abstract class AnalyticsEvent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AnalyticsEvent._({
    required this.channel,
    required this.eventType,
    required this.payloadJson,
    required this.occurredAt,
  });

  factory AnalyticsEvent({
    required String channel,
    required String eventType,
    required String payloadJson,
    required DateTime occurredAt,
  }) = _AnalyticsEventImpl;

  factory AnalyticsEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsEvent(
      channel: jsonSerialization['channel'] as String,
      eventType: jsonSerialization['eventType'] as String,
      payloadJson: jsonSerialization['payloadJson'] as String,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  /// Channel this event is for.
  String channel;

  /// Event type: compliance_update, overdue_count, cert_expiry, course_pass_rate, audit_readiness.
  String eventType;

  /// Payload as JSON (flexible for different metric types).
  String payloadJson;

  /// When the event occurred.
  DateTime occurredAt;

  /// Returns a shallow copy of this [AnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalyticsEvent copyWith({
    String? channel,
    String? eventType,
    String? payloadJson,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsEvent',
      'channel': channel,
      'eventType': eventType,
      'payloadJson': payloadJson,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalyticsEvent',
      'channel': channel,
      'eventType': eventType,
      'payloadJson': payloadJson,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AnalyticsEventImpl extends AnalyticsEvent {
  _AnalyticsEventImpl({
    required String channel,
    required String eventType,
    required String payloadJson,
    required DateTime occurredAt,
  }) : super._(
         channel: channel,
         eventType: eventType,
         payloadJson: payloadJson,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [AnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnalyticsEvent copyWith({
    String? channel,
    String? eventType,
    String? payloadJson,
    DateTime? occurredAt,
  }) {
    return AnalyticsEvent(
      channel: channel ?? this.channel,
      eventType: eventType ?? this.eventType,
      payloadJson: payloadJson ?? this.payloadJson,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}
