/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i3;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i4;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i5;
import 'access_reviews/access_review.dart' as _i6;
import 'access_reviews/access_review_window.dart' as _i7;
import 'access_reviews/role_history.dart' as _i8;
import 'admin/bulk_import_result.dart' as _i9;
import 'admin/import_log.dart' as _i10;
import 'analytics/analytics_event.dart' as _i11;
import 'analytics/analytics_snapshot.dart' as _i12;
import 'analytics/audit_readiness_score.dart' as _i13;
import 'analytics/batch_training_analytics.dart' as _i14;
import 'analytics/compliance_metrics.dart' as _i15;
import 'analytics/compliance_trend_point.dart' as _i16;
import 'analytics/course_analytics.dart' as _i17;
import 'analytics/dashboard.dart' as _i18;
import 'analytics/department_compliance_snapshot.dart' as _i19;
import 'analytics/department_compliance_summary.dart' as _i20;
import 'analytics/report_definition.dart' as _i21;
import 'analytics/simulation_attempt.dart' as _i22;
import 'analytics/sla_breach.dart' as _i23;
import 'analytics/sla_policy.dart' as _i24;
import 'analytics/user_compliance_metrics.dart' as _i25;
import 'assessment/assessment.dart' as _i26;
import 'assessment/assessment_attempt.dart' as _i27;
import 'assessment/assessment_result.dart' as _i28;
import 'assessment/question.dart' as _i29;
import 'assessment/question_bank.dart' as _i30;
import 'audit/access_log.dart' as _i31;
import 'audit/audit_trail.dart' as _i32;
import 'audit/auditor_page_log.dart' as _i33;
import 'audit/auditor_session.dart' as _i34;
import 'audit/error_log.dart' as _i35;
import 'audit/inspection_package.dart' as _i36;
import 'audit/inspection_record.dart' as _i37;
import 'audit/report_export.dart' as _i38;
import 'audit/user_session.dart' as _i39;
import 'auth/oidc_account.dart' as _i40;
import 'auth/oidc_client_config.dart' as _i41;
import 'course/assignment.dart' as _i42;
import 'course/assignment_submission.dart' as _i43;
import 'course/competency.dart' as _i44;
import 'course/course.dart' as _i45;
import 'course/course_competency.dart' as _i46;
import 'course/course_review.dart' as _i47;
import 'course/course_sop_link.dart' as _i48;
import 'course/course_version.dart' as _i49;
import 'course/curriculum.dart' as _i50;
import 'course/curriculum_course.dart' as _i51;
import 'course/lesson.dart' as _i52;
import 'course/lesson_block.dart' as _i53;
import 'course/module.dart' as _i54;
import 'course/qa_validation_result.dart' as _i55;
import 'course/qa_validation_rule_result.dart' as _i56;
import 'course/user_competency.dart' as _i57;
import 'dashboard/dashboard_compliance_alert.dart' as _i58;
import 'dashboard/dashboard_esignature_summary.dart' as _i59;
import 'dashboard/dashboard_item.dart' as _i60;
import 'dashboard/dashboard_recent_activity.dart' as _i61;
import 'dashboard/dashboard_upcoming_due_date.dart' as _i62;
import 'dashboard/dashboard_weekly_progress.dart' as _i63;
import 'document/approval_workflow.dart' as _i64;
import 'document/document.dart' as _i65;
import 'document/document_lifecycle.dart' as _i66;
import 'document/document_version.dart' as _i67;
import 'events/dead_letter_queue.dart' as _i68;
import 'events/domain_event.dart' as _i69;
import 'events/outbox_message.dart' as _i70;
import 'future_calls_generated_models/kafka_event_processor_process_employee_created_model.dart'
    as _i71;
import 'future_calls_generated_models/kafka_event_processor_process_employee_transferred_model.dart'
    as _i72;
import 'future_calls_generated_models/kafka_event_processor_process_sop_updated_model.dart'
    as _i73;
import 'greetings/greeting.dart' as _i74;
import 'infrastructure/audit_integrity_result.dart' as _i75;
import 'infrastructure/feature_flag.dart' as _i76;
import 'infrastructure/retention_archive.dart' as _i77;
import 'infrastructure/retention_policy.dart' as _i78;
import 'infrastructure/scheduled_job_log.dart' as _i79;
import 'infrastructure/system_configuration.dart' as _i80;
import 'material/material.dart' as _i81;
import 'material/material_progress.dart' as _i82;
import 'material/material_version.dart' as _i83;
import 'material/media_asset.dart' as _i84;
import 'mfa/mfa_enroll_result.dart' as _i85;
import 'mfa/mfa_status_result.dart' as _i86;
import 'mfa/mfa_verified_session.dart' as _i87;
import 'mfa/user_mfa.dart' as _i88;
import 'notifications/in_app_notification.dart' as _i89;
import 'notifications/messaging_unread_counts.dart' as _i90;
import 'notifications/notification.dart' as _i91;
import 'notifications/notification_log.dart' as _i92;
import 'notifications/notification_template.dart' as _i93;
import 'organization/department.dart' as _i94;
import 'organization/facility.dart' as _i95;
import 'organization/job_role.dart' as _i96;
import 'organization/organization.dart' as _i97;
import 'organization/permission.dart' as _i98;
import 'organization/role.dart' as _i99;
import 'organization/site.dart' as _i100;
import 'organization/user.dart' as _i101;
import 'organization/user_preference.dart' as _i102;
import 'organization/user_role.dart' as _i103;
import 'quality/capa.dart' as _i104;
import 'quality/change_control.dart' as _i105;
import 'quality/inspection_report.dart' as _i106;
import 'quality/quality_event.dart' as _i107;
import 'security/abac_policy.dart' as _i108;
import 'security/delegated_authority.dart' as _i109;
import 'shared/electronic_signature.dart' as _i110;
import 'shared/signature_meaning.dart' as _i111;
import 'shared/signature_verification_result.dart' as _i112;
import 'sme/sme_assignment.dart' as _i113;
import 'sme/sme_review_comment.dart' as _i114;
import 'sme/sme_thread_summary.dart' as _i115;
import 'training/batch_announcement.dart' as _i116;
import 'training/batch_attendance_record.dart' as _i117;
import 'training/batch_participant_info.dart' as _i118;
import 'training/certificate.dart' as _i119;
import 'training/certificate_template.dart' as _i120;
import 'training/enrollment.dart' as _i121;
import 'training/learner_support_thread_summary.dart' as _i122;
import 'training/learner_trainer_message.dart' as _i123;
import 'training/live_class.dart' as _i124;
import 'training/observation_log.dart' as _i125;
import 'training/practical_checklist_item.dart' as _i126;
import 'training/standalone_assignment.dart' as _i127;
import 'training/standalone_assignment_recipient.dart' as _i128;
import 'training/training_assignment.dart' as _i129;
import 'training/training_batch.dart' as _i130;
import 'training/training_batch_participant.dart' as _i131;
import 'training/training_expiration.dart' as _i132;
import 'training/training_matrix.dart' as _i133;
import 'training/training_record.dart' as _i134;
import 'training/training_record_annotation.dart' as _i135;
import 'training/training_waiver.dart' as _i136;
import 'package:pharma_lms_server/src/generated/access_reviews/access_review.dart'
    as _i137;
import 'package:pharma_lms_server/src/generated/organization/user.dart'
    as _i138;
import 'package:pharma_lms_server/src/generated/organization/role.dart'
    as _i139;
import 'package:pharma_lms_server/src/generated/shared/signature_meaning.dart'
    as _i140;
import 'package:pharma_lms_server/src/generated/training/training_assignment.dart'
    as _i141;
import 'package:pharma_lms_server/src/generated/training/training_matrix.dart'
    as _i142;
import 'package:pharma_lms_server/src/generated/training/training_waiver.dart'
    as _i143;
import 'package:pharma_lms_server/src/generated/analytics/department_compliance_summary.dart'
    as _i144;
import 'package:pharma_lms_server/src/generated/analytics/report_definition.dart'
    as _i145;
import 'package:pharma_lms_server/src/generated/analytics/dashboard.dart'
    as _i146;
import 'package:pharma_lms_server/src/generated/analytics/sla_breach.dart'
    as _i147;
import 'package:pharma_lms_server/src/generated/training/certificate.dart'
    as _i148;
import 'package:pharma_lms_server/src/generated/quality/capa.dart' as _i149;
import 'package:pharma_lms_server/src/generated/analytics/compliance_trend_point.dart'
    as _i150;
import 'package:pharma_lms_server/src/generated/assessment/assessment.dart'
    as _i151;
import 'package:pharma_lms_server/src/generated/assessment/assessment_attempt.dart'
    as _i152;
import 'package:pharma_lms_server/src/generated/assessment/question.dart'
    as _i153;
import 'package:pharma_lms_server/src/generated/assessment/question_bank.dart'
    as _i154;
import 'package:pharma_lms_server/src/generated/assessment/assessment_result.dart'
    as _i155;
import 'package:pharma_lms_server/src/generated/course/assignment.dart'
    as _i156;
import 'package:pharma_lms_server/src/generated/course/assignment_submission.dart'
    as _i157;
import 'package:pharma_lms_server/src/generated/audit/audit_trail.dart'
    as _i158;
import 'package:pharma_lms_server/src/generated/audit/access_log.dart' as _i159;
import 'package:pharma_lms_server/src/generated/training/batch_announcement.dart'
    as _i160;
import 'package:pharma_lms_server/src/generated/training/certificate_template.dart'
    as _i161;
import 'package:pharma_lms_server/src/generated/course/course.dart' as _i162;
import 'package:pharma_lms_server/src/generated/course/course_version.dart'
    as _i163;
import 'package:pharma_lms_server/src/generated/course/module.dart' as _i164;
import 'package:pharma_lms_server/src/generated/course/lesson.dart' as _i165;
import 'package:pharma_lms_server/src/generated/document/document.dart'
    as _i166;
import 'package:pharma_lms_server/src/generated/document/document_version.dart'
    as _i167;
import 'package:pharma_lms_server/src/generated/document/document_lifecycle.dart'
    as _i168;
import 'package:pharma_lms_server/src/generated/audit/inspection_record.dart'
    as _i169;
import 'package:pharma_lms_server/src/generated/audit/auditor_page_log.dart'
    as _i170;
import 'package:pharma_lms_server/src/generated/audit/inspection_package.dart'
    as _i171;
import 'package:pharma_lms_server/src/generated/training/learner_trainer_message.dart'
    as _i172;
import 'package:pharma_lms_server/src/generated/training/learner_support_thread_summary.dart'
    as _i173;
import 'package:pharma_lms_server/src/generated/course/lesson_block.dart'
    as _i174;
import 'package:pharma_lms_server/src/generated/training/live_class.dart'
    as _i175;
import 'package:pharma_lms_server/src/generated/material/material_version.dart'
    as _i176;
import 'package:pharma_lms_server/src/generated/material/material.dart'
    as _i177;
import 'package:pharma_lms_server/src/generated/sme/sme_thread_summary.dart'
    as _i178;
import 'package:pharma_lms_server/src/generated/sme/sme_review_comment.dart'
    as _i179;
import 'package:pharma_lms_server/src/generated/notifications/notification.dart'
    as _i180;
import 'package:pharma_lms_server/src/generated/notifications/in_app_notification.dart'
    as _i181;
import 'package:pharma_lms_server/src/generated/notifications/notification_template.dart'
    as _i182;
import 'package:pharma_lms_server/src/generated/training/practical_checklist_item.dart'
    as _i183;
import 'package:pharma_lms_server/src/generated/training/observation_log.dart'
    as _i184;
import 'package:pharma_lms_server/src/generated/course/user_competency.dart'
    as _i185;
import 'package:pharma_lms_server/src/generated/course/competency.dart'
    as _i186;
import 'package:pharma_lms_server/src/generated/organization/organization.dart'
    as _i187;
import 'package:pharma_lms_server/src/generated/organization/site.dart'
    as _i188;
import 'package:pharma_lms_server/src/generated/organization/department.dart'
    as _i189;
import 'package:pharma_lms_server/src/generated/organization/job_role.dart'
    as _i190;
import 'package:pharma_lms_server/src/generated/infrastructure/system_configuration.dart'
    as _i191;
import 'package:pharma_lms_server/src/generated/course/course_review.dart'
    as _i192;
import 'package:pharma_lms_server/src/generated/quality/quality_event.dart'
    as _i193;
import 'package:pharma_lms_server/src/generated/quality/inspection_report.dart'
    as _i194;
import 'package:pharma_lms_server/src/generated/sme/sme_assignment.dart'
    as _i195;
import 'package:pharma_lms_server/src/generated/course/course_sop_link.dart'
    as _i196;
import 'package:pharma_lms_server/src/generated/training/standalone_assignment.dart'
    as _i197;
import 'package:pharma_lms_server/src/generated/training/standalone_assignment_recipient.dart'
    as _i198;
import 'package:pharma_lms_server/src/generated/training/training_batch.dart'
    as _i199;
import 'package:pharma_lms_server/src/generated/training/batch_participant_info.dart'
    as _i200;
import 'package:pharma_lms_server/src/generated/training/batch_attendance_record.dart'
    as _i201;
import 'package:pharma_lms_server/src/generated/training/enrollment.dart'
    as _i202;
import 'package:pharma_lms_server/src/generated/training/training_record.dart'
    as _i203;
import 'package:pharma_lms_server/src/generated/shared/electronic_signature.dart'
    as _i204;
import 'package:pharma_lms_server/src/generated/training/training_record_annotation.dart'
    as _i205;
import 'package:pharma_lms_server/src/generated/organization/user_preference.dart'
    as _i206;
export 'access_reviews/access_review.dart';
export 'access_reviews/access_review_window.dart';
export 'access_reviews/role_history.dart';
export 'admin/bulk_import_result.dart';
export 'admin/import_log.dart';
export 'analytics/analytics_event.dart';
export 'analytics/analytics_snapshot.dart';
export 'analytics/audit_readiness_score.dart';
export 'analytics/batch_training_analytics.dart';
export 'analytics/compliance_metrics.dart';
export 'analytics/compliance_trend_point.dart';
export 'analytics/course_analytics.dart';
export 'analytics/dashboard.dart';
export 'analytics/department_compliance_snapshot.dart';
export 'analytics/department_compliance_summary.dart';
export 'analytics/report_definition.dart';
export 'analytics/simulation_attempt.dart';
export 'analytics/sla_breach.dart';
export 'analytics/sla_policy.dart';
export 'analytics/user_compliance_metrics.dart';
export 'assessment/assessment.dart';
export 'assessment/assessment_attempt.dart';
export 'assessment/assessment_result.dart';
export 'assessment/question.dart';
export 'assessment/question_bank.dart';
export 'audit/access_log.dart';
export 'audit/audit_trail.dart';
export 'audit/auditor_page_log.dart';
export 'audit/auditor_session.dart';
export 'audit/error_log.dart';
export 'audit/inspection_package.dart';
export 'audit/inspection_record.dart';
export 'audit/report_export.dart';
export 'audit/user_session.dart';
export 'auth/oidc_account.dart';
export 'auth/oidc_client_config.dart';
export 'course/assignment.dart';
export 'course/assignment_submission.dart';
export 'course/competency.dart';
export 'course/course.dart';
export 'course/course_competency.dart';
export 'course/course_review.dart';
export 'course/course_sop_link.dart';
export 'course/course_version.dart';
export 'course/curriculum.dart';
export 'course/curriculum_course.dart';
export 'course/lesson.dart';
export 'course/lesson_block.dart';
export 'course/module.dart';
export 'course/qa_validation_result.dart';
export 'course/qa_validation_rule_result.dart';
export 'course/user_competency.dart';
export 'dashboard/dashboard_compliance_alert.dart';
export 'dashboard/dashboard_esignature_summary.dart';
export 'dashboard/dashboard_item.dart';
export 'dashboard/dashboard_recent_activity.dart';
export 'dashboard/dashboard_upcoming_due_date.dart';
export 'dashboard/dashboard_weekly_progress.dart';
export 'document/approval_workflow.dart';
export 'document/document.dart';
export 'document/document_lifecycle.dart';
export 'document/document_version.dart';
export 'events/dead_letter_queue.dart';
export 'events/domain_event.dart';
export 'events/outbox_message.dart';
export 'greetings/greeting.dart';
export 'infrastructure/audit_integrity_result.dart';
export 'infrastructure/feature_flag.dart';
export 'infrastructure/retention_archive.dart';
export 'infrastructure/retention_policy.dart';
export 'infrastructure/scheduled_job_log.dart';
export 'infrastructure/system_configuration.dart';
export 'material/material.dart';
export 'material/material_progress.dart';
export 'material/material_version.dart';
export 'material/media_asset.dart';
export 'mfa/mfa_enroll_result.dart';
export 'mfa/mfa_status_result.dart';
export 'mfa/mfa_verified_session.dart';
export 'mfa/user_mfa.dart';
export 'notifications/in_app_notification.dart';
export 'notifications/messaging_unread_counts.dart';
export 'notifications/notification.dart';
export 'notifications/notification_log.dart';
export 'notifications/notification_template.dart';
export 'organization/department.dart';
export 'organization/facility.dart';
export 'organization/job_role.dart';
export 'organization/organization.dart';
export 'organization/permission.dart';
export 'organization/role.dart';
export 'organization/site.dart';
export 'organization/user.dart';
export 'organization/user_preference.dart';
export 'organization/user_role.dart';
export 'quality/capa.dart';
export 'quality/change_control.dart';
export 'quality/inspection_report.dart';
export 'quality/quality_event.dart';
export 'security/abac_policy.dart';
export 'security/delegated_authority.dart';
export 'shared/electronic_signature.dart';
export 'shared/signature_meaning.dart';
export 'shared/signature_verification_result.dart';
export 'sme/sme_assignment.dart';
export 'sme/sme_review_comment.dart';
export 'sme/sme_thread_summary.dart';
export 'training/batch_announcement.dart';
export 'training/batch_attendance_record.dart';
export 'training/batch_participant_info.dart';
export 'training/certificate.dart';
export 'training/certificate_template.dart';
export 'training/enrollment.dart';
export 'training/learner_support_thread_summary.dart';
export 'training/learner_trainer_message.dart';
export 'training/live_class.dart';
export 'training/observation_log.dart';
export 'training/practical_checklist_item.dart';
export 'training/standalone_assignment.dart';
export 'training/standalone_assignment_recipient.dart';
export 'training/training_assignment.dart';
export 'training/training_batch.dart';
export 'training/training_batch_participant.dart';
export 'training/training_expiration.dart';
export 'training/training_matrix.dart';
export 'training/training_record.dart';
export 'training/training_record_annotation.dart';
export 'training/training_waiver.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'abac_policy',
      dartName: 'AbacPolicy',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'abac_policy_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ruleJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'effect',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'abac_policy_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'access_log',
      dartName: 'AccessLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'access_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ipAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'userAgent',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'success',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'access_log_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'access_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'access_review',
      dartName: 'AccessReview',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'access_review_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'windowId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'decision',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'PENDING\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'justification',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'signedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'signatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'windowOpen',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'windowClose',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'jobId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'ACTIVE\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'migrationMarker',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'access_review_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'access_review_fk_1',
          columns: ['roleId'],
          referenceTable: 'role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'access_review_fk_2',
          columns: ['reviewedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'access_review_fk_3',
          columns: ['signatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'access_review_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'access_review_window',
      dartName: 'AccessReviewWindow',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'access_review_window_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'windowId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'openDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'closeDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'totalRecords',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'jobId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'ACTIVE\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'migrationMarker',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'access_review_window_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'analytics_snapshot',
      dartName: 'AnalyticsSnapshot',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'analytics_snapshot_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'snapshotDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'totalEmployees',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'compliantCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'overdueCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'orgComplianceRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'totalCertificates',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'certsExpiring30d',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'certsExpiring60d',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'openAssignments',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledJobLogId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'analytics_snapshot_fk_0',
          columns: ['scheduledJobLogId'],
          referenceTable: 'scheduled_job_log',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'analytics_snapshot_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'approval_workflow',
      dartName: 'ApprovalWorkflow',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'approval_workflow_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'documentVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'step',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'approverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'signedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'esignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'approval_workflow_fk_0',
          columns: ['documentVersionId'],
          referenceTable: 'document_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'approval_workflow_fk_1',
          columns: ['approverId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'approval_workflow_fk_2',
          columns: ['esignatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'approval_workflow_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assessment',
      dartName: 'Assessment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'assessment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'questionBankId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'passingScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'randomize',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'timeLimitMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'maxAttempts',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'questionsToDisplay',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'showAnswers',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'showSubmissionHistory',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'limitQuestions',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_fk_0',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_fk_1',
          columns: ['questionBankId'],
          referenceTable: 'question_bank',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assessment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assessment_attempt',
      dartName: 'AssessmentAttempt',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'assessment_attempt_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'assessmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'enrollmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_attempt_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_attempt_fk_1',
          columns: ['assessmentId'],
          referenceTable: 'assessment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_attempt_fk_2',
          columns: ['enrollmentId'],
          referenceTable: 'enrollment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assessment_attempt_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assessment_result',
      dartName: 'AssessmentResult',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'assessment_result_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'attemptId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'questionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'answer',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'correct',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'points',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'needsManualGrading',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'manualScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'gradedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'gradedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_result_fk_0',
          columns: ['attemptId'],
          referenceTable: 'assessment_attempt',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_result_fk_1',
          columns: ['questionId'],
          referenceTable: 'question',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assessment_result_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assignment',
      dartName: 'Assignment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'assignment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'lessonId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'instructions',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'allowedFileTypes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assignment_fk_0',
          columns: ['lessonId'],
          referenceTable: 'lesson',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assignment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assignment_submission',
      dartName: 'AssignmentSubmission',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'assignment_submission_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'assignmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'submissionUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'storageKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'submitted\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'grade',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'feedback',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'submittedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'gradedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assignment_submission_fk_0',
          columns: ['assignmentId'],
          referenceTable: 'assignment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'assignment_submission_fk_1',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assignment_submission_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'audit_integrity_result',
      dartName: 'AuditIntegrityResult',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'audit_integrity_result_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'checkedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'recordsChecked',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'hashMismatches',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sequenceGaps',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'result',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'failureDetailsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledJobLogId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'audit_integrity_result_fk_0',
          columns: ['scheduledJobLogId'],
          referenceTable: 'scheduled_job_log',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'audit_integrity_result_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'audit_trail',
      dartName: 'AuditTrail',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'audit_trail_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'oldValueJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'newValueJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'ipAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'rowHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'audit_trail_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'audit_trail_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'auditor_page_log',
      dartName: 'AuditorPageLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'auditor_page_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'auditorSessionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pageTitle',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entityId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'viewedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'timeOnPageSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'exported',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'auditor_page_log_fk_0',
          columns: ['auditorSessionId'],
          referenceTable: 'auditor_session',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'auditor_page_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'auditor_session',
      dartName: 'AuditorSession',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'auditor_session_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'inspectionRecordId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'auditorUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'accessType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'accessToken',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tokenIssuedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'tokenExpiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'scopeStartDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'scopeEndDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'scopeSitesJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'scopeDepartmentsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'endedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'endedReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'pagesViewedCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lastActivityAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'auditor_session_fk_0',
          columns: ['inspectionRecordId'],
          referenceTable: 'inspection_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'auditor_session_fk_1',
          columns: ['auditorUserId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'auditor_session_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'batch_announcement',
      dartName: 'BatchAnnouncement',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'batch_announcement_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'batchId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'general\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'relatedLiveClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'batch_announcement_fk_0',
          columns: ['batchId'],
          referenceTable: 'training_batch',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'batch_announcement_fk_1',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'batch_announcement_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'batch_announcement_batch_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'batchId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'batch_attendance_record',
      dartName: 'BatchAttendanceRecord',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'batch_attendance_record_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'batchId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'liveClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'present\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'markedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'markedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'batch_attendance_record_fk_0',
          columns: ['batchId'],
          referenceTable: 'training_batch',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'batch_attendance_record_fk_1',
          columns: ['liveClassId'],
          referenceTable: 'live_class',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'batch_attendance_record_fk_2',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'batch_attendance_record_fk_3',
          columns: ['markedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'batch_attendance_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'capa',
      dartName: 'Capa',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'capa_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'qualityEventId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'rootCause',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'trainingRequired',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'trainingAssignmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'Initiation\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'rcaCompletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'effectivenessCheckDue',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'closedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'closedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'capa_fk_0',
          columns: ['qualityEventId'],
          referenceTable: 'quality_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'capa_fk_1',
          columns: ['trainingAssignmentId'],
          referenceTable: 'training_assignment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'capa_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'certificate',
      dartName: 'Certificate',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'certificate_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'trainingRecordId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'issuedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'qrCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'esignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'certificate_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'certificate_fk_1',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'certificate_fk_2',
          columns: ['trainingRecordId'],
          referenceTable: 'training_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'certificate_fk_3',
          columns: ['esignatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'certificate_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'certificate_template',
      dartName: 'CertificateTemplate',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'certificate_template_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'htmlTemplate',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'certificate_template_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'certificate_template_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'change_control',
      dartName: 'ChangeControl',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'change_control_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'qualityEventId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'documentVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'trainingTriggerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'change_control_fk_0',
          columns: ['qualityEventId'],
          referenceTable: 'quality_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'change_control_fk_1',
          columns: ['documentVersionId'],
          referenceTable: 'document_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'change_control_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'competency',
      dartName: 'Competency',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'competency_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'competency_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course',
      dartName: 'Course',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sopNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'draft\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'customMetadataJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'previewVideoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'disableSelfEnrollment',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'featured',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_fk_0',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_fk_1',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course_competency',
      dartName: 'CourseCompetency',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_competency_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competencyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_competency_fk_0',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_competency_fk_1',
          columns: ['competencyId'],
          referenceTable: 'competency',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_competency_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course_review',
      dartName: 'CourseReview',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_review_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reviewerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reviewType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'initial\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'decision',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'comments',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewChecklistJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'esignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_review_fk_0',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_review_fk_1',
          columns: ['reviewerId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_review_fk_2',
          columns: ['esignatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_review_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course_sop_link',
      dartName: 'CourseSopLink',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_sop_link_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'documentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'linkedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'linkedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'unlinkedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_sop_link_fk_0',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_sop_link_fk_1',
          columns: ['documentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_sop_link_fk_2',
          columns: ['linkedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_sop_link_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course_version',
      dartName: 'CourseVersion',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_version_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'effectiveDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'obsoleteDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'draft\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'supersededByVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'changeSummary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_version_fk_0',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_version_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'curriculum',
      dartName: 'Curriculum',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'curriculum_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'curriculum_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'curriculum_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'curriculum_course',
      dartName: 'CurriculumCourse',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'curriculum_course_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'curriculumId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'curriculum_course_fk_0',
          columns: ['curriculumId'],
          referenceTable: 'curriculum',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'curriculum_course_fk_1',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'curriculum_course_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dashboard',
      dartName: 'Dashboard',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dashboard_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'widgetsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dashboard_fk_0',
          columns: ['roleId'],
          referenceTable: 'role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dashboard_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dead_letter_queue',
      dartName: 'DeadLetterQueue',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dead_letter_queue_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'outboxMessageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'failedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'failureReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'retryCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'manuallyResolved',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'resolutionNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dead_letter_queue_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'delegated_authority',
      dartName: 'DelegatedAuthority',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'delegated_authority_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'delegatorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'delegateeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scope',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'delegated_authority_fk_0',
          columns: ['delegatorId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'delegated_authority_fk_1',
          columns: ['delegateeId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'delegated_authority_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'department',
      dartName: 'Department',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'department_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'department_fk_0',
          columns: ['siteId'],
          referenceTable: 'site',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'department_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'department_compliance_snapshot',
      dartName: 'DepartmentComplianceSnapshot',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'department_compliance_snapshot_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'departmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'snapshotDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'totalEmployees',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'compliantCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'overdueCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'upcomingCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'complianceRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledJobLogId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'department_compliance_snapshot_fk_0',
          columns: ['departmentId'],
          referenceTable: 'department',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'department_compliance_snapshot_fk_1',
          columns: ['scheduledJobLogId'],
          referenceTable: 'scheduled_job_log',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'department_compliance_snapshot_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'document',
      dartName: 'Document',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'document_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'documentNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'documentType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'affectedDepartmentIdsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'affectedRoleIdsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'trainingRequiredByQa',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'document_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'document_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'document_lifecycle',
      dartName: 'DocumentLifecycle',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'document_lifecycle_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'documentVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'changedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'changedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'document_lifecycle_fk_0',
          columns: ['documentVersionId'],
          referenceTable: 'document_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'document_lifecycle_fk_1',
          columns: ['changedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'document_lifecycle_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'document_version',
      dartName: 'DocumentVersion',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'document_version_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'documentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'versionMajor',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'versionMinor',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isMajorVersion',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'storageKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'effectiveDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'obsoleteDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'document_version_fk_0',
          columns: ['documentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'document_version_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'domain_event',
      dartName: 'DomainEvent',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'domain_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'eventType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'aggregateId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'payloadJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'processedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'kafkaOffset',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'domain_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'electronic_signature',
      dartName: 'ElectronicSignature',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'electronic_signature_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'signatureMeaning',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'passwordPlaintext',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'passwordReauthHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ipAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'integrityHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isValid',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'revokedReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'revokedBySignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'electronic_signature_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'electronic_signature_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'enrollment',
      dartName: 'Enrollment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'enrollment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'assignmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'not_started\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'retrainingChangeSummary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'acknowledgedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'acknowledgementEsignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'enrollment_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'enrollment_fk_1',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'enrollment_fk_2',
          columns: ['assignmentId'],
          referenceTable: 'training_assignment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'enrollment_fk_3',
          columns: ['acknowledgementEsignatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'enrollment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'error_log',
      dartName: 'ErrorLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'error_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'stackTrace',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'contextJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'error_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'facility',
      dartName: 'Facility',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'facility_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'maxCapacity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '10',
        ),
        _i2.ColumnDefinition(
          name: 'isValidatedSpace',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'facility_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'facility_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_flag',
      dartName: 'FeatureFlag',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'feature_flag_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_flag_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_flag_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'import_log',
      dartName: 'ImportLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'import_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'importedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'importType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'filename',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'recordCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'successCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'failureCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'failureDetailsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'importedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'import_log_fk_0',
          columns: ['importedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'import_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'inspection_package',
      dartName: 'InspectionPackage',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'inspection_package_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'inspectionRecordId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'generatedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'generatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'scopeDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'includedRecordsCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'fileHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'storageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'watermarkText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isOfficial',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'officialEsignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_package_fk_0',
          columns: ['inspectionRecordId'],
          referenceTable: 'inspection_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_package_fk_1',
          columns: ['generatedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_package_fk_2',
          columns: ['officialEsignatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'inspection_package_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'inspection_record',
      dartName: 'InspectionRecord',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'inspection_record_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'inspectionType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'inspectorNames',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'scopeDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'scheduled\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'inspectionAccessToken',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tokenExpiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'briefingPackHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'briefingPackGeneratedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'outcome',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'findingsCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_record_fk_0',
          columns: ['siteId'],
          referenceTable: 'site',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_record_fk_1',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'inspection_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'inspection_report',
      dartName: 'InspectionReport',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'inspection_report_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'inspector',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'inspectionDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'findingsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_report_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'inspection_report_fk_1',
          columns: ['siteId'],
          referenceTable: 'site',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'inspection_report_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'job_role',
      dartName: 'JobRole',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'job_role_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'departmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'trainingMatrixJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'job_role_fk_0',
          columns: ['departmentId'],
          referenceTable: 'department',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'job_role_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'learner_trainer_message',
      dartName: 'LearnerTrainerMessage',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'learner_trainer_message_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'toUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'parentMessageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'learner_trainer_message_fk_0',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'learner_trainer_message_fk_1',
          columns: ['fromUserId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'learner_trainer_message_fk_2',
          columns: ['toUserId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'learner_trainer_message_fk_3',
          columns: ['parentMessageId'],
          referenceTable: 'learner_trainer_message',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'learner_trainer_message_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'learner_trainer_cv_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'courseVersionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'learner_trainer_from_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fromUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'learner_trainer_to_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'readAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'learner_trainer_to_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson',
      dartName: 'Lesson',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'moduleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'materialId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'durationMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'lessonType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'minEngagementMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'prerequisiteMode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'instructorNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'includeInPreview',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_fk_0',
          columns: ['moduleId'],
          referenceTable: 'module',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_fk_1',
          columns: ['materialId'],
          referenceTable: 'material',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lesson_block',
      dartName: 'LessonBlock',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lesson_block_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'lessonId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'blockType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'contentJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lesson_block_fk_0',
          columns: ['lessonId'],
          referenceTable: 'lesson',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lesson_block_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'live_class',
      dartName: 'LiveClass',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'live_class_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'batchId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'durationMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _i2.ColumnDefinition(
          name: 'meetingUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'autoRecording',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'live_class_fk_0',
          columns: ['batchId'],
          referenceTable: 'training_batch',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'live_class_fk_1',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'live_class_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'material',
      dartName: 'Material',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'material_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'materialType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'storageKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'contentUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'material_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'material_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'material_progress',
      dartName: 'MaterialProgress',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'material_progress_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'materialId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'progressPct',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'interactionJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'materialVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'enrollmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'timeSpentSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'lastHeartbeat',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'readTimeMet',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'material_progress_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'material_progress_fk_1',
          columns: ['materialId'],
          referenceTable: 'material',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'material_progress_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'material_version',
      dartName: 'MaterialVersion',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'material_version_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'materialId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'storageKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'fileHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'virusScanStatus',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'virusScanAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'fileSizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'material_version_fk_0',
          columns: ['materialId'],
          referenceTable: 'material',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'material_version_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'media_asset',
      dartName: 'MediaAsset',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'media_asset_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'materialId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'assetType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'url',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'durationSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'media_asset_fk_0',
          columns: ['materialId'],
          referenceTable: 'material',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'media_asset_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'mfa_verified_session',
      dartName: 'MfaVerifiedSession',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'mfa_verified_session_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'verifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'mfa_verified_session_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'module',
      dartName: 'Module',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'module_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'module_fk_0',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'module_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'notification',
      dartName: 'Notification',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'notification_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'enrollmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryStatus',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'channel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'in_app\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'notification_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'notification_fk_1',
          columns: ['enrollmentId'],
          referenceTable: 'enrollment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'notification_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'notification_log',
      dartName: 'NotificationLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'notification_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'notificationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'attemptedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'channel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'sent\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'errorMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'retryCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'externalMessageId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'notification_log_fk_0',
          columns: ['notificationId'],
          referenceTable: 'notification',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'notification_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'notification_template',
      dartName: 'NotificationTemplate',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'notification_template_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'channel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'email\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'triggerEvent',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'subject',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'bodyTemplate',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'draft\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'notification_template_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'notification_template_fk_1',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'notification_template_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'observation_log',
      dartName: 'ObservationLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'observation_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'evaluatorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competencyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'checklistItemId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'result',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'observedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'evaluatorEsignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'traineeEsignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'observation_log_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'observation_log_fk_1',
          columns: ['evaluatorId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'observation_log_fk_2',
          columns: ['competencyId'],
          referenceTable: 'competency',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'observation_log_fk_3',
          columns: ['checklistItemId'],
          referenceTable: 'practical_checklist_item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'observation_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'oidc_account',
      dartName: 'OidcAccount',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'oidc_account_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'providerId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'oidc_account_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'oidc_account_provider_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'providerId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'organization',
      dartName: 'Organization',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'organization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'organization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'outbox_message',
      dartName: 'OutboxMessage',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'outbox_message_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'topic',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'payloadJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'sentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'retryCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lastError',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'outbox_message_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'permission',
      dartName: 'Permission',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'permission_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'resource',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'permission_fk_0',
          columns: ['roleId'],
          referenceTable: 'role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'permission_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pharma_user',
      dartName: 'PharmaUser',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pharma_user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'firstName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'departmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'jobRoleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'employeeId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hireDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'managerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'preferredLanguage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timezone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
          columnDefault: '\'UTC\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'lastLogin',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'authType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'mfaEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'compliancePercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'roles',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'customMetadataJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'biometricCredentialId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pharma_user_fk_0',
          columns: ['departmentId'],
          referenceTable: 'department',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pharma_user_fk_1',
          columns: ['jobRoleId'],
          referenceTable: 'job_role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pharma_user_fk_2',
          columns: ['siteId'],
          referenceTable: 'site',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pharma_user_fk_3',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pharma_user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'practical_checklist_item',
      dartName: 'PracticalChecklistItem',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'practical_checklist_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'competencyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isCritical',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'practical_checklist_item_fk_0',
          columns: ['competencyId'],
          referenceTable: 'competency',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'practical_checklist_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'quality_event',
      dartName: 'QualityEvent',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quality_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'eventType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'referenceId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'quality_event_fk_0',
          columns: ['siteId'],
          referenceTable: 'site',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'quality_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'question',
      dartName: 'Question',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'question_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'questionBankId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'questionType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'optionsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'correctAnswer',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'difficulty',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'regulatoryTag',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'question_fk_0',
          columns: ['questionBankId'],
          referenceTable: 'question_bank',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'question_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'question_bank',
      dartName: 'QuestionBank',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'question_bank_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'tagsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'questions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Question>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'question_bank_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'question_bank_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'report_definition',
      dartName: 'ReportDefinition',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'report_definition_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'reportType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'querySql',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'paramsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'report_definition_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'report_export',
      dartName: 'ReportExport',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'report_export_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'exportedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reportType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'filterParamsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'recordCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'fileHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'storageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'watermarkText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'exportedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'report_export_fk_0',
          columns: ['exportedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'report_export_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'retention_archive',
      dartName: 'RetentionArchive',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'retention_archive_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'rowJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'archivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'retention_archive_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'retention_policy',
      dartName: 'RetentionPolicy',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'retention_policy_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'retentionYears',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '7',
        ),
        _i2.ColumnDefinition(
          name: 'archiveEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'lastArchivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'retention_policy_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'role',
      dartName: 'Role',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'role_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'role_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'role_history',
      dartName: 'RoleHistory',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'role_history_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'performedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'grantRecordId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'ipAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hmacHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'migrationMarker',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'role_history_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'role_history_fk_1',
          columns: ['roleId'],
          referenceTable: 'role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'role_history_fk_2',
          columns: ['performedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'role_history_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'scheduled_job_log',
      dartName: 'ScheduledJobLog',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'scheduled_job_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'jobName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'running\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'recordsProcessed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'recordsAffected',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'errorDetails',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'scheduled_job_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'signature_meaning',
      dartName: 'SignatureMeaning',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'signature_meaning_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'meaning',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'applicableTo',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'signature_meaning_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'simulation_attempt',
      dartName: 'SimulationAttempt',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'simulation_attempt_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scenarioTitle',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scorePercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'metricsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'simulation_attempt_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'simulation_attempt_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'site',
      dartName: 'Site',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'site_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timezone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'UTC\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'site_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'site_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'sla_breach',
      dartName: 'SlaBreach',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'sla_breach_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'slaPolicyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'breachedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'sla_breach_fk_0',
          columns: ['slaPolicyId'],
          referenceTable: 'sla_policy',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'sla_breach_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'sla_policy',
      dartName: 'SlaPolicy',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'sla_policy_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'metric',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'threshold',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'alertRoleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'sla_policy_fk_0',
          columns: ['alertRoleId'],
          referenceTable: 'role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'sla_policy_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'sme_assignment',
      dartName: 'SmeAssignment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'sme_assignment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'smeUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'invitedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'invited\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'invitedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_assignment_fk_0',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_assignment_fk_1',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_assignment_fk_2',
          columns: ['smeUserId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_assignment_fk_3',
          columns: ['invitedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'sme_assignment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'sme_assignment_course_sme_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'courseId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'smeUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'sme_review_comment',
      dartName: 'SmeReviewComment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'sme_review_comment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'authorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sectionRef',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'severity',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'note\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'resolved',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'trainerResponse',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'parentCommentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_review_comment_fk_0',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_review_comment_fk_1',
          columns: ['authorId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'sme_review_comment_fk_2',
          columns: ['parentCommentId'],
          referenceTable: 'sme_review_comment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'sme_review_comment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'sme_comment_cv_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'courseVersionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'sme_comment_author_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authorId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'standalone_assignment',
      dartName: 'StandaloneAssignment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'standalone_assignment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'instructions',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'dueAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'contentKind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'open_ended\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'questionBankId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'individual\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'targetDepartmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'targetBatchId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'draft\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'assignedByType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'standalone_assignment_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'standalone_assignment_fk_1',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'standalone_assignment_fk_2',
          columns: ['questionBankId'],
          referenceTable: 'question_bank',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'standalone_assignment_fk_3',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'standalone_assignment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'standalone_assignment_org_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'dueAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'standalone_assignment_recipient',
      dartName: 'StandaloneAssignmentRecipient',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'standalone_assignment_recipient_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'assignmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'submittedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'responseJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'grade',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'feedback',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'gradedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'gradedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'standalone_assignment_recipient_fk_0',
          columns: ['assignmentId'],
          referenceTable: 'standalone_assignment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'standalone_assignment_recipient_fk_1',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'standalone_assignment_recipient_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'standalone_assignment_recipient_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'assignmentId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'standalone_assignment_recipient_assignment_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'assignmentId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'system_configuration',
      dartName: 'SystemConfiguration',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'system_configuration_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'system_configuration_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'system_configuration_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_assignment',
      dartName: 'TrainingAssignment',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_assignment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'assignedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'assignedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'dueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'medium\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'manual\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'assignmentType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'individual\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'targetRoleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'targetDepartmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'targetUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'cancellationReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_assignment_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_assignment_fk_1',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_assignment_fk_2',
          columns: ['assignedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_assignment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_batch',
      dartName: 'TrainingBatch',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_batch_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'instructorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'capacity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _i2.ColumnDefinition(
          name: 'enrolledCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'completedCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'scheduled\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'facilityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'endTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'medium',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'meetingUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_batch_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_batch_fk_1',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_batch_fk_2',
          columns: ['instructorId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_batch_fk_3',
          columns: ['facilityId'],
          referenceTable: 'facility',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_batch_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_batch_participant',
      dartName: 'TrainingBatchParticipant',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'training_batch_participant_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'batchId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'enrolledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_batch_participant_fk_0',
          columns: ['batchId'],
          referenceTable: 'training_batch',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_batch_participant_fk_1',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_batch_participant_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'batch_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'batchId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_expiration',
      dartName: 'TrainingExpiration',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_expiration_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'certificateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'reminderSentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'renewalAssignmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'expiryStage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_expiration_fk_0',
          columns: ['certificateId'],
          referenceTable: 'certificate',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_expiration_fk_1',
          columns: ['renewalAssignmentId'],
          referenceTable: 'training_assignment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_expiration_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_matrix',
      dartName: 'TrainingMatrix',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_matrix_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'jobRoleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isMandatory',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'dueDaysFromHire',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _i2.ColumnDefinition(
          name: 'retrainingIntervalDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'approvedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'effectiveDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_matrix_fk_0',
          columns: ['jobRoleId'],
          referenceTable: 'job_role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_matrix_fk_1',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_matrix_fk_2',
          columns: ['siteId'],
          referenceTable: 'site',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_matrix_fk_3',
          columns: ['createdById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_matrix_fk_4',
          columns: ['approvedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_matrix_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_record',
      dartName: 'TrainingRecord',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_record_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'enrollmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'esignatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_record_fk_0',
          columns: ['enrollmentId'],
          referenceTable: 'enrollment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_record_fk_1',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_record_fk_2',
          columns: ['courseVersionId'],
          referenceTable: 'course_version',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_record_fk_3',
          columns: ['esignatureId'],
          referenceTable: 'electronic_signature',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_record_annotation',
      dartName: 'TrainingRecordAnnotation',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'training_record_annotation_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'trainingRecordId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'authorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_record_annotation_fk_0',
          columns: ['trainingRecordId'],
          referenceTable: 'training_record',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_record_annotation_fk_1',
          columns: ['authorId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_record_annotation_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_waiver',
      dartName: 'TrainingWaiver',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_waiver_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'requestedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'requestedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'requestReason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'evidenceStoragePath',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'approvedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'approvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'rejectionReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_waiver_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_waiver_fk_1',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_waiver_fk_2',
          columns: ['requestedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_waiver_fk_3',
          columns: ['approvedById'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_waiver_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_competency',
      dartName: 'UserCompetency',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_competency_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'competencyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'achievedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_competency_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_competency_fk_1',
          columns: ['competencyId'],
          referenceTable: 'competency',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_competency_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_mfa',
      dartName: 'UserMfa',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_mfa_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mfaSecretBase32',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mfaEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'enrolledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_mfa_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_preference',
      dartName: 'UserPreference',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_preference_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'preferenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'preferenceValue',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_preference_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_preference_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_role',
      dartName: 'UserRole',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_role_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_role_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_role_fk_1',
          columns: ['roleId'],
          referenceTable: 'role',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_role_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_session',
      dartName: 'UserSession',
      schema: 'public',
      module: 'pharma_lms',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_session_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'endedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'ipAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'userAgent',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceFingerprint',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'endReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isMfaVerified',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_session_fk_0',
          columns: ['userId'],
          referenceTable: 'pharma_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_session_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i5.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i6.AccessReview) {
      return _i6.AccessReview.fromJson(data) as T;
    }
    if (t == _i7.AccessReviewWindow) {
      return _i7.AccessReviewWindow.fromJson(data) as T;
    }
    if (t == _i8.RoleHistory) {
      return _i8.RoleHistory.fromJson(data) as T;
    }
    if (t == _i9.BulkImportResult) {
      return _i9.BulkImportResult.fromJson(data) as T;
    }
    if (t == _i10.ImportLog) {
      return _i10.ImportLog.fromJson(data) as T;
    }
    if (t == _i11.AnalyticsEvent) {
      return _i11.AnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i12.AnalyticsSnapshot) {
      return _i12.AnalyticsSnapshot.fromJson(data) as T;
    }
    if (t == _i13.AuditReadinessScore) {
      return _i13.AuditReadinessScore.fromJson(data) as T;
    }
    if (t == _i14.BatchTrainingAnalytics) {
      return _i14.BatchTrainingAnalytics.fromJson(data) as T;
    }
    if (t == _i15.ComplianceMetrics) {
      return _i15.ComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i16.ComplianceTrendPoint) {
      return _i16.ComplianceTrendPoint.fromJson(data) as T;
    }
    if (t == _i17.CourseAnalytics) {
      return _i17.CourseAnalytics.fromJson(data) as T;
    }
    if (t == _i18.Dashboard) {
      return _i18.Dashboard.fromJson(data) as T;
    }
    if (t == _i19.DepartmentComplianceSnapshot) {
      return _i19.DepartmentComplianceSnapshot.fromJson(data) as T;
    }
    if (t == _i20.DepartmentComplianceSummary) {
      return _i20.DepartmentComplianceSummary.fromJson(data) as T;
    }
    if (t == _i21.ReportDefinition) {
      return _i21.ReportDefinition.fromJson(data) as T;
    }
    if (t == _i22.SimulationAttempt) {
      return _i22.SimulationAttempt.fromJson(data) as T;
    }
    if (t == _i23.SlaBreach) {
      return _i23.SlaBreach.fromJson(data) as T;
    }
    if (t == _i24.SlaPolicy) {
      return _i24.SlaPolicy.fromJson(data) as T;
    }
    if (t == _i25.UserComplianceMetrics) {
      return _i25.UserComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i26.Assessment) {
      return _i26.Assessment.fromJson(data) as T;
    }
    if (t == _i27.AssessmentAttempt) {
      return _i27.AssessmentAttempt.fromJson(data) as T;
    }
    if (t == _i28.AssessmentResult) {
      return _i28.AssessmentResult.fromJson(data) as T;
    }
    if (t == _i29.Question) {
      return _i29.Question.fromJson(data) as T;
    }
    if (t == _i30.QuestionBank) {
      return _i30.QuestionBank.fromJson(data) as T;
    }
    if (t == _i31.AccessLog) {
      return _i31.AccessLog.fromJson(data) as T;
    }
    if (t == _i32.AuditTrail) {
      return _i32.AuditTrail.fromJson(data) as T;
    }
    if (t == _i33.AuditorPageLog) {
      return _i33.AuditorPageLog.fromJson(data) as T;
    }
    if (t == _i34.AuditorSession) {
      return _i34.AuditorSession.fromJson(data) as T;
    }
    if (t == _i35.ErrorLog) {
      return _i35.ErrorLog.fromJson(data) as T;
    }
    if (t == _i36.InspectionPackage) {
      return _i36.InspectionPackage.fromJson(data) as T;
    }
    if (t == _i37.InspectionRecord) {
      return _i37.InspectionRecord.fromJson(data) as T;
    }
    if (t == _i38.ReportExport) {
      return _i38.ReportExport.fromJson(data) as T;
    }
    if (t == _i39.UserSession) {
      return _i39.UserSession.fromJson(data) as T;
    }
    if (t == _i40.OidcAccount) {
      return _i40.OidcAccount.fromJson(data) as T;
    }
    if (t == _i41.OidcClientConfig) {
      return _i41.OidcClientConfig.fromJson(data) as T;
    }
    if (t == _i42.Assignment) {
      return _i42.Assignment.fromJson(data) as T;
    }
    if (t == _i43.AssignmentSubmission) {
      return _i43.AssignmentSubmission.fromJson(data) as T;
    }
    if (t == _i44.Competency) {
      return _i44.Competency.fromJson(data) as T;
    }
    if (t == _i45.Course) {
      return _i45.Course.fromJson(data) as T;
    }
    if (t == _i46.CourseCompetency) {
      return _i46.CourseCompetency.fromJson(data) as T;
    }
    if (t == _i47.CourseReview) {
      return _i47.CourseReview.fromJson(data) as T;
    }
    if (t == _i48.CourseSopLink) {
      return _i48.CourseSopLink.fromJson(data) as T;
    }
    if (t == _i49.CourseVersion) {
      return _i49.CourseVersion.fromJson(data) as T;
    }
    if (t == _i50.Curriculum) {
      return _i50.Curriculum.fromJson(data) as T;
    }
    if (t == _i51.CurriculumCourse) {
      return _i51.CurriculumCourse.fromJson(data) as T;
    }
    if (t == _i52.Lesson) {
      return _i52.Lesson.fromJson(data) as T;
    }
    if (t == _i53.LessonBlock) {
      return _i53.LessonBlock.fromJson(data) as T;
    }
    if (t == _i54.Module) {
      return _i54.Module.fromJson(data) as T;
    }
    if (t == _i55.QaValidationResult) {
      return _i55.QaValidationResult.fromJson(data) as T;
    }
    if (t == _i56.QaValidationRuleResult) {
      return _i56.QaValidationRuleResult.fromJson(data) as T;
    }
    if (t == _i57.UserCompetency) {
      return _i57.UserCompetency.fromJson(data) as T;
    }
    if (t == _i58.DashboardComplianceAlert) {
      return _i58.DashboardComplianceAlert.fromJson(data) as T;
    }
    if (t == _i59.DashboardEsignatureSummary) {
      return _i59.DashboardEsignatureSummary.fromJson(data) as T;
    }
    if (t == _i60.DashboardItem) {
      return _i60.DashboardItem.fromJson(data) as T;
    }
    if (t == _i61.DashboardRecentActivity) {
      return _i61.DashboardRecentActivity.fromJson(data) as T;
    }
    if (t == _i62.DashboardUpcomingDueDate) {
      return _i62.DashboardUpcomingDueDate.fromJson(data) as T;
    }
    if (t == _i63.DashboardWeeklyProgress) {
      return _i63.DashboardWeeklyProgress.fromJson(data) as T;
    }
    if (t == _i64.ApprovalWorkflow) {
      return _i64.ApprovalWorkflow.fromJson(data) as T;
    }
    if (t == _i65.Document) {
      return _i65.Document.fromJson(data) as T;
    }
    if (t == _i66.DocumentLifecycle) {
      return _i66.DocumentLifecycle.fromJson(data) as T;
    }
    if (t == _i67.DocumentVersion) {
      return _i67.DocumentVersion.fromJson(data) as T;
    }
    if (t == _i68.DeadLetterQueue) {
      return _i68.DeadLetterQueue.fromJson(data) as T;
    }
    if (t == _i69.DomainEvent) {
      return _i69.DomainEvent.fromJson(data) as T;
    }
    if (t == _i70.OutboxMessage) {
      return _i70.OutboxMessage.fromJson(data) as T;
    }
    if (t == _i71.KafkaEventProcessorProcessEmployeeCreatedModel) {
      return _i71.KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(data)
          as T;
    }
    if (t == _i72.KafkaEventProcessorProcessEmployeeTransferredModel) {
      return _i72.KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
            data,
          )
          as T;
    }
    if (t == _i73.KafkaEventProcessorProcessSopUpdatedModel) {
      return _i73.KafkaEventProcessorProcessSopUpdatedModel.fromJson(data) as T;
    }
    if (t == _i74.Greeting) {
      return _i74.Greeting.fromJson(data) as T;
    }
    if (t == _i75.AuditIntegrityResult) {
      return _i75.AuditIntegrityResult.fromJson(data) as T;
    }
    if (t == _i76.FeatureFlag) {
      return _i76.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i77.RetentionArchive) {
      return _i77.RetentionArchive.fromJson(data) as T;
    }
    if (t == _i78.RetentionPolicy) {
      return _i78.RetentionPolicy.fromJson(data) as T;
    }
    if (t == _i79.ScheduledJobLog) {
      return _i79.ScheduledJobLog.fromJson(data) as T;
    }
    if (t == _i80.SystemConfiguration) {
      return _i80.SystemConfiguration.fromJson(data) as T;
    }
    if (t == _i81.Material) {
      return _i81.Material.fromJson(data) as T;
    }
    if (t == _i82.MaterialProgress) {
      return _i82.MaterialProgress.fromJson(data) as T;
    }
    if (t == _i83.MaterialVersion) {
      return _i83.MaterialVersion.fromJson(data) as T;
    }
    if (t == _i84.MediaAsset) {
      return _i84.MediaAsset.fromJson(data) as T;
    }
    if (t == _i85.MfaEnrollResult) {
      return _i85.MfaEnrollResult.fromJson(data) as T;
    }
    if (t == _i86.MfaStatusResult) {
      return _i86.MfaStatusResult.fromJson(data) as T;
    }
    if (t == _i87.MfaVerifiedSession) {
      return _i87.MfaVerifiedSession.fromJson(data) as T;
    }
    if (t == _i88.UserMfa) {
      return _i88.UserMfa.fromJson(data) as T;
    }
    if (t == _i89.InAppNotification) {
      return _i89.InAppNotification.fromJson(data) as T;
    }
    if (t == _i90.MessagingUnreadCounts) {
      return _i90.MessagingUnreadCounts.fromJson(data) as T;
    }
    if (t == _i91.Notification) {
      return _i91.Notification.fromJson(data) as T;
    }
    if (t == _i92.NotificationLog) {
      return _i92.NotificationLog.fromJson(data) as T;
    }
    if (t == _i93.NotificationTemplate) {
      return _i93.NotificationTemplate.fromJson(data) as T;
    }
    if (t == _i94.Department) {
      return _i94.Department.fromJson(data) as T;
    }
    if (t == _i95.Facility) {
      return _i95.Facility.fromJson(data) as T;
    }
    if (t == _i96.JobRole) {
      return _i96.JobRole.fromJson(data) as T;
    }
    if (t == _i97.Organization) {
      return _i97.Organization.fromJson(data) as T;
    }
    if (t == _i98.Permission) {
      return _i98.Permission.fromJson(data) as T;
    }
    if (t == _i99.Role) {
      return _i99.Role.fromJson(data) as T;
    }
    if (t == _i100.Site) {
      return _i100.Site.fromJson(data) as T;
    }
    if (t == _i101.PharmaUser) {
      return _i101.PharmaUser.fromJson(data) as T;
    }
    if (t == _i102.UserPreference) {
      return _i102.UserPreference.fromJson(data) as T;
    }
    if (t == _i103.UserRole) {
      return _i103.UserRole.fromJson(data) as T;
    }
    if (t == _i104.Capa) {
      return _i104.Capa.fromJson(data) as T;
    }
    if (t == _i105.ChangeControl) {
      return _i105.ChangeControl.fromJson(data) as T;
    }
    if (t == _i106.InspectionReport) {
      return _i106.InspectionReport.fromJson(data) as T;
    }
    if (t == _i107.QualityEvent) {
      return _i107.QualityEvent.fromJson(data) as T;
    }
    if (t == _i108.AbacPolicy) {
      return _i108.AbacPolicy.fromJson(data) as T;
    }
    if (t == _i109.DelegatedAuthority) {
      return _i109.DelegatedAuthority.fromJson(data) as T;
    }
    if (t == _i110.ElectronicSignature) {
      return _i110.ElectronicSignature.fromJson(data) as T;
    }
    if (t == _i111.SignatureMeaning) {
      return _i111.SignatureMeaning.fromJson(data) as T;
    }
    if (t == _i112.SignatureVerificationResult) {
      return _i112.SignatureVerificationResult.fromJson(data) as T;
    }
    if (t == _i113.SmeAssignment) {
      return _i113.SmeAssignment.fromJson(data) as T;
    }
    if (t == _i114.SmeReviewComment) {
      return _i114.SmeReviewComment.fromJson(data) as T;
    }
    if (t == _i115.SmeThreadSummary) {
      return _i115.SmeThreadSummary.fromJson(data) as T;
    }
    if (t == _i116.BatchAnnouncement) {
      return _i116.BatchAnnouncement.fromJson(data) as T;
    }
    if (t == _i117.BatchAttendanceRecord) {
      return _i117.BatchAttendanceRecord.fromJson(data) as T;
    }
    if (t == _i118.BatchParticipantInfo) {
      return _i118.BatchParticipantInfo.fromJson(data) as T;
    }
    if (t == _i119.Certificate) {
      return _i119.Certificate.fromJson(data) as T;
    }
    if (t == _i120.CertificateTemplate) {
      return _i120.CertificateTemplate.fromJson(data) as T;
    }
    if (t == _i121.Enrollment) {
      return _i121.Enrollment.fromJson(data) as T;
    }
    if (t == _i122.LearnerSupportThreadSummary) {
      return _i122.LearnerSupportThreadSummary.fromJson(data) as T;
    }
    if (t == _i123.LearnerTrainerMessage) {
      return _i123.LearnerTrainerMessage.fromJson(data) as T;
    }
    if (t == _i124.LiveClass) {
      return _i124.LiveClass.fromJson(data) as T;
    }
    if (t == _i125.ObservationLog) {
      return _i125.ObservationLog.fromJson(data) as T;
    }
    if (t == _i126.PracticalChecklistItem) {
      return _i126.PracticalChecklistItem.fromJson(data) as T;
    }
    if (t == _i127.StandaloneAssignment) {
      return _i127.StandaloneAssignment.fromJson(data) as T;
    }
    if (t == _i128.StandaloneAssignmentRecipient) {
      return _i128.StandaloneAssignmentRecipient.fromJson(data) as T;
    }
    if (t == _i129.TrainingAssignment) {
      return _i129.TrainingAssignment.fromJson(data) as T;
    }
    if (t == _i130.TrainingBatch) {
      return _i130.TrainingBatch.fromJson(data) as T;
    }
    if (t == _i131.TrainingBatchParticipant) {
      return _i131.TrainingBatchParticipant.fromJson(data) as T;
    }
    if (t == _i132.TrainingExpiration) {
      return _i132.TrainingExpiration.fromJson(data) as T;
    }
    if (t == _i133.TrainingMatrix) {
      return _i133.TrainingMatrix.fromJson(data) as T;
    }
    if (t == _i134.TrainingRecord) {
      return _i134.TrainingRecord.fromJson(data) as T;
    }
    if (t == _i135.TrainingRecordAnnotation) {
      return _i135.TrainingRecordAnnotation.fromJson(data) as T;
    }
    if (t == _i136.TrainingWaiver) {
      return _i136.TrainingWaiver.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.AccessReview?>()) {
      return (data != null ? _i6.AccessReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AccessReviewWindow?>()) {
      return (data != null ? _i7.AccessReviewWindow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.RoleHistory?>()) {
      return (data != null ? _i8.RoleHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.BulkImportResult?>()) {
      return (data != null ? _i9.BulkImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ImportLog?>()) {
      return (data != null ? _i10.ImportLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AnalyticsEvent?>()) {
      return (data != null ? _i11.AnalyticsEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AnalyticsSnapshot?>()) {
      return (data != null ? _i12.AnalyticsSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AuditReadinessScore?>()) {
      return (data != null ? _i13.AuditReadinessScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.BatchTrainingAnalytics?>()) {
      return (data != null ? _i14.BatchTrainingAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.ComplianceMetrics?>()) {
      return (data != null ? _i15.ComplianceMetrics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ComplianceTrendPoint?>()) {
      return (data != null ? _i16.ComplianceTrendPoint.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.CourseAnalytics?>()) {
      return (data != null ? _i17.CourseAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Dashboard?>()) {
      return (data != null ? _i18.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.DepartmentComplianceSnapshot?>()) {
      return (data != null
              ? _i19.DepartmentComplianceSnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.DepartmentComplianceSummary?>()) {
      return (data != null
              ? _i20.DepartmentComplianceSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.ReportDefinition?>()) {
      return (data != null ? _i21.ReportDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SimulationAttempt?>()) {
      return (data != null ? _i22.SimulationAttempt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SlaBreach?>()) {
      return (data != null ? _i23.SlaBreach.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SlaPolicy?>()) {
      return (data != null ? _i24.SlaPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.UserComplianceMetrics?>()) {
      return (data != null ? _i25.UserComplianceMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.Assessment?>()) {
      return (data != null ? _i26.Assessment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.AssessmentAttempt?>()) {
      return (data != null ? _i27.AssessmentAttempt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.AssessmentResult?>()) {
      return (data != null ? _i28.AssessmentResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Question?>()) {
      return (data != null ? _i29.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.QuestionBank?>()) {
      return (data != null ? _i30.QuestionBank.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.AccessLog?>()) {
      return (data != null ? _i31.AccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.AuditTrail?>()) {
      return (data != null ? _i32.AuditTrail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.AuditorPageLog?>()) {
      return (data != null ? _i33.AuditorPageLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.AuditorSession?>()) {
      return (data != null ? _i34.AuditorSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.ErrorLog?>()) {
      return (data != null ? _i35.ErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.InspectionPackage?>()) {
      return (data != null ? _i36.InspectionPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.InspectionRecord?>()) {
      return (data != null ? _i37.InspectionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.ReportExport?>()) {
      return (data != null ? _i38.ReportExport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.UserSession?>()) {
      return (data != null ? _i39.UserSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.OidcAccount?>()) {
      return (data != null ? _i40.OidcAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.OidcClientConfig?>()) {
      return (data != null ? _i41.OidcClientConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.Assignment?>()) {
      return (data != null ? _i42.Assignment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.AssignmentSubmission?>()) {
      return (data != null ? _i43.AssignmentSubmission.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.Competency?>()) {
      return (data != null ? _i44.Competency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.Course?>()) {
      return (data != null ? _i45.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.CourseCompetency?>()) {
      return (data != null ? _i46.CourseCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.CourseReview?>()) {
      return (data != null ? _i47.CourseReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.CourseSopLink?>()) {
      return (data != null ? _i48.CourseSopLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.CourseVersion?>()) {
      return (data != null ? _i49.CourseVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.Curriculum?>()) {
      return (data != null ? _i50.Curriculum.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.CurriculumCourse?>()) {
      return (data != null ? _i51.CurriculumCourse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.Lesson?>()) {
      return (data != null ? _i52.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.LessonBlock?>()) {
      return (data != null ? _i53.LessonBlock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.Module?>()) {
      return (data != null ? _i54.Module.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.QaValidationResult?>()) {
      return (data != null ? _i55.QaValidationResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.QaValidationRuleResult?>()) {
      return (data != null ? _i56.QaValidationRuleResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.UserCompetency?>()) {
      return (data != null ? _i57.UserCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.DashboardComplianceAlert?>()) {
      return (data != null
              ? _i58.DashboardComplianceAlert.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i59.DashboardEsignatureSummary?>()) {
      return (data != null
              ? _i59.DashboardEsignatureSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i60.DashboardItem?>()) {
      return (data != null ? _i60.DashboardItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.DashboardRecentActivity?>()) {
      return (data != null ? _i61.DashboardRecentActivity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.DashboardUpcomingDueDate?>()) {
      return (data != null
              ? _i62.DashboardUpcomingDueDate.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.DashboardWeeklyProgress?>()) {
      return (data != null ? _i63.DashboardWeeklyProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.ApprovalWorkflow?>()) {
      return (data != null ? _i64.ApprovalWorkflow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.Document?>()) {
      return (data != null ? _i65.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.DocumentLifecycle?>()) {
      return (data != null ? _i66.DocumentLifecycle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.DocumentVersion?>()) {
      return (data != null ? _i67.DocumentVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.DeadLetterQueue?>()) {
      return (data != null ? _i68.DeadLetterQueue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.DomainEvent?>()) {
      return (data != null ? _i69.DomainEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.OutboxMessage?>()) {
      return (data != null ? _i70.OutboxMessage.fromJson(data) : null) as T;
    }
    if (t ==
        _i1.getType<_i71.KafkaEventProcessorProcessEmployeeCreatedModel?>()) {
      return (data != null
              ? _i71.KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t ==
        _i1
            .getType<
              _i72.KafkaEventProcessorProcessEmployeeTransferredModel?
            >()) {
      return (data != null
              ? _i72.KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _i1.getType<_i73.KafkaEventProcessorProcessSopUpdatedModel?>()) {
      return (data != null
              ? _i73.KafkaEventProcessorProcessSopUpdatedModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i74.Greeting?>()) {
      return (data != null ? _i74.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.AuditIntegrityResult?>()) {
      return (data != null ? _i75.AuditIntegrityResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i76.FeatureFlag?>()) {
      return (data != null ? _i76.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.RetentionArchive?>()) {
      return (data != null ? _i77.RetentionArchive.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.RetentionPolicy?>()) {
      return (data != null ? _i78.RetentionPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.ScheduledJobLog?>()) {
      return (data != null ? _i79.ScheduledJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.SystemConfiguration?>()) {
      return (data != null ? _i80.SystemConfiguration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i81.Material?>()) {
      return (data != null ? _i81.Material.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.MaterialProgress?>()) {
      return (data != null ? _i82.MaterialProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.MaterialVersion?>()) {
      return (data != null ? _i83.MaterialVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.MediaAsset?>()) {
      return (data != null ? _i84.MediaAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.MfaEnrollResult?>()) {
      return (data != null ? _i85.MfaEnrollResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.MfaStatusResult?>()) {
      return (data != null ? _i86.MfaStatusResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.MfaVerifiedSession?>()) {
      return (data != null ? _i87.MfaVerifiedSession.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.UserMfa?>()) {
      return (data != null ? _i88.UserMfa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.InAppNotification?>()) {
      return (data != null ? _i89.InAppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.MessagingUnreadCounts?>()) {
      return (data != null ? _i90.MessagingUnreadCounts.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i91.Notification?>()) {
      return (data != null ? _i91.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.NotificationLog?>()) {
      return (data != null ? _i92.NotificationLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.NotificationTemplate?>()) {
      return (data != null ? _i93.NotificationTemplate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i94.Department?>()) {
      return (data != null ? _i94.Department.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.Facility?>()) {
      return (data != null ? _i95.Facility.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.JobRole?>()) {
      return (data != null ? _i96.JobRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i97.Organization?>()) {
      return (data != null ? _i97.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.Permission?>()) {
      return (data != null ? _i98.Permission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.Role?>()) {
      return (data != null ? _i99.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.Site?>()) {
      return (data != null ? _i100.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i101.PharmaUser?>()) {
      return (data != null ? _i101.PharmaUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.UserPreference?>()) {
      return (data != null ? _i102.UserPreference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.UserRole?>()) {
      return (data != null ? _i103.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.Capa?>()) {
      return (data != null ? _i104.Capa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.ChangeControl?>()) {
      return (data != null ? _i105.ChangeControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i106.InspectionReport?>()) {
      return (data != null ? _i106.InspectionReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.QualityEvent?>()) {
      return (data != null ? _i107.QualityEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i108.AbacPolicy?>()) {
      return (data != null ? _i108.AbacPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i109.DelegatedAuthority?>()) {
      return (data != null ? _i109.DelegatedAuthority.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i110.ElectronicSignature?>()) {
      return (data != null ? _i110.ElectronicSignature.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i111.SignatureMeaning?>()) {
      return (data != null ? _i111.SignatureMeaning.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i112.SignatureVerificationResult?>()) {
      return (data != null
              ? _i112.SignatureVerificationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i113.SmeAssignment?>()) {
      return (data != null ? _i113.SmeAssignment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i114.SmeReviewComment?>()) {
      return (data != null ? _i114.SmeReviewComment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i115.SmeThreadSummary?>()) {
      return (data != null ? _i115.SmeThreadSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i116.BatchAnnouncement?>()) {
      return (data != null ? _i116.BatchAnnouncement.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i117.BatchAttendanceRecord?>()) {
      return (data != null ? _i117.BatchAttendanceRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i118.BatchParticipantInfo?>()) {
      return (data != null ? _i118.BatchParticipantInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i119.Certificate?>()) {
      return (data != null ? _i119.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i120.CertificateTemplate?>()) {
      return (data != null ? _i120.CertificateTemplate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i121.Enrollment?>()) {
      return (data != null ? _i121.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.LearnerSupportThreadSummary?>()) {
      return (data != null
              ? _i122.LearnerSupportThreadSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i123.LearnerTrainerMessage?>()) {
      return (data != null ? _i123.LearnerTrainerMessage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i124.LiveClass?>()) {
      return (data != null ? _i124.LiveClass.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i125.ObservationLog?>()) {
      return (data != null ? _i125.ObservationLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i126.PracticalChecklistItem?>()) {
      return (data != null ? _i126.PracticalChecklistItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i127.StandaloneAssignment?>()) {
      return (data != null ? _i127.StandaloneAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i128.StandaloneAssignmentRecipient?>()) {
      return (data != null
              ? _i128.StandaloneAssignmentRecipient.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i129.TrainingAssignment?>()) {
      return (data != null ? _i129.TrainingAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i130.TrainingBatch?>()) {
      return (data != null ? _i130.TrainingBatch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i131.TrainingBatchParticipant?>()) {
      return (data != null
              ? _i131.TrainingBatchParticipant.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i132.TrainingExpiration?>()) {
      return (data != null ? _i132.TrainingExpiration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i133.TrainingMatrix?>()) {
      return (data != null ? _i133.TrainingMatrix.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i134.TrainingRecord?>()) {
      return (data != null ? _i134.TrainingRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i135.TrainingRecordAnnotation?>()) {
      return (data != null
              ? _i135.TrainingRecordAnnotation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i136.TrainingWaiver?>()) {
      return (data != null ? _i136.TrainingWaiver.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i29.Question>) {
      return (data as List).map((e) => deserialize<_i29.Question>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i29.Question>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i29.Question>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i56.QaValidationRuleResult>) {
      return (data as List)
              .map((e) => deserialize<_i56.QaValidationRuleResult>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i137.AccessReview>) {
      return (data as List)
              .map((e) => deserialize<_i137.AccessReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i138.PharmaUser>) {
      return (data as List)
              .map((e) => deserialize<_i138.PharmaUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i139.Role>) {
      return (data as List).map((e) => deserialize<_i139.Role>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i140.SignatureMeaning>) {
      return (data as List)
              .map((e) => deserialize<_i140.SignatureMeaning>(e))
              .toList()
          as T;
    }
    if (t == List<_i141.TrainingAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i141.TrainingAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i142.TrainingMatrix>) {
      return (data as List)
              .map((e) => deserialize<_i142.TrainingMatrix>(e))
              .toList()
          as T;
    }
    if (t == List<_i143.TrainingWaiver>) {
      return (data as List)
              .map((e) => deserialize<_i143.TrainingWaiver>(e))
              .toList()
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i144.DepartmentComplianceSummary>) {
      return (data as List)
              .map((e) => deserialize<_i144.DepartmentComplianceSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i145.ReportDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i145.ReportDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i146.Dashboard>) {
      return (data as List).map((e) => deserialize<_i146.Dashboard>(e)).toList()
          as T;
    }
    if (t == List<_i147.SlaBreach>) {
      return (data as List).map((e) => deserialize<_i147.SlaBreach>(e)).toList()
          as T;
    }
    if (t == Map<String, List<_i148.Certificate>>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<List<_i148.Certificate>>(v),
            ),
          )
          as T;
    }
    if (t == List<_i148.Certificate>) {
      return (data as List)
              .map((e) => deserialize<_i148.Certificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i149.Capa>) {
      return (data as List).map((e) => deserialize<_i149.Capa>(e)).toList()
          as T;
    }
    if (t == List<Map<String, String>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, String>>(e))
              .toList()
          as T;
    }
    if (t == List<_i150.ComplianceTrendPoint>) {
      return (data as List)
              .map((e) => deserialize<_i150.ComplianceTrendPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i151.Assessment>) {
      return (data as List)
              .map((e) => deserialize<_i151.Assessment>(e))
              .toList()
          as T;
    }
    if (t == List<_i152.AssessmentAttempt>) {
      return (data as List)
              .map((e) => deserialize<_i152.AssessmentAttempt>(e))
              .toList()
          as T;
    }
    if (t == List<_i153.Question>) {
      return (data as List).map((e) => deserialize<_i153.Question>(e)).toList()
          as T;
    }
    if (t == List<_i154.QuestionBank>) {
      return (data as List)
              .map((e) => deserialize<_i154.QuestionBank>(e))
              .toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i155.AssessmentResult>) {
      return (data as List)
              .map((e) => deserialize<_i155.AssessmentResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i156.Assignment>) {
      return (data as List)
              .map((e) => deserialize<_i156.Assignment>(e))
              .toList()
          as T;
    }
    if (t == List<_i157.AssignmentSubmission>) {
      return (data as List)
              .map((e) => deserialize<_i157.AssignmentSubmission>(e))
              .toList()
          as T;
    }
    if (t == List<_i158.AuditTrail>) {
      return (data as List)
              .map((e) => deserialize<_i158.AuditTrail>(e))
              .toList()
          as T;
    }
    if (t == List<_i159.AccessLog>) {
      return (data as List).map((e) => deserialize<_i159.AccessLog>(e)).toList()
          as T;
    }
    if (t == List<_i160.BatchAnnouncement>) {
      return (data as List)
              .map((e) => deserialize<_i160.BatchAnnouncement>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i161.CertificateTemplate>) {
      return (data as List)
              .map((e) => deserialize<_i161.CertificateTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_i162.Course>) {
      return (data as List).map((e) => deserialize<_i162.Course>(e)).toList()
          as T;
    }
    if (t == List<_i163.CourseVersion>) {
      return (data as List)
              .map((e) => deserialize<_i163.CourseVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i164.Module>) {
      return (data as List).map((e) => deserialize<_i164.Module>(e)).toList()
          as T;
    }
    if (t == List<_i165.Lesson>) {
      return (data as List).map((e) => deserialize<_i165.Lesson>(e)).toList()
          as T;
    }
    if (t == List<_i166.Document>) {
      return (data as List).map((e) => deserialize<_i166.Document>(e)).toList()
          as T;
    }
    if (t == List<_i167.DocumentVersion>) {
      return (data as List)
              .map((e) => deserialize<_i167.DocumentVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i168.DocumentLifecycle>) {
      return (data as List)
              .map((e) => deserialize<_i168.DocumentLifecycle>(e))
              .toList()
          as T;
    }
    if (t == List<_i169.InspectionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i169.InspectionRecord>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i170.AuditorPageLog>) {
      return (data as List)
              .map((e) => deserialize<_i170.AuditorPageLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i171.InspectionPackage>) {
      return (data as List)
              .map((e) => deserialize<_i171.InspectionPackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i172.LearnerTrainerMessage>) {
      return (data as List)
              .map((e) => deserialize<_i172.LearnerTrainerMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i173.LearnerSupportThreadSummary>) {
      return (data as List)
              .map((e) => deserialize<_i173.LearnerSupportThreadSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i174.LessonBlock>) {
      return (data as List)
              .map((e) => deserialize<_i174.LessonBlock>(e))
              .toList()
          as T;
    }
    if (t == List<_i175.LiveClass>) {
      return (data as List).map((e) => deserialize<_i175.LiveClass>(e)).toList()
          as T;
    }
    if (t == List<_i176.MaterialVersion>) {
      return (data as List)
              .map((e) => deserialize<_i176.MaterialVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i177.Material>) {
      return (data as List).map((e) => deserialize<_i177.Material>(e)).toList()
          as T;
    }
    if (t == List<_i178.SmeThreadSummary>) {
      return (data as List)
              .map((e) => deserialize<_i178.SmeThreadSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i179.SmeReviewComment>) {
      return (data as List)
              .map((e) => deserialize<_i179.SmeReviewComment>(e))
              .toList()
          as T;
    }
    if (t == List<_i180.Notification>) {
      return (data as List)
              .map((e) => deserialize<_i180.Notification>(e))
              .toList()
          as T;
    }
    if (t == List<_i181.InAppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i181.InAppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i182.NotificationTemplate>) {
      return (data as List)
              .map((e) => deserialize<_i182.NotificationTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_i183.PracticalChecklistItem>) {
      return (data as List)
              .map((e) => deserialize<_i183.PracticalChecklistItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i184.ObservationLog>) {
      return (data as List)
              .map((e) => deserialize<_i184.ObservationLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i185.UserCompetency>) {
      return (data as List)
              .map((e) => deserialize<_i185.UserCompetency>(e))
              .toList()
          as T;
    }
    if (t == List<_i186.Competency>) {
      return (data as List)
              .map((e) => deserialize<_i186.Competency>(e))
              .toList()
          as T;
    }
    if (t == List<_i187.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i187.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i188.Site>) {
      return (data as List).map((e) => deserialize<_i188.Site>(e)).toList()
          as T;
    }
    if (t == List<_i189.Department>) {
      return (data as List)
              .map((e) => deserialize<_i189.Department>(e))
              .toList()
          as T;
    }
    if (t == List<_i190.JobRole>) {
      return (data as List).map((e) => deserialize<_i190.JobRole>(e)).toList()
          as T;
    }
    if (t == List<_i191.SystemConfiguration>) {
      return (data as List)
              .map((e) => deserialize<_i191.SystemConfiguration>(e))
              .toList()
          as T;
    }
    if (t == List<_i192.CourseReview>) {
      return (data as List)
              .map((e) => deserialize<_i192.CourseReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i193.QualityEvent>) {
      return (data as List)
              .map((e) => deserialize<_i193.QualityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i194.InspectionReport>) {
      return (data as List)
              .map((e) => deserialize<_i194.InspectionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i195.SmeAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i195.SmeAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<_i196.CourseSopLink>) {
      return (data as List)
              .map((e) => deserialize<_i196.CourseSopLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i197.StandaloneAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i197.StandaloneAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<_i198.StandaloneAssignmentRecipient>) {
      return (data as List)
              .map((e) => deserialize<_i198.StandaloneAssignmentRecipient>(e))
              .toList()
          as T;
    }
    if (t == List<_i199.TrainingBatch>) {
      return (data as List)
              .map((e) => deserialize<_i199.TrainingBatch>(e))
              .toList()
          as T;
    }
    if (t == List<_i200.BatchParticipantInfo>) {
      return (data as List)
              .map((e) => deserialize<_i200.BatchParticipantInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_i201.BatchAttendanceRecord>) {
      return (data as List)
              .map((e) => deserialize<_i201.BatchAttendanceRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i202.Enrollment>) {
      return (data as List)
              .map((e) => deserialize<_i202.Enrollment>(e))
              .toList()
          as T;
    }
    if (t == List<_i203.TrainingRecord>) {
      return (data as List)
              .map((e) => deserialize<_i203.TrainingRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i204.ElectronicSignature>) {
      return (data as List)
              .map((e) => deserialize<_i204.ElectronicSignature>(e))
              .toList()
          as T;
    }
    if (t == List<_i205.TrainingRecordAnnotation>) {
      return (data as List)
              .map((e) => deserialize<_i205.TrainingRecordAnnotation>(e))
              .toList()
          as T;
    }
    if (t == List<_i206.UserPreference>) {
      return (data as List)
              .map((e) => deserialize<_i206.UserPreference>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i5.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6.AccessReview => 'AccessReview',
      _i7.AccessReviewWindow => 'AccessReviewWindow',
      _i8.RoleHistory => 'RoleHistory',
      _i9.BulkImportResult => 'BulkImportResult',
      _i10.ImportLog => 'ImportLog',
      _i11.AnalyticsEvent => 'AnalyticsEvent',
      _i12.AnalyticsSnapshot => 'AnalyticsSnapshot',
      _i13.AuditReadinessScore => 'AuditReadinessScore',
      _i14.BatchTrainingAnalytics => 'BatchTrainingAnalytics',
      _i15.ComplianceMetrics => 'ComplianceMetrics',
      _i16.ComplianceTrendPoint => 'ComplianceTrendPoint',
      _i17.CourseAnalytics => 'CourseAnalytics',
      _i18.Dashboard => 'Dashboard',
      _i19.DepartmentComplianceSnapshot => 'DepartmentComplianceSnapshot',
      _i20.DepartmentComplianceSummary => 'DepartmentComplianceSummary',
      _i21.ReportDefinition => 'ReportDefinition',
      _i22.SimulationAttempt => 'SimulationAttempt',
      _i23.SlaBreach => 'SlaBreach',
      _i24.SlaPolicy => 'SlaPolicy',
      _i25.UserComplianceMetrics => 'UserComplianceMetrics',
      _i26.Assessment => 'Assessment',
      _i27.AssessmentAttempt => 'AssessmentAttempt',
      _i28.AssessmentResult => 'AssessmentResult',
      _i29.Question => 'Question',
      _i30.QuestionBank => 'QuestionBank',
      _i31.AccessLog => 'AccessLog',
      _i32.AuditTrail => 'AuditTrail',
      _i33.AuditorPageLog => 'AuditorPageLog',
      _i34.AuditorSession => 'AuditorSession',
      _i35.ErrorLog => 'ErrorLog',
      _i36.InspectionPackage => 'InspectionPackage',
      _i37.InspectionRecord => 'InspectionRecord',
      _i38.ReportExport => 'ReportExport',
      _i39.UserSession => 'UserSession',
      _i40.OidcAccount => 'OidcAccount',
      _i41.OidcClientConfig => 'OidcClientConfig',
      _i42.Assignment => 'Assignment',
      _i43.AssignmentSubmission => 'AssignmentSubmission',
      _i44.Competency => 'Competency',
      _i45.Course => 'Course',
      _i46.CourseCompetency => 'CourseCompetency',
      _i47.CourseReview => 'CourseReview',
      _i48.CourseSopLink => 'CourseSopLink',
      _i49.CourseVersion => 'CourseVersion',
      _i50.Curriculum => 'Curriculum',
      _i51.CurriculumCourse => 'CurriculumCourse',
      _i52.Lesson => 'Lesson',
      _i53.LessonBlock => 'LessonBlock',
      _i54.Module => 'Module',
      _i55.QaValidationResult => 'QaValidationResult',
      _i56.QaValidationRuleResult => 'QaValidationRuleResult',
      _i57.UserCompetency => 'UserCompetency',
      _i58.DashboardComplianceAlert => 'DashboardComplianceAlert',
      _i59.DashboardEsignatureSummary => 'DashboardEsignatureSummary',
      _i60.DashboardItem => 'DashboardItem',
      _i61.DashboardRecentActivity => 'DashboardRecentActivity',
      _i62.DashboardUpcomingDueDate => 'DashboardUpcomingDueDate',
      _i63.DashboardWeeklyProgress => 'DashboardWeeklyProgress',
      _i64.ApprovalWorkflow => 'ApprovalWorkflow',
      _i65.Document => 'Document',
      _i66.DocumentLifecycle => 'DocumentLifecycle',
      _i67.DocumentVersion => 'DocumentVersion',
      _i68.DeadLetterQueue => 'DeadLetterQueue',
      _i69.DomainEvent => 'DomainEvent',
      _i70.OutboxMessage => 'OutboxMessage',
      _i71.KafkaEventProcessorProcessEmployeeCreatedModel =>
        'KafkaEventProcessorProcessEmployeeCreatedModel',
      _i72.KafkaEventProcessorProcessEmployeeTransferredModel =>
        'KafkaEventProcessorProcessEmployeeTransferredModel',
      _i73.KafkaEventProcessorProcessSopUpdatedModel =>
        'KafkaEventProcessorProcessSopUpdatedModel',
      _i74.Greeting => 'Greeting',
      _i75.AuditIntegrityResult => 'AuditIntegrityResult',
      _i76.FeatureFlag => 'FeatureFlag',
      _i77.RetentionArchive => 'RetentionArchive',
      _i78.RetentionPolicy => 'RetentionPolicy',
      _i79.ScheduledJobLog => 'ScheduledJobLog',
      _i80.SystemConfiguration => 'SystemConfiguration',
      _i81.Material => 'Material',
      _i82.MaterialProgress => 'MaterialProgress',
      _i83.MaterialVersion => 'MaterialVersion',
      _i84.MediaAsset => 'MediaAsset',
      _i85.MfaEnrollResult => 'MfaEnrollResult',
      _i86.MfaStatusResult => 'MfaStatusResult',
      _i87.MfaVerifiedSession => 'MfaVerifiedSession',
      _i88.UserMfa => 'UserMfa',
      _i89.InAppNotification => 'InAppNotification',
      _i90.MessagingUnreadCounts => 'MessagingUnreadCounts',
      _i91.Notification => 'Notification',
      _i92.NotificationLog => 'NotificationLog',
      _i93.NotificationTemplate => 'NotificationTemplate',
      _i94.Department => 'Department',
      _i95.Facility => 'Facility',
      _i96.JobRole => 'JobRole',
      _i97.Organization => 'Organization',
      _i98.Permission => 'Permission',
      _i99.Role => 'Role',
      _i100.Site => 'Site',
      _i101.PharmaUser => 'PharmaUser',
      _i102.UserPreference => 'UserPreference',
      _i103.UserRole => 'UserRole',
      _i104.Capa => 'Capa',
      _i105.ChangeControl => 'ChangeControl',
      _i106.InspectionReport => 'InspectionReport',
      _i107.QualityEvent => 'QualityEvent',
      _i108.AbacPolicy => 'AbacPolicy',
      _i109.DelegatedAuthority => 'DelegatedAuthority',
      _i110.ElectronicSignature => 'ElectronicSignature',
      _i111.SignatureMeaning => 'SignatureMeaning',
      _i112.SignatureVerificationResult => 'SignatureVerificationResult',
      _i113.SmeAssignment => 'SmeAssignment',
      _i114.SmeReviewComment => 'SmeReviewComment',
      _i115.SmeThreadSummary => 'SmeThreadSummary',
      _i116.BatchAnnouncement => 'BatchAnnouncement',
      _i117.BatchAttendanceRecord => 'BatchAttendanceRecord',
      _i118.BatchParticipantInfo => 'BatchParticipantInfo',
      _i119.Certificate => 'Certificate',
      _i120.CertificateTemplate => 'CertificateTemplate',
      _i121.Enrollment => 'Enrollment',
      _i122.LearnerSupportThreadSummary => 'LearnerSupportThreadSummary',
      _i123.LearnerTrainerMessage => 'LearnerTrainerMessage',
      _i124.LiveClass => 'LiveClass',
      _i125.ObservationLog => 'ObservationLog',
      _i126.PracticalChecklistItem => 'PracticalChecklistItem',
      _i127.StandaloneAssignment => 'StandaloneAssignment',
      _i128.StandaloneAssignmentRecipient => 'StandaloneAssignmentRecipient',
      _i129.TrainingAssignment => 'TrainingAssignment',
      _i130.TrainingBatch => 'TrainingBatch',
      _i131.TrainingBatchParticipant => 'TrainingBatchParticipant',
      _i132.TrainingExpiration => 'TrainingExpiration',
      _i133.TrainingMatrix => 'TrainingMatrix',
      _i134.TrainingRecord => 'TrainingRecord',
      _i135.TrainingRecordAnnotation => 'TrainingRecordAnnotation',
      _i136.TrainingWaiver => 'TrainingWaiver',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('pharma_lms.', '');
    }

    switch (data) {
      case _i6.AccessReview():
        return 'AccessReview';
      case _i7.AccessReviewWindow():
        return 'AccessReviewWindow';
      case _i8.RoleHistory():
        return 'RoleHistory';
      case _i9.BulkImportResult():
        return 'BulkImportResult';
      case _i10.ImportLog():
        return 'ImportLog';
      case _i11.AnalyticsEvent():
        return 'AnalyticsEvent';
      case _i12.AnalyticsSnapshot():
        return 'AnalyticsSnapshot';
      case _i13.AuditReadinessScore():
        return 'AuditReadinessScore';
      case _i14.BatchTrainingAnalytics():
        return 'BatchTrainingAnalytics';
      case _i15.ComplianceMetrics():
        return 'ComplianceMetrics';
      case _i16.ComplianceTrendPoint():
        return 'ComplianceTrendPoint';
      case _i17.CourseAnalytics():
        return 'CourseAnalytics';
      case _i18.Dashboard():
        return 'Dashboard';
      case _i19.DepartmentComplianceSnapshot():
        return 'DepartmentComplianceSnapshot';
      case _i20.DepartmentComplianceSummary():
        return 'DepartmentComplianceSummary';
      case _i21.ReportDefinition():
        return 'ReportDefinition';
      case _i22.SimulationAttempt():
        return 'SimulationAttempt';
      case _i23.SlaBreach():
        return 'SlaBreach';
      case _i24.SlaPolicy():
        return 'SlaPolicy';
      case _i25.UserComplianceMetrics():
        return 'UserComplianceMetrics';
      case _i26.Assessment():
        return 'Assessment';
      case _i27.AssessmentAttempt():
        return 'AssessmentAttempt';
      case _i28.AssessmentResult():
        return 'AssessmentResult';
      case _i29.Question():
        return 'Question';
      case _i30.QuestionBank():
        return 'QuestionBank';
      case _i31.AccessLog():
        return 'AccessLog';
      case _i32.AuditTrail():
        return 'AuditTrail';
      case _i33.AuditorPageLog():
        return 'AuditorPageLog';
      case _i34.AuditorSession():
        return 'AuditorSession';
      case _i35.ErrorLog():
        return 'ErrorLog';
      case _i36.InspectionPackage():
        return 'InspectionPackage';
      case _i37.InspectionRecord():
        return 'InspectionRecord';
      case _i38.ReportExport():
        return 'ReportExport';
      case _i39.UserSession():
        return 'UserSession';
      case _i40.OidcAccount():
        return 'OidcAccount';
      case _i41.OidcClientConfig():
        return 'OidcClientConfig';
      case _i42.Assignment():
        return 'Assignment';
      case _i43.AssignmentSubmission():
        return 'AssignmentSubmission';
      case _i44.Competency():
        return 'Competency';
      case _i45.Course():
        return 'Course';
      case _i46.CourseCompetency():
        return 'CourseCompetency';
      case _i47.CourseReview():
        return 'CourseReview';
      case _i48.CourseSopLink():
        return 'CourseSopLink';
      case _i49.CourseVersion():
        return 'CourseVersion';
      case _i50.Curriculum():
        return 'Curriculum';
      case _i51.CurriculumCourse():
        return 'CurriculumCourse';
      case _i52.Lesson():
        return 'Lesson';
      case _i53.LessonBlock():
        return 'LessonBlock';
      case _i54.Module():
        return 'Module';
      case _i55.QaValidationResult():
        return 'QaValidationResult';
      case _i56.QaValidationRuleResult():
        return 'QaValidationRuleResult';
      case _i57.UserCompetency():
        return 'UserCompetency';
      case _i58.DashboardComplianceAlert():
        return 'DashboardComplianceAlert';
      case _i59.DashboardEsignatureSummary():
        return 'DashboardEsignatureSummary';
      case _i60.DashboardItem():
        return 'DashboardItem';
      case _i61.DashboardRecentActivity():
        return 'DashboardRecentActivity';
      case _i62.DashboardUpcomingDueDate():
        return 'DashboardUpcomingDueDate';
      case _i63.DashboardWeeklyProgress():
        return 'DashboardWeeklyProgress';
      case _i64.ApprovalWorkflow():
        return 'ApprovalWorkflow';
      case _i65.Document():
        return 'Document';
      case _i66.DocumentLifecycle():
        return 'DocumentLifecycle';
      case _i67.DocumentVersion():
        return 'DocumentVersion';
      case _i68.DeadLetterQueue():
        return 'DeadLetterQueue';
      case _i69.DomainEvent():
        return 'DomainEvent';
      case _i70.OutboxMessage():
        return 'OutboxMessage';
      case _i71.KafkaEventProcessorProcessEmployeeCreatedModel():
        return 'KafkaEventProcessorProcessEmployeeCreatedModel';
      case _i72.KafkaEventProcessorProcessEmployeeTransferredModel():
        return 'KafkaEventProcessorProcessEmployeeTransferredModel';
      case _i73.KafkaEventProcessorProcessSopUpdatedModel():
        return 'KafkaEventProcessorProcessSopUpdatedModel';
      case _i74.Greeting():
        return 'Greeting';
      case _i75.AuditIntegrityResult():
        return 'AuditIntegrityResult';
      case _i76.FeatureFlag():
        return 'FeatureFlag';
      case _i77.RetentionArchive():
        return 'RetentionArchive';
      case _i78.RetentionPolicy():
        return 'RetentionPolicy';
      case _i79.ScheduledJobLog():
        return 'ScheduledJobLog';
      case _i80.SystemConfiguration():
        return 'SystemConfiguration';
      case _i81.Material():
        return 'Material';
      case _i82.MaterialProgress():
        return 'MaterialProgress';
      case _i83.MaterialVersion():
        return 'MaterialVersion';
      case _i84.MediaAsset():
        return 'MediaAsset';
      case _i85.MfaEnrollResult():
        return 'MfaEnrollResult';
      case _i86.MfaStatusResult():
        return 'MfaStatusResult';
      case _i87.MfaVerifiedSession():
        return 'MfaVerifiedSession';
      case _i88.UserMfa():
        return 'UserMfa';
      case _i89.InAppNotification():
        return 'InAppNotification';
      case _i90.MessagingUnreadCounts():
        return 'MessagingUnreadCounts';
      case _i91.Notification():
        return 'Notification';
      case _i92.NotificationLog():
        return 'NotificationLog';
      case _i93.NotificationTemplate():
        return 'NotificationTemplate';
      case _i94.Department():
        return 'Department';
      case _i95.Facility():
        return 'Facility';
      case _i96.JobRole():
        return 'JobRole';
      case _i97.Organization():
        return 'Organization';
      case _i98.Permission():
        return 'Permission';
      case _i99.Role():
        return 'Role';
      case _i100.Site():
        return 'Site';
      case _i101.PharmaUser():
        return 'PharmaUser';
      case _i102.UserPreference():
        return 'UserPreference';
      case _i103.UserRole():
        return 'UserRole';
      case _i104.Capa():
        return 'Capa';
      case _i105.ChangeControl():
        return 'ChangeControl';
      case _i106.InspectionReport():
        return 'InspectionReport';
      case _i107.QualityEvent():
        return 'QualityEvent';
      case _i108.AbacPolicy():
        return 'AbacPolicy';
      case _i109.DelegatedAuthority():
        return 'DelegatedAuthority';
      case _i110.ElectronicSignature():
        return 'ElectronicSignature';
      case _i111.SignatureMeaning():
        return 'SignatureMeaning';
      case _i112.SignatureVerificationResult():
        return 'SignatureVerificationResult';
      case _i113.SmeAssignment():
        return 'SmeAssignment';
      case _i114.SmeReviewComment():
        return 'SmeReviewComment';
      case _i115.SmeThreadSummary():
        return 'SmeThreadSummary';
      case _i116.BatchAnnouncement():
        return 'BatchAnnouncement';
      case _i117.BatchAttendanceRecord():
        return 'BatchAttendanceRecord';
      case _i118.BatchParticipantInfo():
        return 'BatchParticipantInfo';
      case _i119.Certificate():
        return 'Certificate';
      case _i120.CertificateTemplate():
        return 'CertificateTemplate';
      case _i121.Enrollment():
        return 'Enrollment';
      case _i122.LearnerSupportThreadSummary():
        return 'LearnerSupportThreadSummary';
      case _i123.LearnerTrainerMessage():
        return 'LearnerTrainerMessage';
      case _i124.LiveClass():
        return 'LiveClass';
      case _i125.ObservationLog():
        return 'ObservationLog';
      case _i126.PracticalChecklistItem():
        return 'PracticalChecklistItem';
      case _i127.StandaloneAssignment():
        return 'StandaloneAssignment';
      case _i128.StandaloneAssignmentRecipient():
        return 'StandaloneAssignmentRecipient';
      case _i129.TrainingAssignment():
        return 'TrainingAssignment';
      case _i130.TrainingBatch():
        return 'TrainingBatch';
      case _i131.TrainingBatchParticipant():
        return 'TrainingBatchParticipant';
      case _i132.TrainingExpiration():
        return 'TrainingExpiration';
      case _i133.TrainingMatrix():
        return 'TrainingMatrix';
      case _i134.TrainingRecord():
        return 'TrainingRecord';
      case _i135.TrainingRecordAnnotation():
        return 'TrainingRecordAnnotation';
      case _i136.TrainingWaiver():
        return 'TrainingWaiver';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i5.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AccessReview') {
      return deserialize<_i6.AccessReview>(data['data']);
    }
    if (dataClassName == 'AccessReviewWindow') {
      return deserialize<_i7.AccessReviewWindow>(data['data']);
    }
    if (dataClassName == 'RoleHistory') {
      return deserialize<_i8.RoleHistory>(data['data']);
    }
    if (dataClassName == 'BulkImportResult') {
      return deserialize<_i9.BulkImportResult>(data['data']);
    }
    if (dataClassName == 'ImportLog') {
      return deserialize<_i10.ImportLog>(data['data']);
    }
    if (dataClassName == 'AnalyticsEvent') {
      return deserialize<_i11.AnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'AnalyticsSnapshot') {
      return deserialize<_i12.AnalyticsSnapshot>(data['data']);
    }
    if (dataClassName == 'AuditReadinessScore') {
      return deserialize<_i13.AuditReadinessScore>(data['data']);
    }
    if (dataClassName == 'BatchTrainingAnalytics') {
      return deserialize<_i14.BatchTrainingAnalytics>(data['data']);
    }
    if (dataClassName == 'ComplianceMetrics') {
      return deserialize<_i15.ComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'ComplianceTrendPoint') {
      return deserialize<_i16.ComplianceTrendPoint>(data['data']);
    }
    if (dataClassName == 'CourseAnalytics') {
      return deserialize<_i17.CourseAnalytics>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_i18.Dashboard>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSnapshot') {
      return deserialize<_i19.DepartmentComplianceSnapshot>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSummary') {
      return deserialize<_i20.DepartmentComplianceSummary>(data['data']);
    }
    if (dataClassName == 'ReportDefinition') {
      return deserialize<_i21.ReportDefinition>(data['data']);
    }
    if (dataClassName == 'SimulationAttempt') {
      return deserialize<_i22.SimulationAttempt>(data['data']);
    }
    if (dataClassName == 'SlaBreach') {
      return deserialize<_i23.SlaBreach>(data['data']);
    }
    if (dataClassName == 'SlaPolicy') {
      return deserialize<_i24.SlaPolicy>(data['data']);
    }
    if (dataClassName == 'UserComplianceMetrics') {
      return deserialize<_i25.UserComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'Assessment') {
      return deserialize<_i26.Assessment>(data['data']);
    }
    if (dataClassName == 'AssessmentAttempt') {
      return deserialize<_i27.AssessmentAttempt>(data['data']);
    }
    if (dataClassName == 'AssessmentResult') {
      return deserialize<_i28.AssessmentResult>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i29.Question>(data['data']);
    }
    if (dataClassName == 'QuestionBank') {
      return deserialize<_i30.QuestionBank>(data['data']);
    }
    if (dataClassName == 'AccessLog') {
      return deserialize<_i31.AccessLog>(data['data']);
    }
    if (dataClassName == 'AuditTrail') {
      return deserialize<_i32.AuditTrail>(data['data']);
    }
    if (dataClassName == 'AuditorPageLog') {
      return deserialize<_i33.AuditorPageLog>(data['data']);
    }
    if (dataClassName == 'AuditorSession') {
      return deserialize<_i34.AuditorSession>(data['data']);
    }
    if (dataClassName == 'ErrorLog') {
      return deserialize<_i35.ErrorLog>(data['data']);
    }
    if (dataClassName == 'InspectionPackage') {
      return deserialize<_i36.InspectionPackage>(data['data']);
    }
    if (dataClassName == 'InspectionRecord') {
      return deserialize<_i37.InspectionRecord>(data['data']);
    }
    if (dataClassName == 'ReportExport') {
      return deserialize<_i38.ReportExport>(data['data']);
    }
    if (dataClassName == 'UserSession') {
      return deserialize<_i39.UserSession>(data['data']);
    }
    if (dataClassName == 'OidcAccount') {
      return deserialize<_i40.OidcAccount>(data['data']);
    }
    if (dataClassName == 'OidcClientConfig') {
      return deserialize<_i41.OidcClientConfig>(data['data']);
    }
    if (dataClassName == 'Assignment') {
      return deserialize<_i42.Assignment>(data['data']);
    }
    if (dataClassName == 'AssignmentSubmission') {
      return deserialize<_i43.AssignmentSubmission>(data['data']);
    }
    if (dataClassName == 'Competency') {
      return deserialize<_i44.Competency>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i45.Course>(data['data']);
    }
    if (dataClassName == 'CourseCompetency') {
      return deserialize<_i46.CourseCompetency>(data['data']);
    }
    if (dataClassName == 'CourseReview') {
      return deserialize<_i47.CourseReview>(data['data']);
    }
    if (dataClassName == 'CourseSopLink') {
      return deserialize<_i48.CourseSopLink>(data['data']);
    }
    if (dataClassName == 'CourseVersion') {
      return deserialize<_i49.CourseVersion>(data['data']);
    }
    if (dataClassName == 'Curriculum') {
      return deserialize<_i50.Curriculum>(data['data']);
    }
    if (dataClassName == 'CurriculumCourse') {
      return deserialize<_i51.CurriculumCourse>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i52.Lesson>(data['data']);
    }
    if (dataClassName == 'LessonBlock') {
      return deserialize<_i53.LessonBlock>(data['data']);
    }
    if (dataClassName == 'Module') {
      return deserialize<_i54.Module>(data['data']);
    }
    if (dataClassName == 'QaValidationResult') {
      return deserialize<_i55.QaValidationResult>(data['data']);
    }
    if (dataClassName == 'QaValidationRuleResult') {
      return deserialize<_i56.QaValidationRuleResult>(data['data']);
    }
    if (dataClassName == 'UserCompetency') {
      return deserialize<_i57.UserCompetency>(data['data']);
    }
    if (dataClassName == 'DashboardComplianceAlert') {
      return deserialize<_i58.DashboardComplianceAlert>(data['data']);
    }
    if (dataClassName == 'DashboardEsignatureSummary') {
      return deserialize<_i59.DashboardEsignatureSummary>(data['data']);
    }
    if (dataClassName == 'DashboardItem') {
      return deserialize<_i60.DashboardItem>(data['data']);
    }
    if (dataClassName == 'DashboardRecentActivity') {
      return deserialize<_i61.DashboardRecentActivity>(data['data']);
    }
    if (dataClassName == 'DashboardUpcomingDueDate') {
      return deserialize<_i62.DashboardUpcomingDueDate>(data['data']);
    }
    if (dataClassName == 'DashboardWeeklyProgress') {
      return deserialize<_i63.DashboardWeeklyProgress>(data['data']);
    }
    if (dataClassName == 'ApprovalWorkflow') {
      return deserialize<_i64.ApprovalWorkflow>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i65.Document>(data['data']);
    }
    if (dataClassName == 'DocumentLifecycle') {
      return deserialize<_i66.DocumentLifecycle>(data['data']);
    }
    if (dataClassName == 'DocumentVersion') {
      return deserialize<_i67.DocumentVersion>(data['data']);
    }
    if (dataClassName == 'DeadLetterQueue') {
      return deserialize<_i68.DeadLetterQueue>(data['data']);
    }
    if (dataClassName == 'DomainEvent') {
      return deserialize<_i69.DomainEvent>(data['data']);
    }
    if (dataClassName == 'OutboxMessage') {
      return deserialize<_i70.OutboxMessage>(data['data']);
    }
    if (dataClassName == 'KafkaEventProcessorProcessEmployeeCreatedModel') {
      return deserialize<_i71.KafkaEventProcessorProcessEmployeeCreatedModel>(
        data['data'],
      );
    }
    if (dataClassName == 'KafkaEventProcessorProcessEmployeeTransferredModel') {
      return deserialize<
        _i72.KafkaEventProcessorProcessEmployeeTransferredModel
      >(data['data']);
    }
    if (dataClassName == 'KafkaEventProcessorProcessSopUpdatedModel') {
      return deserialize<_i73.KafkaEventProcessorProcessSopUpdatedModel>(
        data['data'],
      );
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i74.Greeting>(data['data']);
    }
    if (dataClassName == 'AuditIntegrityResult') {
      return deserialize<_i75.AuditIntegrityResult>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i76.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'RetentionArchive') {
      return deserialize<_i77.RetentionArchive>(data['data']);
    }
    if (dataClassName == 'RetentionPolicy') {
      return deserialize<_i78.RetentionPolicy>(data['data']);
    }
    if (dataClassName == 'ScheduledJobLog') {
      return deserialize<_i79.ScheduledJobLog>(data['data']);
    }
    if (dataClassName == 'SystemConfiguration') {
      return deserialize<_i80.SystemConfiguration>(data['data']);
    }
    if (dataClassName == 'Material') {
      return deserialize<_i81.Material>(data['data']);
    }
    if (dataClassName == 'MaterialProgress') {
      return deserialize<_i82.MaterialProgress>(data['data']);
    }
    if (dataClassName == 'MaterialVersion') {
      return deserialize<_i83.MaterialVersion>(data['data']);
    }
    if (dataClassName == 'MediaAsset') {
      return deserialize<_i84.MediaAsset>(data['data']);
    }
    if (dataClassName == 'MfaEnrollResult') {
      return deserialize<_i85.MfaEnrollResult>(data['data']);
    }
    if (dataClassName == 'MfaStatusResult') {
      return deserialize<_i86.MfaStatusResult>(data['data']);
    }
    if (dataClassName == 'MfaVerifiedSession') {
      return deserialize<_i87.MfaVerifiedSession>(data['data']);
    }
    if (dataClassName == 'UserMfa') {
      return deserialize<_i88.UserMfa>(data['data']);
    }
    if (dataClassName == 'InAppNotification') {
      return deserialize<_i89.InAppNotification>(data['data']);
    }
    if (dataClassName == 'MessagingUnreadCounts') {
      return deserialize<_i90.MessagingUnreadCounts>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i91.Notification>(data['data']);
    }
    if (dataClassName == 'NotificationLog') {
      return deserialize<_i92.NotificationLog>(data['data']);
    }
    if (dataClassName == 'NotificationTemplate') {
      return deserialize<_i93.NotificationTemplate>(data['data']);
    }
    if (dataClassName == 'Department') {
      return deserialize<_i94.Department>(data['data']);
    }
    if (dataClassName == 'Facility') {
      return deserialize<_i95.Facility>(data['data']);
    }
    if (dataClassName == 'JobRole') {
      return deserialize<_i96.JobRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i97.Organization>(data['data']);
    }
    if (dataClassName == 'Permission') {
      return deserialize<_i98.Permission>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i99.Role>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i100.Site>(data['data']);
    }
    if (dataClassName == 'PharmaUser') {
      return deserialize<_i101.PharmaUser>(data['data']);
    }
    if (dataClassName == 'UserPreference') {
      return deserialize<_i102.UserPreference>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i103.UserRole>(data['data']);
    }
    if (dataClassName == 'Capa') {
      return deserialize<_i104.Capa>(data['data']);
    }
    if (dataClassName == 'ChangeControl') {
      return deserialize<_i105.ChangeControl>(data['data']);
    }
    if (dataClassName == 'InspectionReport') {
      return deserialize<_i106.InspectionReport>(data['data']);
    }
    if (dataClassName == 'QualityEvent') {
      return deserialize<_i107.QualityEvent>(data['data']);
    }
    if (dataClassName == 'AbacPolicy') {
      return deserialize<_i108.AbacPolicy>(data['data']);
    }
    if (dataClassName == 'DelegatedAuthority') {
      return deserialize<_i109.DelegatedAuthority>(data['data']);
    }
    if (dataClassName == 'ElectronicSignature') {
      return deserialize<_i110.ElectronicSignature>(data['data']);
    }
    if (dataClassName == 'SignatureMeaning') {
      return deserialize<_i111.SignatureMeaning>(data['data']);
    }
    if (dataClassName == 'SignatureVerificationResult') {
      return deserialize<_i112.SignatureVerificationResult>(data['data']);
    }
    if (dataClassName == 'SmeAssignment') {
      return deserialize<_i113.SmeAssignment>(data['data']);
    }
    if (dataClassName == 'SmeReviewComment') {
      return deserialize<_i114.SmeReviewComment>(data['data']);
    }
    if (dataClassName == 'SmeThreadSummary') {
      return deserialize<_i115.SmeThreadSummary>(data['data']);
    }
    if (dataClassName == 'BatchAnnouncement') {
      return deserialize<_i116.BatchAnnouncement>(data['data']);
    }
    if (dataClassName == 'BatchAttendanceRecord') {
      return deserialize<_i117.BatchAttendanceRecord>(data['data']);
    }
    if (dataClassName == 'BatchParticipantInfo') {
      return deserialize<_i118.BatchParticipantInfo>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i119.Certificate>(data['data']);
    }
    if (dataClassName == 'CertificateTemplate') {
      return deserialize<_i120.CertificateTemplate>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i121.Enrollment>(data['data']);
    }
    if (dataClassName == 'LearnerSupportThreadSummary') {
      return deserialize<_i122.LearnerSupportThreadSummary>(data['data']);
    }
    if (dataClassName == 'LearnerTrainerMessage') {
      return deserialize<_i123.LearnerTrainerMessage>(data['data']);
    }
    if (dataClassName == 'LiveClass') {
      return deserialize<_i124.LiveClass>(data['data']);
    }
    if (dataClassName == 'ObservationLog') {
      return deserialize<_i125.ObservationLog>(data['data']);
    }
    if (dataClassName == 'PracticalChecklistItem') {
      return deserialize<_i126.PracticalChecklistItem>(data['data']);
    }
    if (dataClassName == 'StandaloneAssignment') {
      return deserialize<_i127.StandaloneAssignment>(data['data']);
    }
    if (dataClassName == 'StandaloneAssignmentRecipient') {
      return deserialize<_i128.StandaloneAssignmentRecipient>(data['data']);
    }
    if (dataClassName == 'TrainingAssignment') {
      return deserialize<_i129.TrainingAssignment>(data['data']);
    }
    if (dataClassName == 'TrainingBatch') {
      return deserialize<_i130.TrainingBatch>(data['data']);
    }
    if (dataClassName == 'TrainingBatchParticipant') {
      return deserialize<_i131.TrainingBatchParticipant>(data['data']);
    }
    if (dataClassName == 'TrainingExpiration') {
      return deserialize<_i132.TrainingExpiration>(data['data']);
    }
    if (dataClassName == 'TrainingMatrix') {
      return deserialize<_i133.TrainingMatrix>(data['data']);
    }
    if (dataClassName == 'TrainingRecord') {
      return deserialize<_i134.TrainingRecord>(data['data']);
    }
    if (dataClassName == 'TrainingRecordAnnotation') {
      return deserialize<_i135.TrainingRecordAnnotation>(data['data']);
    }
    if (dataClassName == 'TrainingWaiver') {
      return deserialize<_i136.TrainingWaiver>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i5.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i5.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.AccessReview:
        return _i6.AccessReview.t;
      case _i7.AccessReviewWindow:
        return _i7.AccessReviewWindow.t;
      case _i8.RoleHistory:
        return _i8.RoleHistory.t;
      case _i10.ImportLog:
        return _i10.ImportLog.t;
      case _i12.AnalyticsSnapshot:
        return _i12.AnalyticsSnapshot.t;
      case _i18.Dashboard:
        return _i18.Dashboard.t;
      case _i19.DepartmentComplianceSnapshot:
        return _i19.DepartmentComplianceSnapshot.t;
      case _i21.ReportDefinition:
        return _i21.ReportDefinition.t;
      case _i22.SimulationAttempt:
        return _i22.SimulationAttempt.t;
      case _i23.SlaBreach:
        return _i23.SlaBreach.t;
      case _i24.SlaPolicy:
        return _i24.SlaPolicy.t;
      case _i26.Assessment:
        return _i26.Assessment.t;
      case _i27.AssessmentAttempt:
        return _i27.AssessmentAttempt.t;
      case _i28.AssessmentResult:
        return _i28.AssessmentResult.t;
      case _i29.Question:
        return _i29.Question.t;
      case _i30.QuestionBank:
        return _i30.QuestionBank.t;
      case _i31.AccessLog:
        return _i31.AccessLog.t;
      case _i32.AuditTrail:
        return _i32.AuditTrail.t;
      case _i33.AuditorPageLog:
        return _i33.AuditorPageLog.t;
      case _i34.AuditorSession:
        return _i34.AuditorSession.t;
      case _i35.ErrorLog:
        return _i35.ErrorLog.t;
      case _i36.InspectionPackage:
        return _i36.InspectionPackage.t;
      case _i37.InspectionRecord:
        return _i37.InspectionRecord.t;
      case _i38.ReportExport:
        return _i38.ReportExport.t;
      case _i39.UserSession:
        return _i39.UserSession.t;
      case _i40.OidcAccount:
        return _i40.OidcAccount.t;
      case _i42.Assignment:
        return _i42.Assignment.t;
      case _i43.AssignmentSubmission:
        return _i43.AssignmentSubmission.t;
      case _i44.Competency:
        return _i44.Competency.t;
      case _i45.Course:
        return _i45.Course.t;
      case _i46.CourseCompetency:
        return _i46.CourseCompetency.t;
      case _i47.CourseReview:
        return _i47.CourseReview.t;
      case _i48.CourseSopLink:
        return _i48.CourseSopLink.t;
      case _i49.CourseVersion:
        return _i49.CourseVersion.t;
      case _i50.Curriculum:
        return _i50.Curriculum.t;
      case _i51.CurriculumCourse:
        return _i51.CurriculumCourse.t;
      case _i52.Lesson:
        return _i52.Lesson.t;
      case _i53.LessonBlock:
        return _i53.LessonBlock.t;
      case _i54.Module:
        return _i54.Module.t;
      case _i57.UserCompetency:
        return _i57.UserCompetency.t;
      case _i64.ApprovalWorkflow:
        return _i64.ApprovalWorkflow.t;
      case _i65.Document:
        return _i65.Document.t;
      case _i66.DocumentLifecycle:
        return _i66.DocumentLifecycle.t;
      case _i67.DocumentVersion:
        return _i67.DocumentVersion.t;
      case _i68.DeadLetterQueue:
        return _i68.DeadLetterQueue.t;
      case _i69.DomainEvent:
        return _i69.DomainEvent.t;
      case _i70.OutboxMessage:
        return _i70.OutboxMessage.t;
      case _i75.AuditIntegrityResult:
        return _i75.AuditIntegrityResult.t;
      case _i76.FeatureFlag:
        return _i76.FeatureFlag.t;
      case _i77.RetentionArchive:
        return _i77.RetentionArchive.t;
      case _i78.RetentionPolicy:
        return _i78.RetentionPolicy.t;
      case _i79.ScheduledJobLog:
        return _i79.ScheduledJobLog.t;
      case _i80.SystemConfiguration:
        return _i80.SystemConfiguration.t;
      case _i81.Material:
        return _i81.Material.t;
      case _i82.MaterialProgress:
        return _i82.MaterialProgress.t;
      case _i83.MaterialVersion:
        return _i83.MaterialVersion.t;
      case _i84.MediaAsset:
        return _i84.MediaAsset.t;
      case _i87.MfaVerifiedSession:
        return _i87.MfaVerifiedSession.t;
      case _i88.UserMfa:
        return _i88.UserMfa.t;
      case _i91.Notification:
        return _i91.Notification.t;
      case _i92.NotificationLog:
        return _i92.NotificationLog.t;
      case _i93.NotificationTemplate:
        return _i93.NotificationTemplate.t;
      case _i94.Department:
        return _i94.Department.t;
      case _i95.Facility:
        return _i95.Facility.t;
      case _i96.JobRole:
        return _i96.JobRole.t;
      case _i97.Organization:
        return _i97.Organization.t;
      case _i98.Permission:
        return _i98.Permission.t;
      case _i99.Role:
        return _i99.Role.t;
      case _i100.Site:
        return _i100.Site.t;
      case _i101.PharmaUser:
        return _i101.PharmaUser.t;
      case _i102.UserPreference:
        return _i102.UserPreference.t;
      case _i103.UserRole:
        return _i103.UserRole.t;
      case _i104.Capa:
        return _i104.Capa.t;
      case _i105.ChangeControl:
        return _i105.ChangeControl.t;
      case _i106.InspectionReport:
        return _i106.InspectionReport.t;
      case _i107.QualityEvent:
        return _i107.QualityEvent.t;
      case _i108.AbacPolicy:
        return _i108.AbacPolicy.t;
      case _i109.DelegatedAuthority:
        return _i109.DelegatedAuthority.t;
      case _i110.ElectronicSignature:
        return _i110.ElectronicSignature.t;
      case _i111.SignatureMeaning:
        return _i111.SignatureMeaning.t;
      case _i113.SmeAssignment:
        return _i113.SmeAssignment.t;
      case _i114.SmeReviewComment:
        return _i114.SmeReviewComment.t;
      case _i116.BatchAnnouncement:
        return _i116.BatchAnnouncement.t;
      case _i117.BatchAttendanceRecord:
        return _i117.BatchAttendanceRecord.t;
      case _i119.Certificate:
        return _i119.Certificate.t;
      case _i120.CertificateTemplate:
        return _i120.CertificateTemplate.t;
      case _i121.Enrollment:
        return _i121.Enrollment.t;
      case _i123.LearnerTrainerMessage:
        return _i123.LearnerTrainerMessage.t;
      case _i124.LiveClass:
        return _i124.LiveClass.t;
      case _i125.ObservationLog:
        return _i125.ObservationLog.t;
      case _i126.PracticalChecklistItem:
        return _i126.PracticalChecklistItem.t;
      case _i127.StandaloneAssignment:
        return _i127.StandaloneAssignment.t;
      case _i128.StandaloneAssignmentRecipient:
        return _i128.StandaloneAssignmentRecipient.t;
      case _i129.TrainingAssignment:
        return _i129.TrainingAssignment.t;
      case _i130.TrainingBatch:
        return _i130.TrainingBatch.t;
      case _i131.TrainingBatchParticipant:
        return _i131.TrainingBatchParticipant.t;
      case _i132.TrainingExpiration:
        return _i132.TrainingExpiration.t;
      case _i133.TrainingMatrix:
        return _i133.TrainingMatrix.t;
      case _i134.TrainingRecord:
        return _i134.TrainingRecord.t;
      case _i135.TrainingRecordAnnotation:
        return _i135.TrainingRecordAnnotation.t;
      case _i136.TrainingWaiver:
        return _i136.TrainingWaiver.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pharma_lms';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i5.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
