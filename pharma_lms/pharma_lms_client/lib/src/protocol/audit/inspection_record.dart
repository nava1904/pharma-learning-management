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
import '../organization/site.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Inspection record for auditor access. FDA 21 CFR Part 11.
abstract class InspectionRecord implements _i1.SerializableModel {
  InspectionRecord._({
    this.id,
    required this.inspectionType,
    this.scheduledDate,
    this.inspectorNames,
    this.scopeDescription,
    this.siteId,
    this.site,
    String? status,
    this.inspectionAccessToken,
    this.tokenExpiresAt,
    this.briefingPackHash,
    this.briefingPackGeneratedAt,
    this.outcome,
    this.findingsCount,
    this.createdById,
    this.createdBy,
    DateTime? createdAt,
  }) : status = status ?? 'scheduled',
       createdAt = createdAt ?? DateTime.now();

  factory InspectionRecord({
    int? id,
    required String inspectionType,
    DateTime? scheduledDate,
    String? inspectorNames,
    String? scopeDescription,
    int? siteId,
    _i2.Site? site,
    String? status,
    String? inspectionAccessToken,
    DateTime? tokenExpiresAt,
    String? briefingPackHash,
    DateTime? briefingPackGeneratedAt,
    String? outcome,
    int? findingsCount,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) = _InspectionRecordImpl;

  factory InspectionRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return InspectionRecord(
      id: jsonSerialization['id'] as int?,
      inspectionType: jsonSerialization['inspectionType'] as String,
      scheduledDate: jsonSerialization['scheduledDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledDate'],
            ),
      inspectorNames: jsonSerialization['inspectorNames'] as String?,
      scopeDescription: jsonSerialization['scopeDescription'] as String?,
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Site>(jsonSerialization['site']),
      status: jsonSerialization['status'] as String?,
      inspectionAccessToken:
          jsonSerialization['inspectionAccessToken'] as String?,
      tokenExpiresAt: jsonSerialization['tokenExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['tokenExpiresAt'],
            ),
      briefingPackHash: jsonSerialization['briefingPackHash'] as String?,
      briefingPackGeneratedAt:
          jsonSerialization['briefingPackGeneratedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['briefingPackGeneratedAt'],
            ),
      outcome: jsonSerialization['outcome'] as String?,
      findingsCount: jsonSerialization['findingsCount'] as int?,
      createdById: jsonSerialization['createdById'] as int?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Inspection type: fda, ema, internal, customer.
  String inspectionType;

  /// Scheduled date.
  DateTime? scheduledDate;

  /// Inspector names.
  String? inspectorNames;

  /// Scope description.
  String? scopeDescription;

  int? siteId;

  /// Site in scope.
  _i2.Site? site;

  /// Status: scheduled, in_progress, completed, follow_up.
  String status;

  /// Time-limited access token for auditor.
  String? inspectionAccessToken;

  /// When token expires.
  DateTime? tokenExpiresAt;

  /// Briefing pack hash.
  String? briefingPackHash;

  /// When briefing pack was generated.
  DateTime? briefingPackGeneratedAt;

  /// Outcome: no_findings, observations, warning_letter.
  String? outcome;

  /// Findings count.
  int? findingsCount;

  int? createdById;

  /// Who created this record.
  _i3.PharmaUser? createdBy;

  /// When created.
  DateTime createdAt;

  /// Returns a shallow copy of this [InspectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InspectionRecord copyWith({
    int? id,
    String? inspectionType,
    DateTime? scheduledDate,
    String? inspectorNames,
    String? scopeDescription,
    int? siteId,
    _i2.Site? site,
    String? status,
    String? inspectionAccessToken,
    DateTime? tokenExpiresAt,
    String? briefingPackHash,
    DateTime? briefingPackGeneratedAt,
    String? outcome,
    int? findingsCount,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InspectionRecord',
      if (id != null) 'id': id,
      'inspectionType': inspectionType,
      if (scheduledDate != null) 'scheduledDate': scheduledDate?.toJson(),
      if (inspectorNames != null) 'inspectorNames': inspectorNames,
      if (scopeDescription != null) 'scopeDescription': scopeDescription,
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'status': status,
      if (inspectionAccessToken != null)
        'inspectionAccessToken': inspectionAccessToken,
      if (tokenExpiresAt != null) 'tokenExpiresAt': tokenExpiresAt?.toJson(),
      if (briefingPackHash != null) 'briefingPackHash': briefingPackHash,
      if (briefingPackGeneratedAt != null)
        'briefingPackGeneratedAt': briefingPackGeneratedAt?.toJson(),
      if (outcome != null) 'outcome': outcome,
      if (findingsCount != null) 'findingsCount': findingsCount,
      if (createdById != null) 'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InspectionRecordImpl extends InspectionRecord {
  _InspectionRecordImpl({
    int? id,
    required String inspectionType,
    DateTime? scheduledDate,
    String? inspectorNames,
    String? scopeDescription,
    int? siteId,
    _i2.Site? site,
    String? status,
    String? inspectionAccessToken,
    DateTime? tokenExpiresAt,
    String? briefingPackHash,
    DateTime? briefingPackGeneratedAt,
    String? outcome,
    int? findingsCount,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         inspectionType: inspectionType,
         scheduledDate: scheduledDate,
         inspectorNames: inspectorNames,
         scopeDescription: scopeDescription,
         siteId: siteId,
         site: site,
         status: status,
         inspectionAccessToken: inspectionAccessToken,
         tokenExpiresAt: tokenExpiresAt,
         briefingPackHash: briefingPackHash,
         briefingPackGeneratedAt: briefingPackGeneratedAt,
         outcome: outcome,
         findingsCount: findingsCount,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [InspectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InspectionRecord copyWith({
    Object? id = _Undefined,
    String? inspectionType,
    Object? scheduledDate = _Undefined,
    Object? inspectorNames = _Undefined,
    Object? scopeDescription = _Undefined,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    String? status,
    Object? inspectionAccessToken = _Undefined,
    Object? tokenExpiresAt = _Undefined,
    Object? briefingPackHash = _Undefined,
    Object? briefingPackGeneratedAt = _Undefined,
    Object? outcome = _Undefined,
    Object? findingsCount = _Undefined,
    Object? createdById = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
  }) {
    return InspectionRecord(
      id: id is int? ? id : this.id,
      inspectionType: inspectionType ?? this.inspectionType,
      scheduledDate: scheduledDate is DateTime?
          ? scheduledDate
          : this.scheduledDate,
      inspectorNames: inspectorNames is String?
          ? inspectorNames
          : this.inspectorNames,
      scopeDescription: scopeDescription is String?
          ? scopeDescription
          : this.scopeDescription,
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i2.Site? ? site : this.site?.copyWith(),
      status: status ?? this.status,
      inspectionAccessToken: inspectionAccessToken is String?
          ? inspectionAccessToken
          : this.inspectionAccessToken,
      tokenExpiresAt: tokenExpiresAt is DateTime?
          ? tokenExpiresAt
          : this.tokenExpiresAt,
      briefingPackHash: briefingPackHash is String?
          ? briefingPackHash
          : this.briefingPackHash,
      briefingPackGeneratedAt: briefingPackGeneratedAt is DateTime?
          ? briefingPackGeneratedAt
          : this.briefingPackGeneratedAt,
      outcome: outcome is String? ? outcome : this.outcome,
      findingsCount: findingsCount is int? ? findingsCount : this.findingsCount,
      createdById: createdById is int? ? createdById : this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
