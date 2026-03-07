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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'admin/bulk_import_result.dart' as _i2;
import 'analytics/audit_readiness_score.dart' as _i3;
import 'analytics/compliance_metrics.dart' as _i4;
import 'analytics/dashboard.dart' as _i5;
import 'analytics/department_compliance_summary.dart' as _i6;
import 'analytics/report_definition.dart' as _i7;
import 'analytics/sla_breach.dart' as _i8;
import 'analytics/sla_policy.dart' as _i9;
import 'analytics/user_compliance_metrics.dart' as _i10;
import 'assessment/assessment.dart' as _i11;
import 'assessment/assessment_attempt.dart' as _i12;
import 'assessment/assessment_result.dart' as _i13;
import 'assessment/question.dart' as _i14;
import 'assessment/question_bank.dart' as _i15;
import 'audit/access_log.dart' as _i16;
import 'audit/audit_trail.dart' as _i17;
import 'audit/error_log.dart' as _i18;
import 'course/competency.dart' as _i19;
import 'course/course.dart' as _i20;
import 'course/course_competency.dart' as _i21;
import 'course/course_version.dart' as _i22;
import 'course/lesson.dart' as _i23;
import 'course/module.dart' as _i24;
import 'course/user_competency.dart' as _i25;
import 'document/approval_workflow.dart' as _i26;
import 'document/document.dart' as _i27;
import 'document/document_lifecycle.dart' as _i28;
import 'document/document_version.dart' as _i29;
import 'events/domain_event.dart' as _i30;
import 'events/outbox_message.dart' as _i31;
import 'greetings/greeting.dart' as _i32;
import 'infrastructure/feature_flag.dart' as _i33;
import 'infrastructure/system_configuration.dart' as _i34;
import 'material/material.dart' as _i35;
import 'material/material_progress.dart' as _i36;
import 'material/material_version.dart' as _i37;
import 'material/media_asset.dart' as _i38;
import 'notifications/in_app_notification.dart' as _i39;
import 'organization/department.dart' as _i40;
import 'organization/job_role.dart' as _i41;
import 'organization/organization.dart' as _i42;
import 'organization/permission.dart' as _i43;
import 'organization/role.dart' as _i44;
import 'organization/site.dart' as _i45;
import 'organization/user.dart' as _i46;
import 'organization/user_role.dart' as _i47;
import 'quality/capa.dart' as _i48;
import 'quality/change_control.dart' as _i49;
import 'quality/inspection_report.dart' as _i50;
import 'quality/quality_event.dart' as _i51;
import 'security/abac_policy.dart' as _i52;
import 'security/delegated_authority.dart' as _i53;
import 'shared/electronic_signature.dart' as _i54;
import 'training/certificate.dart' as _i55;
import 'training/enrollment.dart' as _i56;
import 'training/training_assignment.dart' as _i57;
import 'training/training_expiration.dart' as _i58;
import 'training/training_record.dart' as _i59;
import 'package:pharma_lms_client/src/protocol/training/training_assignment.dart'
    as _i60;
import 'package:pharma_lms_client/src/protocol/analytics/department_compliance_summary.dart'
    as _i61;
import 'package:pharma_lms_client/src/protocol/analytics/report_definition.dart'
    as _i62;
import 'package:pharma_lms_client/src/protocol/analytics/dashboard.dart'
    as _i63;
import 'package:pharma_lms_client/src/protocol/analytics/sla_breach.dart'
    as _i64;
import 'package:pharma_lms_client/src/protocol/assessment/question.dart'
    as _i65;
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i66;
import 'package:pharma_lms_client/src/protocol/audit/audit_trail.dart' as _i67;
import 'package:pharma_lms_client/src/protocol/audit/access_log.dart' as _i68;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i69;
import 'package:pharma_lms_client/src/protocol/course/course_version.dart'
    as _i70;
import 'package:pharma_lms_client/src/protocol/course/module.dart' as _i71;
import 'package:pharma_lms_client/src/protocol/course/lesson.dart' as _i72;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i73;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i74;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i75;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i76;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i77;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i78;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i79;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i80;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i81;
import 'package:pharma_lms_client/src/protocol/organization/job_role.dart'
    as _i82;
import 'package:pharma_lms_client/src/protocol/organization/user.dart' as _i83;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i84;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i85;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i86;
import 'package:pharma_lms_client/src/protocol/training/certificate.dart'
    as _i87;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i88;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i89;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i90;
export 'admin/bulk_import_result.dart';
export 'analytics/audit_readiness_score.dart';
export 'analytics/compliance_metrics.dart';
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
export 'audit/error_log.dart';
export 'course/competency.dart';
export 'course/course.dart';
export 'course/course_competency.dart';
export 'course/course_version.dart';
export 'course/lesson.dart';
export 'course/module.dart';
export 'course/user_competency.dart';
export 'document/approval_workflow.dart';
export 'document/document.dart';
export 'document/document_lifecycle.dart';
export 'document/document_version.dart';
export 'events/domain_event.dart';
export 'events/outbox_message.dart';
export 'greetings/greeting.dart';
export 'infrastructure/feature_flag.dart';
export 'infrastructure/system_configuration.dart';
export 'material/material.dart';
export 'material/material_progress.dart';
export 'material/material_version.dart';
export 'material/media_asset.dart';
export 'notifications/in_app_notification.dart';
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
export 'training/certificate.dart';
export 'training/enrollment.dart';
export 'training/training_assignment.dart';
export 'training/training_expiration.dart';
export 'training/training_record.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.BulkImportResult) {
      return _i2.BulkImportResult.fromJson(data) as T;
    }
    if (t == _i3.AuditReadinessScore) {
      return _i3.AuditReadinessScore.fromJson(data) as T;
    }
    if (t == _i4.ComplianceMetrics) {
      return _i4.ComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i5.Dashboard) {
      return _i5.Dashboard.fromJson(data) as T;
    }
    if (t == _i6.DepartmentComplianceSummary) {
      return _i6.DepartmentComplianceSummary.fromJson(data) as T;
    }
    if (t == _i7.ReportDefinition) {
      return _i7.ReportDefinition.fromJson(data) as T;
    }
    if (t == _i8.SlaBreach) {
      return _i8.SlaBreach.fromJson(data) as T;
    }
    if (t == _i9.SlaPolicy) {
      return _i9.SlaPolicy.fromJson(data) as T;
    }
    if (t == _i10.UserComplianceMetrics) {
      return _i10.UserComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i11.Assessment) {
      return _i11.Assessment.fromJson(data) as T;
    }
    if (t == _i12.AssessmentAttempt) {
      return _i12.AssessmentAttempt.fromJson(data) as T;
    }
    if (t == _i13.AssessmentResult) {
      return _i13.AssessmentResult.fromJson(data) as T;
    }
    if (t == _i14.Question) {
      return _i14.Question.fromJson(data) as T;
    }
    if (t == _i15.QuestionBank) {
      return _i15.QuestionBank.fromJson(data) as T;
    }
    if (t == _i16.AccessLog) {
      return _i16.AccessLog.fromJson(data) as T;
    }
    if (t == _i17.AuditTrail) {
      return _i17.AuditTrail.fromJson(data) as T;
    }
    if (t == _i18.ErrorLog) {
      return _i18.ErrorLog.fromJson(data) as T;
    }
    if (t == _i19.Competency) {
      return _i19.Competency.fromJson(data) as T;
    }
    if (t == _i20.Course) {
      return _i20.Course.fromJson(data) as T;
    }
    if (t == _i21.CourseCompetency) {
      return _i21.CourseCompetency.fromJson(data) as T;
    }
    if (t == _i22.CourseVersion) {
      return _i22.CourseVersion.fromJson(data) as T;
    }
    if (t == _i23.Lesson) {
      return _i23.Lesson.fromJson(data) as T;
    }
    if (t == _i24.Module) {
      return _i24.Module.fromJson(data) as T;
    }
    if (t == _i25.UserCompetency) {
      return _i25.UserCompetency.fromJson(data) as T;
    }
    if (t == _i26.ApprovalWorkflow) {
      return _i26.ApprovalWorkflow.fromJson(data) as T;
    }
    if (t == _i27.Document) {
      return _i27.Document.fromJson(data) as T;
    }
    if (t == _i28.DocumentLifecycle) {
      return _i28.DocumentLifecycle.fromJson(data) as T;
    }
    if (t == _i29.DocumentVersion) {
      return _i29.DocumentVersion.fromJson(data) as T;
    }
    if (t == _i30.DomainEvent) {
      return _i30.DomainEvent.fromJson(data) as T;
    }
    if (t == _i31.OutboxMessage) {
      return _i31.OutboxMessage.fromJson(data) as T;
    }
    if (t == _i32.Greeting) {
      return _i32.Greeting.fromJson(data) as T;
    }
    if (t == _i33.FeatureFlag) {
      return _i33.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i34.SystemConfiguration) {
      return _i34.SystemConfiguration.fromJson(data) as T;
    }
    if (t == _i35.Material) {
      return _i35.Material.fromJson(data) as T;
    }
    if (t == _i36.MaterialProgress) {
      return _i36.MaterialProgress.fromJson(data) as T;
    }
    if (t == _i37.MaterialVersion) {
      return _i37.MaterialVersion.fromJson(data) as T;
    }
    if (t == _i38.MediaAsset) {
      return _i38.MediaAsset.fromJson(data) as T;
    }
    if (t == _i39.InAppNotification) {
      return _i39.InAppNotification.fromJson(data) as T;
    }
    if (t == _i40.Department) {
      return _i40.Department.fromJson(data) as T;
    }
    if (t == _i41.JobRole) {
      return _i41.JobRole.fromJson(data) as T;
    }
    if (t == _i42.Organization) {
      return _i42.Organization.fromJson(data) as T;
    }
    if (t == _i43.Permission) {
      return _i43.Permission.fromJson(data) as T;
    }
    if (t == _i44.Role) {
      return _i44.Role.fromJson(data) as T;
    }
    if (t == _i45.Site) {
      return _i45.Site.fromJson(data) as T;
    }
    if (t == _i46.PharmaUser) {
      return _i46.PharmaUser.fromJson(data) as T;
    }
    if (t == _i47.UserRole) {
      return _i47.UserRole.fromJson(data) as T;
    }
    if (t == _i48.Capa) {
      return _i48.Capa.fromJson(data) as T;
    }
    if (t == _i49.ChangeControl) {
      return _i49.ChangeControl.fromJson(data) as T;
    }
    if (t == _i50.InspectionReport) {
      return _i50.InspectionReport.fromJson(data) as T;
    }
    if (t == _i51.QualityEvent) {
      return _i51.QualityEvent.fromJson(data) as T;
    }
    if (t == _i52.AbacPolicy) {
      return _i52.AbacPolicy.fromJson(data) as T;
    }
    if (t == _i53.DelegatedAuthority) {
      return _i53.DelegatedAuthority.fromJson(data) as T;
    }
    if (t == _i54.ElectronicSignature) {
      return _i54.ElectronicSignature.fromJson(data) as T;
    }
    if (t == _i55.Certificate) {
      return _i55.Certificate.fromJson(data) as T;
    }
    if (t == _i56.Enrollment) {
      return _i56.Enrollment.fromJson(data) as T;
    }
    if (t == _i57.TrainingAssignment) {
      return _i57.TrainingAssignment.fromJson(data) as T;
    }
    if (t == _i58.TrainingExpiration) {
      return _i58.TrainingExpiration.fromJson(data) as T;
    }
    if (t == _i59.TrainingRecord) {
      return _i59.TrainingRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BulkImportResult?>()) {
      return (data != null ? _i2.BulkImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AuditReadinessScore?>()) {
      return (data != null ? _i3.AuditReadinessScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.ComplianceMetrics?>()) {
      return (data != null ? _i4.ComplianceMetrics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Dashboard?>()) {
      return (data != null ? _i5.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DepartmentComplianceSummary?>()) {
      return (data != null
              ? _i6.DepartmentComplianceSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.ReportDefinition?>()) {
      return (data != null ? _i7.ReportDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.SlaBreach?>()) {
      return (data != null ? _i8.SlaBreach.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.SlaPolicy?>()) {
      return (data != null ? _i9.SlaPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.UserComplianceMetrics?>()) {
      return (data != null ? _i10.UserComplianceMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Assessment?>()) {
      return (data != null ? _i11.Assessment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AssessmentAttempt?>()) {
      return (data != null ? _i12.AssessmentAttempt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AssessmentResult?>()) {
      return (data != null ? _i13.AssessmentResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Question?>()) {
      return (data != null ? _i14.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.QuestionBank?>()) {
      return (data != null ? _i15.QuestionBank.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AccessLog?>()) {
      return (data != null ? _i16.AccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.AuditTrail?>()) {
      return (data != null ? _i17.AuditTrail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ErrorLog?>()) {
      return (data != null ? _i18.ErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Competency?>()) {
      return (data != null ? _i19.Competency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Course?>()) {
      return (data != null ? _i20.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.CourseCompetency?>()) {
      return (data != null ? _i21.CourseCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.CourseVersion?>()) {
      return (data != null ? _i22.CourseVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Lesson?>()) {
      return (data != null ? _i23.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Module?>()) {
      return (data != null ? _i24.Module.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.UserCompetency?>()) {
      return (data != null ? _i25.UserCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ApprovalWorkflow?>()) {
      return (data != null ? _i26.ApprovalWorkflow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Document?>()) {
      return (data != null ? _i27.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.DocumentLifecycle?>()) {
      return (data != null ? _i28.DocumentLifecycle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.DocumentVersion?>()) {
      return (data != null ? _i29.DocumentVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.DomainEvent?>()) {
      return (data != null ? _i30.DomainEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.OutboxMessage?>()) {
      return (data != null ? _i31.OutboxMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Greeting?>()) {
      return (data != null ? _i32.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.FeatureFlag?>()) {
      return (data != null ? _i33.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SystemConfiguration?>()) {
      return (data != null ? _i34.SystemConfiguration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.Material?>()) {
      return (data != null ? _i35.Material.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.MaterialProgress?>()) {
      return (data != null ? _i36.MaterialProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.MaterialVersion?>()) {
      return (data != null ? _i37.MaterialVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.MediaAsset?>()) {
      return (data != null ? _i38.MediaAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.InAppNotification?>()) {
      return (data != null ? _i39.InAppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.Department?>()) {
      return (data != null ? _i40.Department.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.JobRole?>()) {
      return (data != null ? _i41.JobRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.Organization?>()) {
      return (data != null ? _i42.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.Permission?>()) {
      return (data != null ? _i43.Permission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.Role?>()) {
      return (data != null ? _i44.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.Site?>()) {
      return (data != null ? _i45.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.PharmaUser?>()) {
      return (data != null ? _i46.PharmaUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.UserRole?>()) {
      return (data != null ? _i47.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.Capa?>()) {
      return (data != null ? _i48.Capa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.ChangeControl?>()) {
      return (data != null ? _i49.ChangeControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.InspectionReport?>()) {
      return (data != null ? _i50.InspectionReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.QualityEvent?>()) {
      return (data != null ? _i51.QualityEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.AbacPolicy?>()) {
      return (data != null ? _i52.AbacPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.DelegatedAuthority?>()) {
      return (data != null ? _i53.DelegatedAuthority.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.ElectronicSignature?>()) {
      return (data != null ? _i54.ElectronicSignature.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.Certificate?>()) {
      return (data != null ? _i55.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.Enrollment?>()) {
      return (data != null ? _i56.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.TrainingAssignment?>()) {
      return (data != null ? _i57.TrainingAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.TrainingExpiration?>()) {
      return (data != null ? _i58.TrainingExpiration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.TrainingRecord?>()) {
      return (data != null ? _i59.TrainingRecord.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i60.TrainingAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i60.TrainingAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == List<_i61.DepartmentComplianceSummary>) {
      return (data as List)
              .map((e) => deserialize<_i61.DepartmentComplianceSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.ReportDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i62.ReportDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.Dashboard>) {
      return (data as List).map((e) => deserialize<_i63.Dashboard>(e)).toList()
          as T;
    }
    if (t == List<_i64.SlaBreach>) {
      return (data as List).map((e) => deserialize<_i64.SlaBreach>(e)).toList()
          as T;
    }
    if (t == List<_i65.Question>) {
      return (data as List).map((e) => deserialize<_i65.Question>(e)).toList()
          as T;
    }
    if (t == List<_i66.QuestionBank>) {
      return (data as List)
              .map((e) => deserialize<_i66.QuestionBank>(e))
              .toList()
          as T;
    }
    if (t == List<_i67.AuditTrail>) {
      return (data as List).map((e) => deserialize<_i67.AuditTrail>(e)).toList()
          as T;
    }
    if (t == List<_i68.AccessLog>) {
      return (data as List).map((e) => deserialize<_i68.AccessLog>(e)).toList()
          as T;
    }
    if (t == List<_i69.Course>) {
      return (data as List).map((e) => deserialize<_i69.Course>(e)).toList()
          as T;
    }
    if (t == List<_i70.CourseVersion>) {
      return (data as List)
              .map((e) => deserialize<_i70.CourseVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.Module>) {
      return (data as List).map((e) => deserialize<_i71.Module>(e)).toList()
          as T;
    }
    if (t == List<_i72.Lesson>) {
      return (data as List).map((e) => deserialize<_i72.Lesson>(e)).toList()
          as T;
    }
    if (t == List<_i73.Document>) {
      return (data as List).map((e) => deserialize<_i73.Document>(e)).toList()
          as T;
    }
    if (t == List<_i74.DocumentVersion>) {
      return (data as List)
              .map((e) => deserialize<_i74.DocumentVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.DocumentLifecycle>) {
      return (data as List)
              .map((e) => deserialize<_i75.DocumentLifecycle>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.MaterialVersion>) {
      return (data as List)
              .map((e) => deserialize<_i76.MaterialVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.Material>) {
      return (data as List).map((e) => deserialize<_i77.Material>(e)).toList()
          as T;
    }
    if (t == List<_i78.InAppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i78.InAppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i79.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.Site>) {
      return (data as List).map((e) => deserialize<_i80.Site>(e)).toList() as T;
    }
    if (t == List<_i81.Department>) {
      return (data as List).map((e) => deserialize<_i81.Department>(e)).toList()
          as T;
    }
    if (t == List<_i82.JobRole>) {
      return (data as List).map((e) => deserialize<_i82.JobRole>(e)).toList()
          as T;
    }
    if (t == List<_i83.PharmaUser>) {
      return (data as List).map((e) => deserialize<_i83.PharmaUser>(e)).toList()
          as T;
    }
    if (t == List<_i84.QualityEvent>) {
      return (data as List)
              .map((e) => deserialize<_i84.QualityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i85.InspectionReport>) {
      return (data as List)
              .map((e) => deserialize<_i85.InspectionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.Enrollment>) {
      return (data as List).map((e) => deserialize<_i86.Enrollment>(e)).toList()
          as T;
    }
    if (t == List<_i87.Certificate>) {
      return (data as List)
              .map((e) => deserialize<_i87.Certificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i88.ElectronicSignature>) {
      return (data as List)
              .map((e) => deserialize<_i88.ElectronicSignature>(e))
              .toList()
          as T;
    }
    try {
      return _i89.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i90.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.BulkImportResult => 'BulkImportResult',
      _i3.AuditReadinessScore => 'AuditReadinessScore',
      _i4.ComplianceMetrics => 'ComplianceMetrics',
      _i5.Dashboard => 'Dashboard',
      _i6.DepartmentComplianceSummary => 'DepartmentComplianceSummary',
      _i7.ReportDefinition => 'ReportDefinition',
      _i8.SlaBreach => 'SlaBreach',
      _i9.SlaPolicy => 'SlaPolicy',
      _i10.UserComplianceMetrics => 'UserComplianceMetrics',
      _i11.Assessment => 'Assessment',
      _i12.AssessmentAttempt => 'AssessmentAttempt',
      _i13.AssessmentResult => 'AssessmentResult',
      _i14.Question => 'Question',
      _i15.QuestionBank => 'QuestionBank',
      _i16.AccessLog => 'AccessLog',
      _i17.AuditTrail => 'AuditTrail',
      _i18.ErrorLog => 'ErrorLog',
      _i19.Competency => 'Competency',
      _i20.Course => 'Course',
      _i21.CourseCompetency => 'CourseCompetency',
      _i22.CourseVersion => 'CourseVersion',
      _i23.Lesson => 'Lesson',
      _i24.Module => 'Module',
      _i25.UserCompetency => 'UserCompetency',
      _i26.ApprovalWorkflow => 'ApprovalWorkflow',
      _i27.Document => 'Document',
      _i28.DocumentLifecycle => 'DocumentLifecycle',
      _i29.DocumentVersion => 'DocumentVersion',
      _i30.DomainEvent => 'DomainEvent',
      _i31.OutboxMessage => 'OutboxMessage',
      _i32.Greeting => 'Greeting',
      _i33.FeatureFlag => 'FeatureFlag',
      _i34.SystemConfiguration => 'SystemConfiguration',
      _i35.Material => 'Material',
      _i36.MaterialProgress => 'MaterialProgress',
      _i37.MaterialVersion => 'MaterialVersion',
      _i38.MediaAsset => 'MediaAsset',
      _i39.InAppNotification => 'InAppNotification',
      _i40.Department => 'Department',
      _i41.JobRole => 'JobRole',
      _i42.Organization => 'Organization',
      _i43.Permission => 'Permission',
      _i44.Role => 'Role',
      _i45.Site => 'Site',
      _i46.PharmaUser => 'PharmaUser',
      _i47.UserRole => 'UserRole',
      _i48.Capa => 'Capa',
      _i49.ChangeControl => 'ChangeControl',
      _i50.InspectionReport => 'InspectionReport',
      _i51.QualityEvent => 'QualityEvent',
      _i52.AbacPolicy => 'AbacPolicy',
      _i53.DelegatedAuthority => 'DelegatedAuthority',
      _i54.ElectronicSignature => 'ElectronicSignature',
      _i55.Certificate => 'Certificate',
      _i56.Enrollment => 'Enrollment',
      _i57.TrainingAssignment => 'TrainingAssignment',
      _i58.TrainingExpiration => 'TrainingExpiration',
      _i59.TrainingRecord => 'TrainingRecord',
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
      case _i2.BulkImportResult():
        return 'BulkImportResult';
      case _i3.AuditReadinessScore():
        return 'AuditReadinessScore';
      case _i4.ComplianceMetrics():
        return 'ComplianceMetrics';
      case _i5.Dashboard():
        return 'Dashboard';
      case _i6.DepartmentComplianceSummary():
        return 'DepartmentComplianceSummary';
      case _i7.ReportDefinition():
        return 'ReportDefinition';
      case _i8.SlaBreach():
        return 'SlaBreach';
      case _i9.SlaPolicy():
        return 'SlaPolicy';
      case _i10.UserComplianceMetrics():
        return 'UserComplianceMetrics';
      case _i11.Assessment():
        return 'Assessment';
      case _i12.AssessmentAttempt():
        return 'AssessmentAttempt';
      case _i13.AssessmentResult():
        return 'AssessmentResult';
      case _i14.Question():
        return 'Question';
      case _i15.QuestionBank():
        return 'QuestionBank';
      case _i16.AccessLog():
        return 'AccessLog';
      case _i17.AuditTrail():
        return 'AuditTrail';
      case _i18.ErrorLog():
        return 'ErrorLog';
      case _i19.Competency():
        return 'Competency';
      case _i20.Course():
        return 'Course';
      case _i21.CourseCompetency():
        return 'CourseCompetency';
      case _i22.CourseVersion():
        return 'CourseVersion';
      case _i23.Lesson():
        return 'Lesson';
      case _i24.Module():
        return 'Module';
      case _i25.UserCompetency():
        return 'UserCompetency';
      case _i26.ApprovalWorkflow():
        return 'ApprovalWorkflow';
      case _i27.Document():
        return 'Document';
      case _i28.DocumentLifecycle():
        return 'DocumentLifecycle';
      case _i29.DocumentVersion():
        return 'DocumentVersion';
      case _i30.DomainEvent():
        return 'DomainEvent';
      case _i31.OutboxMessage():
        return 'OutboxMessage';
      case _i32.Greeting():
        return 'Greeting';
      case _i33.FeatureFlag():
        return 'FeatureFlag';
      case _i34.SystemConfiguration():
        return 'SystemConfiguration';
      case _i35.Material():
        return 'Material';
      case _i36.MaterialProgress():
        return 'MaterialProgress';
      case _i37.MaterialVersion():
        return 'MaterialVersion';
      case _i38.MediaAsset():
        return 'MediaAsset';
      case _i39.InAppNotification():
        return 'InAppNotification';
      case _i40.Department():
        return 'Department';
      case _i41.JobRole():
        return 'JobRole';
      case _i42.Organization():
        return 'Organization';
      case _i43.Permission():
        return 'Permission';
      case _i44.Role():
        return 'Role';
      case _i45.Site():
        return 'Site';
      case _i46.PharmaUser():
        return 'PharmaUser';
      case _i47.UserRole():
        return 'UserRole';
      case _i48.Capa():
        return 'Capa';
      case _i49.ChangeControl():
        return 'ChangeControl';
      case _i50.InspectionReport():
        return 'InspectionReport';
      case _i51.QualityEvent():
        return 'QualityEvent';
      case _i52.AbacPolicy():
        return 'AbacPolicy';
      case _i53.DelegatedAuthority():
        return 'DelegatedAuthority';
      case _i54.ElectronicSignature():
        return 'ElectronicSignature';
      case _i55.Certificate():
        return 'Certificate';
      case _i56.Enrollment():
        return 'Enrollment';
      case _i57.TrainingAssignment():
        return 'TrainingAssignment';
      case _i58.TrainingExpiration():
        return 'TrainingExpiration';
      case _i59.TrainingRecord():
        return 'TrainingRecord';
    }
    className = _i89.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i90.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.BulkImportResult>(data['data']);
    }
    if (dataClassName == 'AuditReadinessScore') {
      return deserialize<_i3.AuditReadinessScore>(data['data']);
    }
    if (dataClassName == 'ComplianceMetrics') {
      return deserialize<_i4.ComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_i5.Dashboard>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSummary') {
      return deserialize<_i6.DepartmentComplianceSummary>(data['data']);
    }
    if (dataClassName == 'ReportDefinition') {
      return deserialize<_i7.ReportDefinition>(data['data']);
    }
    if (dataClassName == 'SlaBreach') {
      return deserialize<_i8.SlaBreach>(data['data']);
    }
    if (dataClassName == 'SlaPolicy') {
      return deserialize<_i9.SlaPolicy>(data['data']);
    }
    if (dataClassName == 'UserComplianceMetrics') {
      return deserialize<_i10.UserComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'Assessment') {
      return deserialize<_i11.Assessment>(data['data']);
    }
    if (dataClassName == 'AssessmentAttempt') {
      return deserialize<_i12.AssessmentAttempt>(data['data']);
    }
    if (dataClassName == 'AssessmentResult') {
      return deserialize<_i13.AssessmentResult>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i14.Question>(data['data']);
    }
    if (dataClassName == 'QuestionBank') {
      return deserialize<_i15.QuestionBank>(data['data']);
    }
    if (dataClassName == 'AccessLog') {
      return deserialize<_i16.AccessLog>(data['data']);
    }
    if (dataClassName == 'AuditTrail') {
      return deserialize<_i17.AuditTrail>(data['data']);
    }
    if (dataClassName == 'ErrorLog') {
      return deserialize<_i18.ErrorLog>(data['data']);
    }
    if (dataClassName == 'Competency') {
      return deserialize<_i19.Competency>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i20.Course>(data['data']);
    }
    if (dataClassName == 'CourseCompetency') {
      return deserialize<_i21.CourseCompetency>(data['data']);
    }
    if (dataClassName == 'CourseVersion') {
      return deserialize<_i22.CourseVersion>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i23.Lesson>(data['data']);
    }
    if (dataClassName == 'Module') {
      return deserialize<_i24.Module>(data['data']);
    }
    if (dataClassName == 'UserCompetency') {
      return deserialize<_i25.UserCompetency>(data['data']);
    }
    if (dataClassName == 'ApprovalWorkflow') {
      return deserialize<_i26.ApprovalWorkflow>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i27.Document>(data['data']);
    }
    if (dataClassName == 'DocumentLifecycle') {
      return deserialize<_i28.DocumentLifecycle>(data['data']);
    }
    if (dataClassName == 'DocumentVersion') {
      return deserialize<_i29.DocumentVersion>(data['data']);
    }
    if (dataClassName == 'DomainEvent') {
      return deserialize<_i30.DomainEvent>(data['data']);
    }
    if (dataClassName == 'OutboxMessage') {
      return deserialize<_i31.OutboxMessage>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i32.Greeting>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i33.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'SystemConfiguration') {
      return deserialize<_i34.SystemConfiguration>(data['data']);
    }
    if (dataClassName == 'Material') {
      return deserialize<_i35.Material>(data['data']);
    }
    if (dataClassName == 'MaterialProgress') {
      return deserialize<_i36.MaterialProgress>(data['data']);
    }
    if (dataClassName == 'MaterialVersion') {
      return deserialize<_i37.MaterialVersion>(data['data']);
    }
    if (dataClassName == 'MediaAsset') {
      return deserialize<_i38.MediaAsset>(data['data']);
    }
    if (dataClassName == 'InAppNotification') {
      return deserialize<_i39.InAppNotification>(data['data']);
    }
    if (dataClassName == 'Department') {
      return deserialize<_i40.Department>(data['data']);
    }
    if (dataClassName == 'JobRole') {
      return deserialize<_i41.JobRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i42.Organization>(data['data']);
    }
    if (dataClassName == 'Permission') {
      return deserialize<_i43.Permission>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i44.Role>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i45.Site>(data['data']);
    }
    if (dataClassName == 'PharmaUser') {
      return deserialize<_i46.PharmaUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i47.UserRole>(data['data']);
    }
    if (dataClassName == 'Capa') {
      return deserialize<_i48.Capa>(data['data']);
    }
    if (dataClassName == 'ChangeControl') {
      return deserialize<_i49.ChangeControl>(data['data']);
    }
    if (dataClassName == 'InspectionReport') {
      return deserialize<_i50.InspectionReport>(data['data']);
    }
    if (dataClassName == 'QualityEvent') {
      return deserialize<_i51.QualityEvent>(data['data']);
    }
    if (dataClassName == 'AbacPolicy') {
      return deserialize<_i52.AbacPolicy>(data['data']);
    }
    if (dataClassName == 'DelegatedAuthority') {
      return deserialize<_i53.DelegatedAuthority>(data['data']);
    }
    if (dataClassName == 'ElectronicSignature') {
      return deserialize<_i54.ElectronicSignature>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i55.Certificate>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i56.Enrollment>(data['data']);
    }
    if (dataClassName == 'TrainingAssignment') {
      return deserialize<_i57.TrainingAssignment>(data['data']);
    }
    if (dataClassName == 'TrainingExpiration') {
      return deserialize<_i58.TrainingExpiration>(data['data']);
    }
    if (dataClassName == 'TrainingRecord') {
      return deserialize<_i59.TrainingRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i89.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i90.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i89.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i90.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
