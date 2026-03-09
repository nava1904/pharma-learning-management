import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// SYS-06: CAPA effectiveness check worker.
/// Runs periodically to find CAPAs whose effectiveness check is due (30/60/90 days
/// after training completion) and creates notifications for QA to perform the check.
class CapaEffectivenessWorker extends FutureCall {
  Future<void> run(Session session) async {
    final now = DateTime.now();

    final allCapas = await Capa.db.find(
      session,
      where: (t) => t.status.notEquals('Closed'),
      include: Capa.include(
        qualityEvent: QualityEvent.include(),
      ),
    );
    final capas = allCapas
        .where((c) =>
            c.effectivenessCheckDue != null &&
            !c.effectivenessCheckDue!.isAfter(now))
        .toList();

    if (capas.isEmpty) {
      session.log('[CapaEffectivenessWorker] No CAPAs due for effectiveness check');
      return;
    }

    // Get QA users: users in QA department (code 'QA') or first user as fallback
    final qaDept = await Department.db.findFirstRow(
      session,
      where: (t) => t.code.equals('QA'),
    );

    var qaUsers = <PharmaUser>[];
    if (qaDept?.id != null) {
      qaUsers = await PharmaUser.db.find(
        session,
        where: (t) => t.departmentId.equals(qaDept!.id!),
      );
    }
    if (qaUsers.isEmpty) {
      // Fallback: get first user (admin or any)
      final any = await PharmaUser.db.find(session, limit: 1);
      qaUsers = any;
    }

    var count = 0;
    for (final capa in capas) {
      if (capa.id == null) continue;
      for (final user in qaUsers) {
        if (user.id == null) continue;
        // Avoid duplicate: one notification per user per CAPA (type encodes capaId)
        final typeWithCapa = 'capa_effectiveness_check_${capa.id}';
        final existing = await Notification.db.find(
          session,
          where: (t) =>
              t.userId.equals(user.id!) &
              t.type.equals(typeWithCapa),
        );
        if (existing.isNotEmpty) continue;

        await Notification.db.insertRow(
          session,
          Notification(
            userId: user.id!,
            type: typeWithCapa,
            channel: 'in_app',
          ),
        );
        count++;
      }
    }

    await ScheduledJobLog.db.insertRow(
      session,
      ScheduledJobLog(
        jobName: 'CapaEffectivenessCheck',
        startedAt: now,
        completedAt: DateTime.now(),
        status: 'success',
        recordsProcessed: capas.length,
        recordsAffected: count,
      ),
    );

    session.log(
      '[CapaEffectivenessWorker] Processed ${capas.length} CAPAs, created $count notifications',
    );
  }
}
