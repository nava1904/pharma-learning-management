# Email Service (SMTP)

Pharma LMS sends emails for registration verification, password reset, and training notifications via SMTP.

## Configuration

Configure SMTP in config/passwords.yaml (or your deployment secrets):

- smtpHost (required): SMTP server hostname
- smtpPort: Port (default 587; use 465 for SMTPS)
- smtpUser / smtpPassword: Auth credentials (optional for some servers)
- smtpFromEmail: From address for outgoing mail

If SMTP is not configured, registration and password reset codes are logged instead of emailed. Assignment notification emails are skipped.

## Usage

- Registration: EmailService.sendRegistrationCode - called by EmailIdp when a user requests a verification code
- Password reset: EmailService.sendPasswordResetCode - called by EmailIdp when a user requests a reset code
- Training notifications: AssignmentNotificationWorker - sends reminder/overdue emails when assignments match the notification ladder (-30d, -14d, -7d, -3d, due, +1d, +3d, +7d, +14d)

## Testing

Without SMTP config, codes are logged to the server console. Use a local SMTP relay (e.g. MailHog, Mailpit) for development.
