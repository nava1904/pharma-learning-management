import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds material progress records so learner progress tracking,
/// course analytics, and engagement metrics have data.
class MaterialProgressSeed {
  static Future<int> insert(Session session, SeedContext ctx) async {
    if (ctx.materialIds.isEmpty || ctx.learnerIds.isEmpty) return 0;

    final rng = Random(77);
    var count = 0;

    // Give ~60 learners progress on various materials
    for (var ui = 0; ui < 60 && ui < ctx.learnerIds.length; ui++) {
      final userId = ctx.learnerIds[ui];

      // Each learner interacts with 3-6 materials
      final materialCount = 3 + rng.nextInt(4);
      for (var mi = 0; mi < materialCount && mi < ctx.materialIds.length; mi++) {
        final materialId = ctx.materialIds[(ui * 3 + mi) % ctx.materialIds.length];

        // Vary progress: completed, partial, just started
        final progressBucket = (ui + mi) % 5;
        final int progressPct;
        final DateTime? completedAt;
        final int timeSpent;
        final bool readTimeMet;

        switch (progressBucket) {
          case 0:
          case 1:
            // Completed
            progressPct = 100;
            completedAt = ctx.dt(-30 + ui);
            timeSpent = 600 + rng.nextInt(1200); // 10-30 min
            readTimeMet = true;
          case 2:
            // Well into it
            progressPct = 50 + rng.nextInt(40);
            completedAt = null;
            timeSpent = 300 + rng.nextInt(600);
            readTimeMet = false;
          case 3:
            // Just started
            progressPct = 5 + rng.nextInt(20);
            completedAt = null;
            timeSpent = 30 + rng.nextInt(120);
            readTimeMet = false;
          default:
            // Barely opened
            progressPct = 1 + rng.nextInt(5);
            completedAt = null;
            timeSpent = 10 + rng.nextInt(30);
            readTimeMet = false;
        }

        await MaterialProgress.db.insertRow(
          session,
          MaterialProgress(
            userId: userId,
            materialId: materialId,
            progressPct: progressPct,
            completedAt: completedAt,
            timeSpentSeconds: timeSpent,
            lastHeartbeat: ctx.dt(-rng.nextInt(14)),
            readTimeMet: readTimeMet,
          ),
        );
        count++;
      }
    }
    return count;
  }
}
