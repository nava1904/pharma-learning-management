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
import '../training/certificate.dart' as _i2;
import '../training/training_assignment.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Tracks certification expiry and renewal.
abstract class TrainingExpiration implements _i1.SerializableModel {
  TrainingExpiration._({
    this.id,
    required this.certificateId,
    this.certificate,
    required this.expiresAt,
    this.reminderSentAt,
    this.renewalAssignmentId,
    this.renewalAssignment,
  });

  factory TrainingExpiration({
    int? id,
    required int certificateId,
    _i2.Certificate? certificate,
    required DateTime expiresAt,
    DateTime? reminderSentAt,
    int? renewalAssignmentId,
    _i3.TrainingAssignment? renewalAssignment,
  }) = _TrainingExpirationImpl;

  factory TrainingExpiration.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingExpiration(
      id: jsonSerialization['id'] as int?,
      certificateId: jsonSerialization['certificateId'] as int,
      certificate: jsonSerialization['certificate'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Certificate>(
              jsonSerialization['certificate'],
            ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      reminderSentAt: jsonSerialization['reminderSentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['reminderSentAt'],
            ),
      renewalAssignmentId: jsonSerialization['renewalAssignmentId'] as int?,
      renewalAssignment: jsonSerialization['renewalAssignment'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.TrainingAssignment>(
              jsonSerialization['renewalAssignment'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int certificateId;

  /// The certificate.
  _i2.Certificate? certificate;

  /// When it expires.
  DateTime expiresAt;

  /// When reminder was sent.
  DateTime? reminderSentAt;

  int? renewalAssignmentId;

  /// Renewal assignment if created.
  _i3.TrainingAssignment? renewalAssignment;

  /// Returns a shallow copy of this [TrainingExpiration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingExpiration copyWith({
    int? id,
    int? certificateId,
    _i2.Certificate? certificate,
    DateTime? expiresAt,
    DateTime? reminderSentAt,
    int? renewalAssignmentId,
    _i3.TrainingAssignment? renewalAssignment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingExpiration',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      if (certificate != null) 'certificate': certificate?.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toJson(),
      if (renewalAssignmentId != null)
        'renewalAssignmentId': renewalAssignmentId,
      if (renewalAssignment != null)
        'renewalAssignment': renewalAssignment?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingExpirationImpl extends TrainingExpiration {
  _TrainingExpirationImpl({
    int? id,
    required int certificateId,
    _i2.Certificate? certificate,
    required DateTime expiresAt,
    DateTime? reminderSentAt,
    int? renewalAssignmentId,
    _i3.TrainingAssignment? renewalAssignment,
  }) : super._(
         id: id,
         certificateId: certificateId,
         certificate: certificate,
         expiresAt: expiresAt,
         reminderSentAt: reminderSentAt,
         renewalAssignmentId: renewalAssignmentId,
         renewalAssignment: renewalAssignment,
       );

  /// Returns a shallow copy of this [TrainingExpiration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingExpiration copyWith({
    Object? id = _Undefined,
    int? certificateId,
    Object? certificate = _Undefined,
    DateTime? expiresAt,
    Object? reminderSentAt = _Undefined,
    Object? renewalAssignmentId = _Undefined,
    Object? renewalAssignment = _Undefined,
  }) {
    return TrainingExpiration(
      id: id is int? ? id : this.id,
      certificateId: certificateId ?? this.certificateId,
      certificate: certificate is _i2.Certificate?
          ? certificate
          : this.certificate?.copyWith(),
      expiresAt: expiresAt ?? this.expiresAt,
      reminderSentAt: reminderSentAt is DateTime?
          ? reminderSentAt
          : this.reminderSentAt,
      renewalAssignmentId: renewalAssignmentId is int?
          ? renewalAssignmentId
          : this.renewalAssignmentId,
      renewalAssignment: renewalAssignment is _i3.TrainingAssignment?
          ? renewalAssignment
          : this.renewalAssignment?.copyWith(),
    );
  }
}
