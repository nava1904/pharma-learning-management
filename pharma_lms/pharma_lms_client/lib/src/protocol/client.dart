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
import 'package:pharma_lms_client/src/protocol/access_reviews/access_review.dart'
    as _i6;
import 'package:pharma_lms_client/src/protocol/organization/user.dart' as _i7;
import 'package:pharma_lms_client/src/protocol/organization/role.dart' as _i8;
import 'package:pharma_lms_client/src/protocol/shared/signature_meaning.dart'
    as _i9;
import 'package:pharma_lms_client/src/protocol/training/training_assignment.dart'
    as _i10;
import 'package:pharma_lms_client/src/protocol/admin/bulk_import_result.dart'
    as _i11;
import 'package:pharma_lms_client/src/protocol/organization/job_role.dart'
    as _i12;
import 'package:pharma_lms_client/src/protocol/training/training_matrix.dart'
    as _i13;
import 'package:pharma_lms_client/src/protocol/training/training_waiver.dart'
    as _i14;
import 'package:pharma_lms_client/src/protocol/analytics/course_analytics.dart'
    as _i15;
import 'package:pharma_lms_client/src/protocol/analytics/department_compliance_summary.dart'
    as _i16;
import 'package:pharma_lms_client/src/protocol/analytics/audit_readiness_score.dart'
    as _i17;
import 'package:pharma_lms_client/src/protocol/analytics/report_definition.dart'
    as _i18;
import 'package:pharma_lms_client/src/protocol/analytics/dashboard.dart'
    as _i19;
import 'package:pharma_lms_client/src/protocol/analytics/sla_breach.dart'
    as _i20;
import 'package:pharma_lms_client/src/protocol/training/certificate.dart'
    as _i21;
import 'package:pharma_lms_client/src/protocol/quality/capa.dart' as _i22;
import 'package:pharma_lms_client/src/protocol/analytics/compliance_trend_point.dart'
    as _i23;
import 'package:pharma_lms_client/src/protocol/analytics/batch_training_analytics.dart'
    as _i24;
import 'package:pharma_lms_client/src/protocol/analytics/analytics_event.dart'
    as _i25;
import 'package:pharma_lms_client/src/protocol/assessment/question.dart'
    as _i26;
import 'package:pharma_lms_client/src/protocol/assessment/question_bank.dart'
    as _i27;
import 'package:pharma_lms_client/src/protocol/assessment/assessment.dart'
    as _i28;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_attempt.dart'
    as _i29;
import 'package:pharma_lms_client/src/protocol/assessment/assessment_result.dart'
    as _i30;
import 'package:pharma_lms_client/src/protocol/course/assignment.dart' as _i31;
import 'package:pharma_lms_client/src/protocol/course/assignment_submission.dart'
    as _i32;
import 'package:pharma_lms_client/src/protocol/audit/audit_trail.dart' as _i33;
import 'package:pharma_lms_client/src/protocol/audit/access_log.dart' as _i34;
import 'package:pharma_lms_client/src/protocol/training/batch_announcement.dart'
    as _i35;
import 'package:pharma_lms_client/src/protocol/training/certificate_template.dart'
    as _i36;
import 'package:pharma_lms_client/src/protocol/analytics/compliance_metrics.dart'
    as _i37;
import 'package:pharma_lms_client/src/protocol/analytics/user_compliance_metrics.dart'
    as _i38;
import 'package:pharma_lms_client/src/protocol/course/module.dart' as _i39;
import 'package:pharma_lms_client/src/protocol/course/lesson.dart' as _i40;
import 'package:pharma_lms_client/src/protocol/course/course_version.dart'
    as _i41;
import 'package:pharma_lms_client/src/protocol/course/qa_validation_result.dart'
    as _i42;
import 'package:pharma_lms_client/src/protocol/course/course.dart' as _i43;
import 'package:pharma_lms_client/src/protocol/document/document.dart' as _i44;
import 'package:pharma_lms_client/src/protocol/document/document_version.dart'
    as _i45;
import 'package:pharma_lms_client/src/protocol/document/document_lifecycle.dart'
    as _i46;
import 'package:pharma_lms_client/src/protocol/document/approval_workflow.dart'
    as _i47;
import 'package:pharma_lms_client/src/protocol/audit/inspection_record.dart'
    as _i48;
import 'package:pharma_lms_client/src/protocol/audit/auditor_page_log.dart'
    as _i49;
import 'package:pharma_lms_client/src/protocol/audit/inspection_package.dart'
    as _i50;
import 'package:pharma_lms_client/src/protocol/training/learner_trainer_message.dart'
    as _i51;
import 'package:pharma_lms_client/src/protocol/training/learner_support_thread_summary.dart'
    as _i52;
import 'package:pharma_lms_client/src/protocol/course/lesson_block.dart'
    as _i53;
import 'package:pharma_lms_client/src/protocol/training/live_class.dart'
    as _i54;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as _i55;
import 'package:pharma_lms_client/src/protocol/material/material_version.dart'
    as _i56;
import 'package:pharma_lms_client/src/protocol/material/material_progress.dart'
    as _i57;
import 'package:pharma_lms_client/src/protocol/notifications/messaging_unread_counts.dart'
    as _i58;
import 'package:pharma_lms_client/src/protocol/sme/sme_thread_summary.dart'
    as _i59;
import 'package:pharma_lms_client/src/protocol/sme/sme_review_comment.dart'
    as _i60;
import 'package:pharma_lms_client/src/protocol/notifications/notification.dart'
    as _i61;
import 'package:pharma_lms_client/src/protocol/mfa/mfa_status_result.dart'
    as _i62;
import 'package:pharma_lms_client/src/protocol/mfa/mfa_enroll_result.dart'
    as _i63;
import 'package:pharma_lms_client/src/protocol/notifications/in_app_notification.dart'
    as _i64;
import 'package:pharma_lms_client/src/protocol/notifications/notification_template.dart'
    as _i65;
import 'package:pharma_lms_client/src/protocol/training/practical_checklist_item.dart'
    as _i66;
import 'package:pharma_lms_client/src/protocol/training/observation_log.dart'
    as _i67;
import 'package:pharma_lms_client/src/protocol/course/user_competency.dart'
    as _i68;
import 'package:pharma_lms_client/src/protocol/course/competency.dart' as _i69;
import 'package:pharma_lms_client/src/protocol/organization/organization.dart'
    as _i70;
import 'package:pharma_lms_client/src/protocol/organization/site.dart' as _i71;
import 'package:pharma_lms_client/src/protocol/organization/department.dart'
    as _i72;
import 'package:pharma_lms_client/src/protocol/infrastructure/system_configuration.dart'
    as _i73;
import 'package:pharma_lms_client/src/protocol/course/course_review.dart'
    as _i74;
import 'package:pharma_lms_client/src/protocol/quality/quality_event.dart'
    as _i75;
import 'package:pharma_lms_client/src/protocol/quality/inspection_report.dart'
    as _i76;
import 'package:pharma_lms_client/src/protocol/sme/sme_assignment.dart' as _i77;
import 'package:pharma_lms_client/src/protocol/course/course_sop_link.dart'
    as _i78;
import 'package:pharma_lms_client/src/protocol/training/standalone_assignment.dart'
    as _i79;
import 'package:pharma_lms_client/src/protocol/training/standalone_assignment_recipient.dart'
    as _i80;
import 'package:pharma_lms_client/src/protocol/training/training_batch.dart'
    as _i81;
import 'package:pharma_lms_client/src/protocol/training/batch_participant_info.dart'
    as _i82;
import 'package:pharma_lms_client/src/protocol/training/training_batch_participant.dart'
    as _i83;
import 'package:pharma_lms_client/src/protocol/training/batch_attendance_record.dart'
    as _i84;
import 'package:pharma_lms_client/src/protocol/training/enrollment.dart'
    as _i85;
import 'package:pharma_lms_client/src/protocol/training/training_record.dart'
    as _i86;
import 'package:pharma_lms_client/src/protocol/shared/signature_verification_result.dart'
    as _i87;
import 'package:pharma_lms_client/src/protocol/shared/electronic_signature.dart'
    as _i88;
import 'package:pharma_lms_client/src/protocol/training/training_record_annotation.dart'
    as _i89;
import 'package:pharma_lms_client/src/protocol/organization/user_preference.dart'
    as _i90;
import 'package:pharma_lms_client/src/protocol/greetings/greeting.dart' as _i91;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i92;
import 'protocol.dart' as _i93;

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

/// {@category Endpoint}
class EndpointAccessReview extends _i2.EndpointRef {
  EndpointAccessReview(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'accessReview';

  _i3.Future<List<_i6.AccessReview>> getAccessReviews(int windowId) =>
      caller.callServerEndpoint<List<_i6.AccessReview>>(
        'accessReview',
        'getAccessReviews',
        {'windowId': windowId},
      );

  _i3.Future<void> recertify({
    required int reviewId,
    required String justification,
  }) => caller.callServerEndpoint<void>(
    'accessReview',
    'recertify',
    {
      'reviewId': reviewId,
      'justification': justification,
    },
  );

  _i3.Future<void> revoke({
    required int reviewId,
    required String justification,
  }) => caller.callServerEndpoint<void>(
    'accessReview',
    'revoke',
    {
      'reviewId': reviewId,
      'justification': justification,
    },
  );

  _i3.Future<void> signReview({
    required int windowId,
    required String password,
    required String reason,
  }) => caller.callServerEndpoint<void>(
    'accessReview',
    'signReview',
    {
      'windowId': windowId,
      'password': password,
      'reason': reason,
    },
  );

  _i3.Future<String> exportSignedPdf({required int windowId}) =>
      caller.callServerEndpoint<String>(
        'accessReview',
        'exportSignedPdf',
        {'windowId': windowId},
      );
}

/// Admin User Management Endpoint
///
/// Module 1: User & Identity Management
///
/// Handles all user management operations:
/// - List users with filters, search, pagination
/// - Get user details with roles and organization info
/// - Create new user
/// - Update user information
/// - Deactivate/reactivate user
/// - Reset password
/// - Bulk operations
///
/// All operations are audited (logged to audit_trail table)
/// All operations enforce RBAC (admin-only)
/// Compliance: 21 CFR Part 11 - Full audit trail with HMAC
/// {@category Endpoint}
class EndpointAdminUserManagement extends _i2.EndpointRef {
  EndpointAdminUserManagement(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminUserManagement';

  /// List all users with filtering, searching, and pagination
  ///
  /// Query parameters:
  /// - role: Filter by user role (EMPLOYEE, TRAINER, ADMIN)
  /// - status: Filter by status (ACTIVE, INACTIVE, SUSPENDED, PENDING_APPROVAL)
  /// - organization: Filter by organization name
  /// - department: Filter by department
  /// - search: Search by name, email, or employee_id
  /// - page: Page number (1-indexed)
  /// - perPage: Records per page (default 10, max 100)
  ///
  /// Returns: List of users matching criteria
  /// Database: Queries pharma_user table
  /// Audit: Logged as USERS_READ (informational)
  _i3.Future<List<_i7.PharmaUser>> listUsers({
    String? role,
    String? status,
    String? organizationName,
    String? departmentName,
    String? search,
    required int page,
    required int perPage,
  }) => caller.callServerEndpoint<List<_i7.PharmaUser>>(
    'adminUserManagement',
    'listUsers',
    {
      'role': role,
      'status': status,
      'organizationName': organizationName,
      'departmentName': departmentName,
      'search': search,
      'page': page,
      'perPage': perPage,
    },
  );

  /// Get a single user with all details
  ///
  /// Parameters:
  /// - userId: The ID of the user to fetch
  ///
  /// Returns: Full user object with roles and organization details
  /// Database: Queries pharma_user table
  /// Audit: Logged as USER_VIEW
  _i3.Future<_i7.PharmaUser?> getUser({required int userId}) =>
      caller.callServerEndpoint<_i7.PharmaUser?>(
        'adminUserManagement',
        'getUser',
        {'userId': userId},
      );

  /// Create a new user
  ///
  /// Validation:
  /// - Email must be unique
  /// - Email must be valid format
  /// - Name cannot be empty
  /// - Role must be EMPLOYEE, TRAINER, or ADMIN
  ///
  /// Database: Inserts into pharma_user table
  /// Audit: Logged as USER_CREATE
  /// Compliance: New user status = PENDING_APPROVAL, requires admin approval
  _i3.Future<_i7.PharmaUser> createUser({
    required String email,
    required String firstName,
    required String lastName,
    String? employeeId,
    int? organizationId,
    int? departmentId,
    int? jobRoleId,
    int? siteId,
  }) => caller.callServerEndpoint<_i7.PharmaUser>(
    'adminUserManagement',
    'createUser',
    {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'employeeId': employeeId,
      'organizationId': organizationId,
      'departmentId': departmentId,
      'jobRoleId': jobRoleId,
      'siteId': siteId,
    },
  );

  /// Update user information
  ///
  /// All user fields can be updated except id and email (email is immutable)
  /// Database: Updates pharma_user table
  /// Audit: Logged as USER_UPDATE with field changes
  _i3.Future<_i7.PharmaUser?> updateUser({
    required int userId,
    String? firstName,
    String? lastName,
    int? organizationId,
    int? departmentId,
  }) => caller.callServerEndpoint<_i7.PharmaUser?>(
    'adminUserManagement',
    'updateUser',
    {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'organizationId': organizationId,
      'departmentId': departmentId,
    },
  );

  /// Deactivate a user (soft delete)
  ///
  /// Sets is_suspended = true, is_active = false
  /// User cannot login or use system
  /// All enrollment/certificate records remain intact (audit trail)
  ///
  /// Database: Updates pharma_user table
  /// Audit: Logged as USER_DEACTIVATE
  _i3.Future<bool> deactivateUser({required int userId}) =>
      caller.callServerEndpoint<bool>(
        'adminUserManagement',
        'deactivateUser',
        {'userId': userId},
      );

  /// List all portal roles that can be assigned to users (e.g. admin/trainer/employee).
  _i3.Future<List<_i8.Role>> listPortalRoles() =>
      caller.callServerEndpoint<List<_i8.Role>>(
        'adminUserManagement',
        'listPortalRoles',
        {},
      );

  /// Get current portal role codes for a user.
  _i3.Future<List<String>> getUserPortalRoles({required int userId}) =>
      caller.callServerEndpoint<List<String>>(
        'adminUserManagement',
        'getUserPortalRoles',
        {'userId': userId},
      );

  /// Replace the user portal role with a single role code.
  ///
  /// Notes:
  /// - Current UI uses a single portal role at a time (matches seeding + most flows).
  /// - We keep the API shape as a single replace operation for auditability.
  _i3.Future<void> setUserPortalRole({
    required int userId,
    required String roleCode,
    String? reason,
  }) => caller.callServerEndpoint<void>(
    'adminUserManagement',
    'setUserPortalRole',
    {
      'userId': userId,
      'roleCode': roleCode,
      'reason': reason,
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
  _i3.Future<List<_i9.SignatureMeaning>> listSignatureMeanings() =>
      caller.callServerEndpoint<List<_i9.SignatureMeaning>>(
        'admin',
        'listSignatureMeanings',
        {},
      );

  /// Create a signature meaning.
  _i3.Future<_i9.SignatureMeaning> createSignatureMeaning({
    required String meaning,
    required bool isActive,
    required int orderIndex,
  }) => caller.callServerEndpoint<_i9.SignatureMeaning>(
    'admin',
    'createSignatureMeaning',
    {
      'meaning': meaning,
      'isActive': isActive,
      'orderIndex': orderIndex,
    },
  );

  /// Update a signature meaning.
  _i3.Future<_i9.SignatureMeaning> updateSignatureMeaning({
    required int id,
    String? meaning,
    bool? isActive,
    int? orderIndex,
  }) => caller.callServerEndpoint<_i9.SignatureMeaning>(
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
  _i3.Future<List<_i10.TrainingAssignment>> assignTrainingToDepartment({
    required int departmentId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    String? reason,
    required String source,
  }) => caller.callServerEndpoint<List<_i10.TrainingAssignment>>(
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

  /// Real admin "creates trainer" flow (US-ADM-USR-001).
  ///
  /// Creates the `pharma_user`, assigns a portal `role` via `user_role`,
  /// provisions Serverpod auth (email + temporary password) and sends the welcome email,
  /// logs an immutable audit trail entry, and creates onboarding enrollments from the
  /// selected training-matrix `jobRoleId`.
  _i3.Future<_i7.PharmaUser> createUserWithRole({
    required String employeeId,
    required String email,
    required String firstName,
    required String lastName,
    required int departmentId,
    required int siteId,
    required int organizationId,
    required int jobRoleId,
    required String roleCode,
    required int assignedById,
    int? managerId,
    DateTime? dueDate,
  }) => caller.callServerEndpoint<_i7.PharmaUser>(
    'admin',
    'createUserWithRole',
    {
      'employeeId': employeeId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      'siteId': siteId,
      'organizationId': organizationId,
      'jobRoleId': jobRoleId,
      'roleCode': roleCode,
      'assignedById': assignedById,
      'managerId': managerId,
      'dueDate': dueDate,
    },
  );

  /// Bulk import users from CSV (base64).
  ///
  /// Pragmatic production mapping aligned to US-ADM-USR-001/002:
  /// - employeeId (conflict key)
  /// - role (portal role code; e.g. trainer)
  /// - email/firstName/lastName
  /// - departmentId/siteId/organizationId/jobRoleId (training matrix scoping)
  _i3.Future<_i11.BulkImportResult> bulkImportUsers({
    required String csvBase64,
    required int assignedById,
    DateTime? dueDate,
  }) => caller.callServerEndpoint<_i11.BulkImportResult>(
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
  _i3.Future<_i11.BulkImportResult> bulkImportTrainingMatrix({
    required String csvBase64,
  }) => caller.callServerEndpoint<_i11.BulkImportResult>(
    'admin',
    'bulkImportTrainingMatrix',
    {'csvBase64': csvBase64},
  );

  /// Update job role training matrix (JSON array of course IDs).
  _i3.Future<_i12.JobRole> updateJobRoleTrainingMatrix({
    required int jobRoleId,
    required String trainingMatrixJson,
  }) => caller.callServerEndpoint<_i12.JobRole>(
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

  /// List all TrainingMatrix entries for a site (or org-wide if siteId is null).
  _i3.Future<List<_i13.TrainingMatrix>> listTrainingMatrixEntries({
    int? siteId,
  }) => caller.callServerEndpoint<List<_i13.TrainingMatrix>>(
    'admin',
    'listTrainingMatrixEntries',
    {'siteId': siteId},
  );

  /// Upsert a TrainingMatrix entry (create or update).
  _i3.Future<_i13.TrainingMatrix> upsertTrainingMatrixEntry({
    required int jobRoleId,
    required int courseId,
    required bool isMandatory,
    int? dueDaysFromHire,
    int? retrainingIntervalDays,
    int? siteId,
    int? createdById,
  }) => caller.callServerEndpoint<_i13.TrainingMatrix>(
    'admin',
    'upsertTrainingMatrixEntry',
    {
      'jobRoleId': jobRoleId,
      'courseId': courseId,
      'isMandatory': isMandatory,
      'dueDaysFromHire': dueDaysFromHire,
      'retrainingIntervalDays': retrainingIntervalDays,
      'siteId': siteId,
      'createdById': createdById,
    },
  );

  /// Delete a TrainingMatrix entry.
  _i3.Future<bool> deleteTrainingMatrixEntry({
    required int jobRoleId,
    required int courseId,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'deleteTrainingMatrixEntry',
    {
      'jobRoleId': jobRoleId,
      'courseId': courseId,
    },
  );

  /// Assign role-based training (curriculum from JobRole) to a user.
  _i3.Future<List<_i10.TrainingAssignment>> assignRoleBasedTraining({
    required int userId,
    required int jobRoleId,
    required int assignedById,
    required DateTime dueDate,
  }) => caller.callServerEndpoint<List<_i10.TrainingAssignment>>(
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
  _i3.Future<_i14.TrainingWaiver> requestTrainingWaiver({
    required int userId,
    required int courseId,
    required int requestedById,
    required String requestReason,
    String? evidenceStoragePath,
    DateTime? expiresAt,
  }) => caller.callServerEndpoint<_i14.TrainingWaiver>(
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
  _i3.Future<List<_i14.TrainingWaiver>> listTrainingWaivers({
    int? userId,
    String? status,
    int? courseId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i14.TrainingWaiver>>(
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
  _i3.Future<_i14.TrainingWaiver> approveTrainingWaiver({
    required int waiverId,
    required int approvedById,
  }) => caller.callServerEndpoint<_i14.TrainingWaiver>(
    'admin',
    'approveTrainingWaiver',
    {
      'waiverId': waiverId,
      'approvedById': approvedById,
    },
  );

  /// ADM-07: QA reject a training waiver.
  _i3.Future<_i14.TrainingWaiver> rejectTrainingWaiver({
    required int waiverId,
    required int approvedById,
    required String rejectionReason,
  }) => caller.callServerEndpoint<_i14.TrainingWaiver>(
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

  /// List all users with optional filtering and pagination
  _i3.Future<List<_i7.PharmaUser>> listUsers({
    required int page,
    required int perPage,
    String? roleCode,
    String? status,
    String? searchQuery,
  }) => caller.callServerEndpoint<List<_i7.PharmaUser>>(
    'admin',
    'listUsers',
    {
      'page': page,
      'perPage': perPage,
      'roleCode': roleCode,
      'status': status,
      'searchQuery': searchQuery,
    },
  );

  /// Get total count of users with optional filtering
  _i3.Future<int> getUserCount({
    String? roleCode,
    String? status,
    String? searchQuery,
  }) => caller.callServerEndpoint<int>(
    'admin',
    'getUserCount',
    {
      'roleCode': roleCode,
      'status': status,
      'searchQuery': searchQuery,
    },
  );

  /// Get a single user by ID
  _i3.Future<_i7.PharmaUser?> getUser(int userId) =>
      caller.callServerEndpoint<_i7.PharmaUser?>(
        'admin',
        'getUser',
        {'userId': userId},
      );

  /// Update a user's information
  _i3.Future<_i7.PharmaUser?> updateUser({
    required int userId,
    String? firstName,
    String? lastName,
    int? departmentId,
    int? jobRoleId,
  }) => caller.callServerEndpoint<_i7.PharmaUser?>(
    'admin',
    'updateUser',
    {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      'jobRoleId': jobRoleId,
    },
  );

  /// Deactivate a user (soft delete)
  _i3.Future<bool> deactivateUser({
    required int userId,
    required int deactivatedById,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'deactivateUser',
    {
      'userId': userId,
      'deactivatedById': deactivatedById,
    },
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
  _i3.Future<_i15.CourseAnalytics> getCourseAnalytics(int courseVersionId) =>
      caller.callServerEndpoint<_i15.CourseAnalytics>(
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
  _i3.Future<Map<String, String>> getSystemHealth() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'getSystemHealth',
        {},
      );

  /// IT-WF-04: Manual trigger for background jobs.
  /// Supported jobNames: CertExpiryCheck, NotificationWorker, ComplianceCalc, AuditTrailIntegrityCheck
  _i3.Future<Map<String, String>> triggerManualJob({required String jobName}) =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'triggerManualJob',
        {'jobName': jobName},
      );

  /// SYS-WF-04: Run certificate expiry check job.
  /// Creates renewal assignments for certificates expiring in 30-60 days.
  /// Marks expired certificates and logs to audit trail.
  _i3.Future<Map<String, String>> runCertExpiryCheck() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'runCertExpiryCheck',
        {},
      );

  /// SYS-WF-05: Run notification worker job.
  /// Processes escalation ladder for due/overdue enrollments.
  _i3.Future<Map<String, String>> runNotificationWorker() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'runNotificationWorker',
        {},
      );

  /// SYS-WF-07: Run compliance calculation job.
  /// Computes org-wide and dept-wide compliance, writes snapshots.
  _i3.Future<Map<String, String>> runComplianceCalc() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'runComplianceCalc',
        {},
      );

  /// SYS-WF-08: Run audit trail integrity check (CRITICAL - 21 CFR Part 11).
  /// Verifies SHA-256 hashes and sequence continuity.
  /// Throws exception if integrity issues found.
  _i3.Future<Map<String, String>> runAuditTrailIntegrityCheck() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'runAuditTrailIntegrityCheck',
        {},
      );

  /// Aggregate KPIs for the admin dashboard (org-scoped enrollments, compliance average).
  _i3.Future<Map<String, String>> getAdminDashboardKpis() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'getAdminDashboardKpis',
        {},
      );

  /// Department compliance summary.
  _i3.Future<List<_i16.DepartmentComplianceSummary>>
  getDepartmentComplianceSummary() =>
      caller.callServerEndpoint<List<_i16.DepartmentComplianceSummary>>(
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
  _i3.Future<_i17.AuditReadinessScore> getAuditReadinessScore({
    int? organizationId,
  }) => caller.callServerEndpoint<_i17.AuditReadinessScore>(
    'analytics',
    'getAuditReadinessScore',
    {'organizationId': organizationId},
  );

  _i3.Future<List<_i18.ReportDefinition>> listReportDefinitions() =>
      caller.callServerEndpoint<List<_i18.ReportDefinition>>(
        'analytics',
        'listReportDefinitions',
        {},
      );

  _i3.Future<List<_i19.Dashboard>> listDashboards({int? roleId}) =>
      caller.callServerEndpoint<List<_i19.Dashboard>>(
        'analytics',
        'listDashboards',
        {'roleId': roleId},
      );

  _i3.Future<List<_i20.SlaBreach>> getOpenSlaBreaches() =>
      caller.callServerEndpoint<List<_i20.SlaBreach>>(
        'analytics',
        'getOpenSlaBreaches',
        {},
      );

  /// Non-compliant employees (overdue training).
  _i3.Future<List<_i7.PharmaUser>> getNonCompliantEmployees({
    int? departmentId,
  }) => caller.callServerEndpoint<List<_i7.PharmaUser>>(
    'analytics',
    'getNonCompliantEmployees',
    {'departmentId': departmentId},
  );

  /// Upcoming certificate expirations by department (30/60/90 days).
  _i3.Future<Map<String, List<_i21.Certificate>>>
  getUpcomingExpirationsByDepartment() =>
      caller.callServerEndpoint<Map<String, List<_i21.Certificate>>>(
        'analytics',
        'getUpcomingExpirationsByDepartment',
        {},
      );

  /// Recent training assignments (last 10).
  _i3.Future<List<_i10.TrainingAssignment>> getRecentAssignments({
    required int limit,
  }) => caller.callServerEndpoint<List<_i10.TrainingAssignment>>(
    'analytics',
    'getRecentAssignments',
    {'limit': limit},
  );

  /// Open CAPAs requiring training (not yet completed).
  _i3.Future<List<_i22.Capa>> getOpenCapasRequiringTraining() =>
      caller.callServerEndpoint<List<_i22.Capa>>(
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
  _i3.Future<List<Map<String, String>>> getSopRetrainingQueue() =>
      caller.callServerEndpoint<List<Map<String, String>>>(
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
  _i3.Future<Map<String, String>> getTrainingVsDeviationCorrelation() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'getTrainingVsDeviationCorrelation',
        {},
      );

  /// QA-07: Compliance vs deviation overlay - training completion vs deviation count by department.
  _i3.Future<Map<String, String>> getComplianceDeviationOverlay() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'getComplianceDeviationOverlay',
        {},
      );

  /// ANA-03: SLA policy status and breach count.
  _i3.Future<Map<String, String>> getSlaSummary() =>
      caller.callServerEndpoint<Map<String, String>>(
        'analytics',
        'getSlaSummary',
        {},
      );

  /// Compliance trend by calendar month. Prefers [AnalyticsSnapshot] rows; falls back
  /// to live department averages only when no snapshot history exists.
  _i3.Future<List<_i23.ComplianceTrendPoint>> getComplianceTrend({
    required int months,
  }) => caller.callServerEndpoint<List<_i23.ComplianceTrendPoint>>(
    'analytics',
    'getComplianceTrend',
    {'months': months},
  );

  /// Aggregates enrollments, time-on-content, assignments, and assessments for a batch roster.
  _i3.Future<_i24.BatchTrainingAnalytics?> getBatchTrainingAnalytics(
    int batchId,
  ) => caller.callServerEndpoint<_i24.BatchTrainingAnalytics?>(
    'analytics',
    'getBatchTrainingAnalytics',
    {'batchId': batchId},
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
  _i3.Stream<_i25.AnalyticsEvent> streamAnalytics(String channel) =>
      caller.callStreamingServerEndpoint<
        _i3.Stream<_i25.AnalyticsEvent>,
        _i25.AnalyticsEvent
      >(
        'analytics',
        'streamAnalytics',
        {'channel': channel},
        {},
      );

  /// Recent activity for the learner: audit events for this user, outbound
  /// learner messages, and enrollment milestones (merged, newest first).
  _i3.Future<List<Map<String, String>>> getRecentActivity(int userId) =>
      caller.callServerEndpoint<List<Map<String, String>>>(
        'analytics',
        'getRecentActivity',
        {'userId': userId},
      );

  /// Unified overdue rows for the learner dashboard (assignments past due +
  /// expired certificates). Matches [ComplianceCalculatorService.getUserCompliance]
  /// overdue components for display (banner + table stay in sync).
  _i3.Future<List<Map<String, String>>> getOverdueDashboardItems(int userId) =>
      caller.callServerEndpoint<List<Map<String, String>>>(
        'analytics',
        'getOverdueDashboardItems',
        {'userId': userId},
      );

  /// Get the count of open quality events.
  _i3.Future<int> getOpenQualityEventsCount() => caller.callServerEndpoint<int>(
    'analytics',
    'getOpenQualityEventsCount',
    {},
  );

  /// Get SLA breaches.
  _i3.Future<List<_i20.SlaBreach>> getSlaBreaches() =>
      caller.callServerEndpoint<List<_i20.SlaBreach>>(
        'analytics',
        'getSlaBreaches',
        {},
      );

  /// Get monthly training hours for a user (last 5 months) for the Dashboard chart.
  _i3.Future<List<Map<String, String>>> getMonthlyTrainingHours(int userId) =>
      caller.callServerEndpoint<List<Map<String, String>>>(
        'analytics',
        'getMonthlyTrainingHours',
        {'userId': userId},
      );

  /// Get weekly learning progress for a user (last 6 weeks) for the Dashboard area chart.
  _i3.Future<List<Map<String, String>>> getWeeklyLearningProgress(int userId) =>
      caller.callServerEndpoint<List<Map<String, String>>>(
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

  /// Count of completed assessment attempts (for N/A vs zero average on dashboard).
  _i3.Future<int> getUserCompletedAssessmentAttemptCount(int userId) =>
      caller.callServerEndpoint<int>(
        'analytics',
        'getUserCompletedAssessmentAttemptCount',
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
  _i3.Future<List<Map<String, String>>> getUpcomingDueDates(int userId) =>
      caller.callServerEndpoint<List<Map<String, String>>>(
        'analytics',
        'getUpcomingDueDates',
        {'userId': userId},
      );

  /// Get compliance alerts for a user (SOP retraining, overdue, expiring certs).
  _i3.Future<List<Map<String, String>>> getComplianceAlerts(int userId) =>
      caller.callServerEndpoint<List<Map<String, String>>>(
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

  /// Employees × courses matrix with enrollment status (completion overview).
  _i3.Future<String> exportCompletionMatrixCsv({int? organizationId}) =>
      caller.callServerEndpoint<String>(
        'analytics',
        'exportCompletionMatrixCsv',
        {'organizationId': organizationId},
      );

  /// Export learner progress as CSV.
  _i3.Future<String> exportLearnerProgressCsv({int? organizationId}) =>
      caller.callServerEndpoint<String>(
        'analytics',
        'exportLearnerProgressCsv',
        {'organizationId': organizationId},
      );

  /// Get employee dashboard summary (combines multiple data sources for efficiency).
  _i3.Future<Map<String, String>> getEmployeeDashboardSummary(int userId) =>
      caller.callServerEndpoint<Map<String, String>>(
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

  _i3.Future<_i26.Question> createQuestion({
    required int questionBankId,
    required String text,
    required String questionType,
    required String optionsJson,
    required String correctAnswer,
    String? difficulty,
    String? regulatoryTag,
  }) => caller.callServerEndpoint<_i26.Question>(
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

  _i3.Future<_i26.Question> updateQuestion({
    required int questionId,
    String? text,
    String? questionType,
    String? optionsJson,
    String? correctAnswer,
    String? difficulty,
  }) => caller.callServerEndpoint<_i26.Question>(
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
  _i3.Future<_i27.QuestionBank> createQuestionBank({
    required String name,
    required int organizationId,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i27.QuestionBank>(
    'assessmentBuilder',
    'createQuestionBank',
    {
      'name': name,
      'organizationId': organizationId,
      'tagsJson': tagsJson,
    },
  );

  /// TRN-WF-03: Update question bank metadata.
  _i3.Future<_i27.QuestionBank> updateQuestionBank({
    required int questionBankId,
    String? name,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i27.QuestionBank>(
    'assessmentBuilder',
    'updateQuestionBank',
    {
      'questionBankId': questionBankId,
      'name': name,
      'tagsJson': tagsJson,
    },
  );

  /// TRN-WF-03: Get questions in a bank with count for validation.
  _i3.Future<Map<String, String>> getQuestionBankDetails({
    required int questionBankId,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'assessmentBuilder',
    'getQuestionBankDetails',
    {'questionBankId': questionBankId},
  );

  /// TRN-WF-03: Create assessment with 2x question pool validation.
  /// questionsToDisplay must be <= totalQuestions / 2 for adequate randomization.
  _i3.Future<_i28.Assessment> createAssessment({
    required int courseVersionId,
    required int questionBankId,
    required int passingScore,
    required bool randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
    required bool showAnswers,
    required bool showSubmissionHistory,
    int? limitQuestions,
  }) => caller.callServerEndpoint<_i28.Assessment>(
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
      'showAnswers': showAnswers,
      'showSubmissionHistory': showSubmissionHistory,
      'limitQuestions': limitQuestions,
    },
  );

  /// TRN-WF-03: Update assessment with 2x question pool validation.
  _i3.Future<_i28.Assessment> updateAssessment({
    required int assessmentId,
    int? passingScore,
    bool? randomize,
    int? timeLimitMinutes,
    int? maxAttempts,
    int? questionsToDisplay,
    bool? showAnswers,
    bool? showSubmissionHistory,
    int? limitQuestions,
  }) => caller.callServerEndpoint<_i28.Assessment>(
    'assessmentBuilder',
    'updateAssessment',
    {
      'assessmentId': assessmentId,
      'passingScore': passingScore,
      'randomize': randomize,
      'timeLimitMinutes': timeLimitMinutes,
      'maxAttempts': maxAttempts,
      'questionsToDisplay': questionsToDisplay,
      'showAnswers': showAnswers,
      'showSubmissionHistory': showSubmissionHistory,
      'limitQuestions': limitQuestions,
    },
  );

  /// TRN-WF-03: Validate assessment configuration for QA submission.
  /// Returns validation status and any issues found.
  _i3.Future<Map<String, String>> validateAssessmentForSubmission({
    required int assessmentId,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'assessmentBuilder',
    'validateAssessmentForSubmission',
    {'assessmentId': assessmentId},
  );

  /// Admin/Trainer: List assessments for an organization (basic admin visibility).
  _i3.Future<List<_i28.Assessment>> listAssessments({
    int? organizationId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i28.Assessment>>(
    'assessmentBuilder',
    'listAssessments',
    {
      'organizationId': organizationId,
      'limit': limit,
    },
  );

  /// Admin/Trainer: List attempts for an assessment.
  _i3.Future<List<_i29.AssessmentAttempt>> listAssessmentAttempts({
    required int assessmentId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i29.AssessmentAttempt>>(
    'assessmentBuilder',
    'listAssessmentAttempts',
    {
      'assessmentId': assessmentId,
      'limit': limit,
    },
  );
}

/// Assessment Engine domain endpoint.
/// {@category Endpoint}
class EndpointAssessment extends _i2.EndpointRef {
  EndpointAssessment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assessment';

  _i3.Future<_i28.Assessment?> getAssessmentForCourse(int courseVersionId) =>
      caller.callServerEndpoint<_i28.Assessment?>(
        'assessment',
        'getAssessmentForCourse',
        {'courseVersionId': courseVersionId},
      );

  _i3.Future<List<_i26.Question>> getQuestions(int questionBankId) =>
      caller.callServerEndpoint<List<_i26.Question>>(
        'assessment',
        'getQuestions',
        {'questionBankId': questionBankId},
      );

  /// When [skipInterAttemptCooldown] is true, the 24h gap between completed
  /// attempts is not enforced (explicit learner retake from review / practice).
  _i3.Future<_i29.AssessmentAttempt> startAttempt({
    required int userId,
    required int assessmentId,
    int? enrollmentId,
    required bool skipInterAttemptCooldown,
  }) => caller.callServerEndpoint<_i29.AssessmentAttempt>(
    'assessment',
    'startAttempt',
    {
      'userId': userId,
      'assessmentId': assessmentId,
      'enrollmentId': enrollmentId,
      'skipInterAttemptCooldown': skipInterAttemptCooldown,
    },
  );

  /// Completed attempts for trainer-visible learner transcript (same org).
  _i3.Future<List<_i29.AssessmentAttempt>> listCompletedAttemptsForUser({
    required int userId,
  }) => caller.callServerEndpoint<List<_i29.AssessmentAttempt>>(
    'assessment',
    'listCompletedAttemptsForUser',
    {'userId': userId},
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

  _i3.Future<_i29.AssessmentAttempt> submitAttempt({required int attemptId}) =>
      caller.callServerEndpoint<_i29.AssessmentAttempt>(
        'assessment',
        'submitAttempt',
        {'attemptId': attemptId},
      );

  _i3.Future<_i30.AssessmentResult> recordAnswer({
    required int attemptId,
    required int questionId,
    required String answer,
  }) => caller.callServerEndpoint<_i30.AssessmentResult>(
    'assessment',
    'recordAnswer',
    {
      'attemptId': attemptId,
      'questionId': questionId,
      'answer': answer,
    },
  );

  _i3.Future<List<_i27.QuestionBank>> listQuestionBanks({
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i27.QuestionBank>>(
    'assessment',
    'listQuestionBanks',
    {'organizationId': organizationId},
  );

  _i3.Future<_i27.QuestionBank> createQuestionBank({
    required String name,
    required int organizationId,
    String? tagsJson,
  }) => caller.callServerEndpoint<_i27.QuestionBank>(
    'assessment',
    'createQuestionBank',
    {
      'name': name,
      'organizationId': organizationId,
      'tagsJson': tagsJson,
    },
  );

  /// Generate a random assessment selection from a question bank using Fisher-Yates shuffle.
  _i3.Future<List<_i26.Question>> generateRandomAssessment({
    required int questionBankId,
    required int count,
  }) => caller.callServerEndpoint<List<_i26.Question>>(
    'assessment',
    'generateRandomAssessment',
    {
      'questionBankId': questionBankId,
      'count': count,
    },
  );

  /// Bulk import questions into a question bank.
  _i3.Future<List<_i26.Question>> importQuestionsToBank({
    required int targetBankId,
    required List<Map<String, dynamic>> questions,
  }) => caller.callServerEndpoint<List<_i26.Question>>(
    'assessment',
    'importQuestionsToBank',
    {
      'targetBankId': targetBankId,
      'questions': questions,
    },
  );

  /// List assessment results that need manual grading for a given assessment.
  _i3.Future<List<_i30.AssessmentResult>> listUngradedResults({
    required int assessmentId,
  }) => caller.callServerEndpoint<List<_i30.AssessmentResult>>(
    'assessment',
    'listUngradedResults',
    {'assessmentId': assessmentId},
  );

  /// Grade an individual assessment result (open_ended / short_answer).
  /// Recalculates the attempt score after grading.
  _i3.Future<_i30.AssessmentResult> gradeResult({
    required int resultId,
    required bool correct,
    int? manualScore,
  }) => caller.callServerEndpoint<_i30.AssessmentResult>(
    'assessment',
    'gradeResult',
    {
      'resultId': resultId,
      'correct': correct,
      'manualScore': manualScore,
    },
  );

  /// List all results for a specific attempt (for instructor review).
  _i3.Future<List<_i30.AssessmentResult>> listResultsForAttempt({
    required int attemptId,
  }) => caller.callServerEndpoint<List<_i30.AssessmentResult>>(
    'assessment',
    'listResultsForAttempt',
    {'attemptId': attemptId},
  );
}

/// {@category Endpoint}
class EndpointAssignment extends _i2.EndpointRef {
  EndpointAssignment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assignment';

  _i3.Future<_i31.Assignment> createAssignment({
    required int lessonId,
    required String title,
    String? instructions,
    String? allowedFileTypes,
  }) => caller.callServerEndpoint<_i31.Assignment>(
    'assignment',
    'createAssignment',
    {
      'lessonId': lessonId,
      'title': title,
      'instructions': instructions,
      'allowedFileTypes': allowedFileTypes,
    },
  );

  _i3.Future<_i31.Assignment?> getAssignment(int assignmentId) =>
      caller.callServerEndpoint<_i31.Assignment?>(
        'assignment',
        'getAssignment',
        {'assignmentId': assignmentId},
      );

  _i3.Future<List<_i31.Assignment>> listByLesson({required int lessonId}) =>
      caller.callServerEndpoint<List<_i31.Assignment>>(
        'assignment',
        'listByLesson',
        {'lessonId': lessonId},
      );

  _i3.Future<_i31.Assignment> updateAssignment({
    required int assignmentId,
    String? title,
    String? instructions,
    String? allowedFileTypes,
  }) => caller.callServerEndpoint<_i31.Assignment>(
    'assignment',
    'updateAssignment',
    {
      'assignmentId': assignmentId,
      'title': title,
      'instructions': instructions,
      'allowedFileTypes': allowedFileTypes,
    },
  );

  _i3.Future<bool> deleteAssignment({required int assignmentId}) =>
      caller.callServerEndpoint<bool>(
        'assignment',
        'deleteAssignment',
        {'assignmentId': assignmentId},
      );

  _i3.Future<_i32.AssignmentSubmission> submitAssignment({
    required int assignmentId,
    int? userId,
    String? submissionUrl,
    String? storageKey,
    String? fileName,
  }) => caller.callServerEndpoint<_i32.AssignmentSubmission>(
    'assignment',
    'submitAssignment',
    {
      'assignmentId': assignmentId,
      'userId': userId,
      'submissionUrl': submissionUrl,
      'storageKey': storageKey,
      'fileName': fileName,
    },
  );

  _i3.Future<List<_i32.AssignmentSubmission>> listSubmissions({
    required int assignmentId,
  }) => caller.callServerEndpoint<List<_i32.AssignmentSubmission>>(
    'assignment',
    'listSubmissions',
    {'assignmentId': assignmentId},
  );

  _i3.Future<_i32.AssignmentSubmission> gradeSubmission({
    required int submissionId,
    required int grade,
    String? feedback,
  }) => caller.callServerEndpoint<_i32.AssignmentSubmission>(
    'assignment',
    'gradeSubmission',
    {
      'submissionId': submissionId,
      'grade': grade,
      'feedback': feedback,
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

  /// Get audit trail entries for the currently authenticated user (no special permission required).
  /// Trainers call this to populate their "Recent Activity" feed on the dashboard.
  ///
  /// In demo/dev mode the session has no real auth, so the caller can pass
  /// [userId] explicitly. When a real auth session exists the server resolves
  /// the user from the session and ignores [userId].
  ///
  /// If no entries are found for the specific user (e.g. older entries were
  /// logged without a userId), recent entries across the entire audit trail
  /// are returned as a fallback so the card is never empty when data exists.
  _i3.Future<List<_i33.AuditTrail>> getMyAuditTrail({
    required int limit,
    int? userId,
  }) => caller.callServerEndpoint<List<_i33.AuditTrail>>(
    'audit',
    'getMyAuditTrail',
    {
      'limit': limit,
      'userId': userId,
    },
  );

  _i3.Future<List<_i33.AuditTrail>> getAuditTrail({
    String? entityType,
    String? entityId,
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<List<_i33.AuditTrail>>(
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
  _i3.Future<List<_i33.AuditTrail>> getConfigChangeLog({
    String? entityType,
    required int limit,
    DateTime? from,
    DateTime? to,
  }) => caller.callServerEndpoint<List<_i33.AuditTrail>>(
    'audit',
    'getConfigChangeLog',
    {
      'entityType': entityType,
      'limit': limit,
      'from': from,
      'to': to,
    },
  );

  _i3.Future<List<_i34.AccessLog>> getAccessLogs({
    int? userId,
    DateTime? from,
    DateTime? to,
    required int limit,
  }) => caller.callServerEndpoint<List<_i34.AccessLog>>(
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
class EndpointAuditFeed extends _i2.EndpointRef {
  EndpointAuditFeed(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auditFeed';

  _i3.Future<List<_i33.AuditTrail>> getRecentAuditEvents() =>
      caller.callServerEndpoint<List<_i33.AuditTrail>>(
        'auditFeed',
        'getRecentAuditEvents',
        {},
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

/// Batch feed: announcements for roster (assignments, live session notes, general).
/// {@category Endpoint}
class EndpointBatchAnnouncement extends _i2.EndpointRef {
  EndpointBatchAnnouncement(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'batchAnnouncement';

  _i3.Future<List<_i35.BatchAnnouncement>> listForBatch(int batchId) =>
      caller.callServerEndpoint<List<_i35.BatchAnnouncement>>(
        'batchAnnouncement',
        'listForBatch',
        {'batchId': batchId},
      );

  _i3.Future<_i35.BatchAnnouncement?> createForBatch({
    required int batchId,
    required String title,
    required String body,
    required String kind,
    int? relatedLiveClassId,
  }) => caller.callServerEndpoint<_i35.BatchAnnouncement?>(
    'batchAnnouncement',
    'createForBatch',
    {
      'batchId': batchId,
      'title': title,
      'body': body,
      'kind': kind,
      'relatedLiveClassId': relatedLiveClassId,
    },
  );
}

/// Certificate management endpoint for Admin Portal.
/// Manages training certificates and their lifecycle.
/// {@category Endpoint}
class EndpointCertificate extends _i2.EndpointRef {
  EndpointCertificate(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'certificate';

  /// List all certificates for an organization.
  _i3.Future<List<_i21.Certificate>> listCertificates({
    required int organizationId,
    String? status,
    int? userId,
    int? courseVersionId,
    int? limit,
  }) => caller.callServerEndpoint<List<_i21.Certificate>>(
    'certificate',
    'listCertificates',
    {
      'organizationId': organizationId,
      'status': status,
      'userId': userId,
      'courseVersionId': courseVersionId,
      'limit': limit,
    },
  );

  /// Get a single certificate by ID.
  _i3.Future<_i21.Certificate?> getCertificate(int certificateId) =>
      caller.callServerEndpoint<_i21.Certificate?>(
        'certificate',
        'getCertificate',
        {'certificateId': certificateId},
      );

  /// Get certificates for a specific user.
  _i3.Future<List<_i21.Certificate>> getUserCertificates(int userId) =>
      caller.callServerEndpoint<List<_i21.Certificate>>(
        'certificate',
        'getUserCertificates',
        {'userId': userId},
      );

  /// Revoke a certificate.
  _i3.Future<_i21.Certificate?> revokeCertificate(
    int certificateId, {
    String? reason,
  }) => caller.callServerEndpoint<_i21.Certificate?>(
    'certificate',
    'revokeCertificate',
    {
      'certificateId': certificateId,
      'reason': reason,
    },
  );

  /// Get certificate statistics for dashboard.
  _i3.Future<Map<String, int>> getCertificateStats(int organizationId) =>
      caller.callServerEndpoint<Map<String, int>>(
        'certificate',
        'getCertificateStats',
        {'organizationId': organizationId},
      );

  /// Verify a certificate by QR code.
  _i3.Future<_i21.Certificate?> verifyCertificate(String qrCode) =>
      caller.callServerEndpoint<_i21.Certificate?>(
        'certificate',
        'verifyCertificate',
        {'qrCode': qrCode},
      );

  /// Manually issue a certificate to a user for a course version.
  _i3.Future<_i21.Certificate?> issueCertificate({
    required int userId,
    required int courseVersionId,
    DateTime? expiresAt,
    int? templateId,
  }) => caller.callServerEndpoint<_i21.Certificate?>(
    'certificate',
    'issueCertificate',
    {
      'userId': userId,
      'courseVersionId': courseVersionId,
      'expiresAt': expiresAt,
      'templateId': templateId,
    },
  );

  /// Generate certificates for all eligible batch participants.
  _i3.Future<List<_i21.Certificate>> generateBatchCertificates({
    required int batchId,
    int? templateId,
    DateTime? expiresAt,
  }) => caller.callServerEndpoint<List<_i21.Certificate>>(
    'certificate',
    'generateBatchCertificates',
    {
      'batchId': batchId,
      'templateId': templateId,
      'expiresAt': expiresAt,
    },
  );

  /// Render certificate as merged HTML by applying template merge fields.
  _i3.Future<String> renderCertificateHtml({
    required int certificateId,
    int? templateId,
  }) => caller.callServerEndpoint<String>(
    'certificate',
    'renderCertificateHtml',
    {
      'certificateId': certificateId,
      'templateId': templateId,
    },
  );
}

/// CRUD for certificate templates (Admin Portal).
/// {@category Endpoint}
class EndpointCertificateTemplate extends _i2.EndpointRef {
  EndpointCertificateTemplate(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'certificateTemplate';

  _i3.Future<List<_i36.CertificateTemplate>> listTemplates({
    required int organizationId,
  }) => caller.callServerEndpoint<List<_i36.CertificateTemplate>>(
    'certificateTemplate',
    'listTemplates',
    {'organizationId': organizationId},
  );

  _i3.Future<_i36.CertificateTemplate?> getTemplate(int id) =>
      caller.callServerEndpoint<_i36.CertificateTemplate?>(
        'certificateTemplate',
        'getTemplate',
        {'id': id},
      );

  _i3.Future<_i36.CertificateTemplate> createTemplate({
    required int organizationId,
    required String name,
    required String htmlTemplate,
    required bool isDefault,
  }) => caller.callServerEndpoint<_i36.CertificateTemplate>(
    'certificateTemplate',
    'createTemplate',
    {
      'organizationId': organizationId,
      'name': name,
      'htmlTemplate': htmlTemplate,
      'isDefault': isDefault,
    },
  );

  _i3.Future<_i36.CertificateTemplate> updateTemplate({
    required int templateId,
    String? name,
    String? htmlTemplate,
    bool? isDefault,
  }) => caller.callServerEndpoint<_i36.CertificateTemplate>(
    'certificateTemplate',
    'updateTemplate',
    {
      'templateId': templateId,
      'name': name,
      'htmlTemplate': htmlTemplate,
      'isDefault': isDefault,
    },
  );

  _i3.Future<bool> deleteTemplate(int templateId) =>
      caller.callServerEndpoint<bool>(
        'certificateTemplate',
        'deleteTemplate',
        {'templateId': templateId},
      );

  /// Preview: merge sample data into template HTML and return the resulting HTML string.
  _i3.Future<String> previewTemplate({required String htmlTemplate}) =>
      caller.callServerEndpoint<String>(
        'certificateTemplate',
        'previewTemplate',
        {'htmlTemplate': htmlTemplate},
      );
}

/// Compliance Engine domain endpoint.
/// {@category Endpoint}
class EndpointCompliance extends _i2.EndpointRef {
  EndpointCompliance(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'compliance';

  _i3.Future<_i37.ComplianceMetrics> getDepartmentCompliance(
    int departmentId, {
    DateTime? asOf,
  }) => caller.callServerEndpoint<_i37.ComplianceMetrics>(
    'compliance',
    'getDepartmentCompliance',
    {
      'departmentId': departmentId,
      'asOf': asOf,
    },
  );

  _i3.Future<_i38.UserComplianceMetrics> getUserCompliance(
    int userId, {
    DateTime? asOf,
  }) => caller.callServerEndpoint<_i38.UserComplianceMetrics>(
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

  /// E-signature readiness for the learner dashboard: signed training records,
  /// pending retraining acknowledgement, and assessments awaiting signature.
  _i3.Future<List<Map<String, String>>> getEsignatureSummaryForUser(
    int userId,
  ) => caller.callServerEndpoint<List<Map<String, String>>>(
    'compliance',
    'getEsignatureSummaryForUser',
    {'userId': userId},
  );
}

/// Course builder endpoint for SME/trainers (TC-07: restricted editing).
/// {@category Endpoint}
class EndpointCourseBuilder extends _i2.EndpointRef {
  EndpointCourseBuilder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'courseBuilder';

  _i3.Future<_i39.Module> createModule({
    required int courseVersionId,
    required String title,
    required int orderIndex,
  }) => caller.callServerEndpoint<_i39.Module>(
    'courseBuilder',
    'createModule',
    {
      'courseVersionId': courseVersionId,
      'title': title,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i39.Module> updateModule({
    required int moduleId,
    String? title,
    int? orderIndex,
  }) => caller.callServerEndpoint<_i39.Module>(
    'courseBuilder',
    'updateModule',
    {
      'moduleId': moduleId,
      'title': title,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i40.Lesson> createLesson({
    required int moduleId,
    required String title,
    required int materialId,
    required int orderIndex,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
  }) => caller.callServerEndpoint<_i40.Lesson>(
    'courseBuilder',
    'createLesson',
    {
      'moduleId': moduleId,
      'title': title,
      'materialId': materialId,
      'orderIndex': orderIndex,
      'durationMinutes': durationMinutes,
      'lessonType': lessonType,
      'minEngagementMinutes': minEngagementMinutes,
      'prerequisiteMode': prerequisiteMode,
    },
  );

  _i3.Future<_i40.Lesson> updateLesson({
    required int lessonId,
    String? title,
    int? materialId,
    int? orderIndex,
    int? durationMinutes,
    String? lessonType,
    int? minEngagementMinutes,
    String? prerequisiteMode,
  }) => caller.callServerEndpoint<_i40.Lesson>(
    'courseBuilder',
    'updateLesson',
    {
      'lessonId': lessonId,
      'title': title,
      'materialId': materialId,
      'orderIndex': orderIndex,
      'durationMinutes': durationMinutes,
      'lessonType': lessonType,
      'minEngagementMinutes': minEngagementMinutes,
      'prerequisiteMode': prerequisiteMode,
    },
  );

  /// Create new course version. TC-07: if course has approved version, only allow draft.
  /// When superseding (hasApproved), changeSummary is required (TRN-05).
  _i3.Future<_i41.CourseVersion> createCourseVersion({
    required int courseId,
    required String version,
    required String status,
    String? changeSummary,
  }) => caller.callServerEndpoint<_i41.CourseVersion>(
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
  _i3.Future<Map<String, String>> createNewVersionFromExisting({
    required int existingVersionId,
    required String changeSummary,
    required bool isMajorVersion,
    int? createdById,
  }) => caller.callServerEndpoint<Map<String, String>>(
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
  _i3.Future<_i41.CourseVersion> updateCourseVersionStatus({
    required int courseVersionId,
    required String status,
    int? approverId,
  }) => caller.callServerEndpoint<_i41.CourseVersion>(
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
  _i3.Future<_i42.QaValidationResult> validateForQaSubmission({
    required int courseVersionId,
  }) => caller.callServerEndpoint<_i42.QaValidationResult>(
    'courseBuilder',
    'validateForQaSubmission',
    {'courseVersionId': courseVersionId},
  );

  /// TRN-WF-04: Submit course for QA review.
  /// Validates all rules first, then changes status to pending_approval if all pass.
  /// Returns the updated CourseVersion or throws if validation fails.
  _i3.Future<_i41.CourseVersion> submitForQaReview({
    required int courseVersionId,
    int? submittedById,
  }) => caller.callServerEndpoint<_i41.CourseVersion>(
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
  _i3.Future<_i40.Lesson> updateLessonMaterial({
    required int lessonId,
    required int materialId,
  }) => caller.callServerEndpoint<_i40.Lesson>(
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

  _i3.Future<List<_i43.Course>> listCourses({
    int? organizationId,
    String? status,
    String? search,
  }) => caller.callServerEndpoint<List<_i43.Course>>(
    'course',
    'listCourses',
    {
      'organizationId': organizationId,
      'status': status,
      'search': search,
    },
  );

  /// Courses the signed-in user created in their org that are assignable: published
  /// (approved / published / effective / [publishedAt]) or have an approved/effective version.
  ///
  /// [search] optional DB filter (ILIKE on title, SOP, description).
  _i3.Future<List<_i43.Course>> listTrainerPublishedCoursesForAssignment({
    String? search,
  }) => caller.callServerEndpoint<List<_i43.Course>>(
    'course',
    'listTrainerPublishedCoursesForAssignment',
    {'search': search},
  );

  _i3.Future<_i43.Course?> getCourse(int id) =>
      caller.callServerEndpoint<_i43.Course?>(
        'course',
        'getCourse',
        {'id': id},
      );

  _i3.Future<List<_i41.CourseVersion>> getCourseVersions(int courseId) =>
      caller.callServerEndpoint<List<_i41.CourseVersion>>(
        'course',
        'getCourseVersions',
        {'courseId': courseId},
      );

  _i3.Future<_i41.CourseVersion?> getCourseVersion(int courseVersionId) =>
      caller.callServerEndpoint<_i41.CourseVersion?>(
        'course',
        'getCourseVersion',
        {'courseVersionId': courseVersionId},
      );

  _i3.Future<_i43.Course> createCourse({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
  }) => caller.callServerEndpoint<_i43.Course>(
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
  _i3.Future<Map<String, String>> createCourseWithVersion({
    required String title,
    required int organizationId,
    String? sopNumber,
    String? description,
    int? createdById,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'course',
    'createCourseWithVersion',
    {
      'title': title,
      'organizationId': organizationId,
      'sopNumber': sopNumber,
      'description': description,
      'createdById': createdById,
      'previewVideoUrl': previewVideoUrl,
      'imageUrl': imageUrl,
      'tags': tags,
    },
  );

  _i3.Future<List<_i39.Module>> getModulesForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i39.Module>>(
    'course',
    'getModulesForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  _i3.Future<List<_i40.Lesson>> getLessonsForModule(int moduleId) =>
      caller.callServerEndpoint<List<_i40.Lesson>>(
        'course',
        'getLessonsForModule',
        {'moduleId': moduleId},
      );

  _i3.Future<_i40.Lesson?> getLessonWithMaterial(int lessonId) =>
      caller.callServerEndpoint<_i40.Lesson?>(
        'course',
        'getLessonWithMaterial',
        {'lessonId': lessonId},
      );

  /// Search courses by title, description, or SOP number.
  _i3.Future<List<_i43.Course>> searchCourses({
    required String query,
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i43.Course>>(
    'course',
    'searchCourses',
    {
      'query': query,
      'organizationId': organizationId,
    },
  );

  /// Update course metadata (title, description, sopNumber, category, etc.).
  _i3.Future<_i43.Course> updateCourse({
    required int courseId,
    String? title,
    String? description,
    String? sopNumber,
    String? previewVideoUrl,
    String? imageUrl,
    String? tags,
    String? category,
    bool? disableSelfEnrollment,
    bool? featured,
  }) => caller.callServerEndpoint<_i43.Course>(
    'course',
    'updateCourse',
    {
      'courseId': courseId,
      'title': title,
      'description': description,
      'sopNumber': sopNumber,
      'previewVideoUrl': previewVideoUrl,
      'imageUrl': imageUrl,
      'tags': tags,
      'category': category,
      'disableSelfEnrollment': disableSelfEnrollment,
      'featured': featured,
    },
  );

  /// Delete a draft course with no enrollments. Cascades related rows so FK constraints do not fail.
  _i3.Future<void> deleteCourse({required int courseId}) =>
      caller.callServerEndpoint<void>(
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

  _i3.Future<List<_i44.Document>> listDocuments({
    int? organizationId,
    String? documentType,
  }) => caller.callServerEndpoint<List<_i44.Document>>(
    'document',
    'listDocuments',
    {
      'organizationId': organizationId,
      'documentType': documentType,
    },
  );

  _i3.Future<_i44.Document?> getDocument(int id) =>
      caller.callServerEndpoint<_i44.Document?>(
        'document',
        'getDocument',
        {'id': id},
      );

  /// QA gate: classify SOP update as training_required or no_training_required.
  _i3.Future<_i44.Document> updateDocumentQaClassification({
    required int documentId,
    required String trainingRequiredByQa,
    String? affectedDepartmentIdsJson,
    String? affectedRoleIdsJson,
  }) => caller.callServerEndpoint<_i44.Document>(
    'document',
    'updateDocumentQaClassification',
    {
      'documentId': documentId,
      'trainingRequiredByQa': trainingRequiredByQa,
      'affectedDepartmentIdsJson': affectedDepartmentIdsJson,
      'affectedRoleIdsJson': affectedRoleIdsJson,
    },
  );

  _i3.Future<List<_i45.DocumentVersion>> getDocumentVersions(int documentId) =>
      caller.callServerEndpoint<List<_i45.DocumentVersion>>(
        'document',
        'getDocumentVersions',
        {'documentId': documentId},
      );

  _i3.Future<_i44.Document> createDocument({
    required String title,
    required String documentNumber,
    required String documentType,
    required int organizationId,
  }) => caller.callServerEndpoint<_i44.Document>(
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
  _i3.Future<_i45.DocumentVersion> createDocumentVersion({
    required int documentId,
    required String version,
    required String storageKey,
    DateTime? effectiveDate,
    DateTime? obsoleteDate,
    int? versionMajor,
    int? versionMinor,
    bool? isMajorVersion,
  }) => caller.callServerEndpoint<_i45.DocumentVersion>(
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

  _i3.Future<List<_i46.DocumentLifecycle>> getDocumentLifecycle(
    int documentVersionId,
  ) => caller.callServerEndpoint<List<_i46.DocumentLifecycle>>(
    'document',
    'getDocumentLifecycle',
    {'documentVersionId': documentVersionId},
  );

  /// Transition document version lifecycle (QA-02). Enforces: draft→review→approved→effective→obsolete.
  /// Approved/Effective require QA e-sign. Obsolete requires reason.
  _i3.Future<_i46.DocumentLifecycle> transitionDocumentLifecycle({
    required int documentVersionId,
    required String newState,
    String? obsoleteReason,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? ipAddress,
  }) => caller.callServerEndpoint<_i46.DocumentLifecycle>(
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

  _i3.Future<_i47.ApprovalWorkflow> createApprovalStep({
    required int documentVersionId,
    required int step,
    required int approverId,
    required String status,
    int? esignatureId,
  }) => caller.callServerEndpoint<_i47.ApprovalWorkflow>(
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

/// Event trigger endpoint — invokes workflow processors (Kafka/future calls, automation services).
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
  _i3.Future<Map<String, String>> triggerCapaTrainingComplete({
    required int capaId,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'event',
    'triggerCapaTrainingComplete',
    {'capaId': capaId},
  );

  /// SYS-WF-08b: Compliance Drop Alert - check departments below threshold and notify QA.
  /// Triggers: When compliance rate falls below configured threshold (default 90%).
  /// Actions: Creates compliance alerts, notifies QA team, records in audit trail.
  _i3.Future<Map<String, String>> triggerComplianceDropAlert({
    required double threshold,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'event',
    'triggerComplianceDropAlert',
    {'threshold': threshold},
  );

  /// SYS-WF-09: New Training Course Release - assigns training to target roles.
  /// Triggers: When a new course version is published (status='effective').
  /// Actions: Uses TrainingMatrix to assign to affected job roles.
  _i3.Future<Map<String, String>> triggerNewCourseRelease({
    required int courseVersionId,
  }) => caller.callServerEndpoint<Map<String, String>>(
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
  _i3.Future<List<_i48.InspectionRecord>> listInspectionRecords({
    required int limit,
  }) => caller.callServerEndpoint<List<_i48.InspectionRecord>>(
    'inspection',
    'listInspectionRecords',
    {'limit': limit},
  );

  /// Create inspection record and generate time-limited access token.
  _i3.Future<Map<String, String>> createInspectionRecord({
    required String inspectionType,
    required int siteId,
    String? scopeDescription,
    DateTime? scheduledDate,
    String? inspectorNames,
    required int tokenHoursValid,
    int? createdById,
  }) => caller.callServerEndpoint<Map<String, String>>(
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
  _i3.Future<Map<String, String>?> validateAuditorToken({
    required String token,
  }) => caller.callServerEndpoint<Map<String, String>?>(
    'inspection',
    'validateAuditorToken',
    {'token': token},
  );

  /// List page logs for an inspection record (for auditor session widget).
  _i3.Future<List<_i49.AuditorPageLog>> listAuditorPageLogs({
    required int inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i49.AuditorPageLog>>(
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
  _i3.Future<List<_i50.InspectionPackage>> listInspectionPackages({
    required int inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i50.InspectionPackage>>(
    'inspection',
    'listInspectionPackages',
    {
      'inspectionRecordId': inspectionRecordId,
      'limit': limit,
    },
  );

  /// Generate evidence package for auditor (token-based). One-click from auditor portal.
  _i3.Future<Map<String, String>> generateEvidencePackageForAuditor({
    required String token,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'inspection',
    'generateEvidencePackageForAuditor',
    {'token': token},
  );

  /// Generate inspection package (summary of in-scope records).
  /// Creates package with isOfficial: false; QA Director must sign to make official.
  _i3.Future<Map<String, String>> generateInspectionPackage({
    required int inspectionRecordId,
    required int generatedById,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'inspection',
    'generateInspectionPackage',
    {
      'inspectionRecordId': inspectionRecordId,
      'generatedById': generatedById,
    },
  );

  /// Sign inspection package as official (QA Director e-sign). ADM-10.
  /// Requires QA Director, Admin, or QA role.
  _i3.Future<_i50.InspectionPackage> signInspectionPackageAsOfficial({
    required int packageId,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? ipAddress,
  }) => caller.callServerEndpoint<_i50.InspectionPackage>(
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
  _i3.Future<List<Map<String, String>>> searchEmployeesForAudit({
    required String query,
    int? inspectionRecordId,
    required int limit,
  }) => caller.callServerEndpoint<List<Map<String, String>>>(
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
  _i3.Future<Map<String, String>> getSopTrainingCoverage({
    required int sopDocumentId,
    required int versionId,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'inspection',
    'getSopTrainingCoverage',
    {
      'sopDocumentId': sopDocumentId,
      'versionId': versionId,
    },
  );
}

/// Learner ↔ course owner (trainer) messaging for a course version.
/// {@category Endpoint}
class EndpointLearnerSupport extends _i2.EndpointRef {
  EndpointLearnerSupport(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'learnerSupport';

  _i3.Future<List<_i51.LearnerTrainerMessage>> listThread(
    int courseVersionId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i51.LearnerTrainerMessage>>(
    'learnerSupport',
    'listThread',
    {
      'courseVersionId': courseVersionId,
      'limit': limit,
      'offset': offset,
    },
  );

  _i3.Future<_i51.LearnerTrainerMessage?> sendMessage({
    required int courseVersionId,
    required String body,
    int? parentMessageId,
    int? toUserId,
  }) => caller.callServerEndpoint<_i51.LearnerTrainerMessage?>(
    'learnerSupport',
    'sendMessage',
    {
      'courseVersionId': courseVersionId,
      'body': body,
      'parentMessageId': parentMessageId,
      'toUserId': toUserId,
    },
  );

  /// Inbox for course owners and batch instructors: one row per course version that has messages.
  _i3.Future<List<_i52.LearnerSupportThreadSummary>>
  listTrainerSupportThreads() =>
      caller.callServerEndpoint<List<_i52.LearnerSupportThreadSummary>>(
        'learnerSupport',
        'listTrainerSupportThreads',
        {},
      );

  /// Marks messages addressed to the current user in this thread as read (learner or trainer).
  _i3.Future<int> markThreadMessagesRead(int courseVersionId) =>
      caller.callServerEndpoint<int>(
        'learnerSupport',
        'markThreadMessagesRead',
        {'courseVersionId': courseVersionId},
      );
}

/// {@category Endpoint}
class EndpointLessonBlock extends _i2.EndpointRef {
  EndpointLessonBlock(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'lessonBlock';

  _i3.Future<List<_i53.LessonBlock>> listBlocks({required int lessonId}) =>
      caller.callServerEndpoint<List<_i53.LessonBlock>>(
        'lessonBlock',
        'listBlocks',
        {'lessonId': lessonId},
      );

  _i3.Future<_i53.LessonBlock> createBlock({
    required int lessonId,
    required String blockType,
    required String contentJson,
    required int orderIndex,
  }) => caller.callServerEndpoint<_i53.LessonBlock>(
    'lessonBlock',
    'createBlock',
    {
      'lessonId': lessonId,
      'blockType': blockType,
      'contentJson': contentJson,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<_i53.LessonBlock> updateBlock({
    required int blockId,
    String? contentJson,
    int? orderIndex,
  }) => caller.callServerEndpoint<_i53.LessonBlock>(
    'lessonBlock',
    'updateBlock',
    {
      'blockId': blockId,
      'contentJson': contentJson,
      'orderIndex': orderIndex,
    },
  );

  _i3.Future<bool> deleteBlock({required int blockId}) =>
      caller.callServerEndpoint<bool>(
        'lessonBlock',
        'deleteBlock',
        {'blockId': blockId},
      );

  _i3.Future<bool> reorderBlocks({
    required int lessonId,
    required List<int> blockIds,
  }) => caller.callServerEndpoint<bool>(
    'lessonBlock',
    'reorderBlocks',
    {
      'lessonId': lessonId,
      'blockIds': blockIds,
    },
  );
}

/// Live class session management for training batches.
/// {@category Endpoint}
class EndpointLiveClass extends _i2.EndpointRef {
  EndpointLiveClass(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'liveClass';

  _i3.Future<_i54.LiveClass?> create({
    required int batchId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    required int durationMinutes,
    String? meetingUrl,
    required bool autoRecording,
  }) => caller.callServerEndpoint<_i54.LiveClass?>(
    'liveClass',
    'create',
    {
      'batchId': batchId,
      'title': title,
      'description': description,
      'scheduledAt': scheduledAt,
      'durationMinutes': durationMinutes,
      'meetingUrl': meetingUrl,
      'autoRecording': autoRecording,
    },
  );

  _i3.Future<List<_i54.LiveClass>> listByBatch(int batchId) =>
      caller.callServerEndpoint<List<_i54.LiveClass>>(
        'liveClass',
        'listByBatch',
        {'batchId': batchId},
      );

  _i3.Future<_i54.LiveClass?> update({
    required int liveClassId,
    String? title,
    String? description,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? meetingUrl,
    bool? autoRecording,
  }) => caller.callServerEndpoint<_i54.LiveClass?>(
    'liveClass',
    'update',
    {
      'liveClassId': liveClassId,
      'title': title,
      'description': description,
      'scheduledAt': scheduledAt,
      'durationMinutes': durationMinutes,
      'meetingUrl': meetingUrl,
      'autoRecording': autoRecording,
    },
  );

  _i3.Future<bool> delete(int liveClassId) => caller.callServerEndpoint<bool>(
    'liveClass',
    'delete',
    {'liveClassId': liveClassId},
  );
}

/// Material & progress endpoint (M1 + M2 upload).
/// {@category Endpoint}
class EndpointMaterial extends _i2.EndpointRef {
  EndpointMaterial(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'material';

  _i3.Future<_i55.Material?> getMaterial(int id) =>
      caller.callServerEndpoint<_i55.Material?>(
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

  _i3.Future<_i55.Material> createMaterial({
    required String title,
    required String materialType,
    required int organizationId,
    String? contentUrl,
  }) => caller.callServerEndpoint<_i55.Material>(
    'material',
    'createMaterial',
    {
      'title': title,
      'materialType': materialType,
      'organizationId': organizationId,
      'contentUrl': contentUrl,
    },
  );

  /// Get the viewable URL for a material, handling both file-backed and URL-based types.
  _i3.Future<String?> getMaterialContentUrl(int materialId) =>
      caller.callServerEndpoint<String?>(
        'material',
        'getMaterialContentUrl',
        {'materialId': materialId},
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
  _i3.Future<_i56.MaterialVersion> createMaterialVersion({
    required int materialId,
    required String storageKey,
    String? fileHash,
    int? fileSizeBytes,
    String? changeSummary,
  }) => caller.callServerEndpoint<_i56.MaterialVersion>(
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
  _i3.Future<_i55.Material> updateMaterial({
    required int materialId,
    String? title,
    String? materialType,
  }) => caller.callServerEndpoint<_i55.Material>(
    'material',
    'updateMaterial',
    {
      'materialId': materialId,
      'title': title,
      'materialType': materialType,
    },
  );

  /// TRN-WF-02: Get latest version of a material.
  _i3.Future<_i56.MaterialVersion?> getLatestMaterialVersion(int materialId) =>
      caller.callServerEndpoint<_i56.MaterialVersion?>(
        'material',
        'getLatestMaterialVersion',
        {'materialId': materialId},
      );

  /// TRN-WF-02: Update virus scan status after scanning.
  _i3.Future<_i56.MaterialVersion> updateVirusScanStatus({
    required int materialVersionId,
    required String virusScanStatus,
  }) => caller.callServerEndpoint<_i56.MaterialVersion>(
    'material',
    'updateVirusScanStatus',
    {
      'materialVersionId': materialVersionId,
      'virusScanStatus': virusScanStatus,
    },
  );

  _i3.Future<List<_i56.MaterialVersion>> getMaterialVersions(int materialId) =>
      caller.callServerEndpoint<List<_i56.MaterialVersion>>(
        'material',
        'getMaterialVersions',
        {'materialId': materialId},
      );

  _i3.Future<List<_i55.Material>> listMaterials({
    required int organizationId,
  }) => caller.callServerEndpoint<List<_i55.Material>>(
    'material',
    'listMaterials',
    {'organizationId': organizationId},
  );

  /// Update or create material progress for minimum read time / pausable learning.
  /// Server-enforced: when progressPct=100 or completedAt is set, requires
  /// timeSpentSeconds >= lesson.durationMinutes*60, readTimeMet=true, and
  /// for video: videoWatchedPct>=90, for pdf: pdfScrollPct>=80 in interactionJson.
  _i3.Future<_i57.MaterialProgress> updateProgress({
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
  }) => caller.callServerEndpoint<_i57.MaterialProgress>(
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

  _i3.Future<_i57.MaterialProgress?> getProgress({
    required int userId,
    required int materialId,
    int? enrollmentId,
  }) => caller.callServerEndpoint<_i57.MaterialProgress?>(
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
  _i3.Future<_i57.MaterialProgress> recordEngagement({
    required int userId,
    required int materialId,
    required int lessonId,
    int? enrollmentId,
    required bool tabFocused,
    int? scrollDepthPct,
    int? videoWatchedPct,
    int? videoPositionSeconds,
    required int deltaSeconds,
  }) => caller.callServerEndpoint<_i57.MaterialProgress>(
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
  _i3.Future<Map<String, String>> getMaterialWithVersions({
    required int materialId,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'material',
    'getMaterialWithVersions',
    {'materialId': materialId},
  );
}

/// Unified messaging endpoint providing inbox aggregation, unread counts,
/// and paginated access across both learner↔trainer and trainer↔QA channels.
///
/// All methods return properly typed Serverpod protocol objects — no
/// Map<String,dynamic> returns, so the client deserializes everything correctly.
/// {@category Endpoint}
class EndpointMessaging extends _i2.EndpointRef {
  EndpointMessaging(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'messaging';

  /// Returns typed unread counts across all messaging channels.
  _i3.Future<_i58.MessagingUnreadCounts> getUnreadCounts() =>
      caller.callServerEndpoint<_i58.MessagingUnreadCounts>(
        'messaging',
        'getUnreadCounts',
        {},
      );

  /// Paginated message list for a course version thread.
  _i3.Future<List<_i51.LearnerTrainerMessage>> getThreadMessages({
    required int courseVersionId,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i51.LearnerTrainerMessage>>(
    'messaging',
    'getThreadMessages',
    {
      'courseVersionId': courseVersionId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Paginated inbox for trainers: one summary per course version with messages.
  _i3.Future<List<_i52.LearnerSupportThreadSummary>> getTrainerInbox({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i52.LearnerSupportThreadSummary>>(
    'messaging',
    'getTrainerInbox',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Paginated inbox for learners.
  _i3.Future<List<_i52.LearnerSupportThreadSummary>> getLearnerInbox({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i52.LearnerSupportThreadSummary>>(
    'messaging',
    'getLearnerInbox',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Paginated QA/SME review thread inbox for trainers.
  _i3.Future<List<_i59.SmeThreadSummary>> getQaInbox({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i59.SmeThreadSummary>>(
    'messaging',
    'getQaInbox',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// QA/SME inbox for QA reviewers.
  _i3.Future<List<_i59.SmeThreadSummary>> getQaReviewerInbox({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i59.SmeThreadSummary>>(
    'messaging',
    'getQaReviewerInbox',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Paginated QA/SME comment list for a course version.
  _i3.Future<List<_i60.SmeReviewComment>> getQaThreadComments({
    required int courseVersionId,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i60.SmeReviewComment>>(
    'messaging',
    'getQaThreadComments',
    {
      'courseVersionId': courseVersionId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Mark all QA comments in a thread as read for the current user.
  _i3.Future<int> markQaThreadRead(int courseVersionId) =>
      caller.callServerEndpoint<int>(
        'messaging',
        'markQaThreadRead',
        {'courseVersionId': courseVersionId},
      );

  /// Mark all learner↔trainer messages in a thread as read.
  _i3.Future<int> markLearnerThreadRead(int courseVersionId) =>
      caller.callServerEndpoint<int>(
        'messaging',
        'markLearnerThreadRead',
        {'courseVersionId': courseVersionId},
      );

  /// Returns unread in-app notification count.
  _i3.Future<int> getUnreadNotificationCount() =>
      caller.callServerEndpoint<int>(
        'messaging',
        'getUnreadNotificationCount',
        {},
      );

  /// Paginated notification list.
  _i3.Future<List<_i61.Notification>> getNotifications({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i61.Notification>>(
    'messaging',
    'getNotifications',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Mark all in-app notifications as read.
  _i3.Future<int> markAllNotificationsRead() => caller.callServerEndpoint<int>(
    'messaging',
    'markAllNotificationsRead',
    {},
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
  _i3.Future<_i62.MfaStatusResult> getMfaStatus() =>
      caller.callServerEndpoint<_i62.MfaStatusResult>(
        'mfa',
        'getMfaStatus',
        {},
      );

  /// Starts MFA enrollment. Generates secret and returns it for QR setup.
  _i3.Future<_i63.MfaEnrollResult> enrollMfa() =>
      caller.callServerEndpoint<_i63.MfaEnrollResult>(
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
  _i3.Future<List<_i64.InAppNotification>> getInAppNotifications(int userId) =>
      caller.callServerEndpoint<List<_i64.InAppNotification>>(
        'notification',
        'getInAppNotifications',
        {'userId': userId},
      );

  /// Get trainer-specific notifications (QA decisions, SOP updates, assignment alerts).
  _i3.Future<List<_i64.InAppNotification>> getTrainerNotifications(
    int userId,
  ) => caller.callServerEndpoint<List<_i64.InAppNotification>>(
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

  /// List all notifications for an organization (Admin Portal).
  _i3.Future<List<_i61.Notification>> listNotifications({
    required int organizationId,
    String? type,
    String? channel,
    String? deliveryStatus,
    int? limit,
  }) => caller.callServerEndpoint<List<_i61.Notification>>(
    'notification',
    'listNotifications',
    {
      'organizationId': organizationId,
      'type': type,
      'channel': channel,
      'deliveryStatus': deliveryStatus,
      'limit': limit,
    },
  );

  /// Create one in-app notification per user in the organization (admin broadcast).
  _i3.Future<int> broadcastInAppToOrganization({
    required int organizationId,
    required String message,
    required String type,
  }) => caller.callServerEndpoint<int>(
    'notification',
    'broadcastInAppToOrganization',
    {
      'organizationId': organizationId,
      'message': message,
      'type': type,
    },
  );
}

/// Notification Template management endpoint for Admin Portal.
/// Manages notification templates for various training events.
/// {@category Endpoint}
class EndpointNotificationTemplate extends _i2.EndpointRef {
  EndpointNotificationTemplate(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notificationTemplate';

  /// List all notification templates for an organization.
  _i3.Future<List<_i65.NotificationTemplate>> listTemplates({
    required int organizationId,
    String? status,
    String? type,
    String? channel,
    int? limit,
  }) => caller.callServerEndpoint<List<_i65.NotificationTemplate>>(
    'notificationTemplate',
    'listTemplates',
    {
      'organizationId': organizationId,
      'status': status,
      'type': type,
      'channel': channel,
      'limit': limit,
    },
  );

  /// Get a single notification template by ID.
  _i3.Future<_i65.NotificationTemplate?> getTemplate(int templateId) =>
      caller.callServerEndpoint<_i65.NotificationTemplate?>(
        'notificationTemplate',
        'getTemplate',
        {'templateId': templateId},
      );

  /// Create a new notification template.
  _i3.Future<_i65.NotificationTemplate?> createTemplate({
    required int organizationId,
    required String name,
    required String type,
    required String channel,
    String? triggerEvent,
    String? subject,
    required String bodyTemplate,
    required String status,
  }) => caller.callServerEndpoint<_i65.NotificationTemplate?>(
    'notificationTemplate',
    'createTemplate',
    {
      'organizationId': organizationId,
      'name': name,
      'type': type,
      'channel': channel,
      'triggerEvent': triggerEvent,
      'subject': subject,
      'bodyTemplate': bodyTemplate,
      'status': status,
    },
  );

  /// Update a notification template.
  _i3.Future<_i65.NotificationTemplate?> updateTemplate(
    int templateId, {
    String? name,
    String? type,
    String? channel,
    String? triggerEvent,
    String? subject,
    String? bodyTemplate,
    String? status,
  }) => caller.callServerEndpoint<_i65.NotificationTemplate?>(
    'notificationTemplate',
    'updateTemplate',
    {
      'templateId': templateId,
      'name': name,
      'type': type,
      'channel': channel,
      'triggerEvent': triggerEvent,
      'subject': subject,
      'bodyTemplate': bodyTemplate,
      'status': status,
    },
  );

  /// Delete a notification template.
  _i3.Future<bool> deleteTemplate(int templateId) =>
      caller.callServerEndpoint<bool>(
        'notificationTemplate',
        'deleteTemplate',
        {'templateId': templateId},
      );

  /// Get template statistics for dashboard.
  _i3.Future<Map<String, int>> getTemplateStats(int organizationId) =>
      caller.callServerEndpoint<Map<String, int>>(
        'notificationTemplate',
        'getTemplateStats',
        {'organizationId': organizationId},
      );

  /// Duplicate a template.
  _i3.Future<_i65.NotificationTemplate?> duplicateTemplate(
    int templateId, {
    String? newName,
  }) => caller.callServerEndpoint<_i65.NotificationTemplate?>(
    'notificationTemplate',
    'duplicateTemplate',
    {
      'templateId': templateId,
      'newName': newName,
    },
  );
}

/// Operator Qualification (OQ) / On-the-Job Training (OJT) workflow endpoint.
/// Implements the 4-phase OQ process: Theoretical → Practical → Dual E-Signature → QA Verification.
/// {@category Endpoint}
class EndpointOq extends _i2.EndpointRef {
  EndpointOq(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'oq';

  /// Create a practical checklist item for a competency.
  _i3.Future<_i66.PracticalChecklistItem?> createChecklistItem({
    required int competencyId,
    required String title,
    String? description,
    required int orderIndex,
    required bool isCritical,
    required int organizationId,
  }) => caller.callServerEndpoint<_i66.PracticalChecklistItem?>(
    'oq',
    'createChecklistItem',
    {
      'competencyId': competencyId,
      'title': title,
      'description': description,
      'orderIndex': orderIndex,
      'isCritical': isCritical,
      'organizationId': organizationId,
    },
  );

  /// List all checklist items for a competency.
  _i3.Future<List<_i66.PracticalChecklistItem>> listChecklistItems({
    required int competencyId,
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i66.PracticalChecklistItem>>(
    'oq',
    'listChecklistItems',
    {
      'competencyId': competencyId,
      'organizationId': organizationId,
    },
  );

  /// Update a checklist item.
  _i3.Future<_i66.PracticalChecklistItem?> updateChecklistItem({
    required int itemId,
    String? title,
    String? description,
    int? orderIndex,
    bool? isCritical,
  }) => caller.callServerEndpoint<_i66.PracticalChecklistItem?>(
    'oq',
    'updateChecklistItem',
    {
      'itemId': itemId,
      'title': title,
      'description': description,
      'orderIndex': orderIndex,
      'isCritical': isCritical,
    },
  );

  /// Delete a checklist item.
  _i3.Future<bool> deleteChecklistItem(int itemId) =>
      caller.callServerEndpoint<bool>(
        'oq',
        'deleteChecklistItem',
        {'itemId': itemId},
      );

  /// Record an observation for a trainee on a checklist item.
  /// Evaluator signs with e-signature.
  _i3.Future<_i67.ObservationLog?> recordObservation({
    required int userId,
    required int competencyId,
    required int checklistItemId,
    required String result,
    String? notes,
    required String evaluatorSignatureMeaning,
    String? evaluatorPasswordPlaintext,
    required int organizationId,
  }) => caller.callServerEndpoint<_i67.ObservationLog?>(
    'oq',
    'recordObservation',
    {
      'userId': userId,
      'competencyId': competencyId,
      'checklistItemId': checklistItemId,
      'result': result,
      'notes': notes,
      'evaluatorSignatureMeaning': evaluatorSignatureMeaning,
      'evaluatorPasswordPlaintext': evaluatorPasswordPlaintext,
      'organizationId': organizationId,
    },
  );

  /// Trainee countersigns an observation (dual e-signature).
  _i3.Future<_i67.ObservationLog?> traineeCountersignObservation({
    required int observationLogId,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) => caller.callServerEndpoint<_i67.ObservationLog?>(
    'oq',
    'traineeCountersignObservation',
    {
      'observationLogId': observationLogId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
    },
  );

  /// List observation logs for a user + competency.
  _i3.Future<List<_i67.ObservationLog>> listObservationsForUser({
    required int userId,
    int? competencyId,
  }) => caller.callServerEndpoint<List<_i67.ObservationLog>>(
    'oq',
    'listObservationsForUser',
    {
      'userId': userId,
      'competencyId': competencyId,
    },
  );

  /// Check if all practical checklist items for a competency are passed by a user,
  /// with both evaluator and trainee e-signatures.
  _i3.Future<Map<String, String>> getOqProgress({
    required int userId,
    required int competencyId,
    required int organizationId,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'oq',
    'getOqProgress',
    {
      'userId': userId,
      'competencyId': competencyId,
      'organizationId': organizationId,
    },
  );

  /// QA verifies the OQ is complete and awards the UserCompetency.
  /// Requires: all checklist items passed, all dual-signed, QA permission.
  _i3.Future<_i68.UserCompetency?> qaVerifyAndAwardCompetency({
    required int userId,
    required int competencyId,
    required int organizationId,
    required String qaSignatureMeaning,
    String? qaPasswordPlaintext,
    DateTime? expiresAt,
  }) => caller.callServerEndpoint<_i68.UserCompetency?>(
    'oq',
    'qaVerifyAndAwardCompetency',
    {
      'userId': userId,
      'competencyId': competencyId,
      'organizationId': organizationId,
      'qaSignatureMeaning': qaSignatureMeaning,
      'qaPasswordPlaintext': qaPasswordPlaintext,
      'expiresAt': expiresAt,
    },
  );

  /// List user competencies (active and expired).
  _i3.Future<List<_i68.UserCompetency>> listUserCompetencies({
    required int userId,
    required bool activeOnly,
  }) => caller.callServerEndpoint<List<_i68.UserCompetency>>(
    'oq',
    'listUserCompetencies',
    {
      'userId': userId,
      'activeOnly': activeOnly,
    },
  );

  /// Check if a user is qualified for a specific competency.
  _i3.Future<bool> isUserQualified({
    required int userId,
    required int competencyId,
  }) => caller.callServerEndpoint<bool>(
    'oq',
    'isUserQualified',
    {
      'userId': userId,
      'competencyId': competencyId,
    },
  );

  /// Create a new competency definition.
  _i3.Future<_i69.Competency?> createCompetency({
    required String name,
    required String code,
    int? level,
  }) => caller.callServerEndpoint<_i69.Competency?>(
    'oq',
    'createCompetency',
    {
      'name': name,
      'code': code,
      'level': level,
    },
  );

  /// List all competency definitions.
  _i3.Future<List<_i69.Competency>> listCompetencies() =>
      caller.callServerEndpoint<List<_i69.Competency>>(
        'oq',
        'listCompetencies',
        {},
      );
}

/// Organization & Identity domain endpoint.
/// {@category Endpoint}
class EndpointOrganization extends _i2.EndpointRef {
  EndpointOrganization(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  _i3.Future<List<_i70.Organization>> listOrganizations() =>
      caller.callServerEndpoint<List<_i70.Organization>>(
        'organization',
        'listOrganizations',
        {},
      );

  _i3.Future<_i70.Organization?> getOrganization(int id) =>
      caller.callServerEndpoint<_i70.Organization?>(
        'organization',
        'getOrganization',
        {'id': id},
      );

  _i3.Future<_i70.Organization> createOrganization({
    required String name,
    required String code,
  }) => caller.callServerEndpoint<_i70.Organization>(
    'organization',
    'createOrganization',
    {
      'name': name,
      'code': code,
    },
  );

  _i3.Future<List<_i71.Site>> listSites(int organizationId) =>
      caller.callServerEndpoint<List<_i71.Site>>(
        'organization',
        'listSites',
        {'organizationId': organizationId},
      );

  _i3.Future<List<_i72.Department>> listDepartments(int siteId) =>
      caller.callServerEndpoint<List<_i72.Department>>(
        'organization',
        'listDepartments',
        {'siteId': siteId},
      );

  _i3.Future<List<_i12.JobRole>> listJobRoles(int departmentId) =>
      caller.callServerEndpoint<List<_i12.JobRole>>(
        'organization',
        'listJobRoles',
        {'departmentId': departmentId},
      );

  _i3.Future<List<_i7.PharmaUser>> listUsers({
    int? organizationId,
    int? departmentId,
  }) => caller.callServerEndpoint<List<_i7.PharmaUser>>(
    'organization',
    'listUsers',
    {
      'organizationId': organizationId,
      'departmentId': departmentId,
    },
  );

  /// Update organization profile (name/code) within the caller's org scope.
  _i3.Future<_i70.Organization> updateOrganization({
    required int organizationId,
    String? name,
    String? code,
  }) => caller.callServerEndpoint<_i70.Organization>(
    'organization',
    'updateOrganization',
    {
      'organizationId': organizationId,
      'name': name,
      'code': code,
    },
  );

  /// Key-value settings for an organization (system_configuration rows).
  _i3.Future<List<_i73.SystemConfiguration>> listOrganizationSettings(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i73.SystemConfiguration>>(
    'organization',
    'listOrganizationSettings',
    {'organizationId': organizationId},
  );

  /// Upsert a single org-scoped setting.
  _i3.Future<_i73.SystemConfiguration> upsertOrganizationSetting({
    required int organizationId,
    required String key,
    required String value,
  }) => caller.callServerEndpoint<_i73.SystemConfiguration>(
    'organization',
    'upsertOrganizationSetting',
    {
      'organizationId': organizationId,
      'key': key,
      'value': value,
    },
  );
}

/// QA & Course Approval domain endpoint.
/// {@category Endpoint}
class EndpointQa extends _i2.EndpointRef {
  EndpointQa(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'qa';

  /// List course versions awaiting QA review (submitted or in review).
  _i3.Future<List<_i41.CourseVersion>> listPendingCourseVersions() =>
      caller.callServerEndpoint<List<_i41.CourseVersion>>(
        'qa',
        'listPendingCourseVersions',
        {},
      );

  /// Approve and publish a course version (QA sign-off). Sets status to effective.
  /// Marks previous effective versions obsolete and their certificates obsolete.
  /// reviewChecklistJson: QA-WF-01 structured checklist (content accuracy, etc.)
  _i3.Future<_i41.CourseVersion> approveCourseVersion({
    required int courseVersionId,
    required String passwordPlaintext,
    required String signatureMeaning,
    int? approverId,
    String? reviewChecklistJson,
  }) => caller.callServerEndpoint<_i41.CourseVersion>(
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
  _i3.Future<_i41.CourseVersion> rejectCourseVersion({
    required int courseVersionId,
    String? reason,
    required bool returnForChanges,
  }) => caller.callServerEndpoint<_i41.CourseVersion>(
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
  _i3.Future<_i41.CourseVersion> returnCourseForChanges({
    required int courseVersionId,
    required String comments,
    int? reviewerId,
  }) => caller.callServerEndpoint<_i41.CourseVersion>(
    'qa',
    'returnCourseForChanges',
    {
      'courseVersionId': courseVersionId,
      'comments': comments,
      'reviewerId': reviewerId,
    },
  );

  /// Get all course reviews for a course version.
  _i3.Future<List<_i74.CourseReview>> getCourseReviews({
    required int courseVersionId,
  }) => caller.callServerEndpoint<List<_i74.CourseReview>>(
    'qa',
    'getCourseReviews',
    {'courseVersionId': courseVersionId},
  );

  /// Get course reviews visible to the course trainer (no quality_event permission required).
  /// Trainers need to see QA comments / rejection reasons for their own courses.
  _i3.Future<List<_i74.CourseReview>> getCourseReviewsForTrainer({
    required int courseVersionId,
  }) => caller.callServerEndpoint<List<_i74.CourseReview>>(
    'qa',
    'getCourseReviewsForTrainer',
    {'courseVersionId': courseVersionId},
  );
}

/// Quality Event Integration domain endpoint.
/// {@category Endpoint}
class EndpointQualityEvent extends _i2.EndpointRef {
  EndpointQualityEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'qualityEvent';

  _i3.Future<List<_i75.QualityEvent>> listQualityEvents({
    int? siteId,
    String? eventType,
    String? status,
  }) => caller.callServerEndpoint<List<_i75.QualityEvent>>(
    'qualityEvent',
    'listQualityEvents',
    {
      'siteId': siteId,
      'eventType': eventType,
      'status': status,
    },
  );

  _i3.Future<_i75.QualityEvent?> getQualityEvent(int id) =>
      caller.callServerEndpoint<_i75.QualityEvent?>(
        'qualityEvent',
        'getQualityEvent',
        {'id': id},
      );

  _i3.Future<List<_i22.Capa>> listCapas({
    int? qualityEventId,
    String? status,
  }) => caller.callServerEndpoint<List<_i22.Capa>>(
    'qualityEvent',
    'listCapas',
    {
      'qualityEventId': qualityEventId,
      'status': status,
    },
  );

  _i3.Future<_i75.QualityEvent> createQualityEvent({
    required String eventType,
    required String title,
    required String status,
    String? referenceId,
    int? siteId,
  }) => caller.callServerEndpoint<_i75.QualityEvent>(
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
  _i3.Future<_i22.Capa> updateCapaStatus({
    required int capaId,
    required String status,
    String? rootCause,
    DateTime? rcaCompletedAt,
  }) => caller.callServerEndpoint<_i22.Capa>(
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
  _i3.Future<_i22.Capa> closeCapa({
    required int capaId,
    required int closedById,
  }) => caller.callServerEndpoint<_i22.Capa>(
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

  _i3.Future<_i22.Capa> createCapa({
    required int qualityEventId,
    String? description,
    String? rootCause,
    required bool trainingRequired,
  }) => caller.callServerEndpoint<_i22.Capa>(
    'qualityEvent',
    'createCapa',
    {
      'qualityEventId': qualityEventId,
      'description': description,
      'rootCause': rootCause,
      'trainingRequired': trainingRequired,
    },
  );

  _i3.Future<_i10.TrainingAssignment?> assignTrainingFromCapa({
    required int capaId,
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment?>(
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

  _i3.Future<List<_i76.InspectionReport>> listInspectionReports({
    int? organizationId,
    int? siteId,
  }) => caller.callServerEndpoint<List<_i76.InspectionReport>>(
    'qualityEvent',
    'listInspectionReports',
    {
      'organizationId': organizationId,
      'siteId': siteId,
    },
  );

  _i3.Future<_i76.InspectionReport> createInspectionReport({
    required int organizationId,
    required String status,
    int? siteId,
    String? inspector,
    DateTime? inspectionDate,
    String? findingsJson,
  }) => caller.callServerEndpoint<_i76.InspectionReport>(
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

/// Issues short-lived tokens for the WebSocket realtime connection (web server /ws/realtime).
/// {@category Endpoint}
class EndpointRealtime extends _i2.EndpointRef {
  EndpointRealtime(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'realtime';

  _i3.Future<String> getConnectionToken() => caller.callServerEndpoint<String>(
    'realtime',
    'getConnectionToken',
    {},
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
  ///
  /// On failure, returns a plain-text report starting with `SEED FAILED:` (HTTP 200)
  /// so `curl` shows the cause; check server logs for the same stack trace.
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

  /// Fix admin passwords by re-provisioning them with proper password hashes
  _i3.Future<String> fixAdminPasswords() => caller.callServerEndpoint<String>(
    'seed',
    'fixAdminPasswords',
    {},
  );
}

/// SME collaboration: invites, review comments, resolve workflow.
/// {@category Endpoint}
class EndpointSme extends _i2.EndpointRef {
  EndpointSme(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sme';

  _i3.Future<List<_i77.SmeAssignment>> listAssignmentsForCourse(int courseId) =>
      caller.callServerEndpoint<List<_i77.SmeAssignment>>(
        'sme',
        'listAssignmentsForCourse',
        {'courseId': courseId},
      );

  _i3.Future<_i77.SmeAssignment> inviteSme({
    required int courseId,
    required int smeUserId,
    int? courseVersionId,
  }) => caller.callServerEndpoint<_i77.SmeAssignment>(
    'sme',
    'inviteSme',
    {
      'courseId': courseId,
      'smeUserId': smeUserId,
      'courseVersionId': courseVersionId,
    },
  );

  _i3.Future<List<_i60.SmeReviewComment>> listCommentsForCourseVersion(
    int courseVersionId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i60.SmeReviewComment>>(
    'sme',
    'listCommentsForCourseVersion',
    {
      'courseVersionId': courseVersionId,
      'limit': limit,
      'offset': offset,
    },
  );

  _i3.Future<_i60.SmeReviewComment> addComment({
    required int courseVersionId,
    required String sectionRef,
    required String body,
    required String severity,
    int? parentCommentId,
  }) => caller.callServerEndpoint<_i60.SmeReviewComment>(
    'sme',
    'addComment',
    {
      'courseVersionId': courseVersionId,
      'sectionRef': sectionRef,
      'body': body,
      'severity': severity,
      'parentCommentId': parentCommentId,
    },
  );

  _i3.Future<_i60.SmeReviewComment> resolveComment({
    required int commentId,
    String? trainerResponse,
  }) => caller.callServerEndpoint<_i60.SmeReviewComment>(
    'sme',
    'resolveComment',
    {
      'commentId': commentId,
      'trainerResponse': trainerResponse,
    },
  );

  /// Mark all SME comments in a course version thread as read for the current user.
  /// Only marks comments authored by OTHER users (not your own).
  _i3.Future<int> markCommentsRead(int courseVersionId) =>
      caller.callServerEndpoint<int>(
        'sme',
        'markCommentsRead',
        {'courseVersionId': courseVersionId},
      );
}

/// SOP-Course linkage management endpoint.
/// {@category Endpoint}
class EndpointSopLinkage extends _i2.EndpointRef {
  EndpointSopLinkage(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sopLinkage';

  /// Link a SOP document to a course.
  _i3.Future<_i78.CourseSopLink> linkSopToCourse({
    required int courseId,
    required int documentId,
    int? linkedById,
  }) => caller.callServerEndpoint<_i78.CourseSopLink>(
    'sopLinkage',
    'linkSopToCourse',
    {
      'courseId': courseId,
      'documentId': documentId,
      'linkedById': linkedById,
    },
  );

  /// Unlink a SOP document from a course (soft-delete).
  _i3.Future<_i78.CourseSopLink> unlinkSopFromCourse({
    required int linkId,
    int? unlinkedById,
  }) => caller.callServerEndpoint<_i78.CourseSopLink>(
    'sopLinkage',
    'unlinkSopFromCourse',
    {
      'linkId': linkId,
      'unlinkedById': unlinkedById,
    },
  );

  /// Get all active SOP links for a course.
  _i3.Future<List<_i78.CourseSopLink>> getLinkedSops({required int courseId}) =>
      caller.callServerEndpoint<List<_i78.CourseSopLink>>(
        'sopLinkage',
        'getLinkedSops',
        {'courseId': courseId},
      );

  /// Get all courses linked to a specific SOP document.
  _i3.Future<List<_i78.CourseSopLink>> getCoursesForSop({
    required int documentId,
  }) => caller.callServerEndpoint<List<_i78.CourseSopLink>>(
    'sopLinkage',
    'getCoursesForSop',
    {'documentId': documentId},
  );
}

/// Standalone trainer assignments (not tied to a course lesson).
/// {@category Endpoint}
class EndpointStandaloneAssignment extends _i2.EndpointRef {
  EndpointStandaloneAssignment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'standaloneAssignment';

  _i3.Future<_i79.StandaloneAssignment?> createStandaloneAssignment({
    required int organizationId,
    required String title,
    String? instructions,
    required DateTime dueAt,
    required String contentKind,
    int? questionBankId,
    int? courseVersionId,
    required String targetType,
    int? targetDepartmentId,
    int? targetBatchId,
  }) => caller.callServerEndpoint<_i79.StandaloneAssignment?>(
    'standaloneAssignment',
    'createStandaloneAssignment',
    {
      'organizationId': organizationId,
      'title': title,
      'instructions': instructions,
      'dueAt': dueAt,
      'contentKind': contentKind,
      'questionBankId': questionBankId,
      'courseVersionId': courseVersionId,
      'targetType': targetType,
      'targetDepartmentId': targetDepartmentId,
      'targetBatchId': targetBatchId,
    },
  );

  _i3.Future<_i79.StandaloneAssignment?> updateStandaloneAssignment(
    int assignmentId, {
    String? title,
    String? instructions,
    DateTime? dueAt,
    String? contentKind,
    int? questionBankId,
    int? courseVersionId,
    String? targetType,
    int? targetDepartmentId,
    int? targetBatchId,
  }) => caller.callServerEndpoint<_i79.StandaloneAssignment?>(
    'standaloneAssignment',
    'updateStandaloneAssignment',
    {
      'assignmentId': assignmentId,
      'title': title,
      'instructions': instructions,
      'dueAt': dueAt,
      'contentKind': contentKind,
      'questionBankId': questionBankId,
      'courseVersionId': courseVersionId,
      'targetType': targetType,
      'targetDepartmentId': targetDepartmentId,
      'targetBatchId': targetBatchId,
    },
  );

  /// Publishes a draft assignment and creates recipient rows + in-app notifications.
  _i3.Future<_i79.StandaloneAssignment?> publishStandaloneAssignment(
    int assignmentId, {
    List<int>? individualUserIds,
  }) => caller.callServerEndpoint<_i79.StandaloneAssignment?>(
    'standaloneAssignment',
    'publishStandaloneAssignment',
    {
      'assignmentId': assignmentId,
      'individualUserIds': individualUserIds,
    },
  );

  _i3.Future<List<_i79.StandaloneAssignment>>
  listStandaloneAssignmentsForOrganization(
    int organizationId, {
    String? status,
    int? limit,
  }) => caller.callServerEndpoint<List<_i79.StandaloneAssignment>>(
    'standaloneAssignment',
    'listStandaloneAssignmentsForOrganization',
    {
      'organizationId': organizationId,
      'status': status,
      'limit': limit,
    },
  );

  _i3.Future<_i79.StandaloneAssignment?> getStandaloneAssignment(
    int assignmentId,
  ) => caller.callServerEndpoint<_i79.StandaloneAssignment?>(
    'standaloneAssignment',
    'getStandaloneAssignment',
    {'assignmentId': assignmentId},
  );

  /// Recipients for the current user (employee), with assignment embedded.
  _i3.Future<List<_i80.StandaloneAssignmentRecipient>>
  listMyStandaloneAssignmentRecipients() =>
      caller.callServerEndpoint<List<_i80.StandaloneAssignmentRecipient>>(
        'standaloneAssignment',
        'listMyStandaloneAssignmentRecipients',
        {},
      );

  _i3.Future<_i80.StandaloneAssignmentRecipient?>
  getStandaloneAssignmentRecipient(int recipientId) =>
      caller.callServerEndpoint<_i80.StandaloneAssignmentRecipient?>(
        'standaloneAssignment',
        'getStandaloneAssignmentRecipient',
        {'recipientId': recipientId},
      );

  _i3.Future<_i80.StandaloneAssignmentRecipient?> submitStandaloneAssignment(
    int recipientId, {
    required String responseJson,
  }) => caller.callServerEndpoint<_i80.StandaloneAssignmentRecipient?>(
    'standaloneAssignment',
    'submitStandaloneAssignment',
    {
      'recipientId': recipientId,
      'responseJson': responseJson,
    },
  );

  /// Grade a standalone assignment submission (trainer/admin).
  _i3.Future<_i80.StandaloneAssignmentRecipient?> gradeStandaloneSubmission({
    required int recipientId,
    required int grade,
    String? feedback,
  }) => caller.callServerEndpoint<_i80.StandaloneAssignmentRecipient?>(
    'standaloneAssignment',
    'gradeStandaloneSubmission',
    {
      'recipientId': recipientId,
      'grade': grade,
      'feedback': feedback,
    },
  );

  /// List all submitted (ungraded) recipients for an assignment (trainer grading queue).
  _i3.Future<List<_i80.StandaloneAssignmentRecipient>> listSubmittedForGrading({
    required int assignmentId,
  }) => caller.callServerEndpoint<List<_i80.StandaloneAssignmentRecipient>>(
    'standaloneAssignment',
    'listSubmittedForGrading',
    {'assignmentId': assignmentId},
  );
}

/// Training Batch management endpoint for Admin Portal.
/// Manages training batches/cohorts for instructor-led training.
/// {@category Endpoint}
class EndpointTrainingBatch extends _i2.EndpointRef {
  EndpointTrainingBatch(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'trainingBatch';

  /// List all training batches for an organization.
  _i3.Future<List<_i81.TrainingBatch>> listBatches({
    required int organizationId,
    String? status,
    int? courseVersionId,
    int? limit,
  }) => caller.callServerEndpoint<List<_i81.TrainingBatch>>(
    'trainingBatch',
    'listBatches',
    {
      'organizationId': organizationId,
      'status': status,
      'courseVersionId': courseVersionId,
      'limit': limit,
    },
  );

  /// Get a single training batch by ID.
  _i3.Future<_i81.TrainingBatch?> getBatch(int batchId) =>
      caller.callServerEndpoint<_i81.TrainingBatch?>(
        'trainingBatch',
        'getBatch',
        {'batchId': batchId},
      );

  /// Create a new training batch.
  _i3.Future<_i81.TrainingBatch?> createBatch({
    required int organizationId,
    required int courseVersionId,
    required String name,
    int? instructorId,
    required DateTime startDate,
    required DateTime endDate,
    required int capacity,
    String? location,
    String? notes,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  }) => caller.callServerEndpoint<_i81.TrainingBatch?>(
    'trainingBatch',
    'createBatch',
    {
      'organizationId': organizationId,
      'courseVersionId': courseVersionId,
      'name': name,
      'instructorId': instructorId,
      'startDate': startDate,
      'endDate': endDate,
      'capacity': capacity,
      'location': location,
      'notes': notes,
      'startTime': startTime,
      'endTime': endTime,
      'medium': medium,
      'meetingUrl': meetingUrl,
      'category': category,
      'description': description,
    },
  );

  /// Update a training batch.
  _i3.Future<_i81.TrainingBatch?> updateBatch(
    int batchId, {
    String? name,
    int? instructorId,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    String? status,
    String? location,
    String? notes,
    String? startTime,
    String? endTime,
    String? medium,
    String? meetingUrl,
    String? category,
    String? description,
  }) => caller.callServerEndpoint<_i81.TrainingBatch?>(
    'trainingBatch',
    'updateBatch',
    {
      'batchId': batchId,
      'name': name,
      'instructorId': instructorId,
      'startDate': startDate,
      'endDate': endDate,
      'capacity': capacity,
      'status': status,
      'location': location,
      'notes': notes,
      'startTime': startTime,
      'endTime': endTime,
      'medium': medium,
      'meetingUrl': meetingUrl,
      'category': category,
      'description': description,
    },
  );

  /// Delete a training batch.
  _i3.Future<bool> deleteBatch(int batchId) => caller.callServerEndpoint<bool>(
    'trainingBatch',
    'deleteBatch',
    {'batchId': batchId},
  );

  /// Get batch statistics for dashboard.
  _i3.Future<Map<String, int>> getBatchStats(int organizationId) =>
      caller.callServerEndpoint<Map<String, int>>(
        'trainingBatch',
        'getBatchStats',
        {'organizationId': organizationId},
      );

  /// Batches the signed-in user is on the roster for (employee ILT home).
  _i3.Future<List<_i81.TrainingBatch>> listBatchesForCurrentUser() =>
      caller.callServerEndpoint<List<_i81.TrainingBatch>>(
        'trainingBatch',
        'listBatchesForCurrentUser',
        {},
      );

  /// Roster visible to batch participants or users with training update (trainers/admins).
  _i3.Future<List<_i82.BatchParticipantInfo>> listBatchParticipantsForEmployee(
    int batchId,
  ) => caller.callServerEndpoint<List<_i82.BatchParticipantInfo>>(
    'trainingBatch',
    'listBatchParticipantsForEmployee',
    {'batchId': batchId},
  );

  /// Cohort average lesson progress vs current user for the batch's course version.
  _i3.Future<Map<String, String>> getBatchCohortProgress(int batchId) =>
      caller.callServerEndpoint<Map<String, String>>(
        'trainingBatch',
        'getBatchCohortProgress',
        {'batchId': batchId},
      );

  /// Add a user to a batch roster (admin/trainer).
  _i3.Future<_i83.TrainingBatchParticipant?> enrollUserInBatch({
    required int batchId,
    required int userId,
    String? role,
  }) => caller.callServerEndpoint<_i83.TrainingBatchParticipant?>(
    'trainingBatch',
    'enrollUserInBatch',
    {
      'batchId': batchId,
      'userId': userId,
      'role': role,
    },
  );

  /// Remove a user from a batch roster (admin/trainer).
  _i3.Future<bool> removeUserFromBatch({
    required int batchId,
    required int userId,
  }) => caller.callServerEndpoint<bool>(
    'trainingBatch',
    'removeUserFromBatch',
    {
      'batchId': batchId,
      'userId': userId,
    },
  );

  /// Mark attendance for a user in a batch (optionally tied to a live class session).
  _i3.Future<_i84.BatchAttendanceRecord?> markAttendance({
    required int batchId,
    required int userId,
    int? liveClassId,
    required String status,
    String? notes,
  }) => caller.callServerEndpoint<_i84.BatchAttendanceRecord?>(
    'trainingBatch',
    'markAttendance',
    {
      'batchId': batchId,
      'userId': userId,
      'liveClassId': liveClassId,
      'status': status,
      'notes': notes,
    },
  );

  /// Bulk mark attendance for multiple users in a batch session.
  _i3.Future<List<_i84.BatchAttendanceRecord>> bulkMarkAttendance({
    required int batchId,
    int? liveClassId,
    required List<Map<String, dynamic>> attendanceList,
  }) => caller.callServerEndpoint<List<_i84.BatchAttendanceRecord>>(
    'trainingBatch',
    'bulkMarkAttendance',
    {
      'batchId': batchId,
      'liveClassId': liveClassId,
      'attendanceList': attendanceList,
    },
  );

  /// List attendance records for a batch (optionally filtered by live class session).
  _i3.Future<List<_i84.BatchAttendanceRecord>> listAttendance({
    required int batchId,
    int? liveClassId,
  }) => caller.callServerEndpoint<List<_i84.BatchAttendanceRecord>>(
    'trainingBatch',
    'listAttendance',
    {
      'batchId': batchId,
      'liveClassId': liveClassId,
    },
  );

  /// Get attendance summary for a batch (per participant: total sessions, attended, absent).
  _i3.Future<List<Map<String, String>>> getAttendanceSummary({
    required int batchId,
  }) => caller.callServerEndpoint<List<Map<String, String>>>(
    'trainingBatch',
    'getAttendanceSummary',
    {'batchId': batchId},
  );

  /// Close a batch: mark as completed, generate certificates for all
  /// participants who met attendance requirements and passed assessments.
  /// Requires e-signature from the closer (instructor/admin).
  _i3.Future<Map<String, String>> closeBatch({
    required int batchId,
    required String signatureMeaning,
    String? passwordPlaintext,
    required double minAttendanceRate,
  }) => caller.callServerEndpoint<Map<String, String>>(
    'trainingBatch',
    'closeBatch',
    {
      'batchId': batchId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
      'minAttendanceRate': minAttendanceRate,
    },
  );
}

/// Training Assignment domain endpoint.
/// {@category Endpoint}
class EndpointTraining extends _i2.EndpointRef {
  EndpointTraining(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'training';

  /// List active signature meanings for e-signature dropdown (21 CFR Part 11).
  _i3.Future<List<_i9.SignatureMeaning>> listSignatureMeanings() =>
      caller.callServerEndpoint<List<_i9.SignatureMeaning>>(
        'training',
        'listSignatureMeanings',
        {},
      );

  _i3.Future<List<_i10.TrainingAssignment>> getAssignmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i10.TrainingAssignment>>(
        'training',
        'getAssignmentsForUser',
        {'userId': userId},
      );

  _i3.Future<_i10.TrainingAssignment> assignTraining({
    required int userId,
    required int courseVersionId,
    required int assignedById,
    required DateTime dueDate,
    required String priority,
    String? reason,
    required String source,
    required bool forceReassign,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment>(
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
  _i3.Future<_i10.TrainingAssignment> updateAssignment({
    required int assignmentId,
    DateTime? dueDate,
    String? priority,
    required int updatedById,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment>(
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
  _i3.Future<_i10.TrainingAssignment> cancelAssignment({
    required int assignmentId,
    required int cancelledById,
    required String reason,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment>(
    'training',
    'cancelAssignment',
    {
      'assignmentId': assignmentId,
      'cancelledById': cancelledById,
      'reason': reason,
    },
  );

  _i3.Future<List<_i85.Enrollment>> getEnrollmentsForUser(int userId) =>
      caller.callServerEndpoint<List<_i85.Enrollment>>(
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
  _i3.Future<_i85.Enrollment?> getEnrollmentById(int enrollmentId) =>
      caller.callServerEndpoint<_i85.Enrollment?>(
        'training',
        'getEnrollmentById',
        {'enrollmentId': enrollmentId},
      );

  /// Acknowledge retraining change summary with e-signature.
  /// Requires: enrollment has retrainingChangeSummary, acknowledgedAt is null, userId matches.
  _i3.Future<_i85.Enrollment> acknowledgeRetraining({
    required int enrollmentId,
    required int userId,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) => caller.callServerEndpoint<_i85.Enrollment>(
    'training',
    'acknowledgeRetraining',
    {
      'enrollmentId': enrollmentId,
      'userId': userId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
    },
  );

  _i3.Future<List<_i21.Certificate>> getCertificatesForUser(int userId) =>
      caller.callServerEndpoint<List<_i21.Certificate>>(
        'training',
        'getCertificatesForUser',
        {'userId': userId},
      );

  /// Training records for user (enrollment completions with score). Used for training history.
  _i3.Future<List<_i86.TrainingRecord>> getTrainingRecordsForUser(int userId) =>
      caller.callServerEndpoint<List<_i86.TrainingRecord>>(
        'training',
        'getTrainingRecordsForUser',
        {'userId': userId},
      );

  /// Get certificate by ID for verification and direct links.
  _i3.Future<_i21.Certificate?> getCertificateById(int certificateId) =>
      caller.callServerEndpoint<_i21.Certificate?>(
        'training',
        'getCertificateById',
        {'certificateId': certificateId},
      );

  /// Get a training waiver by ID. Returns the waiver only if the current user is the waiver owner (employee view).
  _i3.Future<_i14.TrainingWaiver?> getWaiverById(int waiverId) =>
      caller.callServerEndpoint<_i14.TrainingWaiver?>(
        'training',
        'getWaiverById',
        {'waiverId': waiverId},
      );

  /// Get signature with integrity verification. Returns null signature if not found.
  /// integrityViolation is true when HMAC mismatch (tampering detected).
  _i3.Future<_i87.SignatureVerificationResult> getSignatureWithIntegrityCheck(
    int signatureId,
  ) => caller.callServerEndpoint<_i87.SignatureVerificationResult>(
    'training',
    'getSignatureWithIntegrityCheck',
    {'signatureId': signatureId},
  );

  /// List electronic signatures for auditor verification (21 CFR Part 11).
  _i3.Future<List<_i88.ElectronicSignature>> listElectronicSignatures({
    DateTime? from,
    DateTime? to,
    String? entityType,
    int? userId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i88.ElectronicSignature>>(
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
  _i3.Future<_i21.Certificate> completeTraining({
    required int enrollmentId,
    required int userId,
    required int courseVersionId,
    required int esignatureId,
    int? score,
  }) => caller.callServerEndpoint<_i21.Certificate>(
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
  _i3.Future<List<_i89.TrainingRecordAnnotation>> listAnnotations(
    int trainingRecordId,
  ) => caller.callServerEndpoint<List<_i89.TrainingRecordAnnotation>>(
    'training',
    'listAnnotations',
    {'trainingRecordId': trainingRecordId},
  );

  /// QA-08: Add annotation to a training record (QA role).
  _i3.Future<_i89.TrainingRecordAnnotation> addAnnotation({
    required int trainingRecordId,
    required int authorId,
    required String note,
  }) => caller.callServerEndpoint<_i89.TrainingRecordAnnotation>(
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

  /// QA approves a training assignment (allows learner to begin).
  /// Sets assignment status from 'pending_qa' to 'active'.
  _i3.Future<_i10.TrainingAssignment> qaApproveAssignment({
    required int assignmentId,
    required String signatureMeaning,
    String? passwordPlaintext,
    String? comments,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment>(
    'training',
    'qaApproveAssignment',
    {
      'assignmentId': assignmentId,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
      'comments': comments,
    },
  );

  /// QA rejects/holds a training assignment. Learner cannot begin until resubmitted.
  _i3.Future<_i10.TrainingAssignment> qaRejectAssignment({
    required int assignmentId,
    required String reason,
    required String signatureMeaning,
    String? passwordPlaintext,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment>(
    'training',
    'qaRejectAssignment',
    {
      'assignmentId': assignmentId,
      'reason': reason,
      'signatureMeaning': signatureMeaning,
      'passwordPlaintext': passwordPlaintext,
    },
  );

  /// Submit assignment for QA approval (trainer/admin sets status to pending_qa).
  _i3.Future<_i10.TrainingAssignment> submitForQaApproval({
    required int assignmentId,
  }) => caller.callServerEndpoint<_i10.TrainingAssignment>(
    'training',
    'submitForQaApproval',
    {'assignmentId': assignmentId},
  );

  /// Self-enrollment for employee-initiated course enrollment.
  /// Creates a "self" source assignment and associated enrollment.
  /// Returns the created enrollment.
  _i3.Future<_i85.Enrollment> selfEnroll({
    required int userId,
    required int courseVersionId,
  }) => caller.callServerEndpoint<_i85.Enrollment>(
    'training',
    'selfEnroll',
    {
      'userId': userId,
      'courseVersionId': courseVersionId,
    },
  );

  /// Users who have an enrollment on any version of a course you created and published
  /// (same rules as [CourseEndpoint.listTrainerPublishedCoursesForAssignment]).
  ///
  /// When [search] and [limit] are both omitted, returns every distinct learner (legacy).
  /// When either is set, runs a bounded DB query (search uses ILIKE on name, email, employee id).
  _i3.Future<List<_i7.PharmaUser>>
  listLearnersEnrolledInTrainerPublishedCourses({
    String? search,
    int? limit,
  }) => caller.callServerEndpoint<List<_i7.PharmaUser>>(
    'training',
    'listLearnersEnrolledInTrainerPublishedCourses',
    {
      'search': search,
      'limit': limit,
    },
  );

  /// Get all enrollments for a specific course version (trainer view).
  _i3.Future<List<_i85.Enrollment>> getEnrollmentsForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i85.Enrollment>>(
    'training',
    'getEnrollmentsForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Get all assignments for a specific course version (trainer view).
  _i3.Future<List<_i10.TrainingAssignment>> getAssignmentsForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i10.TrainingAssignment>>(
    'training',
    'getAssignmentsForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Get all assignments across all courses in an organization (trainer overview).
  _i3.Future<List<_i10.TrainingAssignment>> getAllAssignments({
    int? organizationId,
  }) => caller.callServerEndpoint<List<_i10.TrainingAssignment>>(
    'training',
    'getAllAssignments',
    {'organizationId': organizationId},
  );

  /// Get training records for a specific course version (for analytics/learner progress).
  _i3.Future<List<_i86.TrainingRecord>> getTrainingRecordsForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i86.TrainingRecord>>(
    'training',
    'getTrainingRecordsForCourseVersion',
    {'courseVersionId': courseVersionId},
  );

  /// Get enrollment progress as a fraction: completedLessons / totalLessons.
  /// Returns a map with keys: completedLessons, totalLessons, progressPct.
  _i3.Future<Map<String, String>> getEnrollmentProgress(int enrollmentId) =>
      caller.callServerEndpoint<Map<String, String>>(
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
  _i3.Future<List<_i21.Certificate>> getCertificatesForCourseVersion(
    int courseVersionId,
  ) => caller.callServerEndpoint<List<_i21.Certificate>>(
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

  _i3.Future<_i7.PharmaUser?> getUser(int id) =>
      caller.callServerEndpoint<_i7.PharmaUser?>(
        'user',
        'getUser',
        {'id': id},
      );

  /// Returns PharmaUser by email.
  /// For demo/development: if no auth session, looks up user directly by email.
  /// For production: validates session and ensures user can only access own profile.
  _i3.Future<_i7.PharmaUser?> getUserByEmail(String email) =>
      caller.callServerEndpoint<_i7.PharmaUser?>(
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
  _i3.Future<List<_i90.UserPreference>> getUserPreferences({
    required int userId,
  }) => caller.callServerEndpoint<List<_i90.UserPreference>>(
    'user',
    'getUserPreferences',
    {'userId': userId},
  );

  /// Set a user preference (upsert).
  _i3.Future<_i90.UserPreference> setUserPreference({
    required int userId,
    required String key,
    required String value,
  }) => caller.callServerEndpoint<_i90.UserPreference>(
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
  _i3.Future<_i91.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i91.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_core = _i4.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
    auth = _i92.Caller(client);
  }

  late final _i4.Caller serverpod_auth_core;

  late final _i1.Caller serverpod_auth_idp;

  late final _i92.Caller auth;
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
         _i93.Protocol(),
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
    accessReview = EndpointAccessReview(this);
    adminUserManagement = EndpointAdminUserManagement(this);
    admin = EndpointAdmin(this);
    analytics = EndpointAnalytics(this);
    assessmentBuilder = EndpointAssessmentBuilder(this);
    assessment = EndpointAssessment(this);
    assignment = EndpointAssignment(this);
    audit = EndpointAudit(this);
    auditFeed = EndpointAuditFeed(this);
    auditTrail = EndpointAuditTrail(this);
    batchAnnouncement = EndpointBatchAnnouncement(this);
    certificate = EndpointCertificate(this);
    certificateTemplate = EndpointCertificateTemplate(this);
    compliance = EndpointCompliance(this);
    courseBuilder = EndpointCourseBuilder(this);
    course = EndpointCourse(this);
    document = EndpointDocument(this);
    event = EndpointEvent(this);
    inspection = EndpointInspection(this);
    learnerSupport = EndpointLearnerSupport(this);
    lessonBlock = EndpointLessonBlock(this);
    liveClass = EndpointLiveClass(this);
    material = EndpointMaterial(this);
    messaging = EndpointMessaging(this);
    mfa = EndpointMfa(this);
    notification = EndpointNotification(this);
    notificationTemplate = EndpointNotificationTemplate(this);
    oq = EndpointOq(this);
    organization = EndpointOrganization(this);
    qa = EndpointQa(this);
    qualityEvent = EndpointQualityEvent(this);
    realtime = EndpointRealtime(this);
    seed = EndpointSeed(this);
    sme = EndpointSme(this);
    sopLinkage = EndpointSopLinkage(this);
    standaloneAssignment = EndpointStandaloneAssignment(this);
    trainingBatch = EndpointTrainingBatch(this);
    training = EndpointTraining(this);
    user = EndpointUser(this);
    validation = EndpointValidation(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointOidcIdp oidcIdp;

  late final EndpointAccessReview accessReview;

  late final EndpointAdminUserManagement adminUserManagement;

  late final EndpointAdmin admin;

  late final EndpointAnalytics analytics;

  late final EndpointAssessmentBuilder assessmentBuilder;

  late final EndpointAssessment assessment;

  late final EndpointAssignment assignment;

  late final EndpointAudit audit;

  late final EndpointAuditFeed auditFeed;

  late final EndpointAuditTrail auditTrail;

  late final EndpointBatchAnnouncement batchAnnouncement;

  late final EndpointCertificate certificate;

  late final EndpointCertificateTemplate certificateTemplate;

  late final EndpointCompliance compliance;

  late final EndpointCourseBuilder courseBuilder;

  late final EndpointCourse course;

  late final EndpointDocument document;

  late final EndpointEvent event;

  late final EndpointInspection inspection;

  late final EndpointLearnerSupport learnerSupport;

  late final EndpointLessonBlock lessonBlock;

  late final EndpointLiveClass liveClass;

  late final EndpointMaterial material;

  late final EndpointMessaging messaging;

  late final EndpointMfa mfa;

  late final EndpointNotification notification;

  late final EndpointNotificationTemplate notificationTemplate;

  late final EndpointOq oq;

  late final EndpointOrganization organization;

  late final EndpointQa qa;

  late final EndpointQualityEvent qualityEvent;

  late final EndpointRealtime realtime;

  late final EndpointSeed seed;

  late final EndpointSme sme;

  late final EndpointSopLinkage sopLinkage;

  late final EndpointStandaloneAssignment standaloneAssignment;

  late final EndpointTrainingBatch trainingBatch;

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
    'accessReview': accessReview,
    'adminUserManagement': adminUserManagement,
    'admin': admin,
    'analytics': analytics,
    'assessmentBuilder': assessmentBuilder,
    'assessment': assessment,
    'assignment': assignment,
    'audit': audit,
    'auditFeed': auditFeed,
    'auditTrail': auditTrail,
    'batchAnnouncement': batchAnnouncement,
    'certificate': certificate,
    'certificateTemplate': certificateTemplate,
    'compliance': compliance,
    'courseBuilder': courseBuilder,
    'course': course,
    'document': document,
    'event': event,
    'inspection': inspection,
    'learnerSupport': learnerSupport,
    'lessonBlock': lessonBlock,
    'liveClass': liveClass,
    'material': material,
    'messaging': messaging,
    'mfa': mfa,
    'notification': notification,
    'notificationTemplate': notificationTemplate,
    'oq': oq,
    'organization': organization,
    'qa': qa,
    'qualityEvent': qualityEvent,
    'realtime': realtime,
    'seed': seed,
    'sme': sme,
    'sopLinkage': sopLinkage,
    'standaloneAssignment': standaloneAssignment,
    'trainingBatch': trainingBatch,
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
