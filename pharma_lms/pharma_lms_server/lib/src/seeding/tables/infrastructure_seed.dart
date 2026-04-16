import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../seed_context.dart';

/// Seeds facilities, certificate templates, system configuration,
/// competencies, user competencies, notification templates,
/// feature flags, and scheduled job logs.
class InfrastructureSeed {
  // ── Facilities ────────────────────────────────────────────────────────────
  static Future<List<int>> insertFacilities(
    Session session,
    SeedContext ctx,
  ) async {
    final facilities = <({String name, String code, int maxCap, bool validated})>[
      (name: 'Training Room A — Mumbai HQ', code: 'MUM-TRA', maxCap: 40, validated: true),
      (name: 'Training Room B — Mumbai HQ', code: 'MUM-TRB', maxCap: 20, validated: true),
      (name: 'Cleanroom Training Suite — Pune', code: 'PUN-CTS', maxCap: 12, validated: true),
      (name: 'Conference Hall B — Hyderabad', code: 'HYD-CHB', maxCap: 50, validated: false),
      (name: 'Virtual Training Lab', code: 'VTL-001', maxCap: 200, validated: false),
      (name: 'API Training Bay — Ahmedabad', code: 'AHM-ATB', maxCap: 15, validated: true),
    ];
    final ids = <int>[];
    for (final f in facilities) {
      final row = await Facility.db.insertRow(
        session,
        Facility(
          organizationId: ctx.orgId,
          name: f.name,
          code: f.code,
          maxCapacity: f.maxCap,
          isValidatedSpace: f.validated,
        ),
      );
      ids.add(row.id!);
    }
    return ids;
  }

  // ── Certificate Templates ─────────────────────────────────────────────────
  static Future<void> insertCertificateTemplates(
    Session session,
    SeedContext ctx,
  ) async {
    await CertificateTemplate.db.insertRow(
      session,
      CertificateTemplate(
        organizationId: ctx.orgId,
        name: 'Standard GxP Certificate',
        htmlTemplate: '''<div style="border:2px solid #1a237e;padding:40px;text-align:center;font-family:Georgia,serif;">
  <h1 style="color:#1a237e;">PharmaTech India Pvt Ltd</h1>
  <h2>Certificate of Completion</h2>
  <p style="font-size:18px;">This certifies that</p>
  <h3 style="color:#0d47a1;">{{learner_name}}</h3>
  <p>has successfully completed</p>
  <h3>{{course_title}} ({{course_version}})</h3>
  <p>Score: {{score}}% | Completed: {{completion_date}}</p>
  <p style="margin-top:30px;">Certificate ID: {{certificate_id}}</p>
  <p>Verified by electronic signature — 21 CFR Part 11 compliant</p>
</div>''',
        isDefault: true,
      ),
    );

    await CertificateTemplate.db.insertRow(
      session,
      CertificateTemplate(
        organizationId: ctx.orgId,
        name: 'EHS Safety Certificate',
        htmlTemplate: '''<div style="border:3px solid #e65100;padding:40px;text-align:center;font-family:Arial,sans-serif;">
  <h1 style="color:#e65100;">⚠ SAFETY TRAINING CERTIFICATE</h1>
  <h2>PharmaTech India Pvt Ltd</h2>
  <p>{{learner_name}} has completed {{course_title}}</p>
  <p>Valid until: {{expiry_date}}</p>
  <p>QR: {{qr_code}}</p>
</div>''',
        isDefault: false,
      ),
    );
  }

  // ── Competencies & User Competencies ──────────────────────────────────────
  static Future<void> insertCompetencies(
    Session session,
    SeedContext ctx,
  ) async {
    final competencies = <({String name, String code, int level})>[
      (name: 'GMP Fundamentals', code: 'COMP-GMP', level: 1),
      (name: 'Aseptic Processing', code: 'COMP-ASEP', level: 2),
      (name: 'Data Integrity (ALCOA+)', code: 'COMP-DI', level: 1),
      (name: 'Root Cause Analysis', code: 'COMP-RCA', level: 2),
      (name: 'Regulatory Compliance', code: 'COMP-REG', level: 3),
      (name: 'Equipment Qualification', code: 'COMP-EQ', level: 2),
      (name: 'Environmental Monitoring', code: 'COMP-EM', level: 2),
      (name: 'Documentation Practices', code: 'COMP-DOC', level: 1),
    ];

    final compIds = <int>[];
    for (final c in competencies) {
      final row = await Competency.db.insertRow(
        session,
        Competency(name: c.name, code: c.code, level: c.level),
      );
      compIds.add(row.id!);
    }

    // Link competencies to courses
    for (var ci = 0; ci < ctx.courseIds.length && ci < compIds.length; ci++) {
      await CourseCompetency.db.insertRow(
        session,
        CourseCompetency(courseId: ctx.courseIds[ci], competencyId: compIds[ci]),
      );
    }

    // Grant competencies to completed learners (first 40 learners)
    for (var li = 0; li < 40 && li < ctx.learnerIds.length; li++) {
      final compIdx = li % compIds.length;
      await UserCompetency.db.insertRow(
        session,
        UserCompetency(
          userId: ctx.learnerIds[li],
          competencyId: compIds[compIdx],
          achievedAt: ctx.dt(-60 + li),
          expiresAt: ctx.dt(305 + li),
        ),
      );
    }
  }

  // ── Notification Templates ────────────────────────────────────────────────
  static Future<void> insertNotificationTemplates(
    Session session,
    SeedContext ctx,
  ) async {
    final templates = <({
      String name,
      String type,
      String channel,
      String? triggerEvent,
      String? subject,
      String bodyTemplate,
    })>[
      (
        name: 'Training Assignment',
        type: 'assignment',
        channel: 'email',
        triggerEvent: 'training_assigned',
        subject: 'New Training Assignment: {{course_title}}',
        bodyTemplate: 'Dear {{learner_name}},\n\nYou have been assigned {{course_title}}.\nDue date: {{due_date}}\nPriority: {{priority}}\n\nPlease log in to the LMS to begin.',
      ),
      (
        name: 'Overdue Reminder',
        type: 'overdue_employee',
        channel: 'email',
        triggerEvent: 'training_overdue',
        subject: 'OVERDUE: {{course_title}} — Action Required',
        bodyTemplate: 'Dear {{learner_name}},\n\nYour training {{course_title}} is overdue (was due {{due_date}}).\nPlease complete immediately to maintain compliance.\n\nThis is an automated compliance notification.',
      ),
      (
        name: 'Certificate Issued',
        type: 'certificate_issued',
        channel: 'in_app',
        triggerEvent: 'certificate_generated',
        subject: null,
        bodyTemplate: 'Congratulations! Your certificate for {{course_title}} has been issued. View it in My Certificates.',
      ),
      (
        name: 'Certificate Expiry 30-Day Warning',
        type: 'cert_expiring',
        channel: 'email',
        triggerEvent: 'cert_expiry_30d',
        subject: 'Certificate Expiring: {{course_title}}',
        bodyTemplate: 'Your certificate for {{course_title}} expires on {{expiry_date}}. Retraining may be required.',
      ),
      (
        name: 'QA Approval Request',
        type: 'qa_review_request',
        channel: 'in_app',
        triggerEvent: 'course_submitted_for_qa',
        subject: null,
        bodyTemplate: '{{course_title}} v{{version}} has been submitted for QA review by {{trainer_name}}.',
      ),
      (
        name: 'CAPA Training Required',
        type: 'capa_training',
        channel: 'email',
        triggerEvent: 'capa_training_required',
        subject: 'CAPA Training Required: {{capa_title}}',
        bodyTemplate: 'A CAPA ({{capa_title}}) requires training completion. Please complete the assigned training by {{due_date}}.',
      ),
    ];

    for (final t in templates) {
      await NotificationTemplate.db.insertRow(
        session,
        NotificationTemplate(
          organizationId: ctx.orgId,
          name: t.name,
          type: t.type,
          channel: t.channel,
          triggerEvent: t.triggerEvent,
          subject: t.subject,
          bodyTemplate: t.bodyTemplate,
          status: 'active',
          createdById: ctx.adminUserIds.isNotEmpty
              ? ctx.adminUserIds[0]
              : ctx.trainerIds[0],
        ),
      );
    }
  }

  // ── System Configuration ──────────────────────────────────────────────────
  static Future<void> insertSystemConfiguration(
    Session session,
    SeedContext ctx,
  ) async {
    final configs = <({String key, String value})>[
      (key: 'password_policy.min_length', value: '12'),
      (key: 'password_policy.require_special_char', value: 'true'),
      (key: 'password_policy.max_age_days', value: '90'),
      (key: 'session.timeout_minutes', value: '30'),
      (key: 'session.max_concurrent', value: '3'),
      (key: 'mfa.enforcement', value: 'required_for_admin'),
      (key: 'training.default_due_days', value: '30'),
      (key: 'training.overdue_grace_days', value: '7'),
      (key: 'certificate.default_validity_days', value: '365'),
      (key: 'certificate.expiry_reminder_days', value: '30,60,90'),
      (key: 'audit.retention_years', value: '7'),
      (key: 'audit.integrity_check_schedule', value: 'daily'),
      (key: 'compliance.target_rate', value: '95.0'),
      (key: 'email.from_address', value: 'noreply@pharmatech.in'),
      (key: 'email.smtp_host', value: 'smtp.pharmatech.in'),
    ];

    for (final c in configs) {
      await SystemConfiguration.db.insertRow(
        session,
        SystemConfiguration(
          key: c.key,
          value: c.value,
          organizationId: ctx.orgId,
        ),
      );
    }
  }

  // ── Feature Flags ─────────────────────────────────────────────────────────
  static Future<void> insertFeatureFlags(
    Session session,
    SeedContext ctx,
  ) async {
    final flags = <({String key, bool enabled})>[
      (key: 'enable_e_signatures', enabled: true),
      (key: 'enable_mfa', enabled: true),
      (key: 'enable_scorm', enabled: false),
      (key: 'enable_gamification', enabled: false),
      (key: 'enable_ai_recommendations', enabled: false),
      (key: 'enable_video_proctoring', enabled: true),
      (key: 'enable_bulk_import', enabled: true),
      (key: 'enable_sso', enabled: true),
    ];

    for (final f in flags) {
      await FeatureFlag.db.insertRow(
        session,
        FeatureFlag(
          key: f.key,
          enabled: f.enabled,
          organizationId: ctx.orgId,
        ),
      );
    }
  }

  // ── Scheduled Job Logs ────────────────────────────────────────────────────
  static Future<void> insertScheduledJobLogs(
    Session session,
    SeedContext ctx,
  ) async {
    final jobs = <({
      String jobName,
      int offsetDays,
      String status,
      int? recordsProcessed,
      int? recordsAffected,
    })>[
      (jobName: 'CertExpiryCheck', offsetDays: -1, status: 'completed', recordsProcessed: 240, recordsAffected: 8),
      (jobName: 'CertExpiryCheck', offsetDays: -2, status: 'completed', recordsProcessed: 238, recordsAffected: 5),
      (jobName: 'ComplianceCalc', offsetDays: -1, status: 'completed', recordsProcessed: 120, recordsAffected: 120),
      (jobName: 'ComplianceCalc', offsetDays: -2, status: 'completed', recordsProcessed: 118, recordsAffected: 118),
      (jobName: 'AuditIntegrityCheck', offsetDays: -1, status: 'completed', recordsProcessed: 500, recordsAffected: 0),
      (jobName: 'OverdueNotifier', offsetDays: -1, status: 'completed', recordsProcessed: 15, recordsAffected: 15),
      (jobName: 'RetentionArchiver', offsetDays: -7, status: 'completed', recordsProcessed: 0, recordsAffected: 0),
      (jobName: 'SnapshotGenerator', offsetDays: 0, status: 'running', recordsProcessed: null, recordsAffected: null),
    ];

    for (final j in jobs) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: j.jobName,
          startedAt: ctx.dt(j.offsetDays),
          completedAt: j.status == 'completed' ? ctx.dt(j.offsetDays) : null,
          status: j.status,
          recordsProcessed: j.recordsProcessed,
          recordsAffected: j.recordsAffected,
        ),
      );
    }
  }

  // ── Retention Policies ────────────────────────────────────────────────────
  static Future<void> insertRetentionPolicies(Session session) async {
    final policies = <({String entityType, int years, bool archive})>[
      (entityType: 'audit_trail', years: 7, archive: true),
      (entityType: 'training_record', years: 7, archive: true),
      (entityType: 'electronic_signature', years: 7, archive: true),
      (entityType: 'access_log', years: 3, archive: true),
      (entityType: 'notification', years: 2, archive: false),
      (entityType: 'assessment_attempt', years: 5, archive: true),
    ];

    for (final p in policies) {
      await RetentionPolicy.db.insertRow(
        session,
        RetentionPolicy(
          entityType: p.entityType,
          retentionYears: p.years,
          archiveEnabled: p.archive,
        ),
      );
    }
  }
}
