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

/// Unread message/comment counts across all messaging channels.
abstract class MessagingUnreadCounts implements _i1.SerializableModel {
  MessagingUnreadCounts._({
    required this.learnerTrainer,
    required this.qaReview,
    required this.total,
  });

  factory MessagingUnreadCounts({
    required int learnerTrainer,
    required int qaReview,
    required int total,
  }) = _MessagingUnreadCountsImpl;

  factory MessagingUnreadCounts.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MessagingUnreadCounts(
      learnerTrainer: jsonSerialization['learnerTrainer'] as int,
      qaReview: jsonSerialization['qaReview'] as int,
      total: jsonSerialization['total'] as int,
    );
  }

  int learnerTrainer;

  int qaReview;

  int total;

  /// Returns a shallow copy of this [MessagingUnreadCounts]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessagingUnreadCounts copyWith({
    int? learnerTrainer,
    int? qaReview,
    int? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessagingUnreadCounts',
      'learnerTrainer': learnerTrainer,
      'qaReview': qaReview,
      'total': total,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MessagingUnreadCountsImpl extends MessagingUnreadCounts {
  _MessagingUnreadCountsImpl({
    required int learnerTrainer,
    required int qaReview,
    required int total,
  }) : super._(
         learnerTrainer: learnerTrainer,
         qaReview: qaReview,
         total: total,
       );

  /// Returns a shallow copy of this [MessagingUnreadCounts]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessagingUnreadCounts copyWith({
    int? learnerTrainer,
    int? qaReview,
    int? total,
  }) {
    return MessagingUnreadCounts(
      learnerTrainer: learnerTrainer ?? this.learnerTrainer,
      qaReview: qaReview ?? this.qaReview,
      total: total ?? this.total,
    );
  }
}
