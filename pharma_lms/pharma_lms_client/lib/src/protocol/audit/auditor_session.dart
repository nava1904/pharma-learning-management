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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Auditor session for time-limited read-only access. FDA 21 CFR Part 11.
abstract class AuditorSession implements _i1.SerializableModel {
  AuditorSession._({
    this.id,
    required this.inspectionRecordId,
    this.inspectionRecord,
    this.auditorUserId,
    this.auditorUser,
    required this.accessType,
    this.accessToken,
    this.tokenIssuedAt,
    this.tokenExpiresAt,
    this.scopeStartDate,
    this.scopeEndDate,
    this.scopeSitesJson,
    this.scopeDepartmentsJson,
    bool? isActive,
    this.endedAt,
    this.endedReason,
    int? pagesViewedCount,
    this.lastActivityAt,
  }) : isActive = isActive ?? true,
       pagesViewedCount = pagesViewedCount ?? 0;

  factory AuditorSession({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? auditorUserId,
    _i3.PharmaUser? auditorUser,
    required String accessType,
    String? accessToken,
    DateTime? tokenIssuedAt,
    DateTime? tokenExpiresAt,
    DateTime? scopeStartDate,
    DateTime? scopeEndDate,
    String? scopeSitesJson,
    String? scopeDepartmentsJson,
    bool? isActive,
    DateTime? endedAt,
    String? endedReason,
    int? pagesViewedCount,
    DateTime? lastActivityAt,
  }) = _AuditorSessionImpl;

  factory AuditorSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditorSession(
      id: jsonSerialization['id'] as int?,
      inspectionRecordId: jsonSerialization['inspectionRecordId'] as int,
      inspectionRecord: jsonSerialization['inspectionRecord'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.InspectionRecord>(
              jsonSerialization['inspectionRecord'],
            ),
      auditorUserId: jsonSerialization['auditorUserId'] as int?,
      auditorUser: jsonSerialization['auditorUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['auditorUser'],
            ),
      accessType: jsonSerialization['accessType'] as String,
      accessToken: jsonSerialization['accessToken'] as String?,
      tokenIssuedAt: jsonSerialization['tokenIssuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['tokenIssuedAt'],
            ),
      tokenExpiresAt: jsonSerialization['tokenExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['tokenExpiresAt'],
            ),
      scopeStartDate: jsonSerialization['scopeStartDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scopeStartDate'],
            ),
      scopeEndDate: jsonSerialization['scopeEndDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scopeEndDate'],
            ),
      scopeSitesJson: jsonSerialization['scopeSitesJson'] as String?,
      scopeDepartmentsJson:
          jsonSerialization['scopeDepartmentsJson'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      endedReason: jsonSerialization['endedReason'] as String?,
      pagesViewedCount: jsonSerialization['pagesViewedCount'] as int?,
      lastActivityAt: jsonSerialization['lastActivityAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActivityAt'],
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

  int? auditorUserId;

  /// Auditor user.
  _i3.PharmaUser? auditorUser;

  /// Access type: internal, external_fda, external_ema, customer.
  String accessType;

  /// Hashed access token.
  String? accessToken;

  /// When token was issued.
  DateTime? tokenIssuedAt;

  /// When token expires.
  DateTime? tokenExpiresAt;

  /// Scope start date.
  DateTime? scopeStartDate;

  /// Scope end date.
  DateTime? scopeEndDate;

  /// Scope sites as JSON array.
  String? scopeSitesJson;

  /// Scope departments as JSON array.
  String? scopeDepartmentsJson;

  /// Whether session is active.
  bool isActive;

  /// When session ended.
  DateTime? endedAt;

  /// End reason: expired, manual_revoke, completed.
  String? endedReason;

  /// Pages viewed count.
  int pagesViewedCount;

  /// Last activity timestamp.
  DateTime? lastActivityAt;

  /// Returns a shallow copy of this [AuditorSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditorSession copyWith({
    int? id,
    int? inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? auditorUserId,
    _i3.PharmaUser? auditorUser,
    String? accessType,
    String? accessToken,
    DateTime? tokenIssuedAt,
    DateTime? tokenExpiresAt,
    DateTime? scopeStartDate,
    DateTime? scopeEndDate,
    String? scopeSitesJson,
    String? scopeDepartmentsJson,
    bool? isActive,
    DateTime? endedAt,
    String? endedReason,
    int? pagesViewedCount,
    DateTime? lastActivityAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditorSession',
      if (id != null) 'id': id,
      'inspectionRecordId': inspectionRecordId,
      if (inspectionRecord != null)
        'inspectionRecord': inspectionRecord?.toJson(),
      if (auditorUserId != null) 'auditorUserId': auditorUserId,
      if (auditorUser != null) 'auditorUser': auditorUser?.toJson(),
      'accessType': accessType,
      if (accessToken != null) 'accessToken': accessToken,
      if (tokenIssuedAt != null) 'tokenIssuedAt': tokenIssuedAt?.toJson(),
      if (tokenExpiresAt != null) 'tokenExpiresAt': tokenExpiresAt?.toJson(),
      if (scopeStartDate != null) 'scopeStartDate': scopeStartDate?.toJson(),
      if (scopeEndDate != null) 'scopeEndDate': scopeEndDate?.toJson(),
      if (scopeSitesJson != null) 'scopeSitesJson': scopeSitesJson,
      if (scopeDepartmentsJson != null)
        'scopeDepartmentsJson': scopeDepartmentsJson,
      'isActive': isActive,
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (endedReason != null) 'endedReason': endedReason,
      'pagesViewedCount': pagesViewedCount,
      if (lastActivityAt != null) 'lastActivityAt': lastActivityAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditorSessionImpl extends AuditorSession {
  _AuditorSessionImpl({
    int? id,
    required int inspectionRecordId,
    _i2.InspectionRecord? inspectionRecord,
    int? auditorUserId,
    _i3.PharmaUser? auditorUser,
    required String accessType,
    String? accessToken,
    DateTime? tokenIssuedAt,
    DateTime? tokenExpiresAt,
    DateTime? scopeStartDate,
    DateTime? scopeEndDate,
    String? scopeSitesJson,
    String? scopeDepartmentsJson,
    bool? isActive,
    DateTime? endedAt,
    String? endedReason,
    int? pagesViewedCount,
    DateTime? lastActivityAt,
  }) : super._(
         id: id,
         inspectionRecordId: inspectionRecordId,
         inspectionRecord: inspectionRecord,
         auditorUserId: auditorUserId,
         auditorUser: auditorUser,
         accessType: accessType,
         accessToken: accessToken,
         tokenIssuedAt: tokenIssuedAt,
         tokenExpiresAt: tokenExpiresAt,
         scopeStartDate: scopeStartDate,
         scopeEndDate: scopeEndDate,
         scopeSitesJson: scopeSitesJson,
         scopeDepartmentsJson: scopeDepartmentsJson,
         isActive: isActive,
         endedAt: endedAt,
         endedReason: endedReason,
         pagesViewedCount: pagesViewedCount,
         lastActivityAt: lastActivityAt,
       );

  /// Returns a shallow copy of this [AuditorSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditorSession copyWith({
    Object? id = _Undefined,
    int? inspectionRecordId,
    Object? inspectionRecord = _Undefined,
    Object? auditorUserId = _Undefined,
    Object? auditorUser = _Undefined,
    String? accessType,
    Object? accessToken = _Undefined,
    Object? tokenIssuedAt = _Undefined,
    Object? tokenExpiresAt = _Undefined,
    Object? scopeStartDate = _Undefined,
    Object? scopeEndDate = _Undefined,
    Object? scopeSitesJson = _Undefined,
    Object? scopeDepartmentsJson = _Undefined,
    bool? isActive,
    Object? endedAt = _Undefined,
    Object? endedReason = _Undefined,
    int? pagesViewedCount,
    Object? lastActivityAt = _Undefined,
  }) {
    return AuditorSession(
      id: id is int? ? id : this.id,
      inspectionRecordId: inspectionRecordId ?? this.inspectionRecordId,
      inspectionRecord: inspectionRecord is _i2.InspectionRecord?
          ? inspectionRecord
          : this.inspectionRecord?.copyWith(),
      auditorUserId: auditorUserId is int? ? auditorUserId : this.auditorUserId,
      auditorUser: auditorUser is _i3.PharmaUser?
          ? auditorUser
          : this.auditorUser?.copyWith(),
      accessType: accessType ?? this.accessType,
      accessToken: accessToken is String? ? accessToken : this.accessToken,
      tokenIssuedAt: tokenIssuedAt is DateTime?
          ? tokenIssuedAt
          : this.tokenIssuedAt,
      tokenExpiresAt: tokenExpiresAt is DateTime?
          ? tokenExpiresAt
          : this.tokenExpiresAt,
      scopeStartDate: scopeStartDate is DateTime?
          ? scopeStartDate
          : this.scopeStartDate,
      scopeEndDate: scopeEndDate is DateTime?
          ? scopeEndDate
          : this.scopeEndDate,
      scopeSitesJson: scopeSitesJson is String?
          ? scopeSitesJson
          : this.scopeSitesJson,
      scopeDepartmentsJson: scopeDepartmentsJson is String?
          ? scopeDepartmentsJson
          : this.scopeDepartmentsJson,
      isActive: isActive ?? this.isActive,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      endedReason: endedReason is String? ? endedReason : this.endedReason,
      pagesViewedCount: pagesViewedCount ?? this.pagesViewedCount,
      lastActivityAt: lastActivityAt is DateTime?
          ? lastActivityAt
          : this.lastActivityAt,
    );
  }
}
