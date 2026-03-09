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
import '../audit/inspection_record.dart' as _i2;
import '../organization/user.dart' as _i3;
import '../shared/electronic_signature.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Inspection package - compliance evidence bundle. FDA.
abstract class InspectionPackage implements _i1.SerializableModel {
  InspectionPackage._({
    this.id,
    required this.inspectionRecordId,
    this.inspectionRecord,
    required this.generatedById,
    this.generatedBy,
    DateTime? generatedAt,
    this.scopeDescription,
    this.includedRecordsCount,
    this.fileHash,
    this.storageUrl,
    this.watermarkText,
    bool? isOfficial,
    this.officialEsignatureId,
    this.officialEsignature,
  }) : generatedAt = generatedAt ?? DateTime.now(),
       isOfficial = isOfficial ?? false;

  factory InspectionPackage({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    required int generatedById,
    _i3.PharmaUser? generatedBy,
    DateTime? generatedAt,
    String? scopeDescription,
    int? includedRecordsCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    bool? isOfficial,
    int? officialEsignatureId,
    _i4.ElectronicSignature? officialEsignature,
  }) = _InspectionPackageImpl;

  factory InspectionPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return InspectionPackage(
      id: jsonSerialization['id'] as int?,
      inspectionRecordId: jsonSerialization['inspectionRecordId'] as int,
      inspectionRecord: jsonSerialization['inspectionRecord'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.InspectionRecord>(
              jsonSerialization['inspectionRecord'],
            ),
      generatedById: jsonSerialization['generatedById'] as int,
      generatedBy: jsonSerialization['generatedBy'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['generatedBy'],
            ),
      generatedAt: jsonSerialization['generatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['generatedAt'],
            ),
      scopeDescription: jsonSerialization['scopeDescription'] as String?,
      includedRecordsCount: jsonSerialization['includedRecordsCount'] as int?,
      fileHash: jsonSerialization['fileHash'] as String?,
      storageUrl: jsonSerialization['storageUrl'] as String?,
      watermarkText: jsonSerialization['watermarkText'] as String?,
      isOfficial: jsonSerialization['isOfficial'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isOfficial']),
      officialEsignatureId: jsonSerialization['officialEsignatureId'] as int?,
      officialEsignature: jsonSerialization['officialEsignature'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ElectronicSignature>(
              jsonSerialization['officialEsignature'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int inspectionRecordId;

  /// The inspection record.
  _i2.InspectionRecord? inspectionRecord;

  int generatedById;

  /// Who generated the package.
  _i3.PharmaUser? generatedBy;

  /// When generated.
  DateTime generatedAt;

  /// Scope description.
  String? scopeDescription;

  /// Included records count.
  int? includedRecordsCount;

  /// SHA-256 file hash.
  String? fileHash;

  /// Storage URL.
  String? storageUrl;

  /// Watermark text.
  String? watermarkText;

  /// Whether officially signed by QA Director.
  bool isOfficial;

  int? officialEsignatureId;

  /// Official e-signature.
  _i4.ElectronicSignature? officialEsignature;

  /// Returns a shallow copy of this [InspectionPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InspectionPackage copyWith({
    int? id,
    int? inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? generatedById,
    _i3.PharmaUser? generatedBy,
    DateTime? generatedAt,
    String? scopeDescription,
    int? includedRecordsCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    bool? isOfficial,
    int? officialEsignatureId,
    _i4.ElectronicSignature? officialEsignature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InspectionPackage',
      if (id != null) 'id': id,
      'inspectionRecordId': inspectionRecordId,
      if (inspectionRecord != null)
        'inspectionRecord': inspectionRecord?.toJson(),
      'generatedById': generatedById,
      if (generatedBy != null) 'generatedBy': generatedBy?.toJson(),
      'generatedAt': generatedAt.toJson(),
      if (scopeDescription != null) 'scopeDescription': scopeDescription,
      if (includedRecordsCount != null)
        'includedRecordsCount': includedRecordsCount,
      if (fileHash != null) 'fileHash': fileHash,
      if (storageUrl != null) 'storageUrl': storageUrl,
      if (watermarkText != null) 'watermarkText': watermarkText,
      'isOfficial': isOfficial,
      if (officialEsignatureId != null)
        'officialEsignatureId': officialEsignatureId,
      if (officialEsignature != null)
        'officialEsignature': officialEsignature?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InspectionPackageImpl extends InspectionPackage {
  _InspectionPackageImpl({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    required int generatedById,
    _i3.PharmaUser? generatedBy,
    DateTime? generatedAt,
    String? scopeDescription,
    int? includedRecordsCount,
    String? fileHash,
    String? storageUrl,
    String? watermarkText,
    bool? isOfficial,
    int? officialEsignatureId,
    _i4.ElectronicSignature? officialEsignature,
  }) : super._(
         id: id,
         inspectionRecordId: inspectionRecordId,
         inspectionRecord: inspectionRecord,
         generatedById: generatedById,
         generatedBy: generatedBy,
         generatedAt: generatedAt,
         scopeDescription: scopeDescription,
         includedRecordsCount: includedRecordsCount,
         fileHash: fileHash,
         storageUrl: storageUrl,
         watermarkText: watermarkText,
         isOfficial: isOfficial,
         officialEsignatureId: officialEsignatureId,
         officialEsignature: officialEsignature,
       );

  /// Returns a shallow copy of this [InspectionPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InspectionPackage copyWith({
    Object? id = _Undefined,
    int? inspectionRecordId,
    Object? inspectionRecord = _Undefined,
    int? generatedById,
    Object? generatedBy = _Undefined,
    DateTime? generatedAt,
    Object? scopeDescription = _Undefined,
    Object? includedRecordsCount = _Undefined,
    Object? fileHash = _Undefined,
    Object? storageUrl = _Undefined,
    Object? watermarkText = _Undefined,
    bool? isOfficial,
    Object? officialEsignatureId = _Undefined,
    Object? officialEsignature = _Undefined,
  }) {
    return InspectionPackage(
      id: id is int? ? id : this.id,
      inspectionRecordId: inspectionRecordId ?? this.inspectionRecordId,
      inspectionRecord: inspectionRecord is _i2.InspectionRecord?
          ? inspectionRecord
          : this.inspectionRecord?.copyWith(),
      generatedById: generatedById ?? this.generatedById,
      generatedBy: generatedBy is _i3.PharmaUser?
          ? generatedBy
          : this.generatedBy?.copyWith(),
      generatedAt: generatedAt ?? this.generatedAt,
      scopeDescription: scopeDescription is String?
          ? scopeDescription
          : this.scopeDescription,
      includedRecordsCount: includedRecordsCount is int?
          ? includedRecordsCount
          : this.includedRecordsCount,
      fileHash: fileHash is String? ? fileHash : this.fileHash,
      storageUrl: storageUrl is String? ? storageUrl : this.storageUrl,
      watermarkText: watermarkText is String?
          ? watermarkText
          : this.watermarkText,
      isOfficial: isOfficial ?? this.isOfficial,
      officialEsignatureId: officialEsignatureId is int?
          ? officialEsignatureId
          : this.officialEsignatureId,
      officialEsignature: officialEsignature is _i4.ElectronicSignature?
          ? officialEsignature
          : this.officialEsignature?.copyWith(),
    );
  }
}
