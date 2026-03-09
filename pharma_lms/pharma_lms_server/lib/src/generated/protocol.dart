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
import 'admin/bulk_import_result.dart' as _i5;
import 'admin/import_log.dart' as _i6;
import 'analytics/audit_readiness_score.dart' as _i7;
import 'analytics/compliance_metrics.dart' as _i8;
import 'analytics/course_analytics.dart' as _i9;
import 'analytics/dashboard.dart' as _i10;
import 'analytics/department_compliance_summary.dart' as _i11;
import 'analytics/report_definition.dart' as _i12;
import 'analytics/sla_breach.dart' as _i13;
import 'analytics/sla_policy.dart' as _i14;
import 'analytics/user_compliance_metrics.dart' as _i15;
import 'assessment/assessment.dart' as _i16;
import 'assessment/assessment_attempt.dart' as _i17;
import 'assessment/assessment_result.dart' as _i18;
import 'assessment/question.dart' as _i19;
import 'assessment/question_bank.dart' as _i20;
import 'audit/access_log.dart' as _i21;
import 'audit/audit_trail.dart' as _i22;
import 'audit/auditor_page_log.dart' as _i23;
import 'audit/auditor_session.dart' as _i24;
import 'audit/error_log.dart' as _i25;
import 'audit/inspection_package.dart' as _i26;
import 'audit/inspection_record.dart' as _i27;
import 'audit/report_export.dart' as _i28;
import 'audit/user_session.dart' as _i29;
import 'course/competency.dart' as _i30;
import 'course/course.dart' as _i31;
import 'course/course_competency.dart' as _i32;
import 'course/course_review.dart' as _i33;
import 'course/course_version.dart' as _i34;
import 'course/lesson.dart' as _i35;
import 'course/module.dart' as _i36;
import 'course/user_competency.dart' as _i37;
import 'document/approval_workflow.dart' as _i38;
import 'document/document.dart' as _i39;
import 'document/document_lifecycle.dart' as _i40;
import 'document/document_version.dart' as _i41;
import 'events/dead_letter_queue.dart' as _i42;
import 'events/domain_event.dart' as _i43;
import 'events/outbox_message.dart' as _i44;
import 'future_calls_generated_models/kafka_event_processor_process_employee_created_model.dart'
    as _i45;
import 'future_calls_generated_models/kafka_event_processor_process_employee_transferred_model.dart'
    as _i46;
import 'future_calls_generated_models/kafka_event_processor_process_sop_updated_model.dart'
    as _i47;
import 'greetings/greeting.dart' as _i48;
import 'infrastructure/feature_flag.dart' as _i49;
import 'infrastructure/scheduled_job_log.dart' as _i50;
import 'infrastructure/system_configuration.dart' as _i51;
import 'material/material.dart' as _i52;
import 'material/material_progress.dart' as _i53;
import 'material/material_version.dart' as _i54;
import 'material/media_asset.dart' as _i55;
import 'notifications/in_app_notification.dart' as _i56;
import 'notifications/notification.dart' as _i57;
import 'organization/department.dart' as _i58;
import 'organization/job_role.dart' as _i59;
import 'organization/organization.dart' as _i60;
import 'organization/permission.dart' as _i61;
import 'organization/role.dart' as _i62;
import 'organization/site.dart' as _i63;
import 'organization/user.dart' as _i64;
import 'organization/user_role.dart' as _i65;
import 'quality/capa.dart' as _i66;
import 'quality/change_control.dart' as _i67;
import 'quality/inspection_report.dart' as _i68;
import 'quality/quality_event.dart' as _i69;
import 'security/abac_policy.dart' as _i70;
import 'security/delegated_authority.dart' as _i71;
import 'shared/electronic_signature.dart' as _i72;
import 'shared/signature_meaning.dart' as _i73;
import 'shared/signature_verification_result.dart' as _i74;
import 'training/certificate.dart' as _i75;
import 'training/enrollment.dart' as _i76;
import 'training/training_assignment.dart' as _i77;
import 'training/training_expiration.dart' as _i78;
import 'training/training_matrix.dart' as _i79;
import 'training/training_record.dart' as _i80;
import 'training/training_record_annotation.dart' as _i81;
import 'training/training_waiver.dart' as _i82;
import 'package:pharma_lms_server/src/generated/shared/signature_meaning.dart'
    as _i83;
import 'package:pharma_lms_server/src/generated/training/training_assignment.dart'
    as _i84;
import 'package:pharma_lms_server/src/generated/training/training_waiver.dart'
    as _i85;
import 'package:pharma_lms_server/src/generated/analytics/department_compliance_summary.dart'
    as _i86;
import 'package:pharma_lms_server/src/generated/analytics/report_definition.dart'
    as _i87;
import 'package:pharma_lms_server/src/generated/analytics/dashboard.dart'
    as _i88;
import 'package:pharma_lms_server/src/generated/analytics/sla_breach.dart'
    as _i89;
import 'package:pharma_lms_server/src/generated/organization/user.dart' as _i90;
import 'package:pharma_lms_server/src/generated/training/certificate.dart'
    as _i91;
import 'package:pharma_lms_server/src/generated/quality/capa.dart' as _i92;
import 'package:pharma_lms_server/src/generated/assessment/question.dart'
    as _i93;
import 'package:pharma_lms_server/src/generated/assessment/question_bank.dart'
    as _i94;
import 'package:pharma_lms_server/src/generated/audit/audit_trail.dart' as _i95;
import 'package:pharma_lms_server/src/generated/audit/access_log.dart' as _i96;
import 'package:pharma_lms_server/src/generated/course/course.dart' as _i97;
import 'package:pharma_lms_server/src/generated/course/course_version.dart'
    as _i98;
import 'package:pharma_lms_server/src/generated/course/module.dart' as _i99;
import 'package:pharma_lms_server/src/generated/course/lesson.dart' as _i100;
import 'package:pharma_lms_server/src/generated/document/document.dart'
    as _i101;
import 'package:pharma_lms_server/src/generated/document/document_version.dart'
    as _i102;
import 'package:pharma_lms_server/src/generated/document/document_lifecycle.dart'
    as _i103;
import 'package:pharma_lms_server/src/generated/audit/inspection_record.dart'
    as _i104;
import 'package:pharma_lms_server/src/generated/audit/inspection_package.dart'
    as _i105;
import 'package:pharma_lms_server/src/generated/material/material_version.dart'
    as _i106;
import 'package:pharma_lms_server/src/generated/material/material.dart'
    as _i107;
import 'package:pharma_lms_server/src/generated/notifications/in_app_notification.dart'
    as _i108;
import 'package:pharma_lms_server/src/generated/organization/organization.dart'
    as _i109;
import 'package:pharma_lms_server/src/generated/organization/site.dart'
    as _i110;
import 'package:pharma_lms_server/src/generated/organization/department.dart'
    as _i111;
import 'package:pharma_lms_server/src/generated/organization/job_role.dart'
    as _i112;
import 'package:pharma_lms_server/src/generated/quality/quality_event.dart'
    as _i113;
import 'package:pharma_lms_server/src/generated/quality/inspection_report.dart'
    as _i114;
import 'package:pharma_lms_server/src/generated/training/enrollment.dart'
    as _i115;
import 'package:pharma_lms_server/src/generated/training/training_record.dart'
    as _i116;
import 'package:pharma_lms_server/src/generated/shared/electronic_signature.dart'
    as _i117;
import 'package:pharma_lms_server/src/generated/training/training_record_annotation.dart'
    as _i118;
export 'admin/bulk_import_result.dart';
export 'admin/import_log.dart';
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
export 'infrastructure/scheduled_job_log.dart';
export 'infrastructure/system_configuration.dart';
export 'material/material.dart';
export 'material/material_progress.dart';
export 'material/material_version.dart';
export 'material/media_asset.dart';
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

    if (t == _i5.BulkImportResult) {
      return _i5.BulkImportResult.fromJson(data) as T;
    }
    if (t == _i6.ImportLog) {
      return _i6.ImportLog.fromJson(data) as T;
    }
    if (t == _i7.AuditReadinessScore) {
      return _i7.AuditReadinessScore.fromJson(data) as T;
    }
    if (t == _i8.ComplianceMetrics) {
      return _i8.ComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i9.CourseAnalytics) {
      return _i9.CourseAnalytics.fromJson(data) as T;
    }
    if (t == _i10.Dashboard) {
      return _i10.Dashboard.fromJson(data) as T;
    }
    if (t == _i11.DepartmentComplianceSummary) {
      return _i11.DepartmentComplianceSummary.fromJson(data) as T;
    }
    if (t == _i12.ReportDefinition) {
      return _i12.ReportDefinition.fromJson(data) as T;
    }
    if (t == _i13.SlaBreach) {
      return _i13.SlaBreach.fromJson(data) as T;
    }
    if (t == _i14.SlaPolicy) {
      return _i14.SlaPolicy.fromJson(data) as T;
    }
    if (t == _i15.UserComplianceMetrics) {
      return _i15.UserComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i16.Assessment) {
      return _i16.Assessment.fromJson(data) as T;
    }
    if (t == _i17.AssessmentAttempt) {
      return _i17.AssessmentAttempt.fromJson(data) as T;
    }
    if (t == _i18.AssessmentResult) {
      return _i18.AssessmentResult.fromJson(data) as T;
    }
    if (t == _i19.Question) {
      return _i19.Question.fromJson(data) as T;
    }
    if (t == _i20.QuestionBank) {
      return _i20.QuestionBank.fromJson(data) as T;
    }
    if (t == _i21.AccessLog) {
      return _i21.AccessLog.fromJson(data) as T;
    }
    if (t == _i22.AuditTrail) {
      return _i22.AuditTrail.fromJson(data) as T;
    }
    if (t == _i23.AuditorPageLog) {
      return _i23.AuditorPageLog.fromJson(data) as T;
    }
    if (t == _i24.AuditorSession) {
      return _i24.AuditorSession.fromJson(data) as T;
    }
    if (t == _i25.ErrorLog) {
      return _i25.ErrorLog.fromJson(data) as T;
    }
    if (t == _i26.InspectionPackage) {
      return _i26.InspectionPackage.fromJson(data) as T;
    }
    if (t == _i27.InspectionRecord) {
      return _i27.InspectionRecord.fromJson(data) as T;
    }
    if (t == _i28.ReportExport) {
      return _i28.ReportExport.fromJson(data) as T;
    }
    if (t == _i29.UserSession) {
      return _i29.UserSession.fromJson(data) as T;
    }
    if (t == _i30.Competency) {
      return _i30.Competency.fromJson(data) as T;
    }
    if (t == _i31.Course) {
      return _i31.Course.fromJson(data) as T;
    }
    if (t == _i32.CourseCompetency) {
      return _i32.CourseCompetency.fromJson(data) as T;
    }
    if (t == _i33.CourseReview) {
      return _i33.CourseReview.fromJson(data) as T;
    }
    if (t == _i34.CourseVersion) {
      return _i34.CourseVersion.fromJson(data) as T;
    }
    if (t == _i35.Lesson) {
      return _i35.Lesson.fromJson(data) as T;
    }
    if (t == _i36.Module) {
      return _i36.Module.fromJson(data) as T;
    }
    if (t == _i37.UserCompetency) {
      return _i37.UserCompetency.fromJson(data) as T;
    }
    if (t == _i38.ApprovalWorkflow) {
      return _i38.ApprovalWorkflow.fromJson(data) as T;
    }
    if (t == _i39.Document) {
      return _i39.Document.fromJson(data) as T;
    }
    if (t == _i40.DocumentLifecycle) {
      return _i40.DocumentLifecycle.fromJson(data) as T;
    }
    if (t == _i41.DocumentVersion) {
      return _i41.DocumentVersion.fromJson(data) as T;
    }
    if (t == _i42.DeadLetterQueue) {
      return _i42.DeadLetterQueue.fromJson(data) as T;
    }
    if (t == _i43.DomainEvent) {
      return _i43.DomainEvent.fromJson(data) as T;
    }
    if (t == _i44.OutboxMessage) {
      return _i44.OutboxMessage.fromJson(data) as T;
    }
    if (t == _i45.KafkaEventProcessorProcessEmployeeCreatedModel) {
      return _i45.KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(data)
          as T;
    }
    if (t == _i46.KafkaEventProcessorProcessEmployeeTransferredModel) {
      return _i46.KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
            data,
          )
          as T;
    }
    if (t == _i47.KafkaEventProcessorProcessSopUpdatedModel) {
      return _i47.KafkaEventProcessorProcessSopUpdatedModel.fromJson(data) as T;
    }
    if (t == _i48.Greeting) {
      return _i48.Greeting.fromJson(data) as T;
    }
    if (t == _i49.FeatureFlag) {
      return _i49.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i50.ScheduledJobLog) {
      return _i50.ScheduledJobLog.fromJson(data) as T;
    }
    if (t == _i51.SystemConfiguration) {
      return _i51.SystemConfiguration.fromJson(data) as T;
    }
    if (t == _i52.Material) {
      return _i52.Material.fromJson(data) as T;
    }
    if (t == _i53.MaterialProgress) {
      return _i53.MaterialProgress.fromJson(data) as T;
    }
    if (t == _i54.MaterialVersion) {
      return _i54.MaterialVersion.fromJson(data) as T;
    }
    if (t == _i55.MediaAsset) {
      return _i55.MediaAsset.fromJson(data) as T;
    }
    if (t == _i56.InAppNotification) {
      return _i56.InAppNotification.fromJson(data) as T;
    }
    if (t == _i57.Notification) {
      return _i57.Notification.fromJson(data) as T;
    }
    if (t == _i58.Department) {
      return _i58.Department.fromJson(data) as T;
    }
    if (t == _i59.JobRole) {
      return _i59.JobRole.fromJson(data) as T;
    }
    if (t == _i60.Organization) {
      return _i60.Organization.fromJson(data) as T;
    }
    if (t == _i61.Permission) {
      return _i61.Permission.fromJson(data) as T;
    }
    if (t == _i62.Role) {
      return _i62.Role.fromJson(data) as T;
    }
    if (t == _i63.Site) {
      return _i63.Site.fromJson(data) as T;
    }
    if (t == _i64.PharmaUser) {
      return _i64.PharmaUser.fromJson(data) as T;
    }
    if (t == _i65.UserRole) {
      return _i65.UserRole.fromJson(data) as T;
    }
    if (t == _i66.Capa) {
      return _i66.Capa.fromJson(data) as T;
    }
    if (t == _i67.ChangeControl) {
      return _i67.ChangeControl.fromJson(data) as T;
    }
    if (t == _i68.InspectionReport) {
      return _i68.InspectionReport.fromJson(data) as T;
    }
    if (t == _i69.QualityEvent) {
      return _i69.QualityEvent.fromJson(data) as T;
    }
    if (t == _i70.AbacPolicy) {
      return _i70.AbacPolicy.fromJson(data) as T;
    }
    if (t == _i71.DelegatedAuthority) {
      return _i71.DelegatedAuthority.fromJson(data) as T;
    }
    if (t == _i72.ElectronicSignature) {
      return _i72.ElectronicSignature.fromJson(data) as T;
    }
    if (t == _i73.SignatureMeaning) {
      return _i73.SignatureMeaning.fromJson(data) as T;
    }
    if (t == _i74.SignatureVerificationResult) {
      return _i74.SignatureVerificationResult.fromJson(data) as T;
    }
    if (t == _i75.Certificate) {
      return _i75.Certificate.fromJson(data) as T;
    }
    if (t == _i76.Enrollment) {
      return _i76.Enrollment.fromJson(data) as T;
    }
    if (t == _i77.TrainingAssignment) {
      return _i77.TrainingAssignment.fromJson(data) as T;
    }
    if (t == _i78.TrainingExpiration) {
      return _i78.TrainingExpiration.fromJson(data) as T;
    }
    if (t == _i79.TrainingMatrix) {
      return _i79.TrainingMatrix.fromJson(data) as T;
    }
    if (t == _i80.TrainingRecord) {
      return _i80.TrainingRecord.fromJson(data) as T;
    }
    if (t == _i81.TrainingRecordAnnotation) {
      return _i81.TrainingRecordAnnotation.fromJson(data) as T;
    }
    if (t == _i82.TrainingWaiver) {
      return _i82.TrainingWaiver.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.BulkImportResult?>()) {
      return (data != null ? _i5.BulkImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ImportLog?>()) {
      return (data != null ? _i6.ImportLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AuditReadinessScore?>()) {
      return (data != null ? _i7.AuditReadinessScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.ComplianceMetrics?>()) {
      return (data != null ? _i8.ComplianceMetrics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CourseAnalytics?>()) {
      return (data != null ? _i9.CourseAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Dashboard?>()) {
      return (data != null ? _i10.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DepartmentComplianceSummary?>()) {
      return (data != null
              ? _i11.DepartmentComplianceSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.ReportDefinition?>()) {
      return (data != null ? _i12.ReportDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.SlaBreach?>()) {
      return (data != null ? _i13.SlaBreach.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SlaPolicy?>()) {
      return (data != null ? _i14.SlaPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.UserComplianceMetrics?>()) {
      return (data != null ? _i15.UserComplianceMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.Assessment?>()) {
      return (data != null ? _i16.Assessment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.AssessmentAttempt?>()) {
      return (data != null ? _i17.AssessmentAttempt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AssessmentResult?>()) {
      return (data != null ? _i18.AssessmentResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Question?>()) {
      return (data != null ? _i19.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.QuestionBank?>()) {
      return (data != null ? _i20.QuestionBank.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.AccessLog?>()) {
      return (data != null ? _i21.AccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.AuditTrail?>()) {
      return (data != null ? _i22.AuditTrail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.AuditorPageLog?>()) {
      return (data != null ? _i23.AuditorPageLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.AuditorSession?>()) {
      return (data != null ? _i24.AuditorSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ErrorLog?>()) {
      return (data != null ? _i25.ErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.InspectionPackage?>()) {
      return (data != null ? _i26.InspectionPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.InspectionRecord?>()) {
      return (data != null ? _i27.InspectionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ReportExport?>()) {
      return (data != null ? _i28.ReportExport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.UserSession?>()) {
      return (data != null ? _i29.UserSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.Competency?>()) {
      return (data != null ? _i30.Competency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.Course?>()) {
      return (data != null ? _i31.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.CourseCompetency?>()) {
      return (data != null ? _i32.CourseCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CourseReview?>()) {
      return (data != null ? _i33.CourseReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.CourseVersion?>()) {
      return (data != null ? _i34.CourseVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Lesson?>()) {
      return (data != null ? _i35.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.Module?>()) {
      return (data != null ? _i36.Module.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.UserCompetency?>()) {
      return (data != null ? _i37.UserCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.ApprovalWorkflow?>()) {
      return (data != null ? _i38.ApprovalWorkflow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.Document?>()) {
      return (data != null ? _i39.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.DocumentLifecycle?>()) {
      return (data != null ? _i40.DocumentLifecycle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.DocumentVersion?>()) {
      return (data != null ? _i41.DocumentVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.DeadLetterQueue?>()) {
      return (data != null ? _i42.DeadLetterQueue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.DomainEvent?>()) {
      return (data != null ? _i43.DomainEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.OutboxMessage?>()) {
      return (data != null ? _i44.OutboxMessage.fromJson(data) : null) as T;
    }
    if (t ==
        _i1.getType<_i45.KafkaEventProcessorProcessEmployeeCreatedModel?>()) {
      return (data != null
              ? _i45.KafkaEventProcessorProcessEmployeeCreatedModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t ==
        _i1
            .getType<
              _i46.KafkaEventProcessorProcessEmployeeTransferredModel?
            >()) {
      return (data != null
              ? _i46.KafkaEventProcessorProcessEmployeeTransferredModel.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.KafkaEventProcessorProcessSopUpdatedModel?>()) {
      return (data != null
              ? _i47.KafkaEventProcessorProcessSopUpdatedModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i48.Greeting?>()) {
      return (data != null ? _i48.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.FeatureFlag?>()) {
      return (data != null ? _i49.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.ScheduledJobLog?>()) {
      return (data != null ? _i50.ScheduledJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SystemConfiguration?>()) {
      return (data != null ? _i51.SystemConfiguration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.Material?>()) {
      return (data != null ? _i52.Material.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.MaterialProgress?>()) {
      return (data != null ? _i53.MaterialProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.MaterialVersion?>()) {
      return (data != null ? _i54.MaterialVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.MediaAsset?>()) {
      return (data != null ? _i55.MediaAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.InAppNotification?>()) {
      return (data != null ? _i56.InAppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.Notification?>()) {
      return (data != null ? _i57.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.Department?>()) {
      return (data != null ? _i58.Department.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.JobRole?>()) {
      return (data != null ? _i59.JobRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.Organization?>()) {
      return (data != null ? _i60.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.Permission?>()) {
      return (data != null ? _i61.Permission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.Role?>()) {
      return (data != null ? _i62.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.Site?>()) {
      return (data != null ? _i63.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.PharmaUser?>()) {
      return (data != null ? _i64.PharmaUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.UserRole?>()) {
      return (data != null ? _i65.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.Capa?>()) {
      return (data != null ? _i66.Capa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.ChangeControl?>()) {
      return (data != null ? _i67.ChangeControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.InspectionReport?>()) {
      return (data != null ? _i68.InspectionReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.QualityEvent?>()) {
      return (data != null ? _i69.QualityEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.AbacPolicy?>()) {
      return (data != null ? _i70.AbacPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.DelegatedAuthority?>()) {
      return (data != null ? _i71.DelegatedAuthority.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i72.ElectronicSignature?>()) {
      return (data != null ? _i72.ElectronicSignature.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i73.SignatureMeaning?>()) {
      return (data != null ? _i73.SignatureMeaning.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.SignatureVerificationResult?>()) {
      return (data != null
              ? _i74.SignatureVerificationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i75.Certificate?>()) {
      return (data != null ? _i75.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.Enrollment?>()) {
      return (data != null ? _i76.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.TrainingAssignment?>()) {
      return (data != null ? _i77.TrainingAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.TrainingExpiration?>()) {
      return (data != null ? _i78.TrainingExpiration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i79.TrainingMatrix?>()) {
      return (data != null ? _i79.TrainingMatrix.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.TrainingRecord?>()) {
      return (data != null ? _i80.TrainingRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.TrainingRecordAnnotation?>()) {
      return (data != null
              ? _i81.TrainingRecordAnnotation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i82.TrainingWaiver?>()) {
      return (data != null ? _i82.TrainingWaiver.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i83.SignatureMeaning>) {
      return (data as List)
              .map((e) => deserialize<_i83.SignatureMeaning>(e))
              .toList()
          as T;
    }
    if (t == List<_i84.TrainingAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i84.TrainingAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i85.TrainingWaiver>) {
      return (data as List)
              .map((e) => deserialize<_i85.TrainingWaiver>(e))
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
    if (t == List<_i86.DepartmentComplianceSummary>) {
      return (data as List)
              .map((e) => deserialize<_i86.DepartmentComplianceSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.ReportDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i87.ReportDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i88.Dashboard>) {
      return (data as List).map((e) => deserialize<_i88.Dashboard>(e)).toList()
          as T;
    }
    if (t == List<_i89.SlaBreach>) {
      return (data as List).map((e) => deserialize<_i89.SlaBreach>(e)).toList()
          as T;
    }
    if (t == List<_i90.PharmaUser>) {
      return (data as List).map((e) => deserialize<_i90.PharmaUser>(e)).toList()
          as T;
    }
    if (t == Map<String, List<_i91.Certificate>>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<List<_i91.Certificate>>(v),
            ),
          )
          as T;
    }
    if (t == List<_i91.Certificate>) {
      return (data as List)
              .map((e) => deserialize<_i91.Certificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.Capa>) {
      return (data as List).map((e) => deserialize<_i92.Capa>(e)).toList() as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.Question>) {
      return (data as List).map((e) => deserialize<_i93.Question>(e)).toList()
          as T;
    }
    if (t == List<_i94.QuestionBank>) {
      return (data as List)
              .map((e) => deserialize<_i94.QuestionBank>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.AuditTrail>) {
      return (data as List).map((e) => deserialize<_i95.AuditTrail>(e)).toList()
          as T;
    }
    if (t == List<_i96.AccessLog>) {
      return (data as List).map((e) => deserialize<_i96.AccessLog>(e)).toList()
          as T;
    }
    if (t == List<_i97.Course>) {
      return (data as List).map((e) => deserialize<_i97.Course>(e)).toList()
          as T;
    }
    if (t == List<_i98.CourseVersion>) {
      return (data as List)
              .map((e) => deserialize<_i98.CourseVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i99.Module>) {
      return (data as List).map((e) => deserialize<_i99.Module>(e)).toList()
          as T;
    }
    if (t == List<_i100.Lesson>) {
      return (data as List).map((e) => deserialize<_i100.Lesson>(e)).toList()
          as T;
    }
    if (t == List<_i101.Document>) {
      return (data as List).map((e) => deserialize<_i101.Document>(e)).toList()
          as T;
    }
    if (t == List<_i102.DocumentVersion>) {
      return (data as List)
              .map((e) => deserialize<_i102.DocumentVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i103.DocumentLifecycle>) {
      return (data as List)
              .map((e) => deserialize<_i103.DocumentLifecycle>(e))
              .toList()
          as T;
    }
    if (t == List<_i104.InspectionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i104.InspectionRecord>(e))
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
    if (t == List<_i105.InspectionPackage>) {
      return (data as List)
              .map((e) => deserialize<_i105.InspectionPackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i106.MaterialVersion>) {
      return (data as List)
              .map((e) => deserialize<_i106.MaterialVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i107.Material>) {
      return (data as List).map((e) => deserialize<_i107.Material>(e)).toList()
          as T;
    }
    if (t == List<_i108.InAppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i108.InAppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i109.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i109.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i110.Site>) {
      return (data as List).map((e) => deserialize<_i110.Site>(e)).toList()
          as T;
    }
    if (t == List<_i111.Department>) {
      return (data as List)
              .map((e) => deserialize<_i111.Department>(e))
              .toList()
          as T;
    }
    if (t == List<_i112.JobRole>) {
      return (data as List).map((e) => deserialize<_i112.JobRole>(e)).toList()
          as T;
    }
    if (t == List<_i113.QualityEvent>) {
      return (data as List)
              .map((e) => deserialize<_i113.QualityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.InspectionReport>) {
      return (data as List)
              .map((e) => deserialize<_i114.InspectionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i115.Enrollment>) {
      return (data as List)
              .map((e) => deserialize<_i115.Enrollment>(e))
              .toList()
          as T;
    }
    if (t == List<_i116.TrainingRecord>) {
      return (data as List)
              .map((e) => deserialize<_i116.TrainingRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i117.ElectronicSignature>) {
      return (data as List)
              .map((e) => deserialize<_i117.ElectronicSignature>(e))
              .toList()
          as T;
    }
    if (t == List<_i118.TrainingRecordAnnotation>) {
      return (data as List)
              .map((e) => deserialize<_i118.TrainingRecordAnnotation>(e))
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
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.BulkImportResult => 'BulkImportResult',
      _i6.ImportLog => 'ImportLog',
      _i7.AuditReadinessScore => 'AuditReadinessScore',
      _i8.ComplianceMetrics => 'ComplianceMetrics',
      _i9.CourseAnalytics => 'CourseAnalytics',
      _i10.Dashboard => 'Dashboard',
      _i11.DepartmentComplianceSummary => 'DepartmentComplianceSummary',
      _i12.ReportDefinition => 'ReportDefinition',
      _i13.SlaBreach => 'SlaBreach',
      _i14.SlaPolicy => 'SlaPolicy',
      _i15.UserComplianceMetrics => 'UserComplianceMetrics',
      _i16.Assessment => 'Assessment',
      _i17.AssessmentAttempt => 'AssessmentAttempt',
      _i18.AssessmentResult => 'AssessmentResult',
      _i19.Question => 'Question',
      _i20.QuestionBank => 'QuestionBank',
      _i21.AccessLog => 'AccessLog',
      _i22.AuditTrail => 'AuditTrail',
      _i23.AuditorPageLog => 'AuditorPageLog',
      _i24.AuditorSession => 'AuditorSession',
      _i25.ErrorLog => 'ErrorLog',
      _i26.InspectionPackage => 'InspectionPackage',
      _i27.InspectionRecord => 'InspectionRecord',
      _i28.ReportExport => 'ReportExport',
      _i29.UserSession => 'UserSession',
      _i30.Competency => 'Competency',
      _i31.Course => 'Course',
      _i32.CourseCompetency => 'CourseCompetency',
      _i33.CourseReview => 'CourseReview',
      _i34.CourseVersion => 'CourseVersion',
      _i35.Lesson => 'Lesson',
      _i36.Module => 'Module',
      _i37.UserCompetency => 'UserCompetency',
      _i38.ApprovalWorkflow => 'ApprovalWorkflow',
      _i39.Document => 'Document',
      _i40.DocumentLifecycle => 'DocumentLifecycle',
      _i41.DocumentVersion => 'DocumentVersion',
      _i42.DeadLetterQueue => 'DeadLetterQueue',
      _i43.DomainEvent => 'DomainEvent',
      _i44.OutboxMessage => 'OutboxMessage',
      _i45.KafkaEventProcessorProcessEmployeeCreatedModel =>
        'KafkaEventProcessorProcessEmployeeCreatedModel',
      _i46.KafkaEventProcessorProcessEmployeeTransferredModel =>
        'KafkaEventProcessorProcessEmployeeTransferredModel',
      _i47.KafkaEventProcessorProcessSopUpdatedModel =>
        'KafkaEventProcessorProcessSopUpdatedModel',
      _i48.Greeting => 'Greeting',
      _i49.FeatureFlag => 'FeatureFlag',
      _i50.ScheduledJobLog => 'ScheduledJobLog',
      _i51.SystemConfiguration => 'SystemConfiguration',
      _i52.Material => 'Material',
      _i53.MaterialProgress => 'MaterialProgress',
      _i54.MaterialVersion => 'MaterialVersion',
      _i55.MediaAsset => 'MediaAsset',
      _i56.InAppNotification => 'InAppNotification',
      _i57.Notification => 'Notification',
      _i58.Department => 'Department',
      _i59.JobRole => 'JobRole',
      _i60.Organization => 'Organization',
      _i61.Permission => 'Permission',
      _i62.Role => 'Role',
      _i63.Site => 'Site',
      _i64.PharmaUser => 'PharmaUser',
      _i65.UserRole => 'UserRole',
      _i66.Capa => 'Capa',
      _i67.ChangeControl => 'ChangeControl',
      _i68.InspectionReport => 'InspectionReport',
      _i69.QualityEvent => 'QualityEvent',
      _i70.AbacPolicy => 'AbacPolicy',
      _i71.DelegatedAuthority => 'DelegatedAuthority',
      _i72.ElectronicSignature => 'ElectronicSignature',
      _i73.SignatureMeaning => 'SignatureMeaning',
      _i74.SignatureVerificationResult => 'SignatureVerificationResult',
      _i75.Certificate => 'Certificate',
      _i76.Enrollment => 'Enrollment',
      _i77.TrainingAssignment => 'TrainingAssignment',
      _i78.TrainingExpiration => 'TrainingExpiration',
      _i79.TrainingMatrix => 'TrainingMatrix',
      _i80.TrainingRecord => 'TrainingRecord',
      _i81.TrainingRecordAnnotation => 'TrainingRecordAnnotation',
      _i82.TrainingWaiver => 'TrainingWaiver',
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
      case _i5.BulkImportResult():
        return 'BulkImportResult';
      case _i6.ImportLog():
        return 'ImportLog';
      case _i7.AuditReadinessScore():
        return 'AuditReadinessScore';
      case _i8.ComplianceMetrics():
        return 'ComplianceMetrics';
      case _i9.CourseAnalytics():
        return 'CourseAnalytics';
      case _i10.Dashboard():
        return 'Dashboard';
      case _i11.DepartmentComplianceSummary():
        return 'DepartmentComplianceSummary';
      case _i12.ReportDefinition():
        return 'ReportDefinition';
      case _i13.SlaBreach():
        return 'SlaBreach';
      case _i14.SlaPolicy():
        return 'SlaPolicy';
      case _i15.UserComplianceMetrics():
        return 'UserComplianceMetrics';
      case _i16.Assessment():
        return 'Assessment';
      case _i17.AssessmentAttempt():
        return 'AssessmentAttempt';
      case _i18.AssessmentResult():
        return 'AssessmentResult';
      case _i19.Question():
        return 'Question';
      case _i20.QuestionBank():
        return 'QuestionBank';
      case _i21.AccessLog():
        return 'AccessLog';
      case _i22.AuditTrail():
        return 'AuditTrail';
      case _i23.AuditorPageLog():
        return 'AuditorPageLog';
      case _i24.AuditorSession():
        return 'AuditorSession';
      case _i25.ErrorLog():
        return 'ErrorLog';
      case _i26.InspectionPackage():
        return 'InspectionPackage';
      case _i27.InspectionRecord():
        return 'InspectionRecord';
      case _i28.ReportExport():
        return 'ReportExport';
      case _i29.UserSession():
        return 'UserSession';
      case _i30.Competency():
        return 'Competency';
      case _i31.Course():
        return 'Course';
      case _i32.CourseCompetency():
        return 'CourseCompetency';
      case _i33.CourseReview():
        return 'CourseReview';
      case _i34.CourseVersion():
        return 'CourseVersion';
      case _i35.Lesson():
        return 'Lesson';
      case _i36.Module():
        return 'Module';
      case _i37.UserCompetency():
        return 'UserCompetency';
      case _i38.ApprovalWorkflow():
        return 'ApprovalWorkflow';
      case _i39.Document():
        return 'Document';
      case _i40.DocumentLifecycle():
        return 'DocumentLifecycle';
      case _i41.DocumentVersion():
        return 'DocumentVersion';
      case _i42.DeadLetterQueue():
        return 'DeadLetterQueue';
      case _i43.DomainEvent():
        return 'DomainEvent';
      case _i44.OutboxMessage():
        return 'OutboxMessage';
      case _i45.KafkaEventProcessorProcessEmployeeCreatedModel():
        return 'KafkaEventProcessorProcessEmployeeCreatedModel';
      case _i46.KafkaEventProcessorProcessEmployeeTransferredModel():
        return 'KafkaEventProcessorProcessEmployeeTransferredModel';
      case _i47.KafkaEventProcessorProcessSopUpdatedModel():
        return 'KafkaEventProcessorProcessSopUpdatedModel';
      case _i48.Greeting():
        return 'Greeting';
      case _i49.FeatureFlag():
        return 'FeatureFlag';
      case _i50.ScheduledJobLog():
        return 'ScheduledJobLog';
      case _i51.SystemConfiguration():
        return 'SystemConfiguration';
      case _i52.Material():
        return 'Material';
      case _i53.MaterialProgress():
        return 'MaterialProgress';
      case _i54.MaterialVersion():
        return 'MaterialVersion';
      case _i55.MediaAsset():
        return 'MediaAsset';
      case _i56.InAppNotification():
        return 'InAppNotification';
      case _i57.Notification():
        return 'Notification';
      case _i58.Department():
        return 'Department';
      case _i59.JobRole():
        return 'JobRole';
      case _i60.Organization():
        return 'Organization';
      case _i61.Permission():
        return 'Permission';
      case _i62.Role():
        return 'Role';
      case _i63.Site():
        return 'Site';
      case _i64.PharmaUser():
        return 'PharmaUser';
      case _i65.UserRole():
        return 'UserRole';
      case _i66.Capa():
        return 'Capa';
      case _i67.ChangeControl():
        return 'ChangeControl';
      case _i68.InspectionReport():
        return 'InspectionReport';
      case _i69.QualityEvent():
        return 'QualityEvent';
      case _i70.AbacPolicy():
        return 'AbacPolicy';
      case _i71.DelegatedAuthority():
        return 'DelegatedAuthority';
      case _i72.ElectronicSignature():
        return 'ElectronicSignature';
      case _i73.SignatureMeaning():
        return 'SignatureMeaning';
      case _i74.SignatureVerificationResult():
        return 'SignatureVerificationResult';
      case _i75.Certificate():
        return 'Certificate';
      case _i76.Enrollment():
        return 'Enrollment';
      case _i77.TrainingAssignment():
        return 'TrainingAssignment';
      case _i78.TrainingExpiration():
        return 'TrainingExpiration';
      case _i79.TrainingMatrix():
        return 'TrainingMatrix';
      case _i80.TrainingRecord():
        return 'TrainingRecord';
      case _i81.TrainingRecordAnnotation():
        return 'TrainingRecordAnnotation';
      case _i82.TrainingWaiver():
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
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BulkImportResult') {
      return deserialize<_i5.BulkImportResult>(data['data']);
    }
    if (dataClassName == 'ImportLog') {
      return deserialize<_i6.ImportLog>(data['data']);
    }
    if (dataClassName == 'AuditReadinessScore') {
      return deserialize<_i7.AuditReadinessScore>(data['data']);
    }
    if (dataClassName == 'ComplianceMetrics') {
      return deserialize<_i8.ComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'CourseAnalytics') {
      return deserialize<_i9.CourseAnalytics>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_i10.Dashboard>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSummary') {
      return deserialize<_i11.DepartmentComplianceSummary>(data['data']);
    }
    if (dataClassName == 'ReportDefinition') {
      return deserialize<_i12.ReportDefinition>(data['data']);
    }
    if (dataClassName == 'SlaBreach') {
      return deserialize<_i13.SlaBreach>(data['data']);
    }
    if (dataClassName == 'SlaPolicy') {
      return deserialize<_i14.SlaPolicy>(data['data']);
    }
    if (dataClassName == 'UserComplianceMetrics') {
      return deserialize<_i15.UserComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'Assessment') {
      return deserialize<_i16.Assessment>(data['data']);
    }
    if (dataClassName == 'AssessmentAttempt') {
      return deserialize<_i17.AssessmentAttempt>(data['data']);
    }
    if (dataClassName == 'AssessmentResult') {
      return deserialize<_i18.AssessmentResult>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i19.Question>(data['data']);
    }
    if (dataClassName == 'QuestionBank') {
      return deserialize<_i20.QuestionBank>(data['data']);
    }
    if (dataClassName == 'AccessLog') {
      return deserialize<_i21.AccessLog>(data['data']);
    }
    if (dataClassName == 'AuditTrail') {
      return deserialize<_i22.AuditTrail>(data['data']);
    }
    if (dataClassName == 'AuditorPageLog') {
      return deserialize<_i23.AuditorPageLog>(data['data']);
    }
    if (dataClassName == 'AuditorSession') {
      return deserialize<_i24.AuditorSession>(data['data']);
    }
    if (dataClassName == 'ErrorLog') {
      return deserialize<_i25.ErrorLog>(data['data']);
    }
    if (dataClassName == 'InspectionPackage') {
      return deserialize<_i26.InspectionPackage>(data['data']);
    }
    if (dataClassName == 'InspectionRecord') {
      return deserialize<_i27.InspectionRecord>(data['data']);
    }
    if (dataClassName == 'ReportExport') {
      return deserialize<_i28.ReportExport>(data['data']);
    }
    if (dataClassName == 'UserSession') {
      return deserialize<_i29.UserSession>(data['data']);
    }
    if (dataClassName == 'Competency') {
      return deserialize<_i30.Competency>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i31.Course>(data['data']);
    }
    if (dataClassName == 'CourseCompetency') {
      return deserialize<_i32.CourseCompetency>(data['data']);
    }
    if (dataClassName == 'CourseReview') {
      return deserialize<_i33.CourseReview>(data['data']);
    }
    if (dataClassName == 'CourseVersion') {
      return deserialize<_i34.CourseVersion>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i35.Lesson>(data['data']);
    }
    if (dataClassName == 'Module') {
      return deserialize<_i36.Module>(data['data']);
    }
    if (dataClassName == 'UserCompetency') {
      return deserialize<_i37.UserCompetency>(data['data']);
    }
    if (dataClassName == 'ApprovalWorkflow') {
      return deserialize<_i38.ApprovalWorkflow>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i39.Document>(data['data']);
    }
    if (dataClassName == 'DocumentLifecycle') {
      return deserialize<_i40.DocumentLifecycle>(data['data']);
    }
    if (dataClassName == 'DocumentVersion') {
      return deserialize<_i41.DocumentVersion>(data['data']);
    }
    if (dataClassName == 'DeadLetterQueue') {
      return deserialize<_i42.DeadLetterQueue>(data['data']);
    }
    if (dataClassName == 'DomainEvent') {
      return deserialize<_i43.DomainEvent>(data['data']);
    }
    if (dataClassName == 'OutboxMessage') {
      return deserialize<_i44.OutboxMessage>(data['data']);
    }
    if (dataClassName == 'KafkaEventProcessorProcessEmployeeCreatedModel') {
      return deserialize<_i45.KafkaEventProcessorProcessEmployeeCreatedModel>(
        data['data'],
      );
    }
    if (dataClassName == 'KafkaEventProcessorProcessEmployeeTransferredModel') {
      return deserialize<
        _i46.KafkaEventProcessorProcessEmployeeTransferredModel
      >(data['data']);
    }
    if (dataClassName == 'KafkaEventProcessorProcessSopUpdatedModel') {
      return deserialize<_i47.KafkaEventProcessorProcessSopUpdatedModel>(
        data['data'],
      );
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i48.Greeting>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i49.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'ScheduledJobLog') {
      return deserialize<_i50.ScheduledJobLog>(data['data']);
    }
    if (dataClassName == 'SystemConfiguration') {
      return deserialize<_i51.SystemConfiguration>(data['data']);
    }
    if (dataClassName == 'Material') {
      return deserialize<_i52.Material>(data['data']);
    }
    if (dataClassName == 'MaterialProgress') {
      return deserialize<_i53.MaterialProgress>(data['data']);
    }
    if (dataClassName == 'MaterialVersion') {
      return deserialize<_i54.MaterialVersion>(data['data']);
    }
    if (dataClassName == 'MediaAsset') {
      return deserialize<_i55.MediaAsset>(data['data']);
    }
    if (dataClassName == 'InAppNotification') {
      return deserialize<_i56.InAppNotification>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i57.Notification>(data['data']);
    }
    if (dataClassName == 'Department') {
      return deserialize<_i58.Department>(data['data']);
    }
    if (dataClassName == 'JobRole') {
      return deserialize<_i59.JobRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i60.Organization>(data['data']);
    }
    if (dataClassName == 'Permission') {
      return deserialize<_i61.Permission>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i62.Role>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i63.Site>(data['data']);
    }
    if (dataClassName == 'PharmaUser') {
      return deserialize<_i64.PharmaUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i65.UserRole>(data['data']);
    }
    if (dataClassName == 'Capa') {
      return deserialize<_i66.Capa>(data['data']);
    }
    if (dataClassName == 'ChangeControl') {
      return deserialize<_i67.ChangeControl>(data['data']);
    }
    if (dataClassName == 'InspectionReport') {
      return deserialize<_i68.InspectionReport>(data['data']);
    }
    if (dataClassName == 'QualityEvent') {
      return deserialize<_i69.QualityEvent>(data['data']);
    }
    if (dataClassName == 'AbacPolicy') {
      return deserialize<_i70.AbacPolicy>(data['data']);
    }
    if (dataClassName == 'DelegatedAuthority') {
      return deserialize<_i71.DelegatedAuthority>(data['data']);
    }
    if (dataClassName == 'ElectronicSignature') {
      return deserialize<_i72.ElectronicSignature>(data['data']);
    }
    if (dataClassName == 'SignatureMeaning') {
      return deserialize<_i73.SignatureMeaning>(data['data']);
    }
    if (dataClassName == 'SignatureVerificationResult') {
      return deserialize<_i74.SignatureVerificationResult>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i75.Certificate>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i76.Enrollment>(data['data']);
    }
    if (dataClassName == 'TrainingAssignment') {
      return deserialize<_i77.TrainingAssignment>(data['data']);
    }
    if (dataClassName == 'TrainingExpiration') {
      return deserialize<_i78.TrainingExpiration>(data['data']);
    }
    if (dataClassName == 'TrainingMatrix') {
      return deserialize<_i79.TrainingMatrix>(data['data']);
    }
    if (dataClassName == 'TrainingRecord') {
      return deserialize<_i80.TrainingRecord>(data['data']);
    }
    if (dataClassName == 'TrainingRecordAnnotation') {
      return deserialize<_i81.TrainingRecordAnnotation>(data['data']);
    }
    if (dataClassName == 'TrainingWaiver') {
      return deserialize<_i82.TrainingWaiver>(data['data']);
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
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.ImportLog:
        return _i6.ImportLog.t;
      case _i10.Dashboard:
        return _i10.Dashboard.t;
      case _i12.ReportDefinition:
        return _i12.ReportDefinition.t;
      case _i13.SlaBreach:
        return _i13.SlaBreach.t;
      case _i14.SlaPolicy:
        return _i14.SlaPolicy.t;
      case _i16.Assessment:
        return _i16.Assessment.t;
      case _i17.AssessmentAttempt:
        return _i17.AssessmentAttempt.t;
      case _i18.AssessmentResult:
        return _i18.AssessmentResult.t;
      case _i19.Question:
        return _i19.Question.t;
      case _i20.QuestionBank:
        return _i20.QuestionBank.t;
      case _i21.AccessLog:
        return _i21.AccessLog.t;
      case _i22.AuditTrail:
        return _i22.AuditTrail.t;
      case _i23.AuditorPageLog:
        return _i23.AuditorPageLog.t;
      case _i24.AuditorSession:
        return _i24.AuditorSession.t;
      case _i25.ErrorLog:
        return _i25.ErrorLog.t;
      case _i26.InspectionPackage:
        return _i26.InspectionPackage.t;
      case _i27.InspectionRecord:
        return _i27.InspectionRecord.t;
      case _i28.ReportExport:
        return _i28.ReportExport.t;
      case _i29.UserSession:
        return _i29.UserSession.t;
      case _i30.Competency:
        return _i30.Competency.t;
      case _i31.Course:
        return _i31.Course.t;
      case _i32.CourseCompetency:
        return _i32.CourseCompetency.t;
      case _i33.CourseReview:
        return _i33.CourseReview.t;
      case _i34.CourseVersion:
        return _i34.CourseVersion.t;
      case _i35.Lesson:
        return _i35.Lesson.t;
      case _i36.Module:
        return _i36.Module.t;
      case _i37.UserCompetency:
        return _i37.UserCompetency.t;
      case _i38.ApprovalWorkflow:
        return _i38.ApprovalWorkflow.t;
      case _i39.Document:
        return _i39.Document.t;
      case _i40.DocumentLifecycle:
        return _i40.DocumentLifecycle.t;
      case _i41.DocumentVersion:
        return _i41.DocumentVersion.t;
      case _i42.DeadLetterQueue:
        return _i42.DeadLetterQueue.t;
      case _i43.DomainEvent:
        return _i43.DomainEvent.t;
      case _i44.OutboxMessage:
        return _i44.OutboxMessage.t;
      case _i49.FeatureFlag:
        return _i49.FeatureFlag.t;
      case _i50.ScheduledJobLog:
        return _i50.ScheduledJobLog.t;
      case _i51.SystemConfiguration:
        return _i51.SystemConfiguration.t;
      case _i52.Material:
        return _i52.Material.t;
      case _i53.MaterialProgress:
        return _i53.MaterialProgress.t;
      case _i54.MaterialVersion:
        return _i54.MaterialVersion.t;
      case _i55.MediaAsset:
        return _i55.MediaAsset.t;
      case _i57.Notification:
        return _i57.Notification.t;
      case _i58.Department:
        return _i58.Department.t;
      case _i59.JobRole:
        return _i59.JobRole.t;
      case _i60.Organization:
        return _i60.Organization.t;
      case _i61.Permission:
        return _i61.Permission.t;
      case _i62.Role:
        return _i62.Role.t;
      case _i63.Site:
        return _i63.Site.t;
      case _i64.PharmaUser:
        return _i64.PharmaUser.t;
      case _i65.UserRole:
        return _i65.UserRole.t;
      case _i66.Capa:
        return _i66.Capa.t;
      case _i67.ChangeControl:
        return _i67.ChangeControl.t;
      case _i68.InspectionReport:
        return _i68.InspectionReport.t;
      case _i69.QualityEvent:
        return _i69.QualityEvent.t;
      case _i70.AbacPolicy:
        return _i70.AbacPolicy.t;
      case _i71.DelegatedAuthority:
        return _i71.DelegatedAuthority.t;
      case _i72.ElectronicSignature:
        return _i72.ElectronicSignature.t;
      case _i73.SignatureMeaning:
        return _i73.SignatureMeaning.t;
      case _i75.Certificate:
        return _i75.Certificate.t;
      case _i76.Enrollment:
        return _i76.Enrollment.t;
      case _i77.TrainingAssignment:
        return _i77.TrainingAssignment.t;
      case _i78.TrainingExpiration:
        return _i78.TrainingExpiration.t;
      case _i79.TrainingMatrix:
        return _i79.TrainingMatrix.t;
      case _i80.TrainingRecord:
        return _i80.TrainingRecord.t;
      case _i81.TrainingRecordAnnotation:
        return _i81.TrainingRecordAnnotation.t;
      case _i82.TrainingWaiver:
        return _i82.TrainingWaiver.t;
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
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
