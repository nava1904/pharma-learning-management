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
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i22;
import 'package:pharma_lms_client/src/protocol/assessment/assessment.dart'
    as _i23;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_attempt.dart'
    as _i24;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_result.dart'
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
import 'package:pharma_lms_client/src/protocol/course/qa_validation_result.dart'
    as _i33;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i34;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i35;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i36;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i37;
import 'package:pharma_lms_client/src/protocol/document/approval_workflow.dart'
    as _i38;
import 'package:pharma_lms_client/src/protocol/audit/inspection_record.dart'
    as _i39;
import 'package:pharma_lms_client/src/protocol/audit/auditor_page_log.dart'
    as _i40;
import 'package:pharma_lms_client/src/protocol/audit/inspection_package.dart'
    as _i41;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i42;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i43;
import 'package:pharma_lms_client/src/protocol/material/material_progress.dart'
    as _i44;
import 'package:pharma_lms_client/src/protocol/mfa/mfa_status_result.dart'
    as _i45;
import 'package:pharma_lms_client/src/protocol/mfa/mfa_enroll_result.dart'
    as _i46;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i47;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i48;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i49;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i50;
import 'package:pharma_lms_client/src/protocol/course/course_review.dart'
    as _i51;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i52;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i53;
import 'package:pharma_lms_client/src/protocol/course/course_sop_link.dart'
    as _i54;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i55;
import 'package:pharma_lms_client/src/protocol/training/training_record.dart'
    as _i56;
import 'package:pharma_lms_client/src/protocol/shared/signature_verification_result.dart'
    as _i57;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i58;
import 'package:pharma_lms_client/src/protocol/training/training_record_annotation.dart'
    as _i59;
import 'package:pharma_lms_client/src/protocol/organization/user_preference.dart'
    as _i60;
import 'package:pharma_lms_client/src/protocol/greetings/greeting.dart' as _i61;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i62;
import 'protocol.dart' as _i63;

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

  /// ADM-WF-07: Terminate a user - HR workflow for employee offboarding.
  /// - Updates PharmaUser status to 'terminated'
  /// - Revokes all active UserSessions
  /// - Supersedes all open TrainingAssignments
  /// - Cancels all not_started/in_progress Enrollments
  /// - Writes UserTerminated audit event
  /// Training records, certificates, e-signatures are RETAINED for compliance.
  _i3.Future<bool> terminateUser({
    required int userId,
    required DateTime terminationDate,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'terminateUser',
    {
      'userId': userId,
      'terminationDate': terminationDate,
      'reason': reason,
    },
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
  /// Supported jobNames: CertExpiryCheck, NotificationWorker, ComplianceCalc, AuditTrailIntegrityCheck
  _i3.Future<Map<String, dynamic>> triggerManualJob({
    required String jobName,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'analytics',
    'triggerManualJob',
    {'jobName': jobName},
  );

  /// SYS-WF-04: Run certificate expiry check job.
  /// Creates renewal assignments for certificates expiring in 30-60 days.
  /// Marks expired certificates and logs to audit trail.
  _i3.Future<Map<String, dynamic>> runCertExpiryCheck() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'runCertExpiryCheck',
        {},
      );

  /// SYS-WF-05: Run notification worker job.
  /// Processes escalation ladder for due/overdue enrollments.
  _i3.Future<Map<String, dynamic>> runNotificationWorker() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'runNotificationWorker',
        {},
      );

  /// SYS-WF-07: Run compliance calculation job.
  /// Computes org-wide and dept-wide compliance, writes snapshots.
  _i3.Future<Map<String, dynamic>> runComplianceCalc() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'runComplianceCalc',
        {},
      );

  /// SYS-WF-08: Run audit trail integrity check (CRITICAL - 21 CFR Part 11).
  /// Verifies SHA-256 hashes and sequence continuity.
  /// Throws exception if integrity issues found.
  _i3.Future<Map<String, dynamic>> runAuditTrailIntegrityCheck() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'runAuditTrailIntegrityCheck',
        {},
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

  /// Get the count of open quality events.
  _i3.Future<int> getOpenQualityEventsCount() => caller.callServerEndpoint<int>(
    'analytics',
    'getOpenQualityEventsCount',
    {},
  );

  /// Get SLA breaches.
  _i3.Future<List<_i16.SlaBreach>> getSlaBreaches() =>
      caller.callServerEndpoint<List<_i16.SlaBreach>>(
        'analytics',
        'getSlaBreaches',
        {},
      );

  /// Get monthly training hours for a user (last 5 months) for the Dashboard chart.
  _i3.Future<List<Map<String, dynamic>>> getMonthlyTrainingHours(int userId) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getMonthlyTrainingHours',
        {'userId': userId},
      );

  /// Get weekly learning progress for a user (last 6 weeks) for the Dashboard area chart.
  _i3.Future<List<Map<String, dynamic>>> getWeeklyLearningProgress(
    int userId,
  ) => caller.callServerEndpoint<List<Map<String, dynamic>>>(
    'analytics',
    'getWeeklyLearningProgress',
    {'userId': userId},
  );

  /// Get user's average quiz score from all completed assessments.
  _i3.Future<double> getUserAverageQuizScore(int userId) =>
      caller.callServerEndpoint<double>(
        'analytics',
        'getUserAverageQuizScore',
        {'userId': userId},
      );

  /// Get user's learning streak (consecutive days of activity).
  _i3.Future<int> getUserLearningStreak(int userId) =>
      caller.callServerEndpoint<int>(
        'analytics',
        'getUserLearningStreak',
        {'userId': userId},
      );

  /// Get upcoming due dates for a user's training assignments.
  _i3.Future<List<Map<String, dynamic>>> getUpcomingDueDates(int userId) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getUpcomingDueDates',
        {'userId': userId},
      );

  /// Get compliance alerts for a user (SOP retraining, overdue, expiring certs).
  _i3.Future<List<Map<String, dynamic>>> getComplianceAlerts(int userId) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getComplianceAlerts',
        {'userId': userId},
      );

  /// Export course analytics as CSV.
  _i3.Future<String> exportCourseAnalyticsCsv({required int courseVersionId}) =>
      caller.callServerEndpoint<String>(
        'analytics',
        'exportCourseAnalyticsCsv',
        {'courseVersionId': courseVersionId},
      );

  /// Export learner progress as CSV.
  _i3.Future<String> exportLearnerProgressCsv({int? organizationId}) =>
      caller.callServerEndpoint<String>(
        'analytics',
        'exportLearnerProgressCsv',
        {'organizationId': organizationId},
      );

  /// Get employee dashboard summary (combines multiple data sources for efficiency).
  _i3.Future<Map<String, dynamic>> getEmployeeDashboardSummary(int userId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getEmployeeDashboardSummary',
        {'userId': userId},
      );
}

/// Assessment builder endpoint for SME/trainers.
/// TRN-WF-03: Build Assessment and Question Bank
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
    String? regulatoryTag,
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
      'regulatoryTag': regulatoryTag,
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

  /// TRN-WF-03: Delete a question from a question bank.
  /// Note: Cannot delete questions if they have been used in completed attempts.
  _i3.Future<bool> deleteQuestion({required int questionId}) =>
      caller.callServerEndpoint<bool>(
        'assessmentBuilder',
        'deleteQuestion',
        {'questionId': questionId},
      );

  /// TRN-WF-03: Create a new question bank.
  _i3.Future<_i22.QuestionBank> createQuestionBank({
    required String name,
    required int organizationId,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i22.QuestionBank>(
    'assessmentBuilder',
    'createQuestionBank',
    {
      'name': name,
      'organizationId': organizationId,
      'tagsJson': tagsJson,
    },
  );

  /// TRN-WF-03: Update question bank metadata.
  _i3.Future<_i22.QuestionBank> updateQuestionBank({
    required int questionBankId,
    String? name,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i22.QuestionBank>(
    'assessmentBuilder',
    'updateQuestionBank',
    {
      'questionBankId': questionBankId,
      'name': name,
      'tagsJson': tagsJson,
    },
  );

  /// TRN-WF-03: Get questions in a bank with count for validation.
  _i3.Future<Map<String, dynamic>> getQuestionBankDetails({
    required int questionBankId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'assessmentBuilder',
    'getQuestionBankDetails',
    {'questionBankId': questionBankId},
  );

  /// TRN-WF-03: Create assessment with 2x question pool validation.
  /// questionsToDisplay must be <= totalQuestions / 2 for adequate randomization.
  _i3.Future<_i23.Assessment> createAssessment({
    required int courseVersionId,
    required int questionBankId,
    required int passingScore,
    required bool randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
  }) => caller.callServerEndpoint<_i23.Assessment>(
    'assessmentBuilder',
    'createAssessment',
    {
      'courseVersionId': courseVersionId,
      'questionBankId': questionBankId,
      'passingScore': passingScore,
      'randomize': randomize,
      'timeLimitMinutes': timeLimitMinutes,
      'maxAttempts': maxAttempts,
      'questionsToDisplay': questionsToDisplay,
    },
  );

  /// TRN-WF-03: Update assessment with 2x question pool validation.
  _i3.Future<_i23.Assessment> updateAssessment({
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
  }) => caller.callServerEndpoint<_i23.Assessment>(
    'assessmentBuilder',
    'updateAssessment',
    {
      'assessmentId': assessmentId,
      'passingScore': passingScore,
      'randomize': randomize,
      'timeLimitMinutes': timeLimitMinutes,
      'maxAttempts': maxAttempts,
      'questionsToDisplay': questionsToDisplay,
    },
  );

  /// TRN-WF-03: Validate assessment configuration for QA submission.
  /// Returns validation status and any issues found.
  _i3.Future<Map<String, dynamic>> validateAssessmentForSubmission({
    required int assessmentId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'assessmentBuilder',
    'validateAssessmentForSubmission',
    {'assessmentId': assessmentId},
  );
}

/// Assessment Engine domain endpoint.
/// {@category Endpoint}
class EndpointAssessment extends _i2.EndpointRef {
  EndpointAssessment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assessment';

  _i3.Future<_i23.Assessment?> getAssessmentForCourse(int courseVersionId) =>
      caller.callServerEndpoint<_i23.Assessment?>(
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

  _i3.Future<_i24.AssessmentAttempt> startAttempt({
    required int userId,
    required int assessmentId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<_i24.AssessmentAttempt>(
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

  _i3.Future<_i24.AssessmentAttempt> submitAttempt({required int attemptId}) =>
      caller.callServerEndpoint<_i24.AssessmentAttempt>(
        'assessment',
        'submitAttempt',
        {'attemptId': attemptId},
      );

  _i3.Future<_i25.AssessmentResult> recordAnswer({
    required int attemptId,
    required int questionId,
    required String answer,
  }) => caller.callServerEndpoint<_i25.AssessmentResult>(
    'assessment',
    'recordAnswer',
    {
      'attemptId': attemptId,
      'questionId': questionId,
      'answer': answer,
    },
  );

  _i3.Future<List<_i22.QuestionBank>> listQuestionBanks({
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i22.QuestionBank>>(
    'assessment',
    'listQuestionBanks',
    {'organizationId': organizationId},
  );

  _i3.Future<_i22.QuestionBank> createQuestionBank({
    required String name,
    required int organizationId,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i22.QuestionBank>(
    'assessment',
    'createQuestionBank',
    {
      'name': name,
      'organizationId': organizationId,
      'tagsJson': tagsJson,
    },
  );

  /// Generate a random assessment selection from a question bank using Fisher-Yates shuffle.
  _i3.Future<List<_i21.Question>> generateRandomAssessment({
    required int questionBankId,
    required int count,
  }) => caller.callServerEndpoint<List<_i21.Question>>(
    'assessment',
    'generateRandomAssessment',
    {
      'questionBankId': questionBankId,
      'count': count,
    },
  );

  /// Bulk import questions into a question bank.
  _i3.Future<List<_i21.Question>> importQuestionsToBank({
    required int targetBankId,
    required List<Map<String, dynamic>> questions,
  }) => caller.callServerEndpoint<List<_i21.Question>>(
    'assessment',
    'importQuestionsToBank',
    {
      'targetBankId': targetBankId,
      'questions': questions,
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

  /// Export audit trail as CSV string. Logs the export per 21 CFR Part 11.
  _i3.Future<String> exportAuditCsv({
    String? entityType,
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<String>(
    'audit',
    'exportAuditCsv',
    {
      'entityType': entityType,
      'userId': userId,
      'from': from,
      'to': to,
      'limit': limit,
    },
  );
}

/// {@category Endpoint}
class EndpointAuditTrail extends _i2.EndpointRef {
  EndpointAuditTrail(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auditTrail';

  _i3.Future<void> logAction({
    required String action,
    required String entityType,
    required String entityId,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? ipAddress,
    String? rowHash,
  }) => caller.callServerEndpoint<void>(
    'auditTrail',
    'logAction',
    {
      'action': action,
      'entityType': entityType,
      'entityId': entityId,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
      'ipAddress': ipAddress,
      'rowHash': rowHash,
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

  /// TRN-WF-05: Create a new course version from an existing version.
  /// This clones all modules and lessons, increments version, and sets supersededByVersionId.
  /// changeSummary is MANDATORY - describes what changed and why.
  /// Returns the new CourseVersion with all content copied.
  _i3.Future<Map<String, dynamic>> createNewVersionFromExisting({
    required int existingVersionId,
    required String changeSummary,
    required bool isMajorVersion,
    int? createdById,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'courseBuilder',
    'createNewVersionFromExisting',
    {
      'existingVersionId': existingVersionId,
      'changeSummary': changeSummary,
      'isMajorVersion': isMajorVersion,
      'createdById': createdById,
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

  /// TRN-WF-04: Validate course version for QA submission.
  /// Performs all validation checks required before submitting for QA review.
  /// Returns validation status and detailed results for each rule.
  _i3.Future<_i33.QaValidationResult> validateForQaSubmission({
    required int courseVersionId,
  }) => caller.callServerEndpoint<_i33.QaValidationResult>(
    'courseBuilder',
    'validateForQaSubmission',
    {'courseVersionId': courseVersionId},
  );

  /// TRN-WF-04: Submit course for QA review.
  /// Validates all rules first, then changes status to pending_approval if all pass.
  /// Returns the updated CourseVersion or throws if validation fails.
  _i3.Future<_i32.CourseVersion> submitForQaReview({
    required int courseVersionId,
    int? submittedById,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'courseBuilder',
    'submitForQaReview',
    {
      'courseVersionId': courseVersionId,
      'submittedById': submittedById,
    },
  );

  /// Delete a module and cascade delete its lessons. Only for draft course versions.
  _i3.Future<bool> deleteModule({required int moduleId}) =>
      caller.callServerEndpoint<bool>(
        'courseBuilder',
        'deleteModule',
        {'moduleId': moduleId},
      );

  /// Delete a lesson by ID. Only for draft course versions.
  _i3.Future<bool> deleteLesson({required int lessonId}) =>
      caller.callServerEndpoint<bool>(
        'courseBuilder',
        'deleteLesson',
        {'lessonId': lessonId},
      );

  /// Update a lesson's materialId (replaces hardcoded materialId: 1).
  _i3.Future<_i31.Lesson> updateLessonMaterial({
    required int lessonId,
    required int materialId,
  }) => caller.callServerEndpoint<_i31.Lesson>(
    'courseBuilder',
    'updateLessonMaterial',
    {
      'lessonId': lessonId,
      'materialId': materialId,
    },
  );

  /// Bulk save module/lesson ordering and metadata changes.
  _i3.Future<bool> saveDraft({
    required int courseVersionId,
    required List<Map<String, dynamic>> modules,
  }) => caller.callServerEndpoint<bool>(
    'courseBuilder',
    'saveDraft',
    {
      'courseVersionId': courseVersionId,
      'modules': modules,
    },
  );
}

/// Course & Curriculum domain endpoint.
/// {@category Endpoint}
class EndpointCourse extends _i2.EndpointRef {
  EndpointCourse(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'course';

  _i3.Future<List<_i34.Course>> listCourses({
    int? organizationId,
    String? status,
  }) => caller.callServerEndpoint<List<_i34.Course>>(
    'course',
    'listCourses',
    {
      'organizationId': organizationId,
      'status': status,
    },
  );

  _i3.Future<_i34.Course?> getCourse(int id) =>
      caller.callServerEndpoint<_i34.Course?>(
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

  _i3.Future<_i34.Course> createCourse({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) => caller.callServerEndpoint<_i34.Course>(
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

  /// TRN-WF-01: Create Course with initial CourseVersion v1.0 atomically.
  /// This is the correct workflow entry point for trainers creating new courses.
  /// Returns a map with 'course' and 'courseVersion' keys.
  _i3.Future<Map<String, dynamic>> createCourseWithVersion({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'course',
    'createCourseWithVersion',
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

  /// Search courses by title, description, or SOP number.
  _i3.Future<List<_i34.Course>> searchCourses({
    required String query,
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i34.Course>>(
    'course',
    'searchCourses',
    {
      'query': query,
      'organizationId': organizationId,
    },
  );

  /// Update course metadata (title, description, sopNumber).
  _i3.Future<_i34.Course> updateCourse({
    required int courseId,
    String? title,
    String? description,
    String? sopNumber,
  }) => caller.callServerEndpoint<_i34.Course>(
    'course',
    'updateCourse',
    {
      'courseId': courseId,
      'title': title,
      'description': description,
      'sopNumber': sopNumber,
    },
  );

  /// Delete a draft course with no enrollments.
  _i3.Future<bool> deleteCourse({required int courseId}) =>
      caller.callServerEndpoint<bool>(
        'course',
        'deleteCourse',
        {'courseId': courseId},
      );
}

/// Document Control domain endpoint.
/// {@category Endpoint}
class EndpointDocument extends _i2.EndpointRef {
  EndpointDocument(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i3.Future<List<_i35.Document>> listDocuments({
    int? organizationId,
    String? documentType,
  }) => caller.callServerEndpoint<List<_i35.Document>>(
    'document',
    'listDocuments',
    {
      'organizationId': organizationId,
      'documentType': documentType,
    },
  );

  _i3.Future<_i35.Document?> getDocument(int id) =>
      caller.callServerEndpoint<_i35.Document?>(
        'document',
        'getDocument',
        {'id': id},
      );

  /// QA gate: classify SOP update as training_required or no_training_required.
  _i3.Future<_i35.Document> updateDocumentQaClassification({
    required int documentId,
    required String trainingRequiredByQa,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
  }) => caller.callServerEndpoint<_i35.Document>(
    'document',
    'updateDocumentQaClassification',
    {
      'documentId': documentId,
      'trainingRequiredByQa': trainingRequiredByQa,
      'affectedDepartmentIdsJson': affectedDepartmentIdsJson,
      'affectedRoleIdsJson': affectedRoleIdsJson,
    },
  );

  _i3.Future<List<_i36.DocumentVersion>> getDocumentVersions(int documentId) =>
      caller.callServerEndpoint<List<_i36.DocumentVersion>>(
        'document',
        'getDocumentVersions',
        {'documentId': documentId},
      );

  _i3.Future<_i35.Document> createDocument({
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i35.Document>(
    'document',
    'createDocument',
    {
      'title': title,
      'documentNumber': documentNumber,
      'documentType': documentType,
      'organizationId': organizationId,
    },
  );

  /// Create a document version. Plan 3B: optional versionMajor, versionMinor, isMajorVersion.
  /// If versionMajor/versionMinor omitted, parses version as "major.minor".
  _i3.Future<_i36.DocumentVersion> createDocumentVersion({
    required int documentId,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
  }) => caller.callServerEndpoint<_i36.DocumentVersion>(
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

  _i3.Future<List<_i37.DocumentLifecycle>> getDocumentLifecycle(
    int documentVersionId,
  ) => caller.callServerEndpoint<List<_i37.DocumentLifecycle>>(
    'document',
    'getDocumentLifecycle',
    {'documentVersionId': documentVersionId},
  );

  /// Transition document version lifecycle (QA-02). Enforces: draft→review→approved→effective→obsolete.
  /// Approved/Effective require QA e-sign. Obsolete requires reason.
  _i3.Future<_i37.DocumentLifecycle> transitionDocumentLifecycle({
    required int documentVersionId,
    required String newState,
    String? obsoleteReason,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? ipAddress,
  }) => caller.callServerEndpoint<_i37.DocumentLifecycle>(
    'document',
    'transitionDocumentLifecycle',
    {
      'documentVersionId': documentVersionId,
      'newState': newState,
      'obsoleteReason': obsoleteReason,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
      'ipAddress': ipAddress,
    },
  );

  _i3.Future<_i38.ApprovalWorkflow> createApprovalStep({
    required int documentVersionId,
    required int step,
    required int approverId,
    required String status,
    int? esignatureId,
  }) => caller.callServerEndpoint<_i38.ApprovalWorkflow>(
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
/// Implements all Pharma LMS event workflows per GMP and 21 CFR Part 11.
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

  /// Trigger CAPA training complete event (SYS-WF-06).
  /// Sets effectiveness check due date and updates CAPA status.
  _i3.Future<Map<String, dynamic>> triggerCapaTrainingComplete({
    required int capaId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'event',
    'triggerCapaTrainingComplete',
    {'capaId': capaId},
  );

  /// SYS-WF-08b: Compliance Drop Alert - check departments below threshold and notify QA.
  /// Triggers: When compliance rate falls below configured threshold (default 90%).
  /// Actions: Creates compliance alerts, notifies QA team, records in audit trail.
  _i3.Future<Map<String, dynamic>> triggerComplianceDropAlert({
    required double threshold,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'event',
    'triggerComplianceDropAlert',
    {'threshold': threshold},
  );

  /// SYS-WF-09: New Training Course Release - assigns training to target roles.
  /// Triggers: When a new course version is published (status='effective').
  /// Actions: Uses TrainingMatrix to assign to affected job roles.
  _i3.Future<Map<String, dynamic>> triggerNewCourseRelease({
    required int courseVersionId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'event',
    'triggerNewCourseRelease',
    {'courseVersionId': courseVersionId},
  );
}

/// Inspection and auditor access endpoint.
/// {@category Endpoint}
class EndpointInspection extends _i2.EndpointRef {
  EndpointInspection(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'inspection';

  /// List inspection records (for Admin/QA).
  _i3.Future<List<_i39.InspectionRecord>> listInspectionRecords({
    required int limit,
  }) => caller.callServerEndpoint<List<_i39.InspectionRecord>>(
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
  _i3.Future<List<_i40.AuditorPageLog>> listAuditorPageLogs({
    required int inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i40.AuditorPageLog>>(
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
  _i3.Future<List<_i41.InspectionPackage>> listInspectionPackages({
    required int inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i41.InspectionPackage>>(
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
  _i3.Future<_i41.InspectionPackage> signInspectionPackageAsOfficial({
    required int packageId,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? ipAddress,
  }) => caller.callServerEndpoint<_i41.InspectionPackage>(
    'inspection',
    'signInspectionPackageAsOfficial',
    {
      'packageId': packageId,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
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

  _i3.Future<_i42.Material?> getMaterial(int id) =>
      caller.callServerEndpoint<_i42.Material?>(
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

  _i3.Future<_i42.Material> createMaterial({
    required String title,
    required String materialType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i42.Material>(
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

  /// TRN-WF-02: Create material version after successful upload.
  /// Supports file integrity tracking (fileHash), file size, and virus scan status.
  /// changeSummary is required when uploading a new version of existing material.
  _i3.Future<_i43.MaterialVersion> createMaterialVersion({
    required int materialId,
    required String storageKey,
    String? fileHash,
    int? fileSizeBytes,
    String? changeSummary,
  }) => caller.callServerEndpoint<_i43.MaterialVersion>(
    'material',
    'createMaterialVersion',
    {
      'materialId': materialId,
      'storageKey': storageKey,
      'fileHash': fileHash,
      'fileSizeBytes': fileSizeBytes,
      'changeSummary': changeSummary,
    },
  );

  /// TRN-WF-02: Update material metadata (title).
  _i3.Future<_i42.Material> updateMaterial({
    required int materialId,
    String? title,
    String? materialType,
  }) => caller.callServerEndpoint<_i42.Material>(
    'material',
    'updateMaterial',
    {
      'materialId': materialId,
      'title': title,
      'materialType': materialType,
    },
  );

  /// TRN-WF-02: Get latest version of a material.
  _i3.Future<_i43.MaterialVersion?> getLatestMaterialVersion(int materialId) =>
      caller.callServerEndpoint<_i43.MaterialVersion?>(
        'material',
        'getLatestMaterialVersion',
        {'materialId': materialId},
      );

  /// TRN-WF-02: Update virus scan status after scanning.
  _i3.Future<_i43.MaterialVersion> updateVirusScanStatus({
    required int materialVersionId,
    required String virusScanStatus,
  }) => caller.callServerEndpoint<_i43.MaterialVersion>(
    'material',
    'updateVirusScanStatus',
    {
      'materialVersionId': materialVersionId,
      'virusScanStatus': virusScanStatus,
    },
  );

  _i3.Future<List<_i43.MaterialVersion>> getMaterialVersions(int materialId) =>
      caller.callServerEndpoint<List<_i43.MaterialVersion>>(
        'material',
        'getMaterialVersions',
        {'materialId': materialId},
      );

  _i3.Future<List<_i42.Material>> listMaterials({
    required int organizationId,
  }) => caller.callServerEndpoint<List<_i42.Material>>(
    'material',
    'listMaterials',
    {'organizationId': organizationId},
  );

  /// Update or create material progress for minimum read time / pausable learning.
  /// Server-enforced: when progressPct=100 or completedAt is set, requires
  /// timeSpentSeconds >= lesson.durationMinutes*60, readTimeMet=true, and
  /// for video: videoWatchedPct>=90, for pdf: pdfScrollPct>=80 in interactionJson.
  _i3.Future<_i44.MaterialProgress> updateProgress({
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
  }) => caller.callServerEndpoint<_i44.MaterialProgress>(
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

  _i3.Future<_i44.MaterialProgress?> getProgress({
    required int userId,
    required int materialId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<_i44.MaterialProgress?>(
    'material',
    'getProgress',
    {
      'userId': userId,
      'materialId': materialId,
      'enrollmentId': enrollmentId,
    },
  );

  /// Heartbeat: record engagement (tab_focused, scroll_depth, play_position).
  /// Minimum read time is enforced server-side: elapsed time is computed from
  /// [lastHeartbeat], capped at 15 seconds per heartbeat to prevent offline pause abuse.
  /// [readTimeMet] is set strictly on the server when timeSpentSeconds >= required read time.
  _i3.Future<_i44.MaterialProgress> recordEngagement({
    required int userId,
    required int materialId,
    required int lessonId,
    int? enrollmentId,
    required bool tabFocused,
    int? scrollDepthPct,
    int? videoWatchedPct,
    int? videoPositionSeconds,
    required int deltaSeconds,
  }) => caller.callServerEndpoint<_i44.MaterialProgress>(
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

  /// Soft-delete material. Rejects if material is used in any active lesson.
  _i3.Future<bool> deleteMaterial({required int materialId}) =>
      caller.callServerEndpoint<bool>(
        'material',
        'deleteMaterial',
        {'materialId': materialId},
      );

  /// Get material with all its versions for Version History display.
  _i3.Future<Map<String, dynamic>> getMaterialWithVersions({
    required int materialId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'material',
    'getMaterialWithVersions',
    {'materialId': materialId},
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
  _i3.Future<_i45.MfaStatusResult> getMfaStatus() =>
      caller.callServerEndpoint<_i45.MfaStatusResult>(
        'mfa',
        'getMfaStatus',
        {},
      );

  /// Starts MFA enrollment. Generates secret and returns it for QR setup.
  _i3.Future<_i46.MfaEnrollResult> enrollMfa() =>
      caller.callServerEndpoint<_i46.MfaEnrollResult>(
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
  _i3.Future<List<_i47.InAppNotification>> getInAppNotifications(int userId) =>
      caller.callServerEndpoint<List<_i47.InAppNotification>>(
        'notification',
        'getInAppNotifications',
        {'userId': userId},
      );

  /// Get trainer-specific notifications (QA decisions, SOP updates, assignment alerts).
  _i3.Future<List<_i47.InAppNotification>> getTrainerNotifications(
    int userId,
  ) => caller.callServerEndpoint<List<_i47.InAppNotification>>(
    'notification',
    'getTrainerNotifications',
    {'userId': userId},
  );

  /// Mark a notification as read.
  _i3.Future<bool> markNotificationRead({required int notificationId}) =>
      caller.callServerEndpoint<bool>(
        'notification',
        'markNotificationRead',
        {'notificationId': notificationId},
      );

  /// Get count of unread notifications for badge display.
  _i3.Future<int> getUnreadCount(int userId) => caller.callServerEndpoint<int>(
    'notification',
    'getUnreadCount',
    {'userId': userId},
  );
}

/// Organization & Identity domain endpoint.
/// {@category Endpoint}
class EndpointOrganization extends _i2.EndpointRef {
  EndpointOrganization(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  _i3.Future<List<_i48.Organization>> listOrganizations() =>
      caller.callServerEndpoint<List<_i48.Organization>>(
        'organization',
        'listOrganizations',
        {},
      );

  _i3.Future<_i48.Organization?> getOrganization(int id) =>
      caller.callServerEndpoint<_i48.Organization?>(
        'organization',
        'getOrganization',
        {'id': id},
      );

  _i3.Future<_i48.Organization> createOrganization({
    required String name,
    required String code,
  }) => caller.callServerEndpoint<_i48.Organization>(
    'organization',
    'createOrganization',
    {
      'name': name,
      'code': code,
    },
  );

  _i3.Future<List<_i49.Site>> listSites(int organizationId) =>
      caller.callServerEndpoint<List<_i49.Site>>(
        'organization',
        'listSites',
        {'organizationId': organizationId},
      );

  _i3.Future<List<_i50.Department>> listDepartments(int siteId) =>
      caller.callServerEndpoint<List<_i50.Department>>(
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
    required String passwordPlaintext,
    required String signatureMeaning,
    int? approverId,
    String? reviewChecklistJson,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'qa',
    'approveCourseVersion',
    {
      'courseVersionId': courseVersionId,
      'passwordPlaintext': passwordPlaintext,
      'signatureMeaning': signatureMeaning,
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

  /// Get the count of pending document approvals.
  _i3.Future<int> getPendingDocumentApprovalsCount() =>
      caller.callServerEndpoint<int>(
        'qa',
        'getPendingDocumentApprovalsCount',
        {},
      );

  /// Return a course for changes (not rejection). Status -> needs_revision.
  _i3.Future<_i32.CourseVersion> returnCourseForChanges({
    required int courseVersionId,
    required String comments,
    int? reviewerId,
  }) => caller.callServerEndpoint<_i32.CourseVersion>(
    'qa',
    'returnCourseForChanges',
    {
      'courseVersionId': courseVersionId,
      'comments': comments,
      'reviewerId': reviewerId,
    },
  );

  /// Get all course reviews for a course version.
  _i3.Future<List<_i51.CourseReview>> getCourseReviews({
    required int courseVersionId,
  }) => caller.callServerEndpoint<List<_i51.CourseReview>>(
    'qa',
    'getCourseReviews',
    {'courseVersionId': courseVersionId},
  );
}

/// Quality Event Integration domain endpoint.
/// {@category Endpoint}
class EndpointQualityEvent extends _i2.EndpointRef {
  EndpointQualityEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'qualityEvent';

  _i3.Future<List<_i52.QualityEvent>> listQualityEvents({
    int? siteId,
    String? eventType,
    String? status,
  }) => caller.callServerEndpoint<List<_i52.QualityEvent>>(
    'qualityEvent',
    'listQualityEvents',
    {
      'siteId': siteId,
      'eventType': eventType,
      'status': status,
    },
  );

  _i3.Future<_i52.QualityEvent?> getQualityEvent(int id) =>
      caller.callServerEndpoint<_i52.QualityEvent?>(
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

  _i3.Future<_i52.QualityEvent> createQualityEvent({
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) => caller.callServerEndpoint<_i52.QualityEvent>(
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

  /// Close a CAPA with e-signature.
  _i3.Future<void> closeCapaWithSignature({
    required int capaId,
    required String passwordPlaintext,
  }) => caller.callServerEndpoint<void>(
    'qualityEvent',
    'closeCapaWithSignature',
    {
      'capaId': capaId,
      'passwordPlaintext': passwordPlaintext,
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

  _i3.Future<List<_i53.InspectionReport>> listInspectionReports({
    int? organizationId,
    int? siteId,
  }) => caller.callServerEndpoint<List<_i53.InspectionReport>>(
    'qualityEvent',
    'listInspectionReports',
    {
      'organizationId': organizationId,
      'siteId': siteId,
    },
  );

  _i3.Future<_i53.InspectionReport> createInspectionReport({
    required int organizationId,
    required String status,
    int? siteId,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
  }) => caller.callServerEndpoint<_i53.InspectionReport>(
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
/// Provides comprehensive seed data for PharmaTech India with full FRD compliance.
/// {@category Endpoint}
class EndpointSeed extends _i2.EndpointRef {
  EndpointSeed(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  /// Legacy seed method - delegates to comprehensive seed
  _i3.Future<String> runSeed() => caller.callServerEndpoint<String>(
    'seed',
    'runSeed',
    {},
  );

  /// Legacy MVP seed method - delegates to comprehensive seed
  _i3.Future<String> runMvpSeed() => caller.callServerEndpoint<String>(
    'seed',
    'runMvpSeed',
    {},
  );

  /// Clear all seed data and re-run comprehensive seed
  _i3.Future<String> clearAndReseed() => caller.callServerEndpoint<String>(
    'seed',
    'clearAndReseed',
    {},
  );

  /// Comprehensive seed with 100 learners, 15 trainers, 12 pharma courses,
  /// Full compliance: HMAC signatures, assessment attempts,
  /// training matrix, material progress tracking.
  _i3.Future<String> runComprehensiveSeed() =>
      caller.callServerEndpoint<String>(
        'seed',
        'runComprehensiveSeed',
        {},
      );

  /// Provisions Serverpod auth accounts for all PharmaUser records.
  /// Uses [_seedPassword] as the default password for all accounts.
  /// Skips users that already have an email auth account.
  _i3.Future<String> provisionAuthAccounts() =>
      caller.callServerEndpoint<String>(
        'seed',
        'provisionAuthAccounts',
        {},
      );
}

/// SOP-Course linkage management endpoint.
/// {@category Endpoint}
class EndpointSopLinkage extends _i2.EndpointRef {
  EndpointSopLinkage(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sopLinkage';

  /// Link a SOP document to a course.
  _i3.Future<_i54.CourseSopLink> linkSopToCourse({
    required int courseId,
    required int documentId,
    int? linkedById,
  }) => caller.callServerEndpoint<_i54.CourseSopLink>(
    'sopLinkage',
    'linkSopToCourse',
    {
      'courseId': courseId,
      'documentId': documentId,
      'linkedById': linkedById,
    },
  );

  /// Unlink a SOP document from a course (soft-delete).
  _i3.Future<_i54.CourseSopLink> unlinkSopFromCourse({
    required int linkId,
    int? unlinkedById,
  }) => caller.callServerEndpoint<_i54.CourseSopLink>(
    'sopLinkage',
    'unlinkSopFromCourse',
    {
      'linkId': linkId,
      'unlinkedById': unlinkedById,
    },
  );

  /// Get all active SOP links for a course.
  _i3.Future<List<_i54.CourseSopLink>> getLinkedSops({required int courseId}) =>
      caller.callServerEndpoint<List<_i54.CourseSopLink>>(
        'sopLinkage',
        'getLinkedSops',
        {'courseId': courseId},
      );

  /// Get all courses linked to a specific SOP document.
  _i3.Future<List<_i54.CourseSopLink>> getCoursesForSop({
    required int documentId,
  }) => caller.callServerEndpoint<List<_i54.CourseSopLink>>(
    'sopLinkage',
    'getCoursesForSop',
    {'documentId': documentId},
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

  /// Cancel an assignment (ADM-WF-02).
  /// Requires a mandatory reason and cascades cancellation to linked active enrollments.
  _i3.Future<_i7.TrainingAssignment> cancelAssignment({
    required int assignmentId,
    required int cancelledById,
    required String reason,
  }) => caller.callServerEndpoint<_i7.TrainingAssignment>(
    'training',
    'cancelAssignment',
    {
      'assignmentId': assignmentId,
      'cancelledById': cancelledById,
      'reason': reason,
    },
  );

  _i3.Future<List<_i55.Enrollment>> getEnrollmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i55.Enrollment>>(
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
  _i3.Future<_i55.Enrollment?> getEnrollmentById(int enrollmentId) =>
      caller.callServerEndpoint<_i55.Enrollment?>(
        'training',
        'getEnrollmentById',
        {'enrollmentId': enrollmentId},
      );

  /// Acknowledge retraining change summary with e-signature.
  /// Requires: enrollment has retrainingChangeSummary, acknowledgedAt is null, userId matches.
  _i3.Future<_i55.Enrollment> acknowledgeRetraining({
    required int enrollmentId,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) => caller.callServerEndpoint<_i55.Enrollment>(
    'training',
    'acknowledgeRetraining',
    {
      'enrollmentId': enrollmentId,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
    },
  );

  _i3.Future<List<_i18.Certificate>> getCertificatesForUser(int userId) =>
      caller.callServerEndpoint<List<_i18.Certificate>>(
        'training',
        'getCertificatesForUser',
        {'userId': userId},
      );

  /// Training records for user (enrollment completions with score). Used for training history.
  _i3.Future<List<_i56.TrainingRecord>> getTrainingRecordsForUser(int userId) =>
      caller.callServerEndpoint<List<_i56.TrainingRecord>>(
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

  /// Get a training waiver by ID. Returns the waiver only if the current user is the waiver owner (employee view).
  _i3.Future<_i10.TrainingWaiver?> getWaiverById(int waiverId) =>
      caller.callServerEndpoint<_i10.TrainingWaiver?>(
        'training',
        'getWaiverById',
        {'waiverId': waiverId},
      );

  /// Get signature with integrity verification. Returns null signature if not found.
  /// integrityViolation is true when HMAC mismatch (tampering detected).
  _i3.Future<_i57.SignatureVerificationResult> getSignatureWithIntegrityCheck(
    int signatureId,
  ) => caller.callServerEndpoint<_i57.SignatureVerificationResult>(
    'training',
    'getSignatureWithIntegrityCheck',
    {'signatureId': signatureId},
  );

  /// List electronic signatures for auditor verification (21 CFR Part 11).
  _i3.Future<List<_i58.ElectronicSignature>> listElectronicSignatures({
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i58.ElectronicSignature>>(
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
    required String passwordPlaintext,
  }) => caller.callServerEndpoint<String>(
    'training',
    'issueBiometricToken',
    {
      'userId': userId,
      'passwordPlaintext': passwordPlaintext,
    },
  );

  /// Create electronic signature for training completion (called after e-sign UI).
  /// passwordPlaintext: plaintext password for re-authentication (sent over HTTPS); verified server-side, never stored.
  /// biometricToken: short-lived token from issueBiometricToken (plan 6B).
  _i3.Future<int> createTrainingSignature({
    required int userId,
    required String signatureMeaning,
    required String entityType,
    required String entityId,
    String? passwordPlaintext,
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
      'passwordPlaintext': passwordPlaintext,
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
  _i3.Future<List<_i59.TrainingRecordAnnotation>> listAnnotations(
    int trainingRecordId,
  ) => caller.callServerEndpoint<List<_i59.TrainingRecordAnnotation>>(
    'training',
    'listAnnotations',
    {'trainingRecordId': trainingRecordId},
  );

  /// QA-08: Add annotation to a training record (QA role).
  _i3.Future<_i59.TrainingRecordAnnotation> addAnnotation({
    required int trainingRecordId,
    required int authorId,
    required String note,
  }) => caller.callServerEndpoint<_i59.TrainingRecordAnnotation>(
    'training',
    'addAnnotation',
    {
      'trainingRecordId': trainingRecordId,
      'authorId': authorId,
      'note': note,
    },
  );

  /// QA-WF-06: Revoke an electronic signature (QA role).
  /// This invalidates the signature and any linked certificates.
  _i3.Future<void> revokeSignature({
    required int signatureId,
    required String reason,
    required String passwordPlaintext,
  }) => caller.callServerEndpoint<void>(
    'training',
    'revokeSignature',
    {
      'signatureId': signatureId,
      'reason': reason,
      'passwordPlaintext': passwordPlaintext,
    },
  );

  /// Self-enrollment for employee-initiated course enrollment.
  /// Creates a "self" source assignment and associated enrollment.
  /// Returns the created enrollment.
  _i3.Future<_i55.Enrollment> selfEnroll({
    required int userId,
    required int courseVersionId,
  }) => caller.callServerEndpoint<_i55.Enrollment>(
    'training',
    'selfEnroll',
    {
      'userId': userId,
      'courseVersionId': courseVersionId,
    },
  );

  /// Get all enrollments for a specific course version (trainer view).
  _i3.Future<List<_i55.Enrollment>> getEnrollmentsForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i55.Enrollment>>(
    'training',
    'getEnrollmentsForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Get all assignments for a specific course version (trainer view).
  _i3.Future<List<_i7.TrainingAssignment>> getAssignmentsForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i7.TrainingAssignment>>(
    'training',
    'getAssignmentsForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Get all assignments across all courses in an organization (trainer overview).
  _i3.Future<List<_i7.TrainingAssignment>> getAllAssignments({
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i7.TrainingAssignment>>(
    'training',
    'getAllAssignments',
    {'organizationId': organizationId},
  );

  /// Get training records for a specific course version (for analytics/learner progress).
  _i3.Future<List<_i56.TrainingRecord>> getTrainingRecordsForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i56.TrainingRecord>>(
    'training',
    'getTrainingRecordsForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Get enrollment progress as a fraction: completedLessons / totalLessons.
  /// Returns a map with keys: completedLessons, totalLessons, progressPct.
  _i3.Future<Map<String, dynamic>> getEnrollmentProgress(int enrollmentId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'training',
        'getEnrollmentProgress',
        {'enrollmentId': enrollmentId},
      );

  /// Check if all lessons are completed for a course version by a user.
  _i3.Future<bool> isCourseContentComplete({
    required int userId,
    required int courseVersionId,
  }) => caller.callServerEndpoint<bool>(
    'training',
    'isCourseContentComplete',
    {
      'userId': userId,
      'courseVersionId': courseVersionId,
    },
  );

  /// Get all certificates for a course version (trainer view).
  _i3.Future<List<_i18.Certificate>> getCertificatesForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i18.Certificate>>(
    'training',
    'getCertificatesForCourseVersion',
    {'courseVersionId': courseVersionId},
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

  /// Returns PharmaUser by email.
  /// For demo/development: if no auth session, looks up user directly by email.
  /// For production: validates session and ensures user can only access own profile.
  _i3.Future<_i17.PharmaUser?> getUserByEmail(String email) =>
      caller.callServerEndpoint<_i17.PharmaUser?>(
        'user',
        'getUserByEmail',
        {'email': email},
      );

  /// Get the primary role code for a user by email.
  /// Returns the role code string (e.g., 'trainer', 'employee', 'admin', 'qa_manager', 'auditor').
  /// Used by the Flutter client to determine which portal/dashboard to show on login.
  _i3.Future<String?> getUserRoleByEmail(String email) =>
      caller.callServerEndpoint<String?>(
        'user',
        'getUserRoleByEmail',
        {'email': email},
      );

  /// Get all preferences for a user.
  _i3.Future<List<_i60.UserPreference>> getUserPreferences({
    required int userId,
  }) => caller.callServerEndpoint<List<_i60.UserPreference>>(
    'user',
    'getUserPreferences',
    {'userId': userId},
  );

  /// Set a user preference (upsert).
  _i3.Future<_i60.UserPreference> setUserPreference({
    required int userId,
    required String key,
    required String value,
  }) => caller.callServerEndpoint<_i60.UserPreference>(
    'user',
    'setUserPreference',
    {
      'userId': userId,
      'key': key,
      'value': value,
    },
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
  _i3.Future<_i61.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i61.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_core = _i4.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
    auth = _i62.Caller(client);
  }

  late final _i4.Caller serverpod_auth_core;

  late final _i1.Caller serverpod_auth_idp;

  late final _i62.Caller auth;
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
         _i63.Protocol(),
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
    auditTrail = EndpointAuditTrail(this);
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
    sopLinkage = EndpointSopLinkage(this);
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

  late final EndpointAuditTrail auditTrail;

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

  late final EndpointSopLinkage sopLinkage;

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
    'auditTrail': auditTrail,
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
    'sopLinkage': sopLinkage,
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
