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
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Quality event (deviation, CAPA, change control).
abstract class QualityEvent implements _i1.SerializableModel {
  QualityEvent._({
    this.id,
    required this.eventType,
    this.referenceId,
    required this.title,
    required this.status,
    this.siteId,
    this.site,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory QualityEvent({
    int? id,
    required String eventType,
    String? referenceId,
    required String title,
    required String status,
    int? siteId,
    _i2.Site? site,
    DateTime? createdAt,
  }) = _QualityEventImpl;

  factory QualityEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return QualityEvent(
      id: jsonSerialization['id'] as int?,
      eventType: jsonSerialization['eventType'] as String,
      referenceId: jsonSerialization['referenceId'] as String?,
      title: jsonSerialization['title'] as String,
      status: jsonSerialization['status'] as String,
      siteId: jsonSerialization['siteId'] as int?,
      site: jsonSerialization['site'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Site>(jsonSerialization['site']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Type: deviation, capa, change_control.
  String eventType;

  /// External reference ID.
  String? referenceId;

  /// Title.
  String title;

  /// Status.
  String status;

  int? siteId;

  /// The site.
  _i2.Site? site;

  /// When created.
  DateTime createdAt;

  /// Returns a shallow copy of this [QualityEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QualityEvent copyWith({
    int? id,
    String? eventType,
    String? referenceId,
    String? title,
    String? status,
    int? siteId,
    _i2.Site? site,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QualityEvent',
      if (id != null) 'id': id,
      'eventType': eventType,
      if (referenceId != null) 'referenceId': referenceId,
      'title': title,
      'status': status,
      if (siteId != null) 'siteId': siteId,
      if (site != null) 'site': site?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QualityEventImpl extends QualityEvent {
  _QualityEventImpl({
    int? id,
    required String eventType,
    String? referenceId,
    required String title,
    required String status,
    int? siteId,
    _i2.Site? site,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventType: eventType,
         referenceId: referenceId,
         title: title,
         status: status,
         siteId: siteId,
         site: site,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [QualityEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QualityEvent copyWith({
    Object? id = _Undefined,
    String? eventType,
    Object? referenceId = _Undefined,
    String? title,
    String? status,
    Object? siteId = _Undefined,
    Object? site = _Undefined,
    DateTime? createdAt,
  }) {
    return QualityEvent(
      id: id is int? ? id : this.id,
      eventType: eventType ?? this.eventType,
      referenceId: referenceId is String? ? referenceId : this.referenceId,
      title: title ?? this.title,
      status: status ?? this.status,
      siteId: siteId is int? ? siteId : this.siteId,
      site: site is _i2.Site? ? site : this.site?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
