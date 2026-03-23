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
import '../organization/role.dart' as _i3;
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Access Review window and per-user review record
abstract class AccessReview implements _i1.SerializableModel {
  AccessReview._({
    this.id,
    required this.windowId,
    required this.userId,
    this.user,
    required this.roleId,
    this.role,
    String? decision,
    this.justification,
    this.reviewedById,
    this.reviewedBy,
    this.reviewedAt,
    this.signedAt,
    this.signatureId,
    this.signature,
    required this.windowOpen,
    required this.windowClose,
    this.jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.migrationMarker,
  }) : decision = decision ?? 'PENDING',
       status = status ?? 'ACTIVE',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AccessReview({
    int? id,
    required int windowId,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    String? decision,
    String? justification,
    int? reviewedById,
    _i2.PharmaUser? reviewedBy,
    DateTime? reviewedAt,
    DateTime? signedAt,
    int? signatureId,
    _i4.ElectronicSignature? signature,
    required DateTime windowOpen,
    required DateTime windowClose,
    String? jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? migrationMarker,
  }) = _AccessReviewImpl;

  factory AccessReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessReview(
      id: jsonSerialization['id'] as int?,
      windowId: jsonSerialization['windowId'] as int,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      roleId: jsonSerialization['roleId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Role>(jsonSerialization['role']),
      decision: jsonSerialization['decision'] as String?,
      justification: jsonSerialization['justification'] as String?,
      reviewedById: jsonSerialization['reviewedById'] as int?,
      reviewedBy: jsonSerialization['reviewedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['reviewedBy'],
            ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      signedAt: jsonSerialization['signedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['signedAt']),
      signatureId: jsonSerialization['signatureId'] as int?,
      signature: jsonSerialization['signature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['signature'],
            ),
      windowOpen: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowOpen'],
      ),
      windowClose: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowClose'],
      ),
      jobId: jsonSerialization['jobId'] as String?,
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      migrationMarker: jsonSerialization['migrationMarker'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The review window (foreign key to AccessReviewWindow)
  int windowId;

  int userId;

  /// The user under review
  _i2.PharmaUser? user;

  int roleId;

  /// The role being reviewed
  _i3.Role? role;

  /// Review decision (APPROVED, REVOKED, PENDING)
  String decision;

  /// Justification for the decision
  String? justification;

  int? reviewedById;

  /// Reviewer (admin) who made the decision
  _i2.PharmaUser? reviewedBy;

  /// Timestamp when reviewed
  DateTime? reviewedAt;

  /// Timestamp when signed (if e-signed)
  DateTime? signedAt;

  int? signatureId;

  /// E-signature record (if signed)
  _i4.ElectronicSignature? signature;

  /// Review window open date
  DateTime windowOpen;

  /// Review window close date
  DateTime windowClose;

  /// Triggering job ID (for audit)
  String? jobId;

  /// Status (ACTIVE, CLOSED)
  String status;

  /// Audit fields
  DateTime createdAt;

  DateTime updatedAt;

  /// Temporary migration marker - remove after migration applied
  String? migrationMarker;

  /// Returns a shallow copy of this [AccessReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessReview copyWith({
    int? id,
    int? windowId,
    int? userId,
    _i2.PharmaUser? user,
    int? roleId,
    _i3.Role? role,
    String? decision,
    String? justification,
    int? reviewedById,
    _i2.PharmaUser? reviewedBy,
    DateTime? reviewedAt,
    DateTime? signedAt,
    int? signatureId,
    _i4.ElectronicSignature? signature,
    DateTime? windowOpen,
    DateTime? windowClose,
    String? jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? migrationMarker,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessReview',
      if (id != null) 'id': id,
      'windowId': windowId,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'roleId': roleId,
      if (role != null) 'role': role?.toJson(),
      'decision': decision,
      if (justification != null) 'justification': justification,
      if (reviewedById != null) 'reviewedById': reviewedById,
      if (reviewedBy != null) 'reviewedBy': reviewedBy?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (signedAt != null) 'signedAt': signedAt?.toJson(),
      if (signatureId != null) 'signatureId': signatureId,
      if (signature != null) 'signature': signature?.toJson(),
      'windowOpen': windowOpen.toJson(),
      'windowClose': windowClose.toJson(),
      if (jobId != null) 'jobId': jobId,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (migrationMarker != null) 'migrationMarker': migrationMarker,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessReviewImpl extends AccessReview {
  _AccessReviewImpl({
    int? id,
    required int windowId,
    required int userId,
    _i2.PharmaUser? user,
    required int roleId,
    _i3.Role? role,
    String? decision,
    String? justification,
    int? reviewedById,
    _i2.PharmaUser? reviewedBy,
    DateTime? reviewedAt,
    DateTime? signedAt,
    int? signatureId,
    _i4.ElectronicSignature? signature,
    required DateTime windowOpen,
    required DateTime windowClose,
    String? jobId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? migrationMarker,
  }) : super._(
         id: id,
         windowId: windowId,
         userId: userId,
         user: user,
         roleId: roleId,
         role: role,
         decision: decision,
         justification: justification,
         reviewedById: reviewedById,
         reviewedBy: reviewedBy,
         reviewedAt: reviewedAt,
         signedAt: signedAt,
         signatureId: signatureId,
         signature: signature,
         windowOpen: windowOpen,
         windowClose: windowClose,
         jobId: jobId,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
         migrationMarker: migrationMarker,
       );

  /// Returns a shallow copy of this [AccessReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessReview copyWith({
    Object? id = _Undefined,
    int? windowId,
    int? userId,
    Object? user = _Undefined,
    int? roleId,
    Object? role = _Undefined,
    String? decision,
    Object? justification = _Undefined,
    Object? reviewedById = _Undefined,
    Object? reviewedBy = _Undefined,
    Object? reviewedAt = _Undefined,
    Object? signedAt = _Undefined,
    Object? signatureId = _Undefined,
    Object? signature = _Undefined,
    DateTime? windowOpen,
    DateTime? windowClose,
    Object? jobId = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? migrationMarker = _Undefined,
  }) {
    return AccessReview(
      id: id is int? ? id : this.id,
      windowId: windowId ?? this.windowId,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      roleId: roleId ?? this.roleId,
      role: role is _i3.Role? ? role : this.role?.copyWith(),
      decision: decision ?? this.decision,
      justification: justification is String?
          ? justification
          : this.justification,
      reviewedById: reviewedById is int? ? reviewedById : this.reviewedById,
      reviewedBy: reviewedBy is _i2.PharmaUser?
          ? reviewedBy
          : this.reviewedBy?.copyWith(),
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      signedAt: signedAt is DateTime? ? signedAt : this.signedAt,
      signatureId: signatureId is int? ? signatureId : this.signatureId,
      signature: signature is _i4.ElectronicSignature?
          ? signature
          : this.signature?.copyWith(),
      windowOpen: windowOpen ?? this.windowOpen,
      windowClose: windowClose ?? this.windowClose,
      jobId: jobId is String? ? jobId : this.jobId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      migrationMarker: migrationMarker is String?
          ? migrationMarker
          : this.migrationMarker,
    );
  }
}
