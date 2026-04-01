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
import '../course/competency.dart' as _i3;
import '../training/practical_checklist_item.dart' as _i4;
import 'package:pharma_lms_client/src/protocol/protocol.dart' as _i5;

/// Observation log entry for OQ/OJT practical evaluation.
abstract class ObservationLog implements _i1.SerializableModel {
  ObservationLog._({
    this.id,
    required this.userId,
    this.user,
    required this.evaluatorId,
    this.evaluator,
    required this.competencyId,
    this.competency,
    required this.checklistItemId,
    this.checklistItem,
    String? result,
    this.notes,
    DateTime? observedAt,
    this.evaluatorEsignatureId,
    this.traineeEsignatureId,
    required this.organizationId,
  }) : result = result ?? 'pending',
       observedAt = observedAt ?? DateTime.now();

  factory ObservationLog({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int evaluatorId,
    _i2.PharmaUser? evaluator,
    required int competencyId,
    _i3.Competency? competency,
    required int checklistItemId,
    _i4.PracticalChecklistItem? checklistItem,
    String? result,
    String? notes,
    DateTime? observedAt,
    int? evaluatorEsignatureId,
    int? traineeEsignatureId,
    required int organizationId,
  }) = _ObservationLogImpl;

  factory ObservationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ObservationLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['user'],
            ),
      evaluatorId: jsonSerialization['evaluatorId'] as int,
      evaluator: jsonSerialization['evaluator'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.PharmaUser>(
              jsonSerialization['evaluator'],
            ),
      competencyId: jsonSerialization['competencyId'] as int,
      competency: jsonSerialization['competency'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Competency>(
              jsonSerialization['competency'],
            ),
      checklistItemId: jsonSerialization['checklistItemId'] as int,
      checklistItem: jsonSerialization['checklistItem'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PracticalChecklistItem>(
              jsonSerialization['checklistItem'],
            ),
      result: jsonSerialization['result'] as String?,
      notes: jsonSerialization['notes'] as String?,
      observedAt: jsonSerialization['observedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['observedAt']),
      evaluatorEsignatureId: jsonSerialization['evaluatorEsignatureId'] as int?,
      traineeEsignatureId: jsonSerialization['traineeEsignatureId'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  /// The user being evaluated.
  _i2.PharmaUser? user;

  int evaluatorId;

  /// The evaluator (trainer/SME).
  _i2.PharmaUser? evaluator;

  int competencyId;

  /// The competency being observed.
  _i3.Competency? competency;

  int checklistItemId;

  /// The checklist item being observed.
  _i4.PracticalChecklistItem? checklistItem;

  /// Observation result: pass, fail, needs_improvement.
  String result;

  /// Evaluator notes/comments.
  String? notes;

  /// When the observation occurred.
  DateTime observedAt;

  /// E-signature of the evaluator (21 CFR Part 11).
  int? evaluatorEsignatureId;

  /// E-signature of the trainee (21 CFR Part 11).
  int? traineeEsignatureId;

  /// The organization.
  int organizationId;

  /// Returns a shallow copy of this [ObservationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ObservationLog copyWith({
    int? id,
    int? userId,
    _i2.PharmaUser? user,
    int? evaluatorId,
    _i2.PharmaUser? evaluator,
    int? competencyId,
    _i3.Competency? competency,
    int? checklistItemId,
    _i4.PracticalChecklistItem? checklistItem,
    String? result,
    String? notes,
    DateTime? observedAt,
    int? evaluatorEsignatureId,
    int? traineeEsignatureId,
    int? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ObservationLog',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'evaluatorId': evaluatorId,
      if (evaluator != null) 'evaluator': evaluator?.toJson(),
      'competencyId': competencyId,
      if (competency != null) 'competency': competency?.toJson(),
      'checklistItemId': checklistItemId,
      if (checklistItem != null) 'checklistItem': checklistItem?.toJson(),
      'result': result,
      if (notes != null) 'notes': notes,
      'observedAt': observedAt.toJson(),
      if (evaluatorEsignatureId != null)
        'evaluatorEsignatureId': evaluatorEsignatureId,
      if (traineeEsignatureId != null)
        'traineeEsignatureId': traineeEsignatureId,
      'organizationId': organizationId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ObservationLogImpl extends ObservationLog {
  _ObservationLogImpl({
    int? id,
    required int userId,
    _i2.PharmaUser? user,
    required int evaluatorId,
    _i2.PharmaUser? evaluator,
    required int competencyId,
    _i3.Competency? competency,
    required int checklistItemId,
    _i4.PracticalChecklistItem? checklistItem,
    String? result,
    String? notes,
    DateTime? observedAt,
    int? evaluatorEsignatureId,
    int? traineeEsignatureId,
    required int organizationId,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         evaluatorId: evaluatorId,
         evaluator: evaluator,
         competencyId: competencyId,
         competency: competency,
         checklistItemId: checklistItemId,
         checklistItem: checklistItem,
         result: result,
         notes: notes,
         observedAt: observedAt,
         evaluatorEsignatureId: evaluatorEsignatureId,
         traineeEsignatureId: traineeEsignatureId,
         organizationId: organizationId,
       );

  /// Returns a shallow copy of this [ObservationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ObservationLog copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    int? evaluatorId,
    Object? evaluator = _Undefined,
    int? competencyId,
    Object? competency = _Undefined,
    int? checklistItemId,
    Object? checklistItem = _Undefined,
    String? result,
    Object? notes = _Undefined,
    DateTime? observedAt,
    Object? evaluatorEsignatureId = _Undefined,
    Object? traineeEsignatureId = _Undefined,
    int? organizationId,
  }) {
    return ObservationLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.PharmaUser? ? user : this.user?.copyWith(),
      evaluatorId: evaluatorId ?? this.evaluatorId,
      evaluator: evaluator is _i2.PharmaUser?
          ? evaluator
          : this.evaluator?.copyWith(),
      competencyId: competencyId ?? this.competencyId,
      competency: competency is _i3.Competency?
          ? competency
          : this.competency?.copyWith(),
      checklistItemId: checklistItemId ?? this.checklistItemId,
      checklistItem: checklistItem is _i4.PracticalChecklistItem?
          ? checklistItem
          : this.checklistItem?.copyWith(),
      result: result ?? this.result,
      notes: notes is String? ? notes : this.notes,
      observedAt: observedAt ?? this.observedAt,
      evaluatorEsignatureId: evaluatorEsignatureId is int?
          ? evaluatorEsignatureId
          : this.evaluatorEsignatureId,
      traineeEsignatureId: traineeEsignatureId is int?
          ? traineeEsignatureId
          : this.traineeEsignatureId,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}
