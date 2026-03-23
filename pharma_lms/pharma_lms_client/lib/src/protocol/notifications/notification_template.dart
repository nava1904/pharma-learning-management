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
import '../organization/organization.dart' as _i2;
import '../organization/user.dart' as _i3;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i4;

/// Notification template for system notifications. GMP compliant.
abstract class NotificationTemplate implements _i1.SerializableModel {
  NotificationTemplate._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.type,
    String? channel,
    this.triggerEvent,
    this.subject,
    required this.bodyTemplate,
    String? status,
    required this.createdById,
    this.createdBy,
    DateTime? createdAt,
    this.updatedAt,
  }) : channel = channel ?? 'email',
       status = status ?? 'draft',
       createdAt = createdAt ?? DateTime.now();

  factory NotificationTemplate({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String type,
    String? channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    String? status,
    required int createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationTemplateImpl;

  factory NotificationTemplate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotificationTemplate(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      channel: jsonSerialization['channel'] as String?,
      triggerEvent: jsonSerialization['triggerEvent'] as String?,
      subject: jsonSerialization['subject'] as String?,
      bodyTemplate: jsonSerialization['bodyTemplate'] as String,
      status: jsonSerialization['status'] as String?,
      createdById: jsonSerialization['createdById'] as int,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.PharmaUser>(
              jsonSerialization['createdBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  /// Organization this template belongs to.
  _i2.Organization? organization;

  /// Template name/title.
  String name;

  /// Type: assignment, reminder, overdue, certificate, compliance, broadcast.
  String type;

  /// Channel: email, push, sms, in_app.
  String channel;

  /// Trigger event or condition description.
  String? triggerEvent;

  /// Subject line (for email).
  String? subject;

  /// Template body content with variables like {{userName}}, {{courseTitle}}, {{dueDate}}.
  String bodyTemplate;

  /// Status: active, draft, inactive.
  String status;

  int createdById;

  /// Created by user.
  _i3.PharmaUser? createdBy;

  /// Created timestamp.
  DateTime createdAt;

  /// Last updated timestamp.
  DateTime? updatedAt;

  /// Returns a shallow copy of this [NotificationTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationTemplate copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? type,
    String? channel,
    String? triggerEvent,
    String? subject,
    String? bodyTemplate,
    String? status,
    int? createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationTemplate',
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'type': type,
      'channel': channel,
      if (triggerEvent != null) 'triggerEvent': triggerEvent,
      if (subject != null) 'subject': subject,
      'bodyTemplate': bodyTemplate,
      'status': status,
      'createdById': createdById,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationTemplateImpl extends NotificationTemplate {
  _NotificationTemplateImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required String name,
    required String type,
    String? channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    String? status,
    required int createdById,
    _i3.PharmaUser? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         type: type,
         channel: channel,
         triggerEvent: triggerEvent,
         subject: subject,
         bodyTemplate: bodyTemplate,
         status: status,
         createdById: createdById,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [NotificationTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationTemplate copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? type,
    String? channel,
    Object? triggerEvent = _Undefined,
    Object? subject = _Undefined,
    String? bodyTemplate,
    String? status,
    int? createdById,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
  }) {
    return NotificationTemplate(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      type: type ?? this.type,
      channel: channel ?? this.channel,
      triggerEvent: triggerEvent is String? ? triggerEvent : this.triggerEvent,
      subject: subject is String? ? subject : this.subject,
      bodyTemplate: bodyTemplate ?? this.bodyTemplate,
      status: status ?? this.status,
      createdById: createdById ?? this.createdById,
      createdBy: createdBy is _i3.PharmaUser?
          ? createdBy
          : this.createdBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
