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
import 'package:pharma_lms_client/src/protocol/auth/oidc_client_config.dart'
    as _i5;
import 'package:pharma_lms_client/src/protocol/shared/signature_meaning.dart'
    as _i6;
import 'package:pharma_lms_client/src/protocol/training/training_assignment.dart'
    as _i7;
import 'package:pharma_lms_client/src/protocol/admin/bulk_import_result.dart'
    as _i8;
import 'package:pharma_lms_client/src/protocol/organization/job_role.dart'
    as _i9;
import 'package:pharma_lms_client/src/protocol/training/training_waiver.dart'
    as _i10;
import 'package:pharma_lms_client/src/protocol/analytics/course_analytics.dart'
    as _i11;
import 'package:pharma_lms_client/src/protocol/analytics/department_compliance_summary.dart'
    as _i12;
import 'package:pharma_lms_client/src/protocol/analytics/audit_readiness_score.dart'
    as _i13;
import 'package:pharma_lms_client/src/protocol/analytics/report_definition.dart'
    as _i14;
import 'package:pharma_lms_client/src/protocol/analytics/dashboard.dart'
    as _i15;
import 'package:pharma_lms_client/src/protocol/analytics/sla_breach.dart'
    as _i16;
import 'package:pharma_lms_client/src/protocol/organization/user.dart' as _i17;
import 'package:pharma_lms_client/src/protocol/training/certificate.dart'
    as _i18;
import 'package:pharma_lms_client/src/protocol/quality/capa.dart' as _i19;
import 'package:pharma_lms_client/src/protocol/analytics/analytics_event.dart'
    as _i20;
import 'package:pharma_lms_client/src/protocol/assessment/question.dart'
    as _i21;
import 'package:pharma_lms_client/src/protocol/assessment/assessment.dart'
    as _i22;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_attempt.dart'
    as _i23;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_result.dart'
    as _i24;
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i25;
import 'package:pharma_lms_client/src/protocol/audit/audit_trail.dart' as _i26;
import 'package:pharma_lms_client/src/protocol/audit/access_log.dart' as _i27;
import 'package:pharma_lms_client/src/protocol/analytics/compliance_metrics.dart'
    as _i28;
import 'package:pharma_lms_client/src/protocol/analytics/user_compliance_metrics.dart'
    as _i29;
import 'package:pharma_lms_client/src/protocol/course/module.dart' as _i30;
import 'package:pharma_lms_client/src/protocol/course/lesson.dart' as _i31;
import 'package:pharma_lms_client/src/protocol/course/course_version.dart'
    as _i32;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i33;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i34;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i35;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i36;
import 'package:pharma_lms_client/src/protocol/document/approval_workflow.dart'
    as _i37;
import 'package:pharma_lms_client/src/protocol/audit/inspection_record.dart'
    as _i38;
import 'package:pharma_lms_client/src/protocol/audit/auditor_page_log.dart'
    as _i39;
import 'package:pharma_lms_client/src/protocol/audit/inspection_package.dart'
    as _i40;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i41;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i42;
import 'package:pharma_lms_client/src/protocol/material/material_progress.dart'
    as _i43;
import 'package:pharma_lms_client/src/protocol/mfa/mfa_status_result.dart'
    as _i44;
import 'package:pharma_lms_client/src/protocol/mfa/mfa_enroll_result.dart'
    as _i45;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i46;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i47;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i48;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i49;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i50;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i51;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i52;
import 'package:pharma_lms_client/src/protocol/training/training_record.dart'
    as _i53;
import 'package:pharma_lms_client/src/protocol/shared/signature_verification_result.dart'
    as _i54;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i55;
import 'package:pharma_lms_client/src/protocol/training/training_record_annotation.dart'
    as _i56;
import 'package:pharma_lms_client/src/protocol/greetings/greeting.dart' as _i57;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i58;
import 'protocol.dart' as _i59;

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

/// OIDC identity provider endpoint. Supports Auth0, Okta, Azure AD.
/// {@category Endpoint}
class EndpointOidcIdp extends _i1.EndpointIdpBase {
  EndpointOidcIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'oidcIdp';

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'oidcIdp',
    'hasAccount',
    {},
  );

  /// Returns OIDC client config for Flutter when SSO is configured.
  /// Call this to get authorization endpoint, client ID, redirect URI.
  _i3.Future<_i5.OidcClientConfig> getClientConfig() =>
      caller.callServerEndpoint<_i5.OidcClientConfig>(
        'oidcIdp',
        'getClientConfig',
        {},
      );

  _i3.Future<_i4.AuthSuccess> login({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'oidcIdp',
    'login',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );
}

/// Training Administrator domain endpoint.
/// {@category Endpoint}
class EndpointAdmin extends _i2.EndpointRef {
  EndpointAdmin(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  /// List all signature meanings (admin - includes inactive).
  _i3.Future<List<_i6.SignatureMeaning>> listSignatureMeanings() =>
      caller.callServerEndpoint<List<_i6.SignatureMeaning>>(
        'admin',
        'listSignatureMeanings',
        {},
      );

  /// Create a signature meaning.
  _i3.Future<_i6.SignatureMeaning> createSignatureMeaning({
    required String meaning,
    required bool isActive,
    required int orderIndex,
  }) => caller.callServerEndpoint<_i6.SignatureMeaning>(
    'admin',
    'createSignatureMeaning',
    {
      'meaning': meaning,
      'isActive': isActive,
      'orderIndex': orderIndex,
    },
  );

  /// Update a signature meaning.
  _i3.Future<_i6.SignatureMeaning> updateSignatureMeaning({
    required int id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
  }) => caller.callServerEndpoint<_i6.SignatureMeaning>(
    'admin',
    'updateSignatureMeaning',
    {
      'id': id,
      'meaning': meaning,
      'isActive': isActive,
      'orderIndex': orderIndex,
    },
  );

  /// Assign training to all users in a department.
  _i3.Future<List<_i7.TrainingAssignment>> assignTrainingToDepartment({
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    required String source,
  }) => caller.callServerEndpoint<List<_i7.TrainingAssignment>>(
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
  _i3.Future<_i8.BulkImportResult> bulkImportUsers({
    required String csvBase64,
    required int assignedById,
    DateTime? dueDate,
  }) => caller.callServerEndpoint<_i8.BulkImportResult>(
    'admin',
    'bulkImportUsers',
    {
      'csvBase64': csvBase64,
      'assignedById': assignedById,
      'dueDate': dueDate,
    },
  );

  /// Bulk import training matrix from CSV. Columns: job_role_code, course_id.
  /// One row per role-course pair. Merges with existing matrix per role.
  _i3.Future<_i8.BulkImportResult> bulkImportTrainingMatrix({
    required String csvBase64,
  }) => caller.callServerEndpoint<_i8.BulkImportResult>(
    'admin',
    'bulkImportTrainingMatrix',
    {'csvBase64': csvBase64},
  );

  /// Update job role training matrix (JSON array of course IDs).
  _i3.Future<_i9.JobRole> updateJobRoleTrainingMatrix({
    required int jobRoleId,
    required String trainingMatrixJson,
  }) => caller.callServerEndpoint<_i9.JobRole>(
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
  _i3.Future<List<_i7.TrainingAssignment>> assignRoleBasedTraining({
    required int userId,
    required int jobRoleId,
    required int assignedById,
    required DateTime dueDate,
  }) => caller.callServerEndpoint<List<_i7.TrainingAssignment>>(
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

  /// ADM-07: Request a training waiver (admin creates request for user).
  _i3.Future<_i10.TrainingWaiver> requestTrainingWaiver({
    required int userId,
    required int courseId,
    required int requestedById,
    required String requestReason,
    String? evidenceStoragePath,
    DateTime? expiresAt,
  }) => caller.callServerEndpoint<_i10.TrainingWaiver>(
    'admin',
    'requestTrainingWaiver',
    {
      'userId': userId,
      'courseId': courseId,
      'requestedById': requestedById,
      'requestReason': requestReason,
      'evidenceStoragePath': evidenceStoragePath,
      'expiresAt': expiresAt,
    },
  );

  /// ADM-07: List training waivers with optional filters.
  _i3.Future<List<_i10.TrainingWaiver>> listTrainingWaivers({
    int? userId,
    String? status,
    int? courseId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i10.TrainingWaiver>>(
    'admin',
    'listTrainingWaivers',
    {
      'userId': userId,
      'status': status,
      'courseId': courseId,
      'limit': limit,
    },
  );

  /// ADM-07: QA approve a training waiver. Separation of duties: requester cannot approve.
  _i3.Future<_i10.TrainingWaiver> approveTrainingWaiver({
    required int waiverId,
    required int approvedById,
  }) => caller.callServerEndpoint<_i10.TrainingWaiver>(
    'admin',
    'approveTrainingWaiver',
    {
      'waiverId': waiverId,
      'approvedById': approvedById,
    },
  );

  /// ADM-07: QA reject a training waiver.
  _i3.Future<_i10.TrainingWaiver> rejectTrainingWaiver({
    required int waiverId,
    required int approvedById,
    required String rejectionReason,
  }) => caller.callServerEndpoint<_i10.TrainingWaiver>(
    'admin',
    'rejectTrainingWaiver',
    {
      'waiverId': waiverId,
      'approvedById': approvedById,
      'rejectionReason': rejectionReason,
    },
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

  /// Course analytics - pass rate and score distribution from TrainingRecord.
  _i3.Future<_i11.CourseAnalytics> getCourseAnalytics(int courseVersionId) =>
      caller.callServerEndpoint<_i11.CourseAnalytics>(
        'analytics',
        'getCourseAnalytics',
        {'courseVersionId': courseVersionId},
      );

  /// Training completion rate by department.
  _i3.Future<Map<String, double>> getTrainingCompletionRate({
    int? organizationId,
  }) => caller.callServerEndpoint<Map<String, double>>(
    'analytics',
    'getTrainingCompletionRate',
    {'organizationId': organizationId},
  );

  /// IT-02: System health - job status, DLQ count, DB connectivity.
  _i3.Future<Map<String, dynamic>> getSystemHealth() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getSystemHealth',
        {},
      );

  /// IT-WF-04: Manual trigger for background jobs.
  _i3.Future<Map<String, dynamic>> triggerManualJob({
    required String jobName,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'analytics',
    'triggerManualJob',
    {'jobName': jobName},
  );

  /// Department compliance summary.
  _i3.Future<List<_i12.DepartmentComplianceSummary>>
  getDepartmentComplianceSummary() =>
      caller.callServerEndpoint<List<_i12.DepartmentComplianceSummary>>(
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
  _i3.Future<_i13.AuditReadinessScore> getAuditReadinessScore({
    int? organizationId,
  }) => caller.callServerEndpoint<_i13.AuditReadinessScore>(
    'analytics',
    'getAuditReadinessScore',
    {'organizationId': organizationId},
  );

  _i3.Future<List<_i14.ReportDefinition>> listReportDefinitions() =>
      caller.callServerEndpoint<List<_i14.ReportDefinition>>(
        'analytics',
        'listReportDefinitions',
        {},
      );

  _i3.Future<List<_i15.Dashboard>> listDashboards({int? roleId}) =>
      caller.callServerEndpoint<List<_i15.Dashboard>>(
        'analytics',
        'listDashboards',
        {'roleId': roleId},
      );

  _i3.Future<List<_i16.SlaBreach>> getOpenSlaBreaches() =>
      caller.callServerEndpoint<List<_i16.SlaBreach>>(
        'analytics',
        'getOpenSlaBreaches',
        {},
      );

  /// Non-compliant employees (overdue training).
  _i3.Future<List<_i17.PharmaUser>> getNonCompliantEmployees({
    int? departmentId,
  }) => caller.callServerEndpoint<List<_i17.PharmaUser>>(
    'analytics',
    'getNonCompliantEmployees',
    {'departmentId': departmentId},
  );

  /// Upcoming certificate expirations by department (30/60/90 days).
  _i3.Future<Map<String, List<_i18.Certificate>>>
  getUpcomingExpirationsByDepartment() =>
      caller.callServerEndpoint<Map<String, List<_i18.Certificate>>>(
        'analytics',
        'getUpcomingExpirationsByDepartment',
        {},
      );

  /// Recent training assignments (last 10).
  _i3.Future<List<_i7.TrainingAssignment>> getRecentAssignments({
    required int limit,
  }) => caller.callServerEndpoint<List<_i7.TrainingAssignment>>(
    'analytics',
    'getRecentAssignments',
    {'limit': limit},
  );

  /// Open CAPAs requiring training (not yet completed).
  _i3.Future<List<_i19.Capa>> getOpenCapasRequiringTraining() =>
      caller.callServerEndpoint<List<_i19.Capa>>(
        'analytics',
        'getOpenCapasRequiringTraining',
        {},
      );

  /// Pending QA approvals count (course versions).
  _i3.Future<int> getPendingQaApprovalsCount() =>
      caller.callServerEndpoint<int>(
        'analytics',
        'getPendingQaApprovalsCount',
        {},
      );

  /// SOP retraining queue - documents with training_required, employees not retrained.
  _i3.Future<List<Map<String, dynamic>>> getSopRetrainingQueue() =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getSopRetrainingQueue',
        {},
      );

  /// DLQ failures count (for system alerts).
  _i3.Future<int> getDlqFailureCount() => caller.callServerEndpoint<int>(
    'analytics',
    'getDlqFailureCount',
    {},
  );

  /// ANA-02: Training vs deviation correlation - departments/courses with deviation count vs training completion, CAPA effectiveness rate.
  _i3.Future<Map<String, dynamic>> getTrainingVsDeviationCorrelation() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getTrainingVsDeviationCorrelation',
        {},
      );

  /// QA-07: Compliance vs deviation overlay - training completion vs deviation count by department.
  _i3.Future<Map<String, dynamic>> getComplianceDeviationOverlay() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getComplianceDeviationOverlay',
        {},
      );

  /// ANA-03: SLA policy status and breach count.
  _i3.Future<Map<String, dynamic>> getSlaSummary() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getSlaSummary',
        {},
      );

  /// 12-month compliance trend (FR-12-01 AC-05). Uses current snapshot per month.
  _i3.Future<List<Map<String, dynamic>>> getComplianceTrend({
    required int months,
  }) => caller.callServerEndpoint<List<Map<String, dynamic>>>(
    'analytics',
    'getComplianceTrend',
    {'months': months},
  );

  /// SOP retraining velocity - % employees retrained per SOP within 30 days (FR-12-01 AC-04).
  _i3.Future<double> getSopRetrainingVelocity() =>
      caller.callServerEndpoint<double>(
        'analytics',
        'getSopRetrainingVelocity',
        {},
      );

  /// Real-time analytics stream. Poll-based: yields every 30s with fresh metrics.
  /// Channel: 'compliance', 'dept:{deptId}', 'course:{courseVersionId}', 'audit_readiness'.
  _i3.Stream<_i20.AnalyticsEvent> streamAnalytics(String channel) =>
      caller.callStreamingServerEndpoint<
        _i3.Stream<_i20.AnalyticsEvent>,
        _i20.AnalyticsEvent
      >(
        'analytics',
        'streamAnalytics',
        {'channel': channel},
        {},
      );

  /// Recent activity for employee (last 5 training actions).
  _i3.Future<List<Map<String, dynamic>>> getRecentActivity(int userId) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getRecentActivity',
        {'userId': userId},
      );
}

/// Assessment builder endpoint for SME/trainers.
/// {@category Endpoint}
class EndpointAssessmentBuilder extends _i2.EndpointRef {
  EndpointAssessmentBuilder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assessmentBuilder';

  _i3.Future<_i21.Question> createQuestion({
    required int questionBankId,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
  }) => caller.callServerEndpoint<_i21.Question>(
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

  _i3.Future<_i21.Question> updateQuestion({
    required int questionId,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    String? difficulty,
  }) => caller.callServerEndpoint<_i21.Question>(
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

  _i3.Future<_i22.Assessment> createAssessment({
    required int courseVersionId,
    required int questionBankId,
    required int passingScore,
    required bool randomize,
    int? timeLimitMinutes,
  }) => caller.callServerEndpoint<_i22.Assessment>(
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

  _i3.Future<_i22.Assessment> updateAssessment({
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
  }) => caller.callServerEndpoint<_i22.Assessment>(
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

  _i3.Future<_i22.Assessment?> getAssessmentForCourse(int courseVersionId) =>
      caller.callServerEndpoint<_i22.Assessment?>(
        'assessment',
        'getAssessmentForCourse',
        {'courseVersionId': courseVersionId},
      );

  _i3.Future<List<_i21.Question>> getQuestions(int questionBankId) =>
      caller.callServerEndpoint<List<_i21.Question>>(
        'assessment',
        'getQuestions',
        {'questionBankId': questionBankId},
      );

  _i3.Future<_i23.AssessmentAttempt> startAttempt({
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<_i23.AssessmentAttempt>(
    'assessment',
    'startAttempt',
    {
      'userId': userId,
      'assessmentId': assessmentId,
      'enrollmentId': enrollmentId,
    },
  );

  /// Get attempt count for user+assessment+enrollment (for "Attempt X of Y" display).
  _i3.Future<int> getAttemptCount({
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<int>(
    'assessment',
    'getAttemptCount',
    {
      'userId': userId,
      'assessmentId': assessmentId,
      'enrollmentId': enrollmentId,
    },
  );

  _i3.Future<_i23.AssessmentAttempt> submitAttempt({required int attemptId}) =>
      caller.callServerEndpoint<_i23.AssessmentAttempt>(
        'assessment',
        'submitAttempt',
        {'attemptId': attemptId},
      );

  _i3.Future<_i24.AssessmentResult> recordAnswer({
    required int attemptId,
    required int questionId,
    required String answer,
  }) => caller.callServerEndpoint<_i24.AssessmentResult>(
    'assessment',
    'recordAnswer',
    {
      'attemptId': attemptId,
      'questionId': questionId,
      'answer': answer,
    },
  );

  _i3.Future<List<_i25.QuestionBank>> listQuestionBanks({
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i25.QuestionBank>>(
    'assessment',
    'listQuestionBanks',
    {'organizationId': organizationId},
  );

  _i3.Future<_i25.QuestionBank> createQuestionBank({
    required String name,
    required int organizationId,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i25.QuestionBank>(
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

  /// Log report export with integrity hash (21 CFR Part 11). Creates ReportExport record.
  _i3.Future<void> logReportExport({
    required String reportType,
    required String hashSha256,
    int? exportedById,
    String? filterParamsJson,
    int? recordCount,
  }) => caller.callServerEndpoint<void>(
    'audit',
    'logReportExport',
    {
      'reportType': reportType,
      'hashSha256': hashSha256,
      'exportedById': exportedById,
      'filterParamsJson': filterParamsJson,
      'recordCount': recordCount,
    },
  );

  _i3.Future<List<_i26.AuditTrail>> getAuditTrail({
    String? entityType,
    String? entityId,
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<List<_i26.AuditTrail>>(
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

  /// Config change log - filter AuditTrail where action=='ConfigChanged' or entityType matches config entities.
  _i3.Future<List<_i26.AuditTrail>> getConfigChangeLog({
    String? entityType,
    required int limit,
    DateTime? from,
    DateTime? to,
  }) => caller.callServerEndpoint<List<_i26.AuditTrail>>(
    'audit',
    'getConfigChangeLog',
    {
      'entityType': entityType,
      'limit': limit,
      'from': from,
      'to': to,
    },
  );

  _i3.Future<List<_i27.AccessLog>> getAccessLogs({
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<List<_i27.AccessLog>>(
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

  _i3.Future<_i28.ComplianceMetrics> getDepartmentCompliance(
    int departmentId, {
    DateTime? asOf,
  }) => caller.callServerEndpoint<_i28.ComplianceMetrics>(
    'compliance',
    'getDepartmentCompliance',
    {
      'departmentId': departmentId,
      'asOf': asOf,
    },
  );

  _i3.Future<_i29.UserComplianceMetrics> getUserCompliance(
    int userId, {
    DateTime? asOf,
  }) => caller.callServerEndpoint<_i29.UserComplianceMetrics>(
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

  _i3.Future<_i30.Module> createModule({
    required int courseVersionId,
    required String title,
    required int orderIndex,
  }) => caller.callServerEndpoint<_i30.Module>(
    'courseBuilder',
    'createModule',
    {
      'courseVersionId': courseVersionId,
      'title': title,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i30.Module> updateModule({
    required int moduleId,
    String? title,
    int? orderIndex,
  }) => caller.callServerEndpoint<_i30.Module>(
    'courseBuilder',
    'updateModule',
    {
      'moduleId': moduleId,
      'title': title,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i31.Lesson> createLesson({
    required int moduleId,
    required String title,
    required int materialId,
    required int orderIndex,
    int? durationMinutes,
  }) => caller.callServerEndpoint<_i31.Lesson>(
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

  _i3.Future<_i31.Lesson> updateLesson({
    required int lessonId,
    String? title,
    int? materialId,
    int? orderIndex,
    int? durationMinutes,
  }) => caller.callServerEndpoint<_i31.Lesson>(
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
  /// When superseding (hasApproved), changeSummary is required (TRN-05).
  _i3.Future<_i32.CourseVersion> createCourseVersion({
    required int courseId,
    required String version,
    required String status,
    String? changeSummary,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'courseBuilder',
    'createCourseVersion',
    {
      'courseId': courseId,
      'version': version,
      'status': status,
      'changeSummary': changeSummary,
    },
  );

  /// Update course version status. TC-07: approved/effective -> no edit.
  /// Lifecycle: draft -> pending_approval (SME) -> effective (QA). Only QA can set effective.
  _i3.Future<_i32.CourseVersion> updateCourseVersionStatus({
    required int courseVersionId,
    required String status,
    int? approverId,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'courseBuilder',
    'updateCourseVersionStatus',
    {
      'courseVersionId': courseVersionId,
      'status': status,
      'approverId': approverId,
    },
  );
}

/// Course & Curriculum domain endpoint.
/// {@category Endpoint}
class EndpointCourse extends _i2.EndpointRef {
  EndpointCourse(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'course';

  _i3.Future<List<_i33.Course>> listCourses({
    int? organizationId,
    String? status,
  }) => caller.callServerEndpoint<List<_i33.Course>>(
    'course',
    'listCourses',
    {
      'organizationId': organizationId,
      'status': status,
    },
  );

  _i3.Future<_i33.Course?> getCourse(int id) =>
      caller.callServerEndpoint<_i33.Course?>(
        'course',
        'getCourse',
        {'id': id},
      );

  _i3.Future<List<_i32.CourseVersion>> getCourseVersions(int courseId) =>
      caller.callServerEndpoint<List<_i32.CourseVersion>>(
        'course',
        'getCourseVersions',
        {'courseId': courseId},
      );

  _i3.Future<_i32.CourseVersion?> getCourseVersion(int courseVersionId) =>
      caller.callServerEndpoint<_i32.CourseVersion?>(
        'course',
        'getCourseVersion',
        {'courseVersionId': courseVersionId},
      );

  _i3.Future<_i33.Course> createCourse({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) => caller.callServerEndpoint<_i33.Course>(
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

  _i3.Future<List<_i30.Module>> getModulesForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i30.Module>>(
    'course',
    'getModulesForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  _i3.Future<List<_i31.Lesson>> getLessonsForModule(int moduleId) =>
      caller.callServerEndpoint<List<_i31.Lesson>>(
        'course',
        'getLessonsForModule',
        {'moduleId': moduleId},
      );

  _i3.Future<_i31.Lesson?> getLessonWithMaterial(int lessonId) =>
      caller.callServerEndpoint<_i31.Lesson?>(
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

  _i3.Future<List<_i34.Document>> listDocuments({
    int? organizationId,
    String? documentType,
  }) => caller.callServerEndpoint<List<_i34.Document>>(
    'document',
    'listDocuments',
    {
      'organizationId': organizationId,
      'documentType': documentType,
    },
  );

  _i3.Future<_i34.Document?> getDocument(int id) =>
      caller.callServerEndpoint<_i34.Document?>(
        'document',
        'getDocument',
        {'id': id},
      );

  /// QA gate: classify SOP update as training_required or no_training_required.
  _i3.Future<_i34.Document> updateDocumentQaClassification({
    required int documentId,
    required String trainingRequiredByQa,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
  }) => caller.callServerEndpoint<_i34.Document>(
    'document',
    'updateDocumentQaClassification',
    {
      'documentId': documentId,
      'trainingRequiredByQa': trainingRequiredByQa,
      'affectedDepartmentIdsJson': affectedDepartmentIdsJson,
      'affectedRoleIdsJson': affectedRoleIdsJson,
    },
  );

  _i3.Future<List<_i35.DocumentVersion>> getDocumentVersions(int documentId) =>
      caller.callServerEndpoint<List<_i35.DocumentVersion>>(
        'document',
        'getDocumentVersions',
        {'documentId': documentId},
      );

  _i3.Future<_i34.Document> createDocument({
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i34.Document>(
    'document',
    'createDocument',
    {
      'title': title,
      'documentNumber': documentNumber,
      'documentType': documentType,
      'organizationId': organizationId,
    },
  );

  _i3.Future<_i35.DocumentVersion> createDocumentVersion({
    required int documentId,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
  }) => caller.callServerEndpoint<_i35.DocumentVersion>(
    'document',
    'createDocumentVersion',
    {
      'documentId': documentId,
      'version': version,
      'storageKey': storageKey,
      'effectiveDate': effectiveDate,
      'obsoleteDate': obsoleteDate,
      'versionMajor': versionMajor,
      'versionMinor': versionMinor,
      'isMajorVersion': isMajorVersion,
    },
  );

  _i3.Future<List<_i36.DocumentLifecycle>> getDocumentLifecycle(
    int documentVersionId,
  ) => caller.callServerEndpoint<List<_i36.DocumentLifecycle>>(
    'document',
    'getDocumentLifecycle',
    {'documentVersionId': documentVersionId},
  );

  /// Transition document version lifecycle (QA-02). Enforces: draft→review→approved→effective→obsolete.
  /// Approved/Effective require QA e-sign. Obsolete requires reason.
  _i3.Future<_i36.DocumentLifecycle> transitionDocumentLifecycle({
    required int documentVersionId,
    required String newState,
    String? obsoleteReason,
    required int userId,
    required String signatureMeaning,
    String? passwordReauth,
    String? ipAddress,
  }) => caller.callServerEndpoint<_i36.DocumentLifecycle>(
    'document',
    'transitionDocumentLifecycle',
    {
      'documentVersionId': documentVersionId,
      'newState': newState,
      'obsoleteReason': obsoleteReason,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordReauth': passwordReauth,
      'ipAddress': ipAddress,
    },
  );

  _i3.Future<_i37.ApprovalWorkflow> createApprovalStep({
    required int documentVersionId,
    required int step,
    required int approverId,
    required String status,
    int? esignatureId,
  }) => caller.callServerEndpoint<_i37.ApprovalWorkflow>(
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

  /// Trigger employee transferred event - assigns delta training for new role/dept.
  _i3.Future<void> triggerEmployeeTransferred({
    required String userId,
    required String oldDepartmentId,
    required String newDepartmentId,
    required String oldRoleId,
    required String newRoleId,
  }) => caller.callServerEndpoint<void>(
    'event',
    'triggerEmployeeTransferred',
    {
      'userId': userId,
      'oldDepartmentId': oldDepartmentId,
      'newDepartmentId': newDepartmentId,
      'oldRoleId': oldRoleId,
      'newRoleId': newRoleId,
    },
  );
}

/// Inspection and auditor access endpoint.
/// {@category Endpoint}
class EndpointInspection extends _i2.EndpointRef {
  EndpointInspection(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'inspection';

  /// List inspection records (for Admin/QA).
  _i3.Future<List<_i38.InspectionRecord>> listInspectionRecords({
    required int limit,
  }) => caller.callServerEndpoint<List<_i38.InspectionRecord>>(
    'inspection',
    'listInspectionRecords',
    {'limit': limit},
  );

  /// Create inspection record and generate time-limited access token.
  _i3.Future<Map<String, dynamic>> createInspectionRecord({
    required String inspectionType,
    required int siteId,
    String? scopeDescription,
    DateTime? scheduledDate,
    String? inspectorNames,
    required int tokenHoursValid,
    int? createdById,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'inspection',
    'createInspectionRecord',
    {
      'inspectionType': inspectionType,
      'siteId': siteId,
      'scopeDescription': scopeDescription,
      'scheduledDate': scheduledDate,
      'inspectorNames': inspectorNames,
      'tokenHoursValid': tokenHoursValid,
      'createdById': createdById,
    },
  );

  /// Validate auditor token and return session scope.
  _i3.Future<Map<String, dynamic>?> validateAuditorToken({
    required String token,
  }) => caller.callServerEndpoint<Map<String, dynamic>?>(
    'inspection',
    'validateAuditorToken',
    {'token': token},
  );

  /// List page logs for an inspection record (for auditor session widget).
  _i3.Future<List<_i39.AuditorPageLog>> listAuditorPageLogs({
    required int inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i39.AuditorPageLog>>(
    'inspection',
    'listAuditorPageLogs',
    {
      'inspectionRecordId': inspectionRecordId,
      'limit': limit,
    },
  );

  /// Log auditor page view.
  _i3.Future<void> logAuditorPageView({
    required int inspectionRecordId,
    required String pageUrl,
    String? pageTitle,
    String? entityType,
    String? entityId,
    int? timeOnPageSeconds,
  }) => caller.callServerEndpoint<void>(
    'inspection',
    'logAuditorPageView',
    {
      'inspectionRecordId': inspectionRecordId,
      'pageUrl': pageUrl,
      'pageTitle': pageTitle,
      'entityType': entityType,
      'entityId': entityId,
      'timeOnPageSeconds': timeOnPageSeconds,
    },
  );

  /// List inspection packages for a record (for Admin/QA).
  _i3.Future<List<_i40.InspectionPackage>> listInspectionPackages({
    required int inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i40.InspectionPackage>>(
    'inspection',
    'listInspectionPackages',
    {
      'inspectionRecordId': inspectionRecordId,
      'limit': limit,
    },
  );

  /// Generate evidence package for auditor (token-based). One-click from auditor portal.
  _i3.Future<Map<String, dynamic>> generateEvidencePackageForAuditor({
    required String token,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'inspection',
    'generateEvidencePackageForAuditor',
    {'token': token},
  );

  /// Generate inspection package (summary of in-scope records).
  /// Creates package with isOfficial: false; QA Director must sign to make official.
  _i3.Future<Map<String, dynamic>> generateInspectionPackage({
    required int inspectionRecordId,
    required int generatedById,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'inspection',
    'generateInspectionPackage',
    {
      'inspectionRecordId': inspectionRecordId,
      'generatedById': generatedById,
    },
  );

  /// Sign inspection package as official (QA Director e-sign). ADM-10.
  /// Requires QA Director, Admin, or QA role.
  _i3.Future<_i40.InspectionPackage> signInspectionPackageAsOfficial({
    required int packageId,
    required int userId,
    required String signatureMeaning,
    String? passwordReauth,
    String? ipAddress,
  }) => caller.callServerEndpoint<_i40.InspectionPackage>(
    'inspection',
    'signInspectionPackageAsOfficial',
    {
      'packageId': packageId,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordReauth': passwordReauth,
      'ipAddress': ipAddress,
    },
  );

  /// AUD-02: Search employees for audit with full training chain.
  /// Returns users matching query (by name, email, or ID) with assignments,
  /// enrollments, training records, certificates.
  _i3.Future<List<Map<String, dynamic>>> searchEmployeesForAudit({
    required String query,
    int? inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<Map<String, dynamic>>>(
    'inspection',
    'searchEmployeesForAudit',
    {
      'query': query,
      'inspectionRecordId': inspectionRecordId,
      'limit': limit,
    },
  );

  /// AUD-03: SOP training coverage - qualified vs non-qualified users.
  /// qualified = completed training for that SOP/course version.
  /// nonQualified = users in affected depts/roles who haven't completed.
  _i3.Future<Map<String, dynamic>> getSopTrainingCoverage({
    required int sopDocumentId,
    required int versionId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'inspection',
    'getSopTrainingCoverage',
    {
      'sopDocumentId': sopDocumentId,
      'versionId': versionId,
    },
  );
}

/// Material & progress endpoint (M1 + M2 upload).
/// {@category Endpoint}
class EndpointMaterial extends _i2.EndpointRef {
  EndpointMaterial(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'material';

  _i3.Future<_i41.Material?> getMaterial(int id) =>
      caller.callServerEndpoint<_i41.Material?>(
        'material',
        'getMaterial',
        {'id': id},
      );

  /// Get public URL for viewing material content (PDF, video, SCORM, etc.).
  /// SCORM: storage key format materials/{id}/scorm/index.html for zip packages.
  _i3.Future<String?> getMaterialViewUrl(String storageKey) =>
      caller.callServerEndpoint<String?>(
        'material',
        'getMaterialViewUrl',
        {'storageKey': storageKey},
      );

  _i3.Future<_i41.Material> createMaterial({
    required String title,
    required String materialType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i41.Material>(
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
  _i3.Future<_i42.MaterialVersion> createMaterialVersion({
    required int materialId,
    required String storageKey,
  }) => caller.callServerEndpoint<_i42.MaterialVersion>(
    'material',
    'createMaterialVersion',
    {
      'materialId': materialId,
      'storageKey': storageKey,
    },
  );

  _i3.Future<List<_i42.MaterialVersion>> getMaterialVersions(int materialId) =>
      caller.callServerEndpoint<List<_i42.MaterialVersion>>(
        'material',
        'getMaterialVersions',
        {'materialId': materialId},
      );

  _i3.Future<List<_i41.Material>> listMaterials({
    required int organizationId,
  }) => caller.callServerEndpoint<List<_i41.Material>>(
    'material',
    'listMaterials',
    {'organizationId': organizationId},
  );

  /// Update or create material progress for minimum read time / pausable learning.
  /// Server-enforced: when progressPct=100 or completedAt is set, requires
  /// timeSpentSeconds >= lesson.durationMinutes*60, readTimeMet=true, and
  /// for video: videoWatchedPct>=90, for pdf: pdfScrollPct>=80 in interactionJson.
  _i3.Future<_i43.MaterialProgress> updateProgress({
    required int userId,
    required int materialId,
    required int progressPct,
    DateTime? completedAt,
    String? interactionJson,
    int? timeSpentSeconds,
    bool? readTimeMet,
    int? materialVersionId,
    int? enrollmentId,
    int? lessonId,
  }) => caller.callServerEndpoint<_i43.MaterialProgress>(
    'material',
    'updateProgress',
    {
      'userId': userId,
      'materialId': materialId,
      'progressPct': progressPct,
      'completedAt': completedAt,
      'interactionJson': interactionJson,
      'timeSpentSeconds': timeSpentSeconds,
      'readTimeMet': readTimeMet,
      'materialVersionId': materialVersionId,
      'enrollmentId': enrollmentId,
      'lessonId': lessonId,
    },
  );

  _i3.Future<_i43.MaterialProgress?> getProgress({
    required int userId,
    required int materialId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<_i43.MaterialProgress?>(
    'material',
    'getProgress',
    {
      'userId': userId,
      'materialId': materialId,
      'enrollmentId': enrollmentId,
    },
  );

  /// Heartbeat: record engagement (tab_focused, scroll_depth, play_position).
  /// Server accumulates timeSpentSeconds only when tabFocused; sets readTimeMet
  /// when all conditions met (time, PDF scroll 80%, video 90%).
  /// videoPositionSeconds and scrollDepthPct stored for resume-from-last-position.
  _i3.Future<_i43.MaterialProgress> recordEngagement({
    required int userId,
    required int materialId,
    required int lessonId,
    int? enrollmentId,
    required bool tabFocused,
    int? scrollDepthPct,
    int? videoWatchedPct,
    int? videoPositionSeconds,
    required int deltaSeconds,
  }) => caller.callServerEndpoint<_i43.MaterialProgress>(
    'material',
    'recordEngagement',
    {
      'userId': userId,
      'materialId': materialId,
      'lessonId': lessonId,
      'enrollmentId': enrollmentId,
      'tabFocused': tabFocused,
      'scrollDepthPct': scrollDepthPct,
      'videoWatchedPct': videoWatchedPct,
      'videoPositionSeconds': videoPositionSeconds,
      'deltaSeconds': deltaSeconds,
    },
  );
}

/// MFA (TOTP) endpoint: enroll, verify, status, disable.
/// Uses otp package for RFC6238 TOTP compatible with Google Authenticator.
/// {@category Endpoint}
class EndpointMfa extends _i2.EndpointRef {
  EndpointMfa(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mfa';

  /// Returns MFA status for the current user. Requires auth.
  _i3.Future<_i44.MfaStatusResult> getMfaStatus() =>
      caller.callServerEndpoint<_i44.MfaStatusResult>(
        'mfa',
        'getMfaStatus',
        {},
      );

  /// Starts MFA enrollment. Generates secret and returns it for QR setup.
  _i3.Future<_i45.MfaEnrollResult> enrollMfa() =>
      caller.callServerEndpoint<_i45.MfaEnrollResult>(
        'mfa',
        'enrollMfa',
        {},
      );

  /// Verifies the TOTP code and enables MFA.
  _i3.Future<bool> verifyMfaEnrollment(String code) =>
      caller.callServerEndpoint<bool>(
        'mfa',
        'verifyMfaEnrollment',
        {'code': code},
      );

  /// Verifies TOTP code for login. Records session as MFA-verified.
  _i3.Future<bool> verifyMfa(String code) => caller.callServerEndpoint<bool>(
    'mfa',
    'verifyMfa',
    {'code': code},
  );

  /// Disables MFA for the current user.
  _i3.Future<void> disableMfa() => caller.callServerEndpoint<void>(
    'mfa',
    'disableMfa',
    {},
  );

  /// Checks if the current session has passed MFA verification.
  _i3.Future<bool> isMfaVerified() => caller.callServerEndpoint<bool>(
    'mfa',
    'isMfaVerified',
    {},
  );
}

/// Notification domain endpoint (in-app; no email/push in stub).
/// {@category Endpoint}
class EndpointNotification extends _i2.EndpointRef {
  EndpointNotification(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  /// Get in-app notifications: assignment due, overdue from TrainingAssignment.
  _i3.Future<List<_i46.InAppNotification>> getInAppNotifications(int userId) =>
      caller.callServerEndpoint<List<_i46.InAppNotification>>(
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

  _i3.Future<List<_i47.Organization>> listOrganizations() =>
      caller.callServerEndpoint<List<_i47.Organization>>(
        'organization',
        'listOrganizations',
        {},
      );

  _i3.Future<_i47.Organization?> getOrganization(int id) =>
      caller.callServerEndpoint<_i47.Organization?>(
        'organization',
        'getOrganization',
        {'id': id},
      );

  _i3.Future<_i47.Organization> createOrganization({
    required String name,
    required String code,
  }) => caller.callServerEndpoint<_i47.Organization>(
    'organization',
    'createOrganization',
    {
      'name': name,
      'code': code,
    },
  );

  _i3.Future<List<_i48.Site>> listSites(int organizationId) =>
      caller.callServerEndpoint<List<_i48.Site>>(
        'organization',
        'listSites',
        {'organizationId': organizationId},
      );

  _i3.Future<List<_i49.Department>> listDepartments(int siteId) =>
      caller.callServerEndpoint<List<_i49.Department>>(
        'organization',
        'listDepartments',
        {'siteId': siteId},
      );

  _i3.Future<List<_i9.JobRole>> listJobRoles(int departmentId) =>
      caller.callServerEndpoint<List<_i9.JobRole>>(
        'organization',
        'listJobRoles',
        {'departmentId': departmentId},
      );

  _i3.Future<List<_i17.PharmaUser>> listUsers({
    int? organizationId,
    int? departmentId,
  }) => caller.callServerEndpoint<List<_i17.PharmaUser>>(
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
  _i3.Future<List<_i32.CourseVersion>> listPendingCourseVersions() =>
      caller.callServerEndpoint<List<_i32.CourseVersion>>(
        'qa',
        'listPendingCourseVersions',
        {},
      );

  /// Approve and publish a course version (QA sign-off). Sets status to effective.
  /// Marks previous effective versions obsolete and their certificates obsolete.
  /// reviewChecklistJson: QA-WF-01 structured checklist (content accuracy, etc.)
  _i3.Future<_i32.CourseVersion> approveCourseVersion({
    required int courseVersionId,
    int? approverId,
    String? reviewChecklistJson,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'qa',
    'approveCourseVersion',
    {
      'courseVersionId': courseVersionId,
      'approverId': approverId,
      'reviewChecklistJson': reviewChecklistJson,
    },
  );

  /// Reject a course version (return to draft). Optionally return for changes.
  _i3.Future<_i32.CourseVersion> rejectCourseVersion({
    required int courseVersionId,
    String? reason,
    required bool returnForChanges,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'qa',
    'rejectCourseVersion',
    {
      'courseVersionId': courseVersionId,
      'reason': reason,
      'returnForChanges': returnForChanges,
    },
  );
}

/// Quality Event Integration domain endpoint.
/// {@category Endpoint}
class EndpointQualityEvent extends _i2.EndpointRef {
  EndpointQualityEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'qualityEvent';

  _i3.Future<List<_i50.QualityEvent>> listQualityEvents({
    int? siteId,
    String? eventType,
    String? status,
  }) => caller.callServerEndpoint<List<_i50.QualityEvent>>(
    'qualityEvent',
    'listQualityEvents',
    {
      'siteId': siteId,
      'eventType': eventType,
      'status': status,
    },
  );

  _i3.Future<_i50.QualityEvent?> getQualityEvent(int id) =>
      caller.callServerEndpoint<_i50.QualityEvent?>(
        'qualityEvent',
        'getQualityEvent',
        {'id': id},
      );

  _i3.Future<List<_i19.Capa>> listCapas({
    int? qualityEventId,
    String? status,
  }) => caller.callServerEndpoint<List<_i19.Capa>>(
    'qualityEvent',
    'listCapas',
    {
      'qualityEventId': qualityEventId,
      'status': status,
    },
  );

  _i3.Future<_i50.QualityEvent> createQualityEvent({
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) => caller.callServerEndpoint<_i50.QualityEvent>(
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

  /// Update CAPA lifecycle status. Enforces valid state machine transitions.
  _i3.Future<_i19.Capa> updateCapaStatus({
    required int capaId,
    required String status,
    String? rootCause,
    DateTime? rcaCompletedAt,
  }) => caller.callServerEndpoint<_i19.Capa>(
    'qualityEvent',
    'updateCapaStatus',
    {
      'capaId': capaId,
      'status': status,
      'rootCause': rootCause,
      'rcaCompletedAt': rcaCompletedAt,
    },
  );

  /// Close CAPA (QA verifies no recurrence).
  /// Requires: status must be Verification; if trainingRequired, effectivenessCheckDue must be set.
  _i3.Future<_i19.Capa> closeCapa({
    required int capaId,
    required int closedById,
  }) => caller.callServerEndpoint<_i19.Capa>(
    'qualityEvent',
    'closeCapa',
    {
      'capaId': capaId,
      'closedById': closedById,
    },
  );

  _i3.Future<_i19.Capa> createCapa({
    required int qualityEventId,
    String? description,
    String? rootCause,
    required bool trainingRequired,
  }) => caller.callServerEndpoint<_i19.Capa>(
    'qualityEvent',
    'createCapa',
    {
      'qualityEventId': qualityEventId,
      'description': description,
      'rootCause': rootCause,
      'trainingRequired': trainingRequired,
    },
  );

  _i3.Future<_i7.TrainingAssignment?> assignTrainingFromCapa({
    required int capaId,
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
  }) => caller.callServerEndpoint<_i7.TrainingAssignment?>(
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

  _i3.Future<List<_i51.InspectionReport>> listInspectionReports({
    int? organizationId,
    int? siteId,
  }) => caller.callServerEndpoint<List<_i51.InspectionReport>>(
    'qualityEvent',
    'listInspectionReports',
    {
      'organizationId': organizationId,
      'siteId': siteId,
    },
  );

  _i3.Future<_i51.InspectionReport> createInspectionReport({
    required int organizationId,
    required String status,
    int? siteId,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
  }) => caller.callServerEndpoint<_i51.InspectionReport>(
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
/// Call runMvpSeed() for full MVP dataset (32 users, 6 courses, 500+ audit entries).
/// {@category Endpoint}
class EndpointSeed extends _i2.EndpointRef {
  EndpointSeed(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  /// Seeds the database with sample data if empty. Idempotent - skips if org exists.
  /// Signature meanings are always seeded if empty (for existing DBs).
  _i3.Future<String> runSeed() => caller.callServerEndpoint<String>(
    'seed',
    'runSeed',
    {},
  );

  /// Seeds the full MVP dataset: 32 users, 6 courses, 18 modules, 54 lessons,
  /// 6 assessments, 120 questions, training matrix, assignments, enrollments,
  /// e-signatures, certificates, quality events, CAPAs, waivers, audit trail, etc.
  /// Idempotent - skips if org "PharmaCorp International Ltd" exists.
  _i3.Future<String> runMvpSeed() => caller.callServerEndpoint<String>(
    'seed',
    'runMvpSeed',
    {},
  );
}

/// Training Assignment domain endpoint.
/// {@category Endpoint}
class EndpointTraining extends _i2.EndpointRef {
  EndpointTraining(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'training';

  /// List active signature meanings for e-signature dropdown (21 CFR Part 11).
  _i3.Future<List<_i6.SignatureMeaning>> listSignatureMeanings() =>
      caller.callServerEndpoint<List<_i6.SignatureMeaning>>(
        'training',
        'listSignatureMeanings',
        {},
      );

  _i3.Future<List<_i7.TrainingAssignment>> getAssignmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i7.TrainingAssignment>>(
        'training',
        'getAssignmentsForUser',
        {'userId': userId},
      );

  _i3.Future<_i7.TrainingAssignment> assignTraining({
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    required String priority,
    String? reason,
    required String source,
    required bool forceReassign,
  }) => caller.callServerEndpoint<_i7.TrainingAssignment>(
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
      'forceReassign': forceReassign,
    },
  );

  /// Update assignment due date or priority.
  _i3.Future<_i7.TrainingAssignment> updateAssignment({
    required int assignmentId,
    DateTime? dueDate,
    String? priority,
    required int updatedById,
  }) => caller.callServerEndpoint<_i7.TrainingAssignment>(
    'training',
    'updateAssignment',
    {
      'assignmentId': assignmentId,
      'dueDate': dueDate,
      'priority': priority,
      'updatedById': updatedById,
    },
  );

  /// Cancel an assignment.
  _i3.Future<_i7.TrainingAssignment> cancelAssignment({
    required int assignmentId,
    required int cancelledById,
    String? reason,
  }) => caller.callServerEndpoint<_i7.TrainingAssignment>(
    'training',
    'cancelAssignment',
    {
      'assignmentId': assignmentId,
      'cancelledById': cancelledById,
      'reason': reason,
    },
  );

  _i3.Future<List<_i52.Enrollment>> getEnrollmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i52.Enrollment>>(
        'training',
        'getEnrollmentsForUser',
        {'userId': userId},
      );

  /// Resume position for in-progress enrollment (e.g. "Module 2, Lesson 3").
  _i3.Future<String?> getEnrollmentResumePosition(int enrollmentId) =>
      caller.callServerEndpoint<String?>(
        'training',
        'getEnrollmentResumePosition',
        {'enrollmentId': enrollmentId},
      );

  /// Get enrollment by ID for course viewer (e.g. to check retraining gate).
  _i3.Future<_i52.Enrollment?> getEnrollmentById(int enrollmentId) =>
      caller.callServerEndpoint<_i52.Enrollment?>(
        'training',
        'getEnrollmentById',
        {'enrollmentId': enrollmentId},
      );

  /// Acknowledge retraining change summary with e-signature.
  /// Requires: enrollment has retrainingChangeSummary, acknowledgedAt is null, userId matches.
  _i3.Future<_i52.Enrollment> acknowledgeRetraining({
    required int enrollmentId,
    required int userId,
    required String signatureMeaning,
    String? passwordReauth,
  }) => caller.callServerEndpoint<_i52.Enrollment>(
    'training',
    'acknowledgeRetraining',
    {
      'enrollmentId': enrollmentId,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordReauth': passwordReauth,
    },
  );

  _i3.Future<List<_i18.Certificate>> getCertificatesForUser(int userId) =>
      caller.callServerEndpoint<List<_i18.Certificate>>(
        'training',
        'getCertificatesForUser',
        {'userId': userId},
      );

  /// Training records for user (enrollment completions with score). Used for training history.
  _i3.Future<List<_i53.TrainingRecord>> getTrainingRecordsForUser(int userId) =>
      caller.callServerEndpoint<List<_i53.TrainingRecord>>(
        'training',
        'getTrainingRecordsForUser',
        {'userId': userId},
      );

  /// Get certificate by ID for verification and direct links.
  _i3.Future<_i18.Certificate?> getCertificateById(int certificateId) =>
      caller.callServerEndpoint<_i18.Certificate?>(
        'training',
        'getCertificateById',
        {'certificateId': certificateId},
      );

  /// Get signature with integrity verification. Returns null signature if not found.
  /// integrityViolation is true when HMAC mismatch (tampering detected).
  _i3.Future<_i54.SignatureVerificationResult> getSignatureWithIntegrityCheck(
    int signatureId,
  ) => caller.callServerEndpoint<_i54.SignatureVerificationResult>(
    'training',
    'getSignatureWithIntegrityCheck',
    {'signatureId': signatureId},
  );

  /// List electronic signatures for auditor verification (21 CFR Part 11).
  _i3.Future<List<_i55.ElectronicSignature>> listElectronicSignatures({
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i55.ElectronicSignature>>(
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

  /// Issue a short-lived biometric token after password verification (plan 6B).
  _i3.Future<String> issueBiometricToken({
    required int userId,
    required String passwordReauth,
  }) => caller.callServerEndpoint<String>(
    'training',
    'issueBiometricToken',
    {
      'userId': userId,
      'passwordReauth': passwordReauth,
    },
  );

  /// Create electronic signature for training completion (called after e-sign UI).
  /// passwordReauth: plaintext password for re-authentication (sent over HTTPS).
  /// biometricToken: short-lived token from issueBiometricToken (plan 6B).
  _i3.Future<int> createTrainingSignature({
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordReauth,
    String? biometricToken,
    String? ipAddress,
  }) => caller.callServerEndpoint<int>(
    'training',
    'createTrainingSignature',
    {
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'entityType': entityType,
      'entityId': entityId,
      'passwordReauth': passwordReauth,
      'biometricToken': biometricToken,
      'ipAddress': ipAddress,
    },
  );

  /// Complete training: create TrainingRecord, Certificate, update Enrollment.
  /// Call after assessment pass and e-signature.
  /// Idempotent: returns existing certificate if already completed for this enrollment.
  _i3.Future<_i18.Certificate> completeTraining({
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required int esignatureId,
    int? score,
  }) => caller.callServerEndpoint<_i18.Certificate>(
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

  /// QA-08: List annotations for a training record.
  _i3.Future<List<_i56.TrainingRecordAnnotation>> listAnnotations(
    int trainingRecordId,
  ) => caller.callServerEndpoint<List<_i56.TrainingRecordAnnotation>>(
    'training',
    'listAnnotations',
    {'trainingRecordId': trainingRecordId},
  );

  /// QA-08: Add annotation to a training record (QA role).
  _i3.Future<_i56.TrainingRecordAnnotation> addAnnotation({
    required int trainingRecordId,
    required int authorId,
    required String note,
  }) => caller.callServerEndpoint<_i56.TrainingRecordAnnotation>(
    'training',
    'addAnnotation',
    {
      'trainingRecordId': trainingRecordId,
      'authorId': authorId,
      'note': note,
    },
  );
}

/// User-centric endpoint for employee operations.
/// {@category Endpoint}
class EndpointUser extends _i2.EndpointRef {
  EndpointUser(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i3.Future<_i17.PharmaUser?> getUser(int id) =>
      caller.callServerEndpoint<_i17.PharmaUser?>(
        'user',
        'getUser',
        {'id': id},
      );

  _i3.Future<_i17.PharmaUser?> getUserByEmail(String email) =>
      caller.callServerEndpoint<_i17.PharmaUser?>(
        'user',
        'getUserByEmail',
        {'email': email},
      );
}

/// Validation documentation endpoint for GxP compliance.
/// Provides templates for URS, FS, DS, IQ, OQ, PQ, and traceability matrix.
/// {@category Endpoint}
class EndpointValidation extends _i2.EndpointRef {
  EndpointValidation(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'validation';

  /// Returns User Requirements Specification (URS) template as markdown.
  _i3.Future<String> generateUrs() => caller.callServerEndpoint<String>(
    'validation',
    'generateUrs',
    {},
  );

  /// Returns Functional Specification (FS) template as markdown.
  _i3.Future<String> generateFs() => caller.callServerEndpoint<String>(
    'validation',
    'generateFs',
    {},
  );

  /// Returns Design Specification (DS) template as markdown.
  _i3.Future<String> generateDs() => caller.callServerEndpoint<String>(
    'validation',
    'generateDs',
    {},
  );

  /// Returns Installation Qualification (IQ) template as markdown.
  _i3.Future<String> generateIq() => caller.callServerEndpoint<String>(
    'validation',
    'generateIq',
    {},
  );

  /// Returns Operational Qualification (OQ) template as markdown.
  _i3.Future<String> generateOq() => caller.callServerEndpoint<String>(
    'validation',
    'generateOq',
    {},
  );

  /// Returns Performance Qualification (PQ) template as markdown.
  _i3.Future<String> generatePq() => caller.callServerEndpoint<String>(
    'validation',
    'generatePq',
    {},
  );

  /// Returns traceability matrix mapping requirements to test cases as markdown.
  _i3.Future<String> generateTraceabilityMatrix() =>
      caller.callServerEndpoint<String>(
        'validation',
        'generateTraceabilityMatrix',
        {},
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
  _i3.Future<_i57.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i57.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_core = _i4.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
    auth = _i58.Caller(client);
  }

  late final _i4.Caller serverpod_auth_core;

  late final _i1.Caller serverpod_auth_idp;

  late final _i58.Caller auth;
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
         _i59.Protocol(),
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
    oidcIdp = EndpointOidcIdp(this);
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
    inspection = EndpointInspection(this);
    material = EndpointMaterial(this);
    mfa = EndpointMfa(this);
    notification = EndpointNotification(this);
    organization = EndpointOrganization(this);
    qa = EndpointQa(this);
    qualityEvent = EndpointQualityEvent(this);
    seed = EndpointSeed(this);
    training = EndpointTraining(this);
    user = EndpointUser(this);
    validation = EndpointValidation(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointOidcIdp oidcIdp;

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

  late final EndpointInspection inspection;

  late final EndpointMaterial material;

  late final EndpointMfa mfa;

  late final EndpointNotification notification;

  late final EndpointOrganization organization;

  late final EndpointQa qa;

  late final EndpointQualityEvent qualityEvent;

  late final EndpointSeed seed;

  late final EndpointTraining training;

  late final EndpointUser user;

  late final EndpointValidation validation;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'oidcIdp': oidcIdp,
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
    'inspection': inspection,
    'material': material,
    'mfa': mfa,
    'notification': notification,
    'organization': organization,
    'qa': qa,
    'qualityEvent': qualityEvent,
    'seed': seed,
    'training': training,
    'user': user,
    'validation': validation,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_core': modules.serverpod_auth_core,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'auth': modules.auth,
  };
}
