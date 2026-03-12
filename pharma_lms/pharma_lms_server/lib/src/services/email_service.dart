import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';

/// Email service using SMTP. Configure via config smtp section or passwords.
class EmailService {
  EmailService._();

  /// SMTP config from passwords.yaml: smtpHost, smtpPort, smtpUser, smtpPassword, smtpFromEmail.
  static SmtpServer? _getSmtpServer(Serverpod pod) {
    final host = pod.getPassword('smtpHost');
    if (host == null || host.isEmpty) return null;
    final port = int.tryParse(pod.getPassword('smtpPort') ?? '587') ?? 587;
    final user = pod.getPassword('smtpUser');
    final pass = pod.getPassword('smtpPassword');
    return SmtpServer(
      host,
      port: port,
      username: user,
      password: pass,
      ssl: port == 465,
    );
  }

  static String _fromEmail(Serverpod pod) {
    return pod.getPassword('smtpFromEmail') ?? 'noreply@pharmalms.local';
  }

  /// Send registration verification code.
  static Future<void> sendRegistrationCode(
    Session session, {
    required String email,
    required String verificationCode,
  }) async {
    final pod = session.serverpod;
    final smtp = _getSmtpServer(pod);
    if (smtp == null) {
      session.log('[EmailService] Registration code ($email): $verificationCode (SMTP not configured)');
      return;
    }
    final msg = mailer.Message()
      ..from = mailer.Address(_fromEmail(pod), 'Pharma LMS')
      ..recipients.add(email)
      ..subject = 'Pharma LMS - Registration Verification'
      ..text = 'Your verification code is: $verificationCode\n\nThis code expires in 15 minutes.';
    try {
      await mailer.send(msg, smtp);
      session.log('[EmailService] Registration code sent to $email');
    } catch (e) {
      session.log('[EmailService] Failed to send registration email: $e');
    }
  }

  /// Send password reset verification code.
  static Future<void> sendPasswordResetCode(
    Session session, {
    required String email,
    required String verificationCode,
  }) async {
    final pod = session.serverpod;
    final smtp = _getSmtpServer(pod);
    if (smtp == null) {
      session.log('[EmailService] Password reset code ($email): $verificationCode (SMTP not configured)');
      return;
    }
    final msg = mailer.Message()
      ..from = mailer.Address(_fromEmail(pod), 'Pharma LMS')
      ..recipients.add(email)
      ..subject = 'Pharma LMS - Password Reset'
      ..text = 'Your password reset code is: $verificationCode\n\nThis code expires in 15 minutes.';
    try {
      await mailer.send(msg, smtp);
      session.log('[EmailService] Password reset code sent to $email');
    } catch (e) {
      session.log('[EmailService] Failed to send password reset email: $e');
    }
  }

  /// Send assignment/training notification email.
  static Future<void> sendNotificationEmail(
    Session session, {
    required String email,
    required String subject,
    required String body,
  }) async {
    final pod = session.serverpod;
    final smtp = _getSmtpServer(pod);
    if (smtp == null) return;
    final msg = mailer.Message()
      ..from = mailer.Address(_fromEmail(pod), 'Pharma LMS')
      ..recipients.add(email)
      ..subject = subject
      ..text = body;
    try {
      await mailer.send(msg, smtp);
    } catch (e) {
      session.log('[EmailService] Failed to send notification: $e');
    }
  }
}
