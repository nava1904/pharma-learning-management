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
import 'admin/import_log.dart' as _i3;
import 'analytics/analytics_event.dart' as _i4;
import 'analytics/analytics_snapshot.dart' as _i5;
import 'analytics/audit_readiness_score.dart' as _i6;
import 'analytics/compliance_metrics.dart' as _i7;
import 'analytics/course_analytics.dart' as _i8;
import 'analytics/dashboard.dart' as _i9;
import 'analytics/department_compliance_snapshot.dart' as _i10;
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
import 'auth/oidc_account.dart' as _i30;
import 'auth/oidc_client_config.dart' as _i31;
import 'course/competency.dart' as _i32;
import 'course/course.dart' as _i33;
import 'course/course_competency.dart' as _i34;
import 'course/course_review.dart' as _i35;
import 'course/course_sop_link.dart' as _i36;
import 'course/course_version.dart' as _i37;
import 'course/lesson.dart' as _i38;
import 'course/module.dart' as _i39;
import 'course/qa_validation_result.dart' as _i40;
import 'course/qa_validation_rule_result.dart' as _i41;
import 'course/user_competency.dart' as _i42;
import 'document/approval_workflow.dart' as _i43;
import 'document/document.dart' as _i44;
import 'document/document_lifecycle.dart' as _i45;
import 'document/document_version.dart' as _i46;
import 'events/dead_letter_queue.dart' as _i47;
import 'events/domain_event.dart' as _i48;
import 'events/outbox_message.dart' as _i49;
import 'greetings/greeting.dart' as _i50;
import 'infrastructure/audit_integrity_result.dart' as _i51;
import 'infrastructure/feature_flag.dart' as _i52;
import 'infrastructure/retention_archive.dart' as _i53;
import 'infrastructure/retention_policy.dart' as _i54;
import 'infrastructure/scheduled_job_log.dart' as _i55;
import 'infrastructure/system_configuration.dart' as _i56;
import 'material/material.dart' as _i57;
import 'material/material_progress.dart' as _i58;
import 'material/material_version.dart' as _i59;
import 'material/media_asset.dart' as _i60;
import 'mfa/mfa_enroll_result.dart' as _i61;
import 'mfa/mfa_status_result.dart' as _i62;
import 'mfa/mfa_verified_session.dart' as _i63;
import 'mfa/user_mfa.dart' as _i64;
import 'notifications/in_app_notification.dart' as _i65;
import 'notifications/notification.dart' as _i66;
import 'notifications/notification_log.dart' as _i67;
import 'organization/department.dart' as _i68;
import 'organization/job_role.dart' as _i69;
import 'organization/organization.dart' as _i70;
import 'organization/permission.dart' as _i71;
import 'organization/role.dart' as _i72;
import 'organization/site.dart' as _i73;
import 'organization/user.dart' as _i74;
import 'organization/user_preference.dart' as _i75;
import 'organization/user_role.dart' as _i76;
import 'quality/capa.dart' as _i77;
import 'quality/change_control.dart' as _i78;
import 'quality/inspection_report.dart' as _i79;
import 'quality/quality_event.dart' as _i80;
import 'security/abac_policy.dart' as _i81;
import 'security/delegated_authority.dart' as _i82;
import 'shared/electronic_signature.dart' as _i83;
import 'shared/signature_meaning.dart' as _i84;
import 'shared/signature_verification_result.dart' as _i85;
import 'training/certificate.dart' as _i86;
import 'training/enrollment.dart' as _i87;
import 'training/training_assignment.dart' as _i88;
import 'training/training_expiration.dart' as _i89;
import 'training/training_matrix.dart' as _i90;
import 'training/training_record.dart' as _i91;
import 'training/training_record_annotation.dart' as _i92;
import 'training/training_waiver.dart' as _i93;
import 'package:pharma_lms_client/src/protocol/shared/signature_meaning.dart'
    as _i94;
import 'package:pharma_lms_client/src/protocol/training/training_assignment.dart'
    as _i95;
import 'package:pharma_lms_client/src/protocol/training/training_waiver.dart'
    as _i96;
import 'package:pharma_lms_client/src/protocol/analytics/department_compliance_summary.dart'
    as _i97;
import 'package:pharma_lms_client/src/protocol/analytics/report_definition.dart'
    as _i98;
import 'package:pharma_lms_client/src/protocol/analytics/dashboard.dart'
    as _i99;
import 'package:pharma_lms_client/src/protocol/analytics/sla_breach.dart'
    as _i100;
import 'package:pharma_lms_client/src/protocol/organization/user.dart' as _i101;
import 'package:pharma_lms_client/src/protocol/training/certificate.dart'
    as _i102;
import 'package:pharma_lms_client/src/protocol/quality/capa.dart' as _i103;
import 'package:pharma_lms_client/src/protocol/assessment/question.dart'
    as _i104;
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i105;
import 'package:pharma_lms_client/src/protocol/audit/audit_trail.dart' as _i106;
import 'package:pharma_lms_client/src/protocol/audit/access_log.dart' as _i107;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i108;
import 'package:pharma_lms_client/src/protocol/course/course_version.dart'
    as _i109;
import 'package:pharma_lms_client/src/protocol/course/module.dart' as _i110;
import 'package:pharma_lms_client/src/protocol/course/lesson.dart' as _i111;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i112;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i113;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i114;
import 'package:pharma_lms_client/src/protocol/audit/inspection_record.dart'
    as _i115;
import 'package:pharma_lms_client/src/protocol/audit/auditor_page_log.dart'
    as _i116;
import 'package:pharma_lms_client/src/protocol/audit/inspection_package.dart'
    as _i117;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i118;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i119;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i120;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i121;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i122;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i123;
import 'package:pharma_lms_client/src/protocol/organization/job_role.dart'
    as _i124;
import 'package:pharma_lms_client/src/protocol/course/course_review.dart'
    as _i125;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i126;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i127;
import 'package:pharma_lms_client/src/protocol/course/course_sop_link.dart'
    as _i128;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i129;
import 'package:pharma_lms_client/src/protocol/training/training_record.dart'
    as _i130;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i131;
import 'package:pharma_lms_client/src/protocol/training/training_record_annotation.dart'
    as _i132;
import 'package:pharma_lms_client/src/protocol/organization/user_preference.dart'
    as _i133;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i134;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i135;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i136;
export 'admin/bulk_import_result.dart';
export 'admin/import_log.dart';
export 'analytics/analytics_event.dart';
export 'analytics/analytics_snapshot.dart';
export 'analytics/audit_readiness_score.dart';
export 'analytics/compliance_metrics.dart';
export 'analytics/course_analytics.dart';
export 'analytics/dashboard.dart';
export 'analytics/department_compliance_snapshot.dart';
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
export 'course/course_sop_link.dart';
export 'course/course_version.dart';
export 'course/lesson.dart';
export 'course/module.dart';
export 'course/qa_validation_result.dart';
export 'course/qa_validation_rule_result.dart';
export 'course/user_competency.dart';
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
export 'notifications/notification.dart';
export 'notifications/notification_log.dart';
export 'organization/department.dart';
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
export 'training/certificate.dart';
export 'training/enrollment.dart';
export 'training/training_assignment.dart';
export 'training/training_expiration.dart';
export 'training/training_matrix.dart';
export 'training/training_record.dart';
export 'training/training_record_annotation.dart';
export 'training/training_waiver.dart';
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
    if (t == _i3.ImportLog) {
      return _i3.ImportLog.fromJson(data) as T;
    }
    if (t == _i4.AnalyticsEvent) {
      return _i4.AnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i5.AnalyticsSnapshot) {
      return _i5.AnalyticsSnapshot.fromJson(data) as T;
    }
    if (t == _i6.AuditReadinessScore) {
      return _i6.AuditReadinessScore.fromJson(data) as T;
    }
    if (t == _i7.ComplianceMetrics) {
      return _i7.ComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i8.CourseAnalytics) {
      return _i8.CourseAnalytics.fromJson(data) as T;
    }
    if (t == _i9.Dashboard) {
      return _i9.Dashboard.fromJson(data) as T;
    }
    if (t == _i10.DepartmentComplianceSnapshot) {
      return _i10.DepartmentComplianceSnapshot.fromJson(data) as T;
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
    if (t == _i30.OidcAccount) {
      return _i30.OidcAccount.fromJson(data) as T;
    }
    if (t == _i31.OidcClientConfig) {
      return _i31.OidcClientConfig.fromJson(data) as T;
    }
    if (t == _i32.Competency) {
      return _i32.Competency.fromJson(data) as T;
    }
    if (t == _i33.Course) {
      return _i33.Course.fromJson(data) as T;
    }
    if (t == _i34.CourseCompetency) {
      return _i34.CourseCompetency.fromJson(data) as T;
    }
    if (t == _i35.CourseReview) {
      return _i35.CourseReview.fromJson(data) as T;
    }
    if (t == _i36.CourseSopLink) {
      return _i36.CourseSopLink.fromJson(data) as T;
    }
    if (t == _i37.CourseVersion) {
      return _i37.CourseVersion.fromJson(data) as T;
    }
    if (t == _i38.Lesson) {
      return _i38.Lesson.fromJson(data) as T;
    }
    if (t == _i39.Module) {
      return _i39.Module.fromJson(data) as T;
    }
    if (t == _i40.QaValidationResult) {
      return _i40.QaValidationResult.fromJson(data) as T;
    }
    if (t == _i41.QaValidationRuleResult) {
      return _i41.QaValidationRuleResult.fromJson(data) as T;
    }
    if (t == _i42.UserCompetency) {
      return _i42.UserCompetency.fromJson(data) as T;
    }
    if (t == _i43.ApprovalWorkflow) {
      return _i43.ApprovalWorkflow.fromJson(data) as T;
    }
    if (t == _i44.Document) {
      return _i44.Document.fromJson(data) as T;
    }
    if (t == _i45.DocumentLifecycle) {
      return _i45.DocumentLifecycle.fromJson(data) as T;
    }
    if (t == _i46.DocumentVersion) {
      return _i46.DocumentVersion.fromJson(data) as T;
    }
    if (t == _i47.DeadLetterQueue) {
      return _i47.DeadLetterQueue.fromJson(data) as T;
    }
    if (t == _i48.DomainEvent) {
      return _i48.DomainEvent.fromJson(data) as T;
    }
    if (t == _i49.OutboxMessage) {
      return _i49.OutboxMessage.fromJson(data) as T;
    }
    if (t == _i50.Greeting) {
      return _i50.Greeting.fromJson(data) as T;
    }
    if (t == _i51.AuditIntegrityResult) {
      return _i51.AuditIntegrityResult.fromJson(data) as T;
    }
    if (t == _i52.FeatureFlag) {
      return _i52.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i53.RetentionArchive) {
      return _i53.RetentionArchive.fromJson(data) as T;
    }
    if (t == _i54.RetentionPolicy) {
      return _i54.RetentionPolicy.fromJson(data) as T;
    }
    if (t == _i55.ScheduledJobLog) {
      return _i55.ScheduledJobLog.fromJson(data) as T;
    }
    if (t == _i56.SystemConfiguration) {
      return _i56.SystemConfiguration.fromJson(data) as T;
    }
    if (t == _i57.Material) {
      return _i57.Material.fromJson(data) as T;
    }
    if (t == _i58.MaterialProgress) {
      return _i58.MaterialProgress.fromJson(data) as T;
    }
    if (t == _i59.MaterialVersion) {
      return _i59.MaterialVersion.fromJson(data) as T;
    }
    if (t == _i60.MediaAsset) {
      return _i60.MediaAsset.fromJson(data) as T;
    }
    if (t == _i61.MfaEnrollResult) {
      return _i61.MfaEnrollResult.fromJson(data) as T;
    }
    if (t == _i62.MfaStatusResult) {
      return _i62.MfaStatusResult.fromJson(data) as T;
    }
    if (t == _i63.MfaVerifiedSession) {
      return _i63.MfaVerifiedSession.fromJson(data) as T;
    }
    if (t == _i64.UserMfa) {
      return _i64.UserMfa.fromJson(data) as T;
    }
    if (t == _i65.InAppNotification) {
      return _i65.InAppNotification.fromJson(data) as T;
    }
    if (t == _i66.Notification) {
      return _i66.Notification.fromJson(data) as T;
    }
    if (t == _i67.NotificationLog) {
      return _i67.NotificationLog.fromJson(data) as T;
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
    if (t == _i75.UserPreference) {
      return _i75.UserPreference.fromJson(data) as T;
    }
    if (t == _i76.UserRole) {
      return _i76.UserRole.fromJson(data) as T;
    }
    if (t == _i77.Capa) {
      return _i77.Capa.fromJson(data) as T;
    }
    if (t == _i78.ChangeControl) {
      return _i78.ChangeControl.fromJson(data) as T;
    }
    if (t == _i79.InspectionReport) {
      return _i79.InspectionReport.fromJson(data) as T;
    }
    if (t == _i80.QualityEvent) {
      return _i80.QualityEvent.fromJson(data) as T;
    }
    if (t == _i81.AbacPolicy) {
      return _i81.AbacPolicy.fromJson(data) as T;
    }
    if (t == _i82.DelegatedAuthority) {
      return _i82.DelegatedAuthority.fromJson(data) as T;
    }
    if (t == _i83.ElectronicSignature) {
      return _i83.ElectronicSignature.fromJson(data) as T;
    }
    if (t == _i84.SignatureMeaning) {
      return _i84.SignatureMeaning.fromJson(data) as T;
    }
    if (t == _i85.SignatureVerificationResult) {
      return _i85.SignatureVerificationResult.fromJson(data) as T;
    }
    if (t == _i86.Certificate) {
      return _i86.Certificate.fromJson(data) as T;
    }
    if (t == _i87.Enrollment) {
      return _i87.Enrollment.fromJson(data) as T;
    }
    if (t == _i88.TrainingAssignment) {
      return _i88.TrainingAssignment.fromJson(data) as T;
    }
    if (t == _i89.TrainingExpiration) {
      return _i89.TrainingExpiration.fromJson(data) as T;
    }
    if (t == _i90.TrainingMatrix) {
      return _i90.TrainingMatrix.fromJson(data) as T;
    }
    if (t == _i91.TrainingRecord) {
      return _i91.TrainingRecord.fromJson(data) as T;
    }
    if (t == _i92.TrainingRecordAnnotation) {
      return _i92.TrainingRecordAnnotation.fromJson(data) as T;
    }
    if (t == _i93.TrainingWaiver) {
      return _i93.TrainingWaiver.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BulkImportResult?>()) {
      return (data != null ? _i2.BulkImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ImportLog?>()) {
      return (data != null ? _i3.ImportLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AnalyticsEvent?>()) {
      return (data != null ? _i4.AnalyticsEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AnalyticsSnapshot?>()) {
      return (data != null ? _i5.AnalyticsSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AuditReadinessScore?>()) {
      return (data != null ? _i6.AuditReadinessScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.ComplianceMetrics?>()) {
      return (data != null ? _i7.ComplianceMetrics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CourseAnalytics?>()) {
      return (data != null ? _i8.CourseAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Dashboard?>()) {
      return (data != null ? _i9.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.DepartmentComplianceSnapshot?>()) {
      return (data != null
              ? _i10.DepartmentComplianceSnapshot.fromJson(data)
              : null)
          as T;
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
    if (t == _i1.getType<_i30.OidcAccount?>()) {
      return (data != null ? _i30.OidcAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.OidcClientConfig?>()) {
      return (data != null ? _i31.OidcClientConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Competency?>()) {
      return (data != null ? _i32.Competency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Course?>()) {
      return (data != null ? _i33.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.CourseCompetency?>()) {
      return (data != null ? _i34.CourseCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.CourseReview?>()) {
      return (data != null ? _i35.CourseReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CourseSopLink?>()) {
      return (data != null ? _i36.CourseSopLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CourseVersion?>()) {
      return (data != null ? _i37.CourseVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Lesson?>()) {
      return (data != null ? _i38.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.Module?>()) {
      return (data != null ? _i39.Module.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.QaValidationResult?>()) {
      return (data != null ? _i40.QaValidationResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.QaValidationRuleResult?>()) {
      return (data != null ? _i41.QaValidationRuleResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.UserCompetency?>()) {
      return (data != null ? _i42.UserCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.ApprovalWorkflow?>()) {
      return (data != null ? _i43.ApprovalWorkflow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.Document?>()) {
      return (data != null ? _i44.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.DocumentLifecycle?>()) {
      return (data != null ? _i45.DocumentLifecycle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.DocumentVersion?>()) {
      return (data != null ? _i46.DocumentVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.DeadLetterQueue?>()) {
      return (data != null ? _i47.DeadLetterQueue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.DomainEvent?>()) {
      return (data != null ? _i48.DomainEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.OutboxMessage?>()) {
      return (data != null ? _i49.OutboxMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.Greeting?>()) {
      return (data != null ? _i50.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.AuditIntegrityResult?>()) {
      return (data != null ? _i51.AuditIntegrityResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.FeatureFlag?>()) {
      return (data != null ? _i52.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.RetentionArchive?>()) {
      return (data != null ? _i53.RetentionArchive.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.RetentionPolicy?>()) {
      return (data != null ? _i54.RetentionPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.ScheduledJobLog?>()) {
      return (data != null ? _i55.ScheduledJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SystemConfiguration?>()) {
      return (data != null ? _i56.SystemConfiguration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.Material?>()) {
      return (data != null ? _i57.Material.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.MaterialProgress?>()) {
      return (data != null ? _i58.MaterialProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.MaterialVersion?>()) {
      return (data != null ? _i59.MaterialVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.MediaAsset?>()) {
      return (data != null ? _i60.MediaAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.MfaEnrollResult?>()) {
      return (data != null ? _i61.MfaEnrollResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.MfaStatusResult?>()) {
      return (data != null ? _i62.MfaStatusResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.MfaVerifiedSession?>()) {
      return (data != null ? _i63.MfaVerifiedSession.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.UserMfa?>()) {
      return (data != null ? _i64.UserMfa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.InAppNotification?>()) {
      return (data != null ? _i65.InAppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.Notification?>()) {
      return (data != null ? _i66.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.NotificationLog?>()) {
      return (data != null ? _i67.NotificationLog.fromJson(data) : null) as T;
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
    if (t == _i1.getType<_i75.UserPreference?>()) {
      return (data != null ? _i75.UserPreference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.UserRole?>()) {
      return (data != null ? _i76.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.Capa?>()) {
      return (data != null ? _i77.Capa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.ChangeControl?>()) {
      return (data != null ? _i78.ChangeControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.InspectionReport?>()) {
      return (data != null ? _i79.InspectionReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.QualityEvent?>()) {
      return (data != null ? _i80.QualityEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.AbacPolicy?>()) {
      return (data != null ? _i81.AbacPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.DelegatedAuthority?>()) {
      return (data != null ? _i82.DelegatedAuthority.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i83.ElectronicSignature?>()) {
      return (data != null ? _i83.ElectronicSignature.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i84.SignatureMeaning?>()) {
      return (data != null ? _i84.SignatureMeaning.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.SignatureVerificationResult?>()) {
      return (data != null
              ? _i85.SignatureVerificationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i86.Certificate?>()) {
      return (data != null ? _i86.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.Enrollment?>()) {
      return (data != null ? _i87.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.TrainingAssignment?>()) {
      return (data != null ? _i88.TrainingAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i89.TrainingExpiration?>()) {
      return (data != null ? _i89.TrainingExpiration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i90.TrainingMatrix?>()) {
      return (data != null ? _i90.TrainingMatrix.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.TrainingRecord?>()) {
      return (data != null ? _i91.TrainingRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.TrainingRecordAnnotation?>()) {
      return (data != null
              ? _i92.TrainingRecordAnnotation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i93.TrainingWaiver?>()) {
      return (data != null ? _i93.TrainingWaiver.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i41.QaValidationRuleResult>) {
      return (data as List)
              .map((e) => deserialize<_i41.QaValidationRuleResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.SignatureMeaning>) {
      return (data as List)
              .map((e) => deserialize<_i94.SignatureMeaning>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.TrainingAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i95.TrainingAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i96.TrainingWaiver>) {
      return (data as List)
              .map((e) => deserialize<_i96.TrainingWaiver>(e))
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
    if (t == List<_i97.DepartmentComplianceSummary>) {
      return (data as List)
              .map((e) => deserialize<_i97.DepartmentComplianceSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.ReportDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i98.ReportDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i99.Dashboard>) {
      return (data as List).map((e) => deserialize<_i99.Dashboard>(e)).toList()
          as T;
    }
    if (t == List<_i100.SlaBreach>) {
      return (data as List).map((e) => deserialize<_i100.SlaBreach>(e)).toList()
          as T;
    }
    if (t == List<_i101.PharmaUser>) {
      return (data as List)
              .map((e) => deserialize<_i101.PharmaUser>(e))
              .toList()
          as T;
    }
    if (t == Map<String, List<_i102.Certificate>>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<List<_i102.Certificate>>(v),
            ),
          )
          as T;
    }
    if (t == List<_i102.Certificate>) {
      return (data as List)
              .map((e) => deserialize<_i102.Certificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i103.Capa>) {
      return (data as List).map((e) => deserialize<_i103.Capa>(e)).toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == List<_i104.Question>) {
      return (data as List).map((e) => deserialize<_i104.Question>(e)).toList()
          as T;
    }
    if (t == List<_i105.QuestionBank>) {
      return (data as List)
              .map((e) => deserialize<_i105.QuestionBank>(e))
              .toList()
          as T;
    }
    if (t == List<_i106.AuditTrail>) {
      return (data as List)
              .map((e) => deserialize<_i106.AuditTrail>(e))
              .toList()
          as T;
    }
    if (t == List<_i107.AccessLog>) {
      return (data as List).map((e) => deserialize<_i107.AccessLog>(e)).toList()
          as T;
    }
    if (t == List<_i108.Course>) {
      return (data as List).map((e) => deserialize<_i108.Course>(e)).toList()
          as T;
    }
    if (t == List<_i109.CourseVersion>) {
      return (data as List)
              .map((e) => deserialize<_i109.CourseVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i110.Module>) {
      return (data as List).map((e) => deserialize<_i110.Module>(e)).toList()
          as T;
    }
    if (t == List<_i111.Lesson>) {
      return (data as List).map((e) => deserialize<_i111.Lesson>(e)).toList()
          as T;
    }
    if (t == List<_i112.Document>) {
      return (data as List).map((e) => deserialize<_i112.Document>(e)).toList()
          as T;
    }
    if (t == List<_i113.DocumentVersion>) {
      return (data as List)
              .map((e) => deserialize<_i113.DocumentVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.DocumentLifecycle>) {
      return (data as List)
              .map((e) => deserialize<_i114.DocumentLifecycle>(e))
              .toList()
          as T;
    }
    if (t == List<_i115.InspectionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i115.InspectionRecord>(e))
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
    if (t == List<_i116.AuditorPageLog>) {
      return (data as List)
              .map((e) => deserialize<_i116.AuditorPageLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i117.InspectionPackage>) {
      return (data as List)
              .map((e) => deserialize<_i117.InspectionPackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i118.MaterialVersion>) {
      return (data as List)
              .map((e) => deserialize<_i118.MaterialVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i119.Material>) {
      return (data as List).map((e) => deserialize<_i119.Material>(e)).toList()
          as T;
    }
    if (t == List<_i120.InAppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i120.InAppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i121.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i121.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i122.Site>) {
      return (data as List).map((e) => deserialize<_i122.Site>(e)).toList()
          as T;
    }
    if (t == List<_i123.Department>) {
      return (data as List)
              .map((e) => deserialize<_i123.Department>(e))
              .toList()
          as T;
    }
    if (t == List<_i124.JobRole>) {
      return (data as List).map((e) => deserialize<_i124.JobRole>(e)).toList()
          as T;
    }
    if (t == List<_i125.CourseReview>) {
      return (data as List)
              .map((e) => deserialize<_i125.CourseReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i126.QualityEvent>) {
      return (data as List)
              .map((e) => deserialize<_i126.QualityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i127.InspectionReport>) {
      return (data as List)
              .map((e) => deserialize<_i127.InspectionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i128.CourseSopLink>) {
      return (data as List)
              .map((e) => deserialize<_i128.CourseSopLink>(e))
              .toList()
          as T;
    }
    if (t == List<_i129.Enrollment>) {
      return (data as List)
              .map((e) => deserialize<_i129.Enrollment>(e))
              .toList()
          as T;
    }
    if (t == List<_i130.TrainingRecord>) {
      return (data as List)
              .map((e) => deserialize<_i130.TrainingRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i131.ElectronicSignature>) {
      return (data as List)
              .map((e) => deserialize<_i131.ElectronicSignature>(e))
              .toList()
          as T;
    }
    if (t == List<_i132.TrainingRecordAnnotation>) {
      return (data as List)
              .map((e) => deserialize<_i132.TrainingRecordAnnotation>(e))
              .toList()
          as T;
    }
    if (t == List<_i133.UserPreference>) {
      return (data as List)
              .map((e) => deserialize<_i133.UserPreference>(e))
              .toList()
          as T;
    }
    try {
      return _i134.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i135.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i136.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.BulkImportResult => 'BulkImportResult',
      _i3.ImportLog => 'ImportLog',
      _i4.AnalyticsEvent => 'AnalyticsEvent',
      _i5.AnalyticsSnapshot => 'AnalyticsSnapshot',
      _i6.AuditReadinessScore => 'AuditReadinessScore',
      _i7.ComplianceMetrics => 'ComplianceMetrics',
      _i8.CourseAnalytics => 'CourseAnalytics',
      _i9.Dashboard => 'Dashboard',
      _i10.DepartmentComplianceSnapshot => 'DepartmentComplianceSnapshot',
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
      _i30.OidcAccount => 'OidcAccount',
      _i31.OidcClientConfig => 'OidcClientConfig',
      _i32.Competency => 'Competency',
      _i33.Course => 'Course',
      _i34.CourseCompetency => 'CourseCompetency',
      _i35.CourseReview => 'CourseReview',
      _i36.CourseSopLink => 'CourseSopLink',
      _i37.CourseVersion => 'CourseVersion',
      _i38.Lesson => 'Lesson',
      _i39.Module => 'Module',
      _i40.QaValidationResult => 'QaValidationResult',
      _i41.QaValidationRuleResult => 'QaValidationRuleResult',
      _i42.UserCompetency => 'UserCompetency',
      _i43.ApprovalWorkflow => 'ApprovalWorkflow',
      _i44.Document => 'Document',
      _i45.DocumentLifecycle => 'DocumentLifecycle',
      _i46.DocumentVersion => 'DocumentVersion',
      _i47.DeadLetterQueue => 'DeadLetterQueue',
      _i48.DomainEvent => 'DomainEvent',
      _i49.OutboxMessage => 'OutboxMessage',
      _i50.Greeting => 'Greeting',
      _i51.AuditIntegrityResult => 'AuditIntegrityResult',
      _i52.FeatureFlag => 'FeatureFlag',
      _i53.RetentionArchive => 'RetentionArchive',
      _i54.RetentionPolicy => 'RetentionPolicy',
      _i55.ScheduledJobLog => 'ScheduledJobLog',
      _i56.SystemConfiguration => 'SystemConfiguration',
      _i57.Material => 'Material',
      _i58.MaterialProgress => 'MaterialProgress',
      _i59.MaterialVersion => 'MaterialVersion',
      _i60.MediaAsset => 'MediaAsset',
      _i61.MfaEnrollResult => 'MfaEnrollResult',
      _i62.MfaStatusResult => 'MfaStatusResult',
      _i63.MfaVerifiedSession => 'MfaVerifiedSession',
      _i64.UserMfa => 'UserMfa',
      _i65.InAppNotification => 'InAppNotification',
      _i66.Notification => 'Notification',
      _i67.NotificationLog => 'NotificationLog',
      _i68.Department => 'Department',
      _i69.JobRole => 'JobRole',
      _i70.Organization => 'Organization',
      _i71.Permission => 'Permission',
      _i72.Role => 'Role',
      _i73.Site => 'Site',
      _i74.PharmaUser => 'PharmaUser',
      _i75.UserPreference => 'UserPreference',
      _i76.UserRole => 'UserRole',
      _i77.Capa => 'Capa',
      _i78.ChangeControl => 'ChangeControl',
      _i79.InspectionReport => 'InspectionReport',
      _i80.QualityEvent => 'QualityEvent',
      _i81.AbacPolicy => 'AbacPolicy',
      _i82.DelegatedAuthority => 'DelegatedAuthority',
      _i83.ElectronicSignature => 'ElectronicSignature',
      _i84.SignatureMeaning => 'SignatureMeaning',
      _i85.SignatureVerificationResult => 'SignatureVerificationResult',
      _i86.Certificate => 'Certificate',
      _i87.Enrollment => 'Enrollment',
      _i88.TrainingAssignment => 'TrainingAssignment',
      _i89.TrainingExpiration => 'TrainingExpiration',
      _i90.TrainingMatrix => 'TrainingMatrix',
      _i91.TrainingRecord => 'TrainingRecord',
      _i92.TrainingRecordAnnotation => 'TrainingRecordAnnotation',
      _i93.TrainingWaiver => 'TrainingWaiver',
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
      case _i3.ImportLog():
        return 'ImportLog';
      case _i4.AnalyticsEvent():
        return 'AnalyticsEvent';
      case _i5.AnalyticsSnapshot():
        return 'AnalyticsSnapshot';
      case _i6.AuditReadinessScore():
        return 'AuditReadinessScore';
      case _i7.ComplianceMetrics():
        return 'ComplianceMetrics';
      case _i8.CourseAnalytics():
        return 'CourseAnalytics';
      case _i9.Dashboard():
        return 'Dashboard';
      case _i10.DepartmentComplianceSnapshot():
        return 'DepartmentComplianceSnapshot';
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
      case _i30.OidcAccount():
        return 'OidcAccount';
      case _i31.OidcClientConfig():
        return 'OidcClientConfig';
      case _i32.Competency():
        return 'Competency';
      case _i33.Course():
        return 'Course';
      case _i34.CourseCompetency():
        return 'CourseCompetency';
      case _i35.CourseReview():
        return 'CourseReview';
      case _i36.CourseSopLink():
        return 'CourseSopLink';
      case _i37.CourseVersion():
        return 'CourseVersion';
      case _i38.Lesson():
        return 'Lesson';
      case _i39.Module():
        return 'Module';
      case _i40.QaValidationResult():
        return 'QaValidationResult';
      case _i41.QaValidationRuleResult():
        return 'QaValidationRuleResult';
      case _i42.UserCompetency():
        return 'UserCompetency';
      case _i43.ApprovalWorkflow():
        return 'ApprovalWorkflow';
      case _i44.Document():
        return 'Document';
      case _i45.DocumentLifecycle():
        return 'DocumentLifecycle';
      case _i46.DocumentVersion():
        return 'DocumentVersion';
      case _i47.DeadLetterQueue():
        return 'DeadLetterQueue';
      case _i48.DomainEvent():
        return 'DomainEvent';
      case _i49.OutboxMessage():
        return 'OutboxMessage';
      case _i50.Greeting():
        return 'Greeting';
      case _i51.AuditIntegrityResult():
        return 'AuditIntegrityResult';
      case _i52.FeatureFlag():
        return 'FeatureFlag';
      case _i53.RetentionArchive():
        return 'RetentionArchive';
      case _i54.RetentionPolicy():
        return 'RetentionPolicy';
      case _i55.ScheduledJobLog():
        return 'ScheduledJobLog';
      case _i56.SystemConfiguration():
        return 'SystemConfiguration';
      case _i57.Material():
        return 'Material';
      case _i58.MaterialProgress():
        return 'MaterialProgress';
      case _i59.MaterialVersion():
        return 'MaterialVersion';
      case _i60.MediaAsset():
        return 'MediaAsset';
      case _i61.MfaEnrollResult():
        return 'MfaEnrollResult';
      case _i62.MfaStatusResult():
        return 'MfaStatusResult';
      case _i63.MfaVerifiedSession():
        return 'MfaVerifiedSession';
      case _i64.UserMfa():
        return 'UserMfa';
      case _i65.InAppNotification():
        return 'InAppNotification';
      case _i66.Notification():
        return 'Notification';
      case _i67.NotificationLog():
        return 'NotificationLog';
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
      case _i75.UserPreference():
        return 'UserPreference';
      case _i76.UserRole():
        return 'UserRole';
      case _i77.Capa():
        return 'Capa';
      case _i78.ChangeControl():
        return 'ChangeControl';
      case _i79.InspectionReport():
        return 'InspectionReport';
      case _i80.QualityEvent():
        return 'QualityEvent';
      case _i81.AbacPolicy():
        return 'AbacPolicy';
      case _i82.DelegatedAuthority():
        return 'DelegatedAuthority';
      case _i83.ElectronicSignature():
        return 'ElectronicSignature';
      case _i84.SignatureMeaning():
        return 'SignatureMeaning';
      case _i85.SignatureVerificationResult():
        return 'SignatureVerificationResult';
      case _i86.Certificate():
        return 'Certificate';
      case _i87.Enrollment():
        return 'Enrollment';
      case _i88.TrainingAssignment():
        return 'TrainingAssignment';
      case _i89.TrainingExpiration():
        return 'TrainingExpiration';
      case _i90.TrainingMatrix():
        return 'TrainingMatrix';
      case _i91.TrainingRecord():
        return 'TrainingRecord';
      case _i92.TrainingRecordAnnotation():
        return 'TrainingRecordAnnotation';
      case _i93.TrainingWaiver():
        return 'TrainingWaiver';
    }
    className = _i134.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i135.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i136.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.BulkImportResult>(data['data']);
    }
    if (dataClassName == 'ImportLog') {
      return deserialize<_i3.ImportLog>(data['data']);
    }
    if (dataClassName == 'AnalyticsEvent') {
      return deserialize<_i4.AnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'AnalyticsSnapshot') {
      return deserialize<_i5.AnalyticsSnapshot>(data['data']);
    }
    if (dataClassName == 'AuditReadinessScore') {
      return deserialize<_i6.AuditReadinessScore>(data['data']);
    }
    if (dataClassName == 'ComplianceMetrics') {
      return deserialize<_i7.ComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'CourseAnalytics') {
      return deserialize<_i8.CourseAnalytics>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_i9.Dashboard>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSnapshot') {
      return deserialize<_i10.DepartmentComplianceSnapshot>(data['data']);
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
    if (dataClassName == 'OidcAccount') {
      return deserialize<_i30.OidcAccount>(data['data']);
    }
    if (dataClassName == 'OidcClientConfig') {
      return deserialize<_i31.OidcClientConfig>(data['data']);
    }
    if (dataClassName == 'Competency') {
      return deserialize<_i32.Competency>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i33.Course>(data['data']);
    }
    if (dataClassName == 'CourseCompetency') {
      return deserialize<_i34.CourseCompetency>(data['data']);
    }
    if (dataClassName == 'CourseReview') {
      return deserialize<_i35.CourseReview>(data['data']);
    }
    if (dataClassName == 'CourseSopLink') {
      return deserialize<_i36.CourseSopLink>(data['data']);
    }
    if (dataClassName == 'CourseVersion') {
      return deserialize<_i37.CourseVersion>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i38.Lesson>(data['data']);
    }
    if (dataClassName == 'Module') {
      return deserialize<_i39.Module>(data['data']);
    }
    if (dataClassName == 'QaValidationResult') {
      return deserialize<_i40.QaValidationResult>(data['data']);
    }
    if (dataClassName == 'QaValidationRuleResult') {
      return deserialize<_i41.QaValidationRuleResult>(data['data']);
    }
    if (dataClassName == 'UserCompetency') {
      return deserialize<_i42.UserCompetency>(data['data']);
    }
    if (dataClassName == 'ApprovalWorkflow') {
      return deserialize<_i43.ApprovalWorkflow>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i44.Document>(data['data']);
    }
    if (dataClassName == 'DocumentLifecycle') {
      return deserialize<_i45.DocumentLifecycle>(data['data']);
    }
    if (dataClassName == 'DocumentVersion') {
      return deserialize<_i46.DocumentVersion>(data['data']);
    }
    if (dataClassName == 'DeadLetterQueue') {
      return deserialize<_i47.DeadLetterQueue>(data['data']);
    }
    if (dataClassName == 'DomainEvent') {
      return deserialize<_i48.DomainEvent>(data['data']);
    }
    if (dataClassName == 'OutboxMessage') {
      return deserialize<_i49.OutboxMessage>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i50.Greeting>(data['data']);
    }
    if (dataClassName == 'AuditIntegrityResult') {
      return deserialize<_i51.AuditIntegrityResult>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i52.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'RetentionArchive') {
      return deserialize<_i53.RetentionArchive>(data['data']);
    }
    if (dataClassName == 'RetentionPolicy') {
      return deserialize<_i54.RetentionPolicy>(data['data']);
    }
    if (dataClassName == 'ScheduledJobLog') {
      return deserialize<_i55.ScheduledJobLog>(data['data']);
    }
    if (dataClassName == 'SystemConfiguration') {
      return deserialize<_i56.SystemConfiguration>(data['data']);
    }
    if (dataClassName == 'Material') {
      return deserialize<_i57.Material>(data['data']);
    }
    if (dataClassName == 'MaterialProgress') {
      return deserialize<_i58.MaterialProgress>(data['data']);
    }
    if (dataClassName == 'MaterialVersion') {
      return deserialize<_i59.MaterialVersion>(data['data']);
    }
    if (dataClassName == 'MediaAsset') {
      return deserialize<_i60.MediaAsset>(data['data']);
    }
    if (dataClassName == 'MfaEnrollResult') {
      return deserialize<_i61.MfaEnrollResult>(data['data']);
    }
    if (dataClassName == 'MfaStatusResult') {
      return deserialize<_i62.MfaStatusResult>(data['data']);
    }
    if (dataClassName == 'MfaVerifiedSession') {
      return deserialize<_i63.MfaVerifiedSession>(data['data']);
    }
    if (dataClassName == 'UserMfa') {
      return deserialize<_i64.UserMfa>(data['data']);
    }
    if (dataClassName == 'InAppNotification') {
      return deserialize<_i65.InAppNotification>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i66.Notification>(data['data']);
    }
    if (dataClassName == 'NotificationLog') {
      return deserialize<_i67.NotificationLog>(data['data']);
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
    if (dataClassName == 'UserPreference') {
      return deserialize<_i75.UserPreference>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i76.UserRole>(data['data']);
    }
    if (dataClassName == 'Capa') {
      return deserialize<_i77.Capa>(data['data']);
    }
    if (dataClassName == 'ChangeControl') {
      return deserialize<_i78.ChangeControl>(data['data']);
    }
    if (dataClassName == 'InspectionReport') {
      return deserialize<_i79.InspectionReport>(data['data']);
    }
    if (dataClassName == 'QualityEvent') {
      return deserialize<_i80.QualityEvent>(data['data']);
    }
    if (dataClassName == 'AbacPolicy') {
      return deserialize<_i81.AbacPolicy>(data['data']);
    }
    if (dataClassName == 'DelegatedAuthority') {
      return deserialize<_i82.DelegatedAuthority>(data['data']);
    }
    if (dataClassName == 'ElectronicSignature') {
      return deserialize<_i83.ElectronicSignature>(data['data']);
    }
    if (dataClassName == 'SignatureMeaning') {
      return deserialize<_i84.SignatureMeaning>(data['data']);
    }
    if (dataClassName == 'SignatureVerificationResult') {
      return deserialize<_i85.SignatureVerificationResult>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i86.Certificate>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i87.Enrollment>(data['data']);
    }
    if (dataClassName == 'TrainingAssignment') {
      return deserialize<_i88.TrainingAssignment>(data['data']);
    }
    if (dataClassName == 'TrainingExpiration') {
      return deserialize<_i89.TrainingExpiration>(data['data']);
    }
    if (dataClassName == 'TrainingMatrix') {
      return deserialize<_i90.TrainingMatrix>(data['data']);
    }
    if (dataClassName == 'TrainingRecord') {
      return deserialize<_i91.TrainingRecord>(data['data']);
    }
    if (dataClassName == 'TrainingRecordAnnotation') {
      return deserialize<_i92.TrainingRecordAnnotation>(data['data']);
    }
    if (dataClassName == 'TrainingWaiver') {
      return deserialize<_i93.TrainingWaiver>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i134.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i135.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i136.Protocol().deserializeByClassName(data);
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
      return _i134.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i135.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i136.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
