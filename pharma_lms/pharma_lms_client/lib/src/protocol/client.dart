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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:pharma_lms_client/src/protocol/training/training_assignment.dart'
    as _i5;
import 'package:pharma_lms_client/src/protocol/admin/bulk_import_result.dart'
    as _i6;
import 'package:pharma_lms_client/src/protocol/organization/job_role.dart'
    as _i7;
import 'package:pharma_lms_client/src/protocol/analytics/department_compliance_summary.dart'
    as _i8;
import 'package:pharma_lms_client/src/protocol/analytics/audit_readiness_score.dart'
    as _i9;
import 'package:pharma_lms_client/src/protocol/analytics/report_definition.dart'
    as _i10;
import 'package:pharma_lms_client/src/protocol/analytics/dashboard.dart'
    as _i11;
import 'package:pharma_lms_client/src/protocol/analytics/sla_breach.dart'
    as _i12;
import 'package:pharma_lms_client/src/protocol/assessment/question.dart'
    as _i13;
import 'package:pharma_lms_client/src/protocol/assessment/assessment.dart'
    as _i14;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_attempt.dart'
    as _i15;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_result.dart'
    as _i16;
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i17;
import 'package:pharma_lms_client/src/protocol/audit/audit_trail.dart' as _i18;
import 'package:pharma_lms_client/src/protocol/audit/access_log.dart' as _i19;
import 'package:pharma_lms_client/src/protocol/analytics/compliance_metrics.dart'
    as _i20;
import 'package:pharma_lms_client/src/protocol/analytics/user_compliance_metrics.dart'
    as _i21;
import 'package:pharma_lms_client/src/protocol/course/module.dart' as _i22;
import 'package:pharma_lms_client/src/protocol/course/lesson.dart' as _i23;
import 'package:pharma_lms_client/src/protocol/course/course_version.dart'
    as _i24;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i25;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i26;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i27;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i28;
import 'package:pharma_lms_client/src/protocol/document/approval_workflow.dart'
    as _i29;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i30;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i31;
import 'package:pharma_lms_client/src/protocol/material/material_progress.dart'
    as _i32;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i33;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i34;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i35;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i36;
import 'package:pharma_lms_client/src/protocol/organization/user.dart' as _i37;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i38;
import 'package:pharma_lms_client/src/protocol/quality/capa.dart' as _i39;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i40;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i41;
import 'package:pharma_lms_client/src/protocol/training/certificate.dart'
    as _i42;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i43;
import 'package:pharma_lms_client/src/protocol/greetings/greeting.dart' as _i44;
import 'protocol.dart' as _i45;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Training Administrator domain endpoint.
/// {@category Endpoint}
class EndpointAdmin extends _i2.EndpointRef {
  EndpointAdmin(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  /// Assign training to all users in a department.
  _i3.Future<List<_i5.TrainingAssignment>> assignTrainingToDepartment({
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    required String source,
  }) => caller.callServerEndpoint<List<_i5.TrainingAssignment>>(
    'admin',
    'assignTrainingToDepartment',
    {
      'departmentId': departmentId,
      'courseVersionId': courseVersionId,
      'assignedById': assignedById,
      'dueDate': dueDate,
      'reason': reason,
      'source': source,
    },
  );

  /// Bulk import users from CSV (base64). Columns: email,firstName,lastName,departmentId,siteId,organizationId,jobRoleId
  _i3.Future<_i6.BulkImportResult> bulkImportUsers({
    required String csvBase64,
    required int assignedById,
    DateTime? dueDate,
  }) => caller.callServerEndpoint<_i6.BulkImportResult>(
    'admin',
    'bulkImportUsers',
    {
      'csvBase64': csvBase64,
      'assignedById': assignedById,
      'dueDate': dueDate,
    },
  );

  /// Update job role training matrix (JSON array of course IDs).
  _i3.Future<_i7.JobRole> updateJobRoleTrainingMatrix({
    required int jobRoleId,
    required String trainingMatrixJson,
  }) => caller.callServerEndpoint<_i7.JobRole>(
    'admin',
    'updateJobRoleTrainingMatrix',
    {
      'jobRoleId': jobRoleId,
      'trainingMatrixJson': trainingMatrixJson,
    },
  );

  /// Get course version IDs from JobRole training matrix (course IDs -> latest approved version).
  _i3.Future<List<int>> getRoleBasedCurriculum(int jobRoleId) =>
      caller.callServerEndpoint<List<int>>(
        'admin',
        'getRoleBasedCurriculum',
        {'jobRoleId': jobRoleId},
      );

  /// Assign role-based training (curriculum from JobRole) to a user.
  _i3.Future<List<_i5.TrainingAssignment>> assignRoleBasedTraining({
    required int userId,
    required int jobRoleId,
    required int assignedById,
    required DateTime dueDate,
  }) => caller.callServerEndpoint<List<_i5.TrainingAssignment>>(
    'admin',
    'assignRoleBasedTraining',
    {
      'userId': userId,
      'jobRoleId': jobRoleId,
      'assignedById': assignedById,
      'dueDate': dueDate,
    },
  );

  /// Lock (block) a user by email - prevents sign-in. Account lockout.
  _i3.Future<bool> lockUserByEmail(String email) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'lockUserByEmail',
        {'email': email},
      );

  /// Unlock (unblock) a user by email.
  _i3.Future<bool> unlockUserByEmail(String email) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'unlockUserByEmail',
        {'email': email},
      );
}

/// Analytics & Reporting domain endpoint.
/// {@category Endpoint}
class EndpointAnalytics extends _i2.EndpointRef {
  EndpointAnalytics(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  /// Training completion rate by department.
  _i3.Future<Map<String, double>> getTrainingCompletionRate({
    int? organizationId,
  }) => caller.callServerEndpoint<Map<String, double>>(
    'analytics',
    'getTrainingCompletionRate',
    {'organizationId': organizationId},
  );

  /// Department compliance summary.
  _i3.Future<List<_i8.DepartmentComplianceSummary>>
  getDepartmentComplianceSummary() =>
      caller.callServerEndpoint<List<_i8.DepartmentComplianceSummary>>(
        'analytics',
        'getDepartmentComplianceSummary',
        {},
      );

  /// Certification expiry risk - count of certs expiring in next 30 days.
  _i3.Future<int> getCertificationExpiryRiskCount({int? organizationId}) =>
      caller.callServerEndpoint<int>(
        'analytics',
        'getCertificationExpiryRiskCount',
        {'organizationId': organizationId},
      );

  /// Audit readiness score - based on compliance and audit trail completeness.
  _i3.Future<_i9.AuditReadinessScore> getAuditReadinessScore({
    int? organizationId,
  }) => caller.callServerEndpoint<_i9.AuditReadinessScore>(
    'analytics',
    'getAuditReadinessScore',
    {'organizationId': organizationId},
  );

  _i3.Future<List<_i10.ReportDefinition>> listReportDefinitions() =>
      caller.callServerEndpoint<List<_i10.ReportDefinition>>(
        'analytics',
        'listReportDefinitions',
        {},
      );

  _i3.Future<List<_i11.Dashboard>> listDashboards({int? roleId}) =>
      caller.callServerEndpoint<List<_i11.Dashboard>>(
        'analytics',
        'listDashboards',
        {'roleId': roleId},
      );

  _i3.Future<List<_i12.SlaBreach>> getOpenSlaBreaches() =>
      caller.callServerEndpoint<List<_i12.SlaBreach>>(
        'analytics',
        'getOpenSlaBreaches',
        {},
      );
}

/// Assessment builder endpoint for SME/trainers.
/// {@category Endpoint}
class EndpointAssessmentBuilder extends _i2.EndpointRef {
  EndpointAssessmentBuilder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assessmentBuilder';

  _i3.Future<_i13.Question> createQuestion({
    required int questionBankId,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
  }) => caller.callServerEndpoint<_i13.Question>(
    'assessmentBuilder',
    'createQuestion',
    {
      'questionBankId': questionBankId,
      'text': text,
      'questionType': questionType,
      'optionsJson': optionsJson,
      'correctAnswer': correctAnswer,
      'difficulty': difficulty,
    },
  );

  _i3.Future<_i13.Question> updateQuestion({
    required int questionId,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    String? difficulty,
  }) => caller.callServerEndpoint<_i13.Question>(
    'assessmentBuilder',
    'updateQuestion',
    {
      'questionId': questionId,
      'text': text,
      'questionType': questionType,
      'optionsJson': optionsJson,
      'correctAnswer': correctAnswer,
      'difficulty': difficulty,
    },
  );

  _i3.Future<_i14.Assessment> createAssessment({
    required int courseVersionId,
    required int questionBankId,
    required int passingScore,
    required bool randomize,
    int? timeLimitMinutes,
  }) => caller.callServerEndpoint<_i14.Assessment>(
    'assessmentBuilder',
    'createAssessment',
    {
      'courseVersionId': courseVersionId,
      'questionBankId': questionBankId,
      'passingScore': passingScore,
      'randomize': randomize,
      'timeLimitMinutes': timeLimitMinutes,
    },
  );

  _i3.Future<_i14.Assessment> updateAssessment({
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
  }) => caller.callServerEndpoint<_i14.Assessment>(
    'assessmentBuilder',
    'updateAssessment',
    {
      'assessmentId': assessmentId,
      'passingScore': passingScore,
      'randomize': randomize,
      'timeLimitMinutes': timeLimitMinutes,
    },
  );
}

/// Assessment Engine domain endpoint.
/// {@category Endpoint}
class EndpointAssessment extends _i2.EndpointRef {
  EndpointAssessment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assessment';

  _i3.Future<_i14.Assessment?> getAssessmentForCourse(int courseVersionId) =>
      caller.callServerEndpoint<_i14.Assessment?>(
        'assessment',
        'getAssessmentForCourse',
        {'courseVersionId': courseVersionId},
      );

  _i3.Future<List<_i13.Question>> getQuestions(int questionBankId) =>
      caller.callServerEndpoint<List<_i13.Question>>(
        'assessment',
        'getQuestions',
        {'questionBankId': questionBankId},
      );

  _i3.Future<_i15.AssessmentAttempt> startAttempt({
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<_i15.AssessmentAttempt>(
    'assessment',
    'startAttempt',
    {
      'userId': userId,
      'assessmentId': assessmentId,
      'enrollmentId': enrollmentId,
    },
  );

  _i3.Future<_i15.AssessmentAttempt> submitAttempt({
    required int attemptId,
    required int score,
  }) => caller.callServerEndpoint<_i15.AssessmentAttempt>(
    'assessment',
    'submitAttempt',
    {
      'attemptId': attemptId,
      'score': score,
    },
  );

  _i3.Future<_i16.AssessmentResult> recordAnswer({
    required int attemptId,
    required int questionId,
    required String answer,
    required bool correct,
    int? points,
  }) => caller.callServerEndpoint<_i16.AssessmentResult>(
    'assessment',
    'recordAnswer',
    {
      'attemptId': attemptId,
      'questionId': questionId,
      'answer': answer,
      'correct': correct,
      'points': points,
    },
  );

  _i3.Future<List<_i17.QuestionBank>> listQuestionBanks({
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i17.QuestionBank>>(
    'assessment',
    'listQuestionBanks',
    {'organizationId': organizationId},
  );

  _i3.Future<_i17.QuestionBank> createQuestionBank({
    required String name,
    required int organizationId,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i17.QuestionBank>(
    'assessment',
    'createQuestionBank',
    {
      'name': name,
      'organizationId': organizationId,
      'tagsJson': tagsJson,
    },
  );
}

/// Audit & Validation domain endpoint - for QA and auditor access.
/// {@category Endpoint}
class EndpointAudit extends _i2.EndpointRef {
  EndpointAudit(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'audit';

  _i3.Future<List<_i18.AuditTrail>> getAuditTrail({
    String? entityType,
    String? entityId,
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<List<_i18.AuditTrail>>(
    'audit',
    'getAuditTrail',
    {
      'entityType': entityType,
      'entityId': entityId,
      'userId': userId,
      'from': from,
      'to': to,
      'limit': limit,
    },
  );

  _i3.Future<List<_i19.AccessLog>> getAccessLogs({
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<List<_i19.AccessLog>>(
    'audit',
    'getAccessLogs',
    {
      'userId': userId,
      'from': from,
      'to': to,
      'limit': limit,
    },
  );
}

/// Compliance Engine domain endpoint.
/// {@category Endpoint}
class EndpointCompliance extends _i2.EndpointRef {
  EndpointCompliance(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'compliance';

  _i3.Future<_i20.ComplianceMetrics> getDepartmentCompliance(
    int departmentId, {
    DateTime? asOf,
  }) => caller.callServerEndpoint<_i20.ComplianceMetrics>(
    'compliance',
    'getDepartmentCompliance',
    {
      'departmentId': departmentId,
      'asOf': asOf,
    },
  );

  _i3.Future<_i21.UserComplianceMetrics> getUserCompliance(
    int userId, {
    DateTime? asOf,
  }) => caller.callServerEndpoint<_i21.UserComplianceMetrics>(
    'compliance',
    'getUserCompliance',
    {
      'userId': userId,
      'asOf': asOf,
    },
  );

  _i3.Future<bool> isDepartmentBelowThreshold({
    required int departmentId,
    required double threshold,
  }) => caller.callServerEndpoint<bool>(
    'compliance',
    'isDepartmentBelowThreshold',
    {
      'departmentId': departmentId,
      'threshold': threshold,
    },
  );
}

/// Course builder endpoint for SME/trainers (TC-07: restricted editing).
/// {@category Endpoint}
class EndpointCourseBuilder extends _i2.EndpointRef {
  EndpointCourseBuilder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'courseBuilder';

  _i3.Future<_i22.Module> createModule({
    required int courseVersionId,
    required String title,
    required int orderIndex,
  }) => caller.callServerEndpoint<_i22.Module>(
    'courseBuilder',
    'createModule',
    {
      'courseVersionId': courseVersionId,
      'title': title,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i22.Module> updateModule({
    required int moduleId,
    String? title,
    int? orderIndex,
  }) => caller.callServerEndpoint<_i22.Module>(
    'courseBuilder',
    'updateModule',
    {
      'moduleId': moduleId,
      'title': title,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i23.Lesson> createLesson({
    required int moduleId,
    required String title,
    required int materialId,
    required int orderIndex,
    int? durationMinutes,
  }) => caller.callServerEndpoint<_i23.Lesson>(
    'courseBuilder',
    'createLesson',
    {
      'moduleId': moduleId,
      'title': title,
      'materialId': materialId,
      'orderIndex': orderIndex,
      'durationMinutes': durationMinutes,
    },
  );

  _i3.Future<_i23.Lesson> updateLesson({
    required int lessonId,
    String? title,
    int? materialId,
    int? orderIndex,
    int? durationMinutes,
  }) => caller.callServerEndpoint<_i23.Lesson>(
    'courseBuilder',
    'updateLesson',
    {
      'lessonId': lessonId,
      'title': title,
      'materialId': materialId,
      'orderIndex': orderIndex,
      'durationMinutes': durationMinutes,
    },
  );

  /// Create new course version. TC-07: if course has approved version, only allow draft.
  _i3.Future<_i24.CourseVersion> createCourseVersion({
    required int courseId,
    required String version,
    required String status,
  }) => caller.callServerEndpoint<_i24.CourseVersion>(
    'courseBuilder',
    'createCourseVersion',
    {
      'courseId': courseId,
      'version': version,
      'status': status,
    },
  );

  /// Update course version status. TC-07: approved -> no edit.
  _i3.Future<_i24.CourseVersion> updateCourseVersionStatus({
    required int courseVersionId,
    required String status,
  }) => caller.callServerEndpoint<_i24.CourseVersion>(
    'courseBuilder',
    'updateCourseVersionStatus',
    {
      'courseVersionId': courseVersionId,
      'status': status,
    },
  );
}

/// Course & Curriculum domain endpoint.
/// {@category Endpoint}
class EndpointCourse extends _i2.EndpointRef {
  EndpointCourse(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'course';

  _i3.Future<List<_i25.Course>> listCourses({
    int? organizationId,
    String? status,
  }) => caller.callServerEndpoint<List<_i25.Course>>(
    'course',
    'listCourses',
    {
      'organizationId': organizationId,
      'status': status,
    },
  );

  _i3.Future<_i25.Course?> getCourse(int id) =>
      caller.callServerEndpoint<_i25.Course?>(
        'course',
        'getCourse',
        {'id': id},
      );

  _i3.Future<List<_i24.CourseVersion>> getCourseVersions(int courseId) =>
      caller.callServerEndpoint<List<_i24.CourseVersion>>(
        'course',
        'getCourseVersions',
        {'courseId': courseId},
      );

  _i3.Future<_i24.CourseVersion?> getCourseVersion(int courseVersionId) =>
      caller.callServerEndpoint<_i24.CourseVersion?>(
        'course',
        'getCourseVersion',
        {'courseVersionId': courseVersionId},
      );

  _i3.Future<_i25.Course> createCourse({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) => caller.callServerEndpoint<_i25.Course>(
    'course',
    'createCourse',
    {
      'title': title,
      'organizationId': organizationId,
      'sopNumber': sopNumber,
      'description': description,
      'createdById': createdById,
    },
  );

  _i3.Future<List<_i22.Module>> getModulesForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i22.Module>>(
    'course',
    'getModulesForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  _i3.Future<List<_i23.Lesson>> getLessonsForModule(int moduleId) =>
      caller.callServerEndpoint<List<_i23.Lesson>>(
        'course',
        'getLessonsForModule',
        {'moduleId': moduleId},
      );

  _i3.Future<_i23.Lesson?> getLessonWithMaterial(int lessonId) =>
      caller.callServerEndpoint<_i23.Lesson?>(
        'course',
        'getLessonWithMaterial',
        {'lessonId': lessonId},
      );
}

/// Document Control domain endpoint.
/// {@category Endpoint}
class EndpointDocument extends _i2.EndpointRef {
  EndpointDocument(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i3.Future<List<_i26.Document>> listDocuments({
    int? organizationId,
    String? documentType,
  }) => caller.callServerEndpoint<List<_i26.Document>>(
    'document',
    'listDocuments',
    {
      'organizationId': organizationId,
      'documentType': documentType,
    },
  );

  _i3.Future<_i26.Document?> getDocument(int id) =>
      caller.callServerEndpoint<_i26.Document?>(
        'document',
        'getDocument',
        {'id': id},
      );

  _i3.Future<List<_i27.DocumentVersion>> getDocumentVersions(int documentId) =>
      caller.callServerEndpoint<List<_i27.DocumentVersion>>(
        'document',
        'getDocumentVersions',
        {'documentId': documentId},
      );

  _i3.Future<_i26.Document> createDocument({
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i26.Document>(
    'document',
    'createDocument',
    {
      'title': title,
      'documentNumber': documentNumber,
      'documentType': documentType,
      'organizationId': organizationId,
    },
  );

  _i3.Future<_i27.DocumentVersion> createDocumentVersion({
    required int documentId,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
  }) => caller.callServerEndpoint<_i27.DocumentVersion>(
    'document',
    'createDocumentVersion',
    {
      'documentId': documentId,
      'version': version,
      'storageKey': storageKey,
      'effectiveDate': effectiveDate,
      'obsoleteDate': obsoleteDate,
    },
  );

  _i3.Future<List<_i28.DocumentLifecycle>> getDocumentLifecycle(
    int documentVersionId,
  ) => caller.callServerEndpoint<List<_i28.DocumentLifecycle>>(
    'document',
    'getDocumentLifecycle',
    {'documentVersionId': documentVersionId},
  );

  _i3.Future<_i29.ApprovalWorkflow> createApprovalStep({
    required int documentVersionId,
    required int step,
    required int approverId,
    required String status,
    int? esignatureId,
  }) => caller.callServerEndpoint<_i29.ApprovalWorkflow>(
    'document',
    'createApprovalStep',
    {
      'documentVersionId': documentVersionId,
      'step': step,
      'approverId': approverId,
      'status': status,
      'esignatureId': esignatureId,
    },
  );
}

/// Event trigger endpoint - stub for manual testing of workflow events.
/// Triggers future calls (SOP update retraining, employee onboarding).
/// {@category Endpoint}
class EndpointEvent extends _i2.EndpointRef {
  EndpointEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  /// Trigger SOP updated event - assigns retraining to all departments.
  _i3.Future<void> triggerSopUpdated({
    required String documentId,
    required String courseVersionId,
    required String reason,
  }) => caller.callServerEndpoint<void>(
    'event',
    'triggerSopUpdated',
    {
      'documentId': documentId,
      'courseVersionId': courseVersionId,
      'reason': reason,
    },
  );

  /// Trigger employee created event - assigns role-based training.
  _i3.Future<void> triggerEmployeeCreated({
    required String userId,
    required String departmentId,
    required String roleId,
  }) => caller.callServerEndpoint<void>(
    'event',
    'triggerEmployeeCreated',
    {
      'userId': userId,
      'departmentId': departmentId,
      'roleId': roleId,
    },
  );
}

/// Material & progress endpoint (M1 + M2 upload).
/// {@category Endpoint}
class EndpointMaterial extends _i2.EndpointRef {
  EndpointMaterial(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'material';

  _i3.Future<_i30.Material?> getMaterial(int id) =>
      caller.callServerEndpoint<_i30.Material?>(
        'material',
        'getMaterial',
        {'id': id},
      );

  /// Get public URL for viewing material content (PDF, video, etc.).
  _i3.Future<String?> getMaterialViewUrl(String storageKey) =>
      caller.callServerEndpoint<String?>(
        'material',
        'getMaterialViewUrl',
        {'storageKey': storageKey},
      );

  _i3.Future<_i30.Material> createMaterial({
    required String title,
    required String materialType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i30.Material>(
    'material',
    'createMaterial',
    {
      'title': title,
      'materialType': materialType,
      'organizationId': organizationId,
    },
  );

  /// Get upload description for direct client upload. Path like materials/{materialId}/v1.pdf
  _i3.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'material',
        'getUploadDescription',
        {'path': path},
      );

  /// Verify upload completed; must be called or file may be deleted.
  _i3.Future<bool> verifyUpload(String path) => caller.callServerEndpoint<bool>(
    'material',
    'verifyUpload',
    {'path': path},
  );

  /// Create material version after successful upload.
  _i3.Future<_i31.MaterialVersion> createMaterialVersion({
    required int materialId,
    required String storageKey,
  }) => caller.callServerEndpoint<_i31.MaterialVersion>(
    'material',
    'createMaterialVersion',
    {
      'materialId': materialId,
      'storageKey': storageKey,
    },
  );

  _i3.Future<List<_i31.MaterialVersion>> getMaterialVersions(int materialId) =>
      caller.callServerEndpoint<List<_i31.MaterialVersion>>(
        'material',
        'getMaterialVersions',
        {'materialId': materialId},
      );

  _i3.Future<List<_i30.Material>> listMaterials({
    required int organizationId,
  }) => caller.callServerEndpoint<List<_i30.Material>>(
    'material',
    'listMaterials',
    {'organizationId': organizationId},
  );

  /// Update or create material progress for minimum read time / pausable learning.
  _i3.Future<_i32.MaterialProgress> updateProgress({
    required int userId,
    required int materialId,
    required int progressPct,
    DateTime? completedAt,
    String? interactionJson,
  }) => caller.callServerEndpoint<_i32.MaterialProgress>(
    'material',
    'updateProgress',
    {
      'userId': userId,
      'materialId': materialId,
      'progressPct': progressPct,
      'completedAt': completedAt,
      'interactionJson': interactionJson,
    },
  );

  _i3.Future<_i32.MaterialProgress?> getProgress({
    required int userId,
    required int materialId,
  }) => caller.callServerEndpoint<_i32.MaterialProgress?>(
    'material',
    'getProgress',
    {
      'userId': userId,
      'materialId': materialId,
    },
  );
}

/// Notification domain endpoint (in-app; no email/push in stub).
/// {@category Endpoint}
class EndpointNotification extends _i2.EndpointRef {
  EndpointNotification(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  /// Get in-app notifications: assignment due, overdue from TrainingAssignment.
  _i3.Future<List<_i33.InAppNotification>> getInAppNotifications(int userId) =>
      caller.callServerEndpoint<List<_i33.InAppNotification>>(
        'notification',
        'getInAppNotifications',
        {'userId': userId},
      );
}

/// Organization & Identity domain endpoint.
/// {@category Endpoint}
class EndpointOrganization extends _i2.EndpointRef {
  EndpointOrganization(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  _i3.Future<List<_i34.Organization>> listOrganizations() =>
      caller.callServerEndpoint<List<_i34.Organization>>(
        'organization',
        'listOrganizations',
        {},
      );

  _i3.Future<_i34.Organization?> getOrganization(int id) =>
      caller.callServerEndpoint<_i34.Organization?>(
        'organization',
        'getOrganization',
        {'id': id},
      );

  _i3.Future<_i34.Organization> createOrganization({
    required String name,
    required String code,
  }) => caller.callServerEndpoint<_i34.Organization>(
    'organization',
    'createOrganization',
    {
      'name': name,
      'code': code,
    },
  );

  _i3.Future<List<_i35.Site>> listSites(int organizationId) =>
      caller.callServerEndpoint<List<_i35.Site>>(
        'organization',
        'listSites',
        {'organizationId': organizationId},
      );

  _i3.Future<List<_i36.Department>> listDepartments(int siteId) =>
      caller.callServerEndpoint<List<_i36.Department>>(
        'organization',
        'listDepartments',
        {'siteId': siteId},
      );

  _i3.Future<List<_i7.JobRole>> listJobRoles(int departmentId) =>
      caller.callServerEndpoint<List<_i7.JobRole>>(
        'organization',
        'listJobRoles',
        {'departmentId': departmentId},
      );

  _i3.Future<List<_i37.PharmaUser>> listUsers({
    int? organizationId,
    int? departmentId,
  }) => caller.callServerEndpoint<List<_i37.PharmaUser>>(
    'organization',
    'listUsers',
    {
      'organizationId': organizationId,
      'departmentId': departmentId,
    },
  );
}

/// QA & Course Approval domain endpoint.
/// {@category Endpoint}
class EndpointQa extends _i2.EndpointRef {
  EndpointQa(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'qa';

  /// List course versions pending QA approval.
  _i3.Future<List<_i24.CourseVersion>> listPendingCourseVersions() =>
      caller.callServerEndpoint<List<_i24.CourseVersion>>(
        'qa',
        'listPendingCourseVersions',
        {},
      );

  /// Approve a course version (QA sign-off).
  _i3.Future<_i24.CourseVersion> approveCourseVersion({
    required int courseVersionId,
  }) => caller.callServerEndpoint<_i24.CourseVersion>(
    'qa',
    'approveCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Reject a course version (return to draft).
  _i3.Future<_i24.CourseVersion> rejectCourseVersion({
    required int courseVersionId,
    String? reason,
  }) => caller.callServerEndpoint<_i24.CourseVersion>(
    'qa',
    'rejectCourseVersion',
    {
      'courseVersionId': courseVersionId,
      'reason': reason,
    },
  );
}

/// Quality Event Integration domain endpoint.
/// {@category Endpoint}
class EndpointQualityEvent extends _i2.EndpointRef {
  EndpointQualityEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'qualityEvent';

  _i3.Future<List<_i38.QualityEvent>> listQualityEvents({
    int? siteId,
    String? eventType,
    String? status,
  }) => caller.callServerEndpoint<List<_i38.QualityEvent>>(
    'qualityEvent',
    'listQualityEvents',
    {
      'siteId': siteId,
      'eventType': eventType,
      'status': status,
    },
  );

  _i3.Future<_i38.QualityEvent?> getQualityEvent(int id) =>
      caller.callServerEndpoint<_i38.QualityEvent?>(
        'qualityEvent',
        'getQualityEvent',
        {'id': id},
      );

  _i3.Future<_i38.QualityEvent> createQualityEvent({
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) => caller.callServerEndpoint<_i38.QualityEvent>(
    'qualityEvent',
    'createQualityEvent',
    {
      'eventType': eventType,
      'title': title,
      'status': status,
      'referenceId': referenceId,
      'siteId': siteId,
    },
  );

  _i3.Future<_i39.Capa> createCapa({
    required int qualityEventId,
    String? description,
    String? rootCause,
    required bool trainingRequired,
  }) => caller.callServerEndpoint<_i39.Capa>(
    'qualityEvent',
    'createCapa',
    {
      'qualityEventId': qualityEventId,
      'description': description,
      'rootCause': rootCause,
      'trainingRequired': trainingRequired,
    },
  );

  _i3.Future<_i5.TrainingAssignment?> assignTrainingFromCapa({
    required int capaId,
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
  }) => caller.callServerEndpoint<_i5.TrainingAssignment?>(
    'qualityEvent',
    'assignTrainingFromCapa',
    {
      'capaId': capaId,
      'userId': userId,
      'courseVersionId': courseVersionId,
      'assignedById': assignedById,
      'dueDate': dueDate,
    },
  );

  _i3.Future<List<_i40.InspectionReport>> listInspectionReports({
    int? organizationId,
    int? siteId,
  }) => caller.callServerEndpoint<List<_i40.InspectionReport>>(
    'qualityEvent',
    'listInspectionReports',
    {
      'organizationId': organizationId,
      'siteId': siteId,
    },
  );

  _i3.Future<_i40.InspectionReport> createInspectionReport({
    required int organizationId,
    required String status,
    int? siteId,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
  }) => caller.callServerEndpoint<_i40.InspectionReport>(
    'qualityEvent',
    'createInspectionReport',
    {
      'organizationId': organizationId,
      'status': status,
      'siteId': siteId,
      'inspector': inspector,
      'inspectionDate': inspectionDate,
      'findingsJson': findingsJson,
    },
  );
}

/// Seed endpoint for development/demo data.
/// Call runSeed() to populate organizations, sites, departments, users, courses.
/// {@category Endpoint}
class EndpointSeed extends _i2.EndpointRef {
  EndpointSeed(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  /// Seeds the database with sample data if empty. Idempotent - skips if org exists.
  _i3.Future<String> runSeed() => caller.callServerEndpoint<String>(
    'seed',
    'runSeed',
    {},
  );
}

/// Training Assignment domain endpoint.
/// {@category Endpoint}
class EndpointTraining extends _i2.EndpointRef {
  EndpointTraining(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'training';

  _i3.Future<List<_i5.TrainingAssignment>> getAssignmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i5.TrainingAssignment>>(
        'training',
        'getAssignmentsForUser',
        {'userId': userId},
      );

  _i3.Future<_i5.TrainingAssignment> assignTraining({
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    required String priority,
    String? reason,
    required String source,
  }) => caller.callServerEndpoint<_i5.TrainingAssignment>(
    'training',
    'assignTraining',
    {
      'userId': userId,
      'courseVersionId': courseVersionId,
      'assignedById': assignedById,
      'dueDate': dueDate,
      'priority': priority,
      'reason': reason,
      'source': source,
    },
  );

  _i3.Future<List<_i41.Enrollment>> getEnrollmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i41.Enrollment>>(
        'training',
        'getEnrollmentsForUser',
        {'userId': userId},
      );

  _i3.Future<List<_i42.Certificate>> getCertificatesForUser(int userId) =>
      caller.callServerEndpoint<List<_i42.Certificate>>(
        'training',
        'getCertificatesForUser',
        {'userId': userId},
      );

  /// Get certificate by ID for verification and direct links.
  _i3.Future<_i42.Certificate?> getCertificateById(int certificateId) =>
      caller.callServerEndpoint<_i42.Certificate?>(
        'training',
        'getCertificateById',
        {'certificateId': certificateId},
      );

  /// List electronic signatures for auditor verification (21 CFR Part 11).
  _i3.Future<List<_i43.ElectronicSignature>> listElectronicSignatures({
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i43.ElectronicSignature>>(
    'training',
    'listElectronicSignatures',
    {
      'from': from,
      'to': to,
      'entityType': entityType,
      'userId': userId,
      'limit': limit,
    },
  );

  /// Create electronic signature for training completion (called after e-sign UI).
  _i3.Future<int> createTrainingSignature({
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordReauthHash,
    String? ipAddress,
  }) => caller.callServerEndpoint<int>(
    'training',
    'createTrainingSignature',
    {
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'entityType': entityType,
      'entityId': entityId,
      'passwordReauthHash': passwordReauthHash,
      'ipAddress': ipAddress,
    },
  );

  /// Complete training: create TrainingRecord, Certificate, update Enrollment.
  /// Call after assessment pass and e-signature.
  _i3.Future<_i42.Certificate> completeTraining({
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required int esignatureId,
    int? score,
  }) => caller.callServerEndpoint<_i42.Certificate>(
    'training',
    'completeTraining',
    {
      'enrollmentId': enrollmentId,
      'userId': userId,
      'courseVersionId': courseVersionId,
      'esignatureId': esignatureId,
      'score': score,
    },
  );
}

/// User-centric endpoint for employee operations.
/// {@category Endpoint}
class EndpointUser extends _i2.EndpointRef {
  EndpointUser(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i3.Future<_i37.PharmaUser?> getUser(int id) =>
      caller.callServerEndpoint<_i37.PharmaUser?>(
        'user',
        'getUser',
        {'id': id},
      );

  _i3.Future<_i37.PharmaUser?> getUserByEmail(String email) =>
      caller.callServerEndpoint<_i37.PharmaUser?>(
        'user',
        'getUserByEmail',
        {'email': email},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i44.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i44.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_core = _i4.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
  }

  late final _i4.Caller serverpod_auth_core;

  late final _i1.Caller serverpod_auth_idp;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i45.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    admin = EndpointAdmin(this);
    analytics = EndpointAnalytics(this);
    assessmentBuilder = EndpointAssessmentBuilder(this);
    assessment = EndpointAssessment(this);
    audit = EndpointAudit(this);
    compliance = EndpointCompliance(this);
    courseBuilder = EndpointCourseBuilder(this);
    course = EndpointCourse(this);
    document = EndpointDocument(this);
    event = EndpointEvent(this);
    material = EndpointMaterial(this);
    notification = EndpointNotification(this);
    organization = EndpointOrganization(this);
    qa = EndpointQa(this);
    qualityEvent = EndpointQualityEvent(this);
    seed = EndpointSeed(this);
    training = EndpointTraining(this);
    user = EndpointUser(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAdmin admin;

  late final EndpointAnalytics analytics;

  late final EndpointAssessmentBuilder assessmentBuilder;

  late final EndpointAssessment assessment;

  late final EndpointAudit audit;

  late final EndpointCompliance compliance;

  late final EndpointCourseBuilder courseBuilder;

  late final EndpointCourse course;

  late final EndpointDocument document;

  late final EndpointEvent event;

  late final EndpointMaterial material;

  late final EndpointNotification notification;

  late final EndpointOrganization organization;

  late final EndpointQa qa;

  late final EndpointQualityEvent qualityEvent;

  late final EndpointSeed seed;

  late final EndpointTraining training;

  late final EndpointUser user;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'admin': admin,
    'analytics': analytics,
    'assessmentBuilder': assessmentBuilder,
    'assessment': assessment,
    'audit': audit,
    'compliance': compliance,
    'courseBuilder': courseBuilder,
    'course': course,
    'document': document,
    'event': event,
    'material': material,
    'notification': notification,
    'organization': organization,
    'qa': qa,
    'qualityEvent': qualityEvent,
    'seed': seed,
    'training': training,
    'user': user,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_core': modules.serverpod_auth_core,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
  };
}
