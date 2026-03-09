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
import '../endpoints/admin_endpoint.dart' as _i4;
import '../endpoints/analytics_endpoint.dart' as _i5;
import '../endpoints/assessment_builder_endpoint.dart' as _i6;
import '../endpoints/assessment_endpoint.dart' as _i7;
import '../endpoints/audit_endpoint.dart' as _i8;
import '../endpoints/compliance_endpoint.dart' as _i9;
import '../endpoints/course_builder_endpoint.dart' as _i10;
import '../endpoints/course_endpoint.dart' as _i11;
import '../endpoints/document_endpoint.dart' as _i12;
import '../endpoints/event_endpoint.dart' as _i13;
import '../endpoints/inspection_endpoint.dart' as _i14;
import '../endpoints/material_endpoint.dart' as _i15;
import '../endpoints/notification_endpoint.dart' as _i16;
import '../endpoints/organization_endpoint.dart' as _i17;
import '../endpoints/qa_endpoint.dart' as _i18;
import '../endpoints/quality_event_endpoint.dart' as _i19;
import '../endpoints/seed_endpoint.dart' as _i20;
import '../endpoints/training_endpoint.dart' as _i21;
import '../endpoints/user_endpoint.dart' as _i22;
import '../greetings/greeting_endpoint.dart' as _i23;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i24;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i25;
import 'package:pharma_lms_server/src/generated/future_calls.dart' as _i26;
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
      'admin': _i4.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'analytics': _i5.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'assessmentBuilder': _i6.AssessmentBuilderEndpoint()
        ..initialize(
          server,
          'assessmentBuilder',
          null,
        ),
      'assessment': _i7.AssessmentEndpoint()
        ..initialize(
          server,
          'assessment',
          null,
        ),
      'audit': _i8.AuditEndpoint()
        ..initialize(
          server,
          'audit',
          null,
        ),
      'compliance': _i9.ComplianceEndpoint()
        ..initialize(
          server,
          'compliance',
          null,
        ),
      'courseBuilder': _i10.CourseBuilderEndpoint()
        ..initialize(
          server,
          'courseBuilder',
          null,
        ),
      'course': _i11.CourseEndpoint()
        ..initialize(
          server,
          'course',
          null,
        ),
      'document': _i12.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'event': _i13.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'inspection': _i14.InspectionEndpoint()
        ..initialize(
          server,
          'inspection',
          null,
        ),
      'material': _i15.MaterialEndpoint()
        ..initialize(
          server,
          'material',
          null,
        ),
      'notification': _i16.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'organization': _i17.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'qa': _i18.QaEndpoint()
        ..initialize(
          server,
          'qa',
          null,
        ),
      'qualityEvent': _i19.QualityEventEndpoint()
        ..initialize(
          server,
          'qualityEvent',
          null,
        ),
      'seed': _i20.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'training': _i21.TrainingEndpoint()
        ..initialize(
          server,
          'training',
          null,
        ),
      'user': _i22.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'greeting': _i23.GreetingEndpoint()
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
                  (endpoints['admin'] as _i4.AdminEndpoint).bulkImportUsers(
                    session,
                    csvBase64: params['csvBase64'],
                    assignedById: params['assignedById'],
                    dueDate: params['dueDate'],
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
                  (endpoints['admin'] as _i4.AdminEndpoint).lockUserByEmail(
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
                  (endpoints['admin'] as _i4.AdminEndpoint).listTrainingWaivers(
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
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
                  (endpoints['admin'] as _i4.AdminEndpoint).unlockUserByEmail(
                    session,
                    params['email'],
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getSystemHealth(session),
        ),
        'getDepartmentComplianceSummary': _i1.MethodConnector(
          name: 'getDepartmentComplianceSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getOpenCapasRequiringTraining(session),
        ),
        'getPendingQaApprovalsCount': _i1.MethodConnector(
          name: 'getPendingQaApprovalsCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getPendingQaApprovalsCount(session),
        ),
        'getSopRetrainingQueue': _i1.MethodConnector(
          name: 'getSopRetrainingQueue',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getSopRetrainingQueue(session),
        ),
        'getDlqFailureCount': _i1.MethodConnector(
          name: 'getDlqFailureCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getDlqFailureCount(session),
        ),
        'getTrainingVsDeviationCorrelation': _i1.MethodConnector(
          name: 'getTrainingVsDeviationCorrelation',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getTrainingVsDeviationCorrelation(session),
        ),
        'getComplianceDeviationOverlay': _i1.MethodConnector(
          name: 'getComplianceDeviationOverlay',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getComplianceDeviationOverlay(session),
        ),
        'getSlaSummary': _i1.MethodConnector(
          name: 'getSlaSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getSlaSummary(session),
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
              ) async => (endpoints['analytics'] as _i5.AnalyticsEndpoint)
                  .getRecentActivity(
                    session,
                    params['userId'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i6.AssessmentBuilderEndpoint)
                      .createQuestion(
                        session,
                        questionBankId: params['questionBankId'],
                        text: params['text'],
                        questionType: params['questionType'],
                        optionsJson: params['optionsJson'],
                        correctAnswer: params['correctAnswer'],
                        difficulty: params['difficulty'],
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
                          as _i6.AssessmentBuilderEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i6.AssessmentBuilderEndpoint)
                      .createAssessment(
                        session,
                        courseVersionId: params['courseVersionId'],
                        questionBankId: params['questionBankId'],
                        passingScore: params['passingScore'],
                        randomize: params['randomize'],
                        timeLimitMinutes: params['timeLimitMinutes'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['assessmentBuilder']
                          as _i6.AssessmentBuilderEndpoint)
                      .updateAssessment(
                        session,
                        assessmentId: params['assessmentId'],
                        passingScore: params['passingScore'],
                        randomize: params['randomize'],
                        timeLimitMinutes: params['timeLimitMinutes'],
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
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
                  .startAttempt(
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
            'score': _i1.ParameterDescription(
              name: 'score',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
                  .submitAttempt(
                    session,
                    attemptId: params['attemptId'],
                    score: params['score'],
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
            'correct': _i1.ParameterDescription(
              name: 'correct',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'points': _i1.ParameterDescription(
              name: 'points',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
                  .recordAnswer(
                    session,
                    attemptId: params['attemptId'],
                    questionId: params['questionId'],
                    answer: params['answer'],
                    correct: params['correct'],
                    points: params['points'],
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
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
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
              ) async => (endpoints['assessment'] as _i7.AssessmentEndpoint)
                  .createQuestionBank(
                    session,
                    name: params['name'],
                    organizationId: params['organizationId'],
                    tagsJson: params['tagsJson'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _i8.AuditEndpoint).logReportExport(
                    session,
                    reportType: params['reportType'],
                    hashSha256: params['hashSha256'],
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
                  (endpoints['audit'] as _i8.AuditEndpoint).getAuditTrail(
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
                  (endpoints['audit'] as _i8.AuditEndpoint).getConfigChangeLog(
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
                  (endpoints['audit'] as _i8.AuditEndpoint).getAccessLogs(
                    session,
                    userId: params['userId'],
                    from: params['from'],
                    to: params['to'],
                    limit: params['limit'],
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
              ) async => (endpoints['compliance'] as _i9.ComplianceEndpoint)
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
              ) async => (endpoints['compliance'] as _i9.ComplianceEndpoint)
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
              ) async => (endpoints['compliance'] as _i9.ComplianceEndpoint)
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
                  (endpoints['courseBuilder'] as _i10.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i10.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i10.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i10.CourseBuilderEndpoint)
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
                  (endpoints['courseBuilder'] as _i10.CourseBuilderEndpoint)
                      .createCourseVersion(
                        session,
                        courseId: params['courseId'],
                        version: params['version'],
                        status: params['status'],
                        changeSummary: params['changeSummary'],
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
                  (endpoints['courseBuilder'] as _i10.CourseBuilderEndpoint)
                      .updateCourseVersionStatus(
                        session,
                        courseVersionId: params['courseVersionId'],
                        status: params['status'],
                        approverId: params['approverId'],
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
                  (endpoints['course'] as _i11.CourseEndpoint).listCourses(
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
              ) async => (endpoints['course'] as _i11.CourseEndpoint).getCourse(
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
              ) async => (endpoints['course'] as _i11.CourseEndpoint)
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
                  (endpoints['course'] as _i11.CourseEndpoint).getCourseVersion(
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
                  (endpoints['course'] as _i11.CourseEndpoint).createCourse(
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
              ) async => (endpoints['course'] as _i11.CourseEndpoint)
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
              ) async => (endpoints['course'] as _i11.CourseEndpoint)
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
              ) async => (endpoints['course'] as _i11.CourseEndpoint)
                  .getLessonWithMaterial(
                    session,
                    params['lessonId'],
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
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
                  (endpoints['document'] as _i12.DocumentEndpoint).getDocument(
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
                  .createDocumentVersion(
                    session,
                    documentId: params['documentId'],
                    version: params['version'],
                    storageKey: params['storageKey'],
                    effectiveDate: params['effectiveDate'],
                    obsoleteDate: params['obsoleteDate'],
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
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
            'passwordReauthHash': _i1.ParameterDescription(
              name: 'passwordReauthHash',
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
                  .transitionDocumentLifecycle(
                    session,
                    documentVersionId: params['documentVersionId'],
                    newState: params['newState'],
                    obsoleteReason: params['obsoleteReason'],
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordReauthHash: params['passwordReauthHash'],
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
              ) async => (endpoints['document'] as _i12.DocumentEndpoint)
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
                  (endpoints['event'] as _i13.EventEndpoint).triggerSopUpdated(
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
              ) async => (endpoints['event'] as _i13.EventEndpoint)
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
              ) async => (endpoints['event'] as _i13.EventEndpoint)
                  .triggerEmployeeTransferred(
                    session,
                    userId: params['userId'],
                    oldDepartmentId: params['oldDepartmentId'],
                    newDepartmentId: params['newDepartmentId'],
                    oldRoleId: params['oldRoleId'],
                    newRoleId: params['newRoleId'],
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
                  .validateAuditorToken(
                    session,
                    token: params['token'],
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
                  .listInspectionPackages(
                    session,
                    inspectionRecordId: params['inspectionRecordId'],
                    limit: params['limit'],
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
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
            'passwordReauthHash': _i1.ParameterDescription(
              name: 'passwordReauthHash',
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
                  .signInspectionPackageAsOfficial(
                    session,
                    packageId: params['packageId'],
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordReauthHash: params['passwordReauthHash'],
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
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
              ) async => (endpoints['inspection'] as _i14.InspectionEndpoint)
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
                  (endpoints['material'] as _i15.MaterialEndpoint).getMaterial(
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
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
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
                  (endpoints['material'] as _i15.MaterialEndpoint).verifyUpload(
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
                  .createMaterialVersion(
                    session,
                    materialId: params['materialId'],
                    storageKey: params['storageKey'],
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
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i15.MaterialEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['material'] as _i15.MaterialEndpoint).getProgress(
                    session,
                    userId: params['userId'],
                    materialId: params['materialId'],
                  ),
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
                  (endpoints['notification'] as _i16.NotificationEndpoint)
                      .getInAppNotifications(
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i17.OrganizationEndpoint)
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
              ) async => (endpoints['qa'] as _i18.QaEndpoint)
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
                  (endpoints['qa'] as _i18.QaEndpoint).approveCourseVersion(
                    session,
                    courseVersionId: params['courseVersionId'],
                    approverId: params['approverId'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qa'] as _i18.QaEndpoint).rejectCourseVersion(
                    session,
                    courseVersionId: params['courseVersionId'],
                    reason: params['reason'],
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
                      .closeCapa(
                        session,
                        capaId: params['capaId'],
                        closedById: params['closedById'],
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i19.QualityEventEndpoint)
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
                  (endpoints['seed'] as _i20.SeedEndpoint).runSeed(session),
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
                  .getEnrollmentsForUser(
                    session,
                    params['userId'],
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
            'passwordReauthHash': _i1.ParameterDescription(
              name: 'passwordReauthHash',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
                  .acknowledgeRetraining(
                    session,
                    enrollmentId: params['enrollmentId'],
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    passwordReauthHash: params['passwordReauthHash'],
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
                  .getCertificateById(
                    session,
                    params['certificateId'],
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
                  .listElectronicSignatures(
                    session,
                    from: params['from'],
                    to: params['to'],
                    entityType: params['entityType'],
                    userId: params['userId'],
                    limit: params['limit'],
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
            'passwordReauthHash': _i1.ParameterDescription(
              name: 'passwordReauthHash',
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
                  .createTrainingSignature(
                    session,
                    userId: params['userId'],
                    signatureMeaning: params['signatureMeaning'],
                    entityType: params['entityType'],
                    entityId: params['entityId'],
                    passwordReauthHash: params['passwordReauthHash'],
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i21.TrainingEndpoint)
                  .addAnnotation(
                    session,
                    trainingRecordId: params['trainingRecordId'],
                    authorId: params['authorId'],
                    note: params['note'],
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
              ) async => (endpoints['user'] as _i22.UserEndpoint).getUser(
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
                  (endpoints['user'] as _i22.UserEndpoint).getUserByEmail(
                    session,
                    params['email'],
                  ),
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
              ) async => (endpoints['greeting'] as _i23.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i24.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i25.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i26.FutureCalls();
  }
}
