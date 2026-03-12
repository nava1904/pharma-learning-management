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
import '../document/document.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Versioned document for lifecycle control.
/// Plan 3B: versionMajor/versionMinor for major/minor versioning; isMajorVersion
/// controls whether transition to effective emits SOP_UPDATED (retraining).
abstract class DocumentVersion implements _i1.SerializableModel {
  DocumentVersion._({
    this.id,
    required this.documentId,
    this.document,
    required this.version,
    this.versionMajor,
    this.versionMinor,
    this.isMajorVersion,
    required this.storageKey,
    this.effectiveDate,
    this.obsoleteDate,
  });

  factory DocumentVersion({
    int? id,
    required int documentId,
    _i2.Document? document,
    required String version,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  }) = _DocumentVersionImpl;

  factory DocumentVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return DocumentVersion(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as int,
      document: jsonSerialization['document'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Document>(
              jsonSerialization['document'],
            ),
      version: jsonSerialization['version'] as String,
      versionMajor: jsonSerialization['versionMajor'] as int?,
      versionMinor: jsonSerialization['versionMinor'] as int?,
      isMajorVersion: jsonSerialization['isMajorVersion'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMajorVersion']),
      storageKey: jsonSerialization['storageKey'] as String,
      effectiveDate: jsonSerialization['effectiveDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['effectiveDate'],
            ),
      obsoleteDate: jsonSerialization['obsoleteDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['obsoleteDate'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int documentId;

  /// The document.
  _i2.Document? document;

  /// Version string (e.g. "1.0" or "2.3").
  String version;

  /// Major version number (1, 2, ...). Parsed from version or set on create.
  int? versionMajor;

  /// Minor version number (0, 1, ...). Parsed from version or set on create.
  int? versionMinor;

  /// If true, transition to effective emits SOP_UPDATED for retraining.
  bool? isMajorVersion;

  /// S3/MinIO storage key.
  String storageKey;

  /// When effective.
  DateTime? effectiveDate;

  /// When obsolete.
  DateTime? obsoleteDate;

  /// Returns a shallow copy of this [DocumentVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DocumentVersion copyWith({
    int? id,
    int? documentId,
    _i2.Document? document,
    String? version,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
    String? storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DocumentVersion',
      if (id != null) 'id': id,
      'documentId': documentId,
      if (document != null) 'document': document?.toJson(),
      'version': version,
      if (versionMajor != null) 'versionMajor': versionMajor,
      if (versionMinor != null) 'versionMinor': versionMinor,
      if (isMajorVersion != null) 'isMajorVersion': isMajorVersion,
      'storageKey': storageKey,
      if (effectiveDate != null) 'effectiveDate': effectiveDate?.toJson(),
      if (obsoleteDate != null) 'obsoleteDate': obsoleteDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentVersionImpl extends DocumentVersion {
  _DocumentVersionImpl({
    int? id,
    required int documentId,
    _i2.Document? document,
    required String version,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  }) : super._(
         id: id,
         documentId: documentId,
         document: document,
         version: version,
         versionMajor: versionMajor,
         versionMinor: versionMinor,
         isMajorVersion: isMajorVersion,
         storageKey: storageKey,
         effectiveDate: effectiveDate,
         obsoleteDate: obsoleteDate,
       );

  /// Returns a shallow copy of this [DocumentVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DocumentVersion copyWith({
    Object? id = _Undefined,
    int? documentId,
    Object? document = _Undefined,
    String? version,
    Object? versionMajor = _Undefined,
    Object? versionMinor = _Undefined,
    Object? isMajorVersion = _Undefined,
    String? storageKey,
    Object? effectiveDate = _Undefined,
    Object? obsoleteDate = _Undefined,
  }) {
    return DocumentVersion(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      document: document is _i2.Document?
          ? document
          : this.document?.copyWith(),
      version: version ?? this.version,
      versionMajor: versionMajor is int? ? versionMajor : this.versionMajor,
      versionMinor: versionMinor is int? ? versionMinor : this.versionMinor,
      isMajorVersion: isMajorVersion is bool?
          ? isMajorVersion
          : this.isMajorVersion,
      storageKey: storageKey ?? this.storageKey,
      effectiveDate: effectiveDate is DateTime?
          ? effectiveDate
          : this.effectiveDate,
      obsoleteDate: obsoleteDate is DateTime?
          ? obsoleteDate
          : this.obsoleteDate,
    );
  }
}
