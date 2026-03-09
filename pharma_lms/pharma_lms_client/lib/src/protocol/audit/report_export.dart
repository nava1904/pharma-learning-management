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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Report export record for audit. FDA 21 CFR Part 11.
abstract class ReportExport implements _i1.SerializableModel {
  ReportExport._({
    this.id,
    required this.exportedById,
    this.exportedBy,
    required this.reportType,
    this.filterParamsJson,
    this.recordCount,
    this.fileHash,
    this.storageUrl,
    this.watermarkText,
    DateTime? exportedAt,
    this.expiresAt,
  }) : exportedAt = exportedAt ?? DateTime.now();

  factory ReportExport({
    int? id,
    required int exportedById,
    _i2.PharmaUser? exportedBy,
    required String reportType,
    String? filterParamsJson,
    int? recordCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    DateTime? exportedAt,
    DateTime? expiresAt,
  }) = _ReportExportImpl;

  factory ReportExport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportExport(
      id: jsonSerialization['id'] as int?,
      exportedById: jsonSerialization['exportedById'] as int,
      exportedBy: jsonSerialization['exportedBy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['exportedBy'],
            ),
      reportType: jsonSerialization['reportType'] as String,
      filterParamsJson: jsonSerialization['filterParamsJson'] as String?,
      recordCount: jsonSerialization['recordCount'] as int?,
      fileHash: jsonSerialization['fileHash'] as String?,
      storageUrl: jsonSerialization['storageUrl'] as String?,
      watermarkText: jsonSerialization['watermarkText'] as String?,
      exportedAt: jsonSerialization['exportedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['exportedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exportedById;

  /// Who exported.
  _i2.PharmaUser? exportedBy;

  /// Report type: compliance, training_matrix, audit_trail, certificate_list, inspection_package.
  String reportType;

  /// Filter params as JSON.
  String? filterParamsJson;

  /// Record count in export.
  int? recordCount;

  /// SHA-256 hash for tamper detection.
  String? fileHash;

  /// Storage URL.
  String? storageUrl;

  /// Watermark text.
  String? watermarkText;

  /// When exported.
  DateTime exportedAt;

  /// When export expires (if time-limited).
  DateTime? expiresAt;

  /// Returns a shallow copy of this [ReportExport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportExport copyWith({
    int? id,
    int? exportedById,
    _i2.PharmaUser? exportedBy,
    String? reportType,
    String? filterParamsJson,
    int? recordCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    DateTime? exportedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportExport',
      if (id != null) 'id': id,
      'exportedById': exportedById,
      if (exportedBy != null) 'exportedBy': exportedBy?.toJson(),
      'reportType': reportType,
      if (filterParamsJson != null) 'filterParamsJson': filterParamsJson,
      if (recordCount != null) 'recordCount': recordCount,
      if (fileHash != null) 'fileHash': fileHash,
      if (storageUrl != null) 'storageUrl': storageUrl,
      if (watermarkText != null) 'watermarkText': watermarkText,
      'exportedAt': exportedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportExportImpl extends ReportExport {
  _ReportExportImpl({
    int? id,
    required int exportedById,
    _i2.PharmaUser? exportedBy,
    required String reportType,
    String? filterParamsJson,
    int? recordCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    DateTime? exportedAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         exportedById: exportedById,
         exportedBy: exportedBy,
         reportType: reportType,
         filterParamsJson: filterParamsJson,
         recordCount: recordCount,
         fileHash: fileHash,
         storageUrl: storageUrl,
         watermarkText: watermarkText,
         exportedAt: exportedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [ReportExport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportExport copyWith({
    Object? id = _Undefined,
    int? exportedById,
    Object? exportedBy = _Undefined,
    String? reportType,
    Object? filterParamsJson = _Undefined,
    Object? recordCount = _Undefined,
    Object? fileHash = _Undefined,
    Object? storageUrl = _Undefined,
    Object? watermarkText = _Undefined,
    DateTime? exportedAt,
    Object? expiresAt = _Undefined,
  }) {
    return ReportExport(
      id: id is int? ? id : this.id,
      exportedById: exportedById ?? this.exportedById,
      exportedBy: exportedBy is _i2.PharmaUser?
          ? exportedBy
          : this.exportedBy?.copyWith(),
      reportType: reportType ?? this.reportType,
      filterParamsJson: filterParamsJson is String?
          ? filterParamsJson
          : this.filterParamsJson,
      recordCount: recordCount is int? ? recordCount : this.recordCount,
      fileHash: fileHash is String? ? fileHash : this.fileHash,
      storageUrl: storageUrl is String? ? storageUrl : this.storageUrl,
      watermarkText: watermarkText is String?
          ? watermarkText
          : this.watermarkText,
      exportedAt: exportedAt ?? this.exportedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
