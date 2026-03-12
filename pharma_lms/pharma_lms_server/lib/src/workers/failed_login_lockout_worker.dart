import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../services/audit_service.dart';

/// Background worker for 21 CFR Part 11 lockout: after 5 failed login attempts
/// within 5 minutes, lock the user account until admin unlocks.
///
/// Queries serverpod_auth_idp_rate_limited_request_attempt (failed_login),
/// groups by email, locks users with 5+ attempts.
/// Self-reschedules every minute.
class FailedLoginLockoutWorker extends FutureCall {
  static const int _lockoutThreshold = 5;
  static const Duration _timeframe = Duration(minutes: 5);
  static const Duration _rescheduleInterval = Duration(minutes: 1);

  Future<void> run(Session session) async {
    // Schedule next run before doing work (recurring pattern)
    await session.serverpod.endpoints.futureCalls!
        .callWithDelay(_rescheduleInterval)
        .failedLoginLockoutWorker
        .run();
    await _doWork(session);
  }

  Future<void> _doWork(Session session) async {
    final cutoff = DateTime.now().subtract(_timeframe);

    // Query emails with 5+ failed login attempts in the last 5 minutes.
    // Table: serverpod_auth_idp_rate_limited_request_attempt
    // domain='email', source='failed_login', nonce=email
    final result = await session.db.unsafeQuery(
      r'''
      SELECT "nonce" AS email, COUNT(*) AS cnt
      FROM serverpod_auth_idp_rate_limited_request_attempt
      WHERE "domain" = 'email'
        AND "source" = 'failed_login'
        AND "attemptedAt" >= @cutoff
      GROUP BY "nonce"
      HAVING COUNT(*) >= @threshold
      ''',
      parameters: QueryParameters.named({
        'cutoff': cutoff,
        'threshold': _lockoutThreshold,
      }),
    );

    for (final row in result) {
      final email = row[0]?.toString().trim();
      if (email == null || email.isEmpty) continue;

      // Get authUserId from serverpod_auth_core_profile
      final profileResult = await session.db.unsafeQuery(
        r'SELECT "authUserId" FROM serverpod_auth_core_profile WHERE email = @email LIMIT 1',
        parameters: QueryParameters.named({'email': email}),
      );
      if (profileResult.isEmpty) continue;

      final authUserIdStr = profileResult.first[0]?.toString() ?? '';
      if (authUserIdStr.isEmpty) continue;

      UuidValue authUserId;
      try {
        authUserId = UuidValue.fromString(authUserIdStr);
      } catch (_) {
        continue;
      }

      // Check if already blocked
      final authUser = await AuthServices.instance.authUsers.get(
        session,
        authUserId: authUserId,
      );
      if (authUser.blocked == true) continue;

      // Lock the account
      await AuthServices.instance.authUsers.update(
        session,
        authUserId: authUserId,
        blocked: true,
      );

      await AuditService.log(
        session,
        entityType: 'auth_user',
        entityId: authUserId.toString(),
        action: 'UserLocked',
        newValueJson: '{"email":"$email","reason":"5_failed_login_attempts"}',
      );

      session.log(
        '[FailedLoginLockoutWorker] Locked account $email after 5 failed attempts',
      );
    }
  }
}

