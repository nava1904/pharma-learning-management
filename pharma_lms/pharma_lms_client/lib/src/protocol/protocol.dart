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
import 'analytics/audit_readiness_score.dart' as _i4;
import 'analytics/compliance_metrics.dart' as _i5;
import 'analytics/course_analytics.dart' as _i6;
import 'analytics/dashboard.dart' as _i7;
import 'analytics/department_compliance_summary.dart' as _i8;
import 'analytics/report_definition.dart' as _i9;
import 'analytics/sla_breach.dart' as _i10;
import 'analytics/sla_policy.dart' as _i11;
import 'analytics/user_compliance_metrics.dart' as _i12;
import 'assessment/assessment.dart' as _i13;
import 'assessment/assessment_attempt.dart' as _i14;
import 'assessment/assessment_result.dart' as _i15;
import 'assessment/question.dart' as _i16;
import 'assessment/question_bank.dart' as _i17;
import 'audit/access_log.dart' as _i18;
import 'audit/audit_trail.dart' as _i19;
import 'audit/auditor_page_log.dart' as _i20;
import 'audit/auditor_session.dart' as _i21;
import 'audit/error_log.dart' as _i22;
import 'audit/inspection_package.dart' as _i23;
import 'audit/inspection_record.dart' as _i24;
import 'audit/report_export.dart' as _i25;
import 'audit/user_session.dart' as _i26;
import 'course/competency.dart' as _i27;
import 'course/course.dart' as _i28;
import 'course/course_competency.dart' as _i29;
import 'course/course_review.dart' as _i30;
import 'course/course_version.dart' as _i31;
import 'course/lesson.dart' as _i32;
import 'course/module.dart' as _i33;
import 'course/user_competency.dart' as _i34;
import 'document/approval_workflow.dart' as _i35;
import 'document/document.dart' as _i36;
import 'document/document_lifecycle.dart' as _i37;
import 'document/document_version.dart' as _i38;
import 'events/dead_letter_queue.dart' as _i39;
import 'events/domain_event.dart' as _i40;
import 'events/outbox_message.dart' as _i41;
import 'greetings/greeting.dart' as _i42;
import 'infrastructure/feature_flag.dart' as _i43;
import 'infrastructure/scheduled_job_log.dart' as _i44;
import 'infrastructure/system_configuration.dart' as _i45;
import 'material/material.dart' as _i46;
import 'material/material_progress.dart' as _i47;
import 'material/material_version.dart' as _i48;
import 'material/media_asset.dart' as _i49;
import 'notifications/in_app_notification.dart' as _i50;
import 'notifications/notification.dart' as _i51;
import 'organization/department.dart' as _i52;
import 'organization/job_role.dart' as _i53;
import 'organization/organization.dart' as _i54;
import 'organization/permission.dart' as _i55;
import 'organization/role.dart' as _i56;
import 'organization/site.dart' as _i57;
import 'organization/user.dart' as _i58;
import 'organization/user_role.dart' as _i59;
import 'quality/capa.dart' as _i60;
import 'quality/change_control.dart' as _i61;
import 'quality/inspection_report.dart' as _i62;
import 'quality/quality_event.dart' as _i63;
import 'security/abac_policy.dart' as _i64;
import 'security/delegated_authority.dart' as _i65;
import 'shared/electronic_signature.dart' as _i66;
import 'shared/signature_meaning.dart' as _i67;
import 'shared/signature_verification_result.dart' as _i68;
import 'training/certificate.dart' as _i69;
import 'training/enrollment.dart' as _i70;
import 'training/training_assignment.dart' as _i71;
import 'training/training_expiration.dart' as _i72;
import 'training/training_matrix.dart' as _i73;
import 'training/training_record.dart' as _i74;
import 'training/training_record_annotation.dart' as _i75;
import 'training/training_waiver.dart' as _i76;
import 'package:pharma_lms_client/src/protocol/shared/signature_meaning.dart'
    as _i77;
import 'package:pharma_lms_client/src/protocol/training/training_assignment.dart'
    as _i78;
import 'package:pharma_lms_client/src/protocol/training/training_waiver.dart'
    as _i79;
import 'package:pharma_lms_client/src/protocol/analytics/department_compliance_summary.dart'
    as _i80;
import 'package:pharma_lms_client/src/protocol/analytics/report_definition.dart'
    as _i81;
import 'package:pharma_lms_client/src/protocol/analytics/dashboard.dart'
    as _i82;
import 'package:pharma_lms_client/src/protocol/analytics/sla_breach.dart'
    as _i83;
import 'package:pharma_lms_client/src/protocol/organization/user.dart' as _i84;
import 'package:pharma_lms_client/src/protocol/training/certificate.dart'
    as _i85;
import 'package:pharma_lms_client/src/protocol/quality/capa.dart' as _i86;
import 'package:pharma_lms_client/src/protocol/assessment/question.dart'
    as _i87;
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i88;
import 'package:pharma_lms_client/src/protocol/audit/audit_trail.dart' as _i89;
import 'package:pharma_lms_client/src/protocol/audit/access_log.dart' as _i90;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i91;
import 'package:pharma_lms_client/src/protocol/course/course_version.dart'
    as _i92;
import 'package:pharma_lms_client/src/protocol/course/module.dart' as _i93;
import 'package:pharma_lms_client/src/protocol/course/lesson.dart' as _i94;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i95;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i96;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i97;
import 'package:pharma_lms_client/src/protocol/audit/inspection_record.dart'
    as _i98;
import 'package:pharma_lms_client/src/protocol/audit/inspection_package.dart'
    as _i99;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i100;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i101;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i102;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i103;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i104;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i105;
import 'package:pharma_lms_client/src/protocol/organization/job_role.dart'
    as _i106;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i107;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i108;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i109;
import 'package:pharma_lms_client/src/protocol/training/training_record.dart'
    as _i110;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i111;
import 'package:pharma_lms_client/src/protocol/training/training_record_annotation.dart'
    as _i112;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i113;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i114;
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
    if (t == _i4.AuditReadinessScore) {
      return _i4.AuditReadinessScore.fromJson(data) as T;
    }
    if (t == _i5.ComplianceMetrics) {
      return _i5.ComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i6.CourseAnalytics) {
      return _i6.CourseAnalytics.fromJson(data) as T;
    }
    if (t == _i7.Dashboard) {
      return _i7.Dashboard.fromJson(data) as T;
    }
    if (t == _i8.DepartmentComplianceSummary) {
      return _i8.DepartmentComplianceSummary.fromJson(data) as T;
    }
    if (t == _i9.ReportDefinition) {
      return _i9.ReportDefinition.fromJson(data) as T;
    }
    if (t == _i10.SlaBreach) {
      return _i10.SlaBreach.fromJson(data) as T;
    }
    if (t == _i11.SlaPolicy) {
      return _i11.SlaPolicy.fromJson(data) as T;
    }
    if (t == _i12.UserComplianceMetrics) {
      return _i12.UserComplianceMetrics.fromJson(data) as T;
    }
    if (t == _i13.Assessment) {
      return _i13.Assessment.fromJson(data) as T;
    }
    if (t == _i14.AssessmentAttempt) {
      return _i14.AssessmentAttempt.fromJson(data) as T;
    }
    if (t == _i15.AssessmentResult) {
      return _i15.AssessmentResult.fromJson(data) as T;
    }
    if (t == _i16.Question) {
      return _i16.Question.fromJson(data) as T;
    }
    if (t == _i17.QuestionBank) {
      return _i17.QuestionBank.fromJson(data) as T;
    }
    if (t == _i18.AccessLog) {
      return _i18.AccessLog.fromJson(data) as T;
    }
    if (t == _i19.AuditTrail) {
      return _i19.AuditTrail.fromJson(data) as T;
    }
    if (t == _i20.AuditorPageLog) {
      return _i20.AuditorPageLog.fromJson(data) as T;
    }
    if (t == _i21.AuditorSession) {
      return _i21.AuditorSession.fromJson(data) as T;
    }
    if (t == _i22.ErrorLog) {
      return _i22.ErrorLog.fromJson(data) as T;
    }
    if (t == _i23.InspectionPackage) {
      return _i23.InspectionPackage.fromJson(data) as T;
    }
    if (t == _i24.InspectionRecord) {
      return _i24.InspectionRecord.fromJson(data) as T;
    }
    if (t == _i25.ReportExport) {
      return _i25.ReportExport.fromJson(data) as T;
    }
    if (t == _i26.UserSession) {
      return _i26.UserSession.fromJson(data) as T;
    }
    if (t == _i27.Competency) {
      return _i27.Competency.fromJson(data) as T;
    }
    if (t == _i28.Course) {
      return _i28.Course.fromJson(data) as T;
    }
    if (t == _i29.CourseCompetency) {
      return _i29.CourseCompetency.fromJson(data) as T;
    }
    if (t == _i30.CourseReview) {
      return _i30.CourseReview.fromJson(data) as T;
    }
    if (t == _i31.CourseVersion) {
      return _i31.CourseVersion.fromJson(data) as T;
    }
    if (t == _i32.Lesson) {
      return _i32.Lesson.fromJson(data) as T;
    }
    if (t == _i33.Module) {
      return _i33.Module.fromJson(data) as T;
    }
    if (t == _i34.UserCompetency) {
      return _i34.UserCompetency.fromJson(data) as T;
    }
    if (t == _i35.ApprovalWorkflow) {
      return _i35.ApprovalWorkflow.fromJson(data) as T;
    }
    if (t == _i36.Document) {
      return _i36.Document.fromJson(data) as T;
    }
    if (t == _i37.DocumentLifecycle) {
      return _i37.DocumentLifecycle.fromJson(data) as T;
    }
    if (t == _i38.DocumentVersion) {
      return _i38.DocumentVersion.fromJson(data) as T;
    }
    if (t == _i39.DeadLetterQueue) {
      return _i39.DeadLetterQueue.fromJson(data) as T;
    }
    if (t == _i40.DomainEvent) {
      return _i40.DomainEvent.fromJson(data) as T;
    }
    if (t == _i41.OutboxMessage) {
      return _i41.OutboxMessage.fromJson(data) as T;
    }
    if (t == _i42.Greeting) {
      return _i42.Greeting.fromJson(data) as T;
    }
    if (t == _i43.FeatureFlag) {
      return _i43.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i44.ScheduledJobLog) {
      return _i44.ScheduledJobLog.fromJson(data) as T;
    }
    if (t == _i45.SystemConfiguration) {
      return _i45.SystemConfiguration.fromJson(data) as T;
    }
    if (t == _i46.Material) {
      return _i46.Material.fromJson(data) as T;
    }
    if (t == _i47.MaterialProgress) {
      return _i47.MaterialProgress.fromJson(data) as T;
    }
    if (t == _i48.MaterialVersion) {
      return _i48.MaterialVersion.fromJson(data) as T;
    }
    if (t == _i49.MediaAsset) {
      return _i49.MediaAsset.fromJson(data) as T;
    }
    if (t == _i50.InAppNotification) {
      return _i50.InAppNotification.fromJson(data) as T;
    }
    if (t == _i51.Notification) {
      return _i51.Notification.fromJson(data) as T;
    }
    if (t == _i52.Department) {
      return _i52.Department.fromJson(data) as T;
    }
    if (t == _i53.JobRole) {
      return _i53.JobRole.fromJson(data) as T;
    }
    if (t == _i54.Organization) {
      return _i54.Organization.fromJson(data) as T;
    }
    if (t == _i55.Permission) {
      return _i55.Permission.fromJson(data) as T;
    }
    if (t == _i56.Role) {
      return _i56.Role.fromJson(data) as T;
    }
    if (t == _i57.Site) {
      return _i57.Site.fromJson(data) as T;
    }
    if (t == _i58.PharmaUser) {
      return _i58.PharmaUser.fromJson(data) as T;
    }
    if (t == _i59.UserRole) {
      return _i59.UserRole.fromJson(data) as T;
    }
    if (t == _i60.Capa) {
      return _i60.Capa.fromJson(data) as T;
    }
    if (t == _i61.ChangeControl) {
      return _i61.ChangeControl.fromJson(data) as T;
    }
    if (t == _i62.InspectionReport) {
      return _i62.InspectionReport.fromJson(data) as T;
    }
    if (t == _i63.QualityEvent) {
      return _i63.QualityEvent.fromJson(data) as T;
    }
    if (t == _i64.AbacPolicy) {
      return _i64.AbacPolicy.fromJson(data) as T;
    }
    if (t == _i65.DelegatedAuthority) {
      return _i65.DelegatedAuthority.fromJson(data) as T;
    }
    if (t == _i66.ElectronicSignature) {
      return _i66.ElectronicSignature.fromJson(data) as T;
    }
    if (t == _i67.SignatureMeaning) {
      return _i67.SignatureMeaning.fromJson(data) as T;
    }
    if (t == _i68.SignatureVerificationResult) {
      return _i68.SignatureVerificationResult.fromJson(data) as T;
    }
    if (t == _i69.Certificate) {
      return _i69.Certificate.fromJson(data) as T;
    }
    if (t == _i70.Enrollment) {
      return _i70.Enrollment.fromJson(data) as T;
    }
    if (t == _i71.TrainingAssignment) {
      return _i71.TrainingAssignment.fromJson(data) as T;
    }
    if (t == _i72.TrainingExpiration) {
      return _i72.TrainingExpiration.fromJson(data) as T;
    }
    if (t == _i73.TrainingMatrix) {
      return _i73.TrainingMatrix.fromJson(data) as T;
    }
    if (t == _i74.TrainingRecord) {
      return _i74.TrainingRecord.fromJson(data) as T;
    }
    if (t == _i75.TrainingRecordAnnotation) {
      return _i75.TrainingRecordAnnotation.fromJson(data) as T;
    }
    if (t == _i76.TrainingWaiver) {
      return _i76.TrainingWaiver.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BulkImportResult?>()) {
      return (data != null ? _i2.BulkImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ImportLog?>()) {
      return (data != null ? _i3.ImportLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AuditReadinessScore?>()) {
      return (data != null ? _i4.AuditReadinessScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.ComplianceMetrics?>()) {
      return (data != null ? _i5.ComplianceMetrics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CourseAnalytics?>()) {
      return (data != null ? _i6.CourseAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Dashboard?>()) {
      return (data != null ? _i7.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DepartmentComplianceSummary?>()) {
      return (data != null
              ? _i8.DepartmentComplianceSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.ReportDefinition?>()) {
      return (data != null ? _i9.ReportDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.SlaBreach?>()) {
      return (data != null ? _i10.SlaBreach.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.SlaPolicy?>()) {
      return (data != null ? _i11.SlaPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.UserComplianceMetrics?>()) {
      return (data != null ? _i12.UserComplianceMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.Assessment?>()) {
      return (data != null ? _i13.Assessment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.AssessmentAttempt?>()) {
      return (data != null ? _i14.AssessmentAttempt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AssessmentResult?>()) {
      return (data != null ? _i15.AssessmentResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Question?>()) {
      return (data != null ? _i16.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.QuestionBank?>()) {
      return (data != null ? _i17.QuestionBank.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AccessLog?>()) {
      return (data != null ? _i18.AccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AuditTrail?>()) {
      return (data != null ? _i19.AuditTrail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.AuditorPageLog?>()) {
      return (data != null ? _i20.AuditorPageLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.AuditorSession?>()) {
      return (data != null ? _i21.AuditorSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.ErrorLog?>()) {
      return (data != null ? _i22.ErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.InspectionPackage?>()) {
      return (data != null ? _i23.InspectionPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.InspectionRecord?>()) {
      return (data != null ? _i24.InspectionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ReportExport?>()) {
      return (data != null ? _i25.ReportExport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.UserSession?>()) {
      return (data != null ? _i26.UserSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Competency?>()) {
      return (data != null ? _i27.Competency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Course?>()) {
      return (data != null ? _i28.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CourseCompetency?>()) {
      return (data != null ? _i29.CourseCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CourseReview?>()) {
      return (data != null ? _i30.CourseReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CourseVersion?>()) {
      return (data != null ? _i31.CourseVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Lesson?>()) {
      return (data != null ? _i32.Lesson.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Module?>()) {
      return (data != null ? _i33.Module.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.UserCompetency?>()) {
      return (data != null ? _i34.UserCompetency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.ApprovalWorkflow?>()) {
      return (data != null ? _i35.ApprovalWorkflow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.Document?>()) {
      return (data != null ? _i36.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.DocumentLifecycle?>()) {
      return (data != null ? _i37.DocumentLifecycle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.DocumentVersion?>()) {
      return (data != null ? _i38.DocumentVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.DeadLetterQueue?>()) {
      return (data != null ? _i39.DeadLetterQueue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.DomainEvent?>()) {
      return (data != null ? _i40.DomainEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.OutboxMessage?>()) {
      return (data != null ? _i41.OutboxMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.Greeting?>()) {
      return (data != null ? _i42.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.FeatureFlag?>()) {
      return (data != null ? _i43.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.ScheduledJobLog?>()) {
      return (data != null ? _i44.ScheduledJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SystemConfiguration?>()) {
      return (data != null ? _i45.SystemConfiguration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.Material?>()) {
      return (data != null ? _i46.Material.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.MaterialProgress?>()) {
      return (data != null ? _i47.MaterialProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.MaterialVersion?>()) {
      return (data != null ? _i48.MaterialVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.MediaAsset?>()) {
      return (data != null ? _i49.MediaAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.InAppNotification?>()) {
      return (data != null ? _i50.InAppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.Notification?>()) {
      return (data != null ? _i51.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.Department?>()) {
      return (data != null ? _i52.Department.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.JobRole?>()) {
      return (data != null ? _i53.JobRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.Organization?>()) {
      return (data != null ? _i54.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.Permission?>()) {
      return (data != null ? _i55.Permission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.Role?>()) {
      return (data != null ? _i56.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.Site?>()) {
      return (data != null ? _i57.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.PharmaUser?>()) {
      return (data != null ? _i58.PharmaUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.UserRole?>()) {
      return (data != null ? _i59.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.Capa?>()) {
      return (data != null ? _i60.Capa.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.ChangeControl?>()) {
      return (data != null ? _i61.ChangeControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.InspectionReport?>()) {
      return (data != null ? _i62.InspectionReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.QualityEvent?>()) {
      return (data != null ? _i63.QualityEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.AbacPolicy?>()) {
      return (data != null ? _i64.AbacPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.DelegatedAuthority?>()) {
      return (data != null ? _i65.DelegatedAuthority.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.ElectronicSignature?>()) {
      return (data != null ? _i66.ElectronicSignature.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i67.SignatureMeaning?>()) {
      return (data != null ? _i67.SignatureMeaning.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.SignatureVerificationResult?>()) {
      return (data != null
              ? _i68.SignatureVerificationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i69.Certificate?>()) {
      return (data != null ? _i69.Certificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.Enrollment?>()) {
      return (data != null ? _i70.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.TrainingAssignment?>()) {
      return (data != null ? _i71.TrainingAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i72.TrainingExpiration?>()) {
      return (data != null ? _i72.TrainingExpiration.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i73.TrainingMatrix?>()) {
      return (data != null ? _i73.TrainingMatrix.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.TrainingRecord?>()) {
      return (data != null ? _i74.TrainingRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.TrainingRecordAnnotation?>()) {
      return (data != null
              ? _i75.TrainingRecordAnnotation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i76.TrainingWaiver?>()) {
      return (data != null ? _i76.TrainingWaiver.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i77.SignatureMeaning>) {
      return (data as List)
              .map((e) => deserialize<_i77.SignatureMeaning>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.TrainingAssignment>) {
      return (data as List)
              .map((e) => deserialize<_i78.TrainingAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i79.TrainingWaiver>) {
      return (data as List)
              .map((e) => deserialize<_i79.TrainingWaiver>(e))
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
    if (t == List<_i80.DepartmentComplianceSummary>) {
      return (data as List)
              .map((e) => deserialize<_i80.DepartmentComplianceSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.ReportDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i81.ReportDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.Dashboard>) {
      return (data as List).map((e) => deserialize<_i82.Dashboard>(e)).toList()
          as T;
    }
    if (t == List<_i83.SlaBreach>) {
      return (data as List).map((e) => deserialize<_i83.SlaBreach>(e)).toList()
          as T;
    }
    if (t == List<_i84.PharmaUser>) {
      return (data as List).map((e) => deserialize<_i84.PharmaUser>(e)).toList()
          as T;
    }
    if (t == Map<String, List<_i85.Certificate>>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<List<_i85.Certificate>>(v),
            ),
          )
          as T;
    }
    if (t == List<_i85.Certificate>) {
      return (data as List)
              .map((e) => deserialize<_i85.Certificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.Capa>) {
      return (data as List).map((e) => deserialize<_i86.Capa>(e)).toList() as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.Question>) {
      return (data as List).map((e) => deserialize<_i87.Question>(e)).toList()
          as T;
    }
    if (t == List<_i88.QuestionBank>) {
      return (data as List)
              .map((e) => deserialize<_i88.QuestionBank>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.AuditTrail>) {
      return (data as List).map((e) => deserialize<_i89.AuditTrail>(e)).toList()
          as T;
    }
    if (t == List<_i90.AccessLog>) {
      return (data as List).map((e) => deserialize<_i90.AccessLog>(e)).toList()
          as T;
    }
    if (t == List<_i91.Course>) {
      return (data as List).map((e) => deserialize<_i91.Course>(e)).toList()
          as T;
    }
    if (t == List<_i92.CourseVersion>) {
      return (data as List)
              .map((e) => deserialize<_i92.CourseVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.Module>) {
      return (data as List).map((e) => deserialize<_i93.Module>(e)).toList()
          as T;
    }
    if (t == List<_i94.Lesson>) {
      return (data as List).map((e) => deserialize<_i94.Lesson>(e)).toList()
          as T;
    }
    if (t == List<_i95.Document>) {
      return (data as List).map((e) => deserialize<_i95.Document>(e)).toList()
          as T;
    }
    if (t == List<_i96.DocumentVersion>) {
      return (data as List)
              .map((e) => deserialize<_i96.DocumentVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i97.DocumentLifecycle>) {
      return (data as List)
              .map((e) => deserialize<_i97.DocumentLifecycle>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.InspectionRecord>) {
      return (data as List)
              .map((e) => deserialize<_i98.InspectionRecord>(e))
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
    if (t == List<_i99.InspectionPackage>) {
      return (data as List)
              .map((e) => deserialize<_i99.InspectionPackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i100.MaterialVersion>) {
      return (data as List)
              .map((e) => deserialize<_i100.MaterialVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i101.Material>) {
      return (data as List).map((e) => deserialize<_i101.Material>(e)).toList()
          as T;
    }
    if (t == List<_i102.InAppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i102.InAppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i103.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i103.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i104.Site>) {
      return (data as List).map((e) => deserialize<_i104.Site>(e)).toList()
          as T;
    }
    if (t == List<_i105.Department>) {
      return (data as List)
              .map((e) => deserialize<_i105.Department>(e))
              .toList()
          as T;
    }
    if (t == List<_i106.JobRole>) {
      return (data as List).map((e) => deserialize<_i106.JobRole>(e)).toList()
          as T;
    }
    if (t == List<_i107.QualityEvent>) {
      return (data as List)
              .map((e) => deserialize<_i107.QualityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i108.InspectionReport>) {
      return (data as List)
              .map((e) => deserialize<_i108.InspectionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_i109.Enrollment>) {
      return (data as List)
              .map((e) => deserialize<_i109.Enrollment>(e))
              .toList()
          as T;
    }
    if (t == List<_i110.TrainingRecord>) {
      return (data as List)
              .map((e) => deserialize<_i110.TrainingRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i111.ElectronicSignature>) {
      return (data as List)
              .map((e) => deserialize<_i111.ElectronicSignature>(e))
              .toList()
          as T;
    }
    if (t == List<_i112.TrainingRecordAnnotation>) {
      return (data as List)
              .map((e) => deserialize<_i112.TrainingRecordAnnotation>(e))
              .toList()
          as T;
    }
    try {
      return _i113.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i114.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.BulkImportResult => 'BulkImportResult',
      _i3.ImportLog => 'ImportLog',
      _i4.AuditReadinessScore => 'AuditReadinessScore',
      _i5.ComplianceMetrics => 'ComplianceMetrics',
      _i6.CourseAnalytics => 'CourseAnalytics',
      _i7.Dashboard => 'Dashboard',
      _i8.DepartmentComplianceSummary => 'DepartmentComplianceSummary',
      _i9.ReportDefinition => 'ReportDefinition',
      _i10.SlaBreach => 'SlaBreach',
      _i11.SlaPolicy => 'SlaPolicy',
      _i12.UserComplianceMetrics => 'UserComplianceMetrics',
      _i13.Assessment => 'Assessment',
      _i14.AssessmentAttempt => 'AssessmentAttempt',
      _i15.AssessmentResult => 'AssessmentResult',
      _i16.Question => 'Question',
      _i17.QuestionBank => 'QuestionBank',
      _i18.AccessLog => 'AccessLog',
      _i19.AuditTrail => 'AuditTrail',
      _i20.AuditorPageLog => 'AuditorPageLog',
      _i21.AuditorSession => 'AuditorSession',
      _i22.ErrorLog => 'ErrorLog',
      _i23.InspectionPackage => 'InspectionPackage',
      _i24.InspectionRecord => 'InspectionRecord',
      _i25.ReportExport => 'ReportExport',
      _i26.UserSession => 'UserSession',
      _i27.Competency => 'Competency',
      _i28.Course => 'Course',
      _i29.CourseCompetency => 'CourseCompetency',
      _i30.CourseReview => 'CourseReview',
      _i31.CourseVersion => 'CourseVersion',
      _i32.Lesson => 'Lesson',
      _i33.Module => 'Module',
      _i34.UserCompetency => 'UserCompetency',
      _i35.ApprovalWorkflow => 'ApprovalWorkflow',
      _i36.Document => 'Document',
      _i37.DocumentLifecycle => 'DocumentLifecycle',
      _i38.DocumentVersion => 'DocumentVersion',
      _i39.DeadLetterQueue => 'DeadLetterQueue',
      _i40.DomainEvent => 'DomainEvent',
      _i41.OutboxMessage => 'OutboxMessage',
      _i42.Greeting => 'Greeting',
      _i43.FeatureFlag => 'FeatureFlag',
      _i44.ScheduledJobLog => 'ScheduledJobLog',
      _i45.SystemConfiguration => 'SystemConfiguration',
      _i46.Material => 'Material',
      _i47.MaterialProgress => 'MaterialProgress',
      _i48.MaterialVersion => 'MaterialVersion',
      _i49.MediaAsset => 'MediaAsset',
      _i50.InAppNotification => 'InAppNotification',
      _i51.Notification => 'Notification',
      _i52.Department => 'Department',
      _i53.JobRole => 'JobRole',
      _i54.Organization => 'Organization',
      _i55.Permission => 'Permission',
      _i56.Role => 'Role',
      _i57.Site => 'Site',
      _i58.PharmaUser => 'PharmaUser',
      _i59.UserRole => 'UserRole',
      _i60.Capa => 'Capa',
      _i61.ChangeControl => 'ChangeControl',
      _i62.InspectionReport => 'InspectionReport',
      _i63.QualityEvent => 'QualityEvent',
      _i64.AbacPolicy => 'AbacPolicy',
      _i65.DelegatedAuthority => 'DelegatedAuthority',
      _i66.ElectronicSignature => 'ElectronicSignature',
      _i67.SignatureMeaning => 'SignatureMeaning',
      _i68.SignatureVerificationResult => 'SignatureVerificationResult',
      _i69.Certificate => 'Certificate',
      _i70.Enrollment => 'Enrollment',
      _i71.TrainingAssignment => 'TrainingAssignment',
      _i72.TrainingExpiration => 'TrainingExpiration',
      _i73.TrainingMatrix => 'TrainingMatrix',
      _i74.TrainingRecord => 'TrainingRecord',
      _i75.TrainingRecordAnnotation => 'TrainingRecordAnnotation',
      _i76.TrainingWaiver => 'TrainingWaiver',
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
      case _i4.AuditReadinessScore():
        return 'AuditReadinessScore';
      case _i5.ComplianceMetrics():
        return 'ComplianceMetrics';
      case _i6.CourseAnalytics():
        return 'CourseAnalytics';
      case _i7.Dashboard():
        return 'Dashboard';
      case _i8.DepartmentComplianceSummary():
        return 'DepartmentComplianceSummary';
      case _i9.ReportDefinition():
        return 'ReportDefinition';
      case _i10.SlaBreach():
        return 'SlaBreach';
      case _i11.SlaPolicy():
        return 'SlaPolicy';
      case _i12.UserComplianceMetrics():
        return 'UserComplianceMetrics';
      case _i13.Assessment():
        return 'Assessment';
      case _i14.AssessmentAttempt():
        return 'AssessmentAttempt';
      case _i15.AssessmentResult():
        return 'AssessmentResult';
      case _i16.Question():
        return 'Question';
      case _i17.QuestionBank():
        return 'QuestionBank';
      case _i18.AccessLog():
        return 'AccessLog';
      case _i19.AuditTrail():
        return 'AuditTrail';
      case _i20.AuditorPageLog():
        return 'AuditorPageLog';
      case _i21.AuditorSession():
        return 'AuditorSession';
      case _i22.ErrorLog():
        return 'ErrorLog';
      case _i23.InspectionPackage():
        return 'InspectionPackage';
      case _i24.InspectionRecord():
        return 'InspectionRecord';
      case _i25.ReportExport():
        return 'ReportExport';
      case _i26.UserSession():
        return 'UserSession';
      case _i27.Competency():
        return 'Competency';
      case _i28.Course():
        return 'Course';
      case _i29.CourseCompetency():
        return 'CourseCompetency';
      case _i30.CourseReview():
        return 'CourseReview';
      case _i31.CourseVersion():
        return 'CourseVersion';
      case _i32.Lesson():
        return 'Lesson';
      case _i33.Module():
        return 'Module';
      case _i34.UserCompetency():
        return 'UserCompetency';
      case _i35.ApprovalWorkflow():
        return 'ApprovalWorkflow';
      case _i36.Document():
        return 'Document';
      case _i37.DocumentLifecycle():
        return 'DocumentLifecycle';
      case _i38.DocumentVersion():
        return 'DocumentVersion';
      case _i39.DeadLetterQueue():
        return 'DeadLetterQueue';
      case _i40.DomainEvent():
        return 'DomainEvent';
      case _i41.OutboxMessage():
        return 'OutboxMessage';
      case _i42.Greeting():
        return 'Greeting';
      case _i43.FeatureFlag():
        return 'FeatureFlag';
      case _i44.ScheduledJobLog():
        return 'ScheduledJobLog';
      case _i45.SystemConfiguration():
        return 'SystemConfiguration';
      case _i46.Material():
        return 'Material';
      case _i47.MaterialProgress():
        return 'MaterialProgress';
      case _i48.MaterialVersion():
        return 'MaterialVersion';
      case _i49.MediaAsset():
        return 'MediaAsset';
      case _i50.InAppNotification():
        return 'InAppNotification';
      case _i51.Notification():
        return 'Notification';
      case _i52.Department():
        return 'Department';
      case _i53.JobRole():
        return 'JobRole';
      case _i54.Organization():
        return 'Organization';
      case _i55.Permission():
        return 'Permission';
      case _i56.Role():
        return 'Role';
      case _i57.Site():
        return 'Site';
      case _i58.PharmaUser():
        return 'PharmaUser';
      case _i59.UserRole():
        return 'UserRole';
      case _i60.Capa():
        return 'Capa';
      case _i61.ChangeControl():
        return 'ChangeControl';
      case _i62.InspectionReport():
        return 'InspectionReport';
      case _i63.QualityEvent():
        return 'QualityEvent';
      case _i64.AbacPolicy():
        return 'AbacPolicy';
      case _i65.DelegatedAuthority():
        return 'DelegatedAuthority';
      case _i66.ElectronicSignature():
        return 'ElectronicSignature';
      case _i67.SignatureMeaning():
        return 'SignatureMeaning';
      case _i68.SignatureVerificationResult():
        return 'SignatureVerificationResult';
      case _i69.Certificate():
        return 'Certificate';
      case _i70.Enrollment():
        return 'Enrollment';
      case _i71.TrainingAssignment():
        return 'TrainingAssignment';
      case _i72.TrainingExpiration():
        return 'TrainingExpiration';
      case _i73.TrainingMatrix():
        return 'TrainingMatrix';
      case _i74.TrainingRecord():
        return 'TrainingRecord';
      case _i75.TrainingRecordAnnotation():
        return 'TrainingRecordAnnotation';
      case _i76.TrainingWaiver():
        return 'TrainingWaiver';
    }
    className = _i113.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i114.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'ImportLog') {
      return deserialize<_i3.ImportLog>(data['data']);
    }
    if (dataClassName == 'AuditReadinessScore') {
      return deserialize<_i4.AuditReadinessScore>(data['data']);
    }
    if (dataClassName == 'ComplianceMetrics') {
      return deserialize<_i5.ComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'CourseAnalytics') {
      return deserialize<_i6.CourseAnalytics>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_i7.Dashboard>(data['data']);
    }
    if (dataClassName == 'DepartmentComplianceSummary') {
      return deserialize<_i8.DepartmentComplianceSummary>(data['data']);
    }
    if (dataClassName == 'ReportDefinition') {
      return deserialize<_i9.ReportDefinition>(data['data']);
    }
    if (dataClassName == 'SlaBreach') {
      return deserialize<_i10.SlaBreach>(data['data']);
    }
    if (dataClassName == 'SlaPolicy') {
      return deserialize<_i11.SlaPolicy>(data['data']);
    }
    if (dataClassName == 'UserComplianceMetrics') {
      return deserialize<_i12.UserComplianceMetrics>(data['data']);
    }
    if (dataClassName == 'Assessment') {
      return deserialize<_i13.Assessment>(data['data']);
    }
    if (dataClassName == 'AssessmentAttempt') {
      return deserialize<_i14.AssessmentAttempt>(data['data']);
    }
    if (dataClassName == 'AssessmentResult') {
      return deserialize<_i15.AssessmentResult>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i16.Question>(data['data']);
    }
    if (dataClassName == 'QuestionBank') {
      return deserialize<_i17.QuestionBank>(data['data']);
    }
    if (dataClassName == 'AccessLog') {
      return deserialize<_i18.AccessLog>(data['data']);
    }
    if (dataClassName == 'AuditTrail') {
      return deserialize<_i19.AuditTrail>(data['data']);
    }
    if (dataClassName == 'AuditorPageLog') {
      return deserialize<_i20.AuditorPageLog>(data['data']);
    }
    if (dataClassName == 'AuditorSession') {
      return deserialize<_i21.AuditorSession>(data['data']);
    }
    if (dataClassName == 'ErrorLog') {
      return deserialize<_i22.ErrorLog>(data['data']);
    }
    if (dataClassName == 'InspectionPackage') {
      return deserialize<_i23.InspectionPackage>(data['data']);
    }
    if (dataClassName == 'InspectionRecord') {
      return deserialize<_i24.InspectionRecord>(data['data']);
    }
    if (dataClassName == 'ReportExport') {
      return deserialize<_i25.ReportExport>(data['data']);
    }
    if (dataClassName == 'UserSession') {
      return deserialize<_i26.UserSession>(data['data']);
    }
    if (dataClassName == 'Competency') {
      return deserialize<_i27.Competency>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i28.Course>(data['data']);
    }
    if (dataClassName == 'CourseCompetency') {
      return deserialize<_i29.CourseCompetency>(data['data']);
    }
    if (dataClassName == 'CourseReview') {
      return deserialize<_i30.CourseReview>(data['data']);
    }
    if (dataClassName == 'CourseVersion') {
      return deserialize<_i31.CourseVersion>(data['data']);
    }
    if (dataClassName == 'Lesson') {
      return deserialize<_i32.Lesson>(data['data']);
    }
    if (dataClassName == 'Module') {
      return deserialize<_i33.Module>(data['data']);
    }
    if (dataClassName == 'UserCompetency') {
      return deserialize<_i34.UserCompetency>(data['data']);
    }
    if (dataClassName == 'ApprovalWorkflow') {
      return deserialize<_i35.ApprovalWorkflow>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i36.Document>(data['data']);
    }
    if (dataClassName == 'DocumentLifecycle') {
      return deserialize<_i37.DocumentLifecycle>(data['data']);
    }
    if (dataClassName == 'DocumentVersion') {
      return deserialize<_i38.DocumentVersion>(data['data']);
    }
    if (dataClassName == 'DeadLetterQueue') {
      return deserialize<_i39.DeadLetterQueue>(data['data']);
    }
    if (dataClassName == 'DomainEvent') {
      return deserialize<_i40.DomainEvent>(data['data']);
    }
    if (dataClassName == 'OutboxMessage') {
      return deserialize<_i41.OutboxMessage>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i42.Greeting>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i43.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'ScheduledJobLog') {
      return deserialize<_i44.ScheduledJobLog>(data['data']);
    }
    if (dataClassName == 'SystemConfiguration') {
      return deserialize<_i45.SystemConfiguration>(data['data']);
    }
    if (dataClassName == 'Material') {
      return deserialize<_i46.Material>(data['data']);
    }
    if (dataClassName == 'MaterialProgress') {
      return deserialize<_i47.MaterialProgress>(data['data']);
    }
    if (dataClassName == 'MaterialVersion') {
      return deserialize<_i48.MaterialVersion>(data['data']);
    }
    if (dataClassName == 'MediaAsset') {
      return deserialize<_i49.MediaAsset>(data['data']);
    }
    if (dataClassName == 'InAppNotification') {
      return deserialize<_i50.InAppNotification>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i51.Notification>(data['data']);
    }
    if (dataClassName == 'Department') {
      return deserialize<_i52.Department>(data['data']);
    }
    if (dataClassName == 'JobRole') {
      return deserialize<_i53.JobRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i54.Organization>(data['data']);
    }
    if (dataClassName == 'Permission') {
      return deserialize<_i55.Permission>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i56.Role>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i57.Site>(data['data']);
    }
    if (dataClassName == 'PharmaUser') {
      return deserialize<_i58.PharmaUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i59.UserRole>(data['data']);
    }
    if (dataClassName == 'Capa') {
      return deserialize<_i60.Capa>(data['data']);
    }
    if (dataClassName == 'ChangeControl') {
      return deserialize<_i61.ChangeControl>(data['data']);
    }
    if (dataClassName == 'InspectionReport') {
      return deserialize<_i62.InspectionReport>(data['data']);
    }
    if (dataClassName == 'QualityEvent') {
      return deserialize<_i63.QualityEvent>(data['data']);
    }
    if (dataClassName == 'AbacPolicy') {
      return deserialize<_i64.AbacPolicy>(data['data']);
    }
    if (dataClassName == 'DelegatedAuthority') {
      return deserialize<_i65.DelegatedAuthority>(data['data']);
    }
    if (dataClassName == 'ElectronicSignature') {
      return deserialize<_i66.ElectronicSignature>(data['data']);
    }
    if (dataClassName == 'SignatureMeaning') {
      return deserialize<_i67.SignatureMeaning>(data['data']);
    }
    if (dataClassName == 'SignatureVerificationResult') {
      return deserialize<_i68.SignatureVerificationResult>(data['data']);
    }
    if (dataClassName == 'Certificate') {
      return deserialize<_i69.Certificate>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i70.Enrollment>(data['data']);
    }
    if (dataClassName == 'TrainingAssignment') {
      return deserialize<_i71.TrainingAssignment>(data['data']);
    }
    if (dataClassName == 'TrainingExpiration') {
      return deserialize<_i72.TrainingExpiration>(data['data']);
    }
    if (dataClassName == 'TrainingMatrix') {
      return deserialize<_i73.TrainingMatrix>(data['data']);
    }
    if (dataClassName == 'TrainingRecord') {
      return deserialize<_i74.TrainingRecord>(data['data']);
    }
    if (dataClassName == 'TrainingRecordAnnotation') {
      return deserialize<_i75.TrainingRecordAnnotation>(data['data']);
    }
    if (dataClassName == 'TrainingWaiver') {
      return deserialize<_i76.TrainingWaiver>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i113.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i114.Protocol().deserializeByClassName(data);
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
      return _i113.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i114.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
