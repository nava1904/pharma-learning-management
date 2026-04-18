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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../auth/oidc_idp_endpoint.dart' as _i4;
import '../endpoints/access_review_endpoint.dart' as _i5;
import '../endpoints/admin/admin_user_management_endpoint.dart' as _i6;
import '../endpoints/admin_endpoint.dart' as _i7;
import '../endpoints/analytics_endpoint.dart' as _i8;
import '../endpoints/assessment_builder_endpoint.dart' as _i9;
import '../endpoints/assessment_endpoint.dart' as _i10;
import '../endpoints/assignment_endpoint.dart' as _i11;
import '../endpoints/audit_endpoint.dart' as _i12;
import '../endpoints/audit_feed_endpoint.dart' as _i13;
import '../endpoints/audit_trail_endpoint.dart' as _i14;
import '../endpoints/batch_announcement_endpoint.dart' as _i15;
import '../endpoints/certificate_endpoint.dart' as _i16;
import '../endpoints/certificate_template_endpoint.dart' as _i17;
import '../endpoints/compliance_endpoint.dart' as _i18;
import '../endpoints/course_builder_endpoint.dart' as _i19;
import '../endpoints/course_endpoint.dart' as _i20;
import '../endpoints/document_endpoint.dart' as _i21;
import '../endpoints/event_endpoint.dart' as _i22;
import '../endpoints/inspection_endpoint.dart' as _i23;
import '../endpoints/learner_support_endpoint.dart' as _i24;
import '../endpoints/lesson_block_endpoint.dart' as _i25;
import '../endpoints/live_class_endpoint.dart' as _i26;
import '../endpoints/material_endpoint.dart' as _i27;
import '../endpoints/messaging_endpoint.dart' as _i28;
import '../endpoints/mfa_endpoint.dart' as _i29;
import '../endpoints/notification_endpoint.dart' as _i30;
import '../endpoints/notification_template_endpoint.dart' as _i31;
import '../endpoints/oq_endpoint.dart' as _i32;
import '../endpoints/organization_endpoint.dart' as _i33;
import '../endpoints/qa_endpoint.dart' as _i34;
import '../endpoints/quality_event_endpoint.dart' as _i35;
import '../endpoints/realtime_endpoint.dart' as _i36;
import '../endpoints/seed_endpoint.dart' as _i37;
import '../endpoints/sme_endpoint.dart' as _i38;
import '../endpoints/sop_linkage_endpoint.dart' as _i39;
import '../endpoints/standalone_assignment_endpoint.dart' as _i40;
import '../endpoints/training_batch_endpoint.dart' as _i41;
import '../endpoints/training_endpoint.dart' as _i42;
import '../endpoints/user_endpoint.dart' as _i43;
import '../endpoints/validation_endpoint.dart' as _i44;
import '../greetings/greeting_endpoint.dart' as _i45;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i46;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i47;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i48;
import 'package:pharma_lms_server/src/generated/future_calls.dart' as _i49;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'oidcIdp': _i4.OidcIdpEndpoint()
        ..initialize(
          server,
          'oidcIdp',
          null,
        ),
      'accessReview': _i5.AccessReviewEndpoint()
        ..initialize(
          server,
          'accessReview',
          null,
        ),
      'adminUserManagement': _i6.AdminUserManagementEndpoint()
        ..initialize(
          server,
          'adminUserManagement',
          null,
        ),
      'admin': _i7.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'analytics': _i8.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'assessmentBuilder': _i9.AssessmentBuilderEndpoint()
        ..initialize(
          server,
          'assessmentBuilder',
          null,
        ),
      'assessment': _i10.AssessmentEndpoint()
        ..initialize(
          server,
          'assessment',
          null,
        ),
      'assignment': _i11.AssignmentEndpoint()
        ..initialize(
          server,
          'assignment',
          null,
        ),
      'audit': _i12.AuditEndpoint()
        ..initialize(
          server,
          'audit',
          null,
        ),
      'auditFeed': _i13.AuditFeedEndpoint()
        ..initialize(
          server,
          'auditFeed',
          null,
        ),
      'auditTrail': _i14.AuditTrailEndpoint()
        ..initialize(
          server,
          'auditTrail',
          null,
        ),
      'batchAnnouncement': _i15.BatchAnnouncementEndpoint()
        ..initialize(
          server,
          'batchAnnouncement',
          null,
        ),
      'certificate': _i16.CertificateEndpoint()
        ..initialize(
          server,
          'certificate',
          null,
        ),
      'certificateTemplate': _i17.CertificateTemplateEndpoint()
        ..initialize(
          server,
          'certificateTemplate',
          null,
        ),
      'compliance': _i18.ComplianceEndpoint()
        ..initialize(
          server,
          'compliance',
          null,
        ),
      'courseBuilder': _i19.CourseBuilderEndpoint()
        ..initialize(
          server,
          'courseBuilder',
          null,
        ),
      'course': _i20.CourseEndpoint()
        ..initialize(
          server,
          'course',
          null,
        ),
      'document': _i21.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'event': _i22.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'inspection': _i23.InspectionEndpoint()
        ..initialize(
          server,
          'inspection',
          null,
        ),
      'learnerSupport': _i24.LearnerSupportEndpoint()
        ..initialize(
          server,
          'learnerSupport',
          null,
        ),
      'lessonBlock': _i25.LessonBlockEndpoint()
        ..initialize(
          server,
          'lessonBlock',
          null,
        ),
      'liveClass': _i26.LiveClassEndpoint()
        ..initialize(
          server,
          'liveClass',
          null,
        ),
      'material': _i27.MaterialEndpoint()
        ..initialize(
          server,
          'material',
          null,
        ),
      'messaging': _i28.MessagingEndpoint()
        ..initialize(
          server,
          'messaging',
          null,
        ),
      'mfa': _i29.MfaEndpoint()
        ..initialize(
          server,
          'mfa',
          null,
        ),
      'notification': _i30.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'notificationTemplate': _i31.NotificationTemplateEndpoint()
        ..initialize(
          server,
          'notificationTemplate',
          null,
        ),
      'oq': _i32.OqEndpoint()
        ..initialize(
          server,
          'oq',
          null,
        ),
      'organization': _i33.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'qa': _i34.QaEndpoint()
        ..initialize(
          server,
          'qa',
          null,
        ),
      'qualityEvent': _i35.QualityEventEndpoint()
        ..initialize(
          server,
          'qualityEvent',
          null,
        ),
      'realtime': _i36.RealtimeEndpoint()
        ..initialize(
          server,
          'realtime',
          null,
        ),
      'seed': _i37.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'sme': _i38.SmeEndpoint()
        ..initialize(
          server,
          'sme',
          null,
        ),
      'sopLinkage': _i39.SopLinkageEndpoint()
        ..initialize(
          server,
          'sopLinkage',
          null,
        ),
      'standaloneAssignment': _i40.StandaloneAssignmentEndpoint()
        ..initialize(
          server,
          'standaloneAssignment',
          null,
        ),
      'trainingBatch': _i41.TrainingBatchEndpoint()
        ..initialize(
          server,
          'trainingBatch',
          null,
        ),
      'training': _i42.TrainingEndpoint()
        ..initialize(
          server,
          'training',
          null,
        ),
      'user': _i43.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'validation': _i44.ValidationEndpoint()
        ..initialize(
          server,
          'validation',
          null,
        ),
      'greeting': _i45.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['oidcIdp'] = _i1.EndpointConnector(
      name: 'oidcIdp',
      endpoint: endpoints['oidcIdp']!,
      methodConnectors: {
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oidcIdp'] as _i4.OidcIdpEndpoint)
                  .hasAccount(session),
        ),
        'getClientConfig': _i1.MethodConnector(
          name: 'getClientConfig',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oidcIdp'] as _i4.OidcIdpEndpoint)
                  .getClientConfig(session),
        ),
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _i1.ParameterDescription(
              name: 'codeVerifier',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _i1.ParameterDescription(
              name: 'redirectUri',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oidcIdp'] as _i4.OidcIdpEndpoint).login(
                session,
                code: params['code'],
                codeVerifier: params['codeVerifier'],
                redirectUri: params['redirectUri'],
              ),
        ),
      },
    );
    connectors['accessReview'] = _i1.EndpointConnector(
      name: 'accessReview',
      endpoint: endpoints['accessReview']!,
      methodConnectors: {
        'getAccessReviews': _i1.MethodConnector(
          name: 'getAccessReviews',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['accessReview'] as _i5.AccessReviewEndpoint)
                  .getAccessReviews(
                    session,
                    params['windowId'],
                  ),
        ),
        'recertify': _i1.MethodConnector(
          name: 'recertify',
          params: {
            'reviewId': _i1.ParameterDescription(
              name: 'reviewId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'justification': _i1.ParameterDescription(
              name: 'justification',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['accessReview'] as _i5.AccessReviewEndpoint)
                  .recertify(
                    session,
                    reviewId: params['reviewId'],
                    justification: params['justification'],
                  ),
        ),
        'revoke': _i1.MethodConnector(
          name: 'revoke',
          params: {
            'reviewId': _i1.ParameterDescription(
              name: 'reviewId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'justification': _i1.ParameterDescription(
              name: 'justification',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['accessReview'] as _i5.AccessReviewEndpoint)
                  .revoke(
                    session,
                    reviewId: params['reviewId'],
                    justification: params['justification'],
                  ),
        ),
        'signReview': _i1.MethodConnector(
          name: 'signReview',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['accessReview'] as _i5.AccessReviewEndpoint)
                  .signReview(
                    session,
                    windowId: params['windowId'],
                    password: params['password'],
                    reason: params['reason'],
                  ),
        ),
        'exportSignedPdf': _i1.MethodConnector(
          name: 'exportSignedPdf',
          params: {
            'windowId': _i1.ParameterDescription(
              name: 'windowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['accessReview'] as _i5.AccessReviewEndpoint)
                  .exportSignedPdf(
                    session,
                    windowId: params['windowId'],
                  ),
        ),
      },
    );
    connectors['adminUserManagement'] = _i1.EndpointConnector(
      name: 'adminUserManagement',
      endpoint: endpoints['adminUserManagement']!,
      methodConnectors: {
        'listUsers': _i1.MethodConnector(
          name: 'listUsers',
          params: {
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationName': _i1.ParameterDescription(
              name: 'organizationName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'departmentName': _i1.ParameterDescription(
              name: 'departmentName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'perPage': _i1.ParameterDescription(
              name: 'perPage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .listUsers(
                        session,
                        role: params['role'],
                        status: params['status'],
                        organizationName: params['organizationName'],
                        departmentName: params['departmentName'],
                        search: params['search'],
                        page: params['page'],
                        perPage: params['perPage'],
                      ),
        ),
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .getUser(
                        session,
                        userId: params['userId'],
                      ),
        ),
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'employeeId': _i1.ParameterDescription(
              name: 'employeeId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .createUser(
                        session,
                        email: params['email'],
                        firstName: params['firstName'],
                        lastName: params['lastName'],
                        employeeId: params['employeeId'],
                        organizationId: params['organizationId'],
                        departmentId: params['departmentId'],
                        jobRoleId: params['jobRoleId'],
                        siteId: params['siteId'],
                      ),
        ),
        'updateUser': _i1.MethodConnector(
          name: 'updateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .updateUser(
                        session,
                        userId: params['userId'],
                        firstName: params['firstName'],
                        lastName: params['lastName'],
                        organizationId: params['organizationId'],
                        departmentId: params['departmentId'],
                      ),
        ),
        'deactivateUser': _i1.MethodConnector(
          name: 'deactivateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .deactivateUser(
                        session,
                        userId: params['userId'],
                      ),
        ),
        'listPortalRoles': _i1.MethodConnector(
          name: 'listPortalRoles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .listPortalRoles(session),
        ),
        'getUserPortalRoles': _i1.MethodConnector(
          name: 'getUserPortalRoles',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .getUserPortalRoles(
                        session,
                        userId: params['userId'],
                      ),
        ),
        'setUserPortalRole': _i1.MethodConnector(
          name: 'setUserPortalRole',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roleCode': _i1.ParameterDescription(
              name: 'roleCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUserManagement']
                          as _i6.AdminUserManagementEndpoint)
                      .setUserPortalRole(
                        session,
                        userId: params['userId'],
                        roleCode: params['roleCode'],
                        reason: params['reason'],
                      ),
        ),
      },
    );
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'listSignatureMeanings': _i1.MethodConnector(
          name: 'listSignatureMeanings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .listSignatureMeanings(session),
        ),
        'createSignatureMeaning': _i1.MethodConnector(
          name: 'createSignatureMeaning',
          params: {
            'meaning': _i1.ParameterDescription(
              name: 'meaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .createSignatureMeaning(
                    session,
                    meaning: params['meaning'],
                    isActive: params['isActive'],
                    orderIndex: params['orderIndex'],
                  ),
        ),
        'updateSignatureMeaning': _i1.MethodConnector(
          name: 'updateSignatureMeaning',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'meaning': _i1.ParameterDescription(
              name: 'meaning',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .updateSignatureMeaning(
                    session,
                    id: params['id'],
                    meaning: params['meaning'],
                    isActive: params['isActive'],
                    orderIndex: params['orderIndex'],
                  ),
        ),
        'assignTrainingToDepartment': _i1.MethodConnector(
          name: 'assignTrainingToDepartment',
          params: {
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assignedById': _i1.ParameterDescription(
              name: 'assignedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'source': _i1.ParameterDescription(
              name: 'source',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .assignTrainingToDepartment(
                    session,
                    departmentId: params['departmentId'],
                    courseVersionId: params['courseVersionId'],
                    assignedById: params['assignedById'],
                    dueDate: params['dueDate'],
                    reason: params['reason'],
                    source: params['source'],
                  ),
        ),
        'createUserWithRole': _i1.MethodConnector(
          name: 'createUserWithRole',
          params: {
            'employeeId': _i1.ParameterDescription(
              name: 'employeeId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roleCode': _i1.ParameterDescription(
              name: 'roleCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'assignedById': _i1.ParameterDescription(
              name: 'assignedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'managerId': _i1.ParameterDescription(
              name: 'managerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).createUserWithRole(
                    session,
                    employeeId: params['employeeId'],
                    email: params['email'],
                    firstName: params['firstName'],
                    lastName: params['lastName'],
                    departmentId: params['departmentId'],
                    siteId: params['siteId'],
                    organizationId: params['organizationId'],
                    jobRoleId: params['jobRoleId'],
                    roleCode: params['roleCode'],
                    assignedById: params['assignedById'],
                    managerId: params['managerId'],
                    dueDate: params['dueDate'],
                  ),
        ),
        'bulkImportUsers': _i1.MethodConnector(
          name: 'bulkImportUsers',
          params: {
            'csvBase64': _i1.ParameterDescription(
              name: 'csvBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'assignedById': _i1.ParameterDescription(
              name: 'assignedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).bulkImportUsers(
                    session,
                    csvBase64: params['csvBase64'],
                    assignedById: params['assignedById'],
                    dueDate: params['dueDate'],
                  ),
        ),
        'bulkImportTrainingMatrix': _i1.MethodConnector(
          name: 'bulkImportTrainingMatrix',
          params: {
            'csvBase64': _i1.ParameterDescription(
              name: 'csvBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .bulkImportTrainingMatrix(
                    session,
                    csvBase64: params['csvBase64'],
                  ),
        ),
        'updateJobRoleTrainingMatrix': _i1.MethodConnector(
          name: 'updateJobRoleTrainingMatrix',
          params: {
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'trainingMatrixJson': _i1.ParameterDescription(
              name: 'trainingMatrixJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .updateJobRoleTrainingMatrix(
                    session,
                    jobRoleId: params['jobRoleId'],
                    trainingMatrixJson: params['trainingMatrixJson'],
                  ),
        ),
        'getRoleBasedCurriculum': _i1.MethodConnector(
          name: 'getRoleBasedCurriculum',
          params: {
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .getRoleBasedCurriculum(
                    session,
                    params['jobRoleId'],
                  ),
        ),
        'listTrainingMatrixEntries': _i1.MethodConnector(
          name: 'listTrainingMatrixEntries',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .listTrainingMatrixEntries(
                    session,
                    siteId: params['siteId'],
                  ),
        ),
        'upsertTrainingMatrixEntry': _i1.MethodConnector(
          name: 'upsertTrainingMatrixEntry',
          params: {
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isMandatory': _i1.ParameterDescription(
              name: 'isMandatory',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'dueDaysFromHire': _i1.ParameterDescription(
              name: 'dueDaysFromHire',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'retrainingIntervalDays': _i1.ParameterDescription(
              name: 'retrainingIntervalDays',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'createdById': _i1.ParameterDescription(
              name: 'createdById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .upsertTrainingMatrixEntry(
                    session,
                    jobRoleId: params['jobRoleId'],
                    courseId: params['courseId'],
                    isMandatory: params['isMandatory'],
                    dueDaysFromHire: params['dueDaysFromHire'],
                    retrainingIntervalDays: params['retrainingIntervalDays'],
                    siteId: params['siteId'],
                    createdById: params['createdById'],
                  ),
        ),
        'deleteTrainingMatrixEntry': _i1.MethodConnector(
          name: 'deleteTrainingMatrixEntry',
          params: {
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .deleteTrainingMatrixEntry(
                    session,
                    jobRoleId: params['jobRoleId'],
                    courseId: params['courseId'],
                  ),
        ),
        'assignRoleBasedTraining': _i1.MethodConnector(
          name: 'assignRoleBasedTraining',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assignedById': _i1.ParameterDescription(
              name: 'assignedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .assignRoleBasedTraining(
                    session,
                    userId: params['userId'],
                    jobRoleId: params['jobRoleId'],
                    assignedById: params['assignedById'],
                    dueDate: params['dueDate'],
                  ),
        ),
        'lockUserByEmail': _i1.MethodConnector(
          name: 'lockUserByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).lockUserByEmail(
                    session,
                    params['email'],
                  ),
        ),
        'requestTrainingWaiver': _i1.MethodConnector(
          name: 'requestTrainingWaiver',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'requestedById': _i1.ParameterDescription(
              name: 'requestedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'requestReason': _i1.ParameterDescription(
              name: 'requestReason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'evidenceStoragePath': _i1.ParameterDescription(
              name: 'evidenceStoragePath',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .requestTrainingWaiver(
                    session,
                    userId: params['userId'],
                    courseId: params['courseId'],
                    requestedById: params['requestedById'],
                    requestReason: params['requestReason'],
                    evidenceStoragePath: params['evidenceStoragePath'],
                    expiresAt: params['expiresAt'],
                  ),
        ),
        'listTrainingWaivers': _i1.MethodConnector(
          name: 'listTrainingWaivers',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).listTrainingWaivers(
                    session,
                    userId: params['userId'],
                    status: params['status'],
                    courseId: params['courseId'],
                    limit: params['limit'],
                  ),
        ),
        'approveTrainingWaiver': _i1.MethodConnector(
          name: 'approveTrainingWaiver',
          params: {
            'waiverId': _i1.ParameterDescription(
              name: 'waiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'approvedById': _i1.ParameterDescription(
              name: 'approvedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .approveTrainingWaiver(
                    session,
                    waiverId: params['waiverId'],
                    approvedById: params['approvedById'],
                  ),
        ),
        'rejectTrainingWaiver': _i1.MethodConnector(
          name: 'rejectTrainingWaiver',
          params: {
            'waiverId': _i1.ParameterDescription(
              name: 'waiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'approvedById': _i1.ParameterDescription(
              name: 'approvedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rejectionReason': _i1.ParameterDescription(
              name: 'rejectionReason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint)
                  .rejectTrainingWaiver(
                    session,
                    waiverId: params['waiverId'],
                    approvedById: params['approvedById'],
                    rejectionReason: params['rejectionReason'],
                  ),
        ),
        'unlockUserByEmail': _i1.MethodConnector(
          name: 'unlockUserByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).unlockUserByEmail(
                    session,
                    params['email'],
                  ),
        ),
        'listUsers': _i1.MethodConnector(
          name: 'listUsers',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'perPage': _i1.ParameterDescription(
              name: 'perPage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roleCode': _i1.ParameterDescription(
              name: 'roleCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'searchQuery': _i1.ParameterDescription(
              name: 'searchQuery',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint).listUsers(
                session,
                page: params['page'],
                perPage: params['perPage'],
                roleCode: params['roleCode'],
                status: params['status'],
                searchQuery: params['searchQuery'],
              ),
        ),
        'getUserCount': _i1.MethodConnector(
          name: 'getUserCount',
          params: {
            'roleCode': _i1.ParameterDescription(
              name: 'roleCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'searchQuery': _i1.ParameterDescription(
              name: 'searchQuery',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint).getUserCount(
                session,
                roleCode: params['roleCode'],
                status: params['status'],
                searchQuery: params['searchQuery'],
              ),
        ),
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint).getUser(
                session,
                params['userId'],
              ),
        ),
        'updateUser': _i1.MethodConnector(
          name: 'updateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'jobRoleId': _i1.ParameterDescription(
              name: 'jobRoleId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7.AdminEndpoint).updateUser(
                session,
                userId: params['userId'],
                firstName: params['firstName'],
                lastName: params['lastName'],
                departmentId: params['departmentId'],
                jobRoleId: params['jobRoleId'],
              ),
        ),
        'deactivateUser': _i1.MethodConnector(
          name: 'deactivateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'deactivatedById': _i1.ParameterDescription(
              name: 'deactivatedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).deactivateUser(
                    session,
                    userId: params['userId'],
                    deactivatedById: params['deactivatedById'],
                  ),
        ),
        'terminateUser': _i1.MethodConnector(
          name: 'terminateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'terminationDate': _i1.ParameterDescription(
              name: 'terminationDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7.AdminEndpoint).terminateUser(
                    session,
                    userId: params['userId'],
                    terminationDate: params['terminationDate'],
                    reason: params['reason'],
                  ),
        ),
      },
    );
    connectors['analytics'] = _i1.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'getCourseAnalytics': _i1.MethodConnector(
          name: 'getCourseAnalytics',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getCourseAnalytics(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getTrainingCompletionRate': _i1.MethodConnector(
          name: 'getTrainingCompletionRate',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getTrainingCompletionRate(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'getSystemHealth': _i1.MethodConnector(
          name: 'getSystemHealth',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getSystemHealth(session),
        ),
        'triggerManualJob': _i1.MethodConnector(
          name: 'triggerManualJob',
          params: {
            'jobName': _i1.ParameterDescription(
              name: 'jobName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .triggerManualJob(
                    session,
                    jobName: params['jobName'],
                  ),
        ),
        'runCertExpiryCheck': _i1.MethodConnector(
          name: 'runCertExpiryCheck',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .runCertExpiryCheck(session),
        ),
        'runNotificationWorker': _i1.MethodConnector(
          name: 'runNotificationWorker',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .runNotificationWorker(session),
        ),
        'runComplianceCalc': _i1.MethodConnector(
          name: 'runComplianceCalc',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .runComplianceCalc(session),
        ),
        'runAuditTrailIntegrityCheck': _i1.MethodConnector(
          name: 'runAuditTrailIntegrityCheck',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .runAuditTrailIntegrityCheck(session),
        ),
        'getAdminDashboardKpis': _i1.MethodConnector(
          name: 'getAdminDashboardKpis',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getAdminDashboardKpis(session),
        ),
        'getDepartmentComplianceSummary': _i1.MethodConnector(
          name: 'getDepartmentComplianceSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getDepartmentComplianceSummary(session),
        ),
        'getCertificationExpiryRiskCount': _i1.MethodConnector(
          name: 'getCertificationExpiryRiskCount',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getCertificationExpiryRiskCount(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'getAuditReadinessScore': _i1.MethodConnector(
          name: 'getAuditReadinessScore',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getAuditReadinessScore(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'listReportDefinitions': _i1.MethodConnector(
          name: 'listReportDefinitions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .listReportDefinitions(session),
        ),
        'listDashboards': _i1.MethodConnector(
          name: 'listDashboards',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .listDashboards(
                    session,
                    roleId: params['roleId'],
                  ),
        ),
        'getOpenSlaBreaches': _i1.MethodConnector(
          name: 'getOpenSlaBreaches',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getOpenSlaBreaches(session),
        ),
        'getNonCompliantEmployees': _i1.MethodConnector(
          name: 'getNonCompliantEmployees',
          params: {
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getNonCompliantEmployees(
                    session,
                    departmentId: params['departmentId'],
                  ),
        ),
        'getUpcomingExpirationsByDepartment': _i1.MethodConnector(
          name: 'getUpcomingExpirationsByDepartment',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getUpcomingExpirationsByDepartment(session),
        ),
        'getRecentAssignments': _i1.MethodConnector(
          name: 'getRecentAssignments',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getRecentAssignments(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getOpenCapasRequiringTraining': _i1.MethodConnector(
          name: 'getOpenCapasRequiringTraining',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getOpenCapasRequiringTraining(session),
        ),
        'getPendingQaApprovalsCount': _i1.MethodConnector(
          name: 'getPendingQaApprovalsCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getPendingQaApprovalsCount(session),
        ),
        'getSopRetrainingQueue': _i1.MethodConnector(
          name: 'getSopRetrainingQueue',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getSopRetrainingQueue(session),
        ),
        'getDlqFailureCount': _i1.MethodConnector(
          name: 'getDlqFailureCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getDlqFailureCount(session),
        ),
        'getTrainingVsDeviationCorrelation': _i1.MethodConnector(
          name: 'getTrainingVsDeviationCorrelation',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getTrainingVsDeviationCorrelation(session),
        ),
        'getComplianceDeviationOverlay': _i1.MethodConnector(
          name: 'getComplianceDeviationOverlay',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getComplianceDeviationOverlay(session),
        ),
        'getSlaSummary': _i1.MethodConnector(
          name: 'getSlaSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getSlaSummary(session),
        ),
        'getComplianceTrend': _i1.MethodConnector(
          name: 'getComplianceTrend',
          params: {
            'months': _i1.ParameterDescription(
              name: 'months',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getComplianceTrend(
                    session,
                    months: params['months'],
                  ),
        ),
        'getBatchTrainingAnalytics': _i1.MethodConnector(
          name: 'getBatchTrainingAnalytics',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getBatchTrainingAnalytics(
                    session,
                    params['batchId'],
                  ),
        ),
        'getSopRetrainingVelocity': _i1.MethodConnector(
          name: 'getSopRetrainingVelocity',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getSopRetrainingVelocity(session),
        ),
        'getRecentActivity': _i1.MethodConnector(
          name: 'getRecentActivity',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getRecentActivity(
                    session,
                    params['userId'],
                  ),
        ),
        'getOverdueDashboardItems': _i1.MethodConnector(
          name: 'getOverdueDashboardItems',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getOverdueDashboardItems(
                    session,
                    params['userId'],
                  ),
        ),
        'getOpenQualityEventsCount': _i1.MethodConnector(
          name: 'getOpenQualityEventsCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getOpenQualityEventsCount(session),
        ),
        'getSlaBreaches': _i1.MethodConnector(
          name: 'getSlaBreaches',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getSlaBreaches(session),
        ),
        'getMonthlyTrainingHours': _i1.MethodConnector(
          name: 'getMonthlyTrainingHours',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getMonthlyTrainingHours(
                    session,
                    params['userId'],
                  ),
        ),
        'getWeeklyLearningProgress': _i1.MethodConnector(
          name: 'getWeeklyLearningProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getWeeklyLearningProgress(
                    session,
                    params['userId'],
                  ),
        ),
        'getUserAverageQuizScore': _i1.MethodConnector(
          name: 'getUserAverageQuizScore',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getUserAverageQuizScore(
                    session,
                    params['userId'],
                  ),
        ),
        'getUserCompletedAssessmentAttemptCount': _i1.MethodConnector(
          name: 'getUserCompletedAssessmentAttemptCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getUserCompletedAssessmentAttemptCount(
                    session,
                    params['userId'],
                  ),
        ),
        'getUserLearningStreak': _i1.MethodConnector(
          name: 'getUserLearningStreak',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getUserLearningStreak(
                    session,
                    params['userId'],
                  ),
        ),
        'getUpcomingDueDates': _i1.MethodConnector(
          name: 'getUpcomingDueDates',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getUpcomingDueDates(
                    session,
                    params['userId'],
                  ),
        ),
        'getComplianceAlerts': _i1.MethodConnector(
          name: 'getComplianceAlerts',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getComplianceAlerts(
                    session,
                    params['userId'],
                  ),
        ),
        'exportCourseAnalyticsCsv': _i1.MethodConnector(
          name: 'exportCourseAnalyticsCsv',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .exportCourseAnalyticsCsv(
                    session,
                    courseVersionId: params['courseVersionId'],
                  ),
        ),
        'exportCompletionMatrixCsv': _i1.MethodConnector(
          name: 'exportCompletionMatrixCsv',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .exportCompletionMatrixCsv(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'exportLearnerProgressCsv': _i1.MethodConnector(
          name: 'exportLearnerProgressCsv',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .exportLearnerProgressCsv(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'getEmployeeDashboardSummary': _i1.MethodConnector(
          name: 'getEmployeeDashboardSummary',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .getEmployeeDashboardSummary(
                    session,
                    params['userId'],
                  ),
        ),
        'streamAnalytics': _i1.MethodStreamConnector(
          name: 'streamAnalytics',
          params: {
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['analytics'] as _i8.AnalyticsEndpoint)
                  .streamAnalytics(
                    session,
                    params['channel'],
                  ),
        ),
      },
    );
    connectors['assessmentBuilder'] = _i1.EndpointConnector(
      name: 'assessmentBuilder',
      endpoint: endpoints['assessmentBuilder']!,
      methodConnectors: {
        'createQuestion': _i1.MethodConnector(
          name: 'createQuestion',
          params: {
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'questionType': _i1.ParameterDescription(
              name: 'questionType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'optionsJson': _i1.ParameterDescription(
              name: 'optionsJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'correctAnswer': _i1.ParameterDescription(
              name: 'correctAnswer',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'difficulty': _i1.ParameterDescription(
              name: 'difficulty',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'regulatoryTag': _i1.ParameterDescription(
              name: 'regulatoryTag',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .createQuestion(
                        session,
                        questionBankId: params['questionBankId'],
                        text: params['text'],
                        questionType: params['questionType'],
                        optionsJson: params['optionsJson'],
                        correctAnswer: params['correctAnswer'],
                        difficulty: params['difficulty'],
                        regulatoryTag: params['regulatoryTag'],
                      ),
        ),
        'updateQuestion': _i1.MethodConnector(
          name: 'updateQuestion',
          params: {
            'questionId': _i1.ParameterDescription(
              name: 'questionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'questionType': _i1.ParameterDescription(
              name: 'questionType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'optionsJson': _i1.ParameterDescription(
              name: 'optionsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'correctAnswer': _i1.ParameterDescription(
              name: 'correctAnswer',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'difficulty': _i1.ParameterDescription(
              name: 'difficulty',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .updateQuestion(
                        session,
                        questionId: params['questionId'],
                        text: params['text'],
                        questionType: params['questionType'],
                        optionsJson: params['optionsJson'],
                        correctAnswer: params['correctAnswer'],
                        difficulty: params['difficulty'],
                      ),
        ),
        'deleteQuestion': _i1.MethodConnector(
          name: 'deleteQuestion',
          params: {
            'questionId': _i1.ParameterDescription(
              name: 'questionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .deleteQuestion(
                        session,
                        questionId: params['questionId'],
                      ),
        ),
        'createQuestionBank': _i1.MethodConnector(
          name: 'createQuestionBank',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'tagsJson': _i1.ParameterDescription(
              name: 'tagsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .createQuestionBank(
                        session,
                        name: params['name'],
                        organizationId: params['organizationId'],
                        tagsJson: params['tagsJson'],
                      ),
        ),
        'updateQuestionBank': _i1.MethodConnector(
          name: 'updateQuestionBank',
          params: {
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'tagsJson': _i1.ParameterDescription(
              name: 'tagsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .updateQuestionBank(
                        session,
                        questionBankId: params['questionBankId'],
                        name: params['name'],
                        tagsJson: params['tagsJson'],
                      ),
        ),
        'getQuestionBankDetails': _i1.MethodConnector(
          name: 'getQuestionBankDetails',
          params: {
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .getQuestionBankDetails(
                        session,
                        questionBankId: params['questionBankId'],
                      ),
        ),
        'createAssessment': _i1.MethodConnector(
          name: 'createAssessment',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'passingScore': _i1.ParameterDescription(
              name: 'passingScore',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'randomize': _i1.ParameterDescription(
              name: 'randomize',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'timeLimitMinutes': _i1.ParameterDescription(
              name: 'timeLimitMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'maxAttempts': _i1.ParameterDescription(
              name: 'maxAttempts',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'questionsToDisplay': _i1.ParameterDescription(
              name: 'questionsToDisplay',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'showAnswers': _i1.ParameterDescription(
              name: 'showAnswers',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'showSubmissionHistory': _i1.ParameterDescription(
              name: 'showSubmissionHistory',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'limitQuestions': _i1.ParameterDescription(
              name: 'limitQuestions',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .createAssessment(
                        session,
                        courseVersionId: params['courseVersionId'],
                        questionBankId: params['questionBankId'],
                        passingScore: params['passingScore'],
                        randomize: params['randomize'],
                        timeLimitMinutes: params['timeLimitMinutes'],
                        maxAttempts: params['maxAttempts'],
                        questionsToDisplay: params['questionsToDisplay'],
                        showAnswers: params['showAnswers'],
                        showSubmissionHistory: params['showSubmissionHistory'],
                        limitQuestions: params['limitQuestions'],
                      ),
        ),
        'updateAssessment': _i1.MethodConnector(
          name: 'updateAssessment',
          params: {
            'assessmentId': _i1.ParameterDescription(
              name: 'assessmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'passingScore': _i1.ParameterDescription(
              name: 'passingScore',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'randomize': _i1.ParameterDescription(
              name: 'randomize',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'timeLimitMinutes': _i1.ParameterDescription(
              name: 'timeLimitMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'maxAttempts': _i1.ParameterDescription(
              name: 'maxAttempts',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'questionsToDisplay': _i1.ParameterDescription(
              name: 'questionsToDisplay',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'showAnswers': _i1.ParameterDescription(
              name: 'showAnswers',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'showSubmissionHistory': _i1.ParameterDescription(
              name: 'showSubmissionHistory',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'limitQuestions': _i1.ParameterDescription(
              name: 'limitQuestions',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .updateAssessment(
                        session,
                        assessmentId: params['assessmentId'],
                        passingScore: params['passingScore'],
                        randomize: params['randomize'],
                        timeLimitMinutes: params['timeLimitMinutes'],
                        maxAttempts: params['maxAttempts'],
                        questionsToDisplay: params['questionsToDisplay'],
                        showAnswers: params['showAnswers'],
                        showSubmissionHistory: params['showSubmissionHistory'],
                        limitQuestions: params['limitQuestions'],
                      ),
        ),
        'validateAssessmentForSubmission': _i1.MethodConnector(
          name: 'validateAssessmentForSubmission',
          params: {
            'assessmentId': _i1.ParameterDescription(
              name: 'assessmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .validateAssessmentForSubmission(
                        session,
                        assessmentId: params['assessmentId'],
                      ),
        ),
        'listAssessments': _i1.MethodConnector(
          name: 'listAssessments',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .listAssessments(
                        session,
                        organizationId: params['organizationId'],
                        limit: params['limit'],
                      ),
        ),
        'listAssessmentAttempts': _i1.MethodConnector(
          name: 'listAssessmentAttempts',
          params: {
            'assessmentId': _i1.ParameterDescription(
              name: 'assessmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i9.AssessmentBuilderEndpoint)
                      .listAssessmentAttempts(
                        session,
                        assessmentId: params['assessmentId'],
                        limit: params['limit'],
                      ),
        ),
      },
    );
    connectors['assessment'] = _i1.EndpointConnector(
      name: 'assessment',
      endpoint: endpoints['assessment']!,
      methodConnectors: {
        'getAssessmentForCourse': _i1.MethodConnector(
          name: 'getAssessmentForCourse',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .getAssessmentForCourse(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getQuestions': _i1.MethodConnector(
          name: 'getQuestions',
          params: {
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .getQuestions(
                    session,
                    params['questionBankId'],
                  ),
        ),
        'startAttempt': _i1.MethodConnector(
          name: 'startAttempt',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assessmentId': _i1.ParameterDescription(
              name: 'assessmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'skipInterAttemptCooldown': _i1.ParameterDescription(
              name: 'skipInterAttemptCooldown',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .startAttempt(
                    session,
                    userId: params['userId'],
                    assessmentId: params['assessmentId'],
                    enrollmentId: params['enrollmentId'],
                    skipInterAttemptCooldown:
                        params['skipInterAttemptCooldown'],
                  ),
        ),
        'listCompletedAttemptsForUser': _i1.MethodConnector(
          name: 'listCompletedAttemptsForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .listCompletedAttemptsForUser(
                    session,
                    userId: params['userId'],
                  ),
        ),
        'getAttemptCount': _i1.MethodConnector(
          name: 'getAttemptCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assessmentId': _i1.ParameterDescription(
              name: 'assessmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .getAttemptCount(
                    session,
                    userId: params['userId'],
                    assessmentId: params['assessmentId'],
                    enrollmentId: params['enrollmentId'],
                  ),
        ),
        'submitAttempt': _i1.MethodConnector(
          name: 'submitAttempt',
          params: {
            'attemptId': _i1.ParameterDescription(
              name: 'attemptId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .submitAttempt(
                    session,
                    attemptId: params['attemptId'],
                  ),
        ),
        'recordAnswer': _i1.MethodConnector(
          name: 'recordAnswer',
          params: {
            'attemptId': _i1.ParameterDescription(
              name: 'attemptId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questionId': _i1.ParameterDescription(
              name: 'questionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'answer': _i1.ParameterDescription(
              name: 'answer',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .recordAnswer(
                    session,
                    attemptId: params['attemptId'],
                    questionId: params['questionId'],
                    answer: params['answer'],
                  ),
        ),
        'listQuestionBanks': _i1.MethodConnector(
          name: 'listQuestionBanks',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .listQuestionBanks(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'createQuestionBank': _i1.MethodConnector(
          name: 'createQuestionBank',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'tagsJson': _i1.ParameterDescription(
              name: 'tagsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .createQuestionBank(
                    session,
                    name: params['name'],
                    organizationId: params['organizationId'],
                    tagsJson: params['tagsJson'],
                  ),
        ),
        'generateRandomAssessment': _i1.MethodConnector(
          name: 'generateRandomAssessment',
          params: {
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'count': _i1.ParameterDescription(
              name: 'count',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .generateRandomAssessment(
                    session,
                    questionBankId: params['questionBankId'],
                    count: params['count'],
                  ),
        ),
        'importQuestionsToBank': _i1.MethodConnector(
          name: 'importQuestionsToBank',
          params: {
            'targetBankId': _i1.ParameterDescription(
              name: 'targetBankId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questions': _i1.ParameterDescription(
              name: 'questions',
              type: _i1.getType<List<Map<String, dynamic>>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .importQuestionsToBank(
                    session,
                    targetBankId: params['targetBankId'],
                    questions: params['questions'],
                  ),
        ),
        'listUngradedResults': _i1.MethodConnector(
          name: 'listUngradedResults',
          params: {
            'assessmentId': _i1.ParameterDescription(
              name: 'assessmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .listUngradedResults(
                    session,
                    assessmentId: params['assessmentId'],
                  ),
        ),
        'gradeResult': _i1.MethodConnector(
          name: 'gradeResult',
          params: {
            'resultId': _i1.ParameterDescription(
              name: 'resultId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'correct': _i1.ParameterDescription(
              name: 'correct',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'manualScore': _i1.ParameterDescription(
              name: 'manualScore',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .gradeResult(
                    session,
                    resultId: params['resultId'],
                    correct: params['correct'],
                    manualScore: params['manualScore'],
                  ),
        ),
        'listResultsForAttempt': _i1.MethodConnector(
          name: 'listResultsForAttempt',
          params: {
            'attemptId': _i1.ParameterDescription(
              name: 'attemptId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i10.AssessmentEndpoint)
                  .listResultsForAttempt(
                    session,
                    attemptId: params['attemptId'],
                  ),
        ),
      },
    );
    connectors['assignment'] = _i1.EndpointConnector(
      name: 'assignment',
      endpoint: endpoints['assignment']!,
      methodConnectors: {
        'createAssignment': _i1.MethodConnector(
          name: 'createAssignment',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'instructions': _i1.ParameterDescription(
              name: 'instructions',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'allowedFileTypes': _i1.ParameterDescription(
              name: 'allowedFileTypes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .createAssignment(
                    session,
                    lessonId: params['lessonId'],
                    title: params['title'],
                    instructions: params['instructions'],
                    allowedFileTypes: params['allowedFileTypes'],
                  ),
        ),
        'getAssignment': _i1.MethodConnector(
          name: 'getAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .getAssignment(
                    session,
                    params['assignmentId'],
                  ),
        ),
        'listByLesson': _i1.MethodConnector(
          name: 'listByLesson',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .listByLesson(
                    session,
                    lessonId: params['lessonId'],
                  ),
        ),
        'updateAssignment': _i1.MethodConnector(
          name: 'updateAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'instructions': _i1.ParameterDescription(
              name: 'instructions',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'allowedFileTypes': _i1.ParameterDescription(
              name: 'allowedFileTypes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .updateAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                    title: params['title'],
                    instructions: params['instructions'],
                    allowedFileTypes: params['allowedFileTypes'],
                  ),
        ),
        'deleteAssignment': _i1.MethodConnector(
          name: 'deleteAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .deleteAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                  ),
        ),
        'submitAssignment': _i1.MethodConnector(
          name: 'submitAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'submissionUrl': _i1.ParameterDescription(
              name: 'submissionUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'storageKey': _i1.ParameterDescription(
              name: 'storageKey',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .submitAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                    userId: params['userId'],
                    submissionUrl: params['submissionUrl'],
                    storageKey: params['storageKey'],
                    fileName: params['fileName'],
                  ),
        ),
        'listSubmissions': _i1.MethodConnector(
          name: 'listSubmissions',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .listSubmissions(
                    session,
                    assignmentId: params['assignmentId'],
                  ),
        ),
        'gradeSubmission': _i1.MethodConnector(
          name: 'gradeSubmission',
          params: {
            'submissionId': _i1.ParameterDescription(
              name: 'submissionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'grade': _i1.ParameterDescription(
              name: 'grade',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'feedback': _i1.ParameterDescription(
              name: 'feedback',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assignment'] as _i11.AssignmentEndpoint)
                  .gradeSubmission(
                    session,
                    submissionId: params['submissionId'],
                    grade: params['grade'],
                    feedback: params['feedback'],
                  ),
        ),
      },
    );
    connectors['audit'] = _i1.EndpointConnector(
      name: 'audit',
      endpoint: endpoints['audit']!,
      methodConnectors: {
        'logReportExport': _i1.MethodConnector(
          name: 'logReportExport',
          params: {
            'reportType': _i1.ParameterDescription(
              name: 'reportType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'hashSha256': _i1.ParameterDescription(
              name: 'hashSha256',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'exportedById': _i1.ParameterDescription(
              name: 'exportedById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'filterParamsJson': _i1.ParameterDescription(
              name: 'filterParamsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'recordCount': _i1.ParameterDescription(
              name: 'recordCount',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i12.AuditEndpoint).logReportExport(
                    session,
                    reportType: params['reportType'],
                    hashSha256: params['hashSha256'],
                    exportedById: params['exportedById'],
                    filterParamsJson: params['filterParamsJson'],
                    recordCount: params['recordCount'],
                  ),
        ),
        'getMyAuditTrail': _i1.MethodConnector(
          name: 'getMyAuditTrail',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i12.AuditEndpoint).getMyAuditTrail(
                    session,
                    limit: params['limit'],
                    userId: params['userId'],
                  ),
        ),
        'getAuditTrail': _i1.MethodConnector(
          name: 'getAuditTrail',
          params: {
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'entityId': _i1.ParameterDescription(
              name: 'entityId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i12.AuditEndpoint).getAuditTrail(
                    session,
                    entityType: params['entityType'],
                    entityId: params['entityId'],
                    userId: params['userId'],
                    from: params['from'],
                    to: params['to'],
                    limit: params['limit'],
                  ),
        ),
        'getConfigChangeLog': _i1.MethodConnector(
          name: 'getConfigChangeLog',
          params: {
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i12.AuditEndpoint).getConfigChangeLog(
                    session,
                    entityType: params['entityType'],
                    limit: params['limit'],
                    from: params['from'],
                    to: params['to'],
                  ),
        ),
        'getAccessLogs': _i1.MethodConnector(
          name: 'getAccessLogs',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i12.AuditEndpoint).getAccessLogs(
                    session,
                    userId: params['userId'],
                    from: params['from'],
                    to: params['to'],
                    limit: params['limit'],
                  ),
        ),
        'exportAuditCsv': _i1.MethodConnector(
          name: 'exportAuditCsv',
          params: {
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i12.AuditEndpoint).exportAuditCsv(
                    session,
                    entityType: params['entityType'],
                    userId: params['userId'],
                    from: params['from'],
                    to: params['to'],
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['auditFeed'] = _i1.EndpointConnector(
      name: 'auditFeed',
      endpoint: endpoints['auditFeed']!,
      methodConnectors: {
        'getRecentAuditEvents': _i1.MethodConnector(
          name: 'getRecentAuditEvents',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auditFeed'] as _i13.AuditFeedEndpoint)
                  .getRecentAuditEvents(session),
        ),
      },
    );
    connectors['auditTrail'] = _i1.EndpointConnector(
      name: 'auditTrail',
      endpoint: endpoints['auditTrail']!,
      methodConnectors: {
        'logAction': _i1.MethodConnector(
          name: 'logAction',
          params: {
            'action': _i1.ParameterDescription(
              name: 'action',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entityId': _i1.ParameterDescription(
              name: 'entityId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'oldValueJson': _i1.ParameterDescription(
              name: 'oldValueJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'newValueJson': _i1.ParameterDescription(
              name: 'newValueJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ipAddress': _i1.ParameterDescription(
              name: 'ipAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'rowHash': _i1.ParameterDescription(
              name: 'rowHash',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auditTrail'] as _i14.AuditTrailEndpoint)
                  .logAction(
                    session,
                    action: params['action'],
                    entityType: params['entityType'],
                    entityId: params['entityId'],
                    oldValueJson: params['oldValueJson'],
                    newValueJson: params['newValueJson'],
                    reason: params['reason'],
                    ipAddress: params['ipAddress'],
                    rowHash: params['rowHash'],
                  ),
        ),
      },
    );
    connectors['batchAnnouncement'] = _i1.EndpointConnector(
      name: 'batchAnnouncement',
      endpoint: endpoints['batchAnnouncement']!,
      methodConnectors: {
        'listForBatch': _i1.MethodConnector(
          name: 'listForBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['batchAnnouncement']
                          as _i15.BatchAnnouncementEndpoint)
                      .listForBatch(
                        session,
                        params['batchId'],
                      ),
        ),
        'createForBatch': _i1.MethodConnector(
          name: 'createForBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'kind': _i1.ParameterDescription(
              name: 'kind',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'relatedLiveClassId': _i1.ParameterDescription(
              name: 'relatedLiveClassId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['batchAnnouncement']
                          as _i15.BatchAnnouncementEndpoint)
                      .createForBatch(
                        session,
                        batchId: params['batchId'],
                        title: params['title'],
                        body: params['body'],
                        kind: params['kind'],
                        relatedLiveClassId: params['relatedLiveClassId'],
                      ),
        ),
      },
    );
    connectors['certificate'] = _i1.EndpointConnector(
      name: 'certificate',
      endpoint: endpoints['certificate']!,
      methodConnectors: {
        'listCertificates': _i1.MethodConnector(
          name: 'listCertificates',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .listCertificates(
                    session,
                    organizationId: params['organizationId'],
                    status: params['status'],
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                    limit: params['limit'],
                  ),
        ),
        'getCertificate': _i1.MethodConnector(
          name: 'getCertificate',
          params: {
            'certificateId': _i1.ParameterDescription(
              name: 'certificateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .getCertificate(
                    session,
                    params['certificateId'],
                  ),
        ),
        'getUserCertificates': _i1.MethodConnector(
          name: 'getUserCertificates',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .getUserCertificates(
                    session,
                    params['userId'],
                  ),
        ),
        'revokeCertificate': _i1.MethodConnector(
          name: 'revokeCertificate',
          params: {
            'certificateId': _i1.ParameterDescription(
              name: 'certificateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .revokeCertificate(
                    session,
                    params['certificateId'],
                    reason: params['reason'],
                  ),
        ),
        'getCertificateStats': _i1.MethodConnector(
          name: 'getCertificateStats',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .getCertificateStats(
                    session,
                    params['organizationId'],
                  ),
        ),
        'verifyCertificate': _i1.MethodConnector(
          name: 'verifyCertificate',
          params: {
            'qrCode': _i1.ParameterDescription(
              name: 'qrCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .verifyCertificate(
                    session,
                    params['qrCode'],
                  ),
        ),
        'issueCertificate': _i1.MethodConnector(
          name: 'issueCertificate',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .issueCertificate(
                    session,
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                    expiresAt: params['expiresAt'],
                    templateId: params['templateId'],
                  ),
        ),
        'generateBatchCertificates': _i1.MethodConnector(
          name: 'generateBatchCertificates',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .generateBatchCertificates(
                    session,
                    batchId: params['batchId'],
                    templateId: params['templateId'],
                    expiresAt: params['expiresAt'],
                  ),
        ),
        'renderCertificateHtml': _i1.MethodConnector(
          name: 'renderCertificateHtml',
          params: {
            'certificateId': _i1.ParameterDescription(
              name: 'certificateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['certificate'] as _i16.CertificateEndpoint)
                  .renderCertificateHtml(
                    session,
                    certificateId: params['certificateId'],
                    templateId: params['templateId'],
                  ),
        ),
      },
    );
    connectors['certificateTemplate'] = _i1.EndpointConnector(
      name: 'certificateTemplate',
      endpoint: endpoints['certificateTemplate']!,
      methodConnectors: {
        'listTemplates': _i1.MethodConnector(
          name: 'listTemplates',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificateTemplate']
                          as _i17.CertificateTemplateEndpoint)
                      .listTemplates(
                        session,
                        organizationId: params['organizationId'],
                      ),
        ),
        'getTemplate': _i1.MethodConnector(
          name: 'getTemplate',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificateTemplate']
                          as _i17.CertificateTemplateEndpoint)
                      .getTemplate(
                        session,
                        params['id'],
                      ),
        ),
        'createTemplate': _i1.MethodConnector(
          name: 'createTemplate',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'htmlTemplate': _i1.ParameterDescription(
              name: 'htmlTemplate',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isDefault': _i1.ParameterDescription(
              name: 'isDefault',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificateTemplate']
                          as _i17.CertificateTemplateEndpoint)
                      .createTemplate(
                        session,
                        organizationId: params['organizationId'],
                        name: params['name'],
                        htmlTemplate: params['htmlTemplate'],
                        isDefault: params['isDefault'],
                      ),
        ),
        'updateTemplate': _i1.MethodConnector(
          name: 'updateTemplate',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'htmlTemplate': _i1.ParameterDescription(
              name: 'htmlTemplate',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isDefault': _i1.ParameterDescription(
              name: 'isDefault',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificateTemplate']
                          as _i17.CertificateTemplateEndpoint)
                      .updateTemplate(
                        session,
                        templateId: params['templateId'],
                        name: params['name'],
                        htmlTemplate: params['htmlTemplate'],
                        isDefault: params['isDefault'],
                      ),
        ),
        'deleteTemplate': _i1.MethodConnector(
          name: 'deleteTemplate',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificateTemplate']
                          as _i17.CertificateTemplateEndpoint)
                      .deleteTemplate(
                        session,
                        params['templateId'],
                      ),
        ),
        'previewTemplate': _i1.MethodConnector(
          name: 'previewTemplate',
          params: {
            'htmlTemplate': _i1.ParameterDescription(
              name: 'htmlTemplate',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificateTemplate']
                          as _i17.CertificateTemplateEndpoint)
                      .previewTemplate(
                        session,
                        htmlTemplate: params['htmlTemplate'],
                      ),
        ),
      },
    );
    connectors['compliance'] = _i1.EndpointConnector(
      name: 'compliance',
      endpoint: endpoints['compliance']!,
      methodConnectors: {
        'getDepartmentCompliance': _i1.MethodConnector(
          name: 'getDepartmentCompliance',
          params: {
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'asOf': _i1.ParameterDescription(
              name: 'asOf',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['compliance'] as _i18.ComplianceEndpoint)
                  .getDepartmentCompliance(
                    session,
                    params['departmentId'],
                    asOf: params['asOf'],
                  ),
        ),
        'getUserCompliance': _i1.MethodConnector(
          name: 'getUserCompliance',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'asOf': _i1.ParameterDescription(
              name: 'asOf',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['compliance'] as _i18.ComplianceEndpoint)
                  .getUserCompliance(
                    session,
                    params['userId'],
                    asOf: params['asOf'],
                  ),
        ),
        'isDepartmentBelowThreshold': _i1.MethodConnector(
          name: 'isDepartmentBelowThreshold',
          params: {
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'threshold': _i1.ParameterDescription(
              name: 'threshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['compliance'] as _i18.ComplianceEndpoint)
                  .isDepartmentBelowThreshold(
                    session,
                    departmentId: params['departmentId'],
                    threshold: params['threshold'],
                  ),
        ),
        'getEsignatureSummaryForUser': _i1.MethodConnector(
          name: 'getEsignatureSummaryForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['compliance'] as _i18.ComplianceEndpoint)
                  .getEsignatureSummaryForUser(
                    session,
                    params['userId'],
                  ),
        ),
      },
    );
    connectors['courseBuilder'] = _i1.EndpointConnector(
      name: 'courseBuilder',
      endpoint: endpoints['courseBuilder']!,
      methodConnectors: {
        'createModule': _i1.MethodConnector(
          name: 'createModule',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .createModule(
                        session,
                        courseVersionId: params['courseVersionId'],
                        title: params['title'],
                        orderIndex: params['orderIndex'],
                      ),
        ),
        'updateModule': _i1.MethodConnector(
          name: 'updateModule',
          params: {
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .updateModule(
                        session,
                        moduleId: params['moduleId'],
                        title: params['title'],
                        orderIndex: params['orderIndex'],
                      ),
        ),
        'createLesson': _i1.MethodConnector(
          name: 'createLesson',
          params: {
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'lessonType': _i1.ParameterDescription(
              name: 'lessonType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'minEngagementMinutes': _i1.ParameterDescription(
              name: 'minEngagementMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'prerequisiteMode': _i1.ParameterDescription(
              name: 'prerequisiteMode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .createLesson(
                        session,
                        moduleId: params['moduleId'],
                        title: params['title'],
                        materialId: params['materialId'],
                        orderIndex: params['orderIndex'],
                        durationMinutes: params['durationMinutes'],
                        lessonType: params['lessonType'],
                        minEngagementMinutes: params['minEngagementMinutes'],
                        prerequisiteMode: params['prerequisiteMode'],
                      ),
        ),
        'updateLesson': _i1.MethodConnector(
          name: 'updateLesson',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'lessonType': _i1.ParameterDescription(
              name: 'lessonType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'minEngagementMinutes': _i1.ParameterDescription(
              name: 'minEngagementMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'prerequisiteMode': _i1.ParameterDescription(
              name: 'prerequisiteMode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .updateLesson(
                        session,
                        lessonId: params['lessonId'],
                        title: params['title'],
                        materialId: params['materialId'],
                        orderIndex: params['orderIndex'],
                        durationMinutes: params['durationMinutes'],
                        lessonType: params['lessonType'],
                        minEngagementMinutes: params['minEngagementMinutes'],
                        prerequisiteMode: params['prerequisiteMode'],
                      ),
        ),
        'createCourseVersion': _i1.MethodConnector(
          name: 'createCourseVersion',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'changeSummary': _i1.ParameterDescription(
              name: 'changeSummary',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .createCourseVersion(
                        session,
                        courseId: params['courseId'],
                        version: params['version'],
                        status: params['status'],
                        changeSummary: params['changeSummary'],
                      ),
        ),
        'createNewVersionFromExisting': _i1.MethodConnector(
          name: 'createNewVersionFromExisting',
          params: {
            'existingVersionId': _i1.ParameterDescription(
              name: 'existingVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'changeSummary': _i1.ParameterDescription(
              name: 'changeSummary',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isMajorVersion': _i1.ParameterDescription(
              name: 'isMajorVersion',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'createdById': _i1.ParameterDescription(
              name: 'createdById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .createNewVersionFromExisting(
                        session,
                        existingVersionId: params['existingVersionId'],
                        changeSummary: params['changeSummary'],
                        isMajorVersion: params['isMajorVersion'],
                        createdById: params['createdById'],
                      ),
        ),
        'updateCourseVersionStatus': _i1.MethodConnector(
          name: 'updateCourseVersionStatus',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'approverId': _i1.ParameterDescription(
              name: 'approverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .updateCourseVersionStatus(
                        session,
                        courseVersionId: params['courseVersionId'],
                        status: params['status'],
                        approverId: params['approverId'],
                      ),
        ),
        'validateForQaSubmission': _i1.MethodConnector(
          name: 'validateForQaSubmission',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .validateForQaSubmission(
                        session,
                        courseVersionId: params['courseVersionId'],
                      ),
        ),
        'submitForQaReview': _i1.MethodConnector(
          name: 'submitForQaReview',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'submittedById': _i1.ParameterDescription(
              name: 'submittedById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .submitForQaReview(
                        session,
                        courseVersionId: params['courseVersionId'],
                        submittedById: params['submittedById'],
                      ),
        ),
        'deleteModule': _i1.MethodConnector(
          name: 'deleteModule',
          params: {
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .deleteModule(
                        session,
                        moduleId: params['moduleId'],
                      ),
        ),
        'deleteLesson': _i1.MethodConnector(
          name: 'deleteLesson',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .deleteLesson(
                        session,
                        lessonId: params['lessonId'],
                      ),
        ),
        'updateLessonMaterial': _i1.MethodConnector(
          name: 'updateLessonMaterial',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .updateLessonMaterial(
                        session,
                        lessonId: params['lessonId'],
                        materialId: params['materialId'],
                      ),
        ),
        'saveDraft': _i1.MethodConnector(
          name: 'saveDraft',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'modules': _i1.ParameterDescription(
              name: 'modules',
              type: _i1.getType<List<Map<String, dynamic>>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i19.CourseBuilderEndpoint)
                      .saveDraft(
                        session,
                        courseVersionId: params['courseVersionId'],
                        modules: params['modules'],
                      ),
        ),
      },
    );
    connectors['course'] = _i1.EndpointConnector(
      name: 'course',
      endpoint: endpoints['course']!,
      methodConnectors: {
        'listCourses': _i1.MethodConnector(
          name: 'listCourses',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i20.CourseEndpoint).listCourses(
                    session,
                    organizationId: params['organizationId'],
                    status: params['status'],
                    search: params['search'],
                  ),
        ),
        'listTrainerPublishedCoursesForAssignment': _i1.MethodConnector(
          name: 'listTrainerPublishedCoursesForAssignment',
          params: {
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint)
                  .listTrainerPublishedCoursesForAssignment(
                    session,
                    search: params['search'],
                  ),
        ),
        'getCourse': _i1.MethodConnector(
          name: 'getCourse',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint).getCourse(
                session,
                params['id'],
              ),
        ),
        'getCourseVersions': _i1.MethodConnector(
          name: 'getCourseVersions',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint)
                  .getCourseVersions(
                    session,
                    params['courseId'],
                  ),
        ),
        'getCourseVersion': _i1.MethodConnector(
          name: 'getCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i20.CourseEndpoint).getCourseVersion(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'createCourse': _i1.MethodConnector(
          name: 'createCourse',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'sopNumber': _i1.ParameterDescription(
              name: 'sopNumber',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'createdById': _i1.ParameterDescription(
              name: 'createdById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i20.CourseEndpoint).createCourse(
                    session,
                    title: params['title'],
                    organizationId: params['organizationId'],
                    sopNumber: params['sopNumber'],
                    description: params['description'],
                    createdById: params['createdById'],
                  ),
        ),
        'createCourseWithVersion': _i1.MethodConnector(
          name: 'createCourseWithVersion',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'sopNumber': _i1.ParameterDescription(
              name: 'sopNumber',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'createdById': _i1.ParameterDescription(
              name: 'createdById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'previewVideoUrl': _i1.ParameterDescription(
              name: 'previewVideoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint)
                  .createCourseWithVersion(
                    session,
                    title: params['title'],
                    organizationId: params['organizationId'],
                    sopNumber: params['sopNumber'],
                    description: params['description'],
                    createdById: params['createdById'],
                    previewVideoUrl: params['previewVideoUrl'],
                    imageUrl: params['imageUrl'],
                    tags: params['tags'],
                  ),
        ),
        'getModulesForCourseVersion': _i1.MethodConnector(
          name: 'getModulesForCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint)
                  .getModulesForCourseVersion(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getLessonsForModule': _i1.MethodConnector(
          name: 'getLessonsForModule',
          params: {
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint)
                  .getLessonsForModule(
                    session,
                    params['moduleId'],
                  ),
        ),
        'getLessonWithMaterial': _i1.MethodConnector(
          name: 'getLessonWithMaterial',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i20.CourseEndpoint)
                  .getLessonWithMaterial(
                    session,
                    params['lessonId'],
                  ),
        ),
        'searchCourses': _i1.MethodConnector(
          name: 'searchCourses',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i20.CourseEndpoint).searchCourses(
                    session,
                    query: params['query'],
                    organizationId: params['organizationId'],
                  ),
        ),
        'updateCourse': _i1.MethodConnector(
          name: 'updateCourse',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'sopNumber': _i1.ParameterDescription(
              name: 'sopNumber',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'previewVideoUrl': _i1.ParameterDescription(
              name: 'previewVideoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'disableSelfEnrollment': _i1.ParameterDescription(
              name: 'disableSelfEnrollment',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'featured': _i1.ParameterDescription(
              name: 'featured',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i20.CourseEndpoint).updateCourse(
                    session,
                    courseId: params['courseId'],
                    title: params['title'],
                    description: params['description'],
                    sopNumber: params['sopNumber'],
                    previewVideoUrl: params['previewVideoUrl'],
                    imageUrl: params['imageUrl'],
                    tags: params['tags'],
                    category: params['category'],
                    disableSelfEnrollment: params['disableSelfEnrollment'],
                    featured: params['featured'],
                  ),
        ),
        'deleteCourse': _i1.MethodConnector(
          name: 'deleteCourse',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i20.CourseEndpoint).deleteCourse(
                    session,
                    courseId: params['courseId'],
                  ),
        ),
      },
    );
    connectors['document'] = _i1.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'listDocuments': _i1.MethodConnector(
          name: 'listDocuments',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'documentType': _i1.ParameterDescription(
              name: 'documentType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .listDocuments(
                    session,
                    organizationId: params['organizationId'],
                    documentType: params['documentType'],
                  ),
        ),
        'getDocument': _i1.MethodConnector(
          name: 'getDocument',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _i21.DocumentEndpoint).getDocument(
                    session,
                    params['id'],
                  ),
        ),
        'updateDocumentQaClassification': _i1.MethodConnector(
          name: 'updateDocumentQaClassification',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'trainingRequiredByQa': _i1.ParameterDescription(
              name: 'trainingRequiredByQa',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'affectedDepartmentIdsJson': _i1.ParameterDescription(
              name: 'affectedDepartmentIdsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'affectedRoleIdsJson': _i1.ParameterDescription(
              name: 'affectedRoleIdsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .updateDocumentQaClassification(
                    session,
                    documentId: params['documentId'],
                    trainingRequiredByQa: params['trainingRequiredByQa'],
                    affectedDepartmentIdsJson:
                        params['affectedDepartmentIdsJson'],
                    affectedRoleIdsJson: params['affectedRoleIdsJson'],
                  ),
        ),
        'getDocumentVersions': _i1.MethodConnector(
          name: 'getDocumentVersions',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .getDocumentVersions(
                    session,
                    params['documentId'],
                  ),
        ),
        'createDocument': _i1.MethodConnector(
          name: 'createDocument',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'documentNumber': _i1.ParameterDescription(
              name: 'documentNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'documentType': _i1.ParameterDescription(
              name: 'documentType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .createDocument(
                    session,
                    title: params['title'],
                    documentNumber: params['documentNumber'],
                    documentType: params['documentType'],
                    organizationId: params['organizationId'],
                  ),
        ),
        'createDocumentVersion': _i1.MethodConnector(
          name: 'createDocumentVersion',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'storageKey': _i1.ParameterDescription(
              name: 'storageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'effectiveDate': _i1.ParameterDescription(
              name: 'effectiveDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'obsoleteDate': _i1.ParameterDescription(
              name: 'obsoleteDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'versionMajor': _i1.ParameterDescription(
              name: 'versionMajor',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'versionMinor': _i1.ParameterDescription(
              name: 'versionMinor',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isMajorVersion': _i1.ParameterDescription(
              name: 'isMajorVersion',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .createDocumentVersion(
                    session,
                    documentId: params['documentId'],
                    version: params['version'],
                    storageKey: params['storageKey'],
                    effectiveDate: params['effectiveDate'],
                    obsoleteDate: params['obsoleteDate'],
                    versionMajor: params['versionMajor'],
                    versionMinor: params['versionMinor'],
                    isMajorVersion: params['isMajorVersion'],
                  ),
        ),
        'getDocumentLifecycle': _i1.MethodConnector(
          name: 'getDocumentLifecycle',
          params: {
            'documentVersionId': _i1.ParameterDescription(
              name: 'documentVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .getDocumentLifecycle(
                    session,
                    params['documentVersionId'],
                  ),
        ),
        'transitionDocumentLifecycle': _i1.MethodConnector(
          name: 'transitionDocumentLifecycle',
          params: {
            'documentVersionId': _i1.ParameterDescription(
              name: 'documentVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newState': _i1.ParameterDescription(
              name: 'newState',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'obsoleteReason': _i1.ParameterDescription(
              name: 'obsoleteReason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ipAddress': _i1.ParameterDescription(
              name: 'ipAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .transitionDocumentLifecycle(
                    session,
                    documentVersionId: params['documentVersionId'],
                    newState: params['newState'],
                    obsoleteReason: params['obsoleteReason'],
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordPlaintext: params['passwordPlaintext'],
                    ipAddress: params['ipAddress'],
                  ),
        ),
        'createApprovalStep': _i1.MethodConnector(
          name: 'createApprovalStep',
          params: {
            'documentVersionId': _i1.ParameterDescription(
              name: 'documentVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'step': _i1.ParameterDescription(
              name: 'step',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'approverId': _i1.ParameterDescription(
              name: 'approverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'esignatureId': _i1.ParameterDescription(
              name: 'esignatureId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i21.DocumentEndpoint)
                  .createApprovalStep(
                    session,
                    documentVersionId: params['documentVersionId'],
                    step: params['step'],
                    approverId: params['approverId'],
                    status: params['status'],
                    esignatureId: params['esignatureId'],
                  ),
        ),
      },
    );
    connectors['event'] = _i1.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'triggerSopUpdated': _i1.MethodConnector(
          name: 'triggerSopUpdated',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _i22.EventEndpoint).triggerSopUpdated(
                    session,
                    documentId: params['documentId'],
                    courseVersionId: params['courseVersionId'],
                    reason: params['reason'],
                  ),
        ),
        'triggerEmployeeCreated': _i1.MethodConnector(
          name: 'triggerEmployeeCreated',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i22.EventEndpoint)
                  .triggerEmployeeCreated(
                    session,
                    userId: params['userId'],
                    departmentId: params['departmentId'],
                    roleId: params['roleId'],
                  ),
        ),
        'triggerEmployeeTransferred': _i1.MethodConnector(
          name: 'triggerEmployeeTransferred',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'oldDepartmentId': _i1.ParameterDescription(
              name: 'oldDepartmentId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newDepartmentId': _i1.ParameterDescription(
              name: 'newDepartmentId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'oldRoleId': _i1.ParameterDescription(
              name: 'oldRoleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newRoleId': _i1.ParameterDescription(
              name: 'newRoleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i22.EventEndpoint)
                  .triggerEmployeeTransferred(
                    session,
                    userId: params['userId'],
                    oldDepartmentId: params['oldDepartmentId'],
                    newDepartmentId: params['newDepartmentId'],
                    oldRoleId: params['oldRoleId'],
                    newRoleId: params['newRoleId'],
                  ),
        ),
        'triggerCapaTrainingComplete': _i1.MethodConnector(
          name: 'triggerCapaTrainingComplete',
          params: {
            'capaId': _i1.ParameterDescription(
              name: 'capaId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i22.EventEndpoint)
                  .triggerCapaTrainingComplete(
                    session,
                    capaId: params['capaId'],
                  ),
        ),
        'triggerComplianceDropAlert': _i1.MethodConnector(
          name: 'triggerComplianceDropAlert',
          params: {
            'threshold': _i1.ParameterDescription(
              name: 'threshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i22.EventEndpoint)
                  .triggerComplianceDropAlert(
                    session,
                    threshold: params['threshold'],
                  ),
        ),
        'triggerNewCourseRelease': _i1.MethodConnector(
          name: 'triggerNewCourseRelease',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i22.EventEndpoint)
                  .triggerNewCourseRelease(
                    session,
                    courseVersionId: params['courseVersionId'],
                  ),
        ),
      },
    );
    connectors['inspection'] = _i1.EndpointConnector(
      name: 'inspection',
      endpoint: endpoints['inspection']!,
      methodConnectors: {
        'listInspectionRecords': _i1.MethodConnector(
          name: 'listInspectionRecords',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .listInspectionRecords(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'createInspectionRecord': _i1.MethodConnector(
          name: 'createInspectionRecord',
          params: {
            'inspectionType': _i1.ParameterDescription(
              name: 'inspectionType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scopeDescription': _i1.ParameterDescription(
              name: 'scopeDescription',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'scheduledDate': _i1.ParameterDescription(
              name: 'scheduledDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'inspectorNames': _i1.ParameterDescription(
              name: 'inspectorNames',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'tokenHoursValid': _i1.ParameterDescription(
              name: 'tokenHoursValid',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'createdById': _i1.ParameterDescription(
              name: 'createdById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .createInspectionRecord(
                    session,
                    inspectionType: params['inspectionType'],
                    siteId: params['siteId'],
                    scopeDescription: params['scopeDescription'],
                    scheduledDate: params['scheduledDate'],
                    inspectorNames: params['inspectorNames'],
                    tokenHoursValid: params['tokenHoursValid'],
                    createdById: params['createdById'],
                  ),
        ),
        'validateAuditorToken': _i1.MethodConnector(
          name: 'validateAuditorToken',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .validateAuditorToken(
                    session,
                    token: params['token'],
                  ),
        ),
        'listAuditorPageLogs': _i1.MethodConnector(
          name: 'listAuditorPageLogs',
          params: {
            'inspectionRecordId': _i1.ParameterDescription(
              name: 'inspectionRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .listAuditorPageLogs(
                    session,
                    inspectionRecordId: params['inspectionRecordId'],
                    limit: params['limit'],
                  ),
        ),
        'logAuditorPageView': _i1.MethodConnector(
          name: 'logAuditorPageView',
          params: {
            'inspectionRecordId': _i1.ParameterDescription(
              name: 'inspectionRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageUrl': _i1.ParameterDescription(
              name: 'pageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pageTitle': _i1.ParameterDescription(
              name: 'pageTitle',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'entityId': _i1.ParameterDescription(
              name: 'entityId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'timeOnPageSeconds': _i1.ParameterDescription(
              name: 'timeOnPageSeconds',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .logAuditorPageView(
                    session,
                    inspectionRecordId: params['inspectionRecordId'],
                    pageUrl: params['pageUrl'],
                    pageTitle: params['pageTitle'],
                    entityType: params['entityType'],
                    entityId: params['entityId'],
                    timeOnPageSeconds: params['timeOnPageSeconds'],
                  ),
        ),
        'listInspectionPackages': _i1.MethodConnector(
          name: 'listInspectionPackages',
          params: {
            'inspectionRecordId': _i1.ParameterDescription(
              name: 'inspectionRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .listInspectionPackages(
                    session,
                    inspectionRecordId: params['inspectionRecordId'],
                    limit: params['limit'],
                  ),
        ),
        'generateEvidencePackageForAuditor': _i1.MethodConnector(
          name: 'generateEvidencePackageForAuditor',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .generateEvidencePackageForAuditor(
                    session,
                    token: params['token'],
                  ),
        ),
        'generateInspectionPackage': _i1.MethodConnector(
          name: 'generateInspectionPackage',
          params: {
            'inspectionRecordId': _i1.ParameterDescription(
              name: 'inspectionRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'generatedById': _i1.ParameterDescription(
              name: 'generatedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .generateInspectionPackage(
                    session,
                    inspectionRecordId: params['inspectionRecordId'],
                    generatedById: params['generatedById'],
                  ),
        ),
        'signInspectionPackageAsOfficial': _i1.MethodConnector(
          name: 'signInspectionPackageAsOfficial',
          params: {
            'packageId': _i1.ParameterDescription(
              name: 'packageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ipAddress': _i1.ParameterDescription(
              name: 'ipAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .signInspectionPackageAsOfficial(
                    session,
                    packageId: params['packageId'],
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordPlaintext: params['passwordPlaintext'],
                    ipAddress: params['ipAddress'],
                  ),
        ),
        'searchEmployeesForAudit': _i1.MethodConnector(
          name: 'searchEmployeesForAudit',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'inspectionRecordId': _i1.ParameterDescription(
              name: 'inspectionRecordId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .searchEmployeesForAudit(
                    session,
                    query: params['query'],
                    inspectionRecordId: params['inspectionRecordId'],
                    limit: params['limit'],
                  ),
        ),
        'getSopTrainingCoverage': _i1.MethodConnector(
          name: 'getSopTrainingCoverage',
          params: {
            'sopDocumentId': _i1.ParameterDescription(
              name: 'sopDocumentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'versionId': _i1.ParameterDescription(
              name: 'versionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inspection'] as _i23.InspectionEndpoint)
                  .getSopTrainingCoverage(
                    session,
                    sopDocumentId: params['sopDocumentId'],
                    versionId: params['versionId'],
                  ),
        ),
      },
    );
    connectors['learnerSupport'] = _i1.EndpointConnector(
      name: 'learnerSupport',
      endpoint: endpoints['learnerSupport']!,
      methodConnectors: {
        'listThread': _i1.MethodConnector(
          name: 'listThread',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['learnerSupport'] as _i24.LearnerSupportEndpoint)
                      .listThread(
                        session,
                        params['courseVersionId'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentMessageId': _i1.ParameterDescription(
              name: 'parentMessageId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'toUserId': _i1.ParameterDescription(
              name: 'toUserId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['learnerSupport'] as _i24.LearnerSupportEndpoint)
                      .sendMessage(
                        session,
                        courseVersionId: params['courseVersionId'],
                        body: params['body'],
                        parentMessageId: params['parentMessageId'],
                        toUserId: params['toUserId'],
                      ),
        ),
        'listTrainerSupportThreads': _i1.MethodConnector(
          name: 'listTrainerSupportThreads',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['learnerSupport'] as _i24.LearnerSupportEndpoint)
                      .listTrainerSupportThreads(session),
        ),
        'markThreadMessagesRead': _i1.MethodConnector(
          name: 'markThreadMessagesRead',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['learnerSupport'] as _i24.LearnerSupportEndpoint)
                      .markThreadMessagesRead(
                        session,
                        params['courseVersionId'],
                      ),
        ),
      },
    );
    connectors['lessonBlock'] = _i1.EndpointConnector(
      name: 'lessonBlock',
      endpoint: endpoints['lessonBlock']!,
      methodConnectors: {
        'listBlocks': _i1.MethodConnector(
          name: 'listBlocks',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lessonBlock'] as _i25.LessonBlockEndpoint)
                  .listBlocks(
                    session,
                    lessonId: params['lessonId'],
                  ),
        ),
        'createBlock': _i1.MethodConnector(
          name: 'createBlock',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'blockType': _i1.ParameterDescription(
              name: 'blockType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'contentJson': _i1.ParameterDescription(
              name: 'contentJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lessonBlock'] as _i25.LessonBlockEndpoint)
                  .createBlock(
                    session,
                    lessonId: params['lessonId'],
                    blockType: params['blockType'],
                    contentJson: params['contentJson'],
                    orderIndex: params['orderIndex'],
                  ),
        ),
        'updateBlock': _i1.MethodConnector(
          name: 'updateBlock',
          params: {
            'blockId': _i1.ParameterDescription(
              name: 'blockId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'contentJson': _i1.ParameterDescription(
              name: 'contentJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lessonBlock'] as _i25.LessonBlockEndpoint)
                  .updateBlock(
                    session,
                    blockId: params['blockId'],
                    contentJson: params['contentJson'],
                    orderIndex: params['orderIndex'],
                  ),
        ),
        'deleteBlock': _i1.MethodConnector(
          name: 'deleteBlock',
          params: {
            'blockId': _i1.ParameterDescription(
              name: 'blockId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lessonBlock'] as _i25.LessonBlockEndpoint)
                  .deleteBlock(
                    session,
                    blockId: params['blockId'],
                  ),
        ),
        'reorderBlocks': _i1.MethodConnector(
          name: 'reorderBlocks',
          params: {
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'blockIds': _i1.ParameterDescription(
              name: 'blockIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lessonBlock'] as _i25.LessonBlockEndpoint)
                  .reorderBlocks(
                    session,
                    lessonId: params['lessonId'],
                    blockIds: params['blockIds'],
                  ),
        ),
      },
    );
    connectors['liveClass'] = _i1.EndpointConnector(
      name: 'liveClass',
      endpoint: endpoints['liveClass']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'meetingUrl': _i1.ParameterDescription(
              name: 'meetingUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'autoRecording': _i1.ParameterDescription(
              name: 'autoRecording',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['liveClass'] as _i26.LiveClassEndpoint).create(
                    session,
                    batchId: params['batchId'],
                    title: params['title'],
                    description: params['description'],
                    scheduledAt: params['scheduledAt'],
                    durationMinutes: params['durationMinutes'],
                    meetingUrl: params['meetingUrl'],
                    autoRecording: params['autoRecording'],
                  ),
        ),
        'listByBatch': _i1.MethodConnector(
          name: 'listByBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['liveClass'] as _i26.LiveClassEndpoint)
                  .listByBatch(
                    session,
                    params['batchId'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'liveClassId': _i1.ParameterDescription(
              name: 'liveClassId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'meetingUrl': _i1.ParameterDescription(
              name: 'meetingUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'autoRecording': _i1.ParameterDescription(
              name: 'autoRecording',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['liveClass'] as _i26.LiveClassEndpoint).update(
                    session,
                    liveClassId: params['liveClassId'],
                    title: params['title'],
                    description: params['description'],
                    scheduledAt: params['scheduledAt'],
                    durationMinutes: params['durationMinutes'],
                    meetingUrl: params['meetingUrl'],
                    autoRecording: params['autoRecording'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'liveClassId': _i1.ParameterDescription(
              name: 'liveClassId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['liveClass'] as _i26.LiveClassEndpoint).delete(
                    session,
                    params['liveClassId'],
                  ),
        ),
      },
    );
    connectors['material'] = _i1.EndpointConnector(
      name: 'material',
      endpoint: endpoints['material']!,
      methodConnectors: {
        'getMaterial': _i1.MethodConnector(
          name: 'getMaterial',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['material'] as _i27.MaterialEndpoint).getMaterial(
                    session,
                    params['id'],
                  ),
        ),
        'getMaterialViewUrl': _i1.MethodConnector(
          name: 'getMaterialViewUrl',
          params: {
            'storageKey': _i1.ParameterDescription(
              name: 'storageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .getMaterialViewUrl(
                    session,
                    params['storageKey'],
                  ),
        ),
        'createMaterial': _i1.MethodConnector(
          name: 'createMaterial',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'materialType': _i1.ParameterDescription(
              name: 'materialType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'contentUrl': _i1.ParameterDescription(
              name: 'contentUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .createMaterial(
                    session,
                    title: params['title'],
                    materialType: params['materialType'],
                    organizationId: params['organizationId'],
                    contentUrl: params['contentUrl'],
                  ),
        ),
        'getMaterialContentUrl': _i1.MethodConnector(
          name: 'getMaterialContentUrl',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .getMaterialContentUrl(
                    session,
                    params['materialId'],
                  ),
        ),
        'getUploadDescription': _i1.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .getUploadDescription(
                    session,
                    params['path'],
                  ),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['material'] as _i27.MaterialEndpoint).verifyUpload(
                    session,
                    params['path'],
                  ),
        ),
        'createMaterialVersion': _i1.MethodConnector(
          name: 'createMaterialVersion',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storageKey': _i1.ParameterDescription(
              name: 'storageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileHash': _i1.ParameterDescription(
              name: 'fileHash',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileSizeBytes': _i1.ParameterDescription(
              name: 'fileSizeBytes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'changeSummary': _i1.ParameterDescription(
              name: 'changeSummary',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .createMaterialVersion(
                    session,
                    materialId: params['materialId'],
                    storageKey: params['storageKey'],
                    fileHash: params['fileHash'],
                    fileSizeBytes: params['fileSizeBytes'],
                    changeSummary: params['changeSummary'],
                  ),
        ),
        'updateMaterial': _i1.MethodConnector(
          name: 'updateMaterial',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'materialType': _i1.ParameterDescription(
              name: 'materialType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .updateMaterial(
                    session,
                    materialId: params['materialId'],
                    title: params['title'],
                    materialType: params['materialType'],
                  ),
        ),
        'getLatestMaterialVersion': _i1.MethodConnector(
          name: 'getLatestMaterialVersion',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .getLatestMaterialVersion(
                    session,
                    params['materialId'],
                  ),
        ),
        'updateVirusScanStatus': _i1.MethodConnector(
          name: 'updateVirusScanStatus',
          params: {
            'materialVersionId': _i1.ParameterDescription(
              name: 'materialVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'virusScanStatus': _i1.ParameterDescription(
              name: 'virusScanStatus',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .updateVirusScanStatus(
                    session,
                    materialVersionId: params['materialVersionId'],
                    virusScanStatus: params['virusScanStatus'],
                  ),
        ),
        'getMaterialVersions': _i1.MethodConnector(
          name: 'getMaterialVersions',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .getMaterialVersions(
                    session,
                    params['materialId'],
                  ),
        ),
        'listMaterials': _i1.MethodConnector(
          name: 'listMaterials',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .listMaterials(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'updateProgress': _i1.MethodConnector(
          name: 'updateProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'progressPct': _i1.ParameterDescription(
              name: 'progressPct',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'completedAt': _i1.ParameterDescription(
              name: 'completedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'interactionJson': _i1.ParameterDescription(
              name: 'interactionJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'timeSpentSeconds': _i1.ParameterDescription(
              name: 'timeSpentSeconds',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'readTimeMet': _i1.ParameterDescription(
              name: 'readTimeMet',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'materialVersionId': _i1.ParameterDescription(
              name: 'materialVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .updateProgress(
                    session,
                    userId: params['userId'],
                    materialId: params['materialId'],
                    progressPct: params['progressPct'],
                    completedAt: params['completedAt'],
                    interactionJson: params['interactionJson'],
                    timeSpentSeconds: params['timeSpentSeconds'],
                    readTimeMet: params['readTimeMet'],
                    materialVersionId: params['materialVersionId'],
                    enrollmentId: params['enrollmentId'],
                    lessonId: params['lessonId'],
                  ),
        ),
        'getProgress': _i1.MethodConnector(
          name: 'getProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['material'] as _i27.MaterialEndpoint).getProgress(
                    session,
                    userId: params['userId'],
                    materialId: params['materialId'],
                    enrollmentId: params['enrollmentId'],
                  ),
        ),
        'recordEngagement': _i1.MethodConnector(
          name: 'recordEngagement',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'lessonId': _i1.ParameterDescription(
              name: 'lessonId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'tabFocused': _i1.ParameterDescription(
              name: 'tabFocused',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'scrollDepthPct': _i1.ParameterDescription(
              name: 'scrollDepthPct',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'videoWatchedPct': _i1.ParameterDescription(
              name: 'videoWatchedPct',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'videoPositionSeconds': _i1.ParameterDescription(
              name: 'videoPositionSeconds',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'deltaSeconds': _i1.ParameterDescription(
              name: 'deltaSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .recordEngagement(
                    session,
                    userId: params['userId'],
                    materialId: params['materialId'],
                    lessonId: params['lessonId'],
                    enrollmentId: params['enrollmentId'],
                    tabFocused: params['tabFocused'],
                    scrollDepthPct: params['scrollDepthPct'],
                    videoWatchedPct: params['videoWatchedPct'],
                    videoPositionSeconds: params['videoPositionSeconds'],
                    deltaSeconds: params['deltaSeconds'],
                  ),
        ),
        'deleteMaterial': _i1.MethodConnector(
          name: 'deleteMaterial',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .deleteMaterial(
                    session,
                    materialId: params['materialId'],
                  ),
        ),
        'getMaterialWithVersions': _i1.MethodConnector(
          name: 'getMaterialWithVersions',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i27.MaterialEndpoint)
                  .getMaterialWithVersions(
                    session,
                    materialId: params['materialId'],
                  ),
        ),
      },
    );
    connectors['messaging'] = _i1.EndpointConnector(
      name: 'messaging',
      endpoint: endpoints['messaging']!,
      methodConnectors: {
        'getUnreadCounts': _i1.MethodConnector(
          name: 'getUnreadCounts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getUnreadCounts(session),
        ),
        'getThreadMessages': _i1.MethodConnector(
          name: 'getThreadMessages',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getThreadMessages(
                    session,
                    courseVersionId: params['courseVersionId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getTrainerInbox': _i1.MethodConnector(
          name: 'getTrainerInbox',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getTrainerInbox(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getLearnerInbox': _i1.MethodConnector(
          name: 'getLearnerInbox',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getLearnerInbox(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getQaInbox': _i1.MethodConnector(
          name: 'getQaInbox',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['messaging'] as _i28.MessagingEndpoint).getQaInbox(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getQaReviewerInbox': _i1.MethodConnector(
          name: 'getQaReviewerInbox',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getQaReviewerInbox(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getQaThreadComments': _i1.MethodConnector(
          name: 'getQaThreadComments',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getQaThreadComments(
                    session,
                    courseVersionId: params['courseVersionId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'markQaThreadRead': _i1.MethodConnector(
          name: 'markQaThreadRead',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .markQaThreadRead(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'markLearnerThreadRead': _i1.MethodConnector(
          name: 'markLearnerThreadRead',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .markLearnerThreadRead(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getUnreadNotificationCount': _i1.MethodConnector(
          name: 'getUnreadNotificationCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getUnreadNotificationCount(session),
        ),
        'getNotifications': _i1.MethodConnector(
          name: 'getNotifications',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .getNotifications(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'markAllNotificationsRead': _i1.MethodConnector(
          name: 'markAllNotificationsRead',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['messaging'] as _i28.MessagingEndpoint)
                  .markAllNotificationsRead(session),
        ),
      },
    );
    connectors['mfa'] = _i1.EndpointConnector(
      name: 'mfa',
      endpoint: endpoints['mfa']!,
      methodConnectors: {
        'getMfaStatus': _i1.MethodConnector(
          name: 'getMfaStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i29.MfaEndpoint).getMfaStatus(session),
        ),
        'enrollMfa': _i1.MethodConnector(
          name: 'enrollMfa',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i29.MfaEndpoint).enrollMfa(session),
        ),
        'verifyMfaEnrollment': _i1.MethodConnector(
          name: 'verifyMfaEnrollment',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i29.MfaEndpoint).verifyMfaEnrollment(
                    session,
                    params['code'],
                  ),
        ),
        'verifyMfa': _i1.MethodConnector(
          name: 'verifyMfa',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mfa'] as _i29.MfaEndpoint).verifyMfa(
                session,
                params['code'],
              ),
        ),
        'disableMfa': _i1.MethodConnector(
          name: 'disableMfa',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i29.MfaEndpoint).disableMfa(session),
        ),
        'isMfaVerified': _i1.MethodConnector(
          name: 'isMfaVerified',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i29.MfaEndpoint).isMfaVerified(session),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'getUserNotifications': _i1.MethodConnector(
          name: 'getUserNotifications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .getUserNotifications(
                        session,
                        params['userId'],
                      ),
        ),
        'getInAppNotifications': _i1.MethodConnector(
          name: 'getInAppNotifications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .getInAppNotifications(
                        session,
                        params['userId'],
                      ),
        ),
        'getTrainerNotifications': _i1.MethodConnector(
          name: 'getTrainerNotifications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .getTrainerNotifications(
                        session,
                        params['userId'],
                      ),
        ),
        'markNotificationRead': _i1.MethodConnector(
          name: 'markNotificationRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .markNotificationRead(
                        session,
                        notificationId: params['notificationId'],
                      ),
        ),
        'getUnreadCount': _i1.MethodConnector(
          name: 'getUnreadCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .getUnreadCount(
                        session,
                        params['userId'],
                      ),
        ),
        'listNotifications': _i1.MethodConnector(
          name: 'listNotifications',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'deliveryStatus': _i1.ParameterDescription(
              name: 'deliveryStatus',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .listNotifications(
                        session,
                        organizationId: params['organizationId'],
                        type: params['type'],
                        channel: params['channel'],
                        deliveryStatus: params['deliveryStatus'],
                        limit: params['limit'],
                      ),
        ),
        'broadcastInAppToOrganization': _i1.MethodConnector(
          name: 'broadcastInAppToOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i30.NotificationEndpoint)
                      .broadcastInAppToOrganization(
                        session,
                        organizationId: params['organizationId'],
                        message: params['message'],
                        type: params['type'],
                      ),
        ),
      },
    );
    connectors['notificationTemplate'] = _i1.EndpointConnector(
      name: 'notificationTemplate',
      endpoint: endpoints['notificationTemplate']!,
      methodConnectors: {
        'listTemplates': _i1.MethodConnector(
          name: 'listTemplates',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .listTemplates(
                        session,
                        organizationId: params['organizationId'],
                        status: params['status'],
                        type: params['type'],
                        channel: params['channel'],
                        limit: params['limit'],
                      ),
        ),
        'getTemplate': _i1.MethodConnector(
          name: 'getTemplate',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .getTemplate(
                        session,
                        params['templateId'],
                      ),
        ),
        'createTemplate': _i1.MethodConnector(
          name: 'createTemplate',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'triggerEvent': _i1.ParameterDescription(
              name: 'triggerEvent',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'subject': _i1.ParameterDescription(
              name: 'subject',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'bodyTemplate': _i1.ParameterDescription(
              name: 'bodyTemplate',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .createTemplate(
                        session,
                        organizationId: params['organizationId'],
                        name: params['name'],
                        type: params['type'],
                        channel: params['channel'],
                        triggerEvent: params['triggerEvent'],
                        subject: params['subject'],
                        bodyTemplate: params['bodyTemplate'],
                        status: params['status'],
                      ),
        ),
        'updateTemplate': _i1.MethodConnector(
          name: 'updateTemplate',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'triggerEvent': _i1.ParameterDescription(
              name: 'triggerEvent',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'subject': _i1.ParameterDescription(
              name: 'subject',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'bodyTemplate': _i1.ParameterDescription(
              name: 'bodyTemplate',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .updateTemplate(
                        session,
                        params['templateId'],
                        name: params['name'],
                        type: params['type'],
                        channel: params['channel'],
                        triggerEvent: params['triggerEvent'],
                        subject: params['subject'],
                        bodyTemplate: params['bodyTemplate'],
                        status: params['status'],
                      ),
        ),
        'deleteTemplate': _i1.MethodConnector(
          name: 'deleteTemplate',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .deleteTemplate(
                        session,
                        params['templateId'],
                      ),
        ),
        'getTemplateStats': _i1.MethodConnector(
          name: 'getTemplateStats',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .getTemplateStats(
                        session,
                        params['organizationId'],
                      ),
        ),
        'duplicateTemplate': _i1.MethodConnector(
          name: 'duplicateTemplate',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newName': _i1.ParameterDescription(
              name: 'newName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationTemplate']
                          as _i31.NotificationTemplateEndpoint)
                      .duplicateTemplate(
                        session,
                        params['templateId'],
                        newName: params['newName'],
                      ),
        ),
      },
    );
    connectors['oq'] = _i1.EndpointConnector(
      name: 'oq',
      endpoint: endpoints['oq']!,
      methodConnectors: {
        'createChecklistItem': _i1.MethodConnector(
          name: 'createChecklistItem',
          params: {
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isCritical': _i1.ParameterDescription(
              name: 'isCritical',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['oq'] as _i32.OqEndpoint).createChecklistItem(
                    session,
                    competencyId: params['competencyId'],
                    title: params['title'],
                    description: params['description'],
                    orderIndex: params['orderIndex'],
                    isCritical: params['isCritical'],
                    organizationId: params['organizationId'],
                  ),
        ),
        'listChecklistItems': _i1.MethodConnector(
          name: 'listChecklistItems',
          params: {
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['oq'] as _i32.OqEndpoint).listChecklistItems(
                    session,
                    competencyId: params['competencyId'],
                    organizationId: params['organizationId'],
                  ),
        ),
        'updateChecklistItem': _i1.MethodConnector(
          name: 'updateChecklistItem',
          params: {
            'itemId': _i1.ParameterDescription(
              name: 'itemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'orderIndex': _i1.ParameterDescription(
              name: 'orderIndex',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isCritical': _i1.ParameterDescription(
              name: 'isCritical',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['oq'] as _i32.OqEndpoint).updateChecklistItem(
                    session,
                    itemId: params['itemId'],
                    title: params['title'],
                    description: params['description'],
                    orderIndex: params['orderIndex'],
                    isCritical: params['isCritical'],
                  ),
        ),
        'deleteChecklistItem': _i1.MethodConnector(
          name: 'deleteChecklistItem',
          params: {
            'itemId': _i1.ParameterDescription(
              name: 'itemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['oq'] as _i32.OqEndpoint).deleteChecklistItem(
                    session,
                    params['itemId'],
                  ),
        ),
        'recordObservation': _i1.MethodConnector(
          name: 'recordObservation',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'checklistItemId': _i1.ParameterDescription(
              name: 'checklistItemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'result': _i1.ParameterDescription(
              name: 'result',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'evaluatorSignatureMeaning': _i1.ParameterDescription(
              name: 'evaluatorSignatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'evaluatorPasswordPlaintext': _i1.ParameterDescription(
              name: 'evaluatorPasswordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint).recordObservation(
                session,
                userId: params['userId'],
                competencyId: params['competencyId'],
                checklistItemId: params['checklistItemId'],
                result: params['result'],
                notes: params['notes'],
                evaluatorSignatureMeaning: params['evaluatorSignatureMeaning'],
                evaluatorPasswordPlaintext:
                    params['evaluatorPasswordPlaintext'],
                organizationId: params['organizationId'],
              ),
        ),
        'traineeCountersignObservation': _i1.MethodConnector(
          name: 'traineeCountersignObservation',
          params: {
            'observationLogId': _i1.ParameterDescription(
              name: 'observationLogId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint)
                  .traineeCountersignObservation(
                    session,
                    observationLogId: params['observationLogId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordPlaintext: params['passwordPlaintext'],
                  ),
        ),
        'listObservationsForUser': _i1.MethodConnector(
          name: 'listObservationsForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['oq'] as _i32.OqEndpoint).listObservationsForUser(
                    session,
                    userId: params['userId'],
                    competencyId: params['competencyId'],
                  ),
        ),
        'getOqProgress': _i1.MethodConnector(
          name: 'getOqProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint).getOqProgress(
                session,
                userId: params['userId'],
                competencyId: params['competencyId'],
                organizationId: params['organizationId'],
              ),
        ),
        'qaVerifyAndAwardCompetency': _i1.MethodConnector(
          name: 'qaVerifyAndAwardCompetency',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'qaSignatureMeaning': _i1.ParameterDescription(
              name: 'qaSignatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'qaPasswordPlaintext': _i1.ParameterDescription(
              name: 'qaPasswordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint)
                  .qaVerifyAndAwardCompetency(
                    session,
                    userId: params['userId'],
                    competencyId: params['competencyId'],
                    organizationId: params['organizationId'],
                    qaSignatureMeaning: params['qaSignatureMeaning'],
                    qaPasswordPlaintext: params['qaPasswordPlaintext'],
                    expiresAt: params['expiresAt'],
                  ),
        ),
        'listUserCompetencies': _i1.MethodConnector(
          name: 'listUserCompetencies',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['oq'] as _i32.OqEndpoint).listUserCompetencies(
                    session,
                    userId: params['userId'],
                    activeOnly: params['activeOnly'],
                  ),
        ),
        'isUserQualified': _i1.MethodConnector(
          name: 'isUserQualified',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'competencyId': _i1.ParameterDescription(
              name: 'competencyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint).isUserQualified(
                session,
                userId: params['userId'],
                competencyId: params['competencyId'],
              ),
        ),
        'createCompetency': _i1.MethodConnector(
          name: 'createCompetency',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'level': _i1.ParameterDescription(
              name: 'level',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint).createCompetency(
                session,
                name: params['name'],
                code: params['code'],
                level: params['level'],
              ),
        ),
        'listCompetencies': _i1.MethodConnector(
          name: 'listCompetencies',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['oq'] as _i32.OqEndpoint).listCompetencies(
                session,
              ),
        ),
      },
    );
    connectors['organization'] = _i1.EndpointConnector(
      name: 'organization',
      endpoint: endpoints['organization']!,
      methodConnectors: {
        'listOrganizations': _i1.MethodConnector(
          name: 'listOrganizations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .listOrganizations(session),
        ),
        'getOrganization': _i1.MethodConnector(
          name: 'getOrganization',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .getOrganization(
                        session,
                        params['id'],
                      ),
        ),
        'createOrganization': _i1.MethodConnector(
          name: 'createOrganization',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .createOrganization(
                        session,
                        name: params['name'],
                        code: params['code'],
                      ),
        ),
        'listSites': _i1.MethodConnector(
          name: 'listSites',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .listSites(
                        session,
                        params['organizationId'],
                      ),
        ),
        'listDepartments': _i1.MethodConnector(
          name: 'listDepartments',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .listDepartments(
                        session,
                        params['siteId'],
                      ),
        ),
        'listJobRoles': _i1.MethodConnector(
          name: 'listJobRoles',
          params: {
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .listJobRoles(
                        session,
                        params['departmentId'],
                      ),
        ),
        'listUsers': _i1.MethodConnector(
          name: 'listUsers',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'departmentId': _i1.ParameterDescription(
              name: 'departmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .listUsers(
                        session,
                        organizationId: params['organizationId'],
                        departmentId: params['departmentId'],
                      ),
        ),
        'updateOrganization': _i1.MethodConnector(
          name: 'updateOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .updateOrganization(
                        session,
                        organizationId: params['organizationId'],
                        name: params['name'],
                        code: params['code'],
                      ),
        ),
        'listOrganizationSettings': _i1.MethodConnector(
          name: 'listOrganizationSettings',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .listOrganizationSettings(
                        session,
                        params['organizationId'],
                      ),
        ),
        'upsertOrganizationSetting': _i1.MethodConnector(
          name: 'upsertOrganizationSetting',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i33.OrganizationEndpoint)
                      .upsertOrganizationSetting(
                        session,
                        organizationId: params['organizationId'],
                        key: params['key'],
                        value: params['value'],
                      ),
        ),
      },
    );
    connectors['qa'] = _i1.EndpointConnector(
      name: 'qa',
      endpoint: endpoints['qa']!,
      methodConnectors: {
        'listPendingCourseVersions': _i1.MethodConnector(
          name: 'listPendingCourseVersions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['qa'] as _i34.QaEndpoint)
                  .listPendingCourseVersions(session),
        ),
        'approveCourseVersion': _i1.MethodConnector(
          name: 'approveCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'approverId': _i1.ParameterDescription(
              name: 'approverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reviewChecklistJson': _i1.ParameterDescription(
              name: 'reviewChecklistJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qa'] as _i34.QaEndpoint).approveCourseVersion(
                    session,
                    courseVersionId: params['courseVersionId'],
                    passwordPlaintext: params['passwordPlaintext'],
                    signatureMeaning: params['signatureMeaning'],
                    approverId: params['approverId'],
                    reviewChecklistJson: params['reviewChecklistJson'],
                  ),
        ),
        'rejectCourseVersion': _i1.MethodConnector(
          name: 'rejectCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'returnForChanges': _i1.ParameterDescription(
              name: 'returnForChanges',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qa'] as _i34.QaEndpoint).rejectCourseVersion(
                    session,
                    courseVersionId: params['courseVersionId'],
                    reason: params['reason'],
                    returnForChanges: params['returnForChanges'],
                  ),
        ),
        'getPendingDocumentApprovalsCount': _i1.MethodConnector(
          name: 'getPendingDocumentApprovalsCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['qa'] as _i34.QaEndpoint)
                  .getPendingDocumentApprovalsCount(session),
        ),
        'returnCourseForChanges': _i1.MethodConnector(
          name: 'returnCourseForChanges',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comments': _i1.ParameterDescription(
              name: 'comments',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reviewerId': _i1.ParameterDescription(
              name: 'reviewerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qa'] as _i34.QaEndpoint).returnCourseForChanges(
                    session,
                    courseVersionId: params['courseVersionId'],
                    comments: params['comments'],
                    reviewerId: params['reviewerId'],
                  ),
        ),
        'getCourseReviews': _i1.MethodConnector(
          name: 'getCourseReviews',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['qa'] as _i34.QaEndpoint).getCourseReviews(
                session,
                courseVersionId: params['courseVersionId'],
              ),
        ),
        'getCourseReviewsForTrainer': _i1.MethodConnector(
          name: 'getCourseReviewsForTrainer',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['qa'] as _i34.QaEndpoint)
                  .getCourseReviewsForTrainer(
                    session,
                    courseVersionId: params['courseVersionId'],
                  ),
        ),
      },
    );
    connectors['qualityEvent'] = _i1.EndpointConnector(
      name: 'qualityEvent',
      endpoint: endpoints['qualityEvent']!,
      methodConnectors: {
        'listQualityEvents': _i1.MethodConnector(
          name: 'listQualityEvents',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .listQualityEvents(
                        session,
                        siteId: params['siteId'],
                        eventType: params['eventType'],
                        status: params['status'],
                      ),
        ),
        'getQualityEvent': _i1.MethodConnector(
          name: 'getQualityEvent',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .getQualityEvent(
                        session,
                        params['id'],
                      ),
        ),
        'listCapas': _i1.MethodConnector(
          name: 'listCapas',
          params: {
            'qualityEventId': _i1.ParameterDescription(
              name: 'qualityEventId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .listCapas(
                        session,
                        qualityEventId: params['qualityEventId'],
                        status: params['status'],
                      ),
        ),
        'createQualityEvent': _i1.MethodConnector(
          name: 'createQualityEvent',
          params: {
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'referenceId': _i1.ParameterDescription(
              name: 'referenceId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .createQualityEvent(
                        session,
                        eventType: params['eventType'],
                        title: params['title'],
                        status: params['status'],
                        referenceId: params['referenceId'],
                        siteId: params['siteId'],
                      ),
        ),
        'updateCapaStatus': _i1.MethodConnector(
          name: 'updateCapaStatus',
          params: {
            'capaId': _i1.ParameterDescription(
              name: 'capaId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'rootCause': _i1.ParameterDescription(
              name: 'rootCause',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'rcaCompletedAt': _i1.ParameterDescription(
              name: 'rcaCompletedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .updateCapaStatus(
                        session,
                        capaId: params['capaId'],
                        status: params['status'],
                        rootCause: params['rootCause'],
                        rcaCompletedAt: params['rcaCompletedAt'],
                      ),
        ),
        'closeCapa': _i1.MethodConnector(
          name: 'closeCapa',
          params: {
            'capaId': _i1.ParameterDescription(
              name: 'capaId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'closedById': _i1.ParameterDescription(
              name: 'closedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .closeCapa(
                        session,
                        capaId: params['capaId'],
                        closedById: params['closedById'],
                      ),
        ),
        'closeCapaWithSignature': _i1.MethodConnector(
          name: 'closeCapaWithSignature',
          params: {
            'capaId': _i1.ParameterDescription(
              name: 'capaId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .closeCapaWithSignature(
                        session,
                        capaId: params['capaId'],
                        passwordPlaintext: params['passwordPlaintext'],
                      ),
        ),
        'createCapa': _i1.MethodConnector(
          name: 'createCapa',
          params: {
            'qualityEventId': _i1.ParameterDescription(
              name: 'qualityEventId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'rootCause': _i1.ParameterDescription(
              name: 'rootCause',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'trainingRequired': _i1.ParameterDescription(
              name: 'trainingRequired',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .createCapa(
                        session,
                        qualityEventId: params['qualityEventId'],
                        description: params['description'],
                        rootCause: params['rootCause'],
                        trainingRequired: params['trainingRequired'],
                      ),
        ),
        'assignTrainingFromCapa': _i1.MethodConnector(
          name: 'assignTrainingFromCapa',
          params: {
            'capaId': _i1.ParameterDescription(
              name: 'capaId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assignedById': _i1.ParameterDescription(
              name: 'assignedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .assignTrainingFromCapa(
                        session,
                        capaId: params['capaId'],
                        userId: params['userId'],
                        courseVersionId: params['courseVersionId'],
                        assignedById: params['assignedById'],
                        dueDate: params['dueDate'],
                      ),
        ),
        'listInspectionReports': _i1.MethodConnector(
          name: 'listInspectionReports',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .listInspectionReports(
                        session,
                        organizationId: params['organizationId'],
                        siteId: params['siteId'],
                      ),
        ),
        'createInspectionReport': _i1.MethodConnector(
          name: 'createInspectionReport',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'inspector': _i1.ParameterDescription(
              name: 'inspector',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'inspectionDate': _i1.ParameterDescription(
              name: 'inspectionDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'findingsJson': _i1.ParameterDescription(
              name: 'findingsJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qualityEvent'] as _i35.QualityEventEndpoint)
                      .createInspectionReport(
                        session,
                        organizationId: params['organizationId'],
                        status: params['status'],
                        siteId: params['siteId'],
                        inspector: params['inspector'],
                        inspectionDate: params['inspectionDate'],
                        findingsJson: params['findingsJson'],
                      ),
        ),
      },
    );
    connectors['realtime'] = _i1.EndpointConnector(
      name: 'realtime',
      endpoint: endpoints['realtime']!,
      methodConnectors: {
        'getConnectionToken': _i1.MethodConnector(
          name: 'getConnectionToken',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['realtime'] as _i36.RealtimeEndpoint)
                  .getConnectionToken(session),
        ),
      },
    );
    connectors['seed'] = _i1.EndpointConnector(
      name: 'seed',
      endpoint: endpoints['seed']!,
      methodConnectors: {
        'runSeed': _i1.MethodConnector(
          name: 'runSeed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['seed'] as _i37.SeedEndpoint).runSeed(session),
        ),
        'runMvpSeed': _i1.MethodConnector(
          name: 'runMvpSeed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['seed'] as _i37.SeedEndpoint).runMvpSeed(session),
        ),
        'clearAndReseed': _i1.MethodConnector(
          name: 'clearAndReseed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i37.SeedEndpoint)
                  .clearAndReseed(session),
        ),
        'runComprehensiveSeed': _i1.MethodConnector(
          name: 'runComprehensiveSeed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i37.SeedEndpoint)
                  .runComprehensiveSeed(session),
        ),
        'provisionAuthAccounts': _i1.MethodConnector(
          name: 'provisionAuthAccounts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i37.SeedEndpoint)
                  .provisionAuthAccounts(session),
        ),
        'fixAdminPasswords': _i1.MethodConnector(
          name: 'fixAdminPasswords',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i37.SeedEndpoint)
                  .fixAdminPasswords(session),
        ),
      },
    );
    connectors['sme'] = _i1.EndpointConnector(
      name: 'sme',
      endpoint: endpoints['sme']!,
      methodConnectors: {
        'listAssignmentsForCourse': _i1.MethodConnector(
          name: 'listAssignmentsForCourse',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sme'] as _i38.SmeEndpoint)
                  .listAssignmentsForCourse(
                    session,
                    params['courseId'],
                  ),
        ),
        'inviteSme': _i1.MethodConnector(
          name: 'inviteSme',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'smeUserId': _i1.ParameterDescription(
              name: 'smeUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sme'] as _i38.SmeEndpoint).inviteSme(
                session,
                courseId: params['courseId'],
                smeUserId: params['smeUserId'],
                courseVersionId: params['courseVersionId'],
              ),
        ),
        'listCommentsForCourseVersion': _i1.MethodConnector(
          name: 'listCommentsForCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sme'] as _i38.SmeEndpoint)
                  .listCommentsForCourseVersion(
                    session,
                    params['courseVersionId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'addComment': _i1.MethodConnector(
          name: 'addComment',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'sectionRef': _i1.ParameterDescription(
              name: 'sectionRef',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'severity': _i1.ParameterDescription(
              name: 'severity',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentCommentId': _i1.ParameterDescription(
              name: 'parentCommentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sme'] as _i38.SmeEndpoint).addComment(
                session,
                courseVersionId: params['courseVersionId'],
                sectionRef: params['sectionRef'],
                body: params['body'],
                severity: params['severity'],
                parentCommentId: params['parentCommentId'],
              ),
        ),
        'resolveComment': _i1.MethodConnector(
          name: 'resolveComment',
          params: {
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'trainerResponse': _i1.ParameterDescription(
              name: 'trainerResponse',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sme'] as _i38.SmeEndpoint).resolveComment(
                session,
                commentId: params['commentId'],
                trainerResponse: params['trainerResponse'],
              ),
        ),
        'markCommentsRead': _i1.MethodConnector(
          name: 'markCommentsRead',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['sme'] as _i38.SmeEndpoint).markCommentsRead(
                    session,
                    params['courseVersionId'],
                  ),
        ),
      },
    );
    connectors['sopLinkage'] = _i1.EndpointConnector(
      name: 'sopLinkage',
      endpoint: endpoints['sopLinkage']!,
      methodConnectors: {
        'linkSopToCourse': _i1.MethodConnector(
          name: 'linkSopToCourse',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'linkedById': _i1.ParameterDescription(
              name: 'linkedById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sopLinkage'] as _i39.SopLinkageEndpoint)
                  .linkSopToCourse(
                    session,
                    courseId: params['courseId'],
                    documentId: params['documentId'],
                    linkedById: params['linkedById'],
                  ),
        ),
        'unlinkSopFromCourse': _i1.MethodConnector(
          name: 'unlinkSopFromCourse',
          params: {
            'linkId': _i1.ParameterDescription(
              name: 'linkId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'unlinkedById': _i1.ParameterDescription(
              name: 'unlinkedById',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sopLinkage'] as _i39.SopLinkageEndpoint)
                  .unlinkSopFromCourse(
                    session,
                    linkId: params['linkId'],
                    unlinkedById: params['unlinkedById'],
                  ),
        ),
        'getLinkedSops': _i1.MethodConnector(
          name: 'getLinkedSops',
          params: {
            'courseId': _i1.ParameterDescription(
              name: 'courseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sopLinkage'] as _i39.SopLinkageEndpoint)
                  .getLinkedSops(
                    session,
                    courseId: params['courseId'],
                  ),
        ),
        'getCoursesForSop': _i1.MethodConnector(
          name: 'getCoursesForSop',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sopLinkage'] as _i39.SopLinkageEndpoint)
                  .getCoursesForSop(
                    session,
                    documentId: params['documentId'],
                  ),
        ),
      },
    );
    connectors['standaloneAssignment'] = _i1.EndpointConnector(
      name: 'standaloneAssignment',
      endpoint: endpoints['standaloneAssignment']!,
      methodConnectors: {
        'createStandaloneAssignment': _i1.MethodConnector(
          name: 'createStandaloneAssignment',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'instructions': _i1.ParameterDescription(
              name: 'instructions',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dueAt': _i1.ParameterDescription(
              name: 'dueAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'contentKind': _i1.ParameterDescription(
              name: 'contentKind',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'targetType': _i1.ParameterDescription(
              name: 'targetType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetDepartmentId': _i1.ParameterDescription(
              name: 'targetDepartmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'targetBatchId': _i1.ParameterDescription(
              name: 'targetBatchId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'assignedByType': _i1.ParameterDescription(
              name: 'assignedByType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .createStandaloneAssignment(
                        session,
                        organizationId: params['organizationId'],
                        title: params['title'],
                        instructions: params['instructions'],
                        dueAt: params['dueAt'],
                        contentKind: params['contentKind'],
                        questionBankId: params['questionBankId'],
                        courseVersionId: params['courseVersionId'],
                        targetType: params['targetType'],
                        targetDepartmentId: params['targetDepartmentId'],
                        targetBatchId: params['targetBatchId'],
                        assignedByType: params['assignedByType'],
                      ),
        ),
        'updateStandaloneAssignment': _i1.MethodConnector(
          name: 'updateStandaloneAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'instructions': _i1.ParameterDescription(
              name: 'instructions',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dueAt': _i1.ParameterDescription(
              name: 'dueAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'contentKind': _i1.ParameterDescription(
              name: 'contentKind',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'questionBankId': _i1.ParameterDescription(
              name: 'questionBankId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'targetType': _i1.ParameterDescription(
              name: 'targetType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'targetDepartmentId': _i1.ParameterDescription(
              name: 'targetDepartmentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'targetBatchId': _i1.ParameterDescription(
              name: 'targetBatchId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .updateStandaloneAssignment(
                        session,
                        params['assignmentId'],
                        title: params['title'],
                        instructions: params['instructions'],
                        dueAt: params['dueAt'],
                        contentKind: params['contentKind'],
                        questionBankId: params['questionBankId'],
                        courseVersionId: params['courseVersionId'],
                        targetType: params['targetType'],
                        targetDepartmentId: params['targetDepartmentId'],
                        targetBatchId: params['targetBatchId'],
                      ),
        ),
        'publishStandaloneAssignment': _i1.MethodConnector(
          name: 'publishStandaloneAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'individualUserIds': _i1.ParameterDescription(
              name: 'individualUserIds',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .publishStandaloneAssignment(
                        session,
                        params['assignmentId'],
                        individualUserIds: params['individualUserIds'],
                      ),
        ),
        'listStandaloneAssignmentsForOrganization': _i1.MethodConnector(
          name: 'listStandaloneAssignmentsForOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .listStandaloneAssignmentsForOrganization(
                        session,
                        params['organizationId'],
                        status: params['status'],
                        limit: params['limit'],
                      ),
        ),
        'getStandaloneAssignment': _i1.MethodConnector(
          name: 'getStandaloneAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .getStandaloneAssignment(
                        session,
                        params['assignmentId'],
                      ),
        ),
        'listMyStandaloneAssignmentRecipients': _i1.MethodConnector(
          name: 'listMyStandaloneAssignmentRecipients',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .listMyStandaloneAssignmentRecipients(session),
        ),
        'getStandaloneAssignmentRecipient': _i1.MethodConnector(
          name: 'getStandaloneAssignmentRecipient',
          params: {
            'recipientId': _i1.ParameterDescription(
              name: 'recipientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .getStandaloneAssignmentRecipient(
                        session,
                        params['recipientId'],
                      ),
        ),
        'submitStandaloneAssignment': _i1.MethodConnector(
          name: 'submitStandaloneAssignment',
          params: {
            'recipientId': _i1.ParameterDescription(
              name: 'recipientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'responseJson': _i1.ParameterDescription(
              name: 'responseJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .submitStandaloneAssignment(
                        session,
                        params['recipientId'],
                        responseJson: params['responseJson'],
                      ),
        ),
        'gradeStandaloneSubmission': _i1.MethodConnector(
          name: 'gradeStandaloneSubmission',
          params: {
            'recipientId': _i1.ParameterDescription(
              name: 'recipientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'grade': _i1.ParameterDescription(
              name: 'grade',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'feedback': _i1.ParameterDescription(
              name: 'feedback',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .gradeStandaloneSubmission(
                        session,
                        recipientId: params['recipientId'],
                        grade: params['grade'],
                        feedback: params['feedback'],
                      ),
        ),
        'listSubmittedForGrading': _i1.MethodConnector(
          name: 'listSubmittedForGrading',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standaloneAssignment']
                          as _i40.StandaloneAssignmentEndpoint)
                      .listSubmittedForGrading(
                        session,
                        assignmentId: params['assignmentId'],
                      ),
        ),
      },
    );
    connectors['trainingBatch'] = _i1.EndpointConnector(
      name: 'trainingBatch',
      endpoint: endpoints['trainingBatch']!,
      methodConnectors: {
        'listBatches': _i1.MethodConnector(
          name: 'listBatches',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .listBatches(
                        session,
                        organizationId: params['organizationId'],
                        status: params['status'],
                        courseVersionId: params['courseVersionId'],
                        limit: params['limit'],
                      ),
        ),
        'getBatch': _i1.MethodConnector(
          name: 'getBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .getBatch(
                        session,
                        params['batchId'],
                      ),
        ),
        'createBatch': _i1.MethodConnector(
          name: 'createBatch',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'instructorId': _i1.ParameterDescription(
              name: 'instructorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'capacity': _i1.ParameterDescription(
              name: 'capacity',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'startTime': _i1.ParameterDescription(
              name: 'startTime',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'endTime': _i1.ParameterDescription(
              name: 'endTime',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'medium': _i1.ParameterDescription(
              name: 'medium',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'meetingUrl': _i1.ParameterDescription(
              name: 'meetingUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .createBatch(
                        session,
                        organizationId: params['organizationId'],
                        courseVersionId: params['courseVersionId'],
                        name: params['name'],
                        instructorId: params['instructorId'],
                        startDate: params['startDate'],
                        endDate: params['endDate'],
                        capacity: params['capacity'],
                        location: params['location'],
                        notes: params['notes'],
                        startTime: params['startTime'],
                        endTime: params['endTime'],
                        medium: params['medium'],
                        meetingUrl: params['meetingUrl'],
                        category: params['category'],
                        description: params['description'],
                      ),
        ),
        'updateBatch': _i1.MethodConnector(
          name: 'updateBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'instructorId': _i1.ParameterDescription(
              name: 'instructorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'capacity': _i1.ParameterDescription(
              name: 'capacity',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'startTime': _i1.ParameterDescription(
              name: 'startTime',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'endTime': _i1.ParameterDescription(
              name: 'endTime',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'medium': _i1.ParameterDescription(
              name: 'medium',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'meetingUrl': _i1.ParameterDescription(
              name: 'meetingUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .updateBatch(
                        session,
                        params['batchId'],
                        name: params['name'],
                        instructorId: params['instructorId'],
                        startDate: params['startDate'],
                        endDate: params['endDate'],
                        capacity: params['capacity'],
                        status: params['status'],
                        location: params['location'],
                        notes: params['notes'],
                        startTime: params['startTime'],
                        endTime: params['endTime'],
                        medium: params['medium'],
                        meetingUrl: params['meetingUrl'],
                        category: params['category'],
                        description: params['description'],
                      ),
        ),
        'deleteBatch': _i1.MethodConnector(
          name: 'deleteBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .deleteBatch(
                        session,
                        params['batchId'],
                      ),
        ),
        'getBatchStats': _i1.MethodConnector(
          name: 'getBatchStats',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .getBatchStats(
                        session,
                        params['organizationId'],
                      ),
        ),
        'listBatchesForCurrentUser': _i1.MethodConnector(
          name: 'listBatchesForCurrentUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .listBatchesForCurrentUser(session),
        ),
        'listBatchParticipantsForEmployee': _i1.MethodConnector(
          name: 'listBatchParticipantsForEmployee',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .listBatchParticipantsForEmployee(
                        session,
                        params['batchId'],
                      ),
        ),
        'getBatchCohortProgress': _i1.MethodConnector(
          name: 'getBatchCohortProgress',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .getBatchCohortProgress(
                        session,
                        params['batchId'],
                      ),
        ),
        'enrollUserInBatch': _i1.MethodConnector(
          name: 'enrollUserInBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .enrollUserInBatch(
                        session,
                        batchId: params['batchId'],
                        userId: params['userId'],
                        role: params['role'],
                      ),
        ),
        'removeUserFromBatch': _i1.MethodConnector(
          name: 'removeUserFromBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .removeUserFromBatch(
                        session,
                        batchId: params['batchId'],
                        userId: params['userId'],
                      ),
        ),
        'markAttendance': _i1.MethodConnector(
          name: 'markAttendance',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'liveClassId': _i1.ParameterDescription(
              name: 'liveClassId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .markAttendance(
                        session,
                        batchId: params['batchId'],
                        userId: params['userId'],
                        liveClassId: params['liveClassId'],
                        status: params['status'],
                        notes: params['notes'],
                      ),
        ),
        'bulkMarkAttendance': _i1.MethodConnector(
          name: 'bulkMarkAttendance',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'liveClassId': _i1.ParameterDescription(
              name: 'liveClassId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'attendanceList': _i1.ParameterDescription(
              name: 'attendanceList',
              type: _i1.getType<List<Map<String, dynamic>>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .bulkMarkAttendance(
                        session,
                        batchId: params['batchId'],
                        liveClassId: params['liveClassId'],
                        attendanceList: params['attendanceList'],
                      ),
        ),
        'listAttendance': _i1.MethodConnector(
          name: 'listAttendance',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'liveClassId': _i1.ParameterDescription(
              name: 'liveClassId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .listAttendance(
                        session,
                        batchId: params['batchId'],
                        liveClassId: params['liveClassId'],
                      ),
        ),
        'getAttendanceSummary': _i1.MethodConnector(
          name: 'getAttendanceSummary',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .getAttendanceSummary(
                        session,
                        batchId: params['batchId'],
                      ),
        ),
        'closeBatch': _i1.MethodConnector(
          name: 'closeBatch',
          params: {
            'batchId': _i1.ParameterDescription(
              name: 'batchId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'minAttendanceRate': _i1.ParameterDescription(
              name: 'minAttendanceRate',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingBatch'] as _i41.TrainingBatchEndpoint)
                      .closeBatch(
                        session,
                        batchId: params['batchId'],
                        signatureMeaning: params['signatureMeaning'],
                        passwordPlaintext: params['passwordPlaintext'],
                        minAttendanceRate: params['minAttendanceRate'],
                      ),
        ),
      },
    );
    connectors['training'] = _i1.EndpointConnector(
      name: 'training',
      endpoint: endpoints['training']!,
      methodConnectors: {
        'listSignatureMeanings': _i1.MethodConnector(
          name: 'listSignatureMeanings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .listSignatureMeanings(session),
        ),
        'getAssignmentsForUser': _i1.MethodConnector(
          name: 'getAssignmentsForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getAssignmentsForUser(
                    session,
                    params['userId'],
                  ),
        ),
        'assignTraining': _i1.MethodConnector(
          name: 'assignTraining',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assignedById': _i1.ParameterDescription(
              name: 'assignedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'source': _i1.ParameterDescription(
              name: 'source',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'forceReassign': _i1.ParameterDescription(
              name: 'forceReassign',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .assignTraining(
                    session,
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                    assignedById: params['assignedById'],
                    dueDate: params['dueDate'],
                    priority: params['priority'],
                    reason: params['reason'],
                    source: params['source'],
                    forceReassign: params['forceReassign'],
                  ),
        ),
        'updateAssignment': _i1.MethodConnector(
          name: 'updateAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dueDate': _i1.ParameterDescription(
              name: 'dueDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'updatedById': _i1.ParameterDescription(
              name: 'updatedById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .updateAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                    dueDate: params['dueDate'],
                    priority: params['priority'],
                    updatedById: params['updatedById'],
                  ),
        ),
        'cancelAssignment': _i1.MethodConnector(
          name: 'cancelAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cancelledById': _i1.ParameterDescription(
              name: 'cancelledById',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .cancelAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                    cancelledById: params['cancelledById'],
                    reason: params['reason'],
                  ),
        ),
        'getEnrollmentsForUser': _i1.MethodConnector(
          name: 'getEnrollmentsForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getEnrollmentsForUser(
                    session,
                    params['userId'],
                  ),
        ),
        'getEnrollmentResumePosition': _i1.MethodConnector(
          name: 'getEnrollmentResumePosition',
          params: {
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getEnrollmentResumePosition(
                    session,
                    params['enrollmentId'],
                  ),
        ),
        'getEnrollmentById': _i1.MethodConnector(
          name: 'getEnrollmentById',
          params: {
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getEnrollmentById(
                    session,
                    params['enrollmentId'],
                  ),
        ),
        'acknowledgeRetraining': _i1.MethodConnector(
          name: 'acknowledgeRetraining',
          params: {
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .acknowledgeRetraining(
                    session,
                    enrollmentId: params['enrollmentId'],
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordPlaintext: params['passwordPlaintext'],
                  ),
        ),
        'getCertificatesForUser': _i1.MethodConnector(
          name: 'getCertificatesForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getCertificatesForUser(
                    session,
                    params['userId'],
                  ),
        ),
        'getTrainingRecordsForUser': _i1.MethodConnector(
          name: 'getTrainingRecordsForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getTrainingRecordsForUser(
                    session,
                    params['userId'],
                  ),
        ),
        'getCertificateById': _i1.MethodConnector(
          name: 'getCertificateById',
          params: {
            'certificateId': _i1.ParameterDescription(
              name: 'certificateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getCertificateById(
                    session,
                    params['certificateId'],
                  ),
        ),
        'getWaiverById': _i1.MethodConnector(
          name: 'getWaiverById',
          params: {
            'waiverId': _i1.ParameterDescription(
              name: 'waiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getWaiverById(
                    session,
                    params['waiverId'],
                  ),
        ),
        'getSignatureWithIntegrityCheck': _i1.MethodConnector(
          name: 'getSignatureWithIntegrityCheck',
          params: {
            'signatureId': _i1.ParameterDescription(
              name: 'signatureId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getSignatureWithIntegrityCheck(
                    session,
                    params['signatureId'],
                  ),
        ),
        'listElectronicSignatures': _i1.MethodConnector(
          name: 'listElectronicSignatures',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .listElectronicSignatures(
                    session,
                    from: params['from'],
                    to: params['to'],
                    entityType: params['entityType'],
                    userId: params['userId'],
                    limit: params['limit'],
                  ),
        ),
        'issueBiometricToken': _i1.MethodConnector(
          name: 'issueBiometricToken',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .issueBiometricToken(
                    session,
                    userId: params['userId'],
                    passwordPlaintext: params['passwordPlaintext'],
                  ),
        ),
        'createTrainingSignature': _i1.MethodConnector(
          name: 'createTrainingSignature',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entityId': _i1.ParameterDescription(
              name: 'entityId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'biometricToken': _i1.ParameterDescription(
              name: 'biometricToken',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ipAddress': _i1.ParameterDescription(
              name: 'ipAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .createTrainingSignature(
                    session,
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    entityType: params['entityType'],
                    entityId: params['entityId'],
                    passwordPlaintext: params['passwordPlaintext'],
                    biometricToken: params['biometricToken'],
                    ipAddress: params['ipAddress'],
                  ),
        ),
        'completeTraining': _i1.MethodConnector(
          name: 'completeTraining',
          params: {
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'esignatureId': _i1.ParameterDescription(
              name: 'esignatureId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'score': _i1.ParameterDescription(
              name: 'score',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .completeTraining(
                    session,
                    enrollmentId: params['enrollmentId'],
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                    esignatureId: params['esignatureId'],
                    score: params['score'],
                  ),
        ),
        'listAnnotations': _i1.MethodConnector(
          name: 'listAnnotations',
          params: {
            'trainingRecordId': _i1.ParameterDescription(
              name: 'trainingRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .listAnnotations(
                    session,
                    params['trainingRecordId'],
                  ),
        ),
        'addAnnotation': _i1.MethodConnector(
          name: 'addAnnotation',
          params: {
            'trainingRecordId': _i1.ParameterDescription(
              name: 'trainingRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .addAnnotation(
                    session,
                    trainingRecordId: params['trainingRecordId'],
                    authorId: params['authorId'],
                    note: params['note'],
                  ),
        ),
        'revokeSignature': _i1.MethodConnector(
          name: 'revokeSignature',
          params: {
            'signatureId': _i1.ParameterDescription(
              name: 'signatureId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .revokeSignature(
                    session,
                    signatureId: params['signatureId'],
                    reason: params['reason'],
                    passwordPlaintext: params['passwordPlaintext'],
                  ),
        ),
        'qaApproveAssignment': _i1.MethodConnector(
          name: 'qaApproveAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'comments': _i1.ParameterDescription(
              name: 'comments',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .qaApproveAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordPlaintext: params['passwordPlaintext'],
                    comments: params['comments'],
                  ),
        ),
        'qaRejectAssignment': _i1.MethodConnector(
          name: 'qaRejectAssignment',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'signatureMeaning': _i1.ParameterDescription(
              name: 'signatureMeaning',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'passwordPlaintext': _i1.ParameterDescription(
              name: 'passwordPlaintext',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .qaRejectAssignment(
                    session,
                    assignmentId: params['assignmentId'],
                    reason: params['reason'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordPlaintext: params['passwordPlaintext'],
                  ),
        ),
        'submitForQaApproval': _i1.MethodConnector(
          name: 'submitForQaApproval',
          params: {
            'assignmentId': _i1.ParameterDescription(
              name: 'assignmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .submitForQaApproval(
                    session,
                    assignmentId: params['assignmentId'],
                  ),
        ),
        'selfEnroll': _i1.MethodConnector(
          name: 'selfEnroll',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i42.TrainingEndpoint).selfEnroll(
                    session,
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                  ),
        ),
        'listLearnersEnrolledInTrainerPublishedCourses': _i1.MethodConnector(
          name: 'listLearnersEnrolledInTrainerPublishedCourses',
          params: {
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .listLearnersEnrolledInTrainerPublishedCourses(
                    session,
                    search: params['search'],
                    limit: params['limit'],
                  ),
        ),
        'getEnrollmentsForCourseVersion': _i1.MethodConnector(
          name: 'getEnrollmentsForCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getEnrollmentsForCourseVersion(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getAssignmentsForCourseVersion': _i1.MethodConnector(
          name: 'getAssignmentsForCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getAssignmentsForCourseVersion(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getAllAssignments': _i1.MethodConnector(
          name: 'getAllAssignments',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getAllAssignments(
                    session,
                    organizationId: params['organizationId'],
                  ),
        ),
        'getTrainingRecordsForCourseVersion': _i1.MethodConnector(
          name: 'getTrainingRecordsForCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getTrainingRecordsForCourseVersion(
                    session,
                    params['courseVersionId'],
                  ),
        ),
        'getEnrollmentProgress': _i1.MethodConnector(
          name: 'getEnrollmentProgress',
          params: {
            'enrollmentId': _i1.ParameterDescription(
              name: 'enrollmentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getEnrollmentProgress(
                    session,
                    params['enrollmentId'],
                  ),
        ),
        'isCourseContentComplete': _i1.MethodConnector(
          name: 'isCourseContentComplete',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .isCourseContentComplete(
                    session,
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                  ),
        ),
        'getCertificatesForCourseVersion': _i1.MethodConnector(
          name: 'getCertificatesForCourseVersion',
          params: {
            'courseVersionId': _i1.ParameterDescription(
              name: 'courseVersionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i42.TrainingEndpoint)
                  .getCertificatesForCourseVersion(
                    session,
                    params['courseVersionId'],
                  ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i43.UserEndpoint).getUser(
                session,
                params['id'],
              ),
        ),
        'getUserByEmail': _i1.MethodConnector(
          name: 'getUserByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i43.UserEndpoint).getUserByEmail(
                    session,
                    params['email'],
                  ),
        ),
        'getUserRoleByEmail': _i1.MethodConnector(
          name: 'getUserRoleByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i43.UserEndpoint).getUserRoleByEmail(
                    session,
                    params['email'],
                  ),
        ),
        'getUserPreferences': _i1.MethodConnector(
          name: 'getUserPreferences',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i43.UserEndpoint).getUserPreferences(
                    session,
                    userId: params['userId'],
                  ),
        ),
        'setUserPreference': _i1.MethodConnector(
          name: 'setUserPreference',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i43.UserEndpoint).setUserPreference(
                    session,
                    userId: params['userId'],
                    key: params['key'],
                    value: params['value'],
                  ),
        ),
      },
    );
    connectors['validation'] = _i1.EndpointConnector(
      name: 'validation',
      endpoint: endpoints['validation']!,
      methodConnectors: {
        'generateUrs': _i1.MethodConnector(
          name: 'generateUrs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generateUrs(session),
        ),
        'generateFs': _i1.MethodConnector(
          name: 'generateFs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generateFs(session),
        ),
        'generateDs': _i1.MethodConnector(
          name: 'generateDs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generateDs(session),
        ),
        'generateIq': _i1.MethodConnector(
          name: 'generateIq',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generateIq(session),
        ),
        'generateOq': _i1.MethodConnector(
          name: 'generateOq',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generateOq(session),
        ),
        'generatePq': _i1.MethodConnector(
          name: 'generatePq',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generatePq(session),
        ),
        'generateTraceabilityMatrix': _i1.MethodConnector(
          name: 'generateTraceabilityMatrix',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i44.ValidationEndpoint)
                  .generateTraceabilityMatrix(session),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i45.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i46.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i47.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i48.Endpoints()..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i49.FutureCalls();
  }
}
