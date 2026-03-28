import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';
import '../services/realtime_hub.dart';

/// Live class session management for training batches.
class LiveClassEndpoint extends Endpoint {
  Future<LiveClass?> create(
    Session session, {
    required int batchId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    int durationMinutes = 60,
    String? meetingUrl,
    bool autoRecording = false,
  }) async {
    final user = await RbacHelper.getCurrentPharmaUser(session);
    if (user == null) return null;
    if (!await _canMutateLiveClassForBatch(session, batchId)) return null;

    final liveClass = LiveClass(
      batchId: batchId,
      title: title,
      description: description,
      scheduledAt: scheduledAt,
      durationMinutes: durationMinutes,
      meetingUrl: meetingUrl,
      autoRecording: autoRecording,
      createdById: user.id,
    );

    final result = await LiveClass.db.insertRow(session, liveClass);

    await BatchAnnouncement.db.insertRow(
      session,
      BatchAnnouncement(
        batchId: batchId,
        title: 'Live session: $title',
        body: description?.isNotEmpty == true
            ? description!
            : 'Scheduled ${scheduledAt.toIso8601String()}',
        kind: 'live_session',
        relatedLiveClassId: result.id,
        createdById: user.id,
      ),
    );

    RealtimeHub.instance.broadcast(
      'batch:$batchId',
      {
        'event': 'batch_announcement_created',
        'batchId': batchId,
        'payload': {
          'kind': 'live_session',
          'title': 'Live session: $title',
          'liveClassId': result.id,
        },
      },
    );

    await AuditService.log(
      session,
      entityType: 'live_class',
      entityId: result.id.toString(),
      action: 'LiveClassCreated',
      newValueJson: '{"batchId":$batchId,"title":"$title","scheduledAt":"$scheduledAt"}',
      userId: user.id,
    );

    RealtimeHub.instance.broadcast(
      'batch:$batchId',
      {
        'event': 'live_class_created',
        'batchId': batchId,
        'payload': {
          'id': result.id,
          'title': result.title,
          'scheduledAt': result.scheduledAt.toIso8601String(),
          'meetingUrl': result.meetingUrl,
        },
      },
    );

    return result;
  }

  Future<List<LiveClass>> listByBatch(
    Session session,
    int batchId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await _canListLiveClassesForBatch(session, batchId)) return [];

    return await LiveClass.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
      orderBy: (t) => t.scheduledAt,
    );
  }

  Future<LiveClass?> update(
    Session session, {
    required int liveClassId,
    String? title,
    String? description,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
  }) async {
    final existing = await LiveClass.db.findById(session, liveClassId);
    if (existing == null) return null;
    if (!await _canMutateLiveClassForBatch(session, existing.batchId)) return null;

    final updated = existing.copyWith(
      title: title ?? existing.title,
      description: description ?? existing.description,
      scheduledAt: scheduledAt ?? existing.scheduledAt,
      durationMinutes: durationMinutes ?? existing.durationMinutes,
      meetingUrl: meetingUrl ?? existing.meetingUrl,
      autoRecording: autoRecording ?? existing.autoRecording,
    );

    final result = await LiveClass.db.updateRow(session, updated);
    RealtimeHub.instance.broadcast(
      'batch:${existing.batchId}',
      {
        'event': 'live_class_updated',
        'batchId': existing.batchId,
        'payload': {'id': result.id, 'title': result.title},
      },
    );
    return result;
  }

  Future<bool> delete(Session session, int liveClassId) async {
    final existing = await LiveClass.db.findById(session, liveClassId);
    if (existing == null) return false;
    if (!await _canMutateLiveClassForBatch(session, existing.batchId)) return false;

    final batchId = existing.batchId;
    await LiveClass.db.deleteRow(session, existing);
    RealtimeHub.instance.broadcast(
      'batch:$batchId',
      {
        'event': 'live_class_deleted',
        'batchId': batchId,
        'payload': {'id': liveClassId},
      },
    );
    return true;
  }

  /// Roster member, batch instructor, or training admin (update/delete) in same org.
  Future<bool> _canListLiveClassesForBatch(Session session, int batchId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return false;
    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return false;
    if (me!.organizationId != batch.organizationId) return false;

    final onRoster = await TrainingBatchParticipant.db.findFirstRow(
      session,
      where: (t) => t.batchId.equals(batchId) & t.userId.equals(me.id!),
    );
    if (onRoster != null) return true;
    if (batch.instructorId == me.id) return true;
    if (await RbacHelper.hasPermission(session, resource: 'training', action: 'update')) {
      return true;
    }
    if (await RbacHelper.hasPermission(session, resource: 'training', action: 'delete')) {
      return true;
    }
    return false;
  }

  /// Instructor with training write/create/update, or org training admin create/update/delete.
  Future<bool> _canMutateLiveClassForBatch(Session session, int batchId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return false;
    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null) return false;
    if (me!.organizationId != batch.organizationId) return false;

    final hasWrite = await RbacHelper.hasPermission(session, resource: 'training', action: 'write');
    final hasCreate = await RbacHelper.hasPermission(session, resource: 'training', action: 'create');
    final hasUpdate = await RbacHelper.hasPermission(session, resource: 'training', action: 'update');
    final hasDelete = await RbacHelper.hasPermission(session, resource: 'training', action: 'delete');
    final isInstructor = batch.instructorId == me.id;
    if (isInstructor && (hasWrite || hasCreate || hasUpdate)) return true;
    if (hasUpdate || hasDelete || hasCreate) return true;
    return false;
  }
}
