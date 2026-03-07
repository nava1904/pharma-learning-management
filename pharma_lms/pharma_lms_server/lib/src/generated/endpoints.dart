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
import '../endpoints/material_endpoint.dart' as _i14;
import '../endpoints/notification_endpoint.dart' as _i15;
import '../endpoints/organization_endpoint.dart' as _i16;
import '../endpoints/qa_endpoint.dart' as _i17;
import '../endpoints/quality_event_endpoint.dart' as _i18;
import '../endpoints/seed_endpoint.dart' as _i19;
import '../endpoints/training_endpoint.dart' as _i20;
import '../endpoints/user_endpoint.dart' as _i21;
import '../greetings/greeting_endpoint.dart' as _i22;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i23;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i24;
import 'package:pharma_lms_server/src/generated/future_calls.dart' as _i25;
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
      'material': _i14.MaterialEndpoint()
        ..initialize(
          server,
          'material',
          null,
        ),
      'notification': _i15.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'organization': _i16.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'qa': _i17.QaEndpoint()
        ..initialize(
          server,
          'qa',
          null,
        ),
      'qualityEvent': _i18.QualityEventEndpoint()
        ..initialize(
          server,
          'qualityEvent',
          null,
        ),
      'seed': _i19.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'training': _i20.TrainingEndpoint()
        ..initialize(
          server,
          'training',
          null,
        ),
      'user': _i21.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'greeting': _i22.GreetingEndpoint()
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
                  (endpoints['material'] as _i14.MaterialEndpoint).getMaterial(
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
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
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
                  (endpoints['material'] as _i14.MaterialEndpoint).verifyUpload(
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
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
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
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['material'] as _i14.MaterialEndpoint)
                  .updateProgress(
                    session,
                    userId: params['userId'],
                    materialId: params['materialId'],
                    progressPct: params['progressPct'],
                    completedAt: params['completedAt'],
                    interactionJson: params['interactionJson'],
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
                  (endpoints['material'] as _i14.MaterialEndpoint).getProgress(
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
                  (endpoints['notification'] as _i15.NotificationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
                  (endpoints['organization'] as _i16.OrganizationEndpoint)
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
              ) async => (endpoints['qa'] as _i17.QaEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['qa'] as _i17.QaEndpoint).approveCourseVersion(
                    session,
                    courseVersionId: params['courseVersionId'],
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
                  (endpoints['qa'] as _i17.QaEndpoint).rejectCourseVersion(
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
                      .getQualityEvent(
                        session,
                        params['id'],
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
                      .createQualityEvent(
                        session,
                        eventType: params['eventType'],
                        title: params['title'],
                        status: params['status'],
                        referenceId: params['referenceId'],
                        siteId: params['siteId'],
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
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
                  (endpoints['qualityEvent'] as _i18.QualityEventEndpoint)
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
                  (endpoints['seed'] as _i19.SeedEndpoint).runSeed(session),
        ),
      },
    );
    connectors['training'] = _i1.EndpointConnector(
      name: 'training',
      endpoint: endpoints['training']!,
      methodConnectors: {
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
                  .assignTraining(
                    session,
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                    assignedById: params['assignedById'],
                    dueDate: params['dueDate'],
                    priority: params['priority'],
                    reason: params['reason'],
                    source: params['source'],
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
                  .getEnrollmentsForUser(
                    session,
                    params['userId'],
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
                  .getCertificatesForUser(
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
                  .getCertificateById(
                    session,
                    params['certificateId'],
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
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
              ) async => (endpoints['training'] as _i20.TrainingEndpoint)
                  .completeTraining(
                    session,
                    enrollmentId: params['enrollmentId'],
                    userId: params['userId'],
                    courseVersionId: params['courseVersionId'],
                    esignatureId: params['esignatureId'],
                    score: params['score'],
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
              ) async => (endpoints['user'] as _i21.UserEndpoint).getUser(
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
                  (endpoints['user'] as _i21.UserEndpoint).getUserByEmail(
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
              ) async => (endpoints['greeting'] as _i22.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i23.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i24.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i25.FutureCalls();
  }
}
