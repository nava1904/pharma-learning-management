import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Background worker that checks for certifications nearing expiry
/// and triggers reminder notifications / refresher training assignment.
class CertificationExpiryWorker extends FutureCall {
  Future<void> run(Session session) async {
    final now = DateTime.now();
    final reminderThreshold = now.add(const Duration(days: 30));

    final certs = await Certificate.db.find(session);

    for (final cert in certs) {
      if (cert.expiresAt == null) continue;

      if (cert.expiresAt!.isBefore(reminderThreshold)) {
        final existing = await TrainingExpiration.db.find(
          session,
          where: (t) => t.certificateId.equals(cert.id!),
        );

        if (existing.isEmpty) {
          await TrainingExpiration.db.insertRow(
            session,
            TrainingExpiration(
              certificateId: cert.id!,
              expiresAt: cert.expiresAt!,
              reminderSentAt: now,
            ),
          );
        }
      }
    }
  }
}
