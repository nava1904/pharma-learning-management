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
import '../endpoints/admin_endpoint.dart' as _i5;
import '../endpoints/analytics_endpoint.dart' as _i6;
import '../endpoints/assessment_builder_endpoint.dart' as _i7;
import '../endpoints/assessment_endpoint.dart' as _i8;
import '../endpoints/audit_endpoint.dart' as _i9;
import '../endpoints/audit_trail_endpoint.dart' as _i10;
import '../endpoints/compliance_endpoint.dart' as _i11;
import '../endpoints/course_builder_endpoint.dart' as _i12;
import '../endpoints/course_endpoint.dart' as _i13;
import '../endpoints/document_endpoint.dart' as _i14;
import '../endpoints/event_endpoint.dart' as _i15;
import '../endpoints/inspection_endpoint.dart' as _i16;
import '../endpoints/material_endpoint.dart' as _i17;
import '../endpoints/mfa_endpoint.dart' as _i18;
import '../endpoints/notification_endpoint.dart' as _i19;
import '../endpoints/organization_endpoint.dart' as _i20;
import '../endpoints/qa_endpoint.dart' as _i21;
import '../endpoints/quality_event_endpoint.dart' as _i22;
import '../endpoints/seed_endpoint.dart' as _i23;
import '../endpoints/sop_linkage_endpoint.dart' as _i24;
import '../endpoints/training_endpoint.dart' as _i25;
import '../endpoints/user_endpoint.dart' as _i26;
import '../endpoints/validation_endpoint.dart' as _i27;
import '../greetings/greeting_endpoint.dart' as _i28;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i29;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i30;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i31;
import 'package:pharma_lms_server/src/generated/future_calls.dart' as _i32;
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
      'admin': _i5.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'analytics': _i6.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'assessmentBuilder': _i7.AssessmentBuilderEndpoint()
        ..initialize(
          server,
          'assessmentBuilder',
          null,
        ),
      'assessment': _i8.AssessmentEndpoint()
        ..initialize(
          server,
          'assessment',
          null,
        ),
      'audit': _i9.AuditEndpoint()
        ..initialize(
          server,
          'audit',
          null,
        ),
      'auditTrail': _i10.AuditTrailEndpoint()
        ..initialize(
          server,
          'auditTrail',
          null,
        ),
      'compliance': _i11.ComplianceEndpoint()
        ..initialize(
          server,
          'compliance',
          null,
        ),
      'courseBuilder': _i12.CourseBuilderEndpoint()
        ..initialize(
          server,
          'courseBuilder',
          null,
        ),
      'course': _i13.CourseEndpoint()
        ..initialize(
          server,
          'course',
          null,
        ),
      'document': _i14.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'event': _i15.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'inspection': _i16.InspectionEndpoint()
        ..initialize(
          server,
          'inspection',
          null,
        ),
      'material': _i17.MaterialEndpoint()
        ..initialize(
          server,
          'material',
          null,
        ),
      'mfa': _i18.MfaEndpoint()
        ..initialize(
          server,
          'mfa',
          null,
        ),
      'notification': _i19.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'organization': _i20.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'qa': _i21.QaEndpoint()
        ..initialize(
          server,
          'qa',
          null,
        ),
      'qualityEvent': _i22.QualityEventEndpoint()
        ..initialize(
          server,
          'qualityEvent',
          null,
        ),
      'seed': _i23.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'sopLinkage': _i24.SopLinkageEndpoint()
        ..initialize(
          server,
          'sopLinkage',
          null,
        ),
      'training': _i25.TrainingEndpoint()
        ..initialize(
          server,
          'training',
          null,
        ),
      'user': _i26.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'validation': _i27.ValidationEndpoint()
        ..initialize(
          server,
          'validation',
          null,
        ),
      'greeting': _i28.GreetingEndpoint()
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
                  (endpoints['admin'] as _i5.AdminEndpoint).bulkImportUsers(
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
                  .getRoleBasedCurriculum(
                    session,
                    params['jobRoleId'],
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
                  (endpoints['admin'] as _i5.AdminEndpoint).lockUserByEmail(
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
                  (endpoints['admin'] as _i5.AdminEndpoint).listTrainingWaivers(
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
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
                  (endpoints['admin'] as _i5.AdminEndpoint).unlockUserByEmail(
                    session,
                    params['email'],
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
                  (endpoints['admin'] as _i5.AdminEndpoint).terminateUser(
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .runCertExpiryCheck(session),
        ),
        'runNotificationWorker': _i1.MethodConnector(
          name: 'runNotificationWorker',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .runNotificationWorker(session),
        ),
        'runComplianceCalc': _i1.MethodConnector(
          name: 'runComplianceCalc',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .runComplianceCalc(session),
        ),
        'runAuditTrailIntegrityCheck': _i1.MethodConnector(
          name: 'runAuditTrailIntegrityCheck',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .runAuditTrailIntegrityCheck(session),
        ),
        'getDepartmentComplianceSummary': _i1.MethodConnector(
          name: 'getDepartmentComplianceSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getOpenCapasRequiringTraining(session),
        ),
        'getPendingQaApprovalsCount': _i1.MethodConnector(
          name: 'getPendingQaApprovalsCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getPendingQaApprovalsCount(session),
        ),
        'getSopRetrainingQueue': _i1.MethodConnector(
          name: 'getSopRetrainingQueue',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getSopRetrainingQueue(session),
        ),
        'getDlqFailureCount': _i1.MethodConnector(
          name: 'getDlqFailureCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getDlqFailureCount(session),
        ),
        'getTrainingVsDeviationCorrelation': _i1.MethodConnector(
          name: 'getTrainingVsDeviationCorrelation',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getTrainingVsDeviationCorrelation(session),
        ),
        'getComplianceDeviationOverlay': _i1.MethodConnector(
          name: 'getComplianceDeviationOverlay',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getComplianceDeviationOverlay(session),
        ),
        'getSlaSummary': _i1.MethodConnector(
          name: 'getSlaSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getComplianceTrend(
                    session,
                    months: params['months'],
                  ),
        ),
        'getSopRetrainingVelocity': _i1.MethodConnector(
          name: 'getSopRetrainingVelocity',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getRecentActivity(
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getOpenQualityEventsCount(session),
        ),
        'getSlaBreaches': _i1.MethodConnector(
          name: 'getSlaBreaches',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getUserAverageQuizScore(
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .exportCourseAnalyticsCsv(
                    session,
                    courseVersionId: params['courseVersionId'],
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
              ) => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
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
                          as _i7.AssessmentBuilderEndpoint)
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
                          as _i7.AssessmentBuilderEndpoint)
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
                          as _i7.AssessmentBuilderEndpoint)
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
                          as _i7.AssessmentBuilderEndpoint)
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
                          as _i7.AssessmentBuilderEndpoint)
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
                          as _i7.AssessmentBuilderEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i7.AssessmentBuilderEndpoint)
                      .createAssessment(
                        session,
                        courseVersionId: params['courseVersionId'],
                        questionBankId: params['questionBankId'],
                        passingScore: params['passingScore'],
                        randomize: params['randomize'],
                        timeLimitMinutes: params['timeLimitMinutes'],
                        maxAttempts: params['maxAttempts'],
                        questionsToDisplay: params['questionsToDisplay'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i7.AssessmentBuilderEndpoint)
                      .updateAssessment(
                        session,
                        assessmentId: params['assessmentId'],
                        passingScore: params['passingScore'],
                        randomize: params['randomize'],
                        timeLimitMinutes: params['timeLimitMinutes'],
                        maxAttempts: params['maxAttempts'],
                        questionsToDisplay: params['questionsToDisplay'],
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
                          as _i7.AssessmentBuilderEndpoint)
                      .validateAssessmentForSubmission(
                        session,
                        assessmentId: params['assessmentId'],
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
                  .startAttempt(
                    session,
                    userId: params['userId'],
                    assessmentId: params['assessmentId'],
                    enrollmentId: params['enrollmentId'],
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i8.AssessmentEndpoint)
                  .importQuestionsToBank(
                    session,
                    targetBankId: params['targetBankId'],
                    questions: params['questions'],
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
                  (endpoints['audit'] as _i9.AuditEndpoint).logReportExport(
                    session,
                    reportType: params['reportType'],
                    hashSha256: params['hashSha256'],
                    exportedById: params['exportedById'],
                    filterParamsJson: params['filterParamsJson'],
                    recordCount: params['recordCount'],
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
                  (endpoints['audit'] as _i9.AuditEndpoint).getAuditTrail(
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
                  (endpoints['audit'] as _i9.AuditEndpoint).getConfigChangeLog(
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
                  (endpoints['audit'] as _i9.AuditEndpoint).getAccessLogs(
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
                  (endpoints['audit'] as _i9.AuditEndpoint).exportAuditCsv(
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
              ) async => (endpoints['auditTrail'] as _i10.AuditTrailEndpoint)
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
              ) async => (endpoints['compliance'] as _i11.ComplianceEndpoint)
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
              ) async => (endpoints['compliance'] as _i11.ComplianceEndpoint)
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
              ) async => (endpoints['compliance'] as _i11.ComplianceEndpoint)
                  .isDepartmentBelowThreshold(
                    session,
                    departmentId: params['departmentId'],
                    threshold: params['threshold'],
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
                      .createLesson(
                        session,
                        moduleId: params['moduleId'],
                        title: params['title'],
                        materialId: params['materialId'],
                        orderIndex: params['orderIndex'],
                        durationMinutes: params['durationMinutes'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
                      .updateLesson(
                        session,
                        lessonId: params['lessonId'],
                        title: params['title'],
                        materialId: params['materialId'],
                        orderIndex: params['orderIndex'],
                        durationMinutes: params['durationMinutes'],
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i12.CourseBuilderEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i13.CourseEndpoint).listCourses(
                    session,
                    organizationId: params['organizationId'],
                    status: params['status'],
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
              ) async => (endpoints['course'] as _i13.CourseEndpoint).getCourse(
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
              ) async => (endpoints['course'] as _i13.CourseEndpoint)
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
                  (endpoints['course'] as _i13.CourseEndpoint).getCourseVersion(
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
                  (endpoints['course'] as _i13.CourseEndpoint).createCourse(
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['course'] as _i13.CourseEndpoint)
                  .createCourseWithVersion(
                    session,
                    title: params['title'],
                    organizationId: params['organizationId'],
                    sopNumber: params['sopNumber'],
                    description: params['description'],
                    createdById: params['createdById'],
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
              ) async => (endpoints['course'] as _i13.CourseEndpoint)
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
              ) async => (endpoints['course'] as _i13.CourseEndpoint)
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
              ) async => (endpoints['course'] as _i13.CourseEndpoint)
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
                  (endpoints['course'] as _i13.CourseEndpoint).searchCourses(
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['course'] as _i13.CourseEndpoint).updateCourse(
                    session,
                    courseId: params['courseId'],
                    title: params['title'],
                    description: params['description'],
                    sopNumber: params['sopNumber'],
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
                  (endpoints['course'] as _i13.CourseEndpoint).deleteCourse(
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
                  (endpoints['document'] as _i14.DocumentEndpoint).getDocument(
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i14.DocumentEndpoint)
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
                  (endpoints['event'] as _i15.EventEndpoint).triggerSopUpdated(
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
              ) async => (endpoints['event'] as _i15.EventEndpoint)
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
              ) async => (endpoints['event'] as _i15.EventEndpoint)
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
              ) async => (endpoints['event'] as _i15.EventEndpoint)
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
              ) async => (endpoints['event'] as _i15.EventEndpoint)
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
              ) async => (endpoints['event'] as _i15.EventEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i16.InspectionEndpoint)
                  .getSopTrainingCoverage(
                    session,
                    sopDocumentId: params['sopDocumentId'],
                    versionId: params['versionId'],
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
                  (endpoints['material'] as _i17.MaterialEndpoint).getMaterial(
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
                  .createMaterial(
                    session,
                    title: params['title'],
                    materialType: params['materialType'],
                    organizationId: params['organizationId'],
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
                  (endpoints['material'] as _i17.MaterialEndpoint).verifyUpload(
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
                  (endpoints['material'] as _i17.MaterialEndpoint).getProgress(
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i17.MaterialEndpoint)
                  .getMaterialWithVersions(
                    session,
                    materialId: params['materialId'],
                  ),
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
                  (endpoints['mfa'] as _i18.MfaEndpoint).getMfaStatus(session),
        ),
        'enrollMfa': _i1.MethodConnector(
          name: 'enrollMfa',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i18.MfaEndpoint).enrollMfa(session),
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
                  (endpoints['mfa'] as _i18.MfaEndpoint).verifyMfaEnrollment(
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
              ) async => (endpoints['mfa'] as _i18.MfaEndpoint).verifyMfa(
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
                  (endpoints['mfa'] as _i18.MfaEndpoint).disableMfa(session),
        ),
        'isMfaVerified': _i1.MethodConnector(
          name: 'isMfaVerified',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mfa'] as _i18.MfaEndpoint).isMfaVerified(session),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
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
                  (endpoints['notification'] as _i19.NotificationEndpoint)
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
                  (endpoints['notification'] as _i19.NotificationEndpoint)
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
                  (endpoints['notification'] as _i19.NotificationEndpoint)
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
                  (endpoints['notification'] as _i19.NotificationEndpoint)
                      .getUnreadCount(
                        session,
                        params['userId'],
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i20.OrganizationEndpoint)
                      .listUsers(
                        session,
                        organizationId: params['organizationId'],
                        departmentId: params['departmentId'],
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
              ) async => (endpoints['qa'] as _i21.QaEndpoint)
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
                  (endpoints['qa'] as _i21.QaEndpoint).approveCourseVersion(
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
                  (endpoints['qa'] as _i21.QaEndpoint).rejectCourseVersion(
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
              ) async => (endpoints['qa'] as _i21.QaEndpoint)
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
                  (endpoints['qa'] as _i21.QaEndpoint).returnCourseForChanges(
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
              ) async => (endpoints['qa'] as _i21.QaEndpoint).getCourseReviews(
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i22.QualityEventEndpoint)
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
                  (endpoints['seed'] as _i23.SeedEndpoint).runSeed(session),
        ),
        'runMvpSeed': _i1.MethodConnector(
          name: 'runMvpSeed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['seed'] as _i23.SeedEndpoint).runMvpSeed(session),
        ),
        'clearAndReseed': _i1.MethodConnector(
          name: 'clearAndReseed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i23.SeedEndpoint)
                  .clearAndReseed(session),
        ),
        'runComprehensiveSeed': _i1.MethodConnector(
          name: 'runComprehensiveSeed',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i23.SeedEndpoint)
                  .runComprehensiveSeed(session),
        ),
        'provisionAuthAccounts': _i1.MethodConnector(
          name: 'provisionAuthAccounts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i23.SeedEndpoint)
                  .provisionAuthAccounts(session),
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
              ) async => (endpoints['sopLinkage'] as _i24.SopLinkageEndpoint)
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
              ) async => (endpoints['sopLinkage'] as _i24.SopLinkageEndpoint)
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
              ) async => (endpoints['sopLinkage'] as _i24.SopLinkageEndpoint)
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
              ) async => (endpoints['sopLinkage'] as _i24.SopLinkageEndpoint)
                  .getCoursesForSop(
                    session,
                    documentId: params['documentId'],
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
                  .revokeSignature(
                    session,
                    signatureId: params['signatureId'],
                    reason: params['reason'],
                    passwordPlaintext: params['passwordPlaintext'],
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
                  (endpoints['training'] as _i25.TrainingEndpoint).selfEnroll(
                    session,
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i25.TrainingEndpoint)
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
              ) async => (endpoints['user'] as _i26.UserEndpoint).getUser(
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
                  (endpoints['user'] as _i26.UserEndpoint).getUserByEmail(
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
                  (endpoints['user'] as _i26.UserEndpoint).getUserRoleByEmail(
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
                  (endpoints['user'] as _i26.UserEndpoint).getUserPreferences(
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
                  (endpoints['user'] as _i26.UserEndpoint).setUserPreference(
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
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
                  .generateUrs(session),
        ),
        'generateFs': _i1.MethodConnector(
          name: 'generateFs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
                  .generateFs(session),
        ),
        'generateDs': _i1.MethodConnector(
          name: 'generateDs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
                  .generateDs(session),
        ),
        'generateIq': _i1.MethodConnector(
          name: 'generateIq',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
                  .generateIq(session),
        ),
        'generateOq': _i1.MethodConnector(
          name: 'generateOq',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
                  .generateOq(session),
        ),
        'generatePq': _i1.MethodConnector(
          name: 'generatePq',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
                  .generatePq(session),
        ),
        'generateTraceabilityMatrix': _i1.MethodConnector(
          name: 'generateTraceabilityMatrix',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['validation'] as _i27.ValidationEndpoint)
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
              ) async => (endpoints['greeting'] as _i28.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i29.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i30.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i31.Endpoints()..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i32.FutureCalls();
  }
}
