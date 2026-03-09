import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Background worker for full cert expiry ladder (ADM-06).
/// Ladder: 90d (flag), 60d (reminder), 30d (notify), 7d (escalate), expiry-day (EXPIRED).
class CertificationExpiryWorker extends FutureCall {
  Future<void> run(Session session) async {
    final now = DateTime.now();
    final certs = await Certificate.db.find(
      session,
      include: Certificate.include(user: PharmaUser.include()),
    );

    for (final cert in certs) {
      if (cert.expiresAt == null) continue;
      if (cert.status == 'obsolete') continue;

      final daysUntilExpiry = cert.expiresAt!.difference(now).inDays;
      String? notificationType;

      if (daysUntilExpiry < 0) {
        notificationType = 'cert_expired';
      } else if (daysUntilExpiry <= 7) {
        notificationType = 'cert_expiry_7d';
      } else if (daysUntilExpiry <= 30) {
        notificationType = 'cert_expiry_30d';
      } else if (daysUntilExpiry <= 60) {
        notificationType = 'cert_expiry_60d';
      } else if (daysUntilExpiry <= 90) {
        notificationType = 'cert_expiry_90d';
      }

      if (notificationType == null) continue;

      var expiration = await TrainingExpiration.db.findFirstRow(
        session,
        where: (t) => t.certificateId.equals(cert.id!),
      );

      if (expiration == null) {
        expiration = await TrainingExpiration.db.insertRow(
          session,
          TrainingExpiration(
            certificateId: cert.id!,
            expiresAt: cert.expiresAt!,
            reminderSentAt: now,
          ),
        );
      } else {
        await TrainingExpiration.db.updateRow(
          session,
          expiration.copyWith(reminderSentAt: now),
        );
      }

      if (daysUntilExpiry < 0) {
        await Certificate.db.updateRow(
          session,
          cert.copyWith(status: 'expired'),
        );
      }

      if (cert.userId != null) {
        final recent = await Notification.db.find(
          session,
          where: (t) =>
              t.userId.equals(cert.userId!) &
              t.type.equals(notificationType),
          limit: 1,
          orderBy: (t) => t.createdAt,
          orderDescending: true,
        );
        final lastSent = recent.isNotEmpty ? recent.first.createdAt : null;
        if (lastSent == null || now.difference(lastSent).inHours >= 24) {
          await Notification.db.insertRow(
            session,
            Notification(
              userId: cert.userId!,
              type: notificationType,
              channel: 'in_app',
            ),
          );
        }
      }
    }
  }
}
