import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';
import '../services/realtime_hub.dart';

/// Batch feed: announcements for roster (assignments, live session notes, general).
class BatchAnnouncementEndpoint extends Endpoint {
  Future<List<BatchAnnouncement>> listForBatch(
    Session session,
    int batchId,
  ) async {
    if (!await _canViewBatchCommunications(session, batchId)) return [];
    return BatchAnnouncement.db.find(
      session,
      where: (t) => t.batchId.equals(batchId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: BatchAnnouncement.include(
        createdBy: PharmaUser.include(),
      ),
    );
  }

  Future<BatchAnnouncement?> createForBatch(
    Session session, {
    required int batchId,
    required String title,
    required String body,
    String kind = 'general',
    int? relatedLiveClassId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;
    if (!await _canPostAnnouncement(session, batchId)) return null;

    final row = await BatchAnnouncement.db.insertRow(
      session,
      BatchAnnouncement(
        batchId: batchId,
        title: title,
        body: body,
        kind: kind,
        relatedLiveClassId: relatedLiveClassId,
        createdById: me!.id,
      ),
    );

    RealtimeHub.instance.broadcast(
      'batch:$batchId',
      {
        'event': 'batch_announcement_created',
        'batchId': batchId,
        'payload': {
          'id': row.id,
          'title': row.title,
          'body': row.body,
          'kind': row.kind,
          'createdAt': row.createdAt.toIso8601String(),
        },
      },
    );

    return row;
  }

  Future<bool> _canViewBatchCommunications(Session session, int batchId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return false;
    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null || me!.organizationId != batch.organizationId) return false;

    final onRoster = await TrainingBatchParticipant.db.findFirstRow(
      session,
      where: (t) => t.batchId.equals(batchId) & t.userId.equals(me.id!),
    );
    if (onRoster != null) return true;
    if (batch.instructorId == me.id) return true;
    return await RbacHelper.hasPermission(session, resource: 'training', action: 'update') ||
        await RbacHelper.hasPermission(session, resource: 'training', action: 'delete');
  }

  Future<bool> _canPostAnnouncement(Session session, int batchId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return false;
    final batch = await TrainingBatch.db.findById(session, batchId);
    if (batch == null || me!.organizationId != batch.organizationId) return false;

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
