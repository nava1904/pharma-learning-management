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
import 'admin/bulk_import_result.dart' as _i6;
import 'admin/import_log.dart' as _i7;
import 'analytics/analytics_event.dart' as _i8;
import 'analytics/audit_readiness_score.dart' as _i9;
import 'analytics/compliance_metrics.dart' as _i10;
import 'analytics/course_analytics.dart' as _i11;
import 'analytics/dashboard.dart' as _i12;
import 'analytics/department_compliance_summary.dart' as _i13;
import 'analytics/report_definition.dart' as _i14;
import 'analytics/sla_breach.dart' as _i15;
import 'analytics/sla_policy.dart' as _i16;
import 'analytics/user_compliance_metrics.dart' as _i17;
import 'assessment/assessment.dart' as _i18;
import 'assessment/assessment_attempt.dart' as _i19;
import 'assessment/assessment_result.dart' as _i20;
import 'assessment/question.dart' as _i21;
import 'assessment/question_bank.dart' as _i22;
import 'audit/access_log.dart' as _i23;
import 'audit/audit_trail.dart' as _i24;
import 'audit/auditor_page_log.dart' as _i25;
import 'audit/auditor_session.dart' as _i26;
import 'audit/error_log.dart' as _i27;
import 'audit/inspection_package.dart' as _i28;
import 'audit/inspection_record.dart' as _i29;
import 'audit/report_export.dart' as _i30;
import 'audit/user_session.dart' as _i31;
import 'auth/oidc_account.dart' as _i32;
import 'auth/oidc_client_config.dart' as _i33;
import 'course/competency.dart' as _i34;
import 'course/course.dart' as _i35;
import 'course/course_competency.dart' as _i36;
import 'course/course_review.dart' as _i37;
import 'course/course_version.dart' as _i38;
import 'course/lesson.dart' as _i39;
import 'course/module.dart' as _i40;
import 'course/user_competency.dart' as _i41;
import 'document/approval_workflow.dart' as _i42;
import 'document/document.dart' as _i43;
import 'document/document_lifecycle.dart' as _i44;
import 'document/document_version.dart' as _i45;
import 'events/dead_letter_queue.dart' as _i46;
import 'events/domain_event.dart' as _i47;
import 'events/outbox_message.dart' as _i48;
import 'future_calls_generated_models/kafka_event_processor_process_employee_created_model.dart'
    as _i49;
import 'future_calls_generated_models/kafka_event_processor_process_employee_transferred_model.dart'
    as _i50;
import 'future_calls_generated_models/kafka_event_processor_process_sop_updated_model.dart'
    as _i51;
import 'greetings/greeting.dart' as _i52;
import 'infrastructure/feature_flag.dart' as _i53;
import 'infrastructure/retention_archive.dart' as _i54;
import 'infrastructure/retention_policy.dart' as _i55;
import 'infrastructure/scheduled_job_log.dart' as _i56;
import 'infrastructure/system_configuration.dart' as _i57;
import 'material/material.dart' as _i58;
import 'material/material_progress.dart' as _i59;
import 'material/material_version.dart' as _i60;
import 'material/media_asset.dart' as _i61;
import 'mfa/mfa_enroll_result.dart' as _i62;
import 'mfa/mfa_status_result.dart' as _i63;
import 'mfa/mfa_verified_session.dart' as _i64;
import 'mfa/user_mfa.dart' as _i65;
import 'notifications/in_app_notification.dart' as _i66;
import 'notifications/notification.dart' as _i67;
import 'organization/department.dart' as _i68;
import 'organization/job_role.dart' as _i69;
import 'organization/organization.dart' as _i70;
import 'organization/permission.dart' as _i71;
import 'organization/role.dart' as _i72;
import 'organization/site.dart' as _i73;
import 'organization/user.dart' as _i74;
import 'organization/user_role.dart' as _i75;
import 'quality/capa.dart' as _i76;
import 'quality/change_control.dart' as _i77;
import 'quality/inspection_report.dart' as _i78;
import 'quality/quality_event.dart' as _i79;
import 'security/abac_policy.dart' as _i80;
import 'security/delegated_authority.dart' as _i81;
import 'shared/electronic_signature.dart' as _i82;
import 'shared/signature_meaning.dart' as _i83;
import 'shared/signature_verification_result.dart' as _i84;
import 'training/certificate.dart' as _i85;
import 'training/enrollment.dart' as _i86;
import 'training/training_assignment.dart' as _i87;
import 'training/training_expiration.dart' as _i88;
import 'training/training_matrix.dart' as _i89;
import 'training/training_record.dart' as _i90;
import 'training/training_record_annotation.dart' as _i91;
import 'training/training_waiver.dart' as _i92;
import 'package:pharma_lms_server/src/generated/shared/signature_meaning.dart'
    as _i93;
import 'package:pharma_lms_server/src/generated/training/training_assignment.dart'
    as _i94;
import 'package:pharma_lms_server/src/generated/training/training_waiver.dart'
    as _i95;
import 'package:pharma_lms_server/src/generated/analytics/department_compliance_summary.dart'
    as _i96;
import 'package:pharma_lms_server/src/generated/analytics/report_definition.dart'
    as _i97;
import 'package:pharma_lms_server/src/generated/analytics/dashboard.dart'
    as _i98;
import 'package:pharma_lms_server/src/generated/analytics/sla_breach.dart'
    as _i99;
import 'package:pharma_lms_server/src/generated/organization/user.dart'
    as _i100;
import 'package:pharma_lms_server/src/generated/training/certificate.dart'
    as _i101;
import 'package:pharma_lms_server/src/generated/quality/capa.dart' as _i102;
import 'package:pharma_lms_server/src/generated/assessment/question.dart'
    as _i103;
import 'package:pharma_lms_server/src/generated/assessment/question_bank.dart'
    as _i104;
import 'package:pharma_lms_server/src/generated/audit/audit_trail.dart'
    as _i105;
import 'package:pharma_lms_server/src/generated/audit/access_log.dart' as _i106;
import 'package:pharma_lms_server/src/generated/course/course.dart' as _i107;
import 'package:pharma_lms_server/src/generated/course/course_version.dart'
    as _i108;
import 'package:pharma_lms_server/src/generated/course/module.dart' as _i109;
import 'package:pharma_lms_server/src/generated/course/lesson.dart' as _i110;
import 'package:pharma_lms_server/src/generated/document/document.dart'
    as _i111;
import 'package:pharma_lms_server/src/generated/document/document_version.dart'
    as _i112;
import 'package:pharma_lms_server/src/generated/document/document_lifecycle.dart'
    as _i113;
import 'package:pharma_lms_server/src/generated/audit/inspection_record.dart'
    as _i114;
import 'package:pharma_lms_server/src/generated/audit/auditor_page_log.dart'
    as _i115;
import 'package:pharma_lms_server/src/generated/audit/inspection_package.dart'
    as _i116;
import 'package:pharma_lms_server/src/generated/material/material_version.dart'
    as _i117;
import 'package:pharma_lms_server/src/generated/material/material.dart'
    as _i118;
import 'package:pharma_lms_server/src/generated/notifications/in_app_notification.dart'
    as _i119;
import 'package:pharma_lms_server/src/generated/organization/organization.dart'
    as _i120;
import 'package:pharma_lms_server/src/generated/organization/site.dart'
    as _i121;
import 'package:pharma_lms_server/src/generated/organization/department.dart'
    as _i122;
import 'package:pharma_lms_server/src/generated/organization/job_role.dart'
    as _i123;
import 'package:pharma_lms_server/src/generated/quality/quality_event.dart'
    as _i124;
import 'package:pharma_lms_server/src/generated/quality/inspection_report.dart'
    as _i125;
import 'package:pharma_lms_server/src/generated/training/enrollment.dart'
    as _i126;
import 'package:pharma_lms_server/src/generated/training/training_record.dart'
    as _i127;
import 'package:pharma_lms_server/src/generated/shared/electronic_signature.dart'
    as _i128;
import 'package:pharma_lms_server/src/generated/training/training_record_annotation.dart'
    as _i129;
export 'admin/bulk_import_result.dart';
export 'admin/import_log.dart';
export 'analytics/analytics_event.dart';
export 'analytics/audit_readiness_score.dart';
export 'analytics/compliance_metrics.dart';
export 'analytics/course_analytics.dart';
export 'analytics/dashboard.dart';
export 'analytics/department_compliance_summary.dart';
export 'analytics/report_definition.dart';
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
export 'course/competency.dart';
export 'course/course.dart';
export 'course/course_competency.dart';
export 'course/course_review.dart';
export 'course/course_version.dart';
export 'course/lesson.dart';
export 'course/module.dart';
export 'course/user_competency.dart';
export 'document/approval_workflow.dart';
export 'document/document.dart';
export 'document/document_lifecycle.dart';
export 'document/document_version.dart';
export 'events/dead_letter_queue.dart';
export 'events/domain_event.dart';
export 'events/outbox_message.dart';
export 'greetings/greeting.dart';
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
export 'notifications/notification.dart';
export 'organization/department.dart';
export 'organization/job_role.dart';
export 'organization/organization.dart';
export 'organization/permission.dart';
export 'organization/role.dart';
export 'organization/site.dart';
export 'organization/user.dart';
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
export 'training/certificate.dart';
export 'training/enrollment.dart';
export 'training/training_assignment.dart';
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
          isNullable: false,
          dartType: 'int',
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
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'difficulty',
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

    if (t == _i6.BulkImportResult) {
      return _i6.BulkImportResult.fromJson(data) as T;
    }
    if (t == _i7.ImportLog) {
      return _i7.ImportLog.fromJson(data) as T;
    }
    if (t == _i8.AnalyticsEvent) {
      return _i8.AnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i9.AuditReadinessScore) {
      return _i9.AuditReadinessScore.fromJson(data) as T;
    }
    if (t == _i10.ComplianceMetrics) {
      return _i10.ComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i11.CourseAnalytics) {
      return _i11.CourseAnalytics.fromJson(data) as T;
    }
    if (t == _i12.Dashboard) {
      return _i12.Dashboard.fromJson(data) as T;
    }
    if (t == _i13.DepartmentComplianceSummary) {
      return _i13.DepartmentComplianceSummary.fromJson(data) as T;
    }
    if (t == _i14.ReportDefinition) {
      return _i14.ReportDefinition.fromJson(data) as T;
    }
    if (t == _i15.SlaBreach) {
      return _i15.SlaBreach.fromJson(data) as T;
    }
    if (t == _i16.SlaPolicy) {
      return _i16.SlaPolicy.fromJson(data) as T;
    }
    if (t == _i17.UserComplianceMetrics) {
      return _i17.UserComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i18.Assessment) {
      return _i18.Assessment.fromJson(data) as T;
    }
    if (t == _i19.AssessmentAttempt) {
      return _i19.AssessmentAttempt.fromJson(data) as T;
    }
    if (t == _i20.AssessmentResult) {
      return _i20.AssessmentResult.fromJson(data) as T;
    }
    if (t == _i21.Question) {
      return _i21.Question.fromJson(data) as T;
    }
    if (t == _i22.QuestionBank) {
      return _i22.QuestionBank.fromJson(data) as T;
    }
    if (t == _i23.AccessLog) {
      return _i23.AccessLog.fromJson(data) as T;
    }
    if (t == _i24.AuditTrail) {
      return _i24.AuditTrail.fromJson(data) as T;
    }
    if (t == _i25.AuditorPageLog) {
      return _i25.AuditorPageLog.fromJson(data) as T;
    }
    if (t == _i26.AuditorSession) {
      return _i26.AuditorSession.fromJson(data) as T;
    }
    if (t == _i27.ErrorLog) {
      return _i27.ErrorLog.fromJson(data) as T;
    }
    if (t == _i28.InspectionPackage) {
      return _i28.InspectionPackage.fromJson(data) as T;
    }
    if (t == _i29.InspectionRecord) {
      return _i29.InspectionRecord.fromJson(data) as T;
    }
    if (t == _i30.ReportExport) {
      return _i30.ReportExport.fromJson(data) as T;
    }
    if (t == _i31.UserSession) {
      return _i31.UserSession.fromJson(data) as T;
    }
    if (t == _i32.OidcAccount) {
      return _i32.OidcAccount.fromJson(data) as T;
    }
    if (t == _i33.OidcClientConfig) {
      return _i33.OidcClientConfig.fromJson(data) as T;
    }
    if (t == _i34.Competency) {
      return _i34.Competency.fromJson(data) as T;
    }
    if (t == _i35.Course) {
      return _i35.Course.fromJson(data) as T;
    }
    if (t == _i36.CourseCompetency) {
      return _i36.CourseCompetency.fromJson(data) as T;
    }
    if (t == _i37.CourseReview) {
      return _i37.CourseReview.fromJson(data) as T;
    }
    if (t == _i38.CourseVersion) {
      return _i38.CourseVersion.fromJson(data) as T;
    }
    if (t == _i39.Lesson) {
      return _i39.Lesson.fromJson(data) as T;
    }
    if (t == _i40.Module) {
      return _i40.Module.fromJson(data) as T;
    }
    if (t == _i41.UserCompetency) {
      return _i41.UserCompetency.fromJson(data) as T;
    }
    if (t == _i42.ApprovalWorkflow) {
      return _i42.ApprovalWorkflow.fromJson(data) as T;
    }
    if (t == _i43.Document) {
      return _i43.Document.fromJson(data) as T;
    }
    if (t == _i44.DocumentLifecycle) {
      return _i44.DocumentLifecycle.fromJson(data) as T;
    }
    if (t == _i45.DocumentVersion) {
      return _i45.DocumentVersion.fromJson(data) as T;
    }
    if (t == _i46.DeadLetterQueue) {
      return _i46.DeadLetterQueue.fromJson(data) as T;
    }
    if (t == _i47.DomainEvent) {
      return _i47.DomainEvent.fromJson(data) as T;
    }
    if (t == _i48.OutboxMessage) {
      return _i48.OutboxMessage.fromJson(data) as T;
    }
    if (t == _i49.KafkaEventProcessorProcessEmployeeCreatedModel) {
      return _i49.KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(data)
          as T;
    }
    if (t == _i50.KafkaEventProcessorProcessEmployeeTransferredModel) {
      return _i50.KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
            data,
          )
          as T;
    }
    if (t == _i51.KafkaEventProcessorProcessSopUpdatedModel) {
      return _i51.KafkaEventProcessorProcessSopUpdatedModel.fromJson(data) as T;
    }
    if (t == _i52.Greeting) {
      return _i52.Greeting.fromJson(data) as T;
    }
    if (t == _i53.FeatureFlag) {
      return _i53.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i54.RetentionArchive) {
      return _i54.RetentionArchive.fromJson(data) as T;
    }
    if (t == _i55.RetentionPolicy) {
      return _i55.RetentionPolicy.fromJson(data) as T;
    }
    if (t == _i56.ScheduledJobLog) {
      return _i56.ScheduledJobLog.fromJson(data) as T;
    }
    if (t == _i57.SystemConfiguration) {
      return _i57.SystemConfiguration.fromJson(data) as T;
    }
    if (t == _i58.Material) {
      return _i58.Material.fromJson(data) as T;
    }
    if (t == _i59.MaterialProgress) {
      return _i59.MaterialProgress.fromJson(data) as T;
    }
    if (t == _i60.MaterialVersion) {
      return _i60.MaterialVersion.fromJson(data) as T;
    }
    if (t == _i61.MediaAsset) {
      return _i61.MediaAsset.fromJson(data) as T;
    }
    if (t == _i62.MfaEnrollResult) {
      return _i62.MfaEnrollResult.fromJson(data) as T;
    }
    if (t == _i63.MfaStatusResult) {
      return _i63.MfaStatusResult.fromJson(data) as T;
    }
    if (t == _i64.MfaVerifiedSession) {
      return _i64.MfaVerifiedSession.fromJson(data) as T;
    }
    if (t == _i65.UserMfa) {
      return _i65.UserMfa.fromJson(data) as T;
    }
    if (t == _i66.InAppNotification) {
      return _i66.InAppNotification.fromJson(data) as T;
    }
    if (t == _i67.Notification) {
      return _i67.Notification.fromJson(data) as T;
    }
    if (t == _i68.Department) {
      return _i68.Department.fromJson(data) as T;
    }
    if (t == _i69.JobRole) {
      return _i69.JobRole.fromJson(data) as T;
    }
    if (t == _i70.Organization) {
      return _i70.Organization.fromJson(data) as T;
    }
    if (t == _i71.Permission) {
      return _i71.Permission.fromJson(data) as T;
    }
    if (t == _i72.Role) {
      return _i72.Role.fromJson(data) as T;
    }
    if (t == _i73.Site) {
      return _i73.Site.fromJson(data) as T;
    }
    if (t == _i74.PharmaUser) {
      return _i74.PharmaUser.fromJson(data) as T;
    }
    if (t == _i75.UserRole) {
      return _i75.UserRole.fromJson(data) as T;
    }
    if (t == _i76.Capa) {
      return _i76.Capa.fromJson(data) as T;
    }
    if (t == _i77.ChangeControl) {
      return _i77.ChangeControl.fromJson(data) as T;
    }
    if (t == _i78.InspectionReport) {
      return _i78.InspectionReport.fromJson(data) as T;
    }
    if (t == _i79.QualityEvent) {
      return _i79.QualityEvent.fromJson(data) as T;
    }
    if (t == _i80.AbacPolicy) {
      return _i80.AbacPolicy.fromJson(data) as T;
    }
    if (t == _i81.DelegatedAuthority) {
      return _i81.DelegatedAuthority.fromJson(data) as T;
    }
    if (t == _i82.ElectronicSignature) {
      return _i82.ElectronicSignature.fromJson(data) as T;
    }
    if (t == _i83.SignatureMeaning) {
      return _i83.SignatureMeaning.fromJson(data) as T;
    }
    if (t == _i84.SignatureVerificationResult) {
      return _i84.SignatureVerificationResult.fromJson(data) as T;
    }
    if (t == _i85.Certificate) {
      return _i85.Certificate.fromJson(data) as T;
    }
    if (t == _i86.Enrollment) {
      return _i86.Enrollment.fromJson(data) as T;
    }
    if (t == _i87.TrainingAssignment) {
      return _i87.TrainingAssignment.fromJson(data) as T;
    }
    if (t == _i88.TrainingExpiration) {
      return _i88.TrainingExpiration.fromJson(data) as T;
    }
    if (t == _i89.TrainingMatrix) {
      return _i89.TrainingMatrix.fromJson(data) as T;
    }
    if (t == _i90.TrainingRecord) {
      return _i90.TrainingRecord.fromJson(data) as T;
    }
    if (t == _i91.TrainingRecordAnnotation) {
      return _i91.TrainingRecordAnnotation.fromJson(data) as T;
    }
    if (t == _i92.TrainingWaiver) {
      return _i92.TrainingWaiver.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.BulkImportResult?>()) {
      return (data != null ? _i6.BulkImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ImportLog?>()) {
      return (data != null ? _i7.ImportLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AnalyticsEvent?>()) {
      return (data != null ? _i8.AnalyticsEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AuditReadinessScore?>()) {
      return (data != null ? _i9.AuditReadinessScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ComplianceMetrics?>()) {
      return (data != null ? _i10.ComplianceMetrics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CourseAnalytics?>()) {
      return (data != null ? _i11.CourseAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Dashboard?>()) {
      return (data != null ? _i12.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.DepartmentComplianceSummary?>()) {
      return (data != null
              ? _i13.DepartmentComplianceSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.ReportDefinition?>()) {
      return (data != null ? _i14.ReportDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SlaBreach?>()) {
      return (data != null ? _i15.SlaBreach.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.SlaPolicy?>()) {
      return (data != null ? _i16.SlaPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserComplianceMetrics?>()) {
      return (data != null ? _i17.UserComplianceMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.Assessment?>()) {
      return (data != null ? _i18.Assessment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AssessmentAttempt?>()) {
      return (data != null ? _i19.AssessmentAttempt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.AssessmentResult?>()) {
      return (data != null ? _i20.AssessmentResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Question?>()) {
      return (data != null ? _i21.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.QuestionBank?>()) {
      return (data != null ? _i22.QuestionBank.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.AccessLog?>()) {
      return (data != null ? _i23.AccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.AuditTrail?>()) {
      return (data != null ? _i24.AuditTrail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.AuditorPageLog?>()) {
      return (data != null ? _i25.AuditorPageLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.AuditorSession?>()) {
      return (data != null ? _i26.AuditorSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.ErrorLog?>()) {
      return (data != null ? _i27.ErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.InspectionPackage?>()) {
      return (data != null ? _i28.InspectionPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.InspectionRecord?>()) {
      return (data != null ? _i29.InspectionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ReportExport?>()) {
      return (data != null ? _i30.ReportExport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.UserSession?>()) {
      return (data != null ? _i31.UserSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.OidcAccount?>()) {
      return (data != null ? _i32.OidcAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.OidcClientConfig?>()) {
      return (data != null ? _i33.OidcClientConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Competency?>()) {
      return (data != null ? _i34.Competency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Course?>()) {
      return (data != null ? _i35.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CourseCompetency?>()) {
      return (data != null ? _i36.CourseCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CourseReview?>()) {
      return (data != null ? _i37.CourseReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.CourseVersion?>()) {
      return (data != null ? _i38.CourseVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.Lesson?>()) {
      return (data != null ? _i39.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.Module?>()) {
      return (data != null ? _i40.Module.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.UserCompetency?>()) {
      return (data != null ? _i41.UserCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.ApprovalWorkflow?>()) {
      return (data != null ? _i42.ApprovalWorkflow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.Document?>()) {
      return (data != null ? _i43.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.DocumentLifecycle?>()) {
      return (data != null ? _i44.DocumentLifecycle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.DocumentVersion?>()) {
      return (data != null ? _i45.DocumentVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.DeadLetterQueue?>()) {
      return (data != null ? _i46.DeadLetterQueue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.DomainEvent?>()) {
      return (data != null ? _i47.DomainEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.OutboxMessage?>()) {
      return (data != null ? _i48.OutboxMessage.fromJson(data) : null) as T;
    }
    if (t ==
        _i1.getType<_i49.KafkaEventProcessorProcessEmployeeCreatedModel?>()) {
      return (data != null
              ? _i49.KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t ==
        _i1
            .getType<
              _i50.KafkaEventProcessorProcessEmployeeTransferredModel?
            >()) {
      return (data != null
              ? _i50.KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _i1.getType<_i51.KafkaEventProcessorProcessSopUpdatedModel?>()) {
      return (data != null
              ? _i51.KafkaEventProcessorProcessSopUpdatedModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i52.Greeting?>()) {
      return (data != null ? _i52.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.FeatureFlag?>()) {
      return (data != null ? _i53.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.RetentionArchive?>()) {
      return (data != null ? _i54.RetentionArchive.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.RetentionPolicy?>()) {
      return (data != null ? _i55.RetentionPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.ScheduledJobLog?>()) {
      return (data != null ? _i56.ScheduledJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.SystemConfiguration?>()) {
      return (data != null ? _i57.SystemConfiguration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.Material?>()) {
      return (data != null ? _i58.Material.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.MaterialProgress?>()) {
      return (data != null ? _i59.MaterialProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.MaterialVersion?>()) {
      return (data != null ? _i60.MaterialVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.MediaAsset?>()) {
      return (data != null ? _i61.MediaAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.MfaEnrollResult?>()) {
      return (data != null ? _i62.MfaEnrollResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.MfaStatusResult?>()) {
      return (data != null ? _i63.MfaStatusResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.MfaVerifiedSession?>()) {
      return (data != null ? _i64.MfaVerifiedSession.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.UserMfa?>()) {
      return (data != null ? _i65.UserMfa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.InAppNotification?>()) {
      return (data != null ? _i66.InAppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.Notification?>()) {
      return (data != null ? _i67.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.Department?>()) {
      return (data != null ? _i68.Department.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.JobRole?>()) {
      return (data != null ? _i69.JobRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.Organization?>()) {
      return (data != null ? _i70.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.Permission?>()) {
      return (data != null ? _i71.Permission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.Role?>()) {
      return (data != null ? _i72.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.Site?>()) {
      return (data != null ? _i73.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.PharmaUser?>()) {
      return (data != null ? _i74.PharmaUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.UserRole?>()) {
      return (data != null ? _i75.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.Capa?>()) {
      return (data != null ? _i76.Capa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.ChangeControl?>()) {
      return (data != null ? _i77.ChangeControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.InspectionReport?>()) {
      return (data != null ? _i78.InspectionReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.QualityEvent?>()) {
      return (data != null ? _i79.QualityEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.AbacPolicy?>()) {
      return (data != null ? _i80.AbacPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.DelegatedAuthority?>()) {
      return (data != null ? _i81.DelegatedAuthority.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i82.ElectronicSignature?>()) {
      return (data != null ? _i82.ElectronicSignature.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i83.SignatureMeaning?>()) {
      return (data != null ? _i83.SignatureMeaning.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.SignatureVerificationResult?>()) {
      return (data != null
              ? _i84.SignatureVerificationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i85.Certificate?>()) {
      return (data != null ? _i85.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.Enrollment?>()) {
      return (data != null ? _i86.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.TrainingAssignment?>()) {
      return (data != null ? _i87.TrainingAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.TrainingExpiration?>()) {
      return (data != null ? _i88.TrainingExpiration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i89.TrainingMatrix?>()) {
      return (data != null ? _i89.TrainingMatrix.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.TrainingRecord?>()) {
      return (data != null ? _i90.TrainingRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.TrainingRecordAnnotation?>()) {
      return (data != null
              ? _i91.TrainingRecordAnnotation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i92.TrainingWaiver?>()) {
      return (data != null ? _i92.TrainingWaiver.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i93.SignatureMeaning>) {
      return (data as List)
              .map((e) => deserialize<_i93.SignatureMeaning>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.TrainingAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i94.TrainingAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i95.TrainingWaiver>) {
      return (data as List)
              .map((e) => deserialize<_i95.TrainingWaiver>(e))
              .toList()
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i96.DepartmentComplianceSummary>) {
      return (data as List)
              .map((e) => deserialize<_i96.DepartmentComplianceSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i97.ReportDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i97.ReportDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.Dashboard>) {
      return (data as List).map((e) => deserialize<_i98.Dashboard>(e)).toList()
          as T;
    }
    if (t == List<_i99.SlaBreach>) {
      return (data as List).map((e) => deserialize<_i99.SlaBreach>(e)).toList()
          as T;
    }
    if (t == List<_i100.PharmaUser>) {
      return (data as List)
              .map((e) => deserialize<_i100.PharmaUser>(e))
              .toList()
          as T;
    }
    if (t == Map<String, List<_i101.Certificate>>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<List<_i101.Certificate>>(v),
            ),
          )
          as T;
    }
    if (t == List<_i101.Certificate>) {
      return (data as List)
              .map((e) => deserialize<_i101.Certificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i102.Capa>) {
      return (data as List).map((e) => deserialize<_i102.Capa>(e)).toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == List<_i103.Question>) {
      return (data as List).map((e) => deserialize<_i103.Question>(e)).toList()
          as T;
    }
    if (t == List<_i104.QuestionBank>) {
      return (data as List)
              .map((e) => deserialize<_i104.QuestionBank>(e))
              .toList()
          as T;
    }
    if (t == List<_i105.AuditTrail>) {
      return (data as List)
              .map((e) => deserialize<_i105.AuditTrail>(e))
              .toList()
          as T;
    }
    if (t == List<_i106.AccessLog>) {
      return (data as List).map((e) => deserialize<_i106.AccessLog>(e)).toList()
          as T;
    }
    if (t == List<_i107.Course>) {
      return (data as List).map((e) => deserialize<_i107.Course>(e)).toList()
          as T;
    }
    if (t == List<_i108.CourseVersion>) {
      return (data as List)
              .map((e) => deserialize<_i108.CourseVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i109.Module>) {
      return (data as List).map((e) => deserialize<_i109.Module>(e)).toList()
          as T;
    }
    if (t == List<_i110.Lesson>) {
      return (data as List).map((e) => deserialize<_i110.Lesson>(e)).toList()
          as T;
    }
    if (t == List<_i111.Document>) {
      return (data as List).map((e) => deserialize<_i111.Document>(e)).toList()
          as T;
    }
    if (t == List<_i112.DocumentVersion>) {
      return (data as List)
              .map((e) => deserialize<_i112.DocumentVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i113.DocumentLifecycle>) {
      return (data as List)
              .map((e) => deserialize<_i113.DocumentLifecycle>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.InspectionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i114.InspectionRecord>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i115.AuditorPageLog>) {
      return (data as List)
              .map((e) => deserialize<_i115.AuditorPageLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i116.InspectionPackage>) {
      return (data as List)
              .map((e) => deserialize<_i116.InspectionPackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i117.MaterialVersion>) {
      return (data as List)
              .map((e) => deserialize<_i117.MaterialVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i118.Material>) {
      return (data as List).map((e) => deserialize<_i118.Material>(e)).toList()
          as T;
    }
    if (t == List<_i119.InAppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i119.InAppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i120.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i120.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i121.Site>) {
      return (data as List).map((e) => deserialize<_i121.Site>(e)).toList()
          as T;
    }
    if (t == List<_i122.Department>) {
      return (data as List)
              .map((e) => deserialize<_i122.Department>(e))
              .toList()
          as T;
    }
    if (t == List<_i123.JobRole>) {
      return (data as List).map((e) => deserialize<_i123.JobRole>(e)).toList()
          as T;
    }
    if (t == List<_i124.QualityEvent>) {
      return (data as List)
              .map((e) => deserialize<_i124.QualityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i125.InspectionReport>) {
      return (data as List)
              .map((e) => deserialize<_i125.InspectionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i126.Enrollment>) {
      return (data as List)
              .map((e) => deserialize<_i126.Enrollment>(e))
              .toList()
          as T;
    }
    if (t == List<_i127.TrainingRecord>) {
      return (data as List)
              .map((e) => deserialize<_i127.TrainingRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i128.ElectronicSignature>) {
      return (data as List)
              .map((e) => deserialize<_i128.ElectronicSignature>(e))
              .toList()
          as T;
    }
    if (t == List<_i129.TrainingRecordAnnotation>) {
      return (data as List)
              .map((e) => deserialize<_i129.TrainingRecordAnnotation>(e))
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
      _i6.BulkImportResult => 'BulkImportResult',
      _i7.ImportLog => 'ImportLog',
      _i8.AnalyticsEvent => 'AnalyticsEvent',
      _i9.AuditReadinessScore => 'AuditReadinessScore',
      _i10.ComplianceMetrics => 'ComplianceMetrics',
      _i11.CourseAnalytics => 'CourseAnalytics',
      _i12.Dashboard => 'Dashboard',
      _i13.DepartmentComplianceSummary => 'DepartmentComplianceSummary',
      _i14.ReportDefinition => 'ReportDefinition',
      _i15.SlaBreach => 'SlaBreach',
      _i16.SlaPolicy => 'SlaPolicy',
      _i17.UserComplianceMetrics => 'UserComplianceMetrics',
      _i18.Assessment => 'Assessment',
      _i19.AssessmentAttempt => 'AssessmentAttempt',
      _i20.AssessmentResult => 'AssessmentResult',
      _i21.Question => 'Question',
      _i22.QuestionBank => 'QuestionBank',
      _i23.AccessLog => 'AccessLog',
      _i24.AuditTrail => 'AuditTrail',
      _i25.AuditorPageLog => 'AuditorPageLog',
      _i26.AuditorSession => 'AuditorSession',
      _i27.ErrorLog => 'ErrorLog',
      _i28.InspectionPackage => 'InspectionPackage',
      _i29.InspectionRecord => 'InspectionRecord',
      _i30.ReportExport => 'ReportExport',
      _i31.UserSession => 'UserSession',
      _i32.OidcAccount => 'OidcAccount',
      _i33.OidcClientConfig => 'OidcClientConfig',
      _i34.Competency => 'Competency',
      _i35.Course => 'Course',
      _i36.CourseCompetency => 'CourseCompetency',
      _i37.CourseReview => 'CourseReview',
      _i38.CourseVersion => 'CourseVersion',
      _i39.Lesson => 'Lesson',
      _i40.Module => 'Module',
      _i41.UserCompetency => 'UserCompetency',
      _i42.ApprovalWorkflow => 'ApprovalWorkflow',
      _i43.Document => 'Document',
      _i44.DocumentLifecycle => 'DocumentLifecycle',
      _i45.DocumentVersion => 'DocumentVersion',
      _i46.DeadLetterQueue => 'DeadLetterQueue',
      _i47.DomainEvent => 'DomainEvent',
      _i48.OutboxMessage => 'OutboxMessage',
      _i49.KafkaEventProcessorProcessEmployeeCreatedModel =>
        'KafkaEventProcessorProcessEmployeeCreatedModel',
      _i50.KafkaEventProcessorProcessEmployeeTransferredModel =>
        'KafkaEventProcessorProcessEmployeeTransferredModel',
      _i51.KafkaEventProcessorProcessSopUpdatedModel =>
        'KafkaEventProcessorProcessSopUpdatedModel',
      _i52.Greeting => 'Greeting',
      _i53.FeatureFlag => 'FeatureFlag',
      _i54.RetentionArchive => 'RetentionArchive',
      _i55.RetentionPolicy => 'RetentionPolicy',
      _i56.ScheduledJobLog => 'ScheduledJobLog',
      _i57.SystemConfiguration => 'SystemConfiguration',
      _i58.Material => 'Material',
      _i59.MaterialProgress => 'MaterialProgress',
      _i60.MaterialVersion => 'MaterialVersion',
      _i61.MediaAsset => 'MediaAsset',
      _i62.MfaEnrollResult => 'MfaEnrollResult',
      _i63.MfaStatusResult => 'MfaStatusResult',
      _i64.MfaVerifiedSession => 'MfaVerifiedSession',
      _i65.UserMfa => 'UserMfa',
      _i66.InAppNotification => 'InAppNotification',
      _i67.Notification => 'Notification',
      _i68.Department => 'Department',
      _i69.JobRole => 'JobRole',
      _i70.Organization => 'Organization',
      _i71.Permission => 'Permission',
      _i72.Role => 'Role',
      _i73.Site => 'Site',
      _i74.PharmaUser => 'PharmaUser',
      _i75.UserRole => 'UserRole',
      _i76.Capa => 'Capa',
      _i77.ChangeControl => 'ChangeControl',
      _i78.InspectionReport => 'InspectionReport',
      _i79.QualityEvent => 'QualityEvent',
      _i80.AbacPolicy => 'AbacPolicy',
      _i81.DelegatedAuthority => 'DelegatedAuthority',
      _i82.ElectronicSignature => 'ElectronicSignature',
      _i83.SignatureMeaning => 'SignatureMeaning',
      _i84.SignatureVerificationResult => 'SignatureVerificationResult',
      _i85.Certificate => 'Certificate',
      _i86.Enrollment => 'Enrollment',
      _i87.TrainingAssignment => 'TrainingAssignment',
      _i88.TrainingExpiration => 'TrainingExpiration',
      _i89.TrainingMatrix => 'TrainingMatrix',
      _i90.TrainingRecord => 'TrainingRecord',
      _i91.TrainingRecordAnnotation => 'TrainingRecordAnnotation',
      _i92.TrainingWaiver => 'TrainingWaiver',
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
      case _i6.BulkImportResult():
        return 'BulkImportResult';
      case _i7.ImportLog():
        return 'ImportLog';
      case _i8.AnalyticsEvent():
        return 'AnalyticsEvent';
      case _i9.AuditReadinessScore():
        return 'AuditReadinessScore';
      case _i10.ComplianceMetrics():
        return 'ComplianceMetrics';
      case _i11.CourseAnalytics():
        return 'CourseAnalytics';
      case _i12.Dashboard():
        return 'Dashboard';
      case _i13.DepartmentComplianceSummary():
        return 'DepartmentComplianceSummary';
      case _i14.ReportDefinition():
        return 'ReportDefinition';
      case _i15.SlaBreach():
        return 'SlaBreach';
      case _i16.SlaPolicy():
        return 'SlaPolicy';
      case _i17.UserComplianceMetrics():
        return 'UserComplianceMetrics';
      case _i18.Assessment():
        return 'Assessment';
      case _i19.AssessmentAttempt():
        return 'AssessmentAttempt';
      case _i20.AssessmentResult():
        return 'AssessmentResult';
      case _i21.Question():
        return 'Question';
      case _i22.QuestionBank():
        return 'QuestionBank';
      case _i23.AccessLog():
        return 'AccessLog';
      case _i24.AuditTrail():
        return 'AuditTrail';
      case _i25.AuditorPageLog():
        return 'AuditorPageLog';
      case _i26.AuditorSession():
        return 'AuditorSession';
      case _i27.ErrorLog():
        return 'ErrorLog';
      case _i28.InspectionPackage():
        return 'InspectionPackage';
      case _i29.InspectionRecord():
        return 'InspectionRecord';
      case _i30.ReportExport():
        return 'ReportExport';
      case _i31.UserSession():
        return 'UserSession';
      case _i32.OidcAccount():
        return 'OidcAccount';
      case _i33.OidcClientConfig():
        return 'OidcClientConfig';
      case _i34.Competency():
        return 'Competency';
      case _i35.Course():
        return 'Course';
      case _i36.CourseCompetency():
        return 'CourseCompetency';
      case _i37.CourseReview():
        return 'CourseReview';
      case _i38.CourseVersion():
        return 'CourseVersion';
      case _i39.Lesson():
        return 'Lesson';
      case _i40.Module():
        return 'Module';
      case _i41.UserCompetency():
        return 'UserCompetency';
      case _i42.ApprovalWorkflow():
        return 'ApprovalWorkflow';
      case _i43.Document():
        return 'Document';
      case _i44.DocumentLifecycle():
        return 'DocumentLifecycle';
      case _i45.DocumentVersion():
        return 'DocumentVersion';
      case _i46.DeadLetterQueue():
        return 'DeadLetterQueue';
      case _i47.DomainEvent():
        return 'DomainEvent';
      case _i48.OutboxMessage():
        return 'OutboxMessage';
      case _i49.KafkaEventProcessorProcessEmployeeCreatedModel():
        return 'KafkaEventProcessorProcessEmployeeCreatedModel';
      case _i50.KafkaEventProcessorProcessEmployeeTransferredModel():
        return 'KafkaEventProcessorProcessEmployeeTransferredModel';
      case _i51.KafkaEventProcessorProcessSopUpdatedModel():
        return 'KafkaEventProcessorProcessSopUpdatedModel';
      case _i52.Greeting():
        return 'Greeting';
      case _i53.FeatureFlag():
        return 'FeatureFlag';
      case _i54.RetentionArchive():
        return 'RetentionArchive';
      case _i55.RetentionPolicy():
        return 'RetentionPolicy';
      case _i56.ScheduledJobLog():
        return 'ScheduledJobLog';
      case _i57.SystemConfiguration():
        return 'SystemConfiguration';
      case _i58.Material():
        return 'Material';
      case _i59.MaterialProgress():
        return 'MaterialProgress';
      case _i60.MaterialVersion():
        return 'MaterialVersion';
      case _i61.MediaAsset():
        return 'MediaAsset';
      case _i62.MfaEnrollResult():
        return 'MfaEnrollResult';
      case _i63.MfaStatusResult():
        return 'MfaStatusResult';
      case _i64.MfaVerifiedSession():
        return 'MfaVerifiedSession';
      case _i65.UserMfa():
        return 'UserMfa';
      case _i66.InAppNotification():
        return 'InAppNotification';
      case _i67.Notification():
        return 'Notification';
      case _i68.Department():
        return 'Department';
      case _i69.JobRole():
        return 'JobRole';
      case _i70.Organization():
        return 'Organization';
      case _i71.Permission():
        return 'Permission';
      case _i72.Role():
        return 'Role';
      case _i73.Site():
        return 'Site';
      case _i74.PharmaUser():
        return 'PharmaUser';
      case _i75.UserRole():
        return 'UserRole';
      case _i76.Capa():
        return 'Capa';
      case _i77.ChangeControl():
        return 'ChangeControl';
      case _i78.InspectionReport():
        return 'InspectionReport';
      case _i79.QualityEvent():
        return 'QualityEvent';
      case _i80.AbacPolicy():
        return 'AbacPolicy';
      case _i81.DelegatedAuthority():
        return 'DelegatedAuthority';
      case _i82.ElectronicSignature():
        return 'ElectronicSignature';
      case _i83.SignatureMeaning():
        return 'SignatureMeaning';
      case _i84.SignatureVerificationResult():
        return 'SignatureVerificationResult';
      case _i85.Certificate():
        return 'Certificate';
      case _i86.Enrollment():
        return 'Enrollment';
      case _i87.TrainingAssignment():
        return 'TrainingAssignment';
      case _i88.TrainingExpiration():
        return 'TrainingExpiration';
      case _i89.TrainingMatrix():
        return 'TrainingMatrix';
      case _i90.TrainingRecord():
        return 'TrainingRecord';
      case _i91.TrainingRecordAnnotation():
        return 'TrainingRecordAnnotation';
      case _i92.TrainingWaiver():
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
    if (dataClassName == 'BulkImportResult') {
      return deserialize<_i6.BulkImportResult>(data['data']);
    }
    if (dataClassName == 'ImportLog') {
      return deserialize<_i7.ImportLog>(data['data']);
    }
    if (dataClassName == 'AnalyticsEvent') {
      return deserialize<_i8.AnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'AuditReadinessScore') {
      return deserialize<_i9.AuditReadinessScore>(data['data']);
    }
    if (dataClassName == 'ComplianceMetrics') {
      return deserialize<_i10.ComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'CourseAnalytics') {
      return deserialize<_i11.CourseAnalytics>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_i12.Dashboard>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSummary') {
      return deserialize<_i13.DepartmentComplianceSummary>(data['data']);
    }
    if (dataClassName == 'ReportDefinition') {
      return deserialize<_i14.ReportDefinition>(data['data']);
    }
    if (dataClassName == 'SlaBreach') {
      return deserialize<_i15.SlaBreach>(data['data']);
    }
    if (dataClassName == 'SlaPolicy') {
      return deserialize<_i16.SlaPolicy>(data['data']);
    }
    if (dataClassName == 'UserComplianceMetrics') {
      return deserialize<_i17.UserComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'Assessment') {
      return deserialize<_i18.Assessment>(data['data']);
    }
    if (dataClassName == 'AssessmentAttempt') {
      return deserialize<_i19.AssessmentAttempt>(data['data']);
    }
    if (dataClassName == 'AssessmentResult') {
      return deserialize<_i20.AssessmentResult>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i21.Question>(data['data']);
    }
    if (dataClassName == 'QuestionBank') {
      return deserialize<_i22.QuestionBank>(data['data']);
    }
    if (dataClassName == 'AccessLog') {
      return deserialize<_i23.AccessLog>(data['data']);
    }
    if (dataClassName == 'AuditTrail') {
      return deserialize<_i24.AuditTrail>(data['data']);
    }
    if (dataClassName == 'AuditorPageLog') {
      return deserialize<_i25.AuditorPageLog>(data['data']);
    }
    if (dataClassName == 'AuditorSession') {
      return deserialize<_i26.AuditorSession>(data['data']);
    }
    if (dataClassName == 'ErrorLog') {
      return deserialize<_i27.ErrorLog>(data['data']);
    }
    if (dataClassName == 'InspectionPackage') {
      return deserialize<_i28.InspectionPackage>(data['data']);
    }
    if (dataClassName == 'InspectionRecord') {
      return deserialize<_i29.InspectionRecord>(data['data']);
    }
    if (dataClassName == 'ReportExport') {
      return deserialize<_i30.ReportExport>(data['data']);
    }
    if (dataClassName == 'UserSession') {
      return deserialize<_i31.UserSession>(data['data']);
    }
    if (dataClassName == 'OidcAccount') {
      return deserialize<_i32.OidcAccount>(data['data']);
    }
    if (dataClassName == 'OidcClientConfig') {
      return deserialize<_i33.OidcClientConfig>(data['data']);
    }
    if (dataClassName == 'Competency') {
      return deserialize<_i34.Competency>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i35.Course>(data['data']);
    }
    if (dataClassName == 'CourseCompetency') {
      return deserialize<_i36.CourseCompetency>(data['data']);
    }
    if (dataClassName == 'CourseReview') {
      return deserialize<_i37.CourseReview>(data['data']);
    }
    if (dataClassName == 'CourseVersion') {
      return deserialize<_i38.CourseVersion>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i39.Lesson>(data['data']);
    }
    if (dataClassName == 'Module') {
      return deserialize<_i40.Module>(data['data']);
    }
    if (dataClassName == 'UserCompetency') {
      return deserialize<_i41.UserCompetency>(data['data']);
    }
    if (dataClassName == 'ApprovalWorkflow') {
      return deserialize<_i42.ApprovalWorkflow>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i43.Document>(data['data']);
    }
    if (dataClassName == 'DocumentLifecycle') {
      return deserialize<_i44.DocumentLifecycle>(data['data']);
    }
    if (dataClassName == 'DocumentVersion') {
      return deserialize<_i45.DocumentVersion>(data['data']);
    }
    if (dataClassName == 'DeadLetterQueue') {
      return deserialize<_i46.DeadLetterQueue>(data['data']);
    }
    if (dataClassName == 'DomainEvent') {
      return deserialize<_i47.DomainEvent>(data['data']);
    }
    if (dataClassName == 'OutboxMessage') {
      return deserialize<_i48.OutboxMessage>(data['data']);
    }
    if (dataClassName == 'KafkaEventProcessorProcessEmployeeCreatedModel') {
      return deserialize<_i49.KafkaEventProcessorProcessEmployeeCreatedModel>(
        data['data'],
      );
    }
    if (dataClassName == 'KafkaEventProcessorProcessEmployeeTransferredModel') {
      return deserialize<
        _i50.KafkaEventProcessorProcessEmployeeTransferredModel
      >(data['data']);
    }
    if (dataClassName == 'KafkaEventProcessorProcessSopUpdatedModel') {
      return deserialize<_i51.KafkaEventProcessorProcessSopUpdatedModel>(
        data['data'],
      );
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i52.Greeting>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i53.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'RetentionArchive') {
      return deserialize<_i54.RetentionArchive>(data['data']);
    }
    if (dataClassName == 'RetentionPolicy') {
      return deserialize<_i55.RetentionPolicy>(data['data']);
    }
    if (dataClassName == 'ScheduledJobLog') {
      return deserialize<_i56.ScheduledJobLog>(data['data']);
    }
    if (dataClassName == 'SystemConfiguration') {
      return deserialize<_i57.SystemConfiguration>(data['data']);
    }
    if (dataClassName == 'Material') {
      return deserialize<_i58.Material>(data['data']);
    }
    if (dataClassName == 'MaterialProgress') {
      return deserialize<_i59.MaterialProgress>(data['data']);
    }
    if (dataClassName == 'MaterialVersion') {
      return deserialize<_i60.MaterialVersion>(data['data']);
    }
    if (dataClassName == 'MediaAsset') {
      return deserialize<_i61.MediaAsset>(data['data']);
    }
    if (dataClassName == 'MfaEnrollResult') {
      return deserialize<_i62.MfaEnrollResult>(data['data']);
    }
    if (dataClassName == 'MfaStatusResult') {
      return deserialize<_i63.MfaStatusResult>(data['data']);
    }
    if (dataClassName == 'MfaVerifiedSession') {
      return deserialize<_i64.MfaVerifiedSession>(data['data']);
    }
    if (dataClassName == 'UserMfa') {
      return deserialize<_i65.UserMfa>(data['data']);
    }
    if (dataClassName == 'InAppNotification') {
      return deserialize<_i66.InAppNotification>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i67.Notification>(data['data']);
    }
    if (dataClassName == 'Department') {
      return deserialize<_i68.Department>(data['data']);
    }
    if (dataClassName == 'JobRole') {
      return deserialize<_i69.JobRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i70.Organization>(data['data']);
    }
    if (dataClassName == 'Permission') {
      return deserialize<_i71.Permission>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i72.Role>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i73.Site>(data['data']);
    }
    if (dataClassName == 'PharmaUser') {
      return deserialize<_i74.PharmaUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i75.UserRole>(data['data']);
    }
    if (dataClassName == 'Capa') {
      return deserialize<_i76.Capa>(data['data']);
    }
    if (dataClassName == 'ChangeControl') {
      return deserialize<_i77.ChangeControl>(data['data']);
    }
    if (dataClassName == 'InspectionReport') {
      return deserialize<_i78.InspectionReport>(data['data']);
    }
    if (dataClassName == 'QualityEvent') {
      return deserialize<_i79.QualityEvent>(data['data']);
    }
    if (dataClassName == 'AbacPolicy') {
      return deserialize<_i80.AbacPolicy>(data['data']);
    }
    if (dataClassName == 'DelegatedAuthority') {
      return deserialize<_i81.DelegatedAuthority>(data['data']);
    }
    if (dataClassName == 'ElectronicSignature') {
      return deserialize<_i82.ElectronicSignature>(data['data']);
    }
    if (dataClassName == 'SignatureMeaning') {
      return deserialize<_i83.SignatureMeaning>(data['data']);
    }
    if (dataClassName == 'SignatureVerificationResult') {
      return deserialize<_i84.SignatureVerificationResult>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i85.Certificate>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i86.Enrollment>(data['data']);
    }
    if (dataClassName == 'TrainingAssignment') {
      return deserialize<_i87.TrainingAssignment>(data['data']);
    }
    if (dataClassName == 'TrainingExpiration') {
      return deserialize<_i88.TrainingExpiration>(data['data']);
    }
    if (dataClassName == 'TrainingMatrix') {
      return deserialize<_i89.TrainingMatrix>(data['data']);
    }
    if (dataClassName == 'TrainingRecord') {
      return deserialize<_i90.TrainingRecord>(data['data']);
    }
    if (dataClassName == 'TrainingRecordAnnotation') {
      return deserialize<_i91.TrainingRecordAnnotation>(data['data']);
    }
    if (dataClassName == 'TrainingWaiver') {
      return deserialize<_i92.TrainingWaiver>(data['data']);
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
      case _i7.ImportLog:
        return _i7.ImportLog.t;
      case _i12.Dashboard:
        return _i12.Dashboard.t;
      case _i14.ReportDefinition:
        return _i14.ReportDefinition.t;
      case _i15.SlaBreach:
        return _i15.SlaBreach.t;
      case _i16.SlaPolicy:
        return _i16.SlaPolicy.t;
      case _i18.Assessment:
        return _i18.Assessment.t;
      case _i19.AssessmentAttempt:
        return _i19.AssessmentAttempt.t;
      case _i20.AssessmentResult:
        return _i20.AssessmentResult.t;
      case _i21.Question:
        return _i21.Question.t;
      case _i22.QuestionBank:
        return _i22.QuestionBank.t;
      case _i23.AccessLog:
        return _i23.AccessLog.t;
      case _i24.AuditTrail:
        return _i24.AuditTrail.t;
      case _i25.AuditorPageLog:
        return _i25.AuditorPageLog.t;
      case _i26.AuditorSession:
        return _i26.AuditorSession.t;
      case _i27.ErrorLog:
        return _i27.ErrorLog.t;
      case _i28.InspectionPackage:
        return _i28.InspectionPackage.t;
      case _i29.InspectionRecord:
        return _i29.InspectionRecord.t;
      case _i30.ReportExport:
        return _i30.ReportExport.t;
      case _i31.UserSession:
        return _i31.UserSession.t;
      case _i32.OidcAccount:
        return _i32.OidcAccount.t;
      case _i34.Competency:
        return _i34.Competency.t;
      case _i35.Course:
        return _i35.Course.t;
      case _i36.CourseCompetency:
        return _i36.CourseCompetency.t;
      case _i37.CourseReview:
        return _i37.CourseReview.t;
      case _i38.CourseVersion:
        return _i38.CourseVersion.t;
      case _i39.Lesson:
        return _i39.Lesson.t;
      case _i40.Module:
        return _i40.Module.t;
      case _i41.UserCompetency:
        return _i41.UserCompetency.t;
      case _i42.ApprovalWorkflow:
        return _i42.ApprovalWorkflow.t;
      case _i43.Document:
        return _i43.Document.t;
      case _i44.DocumentLifecycle:
        return _i44.DocumentLifecycle.t;
      case _i45.DocumentVersion:
        return _i45.DocumentVersion.t;
      case _i46.DeadLetterQueue:
        return _i46.DeadLetterQueue.t;
      case _i47.DomainEvent:
        return _i47.DomainEvent.t;
      case _i48.OutboxMessage:
        return _i48.OutboxMessage.t;
      case _i53.FeatureFlag:
        return _i53.FeatureFlag.t;
      case _i54.RetentionArchive:
        return _i54.RetentionArchive.t;
      case _i55.RetentionPolicy:
        return _i55.RetentionPolicy.t;
      case _i56.ScheduledJobLog:
        return _i56.ScheduledJobLog.t;
      case _i57.SystemConfiguration:
        return _i57.SystemConfiguration.t;
      case _i58.Material:
        return _i58.Material.t;
      case _i59.MaterialProgress:
        return _i59.MaterialProgress.t;
      case _i60.MaterialVersion:
        return _i60.MaterialVersion.t;
      case _i61.MediaAsset:
        return _i61.MediaAsset.t;
      case _i64.MfaVerifiedSession:
        return _i64.MfaVerifiedSession.t;
      case _i65.UserMfa:
        return _i65.UserMfa.t;
      case _i67.Notification:
        return _i67.Notification.t;
      case _i68.Department:
        return _i68.Department.t;
      case _i69.JobRole:
        return _i69.JobRole.t;
      case _i70.Organization:
        return _i70.Organization.t;
      case _i71.Permission:
        return _i71.Permission.t;
      case _i72.Role:
        return _i72.Role.t;
      case _i73.Site:
        return _i73.Site.t;
      case _i74.PharmaUser:
        return _i74.PharmaUser.t;
      case _i75.UserRole:
        return _i75.UserRole.t;
      case _i76.Capa:
        return _i76.Capa.t;
      case _i77.ChangeControl:
        return _i77.ChangeControl.t;
      case _i78.InspectionReport:
        return _i78.InspectionReport.t;
      case _i79.QualityEvent:
        return _i79.QualityEvent.t;
      case _i80.AbacPolicy:
        return _i80.AbacPolicy.t;
      case _i81.DelegatedAuthority:
        return _i81.DelegatedAuthority.t;
      case _i82.ElectronicSignature:
        return _i82.ElectronicSignature.t;
      case _i83.SignatureMeaning:
        return _i83.SignatureMeaning.t;
      case _i85.Certificate:
        return _i85.Certificate.t;
      case _i86.Enrollment:
        return _i86.Enrollment.t;
      case _i87.TrainingAssignment:
        return _i87.TrainingAssignment.t;
      case _i88.TrainingExpiration:
        return _i88.TrainingExpiration.t;
      case _i89.TrainingMatrix:
        return _i89.TrainingMatrix.t;
      case _i90.TrainingRecord:
        return _i90.TrainingRecord.t;
      case _i91.TrainingRecordAnnotation:
        return _i91.TrainingRecordAnnotation.t;
      case _i92.TrainingWaiver:
        return _i92.TrainingWaiver.t;
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
