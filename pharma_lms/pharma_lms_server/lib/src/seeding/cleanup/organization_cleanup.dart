import 'package:serverpod/serverpod.dart';

/// Deletes org-scoped data before re-seeding. Table/column names must match
/// applied migrations ([definition.sql]).
class OrganizationCleanup {
  static const _cvInOrg =
      r'"courseVersionId" IN (SELECT cv.id FROM course_version cv INNER JOIN course c ON cv."courseId" = c.id WHERE c."organizationId" = @orgId)';

  static Future<void> deleteExistingOrgData(Session session, int orgId) async {
    await session.db.unsafeQuery("SET session_replication_role = 'replica'");
    try {
      final userRows = await session.db.unsafeQuery(
        'SELECT id FROM pharma_user WHERE "organizationId" = @orgId',
        parameters: QueryParameters.named({'orgId': orgId}),
      );
      final userIds = userRows
          .map((r) => r.toColumnMap()['id'])
          .whereType<int>()
          .toList();

      final orgParams = QueryParameters.named({'orgId': orgId});

      if (userIds.isNotEmpty) {
        final placeholders = <String>[];
        final params = <String, dynamic>{};
        for (var i = 0; i < userIds.length; i++) {
          final key = 'u$i';
          placeholders.add('@$key');
          params[key] = userIds[i];
        }
        final inClause = placeholders.join(',');
        final userParams = QueryParameters.named(params);

        // ── User-FK tables ──────────────────────────────────────────────
        await session.db.unsafeQuery(
          'DELETE FROM delegated_authority WHERE "delegatorId" IN ($inClause) OR "delegateeId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          r'''DELETE FROM notification_log WHERE "notificationId" IN (
            SELECT id FROM notification WHERE "userId" IN (''' +
              inClause +
              r'''))''',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM training_expiration WHERE "certificateId" IN (SELECT id FROM certificate WHERE "userId" IN ($inClause))',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM notification WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM training_record_annotation WHERE "trainingRecordId" IN (SELECT id FROM training_record WHERE "userId" IN ($inClause))',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM assessment_result WHERE "attemptId" IN (SELECT id FROM assessment_attempt WHERE "userId" IN ($inClause))',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM assessment_attempt WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM material_progress WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM certificate WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM training_record WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM enrollment WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM training_assignment WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM audit_trail WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM access_review WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM simulation_attempt WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM user_competency WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM user_preference WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM user_session WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM access_log WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM training_waiver WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM role_history WHERE "userId" IN ($inClause) OR "performedById" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM import_log WHERE "importedById" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM report_export WHERE "exportedById" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM user_role WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM learner_trainer_message WHERE "fromUserId" IN ($inClause) OR "toUserId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM sme_assignment WHERE "smeUserId" IN ($inClause) OR "invitedById" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM sme_review_comment WHERE "authorId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM observation_log WHERE "userId" IN ($inClause) OR "evaluatorId" IN ($inClause)',
          parameters: userParams,
        );
        await session.db.unsafeQuery(
          'DELETE FROM standalone_assignment_recipient WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
      }

      // ── ILT batches ───────────────────────────────────────────────────
      await session.db.unsafeQuery(
        r'''DELETE FROM batch_attendance_record WHERE "batchId" IN (
            SELECT id FROM training_batch WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM batch_announcement WHERE "batchId" IN (
            SELECT id FROM training_batch WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM live_class WHERE "batchId" IN (
            SELECT id FROM training_batch WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM training_batch_participant WHERE "batchId" IN (
            SELECT id FROM training_batch WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        'DELETE FROM training_batch WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Standalone assignments ────────────────────────────────────────
      await session.db.unsafeQuery(
        r'''DELETE FROM standalone_assignment_recipient WHERE "assignmentId" IN (
            SELECT id FROM standalone_assignment WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        'DELETE FROM standalone_assignment WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Course content (threaded tables first) ────────────────────────
      await session.db.unsafeQuery(
        'DELETE FROM sme_review_comment WHERE $_cvInOrg',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        'DELETE FROM learner_trainer_message WHERE $_cvInOrg',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM sme_assignment WHERE "courseId" IN (
            SELECT id FROM course WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM assessment_result WHERE "attemptId" IN ('
        'SELECT id FROM assessment_attempt WHERE "assessmentId" IN ('
        'SELECT id FROM assessment WHERE $_cvInOrg))',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        'DELETE FROM assessment_attempt WHERE "assessmentId" IN ('
        'SELECT id FROM assessment WHERE $_cvInOrg)',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM assignment_submission WHERE "assignmentId" IN (
            SELECT id FROM assignment WHERE "lessonId" IN (
              SELECT l.id FROM lesson l
              INNER JOIN module m ON l."moduleId" = m.id
              INNER JOIN course_version cv ON m."courseVersionId" = cv.id
              INNER JOIN course c ON cv."courseId" = c.id
              WHERE c."organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM assignment WHERE "lessonId" IN (
            SELECT l.id FROM lesson l
            INNER JOIN module m ON l."moduleId" = m.id
            INNER JOIN course_version cv ON m."courseVersionId" = cv.id
            INNER JOIN course c ON cv."courseId" = c.id
            WHERE c."organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM lesson_block WHERE "lessonId" IN (
            SELECT l.id FROM lesson l
            INNER JOIN module m ON l."moduleId" = m.id
            INNER JOIN course_version cv ON m."courseVersionId" = cv.id
            INNER JOIN course c ON cv."courseId" = c.id
            WHERE c."organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM lesson WHERE "moduleId" IN (
            SELECT m.id FROM module m
            INNER JOIN course_version cv ON m."courseVersionId" = cv.id
            INNER JOIN course c ON cv."courseId" = c.id
            WHERE c."organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM media_asset WHERE "materialId" IN (
            SELECT id FROM material WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM material_version WHERE "materialId" IN (
            SELECT id FROM material WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM module WHERE $_cvInOrg',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM course_review WHERE $_cvInOrg',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM assessment WHERE $_cvInOrg',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM curriculum_course WHERE "courseId" IN (
            SELECT id FROM course WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM course_competency WHERE "courseId" IN (
            SELECT id FROM course WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM course_sop_link WHERE "courseId" IN (
            SELECT id FROM course WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM training_matrix WHERE "courseId" IN (
            SELECT id FROM course WHERE "organizationId" = @orgId)
            OR "siteId" IN (SELECT id FROM site WHERE "organizationId" = @orgId)
            OR "jobRoleId" IN (
              SELECT jr.id FROM job_role jr
              INNER JOIN department d ON jr."departmentId" = d.id
              INNER JOIN site s ON d."siteId" = s.id
              WHERE s."organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM question WHERE "questionBankId" IN (
            SELECT id FROM question_bank WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        r'''DELETE FROM course_version WHERE "courseId" IN (
            SELECT id FROM course WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM question_bank WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM material WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM course WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM curriculum WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Analytics & compliance snapshots ──────────────────────────────
      await session.db.unsafeQuery(
        r'''DELETE FROM department_compliance_snapshot WHERE "departmentId" IN (
            SELECT d.id FROM department d
            INNER JOIN site s ON d."siteId" = s.id
            WHERE s."organizationId" = @orgId)''',
        parameters: orgParams,
      );

      // ── Quality & inspection ──────────────────────────────────────────
      await session.db.unsafeQuery(
        r'''DELETE FROM inspection_package WHERE "inspectionRecordId" IN (
            SELECT id FROM inspection_record WHERE "siteId" IN (
              SELECT id FROM site WHERE "organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM auditor_session WHERE "inspectionRecordId" IN (
            SELECT id FROM inspection_record WHERE "siteId" IN (
              SELECT id FROM site WHERE "organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM inspection_record WHERE "siteId" IN (
            SELECT id FROM site WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM capa WHERE "qualityEventId" IN (
            SELECT id FROM quality_event WHERE "siteId" IN (
              SELECT id FROM site WHERE "organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM quality_event WHERE "siteId" IN (
            SELECT id FROM site WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM inspection_report WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Documents ─────────────────────────────────────────────────────
      await session.db.unsafeQuery(
        r'''DELETE FROM approval_workflow WHERE "documentVersionId" IN (
            SELECT id FROM document_version WHERE "documentId" IN (
              SELECT id FROM document WHERE "organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM change_control WHERE "documentVersionId" IN (
            SELECT id FROM document_version WHERE "documentId" IN (
              SELECT id FROM document WHERE "organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM document_lifecycle WHERE "documentVersionId" IN (
            SELECT id FROM document_version WHERE "documentId" IN (
              SELECT id FROM document WHERE "organizationId" = @orgId))''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM document_version WHERE "documentId" IN (
            SELECT id FROM document WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        'DELETE FROM document WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Org-level config tables ───────────────────────────────────────
      final orgTablesDirect = <String>[
        'certificate_template',
        'notification_template',
        'facility',
        'system_configuration',
      ];
      for (final t in orgTablesDirect) {
        await session.db.unsafeQuery(
          'DELETE FROM $t WHERE "organizationId" = @orgId',
          parameters: orgParams,
        );
      }
      await session.db.unsafeQuery(
        'DELETE FROM feature_flag WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Electronic signatures (after all referencing tables) ──────────
      if (userIds.isNotEmpty) {
        final placeholders = <String>[];
        final params = <String, dynamic>{};
        for (var i = 0; i < userIds.length; i++) {
          final key = 'u$i';
          placeholders.add('@$key');
          params[key] = userIds[i];
        }
        final inClause = placeholders.join(',');
        final userParams = QueryParameters.named(params);
        await session.db.unsafeQuery(
          'DELETE FROM electronic_signature WHERE "userId" IN ($inClause)',
          parameters: userParams,
        );
      }

      // ── Users ─────────────────────────────────────────────────────────
      await session.db.unsafeQuery(
        'DELETE FROM pharma_user WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      // ── Org structure ─────────────────────────────────────────────────
      await session.db.unsafeQuery(
        r'''DELETE FROM job_role WHERE "departmentId" IN (
            SELECT d.id FROM department d
            INNER JOIN site s ON d."siteId" = s.id
            WHERE s."organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        r'''DELETE FROM department WHERE "siteId" IN (
            SELECT id FROM site WHERE "organizationId" = @orgId)''',
        parameters: orgParams,
      );
      await session.db.unsafeQuery(
        'DELETE FROM site WHERE "organizationId" = @orgId',
        parameters: orgParams,
      );

      await session.db.unsafeQuery(
        'DELETE FROM organization WHERE id = @orgId',
        parameters: orgParams,
      );
    } finally {
      await session.db.unsafeQuery("SET session_replication_role = 'origin'");
    }
  }
}
