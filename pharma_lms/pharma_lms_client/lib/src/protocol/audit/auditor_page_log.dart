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
import '../audit/auditor_session.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Auditor page view log. FDA 21 CFR Part 11.
abstract class AuditorPageLog implements _i1.SerializableModel {
  AuditorPageLog._({
    this.id,
    required this.auditorSessionId,
    this.auditorSession,
    required this.pageUrl,
    this.pageTitle,
    this.entityType,
    this.entityId,
    DateTime? viewedAt,
    this.timeOnPageSeconds,
    bool? exported,
  }) : viewedAt = viewedAt ?? DateTime.now(),
       exported = exported ?? false;

  factory AuditorPageLog({
    int? id,
    required int auditorSessionId,
    _i2.AuditorSession? auditorSession,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    DateTime? viewedAt,
    int? timeOnPageSeconds,
    bool? exported,
  }) = _AuditorPageLogImpl;

  factory AuditorPageLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditorPageLog(
      id: jsonSerialization['id'] as int?,
      auditorSessionId: jsonSerialization['auditorSessionId'] as int,
      auditorSession: jsonSerialization['auditorSession'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuditorSession>(
              jsonSerialization['auditorSession'],
            ),
      pageUrl: jsonSerialization['pageUrl'] as String,
      pageTitle: jsonSerialization['pageTitle'] as String?,
      entityType: jsonSerialization['entityType'] as String?,
      entityId: jsonSerialization['entityId'] as String?,
      viewedAt: jsonSerialization['viewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['viewedAt']),
      timeOnPageSeconds: jsonSerialization['timeOnPageSeconds'] as int?,
      exported: jsonSerialization['exported'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['exported']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int auditorSessionId;

  /// The auditor session.
  _i2.AuditorSession? auditorSession;

  /// Page URL viewed.
  String pageUrl;

  /// Page title.
  String? pageTitle;

  /// Entity type: training_record, certificate, esignature, audit_trail, capa, report.
  String? entityType;

  /// Entity ID.
  String? entityId;

  /// When viewed.
  DateTime viewedAt;

  /// Time on page in seconds.
  int? timeOnPageSeconds;

  /// Whether page was exported.
  bool exported;

  /// Returns a shallow copy of this [AuditorPageLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditorPageLog copyWith({
    int? id,
    int? auditorSessionId,
    _i2.AuditorSession? auditorSession,
    String? pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    DateTime? viewedAt,
    int? timeOnPageSeconds,
    bool? exported,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditorPageLog',
      if (id != null) 'id': id,
      'auditorSessionId': auditorSessionId,
      if (auditorSession != null) 'auditorSession': auditorSession?.toJson(),
      'pageUrl': pageUrl,
      if (pageTitle != null) 'pageTitle': pageTitle,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      'viewedAt': viewedAt.toJson(),
      if (timeOnPageSeconds != null) 'timeOnPageSeconds': timeOnPageSeconds,
      'exported': exported,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditorPageLogImpl extends AuditorPageLog {
  _AuditorPageLogImpl({
    int? id,
    required int auditorSessionId,
    _i2.AuditorSession? auditorSession,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    DateTime? viewedAt,
    int? timeOnPageSeconds,
    bool? exported,
  }) : super._(
         id: id,
         auditorSessionId: auditorSessionId,
         auditorSession: auditorSession,
         pageUrl: pageUrl,
         pageTitle: pageTitle,
         entityType: entityType,
         entityId: entityId,
         viewedAt: viewedAt,
         timeOnPageSeconds: timeOnPageSeconds,
         exported: exported,
       );

  /// Returns a shallow copy of this [AuditorPageLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditorPageLog copyWith({
    Object? id = _Undefined,
    int? auditorSessionId,
    Object? auditorSession = _Undefined,
    String? pageUrl,
    Object? pageTitle = _Undefined,
    Object? entityType = _Undefined,
    Object? entityId = _Undefined,
    DateTime? viewedAt,
    Object? timeOnPageSeconds = _Undefined,
    bool? exported,
  }) {
    return AuditorPageLog(
      id: id is int? ? id : this.id,
      auditorSessionId: auditorSessionId ?? this.auditorSessionId,
      auditorSession: auditorSession is _i2.AuditorSession?
          ? auditorSession
          : this.auditorSession?.copyWith(),
      pageUrl: pageUrl ?? this.pageUrl,
      pageTitle: pageTitle is String? ? pageTitle : this.pageTitle,
      entityType: entityType is String? ? entityType : this.entityType,
      entityId: entityId is String? ? entityId : this.entityId,
      viewedAt: viewedAt ?? this.viewedAt,
      timeOnPageSeconds: timeOnPageSeconds is int?
          ? timeOnPageSeconds
          : this.timeOnPageSeconds,
      exported: exported ?? this.exported,
    );
  }
}
