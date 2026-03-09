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

/// Dead letter queue for failed event publishing. Enterprise.
abstract class DeadLetterQueue implements _i1.SerializableModel {
  DeadLetterQueue._({
    this.id,
    this.outboxMessageId,
    DateTime? failedAt,
    this.failureReason,
    int? retryCount,
    bool? manuallyResolved,
    this.resolvedById,
    this.resolvedAt,
    this.resolutionNotes,
  }) : failedAt = failedAt ?? DateTime.now(),
       retryCount = retryCount ?? 0,
       manuallyResolved = manuallyResolved ?? false;

  factory DeadLetterQueue({
    int? id,
    int? outboxMessageId,
    DateTime? failedAt,
    String? failureReason,
    int? retryCount,
    bool? manuallyResolved,
    int? resolvedById,
    DateTime? resolvedAt,
    String? resolutionNotes,
  }) = _DeadLetterQueueImpl;

  factory DeadLetterQueue.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeadLetterQueue(
      id: jsonSerialization['id'] as int?,
      outboxMessageId: jsonSerialization['outboxMessageId'] as int?,
      failedAt: jsonSerialization['failedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['failedAt']),
      failureReason: jsonSerialization['failureReason'] as String?,
      retryCount: jsonSerialization['retryCount'] as int?,
      manuallyResolved: jsonSerialization['manuallyResolved'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['manuallyResolved'],
            ),
      resolvedById: jsonSerialization['resolvedById'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      resolutionNotes: jsonSerialization['resolutionNotes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The outbox message that failed.
  int? outboxMessageId;

  /// When it failed.
  DateTime failedAt;

  /// Failure reason.
  String? failureReason;

  /// Retry count before moving to DLQ.
  int retryCount;

  /// Whether manually resolved.
  bool manuallyResolved;

  /// Who resolved (if manual).
  int? resolvedById;

  /// When resolved.
  DateTime? resolvedAt;

  /// Resolution notes.
  String? resolutionNotes;

  /// Returns a shallow copy of this [DeadLetterQueue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeadLetterQueue copyWith({
    int? id,
    int? outboxMessageId,
    DateTime? failedAt,
    String? failureReason,
    int? retryCount,
    bool? manuallyResolved,
    int? resolvedById,
    DateTime? resolvedAt,
    String? resolutionNotes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeadLetterQueue',
      if (id != null) 'id': id,
      if (outboxMessageId != null) 'outboxMessageId': outboxMessageId,
      'failedAt': failedAt.toJson(),
      if (failureReason != null) 'failureReason': failureReason,
      'retryCount': retryCount,
      'manuallyResolved': manuallyResolved,
      if (resolvedById != null) 'resolvedById': resolvedById,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolutionNotes != null) 'resolutionNotes': resolutionNotes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeadLetterQueueImpl extends DeadLetterQueue {
  _DeadLetterQueueImpl({
    int? id,
    int? outboxMessageId,
    DateTime? failedAt,
    String? failureReason,
    int? retryCount,
    bool? manuallyResolved,
    int? resolvedById,
    DateTime? resolvedAt,
    String? resolutionNotes,
  }) : super._(
         id: id,
         outboxMessageId: outboxMessageId,
         failedAt: failedAt,
         failureReason: failureReason,
         retryCount: retryCount,
         manuallyResolved: manuallyResolved,
         resolvedById: resolvedById,
         resolvedAt: resolvedAt,
         resolutionNotes: resolutionNotes,
       );

  /// Returns a shallow copy of this [DeadLetterQueue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeadLetterQueue copyWith({
    Object? id = _Undefined,
    Object? outboxMessageId = _Undefined,
    DateTime? failedAt,
    Object? failureReason = _Undefined,
    int? retryCount,
    bool? manuallyResolved,
    Object? resolvedById = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? resolutionNotes = _Undefined,
  }) {
    return DeadLetterQueue(
      id: id is int? ? id : this.id,
      outboxMessageId: outboxMessageId is int?
          ? outboxMessageId
          : this.outboxMessageId,
      failedAt: failedAt ?? this.failedAt,
      failureReason: failureReason is String?
          ? failureReason
          : this.failureReason,
      retryCount: retryCount ?? this.retryCount,
      manuallyResolved: manuallyResolved ?? this.manuallyResolved,
      resolvedById: resolvedById is int? ? resolvedById : this.resolvedById,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      resolutionNotes: resolutionNotes is String?
          ? resolutionNotes
          : this.resolutionNotes,
    );
  }
}
