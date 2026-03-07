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
import '../document/document_version.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Approval workflow step for document version.
abstract class ApprovalWorkflow implements _i1.SerializableModel {
  ApprovalWorkflow._({
    this.id,
    required this.documentVersionId,
    this.documentVersion,
    required this.step,
    required this.approverId,
    this.approver,
    String? status,
    this.signedAt,
    this.esignatureId,
    this.esignature,
  }) : status = status ?? 'pending';

  factory ApprovalWorkflow({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required int step,
    required int approverId,
    _i3.PharmaUser? approver,
    String? status,
    DateTime? signedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) = _ApprovalWorkflowImpl;

  factory ApprovalWorkflow.fromJson(Map<String, dynamic> jsonSerialization) {
    return ApprovalWorkflow(
      id: jsonSerialization['id'] as int?,
      documentVersionId: jsonSerialization['documentVersionId'] as int,
      documentVersion: jsonSerialization['documentVersion'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.DocumentVersion>(
              jsonSerialization['documentVersion'],
            ),
      step: jsonSerialization['step'] as int,
      approverId: jsonSerialization['approverId'] as int,
      approver: jsonSerialization['approver'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['approver'],
            ),
      status: jsonSerialization['status'] as String?,
      signedAt: jsonSerialization['signedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['signedAt']),
      esignatureId: jsonSerialization['esignatureId'] as int?,
      esignature: jsonSerialization['esignature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['esignature'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int documentVersionId;

  /// The document version.
  _i2.DocumentVersion? documentVersion;

  /// Step number.
  int step;

  int approverId;

  /// Approver user.
  _i3.PharmaUser? approver;

  /// Status: pending, approved, rejected.
  String status;

  /// When signed.
  DateTime? signedAt;

  int? esignatureId;

  /// Electronic signature.
  _i4.ElectronicSignature? esignature;

  /// Returns a shallow copy of this [ApprovalWorkflow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ApprovalWorkflow copyWith({
    int? id,
    int? documentVersionId,
    _i2.DocumentVersion? documentVersion,
    int? step,
    int? approverId,
    _i3.PharmaUser? approver,
    String? status,
    DateTime? signedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ApprovalWorkflow',
      if (id != null) 'id': id,
      'documentVersionId': documentVersionId,
      if (documentVersion != null) 'documentVersion': documentVersion?.toJson(),
      'step': step,
      'approverId': approverId,
      if (approver != null) 'approver': approver?.toJson(),
      'status': status,
      if (signedAt != null) 'signedAt': signedAt?.toJson(),
      if (esignatureId != null) 'esignatureId': esignatureId,
      if (esignature != null) 'esignature': esignature?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ApprovalWorkflowImpl extends ApprovalWorkflow {
  _ApprovalWorkflowImpl({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required int step,
    required int approverId,
    _i3.PharmaUser? approver,
    String? status,
    DateTime? signedAt,
    int? esignatureId,
    _i4.ElectronicSignature? esignature,
  }) : super._(
         id: id,
         documentVersionId: documentVersionId,
         documentVersion: documentVersion,
         step: step,
         approverId: approverId,
         approver: approver,
         status: status,
         signedAt: signedAt,
         esignatureId: esignatureId,
         esignature: esignature,
       );

  /// Returns a shallow copy of this [ApprovalWorkflow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ApprovalWorkflow copyWith({
    Object? id = _Undefined,
    int? documentVersionId,
    Object? documentVersion = _Undefined,
    int? step,
    int? approverId,
    Object? approver = _Undefined,
    String? status,
    Object? signedAt = _Undefined,
    Object? esignatureId = _Undefined,
    Object? esignature = _Undefined,
  }) {
    return ApprovalWorkflow(
      id: id is int? ? id : this.id,
      documentVersionId: documentVersionId ?? this.documentVersionId,
      documentVersion: documentVersion is _i2.DocumentVersion?
          ? documentVersion
          : this.documentVersion?.copyWith(),
      step: step ?? this.step,
      approverId: approverId ?? this.approverId,
      approver: approver is _i3.PharmaUser?
          ? approver
          : this.approver?.copyWith(),
      status: status ?? this.status,
      signedAt: signedAt is DateTime? ? signedAt : this.signedAt,
      esignatureId: esignatureId is int? ? esignatureId : this.esignatureId,
      esignature: esignature is _i4.ElectronicSignature?
          ? esignature
          : this.esignature?.copyWith(),
    );
  }
}
