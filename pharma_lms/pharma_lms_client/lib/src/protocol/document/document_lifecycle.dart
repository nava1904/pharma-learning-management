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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Document lifecycle state tracking.
abstract class DocumentLifecycle implements _i1.SerializableModel {
  DocumentLifecycle._({
    this.id,
    required this.documentVersionId,
    this.documentVersion,
    required this.state,
    DateTime? changedAt,
    required this.changedById,
    this.changedBy,
  }) : changedAt = changedAt ?? DateTime.now();

  factory DocumentLifecycle({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required String state,
    DateTime? changedAt,
    required int changedById,
    _i3.PharmaUser? changedBy,
  }) = _DocumentLifecycleImpl;

  factory DocumentLifecycle.fromJson(Map<String, dynamic> jsonSerialization) {
    return DocumentLifecycle(
      id: jsonSerialization['id'] as int?,
      documentVersionId: jsonSerialization['documentVersionId'] as int,
      documentVersion: jsonSerialization['documentVersion'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.DocumentVersion>(
              jsonSerialization['documentVersion'],
            ),
      state: jsonSerialization['state'] as String,
      changedAt: jsonSerialization['changedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changedAt']),
      changedById: jsonSerialization['changedById'] as int,
      changedBy: jsonSerialization['changedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['changedBy'],
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

  /// State: draft, review, approved, effective, obsolete.
  String state;

  /// When changed.
  DateTime changedAt;

  int changedById;

  /// Who changed (user ID).
  _i3.PharmaUser? changedBy;

  /// Returns a shallow copy of this [DocumentLifecycle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DocumentLifecycle copyWith({
    int? id,
    int? documentVersionId,
    _i2.DocumentVersion? documentVersion,
    String? state,
    DateTime? changedAt,
    int? changedById,
    _i3.PharmaUser? changedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DocumentLifecycle',
      if (id != null) 'id': id,
      'documentVersionId': documentVersionId,
      if (documentVersion != null) 'documentVersion': documentVersion?.toJson(),
      'state': state,
      'changedAt': changedAt.toJson(),
      'changedById': changedById,
      if (changedBy != null) 'changedBy': changedBy?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentLifecycleImpl extends DocumentLifecycle {
  _DocumentLifecycleImpl({
    int? id,
    required int documentVersionId,
    _i2.DocumentVersion? documentVersion,
    required String state,
    DateTime? changedAt,
    required int changedById,
    _i3.PharmaUser? changedBy,
  }) : super._(
         id: id,
         documentVersionId: documentVersionId,
         documentVersion: documentVersion,
         state: state,
         changedAt: changedAt,
         changedById: changedById,
         changedBy: changedBy,
       );

  /// Returns a shallow copy of this [DocumentLifecycle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DocumentLifecycle copyWith({
    Object? id = _Undefined,
    int? documentVersionId,
    Object? documentVersion = _Undefined,
    String? state,
    DateTime? changedAt,
    int? changedById,
    Object? changedBy = _Undefined,
  }) {
    return DocumentLifecycle(
      id: id is int? ? id : this.id,
      documentVersionId: documentVersionId ?? this.documentVersionId,
      documentVersion: documentVersion is _i2.DocumentVersion?
          ? documentVersion
          : this.documentVersion?.copyWith(),
      state: state ?? this.state,
      changedAt: changedAt ?? this.changedAt,
      changedById: changedById ?? this.changedById,
      changedBy: changedBy is _i3.PharmaUser?
          ? changedBy
          : this.changedBy?.copyWith(),
    );
  }
}
