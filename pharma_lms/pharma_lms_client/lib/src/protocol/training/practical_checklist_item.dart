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
import '../course/competency.dart' as _i2;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i3;

/// Practical checklist item for OQ/OJT observation.
abstract class PracticalChecklistItem implements _i1.SerializableModel {
  PracticalChecklistItem._({
    this.id,
    required this.competencyId,
    this.competency,
    required this.title,
    this.description,
    int? orderIndex,
    bool? isCritical,
    required this.organizationId,
  }) : orderIndex = orderIndex ?? 0,
       isCritical = isCritical ?? false;

  factory PracticalChecklistItem({
    int? id,
    required int competencyId,
    _i2.Competency? competency,
    required String title,
    String? description,
    int? orderIndex,
    bool? isCritical,
    required int organizationId,
  }) = _PracticalChecklistItemImpl;

  factory PracticalChecklistItem.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PracticalChecklistItem(
      id: jsonSerialization['id'] as int?,
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Competency>(
              jsonSerialization['competency'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      isCritical: jsonSerialization['isCritical'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isCritical']),
      organizationId: jsonSerialization['organizationId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int competencyId;

  /// The competency this checklist item belongs to.
  _i2.Competency? competency;

  /// Step/task title.
  String title;

  /// Detailed description of expected performance.
  String? description;

  /// Order within the checklist.
  int orderIndex;

  /// Whether this step is critical (must-pass).
  bool isCritical;

  /// The organization that owns this checklist item.
  int organizationId;

  /// Returns a shallow copy of this [PracticalChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PracticalChecklistItem copyWith({
    int? id,
    int? competencyId,
    _i2.Competency? competency,
    String? title,
    String? description,
    int? orderIndex,
    bool? isCritical,
    int? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PracticalChecklistItem',
      if (id != null) 'id': id,
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'orderIndex': orderIndex,
      'isCritical': isCritical,
      'organizationId': organizationId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PracticalChecklistItemImpl extends PracticalChecklistItem {
  _PracticalChecklistItemImpl({
    int? id,
    required int competencyId,
    _i2.Competency? competency,
    required String title,
    String? description,
    int? orderIndex,
    bool? isCritical,
    required int organizationId,
  }) : super._(
         id: id,
         competencyId: competencyId,
         competency: competency,
         title: title,
         description: description,
         orderIndex: orderIndex,
         isCritical: isCritical,
         organizationId: organizationId,
       );

  /// Returns a shallow copy of this [PracticalChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PracticalChecklistItem copyWith({
    Object? id = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
    String? title,
    Object? description = _Undefined,
    int? orderIndex,
    bool? isCritical,
    int? organizationId,
  }) {
    return PracticalChecklistItem(
      id: id is int? ? id : this.id,
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i2.Competency?
          ? competency
          : this.competency?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      isCritical: isCritical ?? this.isCritical,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}
